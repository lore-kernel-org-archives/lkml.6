Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ECDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A47C2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="VMCTzpEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A47C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbeJ3IGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:06:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44307 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbeJ3IGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:06:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so2907616plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fm7yU+IPqStpF4GVG7SWRKbt+kBSEs6i60c8bLN4JUw=;
        b=VMCTzpEqFq5Ob9/uncABBwL7o/8R0L5LYB4Vi8myq95BqOdUvDMuCl7yVExS+rxK6m
         zKftqu6GXzPgjq5HTWDlOOpwB3q1lH93hDQiIrl01mHwqThKFvZA8NHXQGyfNZQx8z5c
         TiZr+Oy3KJVXR4koMB8jUbe5o4KjuPc0z841NigWPZujWTCA3BdUnJizNA5cLsXBUBUM
         UVshxwWGZ+LOfsicQL87radDf9Il1MHdaQ8TK4ifBPu31nTCsUYZRO2Ki8ubgmGcmkHN
         uID5c6WWr+JVQtxAjoWisQjGLAgIt+kAGZ/x9WTgd+vxEtrclT+w8fzP7EIxYeKSTPv5
         wtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fm7yU+IPqStpF4GVG7SWRKbt+kBSEs6i60c8bLN4JUw=;
        b=UyNO8DimISdOnRd+pMw8vaSd1PgNm6uIWbrnO2Jvnq9sNmAzEnz6VrvtlEj6N8717k
         4X0OdTeKS2Pp1BAwG9LcpW0Y1V371lAeGNR4Mi4uQx1Qg+E+24FzMzHEmT9FVkAcHWHX
         IpX5KJX3wW/H9PMO604yvVRkZjR4DkeDjVBt21jW/USxQlcYiT3eDFD/qshLQldMhqK6
         ulxVKeVl6NKi3F49h+yW/Gc5eJOSG//QCZjlN0cJmPum8O/Zva8w1WVNueE+bICWZPh/
         fF1DzN79fISjUvxcp0Ztl3omcwt9nc4Kq1jWIxd7LfPeK9io20dW83MtTbdaWy9RP7nA
         8PJg==
X-Gm-Message-State: AGRZ1gJQW5QNsPuAcNzvbAmjjULFfUqIdtfmOiMPs0FxP477O2t8qsg2
        5ltqBVWTDmo9nHGmbA9ym31OWQ==
X-Google-Smtp-Source: AJdET5eXo51lMb2QmLPzn74FplDxF0B/Bys/sN+E1AoZ+s/DDJKMyBboz/zE00C0jxAk3xu9iIPw7g==
X-Received: by 2002:a17:902:4281:: with SMTP id h1-v6mr16325013pld.114.1540854938637;
        Mon, 29 Oct 2018 16:15:38 -0700 (PDT)
Received: from localhost.localdomain (cpe-76-176-152-96.san.res.rr.com. [76.176.152.96])
        by smtp.gmail.com with ESMTPSA id r18-v6sm21698122pgv.17.2018.10.29.16.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 16:15:37 -0700 (PDT)
From:   alex.williams@ettus.com
To:     netdev@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mdf@kernel.org, keescook@chromium.org,
        Alex Williams <alex.williams@ni.com>
Subject: [PATCH net-next 2/2] net: nixge: Update device-tree bindings with v3.00
Date:   Mon, 29 Oct 2018 16:14:47 -0700
Message-Id: <20181029231447.3690-2-alex.williams@ettus.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181029231447.3690-1-alex.williams@ettus.com>
References: <20181029231447.3690-1-alex.williams@ettus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williams <alex.williams@ni.com>

Now the DMA engine is free to float elsewhere in the system map.

Signed-off-by: Alex Williams <alex.williams@ni.com>
---
 Documentation/devicetree/bindings/net/nixge.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
index e55af7f0881a..d0f9fb520578 100644
--- a/Documentation/devicetree/bindings/net/nixge.txt
+++ b/Documentation/devicetree/bindings/net/nixge.txt
@@ -1,8 +1,14 @@
 * NI XGE Ethernet controller
 
 Required properties:
-- compatible: Should be "ni,xge-enet-2.00"
-- reg: Address and length of the register set for the device
+- compatible: Should be "ni,xge-enet-3.00", but can be "ni,xge-enet-2.00" for
+              older device trees with DMA engines co-located in the address map,
+              with the one reg entry to describe the whole device.
+- reg: Address and length of the register set for the device. It contains the
+       information of registers in the same order as described by reg-names.
+- reg-names: Should contain the reg names
+	"dma":  DMA engine control and status region
+        "ctrl": MDIO and PHY control and status region
 - interrupts: Should contain tx and rx interrupt
 - interrupt-names: Should be "rx" and "tx"
 - phy-mode: See ethernet.txt file in the same directory.
@@ -13,7 +19,9 @@ Required properties:
 Examples (10G generic PHY):
 	nixge0: ethernet@40000000 {
 		compatible = "ni,xge-enet-2.00";
-		reg = <0x40000000 0x6000>;
+		reg = <0x40000000 0x4000
+		       0x41002000 0x2000>;
+		reg-names = "dma", "ctrl";
 
 		nvmem-cells = <&eth1_addr>;
 		nvmem-cell-names = "address";
-- 
2.14.5

