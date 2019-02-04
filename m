Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACFAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1EF2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="hUUUihBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfBDRbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:31:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42166 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfBDRa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:30:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so209740pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQIR+vQkRw03k7f92bCCQ4fkFdpX2pG/UQ43gReR3v4=;
        b=hUUUihBrOU63Ld/TuDFBawn3XJYBlwYLusn++lYN0EMoyw1EFSJGqb+1U6OPJruy+k
         X3JdQf/ELBjAk9D39XW9kV42mu4CRMpqoetJXG0UhnFQEjGSJ+FocV8cIgMljAdSJYM/
         i+vCQ6a9t0LtPGM5FAp3qb/fDc7XSpjlnhkoknv2G6GgOudoDvMC1nO3SCtt6q73jGi4
         thvTc04fwlK0KlYjIXj3YTmjfcRY6ODLyB40NXJ336Q5bBbysLOfHFU8/4un8u0e7oPG
         rndbNBH0VfTEXk9BERN5hzCaHrC60DqSW2GakD06Rp84qhhxtyGSZlvQ/8RvBHp6KxcF
         B+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQIR+vQkRw03k7f92bCCQ4fkFdpX2pG/UQ43gReR3v4=;
        b=ZUf+8mVfwuvZhRxCR6PmnjF3pJdwknyMxgOWx5Q6Bz/GPyjJfmDvKBpoO62+yGtLb/
         k91NX5Zm8VRBvP9wJrmqpX7Uj6nIXqbSTGgx/jY83mIywZZZOTERI9GPaLbpDu4z6jh4
         vnntzpYXA4XppWXxH3ITIfThSNz8rO+mGkTtLEImmbANLu1PbbBpET9GYB2gMQTHYGkS
         iDvuh27UM9up0c522dDMOvlFjpOYGfjEYVpGSOVHW20Ow516X7bk66HYFsJHHuG3yq2U
         wcZakUFUN5q5DSxKUrmadRx1HMbym03KLOL8Ldh1c60Q7e6qTHbQEnkKpAGwqbZ15hNC
         uNMQ==
X-Gm-Message-State: AHQUAubSTPwkgEj3e7p23gnuD5LU8FO3DeKSid/hnvjXV3DswJX2KSzc
        7AHqN18n/K7YlUg3tJimcUz+3w==
X-Google-Smtp-Source: AHgI3Ib4WCSRBf+WFdSunDIaUdDJOwXjIkqwp+XXCV49C6XfgX5YUHWr5DdBrMDGcvrDfqXikQ6ROw==
X-Received: by 2002:a62:53c5:: with SMTP id h188mr478199pfb.190.1549301458476;
        Mon, 04 Feb 2019 09:30:58 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id d18sm815373pfj.47.2019.02.04.09.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:30:58 -0800 (PST)
From:   Moritz Fischer <moritz.fischer@ettus.com>
To:     netdev@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williams@ni.com, andrew@lunn.ch, robh+dt@kernel.org,
        davem@davemloft.net, moritz.fischer@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next 3/3] dt-bindings: net: Add fixed-link support
Date:   Mon,  4 Feb 2019 09:30:40 -0800
Message-Id: <20190204173040.5538-4-moritz.fischer@ettus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204173040.5538-1-moritz.fischer@ettus.com>
References: <20190204173040.5538-1-moritz.fischer@ettus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Update device-tree binding with fixed-link support.

With fixed-link support the formerly required property 'phy-handle'
is now optional if 'fixed-link' child is present.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../devicetree/bindings/net/nixge.txt         | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
index bb2929f9c64f..85d7240a9b20 100644
--- a/Documentation/devicetree/bindings/net/nixge.txt
+++ b/Documentation/devicetree/bindings/net/nixge.txt
@@ -12,12 +12,14 @@ Required properties:
 - interrupts: Should contain tx and rx interrupt
 - interrupt-names: Should be "rx" and "tx"
 - phy-mode: See ethernet.txt file in the same directory.
-- phy-handle: See ethernet.txt file in the same directory.
 - nvmem-cells: Phandle of nvmem cell containing the MAC address
 - nvmem-cell-names: Should be "address"
 
 Optional properties:
 - mdio subnode to indicate presence of MDIO controller
+- fixed-link : Assume a fixed link. See fixed-link.txt in the same directory.
+  Use instead of phy-handle.
+- phy-handle: See ethernet.txt file in the same directory.
 
 Examples (10G generic PHY):
 	nixge0: ethernet@40000000 {
@@ -59,3 +61,32 @@ Examples (10G generic PHY, no MDIO):
 		phy-mode = "xgmii";
 		phy-handle = <&ethernet_phy1>;
 	};
+
+Examples (1G generic fixed-link + MDIO):
+	nixge0: ethernet@40000000 {
+		compatible = "ni,xge-enet-2.00";
+		reg = <0x40000000 0x6000>;
+
+		nvmem-cells = <&eth1_addr>;
+		nvmem-cell-names = "address";
+
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>, <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rx", "tx";
+		interrupt-parent = <&intc>;
+
+		phy-mode = "xgmii";
+
+		fixed-link {
+			speed = <1000>;
+			pause;
+			link-gpios = <&gpio0 63 GPIO_ACTIVE_HIGH>;
+		};
+
+		mdio {
+			ethernet_phy1: ethernet-phy@4 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <4>;
+			};
+		};
+
+	};
-- 
2.20.1

