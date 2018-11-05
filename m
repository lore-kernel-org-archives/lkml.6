Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7842081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7842081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbeKFGn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:43:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40286 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbeKFGn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:43:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so9450262otl.7;
        Mon, 05 Nov 2018 13:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3xGNp7VlfXlXI42yd6TZc2H2iSF2ep+K0O+kF8Ele+A=;
        b=miYRTKOTBCjR7PRGegyvOVyXczzY6GTE7FVTALf6R0P2RBbE8kZuEfUEtdub3ycEqr
         xK4gDoDysGNDmCJ36DzilGYptC7yIymd7GXc19xLUeHLMFO3TXuTgl1RJZ3hqio9UzW7
         UilgTKEIDElc3WPBTkzerlxSqqsifXeELiTSELGis5mWhAEvj2jEHufX7G8hCOqku84b
         X3z1cSU8LQVYZTtoDTxnQboSYtWpdVXZItbGVLWrgPU9YKVx6ECo5HYQI2TKlroviASk
         vOlkZ3WwXtvsOm+/Qh79tGcNwMy/OHRR0obfUt/O8iTehE8/fdcsX3ShBQbL12kLY2m/
         VLjQ==
X-Gm-Message-State: AGRZ1gLp++pMxgB4H4cScq9Lp8CU3AnEAwUetB6v1I99Zf2o8yZfzJW6
        dQQ0qJhO+AQh25V7uuB8tAlRUmU=
X-Google-Smtp-Source: AJdET5eDGi3fS24o1+CB1dqSZnw9OgyXMjhHvupIhGgRSnjZHkk5joc6cF+SHcPewcKEX+THmCDRpg==
X-Received: by 2002:a9d:2372:: with SMTP id k47mr8778673otd.261.1541452910170;
        Mon, 05 Nov 2018 13:21:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h54sm5303816otf.59.2018.11.05.13.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 13:21:49 -0800 (PST)
Date:   Mon, 5 Nov 2018 15:21:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
Message-ID: <20181105212148.GA13045@bogus>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
 <20181105103625.9644-7-bugalski.piotr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105103625.9644-7-bugalski.piotr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 11:36:25 +0100, Piotr Bugalski wrote:
> Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
> this change is just moving DT-binding documentation.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
> ---
>  Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
