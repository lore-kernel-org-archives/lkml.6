Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F83421773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZ68djD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBKLXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:23:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40457 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfBKLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:23:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so16667642wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 03:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1j8bbri+HycsAw075of8V538dATVxD2rYwR0snuO0hQ=;
        b=HZ68djD0khJp7NqjFVusFF7uYDgrF1G9z0vyIMxB/DAx4aDZ2JjkywosAfGts5cceW
         +SVb4+RH58RAoiVt8rznPdRKGDVtoUlWnXgU7mK628VyABLx4bmpQl9yWo4Zd+2bgWgr
         5zDVR7pSFA7Gk/wJEJzgdagoEmzR5efLefBq/1fCKd/W6RyCYDHXLO98RH4zQemg2uI/
         oktf8nhGnl61Gq8EIvYlucYmbQH2EpDZmuFXbR6Wr9DSWyQ/sLIMdPwDZq68lZJAitGS
         tTk47U2e7eihwe8BJzH65uOvOi7YfDdxcQcJuxeXwELHQOsv9ffscw7nssEEpJJUr1Os
         gHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1j8bbri+HycsAw075of8V538dATVxD2rYwR0snuO0hQ=;
        b=AbkgHwYInUly5yRi91rf0hIVryMX4JNlqhyzIPJtooO8pzLvOBu6wICeDartku2hyA
         PPSa92ELR1I9FUZnnzJRjReXN031MtudXVK5D2K34ZBMtIm+IRkalHWkc7ktSqcWTl6R
         fVqDgA3nZv05wP8IZE0LxxV461qgoeljKp2ozcrKI0agcubzFc/bGzEQymwZ6oumO3/s
         jfoJVHTzxZlLqd8soAiZU9utGyhgEW/Zuw+Gj2inv0jyGzkIzqADPT0aao6UwhxfSNpk
         qJnEuuZ7Mot42B2+HUE/XzJFx4oRoZWT+N5d/jO0J0fto0kWGwPKvQenirETVI+Jre35
         6D2A==
X-Gm-Message-State: AHQUAuZl9FQKFi9jXGiMvu21JtvjAN18ldPzUxAxRL6FhcA8oVQb+sAm
        3Sy+x3EGr2puq0XDBhheLC8iAQ==
X-Google-Smtp-Source: AHgI3IbRwgJ0aPz+iUuzS5rkHVHBVKHu2InhZwU9uVT2jruPLroczSXeTIObS5eZpH9nbPtUUPPRWQ==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr17846964wru.21.1549884202298;
        Mon, 11 Feb 2019 03:23:22 -0800 (PST)
Received: from [192.168.0.41] (13.50.92.92.rev.sfr.net. [92.92.50.13])
        by smtp.googlemail.com with ESMTPSA id o18sm14814644wrg.40.2019.02.11.03.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 03:23:21 -0800 (PST)
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear
 timer interrupt when shutting down
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        linux-samsung-soc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <CGME20190210225147epcas3p4cedebfc5692274bc6135ceabbcf2642d@epcas3p4.samsung.com>
 <20190210225114.20110-1-stuart.menefy@mathembedded.com>
 <e22c175a-d88a-81a7-9faa-42bb4fe09a22@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e3637f0f-1e72-db3a-f744-ade0e878cfc5@linaro.org>
Date:   Mon, 11 Feb 2019 12:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e22c175a-d88a-81a7-9faa-42bb4fe09a22@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2019 08:14, Marek Szyprowski wrote:
> Hi Stuart
> 
> On 2019-02-10 23:51, Stuart Menefy wrote:
>> When debugging suspend problems on Exynos 5260, I had a large number
>> of debugging prints going to the serial port after interrupts
>> had been disabled but before the timer interrupt was shutdown. This
>> was long enough for a timer tick to occur, but as interrupts were
>> disabled the ISR didn't run, and so the interrupt wasn't cleared.
>> Later when the timer was shutdown the interrupt was left asserted and
>> so the wfi at the heart of the suspend code didn't wait, causing
>> the suspend to fail.
>>
>> Currently the code which stops the timer when it is on one-shot mode
>> and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
>> called this from the shutdown code exynos4_mct_tick_stop() could be
>> called twice. So first restructure the existing code, so the check for
>> one-shot mode and stopping the timer is moved to the ISR, leaving
>> exynos4_mct_tick_clear() just clearing the interrupt flag.
>>
>> Once this has been done simply call exynos4_mct_tick_clear() from
>> set_state_shutdown().
> 
> This also fixes mysterious suspend failures on Odroid XU3/XU4/HC1 :)
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied. Shall I add the stable@ tag?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

