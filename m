Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CDF206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bg85t73J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CDF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJDBdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:33:37 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:52442 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDBdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:33:37 -0400
Received: by mail-it1-f202.google.com with SMTP id e9-v6so8055658itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UP5rnmrvEiHgkl0IUphHQP1xpYLuF8Ln/VhUJdrPYR8=;
        b=Bg85t73Jhh0BQ6JPDYjCJ9TW97mg/RGNT92n9TqXlygiCBh5QmI6QmZoFwv2PfAZoo
         wFXOeGGfJw32U+Sn5bRq9nFJ23DzvxDWGkke/OSLoLQgAie6NmvK/mpKeokbnah/WuVF
         8xUHAFIUqrzbECswfBce8hHjtD+R2Oq0Jm7zgGiHQg2+Kf83ryJ5HXb1qFq9DdD+CSbP
         86nvR293YsQ4G1Qh33ncXaXnIigsA/Psgx6w0XqbP4xOwOGhDLdG4hDd4/nZGRXhR+u/
         PISfoo7GZ/YopD4agpetXzw1/oUUol/RBFrEGW7k8vs1tJvDaBkw7/+4FtGZAxLPQCBH
         oQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UP5rnmrvEiHgkl0IUphHQP1xpYLuF8Ln/VhUJdrPYR8=;
        b=VD3xqrt4NROSNPmXA8l59rvf3q5aYnCXdo6t5i3ie6jgR3/ZeypUeU28lQxlalb5Qa
         /zftnxO8Hg+Gi3SdeRXHZnJT24j1eCuc3SzU/YJloAR/qx+aDQYUhat8Fojacx6Y16Gv
         ZZ7lSFrps6rKQS2WofjyvM8BKdSTW0/tMlpwoIkDYatLoZ5/vUXYJ+ObU0s7KW/6lU/B
         3kdSyu5q5W+lXU098M3HpMMzc8XVRP/p4uw6xS5ChhP2Lkk0nH22vmQwgWl3fBNjC5bL
         ZmebquIHVV58ednpSKfnOM8UMUtbERu8buB/ttOENpZQc2fVnmGUrd5iCujFwwTEy9Fu
         DkGA==
X-Gm-Message-State: ABuFfoh7/GxXrH+Y/+127pc2w8BnwxY49ar5eWx8XIww11NXjcLi/KcA
        1R36VPx5WHKbvySDK7ePMO1S0YzITSYCbA==
X-Google-Smtp-Source: ACcGV63aLx4uukokVrITRqzFhwKzXNoBeSmNkmceroHCNDQBSgcaDb8DGxghJjyF0rWdGElby/haqcK2ZQhNBA==
X-Received: by 2002:a24:fe01:: with SMTP id w1-v6mr6535212ith.0.1538592241800;
 Wed, 03 Oct 2018 11:44:01 -0700 (PDT)
Date:   Wed,  3 Oct 2018 11:43:51 -0700
Message-Id: <20181003184351.148619-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 1/2] mfd: cros_ec: Do not attempt to register a non-positive
 IRQ number
From:   Enrico Granata <egranata@google.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        gwendal@chromium.org
Cc:     Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@google.com>
Signed-off-by: Enrico Granata <egranata@chromium.org>
---
 drivers/mfd/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 65a9757a6d21..d6b21e11cad6 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -118,7 +118,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
 				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				"chromeos-ec", ec_dev);
-- 
2.19.0.605.g01d371f741-goog

