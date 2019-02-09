Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DFBC4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F415A2177B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnSxCEl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBIAJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:09:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37227 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIAJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:09:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so824565wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yxdwW1DyOtKem0WF782kU0A9egQwo4Qvb/PrColHLsc=;
        b=fnSxCEl/bREIP3RAd8NIp5N+R5sUUw7aoHfWroXeUgHAbdmejiO7oc5wXLAEpd6Cyp
         8XcURtp1dY/UuFEsajmGDsm1LkrPE4I1ktUNwpanSsFo2g1ULWf1wKXBOWLcQz96OHCO
         6oiWOvAOyiYggXqmUIY0QmCgVEPeHbqi2NhAxrfHPw5K2iIyg6eJdlLjheNZQe4cLR//
         H3LdjPgINUDp5Y9qXSw9RThVXi/2m4QX1NSRVkcYrMqmMrksKSnIEPmCVY2DZh+IgXpd
         74G4pIpPNLg0jSx3uYpwyCYpxjFmm6YtPJU4ZuGrEPQpoSyyUFzIWYBe5q/zMDPztB2k
         K8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yxdwW1DyOtKem0WF782kU0A9egQwo4Qvb/PrColHLsc=;
        b=qL21kr4jTNpUZHGZD8TyHhmvC5NRGgE9y5IPFZE3B5xdL0qXg0QO1v/EaOgcJOBKxl
         IBiKPeG3mVZyegERqZ97HKpql3G9ZO5wLcJTChAYGS8nR/XkJrXsK8ZXkGoG2aVcMxtO
         lFrflsQtbHrCZZbdhgoYJAYpT9oDRWzi1I8px5OugXDFY9Bbf8zl9ASW+FS2OYDNpcIp
         8SEnQoVP+ZZrhGbni/RJWmuXZjvahkEPE4hRG9AKgtH3GjUbMZNRFqmEa34kS0hyq2g8
         6W2AzI4TqAzXXpL+uMH7eBYsTO3l5/CGqq8LcnKY6yEfIgJV3ktPHv+p97VPwPTRCt/3
         ssIA==
X-Gm-Message-State: AHQUAub5NqVrELwrJIP8cP/Vg6X05+ZcDkdfa2wGjXecLMafbzXuXQ0T
        7htXMP3NJ7Ag3oZrUsS7nlE=
X-Google-Smtp-Source: AHgI3IaZloQG5Jl9/hr4QFOoadP0GpzDuRvYrquOnSQlqZ+xi9CGKN8cYjJa7a//JZ7KkKCUdA/4mw==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr742497wmk.149.1549670947426;
        Fri, 08 Feb 2019 16:09:07 -0800 (PST)
Received: from localhost.localdomain (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id 65sm10483171wrb.62.2019.02.08.16.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:09:06 -0800 (PST)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] include/linux/module.h: copy __init/__exit attrs to init/cleanup_module
Date:   Sat,  9 Feb 2019 01:08:40 +0100
Message-Id: <20190209000840.11018-4-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming GCC 9 release extends the -Wmissing-attributes warnings
(enabled by -Wall) to C and aliases: it warns when particular function
attributes are missing in the aliases but not in their target.

In particular, it triggers for all the init/cleanup_module
aliases in the kernel (defined by the module_init/exit macros),
ending up being very noisy.

These aliases point to the __init/__exit functions of a module,
which are defined as __cold (among other attributes). However,
the aliases themselves do not have the __cold attribute.

Since the compiler behaves differently when compiling a __cold
function as well as when compiling paths leading to calls
to __cold functions, the warning is trying to point out
the possibly-forgotten attribute in the alias.

In order to keep the warning enabled, we decided to silence
this case. Ideally, we would mark the aliases directly
as __init/__exit. However, there are currently around 132 modules
in the kernel which are missing __init/__exit in their init/cleanup
functions (either because they are missing, or for other reasons,
e.g. the functions being called from somewhere else); and
a section mismatch is a hard error.

A conservative alternative was to mark the aliases as __cold only.
However, since we would like to eventually enforce __init/__exit
to be always marked,  we chose to use the new __copy function
attribute (introduced by GCC 9 as well to deal with this).
With it, we copy the attributes used by the target functions
into the aliases. This way, functions that were not marked
as __init/__exit won't have their aliases marked either,
and therefore there won't be a section mismatch.

Note that the warning would go away marking either the extern
declaration, the definition, or both. However, we only mark
the definition of the alias, since we do not want callers
(which only see the declaration) to be compiled as if the function
was __cold (and therefore the paths leading to those calls
would be assumed to be unlikely).

Link: https://lore.kernel.org/lkml/20190123173707.GA16603@gmail.com/
Link: https://lore.kernel.org/lkml/20190206175627.GA20399@gmail.com/
Suggested-by: Martin Sebor <msebor@gcc.gnu.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8fa38d3e7538..f5bc4c046461 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -129,13 +129,13 @@ extern void cleanup_module(void);
 #define module_init(initfn)					\
 	static inline initcall_t __maybe_unused __inittest(void)		\
 	{ return initfn; }					\
-	int init_module(void) __attribute__((alias(#initfn)));
+	int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
 	static inline exitcall_t __maybe_unused __exittest(void)		\
 	{ return exitfn; }					\
-	void cleanup_module(void) __attribute__((alias(#exitfn)));
+	void cleanup_module(void) __copy(exitfn) __attribute__((alias(#exitfn)));
 
 #endif
 
-- 
2.17.1

