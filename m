Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF167C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2D221873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzX0gstJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLRSVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:21:04 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35922 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeLRSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:21:03 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so5610245itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmT+ojIfzoXHWFIf8qOXXNgMtq0rxEi72K/Z9JRjJPw=;
        b=FzX0gstJyd6MVmcxjRorGwjgJe274/TUviKJ/OH6kdlchlQmmMQkenUDMeGLbjviDG
         4EESjlyd2q8YRAnxssqjo4mcNhuczWd8o7K5CQXiuC+7tEj+E6p7oZeKhEvW4Gl/0vXQ
         T1atS0G/kE/qY+vjHyjKc9qydo0xWlxWkdxyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmT+ojIfzoXHWFIf8qOXXNgMtq0rxEi72K/Z9JRjJPw=;
        b=GoDxN337ZX1KFBiolEivkc420fNmJvlGdXMEeudqNAfJAMxkOkXy58E1snL3xiIv8m
         OvmHRXPXIFQzY5mlF5VohCkL1xrub70sHn8meDFhDsDy19FTxi3gLsu/52rdv1RfDGMG
         ul0fW337JHE6vpVt5J3Wv5clm1mGKGIiJeKndaUKPggkAqKfDnDR+MbfgYvJSfeswa2e
         S6PTYA2QuALXmI7AH4lToNuhIbg6pQXGynRZTjbv8xxTOZwXsYVzghmQzg0AF7aqzxsG
         pnXE9GB5SeyhBjsVyRNnHmR0DkSzX6vL4d3yO+wmdC6bHquCh6gouGgxH/ZdrCDgD/yU
         o7UA==
X-Gm-Message-State: AA+aEWYpJWualg6Dq0qsDsCMiwjIZBCrKD5K73kwWUItUAFyjjurYh84
        +HDfGrYK5d6/meJ1bM1sVelMkrW+mCd4Ir2toT7OVg==
X-Google-Smtp-Source: AFSGD/XuUmFo3bfLd7K25mnDfyShkc8U2n4xcLNMV4oqPEO8UO2v8dqn0XxeEyyZBZxw0wyc2eWfaslaWDdL3NlF8sU=
X-Received: by 2002:a02:570d:: with SMTP id u13mr16451137jaa.71.1545157262994;
 Tue, 18 Dec 2018 10:21:02 -0800 (PST)
MIME-Version: 1.0
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com> <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 18 Dec 2018 11:20:51 -0700
Message-ID: <CANLsYkwiQ6q9KTu7oK8gWiu2Rq+iVbRJnXxr5abZ1RSKgs1GyQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, 18 Dec 2018 at 08:21, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
>
> >> +    /*
> >> +     * The HW mapping of a component is unique.  If the value we've been
> >> +     * given matches the component's start address, then we must have found
> >> +     * the device we are looking for.
> >> +     */
> >
> > To be frank, I don't quite like the idea of passing the base address of the
> > component as the key to locate a device, (even though that is unique and readily
> > available). I would rather prefer a programmable way to map the keys to the
> > "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> > address is not obvious from the name). Also if we decide to use a platform
> > agnostic naming scheme, it becomes even more complex.
> >
> > We could assign a static "id/key" exported either via the device sysfs dir or
> > the "pmu" dir. I prefer the latter.
> >
> > Thoughts ?
>
> So, my understanding is that we have a bunch of trace sources and a
> bunch of trace sinks to choose from when we set up the perf event. The
> current model basically treats trace sources as PMUs and relies on the
> sink configuration process to be done via sysfs, which is not ideal as
> an API.

That is correct.  Most of the grief comes from the fact that when
tracing CPU-wide session sinks are concurrently used by more than one
CPU.

>
> The first thing that comes to mind is: can then the sinks be made their
> own PMUs, so the above can be done via the existing SET_OUTPUT ioctl?

I had a serious look at the SET_OUTPUT function as part of the
research that pre-dated implementing CPU-wide support for coresight.
The core does not allow events assigned to different CPUs to use the
same mmap'ed area, which is perfectly understandable.

To me the problem of sharing a sink between CPUs is inherent to
coresight and should be fixed within that framework (see full work
here [1] if interested).  The implementation associates a sink with an
mmap'ed area, just like PT and coresight --per-thread.  Where things
differ is that for coresight CPU-wide the sink is kept in function for
as long as a CPU is using it, ignoring other request for updates or to
switch it off.  So the first CPU to use it turns the sink on and the
last turns it off after collecting trace data from it.

Thanks,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/log/?h=cpu-wide-coresight

>
> Regards,
> --
> Alex
