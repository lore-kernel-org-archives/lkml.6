Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB53EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7125A21727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUv10KxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7125A21727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeHNWbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:31:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45603 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeHNWbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:31:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id w16-v6so16311201ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llkQV3WFKy6ip5gEZVZuagcLpC3OP39sC9fqPSMljS0=;
        b=TUv10KxWnmSOm1iYsApuSd32I4JA2EEMr1It5tpZ3IbpFl5SRBrNLHdp5hTC4ljw0w
         Y5APpiGK7tGvGl+18rt87O++iw7G7VYsbeJD+OP5mLq7SQhOYKXnjfA0wAC9nj5uT1Zr
         dVuHn/AcC26w8a25onR1xc5VfqXtYa+/WUeFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llkQV3WFKy6ip5gEZVZuagcLpC3OP39sC9fqPSMljS0=;
        b=WInROO/YhhmDRZ5pdh8kiQGwZ7R8Bw5LJLKMFWyU0m9shAX8bF3HxpVfK/jpFECu8D
         bQCW0Y/XyhtsuhqAqXwOz3ykhgIJxhG9THmNYrrxAfjG/083gGBE0Iw5SFsh5oPRQG59
         kTSuJWHRw/zQIkDPhHJuWZKVAJhNECsKwms+anHQgYKPQbPvM4zem7oH5mCC22BzQzzg
         kvBORSMmSquIciQwQ+vSp39xUNOvoJe7+3roKS1XTsq9hKRjlrAGYS4OsOgVwq8dWu/D
         KCQ9udV4SD7XsnpCYq5WcSa3xKstB+z/CbW0UYMduPGXJ7PqkB0L8tnaP8P+/0cISHGF
         F1Qg==
X-Gm-Message-State: AOUpUlGkpwXweenB05RIpUXjgnvP6KJMqB2MTnpgjM6zDVDVsmTfdLpx
        NGw9JzelWtqU2+Y0p0zHc7GQyFzWSp4TpFYcdLRJag==
X-Google-Smtp-Source: AA+uWPzpT5vXIoQIYbsI4CsGr3wTa25E044s9GY5HKLDfkwfubeQuZwTvb/bKGW6erKGR13qDstoqyOkWUjGyDCoD9o=
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr16991136lje.105.1534275758187;
 Tue, 14 Aug 2018 12:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
 <20180813124642.3d49c082a95fc294d926016e@arm.com> <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
 <20180814120910.ed225bbc462c58b09e5d68de@arm.com>
In-Reply-To: <20180814120910.ed225bbc462c58b09e5d68de@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 14 Aug 2018 13:42:27 -0600
Message-ID: <CANLsYkxZ_Wts6k9yqJhJf_R5oh74svpcuoNxhtFf6h3mz8U4ZA@mail.gmail.com>
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

On Tue, 14 Aug 2018 at 11:09, Kim Phillips <kim.phillips@arm.com> wrote:
>
> On Tue, 14 Aug 2018 10:15:56 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> > On Mon, 13 Aug 2018 at 11:46, Kim Phillips <kim.phillips@arm.com> wrote:
> > > It yields success for the --per-thread case..:
> > >
> > > $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ --per-thread uname -a
> > > Linux juno 4.18.0-rc8-00011-gb82af52c4b35-dirty #147 SMP PREEMPT Thu Aug 9 11:20:37 CDT 2018 aarch64 GNU/Linux
> > > [ perf record: Woken up 0 times to write data ]
> > > Warning:
> > > AUX data lost 1 times out of 2!
> > >
> > > [ perf record: Captured and wrote 0.067 MB perf.data ]
> > > $
> > >
> > > ..but not for CPU-wide?:
> > >
> > > $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ uname -a
> > > failed to mmap with 12 (Cannot allocate memory)
> > > $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ -C 0 uname -a
> > > failed to mmap with 12 (Cannot allocate memory)
> > > $
> >
> > This patchset is getting very old and a fair amount of things have
> > changed since then.  I'm hoping to be coming out with a new one
> > shortly.  Nonetheless the above is returning an error in CPU-wide
> > scenarios while the feature is being implemented.  Isn't what you
> > requested or have I misunderstood your comment?
>
> No, sigh, I just automatically assumed the patchset would include
> CPU-wide support again.  If it were being done that way, we'd all know
> that the feature(s) this patchset adds would be doing the right thing
> for that purpose, guaranteed.

The patchset published on this list never had support for CPU-wide scenarios.

This is only a preparatory step, the first one in a few more to come.
Sending the whole thing in one go would be way too heavy and is not
realistic.

>
> The other thing that's going on here is that I'm becoming numb to the
> loathsome "failed to mmap with 12 (Cannot allocate memory)" being
> returned no matter what the error is/was. E.g., an error that would
> indicate a sense of non-implementation would be much better
> appreciated than presumably what the above is doing, i.e., returning
> -ENOMEM.  That, backed up with specific details in the form of human
> readable text in dmesg would be *most* welcome.

As part of the refactoring of the code to support CPU-wide scenarios I
intend to emit better diagnostic messages from the driver.  Modifying
rb_alloc_aux() to propagate the error message generated by the
architecture specific PMUs doesn't look hard either and I _may_ get to
it as part of this work.

Mathieu

>
> Thanks,
>
> Kim
