Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7087EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3F82087F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199804;
	bh=wawbdMrQ12CX6VvmHXqtMvqXPPUuOhIDEcJcALjtnPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BcUnjW7Igh6iC2Wsn+b2u7i2iDb5aSmSm6uuBZjm3/UfVGxFWKW2evzVkaP4I45X7
	 hiLpKdWkfr9v4hxkAVYElfHATiJc3VLiaYbVQI0yL1BbCNUQll1Ym3Pb8KUOfKbcCA
	 bH2hMR4rI2SYavBktu+RIjxEMOxqxAKU69u/B4cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeL3T4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeL3T4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:31 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C2B20836;
        Sun, 30 Dec 2018 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199791;
        bh=wawbdMrQ12CX6VvmHXqtMvqXPPUuOhIDEcJcALjtnPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqNezme11RhPiir4Sk/VbmSaDwkuh/+64huNK1EBoqhJ4C4LKQPGFkjVQ+a3aaZvW
         8Wsbkz/qQf3qAecMkuTwrr/kR8mBbbW8WpDwhZtQcs6pQls6N7Aw8s/1X4ILiG/uRe
         SQzTrahER4D0nisNjx5skmScvDbsNQ9Re4Mrlvz8=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v4 10/11] x86/intel/lpss: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:11 +0000
Message-Id: <20181230195612.6657-11-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPSS code relies on PCI infrastructure but this dependency has not been
explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
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

