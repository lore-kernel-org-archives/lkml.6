Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20633C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D853320851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D853320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbeHWMnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:43:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43187 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbeHWMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:43:12 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so8060896oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 02:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLJzq+C6pa+C1Jpovr9YO+dgBwkMXPh4cixUYoASV/M=;
        b=hgSn9s49qhTlKW3y2JGHCDDQtqhiejzIN1zlDOd7Zkvv2sw0mlXXEOsMYWWEfFCYCb
         1ylIpwdgsQCgYp/VFt/Z2tqsl3Z5Yw4R/oDEckBHDxttAhrDC6CbtxF+DQNPVnmTPnNM
         h8VkwNatx7jqQlu8KEzqpDXNdEo5f8Z+RzLvaniQd9A0QcyXvfKoCqWvpmic+2b3LeNo
         T5rlJ2n3ZZUDL9BwHRk6kxrBSFd+oLgwLvWRYcSoS9IZ62gSYqOtAloXMS15GrDtZbin
         KoJxCA4cevXbwhqSeATBTOuuvPdg4CU3xORz04ikbBSgiFvmrVsNX+y60B4+Cg/K7Vwl
         11VQ==
X-Gm-Message-State: APzg51B47b921GewdK5pAqWSi8DWr5a6Z5FsuT6ZW4R1MmgKEE9o9rp2
        k2jhyaq9bl33hfnAq9a6ateRjvt8KD/Ng8vCd+vT6g==
X-Google-Smtp-Source: ANB0VdaQ8k+011XY4tmTsD1krOU5X9i70ymv3swE/oB6YVeBM/CD0eUZ9ookmyPTOr4F6ZF5QtFfvNjr2tOozHP9u+w=
X-Received: by 2002:aca:d098:: with SMTP id j24-v6mr5541907oiy.72.1535015666555;
 Thu, 23 Aug 2018 02:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180820123818.27547-1-omosnace@redhat.com> <alpine.DEB.2.21.1808201721350.1551@nanos.tec.linutronix.de>
 <20180821072114.GC23069@localhost> <CAHC9VhQCB5kB9Vy-TWwu-Z62p2XcPpKwsFLB647=usVM2EE=LA@mail.gmail.com>
In-Reply-To: <CAHC9VhQCB5kB9Vy-TWwu-Z62p2XcPpKwsFLB647=usVM2EE=LA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 23 Aug 2018 11:14:15 +0200
Message-ID: <CAFqZXNuS9JeKnLJkcNYmep4by_pAC=63rPeYXkKM3eagaDEBWg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
To:     Paul Moore <paul@paul-moore.com>
Cc:     mlichvar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:27 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Aug 21, 2018 at 3:21 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > > On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:
> > > > @John or other timekeeping/NTP folks: We had a discussion on the audit
> > > > ML on which of the internal timekeeping/NTP variables we should actually
> > > > log changes for. We are only interested in variables that can (directly
> > > > or indirectly) cause noticeable changes to the system clock, but since we
> > > > have only limited understanding of the NTP code, we would like to ask
> > > > you for advice on which variables are security relevant.
> >
> > I guess that mostly depends on whether you consider setting the clock
> > to run faster or slower than real time to be an important event for
> > the audit.
> >
> > > >   - NTP value adjustments:
> > > >     - time_offset (probably important)
> >
> > This can adjust the clock by up to 0.5 seconds per call and also speed
> > it up or slow down by up to about 0.05% (43 seconds per day).
>
> This seems worthwhile.
>
> > > >     - time_freq (maybe not important?)
> >
> > This can speed up or slow down by up to about 0.05%.
>
> This too.
>
> > > >     - time_status (likely important, can cause leap second injection)
> >
> > Yes, it can insert/delete leap seconds and it also enables/disables
> > synchronization of the hardware real-time clock.
>
> This one as well.
>
> > > >     - time_maxerror (maybe not important?)
> > > >     - time_esterror (maybe not important?)
> >
> > These two change the error estimates that are reported to applications
> > using ntp_gettime()/adjtimex(). If an application was periodically
> > checking that the clock is synchronized with some specified accuracy
> > and setting the maxerror to a larger value would cause the application
> > to abort, would it be an important event in the audit?
>
> Since these don't really affect the time, just the expected error, I'm
> not sure this is important.
>
> > > >     - time_constant (???)
> >
> > This controls the speed of the clock adjustments that are made when
> > time_offset is set. Probably not important for the audit.
>
> Agreed.  I think we can skip this.
>
> > > >     - time_adjust (sounds important)
> >
> > This is similar to time_freq. It can temporarily speed up or slow down
> > the clock by up to 0.05%.
>
> Like time_freq, we should probably log this too.
>
> > > >     - tick_usec (???)
> >
> > This is a more extreme version of time_freq. It can speed up or slow
> > down the clock by up to 10%.
>
> Let's audit this one too.

I agree with Paul on all counts. I will go ahead and prepare a
patchset that logs everything except maxerror, esterror, and constant.

Thank you, Miroslav, for the explanations!

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
