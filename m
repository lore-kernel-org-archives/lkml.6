Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AA220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfAKShG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:37:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfAKShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:37:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0BIarp2767499
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Jan 2019 10:36:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0BIarta767496;
        Fri, 11 Jan 2019 10:36:53 -0800
Date:   Fri, 11 Jan 2019 10:36:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sinan Kaya <tipbot@zytor.com>
Message-ID: <tip-5962dd22f0ff6f7d72fff974b3c637d52586643e@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, bp@suse.de,
        okaya@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          x86@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
          okaya@kernel.org
In-Reply-To: <20190102181038.4418-11-okaya@kernel.org>
References: <20190102181038.4418-11-okaya@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel/lpss: Make PCI dependency explicit
Git-Commit-ID: 5962dd22f0ff6f7d72fff974b3c637d52586643e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5962dd22f0ff6f7d72fff974b3c637d52586643e
Gitweb:     https://git.kernel.org/tip/5962dd22f0ff6f7d72fff974b3c637d52586643e
Author:     Sinan Kaya <okaya@kernel.org>
AuthorDate: Wed, 2 Jan 2019 18:10:37 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 11 Jan 2019 19:32:22 +0100

x86/intel/lpss: Make PCI dependency explicit

After commit

  5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")

dependencies on CONFIG_PCI that previously were satisfied implicitly
through dependencies on CONFIG_ACPI have to be specified directly. LPSS
code relies on PCI infrastructure but this dependency has not been
explicitly called out so do that.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-acpi@vger.kernel.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190102181038.4418-11-okaya@kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15af091611e2..4b4a7f32b68e 100644
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
