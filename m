Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB6EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF0206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550953781;
	bh=R3k2D3NZRTblDzylVeOIFiXsy0ImTaxs2gXWHcb7OCk=;
	h=From:To:Subject:Date:List-ID:From;
	b=HXpzoYGqAl47pOThzf4LhKqUTB8U3RYTOdgUjnZWSv5dlY9qc5s/TFl3k34MTIMHx
	 rtepjXm8PXELgoK3S7Pf/4bGlvxrh3LACInbK2SzFEgtJTCBtw3Fj+ndqIYmPjc0mO
	 wzuJUJcQX+c03ICw/g6sYkDscQLjnlwA7QI8zPeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfBWU3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfBWU3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 15:29:39 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E5D0206A3;
        Sat, 23 Feb 2019 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550953778;
        bh=R3k2D3NZRTblDzylVeOIFiXsy0ImTaxs2gXWHcb7OCk=;
        h=From:To:Subject:Date:From;
        b=sS6o5q2Rqc+ljjiSqR2IwLSGKsbBdVX5gr2EnFC7wJCMrDZbEH5913XOLFg4pKmza
         h1R0EtMTA0UIuD+DAEdmA5fGEdjaVbUi+9HW594mIVmqsgJgs6/TB4/sZnUbf2DA5g
         Knhy/+bvksz4dWjhZnH2kBtAfNfeKiN50sNxs7vk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Enable ADC on Arndale Octa
Date:   Sat, 23 Feb 2019 21:29:32 +0100
Message-Id: <20190223202932.630-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arndale Octa (Exynos5420) has two ADC pins (AIN0 and AIN1) exposed on
CON6 header pins.  Add ADC node to DTS file to enable it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 6b4bf5ee2e45..6f5e6e2fde22 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -51,6 +51,11 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo4_reg>;
+	status = "okay";
+};
+
 &cci {
 	status = "disabled";
 };
-- 
2.17.1

