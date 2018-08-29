Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF5DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE46E20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE46E20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeH3ACy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:02:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42765 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeH3ACy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:02:54 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so5283598oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+neBZzp/eGDF4FA7URUSDthpXSzrccxub2oIhsNm1bs=;
        b=tlqQjlZM+043voaWHPCPMJ1NISv+c+LKrpEOE5BddEx58Q3fNs/f2jU+qjoNNi9+ie
         L1LnbbAZQRYVqFDszpgKh+0MahSVzL9VYMnz+C7lxYt3XcrkgfmefroLe0oSA0EjvoY6
         98KzaBYIf9CHNTqpdsHRSZFACYQtp3JfwsnvD6fkruv3db/a4YLd3fAZb8mtU/3h6gMM
         hD3ecPOWCh8ciPRpSux9CnPItZK5aLvt5enHmlTKeRZtC22pGyryvtPheT3EFh/n4wZc
         YXhbsXPy5IBlDkjq3DF2fqCRb/oMo1CrYioNy16n4HkeQdqp+CGCjlSDRzGm5E77cl49
         yPsQ==
X-Gm-Message-State: APzg51BTwg05++WCGLqISxGf8A2C0wtlq/rCde+El7megVKRam0rwnx1
        GNwUAhoEyV8rWsFl5H52Ug==
X-Google-Smtp-Source: ANB0VdZOe44PIKiRuSNUrKr19j51jGEQoZaUazzTGh93jRXupQ2mFTNvU8rQnVgXK3QyF17V/Hkq/w==
X-Received: by 2002:aca:4c92:: with SMTP id z140-v6mr4052794oia.318.1535573066913;
        Wed, 29 Aug 2018 13:04:26 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r10-v6sm5349969oif.37.2018.08.29.13.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:04:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
Date:   Wed, 29 Aug 2018 15:04:25 -0500
Message-Id: <20180829200425.16435-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the of_get_child_by_name() helper instead of open coding searching
for the 'firmware' child node. This removes directly accessing the name
pointer as well.

Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/fsl/qe/qe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2ef6fc6487c1..612d9c551be5 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -588,11 +588,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	}
 
 	/* Find the 'firmware' child node */
-	for_each_child_of_node(qe, fw) {
-		if (strcmp(fw->name, "firmware") == 0)
-			break;
-	}
-
+	fw = of_get_child_by_name(qe, "firmware");
 	of_node_put(qe);
 
 	/* Did we find the 'firmware' node? */
-- 
2.17.1

