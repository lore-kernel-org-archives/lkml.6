Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A74C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86632698E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClmTnHqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86632698E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeFZLCP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:02:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36906 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeFZLCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:02:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6-v6so16784508wrp.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mnKU79p+g1H4nlZIBzFX3L6LHY56QcsiV3DtkwsCZdg=;
        b=ClmTnHqCZMwgre+i7ricmiPjsK0y13Vn8LHGmLgSWszLA1NPcp8Dp5FUXdqII62hLQ
         OJq4NCPWIKWM+3V/SQscXVvEFu0K/wpeHG5Ybb3JWEhuL4Oxi0fWZRTUOO4VCiHNl5qp
         7MCVBvQq04ReQS+YeJOgUlN5oZtBiXuJZyhe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnKU79p+g1H4nlZIBzFX3L6LHY56QcsiV3DtkwsCZdg=;
        b=Jb6NdKI7Bdqa6RS9VMLWlY6XxGB+w7d225xjKrYM7C7M4iZnbIA5fuFg53O6Ht9vwg
         Y1ZWww5252XMW5e1kZyQi0nVgQQXtufQ6hAJHOEnl+Gp/Cm+O+gz5TTIdVP6At09zDxh
         xSeeJ/3NrgvKtpPitINGqQLJMTAJWlvmjaPYAyV2ICVHVeV8oyEnhyPu0BN8Db/1Doxb
         zn5MVOjp602WgVzHC/5LyIbfLzjaMHgtEcKneuFhh+HTxG/m9Wyvd2NNRofSD+ASkNIN
         kdudCDkcGtdzs3OUkh9Ktwf9WQkPDTr3vhyTJH00Qr61PeL6/VDOHeJoBk8pE8MmEf9a
         0eyA==
X-Gm-Message-State: APt69E3LuZN/zwvqryD49ITZev7De+a+SYce7NC1WMT5nXiXVT5eiqeO
        DnpJB9btFgBCLQ0JSzwRpRqGiQ==
X-Google-Smtp-Source: AAOMgpf+6MDKEpcnl1sgvQkupfcPdGxbtEWGwCIskF6tM35Frze6MKyf2qeoRCKaYXkXmJN5s6dpMg==
X-Received: by 2002:adf:c377:: with SMTP id e52-v6mr1015018wrg.257.1530010932788;
        Tue, 26 Jun 2018 04:02:12 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452? ([2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452])
        by smtp.googlemail.com with ESMTPSA id h11-v6sm1588586wrs.85.2018.06.26.04.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 04:02:12 -0700 (PDT)
Subject: Re: [PATCH V10] powercap/drivers/idle_inject: Add an idle injection
 framework
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
Message-ID: <7d9403db-e26e-619e-c0d4-e601b6d51a78@linaro.org>
Date:   Tue, 26 Jun 2018 13:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530010416-30692-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2018 12:53, Daniel Lezcano wrote:
> Initially, the cpu_cooling device for ARM was changed by adding a new
> policy inserting idle cycles. The intel_powerclamp driver does a
> similar action.
> 
> Instead of implementing idle injections privately in the cpu_cooling
> device, move the idle injection code in a dedicated framework and give
> the opportunity to other frameworks to make use of it.
> 
> The framework relies on the smpboot kthreads which handles via its
> main loop the common code for hotplugging and [un]parking.
> 
> This code was previously tested with the cpu cooling device and went
> through several iterations. It results now in split code and API
> exported in the header file. It was tested with the cpu cooling device
> with success.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Javi Merino <javi.merino@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
> 
> V10:
>    - Remove set_freezable (Rafael J. Wysocki)
>    - Reduce the prefixed names 'injection' by 'inject" (Rafael J. Wysocki)
>    - Rename 'idle_injection_wakeup_fn()' to 'idle_inject_timer_fn()' (Rafael J. Wysocki)
>    - Shorten label 'out_rollback_per_cpu' to 'out_rollback' (Rafael J. Wysocki)


According to these changes I updated :

https://git.linaro.org/people/daniel.lezcano/linux.git
thermal/idle-inject-v4

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

