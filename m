Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x226XhqaxoNkkOkZFJhB8aSeMittiB+jn1NI/XZaml8bUgliaMaYZZy/J7qb0T8j/Ym2Bx5eT
ARC-Seal: i=1; a=rsa-sha256; t=1519391830; cv=none;
        d=google.com; s=arc-20160816;
        b=USGUEBxjgEYkEbOC5mmGYykFoipOU1cX5HU7QrvzPAtHYd6hpGdSuV0UDRg4QmmB98
         t6RDG/bcYBUZMWHGYXQKyGuMIEPw9RoQvP8Tuazvc8wyiETntzAibFzO68EHSFtcQkmW
         LGe0V051vTXXOW0CgK+RXWaYgmQ/VTClC/h6EWeIuLKqLdtqhpXrJoE/Rzy7fRn+zVj+
         M/IKedsdNkXrKQFdhwwx0FTanCjoGCfGeZV9EXN/Sc2eVPgiQXfzSQ1W0RB1g1ATJFEs
         jbky+jvamQ5pbzRlEnRzCsJwjHqpn5a+7mlJIBeT7z4/66U2SEMOnrslX0aZ15dc1tAw
         wQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=iZ2z0E/yPUgYNvLWLfaWq2o/dAu4FL0m5VvJYiqWuy0=;
        b=esF664a6m5lyrl4CPrLTPgiP9h2ybk3MiKBbFdBvMNY3oa8HfKY61aO/zQrUIkRb04
         WJsOK3yqHG6WQcGSwdQGie99QN77ImnZXpnO8XJF1KEBvl0jvu3T/dqYLMhCruJ8FyYv
         UIrLL/0FKv0uCkGPp8ERzHYF8CEYl6jZt/SBYRztcM7r4C1rk7ND+KgUoYyrbbStT92t
         10f/wG8Skget+mcdRh/3b+A/Ovt52sUM+rDPgsPdeIW0qesoekYggyo8CktO3r2qR+AQ
         qNsm7oSU6n5txztMKu6FAtwOLoXVvqJsSsx3Ex3VMPJ3SZ0yOxW8RxoompwVM7pBAE6b
         J0nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Airlie <airlied@linux.ie>,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Icenowy Zheng <icenowy@aosc.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Liu <net147@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: link in front-end code if needed
Date: Fri, 23 Feb 2018 14:06:52 +0100
Message-Id: <20180223131112.715992-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:ae3oP+fmoLgCueMJ06CwWph6/VZkJsVzsh+tpCfUPBug2+HVDrW
 kszn/k3eIsXa53WEbCAPiK+u/YUxV6dex9SayszXSbRT3TEAUGHVtMLauXEF1nLPPzAkjTL
 bkBCUoZEi9thpl+K4T4WV+iGtqhtsKC6TztjAtO/QtkOcWZr1Q40TiyTu+X4p7kgynA/KEJ
 pDOQ6CJLi+42b8T0Y5AkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+QaukY0er9o=:vMjGg/lEsqiKsuZ5prcwjz
 Uu/LNISiBKpBy3wjZTUd3pPs6kAgoe4Ful2UrQCwrqBHgx2D72YQC0GZFDUkOplmgZacizv5s
 R/dpXdqtakxi+DvmD1sBbNcKLETcnYJNXqkbFhW5ZyJZl+iY1n0OfC42ZX20mutkUCb3ZqlnM
 V5+EfZDhXbRsaC4fopbN22uinKl3UF6T2pOqPXB8wJxEeJMPB3IK5pGCu4TTbGJrdvfM3Xkyt
 OHoycQTswLDsMruNW7uqHtoFOw0wdi+e1gpxY57dfDWu1cfruIFFWDulhbB8c2bDPXvD2rqxl
 VeSU1KZJ6WvsJfDzJzpeAYzvKz+PKPUQZkhnT5oRFAKLNlo2/vJBvLnRa9DeJOZ1bBdz0Z9Fs
 nPPBWEbfeyrDSjic2DsecgDr7shMc6Xg2Xp/mZads6b9MpkhtuecKyOMhf1+TvxMKj7TCyb2y
 M6hDktlS3eN2cCSyipJMoQT8dVrdR+bTkEFhvLX7sQJ7DinQwiabRPl3uYFN3Ca7xeUdIqQ8c
 7WI+AaURYnbJFA1NDN7qC6ydCNb25VLLyVa4zxEaiN4vdoThVLHpAmic6FxmtxCpNYhEYi6Lm
 8GaQ7rQ6drj1GSWrhDE2wEpdE61rZmtlhfEP/JpyyCzg4X0tgYagqTjlHrD9TggWsHqjziWyJ
 QxUT0m2NoJRLho3R4tkG2h8OZFfo1obZV5kat+5M/f2NYla2zqgXlk38FAlG/v/2AsXZUNb9l
 NDdvWjvqdaFNQBWFzeF4LUtIQs7mbETKGoHZgw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197807586940998?=
X-GMAIL-MSGID: =?utf-8?q?1593197807586940998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the base sun4i DRM driver is built-in but the back-end is
a loadable module, we run into a link error:

drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_table'

The dependency is a bit tricky, the best workaround I have come up
with is to use a Makefile hack to to interpret both
CONFIG_DRM_SUN4I_BACKEND=m and CONFIG_DRM_SUN4I_BACKEND=y
as a directive to build the front-end the same way as the main module.

Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/sun4i/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 582607c0c488..db14e023256b 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)		+= sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 
-obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o sun4i-frontend.o
+obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
+ifdef CONFIG_DRM_SUN4I_BACKEND
+obj-$(CONFIG_DRM_SUN4I)		+= sun4i-frontend.o
+endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o
-- 
2.9.0
