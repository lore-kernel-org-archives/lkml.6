Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C20C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB52086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W27v7XWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDB52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeIGMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:35:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54104 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIGMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:35:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so13784157wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vL2Bgk50GqR5ByoZy/GCah93JMbsotFIKZyvg3a2tJU=;
        b=W27v7XWFN/34UXoC53P3vXbcAM3WmdhPMh3N8q2lnQ5VDOs9y6wcmCSaDPVNyxgo3Z
         HZ8LRENaId0hwlbxCox8D9OEotYo5fttiRal59nMnMaTb4GucRRslSNyP7Q09Up0BlQF
         jwyZFKilQN8enbjaWeNrjJx1IQSGrfzQ31VE1CJMk1XnlwAt5/LIvOpnWA88xwZrMhX+
         ePTnBru1J5J4D7wY6zvezvNO5u1QgdagBCvnyAqIAczzfHTlJ87ItpGvrXctSuDbXF/O
         /Gn+dNWiRDnTA6ZBQGbI/k3lMuy8AQaiWsxpwyx2E4+QWBdElrNA3KHz1NlmjHI+S426
         SP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vL2Bgk50GqR5ByoZy/GCah93JMbsotFIKZyvg3a2tJU=;
        b=o+2Zks+JHrx9Bfh4zLXAAeMvcLQGPe6SvunXeJqY4Qv61W1ljU1RaD5N0qMWF1jhqB
         EL6wtPmcDlF3Tq+ItzxZF89tumpclorNmWQ2AGjksLaZzYqSWY0C3BIWHmkxhogppvlA
         IR/C8TdZAbgXeWTfkvZGX1HyHijZy6+M38RXDal1hBgisgVs+c2YESZ3c9Wuxvw6kgva
         0fl+PlYMI3R3ubK478XxKJyE+Gy+r90IOqDu5KOug73LfBu7zLpikBstNagguURGkyXH
         ksxGvMmhcKR4qM7XLNmy4UV2xsSMtlmlXxSLF0TazVZ8BjTcZPR7jbJ04GXKvD8geoFO
         jUzA==
X-Gm-Message-State: APzg51AwyrU8vWFPp4+qSCmXCcu66irjTkfG06kZ63NuCoQHB0NCLF/X
        EmAX6osPyNdgeH8LdPfh1mCHhg==
X-Google-Smtp-Source: ANB0VdYePLKm3ub3hiJcEbqlh4g7SjxOclP26/QJI9nOHKucMUSQ4OVbv7rbQ7mNp5L92gwmWPuYkw==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr4131577wmd.135.1536306974636;
        Fri, 07 Sep 2018 00:56:14 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id h8-v6sm10833483wre.15.2018.09.07.00.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 00:56:14 -0700 (PDT)
Message-ID: <1053e423d4ba8c1dd65468d278c79d2b7159401f.camel@baylibre.com>
Subject: Re: [PATCH] leds: pwm: silently error out on EPROBE_DEFER
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Pavel Machek <pavel@ucw.cz>, sre@kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Sep 2018 09:56:12 +0200
In-Reply-To: <20180906153548.GA10088@amd>
References: <20180906135904.13803-1-jbrunet@baylibre.com>
         <20180906153548.GA10088@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 17:35 +0200, Pavel Machek wrote:
> On Thu 2018-09-06 15:59:04, Jerome Brunet wrote:
> > When probing, if we fail to get the pwm due to probe deferal, we shouldn't
> > print an error message. Just be silent in this case.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/leds/leds-pwm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> > index df80c89ebe7f..5d3faae51d59 100644
> > --- a/drivers/leds/leds-pwm.c
> > +++ b/drivers/leds/leds-pwm.c
> > @@ -100,8 +100,9 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
> >  		led_data->pwm = devm_pwm_get(dev, led->name);
> >  	if (IS_ERR(led_data->pwm)) {
> >  		ret = PTR_ERR(led_data->pwm);
> > -		dev_err(dev, "unable to request PWM for %s: %d\n",
> > -			led->name, ret);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(dev, "unable to request PWM for %s: %d\n",
> > +				led->name, ret);
> >  		return ret;
> >  	}
> 
> Hmm, sometimes probing is deffered forever, and in such case debug
> message is useful.
> 
> Do you see excessive number of these?

About 10 but displaying an error which is not error is already excessive IMO.

There is nothing out of the ordinary here. Feel free to grep git log for
EPROBE_DEFER. Many drivers take this into account from the beginning now and
we've been fixing others in most subsystem.

> 									
> 									Pavel


