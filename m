Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D75C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39645208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2y5rWX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39645208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeH1DEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42884 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeH1DEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id r10-v6so438590edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6nR0pRfLmUj2PZ5flmuLWsdHEztq2/Q+Stf4rFsnIdw=;
        b=H2y5rWX1cbcjcAyoLcst6BaSqBAY6jZ/y1GIfHLOt796XhkIcz7knbPGg+5IkCFfj6
         8FFpwvS0jnLx90nDBXjPA1fRj3crXfeCAoC+rX3lWH6ys4sEIF9We6zNUYvs1RXhk1c2
         tQOYlTjWYrUl0oB3TH4KYJkznxs2uOAEKBlhmWD5bBuzYrkJW58dW8pp7G8afGUjnZgf
         kJRskOu8zjk70hWtNEOcLHvS0nyQN+lStlyDRUwXDmagfSGbgJMqIPXo4y9dw9WEszr/
         ru4W/EkC1aiezvCGXH5Z23kaypHI5arjX/ugLQxvV8x23K7gvIvA5QpWN75r0zJyiERK
         7fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6nR0pRfLmUj2PZ5flmuLWsdHEztq2/Q+Stf4rFsnIdw=;
        b=U244Xp8uLHVbn9hY2y1Cbu8c1buE7cJiRtDCNBu4SHic877qsEiCHsYPqvxn65M3Jv
         Uzu82cIlnZBxZfGFObtnuUh0VMyeo+09hoF8+ihWisgvxAFdQgXlE/ptUmTD4DTpZmsh
         x/3UHJN7TOs44NNKLwwoGVG6MMcxM5U1J/WQm2wpA+EbM2s/mFxdQYhXAqLdts2/s5Yh
         BMhkr4ktKclYGZsO9ElxubdzAQRV89T+379eCe8SV/734NmRfmb52raXBD5pT90lORaH
         ZixpQBFNh85HgCBOyEGWZ2XDzY5WsL6EFhaxB3A0mqvUgCygyBp9VmaaDKtYgYbrVuDn
         GsVA==
X-Gm-Message-State: APzg51BV75rQvfxMiGSdXzX/S0HnKwM+wYZUckn52qhfbuoeMqnMuEOz
        jm030Hwatw+CdR0lAnX+SA==
X-Google-Smtp-Source: ANB0VdZI40T9w4U1taB8q6TrhuyxyJposKm94GDU6VszjT/kmg1klUIf14stq/VSYtytVzmQpIiQQw==
X-Received: by 2002:a50:f0c2:: with SMTP id a2-v6mr19510197edm.90.1535411742705;
        Mon, 27 Aug 2018 16:15:42 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:42 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 12/13] proc: convert /proc/*/statm to _print_integer()
Date:   Tue, 28 Aug 2018 02:15:02 +0300
Message-Id: <20180827231503.26899-12-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark pread("/proc/self/statm") 2^23 times:

	6.135596793 seconds time elapsed ( +-  0.11% )
	5.685442773 seconds time elapsed ( +-  0.11% )

	-7.3%

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/array.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 5016e03a4dba..d0565527166a 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -627,27 +627,27 @@ int proc_pid_statm(struct seq_file *m, struct pid_namespace *ns,
 {
 	unsigned long size = 0, resident = 0, shared = 0, text = 0, data = 0;
 	struct mm_struct *mm = get_task_mm(task);
+	/* "%lu %lu %lu %lu 0 %lu 0\n" */
+	char buf[5 * ((sizeof(long) * 5 / 2) + 1) + 2 + 2];
+	char *p = buf + sizeof(buf);
 
 	if (mm) {
 		size = task_statm(mm, &shared, &text, &data, &resident);
 		mmput(mm);
 	}
-	/*
-	 * For quick read, open code by putting numbers directly
-	 * expected format is
-	 * seq_printf(m, "%lu %lu %lu %lu 0 %lu 0\n",
-	 *               size, resident, shared, text, data);
-	 */
-	seq_put_decimal_ull(m, "", size);
-	seq_put_decimal_ull(m, " ", resident);
-	seq_put_decimal_ull(m, " ", shared);
-	seq_put_decimal_ull(m, " ", text);
-	seq_put_decimal_ull(m, " ", 0);
-	seq_put_decimal_ull(m, " ", data);
-	seq_put_decimal_ull(m, " ", 0);
-	seq_putc(m, '\n');
 
-	return 0;
+	p = memcpy(p - 3, " 0\n", 3);
+	p = _print_integer_ul(p, data);
+	p = memcpy(p - 3, " 0 ", 3);
+	p = _print_integer_ul(p, text);
+	*--p = ' ';
+	p = _print_integer_ul(p, shared);
+	*--p = ' ';
+	p = _print_integer_ul(p, resident);
+	*--p = ' ';
+	p = _print_integer_ul(p, size);
+
+	return seq_write(m, p, buf + sizeof(buf) - p);
 }
 
 #ifdef CONFIG_PROC_CHILDREN
-- 
2.16.4

