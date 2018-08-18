Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127D52178F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZUcUOks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127D52178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeHRTEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46918 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHRTED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id o8-v6so6099353edt.13;
        Sat, 18 Aug 2018 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zCpTSpyL1wbgmHjX1/OPXhCprvlf7BBAbtdIyx97wFY=;
        b=ZZUcUOksNz0OFdSnMKougbPymeULYNGSnsplwPTJsaN3umUNJvWq9IGTxy2sP1JL6N
         4i+mMijVnOhCLJ/BJsRsZ4EGV+ylhCN+5b3d25AAb/Gh1969rPeT0ChP+0ZicREHGUzH
         5I/p5ZNPokgupSQiU/+ossg13y7XIM6PSanor19iA2DyvbCVwq1Pam89pGDBILzGbTXQ
         m4VpYDytXEjMm9i8ixZfBEIsR3uT+5YFpSvscpYrdjTIyNlLmnvHPvFonl8mkbopmehg
         BjofX4ho7dWoA/ItjvuCVtWUR5sZ23YeQ4PQvb0oox8qcn+5D3O+TfrvPKSoV6FOFarG
         8rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zCpTSpyL1wbgmHjX1/OPXhCprvlf7BBAbtdIyx97wFY=;
        b=lQc0D34P/RIk2asQZTLLP64qh1CL+Ri/CKpd46J0r9pYg4BujuTT4X+SvI1bkRqn1Z
         Rg7tbaFrKhfABQCdjnJdajMBcsH9vj2eoDpWwKyovAEuxGxzgSy8gx+gGxobjXsX9jIz
         258v3uvm5h6gbFI7pwlMVNrzrWdh6Dz8G7svIGUajnOXa628A+MmF6yk8ZHfF6pWAslh
         0o57Kdn3t1jNuHqYhFu/hLqLmRk5cLxGR7h0qy238iOu4EiPOIW9+YyisiB+JaqF/uJ8
         R4lM6YZNr/onXt/5BnItBjL7QGWlqr37KtmbzpsukM1MrORbnV+0QzKJqSPNG+LU04hD
         /TsA==
X-Gm-Message-State: AOUpUlEmqYQwGSd4NcxdXuYN8t4HArNVQBjBjc9jiBNaXo7lrTf7tauN
        TdG90AX1wPS9v2TwA+UQm5Y=
X-Google-Smtp-Source: AA+uWPwSTEwEikCYTwJuJcdTDR2w6/1XpLOqUjo9gerHdOALPAqyUL4QhG1oTFfuxAhAivNY8xu9sQ==
X-Received: by 2002:a50:ade6:: with SMTP id b35-v6mr47283365edd.168.1534607752946;
        Sat, 18 Aug 2018 08:55:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/19] iommu/tegra: gart: Fix NULL pointer dereference
Date:   Sat, 18 Aug 2018 18:54:24 +0300
Message-Id: <20180818155430.5586-14-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer dereference on IOMMU domain destruction that happens
because clients list is being iterated unsafely and its elements are
getting deleted during the iteration.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e6fe139576c3..1d45b023adea 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -258,9 +258,9 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
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
2.18.0

