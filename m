Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95892084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TCld4ftq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBKKhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53282 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfBKKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so16811020wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNwPEUUTlCKX5Tqu2ze2gsmyzvW07YJCGJtag7575fc=;
        b=TCld4ftq4o8gIrjIznjZq3jxcUZNeaxWAv8Iw0vN33auSy+j/cBSUURcWRlCrpTsyB
         tB+fj7UL22HKjx+Ez8cDvi2t/KERMJRTsbklW1HGgHSJawHsbCHqsTNlyEh68oJ5YwGW
         jKDoDC9+w9yhuGPmx8JFssA9SnzFQFrNdddUGUy7z3gmrkEYjtBilyoWErP5Vou+xDFN
         in+55gJWdO7Og5X6ajvsiIYxeZMrJ7pwhoJ/VAWYdoZ2vzs/Vqd7YRZJfmxczpC3/gFM
         uN4O6lx7oRlSqsvABBtqy+GH+FEpQ7ZZuQOQUY2xjZpup6KoFrI8SSasJxw9hI/uFcjP
         WLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNwPEUUTlCKX5Tqu2ze2gsmyzvW07YJCGJtag7575fc=;
        b=H5tMvJsSpi+Pot1ALwHKDXEtRju/ygkQll0aB8IWsJr2YKnIZTOwmzcYnwiPmOUZyp
         l2DHMiRCIYBQS0wBAKzVuGwfbKQDd8Hr2NJcL0T2MS4ZXvfOp2lc4P8R94Ul5Huj8Ibj
         FIg9zszzpeoX4+yYa4E7Q4n5lgLvY2Nfn0kYN0YWVYFNPqBNADZV+shvEfr0vN+5dw3/
         eUvzy8eVRaYYj38u49ES3uAn47R885w6bCfaPw143wehaFLngykT7cGV0BzZ9+sUQuq8
         6IhcWfLaEAFTpeOKnYpcAi70w6zEi3L0YlIHynKLt54j27yNmx1wIfNlrQmBCZR58xHh
         DpEw==
X-Gm-Message-State: AHQUAuYJdMLkReABzzQ7uzB7umVfG+Zw2Bc3mYlOD13YGerx4KXzLChR
        jtZrA0WGQJKYWr1PTzVYCFoG2w==
X-Google-Smtp-Source: AHgI3IapcLHP60sKSGdnr6I8oTwK59n+VObCekkqjdq2A/HslDpU3Tujq3LohKnrjKJC+aDBWpfZVg==
X-Received: by 2002:a1c:7a18:: with SMTP id v24mr8376506wmc.107.1549881427522;
        Mon, 11 Feb 2019 02:37:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/8] usb: ohci-da8xx: add a new line after local variables
Date:   Mon, 11 Feb 2019 11:36:55 +0100
Message-Id: <20190211103702.4277-2-brgl@bgdev.pl>
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

Add a new line after local variables. This improves the coding style.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
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

