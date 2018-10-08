Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FC9204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpMKngTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FC9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbeJICBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA55204FD;
        Mon,  8 Oct 2018 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024519;
        bh=pxRMTiwMX0EUcUP5JZdm4Ald90D5VxkWr14+HASXsTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpMKngTrU4HSYdD1rFV8KoRGePayRZfTRDjjwWBh7HTV+pjJIH07rHHrxDMlEZ3c9
         F/Vmmt54xR92c+Hd64KvR0jw7xtYUHGRrcawFsCNwbfGawy+xgVjs1XqeYQ2qtwH0n
         jrnIoWDz5k9XBE7RJK/KZi7aKoTz3majgiXXAUJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 034/168] sh_eth: Add R7S9210 support
Date:   Mon,  8 Oct 2018 20:30:14 +0200
Message-Id: <20181008175621.343021806@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Brandt <chris.brandt@renesas.com>

[ Upstream commit 6e0bb04d0e4f597d8d8f4f21401a9636f2809fd1 ]

Add support for the R7S9210 which is part of the RZ/A2 series.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/net/sh_eth.txt |    1 
 drivers/net/ethernet/renesas/sh_eth.c            |   36 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

--- a/Documentation/devicetree/bindings/net/sh_eth.txt
+++ b/Documentation/devicetree/bindings/net/sh_eth.txt
@@ -16,6 +16,7 @@ Required properties:
 	      "renesas,ether-r8a7794"  if the device is a part of R8A7794 SoC.
 	      "renesas,gether-r8a77980" if the device is a part of R8A77980 SoC.
 	      "renesas,ether-r7s72100" if the device is a part of R7S72100 SoC.
+	      "renesas,ether-r7s9210" if the device is a part of R7S9210 SoC.
 	      "renesas,rcar-gen1-ether" for a generic R-Car Gen1 device.
 	      "renesas,rcar-gen2-ether" for a generic R-Car Gen2 or RZ/G1
 	                                device.
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -807,6 +807,41 @@ static struct sh_eth_cpu_data r8a77980_d
 	.magic		= 1,
 	.cexcr		= 1,
 };
+
+/* R7S9210 */
+static struct sh_eth_cpu_data r7s9210_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
+	.set_duplex	= sh_eth_set_duplex,
+	.set_rate	= sh_eth_set_rate_rcar,
+
+	.register_type	= SH_ETH_REG_FAST_SH4,
+
+	.edtrr_trns	= EDTRR_TRNS_ETHER,
+	.ecsr_value	= ECSR_ICD,
+	.ecsipr_value	= ECSIPR_ICDIP,
+	.eesipr_value	= EESIPR_TWBIP | EESIPR_TABTIP | EESIPR_RABTIP |
+			  EESIPR_RFCOFIP | EESIPR_ECIIP | EESIPR_FTCIP |
+			  EESIPR_TDEIP | EESIPR_TFUFIP | EESIPR_FRIP |
+			  EESIPR_RDEIP | EESIPR_RFOFIP | EESIPR_CNDIP |
+			  EESIPR_DLCIP | EESIPR_CDIP | EESIPR_TROIP |
+			  EESIPR_RMAFIP | EESIPR_RRFIP | EESIPR_RTLFIP |
+			  EESIPR_RTSFIP | EESIPR_PREIP | EESIPR_CERFIP,
+
+	.tx_check	= EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_TRO,
+	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE |
+			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE,
+
+	.fdr_value	= 0x0000070f,
+
+	.apr		= 1,
+	.mpr		= 1,
+	.tpauser	= 1,
+	.hw_swap	= 1,
+	.rpadir		= 1,
+	.no_ade		= 1,
+	.xdfar_rw	= 1,
+};
 #endif /* CONFIG_OF */
 
 static void sh_eth_set_rate_sh7724(struct net_device *ndev)
@@ -3131,6 +3166,7 @@ static const struct of_device_id sh_eth_
 	{ .compatible = "renesas,ether-r8a7794", .data = &rcar_gen2_data },
 	{ .compatible = "renesas,gether-r8a77980", .data = &r8a77980_data },
 	{ .compatible = "renesas,ether-r7s72100", .data = &r7s72100_data },
+	{ .compatible = "renesas,ether-r7s9210", .data = &r7s9210_data },
 	{ .compatible = "renesas,rcar-gen1-ether", .data = &rcar_gen1_data },
 	{ .compatible = "renesas,rcar-gen2-ether", .data = &rcar_gen2_data },
 	{ }


