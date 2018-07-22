Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10B9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603E420874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603E420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeGVRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:16 -0400
Received: from mout.perfora.net ([74.208.4.194]:60549 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbeGVRrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:16 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LwYMD-1g55ep0y8V-018Ke0; Sun, 22 Jul 2018 18:49:52 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 04/28] ARM: tegra: apalis_t30: add local-mac-address property
Date:   Sun, 22 Jul 2018 18:49:12 +0200
Message-Id: <20180722164936.20581-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:rTavSNhGNC4xL371PjuAwXeeU5qh8Zo02BYXEPKIOIwb+P0eyti
 siBiMM6xJ5fl0Ilpb5xjQG/3I33rmhQcSNzn0WASGMiMOHLAXvWqff/UBq1cdsGSBIIxPrD
 eQNRlMIeVOZ9jGi9gM6dweGZONywKT/UTClopfd+8YflPPx89V6gGrnAqMBV4W9nrFWrSmx
 dwsf+GV3GFokR/2spoEQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QEus4Pc0otU=:MfE04HEX/RyN6I72QZMY+h
 BTUFgfSpctuyITyfgrjoq10yzjyuMNpVDTKY9vaYyhD2PSVNqI/9cwj3aWTo7Lq9TO3jHzRR/
 l4SN5i6QmCONfhAmfsdDusOX0i4B6344GMuU2VMJxI5d4ljLxvwxXPqfloEdipMDZZ3Cw/9JJ
 O2FT5Q09NulOO5PKirPWCldhPIJHQqGsf2AGddpY8KiaXO/9vNG21J6QgciF6kq4YEd0Zg+TK
 RTHXea8fJPcZX5P4ePCxkRWXSqNxJyypYwFNx9IeB1ypeYYmj6T1u2xj1Cj5TpwwE28oLxWc6
 FEdLOHhI/QWIsRTm3u/wzt/g9L/j8/UGJedXVEPpni5DuY4E6h/2jrwGu0pdCP+fcsgibWSk4
 XYYpZSSk31iCpz77htlcEzPOuJs3PylDH8TmjJO+Dy5+X0C0oCDYY+R+mmEBwX64v+mIzzfGg
 8TptpFA5jzgIYJL2rV4kQUY79kDbuAmiL79nuBiECZ9xAYRdldhkqIurBBp56MfNan2AdvdmK
 4SrDN1HF2TCnt87jwy6T/8yF/iwvSL5BFO2GJCpnArp+qgsAY01ppil7zlnpgADme/69VM1fL
 PjL6HM7XieokhJ6rH5yru+HgdzAnt8rhWWbSZaG+ddmerj8l1+LgbCXp36ekgpIW0ESrMKFtL
 J/+hSiyVS55TFvnt40XjobodJj/bYd0ceugjDyxShykLjAiTqWiNBhuh6p2XAK9hqM4Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index f4dc7e77114f..98d702bc3718 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -34,6 +34,10 @@
 
 		pci@3,0 {
 			nvidia,num-lanes = <1>;
+			pcie@0 {
+				reg = <0 0 0 0 0>;
+				local-mac-address = [00 00 00 00 00 00];
+			};
 		};
 	};
 
-- 
2.14.4

