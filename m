Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-545174-1526291237-2-4685937566151268298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526291237; b=MQefU7EH58jBlxFjWDly2NpeqfPVROp6tqbCrc1jcd1TG0o6c4
    xNsj8YCtIcDJsgdObUGKfJduKrKmW/uO2WUb7ooLxX9FzgUcyqdZI9UbMxtm95Nf
    e/wTqvi4JSs9jyD+S9G3LEpE8wfkrk7OPY5G5fALZREvNDmrVVuKOjogJB1dQtOJ
    xj4xHOqhv7+jeyxIzPgG5fa3w2ENtB8d1X5WLnjVcupLkAWHnOvMz5Y7H0L7Gt8J
    CrSJARMYAdUbP04a6j3Z1LbAy71zXkCCOCW18dcEn71uORclK6lcBbWz/4uTrdOt
    VO1STiHiEQl2LB3aUimJSQYRDxjZigOTxutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526291237; bh=
    S/BtI+vFnbNkUeV2dn+BUNh+xhM1JE/AKSCA9TJ8X+o=; b=CYVVYyCaoAlfUbW2
    kbpJnHdSMadnjvrChk8ToBWU89DMJIMgG2U/a3Qj6YDdf5Qgo/0fAfHoQT2zo4fL
    CoV4qV6xauUsSQ9uUra048d5sXYI02glB8ckVSpKDFrNp20ohHz40Buq0j55m55f
    xdn5wAjbY5xXLLLr8h07S9EqEp7l1/HKpw3oJSDQKf6RvvJbdXPN8r7Qe5sKBkZx
    3hc0FNQ9zd4J0HCWQrjI60cNclDmir5x0zREDNQH8WPV7cw7/mTwu2xo2fLbHoyS
    iEK46431ow6xZuMuUiUx3F0924F30xzm6dS60msvzCgyl8RQCOn615cELeolDXCt
    zB8A3Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMWCm6XpQhz3RWtGmu7/cxNwakqxx68d/TyX0XM0qr1PlSGr8s6eVwOa9GMjpcSS+GWk8gxC0LT07zheS0M+Y6UMvhIR+a56IDD0RezkOpuwp0EMRWv3
    NYMF2tr0tyLYmDVLtSa79PWHRevqer1R89CfBBlej7cYBlDEjmXAUWad1j7xJENjibFL4jOuB9ZeN1qgj6sCH8lxH0g8fS6hf7GKY6XL+AByotTzW0XHa5vH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=Ls1vWjZSrxAP00rdME4A:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeENJrP (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 05:47:15 -0400
Received: from foss.arm.com ([217.140.101.70]:38192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeENJrO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 05:47:14 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 02/18] arm64: move SCTLR_EL{1,2} assertions to <asm/sysreg.h>
Date: Mon, 14 May 2018 10:46:24 +0100
Message-Id: <20180514094640.27569-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently we assert that the SCTLR_EL{1,2}_{SET,CLEAR} bits are
self-consistent with an assertion in config_sctlr_el1(). This is a bit
unusual, since config_sctlr_el1() doesn't make use of these definitions,
and is far away from the definitions themselves.

We can use the CPP #error directive to have equivalent assertions in
<asm/sysreg.h>, next to the definitions of the set/clear bits, which is
a bit clearer and simpler.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6171178075dc..bd1d1194a5e7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -452,9 +452,9 @@
 			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
 			 ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
 
-/* Check all the bits are accounted for */
-#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
-
+#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
+#error "Inconsistent SCTLR_EL2 set/clear bits"
+#endif
 
 /* SCTLR_EL1 specific flags. */
 #define SCTLR_EL1_UCI		(1 << 26)
@@ -492,8 +492,9 @@
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
 			 SCTLR_EL1_RES0)
 
-/* Check all the bits are accounted for */
-#define SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != ~0)
+#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffff
+#error "Inconsistent SCTLR_EL1 set/clear bits"
+#endif
 
 /* id_aa64isar0 */
 #define ID_AA64ISAR0_TS_SHIFT		52
@@ -732,9 +733,6 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 {
 	u32 val;
 
-	SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS;
-	SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS;
-
 	val = read_sysreg(sctlr_el1);
 	val &= ~clear;
 	val |= set;
-- 
2.11.0
