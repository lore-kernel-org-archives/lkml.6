Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF91C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26367208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPfcZnwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26367208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeGIVpc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:45:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41264 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGIVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:45:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id b12-v6so15059180edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myIBQYp6xEsSyR8zr6XOO90C6k+eMKk08UYvtZiZE0s=;
        b=VPfcZnwzGq58W3QPfvoU4XobNj6m4pjcy4tikSY4Ya6N2qm/YWkcVflhuXr+z5jZI7
         qbbnyfOdyWQOb68Nb1TOsjKG+8MtGv+YNHNJ8honftQ+rCozbPuI2AaWI5mMjmQ1szCa
         BN44SGE459nVVIeBXB4E3G/9mYr4A+uB4k+x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myIBQYp6xEsSyR8zr6XOO90C6k+eMKk08UYvtZiZE0s=;
        b=m2CIR2Yl405mFay6kpjL2JqDy82N7Oehii+lCEUagAFrO7WkTC/uiTtSw3mLID5rwW
         7OPKB71+0/Jmm1mX1kEH3PANfnPPzSRw2OcQ0mE4xUKLEyNExWiqXl+gnnHNJzKbXxNV
         mvjUj5mpR9+DbWeUpe92zin4dkV7PfTx0e6iqan4haHmcp0jBRT8XbYo9tkNHTHkSRYr
         SFfnf74kfKotv5MK/FmDj/Bhsi2fnGhxYXAGb2sNMMRXkd4BukLV2OooWDWF3L8nP4FG
         beFrJ4QDo8GGnJQWb6atkX+thqqmIkl4AL/IyFqiYJDN/oskj7Dh+gmyZAysKxnW+1EX
         V1Zg==
X-Gm-Message-State: APt69E0PL4v4f64gBsUvt4DPzP4BOpuAdY0XSGnxMWdAJTuvQHN3uLXT
        YJGzKX3BVti1b317eG0Mz9i6p+e1basmWPvrWyX/fQ==
X-Google-Smtp-Source: AAOMgpcYeATKww+uCoK938I8IuRUb60xy7a4Sz0ROKM2q9ziBHJ0Mvor4tvzXrRnvpjLb1mWj7oajQ6U26mPkzYkH2c=
X-Received: by 2002:a50:b613:: with SMTP id b19-v6mr24064919ede.255.1531172728631;
 Mon, 09 Jul 2018 14:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
 <1530828827-11604-3-git-send-email-mathieu.poirier@linaro.org>
 <20180706182222.8af97a96d613c90415cb202f@arm.com> <CANLsYkxkhbB3i2NP-DCyPUo7sSUNPvEsPM5MLaJOJbd6ZwLYNA@mail.gmail.com>
In-Reply-To: <CANLsYkxkhbB3i2NP-DCyPUo7sSUNPvEsPM5MLaJOJbd6ZwLYNA@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 9 Jul 2018 15:45:17 -0600
Message-ID: <CANLsYkxdmTsi4xGrVPvYC1cDtW-ca6ETj-BK8FOTQH5RE1XELw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] perf/core: Use ioctl to communicate driver
 configuration to kernel
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-s390@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, heiko.carstens@de.ibm.com,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, schwidefsky@de.ibm.com,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 at 10:49, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> On Fri, 6 Jul 2018 at 17:22, Kim Phillips <kim.phillips@arm.com> wrote:
> >
> > On Thu,  5 Jul 2018 16:13:42 -0600
> > Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > Hi Mathieu,
> >
> > > This patch adds the mechanic needed for user space to send PMU specific
> >                       ^^^^^^^^
> > I think you meant 'mechanism' here:  mechanics fix cars :)
>
> I really meant "mechanic", as in "functional details or procedure" [1]
>
> [1]. https://www.merriam-webster.com/dictionary/mechanics
>
> >
> > > +static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
> > > +{
> > > +     unsigned long flags;
> > > +     void *old_drv_data;
> > > +     struct pmu_drv_config *drv_config = &event->hw.drv_config;
> > > +
> > > +     if (!has_drv_config(event))
> > > +             return;
> > > +
> > > +     /* Children take their configuration from their parent */
> > > +     if (event->parent)
> > > +             return;
> > > +
> > > +     /* Make sure the PMU doesn't get a handle on the data */
> > > +     raw_spin_lock_irqsave(&drv_config->lock, flags);
> > > +
> > > +     old_drv_data = drv_config->config;
> > > +     drv_config->config = drv_data;
> > > +
> > > +     raw_spin_unlock_irqrestore(&drv_config->lock, flags);
> > > +
> > > +     /* Free PMU private data allocated by pmu::drv_config_validate() */
> > > +     event->pmu->drv_config_free(old_drv_data);
> > > +}
> >
> > I got this stacktrace whilst testing a perf tool *without* this series
> > applied, running on a kernel *with* this series applied:
>
> That shouldn't matter as I kept the changes backward compatible
> specifically to handle this situation.
>
> >
> > [  132.942054] INFO: trying to register non-static key.
> > [  132.946964] the code is fine but needs lockdep annotation.
> > [  132.952389] turning off the locking correctness validator.
> > [  132.957818] CPU: 2 PID: 2835 Comm: perf64-sans Not tainted 4.18.0-rc3-00196-g5b5d957532a8-dirty #146
> > [  132.966856] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
> > [  132.977527] Call trace:
> > [  132.979947]  dump_backtrace+0x0/0x1c0
> > [  132.983567]  show_stack+0x24/0x30
> > [  132.986845]  dump_stack+0x90/0xb4
> > [  132.990122]  register_lock_class+0x57c/0x580
> > [  132.994343]  __lock_acquire.isra.12+0x6c/0x980
> > [  132.998736]  lock_acquire+0x100/0x1e8
> > [  133.002357]  _raw_spin_lock_irqsave+0x58/0x78
> > [  133.006667]  perf_drv_config_replace+0x4c/0x80
> > [  133.011061]  _free_event+0xbc/0x460
> > [  133.014507]  put_event+0x2c/0x38
> > [  133.017697]  perf_event_release_kernel+0x1ac/0x300
> > [  133.022434]  perf_release+0x10/0x20
> > [  133.025883]  __fput+0xa8/0x1e0
> > [  133.028901]  ____fput+0x20/0x30
> > [  133.032006]  task_work_run+0xa0/0xd0
> > [  133.035539]  do_notify_resume+0x118/0x120
> > [  133.039503]  work_pending+0x8/0x10
> >
> > Is a raw_spin_lock_init missing perhaps?

I read your email too fast... That's exactly what it was.

Thanks for giving this a spin,
Mathieu

>
> Not that I can tell - I need to investigate.
>
> >
> > Thanks,
> >
> > Kim
