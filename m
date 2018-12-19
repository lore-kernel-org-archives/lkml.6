Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14877C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D622F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOz46dXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeLSPGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:06:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34048 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeLSPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:06:11 -0500
Received: by mail-io1-f66.google.com with SMTP id l22so486425ioh.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IVY7up4ZUWiDFb47rYR96dExMpbNSxpyBQZO50QO8c=;
        b=ZOz46dXOUm0SuGlvn/mE5gzqC9AY7QEesK4Eg3ZXgzGqgAvmVlDeyMzPGGvai7FM/x
         IMD/py+YqDgAAf13hjKd0IMsCZhEbsntAmx8smeRu3USz8VYW1AuXUDrSfuvhC2e326I
         1V4S2yXCJz6rZki1ll6olUGvKld7OupvfFvGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IVY7up4ZUWiDFb47rYR96dExMpbNSxpyBQZO50QO8c=;
        b=OL0jqDMXKAkQkv2mVQWbqRyF1BzcS5QggIluQjot3+s63DSE8nSQhu39IQCuOJtAj1
         p8c+0XiskeKdyHAjRJZwxBGGSyEbfTdLPRWHC+yojNKb67+zuLEfFXTelThSAKBRpCHr
         dfCrWUw+vbFLFIUGwEl1u3VBvlmvI/VwEx6jwvLAdjxiTEVAGymDEXFFTW6nBhc6z3dq
         yX995Ndn5iOqiwqHop/d/+Yo0Cpb1nMzovM3VfjBMD2LjmAVmiSPc7I19fL3lmJzyWly
         Ha65QIeNyyx9nsKhwKAGXHAwnw2pUNmXLKCRQ+wDfLYH4k0bShM0KYJIe6Wqp3ZPMzwW
         y02w==
X-Gm-Message-State: AA+aEWa2XQxS0mOEignIzY1h7UtPgS9O8hwCaj5aZHBEZ8XCIYMMvPfj
        1myrWmcsPUw8WmfXiQNS1PD823hGEMPeubPAu0BeCw==
X-Google-Smtp-Source: AFSGD/VA2PVcxzLiNCfuUYYLwYopSKAClxj3q2OqH/w+mHXAS9YX7CM9AybWM/7E90LJAciOlA96FlTEaqDKixrUc6Y=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr17281927iof.183.1545231970337;
 Wed, 19 Dec 2018 07:06:10 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
 <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com> <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
 <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com> <CAKfTPtAprHq4YYdJ1gnuoAcNiVFpFPnxYv_=RS6pXs8aYpjcuA@mail.gmail.com>
 <8ea1a96c-c2e0-cc3f-1cec-444706383e77@arm.com>
In-Reply-To: <8ea1a96c-c2e0-cc3f-1cec-444706383e77@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 16:05:59 +0100
Message-ID: <CAKfTPtCVqSYOC_GUdBm8_5KNMNEwXdf77mXL4SDB4_G5_iE0iA@mail.gmail.com>
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

On Wed, 19 Dec 2018 at 15:59, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
>
> On 19/12/2018 13:39, Vincent Guittot wrote:
> [...]
> >> I used that setup out of convenience for myself, but AFAICT that use-case
> >> just stresses that issue.
> >
> > After looking at you UC in details, your problem comes from the wl=1
> > for cpu0 whereas there is no running task.
> > But wl!=0 without running task should not be possible since fdf5f3
> > ("wsched/fair: Disable LB_BIAS by default")
> >
> > This explain the 1023 instead of 1022
> >
> >
>
> True, I had a look at the trace and there doesn't seem to be any running
> task on that CPU. That's a separate matter however - the rounding issues
> can happen regardless of the wl values.

But it means that the rounding fix +1 works and your problems comes
from something else
