Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D5C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D3D2172B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D3D2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeHHCQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:16:56 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.228]:42566 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbeHHCQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:16:56 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id EF6CC400D927A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 19:00:03 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBtPf9g06bXuJnBtSfYhH6; Tue, 07 Aug 2018 19:00:03 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48968 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBtO-002Coy-TR; Tue, 07 Aug 2018 18:59:58 -0500
Date:   Tue, 7 Aug 2018 18:59:57 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] arm64: alternative: Use true and false for boolean values
Message-ID: <20180807235726.GA6756@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.73.102
X-Source-L: No
X-Exim-ID: 1fnBtO-002Coy-TR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48968
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 210
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value. This code was detected with the help of
Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 36fb069..b5d6039 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -47,11 +47,11 @@ static bool branch_insn_requires_update(struct alt_instr *alt, unsigned long pc)
 	unsigned long replptr;
 
 	if (kernel_text_address(pc))
-		return 1;
+		return true;
 
 	replptr = (unsigned long)ALT_REPL_PTR(alt);
 	if (pc >= replptr && pc <= (replptr + alt->alt_len))
-		return 0;
+		return false;
 
 	/*
 	 * Branching into *another* alternate sequence is doomed, and
-- 
2.7.4

