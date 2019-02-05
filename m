Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C319EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E282083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RSbmwGTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfBEKZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:25:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37099 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfBEKZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:25:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so3007504wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EpyubzHmpBYIwWB1kg4OB1nrghXCzVSBiVe35BMGlw=;
        b=RSbmwGTBNDzgAS9Lt5lvqih71f9/sSFeCPyK4eSrPS/tAUmSE0BmxWJCL8iRsztWa2
         N7Ey0QqNAJhyEeCLmi75nu9eEOqEjoEG5FevLevCJl1b2OVPUxoPEM2eyBrIrDbN1H0W
         0Ru8fiaYlFq9ExKOYyTigL4V73NED9/XzLSrl/vUT6d9szov+BqWikXT6kP8sXQ5SCIX
         ZcXaTp3S3O745Pm/38VvFntkDoOAqG7WnAGlYE1EqszR0ArSnWRZcadksSZTJ7SMCpmz
         7WyIHZiKwtdqx/e/Ndmjz8UcCWYJbQ8H/jwC2TmZMVMz9rDQU+ZgWTENIh2McrH0dvvK
         6UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EpyubzHmpBYIwWB1kg4OB1nrghXCzVSBiVe35BMGlw=;
        b=AnxMiFmIG2QQQ7xFtoVe88GjZKCdigROsLd8GL0OlC8UqEC/WlnmZlDNpRMlCUuo4q
         9WGZACVaZyGwbBehJguw8SbA94ZOChVoGQkP3EyBrmHSa5YFiIAjuk/U/NNqGX2Tc3fp
         bK75ZHlI84hFafsbkDDM/n4uBFtRrWPojEG6KgsKoVGJl3rlFH2segCai0UcK3vuKJF8
         e99bRhdhtz9DN7dhXdUPCHNMWRCRY0uCyy3BPHrJ6ZPGizBdxitT7/bRtaiCpDsbL2Tm
         P9YK4bvTie44VHt1Rwyl6rO1o/NeuYzAHBS8dcHzE9OVAOLZZrUW8kxy7/CQIpwRElkg
         Jjsg==
X-Gm-Message-State: AHQUAuZAVv/VpDYPtCkHv5eC9oPUonwSC/5HipvhdWBnl4dvWTpsOuBE
        DMLXBv5h9o6AIbX4XusB+n+sbg==
X-Google-Smtp-Source: AHgI3IavTgvkr8R3vGnWMQgauROLW65WfKaGxIbsFxWdWDcT0vKa4XoS0uCH6ylybl6tTZuKkciMew==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr3118795wme.120.1549362351739;
        Tue, 05 Feb 2019 02:25:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/8] usb: ohci-da8xx: add a new line after local variables
Date:   Tue,  5 Feb 2019 11:25:39 +0100
Message-Id: <20190205102546.29457-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This improves the coding style.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index a55cbba40a5a..c492c7e6f746 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -405,6 +405,7 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
+
 	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
 				dev_name(&pdev->dev));
 	if (!hcd)
-- 
2.20.1

