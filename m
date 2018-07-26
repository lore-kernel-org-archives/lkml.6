Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E206C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E1A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kacv6DsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E1A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeGZWjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:39:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37673 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbeGZWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:39:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so2699828ljk.4;
        Thu, 26 Jul 2018 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yHy7OzAtnhxOpfiJYaKs+secX5pCJCEqxudCmV/VHMI=;
        b=Kacv6DsQk3uMrUDGMTmuTGvuMC17wP0aPqr93baGbdBLUqO4KWq7W5+QzdNA31XS8g
         7SZGn863QftLO1Tp6uFXME1s+x4AIi+0Cn6XbfwztAU667gYMiXrBDE4t/0xRskSZWNg
         21n24PzDtmUdf2EnqM/AuKMahWkly/u43HPI3nBtxQ4CTFHVWGA24DNR/wGEVVrNEV8e
         SckrXF0aZHbIUgrpLmZpm1MhLMGN1TQzaDatRn4qxByag6L8y8Y0r0kerlgWIAHt0AbL
         9JayXs3XdSf3b3kt6YNKXucX9CbZxVjzxoOxNis2UFIB46WhqUlFveMoRWRbWW7a9CAr
         7n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yHy7OzAtnhxOpfiJYaKs+secX5pCJCEqxudCmV/VHMI=;
        b=E+Je8taxPYEG678Uu9ERJKMgmYzJ8VzLbJvfMcyFGhyq+Ej0yOJwM3jbRBMYx5qfI6
         h0tAGxefNY7AgDpQTCYzZe8vx/tlY8POSSaiVZrRhtKilLHGRrhCQI9YWe3XUJszAnyQ
         Ih4ij2Y1755ZDzcs0nZN3fQEV4Cmbd6mKFVefln3p4c8ABOLuxGe5iYqS3jaBhXID6Ml
         d0pNdToUItfd2O/+xkeSJxbXb7CyGb2xtsL0jpCS9ygQQ63RaM/Q2n2yF0TEQXP9wCyc
         kdTJT1P+3eN7ReoTaTvQ+glCUnv3A4u9/OFU1KZe1R65jUEoXoC1KngB6sWoIg5aXEZU
         dFPA==
X-Gm-Message-State: AOUpUlEmRBuEDYT84a5XIgsXe/08uKXSjhROEYIjAijhHrph58fbezVW
        qeegH4VWvSrgEn8Zdu33Vrg=
X-Google-Smtp-Source: AAOMgpdu9FIDlP1boygiaLpf7t5tw/ZeiwefwyWZvCiuAEhNP3j01Dy7NHUIu0RlxgZdaCeTjZxt9A==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr2967342lji.11.1532640029166;
        Thu, 26 Jul 2018 14:20:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id w14-v6sm376781ljh.71.2018.07.26.14.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 14:20:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Marc Dietrich <marvin24@gmx.de>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] iommu/ipmmu-vmsa: Don't register as BUS IOMMU if machine doesn't have IPMMU-VMSA
Date:   Fri, 27 Jul 2018 00:19:16 +0300
Message-Id: <20180726211916.10264-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes kernel crashing on NVIDIA Tegra if kernel is compiled in
a multiplatform configuration and IPMMU-VMSA driver is enabled.

Cc: <stable@vger.kernel.org> # v3.20+
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/ipmmu-vmsa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9e8495762bc8..78c50db9cd71 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1109,12 +1109,19 @@ static struct platform_driver ipmmu_driver = {
 
 static int __init ipmmu_init(void)
 {
+	struct device_node *np;
 	static bool setup_done;
 	int ret;
 
 	if (setup_done)
 		return 0;
 
+	np = of_find_matching_node(NULL, ipmmu_of_ids);
+	if (!np)
+		return 0;
+
+	of_node_put(np);
+
 	ret = platform_driver_register(&ipmmu_driver);
 	if (ret < 0)
 		return ret;
-- 
2.18.0

