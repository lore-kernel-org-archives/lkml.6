Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B45C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E6220684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E6220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeJCD6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:58:55 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37759 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJCD6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:58:54 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MmkfQ-1fPtUB3FMk-00jr8i; Tue, 02 Oct 2018 23:13:25 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MmkfQ-1fPtUB3FMk-00jr8i; Tue, 02 Oct 2018 23:13:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: TDA1997x: select CONFIG_HDMI
Date:   Tue,  2 Oct 2018 23:12:43 +0200
Message-Id: <20181002211324.2696685-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:SMhp1ipvEagD+VmGlTUAPuJCsOqAnq3MZ6kZ3z+Ql1/u0z8Ha5t
 AWsn+7ptOaMBptXkC4oPASkmgdn9+ZW0qSt2T5H0lg1GHJe/T/AIfO9DXrZmG9EdAKHOA2M
 C2AImqj0VDMAZDQAED/s4cKfN2p0dSsUv7/HN/IWJpm7kE6nj0XY5ncG1SMHDUE5lGQl3iU
 HiZGf3aQcaU1h9jIGVmpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1JQsn2auYzs=:11Qc0CCXDOBcE8mg+aD0aW
 WnXYMF4k7HSTIti9K5ElzFEuA2VTcBfOqW1wCV8AdAS/JV8ojsSasrrPdgCDgA+KU4AEEBcq+
 0SSUgWrIeOfcqidokb8QK+pZeIVwZwLi2n/PZ7AsoEQvADw294ILlxQoy8FVpClUOviNj9dVF
 H+ouf8R6dv/OJeSjKjkf7sVJvVqRAqnuDiz+JS18jLdtcmN7OYXxvY2J6TPrT5gCubu+bTe6m
 m91iV/IdBqEJ71dr/S9/1nU3oYa6+xy7M3Knab+hBUejAbOXvwHkVb1Z1/CooEh8saTao9Ofh
 6cAHrWpEGXL1rsf0EZ3AS/WjUSAc9lkugLh2DWCZAco7MQ0vbKIgQtPoKLuj9m9Zy4duqgueo
 MNN6ecWpC1pkMbj4ap0AQrKsqRJMqRTs1+ZhjT9MpBLvEb2JLtQdj5zvhwe0dXp+quiW7JuGU
 8gNOPlNkTQ2NeJBH7z9mJ9OcsDBExcL1FVASndZzlvZvTNuMzKO2EHD9Ri24qb4YE7vgvTp1E
 u7BPH5c7ECfsG3DjW4Fq9dkvwBhKcaQwqHSmGhPU1y3Apl0/MvSfIVu0JOeuuaVC52G1u1zKU
 B5vVUoxjlsO0gM0WF7f/SEhsSW6kQ9pYOYqIo2WTygcBxeHiu7UrlpsPnf2mXKX4SqbEiJJLi
 Ab5cgQ9/hj8isTuoFXdBWlIJnxIL1r8fDutpwEHoqhQqhIIKPnAGqjpInQO8qnReZgxc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_HDMI, we get a link error for this driver:

drivers/media/i2c/tda1997x.o: In function `tda1997x_parse_infoframe':
tda1997x.c:(.text+0x2195): undefined reference to `hdmi_infoframe_unpack'
tda1997x.c:(.text+0x21b6): undefined reference to `hdmi_infoframe_log'
drivers/media/i2c/tda1997x.o: In function `tda1997x_log_infoframe':
tda1997x.c:(.text.unlikely+0x13d3): undefined reference to `hdmi_infoframe_unpack'
tda1997x.c:(.text.unlikely+0x1426): undefined reference to `hdmi_infoframe_log'

All other drivers in this directory that use HDMI select CONFIG_HDMI,
so do the same here:

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index bcf0686190e0..d958b7fd9e73 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -61,6 +61,7 @@ config VIDEO_TDA1997X
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
 	depends on SND_SOC
 	select SND_PCM
+	select HDMI
 	---help---
 	  V4L2 subdevice driver for the NXP TDA1997x HDMI receivers.
 
-- 
2.18.0

