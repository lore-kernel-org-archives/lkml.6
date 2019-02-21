Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57541C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2248A2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ImAtQQdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfBUQ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:26:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36132 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBUQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:26:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so31310240wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jHASHFNH575gLKJTx/QV3Be+6VBLAjZakfImVWb2z0=;
        b=ImAtQQdQOA0M3o5PZRBMkyh3A2WDkOTaHF/PqvUiRg8ZMYfcmsJspdCMRpOBW7xocf
         1MPLnLax0RauNFkqZTMAHyAfzuR/ALPDvHOjUHzU5EU7T3GKUA1EbX0oRn/O9iDePNtG
         kgGXsjC8BBfLqaPRaLHVL7i8vxXo2O1x5nEpgwevco0WIpFStjVbjQKY4tpb39TiiNdz
         rW8+mCRvAQuaGXIBYi9jTyfLqW0MDU7XPwUNhpAEkGlqVjDVzfsj4n1PYabvZA5hthte
         ey+cAs+IA5I+dwmrMcpcefWEW692AkamOw1I7l0M9X+PygkZt0SF00kj1WKgpWEuWSK0
         txkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jHASHFNH575gLKJTx/QV3Be+6VBLAjZakfImVWb2z0=;
        b=CHH/wpXKUIPUtyXvX2pwr1vad1vjIF85FeGAlKLdZPzc77ekL9UBdU5pobc8s6FfZI
         cpJDUKWiW9wb8f14byv4xVHqq1yexMOfpUE4nISMQaYJ6bmdFJqMNgC9aTKNOqQCuD7v
         Zvhz2l1aOXcozbl5TT1DFuGxbpQnaycvOklWHKSuu+d8UMnxc0hw7QWRAsHZSpq92uGu
         cUQkRuIgUK40wZdXum1+9jclhV1wHbFLHovx6DIRx0G5dsk+Z5pitcZOdSDCf5wFYO+w
         P4HZPiDBjdklJl7PleR4wPmICV4I4AauB3Av0EvPLMVQ6u0Z96VKPlgLzHpJgWx2xMoQ
         RbFw==
X-Gm-Message-State: AHQUAuadJI743N5WcIR1YbAuYi6d8NoDDzTVI9b9zwqgiR/0WdN2XER0
        QCtvspf3CRtYcQ0vj62ua4W6SFClqFE=
X-Google-Smtp-Source: AHgI3IbPRTnrQpzbsmu1pKbnnB2EubQqfZlOETJvTYyfNA32xVOpPZszCZuSH8HSe8qH/9cm9bqKdw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr20881816wrm.127.1550766393089;
        Thu, 21 Feb 2019 08:26:33 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-31-195.w90-86.abo.wanadoo.fr. [90.86.86.195])
        by smtp.gmail.com with ESMTPSA id a8sm14688007wmh.26.2019.02.21.08.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:26:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()
Date:   Thu, 21 Feb 2019 17:26:27 +0100
Message-Id: <20190221162627.3476-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We only build devm_ioremap_resource() if HAS_IOMEM is selected, so this
dependency must cascade down to devm_platform_ioremap_resource().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f82691e1c26c..5f837f2e4f41 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -87,6 +87,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  *        resource managemend
  * @index: resource index
  */
+#ifdef CONFIG_HAS_IOMEM
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 					     unsigned int index)
 {
@@ -96,6 +97,7 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, res);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
+#endif /* CONFIG_HAS_IOMEM */
 
 /**
  * platform_get_irq - get an IRQ for a device
-- 
2.20.1

