Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66152C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2002821788
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWgloFez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2002821788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeHRTEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46918 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeHRTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id o8-v6so6099376edt.13;
        Sat, 18 Aug 2018 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sNwykQjPA6RrHu4K7Tee/w7SvQtdAEKta+nXRaDsCnc=;
        b=MWgloFezqWrwFgBsFkui8En1wMXpxrhkZN5pBXt/j2KliPI0Rxp63z/dc0fK2gBENZ
         ZbSN4PfNpim8osyK/2KlW/qSJjl8AbAD3UmuW4o7xcYylXNig5M9Gceg0fsdvBtHBeQb
         b5oWO6dE3qkU/t4203w95My+QHwDy8w9hqNJ8bUgRHE9RU14/H/GgHFVU92CQYi21vYa
         n8yxxSa//Ac6BIFLVYey5Nx+zoT/9xKM9zWt3rpqHxOF3n81nWvLJet2WrbesGVF9hUe
         wIxpHE3CZ4zNuONO7skWSTjdMA4T7UDkVw80kg1Su07Wn/j249kw8V3jZdXWvbQGN46C
         mzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sNwykQjPA6RrHu4K7Tee/w7SvQtdAEKta+nXRaDsCnc=;
        b=AEqMZz3ADD0ITSW/Irng87BituOq9bPmG86g3dktIIt/uKcQcuETNGG1LNBxd0zqAT
         tNCNAhz/XbeS9ZEsOo5c1JG8Encq2OIUN9nVZllWGJzj8mJflZ+QfF6ue3geQc0Nq0rA
         nfD1mnle4QLOUIvsyi1nI4bdoZDXh4tHsBrV1Vr9jtMCFWiicBgY2BR+86KwUSaIRcgx
         FXVBg39crSlwQQeTtJwrUoUQx2FFsFS1uUfGli5NOS/jIxG5LAzRMjPBGE/jZeMplWlz
         IIaW1W8fluyQpMz0O80701+S2DXFIfEzQLOGhOV344JE3mq6IhItMO7SiUt4/J2BFgJT
         GxiA==
X-Gm-Message-State: AOUpUlEvja/GSGk+p7o2ohWY8fCz8WSlhEg1Ds4p5lPxJjRaDTVvZylI
        Mfq1Up0sLhMMJl2rn0onZM0=
X-Google-Smtp-Source: AA+uWPzlP+h0Su8rS7l8fa1Kt/4H1ljd6I1JcHGqEZ0ohk9PVbaJecYv4dP67OtJOFmXa9CyIiZXFw==
X-Received: by 2002:a50:b178:: with SMTP id l53-v6mr47029574edd.306.1534607754223;
        Sat, 18 Aug 2018 08:55:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/19] iommu/tegra: gart: Allow only one active domain at a time
Date:   Sat, 18 Aug 2018 18:54:25 +0300
Message-Id: <20180818155430.5586-15-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
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
2.18.0

