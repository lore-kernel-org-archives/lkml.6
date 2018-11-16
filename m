Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B950B2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B950B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeKQJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:13:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36440 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:13:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id r127-v6so20981138oie.3;
        Fri, 16 Nov 2018 14:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=lLYD7x1gopXwfD19Pcx/3KKoWGivk1ZGWwuOAml6e/4=;
        b=rrhjXExlbpK1Ga0nQV+YIfbkY27HDAmMaNw4BIFYlr4qlaqHbZmIg/y/UmHAYhw/PM
         wXcqB4tt9IyIc8gr0j6wXUdDGYJxcvGWiInrLQPbk2SBBuSoEPhh2M3sfqLs6UrQu0Pw
         G1UV2ZAOknoMdwBL6ZMEoAsJwqh+pJ9l7Whr3VNSNy3KrUC6YOAZZU/8pcJ5PIsyP7NV
         lFVyzq84jp59wDkeQFSVuDm7XvyLIMVeR17D/hbivoaeeA9eW413lZlI6nnd89G3r4vc
         1Ff4AwitBZWJ3oG7JkhXne6mobkqldgqlF1ZgNo31lAFFbx1lin6uOGS7F4Y1ugXre6K
         JbYw==
X-Gm-Message-State: AGRZ1gK4LuDzwJKiscLo5xHDLgO4uY2vvTcXe5rmeQm03P8PM809PZPv
        cK2IySdVcQYoPxe1914O4w==
X-Google-Smtp-Source: AJdET5fK0sjylaKTxuGGjQ25yQRS2d8uBkLnIAOFq9LRiP5feACffFvhSYxu1uQn5ohtahQE6pRk0w==
X-Received: by 2002:aca:5e84:: with SMTP id s126-v6mr1966898oib.115.1542409166338;
        Fri, 16 Nov 2018 14:59:26 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id a201sm9531337oii.27.2018.11.16.14.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 14:59:25 -0800 (PST)
Message-ID: <5bef4bcd.1c69fb81.20780.023d@mx.google.com>
Date:   Fri, 16 Nov 2018 16:59:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
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
Subject: Re: [PATCH v5 4/9] dt-bindings: spi: Move the bindings for the FSL
 QSPI  driver
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-5-git-send-email-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542116782-13118-5-git-send-email-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:47:34 +0000, Schrempf Frieder wrote:
> Move the documentation of the old SPI NOR driver to the place of the new
> SPI memory interface based driver.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../bindings/{mtd/fsl-quadspi.txt => spi/spi-fsl-qspi.txt}           | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

