Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D05ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A669214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A669214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeIQSBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:01:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33987 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbeIQSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:01:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so18749002ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcOdeIvs8mPFfCShlKEEH1peTl0C5koXCKOgyR8sEAc=;
        b=ILJoz7dv2SC9u5mCf95ENcoOonyW1vzlk1bKUjOO5BfqI2aV2Q9M9yPmV1vbPxoS9Z
         YHF60y6a7G19Iu7WXifPAHw20a+nxNwbv6ML/MOos5ZJJ5qi+eY9fNE5BfEKiPbhOzz/
         cpCSD0LR9tb+voF5r9zEpRTVhNhc6XNP688mc08d/FQhG5ilhnzBtPruRLGy1c0Takds
         bDXqN0zQoSlFUb7dxcUZzDnoS52EM6sNzTCo1v/E4R2h6c3YNT+C1r2rmnD4BE3Hu12w
         qym8jiv55IOJD9L9bAScmLfhHvroEwzc/8TjouBbrCev4dZfjiI1Ckphp9khWJlU/FQO
         D7Sg==
X-Gm-Message-State: APzg51CdNna4clCOK3G/SG0m2TBohf9gdGirzjHE3a+JmtOIhpcqs0TC
        B6bJF5JTl0iRzGZFS3Tpm4r8J6o744yJ2To9roIu1w==
X-Google-Smtp-Source: ANB0VdZ7Lr23UKYaaSSyHTAjufMy4WiajYhg9voF95BRwmkmoqtMYXW06U1IK3Wn3R3OI42tlshVojP8ZuzeeU0R9/o=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr17401704oia.156.1537187649922;
 Mon, 17 Sep 2018 05:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180827075020.GL27091@localhost>
 <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com>
 <4819575.TSNxuEWROA@x2> <CAFqZXNtzSU0KjFwYzqJCQybEvJz1GhQZHxRfJ2hj=6o_RGGLLA@mail.gmail.com>
 <CAHC9VhQwPsK1PJ=wiiG-jt-e5SXoBr0FeaL9dP=7kn2SUftDXQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQwPsK1PJ=wiiG-jt-e5SXoBr0FeaL9dP=7kn2SUftDXQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 17 Sep 2018 14:33:58 +0200
Message-ID: <CAFqZXNt-4NOEimdZXrtAGvNYVm7apNUPnAM=OAp8W+h06Qu65g@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 5:09 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 13, 2018 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Mon, Aug 27, 2018 at 6:38 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Monday, August 27, 2018 5:13:17 AM EDT Ondrej Mosnacek wrote:
> > > > On Mon, Aug 27, 2018 at 9:50 AM Miroslav Lichvar <mlichvar@redhat.com>
> > > wrote:
> > > > > On Fri, Aug 24, 2018 at 02:00:00PM +0200, Ondrej Mosnacek wrote:
> > > > > > This patch adds two auxiliary record types that will be used to
> > > > > > annotate
> > > > > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > > > > been changed.
> > > > >
> > > > > It seems the "adjust" function intentionally logs also calls/modes
> > > > > that don't actually change anything. Can you please explain it a bit
> > > > > in the message?
> > > > >
> > > > > NTP/PTP daemons typically don't read the adjtimex values in a normal
> > > > > operation and overwrite them on each update, even if they don't
> > > > > change. If the audit function checked that oldval != newval, the
> > > > > number of messages would be reduced and it might be easier to follow.
> > > >
> > > > We actually want to log any attempt to change a value, as even an
> > > > intention to set/change something could be a hint that the process is
> > > > trying to do something bad (see discussion at [1]).
> > >
> > > One of the problems is that these applications can flood the logs very
> > > quickly. An attempt to change is not needed unless it fails for permissions
> > > reasons. So, limiting to actual changes is probably a good thing.
> >
> > Well, Richard seemed to "violently" agree with the opposite, so now I
> > don't know which way to go... Paul, you are the official tie-breaker
> > here, which do you prefer?
>
> The general idea is that we only care about *changes* to the system
> state, so if a process is setting a variable to with a value that
> matches it's current value I see no reason why we need to generate a
> change record.
>
> Another thing to keep in mind, we can always change the behavior to be
> more verbose (*always* generate a record, regardless of value) without
> likely causing a regression, but limiting records is more difficult
> and more likely to cause regressions.

OK, that makes sense. I'll limit logging to actual changes in the next revision.

>
> --
> paul moore
> www.paul-moore.com

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
