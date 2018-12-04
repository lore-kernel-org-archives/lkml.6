Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F12C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49DA214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxEiGhjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49DA214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbeLDLEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbeLDLEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82D12146D;
        Tue,  4 Dec 2018 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921439;
        bh=nCKWaKSUIyC2UnHZJWL3ULonfPZK8KWT0gPgj/b9vHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxEiGhjJG5zZSi+OMvVEwbrjukPdqxfT52M2q42pD3QZDA3PDblDoGltqd1w9tpky
         mrhCD4ZS7HUt2enBhaXa13OVeBT+C6dtqkU+jNUF6qy50KTwjJAJHJMJTIcQkCfY3U
         tci9bZtqtPoW+KY/joBNxDN6qN6Y+avN55irfiRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bpetkov@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 072/146] x86/bugs: Update when to check for the LS_CFG SSBD mitigation
Date:   Tue,  4 Dec 2018 11:49:18 +0100
Message-Id: <20181204103729.734248410@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky thomas.lendacky@amd.com

commit 845d382bb15c6e7dc5026c0ff919c5b13fc7e11b upstream

If either the X86_FEATURE_AMD_SSBD or X86_FEATURE_VIRT_SSBD features are
present, then there is no need to perform the check for the LS_CFG SSBD
mitigation support.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180702213553.29202.21089.stgit@tlendack-t1.amdoffice.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -554,7 +554,9 @@ static void bsp_init_amd(struct cpuinfo_
 		nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
-	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
+	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
+	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
+	    c->x86 >= 0x15 && c->x86 <= 0x17) {
 		unsigned int bit;
 
 		switch (c->x86) {


