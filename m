Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32574C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0B02084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491017;
	bh=AV9FArGHI2bL25vfx+XR79YicBC/Pn6/8vi1YIeC6GY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=A4Dgf5Hf1f8qUN1AL5QfeuZpcieJ6Ln3V/uavrI/7rES0h/FP+BqQf7O13TPijDzZ
	 m0YmFb3BRkM7Q5aOxny1MFEXJYY+mGAZLN8DgWWtXkYl0n5GoBeB5Ml6tbRmcu5CM3
	 3XiW0cKIgP3aQn1dsZTpQrYdhPCZYDidkHY+CN1U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0B02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeLKBQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeLKBQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2TFN3VrzvzjDa1B0wJFE0OxCet8xQoROaLsnNE7cgyY=; b=NelpsVncELxR
        +BxEnNbuotrFCFBLRd4IWGBmCMitt6Pjo6aPHe8JCkjQnzD0QQ1i6g1HtJvDyDdVMIOunYqiXljfS
        c8TkCw+cDNX15IhzYJYLwVn3I8ek+Jh215G6b0YvXm3FaA8vEy/emx1zQUK24QLJXtp/wOAgYDxRj
        VPnkw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWel-0000M8-2r; Tue, 11 Dec 2018 01:16:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BBF0511254C7; Tue, 11 Dec 2018 01:16:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "gpio: Export gpiod_get_from_of_node()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011614.BBF0511254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   gpio: Export gpiod_get_from_of_node()

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fe6c473e3e41114301bfbf5710be56bf0eb233dc Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:42 +0100
Subject: [PATCH] gpio: Export gpiod_get_from_of_node()

This function already exist inside gpiolib, we were just
reluctant to make it available to the kernel at large as
the devm_* seemed to be enough for anyone.

However we found out that regulators need to do their own
lifecycle/refcounting on GPIO descriptors and explicitly
call gpiod_put() when done with a descriptor, so export
this function so we can hand the refcounting over to the
regulator core for these descriptors after retrieveal.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpiolib.h        |  6 ------
 include/linux/gpio/consumer.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 087d865286a0..bc57f0dc5953 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -201,12 +201,6 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap);
 
-/* This is just passed between gpiolib and devres */
-struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label);
-
 extern struct spinlock gpio_lock;
 extern struct list_head gpio_devices;
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index f2f887795d43..348885f2f3d3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -172,6 +172,10 @@ int desc_to_gpio(const struct gpio_desc *desc);
 struct device_node;
 struct fwnode_handle;
 
+struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label);
 struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
 					      struct device_node *node,
 					      const char *propname, int index,
@@ -517,6 +521,15 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 struct device_node;
 struct fwnode_handle;
 
+static inline
+struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline
 struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
 					      struct device_node *node,
-- 
2.19.0.rc2

