Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA729ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57921479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B57921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeJRDf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:35:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40866 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeJRDf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:35:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so22075960oib.7;
        Wed, 17 Oct 2018 12:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QfxozjRxrMFDm0Cw6qTg7R2ax/vBudPgWsAL85G/kkU=;
        b=YSFw2WqlYqbyNFkn1JTwfb7jiSjyT0wd+VlYvGmncXT3s5eH/YPd2PzCl/pyELj6WX
         AdipdQTsfaBhM79aSRmb/Dun0RZKaRpDyIW0rPtvYFF5Kqy/Ds4L8lOiUbidJ6UQG0Sl
         +Pd+uHq0kgoyrVfvjEHBP6WFqXT0z+lAdyzQ4HEdYZ1fD9x/45GBdJWQGDTOS2bITx5Z
         +ldgymqoOB8/VgkkExQoFExEbplwMquuOa7C9O3Y4PFr1B0nc2ELSvRrA4CUUBWSQ59l
         5d47kQC0jsj58KSQrz4Siecb6Wwg2qmM+MxYnlo1C4VyX9NxAlMvZj7WcSDtvogq+aMO
         JD9w==
X-Gm-Message-State: ABuFfojBKXtZIZUzkCA4FOx/9DJBZw+A3Ols1SoQHcCzJ9WxGVlFkyIO
        kAAqN4r7V7WOZ02kIn+OnQ==
X-Google-Smtp-Source: ACcGV61HZ20n2O4f10UqPutD/9C5bygChw2JYXGgGnsPIhoOKK2bWFgD1MOT0lTzNkSbzefsnmkePQ==
X-Received: by 2002:aca:aa4f:: with SMTP id t76-v6mr15199422oie.253.1539805093974;
        Wed, 17 Oct 2018 12:38:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v34sm6207238oti.78.2018.10.17.12.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:38:13 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:38:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
 bindings
Message-ID: <20181017193812.GA11939@bogus>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-4-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 07:22:48PM +0200, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> new file mode 100644
> index 000000000000..14385fee65d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> @@ -0,0 +1,24 @@
> +OLPC XO-1.75 Embedded Controller
> +
> +Required properties:
> +- compatible: Should be "olpc,xo1.75-ec".
> +- cmd-gpio: gpio specifier of the CMD pin

cmd-gpios

> +
> +The embedded controller requires the SPI controller driver to signal readiness
> +to receive a transfer (that is, when TX FIFO contains the response data) by
> +strobing the ACK pin with the ready signal. See the "ready-gpio" property of the

This will need updating based on the SPI binding.

> +SSP binding as documented in:
> +<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
> +
> +Example:
> +	&ssp3 {
> +		spi-slave;
> +		status = "okay";

Don't show status in examples.

> +		ready-gpio = <&gpio 125 GPIO_ACTIVE_HIGH>;
> +
> +		slave {
> +			compatible = "olpc,xo1.75-ec";
> +			spi-cpha;
> +			cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> -- 
> 2.19.0
> 
