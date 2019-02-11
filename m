Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D5EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139FD2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P33ZEVn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbfBKTau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:30:50 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42865 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbfBKTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:30:49 -0500
Received: by mail-qk1-f201.google.com with SMTP id 207so5175451qkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fgo15CY3NgYRpF97TzDUfVV2bSFDYAqgksNtaJxXuEA=;
        b=P33ZEVn9lWw4ExXF0pVb2kRhsMzsHIZnSCIoTjgHA67m1TBvJkvTccmmchHplJnzYi
         tK2h0WoALbgU2nZkZBJ2SxgLYpjlLfwsyM0qPDqW+WBGaVbVrCsDmIH6NfN+z6JfOa8G
         T+CWOFyTf+3H6TpEGTUvVR3EWZKAFrVXa/1HeoxRLcFre021WqnSEaB0okT2cdrUH/Zp
         j6/LfS6vWUOX8eAWpEshZ9EdhfKAPlTBxfbG9fyzxahFURQCfQqWoyJvynTy4bLNZmAd
         Fru81lvlu6FIits75GNMSWZETZYzfa/xtYGwkz6eLWKT5EO6vuFx7ZpACi8+YI0l12y3
         10LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fgo15CY3NgYRpF97TzDUfVV2bSFDYAqgksNtaJxXuEA=;
        b=U2F65+YXMKudz+1Yr7Ch+CT4ZLPc0aERcASVopTdV12tIoJAtmTuJ9UTqUQgizm5nt
         GALwQcM1HsR+mh864NlNVshll8rbExrWVxwi21/ijrPeqqz2/sPPp9wgYuS3Hflc2xKo
         vOd+zcFvdztsxNTr1RKy6YA4GzjsRAyv3K6l3jxD5G8/J97Z+F2hYEtdiML2a+tpKfE3
         yg6tX5Udpotb2Rxy8vkXlry2agsPafqhuQibWEiyyOZTQSuqHfR28r9nx1Bqn1kswR7s
         BGvlIxSzvHeNfiYSY1iGJx0THWIsvzJN3oQhjFXcpKfjUCDhD0bxaw/1dIa5SW2auIaY
         h2ow==
X-Gm-Message-State: AHQUAuYjSKd+59Vyq7/SGE3xdHFZZwGgbrcH0jn1SX85U7sDwOmxdTGy
        Q4qEE+lnz4AleW+09jQWXFIiMJNtinGiHrLPO2E=
X-Google-Smtp-Source: AHgI3IY6emNTamoLiOwa6pdZ0u5LLMBlSN9RZx8mrz70CAMQpxHxS0uzBm81DdK35Kw3x7EGXJpyDAJvrnUO/HSEvdc=
X-Received: by 2002:a0c:add8:: with SMTP id x24mr21936434qvc.16.1549913448304;
 Mon, 11 Feb 2019 11:30:48 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:30:06 -0800
In-Reply-To: <20190211193008.24101-1-ndesaulniers@google.com>
Message-Id: <20190211193008.24101-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v2 4/4] Makefile: lld: set -O2 linker flag when linking with LLD
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     natechancellor@gmail.com, sedat.dilek@gmail.com,
        keescook@chromium.org, samitolvanen@google.com,
        michal.lkml@markovi.net, akpm@linux-foundation.org,
        hannes@cmpxchg.org, peterz@infradead.org,
        linux@dominikbrodowski.net, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, gor@linux.ibm.com, adrian@lisas.de,
        rgb@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rui Ueyama <ruiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm64:
0.34% size improvement with lld -O2 over lld for vmlinux.
3.3% size improvement with lld -O2 over lld for Image.lz4-dtb.

Link: https://github.com/ClangBuiltLinux/linux/issues/343
Suggested-by: Rui Ueyama <ruiu@google.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1->V2:
* add tested and reviewed by tags.

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 00e8e01d23fc..8011555745aa 100644
--- a/Makefile
+++ b/Makefile
@@ -718,6 +718,10 @@ else
 KBUILD_CFLAGS += -Wno-unused-but-set-variable
 endif
 
+ifdef CONFIG_LD_IS_LLD
+KBUILD_LDFLAGS += -O2
+endif
+
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
-- 
2.20.1.791.gb4d0f1c61a-goog

