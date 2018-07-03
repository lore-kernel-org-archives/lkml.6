Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BEFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FDC2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FDC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeGCJri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:47:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33434 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754560AbeGCJrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:47:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 12780207F4; Tue,  3 Jul 2018 11:47:34 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id CA7D2203B4;
        Tue,  3 Jul 2018 11:47:23 +0200 (CEST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     mylene.josserand@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        maxime.ripard@free-electrons.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
Date:   Tue,  3 Jul 2018 11:43:07 +0200
Message-Id: <20180703094309.18514-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a V6 series to add the driver of the touchscreen Cypress,
TrueTouch Generation 5.
Based on v4.18-rc3.

This patch series has already been posted in several iterations:
    - v1: Sent on 2017/05/29
    - v2: Sent on 2017/08/18
    - v3: Sent on 2017/09/27
    - v4: Sent on 2017/12/01
    - v5: Sent on 2017/12/20

I did not have any comments the last 4 versions.
And no reviews on my v5 during 6 months. Could I have any updates
or feedback on my series to know why it is not merged (to be able to
correct what is wrong)?

Changes since v5:
   - Rebased on v4.17-rc3
   - Use SPDX header
   - Called "touchscreen_report_pos" function to perform some
   DT properties on position (such as X/Y swapping)
   - Called "__set_bit" for ABS_X, ABS_Y and BTN_TOUCH to be able
   to use "ts_lib" otherwise, it returns an error:
      tslib: Selected device is not a touchscreen (must support
             ABS and KEY event types)
Changes since v4:
   - Fixed kbuild errors about enum hid_cmd_state and .owner
Changes since v3:
   - Rebased on last input's branch
   - Changed the CRC table to use crc_itu_t_table instead of
   crc_ccitt_false_table which is not merged.
   - Added selection of CRC_ITU_T on KConfig
Changes since v2:
   - Removed pinctrl in dt-binding example which is uncessecary.
   - Added Acked-by and Reviewed-by received.
Changes since v1:
   - Updated the driver according to reviews. Most important modifications:
   removed unnecessary mutex, updated dev_err output, handled return cases
   in a better way, created a HID_ENUM, removed magic value, used an
   existing CRC table and used "linux-keycodes" instead of sub-nodes.
   - Updated the dt-bindings to use linux-keycodes and removed properties'
   description that comes from touchscreen's binding.

Patch 01: Add the basis of the driver for Cypress Gen5 Touchscreen.
Patch 02: Add the binding documentation for this driver.

Thank you,

Best regards,
Mylène

Mylène Josserand (2):
  Input: Add driver for Cypress Generation 5 touchscreen
  dt-bindings: input: Add documentation for cyttsp5

 .../bindings/input/touchscreen/cypress,cyttsp5.txt |   39 +
 drivers/input/touchscreen/Kconfig                  |   16 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/cyttsp5.c                | 1110 ++++++++++++++++++++
 4 files changed, 1166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
 create mode 100644 drivers/input/touchscreen/cyttsp5.c

-- 
2.11.0

