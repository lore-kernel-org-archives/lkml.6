Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B5920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bARE+9Ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfAOMlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:41:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51447 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfAOMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:40:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so3138994wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=afNGxF6t55JQ8GV1YRtapNLTOb5vgIZwpwdJqdBeE8I=;
        b=bARE+9Iji2By/usCz7xolHz9wZYOG7oQh69wsSIWry0S+zGsex8f7u8CI/u6YReW/0
         vYGdBqnHuHb/U4AjKUzaVY6GuHoLNQCi3UnlDzRUbY51sRSmHPpy04RcgiEajTWyf6A8
         iTmA7WEdo2rFeFmD9EYfGYTs+Tz3OERfsADnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afNGxF6t55JQ8GV1YRtapNLTOb5vgIZwpwdJqdBeE8I=;
        b=ADhMce0umWrB/UmayslHxDDi0s8UzqcD+5Y4Byxh1Gj76D2vjths9ODRhOJ//Z7XKm
         gICw2GOlIg17lDh4WIH/nzsw2FAhF8rp69H/YP1FNqi1UXdKLfRdRLFoJzH5TADl2eaZ
         9czSn9EonsoV9TvGxE91nEnzE/HxLEd42+qF29EIXiSgBieMdhHhMfHTxPKsWAp4jkH3
         PZK2NON2GV4hNTzfkWa4uc0n2soVbs1H8uAc+n/RwQfhbymuVsiqU0nh0Y/Nbx4lS1vT
         9jRzKax5tvu8CsmR1mlcnp9U4TJSKfzpUgO9rZYV0KaVEyOB+NPQYmODGWXMU0DfD+Kp
         kY4w==
X-Gm-Message-State: AJcUukeiZAM4uuLQ/6fOi6frZz26bKLmPr6KdL9agSKfK+ihjJWgtQ2O
        deuvA5B9hC8H33pLGdqV2JI+f2hR5Qs=
X-Google-Smtp-Source: ALg8bN57YDnRn8DBAXfhMu/EFCEEdjrTUCMk5RMrBYMNVb6pjCf9OLlATZrCuXQ1JHugJ10DPy/QXA==
X-Received: by 2002:a1c:2884:: with SMTP id o126mr3377888wmo.17.1547556054917;
        Tue, 15 Jan 2019 04:40:54 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j124sm21907964wmb.48.2019.01.15.04.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 04:40:54 -0800 (PST)
Subject: Re: [PATCH 3/8] nvmem: Add nvmem_cell_get_optional and
 devm_nvmem_cell_get_optional
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-kernel@vger.kernel.org
References: <20190106192820.12558-1-albeu@free.fr>
 <20190106192820.12558-4-albeu@free.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <de4aa31e-2d9e-a7bd-270e-f00ac3e88988@linaro.org>
Date:   Tue, 15 Jan 2019 12:40:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190106192820.12558-4-albeu@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/2019 19:28, Alban Bedel wrote:
> Add helper functions to make the driver code simpler when a cell is
> optional. Using these functions just return NULL when the cell doesn't
> exists or if nvmem is disabled.
> 
> Signed-off-by: Alban Bedel<albeu@free.fr>
> ---
>   drivers/nvmem/core.c           | 48 ++++++++++++++++++++++++++++++++++
>   include/linux/nvmem-consumer.h | 16 ++++++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index f8c43da6f2ca..8e1b52559467 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1083,6 +1083,30 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id)
>   }
>   EXPORT_SYMBOL_GPL(nvmem_cell_get);
>   
> +/**
> + * nvmem_cell_get_optional() - Get an optional nvmem cell of device from
> + * a given id.
> + *
> + * @dev: Device that requests the nvmem cell.
> + * @cell_id: nvmem cell name to get.
> + *
> + * Return: Will be NULL if no cell with the given name is defined,
> + * an ERR_PTR() on error or a valid pointer to a struct nvmem_cell.
> + * The nvmem_cell will be freed by the nvmem_cell_put().
> + */
> +struct nvmem_cell *nvmem_cell_get_optional(struct device *dev,
> +					   const char *cell_id)
> +{
> +	struct nvmem_cell *cell;
> +
> +	cell = nvmem_cell_get(dev, cell_id);
> +	if (IS_ERR(cell) && PTR_ERR(cell) == -ENOENT)
> +		return NULL;

What is the real use-case here, it does not make sense to me to add this 
additional call just to return NULL when cell is not found!


--srini
> +
> +	return cell;
> +}
