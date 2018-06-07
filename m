Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1eCBLZhFGVvxIQAAmS7hNA
	; Thu, 07 Jun 2018 14:48:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B0178602FC; Thu,  7 Jun 2018 14:48:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XKFlDw9I"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 82C7D6089E;
	Thu,  7 Jun 2018 14:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82C7D6089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935044AbeFGOsF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:48:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34254 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934706AbeFGOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:47:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so10169802wro.1;
        Thu, 07 Jun 2018 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=s89pfoMA2+9mEjIvyYRvDJJMTEs1+yH8R12DucrWV1Y=;
        b=XKFlDw9IVUmn03IDwbu4g3HAvZqbzbSlEC4RmqLVW2qZZrp2sxRE6Mm5WzFOrjtHkO
         tHShNuzZ1+vl8gm/L39EibTcxbrWMeSWD3JlyQSn1aBQGhYeu63D20tC+ihI0wAGQI0V
         g/EoGyDcQT0/X8F1AoW81Kyu9p8L1emG/YEdC97Dx+OGj4tNi/Oh/SfENwWilMvCjnox
         /c0ENwBeR6i46XgcZ6mu/lwyJklYOl7nGdSa8wGW79oj76k1vAHYBenyNXSrKht4H1d1
         0po7QHEsQ/myFW1cXfnNc4b1JRQHwhYWlznLhu/If8iyQp2N5kL1yzr9NfbkuYv1JQQS
         ElOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=s89pfoMA2+9mEjIvyYRvDJJMTEs1+yH8R12DucrWV1Y=;
        b=feLFbu6peivTDfBg5cxc+aX1F8k4a8NjNUOybkZTTaMkIVKaGIebg7rboHWHEs6x+K
         RHs6wVEGqmcFiPQmCiFmmWOC1TBwfiUjvaxH2wEAEHj9Eox68W/2fJr5PunwoSt4VO8B
         /VVr4OBcWmqXhGOxRSIbu7jN79rANwMd+9mdzlCz+E2/FcrYFGZTbBnYlh9S9RjLKjoD
         TKqHlLacLLElybftUegEf3yojOyQUcfNn4RN9c5g4iCsGwKaz51edTtbJA07fv3cKTvM
         SydlTBngb9/Jd8DPrtW3TbD1NMHKe+b6apF2krJwDCtzHppElrODYGsIcjjZTWakidyl
         cCYA==
X-Gm-Message-State: APt69E0gKV8zro8vcNg54N+UQ+LxdZ89NEqRqElowKLdylKeXvTXknO8
        DrB4KPGwFEdvxkonxR/s3KY=
X-Google-Smtp-Source: ADUXVKLtvcmISoQpCY1GYm21IKGr7dFGwd1Hee7eboJG3ws/+LxJTfRjKTae75hzhh/QQws3574QYA==
X-Received: by 2002:adf:bbcd:: with SMTP id z13-v6mr2055740wrg.183.1528382869123;
        Thu, 07 Jun 2018 07:47:49 -0700 (PDT)
Received: from localhost (cable-78-34-23-77.netcologne.de. [78.34.23.77])
        by smtp.gmail.com with ESMTPSA id t1-v6sm2049601wmt.40.2018.06.07.07.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:47:48 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:43:31 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
X-X-Sender: elektroman@T420s
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] rtc: ftrtc010: switch to devm_rtc_allocate_device
In-Reply-To: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
Message-ID: <alpine.LNX.2.00.1806071643190.3181@T420s>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018, Alexandre Belloni wrote:

> Switch to devm_rtc_allocate_device/rtc_register_device. This allow or
> further improvement and simplifies ftrtc010_rtc_remove().
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-ftrtc010.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index af8d6beae20c..165d0b62db00 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -166,14 +166,18 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
>  	if (!rtc->rtc_base)
>  		return -ENOMEM;
>  
> +	rtc->rtc_dev = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
> +	rtc->rtc_dev->ops = &ftrtc010_rtc_ops;
> +
>  	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
>  			       IRQF_SHARED, pdev->name, dev);
>  	if (unlikely(ret))
>  		return ret;
>  
> -	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
> -					   &ftrtc010_rtc_ops, THIS_MODULE);
> -	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
> +	return rtc_register_device(rtc->rtc_dev);
>  }
>  
>  static int ftrtc010_rtc_remove(struct platform_device *pdev)
> @@ -184,7 +188,6 @@ static int ftrtc010_rtc_remove(struct platform_device *pdev)
>  		clk_disable_unprepare(rtc->extclk);
>  	if (!IS_ERR(rtc->pclk))
>  		clk_disable_unprepare(rtc->pclk);
> -	rtc_device_unregister(rtc->rtc_dev);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
