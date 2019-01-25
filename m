Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1A6218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmaGTnwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfAYQwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:52:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35100 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfAYQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:52:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so11410820qtc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 08:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UN6ESAiGqAJMvvF8AbnQOBp19amiChak4CygOVl1KAc=;
        b=TmaGTnwrjvn4GT5lH4VMt0f4C5bCareUNS3U2GP6+FviaBbfRDYBV8FRvS2PYuJxaj
         8CQbHXuuyhIUkGeqcTdrqXQ64jOiarB1pA9wQlByHFG7cKtX3VrLaw7VV6x8dawWxLCy
         CQWxHVceQFbx9Vq01KfRtQAZKYAFXJEpUiS7Lx0MJFUM6VrivO11Hr5Wm4NIAI3mdxvI
         5pl9JHCZ9zpfSXB+mw8Uo8GvIGg+8DOM6LqKqUdOCijoD52zIdTL6PcKbnyTf9bn9FM9
         L1Nb+zrrsYdbhHNU0mA60YPkY9AhX51vlqVZBJkXj6XrYAwnSdWF2MBzvr3uVNjMPbRo
         /HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UN6ESAiGqAJMvvF8AbnQOBp19amiChak4CygOVl1KAc=;
        b=eP5Z9FD++YMt3Bcxcr3fA6UQ82TFR5Qrq85xQg19xeyvxeFidYkEe1TmZIVpz/E8wQ
         tNDh0vEZGrfBMjcXCUM0izyy2JMJZKQ4sTGCg5Anbh7xc55fc746/Zgc/G7MVRdhMCmU
         mM1PgSMwHoOlE6pzhopT4V8iVCllsbZPwmExzdSxYkwIJfsHkY1SZdbAyw4H6ZX7Pdwy
         yHX7f/Ja1eJtAYm6LomhCnl7ZuOT20GoKjHub9al4BKBDU2tpNoqAUiXJf0KeZ1Ld859
         HsjcPA3Avnd001Tkpe62Je4X5DYu36f1d1KyyH12SUJedN11k3Bqa4AOtBCRlWyhf9K2
         2bIg==
X-Gm-Message-State: AJcUukc7PKT/cutw/lN7YTjoKuj7DDBGZmGhtLODcuhXwf2I/07rmCf6
        bNHSgyN7pXa9N6i0M0f8z0ut4nrCJ4xT5blAWRk=
X-Google-Smtp-Source: ALg8bN4KFZSyiLYUNMf2MSBFr/+JuqSmv2p7S2KWZsqTRmVu/y31LTKHFzJjqFZGHDIgzq1pdxjZJXebEBgGKJkTc1c=
X-Received: by 2002:a0c:d94f:: with SMTP id t15mr11163302qvj.189.1548435123908;
 Fri, 25 Jan 2019 08:52:03 -0800 (PST)
MIME-Version: 1.0
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz> <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz> <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
 <20190125155810.GQ3560@dhcp22.suse.cz> <CADfvbxp8sER_Xjkm-g8+BH87Ne8oUBirSWx6mmL=Z3XwyYoQHA@mail.gmail.com>
 <20190125163938.GA20411@dhcp22.suse.cz>
In-Reply-To: <20190125163938.GA20411@dhcp22.suse.cz>
From:   robert shteynfeld <robert.shteynfeld@gmail.com>
Date:   Fri, 25 Jan 2019 11:51:52 -0500
Message-ID: <CADfvbxp6i0usg1XqjCAcTwVzfsF812ue2WcsjtSFZpr8Y2zNtw@mail.gmail.com>
Subject: Re: kernel panic due to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
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

Could the unusual memory config be due to one empty DIMM slot on my
motherboard?  I have 9 slots, but only 8 x 16G filled.  The 6th slot
on the motherboard is empty -- which is a valid config according to
the manual.

On Fri, Jan 25, 2019 at 11:39 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 25-01-19 11:16:30, robert shteynfeld wrote:
> > Attached is the dmesg from patched kernel.
>
> Your Node1 physical memory range precedes Node0 which is quite unusual
> but it shouldn't be a huge problem on its own. But memory ranges are
> not aligned to the memory section
>
> [    0.286954] Early memory node ranges
> [    0.286955]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> [    0.286955]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> [    0.286956]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> [    0.286956]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
>
> As you can see the last pfn for the node1 is inside the section and
> Node0 starts right after. This is quite unusual as well. If for no other
> reasons then the memmap of those struct pages will be remote for one or
> the other. Actually I am not even sure we can handle that properly
> because we do expect 1:1 mapping between sections and nodes.
>
> Now it also makes some sense why 2830bf6f05fb ("mm, memory_hotplug:
> initialize struct pages for the full memory section") made any
> difference. We simply write over a potentially initialized struct page
> and blow up on that. I strongly suspect that the commit just uncovered
> a pre-existing problem. Let me think what we can do about that.
>
> > I'm not an expert at debugging the kernel, obviously.  I tried setting
> > up a serial console before without much luck as part of this debugging
> > session.
>
> Ubuntu has a nice howto for netconsole configuration
> https://wiki.ubuntu.com/Kernel/Netconsole. It is quite important to get
> the actual failure.
> --
> Michal Hocko
> SUSE Labs
