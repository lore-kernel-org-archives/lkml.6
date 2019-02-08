Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A74C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13444218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaaA1Lja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfBHJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:23:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32861 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHJXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:23:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so1419901pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9eATM0xQHVtyoK6VtgvpBCkEoNd+6Q3MQT4JkOQJCL0=;
        b=RaaA1LjawXgIGuxgkZnNg5mh/UzDMlSfl0RAjV5X17i6aUQXPWoVYhZWXZveNeUztJ
         JdDaRubdPRXWOysnuf3YlH7vTT/eCvPfI23p1m27fnyIizdv4GsVOqaxoMFodAwpcOmQ
         0bZ5TtGSmCFYoD1/m5i75JZYShCYEA7dOxif2UQObOZQlj26KkXIuLzqU3moCTmUxNGN
         Ywc951XBosfVA+w9okMO+vjkNt9Wkpc7P7MfzS8awnz6jLjWCpZWqTu3TmXTesrFlcgy
         oZZjez8Rgv1HmBmIYlJG7hVH0XiXUtemC8d1hAq2jZwEfNspP5daXV1XOICiy47oqxAE
         StHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9eATM0xQHVtyoK6VtgvpBCkEoNd+6Q3MQT4JkOQJCL0=;
        b=AqxkkKfJ0ZSPCglKyLFHqT+4NkRe7Nm+MX3BsZL7r++g5fW9KkCTE2n8T17x6R395g
         O4AX+qJ/6CAgjQqiayYydw0nrDaLDNimAw+cVo2eA+kThUQzNkS2SRXQ11GYThsjil//
         bzS3JcS2uiV+OB04AjaDm0L1qOwH0XmAPyxonOKO2Gy4eZxPwA9LT/WJKoEkgvffIm/D
         qM79ZZK8f95WuzKQvVwHAUBUU/hEWtlW4JUHWhSXNQGACJWIjfdNfbDSlH5Ma5YMbkkv
         RO78KNu4g17lst2hJUEfTqzqSNOm3jgKU8emuZwtpv+BetEWb5VWwtTaELa6GeW1THAU
         WZSQ==
X-Gm-Message-State: AHQUAuYfZ10834PyEfVk4G7OQ44YOFAucFYF28VZWWbc2AxPafG0Tqnb
        626qLzJ9ixgrHkS4GF9AlMul1A==
X-Google-Smtp-Source: AHgI3IbCWTFqhdOeoEj1B+MxSHlcBvp08qwvFYLm18/ZnQAWuD/xRiwuwekeTQAHoElAnCMDaOKCbQ==
X-Received: by 2002:a62:9419:: with SMTP id m25mr21934429pfe.147.1549617830961;
        Fri, 08 Feb 2019 01:23:50 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id w6sm1858882pga.72.2019.02.08.01.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:23:50 -0800 (PST)
Date:   Fri, 8 Feb 2019 14:53:48 +0530
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
Message-ID: <20190208092348.uqkfgxwx2pe3lmpd@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com>
 <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
 <bbab0116-c2e5-a3a6-30e4-cbd8c583a120@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbab0116-c2e5-a3a6-30e4-cbd8c583a120@samsung.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 10:15, Marek Szyprowski wrote:
> On 2019-02-08 09:55, Viresh Kumar wrote:
> > On 08-02-19, 09:12, Marek Szyprowski wrote:
> >> On 2019-02-08 07:49, Viresh Kumar wrote:
> >>> Why don't you get similar problem during suspend? I think you can get
> >>> it when the CPUs are offlined as I2C would have gone by then. The
> >>> cpufreq or OPP core can try and run some regulator or genpd or clk
> >>> calls to disable resources, etc. Even if doesn't happen, it certainly
> >>> can.
> >> CPUfreq is suspended very early during system suspend and thus it does
> >> nothing when CPUs are being offlined.
> >>> Also at resume the cpufreq core may try to change the frequency right
> >>> from ->init() on certain cases, though not everytime and so the
> >>> problem can come despite of this series.
> >> cpufreq is still in suspended state (it is being 'resume' very late in
> >> the system resume procedure), so if driver doesn't explicitly change any
> >> opp in ->init(), then cpufreq core waits until everything is resumed. To
> >> sum up, this seems to be fine, beside the issue with regulator
> >> initialization I've addressed in this patchset.
> > Yeah, the governors are suspended very soon, but any frequency change
> > starting from cpufreq core can still happen. There are at least two
> > points in cpufreq_online() where we may end up changing the frequency,
> > but that is conditional and may not be getting hit.
> 
> Then probably cpufreq core suspend should handle this.

Handle what ? That code is part of cpufreq_online() and needs to be
there only.

> >>> We guarantee that the resources are available during probe but not
> >>> during resume, that's where the problem is.
> >> Yes, so I've changed cpufreq-dt to the common approach, in which the
> >> driver keeps all needed resources for the whole lifetime of the device.
> > That's not what I was saying actually. I was saying that it should be
> > fine to do a I2C transfer during resume, else we will always have
> > problems and have to fix them with hacks like the one you proposed
> > where you acquire resources for all the possible CPUs. Maybe we can
> > fix it once and for all.
> 
> It is fine to do i2c transfers during cpufreq resume (see

By resume I meant system resume and the whole onlining process of
non-boot CPUs.

> drivers/base/power/main.c dpm_resume() function for exact call place).
> The problem is that such calls are not allowed in ->init(), which might
> be called very early from CPU hotplug path (CPUs are resumed in the
> first step of system resume procedure).

Right and that's where I think we can do something to fix it in a
proper way.

> What's wrong with my proposed fix? It is not that uncommon to gather all
> resources in probe() and keep them until remove() happens.

For cpufreq drivers, we must be doing most of the stuff in init/exit
only as far as possible. I am not saying your patch is bad, that is
the best we can do in such situations. But I don't like that we have
to get the resources for all CPUs, despite the fact that many of them
would be part of the same policy and hence share resources. The
problem was that we need to get sharing-cpus detail as well in probe
then, etc.

I was thinking about doing disable_nonboot_cpus() much earlier as the
userspace is already frozen by then.

@Rafael: Will that slowdown the suspend/resume process? Maybe not as
we are doing everything from a single CPU/thread anyways ?

-- 
viresh
