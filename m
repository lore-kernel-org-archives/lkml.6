Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839559-2-10164865794121556388
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839558; b=RDl/zqdWVMxECIZs790XuDm6zu8aB+NC30VEQkl0gvMoB0E
    E1t3MCmiE+zyvlXGaCs0S2IB8Z9xz1gStuyVTj9WrL8iFUDBc3LwAmaRCtuQldtF
    IFGegEXr/BLpHAdvDqm0Kov7STdCUBOfRY9Cb/KPrBdPwA2fyUW31xgddK7DOGJh
    otNOGL7sqs3jmtzZw/kCnxZwwFRGIxUl1FlVkljzrgcvFiWCupAYJe5PBQb3AWMs
    3wPgZdmDgCzgwtoFt1vwPHqkHl66WU2Jfaa/HI6H4TKZaE29svW/UU2Yic0XC2wC
    cliOC/BjyL8QmRZ3K7RaZdxFxuWZqga7MNkV5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839558; bh=PS/7GNWxHrATpEKu6ZJ
    MBrvRo3Yf+7a50+q3YpaDg2k=; b=Eg1AJuUO+yP/KdSqgMsnuVsHaIElTJU9w97
    FgmvaQGdkt+bnOlcb/AYBfPOkzu23HU8RRQKj1RsDJi7yZEpDZDh1dOx0Sm9CzoG
    47lK38w40C1FIoVqPEXfF+xMDfxl2Rr5L12FhJLcWn+71WiDcO/kTt6c4Peu7/R8
    OC+twN0ChyOnts32aAB+QeunfcHH0ALWuhT982Vab6oI5DOG8qVOAVt5tcNOboNV
    U4Q6avdMzH7LWACjrgbNsnDoSfUQm/QaBI0flre1jp44JCGaJZVhRVhlmAhOqmUO
    KReQX4nK5TNsxSRaiF09lky1LZioCwQ4h5bZ0lxv1jqrYUxnxBg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeB1RjO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:39:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33177 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932533AbeB1PWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Hirokazu Takata" <takata@linux-m32r.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.552531679@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 120/140] m32r: fix 'fix breakage from "m32r: use
 generic ptrace_resume code"' fallout
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit a6b202979661eb32646048aeaad7be7b70c2cd22 upstream.

Commit acdc0d5ef9dd ('m32r: fix breakage from "m32r: use generic
ptrace_resume code"') tried to fix a problem in commit e34112e3966fc
("m32r: use generic ptrace_resume code") by returning values in a
function returning void, causing:

  arch/m32r/kernel/ptrace.c: In function 'user_enable_single_step':
  arch/m32r/kernel/ptrace.c:594:3: warning: 'return' with a value, in function returning void [enabled by default]
  arch/m32r/kernel/ptrace.c:598:3: warning: 'return' with a value, in function returning void [enabled by default]
  arch/m32r/kernel/ptrace.c:601:3: warning: 'return' with a value, in function returning void [enabled by default]
  arch/m32r/kernel/ptrace.c:604:2: warning: 'return' with a value, in function returning void [enabled by default]

Remove the unneeded return values.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m32r/kernel/ptrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/m32r/kernel/ptrace.c
+++ b/arch/m32r/kernel/ptrace.c
@@ -592,17 +592,16 @@ void user_enable_single_step(struct task
 
 	if (access_process_vm(child, pc&~3, &insn, sizeof(insn), 0)
 	    != sizeof(insn))
-		return -EIO;
+		return;
 
 	compute_next_pc(insn, pc, &next_pc, child);
 	if (next_pc & 0x80000000)
-		return -EIO;
+		return;
 
 	if (embed_debug_trap(child, next_pc))
-		return -EIO;
+		return;
 
 	invalidate_cache();
-	return 0;
 }
 
 void user_disable_single_step(struct task_struct *child)
