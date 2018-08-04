Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA2C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D4217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWonSiQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2D4217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeHDQg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40335 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbeHDQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so3127577edq.7;
        Sat, 04 Aug 2018 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x6P3Wv19cLOAsi405hdR7itID5XxZbj2n6vytLRGHTk=;
        b=aWonSiQvLhtfOb0lYdoKYrJcAlkdNgCLyNYD8xJP/MqeBF6ebhsYaMEqJoiPNsrArH
         qSbbKgK59xzGbJz5iiq4ZZR0u2BHjVxFswc8DfZv5fxt7TliKIU3fU1XSrI1+ey/GzA0
         lCsSz5wB7F2hfkplloXaUDOQt2C/4E3j5YAIybhBEti54HqxPyxy0R/MIQP2yxfQ0SWN
         Pu7CMJxoGMi3QilW8hO4WS8HsNZKo8Li6dXrkFfGrQ0IbrydkeltVxTb1m46Js5H7Bck
         0emTrVfVh21UpOWYyL3uaQmTBmm3RzYBbCTuVLmzka6/ZK3CI6Zw7BV+3WqaDURsennX
         Sn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x6P3Wv19cLOAsi405hdR7itID5XxZbj2n6vytLRGHTk=;
        b=qAf7zpTpyc+NdwWD70KWUJmVommYVWiIVTUuMf+e/DJB/dMFDa8508UbXWm2RRQ9Og
         psZrlCnq+CXqGHRJeHt6ShFe/FdNqVitVzfEPpkJv0NENe6Zohfv6YtYI7sJA81veQu/
         M2JErOs6eE7ceq3Pm29+Qm4EahvX0LMOVILTdqRkvtnz5ABNV0tJLesZKz2YjTTx6xc2
         nyGXgjrw9aBkBXXNhkaWGqwJH1mz8yQok8GZw/92doZ/dpZsIwokumebYyUAzvgBwxJj
         rNNE4w+B68BmCHHuW3kjqWDpySRjRRUCFmKlrPa/Bh0FWs8S0ucCiwcgcHKQMiXAK0Np
         D/tQ==
X-Gm-Message-State: AOUpUlFNQYX7B3mgiDFbne/Y4dGnsOKDfSeLWJOii86LUoX5tYKUzU/H
        O8M28k8NmpbPi4vT8kmXCz8=
X-Google-Smtp-Source: AAOMgpcpWhcEp6FSTIzMmHYcctG4oG63Mtbxt8m5Q7GQYfBAh60YWHUdyTHbUiqoN58AntlZIYtQ7w==
X-Received: by 2002:a50:f4d2:: with SMTP id v18-v6mr11531885edm.162.1533393334153;
        Sat, 04 Aug 2018 07:35:34 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
Date:   Sat,  4 Aug 2018 17:30:01 +0300
Message-Id: <20180804143003.15817-7-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART can't handle all devices, hence ignore devices that aren't related
to GART. IOMMU phandle must be explicitly assign to devices in the device
tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index def570bc88c4..bcdb8973a0ad 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -348,8 +348,12 @@ static bool gart_iommu_capable(enum iommu_cap cap)
 
 static int gart_iommu_add_device(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get_for_dev(dev);
+	struct iommu_group *group;
 
+	if (!dev->iommu_fwspec)
+		return -ENODEV;
+
+	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
@@ -366,6 +370,12 @@ static void gart_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(&gart_handle->iommu, dev);
 }
 
+static int gart_iommu_of_xlate(struct device *dev,
+			       struct of_phandle_args *args)
+{
+	return 0;
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
@@ -380,6 +390,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
+	.of_xlate	= gart_iommu_of_xlate,
 };
 
 static int tegra_gart_suspend(struct device *dev)
@@ -459,6 +470,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
+	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-- 
2.18.0

