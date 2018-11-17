Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA10720811
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI0eiwqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA10720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeKRA3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 19:29:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43749 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRA3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 19:29:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id r71so42000565qkr.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccE9KJ63SN5kg+nHsLCTq6PzFrS0a1qadxxtnarMB+A=;
        b=KI0eiwqzIO+H7KxZEBVrNGuiabyCb4vaNnUqb+7JZC5Dd8AiJXLENowfogC0B8lRji
         s8Avfx4WocujLaDX9BRZoKsGbmPma3pOFNDU8AkXWOpcoKgvN0eyQ6Ahfv4VD7JYgA61
         XZJTlGx9+I9lnl/8r/k0dAcb4KFkS4Np0Lhp4Y177cau2rrEy7TsKiph76vgisAH0EMU
         u2MZD0DyJbd2nNZGUF8GfWP85WYH2Zj1wye8BdtFesImo1PnwZkH6iCUT478+eWHdhNk
         tf5LjXCqyUNiQE3gJLmWMaPxU2vnfL5SafZgf+Ft6/fKmd2iecF9tKsib7Yh9EKyGQMO
         QZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccE9KJ63SN5kg+nHsLCTq6PzFrS0a1qadxxtnarMB+A=;
        b=Igf4NA2nDSFssvwqfUF3c1df2Qg0KPV7KetLRtw0vQtFWcFlRGvSSi88Y9vNRuSKQV
         DSixAGFku1c1IEUyCocfmIpRBm20csD3SpWQEXmTS9LKAxl0PBDfKJha7g7rkVRFWBfC
         DwkX+OQLJeA1J6vT79QyrbDDoic2RDS1tikK+aMbiw2eLFL3Rn+a7sccBIddcK29uOuj
         8iROBawHyLylZ7ysOgp9W0kKt7vhHWI4VnaiDfMN3X8q0o39WHVrtYXWAcuf9rpDDndP
         4RXs7Gqr4sWhMz/EXTWMbBlODKojXT6IpA+qFnoDseBnJY8ed4v79qhuS+U2Ld+t+pO2
         dvFA==
X-Gm-Message-State: AGRZ1gITDXBIUCfxNS0iO89JC/ZKvDZ3S4wZUv+wB6kVSNMF2GaSva2i
        Hh1xJpURzJMJe+NubhLAnYeexFmYknlg7i+GsxZq
X-Google-Smtp-Source: AJdET5cb8ENl8y668+7xZEQ1ig5uXVwqDJ52v+bEIidhEmRSQ3+oaqjNOJvD1h8/umSt4sdz8eX2ZkvBiQcPGcwVZL4=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr14327817qtf.26.1542463951543;
 Sat, 17 Nov 2018 06:12:31 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <alpine.DEB.2.21.1811142146230.9620@hadrien> <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com>
 <alpine.DEB.2.21.1811150544090.2354@hadrien> <878t1tgpk8.fsf@intel.com> <f08820b05467cc95cc195a2639595c0274c95d69.camel@perches.com>
In-Reply-To: <f08820b05467cc95cc195a2639595c0274c95d69.camel@perches.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Sat, 17 Nov 2018 08:12:18 -0600
Message-ID: <CAL_Jsq+4FbB=wj3L67=KEPb_5e8GinMJaXoB2cW6c23yazeNiw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
To:     Joe Perches <joe@perches.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        stfrench@microsoft.com, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:57 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2018-11-16 at 14:44 +0200, Jani Nikula wrote:
> > I quickly cooked up this script to produce the top-5 commit prefixes for
> > the given files over the arbitrary last 200 commits. It'll give you a
> > pretty good idea if you're even close.
> >
> > ---
> > #!/bin/sh
> > # usage: subject-prefix FILE [...]
> > # show top 5 subject prefixes for FILEs
> >
> > git log --format=%s -n 200 -- "$@" |\
> >       grep -v "^Merge " |\

--no-merges in git log can replace this line.

> >       sed 's/\(.*\):.*/\1/' |\
> >       sort | uniq -c | sort -nr | sed 's/ *[0-9]\+ //' |\
> >       head -n 5
> > ---
> >
> > Someone who knows perl could turn that into a checkpatch check: See if
> > the patch subject prefix is one of the top-5 for all files changed by
> > the patch, and ask the user to double check if it isn't. Or some
> > heuristics thereof.
>
> This won't work when a patch contains multiple files
> from different paths, or even multiple files from a
> single driver.

Different paths is often, but not always a sign that patches may need
to be split up. Maybe that is something checkpatch should point out.

> Perhaps it's better to use a generic mechanism like
>
>         basename $(dirname $filename):
>
> with some exceptions and add an override patch subject
> grammar to appropriate various sections of MAINTAINERS.

Perhaps just use the script as a starting point to populate
MAINTAINERS as it may never be that accurate.

> I also think it's better to use a separate script like
> scripts/spdxcheck.py and tie any necessary checkpatch
> use to that script.

Yes, checkpatch is getting pretty unwieldy.

Rob
