Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638C3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4E021479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4E021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJSTAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:00:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49437 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeJSTAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:00:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1gDSQj-0007Sf-50; Fri, 19 Oct 2018 12:54:57 +0200
Received: from mgr by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mgr@pengutronix.de>)
        id 1gDSQg-0000Ai-FQ; Fri, 19 Oct 2018 12:54:54 +0200
From:   Michael Grzeschik <m.grzeschik@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, stoth@kernellabs.com,
        mchehab@kernel.org, davem@davemloft.net,
        laurent.pinchart@ideasonboard.com, kernel@pengutronix.de
Subject: [PATCH 0/2] media: Startech usb2hdcapm hdmi2usb framegrabber support
Date:   Fri, 19 Oct 2018 12:54:37 +0200
Message-Id: <20181019105439.27796-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Startech usb2hdcapm framegrabber. The
code is based on the external kernel module code from Steven Toth's
github page:

https://github.com/stoth68000/hdcapm/

We applied checkpatch.pl --strict and cleaned up the 80 character
length, whitespace issues and replaced simple printks with appropriate
v4l2_* or dev_* helpers, used WARN_ON instead of BUG and changed all
errors and warnings checkpatch was complaining about.

Steven Toth (2):
  media: mst3367: add support for mstar mst3367 HDMI RX
  media: hdcapm: add support for usb2hdcapm hdmi2usb framegrabber from
    startech

 MAINTAINERS                                  |   12 +
 drivers/media/i2c/Kconfig                    |   10 +
 drivers/media/i2c/Makefile                   |    1 +
 drivers/media/i2c/mst3367.c                  | 1104 ++++++++++++++++++
 drivers/media/usb/Kconfig                    |    1 +
 drivers/media/usb/Makefile                   |    1 +
 drivers/media/usb/hdcapm/Kconfig             |   11 +
 drivers/media/usb/hdcapm/Makefile            |    3 +
 drivers/media/usb/hdcapm/hdcapm-buffer.c     |  230 ++++
 drivers/media/usb/hdcapm/hdcapm-compressor.c |  782 +++++++++++++
 drivers/media/usb/hdcapm/hdcapm-core.c       |  743 ++++++++++++
 drivers/media/usb/hdcapm/hdcapm-i2c.c        |  332 ++++++
 drivers/media/usb/hdcapm/hdcapm-reg.h        |  111 ++
 drivers/media/usb/hdcapm/hdcapm-video.c      |  665 +++++++++++
 drivers/media/usb/hdcapm/hdcapm.h            |  283 +++++
 include/media/i2c/mst3367.h                  |   29 +
 16 files changed, 4318 insertions(+)
 create mode 100644 drivers/media/i2c/mst3367.c
 create mode 100644 drivers/media/usb/hdcapm/Kconfig
 create mode 100644 drivers/media/usb/hdcapm/Makefile
 create mode 100644 drivers/media/usb/hdcapm/hdcapm-buffer.c
 create mode 100644 drivers/media/usb/hdcapm/hdcapm-compressor.c
 create mode 100644 drivers/media/usb/hdcapm/hdcapm-core.c
 create mode 100644 drivers/media/usb/hdcapm/hdcapm-i2c.c
 create mode 100644 drivers/media/usb/hdcapm/hdcapm-reg.h
 create mode 100644 drivers/media/usb/hdcapm/hdcapm-video.c
 create mode 100644 drivers/media/usb/hdcapm/hdcapm.h
 create mode 100644 include/media/i2c/mst3367.h

-- 
2.19.0

