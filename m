Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701CCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB82098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6wFADpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFB82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbeJQBN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6918220658;
        Tue, 16 Oct 2018 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710549;
        bh=KRMxz0wFkppIk/iq9RcYptNf8+KQt8x2KKxDFCMOmRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6wFADpKdMSc9AdT6mbrGRxH/xj8jZEKfseG8UP1PaZy285DXcgHBW1oxVKGtmKbm
         7nSeGWxUV5qhrHgEcef9waJvrE9mGt8YPon/B2WJQ/vqn0757GhjYv8KZT1wNERGxn
         IXViWRYj/WOo1uE1fsi9+A0dip2SKCR8l/pUuYhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.14 085/109] ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs
Date:   Tue, 16 Oct 2018 19:05:53 +0200
Message-Id: <20181016170529.640635748@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit f5683e76f35b4ec5891031b6a29036efe0a1ff84 upstream.

Add CPU part numbers for Cortex A53, A57, A72, A73, A75 and the
Broadcom Brahma B15 CPU.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/cputype.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -77,8 +77,16 @@
 #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
 #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
+#define ARM_CPU_PART_CORTEX_A53		0x4100d030
+#define ARM_CPU_PART_CORTEX_A57		0x4100d070
+#define ARM_CPU_PART_CORTEX_A72		0x4100d080
+#define ARM_CPU_PART_CORTEX_A73		0x4100d090
+#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
 #define ARM_CPU_PART_MASK		0xff00fff0
 
+/* Broadcom cores */
+#define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+
 /* DEC implemented cores */
 #define ARM_CPU_PART_SA1100		0x4400a110
 


