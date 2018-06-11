Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XgQkJqWSHlvtFgAAmS7hNA
	; Mon, 11 Jun 2018 15:17:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7CA0C607A4; Mon, 11 Jun 2018 15:17:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAF4860541;
	Mon, 11 Jun 2018 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAF4860541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932655AbeFKPRy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:17:54 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38693 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754038AbeFKPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:17:52 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 43966240016;
        Mon, 11 Jun 2018 15:17:53 +0000 (UTC)
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: mchehab@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/2] media: i2c: mt9v111 sensor driver
Date: Mon, 11 Jun 2018 17:17:31 +0200
Message-Id: <1528730253-25135-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this is a sensor level driver for Aptina MT9V111.

The driver supports YUYV_2X8 output formats and VGA,QVGA,QQVGA,CIF and QCIF
resolution.

The driver allows control of frame rate through s_frame_interval or
V4L2_CID_H/VBLANK control. In order to allow manual frame control, the chip
is initialized with auto-exposure control, auto white balancing and flickering
control disabled.

Tested VGA, QVGA QQVGA resolutions at 5, 10, 15 and 30 frame per second.

Thanks
   j

Jacopo Mondi (2):
  dt-bindings: media: i2c: Document MT9V111 bindings
  media: i2c: Add driver for Aptina MT9V111

 .../bindings/media/i2c/aptina,mt9v111.txt          |   46 +
 MAINTAINERS                                        |    8 +
 drivers/media/i2c/Kconfig                          |   12 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/mt9v111.c                        | 1297 ++++++++++++++++++++
 5 files changed, 1364 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt
 create mode 100644 drivers/media/i2c/mt9v111.c

--
2.7.4
