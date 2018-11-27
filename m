Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A66C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CC7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzHoXGNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CC7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeK1AaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:30:04 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:38123 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeK1AaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:30:03 -0500
Received: by mail-io1-f74.google.com with SMTP id l12so21753749iop.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0x98bOJuAVkDdHDZ1/E8Wz7Dv4wK/V7vxU55zlPZenA=;
        b=EzHoXGNb+UErVyniVY/VeHHrvxS2TQcz/DGSRmykMUgu5pmE1qhFfLQrP0ak2SsE9F
         mxCm7Le/Ux36tctl0jsPFnhKkeU8r5EO1JqdAZ++P7AbcXBRx9Q57j9F7zWoe0B7+XWd
         LdGFm803ydegXgXH2tLzQCas+Tcs8ocQEakkf48PogmZBSlFwYjgz4e3vW23Ofm4UjjT
         m9mn5GcvEItfJrpcNLzmCHs0XYM6gJY4bmPR0QLLxNMmZexUapHtoSWwdICrqZaYimQu
         FwZJMm9ZPnME0nESQb06F2IMJbuwgGgCSP9r9jC8Gu+6h7nhMAzqNb76RDpwbfJKyCs6
         JxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0x98bOJuAVkDdHDZ1/E8Wz7Dv4wK/V7vxU55zlPZenA=;
        b=T8ltFRI5NrxWHYA56hk7oAh6yl8LS/IT27dUccnIFBhkeRmCA6W8WfGxQ6eyXA4gnk
         gJLkdgfeT3sfMqMZ88gnYHNaNZtJ2kueA6pEUr2r1AMXyT7re1EtrkK53XzFvcCDNUl9
         iBiu42eR0qFpGWxFz3ZJj07blKYBELz7dMnHMT6UYbc5FJSjvU/jDVCLlawUnHt0Vzql
         KB+mTAoqCPJ+l8YaUYLyMNnqX1kKo8xWGAYOb2dHl1WF5+51vNtO+H1i0eSIcK/jWx4D
         iz9dlGr74FJJZjhP3uiF+lEXZO/2/J1xnJ9WBm5EwfAO/nV8vIkCsGO6xh19YAiH1lME
         Hwtg==
X-Gm-Message-State: AA+aEWYH7dGdnWW6oqBWbopz9cOP21+kiKiIUOXDIX6xXvJk5ZZEhsdW
        oLRDt752jBbFz27Qn8E1sSQKHsU5qQ==
X-Google-Smtp-Source: AFSGD/VPf2hUp62itkSewGyOa71oswgLrY9qY4sutKYlRMghib84bGI2KyYeWmrXH/g45UtE0Dz/Js08Ug==
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr397233ita.8.1543325526820;
 Tue, 27 Nov 2018 05:32:06 -0800 (PST)
Date:   Tue, 27 Nov 2018 14:32:00 +0100
Message-Id: <20181127133200.38322-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [PATCH v2] x86/fpu: XRSTOR is expected to raise #GP
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess
fixups") incorrectly replaced the fixup entry for XSTATE_OP with a
user-#PF-only fixup. XRSTOR can also raise #GP if the xstate content is
invalid, and _ASM_EXTABLE_UA doesn't expect that.
Change this fixup back to _ASM_EXTABLE so that #GP gets fixed up.

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

