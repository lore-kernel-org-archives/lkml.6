Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CBEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3098220844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Lz/ImGwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfBHUa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:30:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47100 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBHUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:30:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so3856066edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 12:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+qeDFYVl09lrTX9icLA/Vm7j/aVqqA7erMQEarekHc=;
        b=Lz/ImGwgcKsE7W8U/f7y106bDD/k9tx9VUOb2wEL1KsY+ViRB6Iv/JxT7OaReAOxbA
         AHgNawxWsPFkjbmiAm3YgTfX6jy8Gte+tVrieUwY3kJnoKnDng1wlWeyfDAf1eXxB8K2
         WvZY0j9OaYlnxKP5WmmV7bKaVzvrGAS4sjpQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+qeDFYVl09lrTX9icLA/Vm7j/aVqqA7erMQEarekHc=;
        b=DhRZuhu9S+T5AttYK5GFoSMrgzTEqu24Q29S4umpskj7rAb0ghd8NaVsVD4vWapW3Y
         PYWDPAQ164mMZW/cjgnN5/W7BKJx3oYX0DCI3E/EBwX+dFwjKLBuc+6F11uLhVxeS9H/
         NLMS28/PLjdet/LxLgF+8pdcef2XYafqHtnoa9gFrcNrH9rSmy431iw/9sFS82Sq3tlt
         G5RQFwzT7IFNA6dMFWnfS3lcyP3y5+NKSGClRniZEakfi6aChIbcn3FiPVzLMtuYXMDm
         kOsth3WtJgecGOEiic31aYbnXjUoe2fuBvwDeHA4l45bXA0gbjKfRPxC2tFb5PZA3I9M
         mEBg==
X-Gm-Message-State: AHQUAuYCDKmbQLnTsu8Ed/59vZL0Kr9uCVj29HowwxKYqSo7l0zZK4zk
        lP8SWkLMt3x2rhApYlvqpm7uwg==
X-Google-Smtp-Source: AHgI3IZmDpwNSit7/RqdZvilFMjevFLPXIvd+U/8cFOGmj3+Ld6GRVqTcX5dqwZMI9u9h40VzuAxIQ==
X-Received: by 2002:a50:8ba9:: with SMTP id m38mr16003052edm.135.1549657821323;
        Fri, 08 Feb 2019 12:30:21 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id p7sm680095ejb.15.2019.02.08.12.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:30:20 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 1/3] build_bug.h: add wrapper for _Static_assert
Date:   Fri,  8 Feb 2019 21:30:13 +0100
Message-Id: <20190208203015.29702-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUILD_BUG_ON() is a little annoying, since it cannot be used outside
function scope. So one cannot put assertions about the sizeof() a
struct next to the struct definition, but has to hide that in some
more or less arbitrary function.

Since gcc 4.6 (which is now also the required minimum), there is
support for the C11 _Static_assert in all C modes, including gnu89. So
add a simple wrapper for that.

_Static_assert() requires a message argument, which is usually quite
redundant (and I believe that bug got fixed at least in newer C++
standards), but we can easily work around that with a little macro
magic, making it optional.

For example, adding

  static_assert(sizeof(struct printf_spec) == 8);

in vsprintf.c and modifying that struct to violate it, one gets

./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct printf_spec) == 8"
 #define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")

godbolt.org suggests that _Static_assert() has been support by clang
since at least 3.0.0.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v2: drop useless "" "" wrapping

 include/linux/build_bug.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index faeec7433aab..0fe5426f2bdc 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -58,4 +58,23 @@
  */
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
 
+/**
+ * static_assert - check integer constant expression at build time
+ *
+ * static_assert() is a wrapper for the C11 _Static_assert, with a
+ * little macro magic to make the message optional (defaulting to the
+ * stringification of the tested expression).
+ *
+ * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
+ * scope, but requires the expression to be an integer constant
+ * expression (i.e., it is not enough that __builtin_constant_p() is
+ * true for expr).
+ *
+ * Also note that BUILD_BUG_ON() fails the build if the condition is
+ * true, while static_assert() fails the build if the expression is
+ * false.
+ */
+#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
+#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
+
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.20.1

