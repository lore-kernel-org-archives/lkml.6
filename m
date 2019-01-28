Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94777C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6113B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWey+YGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1Icv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:32:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41681 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfA1Ics (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:32:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so16944320wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IdLcjpt4fKK+CAzDfTMlv9oWr2wwLr24MdWR3nRxQgI=;
        b=PWey+YGJyy1UIymK0hXujgAD1HxuLplRsJxe/HtmwI56/h33XwFrDvCs53pbek4OEO
         B6rmeWY2ftST9iX6IijYPce4jjQnGFW8DS/Ow/ogg3vGcF3GUgEc9mdJW/RwClrB1/Hk
         5E7/l9DhBAEIXqk6SLPX7enbUCL2CJhrYGZH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdLcjpt4fKK+CAzDfTMlv9oWr2wwLr24MdWR3nRxQgI=;
        b=n0fi0fTJAB1uEBbGyfqFVXCGXhZkwUQXuRW5LQog9WX1L9tCflNP9pwGgj4h6VNpRz
         50RSC8ZehFaxHp9vyXbvy5HBLvZzzWXj7JTJAxKzINX66a7TJ4sOhfCwqqkEMcqA31xL
         hXogWKTjQvSurQGDWXIupL6fIHqh+mpvzbo/Lyno6ecjjP8T8a4OpKx9mhicS4bU0QPk
         kvaSx/chEWyQ5bEs96qj0UhQK+FdSilAMD/zGo1H9CksP23sT+us6JQznTCYD6K+ufhF
         eSOrw28GgVWzTBtYMXudHYgzMVrd/h9ZzdC43g8kmRbZOFOdrKPSP7FBd9lf084zRtcY
         BmqQ==
X-Gm-Message-State: AJcUukd9ARK/RfYwRxyfwVmKqw0zJmn3AoOwCOK/j2W93E4pvqgY75oT
        N1O3f5hxhhe3tAVls6czWP3XMg==
X-Google-Smtp-Source: ALg8bN6T46LeuvtwUWLLJoQXPo31vBkg13ZgKeLKJbASs3u1hVmDHyJe9BSBQCzr1paiVx7tWlj3qg==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr20126727wro.208.1548664366588;
        Mon, 28 Jan 2019 00:32:46 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id o2sm7412317wmo.33.2019.01.28.00.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:32:45 -0800 (PST)
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3afd5b04-5caf-053d-48c9-f719eec58da0@linaro.org>
Date:   Mon, 28 Jan 2019 09:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2019 07:41, Amit Kucheria wrote:
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
> ---

[ ... ]

> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device.
> + */
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
> +

Isn't the CPUFREQ_IS_COOLING_DEV more appropriate? We define a property
of the cpufreq driver and the resulting action is to auto-register, no?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

