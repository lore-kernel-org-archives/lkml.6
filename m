Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397ADC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B81207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I25XmZ3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B81207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeJXMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:30:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40730 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeJXMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:30:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id z9-v6so4231610qto.7;
        Tue, 23 Oct 2018 21:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcajrvfrkbhr4aN7eaKQgtnrP3L7wB3TYYRQ4bJlwjA=;
        b=I25XmZ3qMOOznouA8nIzeRBZb0ujCDT+w2KzXknbrHl0wADNsAVM3uE82AVROt9ynR
         2RWWsERdWGlO9OxhpAxAKHV6nPIaBlcNQZSTNvGaqtcUT8nSuNOptrCFTov4hUshxXSC
         cFmJLtfhXMVtIuUz/oVpz2LaBLvpTNwmKw5vHE0sSxxi5zOd8kz4EGmJCNwGYQfXkcaD
         l70eUCYPCDsXKGanZbCPbHiYsivfxHIID1JxXCmJz3/iKZ5vzOaKHoCMPfVskNy20mmr
         guL1DJTe3m81w87vx+MlCVxyQi/HUvujgslgyU+ty0frx75bL7z5Sh9WuPjhbNQwW7tq
         3bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcajrvfrkbhr4aN7eaKQgtnrP3L7wB3TYYRQ4bJlwjA=;
        b=Pu/mY/pZsJUt4f1xNBMRTD9uBEKAeLFPhikYA2MoqAez1ErBoB+BLXpOazBTvc9FgT
         3QquRzO65cwlvIhNgg9oRTQ0uCzGGcLB4ASioMhCCmFT3kF1Yt4gPr/QLiAIZxlMnH3M
         PklZsvheLdCZjpkQqSgQtjnOWw/g19XuAAHMzQZAoUMmSHrEqDYBakXFtMvDpN7EWpNr
         7vXCDcUqpQ8ecC9075mHeN77y09xbj2BkDMzDIJpfsDEFmUvOkkxIbfflAkAet/qMdv9
         AYuaMtB+Je7/jU2GtLxemlsF0Mn6jjh3Gavv4PMvBpxGJ/BFnVJ2jl/ps7+H4rM7DNcT
         3OdA==
X-Gm-Message-State: AGRZ1gJHYIbU2YcO5le9Cj/7xwCeodPtLRylPIuOBvZfpDx3R+pBeok5
        Ci7nXH7TNUJX5XyjWf6kRx4=
X-Google-Smtp-Source: AJdET5dX+1y67BUbP8yoaOq+yzRgk4Z+ZZdVd/ZolHZcTOZHpYpkR6c5FZGoRWp4CWBxAGCsKCfQLA==
X-Received: by 2002:a0c:e091:: with SMTP id l17mr893708qvk.144.1540353865835;
        Tue, 23 Oct 2018 21:04:25 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e195-v6sm3229126qka.2.2018.10.23.21.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 21:04:25 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] Adds -Wshadow on KBUILD_HOSTCFLAGS
Date:   Wed, 24 Oct 2018 01:03:54 -0300
Message-Id: <20181024040354.24879-6-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024040354.24879-1-leobras.c@gmail.com>
References: <20181024040354.24879-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds -Wshadow on KBUILD_HOSTCFLAGS to show shadow warnings
on tools built for HOST.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8b599b4dcde..3edae5d359b5 100644
--- a/Makefile
+++ b/Makefile
@@ -360,7 +360,7 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
+KBUILD_HOSTCFLAGS   := -Wall -Wshadow -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
 		$(HOSTCFLAGS)
 KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
-- 
2.19.1

