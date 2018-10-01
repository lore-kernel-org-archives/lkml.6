Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A02145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPYoJsXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359A02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeJBAMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:12:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52965 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBAML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:12:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so9347829wmw.2;
        Mon, 01 Oct 2018 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R1c2+BfqEIKPcQvwKe3jN1rt6iNmOBt0YCCig5nST/g=;
        b=nPYoJsXNTgD2olMybD2SGDpNMJctK9LShFnnX9sx5ii8RcFQQ1sBcU99w6tuerSBW0
         718O4Ie7KzvPPNmFdThV5b271U1EoDpH9vqsOtR5SJ1nnBV0jaBjHkCyV11DNdFikNJ4
         D1mc3tEmcLIgKQY/s59MkUar+ZOMNzKyh2ML2Sx9BxrwPqzYyDDPYtTaeAl/pK0U7QqE
         CPB6YCZQf27pckkgLJukXPId5QNPg+nmuLlxufJRy42sKz+BQdMhDF+KlaSvEGeJKeJL
         ZWg9yibyGEtfCrVgY01E1zfhHqpiBUlHOdk5YWNzlwmPNX38HZkQPbIdOgM/mKl6scKq
         CTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R1c2+BfqEIKPcQvwKe3jN1rt6iNmOBt0YCCig5nST/g=;
        b=UjCHkvsSbj6gFzXhG8onV4lxhsEZyU+wSN4QdSVTpkXORudyIl8BI7Zw2g7sOCZ41X
         3flHfO4czLe0l0iYsWWIkeCXXvcIPxkV5X1q/hrc/td8YGTDbYMs9wJWrr9iv3qf0wyl
         oz/EMgmV6XeZ+RI3QBFIaOD+RSpACk3P2RNZ9NpE2MB+RrMiI1MDy0tO/HvUWifYsZmt
         ayPfAy2rRztC+KDIzj44QdfTsTTrtele/aB9uAFjccBVnRQyLGDNOVASB9BFPwzTOUgA
         RWMWT1XUQA9TZIC1+UR4eM0Wza6iEto6yBhYGefmCdiHqIinVza4eBct1L6zzWQh+V/2
         o0YA==
X-Gm-Message-State: ABuFfoj11RMEkLSWuLvOXS2R5fEmhOUXbpYvdkUOA9RKOdYccF3EficD
        WJuhF9Ouoahz/qDs25fHAIta74uZ
X-Google-Smtp-Source: ACcGV63dwrqBKTy5TUKcPYSU/MbnfBT0OpyefC3oX5qKoOHu8nvgZwA4Vv1MoEx0Nbk5YEFD5dnrPA==
X-Received: by 2002:a1c:f313:: with SMTP id q19-v6mr4165587wmq.87.1538415199255;
        Mon, 01 Oct 2018 10:33:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v16-v6sm7840651wru.31.2018.10.01.10.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:33:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 2/4] ata: ahci_brcm: Allow optional reset controller to be used
Date:   Mon,  1 Oct 2018 10:33:00 -0700
Message-Id: <20181001173302.25398-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On BCM63138, we need to reset the AHCI core prior to start utilizing it,
grab the reset controller device cookie and do that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index f3d557777d82..0e401b7c0856 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/string.h>
 
 #include "ahci.h"
@@ -94,6 +95,7 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
+	struct reset_control *rcdev;
 };
 
 static inline u32 brcm_sata_readreg(void __iomem *addr)
@@ -411,6 +413,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	/* Reset is optional depending on platform */
+	priv->rcdev = devm_reset_control_get(&pdev->dev, "ahci");
+	if (!IS_ERR_OR_NULL(priv->rcdev))
+		reset_control_deassert(priv->rcdev);
+
 	if ((priv->version == BRCM_SATA_BCM7425) ||
 		(priv->version == BRCM_SATA_NSP)) {
 		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;
-- 
2.17.1

