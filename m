Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF3B21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSfU9Rqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF3B21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeIXGrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:47:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44598 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeIXGrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:47:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so8295238pff.11;
        Sun, 23 Sep 2018 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJd5qCvwZt+FEMthacrCaTfBiAsBAEj0Nbh8yr7YEp0=;
        b=YSfU9RqfhF+bLKXSTHxWKI8itgJv7xvcOAFMdX/rGWCccKbwzTm0nHkMaY9yUSZGAx
         RxU9xLsNiQkV5HGvYT2jd+KECQ0OHE8Cdjv5lqWD8NZczrfIvL5np5suat2eE+HSK6gd
         3Xsj1Rj6QJUK/PbDwO2d4Inn3z8RXdATYwnyEdRPpdzK0DvxhkcTXVzlLydPE3e84Lmh
         kZG9HTkD/P3ZFOVG4mTXX6uD31N88mtmbVhFL//7KWUxZvP76Z+ZHN3zDafZC3DQ0tfP
         1RlQov2Vrf98y1HSAZcDQtzoqCxDcS+Iz6p4OoY/rxAA2/98P5aOZpezuVtAIPo+dxQu
         UgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJd5qCvwZt+FEMthacrCaTfBiAsBAEj0Nbh8yr7YEp0=;
        b=X6I64Iwdyu1cyyGSevVINi0w+/BLM3eu9pcU4bG4LZd9PiudXQQ7gKwLxlZ+cIwEts
         MkNUrIQXJiYD9hb62iVufrXn8GfCTpH/oExNUpVn0tB8/nMcXSBsCXoj8R2dmUzgRfg1
         9mVjOsAVGEwXzU/KZr+UlAEd1GYR83dVkQYojuVyi16VM8ROGg6u76rB5F2mOi/0hBH0
         PnWKk+Xo/GyyEyGfKNGIkwa60xLL4YjO5cpJ72Mbdm2nnBdiA4HO7/0CScaALAeaVuII
         2dw6xDWZ9xKXjHYBp0SQgYLxphFRbnVTbOo8DQtJcIkxaZvir1T7zsgRddahHGzU97Pk
         vwFA==
X-Gm-Message-State: ABuFfoiFN9Z/9bvb75uI5dA3HtIp3GI2E1mELVKBPJgauvA/ZOw1hwa/
        f7jjzQdsVOUPi5dLHqP4v+o=
X-Google-Smtp-Source: ACcGV62eFxL2pNEF6V7WFdDnmEgNe2WHtdkiir9/urY7x3zlSRyk2uRGf/3JwirkNaTQ4nXeky55KA==
X-Received: by 2002:a63:9857:: with SMTP id l23-v6mr7508168pgo.321.1537750046763;
        Sun, 23 Sep 2018 17:47:26 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/20] iommu/tegra: gart: Allow only one active domain at a time
Date:   Mon, 24 Sep 2018 03:41:48 +0300
Message-Id: <20180924004153.8232-16-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART has a single address space that is shared by all devices, hence only
one domain could be active at a time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
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

