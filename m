Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16E6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIqFwI6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfAJMiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:38:25 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:33937 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfAJMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:38:24 -0500
Received: by mail-it1-f171.google.com with SMTP id x124so15338892itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Is70u82OulI8r2hpqedctR5XcSdrZyGNzKWtrRZEWsw=;
        b=LIqFwI6MA6GrG7FNcLdvlXmGmP9Fvb7ekQgUDVahyGh4L+Ip8f8L++hBJ7fEC618yP
         MAyApy0l9rpNxWkIV/kF9IMWvN1vxIfWqdYWtwo9ZqiLVcgF7tCxBC0XtU1U+XDCf16A
         FubhWUxFZkcVEX9uiVXYdrzHagFKAOhgmb2HzvIPUfPyQRmbwSlCQ4tExPM7U7zu21BX
         qXnFhuji/gE2oMnMMjU5I9GXSJoeyDV/h4A8DgA3z+QBIfx/52J5I96j9A0dvvJoHGRS
         HI4wpCZg6S2v/dFmgchoz/zOe0G1G1Vs7xVADvisWUJrqZ6nI6slVCtGmolfWcJ7EoPD
         Xaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Is70u82OulI8r2hpqedctR5XcSdrZyGNzKWtrRZEWsw=;
        b=cxgizuBmOPkJgOYIFjhCzp1Q2oxdocOc4EGbbt3TNGK47CNRE7LVN9CSKn+ZvpH4FR
         gqfkIa06skHIrshECVBtMlK5s73GKeOQq/VK1TX/rJPkn8jSrnySneUoll+QtBy8n4Os
         DVpNM3bGLtV7EnHcjBG/ovWBYvxiRtkozJJjHP2c2ixYzz8icIp891N6PQZSsdbfRgAU
         OYXkKXMZ0m571AdXLPUZxUxhKdBwMlKbyqppe5EqL/r6kWjSI2zV61JDxtqIApsMtb73
         XYgMvOXX1rejNV7UzldVUmKeBEzpR21pgbxMd/2bxsd+k9HhmrWAZSrUbsEfLg9jhS5e
         DWtg==
X-Gm-Message-State: AJcUukdQNteBQsowvbPH5Rm4SvNMoHTN26x+N0nZHayMDotGSYS7FR02
        8PEFqskxagcua/cVIPt4sL4ouJWThxM0EHZecOf4hA==
X-Google-Smtp-Source: ALg8bN4/ZVKmQwAk9eoACWRpSjui7paSABLBnyf3Xm0pfG4J8DQive4ojJtT22QRvqNwcdbMBbywBKMRCArBQPJkKFA=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr6374495iti.166.1547123903191;
 Thu, 10 Jan 2019 04:38:23 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea> <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea> <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea> <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
 <20190109171053.GY1215@linux.ibm.com> <CACT4Y+ZZYxE5z4_wZ_Na3z6Y-RmhfrHt3y3sQzUcdUuR35Xc_g@mail.gmail.com>
 <20190110123008.GA13625@andrea>
In-Reply-To: <20190110123008.GA13625@andrea>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Jan 2019 13:38:11 +0100
Message-ID: <CACT4Y+ZMcQ3aF+mJws2mzbHww=ZGB9XQkPU5YUsicNS9SKwD_A@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 1:30 PM Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> > For seqcounts we currently simply ignore all accesses within the read
> > section (thus the requirement to dynamically track read sections).
> > What does LKMM say about seqlocks?
>
> LKMM does not currently model seqlocks, if that's what you're asking;
> c.f., tools/memory-model/linux-kernel.def for a list of the currently
> supported synchronization primitives.
>
> LKMM has also no notion of "data race", it insists that the code must
> contain no unmarked accesses; we have been discussing such extensions
> since at least Dec'17 (we're not quite there!, as mentioned by Paul).

How does it call cases that do contain unmarked accesses then? :)

> My opinion is that ignoring all accesses within a given read section
> _can_ lead to false negatives

Absolutely. But this is a deliberate decision.
For our tools we consider priority 1: no false positives. Period.
Priority 2: also report some true positives in best effort manner.

> (in every possible definition of "data
> race" and "read sections" I can think of at the moment ;D):
>
>         P0                              P1
>         read_seqbegin()                 x = 1;
>         r0 = x;
>         read_seqretry() // =0
>
> ought to be "racy"..., right?  (I didn't audit all the callsites for
> read_{seqbegin,seqretry}(), but I wouldn't be surprised to find such
> pattern ;D ... "legacy", as you recalled).
>
>   Andrea
