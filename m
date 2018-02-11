Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbeBKVHp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:07:45 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34291 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbeBKVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:07:42 -0500
X-Google-Smtp-Source: AH8x2258A18KbJO+ykK39fJjLNO+wq2Q0+25/bFcyLRBOxk3XOs3NET9R/kL8aBOkrjaZN3R5/FoFQ==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] platform/x86: fujitsu-laptop: Clearly distinguish module parameters
Date: Sun, 11 Feb 2018 22:07:24 +0100
Message-Id: <20180211210727.12130-5-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211210727.12130-1-kernel@kempniu.pl>
References: <20180211210727.12130-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve code clarity, move declarations of variables that
are module parameters higher up and add a comment.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 94ff7f86fa8f..7888b779d6c5 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -112,6 +112,10 @@
 #define MAX_HOTKEY_RINGBUFFER_SIZE 100
 #define RINGBUFFERSIZE 40
 
+/* Module parameters */
+static int use_alt_lcd_levels = -1;
+static bool disable_brightness_adjust;
+
 /* Device controlling the backlight and associated keys */
 struct fujitsu_bl {
 	struct input_dev *input;
@@ -122,8 +126,6 @@ struct fujitsu_bl {
 };
 
 static struct fujitsu_bl *fujitsu_bl;
-static int use_alt_lcd_levels = -1;
-static bool disable_brightness_adjust;
 
 /* Device used to access hotkeys and other features on the laptop */
 struct fujitsu_laptop {
-- 
2.16.1
