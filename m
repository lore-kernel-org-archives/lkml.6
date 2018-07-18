Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F66ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA41D20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA41D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeGRTGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:06:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36580 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeGRTGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:06:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E59A9207A8; Wed, 18 Jul 2018 20:27:31 +0200 (CEST)
Received: from dell-desktop.home (176-137-37-244.abo.bbox.fr [176.137.37.244])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4A5AA206A6;
        Wed, 18 Jul 2018 20:27:31 +0200 (CEST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mylene.josserand@bootlin.com, thomas.petazzoni@bootlin.com
Subject: [PATCH v3 0/3] sun8i-a83t: Add touchscreen support on TBS A711
Date:   Wed, 18 Jul 2018 20:27:16 +0200
Message-Id: <20180718182719.29663-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is a V3 of the patch series that adds touchscreen support
(FocalTech EDT-FT5x06 Polytouch) for TBS A711 (Allwinner sun8i-a83t SoC).
Based on last master of linux-input tree.

Since I can't test the suspend/resume functions there is no updates in
this series about factory/normal mode.

Changes since v2:
   - Remove the check if regulator is NULL (Dmitry Torokhov's review)
   - Add EPROBE_DEFER error not to print a error message (Lothar Waßmann's review)
   - Add set wake/reset on suspend/resume.
Changes since v1:
   - Remove patches 01 and 02 as Chen-Yu Tsai sent a similar patch:
   https://patchwork.kernel.org/patch/10111431/
   and it is merged on last next-20171222.
   (See commit f066f46ce5a5 "ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings")
   - Update regulator according to Dmitry Torokhov's review: remove "optional"
   suffix while retrieving the regulator, rename it into "vcc" instead of
   "power" and add bindings documentation.
   - Update device tree according to Maxime Ripard's review: remove the
   label and rename the node.
   - Squash patch 03 with patch 05 to add I2C0 and touchscreen's node
   in one patch (see patch 02).

Patch 01: Add support for regulator in the FocalTech touchscreen driver
because A711 tablet is using a regulator to power-up the touchscreen.
Patch 02: Add a set wake/reset values on resume and suspend.
Patch 03: Add i2c0 and touchscreen's node for A711 TBS tablet.

Thank you in advance for any review.
Best regards,
Mylène

Mylène Josserand (3):
  Input: edt-ft5x06 - Add support for regulator
  Input: edt-ft5x06 - Set wake/reset values on resume/suspend
  arm: dts: sun8i: a83t: a711: Add touchscreen node

 .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          | 16 +++++++++
 drivers/input/touchscreen/edt-ft5x06.c             | 41 ++++++++++++++++++++++
 3 files changed, 58 insertions(+)

-- 
2.11.0

