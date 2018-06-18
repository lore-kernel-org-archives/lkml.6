Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B39EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4C2208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4C2208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965817AbeFRI3K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:29:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964856AbeFRI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:29:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE435BBE;
        Mon, 18 Jun 2018 08:29:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 012/189] MIPS: dts: Boston: Fix PCI bus dtc warnings:
Date:   Mon, 18 Jun 2018 10:11:48 +0200
Message-Id: <20180618081209.724660998@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 2c2bf522ed8cbfaac666f7dc65cfd38de2b89f0f ]

dtc recently (v1.4.4-8-g756ffc4f52f6) added PCI bus checks. Fix the
warnings now emitted:

arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@10000000: missing bus-range for PCI bridge
arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@12000000: missing bus-range for PCI bridge
arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@14000000: missing bus-range for PCI bridge

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19070/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/dts/img/boston.dts |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -51,6 +51,8 @@
 		ranges = <0x02000000 0 0x40000000
 			  0x40000000 0 0x40000000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci0_intc 1>,
 				<0 0 0 2 &pci0_intc 2>,
@@ -79,6 +81,8 @@
 		ranges = <0x02000000 0 0x20000000
 			  0x20000000 0 0x20000000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci1_intc 1>,
 				<0 0 0 2 &pci1_intc 2>,
@@ -107,6 +111,8 @@
 		ranges = <0x02000000 0 0x16000000
 			  0x16000000 0 0x100000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci2_intc 1>,
 				<0 0 0 2 &pci2_intc 2>,


