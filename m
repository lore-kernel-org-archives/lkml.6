Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C222C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEA22082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHCD/1eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEA22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeLIUcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41103 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeLIUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so6487561lfj.8;
        Sun, 09 Dec 2018 12:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvtE3j8jv8WMI+maoi1pX5b2nmVnfMXNrNVRmb/ZtBk=;
        b=aHCD/1eW3UYK8kmvflCjYqnlxh8qUYWEMnxxjuJGY1zhNnZHNfMAr0KwjkvMRsZ2oR
         kH2E9apPiWaGV+vdRYAuqKbjpbxXlkWcO1MD8+3J2W8duIMWnRhHDTxUEo6vdMdQJG/X
         fL5mnomATOJ4qKkJa+zLvBjP+mNxIF219Oo4anfus/fFs0i7tbDmMjxXXMjL8hCMnf3k
         7fvrriCeijJPKhwmNnyRPv07i6/gYEFcg7sVzOfE3aNtWv5SPlSCLV3K036wF79KuXmN
         6fkBBRc86U7Tq83ZElF19f7zCYk4lI0mYQpBYVoFqsQQNUpfCOTsC6RBxYA0Q1ssgaKZ
         /IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvtE3j8jv8WMI+maoi1pX5b2nmVnfMXNrNVRmb/ZtBk=;
        b=UNfWjHXGYDWadn35F/L2wZ9Q41ZdUKE8J6AEV7Hy9F+jkRm7U5DrWvPMwb2c/G9X19
         1Ehz0UY1zbh52qnvM/p6hFn3pNDeb/3uaPWB38FFxeQQq3y156AhdBBtPaF73U9y7W0l
         dyiI1UQiY915AG81fUEtqqz28GXGhFklGhwTA7J4uLwt8uCG60aPUFnvPc2kwrs+Du9v
         eKS74HL7WQu8TR7Io1Hk9dgbOKqLlwu26qLYrHuTMk/STKsJZ3CAGhrbkJk7fikfkOxn
         q2yLUOp4zTHw7qAr1S5vCXy4oVUcXJxJx6F6whYhaXMe3zaJJUs6f+uX3Md6LQgA4KRu
         9LFg==
X-Gm-Message-State: AA+aEWaTxjrjBxL/6G3ZN/gSWG2jbWGr0N6mZRjDRJv8Kab9ucH/GJZf
        mrjDnPP9YMoPv3VSESwJJE8=
X-Google-Smtp-Source: AFSGD/Vq2o3gt6WyzdTVIcKqyn1K8c4u2/ZjrkrbNrBzqNz0RlY+jnrNsFQR8o+NUIFVX26vDd6CFA==
X-Received: by 2002:a19:c203:: with SMTP id l3mr5123243lfc.113.1544387473861;
        Sun, 09 Dec 2018 12:31:13 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:13 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/21] iommu/tegra: gart: Fix spinlock recursion
Date:   Sun,  9 Dec 2018 23:29:43 +0300
Message-Id: <20181209202950.31486-15-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spinlock recursion bug that happens on IOMMU domain destruction if
any of the allocated domains have devices attached to them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 0a72b6afa842..d4a642c636f1 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -197,25 +197,33 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return err;
 }
 
-static void gart_iommu_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
+static void __gart_iommu_detach_dev(struct iommu_domain *domain,
+				    struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
 	struct gart_device *gart = gart_domain->gart;
 	struct gart_client *c;
 
-	spin_lock(&gart->client_lock);
-
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
 			devm_kfree(gart->dev, c);
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
-			goto out;
+			return;
 		}
 	}
-	dev_err(gart->dev, "Couldn't find\n");
-out:
+
+	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+}
+
+static void gart_iommu_detach_dev(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	struct gart_domain *gart_domain = to_gart_domain(domain);
+	struct gart_device *gart = gart_domain->gart;
+
+	spin_lock(&gart->client_lock);
+	__gart_iommu_detach_dev(domain, dev);
 	spin_unlock(&gart->client_lock);
 }
 
@@ -255,7 +263,7 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 			struct gart_client *c;
 
 			list_for_each_entry(c, &gart->client, list)
-				gart_iommu_detach_dev(domain, c->dev);
+				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
 	}
-- 
2.19.1

