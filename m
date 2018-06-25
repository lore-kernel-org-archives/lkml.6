Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3C7256E7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6R2v5T1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3C7256E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbeFYJoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:44:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40132 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754900AbeFYJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:44:15 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so1197891plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32YkUrj/SMuieMECwMviK/ZgojPxyfUEvTgxK/9SUPU=;
        b=D6R2v5T1/cclrGNeh/4etb7I1bNwZsdmCV6jo6GRP5Ye2xA8DGAiae8tc9CfFIsoqz
         a6SVNU2KLtqPyjfqmv5BDh9fTbFkAM5zvPLxnukTOlliQt5HEZiYZRHPbToYf4/XH2nz
         XK0NX6cdWNiL2LwP4uotRQfd8d/K31NneRDZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32YkUrj/SMuieMECwMviK/ZgojPxyfUEvTgxK/9SUPU=;
        b=SehtQ+Vk2w6KmY15dyia0aWh9F0Pt1wttRrlQTZjUTmIOFs00RUciQzxGZOoVOMUDh
         9Ln/uSFWnPODqFhPCimXeipEDJ+4mXxBLEagRVGv6Gc16g/GDoe6f5kmFKpYYSsFtTBA
         lB4x/Av9gwjErNHfC6Hc7uRVIeEoQI+IFRY+cp/S3NMQnWalyIIg1AfipG41OUXLsokJ
         Mg4Bmo4kx2xMJagvKRHUeo72ub6mhWATULEJigSj5zrDv8HxcCPKI/W677YV7e5rhVdn
         sx7nMmkb8k4r9an0wy6mFBTXh3OxY8wM6cq2yb8yeEcPpJKH/BQzkXQbHzc82gOiYtiZ
         6yPw==
X-Gm-Message-State: APt69E0Z0D5GpXGFUNZtm4QAza+f4kHR/6SxpuguWvUZoSNGWHOOJFXV
        1gvEYBZC5tB80iFs+FUzp+IkZQ==
X-Google-Smtp-Source: ADUXVKLyeuc2wJt4hbVA7k/fPotm2mIF8tRMtpT0GantSxnKBUWJ4xYYBm+uF9HrCbEAZ6UkzO5CLQ==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr11555841pld.72.1529919854411;
        Mon, 25 Jun 2018 02:44:14 -0700 (PDT)
Received: from localhost ([122.172.108.70])
        by smtp.gmail.com with ESMTPSA id b83-v6sm38398307pfe.159.2018.06.25.02.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:44:13 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:14:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180625094411.ubklcaxvd7hvuind@vireshk-i7>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-18, 10:23, Rafael J. Wysocki wrote:
> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
> > +void idle_injection_get_duration(struct idle_injection_device *ii_dev,
> > +                                unsigned int *run_duration_ms,
> > +                                unsigned int *idle_duration_ms)
> > +{
> > +       *run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> > +       *idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
> 
> Should you check the arguments against NULL before attempting to
> dereference them?  If not, then why not?

I would vote with a NO. This is a mandatory parameter and not filling it in with
a valid pointer is a BUG really. I don't see a reason why we should prevent the
kernel from crashing if such a mistake happens :)

-- 
viresh
