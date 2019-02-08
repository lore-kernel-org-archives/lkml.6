Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EAFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B3421920
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jD7YDnew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfBHIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:55:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36700 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfBHIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:55:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so1393344plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+IoXi6/wX3eVgVDyb+GtYCpOFNqboyDM2qzEvakKqDc=;
        b=jD7YDnewE84yBR8+OjQj3WntieAgH0DSnhLlZEU33qoq5wgtu5J2kWSlVNO2Ae3B68
         8LELJPMbKb6kzi858SdWX2Wk2RLapCAl0hwKl5vd4TFt2D59Hob2s1PxomTvXkhBwPt7
         gWSXh05FvJTH/6ibNd51Hhqk2r0brPTFwDbdZNNZ/ll9O8/VRilSE15u7OtaS/AnQzH+
         oztz9vYIOwCvEs0zgnPpbEghhPmNZu2gFr7Q1L7Gunv8dNRlysbJmVc5dsBRi582cMMC
         OLjkemwOIqOnySOkhvi+uGdwGRDHEPXBPICq+Zgd0/QZ+FBj3OUdUwNVKLQcX1p6e0Jg
         miGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IoXi6/wX3eVgVDyb+GtYCpOFNqboyDM2qzEvakKqDc=;
        b=BKmQ7WNwfhGhVzouQVfE+5ClNsvL+Xk/FUFAH2HA6ekWlV0BXx44A1M96/Tf6UwoXc
         H+cMnsuMyLrqtvs7BtmCJViiV01Op+uPMTQcXZTWVN0w1V7dd/qlQfkKH8KOuy4/tnk6
         5yk3vuQLPaCfaohvw3cUKVxtZTkUqI65+Bsk0hp6RjWZ+Ps54ja1Vm52U+82wLhpOQRb
         Tz8LD3bNV/7qqsPAoK/NSQ/Y5IejsjlQhEJT4L8TGER9fLtvGd7iIaZuDILle/rqqMFf
         UvC2T/Ghuqaens7jBpDqjctKBpDzNnhoL8fhGK07F2aTs7Jsa1SNil9D2Y+4sKI4ekM4
         GS+A==
X-Gm-Message-State: AHQUAubzz00gDx4OTZAtfc4B++E9BXvH8JbCDpYTBH5ftn6Cg1DtGe0C
        W0EQJKowMdmSf6SKgvYpr3zEbw==
X-Google-Smtp-Source: AHgI3IZPJXr9IO2GZji/7ShvL6yppxJgb4HDPPsed1j7LXSnyGz2s8LmNnFkhjh0QWkpHvaAWrH9Eg==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr10966470pls.273.1549616147936;
        Fri, 08 Feb 2019 00:55:47 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id b68sm2368577pfg.160.2019.02.08.00.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 00:55:46 -0800 (PST)
Date:   Fri, 8 Feb 2019 14:25:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 09:12, Marek Szyprowski wrote:
> On 2019-02-08 07:49, Viresh Kumar wrote:
> > Why don't you get similar problem during suspend? I think you can get
> > it when the CPUs are offlined as I2C would have gone by then. The
> > cpufreq or OPP core can try and run some regulator or genpd or clk
> > calls to disable resources, etc. Even if doesn't happen, it certainly
> > can.
> 
> CPUfreq is suspended very early during system suspend and thus it does
> nothing when CPUs are being offlined.

> > Also at resume the cpufreq core may try to change the frequency right
> > from ->init() on certain cases, though not everytime and so the
> > problem can come despite of this series.
> 
> cpufreq is still in suspended state (it is being 'resume' very late in
> the system resume procedure), so if driver doesn't explicitly change any
> opp in ->init(), then cpufreq core waits until everything is resumed. To
> sum up, this seems to be fine, beside the issue with regulator
> initialization I've addressed in this patchset.

Yeah, the governors are suspended very soon, but any frequency change
starting from cpufreq core can still happen. There are at least two
points in cpufreq_online() where we may end up changing the frequency,
but that is conditional and may not be getting hit.

> > We guarantee that the resources are available during probe but not
> > during resume, that's where the problem is.
> 
> Yes, so I've changed cpufreq-dt to the common approach, in which the
> driver keeps all needed resources for the whole lifetime of the device.

That's not what I was saying actually. I was saying that it should be
fine to do a I2C transfer during resume, else we will always have
problems and have to fix them with hacks like the one you proposed
where you acquire resources for all the possible CPUs. Maybe we can
fix it once and for all.

-- 
viresh
