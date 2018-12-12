Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E6DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B39E20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544619919;
	bh=naeNbhdVztYKao70tkiJpUPH14R/V9BxMkKDVXIdU6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pjss/5fmIK7ZvINKP5kIaDARaJ9Yu2BgYQK/I1Zz7PaEXtYYMiCBbipM25xY3N/3r
	 gMM3KHcVChMkQPOEnWL1N7Kdg/Bfxat0toyDkRuDDFuYHQTf95E1sF5ffgmn4E1Fa7
	 /sLiDEY8qQosL+S60CT8cSM/e2FiyFCwG1vkcLyE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B39E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeLLNFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:05:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35445 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLLNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:05:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so14953338oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 05:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOz/EH5L/mvQAiQcjgyAnfBh30YyI4ZUQ5zwvSdHsgM=;
        b=oKoQ6eMOI3ROEwchdYhJvPok1oRLzTMfmgyeJlgJxJoqkQykczD7eLQUCLdwerbXSb
         sOosiEAYbp0eLR5QVbnHnKcetOmkxlo9jqAbggeeLimQuM3aTNH29V469x2nOOyQtrVH
         IoBr0iupNQuMINDZwLeyhYgVqOjG5kAoIzaOQc02WgjimFLrCN6ZQr9eoMt0wzlUKQlM
         wdHoO/o+DsFOrAEycGEr2IBqIONVxOU+mzwY8xH16AA/k1qJC0ujKWXkJqYKPRKLBGy1
         +WjfQec7yml/QYPpUg5tOZf/gqkF3CACWc+oNpXMA43FKGHrexKfK0BGU5D+UuyKxCDE
         rP6g==
X-Gm-Message-State: AA+aEWbWSS/E5V35aztOUZoXssBWeSB2hf3IGgtknLBTC1zM4fTR3DPD
        StNRJEvulSjAX+H/72d8a0pbtPmcOV66JFnfnJs=
X-Google-Smtp-Source: AFSGD/WY2OCMx7ERtNg7Go9r/JxPJA8jW5Px94YcubauzYsJsjp6xg3Ap6Cmn6Av7VHSkXQqPz/lBc0cMhX6iq0qqIs=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr332226oix.246.1544619916821;
 Wed, 12 Dec 2018 05:05:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hRgBShA_MkqTtvX+Y9QVYKKyLW5jtTzEsNpZYaRTcEFQ@mail.gmail.com>
 <1543832969-8440-1-git-send-email-daniel.lezcano@linaro.org> <20181203103329.qxoquo46yeznbvpe@vireshk-i7>
In-Reply-To: <20181203103329.qxoquo46yeznbvpe@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Dec 2018 14:05:05 +0100
Message-ID: <CAJZ5v0jejPOjj5CnbR-KKUebd6uHQuKnuHWOED32Kxwy-KHWcA@mail.gmail.com>
Subject: Re: [PATCH RESEND] sched/cpufreq: Add the SPDX tags
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 11:33 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-12-18, 11:29, Daniel Lezcano wrote:
> > The SPDX tags are not present in cpufreq.c and cpufreq_schedutil.c.
> >
> > Add them and remove the license descriptions
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  kernel/sched/cpufreq.c           | 5 +----
> >  kernel/sched/cpufreq_schedutil.c | 5 +----
> >  2 files changed, 2 insertions(+), 8 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
