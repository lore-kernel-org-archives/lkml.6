Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62EBC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB5020840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFP/t++V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB5020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJYWn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbeJYWn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:29 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDB52054F;
        Thu, 25 Oct 2018 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476634;
        bh=XfljaKByoWDObBdXbx3ZYB2bEonZh0L1Z2kr2OkmbHc=;
        h=From:To:Cc:Subject:Date:From;
        b=jFP/t++VlMDsRoqeEkp8B2DcYc6cQh1pRz+7PbqGrKw/CmmbGRJLvRdSsi+lw8nzy
         jgfxu89MJfZwb6ck39/iyYDI1xzRGOoNjwSvp3fPtl2q38jgVZ3w3HPzVJWvDIJc7U
         yE5U/PpEaCMHM03EAaJ303UyudNYlUtNk4Hn3yZI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Alok Kataria <akataria@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        kernel-janitors@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 1/8] x86/paravirt: Fix some warning messages
Date:   Thu, 25 Oct 2018 10:10:22 -0400
Message-Id: <20181025141029.213274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 571d0563c8881595f4ab027aef9ed1c55e3e7b7c ]

The first argument to WARN_ONCE() is a condition.

Fixes: 5800dc5c19f3 ("x86/paravirt: Fix spectre-v2 mitigations for paravirt guests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20180919103553.GD9238@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/paravirt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 930c88341e4e..1fbf38dde84c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -90,7 +90,7 @@ unsigned paravirt_patch_call(void *insnbuf,
 
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect CALL in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect CALL in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
@@ -110,7 +110,7 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect JMP in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect JMP in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
-- 
2.17.1

