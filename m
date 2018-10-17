Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA427ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A29621523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihv/pnjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A29621523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJQPBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:01:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35332 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeJQPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:01:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so951766wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AAtjDTWl/2R2tabAbNeMKt+JNSXaro3X8mifByiqvso=;
        b=ihv/pnjfkMmuTOd7Z9u2EcNsUcS/4IcAwfpM9HPz6uFVx9h/bldoMLE9ScvwjoOp9e
         Kux0Y8JAbD8zgDnkS37W5eS5xIhE4N5dHfrJXFmZQzW83CZxbElfkKYDlJmNI3nKc9VK
         RxIQ6vKsCvIUlfUzWMnRSkQAomHMqTgmMUqwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AAtjDTWl/2R2tabAbNeMKt+JNSXaro3X8mifByiqvso=;
        b=pS0ZDIRibZo89Z1qMhSbkOIJwmBRUcrVbtgqxwq5kJ4oSUDvpI2fTOOh2YzCeLu9kO
         8H37TmhrBz8A3alnJyPV9A+/xHNes7sTlBVVjrdIJnBurOyyvT+9qTtsSKnZpDrkCBrP
         ziOFCKAcUXz/h2hkoRrIPLWDMOGPWGc0hCWxqCpuDScfGMjtQW3Pz6tDhwS0Kh+T78bu
         XZxJ0v4Otxy4RFfQdNpUbXT1wtTTUDDeAiBoJ6LLs+7Xlhg0jnInRWnsV4M65X1oebQD
         ak2g3GypuOVJbhS7RRuAYhEZa+A9W7oCANPLrsHHPrhvEcAUkw2CCzbE+CPNggcPcN9a
         z5IQ==
X-Gm-Message-State: ABuFfog7zv94Ui3b6AqXGcRHFjHUHYahWt2bWkFX/5nRA8C/mphxusgo
        g5n4Q4QwN+ve/wEeBK1S2HwgmQ==
X-Google-Smtp-Source: ACcGV62GZ6/lab6+piVRIeuLZM0uUfsunQdp5yDemqjb0s7KkViXyvJsbDjuj7IGMUptkD8dv+fnTQ==
X-Received: by 2002:a1c:a345:: with SMTP id m66-v6mr1548346wme.104.1539760042970;
        Wed, 17 Oct 2018 00:07:22 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id l11-v6sm23207466wrn.61.2018.10.17.00.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 00:07:21 -0700 (PDT)
Subject: Re: [PATCH v11 0/5] Venus updates - PIL
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
 <fb81c8b7946898bc61e9b8c793c74184@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <62411a58-f23a-6215-3b9e-cf3b6b08ffdc@linaro.org>
Date:   Wed, 17 Oct 2018 10:07:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fb81c8b7946898bc61e9b8c793c74184@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 10/16/2018 06:55 PM, Vikash Garodia wrote:
> <A Friendly reminder for review>

I have no review comments. I'll need some time to test this version on
v1 and v3.

> 
> On 2018-10-08 19:02, Vikash Garodia wrote:
>> This version of the series
>> * extends the description of firmware subnode in documentation.
>> * renames the flag suggesting the presence of tz and update code
>>   accordingly.
>>
>> Stanimir Varbanov (1):
>>   venus: firmware: register separate platform_device for firmware loader
>>
>> Vikash Garodia (4):
>>   venus: firmware: add routine to reset ARM9
>>   venus: firmware: move load firmware in a separate function
>>   venus: firmware: add no TZ boot and shutdown routine
>>   dt-bindings: media: Document bindings for venus firmware device
>>
>>  .../devicetree/bindings/media/qcom,venus.txt       |  14 +-
>>  drivers/media/platform/qcom/venus/core.c           |  24 ++-
>>  drivers/media/platform/qcom/venus/core.h           |   6 +
>>  drivers/media/platform/qcom/venus/firmware.c       | 235
>> +++++++++++++++++++--
>>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>>  7 files changed, 274 insertions(+), 43 deletions(-)

-- 
regards,
Stan
