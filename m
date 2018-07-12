Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A6DC468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807DE20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eUX5nL/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807DE20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeGLLu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:50:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36465 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeGLLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:50:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so21383324wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xn9xNUhenQ6ZYCCl4OkzAbhxSqvo1aWlc0y05rj5By8=;
        b=eUX5nL/CoRLYkz4K1tAwINR9ua47OhGa/Z0wDiBcmZeXM+Qxn8lgFP/huWgE/mzltD
         FpHcIwDy8AnSG9GAR1rSE55WnMqAOP6wakcwAxfCrELQwAhdF7QUUL8KDZvk2Ald47wH
         HcKCKM9FTTsbsPYZBrmS2IOLWW407+kvLJ2z5Utw0R2EY2QGgM8auVmOl50jj+NftnPp
         pDmc77OSY+RF448QnoaBKNfeOKc2r6oBHHR/nRfofXd2QCLLh5F3anGGaoyU26OhtKLr
         mEVvFwbQUa2fWO2+nH1RCiq3h8u6J9gHGAr4kvSgf3c4PAcRSHmuo3GyM+0Q1iF+2fjf
         xtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xn9xNUhenQ6ZYCCl4OkzAbhxSqvo1aWlc0y05rj5By8=;
        b=pQWjHTCXz/hAtHfOJCy925sBmN/hmGNdU9qu3fn5QUwzFL2Hc8HoSDcaqFMlGbAoJY
         h74IbHkY+KkKQIAx2BpAkgshE4XMjxLyMPacDp0dbtVqaaudvHvjHiwoc0fyuDKBAznx
         Cxnudk7vSw4dtTJ+p3536c8U4H2jG8vrb/0Yv3j7tGlDFeMtdXZquZIF4ruWv3cXY214
         3zkKGOuF9OW3+t8HbX1TnSle9G7wK8AHmZ2NqkPT/oUAAzYgbaW2oKe7scZIEymSTJOj
         Dh8GEZq8lGbE/ReryfDh28SQwS3LURjoWTyZfbK45Av1I0SmLNKNw9l8BKwm743Y6PJc
         n1Og==
X-Gm-Message-State: AOUpUlFah1RvYH8Ws+PaFg+EKhCMzcOkW6MG5IJiYfF8abFrz/PIg+oD
        EdgWtbjAVp/ITG/zzvpvQWhKuVBf
X-Google-Smtp-Source: AAOMgpfN/cDoSOI4pqhs2aBkr2Tv4cMAnT8w30GH1VDrulgqoX2hXJFb9LgxshXAf9Wiwla2N9fIyA==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr1571862wre.12.1531395704466;
        Thu, 12 Jul 2018 04:41:44 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm7716939wrb.34.2018.07.12.04.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 04:41:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/3] ata: ahci_platform: convert kcalloc to devm_kcalloc
Date:   Thu, 12 Jul 2018 11:41:31 +0000
Message-Id: <1531395691-4653-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like phys, target_pwrs could be allocated with devm_ function

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index be9f54423a9b..fe8939e161ea 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -271,8 +271,6 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 	for (c = 0; c < hpriv->nports; c++)
 		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
 			regulator_put(hpriv->target_pwrs[c]);
-
-	kfree(hpriv->target_pwrs);
 }
 
 static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
@@ -408,7 +406,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
+	hpriv->target_pwrs = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
 	if (!hpriv->target_pwrs) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.16.4

