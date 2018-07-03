Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C9EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AD323F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfpc5PZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AD323F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbeGCWHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:07:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41991 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbeGCWAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:00:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id g12-v6so2616874edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 15:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1NDtu3iLaFTbyqoVjiuXvC55TtLfjP7L5m+Gsq4zK1Q=;
        b=hfpc5PZsj1EOVsKOM8EbWqpo83ot/2EYsuB8iNjsz8QcVPQtadLTAlA7qEIVY0lRUe
         WdkZxo5lartJfFD8m2J9KhYHmqgwy+iofV8BjB59fKPSUQuP7oMUDkaXXepSUFVGq48s
         pk2LFKSTAEDrhQu85Z5HugYqtt8upxBQB/bb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1NDtu3iLaFTbyqoVjiuXvC55TtLfjP7L5m+Gsq4zK1Q=;
        b=iii/Jt2BtVyRBYyp8hgndXpMT0StiHaTrdA7+KCaSomS65CWH6rFiboureImLI3m8Q
         5IqmcNfxCrn4l+lrf0XtsYqFUklTDDXysMmCt5PE31NSJehk1+GHeGIPcKvF6H5NZjv7
         sYKl8EyI9ha3Tk4/TmOOwF7ZaDbHM2x0SLf1kMUlBVxW9yTwf+QbHMIfVbJV1N635deO
         V6cA9o4FSpos+LaRg60fmzFnE/+0iaT1L9TwOj3zYPP1nDBEHnV4nufeQqh5rQ2P2+hj
         9Jqi7m5cOGktfc/dKd9Y6iVImmQRDvRTMmg+EVdxOXzj4zhq8aE+iAoKaM6OxkDvtkhk
         qjmQ==
X-Gm-Message-State: APt69E32v2OpBJTwIk2aDqbkZ4I7ilqfmkTjzIT8GQwTX4SgujNdZzkd
        rB1fo+FbzUODO4srLD8/0uybo98JLCngp4K6NLJkMA==
X-Google-Smtp-Source: AAOMgpedm+869HDuoQ7pcaKuH8kKUfMl6cm1N/KDYRnDI98M+jw4mWkvg+YFHmITgb59KmkypOcEF8bV0qb2lRR7xp8=
X-Received: by 2002:a50:8fe4:: with SMTP id y91-v6mr29939317edy.295.1530655250672;
 Tue, 03 Jul 2018 15:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
 <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com> <20180703105652.psjq5cq4t7o2j6zk@um.fi.intel.com>
In-Reply-To: <20180703105652.psjq5cq4t7o2j6zk@um.fi.intel.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 3 Jul 2018 16:00:39 -0600
Message-ID: <CANLsYkw4w-zRczcb2uddO4UsxXrCCoXCSkPko2it-OJX2H0ecA@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
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

On Tue, 3 Jul 2018 at 04:57, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> On Tue, Jul 03, 2018 at 01:03:48PM +0300, Alexander Shishkin wrote:
> > On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
> > > +/*
> > > + * PMU driver configuration works the same way as filter management above,
> > > + * but without the need to deal with memory mapping.  Driver configuration
> > > + * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
> > > + * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
> > > + * bring the configuration information within reach of the PMU.
> >
> > Wait a second. The reason why we dance around with the generations of filters
> > is the locking order of ctx::mutex vs mmap_sem. In an mmap path, where we're
> > notified about mapping changes, we're called under the latter, and we'd need
> > to grab the former to update the event configuration. In your case, the
> > update comes in via perf_ioctl(), where we're already holding the ctx::mutex,
> > so you can just kick the PMU right there, via an event_function_call() or
> > perf_event_stop(restart=1). In the latter case, your pmu::start() would just
> > grab the new configuration. Should also be about 90% less code. :)
>
> Also, since it affects the AUX buffer configuration, it is probably a one
> time ioctl command that you issue before you mmap the buffer. If that's
> the case, you don't even have to worry about stopping the event, as it
> shouldn't be running, because without the buffer perf_aux_output_begin()
> should fail and so should the pmu::add() iirc.
>

The idea behind the current approach was to make the SET_DRV_CONFIG
ioctl() usable by other drivers where multiple ioctl() calls could be
performed while a session in ongoing.  I also opted to introduce a
_sync() function to let the PMU refresh its configuration at the time
of its own choosing rather than having to interrupt the session.

But all I need for coresight is to have available the sink information
and PMU configuration (in an upcoming patchset) by the time
setup_aux() is called.  You are correct, this is a one time
configuration and since the event isn't running there is no need for
locking - I should be able to access the PMU when the ioctl is called.

If you are fine with this bare-bone scenario and don't care much about
usability in different situation, I'll do a respin with minimal
functionality that cover my needs.

Thanks for the review,
Mathieu

> Regards,
> --
> Alex
