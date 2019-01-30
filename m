Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612DBC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB9E2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pkgv7g/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfA3H2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:28:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56199 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfA3H2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:28:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so20310999wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eRvZZZ80Im6H5Kxc7wgfh4tQhcBXe/w36rsryBat30M=;
        b=Pkgv7g/tXR0AQ6SCHMcL8ENMUMF1iznkszxQojw+8axK8VrKWA9bwZoKlVByEH+0RT
         Azdee+es3m75iQ07HvQJJKKN41XL61O2njT9TEdyA2gw4tj7AjF+PFSmfCs5U78CNoPU
         6c+9Mj1N8AlGrwRA9IzFUusdbXV4ZZnBT+a48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eRvZZZ80Im6H5Kxc7wgfh4tQhcBXe/w36rsryBat30M=;
        b=GKZehM4c4exYdk8tsKhOWnjNgXkfL4Uiz/hA3Ek+iLWNnH1f2bv7j839LAHu8Mrn+5
         XGRWYZ1ryNATGPhznyMzkBmAdf/dfgM18oLGUWeX3db3q6A7OcfrsVxnye91Y2GzUoPz
         fDN26JREXWanZVoE7eIRgEAfzqR5917A0LqoZbq2gX4Zcy11Qsyn6S618N6VWXrrijgA
         b0IkNLquDeObkhhJLovwlQakfPr+Uns9zBln+ymLsYasE2kCjtg1q+8PasEnjcMZLYnu
         XQiKDkIV9YO/nI9284B0rL5uXqu22I7znKPI2kkAiko3fE1J/Z1XeXk09NuIQx5qsN4q
         aW8A==
X-Gm-Message-State: AJcUukcPALx8ZFpQt/8FRsjT8GEGiB73PtI2+Tcj9ho02PYqQDJWsBOt
        LC+LKbLgkuXt064GtJ7SXFBuwQ==
X-Google-Smtp-Source: ALg8bN7tC9pOAycbL6CoRERd4tK3235zTVflWqXeq6GjidRct/Fx4SWxSy8V+ucSrAzPLASF5DkmLw==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr25700851wmg.48.1548833313793;
        Tue, 29 Jan 2019 23:28:33 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id b7sm320424wrs.47.2019.01.29.23.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 23:28:33 -0800 (PST)
Subject: Re: [PATCH] cpufreq: Auto-register the driver as a thermal cooling
 device if asked
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
References: <CAJZ5v0iwq15mwoa-LBN07fgNNurtBGodG6urgfnvMbGWj8vyAw@mail.gmail.com>
 <fdff26d908c5338df44574085701ed93a64af079.1548825443.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0b43f925-b1c8-56ed-c276-a2413bdcd75e@linaro.org>
Date:   Wed, 30 Jan 2019 08:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fdff26d908c5338df44574085701ed93a64af079.1548825443.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2019 06:22, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
> 
> In order to allow this, we add a struct thermal_cooling_device pointer
> to struct cpufreq_policy so that drivers don't need to store it in a
> private data structure.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

