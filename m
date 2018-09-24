Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CACECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CCC21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSPsrIHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CCC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeIXGpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:45:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41399 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:45:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so8306807pfk.8;
        Sun, 23 Sep 2018 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKKvvnsQS7iai+eSRHoNOQky8ZsVQ/gE/DDyaWyDr/8=;
        b=OSPsrIHSYUxs2BnK2TxhyizSwTA9VZ7x+zOm/vkoGautfTrwEnMGsV7L4vNE5DFDAF
         XI7Wpw0trFEBeggYNh472RQOuQdncmfvEtAL7KRBBhy2yuETdFeHMZYmAyd9aYveg+wx
         GoyUmiW9K44Q3sTpryfFxcmycpE5hGZq21DGmfa4swSRsvRmnr0FCAKUarrVqUHME4N1
         rx4tHjHVZbeMdBncpsZTg3zN0raCZCTGfrZ/99RLsgZ9F+63DLGl4nTKycHu77Ze7Zbp
         qazYXpZg8SiM7V/gSyUZ+XELAcp3u/cqUhuT8ohjxEq9Kej2e6rJfBer4yJ+olCdGg6T
         yN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKKvvnsQS7iai+eSRHoNOQky8ZsVQ/gE/DDyaWyDr/8=;
        b=Ppqxndmye4rVLPOuAsE9s/7qf72dpupR5e+X5kzrebkjp60+qLbtGXBp8UsDviazYy
         uZeJ1HY8Vd6uSOygteWuQ/UtKrBmQ9+iytI1t03LG5HunrNgH38LBkNCMR++hWJWyU2u
         ZggRSS5p4uwNv39G9tFlAdA1kJ/1QqRPPLETD+4U2f+R/Q5E9RJlELBbAq6cok3wAyTS
         4sBX7kAlaVkoTYkCrMhYVHFiwLRPYOqI3enn3DrR9+cbEYTZq3Pnm9otHBJO3g0jIaZI
         4SWrAswJlCzvcPMHLd1FA+G3NFsVPVo+99VFBIi6djFR9tFZaSlDY/+i5PVdH3JsQdfy
         kYNg==
X-Gm-Message-State: ABuFfojUkyv8/71pCz+wLF/h5WvMoNGfLHgtoH09qSh5LhRT5TPtOqlX
        OTbpQYq3dmmrBmiSB2JEupI=
X-Google-Smtp-Source: ACcGV62NlENUqmwO/b+a6R4Aep1uL5oOdlj3YwHpOtBQZG0NFvDURl0ycLikLG0WyNvQ44gKUJR9rQ==
X-Received: by 2002:a63:560e:: with SMTP id k14-v6mr7536328pgb.189.1537749975494;
        Sun, 23 Sep 2018 17:46:15 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/20] iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
Date:   Mon, 24 Sep 2018 03:41:36 +0300
Message-Id: <20180924004153.8232-4-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index e9524ed264cf..f6cf5cd5aaca 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -342,8 +342,12 @@ static bool gart_iommu_capable(enum iommu_cap cap)
 
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
 
@@ -360,6 +364,12 @@ static void gart_iommu_remove_device(struct device *dev)
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
@@ -373,6 +383,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
+	.of_xlate	= gart_iommu_of_xlate,
 };
 
 static int tegra_gart_suspend(struct device *dev)
@@ -438,6 +449,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
+	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-- 
2.19.0

