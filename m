Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeEHEnv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:43:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57288 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeEHEnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:43:50 -0400
Subject: Re: [External] [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM and
 fill into GFP_ZONE_TABLE
To: Huaisheng HS1 Ye <yehs1@lenovo.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "mhocko@suse.com" <mhocko@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        Ocean HY1 He <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-4-git-send-email-yehs1@lenovo.com>
 <HK2PR03MB1684653383FFEDAE9B41A548929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ce3a6f37-3b13-0c35-6895-35156c7a290c@infradead.org>
Date: Mon, 7 May 2018 21:43:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <HK2PR03MB1684653383FFEDAE9B41A548929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 07:33 PM, Huaisheng HS1 Ye wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c782e8f..5fe1f63 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -687,6 +687,22 @@ config ZONE_DEVICE
>  
> +config ZONE_NVM
> +	bool "Manage NVDIMM (pmem) by memory management (EXPERIMENTAL)"
> +	depends on NUMA && X86_64

Hi,
I'm curious why this depends on NUMA. Couldn't it be useful in non-NUMA
(i.e., UMA) configs?

Thanks.

> +	depends on HAVE_MEMBLOCK_NODE_MAP
> +	depends on HAVE_MEMBLOCK
> +	depends on !IA32_EMULATION
> +	default n
> +
> +	help
> +	  This option allows you to use memory management subsystem to manage
> +	  NVDIMM (pmem). With it mm can arrange NVDIMMs into real physical zones
> +	  like NORMAL and DMA32. That means buddy system and swap can be used
> +	  directly to NVDIMM zone. This feature is beneficial to recover
> +	  dirty pages from power fail or system crash by storing write cache
> +	  to NVDIMM zone.



-- 
~Randy
