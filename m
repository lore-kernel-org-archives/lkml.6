Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0303C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980D22087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="dVPvPY0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfASAMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:12:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45917 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbfASAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:12:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so9035431qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHPeHYkiG+kt+yg/KDYa6TT6vm5cw8+nKFhtmOsn/MY=;
        b=dVPvPY0p88nbi7xYfnGZDQypj2AzdwLA+pslY51UkTa1rKYcsFDjuCKChqaFdnQEFH
         mQrej5Iwpmt34lz28apM1I+3+ts+sHmcW9Dyys7CLyoHlERzNOW95Cr8XFWVVPQamJbn
         iuN7K0xmb4VnqMVFwtmr0I3UOoHmHQYu3cWmAnClCWOkP8c+Wl3Wl6DAa2uVxfO0iuhd
         o0kfABuqmOw1apBAzxO+PTcJ3RD1Z5/K69Zcj7gfO8OsVKJ2hxhjOG4ocnOCBgbCnPJy
         8cP5ghXTcEAr2e5+Vx5rFhzVMVO6ctkkzM7x2djFSSq1C+5xIJBbK0ZUMKMVxhRkeiPk
         3y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHPeHYkiG+kt+yg/KDYa6TT6vm5cw8+nKFhtmOsn/MY=;
        b=KkxQetTq8N1VSxju5yJLC3Nw6R5iK5RfkU1MmSzDj8e8bpVpp15cq2v7LTM44VZCat
         0GonoUpilQIK3mwEfeREIFQTqWX+7Twh+GG6/Zt0VjobafJvr0Vj4zY2pBTdh87AgLfr
         wXOP8djgA2fdRWjsusUu8Gzg1hDOFEcar4EbTTyOFglg8AErhjh+scHoMWRihx9TZCkn
         yBst91ODc+P4r9PVS7zLH9j8lMOQUTiiaOL6KQj+U/m7UAbAYxn2DOAYJA7g8Tz06I0m
         IIsymQzKZKdnCAgLH+yidHwP+DxHbtJSzBKt6Y5MS1gKgFAia2SLvi1uNbb7mzxt/GqC
         mClQ==
X-Gm-Message-State: AJcUukcMLDrCpq/fAcfe/YqOPlEYA9yBW3cLGuK9obFonuYLSWAa0WAt
        uRCoKMcrn4Y+nW5nCBilBy97CQ==
X-Google-Smtp-Source: ALg8bN7GjBMjkRDGx0h5oKPePAucbY53bsa6D7FKrFdkkpk9z7VisjAj6GXq0T4pq9X6J3Do8nl/SA==
X-Received: by 2002:a37:b46:: with SMTP id 67mr17474806qkl.256.1547856769251;
        Fri, 18 Jan 2019 16:12:49 -0800 (PST)
Received: from localhost.localdomain ([64.125.109.186])
        by smtp.gmail.com with ESMTPSA id m14sm41140501qka.21.2019.01.18.16.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:12:48 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 2/6] selftests: fix typo in seccomp_bpf.c
Date:   Fri, 18 Jan 2019 17:12:13 -0700
Message-Id: <20190119001217.12660-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190119001217.12660-1-tycho@tycho.ws>
References: <20190119001217.12660-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There used to be an explanation here because it could trigger lockdep
previously, but now we're not doing recursive locking, so it really is just
for grins.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9aba1b904089..912a2a5430dc 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3035,7 +3035,7 @@ TEST(user_notification_basic)
 	EXPECT_EQ(true, WIFEXITED(status));
 	EXPECT_EQ(0, WEXITSTATUS(status));
 
-	/* Add some no-op filters so for grins. */
+	/* Add some no-op filters for grins. */
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
-- 
2.19.1

