Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B775DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B02B20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B02B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbeHWMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeHWMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:38 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 28ADFC74;
        Thu, 23 Aug 2018 08:52:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 174/324] ARM: imx_v6_v7_defconfig: Select ULPI support
Date:   Thu, 23 Aug 2018 09:54:00 +0200
Message-Id: <20180823075004.914264842@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 157bcc06094c3c5800d3f4676527047b79b618e7 ]

Select CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS so that
USB ULPI can be functional on some boards like imx51-babbge.

This fixes a kernel hang in 4.18-rc1 on i.mx51-babbage, caused by commit
03e6275ae381 ("usb: chipidea: Fix ULPI on imx51").

Suggested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -294,6 +294,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -330,6 +331,7 @@ CONFIG_USB_GADGETFS=m
 CONFIG_USB_FUNCTIONFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
+CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y


