Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A352C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183E12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183E12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeKQJNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:13:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34674 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:13:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id h25so2658172oig.1;
        Fri, 16 Nov 2018 14:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=X/9fPxFg1g9vrx+jxfZhN5zRTWV0pLK46LaccVoPxLs=;
        b=nJtY9JZ7vllQlwCVKBmSJGc9F4Kvd+hCQgxoagHCdiQalhwnpNpmFCams9ZLJM/pV0
         M3SWneCsqLrff5fj3+qkqpmIBCjxhueJktTEoqt8+7bsRM//hXKTIBAErz7cnyyETIAD
         /jJJKuS1y2fOhvxGRmHMhB2WyLwTyj6VhiWiiDgJFitrqfsWSGVZ0am/kaCi+wR6yw3e
         z9w7oc15kvD/czu4EjZWvP7fyyGTLWGyWJikQdQ6ec2pXFDYAAg8Jg0NfkEBVt/GY1c/
         rn89SLme7u3AD/oijQnsFKFW0QhG2gUcjsFD+JECpqkv7Qz2tOHSWWfOcZ7pjc0RqS06
         zDqw==
X-Gm-Message-State: AGRZ1gLAo/CXdD0s9/1T3AMXK3cYeivk1Lf5JKVa+QZ69FGz8y9K1GLd
        rfDXojPDDfle3N6IBXMopg==
X-Google-Smtp-Source: AJdET5fvK0w/tPHVtewU0yqYTY9m3kqk1Xrt8heC59MjJRwLJYxSJWlsVkdfsWzDG727PVOtP3JeqQ==
X-Received: by 2002:aca:e514:: with SMTP id c20-v6mr2143076oih.75.1542409168651;
        Fri, 16 Nov 2018 14:59:28 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id f37sm1959147otd.15.2018.11.16.14.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 14:59:27 -0800 (PST)
Message-ID: <5bef4bcf.1c69fb81.39c0b.e18d@mx.google.com>
Date:   Fri, 16 Nov 2018 16:59:26 -0600
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 5/9] dt-bindings: spi: Adjust the bindings for the FSL QSPI  driver
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de> <1542116782-13118-6-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1542116782-13118-6-git-send-email-frieder.schrempf@kontron.de>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:47:37 +0000, Schrempf Frieder wrote:
> Adjust the documentation of the new SPI memory interface based
> driver to reflect the new drivers settings.
> 
> The "old" driver was using the "fsl,qspi-has-second-chip" property to
> select one of two dual chip setups (two chips on one bus or two chips
> on separate buses). And it used the order in which the subnodes are
> defined in the dt to select the CS, the chip is connected to.
> 
> Both methods are wrong and in fact the "reg" property should be used to
> determine which bus and CS a chip is connected to. This also enables us
> to use different setups than just single chip, or symmetric dual chip.
> 
> So the porting of the driver from the MTD to the SPI framework actually
> enforces the use of the "reg" properties and makes
> "fsl,qspi-has-second-chip" superfluous.
> 
> As all boards that have "fsl,qspi-has-second-chip" set, also have
> correct "reg" properties, the removal of this property shouldn't lead to
> any incompatibilities.
> 
> The only compatibility issues I can see are with imx6sx-sdb.dts and
> imx6sx-sdb-reva.dts, which have their reg properties set incorrectly
> (see explanation here: [2]), all other boards should stay compatible.
> 
> Also the "big-endian" flag was removed, as this setting is now selected
> by the driver, depending on which SoC is in use.
> 
> [2] https://patchwork.ozlabs.org/patch/922817/#1925445
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../devicetree/bindings/spi/spi-fsl-qspi.txt      | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

