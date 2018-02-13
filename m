Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965044AbeBMOC5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:02:57 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45151 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964879AbeBMOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:02:55 -0500
X-Google-Smtp-Source: AH8x224K1+QRBY3IeG4Z/TMI/GPlusEd7Duw0Rxopte4J4T/8qJEOJ13guF3HUJHpO8ZlzxpCa5mjQ==
Date: Tue, 13 Feb 2018 15:02:48 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] video: fbdev: kconfig: Add help text to FB_I810_I2C
Message-ID: <20180213140248.h4yyc77futu74xg7@huvuddator>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
 <3132455.r9uCTL3ZTk@amdc3058>
 <CAFkk2KQxPnwMKmvhCoKQ0BBciTc5JKqjJqHGHAMR5uHF0w13sg@mail.gmail.com>
 <CGME20180213123147epcas2p2a2bb399e700dacef57a2340afcc0e459@epcas2p2.samsung.com>
 <2836658.i9VlN9LAid@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2836658.i9VlN9LAid@amdc3058>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FB_I810_I2C symbol previously had a blank help text, which was
removed in e9829ac4e5fd ("video: fbdev: kconfig: Remove blank help
text").

Give it a proper help text, derived from commit 74f6ae84b23 ("[PATCH]
i810fb: Add > i2c/DDC support").

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
Note: The removal of the blank help text is already in Linus' tree.

 drivers/video/fbdev/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 11e699f1062b..c691f1489bb7 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1156,6 +1156,11 @@ config FB_I810_I2C
 	bool "Enable DDC Support"
 	depends on FB_I810 && FB_I810_GTF
 	select FB_DDC
+	help
+	  Add DDC/I2C support for i810fb.  This will allow the driver to get
+	  display information, especially for monitors with fickle timings.
+
+	  If unsure, say Y.
 
 config FB_LE80578
 	tristate "Intel LE80578 (Vermilion) support"
-- 
2.14.1
