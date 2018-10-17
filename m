Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB1ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7B521523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMePvr2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7B521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeJQRF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:05:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33171 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJQRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:05:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so1008436wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hheE0NOG3a4zllLUy0TTz5bzx+mNd0TVdMiy3iy9VZ8=;
        b=TMePvr2hn/oh8j5XUVb/QZI+zTErhbEbnD1+pFEPkjYZuRvHcKdjrH2Sp7eiU1Wvuw
         gIutNiMOZUbDbFDzTMU0JeUwDImzT7Ior7WBw+jOifWnQLBhH9fKuyeuBf9QWCRp1795
         1AYokBi3czFX1VuSo8SAC2svie49SG0wa6jSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hheE0NOG3a4zllLUy0TTz5bzx+mNd0TVdMiy3iy9VZ8=;
        b=rIyJV3E5YPZecEDVf4/ArBgVSTNzptx2NUf5k3L3P7onxYU1bfO49gQHaT5hS5fUHw
         ytoflkc/8Pw6+R66ndLcEanDcrt/7DIf+2eVLJu+WD3nPuWHnVOaH6tRvn7IKCVyqziZ
         wgYdS9SwLUjgFbM5R0tGZhqAXgc7xW2T9VNon4bl+aWEX8+xVzPgJRupmOCHqtB/HppD
         ldeigX44YKzHkkWVyUpUiM40xqHUsnVe93nYAITgS4lmCXyE1Xny3JObYnu2z3fPJqQ9
         7I8KoRTc92HXC9519sr5UULtbTS6//Dl1rflrwpMlX3mQvGDDBjYxk0Wy1NAhvvzxEkT
         It4Q==
X-Gm-Message-State: ABuFfogv0Jj9U9+KRfe3CT7+vVU3H2zAHYPgn34vmwtU8R7uthPb3ko8
        jCMEI4Pjc4NR5pzdlVj+O/gp5A==
X-Google-Smtp-Source: ACcGV608UPCaiZ2FKOwJzcM4gZkRlyItd/dyeYDhoswi5/vgx50CVqF0Png+hSFW3CF8ReuVuC7yzw==
X-Received: by 2002:a1c:7f83:: with SMTP id a125-v6mr1968404wmd.23.1539767440881;
        Wed, 17 Oct 2018 02:10:40 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id w4-v6sm15809098wra.83.2018.10.17.02.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 02:10:39 -0700 (PDT)
Subject: Re: [PATCH v11 0/5] Venus updates - PIL
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <a31e499a-fa88-67b8-1853-8ea0d9297aa9@linaro.org>
Date:   Wed, 17 Oct 2018 12:10:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

Thanks for the patches and patience!

On 10/08/2018 04:32 PM, Vikash Garodia wrote:
> This version of the series
> * extends the description of firmware subnode in documentation.
> * renames the flag suggesting the presence of tz and update code
>   accordingly.
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

Tested-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

With the comment addressed in 1/5:

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
