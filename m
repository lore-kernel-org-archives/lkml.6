Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC2EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980DF2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCm6NIpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfA1GhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:37:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37391 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1GhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:37:12 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so17806255iti.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+fgtZwQfJUOjsKuLflFh7dV5h2h2KZCLYosg+iy5eM=;
        b=HCm6NIpNvTg6MqObHqGOITnA0E18gW4uZ/V5VUD2cBU70FSDioHBHnGyL08Mn7tBuj
         UHuEbJKpSSNkaXnUmxn+QEPzgU0GAK3NVnYeU1CSs0Bv8u2cn0Jneeo5Uq8lIT+ZbNMa
         tzjlT1KGu85XMwFutwExZBnXKjggzMhN4T04/7iLYVpRpJJy/5HKuu0jGQc8DMc5qMAV
         r9yRxPyv6zNyFzMDNDzeyaCjlWO66yyU9nnM4HCpyy/ei1d7BAsdAbIWyfwm5+fc6KwO
         47WsUzId+S8VPLidgOEUMGfZ2sFTNvT/QsgpDZ6Mrj+uH2GOmfTrigudfbVORcWW3Ph0
         qjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+fgtZwQfJUOjsKuLflFh7dV5h2h2KZCLYosg+iy5eM=;
        b=oUA5aYh9ZAnyyyuU5XHqzgia3L1svMRFx9Zf08zSl+IUEaH/JBR/mDQBNMnpN0vQLg
         68k+LmeDYeGcHSZafg0KI+/NrljKeg5602+zqpeKaOg+QQni4jEvTrS1XHLrUZ+HRit8
         hjGkmHEydaOZdEVmT7GrTgY16K2Qze4F3pD7+AU6D33Y/BSE75AeEPNp7tfgH6d4KPy3
         e5E6sIjfd9FOoVW8MKuUwKOkVcCJjKlzwDCSG9EbC1CZYuNkXfs9eb+OXHtszcCecCJq
         2TUCyGlGanOttSNSFxzd2IVfd3dS+mH2rrMagm/QBDmHzXJGTELjAcSpaUZoyc71AoZF
         UrpQ==
X-Gm-Message-State: AJcUukf4J46dkjlRZ+nQ5RPbLbr2xe7S7g07N+iVVLu49yY5RfGRnIGU
        BfK2ewKNWGvLCOGJtMkfFnAl2DNGBCX3M8x/Crk=
X-Google-Smtp-Source: ALg8bN5wqV+NX2HuN4q0TmLGPinpAlSfO/Cb9c4SbGQ5wxXf3vP1MfVLEdxVw3Lyf1oa1Acl6tQdkXIvVls7s8+BO60=
X-Received: by 2002:a24:d04:: with SMTP id 4mr9035526itx.19.1548657430991;
 Sun, 27 Jan 2019 22:37:10 -0800 (PST)
MIME-Version: 1.0
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz> <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz> <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
 <20190125155810.GQ3560@dhcp22.suse.cz> <CADfvbxp8sER_Xjkm-g8+BH87Ne8oUBirSWx6mmL=Z3XwyYoQHA@mail.gmail.com>
 <20190125163938.GA20411@dhcp22.suse.cz> <20190125173315.GC20411@dhcp22.suse.cz>
 <20190125181549.GE20411@dhcp22.suse.cz>
In-Reply-To: <20190125181549.GE20411@dhcp22.suse.cz>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 28 Jan 2019 11:37:00 +0500
Message-ID: <CABXGCsM+p5BxJ9qH8z6q9bj9EeVqLW8hauke1jahQKG=mtDvmQ@mail.gmail.com>
Subject: Re: kernel panic due to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
To:     Michal Hocko <mhocko@kernel.org>
Cc:     robert shteynfeld <robert.shteynfeld@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus, could you take the revert please?
>
> From 817b18d3db36a6900ca9043af8c1416c56358be3 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 25 Jan 2019 19:08:58 +0100
> Subject: [PATCH] Revert "mm, memory_hotplug: initialize struct pages for the
>  full memory section"
>
> This reverts commit 2830bf6f05fb3e05bc4743274b806c821807a684.
>
> The underlying assumption that one sparse section belongs into a single
> numa node doesn't hold really. Robert Shteynfeld has reported a boot
> failure. The boot log was not captured but his memory layout is as
> follows:
> [    0.286954] Early memory node ranges
> [    0.286955]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> [    0.286955]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> [    0.286956]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> [    0.286956]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
>
> This means that node0 starts in the middle of a memory section which is
> also in node1. memmap_init_zone tries to initialize padding of a section
> even when it is outside of the given pfn range because there are code
> paths (e.g. memory hotplug) which assume that the full worth of memory
> section is always initialized. In this particular case, though, such a
> range is already intialized and most likely already managed by the page
> allocator. Scribbling over those pages corrupts the internal state and
> likely blows up when any of those pages gets used.
>
> Reported-by: Robert Shteynfeld <robert.shteynfeld@gmail.com>
> Fixes: 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full memory section")
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d295c9bc01a8..35fdde041f5c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5701,18 +5701,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                         cond_resched();
>                 }
>         }
> -#ifdef CONFIG_SPARSEMEM
> -       /*
> -        * If the zone does not span the rest of the section then
> -        * we should at least initialize those pages. Otherwise we
> -        * could blow up on a poisoned page in some paths which depend
> -        * on full sections being initialized (e.g. memory hotplug).
> -        */
> -       while (end_pfn % PAGES_PER_SECTION) {
> -               __init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
> -               end_pfn++;
> -       }
> -#endif
>  }
>
>  #ifdef CONFIG_ZONE_DEVICE

Michal, I suppose that revert the commit
2830bf6f05fb3e05bc4743274b806c821807a68 are return my issue
https://marc.info/?l=linux-mm&m=154499704718428
Are any other better approach would be proposed for fixing my issue?

--
Best Regards,
Mike Gavrilov.
