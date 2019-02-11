Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E78DC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E50A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="beupPIha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfBKKhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52401 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBKKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so16798570wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/VsXHRwtVGabkOsfPCt+jyBM76WQDq7lQ5hZjyQkII=;
        b=beupPIhapQPL6ylvBgwwVgVdOaYx4xjqH/zSbKbnraRrx9ToB0FO8C3cPLRquvThrk
         Hkgcm7hibv2CsXLLletboHoKCjIdzB5/jQO8afldqt6jk2AG1GDgW8Wk8oSnZjLL2J8O
         x3AGBoChuKPMFbzPU3V+HiLWBCU9Uy7t4fS6G9jNgTxuZmZ3VLoO/F6y7EiTdfLb20N8
         0/ukPHZgRw6gtQfR6PHXFw3DBo9couHG7pPggCvluJEFPEBeUeVdBe8butFW0OAb5AWV
         SrflHxSjn9wrbFDl711nvf8yhDjpDwlwE1ARLzcRsPkx7MxQ49wLojS7O6a0pR3vxdBV
         6p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/VsXHRwtVGabkOsfPCt+jyBM76WQDq7lQ5hZjyQkII=;
        b=RKLNjLI1ulZX6U9AKPCLXaMNcXDDkdvkraQA3csfHX3LLgBaH3/2fSrPTvbiwSj+3f
         YwJjm8WdNWNOLNkrg6pp6JI+ldto+g/ZQyQsOUDFU981/edeW+2lEe6G3uN95RgYYlqq
         BIPJss/J5Ll153pYMmEJrtog8pSCSdeumkTzeEdf/coNyvCL2p2jm8N5ZZXWSpDXU+eR
         040UhqnQP0FX7KdR7YM8R6VR8sVuEVTQoOu/wIi6E7Viptm/wpMpVGptjfjJmxLtilw/
         kLu8MchKAyC+tSp5ag+J7mOoyB7Xv6AlanF5O8avlRVZfV5vhhzbUukXLgtlVJFFfxw7
         FrgQ==
X-Gm-Message-State: AHQUAuZkBYmyH6ZAsWMKnXse2mlNftE2Q7h9Y6QyRseDB5PEhm28A8Th
        1wssQG29bfrbXWBXfV71qiPWsQ==
X-Google-Smtp-Source: AHgI3Ia4YHL7VkxiIK9g155puXWkq2+zX2KsPf97SnFlvhBgVTX8tMBPASRi53oK4Rsy8sIPMYtZaw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr6467462wmb.136.1549881429968;
        Mon, 11 Feb 2019 02:37:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/8] ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
Date:   Mon, 11 Feb 2019 11:36:57 +0100
Message-Id: <20190211103702.4277-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add lookup entries for the vbus and overcurrent gpios for omapl138-hawk.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 94c4f126ef86..856c5707bae9 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -302,6 +302,14 @@ static const short da850_hawk_usb11_pins[] = {
 	-1
 };
 
+static struct gpiod_lookup_table hawk_usb_gpio_lookup = {
+	.dev_id		= "ohci-da8xx",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_VBUS_PIN, "vbus", 0),
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_OC_PIN, "oc", 0),
+	},
+};
+
 static int hawk_usb_set_power(unsigned port, int on)
 {
 	gpio_set_value(DA850_USB1_VBUS_PIN, on);
@@ -390,6 +398,8 @@ static __init void omapl138_hawk_usb_init(void)
 		goto usb11_setup_oc_fail;
 	}
 
+	gpiod_add_lookup_table(&hawk_usb_gpio_lookup);
+
 	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
 	if (ret) {
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-- 
2.20.1

