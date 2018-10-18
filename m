Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF220ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD2E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fllIh0Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD2E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJRIzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:55:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43745 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:55:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so31665703wrt.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SWToVUA/ql3233vIUowK3fXJtf4wFVq/XsDPcJE7KE=;
        b=fllIh0FsjWnA6fxDBhADTWP/h42AfGKwHG3sZ+6Ft+QlOqLeyV7QMhQTKLxZZwoIAI
         ke1dPi+wwiAMtc2XW2cfyVaXQDpGoElmw4x9DTEK+CarT5BRgpV/zuCt/VqsEx2O/Pal
         /gvUjwzWZQhk5jTitvuQOw9svAz/bh5p7/Sb7akZA4TXya8UysMf7INYOka0WD5/bw0i
         Kbnzyo5sdP3QAmNBstPylcGe6HEyRe+jev5guVgph2s5VwqUMTJB4YHwEoCGstgxM+Oc
         K67Tb4/neDR5IqkrBxmldpjF3TipZrANpwtCRFc1DXhJNPVpG4roqi76nxNi7FGDigPS
         6HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SWToVUA/ql3233vIUowK3fXJtf4wFVq/XsDPcJE7KE=;
        b=Ah9677HsB3JauYiuHmPjmWOEcYCBP4BccU2gR9ueqqydmExvKu9Nb9PasAhGIf8JSO
         VGxiiF6TSq4FkXFen5ah2vwdLQTi54VQ5GVZZ7CcEh1HYBHpg+zsPnwcfd1aDNrB+sqN
         MG9JlgfqfHFwlKgECZvnS+eUVeecfWslMD2zmB3hB8THmBtAmYUY2hN6QsuO0NQxOoHz
         63CNqWhRQZh5zZ1yWCxFrpHx7j1sQvtBrrSUnC0YNZIZrg4aLCRLgpgp4QHLDsCrxSDj
         3/VIozAIzVEYTEMwMgqYS9fF1HgZu1dLdjEoy75RDoWJtqtXuwvePUV1iurNybSUXQ9e
         6HGA==
X-Gm-Message-State: ABuFfoivusdlQ6bJ5ADlz6EaG8IEBhIJRjqkwdZZCmdLsUO34PxoEVfQ
        w/ivOyN6ibyOoy+wpsuf9J5WYfoW4s4NNg==
X-Google-Smtp-Source: ACcGV60MgTk47aKYFjsTozyoU/epWE3b7PK7678Y/dmiLXHsTpWGCkOhxaS3I4K9qTIGnza1lWEpxA==
X-Received: by 2002:adf:eec4:: with SMTP id a4-v6mr27354128wrp.242.1539824198103;
        Wed, 17 Oct 2018 17:56:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id i7-v6sm23112559wrb.30.2018.10.17.17.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 17:56:37 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mfd: db8500-prcmu: Fix some section annotations
Date:   Wed, 17 Oct 2018 17:56:28 -0700
Message-Id: <20181018005628.8295-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with Clang, the following section mismatch
warnings appear:

WARNING: vmlinux.o(.text+0x7239cc): Section mismatch in reference from
the function db8500_prcmu_probe() to the function
.init.text:init_prcm_registers()
The function db8500_prcmu_probe() references
the function __init init_prcm_registers().
This is often because db8500_prcmu_probe lacks a __init
annotation or the annotation of init_prcm_registers is wrong.

WARNING: vmlinux.o(.text+0x723e28): Section mismatch in reference from
the function db8500_prcmu_probe() to the function
.init.text:fw_project_name()
The function db8500_prcmu_probe() references
the function __init fw_project_name().
This is often because db8500_prcmu_probe lacks a __init
annotation or the annotation of fw_project_name is wrong.

db8500_prcmu_probe should not be marked as __init so remove the __init
annotation from fw_project_name and init_prcm_registers.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mfd/db8500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5970b8def548..aec20e1c7d3d 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2584,7 +2584,7 @@ static struct irq_chip prcmu_irq_chip = {
 	.irq_unmask	= prcmu_irq_unmask,
 };
 
-static __init char *fw_project_name(u32 project)
+static char *fw_project_name(u32 project)
 {
 	switch (project) {
 	case PRCMU_FW_PROJECT_U8500:
@@ -2732,7 +2732,7 @@ void __init db8500_prcmu_early_init(u32 phy_base, u32 size)
 	INIT_WORK(&mb0_transfer.mask_work, prcmu_mask_work);
 }
 
-static void __init init_prcm_registers(void)
+static void init_prcm_registers(void)
 {
 	u32 val;
 
-- 
2.19.1

