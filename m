Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2932C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ACB208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d+aV+3wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ACB208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHWAyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:54:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34160 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeHWAyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:54:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id g9-v6so2497631lfh.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cm+nAL3IIhx6QRZZYR+YGJCmHAXx9DJF+n4BLRzP6dU=;
        b=d+aV+3wjv3KVmrx0Ry7/8GLpj0tQOudnHMs23HeK63bguB/flgbeU3wpoIk2xipKuZ
         s+DU3hHcvw55XS5/5737+IDSCsMRvaIoOkmlmfvVze98Do/t1g8PrddMB6aPnfbw2HUd
         xXu/OBb9wUPO7Pt1zX9g3DZrjJ+7CoJD/QZI+KmuuwxVF+ZFxHh9+UW6ac2FJgl+A8Wp
         6aCAiYmPNKdyft8POsrXx9XE4s6uLfrbmH5D0HrBijqqHg2eznP6IGb/jqo0q1gf8+pl
         TuJCM14NdBsasy0tM2J8EJddEcsYDLHggz3JQGugBHn3QwwNByAAb7woyqU48p+UMX+X
         nu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cm+nAL3IIhx6QRZZYR+YGJCmHAXx9DJF+n4BLRzP6dU=;
        b=fiHFHKAPxb2S5/3bDw3ANIr2X869X9npT6H5BCfnGciRXgUhaTNWahO1qHyWwqPYih
         yIBcOkkiRWAfJ2HOhVgl51ETOFoj58q5+oJvKWCAIBkSstRXDWTuAReiIHEIfjhEr+Ma
         u37vPshcywx/kgSpDdZthKW5PaWZk4gvKwAUn7SHXjWbFouXJAi+nmCplxnQ2KpYJHn9
         IzISj+qVvKbRa2sFWn8Pub9Yy6ncvpLrtXUn6NMEiyMiNZpfLU+a6l6HQhJIRQiTgxLL
         aCaSDHBWUJZJuzwCLYvm1aKUy2O8UNgLKELdl7VX/WdGb0GWsBTxgs3Q83mAgcgu1dT9
         PP+g==
X-Gm-Message-State: APzg51CvlQ68FZFwrhWMAGz1VKxFg6yx9S2nwtbFDO31UJ26OuvZSr8A
        aocfG7CelygMBeuJNvwUYrlSDJ2738e/uef6Xp/cag4=
X-Google-Smtp-Source: ANB0VdbnxIbYRyeTFcCFQv+USCLkTTisjGNYT7nTiU6kd0MO0cqVF4/RUDC/ga4sDrAVBXkMQUAtDApO0aR7l1JCC/c=
X-Received: by 2002:a19:14e6:: with SMTP id 99-v6mr5673367lfu.26.1534973248688;
 Wed, 22 Aug 2018 14:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180820123818.27547-1-omosnace@redhat.com> <alpine.DEB.2.21.1808201721350.1551@nanos.tec.linutronix.de>
 <20180821072114.GC23069@localhost>
In-Reply-To: <20180821072114.GC23069@localhost>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Aug 2018 17:27:17 -0400
Message-ID: <CAHC9VhQCB5kB9Vy-TWwu-Z62p2XcPpKwsFLB647=usVM2EE=LA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
To:     mlichvar@redhat.com, omosnace@redhat.com
Cc:     tglx@linutronix.de, linux-audit@redhat.com, rgb@redhat.com,
        sgrubb@redhat.com, john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 3:21 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:
> > > @John or other timekeeping/NTP folks: We had a discussion on the audit
> > > ML on which of the internal timekeeping/NTP variables we should actually
> > > log changes for. We are only interested in variables that can (directly
> > > or indirectly) cause noticeable changes to the system clock, but since we
> > > have only limited understanding of the NTP code, we would like to ask
> > > you for advice on which variables are security relevant.
>
> I guess that mostly depends on whether you consider setting the clock
> to run faster or slower than real time to be an important event for
> the audit.
>
> > >   - NTP value adjustments:
> > >     - time_offset (probably important)
>
> This can adjust the clock by up to 0.5 seconds per call and also speed
> it up or slow down by up to about 0.05% (43 seconds per day).

This seems worthwhile.

> > >     - time_freq (maybe not important?)
>
> This can speed up or slow down by up to about 0.05%.

This too.

> > >     - time_status (likely important, can cause leap second injection)
>
> Yes, it can insert/delete leap seconds and it also enables/disables
> synchronization of the hardware real-time clock.

This one as well.

> > >     - time_maxerror (maybe not important?)
> > >     - time_esterror (maybe not important?)
>
> These two change the error estimates that are reported to applications
> using ntp_gettime()/adjtimex(). If an application was periodically
> checking that the clock is synchronized with some specified accuracy
> and setting the maxerror to a larger value would cause the application
> to abort, would it be an important event in the audit?

Since these don't really affect the time, just the expected error, I'm
not sure this is important.

> > >     - time_constant (???)
>
> This controls the speed of the clock adjustments that are made when
> time_offset is set. Probably not important for the audit.

Agreed.  I think we can skip this.

> > >     - time_adjust (sounds important)
>
> This is similar to time_freq. It can temporarily speed up or slow down
> the clock by up to 0.05%.

Like time_freq, we should probably log this too.

> > >     - tick_usec (???)
>
> This is a more extreme version of time_freq. It can speed up or slow
> down the clock by up to 10%.

Let's audit this one too.

-- 
paul moore
www.paul-moore.com
