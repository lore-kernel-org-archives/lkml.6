Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeCLTMD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:12:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39671 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbeCLTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:09:18 -0400
X-Google-Smtp-Source: AG47ELtdT8cmihGr3Ez+zs1LszGwtzuckZoS9UU8OtDBn+9FVvEiIW8dNvxOPn1zfmiY4/2n+iGLwA==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] platform/chrome: chromeos_laptop - stop setting suspend mode for Atmel devices
Date: Mon, 12 Mar 2018 12:08:58 -0700
Message-Id: <20180312190907.174301-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atmel touch controller driver no longer respects suspend mode specified in
platform data, so let's stop setting it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 54a13c70e1d8f..0a43f1833de3f 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -100,7 +100,6 @@ static struct mxt_platform_data atmel_224s_tp_platform_data = {
 	.irqflags		= IRQF_TRIGGER_FALLING,
 	.t19_num_keys		= ARRAY_SIZE(mxt_t19_keys),
 	.t19_keymap		= mxt_t19_keys,
-	.suspend_mode		= MXT_SUSPEND_T9_CTRL,
 };
 
 static struct i2c_board_info atmel_224s_tp_device = {
@@ -111,7 +110,6 @@ static struct i2c_board_info atmel_224s_tp_device = {
 
 static struct mxt_platform_data atmel_1664s_platform_data = {
 	.irqflags		= IRQF_TRIGGER_FALLING,
-	.suspend_mode		= MXT_SUSPEND_T9_CTRL,
 };
 
 static struct i2c_board_info atmel_1664s_device = {
-- 
2.16.2.660.g709887971b-goog
