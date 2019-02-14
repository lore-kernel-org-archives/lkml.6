Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4919222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437532AbfBNIgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:36:31 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:45473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390593AbfBNIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:36:31 -0500
Received: from orion.localdomain ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MUD7D-1gU7DS1S8B-00RGuP; Thu, 14 Feb 2019 09:36:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH 1/2] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date:   Thu, 14 Feb 2019 09:36:18 +0100
Message-Id: <1550133379-1793-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550133379-1793-1-git-send-email-info@metux.net>
References: <1550133379-1793-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:TGbmGLcKjkoB58xNX96cu0xCZOUwhxYape1e1SSfrihazu+DOrc
 5CvZ8dVQCTTLSePhsnx2c+5cDlrV+sW8cnhpDgkqRautYnRa0hQOrSY8flkXd94sZ77imBE
 EtAhYRGjifQibLD8t4RuZjM+4Jmvd7fvXGq+jVCC52/Syw26Dip2KlbMlrgzdRYoZqyBV5u
 d3b/FbfL0sQG6LaXpd3lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AG2EoBO6Aik=:zVKgW4HoKpRUbwQHtjhziq
 eZkCke7uROtjUQomBJKeBoCD3a57nlHxrDD3XzuX/TyHkxlOLemoySRM2BlIxEG+HIEWlm6L6
 7q+aONZKQLzCFJlHjBirv/80cKApuko9p214NIZGKFaqTpPxt4qJlVkH0X8TOWy5MSdhSRw6p
 yvmdvspTn8VoNU3/UKbSj43I9MLw4FZDl9uW1Q1HgPjpySDPvHmYi8790PQCd4W5YyYS3Z+9V
 +e5Dr6KIQpTN+0UIRvIzuJ04/qJ5WR4m/3nemBvnCKccY8rl8HDIsJsD650/dvaLOpMonRGyv
 uL0gdV4SNy1TS83lgY1WBewvnTXYQeJ4rgSsKCqtCeT+0qswt0LpsIcHdIFQTppsLMdJsW2ss
 rWjCQZz11MTgxl8QeSekpi7itjLbN63ta/CcvVwEJeKgPVovXpyotNhKiBd/I1I81QW1oenKm
 JaNbxmlJ8BZYbPQRf0uTqIY4xeMkvYDBmHze9by97BvNwhkpBig6EBL+VfO5ChN+t9CQkAUDH
 cI0x7Iui1uHr6yfGglAUF7Wz02Xcod5IRgUCfo16n9rMyJenqbNnXjGu2j/eMaD8XM6osMP61
 GFT+Z4zTf9dZ3DF4AxkjvKLJCmoJJVySHdUBxUslJqjDDKPXJZWW65+EIlefazeVtIqAngeg2
 dDjY3Ca8kLigtCeE9cL7cEoHJkt8JvJCJ+9cF0kF4uoeDa0uPNshoZkLUcqfUpPuG3Cc7MWAu
 fkHWVHN5JJtp0rqOoyRGwvQDan6q21hEWzMYzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding the input name to the driver name
('gpio-keys-polled'), allow the passing a name via platform data
('name' field was already present), but default to old behaviour
in case of NULL.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262..3312186 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input = poll_dev->input;
 
-	input->name = pdev->name;
+	input->name = (pdata->name ? pdata->name : pdev->name);
 	input->phys = DRV_NAME"/input0";
 
 	input->id.bustype = BUS_HOST;
-- 
1.9.1

