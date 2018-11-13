Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF01C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78421223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78421223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbeKNIoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:44:34 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:38758 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNIoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:44:23 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993052AbeKMWmhraj5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:42:37 +0100
Date:   Tue, 13 Nov 2018 22:42:37 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] MIPS: SiByte: Enable ZONE_DMA32 for LittleSur
In-Reply-To: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1811132145480.9637@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LittleSur board is marked for high memory support and therefore 
clearly must provide a way to have enough memory installed for some to 
be present outside the low 4GiB physical address range.  With the memory 
map of the BCM1250 SOC it has been built around it means over 1GiB of 
actual DRAM, as only the first 1GiB is mapped in the low 4GiB physical 
address range[1].

Complement commit cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need 
DMA32.") then and also enable ZONE_DMA32 for LittleSur.

References:

[1] "BCM1250/BCM1125/BCM1125H User Manual", Revision 1250_1125-UM100-R,
    Broadcom Corporation, 21 Oct 2002, Section 3: "System Overview",
    "Memory Map", pp. 34-38

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need DMA32.")
---
New in v3.
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

linux-mips-sibyte-littlesur-zone-dma32.diff
Index: linux-20181104-littlesur64-defconfig/arch/mips/Kconfig
===================================================================
--- linux-20181104-littlesur64-defconfig.orig/arch/mips/Kconfig
+++ linux-20181104-littlesur64-defconfig/arch/mips/Kconfig
@@ -805,6 +805,7 @@ config SIBYTE_LITTLESUR
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select ZONE_DMA32 if 64BIT
 
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
