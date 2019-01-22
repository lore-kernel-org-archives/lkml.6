Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A798C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE5820866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfAVVwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:52:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVVwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:52:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MLpuG13119316
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 13:51:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MLptkV3119312;
        Tue, 22 Jan 2019 13:51:55 -0800
Date:   Tue, 22 Jan 2019 13:51:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sinan Kaya <tipbot@zytor.com>
Message-ID: <tip-625210cfa6c0c26ea422f655bf68288176f174e6@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        okaya@kernel.org, mingo@redhat.com
Reply-To: x86@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@redhat.com, okaya@kernel.org, mingo@kernel.org, bp@suse.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190121231958.28255-2-okaya@kernel.org>
References: <20190121231958.28255-2-okaya@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is
 enabled
Git-Commit-ID: 625210cfa6c0c26ea422f655bf68288176f174e6
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

Commit-ID:  625210cfa6c0c26ea422f655bf68288176f174e6
Gitweb:     https://git.kernel.org/tip/625210cfa6c0c26ea422f655bf68288176f174e6
Author:     Sinan Kaya <okaya@kernel.org>
AuthorDate: Mon, 21 Jan 2019 23:19:58 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 22 Jan 2019 17:06:28 +0100

x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is enabled

After commit

  5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")

dependencies on CONFIG_PCI that previously were satisfied implicitly
through dependencies on CONFIG_ACPI have to be specified directly.

PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
mentioned in the Kconfig so add an explicit dependency here and fix

  WARNING: unmet direct dependencies detected for PCI_LOCKLESS_CONFIG
    Depends on [n]: PCI [=n]
    Selected by [y]:
    - X86 [=y]

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190121231958.28255-2-okaya@kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b4a7f32b68e..26387c7bf305 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -198,7 +198,7 @@ config X86
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
-	select PCI_LOCKLESS_CONFIG
+	select PCI_LOCKLESS_CONFIG		if PCI
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
