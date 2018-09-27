Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A27EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CEF215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CEF215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeI0R4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:56:09 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:45636 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0R4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:56:08 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id gbeE1y0093XaVaC06beEKa; Thu, 27 Sep 2018 13:38:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UcY-0001Uz-8L; Thu, 27 Sep 2018 13:38:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UcY-00080M-7C; Thu, 27 Sep 2018 13:38:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/3] Documentation: gpio: Fix return type of gpiod_set_raw_array_value*()
Date:   Thu, 27 Sep 2018 13:38:08 +0200
Message-Id: <20180927113810.30721-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927113810.30721-1-geert+renesas@glider.be>
References: <20180927113810.30721-1-geert+renesas@glider.be>
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
v2:
  - Rebase on top of gpio array rework.
---
 Documentation/driver-api/gpio/consumer.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index cf992e5ab976e62a..ba4973829faef238 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -344,18 +344,18 @@ The following functions get or set the values of an array of GPIOs::
 				   struct gpio_desc **desc_array,
 				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
-	void gpiod_set_raw_array_value(unsigned int array_size,
-				       struct gpio_desc **desc_array,
-				       struct gpio_array *array_info,
-				       unsigned long *value_bitmap)
+	int gpiod_set_raw_array_value(unsigned int array_size,
+				      struct gpio_desc **desc_array,
+				      struct gpio_array *array_info,
+				      unsigned long *value_bitmap)
 	void gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
 					    struct gpio_array *array_info,
 					    unsigned long *value_bitmap)
-	void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
-						struct gpio_desc **desc_array,
-						struct gpio_array *array_info,
-						unsigned long *value_bitmap)
+	int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
+					       struct gpio_desc **desc_array,
+					       struct gpio_array *array_info,
+					       unsigned long *value_bitmap)
 
 The array can be an arbitrary set of GPIOs. The functions will try to access
 GPIOs belonging to the same bank or chip simultaneously if supported by the
-- 
2.17.1

