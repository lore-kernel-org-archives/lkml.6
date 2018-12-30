Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C94DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5552B20855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iqE9zpvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeL3MgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 07:36:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38214 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeL3MgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 07:36:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so24619915wrw.5;
        Sun, 30 Dec 2018 04:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i02gaLkDojUSUqCyfJ9g7Ameroxnp+aU5hKWOv8LesU=;
        b=iqE9zpvryHXMKRsa4UKqZi+kCEuOp+Zxuc+oDI/g4RfK6QHEiFUHTlPartEADQZeJ9
         Ukdo3HSldiZraOFYa58GorfZczo6jCryTx7Mg+CviszADBhPTMnsRp8/Wpq1hYJspmPd
         obc+n3LTTdK9PiiIA69R5LHMrkQCMuh3U3FyRYFwdc+8epLohJcGYlm5PJZ3Ubh9d605
         /0OVIvy/iugFVQmgLtTuGlZU143aeSc1uchnNHqBSJ7eZ9NYwcRWroiN8pZ48Mv1/7Yx
         NnOcah4WeJ1r5r2p4X6olxTk70nvy/3fy1PGKOCW8RhYf9Ngs8KQe9umNpAVgJ16Cmr9
         dVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i02gaLkDojUSUqCyfJ9g7Ameroxnp+aU5hKWOv8LesU=;
        b=K4EKWsgc2sHLqitH2B0AX/6Nr7+YZ35xi5h/S9LwBJAZQLGoXOY/dyhSskJRst6AM5
         SkXD8Uf1LZH3iys+bZ4HqBxG8Jj9i9reeULjNLDU2ZqyR4zoL1DGtJ9hW7w11YqHPz9y
         xRctenXSmKBFGrisUFEMOcVfwoECZFvvB+QFy/rXiEziKg4lu5brdCrBVqG0tiQVhAyG
         IxiDXvaecVy8aDpLp+7YOw7pzGDI/EJCGQdpXptIjhLbf7QuGL6Cp62Au+dIdRIx+izN
         aWY0Trn3S1oI5fwIlWZqUwBEH2pSlAX4qlqqeRt+DFAv1Ru45R1WPNb1QkT098SNifnb
         OAcw==
X-Gm-Message-State: AJcUukeZ8tDCrrbaAL0/o4jv5sMQtwI+YE5XfMJvquZKA3H0s//qtFDU
        7XKWN/lMqJZ96a2nMBrt1kMJjiE4
X-Google-Smtp-Source: ALg8bN6BYjID4rCHzAiWFgobfF6iA42hRF8lVEXvedr7xg8YoTiBOcZTvSshIEBNhrU/4lAR1/m8Aw==
X-Received: by 2002:adf:8484:: with SMTP id 4mr29951651wrg.249.1546173382090;
        Sun, 30 Dec 2018 04:36:22 -0800 (PST)
Received: from jig.fritz.box (p3EE0413B.dip0.t-ipconnect.de. [62.224.65.59])
        by smtp.gmail.com with ESMTPSA id e27sm39258165wra.67.2018.12.30.04.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 04:36:21 -0800 (PST)
From:   Mathias Krause <minipli@googlemail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@googlemail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] kallsyms: lower alignment on ARM
Date:   Sun, 30 Dec 2018 13:36:00 +0100
Message-Id: <1546173360-25573-1-git-send-email-minipli@googlemail.com>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in the info pages of gas, the '.align' pseudo op's
interpretation of the alignment value is architecture specific.
It might either be a byte value or taken to the power of two.

On ARM it's actually the latter which leads to unnecessary large
alignments of 16 bytes for 32 bit builds or 256 bytes for 64 bit
builds.

Fix this by switching to '.balign' instead which is consistent
across all architectures.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 scripts/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 109a1af7e444..77cebad0474e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -334,10 +334,10 @@ static void write_src(void)
 	printf("#include <asm/types.h>\n");
 	printf("#if BITS_PER_LONG == 64\n");
 	printf("#define PTR .quad\n");
-	printf("#define ALGN .align 8\n");
+	printf("#define ALGN .balign 8\n");
 	printf("#else\n");
 	printf("#define PTR .long\n");
-	printf("#define ALGN .align 4\n");
+	printf("#define ALGN .balign 4\n");
 	printf("#endif\n");
 
 	printf("\t.section .rodata, \"a\"\n");
-- 
2.19.2

