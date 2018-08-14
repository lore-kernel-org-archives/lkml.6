Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C117C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BCD216EE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtIlKoDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BCD216EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbeHNTD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:03:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47098 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbeHNTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:03:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id l16-v6so14175702lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDsve/tkZzdGny1shTMPYKbIoE1fI0/YwA2iuO3vtfY=;
        b=dtIlKoDJhtPWzcdujxNWYg1FyqDbrBdJSq10KiMXqlIbC8MwZXSOuZX6VivBW7UC8t
         5PcDXREjowS/6r579wdr21JD/9aHgHcGevOt/zaRFVIocZeAW9RDye56+gCTtZP7Ngum
         Q6DV7r2ZHd2tjy2BlDIYMCTze1pLsXv1TqvG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDsve/tkZzdGny1shTMPYKbIoE1fI0/YwA2iuO3vtfY=;
        b=F0YiVQZWOUykwz/+HcubdyvHKC+sYVgC/GKxKm0EU1UcQ58Q7YdkYFrw1r/hbFhwc2
         SteEHqC0tLLY0U69hgXNDqJdMu7an2HhV4xGY/SbcX9oVFsYDbdZL4JpFwTw3M31/Ls0
         3XD/XRhyg13Og4yV2u16dKf6HRDX2RyO3n8Qgc1Dzg5fPm+NU5sj6RRI5BopvHTNJqF1
         bx45f/QpfrnzVNXQtRr91pSSP56TZd/PxgjgsPrByewCWWgRgmqmgAITGh/TcUSzInG+
         4DdFZVZilGfmFBnk+A3FK0pUifhIrgco+tXGkKP8Vsens1hcjLWiKSt0hWFfjx3C3YEj
         Kxsw==
X-Gm-Message-State: AOUpUlF059vU5oOp2rEuMqwDz1voyFFyitEoYxEflBh/dYE+EL80JR7C
        fXwFHd5mJpNCMXXTeHac9CQxdOLkLhyZznz8iIl5LA==
X-Google-Smtp-Source: AA+uWPx3SQR5YZ+XhXh91jjzU6rIN9bD0nlgtcpA4oObUnpFgKLba8XVQjbs8y6pFHu/+OzKyBsw8m1waaTdk//jieQ=
X-Received: by 2002:a19:26d2:: with SMTP id m201-v6mr13696194lfm.43.1534263367428;
 Tue, 14 Aug 2018 09:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org> <20180813124642.3d49c082a95fc294d926016e@arm.com>
In-Reply-To: <20180813124642.3d49c082a95fc294d926016e@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 14 Aug 2018 10:15:56 -0600
Message-ID: <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 at 11:46, Kim Phillips <kim.phillips@arm.com> wrote:
>
> On Wed, 18 Jul 2018 15:48:00 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> > This set adds the capability to communiate event specific configuration
> > to the PMU kernel driver using an ioctl().  The functionatlity is made
> > generic enough for anyone to use but is targeted at the identification
> > of CoreSight sinks when operating in CPU-wide trace scenarios.
> >
> > ---
> > Changes for V3:
> > . Return an error for CPU-wide scenarios while the feature is being
> >   implemented (Kim)
>
> Hi, I'm giving this series a short test-drive on Juno.

Hi,

>
> It yields success for the --per-thread case..:
>
> $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ --per-thread uname -a
> Linux juno 4.18.0-rc8-00011-gb82af52c4b35-dirty #147 SMP PREEMPT Thu Aug 9 11:20:37 CDT 2018 aarch64 GNU/Linux
> [ perf record: Woken up 0 times to write data ]
> Warning:
> AUX data lost 1 times out of 2!
>
> [ perf record: Captured and wrote 0.067 MB perf.data ]
> $
>
> ..but not for CPU-wide?:
>
> $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ uname -a
> failed to mmap with 12 (Cannot allocate memory)
> $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ -C 0 uname -a
> failed to mmap with 12 (Cannot allocate memory)
> $

This patchset is getting very old and a fair amount of things have
changed since then.  I'm hoping to be coming out with a new one
shortly.  Nonetheless the above is returning an error in CPU-wide
scenarios while the feature is being implemented.  Isn't what you
requested or have I misunderstood your comment?

>
> Thanks,
>
> Kim
