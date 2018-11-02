Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E28C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9380020870
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKsCC6US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9380020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeKBJuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:50:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39803 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeKBJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:50:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id n11-v6so165670pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 17:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIonunmopofPGzSNm75ie2dBu2DrhPo42aMJpvxj16s=;
        b=WKsCC6USfGKBWf7sdRhHN+Ns+u3Qi32TVhckF5ZO7P/46ZbZOBigxEMdQQKLJPL+If
         RLmfgP2oPrqyib7TPKpSWDcTGx0c2xjbYUQC9p599wXUdy+GhNG67bKZv2bOp+/w6Pyl
         hNHmJluj5nx0is7boind93FL8tpe7hkyfaoqP2By9AVVoJtA9sUAtsI0VusJVckORxZe
         KR/VocN/LnSRTni4VQq30Ki6Lavr230lNBIVivTgksMdYullPVBZHEiiWSyeR/1lqJeK
         yNnCG2SzaTXAQ2vx38V1cTnMUj3DtTsaRrDQ02i5vd6RjlhTa5FSHhbUAT0Rkjvd1Y8J
         +oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HIonunmopofPGzSNm75ie2dBu2DrhPo42aMJpvxj16s=;
        b=OTl3NdXSQ70pRcuoT5sjW3H6pqHJ8p7+NaMxiKPkDYWfMI7PfP8ethmeHvTd+rYHlA
         RdZVZUOG1mLqk/ngYZsvirbkvLyb4UWsaMyWzzKdt+pmWTCsJkY2YQYCZWQk6lLA/1+j
         hC/oqrjCmFW0+waW9D6ZEGMYM8njbE5scN03YOe8S6z5tnKk6TkarMhc3GBVRYVVPFnu
         CB8g5ESGpafZzeTj+VD3f4Ft3n9yWMpAC3fw9u3tRtGt0ez1nTe0rK9P+0BYMNuIOALe
         UHXnBgW3Xw8d5ZzfjIvLoADyW3oj4PbIHxey5okgWw12Cdt9EKQKfMQ7SBNCV/6zs+FI
         U9Ew==
X-Gm-Message-State: AGRZ1gJTFkubd4ZrLtCaopEE08jVI4R+hIDXdOp60Dm9mGpA79x+ByvR
        +N7R/fV1QP/8cF3BgTeiWxE=
X-Google-Smtp-Source: AJdET5cmBd3bR6iAqNr57q7YSwG+um3oWBF7hrdjWIvB8uSJMQ1tF2ARax6rnTkjlWiSdx27TnvnEw==
X-Received: by 2002:a62:e707:: with SMTP id s7-v6mr9865843pfh.124.1541119507975;
        Thu, 01 Nov 2018 17:45:07 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id q7-v6sm26252401pgv.78.2018.11.01.17.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 17:45:07 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Fri, 02 Nov 2018 11:15:00 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jinsong Ji <jji@us.ibm.com>
Subject: [PATCH v2] raid6/ppc: Fix build for clang
Date:   Fri,  2 Nov 2018 11:14:55 +1030
Message-Id: <20181102004455.10157-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot build these files with clang as it does not allow altivec
instructions in assembly when -msoft-float is passed.

Jinsong Ji <jji@us.ibm.com> wrote:
> We currently disable Altivec/VSX support when enabling soft-float.  So
> any usage of vector builtins will break.
>
> Enable Altivec/VSX with soft-float may need quite some clean up work, so
> I guess this is currently a limitation.
>
> Removing -msoft-float will make it work (and we are lucky that no
> floating point instructions will be generated as well).

This is a workaround until the issue is resolved in clang.

Link: https://bugs.llvm.org/show_bug.cgi?id=31177
Link: https://github.com/ClangBuiltLinux/linux/issues/239
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: fix typo in comment, thanks Jinsong

 lib/raid6/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 2f8b61dfd9b0..7ed43eaa02ef 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+
+ifdef CONFIG_CC_IS_CLANG
+# clang ppc port does not yet support -maltivec when -msoft-float is
+# enabled. A future release of clang will resolve this
+# https://bugs.llvm.org/show_bug.cgi?id=31177
+CFLAGS_REMOVE_altivec1.o  += -msoft-float
+CFLAGS_REMOVE_altivec2.o  += -msoft-float
+CFLAGS_REMOVE_altivec4.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_vpermxor1.o += -msoft-float
+CFLAGS_REMOVE_vpermxor2.o += -msoft-float
+CFLAGS_REMOVE_vpermxor4.o += -msoft-float
+CFLAGS_REMOVE_vpermxor8.o += -msoft-float
+endif
 endif
 
 # The GCC option -ffreestanding is required in order to compile code containing
-- 
2.19.1

