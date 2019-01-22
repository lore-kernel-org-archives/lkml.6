Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6093DC282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF2820855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvEItE1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfAVEWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:22:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34270 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfAVEWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:22:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so11126103pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 20:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8BYTp8mhM/pilsodAKivXfXoRjeqU3Tj9aOBeEVYqE=;
        b=DvEItE1NiPV7p/vSyCBMjpexW+q0uRczQQLq0s75ULzh413ZovsWdPBMAsEhPzK9SK
         4WuWYl5H83Ou4mDtYAQK4aE4M67LfklMKcMu1BP+JhwfggJ55vcvnYEDX1ypP1Qe+7BD
         o/dbTwt5pNEvlgjDc421pBNC8VaixHFlIRqOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z8BYTp8mhM/pilsodAKivXfXoRjeqU3Tj9aOBeEVYqE=;
        b=ds/pv0Rks/I5VDHuPeGm6mPuoPiFgKJ/pXgJf+VztTKrqLMDlObNH7vs1r578UBj0K
         SkkYzIDjOJUeLYidr3za7g5tRxpksCDSdKEG33+MjYRi01ls398W10bjZ6dYDMO9++m5
         EiPDZsQZS706yvTNNSD8ys/4XE0oJI1d4KG2MyiFyRY1V01AXnNBMYaF0WtlbQ1PXJKl
         IabtR/JPCK2kQedNkeipS5+l7H5eRaa1CT5dp1zpTB2MLT2bhbQDB/70ObNyew1CCVll
         BSf9tUizHn8rFc8KiR4eR3OQKQjip1zdD8lfL9e2H/zHIojWKigGezvpjthqfCjlxyD2
         IiHw==
X-Gm-Message-State: AJcUukeUCdrYRfY8yyZZquNrK9a2s53Z7BLe5U/RFObrR3gERkYqrqAn
        DsJJv9O3dAuIfvhak+g9Xk9o
X-Google-Smtp-Source: ALg8bN5aVRMENZwWODam+9GBXodJhtO1QXkbGFKxoyR3b+ubqSaDT2avkxozUJ575izNZjKdx67xKQ==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr32240493pfl.106.1548130940258;
        Mon, 21 Jan 2019 20:22:20 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
        by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 20:22:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/5] dt-bindings: arm: fsl: Add devicetree binding for Oxalis
Date:   Tue, 22 Jan 2019 09:51:46 +0530
Message-Id: <20190122042147.5424-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for LS1012A SoC based Oxalis board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 20fb61006f2b..6f85965e9fb4 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -176,6 +176,7 @@ properties:
       - description: LS1012A based Boards
         items:
           - enum:
+              - ebs-systart,oxalis
               - fsl,ls1012a-rdb
               - fsl,ls1012a-frdm
               - fsl,ls1012a-qds
-- 
2.17.1

