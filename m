Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9402C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94384215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6fuKEms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94384215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeHRTEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43222 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHRTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id j21-v6so6099028edp.10;
        Sat, 18 Aug 2018 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MZTAS1Iy0icNe6ggrGcyODXbMAedd10yzkGmnpxDcvk=;
        b=C6fuKEmsy1bn5SlPeUA9iNKVk/3xrr0/WQClmB1VenyMkT6JDI/OftPhkvEJ5cCguh
         HKGfY8U0RhOBbpxfNrLROhLwOoGAn0xU6T2dVQ3f6bJcXa6EevGuI+AtudpXrf95kco0
         ulEo9EcAfQElcU4FgY96K1ei0kjITg4WK6NwVkWLxi/EPw8O52Yb25TpUt6d0sW+7agY
         RcpPs0TCp/eefKfCvFRC//Mem1hiGN89UoljipH5Ze6v+bfjXYDq8fGHdIkwmqXHFZ8S
         CmcxH9QNULx/6Rr4wfoN3UYNGrHsHPFIQfU04Fk2UpJBZMiOeKFeNTzoUOHMmHjDLJc4
         CMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MZTAS1Iy0icNe6ggrGcyODXbMAedd10yzkGmnpxDcvk=;
        b=isXM3Ry8W3qI1JAq40MGGh2BZylrGnNG1NykGJ0/nuES3nIb7l4YHBCqXyws93M9no
         RuS9GK1cnlEopHYUpuQarL+cLR845KkAxCcVVPNWogbrD01urhWZPjsPobUiGEaw27wj
         sZC3q418qWJnrbrSkFfEAiHKY/cWwV4+555acP1IfIWdAW0pAKWPBFNTlCNGYbiHIbC/
         C2OfeWBGAYYqzR4XPODpqIncCfYIRpCS7BjR7YAV4yiUmMLb6kXk9RTNibK2wWnrhqy7
         oyVmbLhoelh/z+/2XBRw92/Pp9FmZxwr3fG97HVuQDNYPPqatQhF2GE5/lN53DYuv+8o
         zu3g==
X-Gm-Message-State: AOUpUlER39mt8hJy4JZqDamVBIR0sn10QB7X/mH+Gd8cCcSMvvwBd7sq
        T8+4HmPOAR+KHUKjLq0f16I=
X-Google-Smtp-Source: AA+uWPxeLlz4pEGLnCDPnNyfPW+w3yd2LM6aC1qfeu0LuVOC9nithf5rjm2bTKY1y7AvATrleRt38A==
X-Received: by 2002:a50:9704:: with SMTP id c4-v6mr47479849edb.246.1534607755525;
        Sat, 18 Aug 2018 08:55:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/19] iommu/tegra: gart: Don't use managed resources
Date:   Sat, 18 Aug 2018 18:54:26 +0300
Message-Id: <20180818155430.5586-16-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART is a part of the Memory Controller driver that is always built-in,
hence there is no benefit from the use of managed resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 9f7d3afb686f..d019ae8ecfc9 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -171,7 +171,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	struct gart_client *client, *c;
 	int err = 0;
 
-	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
+	client = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 	client->dev = dev;
@@ -197,7 +197,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 fail:
-	devm_kfree(gart->dev, client);
+	kfree(client);
 	spin_unlock(&gart->client_lock);
 	return err;
 }
@@ -212,7 +212,7 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
-			devm_kfree(gart->dev, c);
+			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
@@ -459,7 +459,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 		return ERR_PTR(-ENXIO);
 	}
 
-	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
+	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
 		return ERR_PTR(-ENOMEM);
@@ -468,7 +468,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ERR_PTR(ret);
+		goto free_gart;
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -506,6 +506,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
+free_gart:
+	kfree(gart);
 
 	return ERR_PTR(ret);
 }
-- 
2.18.0

