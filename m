Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4786CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093DE214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093DE214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbeIXSb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:31:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbeIXSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:31:56 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 027AC1098;
        Mon, 24 Sep 2018 12:30:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 058/235] omapfb: rename omap2 module to omap2fb.ko
Date:   Mon, 24 Sep 2018 13:50:44 +0200
Message-Id: <20180924113110.833583083@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4bcd8c90ac0f27d3d76fcfc50582ff3685059de9 ]

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
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/omap2/omapfb/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


