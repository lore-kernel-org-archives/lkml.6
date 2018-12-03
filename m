Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C993C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F9F20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CjuBsuRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F9F20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLCU5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:57:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19087 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLCU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543870660; x=1575406660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3mJpoam2A2xj4ZksT23VyuZFVe6fICI7QinZh5RdjX0=;
  b=CjuBsuRc/lJa1aUXaU8tmSUFSDmp88vQxPVjdYQHosV/yI8lNWYnfh5J
   F7G37rlYN6wZQeGQegDr3q8Na69hWK/dkw+IQC+vWQbRgFzrFE3YDwz+l
   ERREk4QeXM2KAa8i+ieN20jrC4kjO8gJhaNx/rdjWITKFPzeYfrYbH2ZF
   oKTq+SxgAontDTEGlo0wgm1jIJlqykbdM2T3HPwdqT4PjZfomcdkUlzQG
   FlVLfq9c8y6NBfOpqrDpEIhOqZfYYR2z32Rx0ClNlS3OLQBQxTfh5wL4y
   Xv5KaU4eRFKHoNAuzJ9P1spumE935fVHqXzvrvuFh7T1uNSDldOJlNUB8
   A==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; 
   d="scan'208";a="100519857"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 04:57:39 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Dec 2018 12:39:55 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 12:57:39 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 1/4] dt-bindings: Correct RISC-V's timebase-frequency
Date:   Mon,  3 Dec 2018 12:57:28 -0800
Message-Id: <1543870651-16669-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
References: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

Someone must have read the device tree specification incorrectly,
because we were putting timebase-frequency in the wrong place.  This
corrects the issue, moving it from

/ {
        cpus {
                timebase-frequency = X;
        }
}

to

/ {
        cpus {
                cpu@0 {
                        timebase-frequency = X;
                }
        }
}

This is great, because the timer's frequency should really be a per-cpu
quantity on RISC-V systems since there's a timer per CPU.  This should
lead to some cleanups in our timer driver.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
index adf7b7af..b0b038d6 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.txt
+++ b/Documentation/devicetree/bindings/riscv/cpus.txt
@@ -93,9 +93,9 @@ Linux is allowed to run on.
         cpus {
                 #address-cells = <1>;
                 #size-cells = <0>;
-                timebase-frequency = <1000000>;
                 cpu@0 {
                         clock-frequency = <1600000000>;
+                        timebase-frequency = <1000000>;
                         compatible = "sifive,rocket0", "riscv";
                         device_type = "cpu";
                         i-cache-block-size = <64>;
@@ -113,6 +113,7 @@ Linux is allowed to run on.
                 };
                 cpu@1 {
                         clock-frequency = <1600000000>;
+                        timebase-frequency = <1000000>;
                         compatible = "sifive,rocket0", "riscv";
                         d-cache-block-size = <64>;
                         d-cache-sets = <64>;
@@ -145,6 +146,7 @@ Example: Spike ISA Simulator with 1 Hart
 This device tree matches the Spike ISA golden model as run with `spike -p1`.
 
         cpus {
+                timebase-frequency = <1000000>;
                 cpu@0 {
                         device_type = "cpu";
                         reg = <0x00000000>;
-- 
2.7.4

