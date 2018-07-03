Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A78CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E4249C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NR3y63gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137E4249C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbeGCRrO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:47:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43333 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934222AbeGCRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:47:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id u11-v6so2200198eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mHU1juF5G44FcvmUacMZQ/o66H1kMQ2zZeEOKce9NI=;
        b=NR3y63gcwNdEfFyVFSKd123NZ87SqMEn5xHFW5dW1oaQS1rN5r2n5t3EWbTDFL/13g
         VRap6XJTmK1/Phg7x21NDkElkmUHRpvR/5w1LZpEnPYffMVRVnQzwUmdULeVc2uhKgIF
         zw5GASJdZC29w//mfJ5I0mgJGqNYU8x2f9W7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mHU1juF5G44FcvmUacMZQ/o66H1kMQ2zZeEOKce9NI=;
        b=lpdWjo/Vp1rnMLdHkuca4VaL10UxvRkw19QZHYeuCPJ9IRPSxmPQJDPejDxAArFHlC
         /ffL9QIMVJcS2pmMQjYbA+aowerwLJWvS3JDs+/kFjwN3tZoCTl53XqVKdFD0dN0HGjc
         hZPuX2x3R1cN3Ph8FRmqRH/6PF+/mMZjU8LH/joEPNGkCKo7/0KCXBP+l8rHGmXYA70A
         vGxgHOB/XyIa0fg6uEYdfWrYbbgyBrX46jN/p3/C+6xqkfrNLF7wZnPWKkYXbpJgxAkW
         tSsM2cHvbfBYhLgxOwJPrPCQ8H7B9/lcqM+0KS0MRndjbWb1LC6u3wRi++0DnRo6OqHb
         XGnw==
X-Gm-Message-State: APt69E3e0sWnN0VyqnN9eqXPg+dHHcQ7NLf8HtbMqxueJVxZjGjAVaAb
        O9kizh5q1RqTt5QNXR4xrnAn5Zr38Nef/MxLpPSZtA==
X-Google-Smtp-Source: AAOMgpcnJ5u9W1qY2wi+a2sOk9RTDCTru3z/uf3U0J+iLC3lhqw2Grj06imZTVdr2EFPYftoecNDAkfAzVjfEafJLos=
X-Received: by 2002:a50:8fe4:: with SMTP id y91-v6mr29305393edy.295.1530640031673;
 Tue, 03 Jul 2018 10:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org> <20180703134026.GA3728@krava>
In-Reply-To: <20180703134026.GA3728@krava>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 3 Jul 2018 11:47:00 -0600
Message-ID: <CANLsYkyAcJ3yPmdtRWnktOTLcirzxz0G2kwRjwtfhYvorXOs0Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 at 07:40, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
>
> SNIP
>
> > +static int
> > +perf_event_process_drv_config(struct perf_event *event, char *config_str)
> > +{
> > +     int ret = -EINVAL;
> > +     void *drv_data;
> > +
> > +     /* Make sure ctx.mutex it held */
> > +     lockdep_assert_held(&event->ctx->mutex);
> > +
> > +     /* Children take their configuration from their parent */
> > +     if (WARN_ON_ONCE(event->parent))
> > +             goto out;
> > +
> > +     drv_data = event->pmu->drv_config_validate(event, config_str);
> > +     if (!drv_data)
> > +             goto out;
>
> what's this check for? doc does not mention that,
> also the coresight callback does not return NULL
>

Very true - thanks for pointing this out.

Mathieu

> jirka
