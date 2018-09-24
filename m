Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299FA21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5XKBDnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299FA21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeIXGqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37248 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeIXGqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so1424682pgq.4;
        Sun, 23 Sep 2018 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbmP4w1+k4iZZVe/x3jH6bMmJ9XtwjJDAZgIUWobb9s=;
        b=F5XKBDnlsARrOxB8ATLtQRGKb+l4U7TOvPaZc9ctDL+NzDtOop2vPSs3z3qr0JysWg
         8rFIRHYy/464DNKBt7aUdTCOD/ZdajiMR7L+F1TSKc5HjwM7bgv+idrM9ZtmFSZ7N+/v
         J0YZ2VoMW8fNBMKUOsnPP83O7nP8gTn2+mZiyjBvdxj587NhqVCeASDIUx2bbIwvxrX1
         9RbqVFJ7bGG5meOA534K/oB7ObJScAw3Aawb47h1oJeBkDfQ/ISTNAZbuZ7S323DqKZu
         9XtiXtvNNwdvxLpju3uXjwJDdfb8L0voZuuRSJKwMefRA4M3M84s8ELdyAwXT3joY9JQ
         5TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbmP4w1+k4iZZVe/x3jH6bMmJ9XtwjJDAZgIUWobb9s=;
        b=IWDrP19pisbcB9wwR5A9ndBV42qCqJR3+9YLn9S9VNl3MvlZ0Dlrg10Kh+qY0DT5fW
         Hji8odw3fekYhYPGUHMDH4qfV0HKfUfnvPinipyfndTs9EMoOs8zHIzRrPSyonSZe/Pz
         bzy6DDUwQ21lRlSV8YiAEftrXUe6RVl6a1t138pmj5zCvnfDF5nvZb2GA9rDCzIrvChJ
         WLYe8tuZGWqhVEqndsOoz3NhLt2ZXHRcuF4SQs71f2H1zaNE2VXib2/X3fxCDsYIYzUh
         Io9Lu12e/a9Fx/V0Zr7ZpAylKVhbIS379NgGOo2lr18AXscIQYV+ggI1q7Q2i5T89/bG
         fWUA==
X-Gm-Message-State: ABuFfojKvKBlp/JtQrRDFenYnoghUhHkf3dthpzUAIlzW7BFxueSXhBM
        7N2Mc7AwspsmpqnnnMj5eXg=
X-Google-Smtp-Source: ACcGV61iQThEjySxODGCn5IkgXOQWTE0nwggaaRd/yaDyKXm6M7CfvRu3N0PsYXl9aV9heZwdWX0qw==
X-Received: by 2002:a63:350f:: with SMTP id c15-v6mr7307140pga.206.1537750035006;
        Sun, 23 Sep 2018 17:47:15 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/20] iommu/tegra: gart: Fix spinlock recursion
Date:   Mon, 24 Sep 2018 03:41:46 +0300
Message-Id: <20180924004153.8232-14-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spinlock recursion bug that happens on IOMMU domain destruction if
any of the allocated domains have devices attached to them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 1c89b20ba4bb..e6fe139576c3 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -195,25 +195,33 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
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
 
@@ -253,7 +261,7 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 			struct gart_client *c;
 
 			list_for_each_entry(c, &gart->client, list)
-				gart_iommu_detach_dev(domain, c->dev);
+				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
 	}
-- 
2.19.0

