Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D144C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41AF2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547912541;
	bh=mSOK+5vCBQoqvx/N69fr27yhahTN2A0lMMtC837TB74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=cd+XR09a1NE93NKTWqEpjKCN3I5F/F6Ks0WsRwBNY6a6eUCAxMeTWUBXKD7BN7zrx
	 opFf/ojEArFPs3ajKd1lsHEuGYB6QwPBGJAyd2N3rR5upahIYzjd/YcOmc5nxIHGxh
	 WJ9rBGk982UwXnfZkfp6JULqw/Pd7a/ebZnvEaKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbfASPmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfASPmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:42:15 -0500
Received: from localhost.localdomain (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FBE2087E;
        Sat, 19 Jan 2019 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547912534;
        bh=mSOK+5vCBQoqvx/N69fr27yhahTN2A0lMMtC837TB74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=KRmFIrMudRrFkHS1BipcOr8BMxamj66SrCuvIHDlLNG8avtAd8opCEiHJckq5caUR
         FzlslG/h+t1KF5XhuiHJiDCjjJ1lyDief6+e1LwfNwth8i4JUfb6OeRDsM+TsgCoMZ
         uiSl/cwACBKKNOem6O669CLqO75unMBgpUtYZctU=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v7,2/5] mtd: spi-nor: add octal read flag for flash mt35xu512aba
Date:   Sat, 19 Jan 2019 16:42:04 +0100
Message-Id: <20190119154204.3518-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 2bda2f811b36cb7e569ca384e2dfcf74740a8279
In-Reply-To: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 10:05:16 UTC, Yogesh Narayan Gaur wrote:
> Add octal read flag for flash mt35xu512aba.
> This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
> not seem to support newer JESD216C standard that provides auto
> detection of Octal mode capabilities and opcodes. Therefore, this
> capability is manually added using new SPI_NOR_OCTAL_READ flag.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
