Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8F426E4B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq6LDbkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8F426E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeF1Fmf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:42:35 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43142 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753402AbeF1Fmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:42:32 -0400
Received: by mail-qk0-f193.google.com with SMTP id z74-v6so2349026qkb.10;
        Wed, 27 Jun 2018 22:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Zqp/kN7gR56q7EDEf/YJdloYXw1ee8iuiJEak0kz1I=;
        b=Uq6LDbkXskFNuwR6v7159M3MQZr/DsDjCMFzy8gYmRJRNTkxUg9ysK2CP6qFMJG0eV
         NF7LxFXevmR142PYG/S2DQwUnt8X7iSt8F6zXUuVj2VMUkiuOkghZGQGJFk37zIl2izg
         mgSJbhtoD2qoENBbDBEbSC+ef9rvpB/IhVWABzRYEg6AbMjfQa73pw4tWKC51uoWIl7F
         rlI2I+5dkyZBOWYDjNRjeFG1V+8F6vaK60QJw6rQUY3RjabrGn4K8Q2uGsAvkt7+yERM
         zVqzhmGVc7AVtkfiPMEX3pPVTBZAb3WxAJdnn26ZiErszLBvrx+RDSiMWJG/fMuQsQFI
         OXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Zqp/kN7gR56q7EDEf/YJdloYXw1ee8iuiJEak0kz1I=;
        b=UR/WS0OUqUi6L7dcM7gKKItlduPYuVOvsvk+7QrNQjGicbCFKohakhs3apXTZnnuqE
         nLPNWqu4z8JjZI0JYVefzeX+i8gLWyMzSoQmkBWye3lDumladt1M7FEphifMrPRNXik5
         4xKdvwbbyXFJNSM8OPOWTeqzCNRtLKDWgrabOoTdzapRKKvPqBhkHoUR4j9QG9CXjzRX
         GfFzLdcL9UeLKRShE2ub6JCOHbNRj0lTxbmkAwpZ1B9aVePq5mf2xhymv+tTlmq6pu7Y
         jMvlaC+OjBXDhKpHgl9vHzUqVeV372PvNvUxLpo2lfggmwY+565K8eyAEGRWeOHJP1fe
         og3Q==
X-Gm-Message-State: APt69E1ol7ocmdBmCWjdVzEgrYT8NVsg3dMazSRPJRpRopAGIAVDh7zx
        8n0W3Ps9s+JqEFeyzn8n9TQ=
X-Google-Smtp-Source: AAOMgpfxHztyt6DsEVGbfC2Brm1dm7YJsGsBaUrc9grD7DOYLE6CyImJKbUbzBHEzzE/4DoocvZiBg==
X-Received: by 2002:a37:b1c6:: with SMTP id a189-v6mr7546261qkf.321.1530164551796;
        Wed, 27 Jun 2018 22:42:31 -0700 (PDT)
Received: from localhost.localdomain (186-106-135-170.baf.movistar.cl. [186.106.135.170])
        by smtp.gmail.com with ESMTPSA id u40-v6sm3410281qth.24.2018.06.27.22.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:42:31 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [RFC PATCH 4/5] arm: dts: zynq: rename board zed to zedboard
Date:   Thu, 28 Jun 2018 01:42:04 -0400
Message-Id: <20180628054205.17737-5-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628054205.17737-1-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The real name of the board is ZedBoard, from Avnet

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 Documentation/devicetree/bindings/arm/xilinx.txt      | 2 +-
 arch/arm/boot/dts/Makefile                            | 2 +-
 arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} (93%)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index f1e911058..d10adc4d0 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -30,7 +30,7 @@ Additional compatible strings:
   "xlnx,zynq-zc770-xm013"
 
 - Avnet ZedBoard board
-  "avnet,zynq-zed"
+  "avnet,zynq-zedboard"
 
 - Digilent Zybo board
   "digilent,zynq-zybo"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760..e4c39e26f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1108,7 +1108,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zc770-xm011.dtb \
 	zynq-zc770-xm012.dtb \
 	zynq-zc770-xm013.dtb \
-	zynq-zed.dtb \
+	zynq-zedboard.dtb \
 	zynq-zybo.dtb \
 	zynq-zybo-z7.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zedboard.dts
similarity index 93%
rename from arch/arm/boot/dts/zynq-zed.dts
rename to arch/arm/boot/dts/zynq-zedboard.dts
index bf3e26dbf..540581c56 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zedboard.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Avnet ZedBoard board";
-	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-zedboard", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
-- 
2.18.0

