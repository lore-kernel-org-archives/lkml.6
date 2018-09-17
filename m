Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60616ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226B0214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226B0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeIQSAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:00:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41854 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeIQSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:00:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so18710313oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5aHiR6+3zt3C7Vzzfckl9vUMf6yvzMEKWhn7kTjaL8=;
        b=oVD2Vu1yOwSACaHBJ8S0WaPCxLXalTOatKRlYPcVwRFkM0arhxppoahGasUQ78SRAG
         sjNVWjYw07Tlq+LHABgjttEgOlI145XZgOQNw4MHDmMh9dGbMrESyHzZF/6MxqDQF77p
         0/Y96aiEreKxGWIO2SVIaZpgKN17whF1aahgrWFlrD7R7BL8mW4uuP7OsVRllPHf7Sv3
         yX1ryYljGeUUGmP6L/BkfO+VCWiLQDegfGofi4urWmCfFoum16K7fr6cx6gLZCa64shC
         LtKGizS3Fs/1enWHwN/74yWOK7dR4qC0G0UWwb4PRFlmTnWfJwjvBppNHqmz1RBHyatj
         pgaw==
X-Gm-Message-State: APzg51CdNLGFXLeYSdg7I3hb5LE2w8WXrAlYH8KDAEl9kXwaB8b6YxL5
        lGyOKGg6v3HpnwMuLWwEerxWHXtHnTcGu3VnvrjLyQ==
X-Google-Smtp-Source: ANB0Vda/tU8xqQu6v9dWOE84IXeDpsvq7um/qpwuEj53vpgvivoS9GCx85cl4ADkwOsi80tG+iXjjdZPR2bbrnYHLc8=
X-Received: by 2002:aca:6044:: with SMTP id u65-v6mr17526928oib.323.1537187577929;
 Mon, 17 Sep 2018 05:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180827075020.GL27091@localhost>
 <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com>
 <4819575.TSNxuEWROA@x2> <CAFqZXNtzSU0KjFwYzqJCQybEvJz1GhQZHxRfJ2hj=6o_RGGLLA@mail.gmail.com>
 <20180913151455.yxvtcorxakh7vqrq@madcap2.tricolour.ca>
In-Reply-To: <20180913151455.yxvtcorxakh7vqrq@madcap2.tricolour.ca>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 17 Sep 2018 14:32:46 +0200
Message-ID: <CAFqZXNsADjmP--Gy20nkF3NjADpAT+7JAWa2raEhQMGfhoaTvQ@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:19 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-09-13 15:59, Ondrej Mosnacek wrote:
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
> The circumstances have changed with new information being added.  I
> recall violently agreeing several iterations ago with your previous
> assessment, which has also changed with this new information.  I'd agree
> with Steve that a flood of information about something that did not
> change value could hide important information.

OK, understood.

> (BTW: The expression "to violoently agree with" is generally used in a
> situation where two parties appear to have been arguing two different
> sides of an issue and then realize they have much more in common than
> initially apparent.)

I see, thanks for the explanation!  I didn't know that expression
before, so I think I took it a bit too literally :)

>
> > > -Steve
> > >
> > > > There are valid
> > > > arguments both for and against this choice, but we have to pick one in
> > > > the end... Anyway, I should explain the reasoning in the commit
> > > > message better, right now it just states the fact without explanation
> > > > (in the second patch), thank you for pointing my attention to it.
> > > >
> > > > [1] https://www.redhat.com/archives/linux-audit/2018-July/msg00061.html
> > > >
> > > > --
> > > > Ondrej Mosnacek <omosnace at redhat dot com>
> >
> > Ondrej Mosnacek <omosnace at redhat dot com>
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635

--
Ondrej Mosnacek <omosnace at redhat dot com>Associate Software
Engineer, Security Technologies
Red Hat, Inc.
