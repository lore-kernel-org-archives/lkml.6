Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA436C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAFC2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebbLroa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfBUQYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:24:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37458 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbfBUQYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:24:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so14072195pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USzj74M59gvJ0Ydb19s1rmXKxEc/2juHtDduMISBNPU=;
        b=ebbLroa7cvk1/WDpxo+gZch1kmqcLROZT//ejrxQixC4HdO/Frf6hdPMgyZq2VUi8h
         bUDDbZS+cq1UU5Q30GudNUTcqxyt80zIRfZoMwXsXM3mLNxi5xiw1MKbBnV9e1iaZr5V
         9bxKd4YbZ39p/czczIDooLSQC3l+V/h6H1iPemEGrjM9kY5WiXsbSzfoKWokjuL9wH6Y
         83NX4t6+ZkTZ4K45QCAeekz8kkp9JLnjMiUbsK6CVM4TeIEa6PQtw9Ls1uvhYXt3YA2o
         ydWk0wUiQf6rietw/Z4EIpPsK4u0mZZEKyHFN+R9wUlVwcKxDJ5YD7b6oTZPhwluWIXf
         WljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=USzj74M59gvJ0Ydb19s1rmXKxEc/2juHtDduMISBNPU=;
        b=F04dQ8vpvX029mwzDDofCCt4qULxu/+acMz62UJ2NTf8fIVQr9/KpHvfuZ0DFh+3d0
         dyxrMlDRzHFPBHLd8OkNGQhhRmsGSVEasKaR/6wMSCLCxbUIElF2Ih/Bj9vudzWEDyXs
         wVaLkfqQZnUjW+83flrjN2941JNct3XMCYMyUkUucc6cUsMpk2FGvsZ+n05/6VHdnQ92
         fkWfWI3XYB2CK5aPeIZPN14m8Rcp3Qz1nBmk54Ot+FRKmNWQD13ibR3b6KXqKId0C9ZF
         BOaLD8jrp6tuo21zV7/Rlqch8/RqdP3VvE+qJ65MIjEXA98aV1f9jLrh3cabL0fDl6lZ
         +aqA==
X-Gm-Message-State: AHQUAuanYuiD9hDMG1spCQ6yH3qC2yxee4PpHUm9dAScAaZMnabCtBeJ
        Dm595l7NNFyv7E5VRGdRaJpl5w==
X-Google-Smtp-Source: AHgI3IZ7ktWdBpqVFrgOXm1fiwMyII1nWmty55efWpOlvYfgQg4DYQ5VyMfdzxX4znv9RyMyZEUliA==
X-Received: by 2002:a63:5702:: with SMTP id l2mr6740622pgb.2.1550766276529;
        Thu, 21 Feb 2019 08:24:36 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id 20sm21382910pfs.182.2019.02.21.08.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:24:35 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v3 2/5] base: soc: Export soc_device_register/unregister APIs
Date:   Thu, 21 Feb 2019 21:54:16 +0530
Message-Id: <20190221162419.32384-3-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
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
Changes since v2:
	- Reordered patches [patch 5->patch 2]
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

