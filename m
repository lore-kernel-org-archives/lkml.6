Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D4C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E2123C91
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E2123C91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeGDKRt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:17:49 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58987 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932548AbeGDKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:16:09 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 18BB0C0009;
        Wed,  4 Jul 2018 10:16:10 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] sh: defconfig: ecovec: Enable CEU and video drivers
Date:   Wed,  4 Jul 2018 12:15:41 +0200
Message-Id: <1530699346-3235-5-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699346-3235-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1530699346-3235-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the new renesas-ceu driver and drivers for the MT9T112
image sensor and TW9910 video receiver installed on Ecovec24
development board.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/configs/ecovec24_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index ecbe791..77017de 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -60,6 +60,12 @@ CONFIG_SPI=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_CEU=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_TW9910=y
+CONFIG_VIDEO_MT9T112=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.7.4

