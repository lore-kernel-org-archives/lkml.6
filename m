Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1762E23E01
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1762E23E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeFVHGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:06:51 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:19145
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750983AbeFVHGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:06:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CjAADcnixb/zXSMGcNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFPxODeZZJlnmEdwKDHjgUAQIBAQEBAQEChj4BAQEDIw8BBUEQCw0?=
 =?us-ascii?q?LAgImAgJXBg0GAgEBgyGBc6pzbYIcGoRBg2mBBYELiVyBNoI6Lod7glUCkU2HW?=
 =?us-ascii?q?QgBjwqBRYQBglmFKJM4gXMzGggoCIMikGFdkCwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2CjAADcnixb/zXSMGcNTxoBAQEBAQIBAQEBCAEBAQGFPxO?=
 =?us-ascii?q?DeZZJlnmEdwKDHjgUAQIBAQEBAQEChj4BAQEDIw8BBUEQCw0LAgImAgJXBg0GA?=
 =?us-ascii?q?gEBgyGBc6pzbYIcGoRBg2mBBYELiVyBNoI6Lod7glUCkU2HWQgBjwqBRYQBglm?=
 =?us-ascii?q?FKJM4gXMzGggoCIMikGFdkCwBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,255,1526313600"; 
   d="scan'208";a="108179643"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 22 Jun 2018 15:06:33 +0800
Subject: Re: [PATCH v2] m68knommu: Fix typos in Coldfire 5272 DMA debug code
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180621203053.32047-1-geert@linux-m68k.org>
 <ecdf3bdf-6453-0c5f-1a72-b4df7148c867@linux-m68k.org>
 <CAMuHMdUhauqTLrjvrypfA+k=Sg7w4aJp53jeXHML0Gk3V_ynwA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <044eb398-8bf9-706e-f321-881b77d02060@linux-m68k.org>
Date:   Fri, 22 Jun 2018 17:06:31 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUhauqTLrjvrypfA+k=Sg7w4aJp53jeXHML0Gk3V_ynwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 22/06/18 16:35, Geert Uytterhoeven wrote:
> On Fri, Jun 22, 2018 at 2:20 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 22/06/18 06:30, Geert Uytterhoeven wrote:
>>> If DEBUG_DMA is defined:
>>>
>>>       include/asm/dma.h: In function ‘set_dma_mode’:
>>>       include/asm/dma.h:393: error: ‘dmabp’ undeclared (first use in this function)
>>>       include/asm/dma.h:393: error: (Each undeclared identifier is reported only once
>>>       include/asm/dma.h:393: error: for each function it appears in.)
>>>       include/asm/dma.h: In function ‘set_dma_addr’:
>>>       include/asm/dma.h:424: error: ‘dmawp’ undeclared (first use in this function)
>>>
>>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>>
>> Do you want me to take this via the m68knommu git tree?
> 
> Yes please. Thx!

Done!

Regards
Greg

