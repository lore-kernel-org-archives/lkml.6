Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3256B20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQF9nSVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfAaKG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:06:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42376 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:06:27 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so2126594ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SG7v4bRVtQBwELW4peWymZeXzLc+LVRGGc44ak/ZhLU=;
        b=YQF9nSVMjqVd/G146UommuM1SKs60XsM0YZ3vx9/sdB4CChDAKt05htpnqF1+/+KKi
         PnPurKFST2zoBFJCQTntigs3zMQtVVV51lrPT62Rjn2Sz0F0oyX2mSrtIgHg6MFYYS20
         nFxtnWFcUMqwdURHjktA2QAXfIWx7At3mK1xrxfTJqi7eiFsIrjs4IpSjIA8rdgl36l/
         EaywDAXpSAtTJrl71LUmFO+8qr1j07kcFsoydko0DhRygZoQCE0AWL9FM9U5o5sxhSAN
         92j+BjXH/ezUkUatHsXjrSdlUgti2D9/pzEnuLz30x3BwAjVdyE1awqeXgDH4meK/pQU
         oUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SG7v4bRVtQBwELW4peWymZeXzLc+LVRGGc44ak/ZhLU=;
        b=n9buDh8R+AtGywMrxm7gN0zlmBcTQdYBAxHyodBQP7SBuU9XzJenRQ5r8GUaH2D3iN
         C70ZUWog02RH/hEQMZ9EG6SI93UMCSZRItYJ1uEacIdw66lr73GMCeXs9DaKAFPnVnbM
         RTvPMbgsedaQxA6P9202v7xDbYDbBD7nbYB2zgIboAlmClIayXInRKWLmZgFQMNf1LWA
         Q1pG8epMSDPVoOjP1wABT/XaNUFpkMxun865qb0JRQpphYDsrY9mPqNpcCcDaktwGmWG
         QaCVsnGGqSUeVjh6RYVSCbntil7b/bYPkkp6cI9xidmZIi0qwzj+2ROI33uxOWwr9kQh
         Zk/Q==
X-Gm-Message-State: AJcUukcXI1W0HfcLvYZrv0YVdHo9uiJWwCin0ikRLBs+jda57Ddh/6go
        jOTh239xZjP+fpKC5jqR3E+6Q2/JljU/eTHr63d9/A==
X-Google-Smtp-Source: AHgI3IZJ4fZGZwRfOEkTejgO9PE+tjdzRKuAW43U+v1aWQ7MfSutJzIgri3lI1eEW6hxs9VboLre30plhf34QwlzDcY=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr18538473ioh.271.1548929186449;
 Thu, 31 Jan 2019 02:06:26 -0800 (PST)
MIME-Version: 1.0
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <20190121123836.GC47506@lakrids.cambridge.arm.com> <CACT4Y+Y6JNyQ+SSZXDSYVcBXZ_e1Hf3OMpoz=1eqGNhNKqYikg@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B9BBF9@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B9BBF9@IRSMSX102.ger.corp.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 31 Jan 2019 11:06:15 +0100
Message-ID: <CACT4Y+Y5Y54iWn3w2jifjecDb+dZa_B=qZBsKTH8immHktij2Q@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:04 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>  > Just to check, has this been tested with CONFIG_REFCOUNT_FULL and
> > > something poking kcov?
> > >
> > > Given lib/refcount.c is instrumented, the refcount_*() calls will
> > > recurse back into the kcov code. It looks like that's fine, given these
> > > are only manipulated in setup/teardown paths, but it would be nice to be
> > > sure.
> >
> > A simple program using KCOV is available here:
> > https://elixir.bootlin.com/linux/v5.0-rc3/source/Documentation/dev-
> > tools/kcov.rst#L42
> > or here (it's like strace but collects and prints KCOV coverage):
> > https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c
> >
>
> Ok, so I finally got to compile kcov in and try the first test program
> and it works fine as far as I can see: runs, prints results, and no WARNs anywhere
> visible with regards to refcount_t.
>
> I did my test on 4.20 with CONFIG_REFCOUNT_FULL=y
> since I have serious issues getting 5.0 running as it is even from
> the stable branch, but unless kcov underwent some serious changes since December,
> it should not affect.

There were no changes that should affect this part.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


> Is it ok now for merging this change? The stricter mem ordering on dec_and_test
> hopefully will also lands soon.
>
> Best Regards,
> Elena.
>
