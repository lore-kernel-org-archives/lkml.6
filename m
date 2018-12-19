Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A377CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7523D20449
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuAxKHSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeLSPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:20:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55660 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeLSPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:20:38 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so10160825ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FklyYJO9NHvl7kBp6w+KCXPR07gLwr2E3ER5GfyYIII=;
        b=iuAxKHSB8pIHjl8fvgUu8Z0iZ84GzDcW6S0Zi/1he/tIAgAhWtxC4BBkv/viD32vU/
         Nmwg4wavaKrai4usaEKT0M1RQn4MqjYmsSLlkV6guVmfRuOkrsrkm0wdfVb51dcJZVbB
         tMgGXMAieGqZsH4OETJTVLBFNBSBScSf192nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FklyYJO9NHvl7kBp6w+KCXPR07gLwr2E3ER5GfyYIII=;
        b=guw8yo8+weZOj4FnoItz2PH/qp20h1ncoQ06ziIAjkcllUtZgkK1A0Ne486AMifEhf
         fFQEcJ0oFXlsV/tktU+sdXDniiBOBO4UG+qbgOPbePHiiwL6VitadjIJQMGGeFHnj/Ov
         N9QLwFesCK69rUxUkTKIVwwHwFXxeEOf4FxwBQ41ByjtTVuUCcTEdKxQ+sj95k4FoDI/
         XLmalxzf7LycLHP4J3MO8cxGSwlwUNnUS8SjlYvLxhbzOoWY6ASX5uktud/hs1HECosl
         wX90jAemocaLOF0ySMNJRcRevoxeRVLMxYZnZrAZFDNj00+jRoRbCtB/FWbfUYLBO/wY
         sOTQ==
X-Gm-Message-State: AA+aEWbiKxm4cWqBpEp7mpvFRhau5YQlmjaHV2VH9TLYpBmzsUlB6KUQ
        QC5KYIVY1Ia4wlSIdWuLGldCOVm9NhEZAOM+wpdEFuybVbI=
X-Google-Smtp-Source: AFSGD/X4VBQSYqwSj/4t2idNV/8ihMhOfEtdEBwKjT4AlidKxZOHPnKRwg2g/wzNwZSvwzrfuoKD75/N+2KVgHSNONs=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr6824353itk.114.1545232838023;
 Wed, 19 Dec 2018 07:20:38 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
 <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com> <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
 <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com> <CAKfTPtAprHq4YYdJ1gnuoAcNiVFpFPnxYv_=RS6pXs8aYpjcuA@mail.gmail.com>
 <8ea1a96c-c2e0-cc3f-1cec-444706383e77@arm.com> <CAKfTPtCVqSYOC_GUdBm8_5KNMNEwXdf77mXL4SDB4_G5_iE0iA@mail.gmail.com>
 <f48118ab-8782-a096-9299-58c6b8d384bb@arm.com>
In-Reply-To: <f48118ab-8782-a096-9299-58c6b8d384bb@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 16:20:27 +0100
Message-ID: <CAKfTPtDwUqf1tKxOkJ-rU2FHUL63=smEtCRu5dqwYZC7zjvtJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 16:11, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/12/2018 15:05, Vincent Guittot wrote:
> [...]
> >> True, I had a look at the trace and there doesn't seem to be any running
> >> task on that CPU. That's a separate matter however - the rounding issues
> >> can happen regardless of the wl values.
> >
> > But it means that the rounding fix +1 works and your problems comes
> > from something else
>
> Oh yes, I never said it didn't work - I was doing some investigation on
> the reason as to why we'd need this fix, because it's wasn't explicit from
> the commit message.
>
> The rounding errors are countered by the +1, yes, but I'd rather remove
> the errors altogether and go for the snippet I suggested in my previous
> reply.

except that you don't always want to migrate all group load.
I prefer keeping current algorithm and fix it for now. Trying "new"
thing can come in a 2nd step
