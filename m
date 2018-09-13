Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE65F8183F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE149214FF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVxCnaX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE149214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIMVGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:06:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40464 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeIMVGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:06:33 -0400
Received: by mail-qt0-f194.google.com with SMTP id h4-v6so5823593qtj.7;
        Thu, 13 Sep 2018 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QuhX72KSLnnFbp7PzLVsBNUbgyirPG0A1pJuO3fFPNk=;
        b=VVxCnaX2ugasMM1vfkezJYDK78mdxxvcfGx0nGod62oKkXS6/Uc5QxrKf3IxPMlOej
         hd2/OFyLUNtROftBgWdxvtPXsQoT53RAhCQrsl2OjZ8d+nFz3YNNLdLvSiv54qHhIysM
         GRR3oRoEdq3VSgX8qsdQh0n6JROcRTyeGWSMf6yS/6xiueTDRZzDQk0YtAVD0tsTJohH
         gF0V/ModdI3WwYWKmje5B9Phe38KpFvxzZXrFKQKJ5aBJwpdMxv3hBEollxArL+yCJVz
         ozjTGLZOskBxW0/T0M4ipUbnG8/wcjnAxKdnG9CsKd9nhGg3pJAgZ03FjYqUKR9QDF/Q
         Ufww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QuhX72KSLnnFbp7PzLVsBNUbgyirPG0A1pJuO3fFPNk=;
        b=clyc3yzSNKL/6QvNOnUwoFEx3ZKSL3dJMMugv0w/hqbBZ88sW/JGFL/Lnp25k9aO1Y
         AX4awnI0HjsemJ7oobfGLneM+ef02dYYTjCRc3moHeyvWVHY+ns6orgGpFYoc39+ikvj
         IOgKV6ayg3P5mMCJ63Hu5mJexKEOwJtPOkGT1UhgAGr5rzxZYCekaW2Zohd7zEL+/XYp
         /hmGyQkvMoIzFQpMek7p5MqB1LEiWs2/CKjsdMCRaaAYCrwMPwRBSsjaZwy4t/5Vv8W4
         cqhBINhB/AzzU+RpUFSdeDRvGqkB14OvRDJhJSw4fW0RFBsWUX1egXNg+CcxQQ11jdsn
         /uqw==
X-Gm-Message-State: APzg51C00frFyNEl4FLdXuBLwLdo5gtl5Vh2TNFWW+k6TGQtkQ+DpHdI
        ONDGcp6FHNkL9DBnGPUkAo605yNz
X-Google-Smtp-Source: ANB0VdaG0/tQ4RK4sVx8RxtHsa1Wfob0F6nmzuPlwgIVVQ6sYHGbX61xKOPytysrMX2QzfQeb8D9nQ==
X-Received: by 2002:ac8:184b:: with SMTP id n11-v6mr5793635qtk.10.1536854185346;
        Thu, 13 Sep 2018 08:56:25 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ad84:d559:aec9:bdfe])
        by smtp.gmail.com with ESMTPSA id 56-v6sm3255293qtw.31.2018.09.13.08.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 08:56:24 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jbeulich@suse.com,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH 4.14] x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
Date:   Thu, 13 Sep 2018 11:56:11 -0400
Message-Id: <20180913155611.10854-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKf6xpvseyNJtbr3fp=qH4kMeJReBd=fm5Kn-DpqoZL25moVqg@mail.gmail.com>
References: <CAKf6xpvseyNJtbr3fp=qH4kMeJReBd=fm5Kn-DpqoZL25moVqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit b2d7a075a1ccef2fb321d595802190c8e9b39004 upstream

Using only 32-bit writes for the pte will result in an intermediate
L1TF vulnerable PTE. When running as a Xen PV guest this will at once
switch the guest to shadow mode resulting in a loss of performance.

Use arch_atomic64_xchg() instead which will perform the requested
operation atomically with all 64 bits.

Some performance considerations according to:

https://software.intel.com/sites/default/files/managed/ad/dc/Intel-Xeon-Scalable-Processor-throughput-latency.pdf

The main number should be the latency, as there is no tight loop around
native_ptep_get_and_clear().

"lock cmpxchg8b" has a latency of 20 cycles, while "lock xchg" (with a
memory operand) isn't mentioned in that document. "lock xadd" (with xadd
having 3 cycles less latency than xchg) has a latency of 11, so we can
assume a latency of 14 for "lock xchg".

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Tested-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Atomic operations gained an arch_ prefix in commit
8bf705d130396e69c04cd8e6e010244ad2ce71f4
s/arch_atomic64_xchg/atomic64_xchg/ for backport.
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 arch/x86/include/asm/pgtable-3level.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 9dc19b4a2a87..c5d4931d1ef9 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_H
 #define _ASM_X86_PGTABLE_3LEVEL_H
 
+#include <asm/atomic64_32.h>
+
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
  * tables on PPro+ CPUs.
@@ -147,10 +149,7 @@ static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 {
 	pte_t res;
 
-	/* xchg acts as a barrier before the setting of the high bits */
-	res.pte_low = xchg(&ptep->pte_low, 0);
-	res.pte_high = ptep->pte_high;
-	ptep->pte_high = 0;
+	res.pte = (pteval_t)atomic64_xchg((atomic64_t *)ptep, 0);
 
 	return res;
 }
-- 
2.17.1

