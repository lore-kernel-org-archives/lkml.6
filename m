Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C553CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8DD20020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8DD20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030442AbeFSSrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:47:52 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39576 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030350AbeFSSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:51 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfJ-0003WN-Br; Tue, 19 Jun 2018 20:47:41 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/9] x86/microcode/AMD: Add a reminder about PATCH_MAX_SIZE macro
Date:   Tue, 19 Jun 2018 20:47:37 +0200
Message-Id: <81353c66cf069935f275b1265c47c9b5516b2f8e.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PATCH_MAX_SIZE macro should contain the maximum of all family patch
sizes.
Since these sizes are defined in an other place than this macro, let's add
a reminder to them so people will remember to verify PATCH_MAX_SIZE
correctness when modifying a family patch size or adding a new family.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/include/asm/microcode_amd.h | 1 +
 arch/x86/kernel/cpu/microcode/amd.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 209492849566..8ea477fbc65f 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,6 +41,7 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
+/* Maximum patch size of all supported families */
 #define PATCH_MAX_SIZE PAGE_SIZE
 
 #ifdef CONFIG_MICROCODE_AMD
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 2dbdd7951475..9807e27f8fde 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -215,6 +215,9 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
 	/*
 	 * Check whether patch_size isn't something nonsensically huge so
 	 * we don't skip over good patches by mistake.
+	 *
+	 * If you modify these values or add a new one also check whether
+	 * PATCH_MAX_SIZE in include/asm/microcode_amd.h needs updating, too.
 	 */
 #define F1XH_MPB_MAX_SIZE 2048
 #define F14H_MPB_MAX_SIZE 1824
