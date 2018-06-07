Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EdtaArZFGVsOJQAAmS7hNA
	; Thu, 07 Jun 2018 14:48:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E0421608C8; Thu,  7 Jun 2018 14:48:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s5Eeoejw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 528ED601C3;
	Thu,  7 Jun 2018 14:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 528ED601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935053AbeFGOsT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:48:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45751 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934861AbeFGOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:48:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so10135392wrm.12;
        Thu, 07 Jun 2018 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RO6oLbYMqbZKgSXbSu6Mk50NAV/EZEChxrXI4ok+0wE=;
        b=s5EeoejwGM4ROW2umJkBE7YRecyieD+pxntGwpKWBPR10UVWTOA8oYHTXTS8nWBkWT
         wY3GODSt3bvyiBE75z1sT8USjdYTZOI8yawNqHTsRemehQOSVdzFAdl3hkSQlMxRL1ZW
         z22ln8k/1b5hEGbQz710L/hT35epUCj98Ju68A6L4evqFMob3oM1jObizfvx6zmxieFC
         P3bNTD4x8Tgf3FHkCUcKuBF9WateWfPfVMGlr71EFcw0SG1A2/b4WCnyr2hXgmvIDVe5
         tFjqYp+L+XxGANVAJtFZTVC6OnLXtp2yzOte5iwlzED8KAUsdP3SsIJiK7T3HjsSl8ZY
         oy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RO6oLbYMqbZKgSXbSu6Mk50NAV/EZEChxrXI4ok+0wE=;
        b=lWpqQqhWCZ1va6reDO/Ko8Se6/Ibf+KtBnn6144zIyilGZyXgdGk/ZUlP4v+YnApRf
         L1xD6sE6HBTk+k6vFpWLutPYLCjgz8lnK3nzL1rWAdPX6arXA8cbTtgpRTEAy+j3tXqH
         bv8O+Sb2t0WvpUd121BrLoj13o3DGqeT59uyRIog7tw+RVlf18nERTXVldmFgVDKyJj0
         LYvh89n96SMhbefqPKPQUWIEuQOoeDpIJTSvjn37whqBB/wj/xomvJQbbuBiKYIiGO0i
         Pydm3sF8ucyw3RIl6ViHzLeKP7k379Ulhb5pOIqFlPLPqky5/GQRQCqKPjrfNP2g2l4P
         wFOA==
X-Gm-Message-State: APt69E3HWswYCO8Tk+O33bCSmPcc7zN/mQqkNzI+pqgS5Bu3oJuXY7Wf
        qHbVYj6Vh/wUqXMzssW1+D0puw==
X-Google-Smtp-Source: ADUXVKJ1qupzqHyzTP+2skO/BkZY+sS1WNHgc2dAIHkPnb9i78+/3191EOICh8vD/C3+6RolWf+GkA==
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr2120085wrm.2.1528382882500;
        Thu, 07 Jun 2018 07:48:02 -0700 (PDT)
Received: from localhost (cable-78-34-23-77.netcologne.de. [78.34.23.77])
        by smtp.gmail.com with ESMTPSA id s13-v6sm14556804wrq.48.2018.06.07.07.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:48:01 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:43:45 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
X-X-Sender: elektroman@T420s
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] rtc: ftrtc010: handle dates after 2106
In-Reply-To: <20180604141528.15635-2-alexandre.belloni@bootlin.com>
Message-ID: <alpine.LNX.2.00.1806071643370.3181@T420s>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com> <20180604141528.15635-2-alexandre.belloni@bootlin.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018, Alexandre Belloni wrote:

> Use correct types for offset and time and use
> rtc_time64_to_tm/rtc_tm_to_time64 to handle dates after 2106 properly.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-ftrtc010.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index 165d0b62db00..2cdc78ffeb17 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -73,8 +73,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
>  
> -	unsigned int  days, hour, min, sec;
> -	unsigned long offset, time;
> +	u32 days, hour, min, sec, offset;
> +	timeu64_t time;
>  
>  	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
>  	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
> @@ -84,7 +84,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  
>  	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
>  
> -	rtc_time_to_tm(time, tm);
> +	rtc_time64_to_tm(time, tm);
>  
>  	return 0;
>  }
> @@ -92,13 +92,13 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
> -	unsigned int sec, min, hour, day;
> -	unsigned long offset, time;
> +	u32 sec, min, hour, day, offset;
> +	timeu64_t time;
>  
>  	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
>  		return -EINVAL;
>  
> -	rtc_tm_to_time(tm, &time);
> +	time = rtc_tm_to_time64(tm);
>  
>  	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
>  	min = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
> -- 
> 2.17.1
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
