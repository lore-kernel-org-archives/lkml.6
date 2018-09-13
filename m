Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD25DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A314020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A314020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeIMSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:44:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbeIMSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:44:14 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 07B80CF3;
        Thu, 13 Sep 2018 13:34:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 4.4 40/60] Revert "ARM: imx_v6_v7_defconfig: Select ULPI support"
Date:   Thu, 13 Sep 2018 15:30:47 +0200
Message-Id: <20180913131747.319525642@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

This reverts commit 0d0af17ae83d6feb29d676c72423461419df5110.

This commit causes reboot to fail on imx6 wandboard, so let's
revert it.

Cc: <stable@vger.kernel.org> #4.4
Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -261,7 +261,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -288,7 +287,6 @@ CONFIG_USB_G_NCM=m
 CONFIG_USB_GADGETFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
-CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y


