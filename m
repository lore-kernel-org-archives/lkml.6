Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1+CBLZhFGVvxIQAAmS7hNA
	; Thu, 07 Jun 2018 14:48:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 83C38602FC; Thu,  7 Jun 2018 14:48:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J8idrU0y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E00C56074D;
	Thu,  7 Jun 2018 14:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E00C56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935066AbeFGOsW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:48:22 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36477 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934474AbeFGOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:48:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so10169938wrm.3;
        Thu, 07 Jun 2018 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1Y96TUtKgCbok0FmySMtQ6nmy5OuzGfdueo7l/CuSEI=;
        b=J8idrU0yBfXTSRINE/VInP22sohi+CqzscFUEqXpw41cQUuOXrpLCWxI7DQyocSBiN
         mdkXB9P28fDKMlLclBtBxqqcPKkMT4qnfn2lkWt+yZLtX32vGYAac813DYM8l40OCzNI
         C0XI7f7rNvyyPnx/c/6DeoJGzIqweSOSgmGLINdJ3p2qPUNEJmpbwbyBUKsHHvK8IMlV
         BL4X7/jNIEzCCjajNKBPCniMKb8wiACYuxXQ6qSbhCpzhB7qINnQ9zzIrIp+RX85iV99
         nR7hln2fXO/q2gbfbNr4/YjkU3G9WrQKBe2oOUwO6NqEwFqZObK43dTj45QA7Kfxzcsb
         TQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1Y96TUtKgCbok0FmySMtQ6nmy5OuzGfdueo7l/CuSEI=;
        b=ds4RqM0QM35oF1fPv63E6zfE3wYUJs+91dpDYNrRPpzS6OkVMqdD/e4uJlPFJhMw5H
         MFDU4b7Vo6pJ3zaujQuLvyjHUXSYMBqKMEcBZw1spMiZhFTPcwe95oqlXYGWj6kjjGrl
         FnMqgR/H3ltCzWEmlJUOAgZMe/iujRi9sWdz2eIGO3WQGG0Mw2wOjn8Bit53dXOM76W9
         jGmCKEbiylX6QsyNCgfDNuXLICMnplyQEC+u6FFtBc3Kkm7X2nAswf8o/Idau416u65d
         ABepAZW4GpdXH3BI7vif4DMxiyU1MmC4bWDiiS8P2E1IQ3Mn6995aHWuez9smoEF3c/U
         b3jw==
X-Gm-Message-State: APt69E1nchpu8M6Toy2zUWYXHgibbm1spZvNwTQXz/0vnlLuXoXs09v6
        /VZpTWch7KZxlMtS01z6tXk=
X-Google-Smtp-Source: ADUXVKKYMWHKT7q4cqbKxK18GDQGIwG5PxgrDw/2Piddi17iqfa751w9obMC3h3SgXD7n85NezF8qg==
X-Received: by 2002:adf:9724:: with SMTP id r33-v6mr2107216wrb.79.1528382895810;
        Thu, 07 Jun 2018 07:48:15 -0700 (PDT)
Received: from localhost (cable-78-34-23-77.netcologne.de. [78.34.23.77])
        by smtp.gmail.com with ESMTPSA id n56-v6sm66496740wrn.72.2018.06.07.07.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:48:15 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:43:59 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
X-X-Sender: elektroman@T420s
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] rtc: ftrtc010: let the core handle range
In-Reply-To: <20180604141528.15635-3-alexandre.belloni@bootlin.com>
Message-ID: <alpine.LNX.2.00.1806071643490.3181@T420s>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com> <20180604141528.15635-3-alexandre.belloni@bootlin.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018, Alexandre Belloni wrote:

> The current range handling is highly suspicious. Anyway, let the core
> handle it.
> The RTC has a 32 bit counter on top of days + hh:mm:ss registers.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-ftrtc010.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index 2cdc78ffeb17..61f798c6101f 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -95,9 +95,6 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	u32 sec, min, hour, day, offset;
>  	timeu64_t time;
>  
> -	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
> -		return -EINVAL;
> -
>  	time = rtc_tm_to_time64(tm);
>  
>  	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
> @@ -120,6 +117,7 @@ static const struct rtc_class_ops ftrtc010_rtc_ops = {
>  
>  static int ftrtc010_rtc_probe(struct platform_device *pdev)
>  {
> +	u32 days, hour, min, sec;
>  	struct ftrtc010_rtc *rtc;
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> @@ -172,6 +170,15 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
>  
>  	rtc->rtc_dev->ops = &ftrtc010_rtc_ops;
>  
> +	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
> +	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
> +	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
> +	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
> +
> +	rtc->rtc_dev->range_min = (u64)days * 86400 + hour * 3600 +
> +				  min * 60 + sec;
> +	rtc->rtc_dev->range_max = U32_MAX + rtc->rtc_dev->range_min;
> +
>  	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
>  			       IRQF_SHARED, pdev->name, dev);
>  	if (unlikely(ret))
> -- 
> 2.17.1
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
