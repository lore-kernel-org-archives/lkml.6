Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C6C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7F020833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozgKaxvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7F020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeIIUhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:37:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38695 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeIIUhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:37:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so19359491wrc.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AeMTx8qk3FDW9w7DTC4mll/cK3b+woQ7VNKwZGErtIQ=;
        b=ozgKaxvdOaMLMb9iu0KILKaQE8oQXOUlFHCkRu4nxy2AQIh+ivZoiIcETbWipaWdSI
         XkA03z3XMOjNBtt3kJ+GUpDQpflAlBGrRq6/fZgUuvB0xg1mhmQxXfW4Jpi0CJ1OCskw
         4xl1YlGRwSEfroZHZly0Vab5TgXGntNk/vwRt9RPN73xAm9P8IBRXrYWg4H1XhZL9ZC/
         8ZTfm0sM06nFv+c/OXn4Hr5EHSIjSAWYTT1vlfCBcQX1abJ5aaxCDjLd+dOSrce9Qf+y
         UTjCOoYhh1iueqbeDlnuaZmZjRvJdW5jmT6OvOIQ8DA8qHGsciVAzrKR5wvOSYgtdwVp
         Bqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AeMTx8qk3FDW9w7DTC4mll/cK3b+woQ7VNKwZGErtIQ=;
        b=ToZ974Z6NBG/Zwb1A55CPa8egCak2PXPq8OgxF3IoOnGo2NTD2PhIZV94zqJbXFggl
         lzwp9EsBZ8XnT3pcW6C3OBzNMFoDg4vtkgyZMjJcFkSRHGnBm8EL5GLzalgJmm4QNW53
         Nf5vCVBod2MQ4WfYLAGfbA3n+p74jSx/hd8vyLX8lOdTcZkRxYxILsa9TeMQH65srcPZ
         kYsfn18xBYywmyncZRYVbyYb5z4MU6CyGLMpmCmd6mphZvYKP0a66hicKPFuqI6DX255
         /ZygUZYYj1suv0g//Pzi6U575oU/1XGAl05waFqozpruZxgvQo8XtmsgHij6sZF5o9Wc
         MLdQ==
X-Gm-Message-State: APzg51AOxoQljOqVUoiEEpg9cqrUV6LnupCyMQ+K8RHrX7iQFEwCykjl
        0VzkTAzUpF+f988hBpojrz4=
X-Google-Smtp-Source: ANB0VdZCYnJXmwkQCis27/OjiY0+r2Q0Ct98BNx8eazji2EuCOFe7h+YYG+W0BBd2fzG+ZFB15rjig==
X-Received: by 2002:a5d:488c:: with SMTP id g12-v6mr12458811wrq.0.1536508059789;
        Sun, 09 Sep 2018 08:47:39 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u4-v6sm8961460wro.47.2018.09.09.08.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 08:47:38 -0700 (PDT)
Date:   Sun, 9 Sep 2018 17:47:31 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/arm64/include/asm/jump_label.h: use asm_volatile_goto
Message-ID: <20180909154731.GA20381@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other uses of "asm goto" go through asm_volatile_goto
(including the arm version of the same file). For consistency,
use it here as well.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 arch/arm64/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 1b5e0e843c3a..7e2b3e360086 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -28,7 +28,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm goto("1: nop\n\t"
+	asm_volatile_goto("1: nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
@@ -42,7 +42,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm goto("1: b %l[l_yes]\n\t"
+	asm_volatile_goto("1: b %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
-- 
2.17.1

