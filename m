Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C36C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421AC208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwiS06xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421AC208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeH1DEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42878 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbeH1DEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id r10-v6so438457edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XkRJOsOWn4KKRiMGea1FnpjebI85PcYXb5suXzt7bKc=;
        b=GwiS06xGrE6n1ckmwb4EfbmOFZHrB1oRJfFt6pfdFV5DLX3ro+DwSSMylTRJgkr3Fz
         EOslHKHAQGEklNcRvv6HJR1Fpeg3DvuU+ekhbQTMk3DyKlb4IMAUs2fwCwMFZrzD4VK8
         VAXScGIFpjwo1ngifTgdWbyqWavYkueukddb3WZNSjEl6zrSGAXj8J4r2fwZ7LhGWiFK
         rTf+3jWEpYF/a507r2Gqx67qoOpEHjrcFjwi7Nrpp9UY3EypNt55hMJnPLNmUQ47FurG
         TlKu1MJOdP1PDfjYcqTOIqJ7bIUldVAKBMI52Do4FxTByrIX6qwMChmw43L/B8hGevTr
         oojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XkRJOsOWn4KKRiMGea1FnpjebI85PcYXb5suXzt7bKc=;
        b=nnDj1YRZWCXq1+1JnmWsVvlz22soAYb9kjrrmJyo9CuL9QTK/d1bPfacZzDa/DHgiJ
         CACOpXicdCrYbB0nXsBw78wi8eOkX2DWEc7NA9ODfDdZl18HPJXU1dn2Yqi0H4/GMWvq
         Wr5Zn5HgtojhSnCqYuUbK6mE5647/BwXVUlxlYvcUZD9arSX3nb8Kd6vGrM+FXjj/sPZ
         LpJuKkmcGIhH1ncBnSM4prFkG2wdaJZV9SkT6GmQf/vgIFm9pho15KNb43kTpdSyxaHM
         o9AJOkyga9D7Wgrg1fWdFeiYuRh8UCYZVv7J33RcMkboXTH49tlFIfZlC0FAd88KL2uR
         NFjQ==
X-Gm-Message-State: APzg51C8vfkAh9WykaJ6Imnk5sleiPcbJPpzMut0zf6aF6lIqnq3TL+B
        cuKwLhwcvDNaTFBeXrRWM9xEibY=
X-Google-Smtp-Source: ANB0VdYNDFbs1tc6Y0YoozIdD8knMdHfS1/YdMNkLxKtCL/j24nxasim7Z9X2LZVS6hGfVrOVZceXw==
X-Received: by 2002:a50:af03:: with SMTP id g3-v6mr18593341edd.220.1535411736328;
        Mon, 27 Aug 2018 16:15:36 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:35 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 05/13] proc: new and improved way to print decimals
Date:   Tue, 28 Aug 2018 02:14:55 +0300
Message-Id: <20180827231503.26899-5-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C lacks a capable preprocess to turn

	snprintf(buf, sizeof(buf), "%u", x);

into

	print_integer_u32(buf, x);

so vsnprintf() is forced to have a million branches.
Benchmark anything which uses /proc and look for format_decode().

This unfortunate situation was partially fixed by seq_put_decimal_ull()
function which skipped "format specifier" part. However, it still does
unnecessary copies internally and even reflects the digits before
putting them into final buffer. It also does strlen() which is done at
runtime.

The following 3 functions

	_print_integer_u32
	_print_integer_u64
	_print_integer_ul

cut all the overhead by printing backwards one character at a time:

	x = 123456789

	|	<====|
	|...123456789|

This is just as fast as current printing by 2 characters at a time,
because pids, fds, uids are small integers so emitting 2 characters
doesn't make much difference. It also generates very small code
(146 bytes total here, not counting the callers).
Current put_dec() and friends are surprisingly large.

All the functions have the following signature:

	char *_print_integer_XXX(char *p, T x);

They are written quite in a very specific way to prevent gcc from
inlining everything and making a mess.

They aren't exported and advertised because idiomatic way of using them
is not something you see every day:
* fixed sized buffer on stack capable of holding the worst case,
* pointer past the end of the buffer (yay 6.5.6 p8!)
* no buffer length checks (wheee),
* no NUL terminator (ha-ha-ha),
* emitting output BACKWARDS (one character at a time!),
* finally one copy to the final buffer (one copy, one!).

	char buf[10 + 1 + 20 + 1], *p = buf + sizeof(buf);

	*--p = '\n';
	p = _print_integer_u64(p, y);
	*--p = ' ';
	p = _print_integer_u32(p, x);

	seq_write(seq, p, buf + sizeof(buf) - p);

As the comment says, do not tell anyone about these functions.

The plan is to use them inside /proc and only inside /proc.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/internal.h | 11 +++++++++++
 fs/proc/util.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f6a51e..be4965ef8e48 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -127,6 +127,17 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 		     kuid_t *ruid, kgid_t *rgid);
 
 unsigned name_to_int(const struct qstr *qstr);
+
+char *_print_integer_u32(char *, u32);
+char *_print_integer_u64(char *, u64);
+static inline char *_print_integer_ul(char *p, unsigned long x)
+{
+	if (sizeof(unsigned long) == 4)
+		return _print_integer_u32(p, x);
+	else
+		return _print_integer_u64(p, x);
+}
+
 /*
  * Offset of the first process in the /proc root directory..
  */
diff --git a/fs/proc/util.c b/fs/proc/util.c
index b161cfa0f9fa..2d9ceab04289 100644
--- a/fs/proc/util.c
+++ b/fs/proc/util.c
@@ -1,4 +1,5 @@
 #include <linux/dcache.h>
+#include <linux/math64.h>
 
 unsigned name_to_int(const struct qstr *qstr)
 {
@@ -21,3 +22,49 @@ unsigned name_to_int(const struct qstr *qstr)
 out:
 	return ~0U;
 }
+
+/*
+ * Print an integer in decimal.
+ * "p" initially points PAST THE END OF THE BUFFER!
+ *
+ * DO NOT USE THESE FUNCTIONS!
+ *
+ * Do not copy these functions.
+ * Do not document these functions.
+ * Do not move these functions to lib/ or elsewhere.
+ * Do not export these functions to modules.
+ * Do not tell anyone about these functions.
+ */
+noinline
+char *_print_integer_u32(char *p, u32 x)
+{
+	do {
+		*--p = '0' + (x % 10);
+		x /= 10;
+	} while (x != 0);
+	return p;
+}
+
+static char *__print_integer_u32(char *p, u32 x)
+{
+	/* 0 <= x < 10^8 */
+	char *p0 = p - 8;
+
+	p = _print_integer_u32(p, x);
+	while (p != p0)
+		*--p = '0';
+	return p;
+}
+
+char *_print_integer_u64(char *p, u64 x)
+{
+	while (x >= 100000000) {
+		u64 q;
+		u32 r;
+
+		q = div_u64_rem(x, 100000000, &r);
+		p = __print_integer_u32(p, r);
+		x = q;
+	}
+	return _print_integer_u32(p, x);
+}
-- 
2.16.4

