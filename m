Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB01FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8461923EB5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8tbPgBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8461923EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeGDM5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:57:30 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46956 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeGDM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:57:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id s11-v6so5239286wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+kdKDfwFEixqX3pvCTBkY17HmKIiwGcgmmNNAYN9kA8=;
        b=D8tbPgBDLu4uF4MrYca+UUzIBO3W7t301JSLl9J7Db1V4oquGG8MboamL4kD3QKgvX
         m8FYgSvSuv73BngSPmCeCj6qBJINyc6+G+NNPUiy9QZrr1m5XhFyg+y7LfQZyOJze//t
         Te+IluJGgYIwA+d9JLNkpNNw8noQWwI7pBHmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+kdKDfwFEixqX3pvCTBkY17HmKIiwGcgmmNNAYN9kA8=;
        b=iUrhdrqlTxUayM6Bp5CXP+kRaiI8OL2Byi9xuUQWfFr/HXZgrVuapZFQE8SlCnj2Mr
         xqW6oYsF4ht7SkypbaL827k6Ew9n/k6fztmMol4gs4K9m0b+mccFzoWPrriwHChqWNHh
         nCZzMu+jLTJCw0a1Cr+8JLBSnnKtmqUAoMvwt7nmraQx+KL4WhxfsNqqD/9ZPqLUcIWt
         8WxOZr59XiIyOwEzjn8C4sPD0NLuoiewoZdXVhjfOfGAl3EiEZTVhF0t3eyskD12w4OA
         sA/V1MHBHP3Y72CMVR6kyldMSsvZQvp+QcHRKEcVGMo4MFqh/3aDjKWNIDRCFIA1EcpN
         kQdA==
X-Gm-Message-State: APt69E3gkMCURsL5fWXwqQnhms4Ru96va/hfD00vWPiYP4VR0MMPo2LH
        7ubqeeEWIdRYquq1bq4G8nKLhA==
X-Google-Smtp-Source: AAOMgpcqHUBPj/aN+fYpGnxbozZwTXegj6y1gH2thyFRRRDjNgKyIY1TIztpou2v2TXIZuB/nevF6w==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr1680679wrb.155.1530709046980;
        Wed, 04 Jul 2018 05:57:26 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.188.193])
        by smtp.googlemail.com with ESMTPSA id h2-v6sm3402498wmd.0.2018.07.04.05.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 05:57:26 -0700 (PDT)
Subject: Re: [PATCH V10] powercap/drivers/idle_inject: Add an idle injection
 framework
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
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
References: <1530010416-30692-1-git-send-email-daniel.lezcano@linaro.org>
 <20180626110105.qqsrslavtfxuubcm@vireshk-i7>
 <2148928.GlOskIdrt7@aspire.rjw.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7797097c-79fd-2992-35a1-967bf6261e99@linaro.org>
Date:   Wed, 4 Jul 2018 14:57:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2148928.GlOskIdrt7@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 12:49, Rafael J. Wysocki wrote:
> On Tuesday, June 26, 2018 1:01:05 PM CEST Viresh Kumar wrote:
>> On 26-06-18, 12:53, Daniel Lezcano wrote:
>>> Initially, the cpu_cooling device for ARM was changed by adding a new
>>> policy inserting idle cycles. The intel_powerclamp driver does a
>>> similar action.
>>>
>>> Instead of implementing idle injections privately in the cpu_cooling
>>> device, move the idle injection code in a dedicated framework and give
>>> the opportunity to other frameworks to make use of it.
>>>
>>> The framework relies on the smpboot kthreads which handles via its
>>> main loop the common code for hotplugging and [un]parking.
>>>
>>> This code was previously tested with the cpu cooling device and went
>>> through several iterations. It results now in split code and API
>>> exported in the header file. It was tested with the cpu cooling device
>>> with success.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: Eduardo Valentin <edubezval@gmail.com>
>>> Cc: Javi Merino <javi.merino@kernel.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Cc: Rui Zhang <rui.zhang@intel.com>
>>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>>> ---
>>>
>>> V10:
>>>    - Remove set_freezable (Rafael J. Wysocki)
>>>    - Reduce the prefixed names 'injection' by 'inject" (Rafael J. Wysocki)
>>>    - Rename 'idle_injection_wakeup_fn()' to 'idle_inject_timer_fn()' (Rafael J. Wysocki)
>>>    - Shorten label 'out_rollback_per_cpu' to 'out_rollback' (Rafael J. Wysocki)
>>
>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I've applied the patch, but I've rewrittent all of the comments in it.
> 
> Daniel, please check the result in linux-next and let me know if you see any
> problems.

I went through the comments and I don't see any problems. Thanks for
taking care of making them more clear.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

