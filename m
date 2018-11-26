Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26332C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4A420862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3anh+9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4A420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK0EWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:22:04 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:32870 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeK0EWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:22:04 -0500
Received: by mail-qk1-f201.google.com with SMTP id 80so20096686qkd.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2uvYqwo8b0d15h+35lgIxvtd3vHLDG6JsoJ+bhXgr5M=;
        b=R3anh+9CYkNOdHKx/t0Js6QRHN0H3wJhaUFe39j7ELxRdo3kQLWljIhaXciPQkbp36
         qtE9nmJmVCSfNaOBjyVx8qOy+M8Tx22ds74m1E6aHiu18x3q9oN6bGXpC1iAuv+8Pzjv
         U3v9E+c/1GwT/+dIDL+P6XQkPeirUpFOONDOn0zy+oU9H52e0Ry/WREvGDqoqzXs3NYy
         xeko7wlvYtG/hDLz7GRIZ4XFGjUSx/Y9k81qZ1gRXQ7Eyl2Ofb+y3YX74QEGyQkszEUD
         EXDlez6Aq1+rvv+JyXaeXHnkU5tuVDnq+N20kHfwhSlHJiRjQ9LKo5srhDUMat8omQDb
         mtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2uvYqwo8b0d15h+35lgIxvtd3vHLDG6JsoJ+bhXgr5M=;
        b=FBw+Vn4yPms3rWeoFjkDt8AVjapBoKFnHRcLPj8lvpxCA72t48LWCL+OOPmx0ZvjHc
         OO7NU1Ea9VA1uxbxc4AcIHcW+feF/SGyBVcXgdKRRZCrrFKVa9tVdtgj7khRATMhcRA4
         AjQxYh7ku/UrO98cmlf8QJrTTJsZiEH36E4pXtbjIhfqw3tRCZ1uRmbawtc4bprattKv
         E6S2Q+k56acP18oNfvmiYWNa2KoDqoRd1awfQd2bA9hWt3pyk/KJfI+X9AMJ/+gARcnq
         JJ62fY0wsHh7DswArjaz7QQbCVzlwIPvaoL+7B3Qk29I4u0hoNPYawTQ4HzOJV1RwJfq
         dqwQ==
X-Gm-Message-State: AGRZ1gLL9zX0KPfCgb5Po7SDY0Mr/hdQqFitPCJkCWPdteiQbiuyWZ1A
        /0/O9b9Rvz8Ng1GcX/BUsQ5E3Fa5xQ==
X-Google-Smtp-Source: AJdET5e7LX3HaAy/Rrg06eUAN//jyR1uYYLyA4NcwQVXpJR+VoRkY8ps3mubK4/cT7nNxxqh+05cBxPfLg==
X-Received: by 2002:aed:23fd:: with SMTP id k58mr17514268qtc.39.1543253237335;
 Mon, 26 Nov 2018 09:27:17 -0800 (PST)
Date:   Mon, 26 Nov 2018 18:27:06 +0100
Message-Id: <20181126172706.184008-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [PATCH] x86/fpu: XRSTOR is expected to raise #GP
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        jannh@google.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess
fixups") incorrectly replaced the fixup entry for XSTATE_OP with a
user-#PF-only fixup. However, XRSTOR can also raise #GP when the supplied
address points to userspace memory. Change it back.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess fixups")
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5f7290e6e954..69dcdf195b61 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -226,7 +226,7 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		     "3: movl $-2,%[err]\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     _ASM_EXTABLE(1b, 3b)				\
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

