Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843A22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="OvDJDJsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4843A22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeKNTWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:22:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43711 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeKNTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:22:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so10966599lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n99mkv/qstUMd+hP8pL5EXKhGK3hgCcBJmquKoTxPcE=;
        b=OvDJDJsl+x9Gp+XTA01laQDOIKUb+v5y//himdt5/oPjOPzRA+xj/74IOHpuBEe/l1
         E/q4S4xEzCHVdQEMKgWnnOTf7GXq9XJJswo58+oWZkBFseG7ydotWmrDdM+89vyfx93P
         JNlzLiFXRhkk6aLIZIreuDwCUFUFP5EMB3HwKhpnwfX0hintaqGR8eDEXyfnfxN0K0Pi
         GXxiQwccSneHMn4X/Y5HCcZTay+qe0WD7pF6faXk49J855bz/TCnWnK8WZlNKolmIrsl
         9X5iuz4p6hS/zFKKzLVF5RJITBAK0cmzW9NkAZYtMktnncYL8C1Jr6oeCjkxKTX8JUP1
         TgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n99mkv/qstUMd+hP8pL5EXKhGK3hgCcBJmquKoTxPcE=;
        b=WmCHAXl0kf/DwmEjvWMdH7y7m8fpU7FCCOZaTCPieWZV0wnnkDhmc79xKdDLUvLN7L
         j1Vd29uaj9m3ru5TfOGsu4vEwdkeoY128p5t3U8wi4cdGPg0YeXW6ohRqpS3Mr2dmbIh
         YRFSX1E1qQrGTHzKABaYuSv1zOp7Wce2rK6Np6YuV7n+1dYVDO+FoHR1DyMis0zZji82
         LYPiB8rGjLD9svnc2YvORGcyJqYneHQ0mFASkE+PO4DXDIla7IWx/82XZl2gxgmixl4d
         S8MLKJVqUWwdDE2zeEXym1vS+eBVMO118Me0PT092ZXzwf/acxG1bvileDZWa80/ksFL
         ihIQ==
X-Gm-Message-State: AGRZ1gJmIlxBULE+zLE0Vt9nzGTMRk//cen7plnikgMJO2b/r/4WLaVb
        SNJJgie5L4hCL31h9Axk6IT8/w==
X-Google-Smtp-Source: AJdET5eYnJINUeb4ownQVJKSwaBSTpGuEKL9ZDDEJc/ChK3MJyFNG6cyTr95ih4yTSuetAczKARZtA==
X-Received: by 2002:a19:10da:: with SMTP id 87mr594938lfq.60.1542187225142;
        Wed, 14 Nov 2018 01:20:25 -0800 (PST)
Received: from [192.168.0.200] ([31.173.86.45])
        by smtp.gmail.com with ESMTPSA id 67-v6sm3871926ljc.26.2018.11.14.01.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:20:24 -0800 (PST)
Subject: Re: [PATCH v2] net: phy: mdio-gpio: fix access that may sleep
To:     Martin Schiller <ms@dev.tdt.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181114063703.13379-1-ms@dev.tdt.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <93d2cb1c-47ee-0b9b-472a-a7fa8a2dfd3d@cogentembedded.com>
Date:   Wed, 14 Nov 2018 12:20:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181114063703.13379-1-ms@dev.tdt.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 14.11.2018 9:37, Martin Schiller wrote:

> This commit re-enables support for slow GPIO pins. It was initially
> introduced by commit
> 	2d6c9091ab7630dfcf34417c6683ce4764d7d40a
> and got lost by commit
> 	7e5fbd1e0700f1bdb94508f84ec2aeb01eed7b12

    This is not how you cite a commit: 12 digits is enough and they should
be followed by the commit summary enclosed in ("").

> 
> Also add a warning about slow GPIO pins like it is done in i2c-gpio.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
> v2:
>   - fixed copy/paste bug in warning about slow GPIO pins
> ---
>   drivers/net/phy/mdio-gpio.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
> index 33265747bf39..6c1cca14689b 100644
> --- a/drivers/net/phy/mdio-gpio.c
> +++ b/drivers/net/phy/mdio-gpio.c
[...]
> @@ -162,6 +162,11 @@ static int mdio_gpio_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	if (gpiod_cansleep(bitbang->mdc) || gpiod_cansleep(bitbang->mdio)
> +		|| gpiod_cansleep(bitbang->mdo))

    The line continued that way blends with the branch below, the networking
code uses a different style of line continuation where the continuation line
starts immediately below the 1st gpiod_cansleep() call. Also, || should be
left on the 1st line...

> +		dev_warn(&pdev->dev, "Slow GPIO pins might wreak havoc into"
> +				     "MDIO bus timing");
> +
>   	if (pdev->dev.of_node) {
>   		bus_id = of_alias_get_id(pdev->dev.of_node, "mdio-gpio");
>   		if (bus_id < 0) {

MBR, Sergei
