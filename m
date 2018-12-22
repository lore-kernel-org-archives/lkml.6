Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3EDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E4521927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437745;
	bh=PerGQ42UQp7XIjrqw16tnFzYITpTV97rKyz/MRILHh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tIuKkzcaCIKL5q4pnXFBn1wWk31Cd9pnmfSZfOZiRgTvi6q6YtiPsBrTk/L07JTk8
	 zhekXH7CwWSLCD5L3mNNN/EdOFslHlMN44bBSgx4p5IxR63ynYuARkHSkeEwpmoJDR
	 dO9e2ZemHH7IozpXMne6TGAygS9jzbtkVWDYQa0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404788AbeLVAPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404744AbeLVAPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:15 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA1621939;
        Sat, 22 Dec 2018 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437715;
        bh=PerGQ42UQp7XIjrqw16tnFzYITpTV97rKyz/MRILHh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTtVUKnbQhVJfx0UqcEp/7ePVdU+ctvhC87jiqVHXE+0uBPSErDKdXBoZb4uHYSs0
         eNbVlJ7d9+MafTQc2f+Ua9ijR3Yn8I417kLjGejx4MhapJL7Fd5mQ8Au7fOQOT3MfK
         HrlzHPrdMbG9BV0Xga0QBA6tfG9UDuulj8zDQ16w=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v1 10/11] x86: select IOSF_MBI only when CONFIG_PCI is set
Date:   Sat, 22 Dec 2018 00:14:51 +0000
Message-Id: <20181222001452.7474-11-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need CONFIG_PCI to be set in order to be able to use IOSF_MBI
functionality.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cc4f0c6ee1ed..322a58ababb0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -617,7 +617,7 @@ config X86_INTEL_QUARK
 
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select COMMON_CLK
 	select PINCTRL
 	select IOSF_MBI
-- 
2.19.0

