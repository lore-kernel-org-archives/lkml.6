Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB83C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34965208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wIjVJBSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34965208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964847AbeFRMB0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:01:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeFRMBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=faQo74HFaSSA9s7p3e5L1xY8FLwgvAYJJSCtJrbZUzg=; b=wIjVJBSRNvwr
        /hoGbgEyMaS+eiU/EOuRYlLO0haugYVIMX7nzyz4iiPKNm7Uoa4Wlhhp9xaRrjB8xa6h0x5xlqvDX
        p2qSSLeFerOFb/NF2F6cGX3YlaKfyopMCL52bBSUpxDFbAGx1ykbxHglZIk/OMkTXXAafiCMZBJ4C
        zBYPw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsqU-00081P-FE; Mon, 18 Jun 2018 12:01:18 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsqU-0000e4-1S; Mon, 18 Jun 2018 13:01:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: remove unused adi_spi3.h header" to the spi tree
In-Reply-To:  <1528400432-29612-1-git-send-email-clabbe@baylibre.com>
Message-Id: <E1fUsqU-0000e4-1S@debutante>
Date:   Mon, 18 Jun 2018 13:01:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: remove unused adi_spi3.h header

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 3e247b0fb540a9a503a71ef6b918a3443e49655f Mon Sep 17 00:00:00 2001
From: Corentin Labbe <clabbe@baylibre.com>
Date: Thu, 7 Jun 2018 19:40:32 +0000
Subject: [PATCH] spi: remove unused adi_spi3.h header

include/linux/spi/adi_spi3.h is unused since commit 47838669de9d ("spi: remove blackfin related host drivers")
Finish the cleaning by removing it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/adi_spi3.h | 254 -----------------------------------
 1 file changed, 254 deletions(-)
 delete mode 100644 include/linux/spi/adi_spi3.h

