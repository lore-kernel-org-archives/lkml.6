Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BED21756
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VhkOi+Cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BED21756
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeHUB6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:58:34 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:52913 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:58:34 -0400
Received: by mail-yb0-f201.google.com with SMTP id 79-v6so3100381ybl.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EoH5pauqWlTA0RTnufTs0PyEbborC6SNL6ee6ZkN5rM=;
        b=VhkOi+CbXyia7j+wc7X6rTCrw9XR+q9dCZK7qfrsShokxp4I8WAyhc3Pk8LVoVqwVg
         w6gTHsWJIY8dZX2ipWuMpQmIOsZt5llRTn4E4I4XEebYUMi1XjNETWPf7OJM0dWtapKm
         DDR8RGUIa+M8X6YlMdaVyML5taGs5iI+SirzF8mdZIjcW0lCbBuC03cuXIvJ+K7hfFmL
         f6OlD92dPzRBrm69wa1EIzfgWjS1Vp6MphvIBIDzxRbecFO9c0RLCafA/CixBJ8qDi60
         7WZboInv3vKD2VS7AzQiAATyzqT53ODqu5J6R0UB1mFhSUVGBDcxZQMzHy1uPAp1zHka
         ojJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EoH5pauqWlTA0RTnufTs0PyEbborC6SNL6ee6ZkN5rM=;
        b=GYKvj/xFgo1i+ED7Y9jF77yPfbEyzs4OpK22U3bdOM0eQC2KtrZJu+HLfpgWpNffcF
         dwkwNUqWbCa4m0O5WS/eEdvCDJZZef7IhDV57OH1jlKlgATzSnMDanelPkOz+wlYi0Vb
         RNRNMeW5ZpEhUGFuQf3e63DOMSVNKUGatNxztWM3SHNxu0Tw5hKLu3guwqwIyszPv7FJ
         /Eqc7tEFMxalDBMqhv3U2zM6K7Ka3ft4ep5l3HmFuU7OOPitQ9oF1B73YT+sjyVTkQVB
         qJTQiOfg3AcJPescF6hsbHF3m218rhpwYAvVVVHFByIvUrsRCLJIX2/XyEqjJ+F+m83M
         l1Zw==
X-Gm-Message-State: AOUpUlEY6X3vbujtm3Ur3/QZA+NdiD7Dq3FtMtSd55ZGScSL+qlJ2FOF
        y+DAmM/d3C5NDGDJpFLPqyIBOovO+USCPGq2Kgk=
X-Google-Smtp-Source: AA+uWPw7n4D3afJ4dsA2aTX+Y42hvf4SGYTi3IfVbE4yuIvCJujG1ua4iUX7pyKts31Pcgxb7r0+QsljwR0U9Pn9KfU=
X-Received: by 2002:a0d:fbc5:: with SMTP id l188-v6mr14440405ywf.133.1534804864260;
 Mon, 20 Aug 2018 15:41:04 -0700 (PDT)
Date:   Mon, 20 Aug 2018 15:40:32 -0700
Message-Id: <20180820224032.53194-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH] arm64/crypto: remove non-standard notation
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     ard.biesheuvel@linaro.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that:
ldr q8, =0x30000000200000001

is a GNU as convience notation for:
ldr q8, .Lconstant
.Lconstant
.word 0x00000001
.word 0x00000002
.word 0x00000003
.word 0x00000000

based on this comment in binutils' source [0]. I've asked for this
non-standard convience notation to be added to other assemblers [1], but
until then, we can remove it and get equivalent disassembly:

before:
00000000000009d4 <neon_aes_ctr_encrypt>:
...
     a48:       9c000ac8        ldr     q8, ba0 <neon_aes_ctr_encrypt+0x1cc>
...
     ba0:       00000001        .word   0x00000001
     ba4:       00000002        .word   0x00000002
     ba8:       00000003        .word   0x00000003
     bac:       00000000        .word   0x00000000

after:

00000000000009d4 <neon_aes_ctr_encrypt>:
...
     a48:       9c000aa8        ldr     q8, b9c <neon_aes_ctr_encrypt+0x1c8>
...
     b9c:       00000001        .word   0x00000001
     ba0:       00000002        .word   0x00000002
     ba4:       00000003        .word   0x00000003
     ba8:       00000000        .word   0x00000000

[0] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gas/testsuite/gas/aarch64/programmer-friendly.s;h=6254c6476efdc848648b05068be0574e7addc85d;hb=HEAD#l11
[1] https://bugs.llvm.org/show_bug.cgi?id=38642

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/crypto/aes-modes.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
index 483a7130cf0e..9288c5b0eca2 100644
--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -232,7 +232,7 @@ AES_ENTRY(aes_ctr_encrypt)
 	bmi		.Lctr1x
 	cmn		w6, #4			/* 32 bit overflow? */
 	bcs		.Lctr1x
-	ldr		q8, =0x30000000200000001	/* addends 1,2,3[,0] */
+	ldr		q8, .Laddends /* addends 1,2,3[,0] */
 	dup		v7.4s, w6
 	mov		v0.16b, v4.16b
 	add		v7.4s, v7.4s, v8.4s
@@ -295,6 +295,12 @@ AES_ENTRY(aes_ctr_encrypt)
 	rev		x7, x7
 	ins		v4.d[0], x7
 	b		.Lctrcarrydone
+
+.Laddends:
+	.word	0x00000001
+	.word	0x00000002
+	.word	0x00000003
+	.word	0x00000000
 AES_ENDPROC(aes_ctr_encrypt)
 	.ltorg
 
-- 
2.18.0.865.gffc8e1a3cd6-goog

