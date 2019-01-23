Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37CCC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18172184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Pb/VTSN0";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Pb/VTSN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfAWPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:23:48 -0500
Received: from node.akkea.ca ([192.155.83.177]:52682 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfAWPXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:23:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id D43704E2050;
        Wed, 23 Jan 2019 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548257023; bh=AKnivERQKU1x5vC9EhfVn3Srj4A6L5LICNTbEtiPN3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Pb/VTSN0XG7T+AI9uVwwUXY9xX0hE8KEkmVCIvjJjkvNjZTf3IqeRKJE7+p8TGyKN
         tNYSmm+gKrADuyRgiPLBgRdBIpU6L7f+BqPZsa7rZhR+KkYlVaCEfgbwXUwIZmfZHV
         0tVSFQkST+UbRM8uFWgmwe0tfRSHbKf8f/yNMlkQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L1lW991LxVdu; Wed, 23 Jan 2019 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id B610D4E204B;
        Wed, 23 Jan 2019 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548257023; bh=AKnivERQKU1x5vC9EhfVn3Srj4A6L5LICNTbEtiPN3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Pb/VTSN0XG7T+AI9uVwwUXY9xX0hE8KEkmVCIvjJjkvNjZTf3IqeRKJE7+p8TGyKN
         tNYSmm+gKrADuyRgiPLBgRdBIpU6L7f+BqPZsa7rZhR+KkYlVaCEfgbwXUwIZmfZHV
         0tVSFQkST+UbRM8uFWgmwe0tfRSHbKf8f/yNMlkQ=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v3 0/5] dma: imx-sdma: add the sdma engine to the imx8mq
Date:   Wed, 23 Jan 2019 08:23:05 -0700
Message-Id: <20190123152310.11680-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdma support for the imx8mq

Changes since V2

Dropped device tree bindings and added clock ratio check.
Fixed bug where incorrect sdma device was selected.
Added new compatible string for "fsl,imx8mq-sdma"

Changes since V1

Fixed to build against v5.0-rc2

Angus Ainslie (Purism) (5):
  dma: imx-sdma: add clock ratio 1:1 check
  dma: imx-sdma: add imx8mq sdma compatible parts
  dt-bindings: dma: fsl-imx-sdma: add imx8mq compatible string
  dma: imx-sdma: add an index for imx8mq multi sdma devices
  imx8mq.dtsi: add the sdma nodes

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 31 +++++++++++++
 drivers/dma/imx-sdma.c                        | 45 +++++++++++++++++--
 include/linux/platform_data/dma-imx.h         |  1 +
 4 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.17.1

