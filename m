Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uuNhJZF5GVtLNQAAmS7hNA
	; Thu, 07 Jun 2018 18:32:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 252CF6089E; Thu,  7 Jun 2018 18:32:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEY9qXL0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E052606DD;
	Thu,  7 Jun 2018 18:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E052606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936332AbeFGScp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:32:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47025 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936302AbeFGScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:32:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id d2-v6so5145500pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGeT2z0TEJiRxrbez/GsuqB8RgVtytCBVtTQ7JK4sXk=;
        b=HEY9qXL0YcX2J/MicPECY+V3ZoGxJP/xLAozSfgprvI3D92IZpm8v4ObDuMESHGzaZ
         OjxTgmRCC9Zmem1Llyw95kbepoh7KsvzS6MNlWBfgPk1gcn0MQy3nnC1xqtu74v+l2qU
         IfOsjUYoY/RR7vT641Im4/kZtTR81HpVoaeEoVEV7zWiWDw7hTPmWFpWJnMZmxleJ4S6
         200zJnowE8s2fQ/pcvbjKK0LyIBGS3kXaDSMq7bgvSe7/FHc2AlkWds4Sc0+au6/FVz/
         CTee8j0BE4xELO9CeEUBqUnprYHSh+Vhr2+xG5OKV1IqAnydbk67U73nsuV+lod5xp26
         JbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yGeT2z0TEJiRxrbez/GsuqB8RgVtytCBVtTQ7JK4sXk=;
        b=sb+VoINXdXb68AmUpq1suNSSAyuje2PAI3cIrSxaZqzjoeSuwN1yc5DJEX+L+xDjrN
         J7Qz/3EfLIIJF6owa8VcLEa896pyiqVkkHeZHZecusx6ElTUeyoPFg+dmXkcR4vHNixN
         AnGl8lRQejvM8PAhZ2X5DwGjqwvdf+Eyi9ZB5YxmjsvZl3+/Okgb9Z0lK99heES1e3oB
         /n45TTtpr1P2PXKUobSGibS9WS9ghUHBSI38nLrGKa+tntV47KI1sIxUDI9qglD+x+mh
         n4DNhx+VbrC1NkCaupqnQIbYXztDudvMlylEvTJmpfvKuFxhPN103I0niAuhvtCAGR90
         qUZg==
X-Gm-Message-State: APt69E1pRKmIYqQsuQUGD2ZPzJ+PfE3Zk2D+zI/sCo4CzOSXKGQBYdLo
        gDJ7pwMXcjfZjTXxHh6K5ucFPQ==
X-Google-Smtp-Source: ADUXVKIGM8arhElcDh7dZYE268X/tBQJDJ/k5GqXsRFnnWciR39Ccu/nvu8o2N7d99EPc3yHTG8JLw==
X-Received: by 2002:a62:418b:: with SMTP id g11-v6mr2801235pfd.51.1528396360716;
        Thu, 07 Jun 2018 11:32:40 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id n76-v6sm6932739pfg.98.2018.06.07.11.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:32:39 -0700 (PDT)
From: Nick Desaulniers <ndesaulniers@google.com>
To: akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        ndesaulniers@google.com, thomas.lendacky@amd.com, tweek@google.com,
        mjg59@google.com, joe@perches.com,
        "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH v3 2/3] x86/asm: add _ASM_ARG* constants for argument registers to <asm/asm.h>
Date: Thu,  7 Jun 2018 11:32:18 -0700
Message-Id: <20180607183219.192973-3-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607183219.192973-1-ndesaulniers@google.com>
References: <20180607183219.192973-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

i386 and x86-64 uses different registers for arguments; make them
available so we don't have to #ifdef in the actual code.

Native size and specified size (q, l, w, b) versions are provided.

Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/asm.h | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faaec51df..990770f9e76b 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -46,6 +46,65 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+#ifndef __x86_64__
+/* 32 bit */
+
+#define _ASM_ARG1	_ASM_AX
+#define _ASM_ARG2	_ASM_DX
+#define _ASM_ARG3	_ASM_CX
+
+#define _ASM_ARG1L	eax
+#define _ASM_ARG2L	edx
+#define _ASM_ARG3L	ecx
+
+#define _ASM_ARG1W	ax
+#define _ASM_ARG2W	dx
+#define _ASM_ARG3W	cx
+
+#define _ASM_ARG1B	al
+#define _ASM_ARG2B	dl
+#define _ASM_ARG3B	cl
+
+#else
+/* 64 bit */
+
+#define _ASM_ARG1	_ASM_DI
+#define _ASM_ARG2	_ASM_SI
+#define _ASM_ARG3	_ASM_DX
+#define _ASM_ARG4	_ASM_CX
+#define _ASM_ARG5	r8
+#define _ASM_ARG6	r9
+
+#define _ASM_ARG1Q	rdi
+#define _ASM_ARG2Q	rsi
+#define _ASM_ARG3Q	rdx
+#define _ASM_ARG4Q	rcx
+#define _ASM_ARG5Q	r8
+#define _ASM_ARG6Q	r9
+
+#define _ASM_ARG1L	edi
+#define _ASM_ARG2L	esi
+#define _ASM_ARG3L	edx
+#define _ASM_ARG4L	ecx
+#define _ASM_ARG5L	r8d
+#define _ASM_ARG6L	r9d
+
+#define _ASM_ARG1W	di
+#define _ASM_ARG2W	si
+#define _ASM_ARG3W	dx
+#define _ASM_ARG4W	cx
+#define _ASM_ARG5W	r8w
+#define _ASM_ARG6W	r9w
+
+#define _ASM_ARG1B	dil
+#define _ASM_ARG2B	sil
+#define _ASM_ARG3B	dl
+#define _ASM_ARG4B	cl
+#define _ASM_ARG5B	r8b
+#define _ASM_ARG6B	r9b
+
+#endif
+
 /*
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
-- 
2.17.1.1185.g55be947832-goog
