Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDFC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A73A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orBz6Hqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A73A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeI2DCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:02:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39212 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeI2DCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:02:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so1388632pgv.6;
        Fri, 28 Sep 2018 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=inNTmMjCpeoFHy6n5HmPjZhpGTbPUzYd6nWl91PY/Lg=;
        b=orBz6Hqx6R1NRiUm4JZaNIvVZ590Vp3s0OwSM/PuxFAubJTyOsrrGLsKa4dlVq4EpC
         isp0sd3FepTQO9nZnK6bYZIRrp1TNsavYlgI6T8HgqkMJSdLQKTBsRlu0idqHjP1p5Zj
         N3xkZiYwV1l//eBDBgdYTvUYLwXTPTqk56g3yiJ5c5N/SbZwFeT+6eIJlkmKAQEnWnGV
         7CrOwfA+GcUF3bKF3pVpqFrhiQ9mFWIKiZfj5wY0KwyoMedAazlC8KfsApxZh27RMWZW
         YmVp7UmUxSqyOR8EuBTMNmNi107RPNt7BbMGEvIxiGX2zweLxgOvXneY9ogRyc8mqCGV
         TveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inNTmMjCpeoFHy6n5HmPjZhpGTbPUzYd6nWl91PY/Lg=;
        b=Z8x1ka6qSGKXx0zuIi0r/nSZTq5Z+CedLIMvplfOpfmXD9VPJi60yfMwcdJKLIMT6S
         WGO+Fp1LOQeDG2DFKGzfmjhRHZbpYkrs3TjXYUNbu9jnltPD0gkrqBRnA4/TYP13dWfk
         i2R4kCmsyQyO8pbOwiKuaGLvLt0hFqNHGi2DBY+a9MyepR0VKNw79M8ndgQU43jktE0W
         pCABvzwTn30YXgL+rYSPOUH16F5PZHMA6syV9i5cMa8xEF5jfzyfpPBiQeCaosyQZ7VB
         YAvtngLRPz0sNbguzUuWLyFP40dunXuDb9yiGYd3EGR7k8v56/jMRZjhZytWJROCsmEb
         IyGw==
X-Gm-Message-State: ABuFfohRTEmVS9u+gSFv7hVr0J2G0UaUmLmvnG7YXhTQMmBimJpQNdF8
        8S5nASA0kdL7HDEKt4XhWMiHq50d
X-Google-Smtp-Source: ACcGV61jFwojxE1tPmt6lnbrzEsuVqF8uHXcVUJWZsGAMsqs4+mUIShtQk0jd6pvvznAvt9ULzR6Ag==
X-Received: by 2002:a63:3747:: with SMTP id g7-v6mr242730pgn.59.1538167000929;
        Fri, 28 Sep 2018 13:36:40 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id y128-v6sm8742523pfb.56.2018.09.28.13.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:36:40 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
To:     Tony Lindgren <tony@atomide.com>
Cc:     Maciej Purski <m.purski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
 <20180928202251.GM5662@atomide.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <74a96485-268c-3e80-bde5-70e28896c48c@gmail.com>
Date:   Fri, 28 Sep 2018 23:36:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180928202251.GM5662@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/18 11:22 PM, Tony Lindgren wrote:
> * Dmitry Osipenko <digetx@gmail.com> [180928 20:13]:
>> Tony, could you please give a try to the patch below?
>>
>> Do the following:
>>
>> 1) git cherry-pick 696861761a58d8c93605b5663824929fb6540f16
>> 2) git cherry-pick 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a
>> 3) Apply this patch:
> 
> Seems to be getting closer, system boots up and starts
> init, but then I start getting tons of this on beagle-x15:
> 
> [   17.089059] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.096342] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.103275] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.118139] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.125078] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.132105] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.148187] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.155265] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.162355] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.171111] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.178156] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.185240] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.197636] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.204597] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.211621] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.227466] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.234428] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.241467] cpufreq: __target_index: Failed to change cpu frequency: -22

Thank you very much for testing and for the quick reply! That's an interesting result. I'll take a closer look at the patches and come back once there will be another patch to try.
