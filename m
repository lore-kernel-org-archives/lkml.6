Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3DCC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEC12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjWSTInf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEC12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeJOIUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:20:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40193 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeJOIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:20:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so8304930pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b/Xhw2EK4mi+d59RNeXlr73INQgb0338IFEVhaRhBVU=;
        b=bjWSTInflpJ4vXSG1gpGc3EsEluf5+so9hwwcTwCMK/MJZeZjmCfYcnd0YfeExuyRG
         lCa2st5Zp1NKjHcBqOMrutc15brV5iq8VJ2PtxPjXAawxffRIThJWqsnJWP6vmrC0ait
         HS6nESbTlhrnp430Sx+qx6JzD8UxeDJ85hSPBtuO4JB8Vuc5dnFJF8nql/JX57ovDlDT
         tsL1XAECbl5AilWYka10aweSTWBlTijoHnUSmqrQdPzmIeIGdH+vj39WZ4hy3mxuOQFg
         cRGxnHE/J3kaWFuLIJNIpKuiqXrU4SEIZI04wFv3z4XLbrauveynBrgfu/tUXz8bdAKm
         n9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b/Xhw2EK4mi+d59RNeXlr73INQgb0338IFEVhaRhBVU=;
        b=jmwieVPuThnWMN2C6kVWffjHn8EWWj/JDve3P0EoFAjsesKWuaG5sRJKC5Qi8SnYmN
         VYAyJofo2fPMgzvEn3N3R98YCuYgCNddOlazX6dXDTc0/WtDbmkWGne4uJ5GYUtFV2A/
         qPkAKy2dpgIjw47M+VfAFO1q/bSWZosg5Sj9i8VEWsxKhHI8ynE0u5rJU/1zUFEtSCNo
         FywCnnlEBD5ho7Klz5JCofdMplZykvHKxTwf8o5ocsJlotPQ/kMCzJr1sgQLvKMccM6r
         8DZd5RCGa6Akv9XO69EngFVbRaZs/xnIdKdV/3JDLrGuNGklPce2zQcI/q2TSlui0MyU
         er1w==
X-Gm-Message-State: ABuFfoho1yx3jZPulSDiGuFwecb8T1nKA5Nrif5OzWAxV9EZ6l+XLZEy
        7fAkHaSxCTx2xkJ28ZLaXbI=
X-Google-Smtp-Source: ACcGV60pdp+BL3SB8DimSZAAUgoTMSsWgQOXimAzocDiP8drsr9gIpcdwlSNm2zd+t1acZVlod9FOQ==
X-Received: by 2002:a62:5b43:: with SMTP id p64-v6mr15673839pfb.122.1539563867666;
        Sun, 14 Oct 2018 17:37:47 -0700 (PDT)
Received: from localhost.localdomain (50-197-184-177-static.hfc.comcastbusiness.net. [50.197.184.177])
        by smtp.googlemail.com with ESMTPSA id x15-v6sm15489920pfd.27.2018.10.14.17.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 17:37:46 -0700 (PDT)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     natechancellor@gmail.com,
        Nick Desaulniers <nick.desaulniers@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
Date:   Sun, 14 Oct 2018 17:37:26 -0700
Message-Id: <20181015003726.29103-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the objtool warning:
arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
instruction

Link: https://github.com/ClangBuiltLinux/linux/issues/204
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 arch/x86/mm/fault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 47bebfe6efa7..057d2178fa19 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 * and then double-fault, though, because we're likely to
 		 * break the console driver and lose most of the stack dump.
 		 */
-		asm volatile ("movq %[stack], %%rsp\n\t"
+		asm volatile (UNWIND_HINT_SAVE
+			      "movq %[stack], %%rsp\n\t"
 			      "call handle_stack_overflow\n\t"
-			      "1: jmp 1b"
+			      "1: jmp 1b\n\t"
+			      UNWIND_HINT_RESTORE
 			      : ASM_CALL_CONSTRAINT
 			      : "D" ("kernel stack overflow (page fault)"),
 				"S" (regs), "d" (address),
-- 
2.17.1

