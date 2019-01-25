Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7C6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD2E218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/2E9e4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfAYPwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:52:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33364 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:52:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so11199091qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wouTF3AFYPBCowI7Rs9rSL8qFQNxiyESDT34NHktT+M=;
        b=g/2E9e4q5Uw6paWH1yghmYt8X/78tu4OMyTgUiMA8AUR/mkMcJm1WWgonW1XGV81Im
         aXROwLn4a4lv9YVHGKZ/9ZKJQLtiQWDnC/AJHfwjAZRHsf0cAP+LM41ZF9AETKyEINI2
         VOsD8APXR7ritm+MENVCcbhs7CScQsUHctWVlLU5+q+sNCmJh/GxBxPRDPaiqK0Tb+Zr
         0M3G/cTM7O38DKqa85qMwpcCG8m4MsUvPzIiIcLuupl6NGB91jzejsQThuMhxL9dKIik
         cEc5bl1GQmrcGSvPZbxKDOwk/XbDx50XZce85z5MALEuP0mxCPQ46QZVFzC9xo0npfju
         r7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wouTF3AFYPBCowI7Rs9rSL8qFQNxiyESDT34NHktT+M=;
        b=X9fduynQ15OCN8RVgZuKRfsGjXWK0sHaOaVtuC1xUlt1IGm667cDNPoTsCrT0sFmmA
         hbHVqY6H2sCn8IdDEGU5h7gCb6qAeab2oERet3/kvkMCZiozLnsu5/UeQbTdAsDjeVeX
         RxuvgefUB5SJlf798tr6SxlbL/kZQq3TUw656jQQIq91iEzP/UCJJvfIpWBgclBroa5l
         EwN/UeSAX0Gzsph5Qgc0CW8dBkPKV6sc9IaB6EhZLDsz9J7TkuzVBX9C2l8Fsq9Y4yEu
         SYXz6YLYgZGDOfKniI/dh6DpRAL7epbrH2ULz1NENm9aeo1E5Rl4ZfjN5d8v4w/Ztp53
         UVHw==
X-Gm-Message-State: AJcUukdAtR0qKTQwFphwlFaRg/KAxMHmvsP6qer7bGGn80uqbegZvUyU
        ujCBR37Tz7TaR4hcIUpOmQKgaMurJTJLp3CoRSs=
X-Google-Smtp-Source: ALg8bN7LmRaB+wUsGGvZ7TflPPqmbRL8+PVrASyVC/zbAii0l4VBTDGUOAcRfpHJoFQhUWYT5Z5DJCjV+FgaA5a550I=
X-Received: by 2002:ac8:7493:: with SMTP id v19mr11315647qtq.309.1548431537475;
 Fri, 25 Jan 2019 07:52:17 -0800 (PST)
MIME-Version: 1.0
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz> <20190125081924.GF3560@dhcp22.suse.cz> <20190125082952.GG3560@dhcp22.suse.cz>
In-Reply-To: <20190125082952.GG3560@dhcp22.suse.cz>
From:   robert shteynfeld <robert.shteynfeld@gmail.com>
Date:   Fri, 25 Jan 2019 10:52:06 -0500
Message-ID: <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
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

The person who pointed to mm/page_alloc.c commits likely causing the
issue did not have time to build a patched/reverted kernel to confirm
his hypothesis.  When I tried backing out the two separate commits he
suggested, the first commit (ie. the one in the subject) was the one
that when backed out fixed the boot issue.  Reverting the second one
had no effect.

On Fri, Jan 25, 2019 at 3:29 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 25-01-19 09:19:24, Michal Hocko wrote:
> > On Fri 25-01-19 08:37:04, Michal Hocko wrote:
> > > On Fri 25-01-19 17:48:32, Linus Torvalds wrote:
> > > > [ Just adding a lot of other people to the cc ]
> > > >
> > > > Robert, could you add a dmesg of a successful boot to that bugzilla,
> > > > or just as an attachement in email to this group of people..
> > > >
> > > > This looks to be with the Fedora kernel config. Two people reporting
> > > > it, it looks like similar machines.
> > > >
> > > > I assume it's some odd memory sizing detail that happens to trigger a
> > > > particular case.
> > >
> > > Quite possible.
> >
> > Forgot to ask. Can we get a dmesg with 2830bf6f05fb ("mm,
> > memory_hotplug: initialize struct pages for the full memory section")
> > reverted and memblock=debug kernel command line parameter?
>
> And one more thing which I have overlook until now and it is not really
> clear to me. One of th comments says
> : The relevant part was:
> : kernel bug at mm/page_alloc.c=790
>
> I suppose this is 4.19 stable kernel because that would be
> VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>
> in __free_one_page. I do not really see how 2830bf6f05fb could make any
> difference here. It simply zeroes out the rest of the mem section and
> that is guaranteed to be allocated because we do not do subsections. The
> above VM_BUG_ON says that we start allocating an unaligned pfn for its
> order.
>
> Or are there two issues reported in that bug?
> --
> Michal Hocko
> SUSE Labs
