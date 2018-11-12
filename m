Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3514BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F038B2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyACUyJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F038B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeKLQss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:48:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37130 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeKLQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:48:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so6990783wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJSVjBY7z7TVE9l5S0IYUWqit7PdZWXsGxgVWo7GwlU=;
        b=YyACUyJxuJfSfTQqO/+86APyf3UAhGxV6NLRSjos+5Z5lMfTaOSqJ0W4L/1jfy4gcw
         RLOAV36fA3Mk2+lWc7RlN/Up2EGkYD+h1WdAVs4+zwV7s7fnspESQx0bbeBiRjotdhPf
         +mn6oVkxAdCFJ9VmIfJ7hWObFahUBv6c3DB+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJSVjBY7z7TVE9l5S0IYUWqit7PdZWXsGxgVWo7GwlU=;
        b=mIgpGl/kAL2iSdrb4DgLK5X0NSwyKvA+TilETGx0zPN9hsIX6+hYCdcKQzJYyy43r2
         P/HEW7Yqj33GGH+0EITLjp+qRjVMe71DEr2X4tmfpOm8BLaU1TPjQyjX8a1tQKH7SFsB
         naQLa2lqamG6agwkN0pYQAjVDK5t51dW9Asp60P+XI0085XzfOxMqg7O1nEOrF+3VUt6
         uwRcSVwpi+K9yVBcUR65IM/8BNSPMEFAcHYA50++HHITJqmbhV/IB0dUHMp71h4s2Icx
         1iJF2L5S6iSluO8hZzAuzZFR21uAHlycfxOAiKJRE0J6qUrRxsyCsSBy9q2f/5xa4U+e
         Zwyg==
X-Gm-Message-State: AGRZ1gJJ6ogmq/RyF0llVwR9kzymexPqVraqawaX66rOEnQl382GOMnA
        5rSybHKbcUjwR9wMWQvE4pRLSw==
X-Google-Smtp-Source: AJdET5eRyMIGi4DeQjeh0rJH4QQx23KD2hKuuYI/2y+dgK6GM2IpWXKPKWC6EzFHk2XRCvpZIXKIwA==
X-Received: by 2002:a1c:1f43:: with SMTP id f64mr293378wmf.64.1542005812199;
        Sun, 11 Nov 2018 22:56:52 -0800 (PST)
Received: from [192.168.0.40] (233.25.136.77.rev.sfr.net. [77.136.25.233])
        by smtp.googlemail.com with ESMTPSA id m192-v6sm13009230wmb.29.2018.11.11.22.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 22:56:51 -0800 (PST)
Subject: Re: [PATCH 05/17] clocksource: bcm2835: Switch to SPDX identifier
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Arlott <simon@arlott.org>
References: <1541863719-7244-1-git-send-email-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dbc12f84-ebb1-998f-dd42-5ad936635744@linaro.org>
Date:   Mon, 12 Nov 2018 07:56:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541863719-7244-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 16:28, Stefan Wahren wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management. Also drop the FSF address.
> 
> Cc: Simon Arlott <simon@arlott.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

