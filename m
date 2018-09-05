Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B955FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A66820857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A66820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIENwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:52:50 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:39658 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeIENwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:52:49 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id XlPU1y00a3XaVaC06lPU4z; Wed, 05 Sep 2018 11:23:29 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fxU24-0006p3-G6; Wed, 05 Sep 2018 11:23:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fxTlB-0002aQ-3H; Wed, 05 Sep 2018 11:06:01 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] Documentation: gpio: Fix return type of gpiod_set_raw_array_value*()
Date:   Wed,  5 Sep 2018 11:05:53 +0200
Message-Id: <20180905090555.9888-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905090555.9888-1-geert+renesas@glider.be>
References: <20180905090555.9888-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of gpiod_set_raw_array_value() and
gpiod_set_raw_array_value_cansleep() was changed from void to int, but
the doc update was forgotten.

Fixes: 3027743f83f867d8 ("gpio: Remove VLA from gpiolib")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/driver-api/gpio/consumer.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index aa03f389d41d6a79..a4e340c1859439ad 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -337,15 +337,15 @@ The following functions get or set the values of an array of GPIOs::
 	void gpiod_set_array_value(unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   int *value_array)
-	void gpiod_set_raw_array_value(unsigned int array_size,
-				       struct gpio_desc **desc_array,
-				       int *value_array)
+	int gpiod_set_raw_array_value(unsigned int array_size,
+				      struct gpio_desc **desc_array,
+				      int *value_array)
 	void gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
 					    int *value_array)
-	void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
-						struct gpio_desc **desc_array,
-						int *value_array)
+	int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
+					       struct gpio_desc **desc_array,
+					       int *value_array)
 
 The array can be an arbitrary set of GPIOs. The functions will try to access
 GPIOs belonging to the same bank or chip simultaneously if supported by the
-- 
2.17.1

