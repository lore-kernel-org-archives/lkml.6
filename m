Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D8C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D31B2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAqDaheT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D31B2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbeKVB3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43537 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbeKVB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id f4so5095787edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0g5297Ph0oBQiTjb03G8l+LGEonV+v0N8AP6U2Tw8U=;
        b=rAqDaheTmUAcTlQIPqXzWlg6XLyHCNAzVM2XhCx19rd5Umn2bZsImFPg8L7J5hs6Wf
         Dd8HHN6sB0cfg9/aIrNlW1E8voIlQtXp3ykq+PtG+kVBkZ13jBMWwtgOqupeZP6k0o21
         FQijW5VIkAwbLmxNx6rPBSLSO9t/aiNzzzAukYDUZPZ+wPMANySS5kbqJHGe0fsenRbf
         n2y2WfXVxRRJWfC9WCmGuUEZli53upKJyGIyvNOgE8sZ8cDOJuuITl2DPFbE4OtqU9WC
         uAHbP99Dc3Ba5N/MJW7ku1lXi4AbnCxHCFSD6cOzG2e6k13D/5cAl1FFmYimT/Z6AQb9
         xUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0g5297Ph0oBQiTjb03G8l+LGEonV+v0N8AP6U2Tw8U=;
        b=JISHULmSSNa6lc1C+jHFPVTQPPcTRoE4LkirhZeY7w6EH3bitejK43dThy8szlm5bH
         TsoRDisb08qq4p9qJB779NJc9a9+xNOXtGoUYZHAJyibNbmngmnHoE5+44bImR8C0ihR
         EMLhsQ35u6/Twv1dneM/8t6QK6bOajooex+yPJ+je/Y4GjW6QKPDXMyhLHHLaK/mjOHU
         QeLjIgDhWwrcSHo/8WRhqztpQwNP++pHcjfCDDCKxDWDnFEtx+4Ry/dPDwT4RBUOyazq
         U8N5gCwioaV77/AeCyxbMza+LUyMP5d/AxHjnamItwZq48L4j0PQUAdzQzHrF3M1t/J2
         tujw==
X-Gm-Message-State: AGRZ1gKT/7jwq1JSL5Mu9V4enyitBiHpFwgpAVdCirxEBJe2ydCFnKQb
        e2k+YCGmWLvv1KtDc61O4W/I2FhX
X-Google-Smtp-Source: AJdET5crat0TcXc16hL4XdNtreuXOCQT710kCcmtNVguRH3rYBCW1RR8x+cabKFj2w60W+/TmqJySA==
X-Received: by 2002:a17:906:3488:: with SMTP id g8-v6mr5373081ejb.11.1542812082917;
        Wed, 21 Nov 2018 06:54:42 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id m13sm11094963edd.2.2018.11.21.06.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:42 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] mailbox: imx: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:18 +0100
Message-Id: <20181121145429.7582-9-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 363d35d5e49d..774362a05159 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -324,14 +324,13 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	imx_mu_init_generic(priv);
 
-	return mbox_controller_register(&priv->mbox);
+	return devm_mbox_controller_register(dev, &priv->mbox);
 }
 
 static int imx_mu_remove(struct platform_device *pdev)
 {
 	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&priv->mbox);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
2.19.1

