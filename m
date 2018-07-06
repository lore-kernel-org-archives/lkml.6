Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E6FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0A72170E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0A72170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGFMfq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:35:46 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeGFMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:35:44 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MINTj-1fXIxX1Qdz-004C3D; Fri, 06 Jul 2018 14:35:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] omapfb: rename omap2 module to omap2fb.ko
Date:   Fri,  6 Jul 2018 14:35:07 +0200
Message-Id: <20180706123528.2729378-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:yqtm9EmNCwRfWGPZbrJYWyp2L68CCEbo4RiE4Fb1IRz4vH2bq8g
 X5+67i0e5Z/B+onI9jAA/xJrfb0k4FAhGPffgt2JzbVt3zvnbs5PlVAel4CpgsPHFTanfd2
 DvLPcK/oXyTfAwKITbksPgBr5TNZNa8frqAZueAySNyjX5SzP5vGxIVnh9zMWNoE81udZAB
 jQSLMSmIWQLC3r7j7aFPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ipGVinzco3I=:LlUGQYRFc//nYMIRvxDSyl
 SyN4ZFwjSlPHLhPwzyEIoRGAPtzcXT7Q1ulpcJpAcOeq8r4s0m+5bojhtSKNOo/sO0dqXAEx4
 hsu729iPWCI+PW4OJ3SJ5uoFlxzGR1mfB2Ch+ZEeIPzDExKNGPja06127x3hIkZ5tuXg++V0r
 oAOID4pbGR+ZvqSfB2sRlczVpufxw/YyqkXwMjI7UUGBgBGXmWedC9kp8DlCKTmY0K6oDADKb
 SkzbUgXqnYEnqgXi3NUqoOPJHhpBA15sngrfJ7yGJOmUsefyNkq9+Rs5znO8tdk7e68hcC89y
 H9juvOobqBDehcoMWPNXg5TbZc6cq01OOxb+g+a+5I6mvOS9xHGdHD2P0LmarzVlldwn+GcWa
 9hpGaZ5O8vWRl6snDmtvbloZqbgIep5aqJLR2D4RPnfDFdd57Ix4Jz9qN7uB78eU23FiMCYIt
 wSdgikee0H81QvFM97lCzFUx48UQdBvaWleI1ZkNoHXmBXqxN6A3A4X6cN2nROTdcWPQbqXHQ
 FnvIm8JnNGnNCCD/Bu7fFQxpiJuDrVAn1Nrx9fdAZmKo3sPvRc8R9wRF2blKWNe3oY1T0pPK8
 82dBgVlMoBOdbzpB5wcjwiIbv4muVBms+TZjsgj6yRe5wNce4ZLg5klMrkqiIVTemDAe9BzMY
 2jb3CAZXGUoZcRc+o6D7GnAXHXYCnoVV5WhO9+1O6ydQ2EJIH4i9PP0HNT7SrSy8tZlI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a kernel configuration with both CONFIG_FB_OMAP=m and CONFIG_FB_OMAP2=m,
Kbuild fails to point out that we have two modules with the same name (omapfb.ko),
but instead fails with a cryptic error message like:

ERROR: "omapfb_register_panel" [drivers/video/fbdev/omap/lcd_osk.ko] undefined!

This can now happen when building a randconfig kernel with CONFIG_ARCH_OMAP1,
as the omap1 fbdev driver depends on that, whiel the omap2 fbdev driver can
now be built anywhere with CONFIG_COMPILE_TEST.

The solution is to rename one of the two modules, so for consistency with
the directory naming I decided to rename the omap2 version to omap2fb.ko.

Fixes: 7378f1149884 ("media: omap2: omapfb: allow building it with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap2/omapfb/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/Makefile b/drivers/video/fbdev/omap2/omapfb/Makefile
index 602edfed09df..f54c3f56b641 100644
--- a/drivers/video/fbdev/omap2/omapfb/Makefile
+++ b/drivers/video/fbdev/omap2/omapfb/Makefile
@@ -2,5 +2,5 @@
 obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
 obj-y += dss/
 obj-y += displays/
-obj-$(CONFIG_FB_OMAP2) += omapfb.o
-omapfb-y := omapfb-main.o omapfb-sysfs.o omapfb-ioctl.o
+obj-$(CONFIG_FB_OMAP2) += omap2fb.o
+omap2fb-y := omapfb-main.o omapfb-sysfs.o omapfb-ioctl.o
-- 
2.9.0

