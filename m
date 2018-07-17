Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D44520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DgniaWOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D44520C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeGQLVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:21:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39792 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbeGQLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:21:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so771780wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hsNjGTsemWCd9gXayztWXXeXmIf6PJJi33nbtmV3MSI=;
        b=DgniaWOIcYJuWGv6WFjiL/o5QKg2NbVXP42Xt757hnbSl7BG07YAk+NigSXlpELXD4
         2G2+oEilqXAbqkWJhgnb2iwzsyJgz4s183luDHk6lNHB4DAhwTHLmogn9ErF1WhHQW9W
         kojEXYh9y73IWm0yhqDXTsSAQb3KVbQA5GlzsAfbxiP7eP/TRZ9mEQhev5OAZ2HKmn8c
         EXTQjwUuynMSaTYVXUm2Hmd1gCF+sMR0T7Bkv4CYmUxd9AahTtdXDdScfj/K8Nk+3mHv
         Xkk5e4Jr0YGiSROaHWeX8HLNkhLJZZV++d5daRi/ljuz1m/F+1a+iS5HxDReHR0T1R1A
         xWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hsNjGTsemWCd9gXayztWXXeXmIf6PJJi33nbtmV3MSI=;
        b=CrYrWAwWbimieVNGAQG2QMGB3vHMfmgVOEB1tY0no9GM+BNRAMCQoabrGMMzyKbSLx
         I3HfDYoLgiQ5T2ecugyQ6PBF0CxN7MFlyHJEcMKN+EzSdCgJwzZgd1Z2xupkvBmJ/sAP
         7C+v3OiqASHxI4Eux+SPHUiCP1JGjOnSP7B9TDt6w+7gNlowZBadwsxkehJmqBy8IqRq
         KlJ6J9HlMEfPCjwLX6Fk1w6deYeQ4MVoHagj6bwrQyXaFOB1+Rxu9Fbj9C3trtMqlS2L
         kMc5RlM8O5eWLNo/yhcV4xOvX4ZDiHwqHETCVkE+y+VaYc4Zu8kj8K+nSG03W26qxEIi
         XXAA==
X-Gm-Message-State: AOUpUlHESn2FpqmbvX7E2ctPNOeDv2NBIxL6aYvRRWtwMAVDPcUehq4y
        HB9HFAPExOCW5cHcbzkrwb/AWw==
X-Google-Smtp-Source: AAOMgpfifj2cpoDoXpM6otmA2U2jNc1yQD6xRTjVKIl5vdcgcs7RygvSDfakPsmRFtJMeYcx1G+P2A==
X-Received: by 2002:adf:adae:: with SMTP id w43-v6mr1010001wrc.251.1531824582211;
        Tue, 17 Jul 2018 03:49:42 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16298757wmb.3.2018.07.17.03.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 03:49:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, tj@kernel.org, sfr@canb.auug.org.au,
        mperttunen@nvidia.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Revert "ata: ahci_platform: convert kcalloc to devm_kcalloc"
Date:   Tue, 17 Jul 2018 10:49:35 +0000
Message-Id: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ahci_platform_put_resources() use target_pwrs after "devm_" freed
it, we cannot use devm_kcalloc for allocating target_pwrs.

This reverts commit bd0038b1b4f499d814d8f33a55b1df5ea6cf3b85.

Reported-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index fe8939e161ea..2ceebaf2ed56 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -271,6 +271,8 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 	for (c = 0; c < hpriv->nports; c++)
 		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
 			regulator_put(hpriv->target_pwrs[c]);
+
+	kfree(hpriv->target_pwrs);
 }
 
 static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
@@ -406,7 +408,11 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	hpriv->target_pwrs = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
+	/*
+	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
+	 * target_pwrs after devm_ have freed memory
+	 */
+	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
 	if (!hpriv->target_pwrs) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.16.4

