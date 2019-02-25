Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFC320842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlpUbWav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfBYGvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:51:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32961 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfBYGvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:51:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so4044446pfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 22:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=brSEkqPU67+YSKKICmWqvC8LaR32/XJ1b0KQTf20AHc=;
        b=DlpUbWav8CGMsKhKQhOnxldDD1RkkwaoSGca2TYWW0qDeFC//nEtAAQ4nlnoiZ4Dub
         Jn2dReYOZTaMmbxNTglt5YSMVCFVvmua6OBvSwBs1SAbUwzIy2aBk84r9HBJjDzRwEpy
         x0JOKL9h6eJgEdg3MdG4UxqgElrFsyJUtsoHqhGpdrv59THioI1XfCvGotwPt4fQfXpg
         qWKV7b8vi+Tg3peYVw6mBwaUmmA4oubYQQJqPorsfc13e5i0S7JRYkk4D2D/a1p/hwdV
         4ZWGgULHGtyui4hubEhCMCYkDem9Rl8IkbtkgTI12T8oOfGFoXAy/WXnF4ara+evF6Pm
         4mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=brSEkqPU67+YSKKICmWqvC8LaR32/XJ1b0KQTf20AHc=;
        b=kJIItskv8w/HDVLfFjhKcxHUB4ZWMjHZ+Ut4I9ARzcRXlnnEZY9T/H1v/Wf8/iAkN/
         Iz9zxseV90Ny+wLmlB/zeLmGlEVHu3RepNKZyHYY6FvgJCdslWyDv0TYhcs68i+KiKD3
         roGHjPW2TYSw7Or/xWuo4WBtIwxxYppzLS1GKx+S+86UPC8F3g3YiluRjpHWYkaedvlc
         LXYamtkTMpnuVcy0LOSj8sC/AV/w5Fjl9pHphiIdfzheyZDfuorSst7RTwH3rQJUI9l8
         c3H6oomOuyRfEBoDpE13P5AzPF3GPmfTLgZ+oOjV8MfenE1T/7VeH89nz4jueNMKiydy
         Bz+A==
X-Gm-Message-State: AHQUAuYLY0tclwBR0TPQVGQdCFSdxC8KczYOrm4JAmX5z0JyLFLNsbl1
        kz3msYEPL/WzaUm7wcrFJlYWgg==
X-Google-Smtp-Source: AHgI3IY8YFhFT/p/K0UUefQOeLGOON5wxjnKMmRkYClZF88EUb9NLG3Yhw9Fp7bGTncNC0zZIQoUpg==
X-Received: by 2002:aa7:81c5:: with SMTP id c5mr19012538pfn.217.1551077461503;
        Sun, 24 Feb 2019 22:51:01 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id f16sm9990021pgg.20.2019.02.24.22.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 22:51:00 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v4 2/5] base: soc: Export soc_device_register/unregister APIs
Date:   Mon, 25 Feb 2019 12:20:41 +0530
Message-Id: <20190225065044.11023-3-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Qcom Socinfo driver can be built as a module, so
export these two APIs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Changes since v3:
	- Add Greg's reviewed-by
Changes since v2:
	- Reorder patches [patch 5->patch 2]
Changes since v1:
	- None
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index b0933b9fe67f..7c0c5ca5953d 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -164,6 +164,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 out1:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(soc_device_register);
 
 /* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
 void soc_device_unregister(struct soc_device *soc_dev)
@@ -173,6 +174,7 @@ void soc_device_unregister(struct soc_device *soc_dev)
 	device_unregister(&soc_dev->dev);
 	early_soc_dev_attr = NULL;
 }
+EXPORT_SYMBOL_GPL(soc_device_unregister);
 
 static int __init soc_bus_register(void)
 {
-- 
2.17.1

