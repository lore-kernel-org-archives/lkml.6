Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE95C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEE2206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5g3goYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEE2206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeJAFYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45705 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJAFX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id x16-v6so10317135ljd.12;
        Sun, 30 Sep 2018 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Astfz63yJdg+odKQfhD7o5jkGLlWsoAUFfFT0kJpypU=;
        b=f5g3goYS/ltr4ZRX8+/f48XdiOlCLH7Kgh3gVYmBXyBm2SJ5piCxLMdXPttS3CdTFt
         THcAUXZSpE9hgSqwHgv7MfFrlzOgMKs5N6P7Eaolgmz0EiaklQBImDR5WxfVFxiIh4pw
         2wHzlbHbYAji7rQ5qbJoLF0sQG3s4zJm4xGUKkJUT9QQg1x/c7BB/Eh9LBnhdC+6XBcl
         ad/KkkC1REaekFFveuvKPzYLP4FRweBZUXjGJwVD4uWQaNT/mjwqmp+dwILjD/9H/q9m
         fQfve16rE9LZqxlqt44ZM266eEOBVb+1sBrmNA0POPXbya67/OtuoK7KGBwGz5oDM1se
         R6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Astfz63yJdg+odKQfhD7o5jkGLlWsoAUFfFT0kJpypU=;
        b=m1v5Y5+0kshQSwRHuF8uuvF7Q+y+f4MOm//Oba1vdIekXxpW7Y0wjXkQlJeVZrQ+0Z
         xrPi0wOiuLGgL+Mx6sLz8mFum970Jb1VCSKYclv3DzyMp0EdD035y/ZUlWoNSCL3iZW2
         jedSLN/9ONVaTsnj08a6QNJbRix8/gJt1CaQ11Ts92gd8s82smIobI69jOdr6/yqtdhs
         06VxuDeP83vNhkBsTlyZLk4Gt6DxMEihRIhK9GXxHpnNapv+ZgHTynKcVHZHiVtsWjwX
         TcmV5OocnYx1nLIgbzmfqAIKUniN7ppy6fmyPlO6J4S5cq5wKzOQljOa3Y3oq3490Fit
         BVrg==
X-Gm-Message-State: ABuFfoiulfvCgZwZ8xeR6srsS321YrXD39t0K1UeGE1KG/kvnoBa+vpn
        qEwI3AmQRu5kBdKNxh5CwAA=
X-Google-Smtp-Source: ACcGV61UZ/Cr4pG0vZqStj4KrTBZ/23wBfGhFNmKONqij3/vrnoI+cXSuxNnbMphkGeHEwUmT3w0ag==
X-Received: by 2002:a2e:94c4:: with SMTP id r4-v6mr583928ljh.68.1538347748611;
        Sun, 30 Sep 2018 15:49:08 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/21] iommu/tegra: gart: Fix NULL pointer dereference
Date:   Mon,  1 Oct 2018 01:48:27 +0300
Message-Id: <20180930224833.28809-16-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
2.19.0

