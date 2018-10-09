Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152ADC677F0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EBE214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="W/wttFUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EBE214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJIShO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44281 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeJIShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id z21-v6so1304963edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIJUhDioAr0S54rVlBBKaufO7xOSlwIZAdhjAisUPxk=;
        b=W/wttFUqVCQfhhqd9JWVbCMpRRNEiXz1tTH43JpJRx5yb0mitvWOKuuMKj+5hfoUhn
         D6lHbFNkq4xrdlYBbtDn7c6Fzj/i+2isms/kndFjCNVMwFD/lW5I6J6NEFrav5R4dBhc
         GucavX6VKe8kFeyhckdwkRJU+CdJCXfahZJV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIJUhDioAr0S54rVlBBKaufO7xOSlwIZAdhjAisUPxk=;
        b=CgkQH74qt+DvCB95V8o8S2SbsSRkq0boveKgMrqNLAcN8DpDE9gAjkafq3KxHSsaYU
         i21h2Cgw4QN+srnUzdHixX0kr9y59F/TpVZixCOTtqbgIs8FL3CSHLYhPqKKfzmEReO0
         /j6nhb06YsWHvDqhvL2M7ns2CazVefPRN/cib+tMO/NGdjYSv2nNDS7D/EISbsyTnIzv
         VynxJ3W7Z8BghuvETUs+gg+EvdKygJ/yFm5W2+cKA36CgAyHQ7ySZIvnJJTjB+jNoAL3
         0sQCsGPsKamIiKcY1oSn+kgJwgW0s0vWWszXf4IacI0AJEkxeIAOXL95WrOXQa4X0vxg
         /khQ==
X-Gm-Message-State: ABuFfogpzlyLss+B1J4c2xSMnvqkFK6Cr8R/XRwYfet/w+rpqO+pKYu6
        J+87M7AsCcuejZXjrHA6SFqTGw==
X-Google-Smtp-Source: ACcGV61FFRGAkoJKH1i58t3FXZP9j027yxgwlZmRYwA4wryGc6524nNTMR0QsTx+GG0ONHUhy0sdRw==
X-Received: by 2002:a50:8807:: with SMTP id b7-v6mr34131948edb.182.1539084043659;
        Tue, 09 Oct 2018 04:20:43 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 23/23] x86: dynamic_debug: protect against dynamic debug identifier reuse
Date:   Tue,  9 Oct 2018 13:20:13 +0200
Message-Id: <20181009112013.14238-24-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most invocations of DEFINE_DYNAMIC_DEBUG_METADATA happen through
"public" macros such as pr_debug or netdev_dbg, which have been updated
to ensure they pass a unique identifier to use as the name for the
struct _ddebug instance. But it is still possible that someone invokes
DEFINE_DYNAMIC_DEBUG_METADATA directly, or creates a new wrapper macro
that does not do the extra-level-of-macros-passing-on-a__UNIQUE_ID
dance. On x86-64, all subsequent uses of that same identifier would
silently reuse the first instance, which is bad.

But we can catch such cases by defining a guard symbol that is unique
per expansion of DEFINE_DYNAMIC_DEBUG_METADATA. This still allows gcc to
emit multiple copies of some static inline function that has a pr_debug
call (because all such copies would pass the same value of %5 to the
assembler), but prevents repeated naked
DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "bla") - even with a helpful
error message saying that '"descriptor" used as _ddebug identifer more
than once'.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/dynamic_debug.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/dynamic_debug.h b/arch/x86/include/asm/dynamic_debug.h
index 350ef6e2feff..69167f40482c 100644
--- a/arch/x86/include/asm/dynamic_debug.h
+++ b/arch/x86/include/asm/dynamic_debug.h
@@ -26,10 +26,15 @@
 		     "\t.long 0        \t# <padding>\n"			\
 		     _DPRINTK_ASM_KEY_INIT				\
 		     ".popsection\n"					\
+		     ".set "__stringify(name)".ddebug.once, %c5\n"	\
+		     ".elseif "__stringify(name)".ddebug.once - %c5\n"	\
+		     ".line "__stringify(__LINE__) " - 1\n"		\
+		     ".error \"'"__stringify(name)"' used as _ddebug identifier more than once\"\n" \
 		     ".endif\n"						\
 		     : : "i" (KBUILD_MODNAME), "i" (__func__),		\
 		       "i" (__FILE__), "i" (fmt),			\
-		       "i" (_DPRINTK_FLAGS_LINENO_INIT))
+		       "i" (_DPRINTK_FLAGS_LINENO_INIT),		\
+		       "i" (__COUNTER__))
 
 #endif /* _ASM_X86_DYNAMIC_DEBUG_H */
 
-- 
2.19.1.3.g1d92a00e68

