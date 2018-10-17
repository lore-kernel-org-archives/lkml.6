Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA1BECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F96421527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4lQ/Cid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F96421527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeJQWGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:06:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40152 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJQWGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:06:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so2357040wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=256DI5Jjz6Hr7kJYrpIaNnaNUVkHxyLPILqbsIZhtZo=;
        b=e4lQ/Cidgok476ekW4Cp469aXenb5cWmUG7XwdHPVQ8mCnKjExlyz9F0ew3YGUJHiH
         v1cfciiGM3vnYcWMLcW1jSqwvl5tnAEHkkvueKbu7gQG1c/F+L5AhHmoIY7ygtvIIxPd
         1BQO2WZb5shJM5EEYGqJHcetGcXbCc+QHB5Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=256DI5Jjz6Hr7kJYrpIaNnaNUVkHxyLPILqbsIZhtZo=;
        b=Of95KSjpD7V5u7ZVWiI03rYabknR4rD6mvDB7WRqbahuWIdkEXWhPws7ZiTCGiihVL
         wSCUxGQBs5LzKGvD2zhjnCykloTtMjskz9h4tDrJXnWBNi2fkWfdkiE9Rdy6hIrZk0l3
         J7GTiCLlFg5ygal9IlrpDJi4ujeuI6citGAl2SAkIokGzvGKNDyRmai6yyGf0fvj4mal
         h/sbTHbukCiFWGa4TbPtIDogMm/nE2K8lHV/Sri8AIQ1NVw9OBoErk46SCYbmzfoV+7n
         GtVR1QP6ebUQwXqigRk2AJqZ84f1/XUPwo8huYXrqE+ZJNQyU29KLl0gWQGfQbTEcvbS
         sezw==
X-Gm-Message-State: ABuFfojknjGAaLoMXm8tKyHb+a9sTdlGUvPFuMhZgdn3ZhlPM0HK56sf
        TF6pfEyO0xTP9pvwtgfxrPXwDQ==
X-Google-Smtp-Source: ACcGV62W+0x17e0lx2oaE+6F2PucxdS4hv345tVP+kE47cW1BEU1MG7ncKcB8/mvL+eGBLWQjPW7VA==
X-Received: by 2002:a1c:1984:: with SMTP id 126-v6mr2973913wmz.7.1539785459197;
        Wed, 17 Oct 2018 07:10:59 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id y4-v6sm24155144wrd.25.2018.10.17.07.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:10:58 -0700 (PDT)
Subject: Re: [PATCH v12 0/5] Venus updates - PIL
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <5a6bf95a-da0f-2304-3f42-68aedd6f88c8@linaro.org>
Date:   Wed, 17 Oct 2018 17:10:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vikash, thanks for the patches!

On 10/17/2018 04:18 PM, Vikash Garodia wrote:
> This version of the series
> * updates the tz flag to unsigned
> 
> Stanimir Varbanov (1):
>   venus: firmware: register separate platform_device for firmware loader
> 
> Vikash Garodia (4):
>   venus: firmware: add routine to reset ARM9
>   venus: firmware: move load firmware in a separate function
>   venus: firmware: add no TZ boot and shutdown routine
>   dt-bindings: media: Document bindings for venus firmware device
> 
>  .../devicetree/bindings/media/qcom,venus.txt       |  14 +-
>  drivers/media/platform/qcom/venus/core.c           |  24 ++-
>  drivers/media/platform/qcom/venus/core.h           |   6 +
>  drivers/media/platform/qcom/venus/firmware.c       | 235 +++++++++++++++++++--
>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>  7 files changed, 274 insertions(+), 43 deletions(-)
> 

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