diff --git a/include/linux/spi/adi_spi3.h b/include/linux/spi/adi_spi3.h
deleted file mode 100644
index c84123aa1d06..000000000000
--- a/include/linux/spi/adi_spi3.h
+++ /dev/null
@@ -1,254 +0,0 @@
-/*
- * Analog Devices SPI3 controller driver
- *
- * Copyright (c) 2014 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _ADI_SPI3_H_
-#define _ADI_SPI3_H_
-
-#include <linux/types.h>
-
-/* SPI_CONTROL */
-#define SPI_CTL_EN                  0x00000001    /* Enable */
-#define SPI_CTL_MSTR                0x00000002    /* Master/Slave */
-#define SPI_CTL_PSSE                0x00000004    /* controls modf error in master mode */
-#define SPI_CTL_ODM                 0x00000008    /* Open Drain Mode */
-#define SPI_CTL_CPHA                0x00000010    /* Clock Phase */
-#define SPI_CTL_CPOL                0x00000020    /* Clock Polarity */
-#define SPI_CTL_ASSEL               0x00000040    /* Slave Select Pin Control */
-#define SPI_CTL_SELST               0x00000080    /* Slave Select Polarity in-between transfers */
-#define SPI_CTL_EMISO               0x00000100    /* Enable MISO */
-#define SPI_CTL_SIZE                0x00000600    /* Word Transfer Size */
-#define SPI_CTL_SIZE08              0x00000000    /* SIZE: 8 bits */
-#define SPI_CTL_SIZE16              0x00000200    /* SIZE: 16 bits */
-#define SPI_CTL_SIZE32              0x00000400    /* SIZE: 32 bits */
-#define SPI_CTL_LSBF                0x00001000    /* LSB First */
-#define SPI_CTL_FCEN                0x00002000    /* Flow-Control Enable */
-#define SPI_CTL_FCCH                0x00004000    /* Flow-Control Channel Selection */
-#define SPI_CTL_FCPL                0x00008000    /* Flow-Control Polarity */
-#define SPI_CTL_FCWM                0x00030000    /* Flow-Control Water-Mark */
-#define SPI_CTL_FIFO0               0x00000000    /* FCWM: TFIFO empty or RFIFO Full */
-#define SPI_CTL_FIFO1               0x00010000    /* FCWM: TFIFO 75% or more empty or RFIFO 75% or more full */
-#define SPI_CTL_FIFO2               0x00020000    /* FCWM: TFIFO 50% or more empty or RFIFO 50% or more full */
-#define SPI_CTL_FMODE               0x00040000    /* Fast-mode Enable */
-#define SPI_CTL_MIOM                0x00300000    /* Multiple I/O Mode */
-#define SPI_CTL_MIO_DIS             0x00000000    /* MIOM: Disable */
-#define SPI_CTL_MIO_DUAL            0x00100000    /* MIOM: Enable DIOM (Dual I/O Mode) */
-#define SPI_CTL_MIO_QUAD            0x00200000    /* MIOM: Enable QUAD (Quad SPI Mode) */
-#define SPI_CTL_SOSI                0x00400000    /* Start on MOSI */
-/* SPI_RX_CONTROL */
-#define SPI_RXCTL_REN               0x00000001    /* Receive Channel Enable */
-#define SPI_RXCTL_RTI               0x00000004    /* Receive Transfer Initiate */
-#define SPI_RXCTL_RWCEN             0x00000008    /* Receive Word Counter Enable */
-#define SPI_RXCTL_RDR               0x00000070    /* Receive Data Request */
-#define SPI_RXCTL_RDR_DIS           0x00000000    /* RDR: Disabled */
-#define SPI_RXCTL_RDR_NE            0x00000010    /* RDR: RFIFO not empty */
-#define SPI_RXCTL_RDR_25            0x00000020    /* RDR: RFIFO 25% full */
-#define SPI_RXCTL_RDR_50            0x00000030    /* RDR: RFIFO 50% full */
-#define SPI_RXCTL_RDR_75            0x00000040    /* RDR: RFIFO 75% full */
-#define SPI_RXCTL_RDR_FULL          0x00000050    /* RDR: RFIFO full */
-#define SPI_RXCTL_RDO               0x00000100    /* Receive Data Over-Run */
-#define SPI_RXCTL_RRWM              0x00003000    /* FIFO Regular Water-Mark */
-#define SPI_RXCTL_RWM_0             0x00000000    /* RRWM: RFIFO Empty */
-#define SPI_RXCTL_RWM_25            0x00001000    /* RRWM: RFIFO 25% full */
-#define SPI_RXCTL_RWM_50            0x00002000    /* RRWM: RFIFO 50% full */
-#define SPI_RXCTL_RWM_75            0x00003000    /* RRWM: RFIFO 75% full */
-#define SPI_RXCTL_RUWM              0x00070000    /* FIFO Urgent Water-Mark */
-#define SPI_RXCTL_UWM_DIS           0x00000000    /* RUWM: Disabled */
-#define SPI_RXCTL_UWM_25            0x00010000    /* RUWM: RFIFO 25% full */
-#define SPI_RXCTL_UWM_50            0x00020000    /* RUWM: RFIFO 50% full */
-#define SPI_RXCTL_UWM_75            0x00030000    /* RUWM: RFIFO 75% full */
-#define SPI_RXCTL_UWM_FULL          0x00040000    /* RUWM: RFIFO full */
-/* SPI_TX_CONTROL */
-#define SPI_TXCTL_TEN               0x00000001    /* Transmit Channel Enable */
-#define SPI_TXCTL_TTI               0x00000004    /* Transmit Transfer Initiate */
-#define SPI_TXCTL_TWCEN             0x00000008    /* Transmit Word Counter Enable */
-#define SPI_TXCTL_TDR               0x00000070    /* Transmit Data Request */
-#define SPI_TXCTL_TDR_DIS           0x00000000    /* TDR: Disabled */
-#define SPI_TXCTL_TDR_NF            0x00000010    /* TDR: TFIFO not full */
-#define SPI_TXCTL_TDR_25            0x00000020    /* TDR: TFIFO 25% empty */
-#define SPI_TXCTL_TDR_50            0x00000030    /* TDR: TFIFO 50% empty */
-#define SPI_TXCTL_TDR_75            0x00000040    /* TDR: TFIFO 75% empty */
-#define SPI_TXCTL_TDR_EMPTY         0x00000050    /* TDR: TFIFO empty */
-#define SPI_TXCTL_TDU               0x00000100    /* Transmit Data Under-Run */
-#define SPI_TXCTL_TRWM              0x00003000    /* FIFO Regular Water-Mark */
-#define SPI_TXCTL_RWM_FULL          0x00000000    /* TRWM: TFIFO full */
-#define SPI_TXCTL_RWM_25            0x00001000    /* TRWM: TFIFO 25% empty */
-#define SPI_TXCTL_RWM_50            0x00002000    /* TRWM: TFIFO 50% empty */
-#define SPI_TXCTL_RWM_75            0x00003000    /* TRWM: TFIFO 75% empty */
-#define SPI_TXCTL_TUWM              0x00070000    /* FIFO Urgent Water-Mark */
-#define SPI_TXCTL_UWM_DIS           0x00000000    /* TUWM: Disabled */
-#define SPI_TXCTL_UWM_25            0x00010000    /* TUWM: TFIFO 25% empty */
-#define SPI_TXCTL_UWM_50            0x00020000    /* TUWM: TFIFO 50% empty */
-#define SPI_TXCTL_UWM_75            0x00030000    /* TUWM: TFIFO 75% empty */
-#define SPI_TXCTL_UWM_EMPTY         0x00040000    /* TUWM: TFIFO empty */
-/* SPI_CLOCK */
-#define SPI_CLK_BAUD                0x0000FFFF    /* Baud Rate */
-/* SPI_DELAY */
-#define SPI_DLY_STOP                0x000000FF    /* Transfer delay time in multiples of SCK period */
-#define SPI_DLY_LEADX               0x00000100    /* Extended (1 SCK) LEAD Control */
-#define SPI_DLY_LAGX                0x00000200    /* Extended (1 SCK) LAG control */
-/* SPI_SSEL */
-#define SPI_SLVSEL_SSE1             0x00000002    /* SPISSEL1 Enable */
-#define SPI_SLVSEL_SSE2             0x00000004    /* SPISSEL2 Enable */
-#define SPI_SLVSEL_SSE3             0x00000008    /* SPISSEL3 Enable */
-#define SPI_SLVSEL_SSE4             0x00000010    /* SPISSEL4 Enable */
-#define SPI_SLVSEL_SSE5             0x00000020    /* SPISSEL5 Enable */
-#define SPI_SLVSEL_SSE6             0x00000040    /* SPISSEL6 Enable */
-#define SPI_SLVSEL_SSE7             0x00000080    /* SPISSEL7 Enable */
-#define SPI_SLVSEL_SSEL1            0x00000200    /* SPISSEL1 Value */
-#define SPI_SLVSEL_SSEL2            0x00000400    /* SPISSEL2 Value */
-#define SPI_SLVSEL_SSEL3            0x00000800    /* SPISSEL3 Value */
-#define SPI_SLVSEL_SSEL4            0x00001000    /* SPISSEL4 Value */
-#define SPI_SLVSEL_SSEL5            0x00002000    /* SPISSEL5 Value */
-#define SPI_SLVSEL_SSEL6            0x00004000    /* SPISSEL6 Value */
-#define SPI_SLVSEL_SSEL7            0x00008000    /* SPISSEL7 Value */
-/* SPI_RWC */
-#define SPI_RWC_VALUE               0x0000FFFF    /* Received Word-Count */
-/* SPI_RWCR */
-#define SPI_RWCR_VALUE              0x0000FFFF    /* Received Word-Count Reload */
-/* SPI_TWC */
-#define SPI_TWC_VALUE               0x0000FFFF    /* Transmitted Word-Count */
-/* SPI_TWCR */
-#define SPI_TWCR_VALUE              0x0000FFFF    /* Transmitted Word-Count Reload */
-/* SPI_IMASK */
-#define SPI_IMSK_RUWM               0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_TUWM               0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_ROM                0x00000010    /* Receive Over-Run Error Interrupt Mask */
-#define SPI_IMSK_TUM                0x00000020    /* Transmit Under-Run Error Interrupt Mask */
-#define SPI_IMSK_TCM                0x00000040    /* Transmit Collision Error Interrupt Mask */
-#define SPI_IMSK_MFM                0x00000080    /* Mode Fault Error Interrupt Mask */
-#define SPI_IMSK_RSM                0x00000100    /* Receive Start Interrupt Mask */
-#define SPI_IMSK_TSM                0x00000200    /* Transmit Start Interrupt Mask */
-#define SPI_IMSK_RFM                0x00000400    /* Receive Finish Interrupt Mask */
-#define SPI_IMSK_TFM                0x00000800    /* Transmit Finish Interrupt Mask */
-/* SPI_IMASKCL */
-#define SPI_IMSK_CLR_RUW            0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_CLR_TUWM           0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_CLR_ROM            0x00000010    /* Receive Over-Run Error Interrupt Mask */
-#define SPI_IMSK_CLR_TUM            0x00000020    /* Transmit Under-Run Error Interrupt Mask */
-#define SPI_IMSK_CLR_TCM            0x00000040    /* Transmit Collision Error Interrupt Mask */
-#define SPI_IMSK_CLR_MFM            0x00000080    /* Mode Fault Error Interrupt Mask */
-#define SPI_IMSK_CLR_RSM            0x00000100    /* Receive Start Interrupt Mask */
-#define SPI_IMSK_CLR_TSM            0x00000200    /* Transmit Start Interrupt Mask */
-#define SPI_IMSK_CLR_RFM            0x00000400    /* Receive Finish Interrupt Mask */
-#define SPI_IMSK_CLR_TFM            0x00000800    /* Transmit Finish Interrupt Mask */
-/* SPI_IMASKST */
-#define SPI_IMSK_SET_RUWM           0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_SET_TUWM           0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_SET_ROM            0x00000010    /* Receive Over-Run Error Interrupt Mask */
-#define SPI_IMSK_SET_TUM            0x00000020    /* Transmit Under-Run Error Interrupt Mask */
-#define SPI_IMSK_SET_TCM            0x00000040    /* Transmit Collision Error Interrupt Mask */
-#define SPI_IMSK_SET_MFM            0x00000080    /* Mode Fault Error Interrupt Mask */
-#define SPI_IMSK_SET_RSM            0x00000100    /* Receive Start Interrupt Mask */
-#define SPI_IMSK_SET_TSM            0x00000200    /* Transmit Start Interrupt Mask */
-#define SPI_IMSK_SET_RFM            0x00000400    /* Receive Finish Interrupt Mask */
-#define SPI_IMSK_SET_TFM            0x00000800    /* Transmit Finish Interrupt Mask */
-/* SPI_STATUS */
-#define SPI_STAT_SPIF               0x00000001    /* SPI Finished */
-#define SPI_STAT_RUWM               0x00000002    /* Receive Urgent Water-Mark Breached */
-#define SPI_STAT_TUWM               0x00000004    /* Transmit Urgent Water-Mark Breached */
-#define SPI_STAT_ROE                0x00000010    /* Receive Over-Run Error Indication */
-#define SPI_STAT_TUE                0x00000020    /* Transmit Under-Run Error Indication */
-#define SPI_STAT_TCE                0x00000040    /* Transmit Collision Error Indication */
-#define SPI_STAT_MODF               0x00000080    /* Mode Fault Error Indication */
-#define SPI_STAT_RS                 0x00000100    /* Receive Start Indication */
-#define SPI_STAT_TS                 0x00000200    /* Transmit Start Indication */
-#define SPI_STAT_RF                 0x00000400    /* Receive Finish Indication */
-#define SPI_STAT_TF                 0x00000800    /* Transmit Finish Indication */
-#define SPI_STAT_RFS                0x00007000    /* SPI_RFIFO status */
-#define SPI_STAT_RFIFO_EMPTY        0x00000000    /* RFS: RFIFO Empty */
-#define SPI_STAT_RFIFO_25           0x00001000    /* RFS: RFIFO 25% Full */
-#define SPI_STAT_RFIFO_50           0x00002000    /* RFS: RFIFO 50% Full */
-#define SPI_STAT_RFIFO_75           0x00003000    /* RFS: RFIFO 75% Full */
-#define SPI_STAT_RFIFO_FULL         0x00004000    /* RFS: RFIFO Full */
-#define SPI_STAT_TFS                0x00070000    /* SPI_TFIFO status */
-#define SPI_STAT_TFIFO_FULL         0x00000000    /* TFS: TFIFO full */
-#define SPI_STAT_TFIFO_25           0x00010000    /* TFS: TFIFO 25% empty */
-#define SPI_STAT_TFIFO_50           0x00020000    /* TFS: TFIFO 50% empty */
-#define SPI_STAT_TFIFO_75           0x00030000    /* TFS: TFIFO 75% empty */
-#define SPI_STAT_TFIFO_EMPTY        0x00040000    /* TFS: TFIFO empty */
-#define SPI_STAT_FCS                0x00100000    /* Flow-Control Stall Indication */
-#define SPI_STAT_RFE                0x00400000    /* SPI_RFIFO Empty */
-#define SPI_STAT_TFF                0x00800000    /* SPI_TFIFO Full */
-/* SPI_ILAT */
-#define SPI_ILAT_RUWMI              0x00000002    /* Receive Urgent Water Mark Interrupt */
-#define SPI_ILAT_TUWMI              0x00000004    /* Transmit Urgent Water Mark Interrupt */
-#define SPI_ILAT_ROI                0x00000010    /* Receive Over-Run Error Indication */
-#define SPI_ILAT_TUI                0x00000020    /* Transmit Under-Run Error Indication */
-#define SPI_ILAT_TCI                0x00000040    /* Transmit Collision Error Indication */
-#define SPI_ILAT_MFI                0x00000080    /* Mode Fault Error Indication */
-#define SPI_ILAT_RSI                0x00000100    /* Receive Start Indication */
-#define SPI_ILAT_TSI                0x00000200    /* Transmit Start Indication */
-#define SPI_ILAT_RFI                0x00000400    /* Receive Finish Indication */
-#define SPI_ILAT_TFI                0x00000800    /* Transmit Finish Indication */
-/* SPI_ILATCL */
-#define SPI_ILAT_CLR_RUWMI          0x00000002    /* Receive Urgent Water Mark Interrupt */
-#define SPI_ILAT_CLR_TUWMI          0x00000004    /* Transmit Urgent Water Mark Interrupt */
-#define SPI_ILAT_CLR_ROI            0x00000010    /* Receive Over-Run Error Indication */
-#define SPI_ILAT_CLR_TUI            0x00000020    /* Transmit Under-Run Error Indication */
-#define SPI_ILAT_CLR_TCI            0x00000040    /* Transmit Collision Error Indication */
-#define SPI_ILAT_CLR_MFI            0x00000080    /* Mode Fault Error Indication */
-#define SPI_ILAT_CLR_RSI            0x00000100    /* Receive Start Indication */
-#define SPI_ILAT_CLR_TSI            0x00000200    /* Transmit Start Indication */
-#define SPI_ILAT_CLR_RFI            0x00000400    /* Receive Finish Indication */
-#define SPI_ILAT_CLR_TFI            0x00000800    /* Transmit Finish Indication */
-
-/*
- * adi spi3 registers layout
- */
-struct adi_spi_regs {
-	u32 revid;
-	u32 control;
-	u32 rx_control;
-	u32 tx_control;
-	u32 clock;
-	u32 delay;
-	u32 ssel;
-	u32 rwc;
-	u32 rwcr;
-	u32 twc;
-	u32 twcr;
-	u32 reserved0;
-	u32 emask;
-	u32 emaskcl;
-	u32 emaskst;
-	u32 reserved1;
-	u32 status;
-	u32 elat;
-	u32 elatcl;
-	u32 reserved2;
-	u32 rfifo;
-	u32 reserved3;
-	u32 tfifo;
-};
-
-#define MAX_CTRL_CS          8  /* cs in spi controller */
-
-/* device.platform_data for SSP controller devices */
-struct adi_spi3_master {
-	u16 num_chipselect;
-	u16 pin_req[7];
-};
-
-/* spi_board_info.controller_data for SPI slave devices,
- * copied to spi_device.platform_data ... mostly for dma tuning
- */
-struct adi_spi3_chip {
-	u32 control;
-	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
-	u32 tx_dummy_val; /* tx value for rx only transfer */
-	bool enable_dma;
-};
-
-#endif /* _ADI_SPI3_H_ */
-- 
2.17.1

