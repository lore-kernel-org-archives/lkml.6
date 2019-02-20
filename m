Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0660720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjsInBN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfBTE7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:59:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45997 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfBTE7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:59:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id v21so8301460pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GrPVf3f3smH6f7udVG/agaLjSqZZfKta/0GjZ4pIsL4=;
        b=gjsInBN0fn0CvNWxvIVYgxypGFQ8kwrNgSwA1Kd+N6R0eCH5ZHGel9NNstoiLFibth
         uFuWY9eDqi3lKGa1xKUMTZGw4X5KLEyOjNIfnsWalGjsVwkUOQFAQM4YPDUsY55St3Z5
         Sfs7TDP7TfAhnJvbM213qQtyZUm5KwQDwfvaBCnwS4ToEctNUNkeb3vWMjAM9c6PUYfs
         NgP++9lOh973WakRt8LUGHZtMdhQyvjkdvHg9bfVDIq1+C3uA/mp86PvfEHpj1fA9LDJ
         FncKo/1YJaKMtcmk+lKjeZQ9xct+88bQgDZsdhPxkFiA4siZM2FqRh8/7UG3c1O1qNId
         7zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GrPVf3f3smH6f7udVG/agaLjSqZZfKta/0GjZ4pIsL4=;
        b=Uem1cePbj11mCBFu7ayZme3l0aZs4p3a9roT7o8CcDMf3NCTmbbP8KrnsggQWjeXlb
         foMzTJTxK59e5yIvW2CvJ7J8wlSBhVDmvu+bSbkvcQLScRJ/JOKphHxOOyuBTKpC0+Rx
         CnrVxO0aPJiM+vcVNOdRbtOEwuRE1VGlnChYq1nwuTa830ORddqV7A+PvmXvx9Zt4i8V
         DnzLuGCoS9u3205jQY0Xgc2WGbuZwm7DbvT5ld536CKNyuORzNJoW8gZr+unL/e3qtD3
         +yPGWZzFZhgbzhck2CP/HMgY9R1TC3KgB2vLzwLeU8fzBeCRyWLNfjZ9NSK+/ZbgwUK4
         cXaw==
X-Gm-Message-State: AHQUAuadXEJtOX3+fDDEEgW5KHjzCAa5zlONiI+hqesMrzuk3iMxisky
        lCw1IF940b7eIOJWvvZgFJDsH0qsqIc=
X-Google-Smtp-Source: AHgI3Ibf8A/25EM0O4lRrHzYt4llbIjE+6l9E0LVG2LLOrJLjE1wno85JyMyG6DrVvp6W3ZpDt/BsQ==
X-Received: by 2002:aa7:8150:: with SMTP id d16mr10126710pfn.172.1550638794140;
        Tue, 19 Feb 2019 20:59:54 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id n72sm28493966pfg.13.2019.02.19.20.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:59:53 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v2 5/5] base: soc: Export soc_device_register/unregister APIs
Date:   Wed, 20 Feb 2019 10:29:46 +0530
Message-Id: <20190220045946.7452-1-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Qcom Socinfo driver can be built as a module, so
export these two APIs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
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

