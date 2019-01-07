Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8168D2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546878031;
	bh=nY5h4G6pGV6I5HY+Op6Ll6YyzBriIdVHFs90/S5/jVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uuWrlxsgFQ6fGPdlh5ze46VNaJXIKHkMVo/3GHX9hRr/dB2XkhDTdR0+xGXA4hhjM
	 A39DpuTDnff04MouJX+nm33XQkB/4exK/1Q01uZhlSQIYWgTYKGlSGDR95sn7h73Px
	 PFzg49J6Pa5sb0RNv68CWHQG0iUCo0CU4e7bEh6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfAGQUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:20:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfAGQU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:20:29 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2792147C;
        Mon,  7 Jan 2019 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546878028;
        bh=nY5h4G6pGV6I5HY+Op6Ll6YyzBriIdVHFs90/S5/jVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctD8tpbREV2OJYNq19cu4v3s+ugJle1gaf1mkFUq6fn05y03SeklPGp9akZfWi392
         pNe5At3atrFjruDg3Hcs6ST0FPWh/LcM91lNkvg2sOnlskSyIVbOXtN9y2kdC9HDjN
         gDgrRevARlO9R0kKh0M09XQV1Td2xGnfFRDU32IY=
Date:   Mon, 7 Jan 2019 17:20:03 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/7] mtd: fsl-quadspi: Remove the driver as it was
 replaced by spi-fsl-qspi.c
Message-ID: <20190107172003.1bca8a66@bbrezillon>
In-Reply-To: <20190107092823.11188-5-frieder.schrempf@kontron.de>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
        <20190107092823.11188-5-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 09:29:53 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> There's a new driver using the SPI memory interface of the SPI framework
> at spi/spi-fsl-qspi.c, which can be used together with m25p80.c to
> replace the functionality of this SPI NOR driver.
> 
> The new driver is already in use and this code is not compiled anymore,
> so let's remove it.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Acked-by: Han Xu <han.xu@nxp.com>
> Tested-by: Han Xu <han.xu@nxp.com>

Acked-by: Boris Brezillon <bbrezillon@kernel.org>
