Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeBTF0B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:26:01 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36187 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeBTFZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:25:07 -0500
X-Google-Smtp-Source: AH8x224ohi5iPNGxO83guqWz4BrLyS3gNgf9CycR9u4xK8eIgKMtfLW6+/YdS+E6O2luOFwkfkZHhQ==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] platform/x86: fujitsu-laptop: Clearly distinguish module parameters
Date: Tue, 20 Feb 2018 06:24:51 +0100
Message-Id: <20180220052454.11134-5-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
References: <20180220052454.11134-1-kernel@kempniu.pl>
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
