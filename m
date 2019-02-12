Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2D820842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfBLKe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:34:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:64778 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfBLKe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:34:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 02:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="117246137"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.67.170.184]) ([10.67.170.184])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2019 02:34:53 -0800
Subject: Re: [PATCH 09/10] platform/x86: intel_pmc_core: Add Package cstates
 residency info
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Anshuman Gupta <anshuman.gupta@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
 <20190201073234.13280-10-rajneesh.bhardwaj@linux.intel.com>
 <20190211164118.GA23796@genxfsim-desktop>
 <78e5e6b3-5712-6ef5-283c-83b0f6d3dcc7@linux.intel.com>
 <CAHp75VeZwgM9KPNahmpsLzzkmOKDN2JeBKQWO9hBK_O=Gk8oFw@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <38444053-cbab-ae6d-9504-18ca3cd84d15@linux.intel.com>
Date:   Tue, 12 Feb 2019 16:04:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZwgM9KPNahmpsLzzkmOKDN2JeBKQWO9hBK_O=Gk8oFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Feb-19 3:55 PM, Andy Shevchenko wrote:
> On Mon, Feb 11, 2019 at 8:32 PM Bhardwaj, Rajneesh
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> On 11-Feb-19 10:11 PM, Anshuman Gupta wrote:
>>> On Fri, Feb 01, 2019 at 01:02:33PM +0530, Rajneesh Bhardwaj wrote:
>>>> This patch introduces a new debugfs entry to read current Package
>>>> cstate residency counters. A similar variant of this patch was discussed
>>>> earlier "https://patchwork.kernel.org/patch/9908563/" but didn't make it
>>>> into mainline for various reasons. Current version only adds debugfs
>>>> entry which is quite useful for S0ix debug but excludes the exported API
>>>> that was there in initial version. Though there are tools like turbostat
>>>> and socwatch which can also show this info but sometimes its more
>>>> practical to have it here as it's hard to switch between various tools for
>>>> S0ix debug when pmc_core driver is the primary debug tool. Internal and
>>>> external customers have requested for this patch to be included in the
>>>> PMC driver on many occasions and Google Chrome OS team has already included
>>>> it in their builds. This becomes handy when requesting logs from external
>>>> customers who may not always have above mentioned tools in their integrated
>>>> kernel builds.
>>>     Tested-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>>     Acked-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> Hi Andy, Darren - Can i used Acked-and-tested-by instead of these two?
> Better to split. I didn't see in common practice acked-and-tested.
> Rather reviewed-and-tested, or reported-and-tested.


Sure Andy, I can do as you suggest but i am confused now because on 
another patch i've got "Acked-and-tested-by" only i.e. just one single 
tag. So for consistency, what should i do? I also noticed that this tag 
is used about 59 times in Linux kernel and i even found one 
"Reported-Acked-and-Tested-by" too :) though i understand these may not 
be acceptable by all Maintainers. So, please guide.

>
