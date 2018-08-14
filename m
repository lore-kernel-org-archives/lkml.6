Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C141C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E6920C0D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpsGQv+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E6920C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbeHNMOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:14:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36941 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeHNMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:14:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so13280908lfb.4;
        Tue, 14 Aug 2018 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=puG/LxjKy10aeWZsfMdG4slV1c/9OicxKJl5erx6DAs=;
        b=kpsGQv+0n5sH7Engf8RL2xICyl3y//wVJrvyDcmehp/i1rVB+ZBSW1xnhUPrCZBA+i
         x1BRx/Ai4xM7ZEQnRmoHniNJt5/85Y9YVG8OPlElpbtIdZmb+VsgdBS96QDJvK0lT2Ov
         hBi8laKHNPHe4Q/W2XeW01m5tnfQ2uR+5CjLr2tQvbVgWYBcdlXxAJ6EZs4VcFWZDual
         BSZ89bLOsGACJlHBtrMgvHX8gBN1AJ9ebO//el9sGyxV9plMsBk2ufFbCe8K9dxDfGBt
         7sjlu70kIKfx4ft/F85kYVeQhw3k2Vc5LmQdIN3pZLmOGyKX42ku70Xejpt1WN4knwei
         ccXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=puG/LxjKy10aeWZsfMdG4slV1c/9OicxKJl5erx6DAs=;
        b=uBfuiNdb1hiIoONMlU/7AHJAYm7f9N5G632nfvLH0fzQGOYmILsKILfhABfmKAO72j
         klTnYYqbAvhF/F0OgnlGIeZrqzauYNUj3dUFJwV2I/s6bTp+rDSNGOdT9WIcKREpOeqz
         I8A65CdD+uKyav3PEERxXFvdXV22Z8Ndm/zhhr+yqMl2cdn4kCxIluNAb8nZmL1xYCX2
         RfNBIUg84cxjxSv3ZWE6EMtaol8mpzZ1QKHpO3EkztxIhzkYfUeVrgGW5jlPH8eCtyZ+
         VkDDdlJFvE5ABvsNkHajKlvrbdTBzza1EUYeMePqTQC3znSvMXbJXcE7k3LTmpOv99ek
         L/eg==
X-Gm-Message-State: AOUpUlHtM8e2dxJOsgQcT3DG6akcanzH2ea1AqXRO3MvdeggiEiBww1z
        oFGyuuNEuzItmuOWZ4CKqtzIlari
X-Google-Smtp-Source: AA+uWPyP67ROBs5+TwrjZhUTfF/BZLvwyiBvm3xegqNo8+4sG0XtkqHOQmxba8h24O8TPSLzh9vo8g==
X-Received: by 2002:a19:5c8c:: with SMTP id u12-v6mr13017632lfi.98.1534238881872;
        Tue, 14 Aug 2018 02:28:01 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g16-v6sm3491771lje.1.2018.08.14.02.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 02:28:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fpVcJ-0003WT-Ck; Tue, 14 Aug 2018 11:27:55 +0200
Date:   Tue, 14 Aug 2018 11:27:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, t-kristo@ti.com,
        linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan@kernel.org
Subject: Re: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180814092755.GB30344@localhost>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
 <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
 <20180725093018.GA3539@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725093018.GA3539@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:30:18AM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 25/07/2018 11:21:22+0530, Keerthy wrote:
> > Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> > over try again.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>

> >  static void omap_rtc_power_off(void)
> > @@ -435,17 +429,20 @@ static void omap_rtc_power_off(void)
> >  	struct rtc_time tm;
> >  	unsigned long now;
> >  	u32 val;
> > +	int seconds;
> >  
> >  	rtc->type->unlock(rtc);
> >  	/* enable pmic_power_en control */
> >  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
> >  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
> >  
> > -	/* set alarm two seconds from now */
> > +again:
> > +	/* set alarm one second from now */
> >  	omap_rtc_read_time_raw(rtc, &tm);
> > +	seconds = tm.tm_sec;
> >  	bcd2tm(&tm);
> >  	rtc_tm_to_time(&tm, &now);
> > -	rtc_time_to_tm(now + 2, &tm);
> > +	rtc_time_to_tm(now + 1, &tm);
> >  
> >  	if (tm2bcd(&tm) < 0) {
> >  		dev_err(&rtc->rtc->dev, "power off failed\n");
> > @@ -470,14 +467,25 @@ static void omap_rtc_power_off(void)
> >  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> >  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> >  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> > +
> > +	/*
> > +	 * first check if ALARM2 has fired, if not then check if
> > +	 * our calculations started right before the rollover, try again
> > +	 * in case of rollover
> > +	 */
> > +	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
> > +						 OMAP_RTC_STATUS_REG)) &&
> > +	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> > +		goto again;
> > +
> 
> Can you use a while loop instead of goto?

I think a goto is warranted here as it allows for more readable code
with less indentation. And the exception case it is used for is truly an
exception that a single retry would take care of.

Johan
