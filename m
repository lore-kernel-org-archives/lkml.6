Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEF9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9CA20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9CA20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbeGWEKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:10:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56456 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbeGWEKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:10:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CCFD51A0094;
        Mon, 23 Jul 2018 05:11:46 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8ECBD1A0074;
        Mon, 23 Jul 2018 05:11:46 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id F0AB640C94;
        Sun, 22 Jul 2018 20:11:45 -0700 (MST)
Received: from mega.am.freescale.net ([10.192.208.232])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6N3BZOs018846;
        Sun, 22 Jul 2018 20:11:43 -0700
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ran.wang_1@nxp.com, pengbo.mu@nxp.com
Subject: [PATCH v6 3/4] arm64: dts: dwc3: description of incr burst type
Date:   Mon, 23 Jul 2018 11:11:26 +0800
Message-Id: <1532315487-23137-3-git-send-email-pengbo.mu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532315487-23137-1-git-send-email-pengbo.mu@nxp.com>
References: <1532315487-23137-1-git-send-email-pengbo.mu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of 'snps,incr-burst-type-adjustment'

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
---
Changes in v1:
 - add description of 'snps,incr-burst-type-adjustment' property
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 7f13ebe..3e4c38b 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -96,6 +96,11 @@ Optional properties:
 			enable periodic ESS TX threshold.
 
  - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+ - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
+			register, undefined length INCR burst type enable and INCRx type.
+			When just one value, which means INCRX burst mode enabled. When
+			more than one value, which means undefined length INCR burst type
+			enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
 
  - in addition all properties from usb-xhci.txt from the current directory are
    supported as well
@@ -108,4 +113,5 @@ dwc3@4a030000 {
 	reg = <0x4a030000 0xcfff>;
 	interrupts = <0 92 4>
 	usb-phy = <&usb2_phy>, <&usb3,phy>;
+	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 };
-- 
2.7.4

