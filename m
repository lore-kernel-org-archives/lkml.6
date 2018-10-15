Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF18C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571A1208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EotbEoNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571A1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeJPBIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:08:34 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:48699 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeJPBIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:08:34 -0400
Received: by mail-io1-f74.google.com with SMTP id v12-v6so19117686iob.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XMcqh5XRoQ1PvlCwntYAcDsP0fw8oVCaOJbZpBP8xLk=;
        b=EotbEoNssUEaz7P7Ekbr7i/9IOmadX2W/Q2SdUowGSBDF5VMEg1tUE/iXqxySE4iKR
         IxzsKrYEDv6WCmUOphiF+wRmRN9sj5t/i8do5eH1ta8VSBV/zk0ZCiiGRaz9mrx1cAsh
         CM6dhLJrWb7IbcytOagh6Chu61r4FnseaXD9emjkyKs+WnV1sMShYrnOJOMEJHapMGGQ
         9H3ZUN9s/mv2BOrb0eQ6epjxpJDUc7ihD9mU6aTIqivWIptCaK6Gu9K1b4FThz9+hra6
         Wh6HL0s3S6CNNDwr95e49Lxbluv9ScqpC5XBzMAx+oKRo3VVVox3CSefh52rZUa9/y7D
         2oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XMcqh5XRoQ1PvlCwntYAcDsP0fw8oVCaOJbZpBP8xLk=;
        b=KNNEJGsApVBIj3/ZJZXa7SvzZNaIc9aUg8bzNRq+2cse+j9/r4T8zLwiu6IPse9hZ6
         WWGjHCjPIc823AbyOik6cSjLVhPLBP8ch2Ek2pOM44Opei5q0QHde85IaT7Nfk4kXAtQ
         SYymQ9VHPzsRiSd9D6HTLERavq3lZUhI4GJBr19BGy7XhwZbpUx5Wcf8B1qkhnexKSHm
         GffJi2fwb0PEi0rQ/VbsKCeh8rOmQxHSnmKQFz8L8DC8r/n1WUes95e4q2vmrnfoGkLJ
         W8qY3TiR78TT0ZxcnEI4Ib6AuUZwDVoRJ+uttR7qf/+BpuA4yngveBfZEJJ/wHRFAN3W
         xo6w==
X-Gm-Message-State: ABuFfoim3MRltsAmMuHUH5nOdWqojDUvd9sLgyo+OwYF08ZgvMIHBrXO
        5EGmFejrT1oUDkUGCZZeLFGWVws2glISGRAlg/k=
X-Google-Smtp-Source: ACcGV63Gkk658SnEs6ZnHLok8jbp90a/7A2jeP8tM27WFQDmSJWad/4kOrRPnEpGHTRewmPfjdpKmSZm/lujf+D286Y=
X-Received: by 2002:a24:2153:: with SMTP id e80-v6mr14602605ita.1.1539624145088;
 Mon, 15 Oct 2018 10:22:25 -0700 (PDT)
Date:   Mon, 15 Oct 2018 10:22:21 -0700
Message-Id: <20181015172221.35709-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] compiler.h: update definition of unreachable()
From:   ndesaulniers@google.com
To:     miguel.ojeda.sandonis@gmail.com
Cc:     luto@amacapital.net, jpoimboe@redhat.com, natechancellor@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the objtool warning seen with Clang:
arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
instruction

Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
mutually exclusive")

Josh noted that the fallback definition was meant to work around a
pre-gcc-4.6 bug. GCC still needs to work around
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365, so compiler-gcc.h
defines its own version of unreachable().  Clang and ICC can use this
shared definition.

Link: https://github.com/ClangBuiltLinux/linux/issues/204
Suggested-by: Andy Lutomirski <luto@amacapital.net>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Miguel, would you mind taking this up in your new compiler attributes
tree?

 include/linux/compiler.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..8875fd3243fd 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -124,7 +124,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define ASM_UNREACHABLE
 #endif
 #ifndef unreachable
-# define unreachable() do { annotate_reachable(); do { } while (1); } while (0)
+# define unreachable() do {		\
+	annotate_unreachable();		\
+	__builtin_unreachable();	\
+} while (0)
 #endif
 
 /*
-- 
2.19.0.605.g01d371f741-goog

