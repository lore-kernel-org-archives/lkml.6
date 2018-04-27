Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbeD0I4j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:56:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45578 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbeD0I4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:56:36 -0400
X-Google-Smtp-Source: AB8JxZq8QNLG6QUAQ1vOlQRpIRHgrzrEA0wllc6YrqY4qe0pvn1nI/hVfn3rgIL2dc8er3MtnDcofw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: samsung: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 14:26:11 +0530
Message-Id: <f7e9ff7d5d7c559967e9d63f3caff478e05017e8.1524819053.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/samsung/s3c24xx_simtec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 6de63f3..23e8ef9d 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -229,7 +229,7 @@ static int attach_gpio_amp(struct device *dev,
 	int ret;
 
 	/* attach gpio amp gain (if any) */
-	if (pdata->amp_gain[0] > 0) {
+	if (gpio_is_valid(pdata->amp_gain[0])) {
 		ret = gpio_request(pd->amp_gain[0], "gpio-amp-gain0");
 		if (ret) {
 			dev_err(dev, "cannot get amp gpio gain0\n");
@@ -248,7 +248,7 @@ static int attach_gpio_amp(struct device *dev,
 	}
 
 	/* note, currently we assume GPA0 isn't valid amp */
-	if (pdata->amp_gpio > 0) {
+	if (gpio_is_valid(pdata->amp_gpio)) {
 		ret = gpio_request(pd->amp_gpio, "gpio-amp");
 		if (ret) {
 			dev_err(dev, "cannot get amp gpio %d (%d)\n",
@@ -263,7 +263,7 @@ static int attach_gpio_amp(struct device *dev,
 	return 0;
 
 err_amp:
-	if (pd->amp_gain[0] > 0) {
+	if (gpio_is_valid(pd->amp_gain[0])) {
 		gpio_free(pd->amp_gain[0]);
 		gpio_free(pd->amp_gain[1]);
 	}
@@ -273,12 +273,12 @@ static int attach_gpio_amp(struct device *dev,
 
 static void detach_gpio_amp(struct s3c24xx_audio_simtec_pdata *pd)
 {
-	if (pd->amp_gain[0] > 0) {
+	if (gpio_is_valid(pd->amp_gain[0])) {
 		gpio_free(pd->amp_gain[0]);
 		gpio_free(pd->amp_gain[1]);
 	}
 
-	if (pd->amp_gpio > 0)
+	if (gpio_is_valid(pd->amp_gpio))
 		gpio_free(pd->amp_gpio);
 }
 
-- 
1.9.1
