Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6ADC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4CF20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l10yn+fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4CF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbeGXTxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:53:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43904 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbeGXTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:53:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so1053286pfi.10;
        Tue, 24 Jul 2018 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=j0JxVvcPoAph3yvy8Ymjq7LnBncFhOl3XK7mHAC/r/E=;
        b=l10yn+fbZ2SPOcjPyk/EKyOfH2Swn/qzHCNhpXg7Pn/9Y5yP+u4hOUeVwdApjnXva3
         XQEQ2hQ/7egCgj0nANi17xMc9txhabj3HJbKQU5GXgOaymbqECUct7TGr9HV5ivfbGDm
         U4TyhRmxCVdv0aDxzdiN4T3wCB7EJTSoo6zexfuNkbC3OaQPMi+XRPfY8KdS15cFRM7W
         3+GGWSenUjtpQJQB3VUVyiIKBqNE1r6K+KDmiNB627OLn6/lXUB12l6Ya5n/1qY0FyqD
         oq5KFs473NM2R8mkmTgV+NKAER4/QPitQCGK8plc1B22Poqet0nwY/jo0J24bBO80Kmy
         Mgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=j0JxVvcPoAph3yvy8Ymjq7LnBncFhOl3XK7mHAC/r/E=;
        b=kR4W7rjdh4uLRYSb6Lpn3GfRFZWznjQsbPNXb4hnPzjlbC25t7ZoPqZp8M1Sna79B4
         6+2bknhJ7IzqEVna+F0kp0MZUAj+eOolxjhxuBAzNdbJPO23VY/s3JWrfn09sEeyY0YI
         /uXBd1m69djzenJjSqvcnw8wQAzf34aQEGt//WB8OWofKyh5UiTeKxOwimIlYpgn5GHT
         m6BLGuSE9gfF7Wxtlu3aSnDdxV9A4yf8AIuQJDRdUxwYTrTqbMMpG92GQpUIqoqOsR+m
         ILZ0UGY3rAmkt/aVyyzutD/PozAx0uM9WWfMSnbAN8RFoP7JpqaoHGyPXhY86bZp9mek
         D2ZA==
X-Gm-Message-State: AOUpUlG4FHMG+YZvtP6IWhW1V9nLSaWKDtpFD7rAl1ZQppe18HAHbpAC
        mA4FDM6O3DHwUTsN1wDkLZToOw0K
X-Google-Smtp-Source: AAOMgpcPWoLYRC5FKGcqK9FbYUy3cZj6xpQqDBcBjTPoU8HiE014nGbf6uo42H0USD6YG9TpNCu1UQ==
X-Received: by 2002:a62:9bc5:: with SMTP id e66-v6mr18715539pfk.84.1532457957936;
        Tue, 24 Jul 2018 11:45:57 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id g15-v6sm25805938pfg.98.2018.07.24.11.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:45:56 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:45:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vojtech Pavlik <vojtech@suse.cz>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        vojtech@ucw.cz
Subject: [PATCH] Input: stop telling users to snail-mail Vojtech
Message-ID: <20180724184554.GA74150@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not think Vojtech wants snail mail these days, even if the
address were correct (I do not know if it is), so let's remove
snail-mail instructions from the sources.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/evbug.c                          | 4 ----
 drivers/input/gameport/emu10k1-gp.c            | 4 ----
 drivers/input/gameport/lightning.c             | 4 ----
 drivers/input/gameport/ns558.c                 | 4 ----
 drivers/input/joystick/a3d.c                   | 4 ----
 drivers/input/joystick/adi.c                   | 4 ----
 drivers/input/joystick/amijoy.c                | 4 ----
 drivers/input/joystick/analog.c                | 4 ----
 drivers/input/joystick/cobra.c                 | 4 ----
 drivers/input/joystick/db9.c                   | 4 ----
 drivers/input/joystick/gamecon.c               | 4 ----
 drivers/input/joystick/gf2k.c                  | 4 ----
 drivers/input/joystick/grip.c                  | 4 ----
 drivers/input/joystick/guillemot.c             | 4 ----
 drivers/input/joystick/iforce/iforce-ff.c      | 4 ----
 drivers/input/joystick/iforce/iforce-main.c    | 4 ----
 drivers/input/joystick/iforce/iforce-packets.c | 4 ----
 drivers/input/joystick/iforce/iforce-serio.c   | 4 ----
 drivers/input/joystick/iforce/iforce-usb.c     | 4 ----
 drivers/input/joystick/iforce/iforce.h         | 4 ----
 drivers/input/joystick/interact.c              | 4 ----
 drivers/input/joystick/joydump.c               | 4 ----
 drivers/input/joystick/magellan.c              | 4 ----
 drivers/input/joystick/sidewinder.c            | 4 ----
 drivers/input/joystick/spaceball.c             | 4 ----
 drivers/input/joystick/spaceorb.c              | 4 ----
 drivers/input/joystick/stinger.c               | 4 ----
 drivers/input/joystick/tmdc.c                  | 4 ----
 drivers/input/joystick/turbografx.c            | 4 ----
 drivers/input/joystick/warrior.c               | 4 ----
 drivers/input/keyboard/amikbd.c                | 4 ----
 drivers/input/keyboard/atakbd.c                | 4 ----
 drivers/input/keyboard/newtonkbd.c             | 4 ----
 drivers/input/keyboard/stowaway.c              | 4 ----
 drivers/input/keyboard/sunkbd.c                | 4 ----
 drivers/input/keyboard/xtkbd.c                 | 4 ----
 drivers/input/mouse/inport.c                   | 4 ----
 drivers/input/mouse/logibm.c                   | 4 ----
 drivers/input/mouse/pc110pad.c                 | 4 ----
 drivers/input/mouse/sermouse.c                 | 4 ----
 drivers/input/serio/ct82c710.c                 | 4 ----
 drivers/input/serio/q40kbd.c                   | 4 ----
 drivers/input/serio/rpckbd.c                   | 4 ----
 drivers/input/serio/serio.c                    | 4 ----
 drivers/input/touchscreen/gunze.c              | 4 ----
 include/linux/joystick.h                       | 4 ----
 include/uapi/linux/joystick.h                  | 4 ----
 47 files changed, 188 deletions(-)

