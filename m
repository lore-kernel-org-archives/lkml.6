Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C09C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DEB20659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QKQn+QAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DEB20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeJNVGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:06:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38482 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeJNVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:06:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so16927922wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8nGVffKLqMsApvjnF0Xvonfe8qyp7cUYkrb2XMD3xvY=;
        b=QKQn+QAUqwv1Kyz1ZbibdpxDpDl7avU8uCKoeXNx2BS0SzhgjK2gVVlhg2ZoCAse+Z
         EFQFPJVwn/LXGqJupmH3V+fWYyTTJfnEidBdTj0G7sL7x0IEguLdnySVaAX5h5x0ZnRX
         5xkQ8IIMaH5bJAPb4OOtlk4PK0gu0UMl7z8LngzzBIzVe+O3iRyJEtQbTvzGpWhe+n1x
         R0HnQw/8SJkoJD/2c24RM/UVVHoKrRpZZ0TeCVotoGdnBMQ2GEbktFzQ4jVphE4Sa4tl
         k/3M/9Brgxum5kM9EMWSNOfqHgecwayRVnVKjLPW3rb5iQhacEVAd7NAYsf4yJh9FvYa
         KGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8nGVffKLqMsApvjnF0Xvonfe8qyp7cUYkrb2XMD3xvY=;
        b=rUcJHFucx2WQjSfYd1kygcC8RNlnfKZoCAELZFJrPW47kVzruYtjhHxo7BIWtOKFWv
         UHkzCIZfiIh7F5NpdSsnTmPNyeayKZP8/oOeXq0TpVxPt4tXLEZQ53v4kGhXwP5i5ZP5
         Y+dqs6bJmivnNvSiN2cqhcJt9mzRyXJ+JEU2FksmL7o6ND/35nnfg67YADFB0g1xe8kW
         q0T7e2FEXq9vWedbC8V0BR7HOnkHqckq71aPTJLNzF00IthvwpJ/SBP9aSTnzvGuMKdi
         ScEK2ilfosI85hYkruQqbX3bIveS0rdlcK3DhYwsCoFS73fE4+6qwEePjjwj1DHpsTdi
         3KUg==
X-Gm-Message-State: ABuFfoj1trF+Scs1xVfdB0c9ZhGr8z/yuKG/YKKiaTQqBdB9nSA1txCq
        wrP4LqSwlC5fIt5fOC7rrG4CHg==
X-Google-Smtp-Source: ACcGV60RIAi86+44aaXXKe8+C8G6ZHif00zkeRLtdZU755B9K6A3lWNb6qOcdNTRWcjE8muWcE+DWg==
X-Received: by 2002:a1c:96c7:: with SMTP id y190-v6mr10716857wmd.36.1539523542531;
        Sun, 14 Oct 2018 06:25:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id a11-v6sm10550050wrp.3.2018.10.14.06.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 06:25:41 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/2] sysctl: add overflow detection to proc_get_long()
Date:   Sun, 14 Oct 2018 15:25:09 +0200
Message-Id: <20181014132510.25943-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181014132510.25943-1-christian@brauner.io>
References: <20181014132510.25943-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_get_long() is a funny function. It uses simple_strtoul() and for a
good reason. proc_get_long() wants to always succeed the parse and
return the maybe incorrect value and the trailing characters to check
against a pre-defined list of acceptable trailing values.
However, simple_strtoul() doesn not surface overflows when it detects
them which is problematic since it can cause funny things like:

echo 18446744073709551616 > /proc/sys/fs/file-max
cat /proc/sys/fs/file-max
0

(which will cause your system to silently die behind your back.)

On the other hand kstrtoul() does do overflow detection but fails the
parse in this case, does not return the trailing characters, and also
fails the parse when anything other than '\n' is a trailing character
whereas proc_get_long() wants to be more lenient in this case.

Now, before adding another kstrtoul() function let's simply add
a static parse sysctl_strtoul_lenient() which does:
- always return a value even if incorrect
- reports overflow to the caller
- returns the trailing characters to the caller
This guarantees that we don't regress userspace in any way but also
allows us to adapt callers of proc_get_long() to make decisions what is
supposed to happen when overflow was detected.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/sysctl.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..a9409375380c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -67,6 +67,7 @@
 #include <linux/bpf.h>
 #include <linux/mount.h>
 #include <linux/pipe_fs_i.h>
