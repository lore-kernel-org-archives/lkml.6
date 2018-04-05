Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709085-1522960127-2-11750384301324411973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522960126; b=EIMNYzbCeC8eNxCXCUQebma0liwoqVl6Nqfsu/hkQsXlmNnsTE
    mdDvI0a1/ayJccyAA3Fnaabl9szmKrvZPs1wIzoM214kIj+MzIAIahSpfY9P3Dv+
    ZbGoGSD9ETB7VJm1/EIqejyeQp5COP6n/5eq09JLrcsndmkPwxeUzQee0E73Pjnl
    /g/AKxChQiFiYPj88dJYlEokZTHelw9iVsGbYSKGmmrqXyzOYY9yJCjnDu2CM1W6
    7fva51c9/dYSlho60HE1+YN9Y9v5XrI7i9fdeJ5h/3LhnXTGjZpCvJPDvbkaqnPF
    lH5x10ZDdQqGyvl8VYsHJvyyJpc3ShsAzQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522960126; bh=gTuJ8r5NWwBR/5EKxtmhfJrB6wRp8N
    8A/0G1vu8IaoY=; b=t0E+fhEoi4FCkOibNcJsTKJXm7e/YsrzHnxSX7GZg5l0b8
    y6jzbpkFRlhrtRSI2FTLTjU0FIbLGwqJofawMGJvmDh9Nm9Kn9HtBae+ghLytlIP
    gxi1hJjk67rHhlYzwdIGjL1B3ejYjC2iBRq2EowlGisZKMxwDSLT/XetZnorRS+j
    hNK40dP3k6NKWgcA9EUhVX0pwo/MDJyX+fy+pAjkZ9JqZyEY17aaZh0oLLx5BUEB
    3Mga0je4tP8WdJgSvGnSM2R0szBNSkCh287BMrVuCYgSfV3tkTre2MKYT5hcT0Rt
    4DKcxNHZUpiiA1Cclf6+uDlof5sr8xVJokJQ758Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=awxrd.com header.i=@awxrd.com header.b=WC61Rsfz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lazb3Kbt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=awxrd.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=awxrd.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=awxrd.com header.i=@awxrd.com header.b=WC61Rsfz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lazb3Kbt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=awxrd.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=awxrd.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM9crwx/ZvEs0iRPVuadWAYN6eC059K+0wMYqhdNapf+gIsoVLTBL7nPGBlM0riHWctH/WnEDY9Gc0cb9NvaxkI3uBQsZztKZ+3+J1c3z+xbiav/4EfC
    vbGAYBL8sW74+QXtszI7S4mY4cE3Llg3EIO8Sx4aMBuoR2q5oamVuCcnGsgXD/rfD/rsyVmM/wjV9ujphIgH5lXm/b5waWLq6IThcvic09Sb5/pPNN3ASTpA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=vDLGeLTdAAAA:8
    a=VwQbUJbxAAAA:8 a=i0eTMvnbfTUS0iVQZV4A:9 a=odJAAQQ5ToBQNitR:21
    a=cNGU9jdt2scwjVbt:21 a=1GWREyU_VPGQROUScI6K:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeDEU2p (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 16:28:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36689 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750726AbeDEU2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 16:28:44 -0400
X-ME-Sender: <xms:_IbGWhnxUVDUG7_iRlXpDvRibQWmB74ZcDR77TStgUqIXHjmFp1GrA>
From: David Rivshin <drivshin@awxrd.com>
To: linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rabin Vincent <rabin@rab.in>
Subject: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct size
Date: Thu,  5 Apr 2018 16:09:16 -0400
Message-Id: <20180405200916.27964-1-drivshin@awxrd.com>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Rivshin <DRivshin@allworx.com>

NUMREGBYTES (which is used as the size for gdb_regs[]) is incorrectly based
on DBG_MAX_REG_NUM instead of GDB_MAX_REGS. DBG_MAX_REG_NUM is the number
of total registers, while GDB_MAX_REGS is the number of 'unsigned longs'
it takes to serialize those registers. Since FP registers require 3
'unsigned longs' each, DBG_MAX_REG_NUM is smaller than GDB_MAX_REGS.

This causes GDB 8.0 give the following error on connect:
"Truncated register 19 in remote 'g' packet"

This also causes the register serialization/deserialization logic to
overflow gdb_regs[], overwriting whatever follows.

Fixes: 834b2964b7ab ("kgdb,arm: fix register dump")
Cc: <stable@vger.kernel.org> # 2.6.37+
Signed-off-by: David Rivshin <drivshin@allworx.com>
---
 arch/arm/include/asm/kgdb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
index 3b73fdcf3627a..8de1100d10674 100644
--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -77,7 +77,7 @@ extern int kgdb_fault_expected;
 
 #define KGDB_MAX_NO_CPUS	1
 #define BUFMAX			400
-#define NUMREGBYTES		(DBG_MAX_REG_NUM << 2)
+#define NUMREGBYTES		(GDB_MAX_REGS << 2)
 #define NUMCRITREGBYTES		(32 << 2)
 
 #define _R0			0

base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
-- 
2.14.3
