Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2A9C282C8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3EA21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICkeb7HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfAVEWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:22:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44686 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfAVEWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:22:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so10792718plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qh9OH2ewndXqi7LmYpIulU5BfBE/yUMVvx34aUuKYu0=;
        b=ICkeb7HRNIH9VLfwNSH+e9HuXwGT5x7DgnnfjwxgUJrUM17uD5HgT73ahqxLOeGTHu
         FLJhMxTvCnvZ510Ay3ZCHeXKDuJSGqcJWBpmLDnc7woc9NR0FUbO9DvlvMFu6UG15fl1
         XcLpLTRg3AQVGIpgn6ZWXYRnrKm9GJZF7q16E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qh9OH2ewndXqi7LmYpIulU5BfBE/yUMVvx34aUuKYu0=;
        b=VNHCQMih6dKrid/lE2ejrzcZkCh5SL4mMy1kNi7LKADRfc+Cl5W425WnvHndsPqQeK
         GuLfhvHnzmcavevpK8SvISHPxo6hCLiwcKF/AOJKN4mzMgEAgSEk0S+vo3YX+f3I3ck4
         CFOMGjJWpL5efiOR/fe8560oiQkEx5zeBeJxR6IOfqe0J6RoIlixqjskvPRBv9lyPJpZ
         phHLZNArtLw7Wx1N9LMwu4+5y0fwfsk4qhNDbud73o7skhVksZEv6sLJRvRTliIZiO5v
         pM82vOnjFgS+KTYjO1UCUUCtFlzTTCZXNbnlfSbPQ0vDxYU5sg+9AJdCD1mvqFQ9uzq6
         jjYw==
X-Gm-Message-State: AJcUukeKrrFrveUE8hmtnJqDCUXlUgB3P+uLcRcpdaSm6MSN9WjdduEH
        jcG+g+lMpgfEqZCrjPcGEBGQBpGKOw==
X-Google-Smtp-Source: ALg8bN6+W9kfH9ubBJQ+oNWmtl6QwFd+5/vhMV/fvcYNf3EekCAbeAmIvchON8qbdu0113MEFRwU2g==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr32192473plb.46.1548130924334;
        Mon, 21 Jan 2019 20:22:04 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
        by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 20:22:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/5] dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based boards
Date:   Tue, 22 Jan 2019 09:51:43 +0530
Message-Id: <20190122042147.5424-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix devicetree bindings for Freescale LS1012A and LS1021A SoC based boards.

Fixes: a1a38e1f4d1d ("dt-bindings: arm: Convert FSL board/soc bindings to json-schema")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d34fe0749199..20fb61006f2b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -173,12 +173,20 @@ properties:
               - fsl,vf610
               - fsl,vf610m4
 
-      - description: LS1021A based Boards
+      - description: LS1012A based Boards
         items:
           - enum:
               - fsl,ls1012a-rdb
               - fsl,ls1012a-frdm
               - fsl,ls1012a-qds
+          - const: fsl,ls1012a
+
+      - description: LS1021A based Boards
+        items:
+          - enum:
+              - fsl,ls1021a-moxa-uc-8410a
+              - fsl,ls1021a-qds
+              - fsl,ls1021a-twr
           - const: fsl,ls1021a
 
       - description: LS1043A based Boards
-- 
2.17.1

