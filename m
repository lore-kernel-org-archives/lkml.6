Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FD9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260AB20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sqZboHvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260AB20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbeHWPUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:20:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35265 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeHWPUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:20:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id q13-v6so3850055lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUMMtffLyvwHe3IkcXJpzy9Y6JflRHWIpERcQRpeHfI=;
        b=sqZboHvCdzkJs1XDbwB9TVzMETEKei42jD0RfvG0YPMsbmjtDj/zRxXgXc5fKOUWFA
         1EHcvFzGECbwp9TW0KbKm0EWV00ki5ydJNGSe76EzxBqZw+jPJxCiI0Ib8xcya9tFcaC
         Lz975g+mS/xxN11RTAf3NEYO1x5Q2XOCAJdZM/DjkU48Oplt66L3GBaYUdYyv57TiYo4
         CW924w2XMHtv6OiaQseDkuY2G8juHSXrBqVvw8n4V/mf/AjeS1yfrAPXzi+lQ1N8VnAK
         aVLmCQHgxKNegW5A1ISLTaNawtZTmCG+eWaOkQilp/TMQ/wUfitWKE3jwk05bp2phAql
         kuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUMMtffLyvwHe3IkcXJpzy9Y6JflRHWIpERcQRpeHfI=;
        b=lbO9Df6YcdEDjFbYJtLqxA91EoeuxwqB+Imh9KhL/lJeP+Anlq43XgysciEG8wAA/c
         DufpSTsqfCGPSd6g79vNmDUpA5c4trXRqH+7+KpQOxP+13YgqDopAyEBXvDCLRpDTLCQ
         EHx7swJHoE4K3lOhN9kTN4RqcFf1rR/X+iaynPaBwU5kPV54VGm7mtPIULk3KjkgbHrG
         eDx9LvqaJfaubBop0j2qvpIRhsT6MzLw5q+3rQ1GAzoVMHMc+FBNnkdEFDf0ZiFb7MPA
         hE1nZgkhtRPykjuOELB4j0hLDOEV8L1ZX5xJA3hZgKNfmHvpJFqnBfB02ehxtlRX0H4N
         nXhA==
X-Gm-Message-State: APzg51AZr16VzHwUGzqjVYpt3Q1PiyYORbw/amDLg0mfR3fZKPf/j6rB
        xOfEbAHKTuqt0gDKEEJPjJycnShREbjykFGwJov3
X-Google-Smtp-Source: ANB0VdZmGDV2DjhmKbIGc7CrXuTFBp6dHC3C4mx+YYo67J8FJYOn1KPWquMSNpusNxaedY8Ow6ZxLxdlvAVBFxbOlBs=
X-Received: by 2002:a19:14e6:: with SMTP id 99-v6mr7348145lfu.26.1535025061019;
 Thu, 23 Aug 2018 04:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180820123818.27547-1-omosnace@redhat.com> <alpine.DEB.2.21.1808201721350.1551@nanos.tec.linutronix.de>
 <20180821072114.GC23069@localhost> <CAHC9VhQCB5kB9Vy-TWwu-Z62p2XcPpKwsFLB647=usVM2EE=LA@mail.gmail.com>
 <CAFqZXNuS9JeKnLJkcNYmep4by_pAC=63rPeYXkKM3eagaDEBWg@mail.gmail.com>
In-Reply-To: <CAFqZXNuS9JeKnLJkcNYmep4by_pAC=63rPeYXkKM3eagaDEBWg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Aug 2018 07:50:49 -0400
Message-ID: <CAHC9VhTCx101boUJn8d9NxhXaV+R75dueR4Xjp-gQmqKi30uMg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
To:     omosnace@redhat.com
Cc:     mlichvar@redhat.com, tglx@linutronix.de, linux-audit@redhat.com,
        rgb@redhat.com, sgrubb@redhat.com, john.stultz@linaro.org,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 5:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Aug 22, 2018 at 11:27 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Aug 21, 2018 at 3:21 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > > > On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:
> > > > > @John or other timekeeping/NTP folks: We had a discussion on the audit
> > > > > ML on which of the internal timekeeping/NTP variables we should actually
> > > > > log changes for. We are only interested in variables that can (directly
> > > > > or indirectly) cause noticeable changes to the system clock, but since we
> > > > > have only limited understanding of the NTP code, we would like to ask
> > > > > you for advice on which variables are security relevant.
> > >
> > > I guess that mostly depends on whether you consider setting the clock
> > > to run faster or slower than real time to be an important event for
> > > the audit.
> > >
> > > > >   - NTP value adjustments:
> > > > >     - time_offset (probably important)
> > >
> > > This can adjust the clock by up to 0.5 seconds per call and also speed
> > > it up or slow down by up to about 0.05% (43 seconds per day).
> >
> > This seems worthwhile.
> >
> > > > >     - time_freq (maybe not important?)
> > >
> > > This can speed up or slow down by up to about 0.05%.
> >
> > This too.
> >
> > > > >     - time_status (likely important, can cause leap second injection)
> > >
> > > Yes, it can insert/delete leap seconds and it also enables/disables
> > > synchronization of the hardware real-time clock.
> >
> > This one as well.
> >
> > > > >     - time_maxerror (maybe not important?)
> > > > >     - time_esterror (maybe not important?)
> > >
> > > These two change the error estimates that are reported to applications
> > > using ntp_gettime()/adjtimex(). If an application was periodically
> > > checking that the clock is synchronized with some specified accuracy
> > > and setting the maxerror to a larger value would cause the application
> > > to abort, would it be an important event in the audit?
> >
> > Since these don't really affect the time, just the expected error, I'm
> > not sure this is important.
> >
> > > > >     - time_constant (???)
> > >
> > > This controls the speed of the clock adjustments that are made when
> > > time_offset is set. Probably not important for the audit.
> >
> > Agreed.  I think we can skip this.
> >
> > > > >     - time_adjust (sounds important)
> > >
> > > This is similar to time_freq. It can temporarily speed up or slow down
> > > the clock by up to 0.05%.
> >
> > Like time_freq, we should probably log this too.
> >
> > > > >     - tick_usec (???)
> > >
> > > This is a more extreme version of time_freq. It can speed up or slow
> > > down the clock by up to 10%.
> >
> > Let's audit this one too.
>
> I agree with Paul on all counts. I will go ahead and prepare a
> patchset that logs everything except maxerror, esterror, and constant.

Please make sure you include explanations similar to the above in the
patch descriptions; not just the cover letter, the goal is to have
this information captured in the git log.

> Thank you, Miroslav, for the explanations!

Yes, those explanations were helpful.

-- 
paul moore
www.paul-moore.com
