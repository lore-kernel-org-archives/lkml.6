Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECDE2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoEeQ0ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECDE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLHPqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:46:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33041 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:46:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so3361329wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7GQhOnYZ/9ITTatnN1cAFhc2f132GWO/j4E7PzXJkc=;
        b=MoEeQ0qlk8lK2HFY5wZuBTYmTkRj2V1GDxW8Qk7FWgacrci8nWtEJYzosetPdMMRWx
         /NjfFWyv+Ue/R7Z11KXN7RxXNZRUsk9ELrWUJRHx+bzh1pgjPDA72LXm9Zwvv/m3VrLi
         KO869Z7ZBi27Ezo71rrQ6df3++3ciUwHv9+jdFcv2xlrCyYqNodA1a3Yx9UfwGwfoGu2
         2VhayLS8pS7gLLvX1sA/Qdw+XcPDfkMeNVzbNlyGLzhk52MaowKEGZE+uBFwjLYx9wNq
         +K/DNpY4UTyNR6PrgVupIMk5kMa/ilY3zLx3fuXQNazKR51dzfuczTKmflOVy5s/T+hO
         0zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L7GQhOnYZ/9ITTatnN1cAFhc2f132GWO/j4E7PzXJkc=;
        b=prcWGCufW9+hOaBY/KJglmTCDgrdQtLZs8poiEbvQ2Xc8sg6zl5tF1qhyEL9o5GZKB
         fQrd+60KSJUNslMiZOfu460y7FMQ3HVr7B4y/oIqBsAUkw7ZEFbBUQnNZgMRNvqcu4x4
         Rzqh+dMAAh1Z+xT5pRbIsSAT13u0mA4bGvxR/NZChw/Jn0K9YLP70RniXHYN0DxMuDK4
         HSA4+bqxyyFPuzWkYM/FIdmfGtbXIKlaeQxgD3/zg4dzyWy0JFrfU/d3dkrodWLZhBNt
         FSoejtE34CR2SCofHC8Way1CRDGlxp+4u9blTkFGQrX7rvSNCJWqYot0LO8bpcBDAJSG
         t0lw==
X-Gm-Message-State: AA+aEWaUvf5vf/U+1n/yGDGgo3QDOp4zM7P/SSl+V9uyyu3xl892SzYF
        OJjh5nMCya99oxCF8ID6pak=
X-Google-Smtp-Source: AFSGD/Xyiblms4cYzEQCqEbXOREVh2DV4op56OzEiW80YkOLqrBCipD5tsMeepqmJ///o5qy1h76fA==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr5337638wmg.71.1544284004126;
        Sat, 08 Dec 2018 07:46:44 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id l37sm15771092wre.69.2018.12.08.07.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 07:46:43 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 19C4D11422CD; Sat,  8 Dec 2018 16:46:37 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
Date:   Sat,  8 Dec 2018 16:46:23 +0100
Message-Id: <20181208154624.6504-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`pt_regs_check` is a dummy function, its purpose is to break the build
if struct pt_regs and struct user_pt_regs don't match.

This function has no functionnal purpose, and will get eliminated at
link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION

This commit adds a prototype to fix warning at W=1:

  arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype for ‘pt_regs_check’ [-Werror=missing-prototypes]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/ptrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index a398999d0770..341c0060b4c8 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3338,6 +3338,10 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 	user_enter();
 }
 
+void __init pt_regs_check(void);
+/* dummy function, its purpose is to break the build if struct pt_regs and
+ * struct user_pt_regs don't match.
+ */
 void __init pt_regs_check(void)
 {
 	BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=
-- 
2.19.2

