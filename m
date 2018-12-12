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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DDC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3806B2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm3j8T3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3806B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeLLUxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLUxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so9420943pfe.13;
        Wed, 12 Dec 2018 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxK9RMJELvGUwh2e48DLDAyybI+xi2gMHKnphksiQDk=;
        b=Jm3j8T3XYVm5XweSGJ4YXa3gKZJ+kHSCZ2KFbyBMCmhRfIaMJlDm4+aJELMo87au3C
         AFIcOI+oOlXwBtI2lBWhyr4XsaJPbn6LVclk6Y3a0eLo6ls1ParqkNUr8OQhEmuKPfG4
         1+QENbJASkBny2jtwyQgDV3uZQZNzJx6sntiBZzAMxtopivXfchyBTjb1slF4wjVfvHu
         ZngCGUCRqLTYu2rNouayCAfgAmeobA/aED+xDglrEfbVWFkNw5jEKBDyjFJt2wCQrrtg
         23n9WmkUQz1qkdeLJKXgHJo0/PiViGc5OSFxOQCKtSaE/2zUObCtaarHffmrR0KCBaxV
         UeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxK9RMJELvGUwh2e48DLDAyybI+xi2gMHKnphksiQDk=;
        b=nEz03lHuNdsrieA49XZjRvbkISDJJleNizqgvs9hSaVIoGf0ZeIoTaH2mK3OF+P0ji
         5tl0wZc6j6Zw9zjlu24vP+ElcJ4KZhOjt3C31Sk0WroaG4Vx/ofr1b1X1EXGWpeHA9Vx
         +vNixlqY4T7wU15YD8dvjB4cPcXVCokSmBN4KvM0a1uvg+0/5jvRrWfz6jt2lfLZ2zuT
         wv2E4a3C+OuKinGH5b+Wrm0QilDKGnnpQYJXKjywCKqUBF+9ED4+6EBh1V3QBNZ7ALqC
         ufCez96eiw/zX0fRLwLAQLFzUiRkjXzXkqKVDGzk6qSdMzclG3RBAOPMVMjEW5/ykUaf
         WOoQ==
X-Gm-Message-State: AA+aEWYhrA7f+Z1nrIVFSuossjcnXeg0rjnBrFKVe8vYoxVPfU+J3lRp
        rL1DEj0zY+WC5CC8mZ2fUq8=
X-Google-Smtp-Source: AFSGD/U9B3gsdGNLR3lNaD54fkIbUbvkXMtWQ43dc7taCUX02C0SYr/PQwI08HI2b39z0Yiz6tZC3g==
X-Received: by 2002:a62:5793:: with SMTP id i19mr21807340pfj.49.1544648031557;
        Wed, 12 Dec 2018 12:53:51 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:51 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 18/24] iommu/tegra: gart: Fix NULL pointer dereference
Date:   Wed, 12 Dec 2018 23:39:01 +0300
Message-Id: <20181212203907.23461-19-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer dereference on IOMMU domain destruction that happens
because clients list is being iterated unsafely and its elements are
getting deleted during the iteration.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index a7a9400e0cd8..7fdd8b12efd5 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -260,9 +260,9 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	if (gart) {
 		spin_lock(&gart->client_lock);
 		if (!list_empty(&gart->client)) {
-			struct gart_client *c;
+			struct gart_client *c, *tmp;
 
-			list_for_each_entry(c, &gart->client, list)
+			list_for_each_entry_safe(c, tmp, &gart->client, list)
 				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
-- 
2.20.0

