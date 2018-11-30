Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D94620867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECdzdTRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D94620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeLAFPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:15:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35081 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeLAFPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:15:20 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so10611769itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a43LC2+4MAeMgP4igS8FVKZSHAUCT+u0zToUDddAkqI=;
        b=ECdzdTRmPqsRenzzLUYd1cvwmKrJBeGDGQrZEkjBcvE3o95fimJc6FCHLuyHyccYM/
         Vv4lypSZU693Jyse70NWt0AhlCKdUq5E8Rko3m33dpJUOq/E4CHBEV04H6EGSXmxomZZ
         HQjCOBHJWdXGEz1XOHpm7hQr8IlV8FDRMLlDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a43LC2+4MAeMgP4igS8FVKZSHAUCT+u0zToUDddAkqI=;
        b=VRwV70peINRIMzcIDZBIQ9f/AAOjkb+HpU1n/MGMcSFNXnpuCwMMSE4G74CMziddIR
         DNZF/fGaScMnhcESHfBORQ8W7gLzXaF+TsFj04ekaqvxSU2Y9VsTE9ZLuJXy2zcdOmge
         GjFqqU0ScF2DD8w9jB6PsSuCHdlNmln1+JUwDE/H9Tt89XVTDraDjMUFrrHAJwwEoOoA
         dRFq5+OJhWj+9UjgaCyXIQlEklk/Uz+JVJ6VBLNc+/A2i1mN8cDxU4nY1EAkpB4DUvhl
         7i13/kQaQr0/HBrBvnLFzy5aVwDwpdqcdBpZuiKGA9I7fPjPg2BCuhtkJUb8Y2VLEZAf
         DyaQ==
X-Gm-Message-State: AA+aEWYK8Su28LIPkIF+KqZDx7QK2qiLXn+aLxhV8pJJsJca5ahdkvjf
        T4jPB06gvlWINp/QLZqmoXdXT5hIwYZ3JuCQOV5YVA==
X-Google-Smtp-Source: AFSGD/UOutzJiAIsPArlD/Uevkn+hzwz7NexH+71fGQJB8JFciQ0GLyyriLXcKtUiUuT0kuD6lV9KgPB1VBZxV8WgXE=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6363976itg.137.1543601113722;
 Fri, 30 Nov 2018 10:05:13 -0800 (PST)
MIME-Version: 1.0
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
 <20181129074936.GE12347@kroah.com> <20181129230915.GA8881@xps15> <20181130074253.GA3314@kroah.com>
In-Reply-To: <20181130074253.GA3314@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 30 Nov 2018 11:05:02 -0700
Message-ID: <CANLsYkwcbbrPAE1=_R-HZ4XtT7_=wyWVSaADbfis+_YjiuZfww@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink selection
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
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

On Fri, 30 Nov 2018 at 00:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 29, 2018 at 04:09:15PM -0700, Mathieu Poirier wrote:
> > Hi Greg,
> >
> > On Thu, Nov 29, 2018 at 08:49:36AM +0100, Greg KH wrote:
> > > On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> > > > This patch uses the PMU driver configuration held in event::hw::drv_config
> > > > to select a sink for each event that is created (the old sysFS way of
> > > > working is kept around for backward compatibility).
> > >
> > > It is "sysfs", no InterCaps please, I've never called it that in the
> > > past.
> > >
> > > And just use sysfs, if that does not work properly, then fix that, don't
> > > create yet-another-way-to-configure-this-thing to just confuse people.
> >
> > Thanks for the review, you've provided usefull comments.
> >
> > Regarding the "char *" argument for the ioctl, I followed an example that
> > currently exist but I can proceed differently.
>
> What driver currently uses a char * on an ioctl to parse arbritrary
> userspace information to set its configuration?  That should be fixed...
>

Perf filters [1] are communicated to the kernel as a char *.  Given
the dynamic nature of event creation I really don't know how else it
could have been done.

[1]. https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/perf_event.h#L459

> > My goal with this patchset was specifically to fix what is wrong with sysfs and
> > completely take it out of the equation.  The only reason to keep the kernel
> > interface alive was to prevent braking older user space perf tools currently
> > using it.
>
> That's fine, just don't create a new syscall that takes arbritrary data
> and parses it in the kernel, that's not ok.

You got it.

>
> > I chose to use an ioctl() because it is flexible and well suited for the dynamic
> > nature of perf events.  It is also currently used to set various event specific
> > configuration so doing the same adds to the established pattern and avoids
> > creating a new way of doing things, something the perf crew would have been
> > quick to point out.
> >
> > Was my approach wrong?
>
> I don't know how the perf interface works, so perhaps work with those
> developers to sync up and match what they use today?

I have already done a fair amount of work with them.

>
> But step back, what exactly are you trying to do here?  You have an
> implementation of a solution but I don't see the problem stated anywhere
> here.

In the coresight world there can be more than one sink to aggregate
trace data generated by CPUs, hence the need for users to select which
one to use from the perf command line.

Up until now sysfs was used to communicate sink information to the
kernel but that was never the right way to proceed because it breaks
when more than one perf session are created at the same time.  The
situation was manageable when working with per-thread scenarios where
a single HW trace event is created but in CPU-wide mode a HW trace
event is created for each CPU that is specified on the perf command
line, taking us back to the concurrency problem we have when dealing
with multiple per-thread session.

Since my goal is to add coresight support for CPU-wide trace
scenarios, the issue with sysfs concurrency needs to be addressed
first, which this set is aiming at.  Sysfs is a problem so I'm
removing it in favour of an ioctl() where a specific sink can be
assigned to each event.

The above should probably go in the cover letter.  Let me know if you
want more information.

Thanks,
Mathieu
