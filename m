Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96312C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A8C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A8C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJPRKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:10:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:23710 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbeJPRKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:10:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 02:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="97835800"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2018 02:20:28 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     gregkh@linuxfoundation.org, paul.burton@mips.com, jslaby@suse.com,
        Songjun Wu <songjun.wu@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RESEND PATCH 14/14] dt-bindings: serial: lantiq: Add optional properties for CCF
Date:   Tue, 16 Oct 2018 17:19:15 +0800
Message-Id: <20181016091915.19909-15-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181016091915.19909-1-songjun.wu@linux.intel.com>
References: <20181016091915.19909-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks and clock-names are updated in device tree binding.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 Documentation/devicetree/bindings/serial/lantiq_asc.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
index 3acbd309ab9d..40e81a5818f6 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
@@ -6,8 +6,23 @@ Required properties:
 - interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
   depends on the interrupt-parent interrupt controller.
 
+Optional properties:
+- clocks: Should contain frequency clock and gate clock
+- clock-names: Should be "freq" and "asc"
+
 Example:
 
+asc0: serial@16600000 {
+	compatible = "lantiq,asc";
+	reg = <0x16600000 0x100000>;
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
+	clock-names = "freq", "asc";
+};
+
 asc1: serial@e100c00 {
 	compatible = "lantiq,asc";
 	reg = <0xE100C00 0x400>;
-- 
2.11.0

