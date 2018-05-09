Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68406-1525852270-2-8808316739473455209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525852269; b=MsFShNwu2ZWp1kReTUVcqFsddpIDgkfcos4VftiPveM1RIQoRA
    V16cIZA8IaOmR2BEy12BC9NExe6/EEijDSiYStfEozF5WFifrv836rF1Q8me1zG2
    MLweN2BY8q5acYLZdG9rhY/K7dTCtrI4U9QXXTzLjTUQBnHhuN3j7FVXnklSse1L
    S8R0ZrarPGNAXpcDZgG9QKSo/vqr7Vvb9Y+gfgAy6ycAb1+I6Sl4kBc2LgVYugH0
    geia27/OYeC4XJuZV1rrOITZijobpJ56RxCFng2uSTw0iNl8P2Eg3WzYBqhqwN80
    6k+6YpIsdSdiRv611an1mPPNHOfgs71TOvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525852269; bh=5BsZx1jSffOrjmctAfU4IK8rsFlWwN
    K5AMe0WRPacXY=; b=FPbHS5zWeUxBoxR/bCnrP2GzRrn8AuBeqIgUSC5vF/l3J/
    0+MVfrOB6PnK9iFzEpk9Zpp+gxY1yf1R6zXzwCkjUBCCEiQarqS+kizeeaFnxvVa
    4LakF0i2jsI7QzFzTfncerFpwGRTlTwXmbB9XDTdR/yfd1orUMqRTao1rJm999um
    Rv8EZ1DqsvrniHoPfnT1cDvzsYnkMgAJaZUUFDITEPwTZvgJadBzv8YkSnSYgenX
    Jh4q90ac5CQTWqvBqkN6kAznYdEv2ONjtHnQa7/VBBDsIwT7PZHYbRdl6pZkZey2
    WdAvWw2SkBdvkiNaRqpIg4WKA5/CK/9jYDdTspxw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
    header.i=@nifty.com header.b=yK9UJ7cf x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
      header.i=@nifty.com header.b=yK9UJ7cf x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMAT2YkN0t3PagV7WjcXoCmTYBPh+zrdvhCkACg9LLtgLG/7USVlcLVOGRje7VkJgNW+N6oZrAPuTOdVyniM94pQ9sjz8lnSeoTvHvjG9yOd0uYs8oGM
    sEfaHPhWaEtnvjJIsAKtAB/zqlscAhV7d5jaYsDhz5+k+LENTAWRcBfKiswtQdhJLOMSDcHuE01+E2FexszrN8qmLQOTokM4N3n8DFOm7GF9x92fiNxi9mXD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=c-n4J4-pAAAA:8
    a=ChmWbc53oW39AlPumEIA:9 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933844AbeEIHvH (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 03:51:07 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:36038 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933773AbeEIHvG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 03:51:06 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w497nsEZ031539
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: x86@kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] x86: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:49:34 +0900
Message-Id: <1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for x86-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 795f3a8..5e1458f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -117,11 +117,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
+		__entry_trampoline_start = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
+		__entry_trampoline_end = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
-- 
2.7.4
