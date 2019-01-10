Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA5CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92DB2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KIv2goHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfAJMrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:47:04 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41533 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfAJMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:47:04 -0500
Received: by mail-ed1-f48.google.com with SMTP id a20so10083812edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tYi9UWHv4poWaAe7xdCVB/ME9MYSdW/l2osgWXicvxM=;
        b=KIv2goHcx4YRImBY2oqIXmTX0KUQgBlTAuqkiK3Ln0tpR/+YSaBrAbtlKJg9ynGKTO
         cXfp3wcjWgLICOUYUEFHhmFpHPEgW2Rbv6llWarmuAJ6tfVcGHs5NiYUzJTi4T/YLRGh
         wtMEtqqaP8mWP8fX4r7EYmju3d5KsF+OnoH1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYi9UWHv4poWaAe7xdCVB/ME9MYSdW/l2osgWXicvxM=;
        b=X1qTyR1ebD7AzRlaVOOsAWTQo94RjvlpU4QK79snYcuL3KLJ0aumTitmv76LHJ50a0
         D8BrGvtvsK1+ecJAW7s9EQNHhK9RhqhITwI5b8vN++BnRyghl48lZkQX/h7EWfa9c4VH
         Qvs0kvvFnIqYSypzBfdIGVjnOrZMxrq8Sxcrxi1qSqx/SvKIf9woAVukz+bTD/6Ww94h
         r2pj9ls7uLzaz2DQqFhr3T4b+Y7YUhG6Ccu0k4L6cIuovET5sT83l3b5kgcabCHMcK9s
         fXinPbJwF01ecoUlb1K5qFOfFKQPEMJbAp1GE5PY/YvdfLcPHaL5H8sVzXz5Dh8rfqhr
         yTAg==
X-Gm-Message-State: AJcUukcOv/Dl083sM2UKhWZCEH8SMxJzL7+Q46k7Z6Nag00JCPwHKswx
        +tVH7K4GCMkQTmzptmYhlQybAg==
X-Google-Smtp-Source: ALg8bN6cONg5ijNOlLxCIDis2ooyOSWJloZ87HRmEOfX9hJWeJ5KsPvWeyjxpvThewwA/UXcZXr55Q==
X-Received: by 2002:a17:906:8301:: with SMTP id j1-v6mr8687812ejx.60.1547124422238;
        Thu, 10 Jan 2019 04:47:02 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id f31sm2024381eda.16.2019.01.10.04.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 04:47:01 -0800 (PST)
Date:   Thu, 10 Jan 2019 13:46:55 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110124655.GA13986@andrea>
References: <20190109000214.GA5907@andrea>
 <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea>
 <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea>
 <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
 <20190109171053.GY1215@linux.ibm.com>
 <CACT4Y+ZZYxE5z4_wZ_Na3z6Y-RmhfrHt3y3sQzUcdUuR35Xc_g@mail.gmail.com>
 <20190110123008.GA13625@andrea>
 <CACT4Y+ZMcQ3aF+mJws2mzbHww=ZGB9XQkPU5YUsicNS9SKwD_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZMcQ3aF+mJws2mzbHww=ZGB9XQkPU5YUsicNS9SKwD_A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:38:11PM +0100, Dmitry Vyukov wrote:
> On Thu, Jan 10, 2019 at 1:30 PM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > > For seqcounts we currently simply ignore all accesses within the read
> > > section (thus the requirement to dynamically track read sections).
> > > What does LKMM say about seqlocks?
> >
> > LKMM does not currently model seqlocks, if that's what you're asking;
> > c.f., tools/memory-model/linux-kernel.def for a list of the currently
> > supported synchronization primitives.
> >
> > LKMM has also no notion of "data race", it insists that the code must
> > contain no unmarked accesses; we have been discussing such extensions
> > since at least Dec'17 (we're not quite there!, as mentioned by Paul).
> 
> How does it call cases that do contain unmarked accesses then? :)

"work-in-progress" ;), or "limitation" (see tools/memory-model/README)


> 
> > My opinion is that ignoring all accesses within a given read section
> > _can_ lead to false negatives
> 
> Absolutely. But this is a deliberate decision.
> For our tools we consider priority 1: no false positives. Period.
> Priority 2: also report some true positives in best effort manner.

This sound reasonable to me.  But please don't overlook the fact that
to be able to talk about "false positive" and "false negative" (for a
data race detector) we need to agree about "what a data race is".

(The hope, of course, is that the LKMM will have a say soon here ...)

  Andrea


> 
> > (in every possible definition of "data
> > race" and "read sections" I can think of at the moment ;D):
> >
> >         P0                              P1
> >         read_seqbegin()                 x = 1;
> >         r0 = x;
> >         read_seqretry() // =0
> >
> > ought to be "racy"..., right?  (I didn't audit all the callsites for
> > read_{seqbegin,seqretry}(), but I wouldn't be surprised to find such
> > pattern ;D ... "legacy", as you recalled).
> >
> >   Andrea
