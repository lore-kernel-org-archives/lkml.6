Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30994FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEEC20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyJcm98D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEEC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeINNrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:32 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:56023 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeINNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:32 -0400
Received: by mail-wm1-f49.google.com with SMTP id f21-v6so1106623wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f2B17xTVjsYnnRYhCe8+oFIUFMN8V3uGQgsi1k4TN6I=;
        b=AyJcm98DQFq3C0NKLRqr/9eVvtGoTIBJ/mJXOjYcrYDOaQ7saIAKTb5AwwWA5s2R/H
         ylPxI9vL1oeOfa+pES23bTOuJOcFC2LBf2MwsTQw/N8jRlhwvYdc9jleEvYyrS6iVNxr
         8/vHH9aL7aowl/cjBfeppvrksEnOImYHExyYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f2B17xTVjsYnnRYhCe8+oFIUFMN8V3uGQgsi1k4TN6I=;
        b=VxprSpc1pX7HSlsUgf3caogust0z2S4D047v6hv4S3FDpzOZWmR0nvmTxU3rPRVTM2
         RM8NjjqZTv0KpEAdNecdRHWYf5MbrX837yCTQWJeKRNGwJ2FLvg7Cj9k+HbVo+hCjGpw
         ZK/t9n89jjo5BMwpbLNHNRUYpGns+Nc1yHIN7EbIZAbYgCJoY7weEv7d/LzdAi+O4k0N
         0VTh++/xZVgzER03coiVXRF0ADs9r0lF3lGLVHyEl0MQ1PVkhS87SaXadGhDgwWPhD2Z
         UuNn1FrMNk1tyxwAMrkQycaWbOEHT8WsH+/4K592Rk8ShlJozUNsTCr7SMlsRscRoTyv
         rQ/g==
X-Gm-Message-State: APzg51A/F0ZHn/fVdiLoJLsH6CF2/uUSWRKtI5N6ZqnjmxqgEPjDRuwc
        zRhm3jQLwNK4MHWLwdyL5jHQeg==
X-Google-Smtp-Source: ANB0VdZz7ZA8keSh60hFDTH5jcVGr+I0Ec15gCihcA/XsPpeg/bFUvenAccaLgtw4JbItU19iUSJ4w==
X-Received: by 2002:a1c:580a:: with SMTP id m10-v6mr1302702wmb.131.1536914046302;
        Fri, 14 Sep 2018 01:34:06 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm6405401wrn.83.2018.09.14.01.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 01:34:05 -0700 (PDT)
Subject: Re: [PATCH -next] ASoC: qdsp6: q6asm-dai: remove duplicated include
 from q6asm-dai.c
To:     YueHaibing <yuehaibing@huawei.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1536888964-55681-1-git-send-email-yuehaibing@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b3aaddd8-0aa6-d1b3-75e7-a08930471e0c@linaro.org>
Date:   Fri, 14 Sep 2018 09:34:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1536888964-55681-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/09/18 02:36, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
		
> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index c75fab3..c3806d7 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -8,7 +8,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <sound/soc.h>
> -#include <sound/soc.h>
>   #include <sound/soc-dapm.h>
>   #include <sound/pcm.h>
>   #include <asm/dma.h>
> 
> 
> 
