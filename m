Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B7C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4048120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4048120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbeIMSuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:50:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:50:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35FD4D19;
        Thu, 13 Sep 2018 13:40:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 4.9 65/78] Revert "ARM: imx_v6_v7_defconfig: Select ULPI support"
Date:   Thu, 13 Sep 2018 15:31:52 +0200
Message-Id: <20180913131812.226030405@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

This reverts commit 721476147fd2571309b6aa6daa695b39170602ef.

This commit causes reboot to fail on imx6 wandboard, so let's
revert it.

Cc: <stable@vger.kernel.org> #4.9
Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -271,7 +271,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -308,7 +307,6 @@ CONFIG_USB_GADGETFS=m
 CONFIG_USB_FUNCTIONFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
-CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y


