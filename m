Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D379ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3448D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="c3dPRrt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3448D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKHXEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:04:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36526 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKHXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:04:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id z13-v6so18879319wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kJJRkXU+s0lNK/6NzH/lJ3Yu+N4kSAfk4xdlT1u/3lw=;
        b=c3dPRrt6jaroc+p6Maql3o32dtPi9GhWyMoFCSzwdGvR5sLB5118vkqrSPshAvs7Ub
         XdrqHY3jA6mjyPLojZqz9NYLhtkULKwf90biqJkjM1nbXWQQQ9e2Bjg1N8ehQ2LHu+7X
         MnHPnxOxnOFDlSbSu3SVsd3lruXv9rdZSV39iLA8tZWM5D1bygXGZaMBsyZcTEPm07vT
         PQBQJtoPuHVo/WcPycsE7DpNc+O5kBr1bpiQTSKL4ceQJzzrsiGPgPWUntKeR9q3q6e9
         +VrSE9KjfV+CnynL/I4tyEfwUHtSPSfdm0p1iiHfqXcdB/ELoG/Cw4H9tMf+tWaLpJ54
         tbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=kJJRkXU+s0lNK/6NzH/lJ3Yu+N4kSAfk4xdlT1u/3lw=;
        b=BbeYc2dEps7NC8rxf8ppw+wL4XzhhiU/LS0W1DwPYtu+noS3Ur69TUbE6lJL2QbCA8
         moNt8+AKTV1ka5uDZnmLKNRtFpWJg3zRmKizuaVpc0qmpGQRMlLnrs01lziSS2dDE+Am
         zF34Wnva/2lSp55mk6xhgSldBL4jSLKpK6qpbUEKIJLw7v2HfGfMzwF5FZ1blA3C80Bk
         V0qVu+C1PgmeEJhORQrYqO0MVP6jEAkJKuwwLHGotYSUOMiX+wxyVOAzYg7BJGeFJYOu
         7uqp/C8DmoIUhuaIYiY6JILFRWcSnyfp3IRc9k6lQuJ1RYzYTtpjWe6vC6E9c3lnd0SD
         8h/A==
X-Gm-Message-State: AGRZ1gKC1CjwA551i67k0PgZEw2AHL0S0/N7S0lPr7TYLLMvPgKXP/57
        FiSUgSIbf+QQEt/DR0MP1tFSIQ==
X-Google-Smtp-Source: AJdET5fGd1vJG0mhd7cxR6yuEDGmSsSYFdwsKRAGzDaw+yJZ4DLTw9XwTKdj7hSKbR8ZnHWs0JpFpg==
X-Received: by 2002:adf:9441:: with SMTP id 59-v6mr4005763wrq.305.1541683739366;
        Thu, 08 Nov 2018 05:28:59 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j129-v6sm5313108wmb.47.2018.11.08.05.28.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 05:28:58 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Rob Herring <robherring2@gmail.com>
Cc:     monstr@monstr.eu, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: arm: Add missing Xilinx boards
Date:   Thu,  8 Nov 2018 14:28:54 +0100
Message-Id: <21fdf3098b45ff1a47f271d4b2a5e496dd39a81c.1541683727.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing description for Ultra96, zcu104, zcu106 and zcu111.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git yaml-bindings

---
 Documentation/devicetree/bindings/arm/xilinx.yaml | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index dd227bccf015..a7c545464620 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -69,6 +69,14 @@ properties:
           - const: xlnx,zynqmp-zcu100
           - const: xlnx,zynqmp
 
+      - description: Xilinx 96boards compatible board Ultra96
+        items:
+          - const: avnet,ultra96-rev1
+          - const: avnet,ultra96
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
       - description: Xilinx evaluation board zcu102
         items:
           - enum:
@@ -78,4 +86,28 @@ properties:
           - const: xlnx,zynqmp-zcu102
           - const: xlnx,zynqmp
 
+      - description: Xilinx evaluation board zcu104
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu104-revA
+              - xlnx,zynqmp-zcu104-rev1.0
+          - const: xlnx,zynqmp-zcu104
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu106
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu106-revA
+              - xlnx,zynqmp-zcu106-rev1.0
+          - const: xlnx,zynqmp-zcu106
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu111
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu111-revA
+              - xlnx,zynqmp-zcu11-rev1.0
+          - const: xlnx,zynqmp-zcu111
+          - const: xlnx,zynqmp
+
 ...
-- 
1.9.1

