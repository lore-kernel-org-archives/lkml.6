Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E2CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152202173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6lTl0j/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAJIIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:08:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36346 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfAJIIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:08:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so4864569plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s471nejhsjTfcdDaXDgAGqn3s53gJX07/ZFUZW5j13g=;
        b=E6lTl0j/ez81RlorO/ahP9ZD+M0S2i1xKYNwIHIfWR5+KOhxpZCS/oiuVpu3PpYFZD
         3gWzMTdcemwBNXEt6m3/CTog8fi8bPfJUexd8tpng/ezzuDmsd+xi9JV0kdQoL4u9G07
         vWTZX1ITsMLKj/kYSssG05CaR5xiG/pyrXwC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s471nejhsjTfcdDaXDgAGqn3s53gJX07/ZFUZW5j13g=;
        b=qrtj1cxDsx00BoBFJh04FY6xhv5RTvASJfPKWPwucHffdMa0uMQMWJHIGWsrCgHcQr
         oSNIkvSTtJlWYuF98f+EW/XxsJ/JZWGOU6gUwsdeJQB0uy6pC3bYWRu+XhV/iKP3W1H2
         nJFKzKyGNu4IsxL0iZxnIRjiXA+Vw61Clxfv2EPm53u0ndz9tjayGGIrjx1dX0qDTSvE
         oWU8esh6juzbXZQk7yUOJyNQr/SKl+hEoaDunfv7LYIi+PDJwy62eSQ91iwAdbMDXJlz
         VWgmeY6kqtNXg5qiiFef8V+Ooh8UyKJZaedeYfIPzXE5HT/URPKKzvEeoBrISoRJqAGa
         tOyQ==
X-Gm-Message-State: AJcUukdpF4s+TKURSttFP7dI9ihmzNhqcdA0y5QSbWlDCizLfNBcMHGy
        eazcDN6SoMd6Lb5JPV3Ne07M
X-Google-Smtp-Source: ALg8bN6tb2tVSzhlp99qSCj2VD8vXapiODKSWACxvsWYxU6McbqpOqoMvnU3s5KddyTYuofLPaFhig==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr9629649plp.9.1547107724619;
        Thu, 10 Jan 2019 00:08:44 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:89d:654d:749c:afde:a8a6:224d])
        by smtp.gmail.com with ESMTPSA id w23sm27401007pgc.72.2019.01.10.00.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 00:08:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] dt-bindings: arm: fsl: Add devicetree binding for Oxalis
Date:   Thu, 10 Jan 2019 13:38:20 +0530
Message-Id: <20190110080821.30280-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Oxalis SoM board from EBS-SYSTART GmbH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 7fbc42484001..b3bc70665a47 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -172,6 +172,10 @@ LS1012A ARMv8 based QDS Board
 Required root node properties:
     - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
 
+LS1012A ARMv8 based Oxalis Board
+Required root node properties:
+    - compatible = "ebs-systart,oxalis", "fsl,ls1012a";
+
 LS1043A SoC
 Required root node properties:
     - compatible = "fsl,ls1043a";
-- 
2.17.1

