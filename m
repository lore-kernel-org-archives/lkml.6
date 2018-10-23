Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F34EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B1620671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9lxC6FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B1620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeJWUjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:39:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53175 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:39:12 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so1617433itz.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQmzRTCkKasMuTUaJ65GS+2TFw9iSMz8vMwDuQQErL4=;
        b=W9lxC6FCigRj30vLcl035kspsJKrYnTLKwHFzc0U9c8Ho350qH0rqNG6OCknZ3eZY6
         1QNJQUFJ7hjRSD3Qt/UE2Zd3cJQoe6jlADypzXkxReFU+XdijjNStRw0ROzv06ceglOj
         o3iWA6BDD88B2ocVpaypdwgtHluOeP8mmxRyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQmzRTCkKasMuTUaJ65GS+2TFw9iSMz8vMwDuQQErL4=;
        b=bhWuzZu+hb08lvEV62Hh5ut1d+xY71SaOnktOvl24JJZz6zUCHYMKgZPc7ZpLpNmGb
         esjRex/EVd2sD0dtMHgKPnWV51/QHibdyZTNvXaruf10uU9FNsajcY9ldnDsr+SjaBtf
         yRIEopls+ZGfJkXHNip5INly2FS3MK0o9EMCAqYH2PDuem0JsJA4hgDNNpkwjbKDhCSp
         X67tn1pfIxl+UQ556PBXTXEu1K17snZyysilk0tKqCVUSnVq/NgOjj2zSrb6J4kBKTx1
         VQGjCLx414iYqkVj0RXiXESp8gfvCcaGJNG+gwAndr/0qHksphWkVvhX6g7iNPlsHFPo
         7WPg==
X-Gm-Message-State: ABuFfoglE/dLNjeMZjsO24Iu+AOSt6TrdwxTvD5inxvKyk1Gt0tKlyVs
        FhJWt5Cadi8c4hfWIxMT75Y6JoGLGxgYHwq81uKjcQ==
X-Google-Smtp-Source: ACcGV62Mm3xPkpNyh2MHXE3kdz2twRvTc5e3HtScLAzJwGpHOEGPCleZKuWFARtqR0eCrv4MqLtXFmlBZ343+4tGfNU=
X-Received: by 2002:a24:670a:: with SMTP id u10-v6mr12294512itc.114.1540296957137;
 Tue, 23 Oct 2018 05:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org> <20181023100057.GJ3109@worktop.c.hoisthospitality.com>
In-Reply-To: <20181023100057.GJ3109@worktop.c.hoisthospitality.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Oct 2018 14:15:46 +0200
Message-ID: <CAKfTPtAVODuDsvFsGpdnxQjGffOa=WKBEcnqo-vGkmaMs=UcAQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 19, 2018 at 06:17:51PM +0200, Vincent Guittot wrote:
> > In order to achieve this time scaling, a new clock_pelt is created per rq.
>
>
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 3990818..d987f50 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -848,6 +848,8 @@ struct rq {
> >       unsigned int            clock_update_flags;
> >       u64                     clock;
> >       u64                     clock_task;
> > +     u64                     clock_pelt;
> > +     unsigned long           lost_idle_time;
>
> Very clever that. Seems to work out nicely. We should maybe look at

Thanks

> ensuring all these clock fields are indeed on the same cacheline.

yes good point
