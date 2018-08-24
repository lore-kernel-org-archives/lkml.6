Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA91208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA91208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeHXDho convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:37:44 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:48956 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHXDhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:37:43 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w7O05KaB032216
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Aug 2018 09:05:20 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7O05Jf7015837;
        Fri, 24 Aug 2018 09:05:20 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7O03jKC002529;
        Fri, 24 Aug 2018 09:05:19 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3045557; Fri, 24 Aug 2018 09:03:27 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Fri,
 24 Aug 2018 09:03:26 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "osalvador@techadventures.net" <osalvador@techadventures.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Thread-Topic: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Thread-Index: AQHUOz3hJO6tZLKv2Eedq0vBDZ0sig==
Date:   Fri, 24 Aug 2018 00:03:25 +0000
Message-ID: <20180824000325.GA20143@hori1.linux.bs1.fc.nec.co.jp>
References: <20180823182513.8801-1-msys.mizuma@gmail.com>
In-Reply-To: <20180823182513.8801-1-msys.mizuma@gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.82]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4ACE734EF426E548A9644DAC9290E1B2@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(CCed related people)

Hi Mizuma-san,

Thank you for the report.
The mentioned patch was created based on feedbacks from reviewers/maintainers,
so I'd like to hear from them about how we should handle the issue.

And one note is that there is a follow-up patch for "x86/e820: put !E820_TYPE_RAM
regions into memblock.reserved" which might be affected by your changes.

> commit e181ae0c5db9544de9c53239eb22bc012ce75033
> Author: Pavel Tatashin <pasha.tatashin@oracle.com>
> Date:   Sat Jul 14 09:15:07 2018 -0400
> 
>     mm: zero unavailable pages before memmap init

Thanks,
Naoya Horiguchi

On Thu, Aug 23, 2018 at 02:25:12PM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
> memblock.reserved") breaks movable_node kernel option because it
> changed the memory gap range to reserved memblock. So, the node
> is marked as Normal zone even if the SRAT has Hot plaggable affinity.
> 
>     =====================================================================
>     kernel: BIOS-e820: [mem 0x0000180000000000-0x0000180fffffffff] usable
>     kernel: BIOS-e820: [mem 0x00001c0000000000-0x00001c0fffffffff] usable
>     ...
>     kernel: reserved[0x12]#011[0x0000181000000000-0x00001bffffffffff], 0x000003f000000000 bytes flags: 0x0
>     ...
>     kernel: ACPI: SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
>     kernel: ACPI: SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
>     ...
>     kernel: Movable zone start for each node
>     kernel:  Node 3: 0x00001c0000000000
>     kernel: Early memory node ranges
>     ...
>     =====================================================================
> 
> Naoya's v1 patch [*] fixes the original issue and this movable_node
> issue doesn't occur.
> Let's revert commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM
> regions into memblock.reserved") and apply the v1 patch.
> 
> [*] https://lkml.org/lkml/2018/6/13/27
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/kernel/e820.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c88c23c658c1..d1f25c831447 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1248,7 +1248,6 @@ void __init e820__memblock_setup(void)
>  {
>  	int i;
>  	u64 end;
> -	u64 addr = 0;
>  
>  	/*
>  	 * The bootstrap memblock region count maximum is 128 entries
> @@ -1265,21 +1264,13 @@ void __init e820__memblock_setup(void)
>  		struct e820_entry *entry = &e820_table->entries[i];
>  
>  		end = entry->addr + entry->size;
> -		if (addr < entry->addr)
> -			memblock_reserve(addr, entry->addr - addr);
> -		addr = end;
>  		if (end != (resource_size_t)end)
>  			continue;
>  
> -		/*
> -		 * all !E820_TYPE_RAM ranges (including gap ranges) are put
> -		 * into memblock.reserved to make sure that struct pages in
> -		 * such regions are not left uninitialized after bootup.
> -		 */
>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> -			memblock_reserve(entry->addr, entry->size);
> -		else
> -			memblock_add(entry->addr, entry->size);
> +			continue;
> +
> +		memblock_add(entry->addr, entry->size);
>  	}
>  
>  	/* Throw away partial pages: */
> -- 
> 2.18.0
> 
> 