diff --git a/drivers/input/evbug.c b/drivers/input/evbug.c
index cd4e6679d61a..5419c1c1f621 100644
--- a/drivers/input/evbug.c
+++ b/drivers/input/evbug.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
index 2909e9561cf3..afdc20ca0e24 100644
--- a/drivers/input/gameport/emu10k1-gp.c
+++ b/drivers/input/gameport/emu10k1-gp.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <asm/io.h>
diff --git a/drivers/input/gameport/lightning.c b/drivers/input/gameport/lightning.c
index 85d6ee09f11f..c6e74c7945cb 100644
--- a/drivers/input/gameport/lightning.c
+++ b/drivers/input/gameport/lightning.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <asm/io.h>
diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
index 7c217848613e..6437645858f9 100644
--- a/drivers/input/gameport/ns558.c
+++ b/drivers/input/gameport/ns558.c
@@ -21,10 +21,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <asm/io.h>
diff --git a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
index 55efdfc7eb62..98307039a534 100644
--- a/drivers/input/joystick/a3d.c
+++ b/drivers/input/joystick/a3d.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index 15a71acb6997..f466c0d34247 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
index c65b5fa69f1e..2b82a838c511 100644
--- a/drivers/input/joystick/amijoy.c
+++ b/drivers/input/joystick/amijoy.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/types.h>
diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index c79dbcb4d146..2b445c8d3fcd 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
index ae3ee24a2368..14cb956beac4 100644
--- a/drivers/input/joystick/cobra.c
+++ b/drivers/input/joystick/cobra.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index de0dd4756c84..7721cc0bf569 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 4e10ffdf8a36..d62e73dd9f7f 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -24,10 +24,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
index 0f519db64748..50a60065ab14 100644
--- a/drivers/input/joystick/gf2k.c
+++ b/drivers/input/joystick/gf2k.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
index eac9c5b8d73e..e10395ba62bc 100644
--- a/drivers/input/joystick/grip.c
+++ b/drivers/input/joystick/grip.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
index a9ac2f9cfce0..43ff817d80ac 100644
--- a/drivers/input/joystick/guillemot.c
+++ b/drivers/input/joystick/guillemot.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/iforce/iforce-ff.c b/drivers/input/joystick/iforce/iforce-ff.c
index a56145d14b6d..3536d5f5ad18 100644
--- a/drivers/input/joystick/iforce/iforce-ff.c
+++ b/drivers/input/joystick/iforce/iforce-ff.c
@@ -19,10 +19,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include "iforce.h"
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index dcc50f4aae46..f43009703574 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -19,10 +19,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include "iforce.h"
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index debb0acc5bbd..128f7d0f0151 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -19,10 +19,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include "iforce.h"
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 154e827b559b..f4ba4a751fe0 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -19,10 +19,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include "iforce.h"
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index e8724f1a4a25..78073259c9a1 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -19,10 +19,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include "iforce.h"
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index b57ad21db722..0e9d01f8bcb6 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -19,10 +19,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
index 17c2c800743c..598788b3da62 100644
--- a/drivers/input/joystick/interact.c
+++ b/drivers/input/joystick/interact.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
index d1c6e4846a4a..2ea05ade4d4e 100644
--- a/drivers/input/joystick/joydump.c
+++ b/drivers/input/joystick/joydump.c
@@ -21,10 +21,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
index a9d0e3edca94..95a34ab34fc3 100644
--- a/drivers/input/joystick/magellan.c
+++ b/drivers/input/joystick/magellan.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- *  Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 5e602a6852b7..f46bf4d41972 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
index bb3faeff8cac..ffb9c1f495b6 100644
--- a/drivers/input/joystick/spaceball.c
+++ b/drivers/input/joystick/spaceball.c
@@ -24,10 +24,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- *  Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
index 05da0ed514e2..20540ee71d7f 100644
--- a/drivers/input/joystick/spaceorb.c
+++ b/drivers/input/joystick/spaceorb.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- *  Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
index cb10e7b097ae..ba8579435d6c 100644
--- a/drivers/input/joystick/stinger.c
+++ b/drivers/input/joystick/stinger.c
@@ -21,10 +21,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- *  Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
index 7e17cde464f0..6f4a01cfe79f 100644
--- a/drivers/input/joystick/tmdc.c
+++ b/drivers/input/joystick/tmdc.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index e2685753e460..bf2f9925e416 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
index ef5391ba4470..b60cab168e2a 100644
--- a/drivers/input/joystick/warrior.c
+++ b/drivers/input/joystick/warrior.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- *  Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index e04a3b4e55d6..420e33c49e58 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
index f1235831283d..6f62da2909ec 100644
--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -34,10 +34,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
index fb9b8e23ab93..de26e2df0ad5 100644
--- a/drivers/input/keyboard/newtonkbd.c
+++ b/drivers/input/keyboard/newtonkbd.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <j.cormack@doc.ic.ac.uk>, or by paper mail:
- * Justin Cormack, 68 Dartmouth Park Road, London NW5 1SN, UK.
  */
 
 #include <linux/slab.h>
