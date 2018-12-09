Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF11C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 03:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050DA2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 03:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="danNkbBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050DA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLID1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 22:27:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38062 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLID1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 22:27:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so3417125pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 19:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aB9KQN2ZcaEJuOh7/Wd3qXF/Iq2zpm/WHz5YkFy4y84=;
        b=danNkbBTa0+vrhR2gc+rB7AmupFxMbj79/8CO5v6yihY2Y1M890FRTiEdMXgLlRYxe
         FzsPFLJ73q/ACrkCCUFAeao0ba6a/Z/kUM4UzmAziQJvMwfPwvQ+n7/SADT3AKAnwkQI
         CP0JYeCzhMvYhbIeB5BIxMduWJ5oIQ57uOKUE06HIHSdmPghYhIRWxQ7Yb4qbZmMIofG
         VX0Rvv6DuqeFP77r2r6x1MUU5dJAg305ctUvBoXpOyicd43rvGX+Bd02bmY947pzWcIO
         7cE+ct4oER6Hev9SoGjQmLNUQC7y2eJwEZinVI0QbVwo8cxTE3NTAPJsvbEREKuwJC5o
         8cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aB9KQN2ZcaEJuOh7/Wd3qXF/Iq2zpm/WHz5YkFy4y84=;
        b=ZWFnSpBXrHV99gbaIUjp1rzLrDqfCROfyY7As+nz/FC3B+0xUjaiUwu5/go19ybRkU
         yVS/b9QUI0w5k+LB+0AOJjrT3I/EkznzrVAHUbYWBBNVLsS6OOzJYVPAR4n5Znq9mK8H
         lg2e41Q+u8TqLzKefh2a/A269zZyDu+5G2jPdaHoR7zkCo8AjXu2ReO9dDWE9TxhLgr4
         ftej4Xpu/0wnhF+uvFOvr6Rn5LLQreOvZ4P5+vR0v1tVuZYof6n3cl0HGTUfLBeuIEiS
         430PYP2ExO64nMiAgHjkLIqySedequms7mXw2GNhVvQVzoEA8q9dpnLUovfOFVe90gpe
         d+VA==
X-Gm-Message-State: AA+aEWYk/LLlawr8LeCpKL2lDyiHMdn79WRheEM7dwr4pSGzSHMi0UcQ
        QLuNm9XOEeEGWVbmHtYUGJEGrS46VqU=
X-Google-Smtp-Source: AFSGD/XBtOzeXOVIsC/DwggsRewTaiK5hmsRticzD7D1lY5cyi4uh5Ljdik58cSL/197y5cfb016lA==
X-Received: by 2002:a63:6506:: with SMTP id z6mr6772528pgb.334.1544326060035;
        Sat, 08 Dec 2018 19:27:40 -0800 (PST)
Received: from n3-021-216.byted.org ([123.58.9.150])
        by smtp.gmail.com with ESMTPSA id v89sm11873185pfk.12.2018.12.08.19.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 19:27:39 -0800 (PST)
From:   Xiaozhou Liu <liuxiaozhou@bytedance.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Xiaozhou Liu <liuxiaozhou@bytedance.com>
Subject: [PATCH v2] Compiler Attributes: don't pollute userspace with macro definitions
Date:   Sun,  9 Dec 2018 11:27:15 +0800
Message-Id: <20181209032715.3466040-1-liuxiaozhou@bytedance.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros 'inline' and '__gnu_inline' used to be defined within __KERNEL__.
Commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
exclusive") had them exposed to userspace (unintentionally).

Then commit a3f8a30f3f00 ("Compiler Attributes: use feature checks instead
of version checks") moved __gnu_inline back into __KERNEL__ and inline
was left behind. Since inline depends on __gnu_inline, compiling error
showing "unknown type name ‘__gnu_inline’" will pop up, if userspace
somehow includes <linux/compiler.h>.

Other macros like __must_check, notrace, etc. used to be defined within
__KERNEL__ too. So just move these macros back into __KERNEL__.

v2: update commit message.

Signed-off-by: Xiaozhou Liu <liuxiaozhou@bytedance.com>
---
 include/linux/compiler_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4a3f9c09c92d..9e23ec015221 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -161,6 +161,8 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
+#ifdef __KERNEL__
+
 #ifdef CONFIG_ENABLE_MUST_CHECK
 #define __must_check		__attribute__((__warn_unused_result__))
 #else
@@ -215,4 +217,6 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
+#endif /* __KERNEL */
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.11.0

