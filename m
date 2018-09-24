Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC15ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0363220877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0363220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbeIXSIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:08:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbeIXSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:08:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0F56D1084;
        Mon, 24 Sep 2018 12:06:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 091/111] gpiolib: Mark gpio_suffixes array with __maybe_unused
Date:   Mon, 24 Sep 2018 13:52:58 +0200
Message-Id: <20180924113113.873195154@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b23ec59926faf05b0c43680d05671c484e810ac4 ]

Since we put static variable to a header file it's copied to each module
that includes the header. But not all of them are actually used it.

Mark gpio_suffixes array with __maybe_unused to hide a compiler warning:

In file included from
drivers/gpio/gpiolib-legacy.c:6:0:
drivers/gpio/gpiolib.h:95:27: warning: ‘gpio_suffixes’ defined but not used [-Wunused-const-variable=]
 static const char * const gpio_suffixes[] = { "gpios", "gpio" };
                           ^~~~~~~~~~~~~
In file included from drivers/gpio/gpiolib-devprop.c:17:0:
drivers/gpio/gpiolib.h:95:27: warning: ‘gpio_suffixes’ defined but not used [-Wunused-const-variable=]
 static const char * const gpio_suffixes[] = { "gpios", "gpio" };
                           ^~~~~~~~~~~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -85,7 +85,7 @@ struct acpi_gpio_info {
 };
 
 /* gpio suffixes used for ACPI and device tree lookup */
-static const char * const gpio_suffixes[] = { "gpios", "gpio" };
+static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
 #ifdef CONFIG_OF_GPIO
 struct gpio_desc *of_find_gpio(struct device *dev,


