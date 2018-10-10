Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB44C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6E521479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxwohb8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6E521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:55:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32785 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:55:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so2418369plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m77aAX7nz09GGNKYMSeXlAxI5zFlcTR4XjjXk5bt2eE=;
        b=qxwohb8IeVIA6M+g1c3v9hx155YNdNAd2VHwbh8d5sw/B3Ymu9ksMYlkY9lfvzogIp
         DF1Z/lEH8gd9EhmulDVrD/R/kcaVYhZAHLRAzTqD/9v0f5sxEwXqMZ5hD0tzTWC5/MUv
         WmVn8jA09SWsdpBSrTEpHzdv40aDrY6AVnbZD0iDJZ96Q8XhrvD+/3Ip3t+Dt2L35dlS
         Frya4jzU7iv+Xd1QUGxVTm/YzmPBfLjDb5F7pZUe4GBhSffR9Qpy9F57WqnG6WlyQkrC
         SviQx5huyFUP3Q0b7k35Sj+dbE+of2eXXj7m3aUE2uchXPyQ0El9HduTojQ6JsWo1/pY
         dPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m77aAX7nz09GGNKYMSeXlAxI5zFlcTR4XjjXk5bt2eE=;
        b=RCGrseZeAmkvmP8Eq+kV/ODAqz0/Kd/x9R3n2tIJVIfeVvASkGK4DQN6YIxGe0AUbp
         efgSQ152DskaXYx1099Ys73+v1gUOgUnSPBEwD1S3mOIPedjeLcti7Hp8UphYxAs2OAY
         tVqc1FYbO+V/tvySAiBfAarb31rL21+MWsFQLoNxJ7dBqSUe90iDGWxIS3sNYfrQzkk+
         niFH2Mj/izU3MoxXlKfmN1b+/afc63mJmjUoBOiY4+80XXyjC6ozOtMLiQdMAGZroJ74
         uuEl5DaIjEdCgGLkcGtXxuJmKg+Kqc6ahGDHPHhAGfddz0Tz+TIP52KMnpcqSBVMzKiv
         Jfaw==
X-Gm-Message-State: ABuFfoiFkdmV5zQT2uUzgewn8HxAdgIaF9f2uLF3yiGjfCmmCxKvSJCg
        iHgyQtoHsycW32r4pxSTWCY=
X-Google-Smtp-Source: ACcGV60joCZSMsg6r2tZmtffUQk6QVTe95G/lfzFBKZlizN2pTy88EJaGB3mtPnXersLR68RWAYwyA==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr32577422plq.77.1539171206972;
        Wed, 10 Oct 2018 04:33:26 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id g5-v6sm36349514pfk.160.2018.10.10.04.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 04:33:26 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] printk: fix integer overflow in setup_log_buf()
Date:   Wed, 10 Oct 2018 20:33:08 +0900
Message-Id: <20181010113308.9337-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
References: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way we calculate logbuf free space percentage overflows signed
integer:

	int free;

	free = __LOG_BUF_LEN - log_next_idx;
	pr_info("early log buf free: %u(%u%%)\n",
		free, (free * 100) / __LOG_BUF_LEN);

We support LOG_BUF_LEN of up to 1<<25 bytes. Since setup_log_buf() is
called during early init, logbuf is mostly empty, so

	__LOG_BUF_LEN - log_next_idx

is close to 1<<25. Thus when we multiply it by 100, we overflow signed
integer value range: 100 is 2^6 + 2^5 + 2^2.

Example, booting with LOG_BUF_LEN 1<<25 and log_buf_len=2G
boot param:

[    0.075317] log_buf_len: -2147483648 bytes
[    0.075319] early log buf free: 33549896(-28%)

Make "free" unsigned integer and use appropriate printk() specifier.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c3f0e3927e77..c9e1d3bf695e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1083,7 +1083,7 @@ void __init setup_log_buf(int early)
 {
 	unsigned long flags;
 	char *new_log_buf;
-	int free;
+	unsigned int free;
 
 	if (log_buf != __log_buf)
 		return;
@@ -1116,8 +1116,8 @@ void __init setup_log_buf(int early)
 	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
 	logbuf_unlock_irqrestore(flags);
 
-	pr_info("log_buf_len: %d bytes\n", log_buf_len);
-	pr_info("early log buf free: %d(%d%%)\n",
+	pr_info("log_buf_len: %u bytes\n", log_buf_len);
+	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
 }
 
-- 
2.19.1

