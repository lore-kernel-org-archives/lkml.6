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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1156FC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C754820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONgd+SJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C754820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLIUbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35853 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLIUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so6520932lfg.3;
        Sun, 09 Dec 2018 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgwCQscgq5+zWM4UdqreWOmsuVch50Kck+PS511Xu4I=;
        b=ONgd+SJ8cyD0POXRqcGuzZEsJjZ85TYO9A1aT3xm/wIdzeXNe0I+FrZMnYxmX0cQHm
         RSLQfXkWWhoii3h+pmxViSwoczPT6uJADMFjto5vMesDZhslHVLKzio6CLyuhzgnHmmp
         lx22zqWNQ1WvwWbNPedy375Qm4Me0fdC8SAuWHSICzGKExZjWXG9W3BvqWp/LAkSMtLb
         +5NCVeOpROTwOHSE/ZhbZ0GR/IEmF+hyQ6UIwdrB0HFrxg4gajsoUTAoFnB/xqzU636j
         504jPqKwQMHyjg5EwqjhKkM78svQ6asrQqpC2rKOQWVY8KObqcO1qfe/32xtgnrFkcw2
         +UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgwCQscgq5+zWM4UdqreWOmsuVch50Kck+PS511Xu4I=;
        b=BTt6ydfmD3fI+tu3rP12UVWYDerHNcEuROFH8zgUFIWvtsQaAzNE81Fh+ieYwPgtzV
         J/+n1VPHkKEJE5k0SYVdSYhdzeBai4OsWmVoywMhh/PRHQ/AEREYBlm9jidJud94RCzJ
         ZDSLcg0elbrgA4zsBJl4ILTLeSNgLVBIsMIpBo+MfluLAKAhK21mAo2gskTMXtR2oyyC
         ewVPqBjmjZPiqUlqQctLxFZKVz7/LfdkRFbPH6J4f956PtRTuXCHfHGnTHsfCKDZ2E5e
         VO704TMBpBxPMbKyTToXnLtFH0hOyeAn8pS19RznmZpSN4a9MQJmyxwkeYGGzn6YE0LD
         TwcA==
X-Gm-Message-State: AA+aEWZ/e9fI+fMHc44mYPEslV28Us+p7OBsLQtiEagTJYItSezweY58
        wpHzpnK+aDab5l2uQQJdKa9bQMqA
X-Google-Smtp-Source: AFSGD/WbT9bm1WH6kNg1x1Bf98K3E9ml1w0tFJhrUG/KRoCYwagQ5LcSI5s7PIVLNkZwEoEhkxcQVw==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr5283526lfa.40.1544387460532;
        Sun, 09 Dec 2018 12:31:00 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:30:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/21] iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
Date:   Sun,  9 Dec 2018 23:29:32 +0300
Message-Id: <20181209202950.31486-4-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 1cd470b2beea..37a76388ff7e 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -345,8 +345,12 @@ static bool gart_iommu_capable(enum iommu_cap cap)
 
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
 
@@ -363,6 +367,12 @@ static void gart_iommu_remove_device(struct device *dev)
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
@@ -376,6 +386,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
+	.of_xlate	= gart_iommu_of_xlate,
 };
 
 static int tegra_gart_suspend(struct device *dev)
@@ -441,6 +452,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
+	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-- 
2.19.1

