Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBA4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEA820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="I/7GpVFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEA820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeGWVtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:49:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38875 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeGWVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:49:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so1692228ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dAXSd2EnRP+gL6XfCUP1+8UfeP3EVi29NpStfd5o+XY=;
        b=I/7GpVFQhDY9zq5zvQnY0Gn7PwLlK8tl5R0XmRdRRMW57islZ+z/59CaklnudpV5xg
         ifNzT8jyDYvO+jWbusjmanHMr1jvLDrfjOrAkyf5rr68MTTSpboeHxaLi5Ne+fc9dzh7
         rwGvdG4BF5AlR+/pROpQA0BssuBOZEEPmiSYepjOwri2igLlEbS0WMN18zsHKUnoofhh
         xBB0MIakeX+DukC8GIT+LbHO+NJtv0foJdi9ERVyOhhSgCm4Qe04UZVzupYsf8mIIkRN
         yjlaPThaI5RPP3V8NYE1remeIi1neMcsTg7jOFQXpVr44iO1E1QUjfi6obiR8kJ0tMAj
         +oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dAXSd2EnRP+gL6XfCUP1+8UfeP3EVi29NpStfd5o+XY=;
        b=nUDeQXSQBNW1TPjaeWd4G60oWOIG+q4SJ4u/NK2PwzHQ8tSIcQZdo28sWwwhPANC3l
         fe5bT+WHb4cQBGhPmRXwxXVlWv0ZgNhb6j+9jHcSkRjFUJQx9EnCpADcpZyIIUQfE9mv
         eMa/14dM0SODBRUFlg3FIzxakn2Yfgtgznz6XdTxVcGnbH3eXIgxZ97siGwNlV+y7GG9
         dBAxsRp1vYv+byNBkXQOr/NEboaqeGnhJiGHDhfEUXcNQpW9hRzMPIwcu6PyhC2M59pz
         0R/DjmlyzCkn/AkZA3DD8+Z9McvjUOX3HGVyOQKooBrAD75qt7FGsE4UlEg/9DwZNsUD
         BBTQ==
X-Gm-Message-State: AOUpUlFRZ5G+lVt9ls4PzTjUWCFd6L8OqNP9ZjL6GYWZxlEab685UBdA
        BGF3IK44V+m3Msy6Co17o/foFA==
X-Google-Smtp-Source: AAOMgpds0y6PVG4DAF3EFDxte/ulE/SgdJTKThbIfkbXinLCkaslAHWAiCHW8yapAbXTNu/OhRaihg==
X-Received: by 2002:a2e:8:: with SMTP id 8-v6mr9894877lja.112.1532378772297;
        Mon, 23 Jul 2018 13:46:12 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id r64-v6sm1543180lff.90.2018.07.23.13.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:46:11 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:46:10 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] i2c: rcar: use core to detect 'no zero length'
 quirk
Message-ID: <20180723204610.GH1432@bigcity.dyn.berto.se>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-11-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180723202617.15230-11-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2018-07-23 22:26:14 +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
>  drivers/i2c/busses/i2c-rcar.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 2688520110d1..791a4aa34fdd 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -796,14 +796,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
>  	if (ret < 0)
>  		goto out;
>  
> -	for (i = 0; i < num; i++) {
> -		/* This HW can't send STOP after address phase */
> -		if (msgs[i].len == 0) {
> -			ret = -EOPNOTSUPP;
> -			goto out;
> -		}
> +	for (i = 0; i < num; i++)
>  		rcar_i2c_request_dma(priv, msgs + i);
> -	}
>  
>  	/* init first message */
>  	priv->msg = msgs;
> @@ -890,6 +884,10 @@ static const struct i2c_algorithm rcar_i2c_algo = {
>  	.unreg_slave	= rcar_unreg_slave,
>  };
>  
> +static const struct i2c_adapter_quirks rcar_i2c_quirks = {
> +	.flags = I2C_AQ_NO_ZERO_LEN,
> +};
> +
>  static const struct of_device_id rcar_i2c_dt_ids[] = {
>  	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
>  	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
> @@ -943,6 +941,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent = dev;
>  	adap->dev.of_node = dev->of_node;
>  	adap->bus_recovery_info = &rcar_i2c_bri;
> +	adap->quirks = &rcar_i2c_quirks;
>  	i2c_set_adapdata(adap, priv);
>  	strlcpy(adap->name, pdev->name, sizeof(adap->name));
>  
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