+#include <../lib/kstrtox.h>
 
 #include <linux/uaccess.h>
 #include <asm/processor.h>
@@ -2065,6 +2066,28 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
 	}
 }
 
+static unsigned long sysctl_strtoul_lenient(const char *cp, char **endp,
+					    unsigned int base, bool *overflow)
+{
+	unsigned long long result;
+	unsigned int rv;
+
+	cp = _parse_integer_fixup_radix(cp, &base);
+	rv = _parse_integer(cp, base, &result);
+	if ((rv & KSTRTOX_OVERFLOW) ||
+	    (result != (unsigned long long)(unsigned long)result))
+		*overflow = true;
+	else
+		*overflow = false;
+
+	cp += (rv & ~KSTRTOX_OVERFLOW);
+
+	if (endp)
+		*endp = (char *)cp;
+
+	return result;
+}
+
 #define TMPBUFLEN 22
 /**
  * proc_get_long - reads an ASCII formatted integer from a user buffer
@@ -2084,7 +2107,8 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
  */
 static int proc_get_long(char **buf, size_t *size,
 			  unsigned long *val, bool *neg,
-			  const char *perm_tr, unsigned perm_tr_len, char *tr)
+			  const char *perm_tr, unsigned perm_tr_len, char *tr,
+			  bool *overflow)
 {
 	int len;
 	char *p, tmp[TMPBUFLEN];
@@ -2108,7 +2132,7 @@ static int proc_get_long(char **buf, size_t *size,
 	if (!isdigit(*p))
 		return -EINVAL;
 
-	*val = simple_strtoul(p, &p, 0);
+	*val = sysctl_strtoul_lenient(p, &p, 0, overflow);
 
 	len = p - tmp;
 
@@ -2251,7 +2275,7 @@ static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
 
 	for (; left && vleft--; i++, first=0) {
 		unsigned long lval;
-		bool neg;
+		bool neg, overflow;
 
 		if (write) {
 			left -= proc_skip_spaces(&p);
@@ -2259,8 +2283,9 @@ static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
 			if (!left)
 				break;
 			err = proc_get_long(&p, &left, &lval, &neg,
-					     proc_wspace_sep,
-					     sizeof(proc_wspace_sep), NULL);
+					    proc_wspace_sep,
+					    sizeof(proc_wspace_sep), NULL,
+					    &overflow);
 			if (err)
 				break;
 			if (conv(&neg, &lval, i, 1, data)) {
@@ -2319,7 +2344,7 @@ static int do_proc_douintvec_w(unsigned int *tbl_data,
 	unsigned long lval;
 	int err = 0;
 	size_t left;
-	bool neg;
+	bool neg, overflow;
 	char *kbuf = NULL, *p;
 
 	left = *lenp;
@@ -2342,7 +2367,7 @@ static int do_proc_douintvec_w(unsigned int *tbl_data,
 
 	err = proc_get_long(&p, &left, &lval, &neg,
 			     proc_wspace_sep,
-			     sizeof(proc_wspace_sep), NULL);
+			     sizeof(proc_wspace_sep), NULL, &overflow);
 	if (err || neg) {
 		err = -EINVAL;
 		goto out_free;
@@ -3078,10 +3103,10 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 		proc_skip_char(&p, &left, '\n');
 		while (!err && left) {
 			unsigned long val_a, val_b;
-			bool neg;
+			bool neg, overflow;
 
 			err = proc_get_long(&p, &left, &val_a, &neg, tr_a,
-					     sizeof(tr_a), &c);
+					     sizeof(tr_a), &c, &overflow);
 			if (err)
 				break;
 			if (val_a >= bitmap_len || neg) {
@@ -3098,7 +3123,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			if (c == '-') {
 				err = proc_get_long(&p, &left, &val_b,
 						     &neg, tr_b, sizeof(tr_b),
-						     &c);
+						     &c, &overflow);
 				if (err)
 					break;
 				if (val_b >= bitmap_len || neg ||
-- 
2.17.1

