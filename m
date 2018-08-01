Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50225C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90CA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M33igTtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90CA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbeHAOM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:12:29 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55171 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbeHAOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:12:28 -0400
Received: by mail-wm0-f42.google.com with SMTP id c14-v6so6761789wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/3pLi0WmkIWVv0EXLHXsNzSDMM34bGwXHFb7l9lC2+A=;
        b=M33igTtm8qrEm7NJEBfW6TrPEZLi+byQM6ozTEt0/bGXjZJNZhTDhF4BQQI1YobpxG
         irzLoU7MlwbHDQrIv32suwmM1I0eQV2pA9vgvPH88OJcaJ5kJEHG7c5KUuGmQtpeabQW
         pCO8uYU3+tdHnA1jIgX2k+EI+ydu+Cxh0kNC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/3pLi0WmkIWVv0EXLHXsNzSDMM34bGwXHFb7l9lC2+A=;
        b=Wf1GdEGly3UfuBaLTdl5/CnPuWxuW+6yAm0iRug4M0l8SEh5Rm5ksTQI0dXpb89dcu
         SNUrJ/p5ImfLYS/pkskxHfA8dEXLIoZn2OFqcfiWUhaRvOXjzy59Iy0WysRLhUY04+PT
         K7ccIuwJe6GP0O6DHyzevWOjEB6/LU4zL4OJK36Qjo53MD19cE0lrafSOxEScoKsX5Hl
         fkd544Wdc5kjI58oRH7aBnW3U1nNWEMnqZiO0zFk5AYf7XeM8ys4Hc1jxDYn2v6bdR4p
         y7yUGFrG1Rv9VkLh6D2ii9oQr5xsLGZIAw/mZYeU10R7D4QeNjj7UjLC4Q1WFbL7y7M/
         RG4Q==
X-Gm-Message-State: AOUpUlEG8hCsYOFo9wzuywl3K6IMhO/Brx1woAfFsDVDTJ2SdZisoMrk
        koxqYmW3WXd9oTyYWXgMR5XtDg==
X-Google-Smtp-Source: AAOMgpfSx+l7VGiWPP48HDAQZg0p/2urud4T+BhnZ90MOWITY4Cm8/oBq7ChhC2oKoirqAAN0+5lgw==
X-Received: by 2002:a1c:3543:: with SMTP id c64-v6mr2462207wma.62.1533126414228;
        Wed, 01 Aug 2018 05:26:54 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 31-v6sm20278904wra.26.2018.08.01.05.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 05:26:53 -0700 (PDT)
Subject: Re: Applied "ASoC: wcd9335: add CLASS-H Controller support" to the
 asoc tree
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
Date:   Wed, 1 Aug 2018 13:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 01/08/18 12:20, Mark Brown wrote:
>   snd-soc-wm0010-objs := wm0010.o
> diff --git a/sound/soc/codecs/wcd-clsh.c b/sound/soc/codecs/wcd-clsh.c
> new file mode 100644
> index 000000000000..2393456cbd97
> --- /dev/null
> +++ b/sound/soc/codecs/wcd-clsh.c
> @@ -0,0 +1,605 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2017-2018, Linaro Limited
> +
> +#include <linux/slab.h>
> +#include <sound/soc.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/wcd9335/wcd9335.h>
> +#include <linux/mfd/wcd9335/registers.h>
Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" 
It would break the build.


--srini
