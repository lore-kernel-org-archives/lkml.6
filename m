Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBC520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="p5t0c0v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfAaVdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:33:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38741 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfAaVdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:33:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so1920929pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wlcvbiL72Jc8Iz+RcmHbInQeojUnOtdkjgRRDx3HUhs=;
        b=p5t0c0v4lWbBwMZ7CTozVDFGIbcTbyg8+PkvJl3NC47GkknFZLzShWuxidH+r784sE
         PQlVbd3OnOpAvbcuNPctXs42PrIf60fU+ZvF+tPfnGgskSw+gzIAVAoIVzt4nRwvo3i3
         SnxALNnI/2kCAuvKi4It5wXersySHRQnwXRimX8QoJobwk4DKJkavOX/5Kmg1c+SBqP6
         HcPZvePFSBfinzBT5RbEZnQ/e4tZU9z0H3/l1CcvM98YjtSwpE/jX6VVGmuWSAJR0G5h
         pm44iRSmSurMpqV/l6leBoNhKqBb/iFJ5awEK10SSFuQ7Q0i2j9PHd0g6820LAdv6SBe
         FKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wlcvbiL72Jc8Iz+RcmHbInQeojUnOtdkjgRRDx3HUhs=;
        b=dVn4aCUd8VM4NLCuWacS1EPVURNkoCeB81KBaHI26iLTCzDKOZQ6PZEjuOYuzCGTQV
         FdfxinsI/AXtFIsnLXES48gYi8CsXvCZ+tUPj/da46iyOKzmERMQCWheDDlW6TtSIA/4
         KVQSn73LbpUoIM/vL8Pr1TMzXpuoev8GYV18+9fdkFQXWp8m7C9zgVzXrw/IgpUM03Jy
         ou1dBSs8F0vOFRFUJEFWeghBA6M5v2F4HommT45JA0LTr5r8WUbF6EReSC2sFi5ja2fL
         aHJUjMaiXcLTlHUXbDF9A9ytvS4QTjZiyQwWhygFZjpZCkF/fA7J/yrfYXZQGxKh4TPU
         j/dw==
X-Gm-Message-State: AJcUukfriEXW22udcPNwWa49FcptMY6NymAKGvteQwhEOMnXjfANefyh
        +pilOaZ7zMvd5Nrk9qMx+FRXVw==
X-Google-Smtp-Source: ALg8bN7UTeCae1p33PbeE6AjL5NQJRvbkfAGXfCdUP2IiCr8nhEyKOkNf8bvj3vTDlBRYtALnT7dvQ==
X-Received: by 2002:a62:9683:: with SMTP id s3mr36269753pfk.60.1548970421328;
        Thu, 31 Jan 2019 13:33:41 -0800 (PST)
Received: from localhost.localdomain (cpe-76-176-152-96.san.res.rr.com. [76.176.152.96])
        by smtp.gmail.com with ESMTPSA id n21sm7513227pfg.84.2019.01.31.13.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:33:40 -0800 (PST)
From:   alex.williams@ettus.com
To:     davem@davemloft.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mdf@kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williams <alex.williams@ni.com>
Subject: [PATCH v2 net-next 2/2] net: nixge: Update device-tree bindings with v3.00
Date:   Thu, 31 Jan 2019 13:33:28 -0800
Message-Id: <20190131213328.11236-2-alex.williams@ettus.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190131213328.11236-1-alex.williams@ettus.com>
References: <20190131213328.11236-1-alex.williams@ettus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williams <alex.williams@ni.com>

Now the DMA engine is free to float elsewhere in the system map.

Signed-off-by: Alex Williams <alex.williams@ni.com>
---
 Documentation/devicetree/bindings/net/nixge.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
index e55af7f0881a..44a7358b4399 100644
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
@@ -12,8 +18,10 @@ Required properties:
 
 Examples (10G generic PHY):
 	nixge0: ethernet@40000000 {
-		compatible = "ni,xge-enet-2.00";
-		reg = <0x40000000 0x6000>;
+		compatible = "ni,xge-enet-3.00";
+		reg = <0x40000000 0x4000
+		       0x41002000 0x2000>;
+		reg-names = "dma", "ctrl";
 
 		nvmem-cells = <&eth1_addr>;
 		nvmem-cell-names = "address";
-- 
2.14.5

