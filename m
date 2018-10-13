Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73114C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AF520868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcxFY+tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AF520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJMI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:28:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51219 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeJMI25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:28:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so13711377wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 17:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MxP964SJNuxvyrJcQLscB6E/aBSlXrtX10bhOcvWSY=;
        b=jcxFY+tcIrdpJ6VI/UbpsucxZmeqjdv+wReuryK35tl4olgSAdptJKHbpPx5cMvR9m
         TKWD1wlyAy6qis9WaPH0K9Q9/T8qxN837Ol3rib6IxRgpLDGRRGHlOCTI8ifhvfrZ92o
         VtJqULwxEuxscJ/NbWZ8/Pn12Ve7Yacs/HwDe4MDMyg5lzqLjkbwNjoIvvcPt83VNlV3
         0/ED27/VRjN7wQ1fwpNnCcCjZuo6KhvDGxWrY8tDg02ckHEpBnW6lwyOgXxY/r7MFBY/
         Cb1cVqrScFZV1yVfPs4FCTRlpdqyygaRLrYXE2sAh0Y8CigCeRlKCMmZj7VtCfOpcMJl
         DAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MxP964SJNuxvyrJcQLscB6E/aBSlXrtX10bhOcvWSY=;
        b=fB59lQ0F/HJ0GjXUh+4SOZ/Nu859CK1wiUB5ae892/B9go5oDTJm7PfMq+YU58itPh
         +97CnGePf6B1smJ6ylCXKFbkS66hPv2iBzODs4jBSvy0i210T5xUD3fM6/jRz91v7fLy
         j+/L21J/E6Vd+8phryLLlda5vTTdWgialG/Ifx+ec2/qKbW7EDYEH4SdziLvSOwWbwGa
         yPPhMb5IaqxxcTDieLuGlbrgVIFon+amcrXUX3vyJC+Ools2lCLZB6JdCvv6gnFK+6Dn
         HZdbmQM7XU5WPQSZ6OR72SDxDdyogy4tafWr54m7OwuBQmNyfxN+n9uNgW9gPXcmUfsw
         Z6xA==
X-Gm-Message-State: ABuFfojAolN+R0fZR3K7Ngso4xLYW/R+saHij0dYvejMtzaEMDIWMz1S
        x4QMGTLNa4KpT11UEUtj770=
X-Google-Smtp-Source: ACcGV61GWL85P5246CUibATbBFuSRESb9XMM/yw+2pb7QUtD6RULle+jgi63IdNrfIanLaK5Bkrznw==
X-Received: by 2002:a1c:41c5:: with SMTP id o188-v6mr7202861wma.34.1539392035212;
        Fri, 12 Oct 2018 17:53:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w192-v6sm1899226wmf.33.2018.10.12.17.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 17:53:54 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] x86/time: Correct the attribute on jiffies' definition
Date:   Fri, 12 Oct 2018 17:53:12 -0700
Message-Id: <20181013005311.28617-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the declaration of jiffies in include/linux/jiffies.h
doesn't match the definition in arch/x86/time/kernel.c:

arch/x86/kernel/time.c:29:42: warning: section does not match previous declaration [-Wsection]
__visible volatile unsigned long jiffies __cacheline_aligned = INITIAL_JIFFIES;
                                         ^
./include/linux/cache.h:49:4: note: expanded from macro '__cacheline_aligned'
                 __section__(".data..cacheline_aligned")))
                 ^
./include/linux/jiffies.h:81:31: note: previous attribute is here
extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data jiffies;
                              ^
./arch/x86/include/asm/cache.h:20:2: note: expanded from macro '__cacheline_aligned_in_smp'
        __page_aligned_data
        ^
./include/linux/linkage.h:39:29: note: expanded from macro '__page_aligned_data'
#define __page_aligned_data     __section(.data..page_aligned) __aligned(PAGE_SIZE)
                                ^
./include/linux/compiler_attributes.h:233:56: note: expanded from macro '__section'
#define __section(S)                    __attribute__((__section__(#S)))
                                                       ^
1 warning generated.

The declaration was changed in commit 7c30f352c852 ("jiffies.h: declare
jiffies and jiffies_64 with ____cacheline_aligned_in_smp") but wasn't
updated here. Make them match so Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/98
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/x86/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index b23f5420b26a..0e14f6c0d35e 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -26,7 +26,7 @@
 #include <asm/time.h>
 
 #ifdef CONFIG_X86_64
-__visible volatile unsigned long jiffies __cacheline_aligned = INITIAL_JIFFIES;
+__visible volatile unsigned long jiffies __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 #endif
 
 unsigned long profile_pc(struct pt_regs *regs)
-- 
2.19.1

