Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E478BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90DC20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIwyKPTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90DC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLGHJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:09:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:09:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2769266wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 23:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p/ijNVegE4ehNi8UoZbjg25Mma34Nj/8H2lL0QDCA7Y=;
        b=MIwyKPTe8BGgP5A4fEMcZ5cV7tH8byg4g2QBt18tTZmmz9thhSftgkcsmG85ual2kD
         OPL8KV43SLHXsRbpJHZfFG6SySe8k+rCq7PrbwX8cClkoodvzTGUQ5c8RoGWk/zUBX2+
         9wuIIm7VRJKHeA8eFhgeGbps5mrCLBlDQ9Quw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p/ijNVegE4ehNi8UoZbjg25Mma34Nj/8H2lL0QDCA7Y=;
        b=El6Lx42ZNK8/8XVaB/DgHTsbMlgcEOxdHJBpQ047hr2a/C9Axit+tAqncvghxDOBdG
         khh4JI4SNhY8xkZ4myvEkKFkF3EHinfu0PrEJk78yj817jL9a04UDcA18FXFDZgI1uoM
         WdUAzy8FpPRlMs0AdTTu1f//VkXsY5pyoYQ4wkT35Bb7HNAYp1PSfVT+B38l/I2gsh1G
         73H2vuODITElqnGFtJaEjs4WZ/ZGjPEDy+SIbics4WuNIEDYT+Pr8dThvVRXOYcaW7+C
         gOfUxkc+VKdtsZtQ4IOa5Nbtlem6y5G67CUnIGA+SCHqrf6Ese4GxpMoUU2tvcZ0Agwr
         VlkQ==
X-Gm-Message-State: AA+aEWb8IvSJxDw9DPWiSdHkm4LJeKhohbfZHjkI3S1M2fMwvMMunY+R
        fwfhLtAtw6VBIl/njmRxwTU8wKLZHzI=
X-Google-Smtp-Source: AFSGD/VjSPhQM2jS1fKl6/lvV+e9jStHXlnTFkVm+EBCTjjKtSF1GBdNAyY5P6p/zLmkeDW19MZQJA==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr879206wrm.2.1544166552994;
        Thu, 06 Dec 2018 23:09:12 -0800 (PST)
Received: from [192.168.0.40] (80.149.136.77.rev.sfr.net. [77.136.149.80])
        by smtp.googlemail.com with ESMTPSA id x8sm7519758wmd.45.2018.12.06.23.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 23:09:12 -0800 (PST)
Subject: Re: [PATCH] thermal: uniphier: Convert to SPDX identifier
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1544144764-17964-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e8a64b24-b107-98ed-0e67-a61531e0ca0e@linaro.org>
Date:   Fri, 7 Dec 2018 08:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544144764-17964-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 02:06, Kunihiko Hayashi wrote:
> This converts license boilerplate to SPDX identifier, and removes
> unnecessary lines.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/thermal/uniphier_thermal.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
> index 55477d7..bba2284 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -1,21 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /**
>   * uniphier_thermal.c - Socionext UniPhier thermal driver
> - *
>   * Copyright 2014      Panasonic Corporation
>   * Copyright 2016-2017 Socionext Inc.
> - * All rights reserved.
> - *
>   * Author:
>   *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2  of
> - * the License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/bitops.h>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

