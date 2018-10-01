Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBC4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B44C2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B44C2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeJBEXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:23:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40385 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBEXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:23:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id w67so5418730ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izeOu+0ONa8a1oLSVbpVAkQ9ixGaZeWkki3gl1d8nyU=;
        b=Lr4SbMajKCAYWeqCEoR+F04S51C3dPR6pn8sbBtTtO9q+lY1WK2uRSB5hqoYGCqMxe
         pOZPB2Uh8cB8gbOeC9mIKK8eoRtHa0AFbS5fyHX7efu7ay+mPReutb7MtfmNYfE0Nu1o
         n4rN5ZRs8oWAUAhNkShZyvak6ZkdUpHKzLsZieBlFN/xONa24VWWpFzcROPN7bt77wlD
         Ja0lAnJrqIzdMRPq38LUK8vC8ppMq9AkK52DHd0YXFFzjKGSZ+bd2f9fsnyZFJ8Hst/W
         A18brbrOW8CV6ibDbNnihrI1jgEM7emqjkgR+nDMprP8XiqbVCxbfQND3BPrEqNkFH7g
         YWZQ==
X-Gm-Message-State: ABuFfogoxZZFFJmQTsKSLEUbIbqtC+0hD+VztOWBlAO1c8eL6ASKYjc5
        Fbin5e/abvu6G1vdRxrmyYkh6mOwIQ==
X-Google-Smtp-Source: ACcGV608pvfVYjBqyoD0jpMEXj+8IVVr+oa3umf+H27tlEDGfP8QmaeZ/av1iZLh19hYADx7uJ8N3Q==
X-Received: by 2002:a9d:6007:: with SMTP id h7-v6mr7241421otj.295.1538430235420;
        Mon, 01 Oct 2018 14:43:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h22-v6sm6401661otd.21.2018.10.01.14.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:43:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] uio: Convert a few more users to using %pOFn instead of device_node.name
Date:   Mon,  1 Oct 2018 16:43:51 -0500
Message-Id: <20181001214351.13230-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001214351.13230-1-robh@kernel.org>
References: <20181001214351.13230-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/uio/uio_dmem_genirq.c | 3 ++-
 drivers/uio/uio_pdrv_genirq.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index e1134a4d97f3..003badaef5f3 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -163,7 +163,8 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "unable to kmalloc\n");
 			goto bad2;
 		}
-		uioinfo->name = pdev->dev.of_node->name;
+		uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
+					       pdev->dev.of_node);
 		uioinfo->version = "devicetree";
 
 		/* Multiple IRQs are not supported */
diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index f598ecddc8a7..6c759934bff3 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -118,7 +118,8 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "unable to kmalloc\n");
 			return -ENOMEM;
 		}
-		uioinfo->name = pdev->dev.of_node->name;
+		uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
+					       pdev->dev.of_node);
 		uioinfo->version = "devicetree";
 		/* Multiple IRQs are not supported */
 	}
-- 
2.17.1

