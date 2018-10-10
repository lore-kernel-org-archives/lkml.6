Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB418C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772AE2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDGegHc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772AE2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeJKB7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:59:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44138 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbeJKB7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:59:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id p25-v6so2926714pli.11;
        Wed, 10 Oct 2018 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oiK0EEhORkRTEBxomFkAKkopBwWgvGTz5bp1j/Imd5I=;
        b=PDGegHc55idA2/P1XAyJ42qb8/wgkSUaN4wWzTOGB4ul612eE+eaMliC3iEy7Tz8TL
         cQYRlfyd3zW3HkpFvY4+I0bwXPeqfwFOMBydmVgH7M+O71Je95MCPA1oZNStm/pBu7bM
         TQsFwKNCwgylLS9Dekhh7UbzAZTxSMUhC4DAbvN76KRoE/w4jrmgNutrPEez3HGB0UVk
         +S4kVJ6J/XLKrvitRUAHKFMLLN/pswlmiQ8uKN+ebKwZYNTTr+8ydawgSgj4TwuuP7Vg
         pnkMybuh3P5EIPtU55h9bY6h9VHhh9h0DB1fflUvnZyImrOrqFQn2BQ2ueo6ytDPmYsz
         Wdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oiK0EEhORkRTEBxomFkAKkopBwWgvGTz5bp1j/Imd5I=;
        b=hwiOpwABWBHyd4FTU/DJ4v9+6ub+Qpg+4pwl+FHaGmO5FiSp1HQQY4h4ULeW+xsKNz
         tm+XWJkAlb4zorA+0mXHFpgv8mljPx7xZ+gdJlZmv5F6VYxvZPA+PwdOCSRY/RrmMDF5
         Rq6YJtavmu5g76mPF77l7e8mNje6UGRJwtdFkfIdq7ru/SSWN81fLvqNkFV40HPLe/fH
         IEPXF13OyeQbsKd18hDaHbqtlSW1flsGRU1+DBwOD1+28vNbS86mWDt29wO63ZOI/ChT
         44RevXdMGpEhMEDAIF+mfROJRVLatTB8qmUNIB/mMzf1bP5OTL+T3/FLxE8RKHHUhpiV
         VK7A==
X-Gm-Message-State: ABuFfohYGYLwJzu27vkIofxBZ4jtKSBmdPar5GGsCQD8XzxuodMFuBTW
        NrBqLGj4TqKqNnJQBMTmxLXT79EwCYY=
X-Google-Smtp-Source: ACcGV63sraa8uHNnna3V3MzOUbiKsyCPF/FYKId4dEVNsaT3XNoMu1jWHUk+q4p/4/59xxF6mn/oJg==
X-Received: by 2002:a17:902:9896:: with SMTP id s22-v6mr618880plp.113.1539196573386;
        Wed, 10 Oct 2018 11:36:13 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n63-v6sm25021906pfn.9.2018.10.10.11.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:36:12 -0700 (PDT)
Date:   Wed, 10 Oct 2018 11:36:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010183609.GG47260@dtor-ws>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
 <20181010181148.GI32006@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010181148.GI32006@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:11:48PM -0400, Sasha Levin wrote:
> On Wed, Oct 10, 2018 at 10:02:19AM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 10, 2018 at 10:29:58AM -0400, Sasha Levin wrote:
> > > On Mon, Oct 08, 2018 at 12:20:26PM -0700, Dmitry Torokhov wrote:
> > > > Hi Michael,
> > > >
> > > > On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > > > >
> > > > > Dmitry,
> > > > >
> > > > > someone on debian-68k reported the bug, which (to me) indicates that the
> > > > > code is not just used by me.
> > > > >
> > > > > Whether or not a functioning Capslock is essential to have? You be the
> > > > > judge of that. If you are OK with applying the keymap patch, why not
> > > > > this one?
> > > >
> > > > I have exactly the same concerns about the keymap patch. This all has
> > > > not been working correctly for many many years (and it was not broken
> > > > in a subtly way as far as I understand, but rather quite obvious).
> > > > Thus I do not understand why this belongs to stable release. It is not
> > > > a [recent] regression, nor secutiry bug, nor even enabling of new
> > > > hardware, that is why I myself did not mark it as stable.
> > > >
> > > > I still maintain that we pick up for stable too many patches for no
> > > > clear benefit. This is similar to the patch for Atmel controllers that
> > > > was picked to stable and I asked why, as it is not clear how many
> > > > users might be affected (or if the problem the patch was solving was
> > > > purely theoretical, or only affecting hardware that is not in
> > > > circulation yet).
> > > 
> > > If you belive that a certain piece of code has no actual users, why do
> > > you keep it in the upstream kernel to begin with?
> > 
> > Because obviously there are users. Maybe 5 of them, maybe 10. They do
> > not follow upstream very closely (otherwise these fixes would have
> > appeared in mainline long time ago) but they still exist. And it is not
> > hard to keep the driver in if there are not many changes.
> 
> It, similarily, not hard to backport these changes to stable tree
> especially if they're in a self-contained driver such as this one.

