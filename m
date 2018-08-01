Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FDFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16FA208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTqSOAq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16FA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbeHAW4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:56:02 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:52495 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeHAW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:56:02 -0400
Received: by mail-io0-f202.google.com with SMTP id y26-v6so14832433iob.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JfQ/MsRcHfx2Y3EaJLe0gfU1g3PTz5+rH597G5zAFm4=;
        b=DTqSOAq9+SROUlYWnL43fAxh3dlvievQmscczPnV/2EGjowqcnds5WsDl6UZd1mM/A
         0E4YmwsoN62Kd8BeUd4+dPE1ZaEMuLl3JcN6J0cT0MZhOx8EXCo8wLGJVg8c4M/4nyjp
         7vvzjqXjiVQ05H36IWihW/krjX0JcTy4tkO/KsjHZh3/u3gvSSUcYD4SjSaQXjK9JaTF
         sxjhMaIKi3YsPcgZLpvy6CPtOk3e+tEE7BTFlCvb5mABn3ELXOfKBttac8i40aKEjDdV
         rA45kG1i9V/0DQufLdMMru9DrDI8ZxgZNIlJfp+uIiCxPT/0HqHUkWWP5yGREHLBGA9t
         Fkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JfQ/MsRcHfx2Y3EaJLe0gfU1g3PTz5+rH597G5zAFm4=;
        b=nQLCQn4+2MuPPG00hK+8Lwdu/Y2ZADsD2Su79dyHiBcCJC+SMtlLmJUo6KohaBvnaZ
         85OYBtKnjmy+OiTT4tw6kIdu/Iuk6qAVkf/QLhquOYvb4aGDLoT52bcuJ2y/tLRGNTdn
         0ZaWM2S1x7ClumGfGXDfOpQRHXTBvxCc5RBXgo94D0Fc2DNy2qQUjQGtxrdsJWEy7gu8
         yYbdunHwrlxTESjpJWeuEnKt0oUwfPSSCWXKuIdt0rePAmjHJO37P1ClO8pHaGI8jjqb
         NanRtuXAS3JZWYpA9G/mL3nEJInPtlkMmIJWjH7OTUeAQMXUZbeea7OVFkx4WiWkoI6t
         TCUg==
X-Gm-Message-State: AOUpUlGQwVuQlWNF+XkA8JWn5WyslNqN4ftU79SCDq/rdF2wtiw0C5QA
        qnorGA6X5YK8en2Aoiyh7+LanGj9Fuy+bCCTkTI=
X-Google-Smtp-Source: AA+uWPxHIjRbX+UqWtaS/tHTa6rpHj2A1fZb3OLPYd2HhRNqu30k/jRhyRoIH7V7+iu/FVVwtRrjLx54322CEkODjAA=
X-Received: by 2002:a6b:5d5:: with SMTP id 204-v6mr2671iof.98.1533157702141;
 Wed, 01 Aug 2018 14:08:22 -0700 (PDT)
Date:   Wed,  1 Aug 2018 14:08:03 -0700
Message-Id: <20180801210804.175176-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     natechancellor@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to reduce the code duplication between _THIS_IP_
and current_text_addr(), let's consolidate callers of
current_text_addr() to use _THIS_IP_.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/kexec.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index f327236f0fa7..86924d594ecd 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -21,6 +21,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
+#include <linux/kernel.h>
 
 #include <asm/page.h>
 #include <asm/ptrace.h>
@@ -132,7 +133,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
 		asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
 #endif
-		newregs->ip = (unsigned long)current_text_addr();
+		newregs->ip = _THIS_IP_;
 	}
 }
 
-- 
2.18.0.597.ga71716f1ad-goog

