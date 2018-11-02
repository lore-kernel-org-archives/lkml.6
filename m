Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ECEC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337842084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUzdUiTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337842084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeKCEBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:02 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41C12082D;
        Fri,  2 Nov 2018 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184767;
        bh=DOAICTkvSqZo7DmZSi0Wly8DlSTOORUGPrsHHRAWi0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUzdUiTKgzuwt1E76h05hp1kAuwnCW1/Rjyu5tJMYE4ee75XmTwNQKn0+4UsZh1ta
         n44hVg/iu1OVa3P9nqgH9PmzrbP14xNyTdK2dxcZxZhKWksxbsyX25Csb755BAIfz2
         oF2SNyrkGKNzcrIvdtaddcbI/aOtDkxNRD69p2b4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alok Kataria <akataria@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        kernel-janitors@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 091/143] x86/paravirt: Fix some warning messages
Date:   Fri,  2 Nov 2018 19:34:36 +0100
Message-Id: <20181102182905.146726078@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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
index f3559b84cd75..04da826381c9 100644
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