It is easy to backport, but that should not be a criteria. If we
backport each end every one patch landing into mainline into stable
then "backporting" is trivial. It does mean that it should be done.

> 
> > > 
> > > I don't think it makes sense to keep something upstream because it might
> > > have users, but not backport fixes because there might not have any
> > > users.
> > > 
> > > You haven't seen evidence of anyone using/caring about it for a few
> > > years? Great! Remove the code and if someone complains we can always
> > > revert. This is how all those orphaned archs got removed a few releases
> > > back. I'll even submit the patch if you'd like.
> > > 
> > > It doesn't make sense to have "second class citizens" like how you
> > > suggested.
> > 
> > Sure does. Look, one of roles of a mantainer is basically a release
> > manager. We need to decide what goes into new release, what goes into
> > maintenance release, what stays until later milestone. Each release has
> > different criteria. With maintenance release you want to minimize the
> > disruption while alleviating most recent and critical/high visibility
> > issues, IOW you want to get the most bang for your buck. And these
> > particular fixes do not give you any bang, none at all.
> > 
> > Same goes for patches that deal with error handling in probe() functions
> > that your AUTOSEL scripts like to pick. Yes, they are fixing bugs. But
> > show me actually users affected by them? You encounter these issues with
> > probe when you do initial device bringup, but once device is stabilized
> > probes are expected to succeed. There won't be duplicate sysfs
> > attributes, memory will be allocated, and so on. Fixes to remove() might
> > be worthwhile if it is a hot-pluggable bus, but otherwise - no. Yes, the
> > box may OOPS if someone manually unbind device through sysfs, but the
> > solution is no to patch stable kernels, but simply tell user "dont to
> > that [yet]".
> > 
> > When selecting a patch for stable ask yourself: "if I do not pick this
> > for stable will a distribution be willing to patch this into their
> > kernel on their own"? If the answer is "no" it should be pretty strong
> > indicator whether a patch belongs to stable or not.
> 
> There is a big difference between distros and the stable trees. Distros
> know who their users/customers are, OTOH we have no clue who the users
> of stable trees are.
> 
> I think Greg's last estimate was that about 1/3 of the kernels in the
> wild are custom based on a kernel.org stable kernel, which means that we
> have no visibility as to what they do with the kernel. If you don't know
> who your users are, how can you prioritize some subsystems over others?

You make a judgement call, based on the data you have. And I think if
you want override maintainer decision you need a decent justification,
better than "it is easy to backport" or "we do not know if someone might
use it".

> 
> I don't think we can do any of that because we don't know who uses the
> kernel and what bugs they hit, or don't hit.

They should file bugs, report on mailing lists, and so on. If they hit
bugs and do not bother to report them anywhere, it is not our problem.
They need to be part of community.

> This is one of the reasons
> we ask everyone to pick everything, if they don't use whatever code we
> changed they won't be affected at all.

Or there is unexpected behavior change and they are affected. What do
you do if users of atakbd adjusted their userspace for the broken kernel
map? From my POV it is OK-ish to change in new kernel release, but
not in a middle of "stable" series.

> 
> As a trivial example: we run a few kernels with custom configs in
> Microsoft. Can you tell which drivers we use and how many machines use
> them? Us not showing up in git log doesn't mean we don't use something,
> it just means that the stable process works for us.

I can tell you that you are not using atakbd ;)

Look, if we are talking about Microsoft, what are criteria for changes
that are going into "patch tuesday" releases? Is it any random junk that
might land on top of the development tree? Or is it just a bit more
disciplined? Like Release managers looking at the incoming problem
report rates and make a judgement call as to whether pull the fix in or
wait for bigger maintenance release? In ChromeOS land it is the latter.

Thanks.

-- 
Dmitry
