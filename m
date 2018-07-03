Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F63C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DA824737
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgpBlcAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DA824737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeGCU4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:56:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33007 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeGCU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:56:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id k7-v6so3255979wrq.0;
        Tue, 03 Jul 2018 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a+aPFdy4v45rr+JsLb7e4+qFXauYaSCJSRu9DDL4HlQ=;
        b=dgpBlcASwGhRVKEvjhml1o7e/RXGb1t1OCo3G5OnWM04GS4SUR40gpwwljpP1jBQNf
         oWnTSqbvxKOdeumKE/QxnsSnbJMM8Z+Y15pq5jjIDCLzC0y7ZRgaoMH3dipu0IUmYj70
         ykZ5l88i2Xh3PPvQ9F0j1TB4m57MeYdcn4d8GSkQsn6BT4dih/1dSfmP7ey/XWbQhSnH
         dtq5ivF/z5dj2dOyP7iTZgJmPi3ETwUYtq6PF6/2Fi31z+NYDtQ6D3JEVwmVChMkAxUG
         lz4qcsLuwuo/OFqdJmF861p+qgVZwDGXq0c7Ta68BX/nt+Yua1gLU2JsGVwoJpZtVeDz
         Fi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a+aPFdy4v45rr+JsLb7e4+qFXauYaSCJSRu9DDL4HlQ=;
        b=fFFalZluz8HDVsXMgfK146BhVqTu1sOQCW6Y7fltEZaCSruFVyNMSmVcdxqWipV4KL
         ATw4hxa6V1TvR8reQSbB3pJZFZLdZ09Wiot1k+SU9NCbGkJR114Ul58XJHlDINwikN0B
         5ZkwbJtCS4yXBc5Yc+XDCO/iFNf/UkUusIaCw/V/VClQGUd9JNOxSfHzBqB9zqpDxOHP
         HjtIFifihlLyZvSfoCvXmGbGtK0nHTieU7WSLlJw2QWfPZrO30NGKIGQC3gQOzYasS5h
         pPYtdk2l8PxQ+4K/CAEpbUc5TaaMzkmO8w3JjRtBKdVjAg9bhB4TTVXDnukqVkd5Fzw5
         04nA==
X-Gm-Message-State: APt69E1sUalbvk4OdlOOMYm+pgHMa/B8hgRgitvQ3HOd/mYHwm+XYSb/
        IRNZr+hPmPWXuSMSTXdZLoVkxwFX
X-Google-Smtp-Source: AAOMgpc1jYKJ9S+2LOiYUoSMAIZR5ts6jAyoSavXM79ddE60daX5Wv+jGghlVagBYSrOnnBe1HwNdQ==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr12494076wrb.127.1530651401057;
        Tue, 03 Jul 2018 13:56:41 -0700 (PDT)
Received: from [192.168.1.18] (bky248.neoplus.adsl.tpnet.pl. [83.28.192.248])
        by smtp.gmail.com with ESMTPSA id n8-v6sm3478317wmg.27.2018.07.03.13.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 13:56:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] leds: lm3692x: Update license header to SPDX
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.shevchenko@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180702181216.19660-1-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5845fa3b-a70e-bf7b-41e6-5b8a2a837f4a@gmail.com>
Date:   Tue, 3 Jul 2018 22:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702181216.19660-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch set, applied.

Best regards,
Jacek Anaszewski

On 07/02/2018 08:12 PM, Dan Murphy wrote:
> Update the license header to the current
> SPDX licensing format.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   drivers/leds/leds-lm3692x.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
> index 437173d1712c..1a06d8c97789 100644
> --- a/drivers/leds/leds-lm3692x.c
> +++ b/drivers/leds/leds-lm3692x.c
> @@ -1,17 +1,6 @@
> -/*
> - * TI lm3692x LED Driver
> - *
> - * Copyright (C) 2017 Texas Instruments
> - *
> - * Author: Dan Murphy <dmurphy@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * Data sheet is located
> - * http://www.ti.com/lit/ds/snvsa29/snvsa29.pdf
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// TI LM3692x LED chip family driver
> +// Copyright (C) 2017-18 Texas Instruments Incorporated - http://www.ti.com/
>   
>   #include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
> 

