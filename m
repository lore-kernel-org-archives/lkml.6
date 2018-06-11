Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vdGCDeSWHltwOQAAmS7hNA
	; Mon, 11 Jun 2018 15:36:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DB7D1607E7; Mon, 11 Jun 2018 15:36:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 78E46601C3;
	Mon, 11 Jun 2018 15:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78E46601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeFKPgr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:36:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55237 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932433AbeFKPgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:36:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 44B7420702; Mon, 11 Jun 2018 17:36:42 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 177DA20012;
        Mon, 11 Jun 2018 17:36:32 +0200 (CEST)
Date: Mon, 11 Jun 2018 17:36:32 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com,
        lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 3/6] mfd: at91-usart: added mfd driver for usart
Message-ID: <20180611153632.GG10521@piout.net>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
 <20180607110020.20565-4-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607110020.20565-4-radu.pirea@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 14:00:17+0300, Radu Pirea wrote:
> +static int at91_usart_mode_probe(struct platform_device *pdev)
> +{
> +	struct mfd_cell cell;
> +	u32 opmode;

This has to be initialized to AT91_USART_MODE_SERIAL...

> +	int err;
> +
> +	err = device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> +

because if the property is not present, then opmode will not be modified
which means it could hold the value of AT91_USART_MODE_SPI.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
