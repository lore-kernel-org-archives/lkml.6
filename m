Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41207C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0184C21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="In6v+mWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0184C21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbeKNVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:06:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44024 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeKNVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:06:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so11181190lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2EdWxzCnG3wiWjJ23SzFhSaz3PgHMA+CwmMrN4no4Y=;
        b=In6v+mWSH8IY0RF3mpA8Lk6drwrOFnXI/5aeH6yscRvfbCE2uT5xhwDScbpmHEMdxd
         T3erjV2E3QBGx7qWSpVJRiNyXG0KlQgzHCHC54j1gAQ3OSub3eDogTyBkWqk1QfrIUnN
         NhhEbcG2/v3UTO7AEVE9wlDfjnz056VoyFFbT5w4Xi9enj+8mqs9vtx7JKMbHsMtG6rQ
         gwafx1NTNO7OZQtPHxgxZGXwqmdD2Rqb1elmLbEz5Qyn+KAbn5KGBBtxBG9Sj/1MaqUa
         0T8B1NheSCi4jC98WLWXeaB8YFvoLNQcTZOJtNmpWPBOFJW1f2F2T4z63s3QNj36tKxe
         crKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J2EdWxzCnG3wiWjJ23SzFhSaz3PgHMA+CwmMrN4no4Y=;
        b=PYqyeaL259MUmZbDWTKD7+UI4IAxyiNZaU1eP5d6BT6b8BAmdNOtpX4pf4vXa46kzg
         borh9lHoWOUs/DNObfYIy9bYBtdeyDNHbqyYrcV4fgKMtzQBzDFgS14elMVyl/fUsx80
         1wfWCA19NjBKJ6W+TUabMvb2+Vn6JN+MHvliO2ge2zmr0z9R6RK31L6A7bQp4gWWX13z
         gMkuh7QUYyB+Ip8x0CRzKjiAoBsFoPMohDCnJyeP9TPgtCCf9AVeVQ75gsHbcRc5xoba
         lN14CsdMP5oQz8FHXqls4YxHj7DtIOskWzqwVMwWwyxLMpqfGHlbLMqd7+BpLessQLQH
         PlvQ==
X-Gm-Message-State: AGRZ1gJRNUVwvwg7Fc6Ji89Pi7khAtf8ccJZqbgTLaKu+e4XKZ3osIoz
        zeiAxxNVPeML/4A/UnuS5wbVU7FuUyY=
X-Google-Smtp-Source: AJdET5dL//dEHBhyvg2c1DqahTLAf3T0M9zCePx2MdJHyQlBxIv2UtCq4N8DHkCYjdgoHLc2XqJQww==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr847545lfc.124.1542193433490;
        Wed, 14 Nov 2018 03:03:53 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.82.138])
        by smtp.gmail.com with ESMTPSA id m21sm3513609lfl.97.2018.11.14.03.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 03:03:52 -0800 (PST)
Subject: Re: [PATCH v3] net: phy: mdio-gpio: Fix working over slow can_sleep
 GPIOs
To:     Martin Schiller <ms@dev.tdt.de>, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181114101236.10398-1-ms@dev.tdt.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <6c22e59d-b108-0df0-548b-6590b8775f61@cogentembedded.com>
Date:   Wed, 14 Nov 2018 14:03:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181114101236.10398-1-ms@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2018 01:12 PM, Martin Schiller wrote:

> This commit re-enables support for slow GPIO pins. It was initially
> introduced by commit 2d6c9091ab76 ("net: mdio-gpio: support access that
> may sleep") and got lost by commit 7e5fbd1e0700 ("net: mdio-gpio:
> Convert to use gpiod functions where possible").
> 
> Also add a warning about slow GPIO pins like it is done in i2c-gpio.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
> v3:
>  - modified commit summary
>  - fixed commit cites in commit message
>  - fixed line continuation
>  
> v2:
>  - fixed copy/paste bug in warning about slow GPIO pins
> ---
>  drivers/net/phy/mdio-gpio.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
> index 33265747bf39..e1c305089172 100644
> --- a/drivers/net/phy/mdio-gpio.c
> +++ b/drivers/net/phy/mdio-gpio.c
[...]
> @@ -162,6 +162,11 @@ static int mdio_gpio_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (gpiod_cansleep(bitbang->mdc) || gpiod_cansleep(bitbang->mdio) ||
> +	    gpiod_cansleep(bitbang->mdo))
> +		dev_warn(&pdev->dev, "Slow GPIO pins might wreak havoc into"
> +				     "MDIO bus timing");

   Oops, missed this in the 1st review: you don't need to break the kernel messages
like that, they may violate the 80-column limit (to facilitate searching)...

[...]

MBR, Sergei
