Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67CCC64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A698E208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm6D0m1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A698E208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeJAFYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45353 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeJAFX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id m80-v6so8417217lfi.12;
        Sun, 30 Sep 2018 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5abOcOly7V3l4Mn/u5KX7PNvFV4evIUrlxOoa0KgHvc=;
        b=mm6D0m1beLEg92UNi9KNjVkqZSGJVwP8dXNYGOin//ogpKpEjEowYzKXiMdoWlN1vc
         BJttH9PosE0jlbR0BQ373FTDcVoE7VYWFSgOcHeccCiHtGinsuVAW9a7/gk9I5LJdhih
         ovEucsDEe+kQ0JFtmjf3qSyqOfZ6/NkhQ1Trn0SbOVk/OSMAX0q/EngTA2dpr63nSHGC
         ajnsy//tS9GKu3sTPNycKYORodFNtU7LiYrdJwV/cjVoyZ0Ic8FBhvH0Abqh7iWtPfWu
         jG+G/dlJtFWGPpc9hUUzr6bRcczKDJSqijwuT9ixQcVQFtL5PEqBeLbPSgnJDJxoNwnL
         ErNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5abOcOly7V3l4Mn/u5KX7PNvFV4evIUrlxOoa0KgHvc=;
        b=l2SoBDinl10uiLkVx3CEjEszRhMQY4OkzbMOT6NFL7gmo3X6qgmef3BOXo/tanXTS4
         U6li0AWvohuJbwb/o26mYjiDuOhGgUTAc60BJGT4Dfv7n0zAUNg5N/+jbKX0GnflvsVL
         sfje2k3igmn2Eq3QgwQdQpJuYX8mZNH04bPeOuwpowYDhcfkTvoJo2wo6CUfJjrVogYT
         G4ylkrQAv8RKm8Yg5Cg1AItQ/LhKay2peNHD1BcamRKphV3QCpwBnJKdkJdyyY44zV08
         QT+xibld9vdAvZknVHtkXiDGwS2vcLYbWO08vfHvDXF6HH5dD+y+/IEL/CJ/QPm2W5aU
         TXSA==
X-Gm-Message-State: ABuFfogsbZNKCKK9opTpd+MVfoLGGrnnKmb94El6cRhNJ7yMac4qdErG
        EBjj/eTKJmy8myGhmTpUPb0=
X-Google-Smtp-Source: ACcGV633J7b7SgoGp7ghoUAuavaGp9IfbHe/sHtXZu/hDAdf5moD3VRER5irGiwBwHhKJa7zAy9Enw==
X-Received: by 2002:a19:3bcf:: with SMTP id d76-v6mr3776423lfl.126.1538347749600;
        Sun, 30 Sep 2018 15:49:09 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/21] iommu/tegra: gart: Allow only one active domain at a time
Date:   Mon,  1 Oct 2018 01:48:28 +0300
Message-Id: <20180930224833.28809-17-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
index 1d45b023adea..9f7d3afb686f 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -55,6 +55,7 @@ struct gart_device {
 	spinlock_t		pte_lock;	/* for pagetable */
 	struct list_head	client;
 	spinlock_t		client_lock;	/* for client list */
+	struct iommu_domain	*active_domain;	/* current active domain */
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
@@ -184,6 +185,12 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
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
@@ -206,6 +213,8 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			list_del(&c->list);
 			devm_kfree(gart->dev, c);
+			if (list_empty(&gart->client))
+				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
 			return;
 		}
-- 
2.19.0

