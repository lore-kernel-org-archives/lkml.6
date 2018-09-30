Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40193C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B53206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXGGGzf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B53206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeJAFYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41744 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeJAFX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so3318928lja.8;
        Sun, 30 Sep 2018 15:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4Mi4UuJVD9VS+LyrubAJEL0CQgvXXiykgp+9dSMsmo=;
        b=dXGGGzf3YfmAQoyGecYZhVMg7tdwvRWnQaBZBfpy9SaUeOZpeidP/KWVWAtpBW8N89
         7gMAR8XEUlbP7vyJ83N0amzLnfBnpoaCa1Oyn0Vio0p8K+kIkNfia5OMFvNd4PM2YEYJ
         VLby6Hwg0ADb+SojXOr9FJ+LKraBj6R9V/sqx7BTnNGQ2jHneXMw1dvwLQOp0YjgYan/
         sMA8TfIwwanwlq1M3yCgJav9ut5NdrAGEJCd5D337TAfsO8cEi35aPQqRnnj4Bx5m6RV
         FhUEv2J6p61bX1KX13tvqYIPCNgDd3LYOO0VXALctb0prFIrsuejTJsH3QKALCsfVzhX
         P4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4Mi4UuJVD9VS+LyrubAJEL0CQgvXXiykgp+9dSMsmo=;
        b=X/1+CwwrfHlL0tD1bRWtqRBWMaJPXeBvOwNrpj66G3dg1ehyIRmUc+A3ooBoUwsSe/
         99uHurHJxxJ370dLMC+GewL4fMG7x/5yCn6jINAknaAMLsah3Ty3T6EUA5F7pMR1DX/Q
         zl0N9Ps9yhM/DjQr+RGXER6b2Fth/o1FXOf5faPLRn4teP6Z3bIe9lD+FYRZaKFEWFm8
         AZyF5w7vXrlXNTiZtHlDyr5KUQhQGMMPrgrxL+TRKGETZ5S7D0njJ9rwTJ8wu9AGv7km
         N7vhIO2ETlgikLrJSwi7URIMw4+FNoYmuEFlY6PbG7NZGX/l0OOUH3FnOsyg32nQ1LsX
         KIRw==
X-Gm-Message-State: ABuFfogDSOSv8QBe5ikYx59tZXwBMECSTtcNyl0TuH6DF6/7QwO37LBT
        VRtN56SkVYBl9ULyAY4mWvTD0Rnu
X-Google-Smtp-Source: ACcGV61wUMRovLON1MElFsQ0WsQ4JydXWFsUxdNDTfn7tlPq6FgiXoVnTKjSpVNHcvsAyLTcbu+sVA==
X-Received: by 2002:a2e:6c07:: with SMTP id h7-v6mr4516688ljc.81.1538347747554;
        Sun, 30 Sep 2018 15:49:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/21] iommu/tegra: gart: Fix spinlock recursion
Date:   Mon,  1 Oct 2018 01:48:26 +0300
Message-Id: <20180930224833.28809-15-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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

