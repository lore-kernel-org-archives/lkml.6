Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C45C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EB520899
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeH1ogwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EB520899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeGDNhU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:37:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34202 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeGDNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:37:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so2665239plo.1;
        Wed, 04 Jul 2018 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HrSz6IWJ9gAhRDEbhboGcIZLLt5aCt6criFoTC4LdoQ=;
        b=YeH1ogwVYJ3CpTOTC6gSNBWN9gM+iWozowt3IVGOffU+ADgsOYGnYFj64/lyCYSgfx
         flz9C8eG0R5PI2w8Tc/3jhkQ5JPL4Tj+DnWgaEgfydfZY4BLAtbK9oykjx9XogjJavq+
         SCgg6M+guF+b0NWjJA8j3vFxHxqPplBq+Pzsuy0nR3V1W5mJRMqjSR0CNddmp8VFDHi4
         P48e7aIKgPQKiRfK3vhUw19uUF0Cskb9gKM1ZkOlh534nPFtlFlg/AVJfr0vtRx4l90n
         YE+7wMyG2ihWRVNa4+SP17+UCF2a+iE1TZFfQlxFSdWj7N5pRSvou6eDXpGP6nwXYlI2
         GYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HrSz6IWJ9gAhRDEbhboGcIZLLt5aCt6criFoTC4LdoQ=;
        b=aftUCzlwSUvB5INa2qrl419rSegDTGnJuYHUMDjQ1sf4Zs3N1Ulo7lvDHHpk5Jfcxp
         7SeLmq+QB1WpZvnqDKtwYHGss6XG3EXsdlcWvz6STjbvr1t6i1ayAVuD4ugEMBpTeNba
         ZJbvaFrW+OXmfvJnfYMIYPwZKGAiUOSxdPOeu3lMDPG/ePqPW6WTOnKRDMyXLxkevshN
         e5z7LzfYvYvHFtvSaiiB9sBid0r/pE3hxRWc6qTXEvyf3ycQcnMpIYQRQEnzAZpBfOx2
         vHnfE5e0Y6MutuiEdbg1ss2nz8R3EUbhnnjmUCWCQ5oPmsxWhtoYQox6fzwxplJ73awa
         OdVQ==
X-Gm-Message-State: APt69E0y0d09zx4t9wI5dKUCQ03JVy8awtDoU65/tdpm6HQ7rlw3y5VB
        xz+YApwLVojC3t9+LahpUSk=
X-Google-Smtp-Source: AAOMgpd72s0nNycPdjlIJrh9Q46Mpvlz+QAJDC4xzp+eG1M0ADdGdAQNhWwDaLYA1KlpLFlsSw9jXA==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14-v6mr2216781plr.5.1530711437257;
        Wed, 04 Jul 2018 06:37:17 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id i12-v6sm3593913pgd.87.2018.07.04.06.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:37:16 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2 3/4] samples/bpf: Check the error of write() and read()
Date:   Wed,  4 Jul 2018 22:36:38 +0900
Message-Id: <20180704133639.11855-4-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704133639.11855-1-treeze.taeung@gmail.com>
References: <20180704133639.11855-1-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_task_rename() and test_urandom_read()
can be failed during write() and read(),
So check the result of them.

Reviewed-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/test_overhead_user.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/test_overhead_user.c b/samples/bpf/test_overhead_user.c
index 6caf47afa635..9d6dcaa9db92 100644
--- a/samples/bpf/test_overhead_user.c
+++ b/samples/bpf/test_overhead_user.c
@@ -6,6 +6,7 @@
  */
 #define _GNU_SOURCE
 #include <sched.h>
+#include <errno.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <asm/unistd.h>
@@ -44,8 +45,13 @@ static void test_task_rename(int cpu)
 		exit(1);
 	}
 	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++)
-		write(fd, buf, sizeof(buf));
+	for (i = 0; i < MAX_CNT; i++) {
+		if (write(fd, buf, sizeof(buf)) < 0) {
+			printf("task rename failed: %s\n", strerror(errno));
+			close(fd);
+			return;
+		}
+	}
 	printf("task_rename:%d: %lld events per sec\n",
 	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
 	close(fd);
@@ -63,8 +69,13 @@ static void test_urandom_read(int cpu)
 		exit(1);
 	}
 	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++)
-		read(fd, buf, sizeof(buf));
+	for (i = 0; i < MAX_CNT; i++) {
+		if (read(fd, buf, sizeof(buf)) < 0) {
+			printf("failed to read from /dev/urandom: %s\n", strerror(errno));
+			close(fd);
+			return;
+		}
+	}
 	printf("urandom_read:%d: %lld events per sec\n",
 	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
 	close(fd);
-- 
2.17.1

