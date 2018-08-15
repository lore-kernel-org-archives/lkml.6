Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61FBC46470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A60C215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bPpmvb/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A60C215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeHORU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:20:27 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:42882 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbeHORU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:20:26 -0400
Received: by mail-lj1-f181.google.com with SMTP id f1-v6so1093120ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkFeSBVO3ndcBJySjbdB4jBjDn31pcPBVo8d0rQR4Gw=;
        b=bPpmvb/HZ/WLqWJI+/UNL49F065PaI8FHPuO7zbuWas/eUmHQusXBPQtlNXMsvVyqL
         YSo4P7NWFNy2Lx6pek8knvYz42+/pWbJlGMKPrfgrKojh50Zw72JEPK9ko5qWXTYqahl
         LE7MTBbXFXV747Hvp53LpW402ZehNae9RYrQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkFeSBVO3ndcBJySjbdB4jBjDn31pcPBVo8d0rQR4Gw=;
        b=aeLCm4vTVyOFXDO2CFTuCW8f2U1a48etG/RM1871HVfqZ2uBA0GZu5PVtIB0UN3Uvt
         o9iZF+X9Ew4mGBRtPXjrIkhzl62pWAGp/LlwTiY/Z7fYUAeKTloM7pmVcMO4ipbRjODD
         aDhKwdOZQ2DVQamBFtpXCm1q09rz43KYZJ3cd5HARjjl2Z6FK9scqnOjhduqbivrhJE1
         NC+rFKNswmdrdcleUYH7by47uN7Vh0nZisjcb4qK1siYdtC6uekHRv9R6r63f8aWxXa7
         ++XRlWa3RdVBoqd7UcZentcQCD3qcFMT0zuO1YpSkmqbYM7Vn7rRaFrB71s0eBULhGGG
         Dfpw==
X-Gm-Message-State: AOUpUlGnlO8f83MjK7+0r4RPGNRbpQMP4EoZDJso56RKXhn34FvL+sbI
        lp3PiFbzHFqc0MTC2P20OEuR3w==
X-Google-Smtp-Source: AA+uWPxBllHj7TP4r5les7Nlfo81SDfXjTNZYetuXv6oI97Wn06rSbbkSSTFiATM6N0y/o5pRBLJXQ==
X-Received: by 2002:a2e:590e:: with SMTP id n14-v6mr18033982ljb.128.1534343283267;
        Wed, 15 Aug 2018 07:28:03 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l3-v6sm4559597lfi.36.2018.08.15.07.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 07:28:02 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Kbuild: refactor fixdep to use getopt()
Date:   Wed, 15 Aug 2018 16:27:47 +0200
Message-Id: <20180815142749.18804-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
References: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for teaching an old dog a few new tricks.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/basic/fixdep.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 850966f3d602..666041841200 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -381,16 +381,23 @@ int main(int argc, char *argv[])
 	const char *depfile, *target, *cmdline;
 	int insert_extra_deps = 0;
 	void *buf;
+	int opt;
 
-	if (argc == 5 && !strcmp(argv[1], "-e")) {
-		insert_extra_deps = 1;
-		argv++;
-	} else if (argc != 4)
+	while ((opt = getopt(argc, argv, "e")) != -1) {
+		switch (opt) {
+		case 'e': insert_extra_deps = 1; break;
+		default: usage();
+		}
+	}
+	argc -= optind;
+	argv += optind;
+
+	if (argc != 3)
 		usage();
 
-	depfile = argv[1];
-	target = argv[2];
-	cmdline = argv[3];
+	depfile = argv[0];
+	target = argv[1];
+	cmdline = argv[2];
 
 	printf("cmd_%s := %s\n\n", target, cmdline);
 
-- 
2.16.4

