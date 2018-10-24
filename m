Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE45C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219DC20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ykYFjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219DC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJXMak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:30:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46653 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeJXMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:30:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id c16-v6so4207153qtj.13;
        Tue, 23 Oct 2018 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yg0WFvnhpoiY1xicrTEMzVs+sIxjqijPnqrrojoKadA=;
        b=l4ykYFjrxd+tE8MLPU4hUwoZE/9w2uR6AyW5yDPeef6cRrD472Uccm3d4OM+Vo7Kgc
         ghB2Mlxv0He2l3IZ7YQdZdBRVQT8nAqPwXLJ0rHAocDR/90EeTzauiSxK4Co91CIGXP1
         YSYu4D7ju/4Mj0Lsf2GAbpa8jOftW47aPr4l9JSFpn+FNXMr2EX736IMtqafdX3f0ROg
         INNRlwhPun3yzIU5n4EgyoitcMZiIM1wAqTGigtlULQ9NADbBOlnW9KXKwkIEBS17rqe
         KEXxt+2+BIBjrbNcR9OBjYxOzupGKu1qvqdNpaH0Kz+Am5yPASMFqWs2Ej6ZH/VjCa0Q
         kG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yg0WFvnhpoiY1xicrTEMzVs+sIxjqijPnqrrojoKadA=;
        b=m43VfDErx+VQp1D9nzd8PUlGFYo0VGBxBQb/9vB0iCKryqwWUkNLszWTAiEJfUPaqX
         brKAqftQ4n/cbdwCQ23I6tzJ98+GAb1XbD1TEv97lHQQk31w1YSrFW1UGcdxSl86cjJu
         fyuh77C225PTbTU43+CRxEwo6tAbX3DY44d5NVKsmp5dMv0wOiHAoSvqIqDj11QSFccX
         Ug8+I2bCT9X1F5z4r+XVmoFbFWBdki3ZDT8FpJ55ciev+rbmNivj0Vi4MYDsM4visTRS
         XawZDFQnqNEbuoDazHmMlONTiMdoTOwa92GISEYT9UVwkx771CAHD+tf2gKhaPu3sDP5
         v5gg==
X-Gm-Message-State: AGRZ1gLI+dwB1Mi6L0+ErONWHOfO8l286JqF9bQwrUeu58PYsWDMcNnS
        +2iM9h40sMdbj82z452tKOw=
X-Google-Smtp-Source: AJdET5fw8P03DX+dcu9bu3JBYFKZwspy5r9CUkHSM1xAmz2PBNY4gRcejzdiN9xE9umBSi9Ye7twqg==
X-Received: by 2002:a0c:983d:: with SMTP id c58-v6mr930642qvd.86.1540353861450;
        Tue, 23 Oct 2018 21:04:21 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e195-v6sm3229126qka.2.2018.10.23.21.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 21:04:21 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] modpost: Changes parameter name to avoid shadowing.
Date:   Wed, 24 Oct 2018 01:03:53 -0300
Message-Id: <20181024040354.24879-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024040354.24879-1-leobras.c@gmail.com>
References: <20181024040354.24879-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the parameter name to avoid shadowing a variable.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d998c54564d..368fe42340df 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2228,13 +2228,13 @@ static int add_versions(struct buffer *b, struct module *mod)
 }
 
 static void add_depends(struct buffer *b, struct module *mod,
-			struct module *modules)
+			struct module *module_list)
 {
 	struct symbol *s;
 	struct module *m;
 	int first = 1;
 
-	for (m = modules; m; m = m->next)
+	for (m = module_list; m; m = m->next)
 		m->seen = is_vmlinux(m->name);
 
 	buf_printf(b, "\n");
-- 
2.19.1

