Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D337BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A56920873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRSgI53a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A56920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeK0UOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:14:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38000 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeK0UOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:14:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so21420255wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3x428OLtnA404GOOHS4/xsYooaXLBHBw70xe8PUCobg=;
        b=XRSgI53aNg0bW2CSxMvZ22Zx9uY3Viax7YgbqKvwmsuPJEmyrUh7eDb6syy+4lWdob
         V80zrgcMUM8UMY4DBxMn9jKxUjsubH4D9HSL9m4U8TSpkxjkNkgBuQFZLD0b29D5BQBH
         Mta3Kd45iE34TKo2kF+HBVaIpGK8JdXaSAFGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3x428OLtnA404GOOHS4/xsYooaXLBHBw70xe8PUCobg=;
        b=CE+UFgeKoGqJVi7qCQ6+tBMQngoNLbdV/sCnbB1qkfJf7x2pekVZOZmqEDFcjCEaoH
         UWsNuXcUOK3wiqXRTI/ZHgmN9RT59VPjcYBm57me2kt88RPng9YxGqx3MdagyopTlFkX
         bpuzZJ3K0yFFy+3a45UnUyYLtczf+I4nEHGc+W9lxKFNjr9L+HCy4tDOGsOodPpLfaxb
         yWTyZSaOKGEAekJLZQO1i8DKFDyVahSOLNh/yxf5aP49pDEC78qgjsZMuSYiGEcNbz3T
         47kzsA+8J6XCm59PgVUMA0gOOfbYuzkcnPPdZ2gXXVItCPuHmZ//1PNk3g5NesZae9bu
         7X8A==
X-Gm-Message-State: AGRZ1gICxVqXrjfaL+ipESc1Hnhz/NIzKiz9UpNMN/pvyUea61GN87Qp
        wol/R0YUyKzmly3eLY16i0z3HXHHs/M=
X-Google-Smtp-Source: AFSGD/V9IfcpRa12S59HeG841K80osRmHAjWnMlimVuccGIJzSjkBiBQzW4qCwavN1uSrBL0VqeHKA==
X-Received: by 2002:a1c:a6cd:: with SMTP id p196mr26905440wme.142.1543310224461;
        Tue, 27 Nov 2018 01:17:04 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f15sm4239375wrt.10.2018.11.27.01.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:17:03 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: qcom: sdm845: Add board specific
 dapm widgets
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
References: <20181124110948.209019-1-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f6d2c5d7-ac18-d95a-4814-14365a0a63e7@linaro.org>
Date:   Tue, 27 Nov 2018 09:17:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181124110948.209019-1-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Add board specific dapm widgets so these widgets can be used
> in the route.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/sdm845.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 58593db2ab151..95d8d4422dae0 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -212,6 +212,14 @@ static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>   	return 0;
>   }
>   
> +static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +	SND_SOC_DAPM_SPK("Left Spk", NULL),
> +	SND_SOC_DAPM_SPK("Right Spk", NULL),
> +	SND_SOC_DAPM_MIC("Int Mic", NULL),
> +};
> +
>   static void sdm845_add_be_ops(struct snd_soc_card *card)
>   {
>   	struct snd_soc_dai_link *link;
> @@ -243,6 +251,8 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
>   		goto data_alloc_fail;
>   	}
>   
> +	card->dapm_widgets = sdm845_snd_widgets;
> +	card->num_dapm_widgets = ARRAY_SIZE(sdm845_snd_widgets);
>   	card->dev = dev;
>   	dev_set_drvdata(dev, card);
>   	ret = qcom_snd_parse_of(card);
> 