diff --git a/drivers/input/keyboard/stowaway.c b/drivers/input/keyboard/stowaway.c
index 8b6de9a692dc..15a5e74dbe91 100644
--- a/drivers/input/keyboard/stowaway.c
+++ b/drivers/input/keyboard/stowaway.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <marek.vasut@gmail.com>, or by paper mail:
- * Marek Vasut, Liskovecka 559, Frydek-Mistek, 738 01 Czech Republic
  */
 
 #include <linux/slab.h>
diff --git a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
index c95707ea2656..ad5d7f94f95a 100644
--- a/drivers/input/keyboard/sunkbd.c
+++ b/drivers/input/keyboard/sunkbd.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
index 8f64b9ded8d0..f7598114b962 100644
--- a/drivers/input/keyboard/xtkbd.c
+++ b/drivers/input/keyboard/xtkbd.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/slab.h>
diff --git a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
index 9ce71dfa0de1..b9e68606c44a 100644
--- a/drivers/input/mouse/inport.c
+++ b/drivers/input/mouse/inport.c
@@ -26,10 +26,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
index 6f165e053f4d..2fd6c84cd5b7 100644
--- a/drivers/input/mouse/logibm.c
+++ b/drivers/input/mouse/logibm.c
@@ -27,10 +27,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index 7b02b652e267..b8965e6bc890 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
index 8df526620ebf..d27816ac038f 100644
--- a/drivers/input/mouse/sermouse.c
+++ b/drivers/input/mouse/sermouse.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index 9c54c43c9749..2d1e2993b5a8 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/delay.h>
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index d0fccc8ec259..fbb6b33845fa 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -23,10 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index 8cf964736902..a308d7811427 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -21,10 +21,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 4c4e822a4c42..97e6e7dc5ef7 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 481586909d28..054c2537b392 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -20,10 +20,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/errno.h>
diff --git a/include/linux/joystick.h b/include/linux/joystick.h
index cbf2aa9e93b9..5153f5b9294c 100644
--- a/include/linux/joystick.h
+++ b/include/linux/joystick.h
@@ -17,10 +17,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
- * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
  */
 #ifndef _LINUX_JOYSTICK_H
 #define _LINUX_JOYSTICK_H
diff --git a/include/uapi/linux/joystick.h b/include/uapi/linux/joystick.h
index 9c63bb60afd5..1c1c42f53bc2 100644
--- a/include/uapi/linux/joystick.h
+++ b/include/uapi/linux/joystick.h
@@ -18,10 +18,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
- * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
  */
 #ifndef _UAPI_LINUX_JOYSTICK_H
 #define _UAPI_LINUX_JOYSTICK_H
-- 
2.18.0.233.g985f88cf7e-goog


-- 
Dmitry
