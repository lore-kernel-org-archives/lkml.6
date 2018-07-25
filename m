Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B2CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0705620671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0705620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeGYIqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:46:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54097 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbeGYIqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:46:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 736ED207A8; Wed, 25 Jul 2018 09:36:23 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2BAA020618;
        Wed, 25 Jul 2018 09:36:23 +0200 (CEST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com
Subject: [PATCH v4 0/3] sun8i-a83t: Add touchscreen support on TBS A711
Date:   Wed, 25 Jul 2018 09:34:07 +0200
Message-Id: <20180725073410.730-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is a V4 of the patch series that adds touchscreen support
(FocalTech EDT-FT5x06 Polytouch) for TBS A711 (Allwinner sun8i-a83t SoC)
and add regulator support for this touchscreen.
Based on last master of linux-input tree.

Changes since v3:
   - Created a new function to disable regulator via
   devm_add_action_or_reset (Dmitry Torokhov's review)
   - Moved regulator_enable/disable functions in device_may_wakeup
   guard (Ondřej Jirman and Dmitry Torokhov's reviews)
   - Added Rob Herring Reviewed-by on patch 01 (sorry again)
Changes since v2:
   - Removed the check if regulator is NULL (Dmitry Torokhov's review)
   - Added EPROBE_DEFER error not to print a error message (Lothar Waßmann's review)
   - Added set wake/reset on suspend/resume.
Changes since v1:
   - Removed patches 01 and 02 as Chen-Yu Tsai sent a similar patch:
   https://patchwork.kernel.org/patch/10111431/
   and it is merged on last next-20171222.
   (See commit f066f46ce5a5 "ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings")
   - Updated regulator according to Dmitry Torokhov's review: removed "optional"
   suffix while retrieving the regulator, renamed it into "vcc" instead of
   "power" and added bindings documentation.
   - Updated device tree according to Maxime Ripard's review: remove the
   label and rename the node.
   - Squashed patch 03 with patch 05 to add I2C0 and touchscreen's node
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
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          | 16 +++++++
 drivers/input/touchscreen/edt-ft5x06.c             | 55 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)

-- 
2.11.0

