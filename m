Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B9CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F6E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbXaSmAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F6E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGSLhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:37:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40189 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbeGSLho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:37:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so3470919pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FpNQDKwAonjqvoukl3WObBvX3Y5bPh4aNQFopg9JSV0=;
        b=GbXaSmAZTskrPhtm4SOAMJ8qyjHWmjXf+qsO2ntxH9sKNQ40vVYlePvjPvysNGKU4N
         RzLAgoKbTXn4vbNucNmCsKFUEt9208TWHuETI2SRtkSmCkpc7yqOKvGv4NzK5K4YqULg
         o7uE2glTeicUqqHRz7WsWl4DTw4lmUw2G3VFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FpNQDKwAonjqvoukl3WObBvX3Y5bPh4aNQFopg9JSV0=;
        b=SonIp1eUuqTxrhh1trC5fXYSZBeO/s/SGVjAs3EM1kv4fv0z/wj677rRqKIsb+kdgM
         NHkbc8q+byFGCMhfz3pOUcnhU0nzUo7tRCYd2Ok6A2D3qySmubJAdXyE+UH2+1ox8/yr
         inou7Lr0nZd6McJHrfPkKtgo9Mb58llcLYJv+akqNI2CwZojudYowsuMvSpTvY+GSzMF
         2bEdCPiRU99G+XluBVbFTWCJ1CSJoECtPBwQbUt1WJVMiTyN6S0HifWlkSu5r19YwP22
         +fnQeq2aAuMSs9dT06DBh05CAaJY8msNqNR8G3cr7iovWvioUeweawldEHqu2yjlhhn5
         iX/Q==
X-Gm-Message-State: AOUpUlE3jc88yILTLw0sC4kkpIm7RkXcMhz+2ByMoX+Co7iAqb8j0cnK
        2Cyud1G3aSfLRSEp1EVlHJAW
X-Google-Smtp-Source: AAOMgpe8CO3et9aXLBzHSqiRNAtIZ0fI5Josor0ICQY8G5todnH+LY+ztdGMl2MiWMO4CSYBYY5mWA==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr9512175pgp.65.1531997708730;
        Thu, 19 Jul 2018 03:55:08 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 85-v6sm3653262pgd.81.2018.07.19.03.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 03:55:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
Date:   Thu, 19 Jul 2018 16:24:49 +0530
Message-Id: <1531997690-6040-2-git-send-email-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Mediatek X20 Development Board which is a 96Boards Consumer
Edition platform based on MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..356df1e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -47,6 +47,9 @@ Supported boards:
 - Evaluation board for MT6797(Helio X20):
     Required root node properties:
       - compatible = "mediatek,mt6797-evb", "mediatek,mt6797";
+- Mediatek X20 Development Board:
+    Required root node properties:
+      - compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
 - Reference board variant 1 for MT7622:
     Required root node properties:
       - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
-- 
2.7.4

