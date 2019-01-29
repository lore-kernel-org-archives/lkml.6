Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3E5C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D32175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFWy4rBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfA2AZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:25:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfA2AZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:25:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so7957608pgb.4;
        Mon, 28 Jan 2019 16:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zuMTD7i3DPkolHvTelq1ypV2FTV33mbaMeF7pJE/ifg=;
        b=EFWy4rBWDq+u6NPT9mOPTSNspPt7122l91jUcujP3gYExTiAuSUEYzk8FdA6/ounhB
         5IahCb4Ne9Pq4zu4Bt0UcXvmfAEPmme2E1caVSMZbFELDG5h6w70F2We1sLyP/W5qU2Q
         FLbUlTfuLzFhIfR/jTRVXs+6PYWsiypzGwGPEhhV20RymdESHypjOYHzsfN6K/ZUALFV
         F8rl9PsZ+RymmK3+GdPLB79OPwWo8VjVWLWd7oL4d+EOeUCMiHPeuhomAHLAANveIXZt
         5bwvY0HaVbU7ODu0WHwnrVTePB0z3d5Gk6dr+v+ZW2RnJPIy5g53f6P9Kvo1xGIV6yA9
         Qjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zuMTD7i3DPkolHvTelq1ypV2FTV33mbaMeF7pJE/ifg=;
        b=MzidgjSKwdXD5EiJkMguS/kc22qGDx3abphMQXN8XwqySfpkZ5vu6K2F7GSdhzaEGu
         YLd80Pbd8MUodaPmGjeeTv4dvW/7nMWVtbA3uWTwL1Hf8QYb22xB5kEF7ovJJWrmGLAA
         Hb5Jm4AS47YcSYOqpbwZPuJT95HVcyZWLmMUStFB5zVxVGHfDtbtzUt6DyaUlVVcy6io
         rmEJVRk5YqsuGT81P3zRc7fnMkwgDB+5Q6pPbceO9lcpRtwOyq8gAipVAr1QyPXFBily
         BwhpAdz1Zj53ZqoyWpiCl1OFZbidItDNQRLX7bK29S+uZDiLUrvut9c9xkQhenXIuoI6
         Gamw==
X-Gm-Message-State: AJcUukfwkKsvVVRU0sai0jgsai4k0zd/Wqstm9CyWEdqsgsb9uEn3G34
        4JnHnXXb4FCDS6T2l7T9dPM=
X-Google-Smtp-Source: ALg8bN60Njc+HyRR1wyo2PUw1KMz+0tC+hHk8lwR36tlAlkztsflghb5xM/1/B6rkvuzTnhC8xwLYg==
X-Received: by 2002:a63:c904:: with SMTP id o4mr21542547pgg.331.1548721520628;
        Mon, 28 Jan 2019 16:25:20 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g28sm54717040pfd.100.2019.01.28.16.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 16:25:19 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:25:18 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 8/8] Input: sx8654 - convert #defined flags to
 BIT(x)
Message-ID: <20190129002518.GH34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218084002.19454-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218084002.19454-1-richard.leitner@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:40:02AM +0100, Richard Leitner wrote:
> Some of the #defined register values are one-bit flags. Convert them to
> use the BIT(x) macro instead of 1 byte hexadecimal values. This improves
> readability and clarifies the intent.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/sx8654.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index b7b263ed52af..3746ea855f94 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -36,6 +36,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
>  #include <linux/input/touchscreen.h>
> +#include <linux/bitops.h>
>  
>  /* register addresses */
>  #define I2C_REG_TOUCH0			0x00
> @@ -46,7 +47,7 @@
>  #define I2C_REG_SOFTRESET		0x3f
>  
>  #define I2C_REG_SX8650_STAT		0x05
> -#define SX8650_STAT_CONVIRQ		0x80
> +#define SX8650_STAT_CONVIRQ		BIT(7)
>  
>  /* commands */
>  #define CMD_READ_REGISTER		0x40
> @@ -56,8 +57,8 @@
>  #define SOFTRESET_VALUE			0xde
>  
>  /* bits for I2C_REG_IRQSRC */
> -#define IRQ_PENTOUCH_TOUCHCONVDONE	0x08
> -#define IRQ_PENRELEASE			0x04
> +#define IRQ_PENTOUCH_TOUCHCONVDONE	BIT(7)
> +#define IRQ_PENRELEASE			BIT(6)
>  
>  /* bits for RegTouch1 */
>  #define CONDIRQ				0x20
> @@ -65,8 +66,8 @@
>  #define FILT_7SA			0x03
>  
>  /* bits for I2C_REG_CHANMASK */
> -#define CONV_X				0x80
> -#define CONV_Y				0x40
> +#define CONV_X				BIT(7)
> +#define CONV_Y				BIT(6)
>  
>  /* coordinates rate: higher nibble of CTRL0 register */
>  #define RATE_MANUAL			0x00
> -- 
> 2.11.0
> 

-- 
Dmitry
