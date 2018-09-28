Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A049206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKAQTyDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A049206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeI2Dsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:48:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43608 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2Dsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:48:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id e21-v6so7369624otk.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6JoaT5QqcFDfr2sNpa+ntHycWlLavMKmWFyVoIELwM=;
        b=MKAQTyDrVywFgsT0B1SO5kUBDfOj6H2JZC/AyU9U3K99IWglYo2+QS4Mp9LBI3zJYO
         SHMA+6Ve7xhcUUzrMAnBfttp1X4z2SuNFxTDlxnrGaN2cirvHLnCc7Ji9xfc0W1VLQ3t
         RpBh+JSwN3mzD/4+rCJxr4aCRNDtf0xbjvAgejTDSdNURtLu3iwmkssiXVtJoiTPRaPs
         5ckbuEy1R+5dx7ACiWGDBVWv8BdFknkxkxDTWhbpYtUrQvwomwb77xcf0tQXCH0pom7r
         DJ6hPQoyD3vRYF5nvS+RsCZHncDfjFEapGPa9dZINzVjYXoUG6fboOLYU/HVH5vJec7V
         16bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6JoaT5QqcFDfr2sNpa+ntHycWlLavMKmWFyVoIELwM=;
        b=WKGHclgQujSNl265p8bZtFwLiAwETo+jRXrN06jzVGprtkKw4ztLzgYnwFYhVMmm/w
         MQnRME09iRdRazIS8JNTLo2a04ewJTv+5PsSL2RNmor0tej1h+ZsIQCyuUiTxJOFVs/+
         kf4NoEeTTqnx0HIn1jNwvVjJSmxHQoEE2SF0X3mnTa8Td1hCh9dquSc5rdwSv9wEPYxQ
         n118oIrVLEY+MmObfcbeffGHgIMWheNjqd3bdb/VaEpelrCSLANvgbCFs+DwNBW5Ac2E
         olBVpuAEo4a4/7XX8EsY4kvvKHcwm6aJpa4nVulC+OcrfKlH3FRIUChHl5UOPFebkoKA
         jbhQ==
X-Gm-Message-State: ABuFfojM21n8NcPCQW08xyCdMn2djxCECkSOAnFrdfwQ04fGYryG2ws4
        lh6jB19ZZwgAz2YdZOJzDlce2rVfc7RXJf413mwdQw==
X-Google-Smtp-Source: ACcGV61CEBCT6QaY+o9/PskndvncIzOFakMdZfNeD7K6Ed3GCB30mHXDG+N9E3s1uyUGLNaLsBzj2jz9q4uDlThJIEo=
X-Received: by 2002:a9d:870:: with SMTP id 103-v6mr283311oty.292.1538169783895;
 Fri, 28 Sep 2018 14:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com> <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com> <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
 <20180928205907.GD32651@tassilo.jf.intel.com>
In-Reply-To: <20180928205907.GD32651@tassilo.jf.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 23:22:37 +0200
Message-ID: <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        alexey.budankov@linux.intel.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:59 PM Andi Kleen <ak@linux.intel.com> wrote:
> > > This new file descriptor argument doesn't exist today so it would
> > > need to create a new system call with more arguments
> >
> > Is that true? The first argument is a pointer to a struct that
> > contains its own size, so it can be expanded without an ABI break. I
> > don't see any reason why you couldn't cram more stuff in there.
>
> You're right we could put the fd into the perf_event, but the following is
> still true:
>
> > > Obviously we would need to keep the old system call around
> > > for compability, so you would need to worry about this
> > > interaction in any case!

<blasphemy>
Is that true? IIRC if you want to use the perf tools after a kernel
update, you have to install a new version of perf anyway, no? I think
after I run a kernel update, when I run "perf top", it just refuses to
start and tells me to go install a newer version. Would the users of
perf_event_open() that want to monitor this graphics stuff normally
keep working after a kernel version bump?
I realize that the kernel is very much against breaking userspace
interfaces, but if userspace has already decided to break itself after
every update, we might as well take advantage of that...
</blasphemy>

> > > So tying it together doesn't make any sense, because
> > > the problem has to be solved separately anyways.
