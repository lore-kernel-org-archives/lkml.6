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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6CC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83DD20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW6LuAE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83DD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeLIUbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43151 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeLIUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so6489281lff.10;
        Sun, 09 Dec 2018 12:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BRH3guyXjR1Gzp08Whw7GlnOA5eJBdBF2Ah4nroPQU=;
        b=MW6LuAE1E+kNbgea0E54JRrReA3MejMHqYlMidDHArFoaAQGfrk28oDxIlQsvaphrT
         drYu2Xb2N+x+jMq+wB6XFK+Jg3GB2tYrxn11ZQfpUfEEAPl/0/IclNj6Pn4IevMIGS3M
         +ZpHiLPl7FIBkHbpPjBfRbL41SZocXRt+4kYNDAwxbp0nyVRwnCV6oG50PZpChbqFqHw
         RpFlVJvjqxoByKpn6UQjQRWHtSEPZnEXaaXFiOzy9SLSudmsxQ6K61/FIrC/AZ7tL2ux
         iMQUFo6CjJFptdf/ws3EPPyNj/9PyVZZEMC16XDGRDq9oWKdgHCwnIsGk4d8dUypsaSL
         E27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BRH3guyXjR1Gzp08Whw7GlnOA5eJBdBF2Ah4nroPQU=;
        b=DOIs39kOuq6rh9CxsE4wDFac2mv365V1YloXMxgypfkGCo/IjKy1wE3wvu4RgfU8fk
         nxxw3AwJFhIKtNkniIlyOMzdr7KLudDIQwMx8dENU/mh5BopbKurnxW0gP/2eO2qPRub
         SvIhDl1VOrxJURY0YnWPXQ5UWAy//gUaaA5QXAK3ym7CDJspl+ZxpYqGPQ0WrAYF1YJL
         O+pE16Fv+35AuzAiJS4zOseu5nXe52AGzeCGKzTU2YM4+Pin1Hrcm7J34p84QEM0w89e
         ijNU8Q4z6RsROalMJXnWYOH5Ik8QtCifO4vrWJ6KUOZAWu46O4aLq/r1otmlgVHpg0oC
         zSiw==
X-Gm-Message-State: AA+aEWaMpSMVUJpCKddOmmIRtr95jX/bLVngzQKWMZyKBXgWkjEh6W3k
        +7zp2BJqHLni+at3ErQOSRA4LDBd
X-Google-Smtp-Source: AFSGD/VhOneilHoYYuTroqyRnWgr/FX6/dzfUUjjvVG5VnFOhJO7zR9wiF7Blg5QrfDNMn4XdhTG8w==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr5630535lfi.57.1544387476377;
        Sun, 09 Dec 2018 12:31:16 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:15 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/21] iommu/tegra: gart: Allow only one active domain at a time
Date:   Sun,  9 Dec 2018 23:29:45 +0300
Message-Id: <20181209202950.31486-17-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART has a single address space that is shared by all devices, hence only
one domain could be active at a time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index bb5303b06845..1be595d15e7e 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -57,6 +57,7 @@ struct gart_device {
 	spinlock_t		pte_lock;	/* for pagetable */
 	struct list_head	client;
 	spinlock_t		client_lock;	/* for client list */
+	struct iommu_domain	*active_domain;	/* current active domain */
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
@@ -186,6 +187,12 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 			goto fail;
 		}
 	}
+	if (gart->active_domain && gart->active_domain != domain) {
+		dev_err(gart->dev, "Only one domain can be active at a time\n");
+		err = -EINVAL;
+		goto fail;
+	}
+	gart->active_domain = domain;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
 	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
@@ -208,6 +215,8 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			list_del(&c->list);
 			devm_kfree(gart->dev, c);
+			if (list_empty(&gart->client))
+				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
 			return;
 		}
-- 
2.19.1

