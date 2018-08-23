Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1DDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E27208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E27208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeHWL5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:57:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbeHWL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:57:22 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1412C74;
        Thu, 23 Aug 2018 08:28:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 104/217] ARM64: dts: meson-gxl: fix Mali GPU compatible string
Date:   Thu, 23 Aug 2018 09:53:37 +0200
Message-Id: <20180823075510.177007733@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 1c38f4afd5d40234b67635b3c608a4093be04b96 ]

meson-gxl-mali.dtsi is only used on GXL SoCs. Thus it should use the GXL
specific compatible string instead of the GXBB one.
For now this is purely cosmetic since the (out-of-tree) lima driver for
this GPU currently uses the "arm,mali-450" match instead of the SoC
specific one. However, update the .dts to match the documentation since
this driver behavior might change in the future.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
@@ -7,7 +7,7 @@
 
 &apb {
 	mali: gpu@c0000 {
-		compatible = "amlogic,meson-gxbb-mali", "arm,mali-450";
+		compatible = "amlogic,meson-gxl-mali", "arm,mali-450";
 		reg = <0x0 0xc0000 0x0 0x40000>;
 		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,


