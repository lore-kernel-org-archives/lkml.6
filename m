Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DDC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4232085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpSNJvA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfAUPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:35:59 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44397 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbfAUPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:35:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id u11so12813561vsp.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+QB4YZGEJLcPSkGnAhuoFe4nirgoy69vDlYb4K4aCQ=;
        b=XpSNJvA31VORta233d9tgGET0O1mugOj/Wqy1IfVVwWc2D0CztIYeLjsxSlvWfANSy
         UBLpu5A23chNkqlRpdscDVrMU6W2k6GiFcgKfhxsk6ayX4o7ndog6bD9iaGRkKedvSvD
         rlkuBgbbXwPonhrkP/genyI4TflOVx55lhsY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+QB4YZGEJLcPSkGnAhuoFe4nirgoy69vDlYb4K4aCQ=;
        b=TEuj0a84srloORY6spqy+e1N2C4DB/qra5Q8kPqcaNIo9NEwuSB8kV15ziYk4pcfFn
         wQxHV7/OfL6F14amRHtCeivOU4GUj0JnBBl55Rj4PC+qSNgdjh+a1ILu6dH7K+C02sXW
         SAiy7nrlKGqzAzM5e68FMTsfWUmSSSA/gJgyJG4SCBNXfd3BOLIWgeYLL1aIrSU0+kCX
         7AWS6RGtEw3f/8v/NEa8YFlUzyVmtYsCc1w2lh6t7LBx83uQ4DXDElGdDCm7e9d4F3mu
         ZScbK+3+JQYHbvFIKXMZaxb6d8OsjZD8LWWEPvj/YpuMqLA5NLgh+HSHb76NyHsKmlid
         iVfg==
X-Gm-Message-State: AJcUukdpdwgepI2kaNDrHKKzPQ2ttCe+9RGUupmQAMxQu0KqchxYe9Ml
        fbgKeAUGX2Lt6zdBkiq7AsvK2nci9550u6ZLApCKfw==
X-Google-Smtp-Source: ALg8bN5OQXsJT5dEgvw62DKG1u22ChYvckx2arIxE/Ebl6FPE0U6WW29ZixVYyhbdYdMSOMFXP1AVmAkpT8CV8MOEyY=
X-Received: by 2002:a67:e0d4:: with SMTP id m20mr12739834vsl.182.1548084956390;
 Mon, 21 Jan 2019 07:35:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <168294311714f269b1050bcbf5d3324eae0808f2.1547481320.git.amit.kucheria@linaro.org>
 <1718046.8NPD0iV1Wv@aspire.rjw.lan>
In-Reply-To: <1718046.8NPD0iV1Wv@aspire.rjw.lan>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 21:05:45 +0530
Message-ID: <CAHLCerOLXwdMmRci9wSr8+LjVf4m3CdLd85WWjd1Q3VriQy_MA@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Add thermal_cooling_device pointer to
 struct cpufreq_policy
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:27 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, January 14, 2019 5:34:53 PM CET Amit Kucheria wrote:
> > Several cpufreq drivers register themselves as thermal cooling devices.
> > Adding a pointer to struct cpufreq_policy removes the need for them to
> > store this pointer in a private data structure.
> >
> > We can then auto-register the cpufreq driver as a thermal cooling device
> > from cpufreq core code.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  include/linux/cpufreq.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index c86d6d8bdfed..7d0cf54125fa 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -95,6 +95,11 @@ struct cpufreq_policy {
> >       struct cpufreq_frequency_table  *freq_table;
> >       enum cpufreq_table_sorting freq_table_sorted;
> >
> > +#ifdef CONFIG_CPU_THERMAL
> > +     /* Pointer to the cooling device if used for thermal mitigation */
> > +     struct thermal_cooling_device *cooldev;
> > +#endif
> > +
>
> Why here and not at the end of the struct?

Fixed

> >       struct list_head        policy_list;
> >       struct kobject          kobj;
> >       struct completion       kobj_unregister;
> >
>
> Also, I would suggest combining this one with patch [02/10].

Will do.

Thanks for the review.
