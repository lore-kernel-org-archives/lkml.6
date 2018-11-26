Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF6EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75E820865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="ijvUyNCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75E820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeK0CWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:22:45 -0500
Received: from plaes.org ([188.166.43.21]:49978 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0CWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:42 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 6440E41BE1;
        Mon, 26 Nov 2018 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246094; bh=Am9rnwVkIRMruDgJGJutI3eHepJo6vST87U9/F3qG7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijvUyNCmU5cW+nEuAmw8BOCRuMCHoAmgP6YO0PQGbO350bjO528YhDYzAOZfw3jES
         zM5u7t1XXAL2Z2giEU0XfTzoBahEfxjZLt0J0RXbaVBXuP7eDtty+uc2i8Y1vcpkMx
         XFM9fwaYUiUmAWpEyQUB9Yrt/mlFzWiCQYil353USzL+fwHkr8NjZ4CSzlyyOHfWe8
         JwP5tHziDLiBqbNlF1LCXScLe0mLzMJFmYIgxf2BZbNgq0bH/6hssxsvGg+CSV6FEg
         6sfeq5Ul1VOOdghwtzShKuysy0/QVztGYC6RDtyFMhpIb3DuQCTHjRsrjHWxw3Xou6
         tWgUUiTjqk7Zw==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 08/14] regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
Date:   Mon, 26 Nov 2018 17:27:49 +0200
Message-Id: <3fd79fcb96c8ead9fa5a3a85a080caf00f186e36.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The OLinuXino Lime2 has a big capacitor on its LDO3 output. It is
actually too large, causing the PMIC to shutdown when toggling the LDO3.

By enabling soft-start and ramp delay we increase the time for the
capacitor to charge lowering the current drain on the power regulator.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index b828677..ffafe97 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -245,6 +245,8 @@
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
 	regulator-name = "vddio-csi0";
+	regulator-soft-start;
+	regulator-ramp-delay = <1600>;
 };
 
 &reg_ldo4 {
-- 
git-series 0.9.1
