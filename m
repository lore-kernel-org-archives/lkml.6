Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF01C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2878320651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI4jJ68z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2878320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJWBZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:25:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37294 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWBZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:25:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22-v6so3293478wmc.2;
        Mon, 22 Oct 2018 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gG6S4sQ8Jw5x72V+IttHc73vsPFxoJWp4Oug5JclafU=;
        b=XI4jJ68zftlVCVlYkc2wYUBZVx8E7q/jHmIEpNiThvpQWpauS6tzBvITsjcALYR96m
         W7LxSG9J2Zt4+Bomah/GhG5GTHv/PRxppNeNjkk3LZkMGdl1dYeIctl59wwX6QxQXymO
         lUjjZ4GAQwhEdfIb4LqhTv7fxtqOmNEqjU9pvI3y5c4RR9e5KviLMjwCXxk9vzQtYZ0z
         vsy10RuYrOtfsxrXbuv1nQIrl7H5akXs8nq59Us+GgAYcmXFznWDpVq/+0RwcDVxeLRc
         YDWDD6s5JIPpKLXo80fyAEz06knLFca+e60qk+vrNdSRq5rck1XvCtbWOSkX7ZEybjM6
         94gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gG6S4sQ8Jw5x72V+IttHc73vsPFxoJWp4Oug5JclafU=;
        b=SvX6ozbtRqDibSNvgqv2v5R+xfPUnpRq3AqOczzfkUDY1CH3Od7t7vDysgymNnJ8ku
         5DSbqgO2Cnbiiy3hCbs/OW48CHBLwbJyhvdsaNckzP2qJUHJYRCL4hzqni40WyIx4Ea7
         AcVah+iykqmJHQ4bqMgjaGMdFzjOMmiEIRUzjoZ8cJwyAET0mxBNYphwGaBG+hCpiebk
         14D/kRP+eh3Y1ZPNZfuQTtyZ9/rRLHzTItadONm4jX8TCogWIXB301vYLswTiNBbShgP
         Gh4QHRMvFRjEKEqqrgt7cE8C94sBYf6sm/KSXOpuLegn8rHHeLaWLCebCcL87MUgIPiY
         sgJw==
X-Gm-Message-State: AGRZ1gJJEgHYxAvBv+68BCdwB0crU1ufQkqXAQaYO4RJxiiBkVTluKAF
        O2rBVraxw17yHpx1YW2rIi5Dtva3
X-Google-Smtp-Source: ACcGV61l9vBJm+cTgQZFNfwPbPM7yfn2PZTJ2aI0WGlm7UhXzjkvMi7XFkuE9uePBN/OwKuzsfHx9Q==
X-Received: by 2002:a1c:7508:: with SMTP id o8-v6mr17100214wmc.76.1540227954855;
        Mon, 22 Oct 2018 10:05:54 -0700 (PDT)
Received: from [10.67.49.28] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id u10-v6sm28195593wrt.59.2018.10.22.10.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 10:05:53 -0700 (PDT)
Subject: Re: [PATCH 0/9] net: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <7a2fdd94-a883-da02-845e-f6dd8dcfb969@gmail.com>
Date:   Mon, 22 Oct 2018 10:05:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/18 1:00 PM, Wolfram Sang wrote:
> I got tired of fixing this in Renesas drivers manually, so I took the big
> hammer. Remove this cumbersome code pattern which got copy-pasted too much
> already:
> 
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
> 
> A branch, tested by buildbot, can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git coccinelle/get_drvdata
> 
> I have been asked if it couldn't be done for dev_set_drvdata as well. I checked
> it and did not find one occasion where it could be simplified like this. Not
> much of a surprise because driver_data is usually set in probe() functions
> which access struct platform_device in many other ways.
> 
> I am open for other comments, suggestions, too, of course.

Would it make sense to annotate platform_get_drvdata() with __deprecated
or something like that to prevent further uses by driver authors?

Do you mind submitting the cocci-script to the maintainers of the
coccinelle scripts that way it can be included and run by automated
tools? Thanks!

> 
> Here is the cocci-script I created:
> 
> @@
> struct device* d;
> identifier pdev;
> expression *ptr;
> @@
> (
> -	struct platform_device *pdev = to_platform_device(d);
> |
> -	struct platform_device *pdev;
> 	...
> -	pdev = to_platform_device(d);
> )
> 	<... when != pdev
> -	&pdev->dev
> +	d
> 	...>
> 
> 	ptr =
> -	platform_get_drvdata(pdev)
> +	dev_get_drvdata(d)
> 
> 	<... when != pdev
> -	&pdev->dev
> +	d
> 	...>
> 
> Kind regards,
> 
>    Wolfram
> 
> 
> Wolfram Sang (9):
>   net: dsa: bcm_sf2: simplify getting .driver_data
>   net: dsa: qca8k: simplify getting .driver_data
>   net: ethernet: cadence: macb_main: simplify getting .driver_data
>   net: ethernet: davicom: dm9000: simplify getting .driver_data
>   net: ethernet: smsc: smc91x: simplify getting .driver_data
>   net: ethernet: ti: cpsw: simplify getting .driver_data
>   net: ethernet: ti: davinci_emac: simplify getting .driver_data
>   net: ethernet: wiznet: w5300: simplify getting .driver_data
>   net: phy: mdio-mux-bcm-iproc: simplify getting .driver_data
> 
>  drivers/net/dsa/bcm_sf2.c                | 6 ++----
>  drivers/net/dsa/qca8k.c                  | 6 ++----
>  drivers/net/ethernet/cadence/macb_main.c | 6 ++----
>  drivers/net/ethernet/davicom/dm9000.c    | 6 ++----
>  drivers/net/ethernet/smsc/smc91x.c       | 3 +--
>  drivers/net/ethernet/ti/cpsw.c           | 6 ++----
>  drivers/net/ethernet/ti/davinci_emac.c   | 6 ++----
>  drivers/net/ethernet/wiznet/w5300.c      | 6 ++----
>  drivers/net/phy/mdio-mux-bcm-iproc.c     | 6 ++----
>  9 files changed, 17 insertions(+), 34 deletions(-)
> 


-- 
Florian
