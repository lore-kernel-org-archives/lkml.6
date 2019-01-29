Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFE52175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsJBauhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfA2RwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:52:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33084 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfA2RwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:52:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so9687784plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/tBJEqMWNjDrJbK7vLSjt12W3B5Rc+tYahKPemMtANI=;
        b=QsJBauhg4eUekdMhtLnxRl62aPdx2TMYBB8tV2MxqlsN3jtBnddYi44PvvrYG38ur1
         RtH4FdFx6B6W18ousVB8IzVANCNwqqhF51FVOxaUOU0upOTLjSkzKWdGbl0fuF8tDv1I
         Mp285vTUpHfN1pBJTiJEvKS+FH54zQB4oPYxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tBJEqMWNjDrJbK7vLSjt12W3B5Rc+tYahKPemMtANI=;
        b=IithJdI/78Hlv+qsbL7zqwruwDU14ngZ19ZMWsxdYV8Fj4LQevgb4w1UUuGavTWO2k
         vXiSl/FwBjb5UR8//j9QAF+q4FfKVmv3MRg6jZujLGmmvEi3Kd6efasAmoOhsTFnZEGc
         NGMrOmuj8Uf3GuU9HOUAzasLo7cNj42BjAeSpm/rw6nPCBckZ8sDxoy5soZX9L81tsK6
         pt0JoRYZblpn0lxDsAbMvse+pcNWwzcxJGUWnaEv8CT04Pvmn+v3AquRDpn9S4Fl5c5y
         hk3HuHnxDBExzuNV7Lh60Z/4F8M5ylh7f1Kg7KMAHe9OvVeBBoYHMBxGC+xySvq7GFUr
         sUyw==
X-Gm-Message-State: AJcUuke15LcvwyVakXFyBIDnhL55YamP4qvS/Mv2ok8qDJJamM2lomiH
        SF47bQ+X/Pw8stj0a9xsrDlQT5cBB5c=
X-Google-Smtp-Source: ALg8bN7j5UhBKQlvkZLZOXYipaHjr9dC+/pB5TbPyABoNkl4cpYONYQGcG5JZEXuE9HffEFUGEM/rQ==
X-Received: by 2002:a17:902:50e:: with SMTP id 14mr26655081plf.141.1548784337163;
        Tue, 29 Jan 2019 09:52:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j6sm64534816pfg.126.2019.01.29.09.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 09:52:16 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:52:15 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190129175215.GK81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
 <20190128190251.GH81583@google.com>
 <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, Jan 29, 2019 at 09:03:34AM +0000, Quentin Perret wrote:
> Hi Matthias,
> 
> On Monday 28 Jan 2019 at 11:02:51 (-0800), Matthias Kaehlcke wrote:
> > > +/**
> > > + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> > > + * @mW:		pointer to the power estimate in milli-watts
> > > + * @KHz:	pointer to the OPP's frequency, in kilo-hertz
> > 
> > nit: should be kHz
> 
> Right, I can change that :-)
> 
> > 
> > > + * @cpu:	CPU for which power needs to be estimated
> > > + *
> > > + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> > > + * and updates @KHz and @mW accordingly.
> > > + *
> > > + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> > > + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> > > + * respectively the voltage and frequency of the OPP.
> > > + *
> > > + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> > > + * calculation failed because of missing parameters, 0 otherwise.
> > > + */
> > > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > 
> > I think it is more common to put the input parameters first, then the
> > output ones, i.e. cpu, kHz, mW.
> 
> Hmm, the issue is this must match the expectations of the EM framework:
> 
> https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L62
> 
> So, I don't really have a choice. Or we can change the core code if this
> _really_ is a problem -- we don't have users yet so now is the best time
> to do so I guess ...

I see.

I think it would be preferable to follow the common scheme, but it's
also not a major issue, up to you whether you want to change the
definition of the callback. It's certainly true that now would be the
best time for a change.

Cheers

Matthias
