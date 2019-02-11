Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3402C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DC72186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUfDjdob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfBKTar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:30:47 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:39705 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbfBKTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:30:46 -0500
Received: by mail-it1-f201.google.com with SMTP id k133so16344ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A+p5CcPbc67CNJ+HtkbKBMLEqE5iK/BxBkcy0srR2f4=;
        b=EUfDjdobRLMV2Tk3lGBtNvj9QujsHoJi9ZqtEcH+YVtBCw0t/FCOOKOLjYPLz2olUE
         +TKRIo6Qkhd4/yl5EoeB93P6IDHZzfNjrzFK7iELdrQbe/FgB6/rqt0ScvP0xuzVt8hB
         z3fEBdPiKZndqh/aWqmvhVbI4J2B7eYEVxxuxU9Axu+akFPva/9Qj60M9PMrdYG72vSq
         Gubv63+gi2EzkY3wnIv2NYmvI/aEm0HnzTlhgrrxsVzTrjldQ24LgR14yr2G4DK4e8hr
         yPFkN2CogT0A25zsQf9ZCs9OjpRlwz3HR/KZ4hDpMclFW4EC5h+L1Va45mhPLcZKJY2J
         lLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A+p5CcPbc67CNJ+HtkbKBMLEqE5iK/BxBkcy0srR2f4=;
        b=TfYv2Iel5R29UNe5jfMHAEhuu3XDISufMYE3miPc22kAmC/MOX1rU6Cv/q4o6wPhQv
         gAh+aWF/9JapQxJSlUkUf3TObRculUmt0z+/zYupSwqtSVCnofdIVWjDVU3vKPWEymkt
         jfWoFd+H3BQ0i0RULfxmIpIW4v8NckFXU4JPc2kTx59os/HQMgklodZctuRLvRzrWg71
         zfi8lQjRKV+i5/F37rLh+jy/8reuTVPiwL+1O+0hMMpCSIvcBo64YrCDL1mgbSbGxWIv
         fjO6pwhIAg3EDTxmV0lv7anHJ8CwQboyL1NwIFagEVigjq9H2hIF7IvgUpi3UAO7g87E
         vXYg==
X-Gm-Message-State: AHQUAubHMbdwMGw4mdTcjvnsT0j+FacqmoWxTPCt8cUzJfVRau9/NYbO
        ciWiWHP4LKFUn6q2UBHKNPc+Sq3FovsqcZzjCZU=
X-Google-Smtp-Source: AHgI3IYF+PQlndRP+6W1b1+rJPutoAPanw6IRHwvLut+f1J4HrBcdzpQTR7g4ywG2Ll0njjvZe7wN/kSkeOVBeIn3MA=
X-Received: by 2002:a24:d82:: with SMTP id 124mr794567itx.10.1549913443054;
 Mon, 11 Feb 2019 11:30:43 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:30:05 -0800
In-Reply-To: <20190211193008.24101-1-ndesaulniers@google.com>
Message-Id: <20190211193008.24101-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v2 3/4] Makefile: lld: tell clang to use lld
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
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed because clang doesn't select which linker to use based on
$LD but rather -fuse-ld=lld. This is problematic especially for
cc-ldoption, which checks for linker flag support via invoking the
compiler, rather than the linker.

Link: https://github.com/ClangBuiltLinux/linux/issues/342
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1->V2:
* add reviewed and tested by tags.
* move this addition up 2 statments so that it's properly added to
  KBUILD_*FLAGS as per Nathan.

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index d3b65e96d183..00e8e01d23fc 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,9 @@ ifneq ($(GCC_TOOLCHAIN),)
 CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 CLANG_FLAGS	+= -no-integrated-as
+ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
+CLANG_FLAGS	+= -fuse-ld=lld
+endif
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
-- 
2.20.1.791.gb4d0f1c61a-goog

