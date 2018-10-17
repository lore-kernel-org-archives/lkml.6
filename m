Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93428214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvyuX3BA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93428214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQQoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:44:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38618 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:44:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so28681424wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O4zJdEEV9BvS09KO5leN80wiUsksBIlyM/CWEY/hlwc=;
        b=SvyuX3BAWLNtqYkdXcdpVEFC001CJtXZRUpzSjFK3F3mXtUQbaqiBnZLm0C3zUPfBu
         MxcWK6dA/vdvEeqYDgFcSu1a1XCq0sJK/evzFUJRJlEyVvsbV1vrQSgg+xZopXPcgSlS
         U/PfI7Y55XtKx/WbaZS8M07H/fspWQpswAIWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O4zJdEEV9BvS09KO5leN80wiUsksBIlyM/CWEY/hlwc=;
        b=jgsiothuK53J7mNazKtytCRpd+YVPUO6vjsgrivBzRCBqTrKnRrSb9DhrTocF813A+
         N0cPIMcHoyerlOyDsu1/wULEPBEC0tWGksgyOTspHXBQK2LtpkFVIDGfAnPIeHbZ6cox
         48IdMvHmvA4IXnRP4SNWIm5vgMEFoA4hYeuU06L5sVIAASqLpZpXBlA2jZSZVOEhykyL
         2CtoExmmvvSGETNrTQdkcXf3HHNibkp0QGmTqNf/zbJADg12lfySjU5fdiUwPxFxe3Lx
         H5Ilc9xiEtcHcVFDOgQuFN05oqp6P2D8PzJxJUh7bI4WnlRxy89bjFyae7xGhWMyYSsi
         pipg==
X-Gm-Message-State: ABuFfoiHPXp6L/b3cmzndehNiX1rtW00J69+wuSuLRf2UHmTPXO5QFHw
        yfGCprVl5k5YEhyU3dgTJkWZ6w==
X-Google-Smtp-Source: ACcGV637r9fe6jTFdtS/13eg9ISUEz+rH46/DYp2KtXFavOyaQhDMu1NP0cI1ciMgUN38LwF8h2mDg==
X-Received: by 2002:a5d:698b:: with SMTP id g11-v6mr23950514wru.159.1539766182015;
        Wed, 17 Oct 2018 01:49:42 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id k1-v6sm15500259wrl.39.2018.10.17.01.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 01:49:41 -0700 (PDT)
Subject: Re: [PATCH v11 1/5] venus: firmware: add routine to reset ARM9
To:     Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
 <1539005572-803-2-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <fffd5b1f-73b5-81d5-a95b-a2dc9db1961d@linaro.org>
Date:   Wed, 17 Oct 2018 11:49:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539005572-803-2-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 10/08/2018 04:32 PM, Vikash Garodia wrote:
> Add routine to reset the ARM9 and brings it out of reset. Also
> abstract the Venus CPU state handling with a new function. This
> is in preparation to add PIL functionality in venus driver.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.h         |  2 ++
>  drivers/media/platform/qcom/venus/firmware.c     | 33 ++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h     | 11 ++++++++
>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++-------
>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 +++++
>  5 files changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 2f02365..385e309 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -98,6 +98,7 @@ struct venus_caps {
>   * @dev:		convenience struct device pointer
>   * @dev_dec:	convenience struct device pointer for decoder device
>   * @dev_enc:	convenience struct device pointer for encoder device
> + * @use_tz:	a flag that suggests presence of trustzone
>   * @lock:	a lock for this strucure
>   * @instances:	a list_head of all instances
>   * @insts_count:	num of instances
> @@ -129,6 +130,7 @@ struct venus_core {
>  	struct device *dev;
>  	struct device *dev_dec;
>  	struct device *dev_enc;
> +	bool use_tz;

could you make it unsigned? For more info please run checkpatch --strict.

I know that we have structure members of type bool already - that should
be fixed with follow-up patches, I guess.

-- 
regards,
Stan
