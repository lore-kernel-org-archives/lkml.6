Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67917C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC3820851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9ed7zXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC3820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeLLUyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:54:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34944 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so8894929pgs.2;
        Wed, 12 Dec 2018 12:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Tj1qjXBLfnkSsUTvtTCTA5DtXU5UPAVlSS29eIqWoA=;
        b=B9ed7zXr5XKp9qIXeR1KqSLSAjNAYea42kG5h9kS+kXbwfdRhnGyVwj+YlYQpoujd9
         fbxSplbBUUwbXjHHB8iOltO2Opbdf9r6h06rbY5CCllk628TPtqhPZBihS26hMAjYj4t
         i26CzokaIRGneISdPEUvDooZIJzTvBvbTNZHuBXqDBMrLPjezpl2UcEo/uEQtgBpbQLC
         jH7rqHOOO+FlqZd28st1w2JZGL3WlA32mW0QglIRWKvleZ5UsUjmu0Y75I7TWeMiRHlY
         TaJCyFqZH9NHUNzGSrR7KqDUm1tFw2H7IB/BDcVZpGQMegLrzKgYqXRrC1drCiiw17pl
         oHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Tj1qjXBLfnkSsUTvtTCTA5DtXU5UPAVlSS29eIqWoA=;
        b=Hk8BE7vWSR8K0euPjS9X9iNnwYP8plxXNaojtVaoFtZK95J3sfXhinC5Uhj4OtNedE
         NX6LWjsz7FiJgj3YJSDeYxRsHV8DUmgEMOy3ihR4nuKfHkfdyG0woxT3SIzmVmMqsnTw
         KQQFs7kOzWYcgOzZp6qSAk5szAnng1L9Z4EgbGeh1eEWFx4E88d/npPdN6leECyVXkVF
         yT71+RECrF/mK45PXx/jDbLC/3e4r/vwidQceycE0sXgxyH4HalTzuIeN9N0YFxSZxDu
         iCclDwhlhkNauLOlDE43XMBnmOmcw4h2SP03G392EMlyftebpTBNNmVQxw23LOTvi2GK
         aYrQ==
X-Gm-Message-State: AA+aEWaomKaDX9+taL+micetOSIhpcPIPD4BVoRoguJ+DvczUVctC7XM
        64iEiYlHfeBOuBiazkNNsX0=
X-Google-Smtp-Source: AFSGD/XuWdTJEIuIHBSRWwGd6X+5LyYf8AGc9j+bfFnrZIRHiRDJsI7aNbwnvImk+NP74gax8AHZeQ==
X-Received: by 2002:a63:26c1:: with SMTP id m184mr1038815pgm.367.1544648038165;
        Wed, 12 Dec 2018 12:53:58 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 19/24] iommu/tegra: gart: Allow only one active domain at a time
Date:   Wed, 12 Dec 2018 23:39:02 +0300
Message-Id: <20181212203907.23461-20-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
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
index 7fdd8b12efd5..71ff22be9560 100644
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
2.20.0

