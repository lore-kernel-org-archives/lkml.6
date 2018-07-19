Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF92C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F44206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMzTU4Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F44206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeGSKpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:45:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41051 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeGSKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:45:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so6693409ljy.8;
        Thu, 19 Jul 2018 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gXOMtGsvPoPbDPilCZV/HarAVISUF34rTujT1xi9Qs=;
        b=aMzTU4Sy/0z66j7r4q5g7cYZaYfv0/JC293VoEeZpT3QIvjzCwjEaFPrmRH31INaPU
         O+Qvm7dDiPLpD2/hrEFusAc5DHVH2gd5abkMHT/w15J3mtRRm4vQE7pfm7kYua0ZJDhX
         f3mNEbRhxOo4pB+523+cNYEOf5/RQYh/5Yo/J0j5IgUH2MwiHEOb7LP5kceT1apteqHn
         C5WsbXSyKLhcWlV3XQKuM9wxo+hvndAPx3uUUEYoId9+6BRpBOdMOLyY/HsHKoOHl75D
         /g97Vh1RyRJHysyIOlYEFMT4yJGfSC4klbttNIitIeZ7ew9Ie+r8EKakXO5cqFj5hVal
         w2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gXOMtGsvPoPbDPilCZV/HarAVISUF34rTujT1xi9Qs=;
        b=VvDpGPtoJch4DwTc+lNn60A9YZoF5DQMmIMbZUfwEAuWUwY+ski4RZYm9y6q+0sdmM
         ySJeRMlL/goOTXzpZuwC+Jqx+J2Ghs98l8JjKGh93JraxDBu/U4OcfVVmW1HI68vCNXs
         ytquQNNGxrkL0OlwTMkTcPhKZb1O8YNKPbzkyjMK0UYwGy1iDMVrYDIp3iq/OoBA2bk+
         vGqs8KU8ZFw/FMPYUt3fTbUlu7N2rJyAXR79Rfn+XcTBhjVCWjIP2BaS3kUuOd5eaikd
         yEZyhkFT/5SdfuibvVYWddW9V1F0quo8U2Cy/QgSk1ZasUc553Bm1afApdn357g4ULTW
         JfuQ==
X-Gm-Message-State: AOUpUlFho9YfUKg96WKlMJtDCQHYMYO3FkvGIdKpxrTtmRFERArNwRih
        2p6H48CFoG93aIDRrAZmYM6WzsaJ
X-Google-Smtp-Source: AAOMgpfHEKPAqfSZBeB4aQif3s7cridVnTpBfZmL+jave3H6hf1v9tocivJC7ie9sVy0HzU+6srcfw==
X-Received: by 2002:a2e:6505:: with SMTP id z5-v6mr6914475ljb.62.1531994561769;
        Thu, 19 Jul 2018 03:02:41 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j26-v6sm1037804ljc.54.2018.07.19.03.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:02:40 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fg5lV-0006Gp-8x; Thu, 19 Jul 2018 12:02:29 +0200
Date:   Thu, 19 Jul 2018 12:02:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180719100229.GQ10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v4:
> 
>   * Fixed a compilation issue.
>   * Extended the roll over check post interrupt programming.
> 
>  drivers/rtc/rtc-omap.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 323ff55..88da927 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c

First, the comment above this function would need to be updated as part
of this patch as it refers to the two-second alarm offset.

> @@ -435,17 +435,23 @@ static void omap_rtc_power_off(void)
>  	struct rtc_time tm;
>  	unsigned long now;
>  	u32 val;
> +	int seconds;
>  
>  	rtc->type->unlock(rtc);
>  	/* enable pmic_power_en control */
>  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>  
> -	/* set alarm two seconds from now */
> +again:
> +	/* Clear any existing ALARM2 event */
> +	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);

Why is this needed? Any pending interrupt is cleared at probe, and a
previous attempt to set the alarm really led to the alarm going off, why
would we retry?

> +
> +	/* set alarm one second from now */
>  	omap_rtc_read_time_raw(rtc, &tm);
> +	seconds = tm.tm_sec;
>  	bcd2tm(&tm);
>  	rtc_tm_to_time(&tm, &now);
> -	rtc_time_to_tm(now + 2, &tm);
> +	rtc_time_to_tm(now + 1, &tm);
>  
>  	if (tm2bcd(&tm) < 0) {
>  		dev_err(&rtc->rtc->dev, "power off failed\n");
> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);

Add a newline here.

> +	/* Our calculations started right before the rollover, try again */

Nit: use all lower case unless writing full sentences, which also
matches most of the other comments in this file.

> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> +		goto again;

Here the alarm may have gone off as part of the roll over, in which case
you shouldn't retry.

Add a newline here too.

>  	rtc->type->lock(rtc);
>  
>  	/*

Thanks,
Johan
