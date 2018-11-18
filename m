Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7EEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514BC20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlfqazKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514BC20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeKSISg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:18:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44384 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeKSISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:18:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so4246257pgr.11;
        Sun, 18 Nov 2018 13:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/tlmixrGXZ9X9NR3jXIkD/wrehksQ7lAJeQipAECFqE=;
        b=hlfqazKqlmO8wLrZcppCbmM4G8I7ZCScU9tYRZua5bP5pKrmAO69m+nWzb2VfQHMW2
         g/27e+PKzNg7Zg4niPzOeAm0y7tJmQK3Hjl9TswbrdXdwKxOCHtGQw2jlBmw0+fqAJvp
         yxHWxG22YFLLuD4fMsbOIzzMxFMAQTJcfHDyJr8CcT1G3Dem1kl6HKH7JvmgesxLSE3j
         +dYIZHJhfU8LVaCbWoMEwr0k3pjt+y1s+bJPZ5eZM3JcDK41RlhM2lcHYWodnft66TcX
         gV7qb0C5R/TnBS8jpO9JJAKa0qpgiTax+4W4nfSBm6TrWEU84uRQ++EQC1BZnjG2sMpq
         /2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/tlmixrGXZ9X9NR3jXIkD/wrehksQ7lAJeQipAECFqE=;
        b=fPFV9JXeeFuFxT60yn/myzb/S/s0t/d6iZHWlZ96nIrq111HETtPrF+Cf9I74XYZwA
         OXe/BMNhsJ4A9ktghlUQ8iKKepDN2o+0Lj+kLxILpGYanIAjXVXGh2mlL7a7cla0KzyY
         rTwuQt9pGTQq5l1Cl2eUzjFL2XgoU/1E/SuV6CLkcKuB6pSCFCKXw+6vYzyfjYpme6Uf
         EQsjBzL3cdTM/G3VZybV/NooTeIeqqeBuX4scvbW3OOufTQUJBIBYTK3Jp+fSQ/toJiS
         q9y7vopEFMeAI6kfOoi80UwOuU11BCYglpXjcrU6m7yhMrYe8Gb5nNnvFyHz4n/5/zTh
         TDgQ==
X-Gm-Message-State: AGRZ1gKBU2lMTxTK+w9AfKsJfi5DqdSpxrvFLMttY/lPA9LoS9DWaBns
        HlCk6Q52QlETkuMzn3Je8lwcPRyn
X-Google-Smtp-Source: AJdET5cT8KyxD7fTvzuOT5AT/jh++2pLB3JGtRs/H37M93J/cizH8G1qnat9s/in/cbRm2kS0BhnfA==
X-Received: by 2002:a62:6981:: with SMTP id e123-v6mr20286224pfc.104.1542578226329;
        Sun, 18 Nov 2018 13:57:06 -0800 (PST)
Received: from localhost.localdomain (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.gmail.com with ESMTPSA id j64-v6sm9733422pfc.43.2018.11.18.13.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:57:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] regulator: core: Properly handle case where supply is the couple
Date:   Mon, 19 Nov 2018 00:56:18 +0300
Message-Id: <20181118215619.21518-4-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118215619.21518-1-digetx@gmail.com>
References: <20181118215619.21518-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether supply regulator is the couple to avoid infinite recursion
during of locking.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c58e76a37e5f..a3ab419a3aa6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -233,6 +233,21 @@ void regulator_unlock(struct regulator_dev *rdev)
 	mutex_unlock(&regulator_nesting_mutex);
 }
 
+static bool regulator_supply_is_couple(struct regulator_dev *rdev)
+{
+	struct regulator_dev *c_rdev;
+	int i;
+
+	for (i = 1; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (rdev->supply->rdev == c_rdev)
+			return true;
+	}
+
+	return false;
+}
+
 static void regulator_unlock_recursive(struct regulator_dev *rdev,
 				       unsigned int n_coupled)
 {
@@ -245,7 +260,7 @@ static void regulator_unlock_recursive(struct regulator_dev *rdev,
 		if (!c_rdev)
 			continue;
 
-		if (c_rdev->supply)
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev))
 			regulator_unlock_recursive(
 					c_rdev->supply->rdev,
 					c_rdev->coupling_desc.n_coupled);
@@ -283,7 +298,7 @@ static int regulator_lock_recursive(struct regulator_dev *rdev,
 			*old_contended_rdev = NULL;
 		}
 
-		if (c_rdev->supply) {
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev)) {
 			err = regulator_lock_recursive(c_rdev->supply->rdev,
 						       new_contended_rdev,
 						       old_contended_rdev,
-- 
2.19.1

