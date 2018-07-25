Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E3BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863820843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTaEIpA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D863820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeGYR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:58:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41409 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbeGYR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:58:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so5673168pgu.8;
        Wed, 25 Jul 2018 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=UCweW1InLU2Q85AunX5HAU4/+xnLCNr/K66HbXtDuGI=;
        b=lTaEIpA29luhxnZNhJ1EnWj9yNkv/Zyy134/IbnTdPWUn4ierjXniv7SIiaY6nWigC
         SeLYILe1w1BTccmVgTIySonkOvMYUPSbgmBH+HBF8gGuqTkQWJW9arZisinc9DGeJoM/
         WpSQada+aVPLg7kpxJc/m87kTpg94htI4d9xNHQvFgB0cAQboBcrj2/1Ax36vYJsRcQ8
         M5bgDgId3xWKFChY3cG2x5taew4sbyZn0sgodmNeY5EnnLiYs8TdtDK//ou/v6f09htR
         KYqr1YPomaCdAmzVwzQvrZpb/pZjESKBa+3tq1FIasBYq0Qt0adYlBpEEy8mG2UodcgB
         cNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=UCweW1InLU2Q85AunX5HAU4/+xnLCNr/K66HbXtDuGI=;
        b=bl6R/wGwo7IoHk2z041/Ua+QWd1eIlDf2q7kavnNWCmidjDbNTnwXvvPymDSvuW/wv
         8A49+lOdc5K3hPQB9OM6FK/E4aSayPD0p2Xvj4gZ6QbJpA2km4ARGFRIeqEEU4kVHJED
         SO9GMjJ1vfd2YddR+njdU14+tSVB+Y+1qTqnSUAn+DiQJOWjt5WNzLd5h2M1kic2O8FE
         P/nNGLO3ygY34gKD1lAMIkvCOk55dZscpZKww7LE6uT8nUVx9xJJZVO4ex+d1OSdtgjK
         L544DNi0OiDc0WpbiE0MsIAI3mwymlQECed2dBJPfIoVof0I5BqagwUR6Y5qlCzx7tyW
         zEHw==
X-Gm-Message-State: AOUpUlGlNJbCf0LPzS/0NPBPOvkVc5eOuzUpFeSLPBvESjb9NYSdGprC
        b/HSYCMtQO8tzHF2UJuGYvA=
X-Google-Smtp-Source: AAOMgpfQMs6qV00+QtdyEy99BeAosCCj+KPKP8ZVEouInv5YwHSc/8dvD+xjzoy2kMmVQC9/b2/Mfw==
X-Received: by 2002:a63:4b1f:: with SMTP id y31-v6mr21680430pga.14.1532537130556;
        Wed, 25 Jul 2018 09:45:30 -0700 (PDT)
Received: from udknight.localhost ([183.90.36.235])
        by smtp.gmail.com with ESMTPSA id r11-v6sm21668021pgn.62.2018.07.25.09.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 09:45:30 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.9) with ESMTP id w6PGkHDB027373;
        Thu, 26 Jul 2018 00:46:17 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id w6PGkBbk027369;
        Thu, 26 Jul 2018 00:46:11 +0800
Date:   Thu, 26 Jul 2018 00:46:11 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, davem@davemloft.net, illusionist.neo@gmail.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, mroos@linux.ee
Subject: [PATCH] bpf, x32: Fix regression caused by commit 24dea04767e6
Message-ID: <20180725164611.GA12441@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org, davem@davemloft.net, illusionist.neo@gmail.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        mroos@linux.ee
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 24dea04767e6 ("bpf, x32: remove ld_abs/ld_ind")
removed the 4 /* Extra space for skb_copy_bits buffer */
from _STACK_SIZE, but it didn't fix the concerned code
in emit_prologue and emit_epilogue, and this error will
bring very strange kernel runtime errors.

This patch fix it.

Fixes: 24dea04767e6 ("bpf, x32: remove ld_abs/ld_ind")
Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 5579987..8f6cc71 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1441,8 +1441,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth)
 
 	/* sub esp,STACK_SIZE */
 	EMIT2_off32(0x81, 0xEC, STACK_SIZE);
-	/* sub ebp,SCRATCH_SIZE+4+12*/
-	EMIT3(0x83, add_1reg(0xE8, IA32_EBP), SCRATCH_SIZE + 16);
+	/* sub ebp,SCRATCH_SIZE+12*/
+	EMIT3(0x83, add_1reg(0xE8, IA32_EBP), SCRATCH_SIZE + 12);
 	/* xor ebx,ebx */
 	EMIT2(0x31, add_2reg(0xC0, IA32_EBX, IA32_EBX));
 
@@ -1475,8 +1475,8 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
 	/* mov edx,dword ptr [ebp+off]*/
 	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EDX), STACK_VAR(r0[1]));
 
-	/* add ebp,SCRATCH_SIZE+4+12*/
-	EMIT3(0x83, add_1reg(0xC0, IA32_EBP), SCRATCH_SIZE + 16);
+	/* add ebp,SCRATCH_SIZE+12*/
+	EMIT3(0x83, add_1reg(0xC0, IA32_EBP), SCRATCH_SIZE + 12);
 
 	/* mov ebx,dword ptr [ebp-12]*/
 	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EBX), -12);
-- 
1.8.5.6.2.g3d8a54e.dirty
