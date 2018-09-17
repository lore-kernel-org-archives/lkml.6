Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D080ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAF62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXe9HGd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAF62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeIQNEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:04:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43463 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIQNEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:04:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id 38-v6so1289230plc.10;
        Mon, 17 Sep 2018 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=RjDxg38tAu7dzJeG4KgwfOc/djiPGSpCCO0IHxqB0oQ=;
        b=bXe9HGd/2SUH3zcBXE2ZzJPFwhLjtCuJyEBiKTV+W+rB7YDjWq0TTmeIdV85iGs4Ns
         UpvOxJqx3cARtAWsWZ89n9LGOBJKMSUE+yCZ9SiZ2oCCqnJZGfSJMVzqvXm7qqzRPUfZ
         nXNFJ/LOpDx7Ic+UDgYjuWjrbTlLMnAQQpwOksPNiGp3m2tyOyZ85nGJOOYDJowX20uv
         aKmp2ohym8Yk/tO8TZ61gpP55I2galF02KJqedf5mO78e6VF33j+uqZ7aoTIKDZFhHNW
         2sPlGTYJhfVd7HYfCUbYRnkvq/9s1WhDX2v7W/0tZ+bMaHLPoFoUdemlKlxgv+if259f
         iBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=RjDxg38tAu7dzJeG4KgwfOc/djiPGSpCCO0IHxqB0oQ=;
        b=eDPh2yLtP366nD0wUvUNayo8L8819IfW97u0sI8rb1UrJhKL1lRfEXhflCPddEiyRV
         DY8eMCGOA08Unezxg0nAp8dZWvfrr3zQyZIOn1l8ofiaivZaWZlDCMb3JZV72tMeYFGU
         wkWv6DUbYLsrrBhCvFUKxb44L6BZOHGeOhHMZtGkUMbiqm2LhLk22943/PDROAxYKHQS
         a0D9lxjC3mekRttxJs+X2p85j3oLsfV2s9FkfpnRDaoznA6anRLiXkqDaYY97RIg/YoI
         a7REo4Xn05BOwNXmsMnbiZBQWMxuKaNG4pxQWNjgpk60oysAxG7TMPoMqwfHyQ8ueLkh
         PUeg==
X-Gm-Message-State: APzg51CQX5D3EBOZTM8mQ+5NJQDH1Thah9oUMUjFApab2l0vDOf4I5BH
        WtsInKXrqJIAhbrb9fPWT60=
X-Google-Smtp-Source: ANB0Vdae0AZiCg9yK6pwJol/J5v6zM/krQDpzwLWDyWf+1GkaIWWIHHt0zFHy6NmdOR97AEZdaWTfw==
X-Received: by 2002:a17:902:be08:: with SMTP id r8-v6mr23738423pls.265.1537169886296;
        Mon, 17 Sep 2018 00:38:06 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id d10-v6sm15774327pgo.2.2018.09.17.00.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 00:38:05 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 17 Sep 2018 17:07:56 +0930
From:   Joel Stanley <joel@jms.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] ftrace: Build with CPPFLAGS to get -Qunused-arguments
Date:   Mon, 17 Sep 2018 17:07:54 +0930
Message-Id: <20180917073754.24048-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building to record the mcount locations the kernel uses
KBUILD_CFLAGS but not KBUILD_CPPFLAGS. This means it lacks
-Qunused-arguments when building with clang, resulting in a lot of
noisy warnings.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Not sure why -Qunused-arguments is in CPP instead of KBUILD_CFLAGS. We
could instead put it in KBUILD_CFLAGS, and not need this patch.

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5a2d1c9578a0..54da4b070db3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -219,7 +219,7 @@ else
 sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
-	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
+	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
-- 
2.17.1

