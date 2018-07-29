Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6837FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 13:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A34520870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 13:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r21Uvgb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A34520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeG2Odw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 10:33:52 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:41334 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeG2Odw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 10:33:52 -0400
Received: by mail-lj1-f181.google.com with SMTP id y17-v6so8134088ljy.8;
        Sun, 29 Jul 2018 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gSIxRXdMjs0Gl9AsXbankfkAI0CfHbaVgFBR7b4VGfA=;
        b=r21Uvgb2kBSMfwJKkBJHP7npY7bZZ5oUjWzUw/GbitbZDeddYp0cCd/95PiZu+0FnJ
         YOipJuBRwOxxNlQMfkUAso2mhS86HdEXYmEWCfD7mbfegOuE/Zw7HISL/8F68vrAH5zT
         ULkwGGUa+sSuNyu8iua1w7sAUXnwJ8U9fr3p5Yhk90UbjL3CWrcrZysxy9bU0qWEBsI8
         ZP/ty0Z0m+2YmLwHl5tbRXzf0jWDVaQ3loLvn0Elq8DrBZBTZHLy3nkkwuMK/hIXbgKF
         8e5j431N1pfv690H6Y64Pru8F4SZ8OQRFAUibFTnxoyXwy75AdjqzO3K7TFxQ+XeWqmd
         SBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gSIxRXdMjs0Gl9AsXbankfkAI0CfHbaVgFBR7b4VGfA=;
        b=pryZfB/qihpBXPRRD8yBCVcAtivLw8Q1l5zxzOGMkCDlkTG75eI/6C3PzP1ql+ii3V
         IiRqllJdotLAztvVuv0RA3NRtlLTa2o//jpNPJF1H34nCQiuN5+PpT0I/cwjwevlDJs5
         OMb2b/hT9KKPyuVEqU8CjUwTPe5tJMwh9ofupzHhLIeA3Z2EldcAO1S44rxYulTNrU61
         /ej3GXUV1+ya4S1Q5PO4PyYl+zRKT0PWVGmgr6eBSMbj9CMrclgctpm79nt7VzMU8Zyz
         2rqluw4SEU4KXCv6ZBVqFC0p0y0HlfCqRlOmjhnZbTzJ6XtQZzL/cLRNh2J3Y5cauJNW
         RRsg==
X-Gm-Message-State: AOUpUlG3/bQ7ffeL52j3o67pLOW0/tG/W5tmIWGhi3QwhhXmJCdf9sxg
        jzuqwzhedc8FD+GRUMgBHpM=
X-Google-Smtp-Source: AAOMgpethCwgIkfdR6zOdCylCzXO6jprWuYB0t1NOmr0Mvdg7qkAJlhBEG9HtnufMGyU5fYjq6z5wA==
X-Received: by 2002:a2e:8147:: with SMTP id t7-v6mr10716218ljg.32.1532869404609;
        Sun, 29 Jul 2018 06:03:24 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id m129-v6sm1189488lfe.50.2018.07.29.06.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 06:03:23 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] 9p: fix Use-After-Free in p9_write_work()
Date:   Sun, 29 Jul 2018 15:02:48 +0200
Message-Id: <20180729130248.29612-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition between p9_free_req() and p9_write_work().
A request might still need to be processed while p9_free_req() is called.

To fix it, flush the read/write work before freeing any request.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
---

To be able to flush the r/w work from client.c we need the p9_conn and
p9_trans_fd definitions. Therefore this commit moves most of the declarations in
trans_fd.c to trans_fd.h and import such file in client.c

Moreover, a couple of identifiers were altered to avoid name conflicts with the
new import.

 include/net/9p/trans_fd.h | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 net/9p/client.c           |   8 ++-
 net/9p/trans_fd.c         | 113 +------------------------------------
 3 files changed, 148 insertions(+), 112 deletions(-)
 create mode 100644 include/net/9p/trans_fd.h

diff --git a/include/net/9p/trans_fd.h b/include/net/9p/trans_fd.h
new file mode 100644
index 000000000000..cfd4457c40fb
--- /dev/null
+++ b/include/net/9p/trans_fd.h
@@ -0,0 +1,139 @@
+/*
+ * include/fs/9p/trans_fd.h
+ *
+ * Fd transport layer definitions.
+ *
+ *  Copyright (C) 2006 by Russ Cox <rsc@swtch.com>
+ *  Copyright (C) 2004-2005 by Latchesar Ionkov <lucho@ionkov.net>
+ *  Copyright (C) 2004-2008 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 1997-2002 by Ron Minnich <rminnich@sarnoff.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor
+ *  Boston, MA  02111-1301  USA
+ *
+ */
+
+#ifndef P9_TRANS_FD_H
+#define P9_TRANS_FD_H
+
+/**
+ * struct p9_fd_opts - per-transport options
+ * @rfd: file descriptor for reading (trans=fd)
+ * @wfd: file descriptor for writing (trans=fd)
+ * @port: port to connect to (trans=tcp)
+ *
+ */
+
+#define P9_PORT 564
+#define MAX_SOCK_BUF (64*1024)
+#define MAXPOLLWADDR	2
+
+struct p9_fd_opts {
+	int rfd;
+	int wfd;
+	u16 port;
+	bool privport;
+};
+
+/*
+  * Option Parsing (code inspired by NFS code)
+  *  - a little lazy - parse all fd-transport options
+  */
+
+enum {
+	/* Options that take integer arguments */
+	Opt_port, Opt_rfdno, Opt_wfdno, Opt_err,
+	/* Options that take no arguments */
+	Opt_privport,
+};
+
+static const match_table_t trans_tokens = {
+	{Opt_port, "port=%u"},
+	{Opt_rfdno, "rfdno=%u"},
+	{Opt_wfdno, "wfdno=%u"},
+	{Opt_privport, "privport"},
+	{Opt_err, NULL},
+};
+
+enum {
+	Rworksched = 1,		/* read work scheduled or running */
+	Rpending = 2,		/* can read */
+	Wworksched = 4,		/* write work scheduled or running */
+	Wpending = 8,		/* can write */
+};
+
+struct p9_poll_wait {
+	struct p9_conn *conn;
+	wait_queue_entry_t wait;
+	wait_queue_head_t *wait_addr;
+};
+
+/**
+ * struct p9_conn - fd mux connection state information
+ * @mux_list: list link for mux to manage multiple connections (?)
+ * @client: reference to client instance for this connection
+ * @err: error state
+ * @req_list: accounting for requests which have been sent
+ * @unsent_req_list: accounting for requests that haven't been sent
+ * @req: current request being processed (if any)
+ * @tmp_buf: temporary buffer to read in header
+ * @rc: temporary fcall for reading current frame
+ * @wpos: write position for current frame
+ * @wsize: amount of data to write for current frame
+ * @wbuf: current write buffer
+ * @poll_pending_link: pending links to be polled per conn
+ * @poll_wait: array of wait_q's for various worker threads
+ * @pt: poll state
+ * @rq: current read work
+ * @wq: current write work
+ * @wsched: ????
+ *
+ */
+
+struct p9_conn {
+	struct list_head mux_list;
+	struct p9_client *client;
+	int err;
+	struct list_head req_list;
+	struct list_head unsent_req_list;
+	struct p9_req_t *req;
+	char tmp_buf[7];
+	struct p9_fcall rc;
+	int wpos;
+	int wsize;
+	char *wbuf;
+	struct list_head poll_pending_link;
+	struct p9_poll_wait poll_wait[MAXPOLLWADDR];
+	poll_table pt;
+	struct work_struct rq;
+	struct work_struct wq;
+	unsigned long wsched;
+};
+
+/**
+ * struct p9_trans_fd - transport state
+ * @rd: reference to file to read from
+ * @wr: reference of file to write to
+ * @conn: connection state reference
+ *
+ */
+
+struct p9_trans_fd {
+	struct file *rd;
+	struct file *wr;
+	struct p9_conn conn;
+};
+
+#endif
diff --git a/net/9p/client.c b/net/9p/client.c
index 2ec0edc6104f..ddfb63672a63 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -40,6 +40,7 @@
 #include <linux/seq_file.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
+#include <net/9p/trans_fd.h>
 #include "protocol.h"
 
 #define CREATE_TRACE_POINTS
@@ -55,7 +56,7 @@ enum {
 	Opt_trans,
 	Opt_legacy,
 	Opt_version,
-	Opt_err,
+	Opt_error,
 };
 
 static const match_table_t tokens = {
@@ -63,7 +64,7 @@ static const match_table_t tokens = {
 	{Opt_legacy, "noextend"},
 	{Opt_trans, "trans=%s"},
 	{Opt_version, "version=%s"},
-	{Opt_err, NULL},
+	{Opt_error, NULL},
 };
 
 inline int p9_is_proto_dotl(struct p9_client *clnt)
@@ -329,12 +330,15 @@ EXPORT_SYMBOL(p9_tag_lookup);
 static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
 {
 	unsigned long flags;
+	struct p9_trans_fd *ts = c->trans;
 	u16 tag = r->tc->tag;
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p req %p tag: %d\n", c, r, tag);
 	spin_lock_irqsave(&c->lock, flags);
 	idr_remove(&c->reqs, tag);
 	spin_unlock_irqrestore(&c->lock, flags);
+	flush_work(&ts->conn.wq);
+	flush_work(&ts->conn.rq);
 	kfree(r->tc);
 	kfree(r->rc);
 	kmem_cache_free(p9_req_cache, r);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index e2ef3c782c53..63b3c7ef0d90 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -45,122 +45,15 @@
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
+#include <net/9p/trans_fd.h>
 
 #include <linux/syscalls.h> /* killme */
 
-#define P9_PORT 564
-#define MAX_SOCK_BUF (64*1024)
-#define MAXPOLLWADDR	2
+static void p9_poll_workfn(struct work_struct *work);
 
 static struct p9_trans_module p9_tcp_trans;
 static struct p9_trans_module p9_fd_trans;
 
-/**
- * struct p9_fd_opts - per-transport options
- * @rfd: file descriptor for reading (trans=fd)
- * @wfd: file descriptor for writing (trans=fd)
- * @port: port to connect to (trans=tcp)
- *
- */
-
-struct p9_fd_opts {
-	int rfd;
-	int wfd;
-	u16 port;
-	bool privport;
-};
-
-/*
-  * Option Parsing (code inspired by NFS code)
-  *  - a little lazy - parse all fd-transport options
-  */
-
-enum {
-	/* Options that take integer arguments */
-	Opt_port, Opt_rfdno, Opt_wfdno, Opt_err,
-	/* Options that take no arguments */
-	Opt_privport,
-};
-
-static const match_table_t tokens = {
-	{Opt_port, "port=%u"},
-	{Opt_rfdno, "rfdno=%u"},
-	{Opt_wfdno, "wfdno=%u"},
-	{Opt_privport, "privport"},
-	{Opt_err, NULL},
-};
-
-enum {
-	Rworksched = 1,		/* read work scheduled or running */
-	Rpending = 2,		/* can read */
-	Wworksched = 4,		/* write work scheduled or running */
-	Wpending = 8,		/* can write */
-};
-
-struct p9_poll_wait {
-	struct p9_conn *conn;
-	wait_queue_entry_t wait;
-	wait_queue_head_t *wait_addr;
-};
-
-/**
- * struct p9_conn - fd mux connection state information
- * @mux_list: list link for mux to manage multiple connections (?)
- * @client: reference to client instance for this connection
- * @err: error state
- * @req_list: accounting for requests which have been sent
- * @unsent_req_list: accounting for requests that haven't been sent
- * @req: current request being processed (if any)
- * @tmp_buf: temporary buffer to read in header
- * @rc: temporary fcall for reading current frame
- * @wpos: write position for current frame
- * @wsize: amount of data to write for current frame
- * @wbuf: current write buffer
- * @poll_pending_link: pending links to be polled per conn
- * @poll_wait: array of wait_q's for various worker threads
- * @pt: poll state
- * @rq: current read work
- * @wq: current write work
- * @wsched: ????
- *
- */
-
-struct p9_conn {
-	struct list_head mux_list;
-	struct p9_client *client;
-	int err;
-	struct list_head req_list;
-	struct list_head unsent_req_list;
-	struct p9_req_t *req;
-	char tmp_buf[7];
-	struct p9_fcall rc;
-	int wpos;
-	int wsize;
-	char *wbuf;
-	struct list_head poll_pending_link;
-	struct p9_poll_wait poll_wait[MAXPOLLWADDR];
-	poll_table pt;
-	struct work_struct rq;
-	struct work_struct wq;
-	unsigned long wsched;
-};
-
-/**
- * struct p9_trans_fd - transport state
- * @rd: reference to file to read from
- * @wr: reference of file to write to
- * @conn: connection state reference
- *
- */
-
-struct p9_trans_fd {
-	struct file *rd;
-	struct file *wr;
-	struct p9_conn conn;
-};
-
-static void p9_poll_workfn(struct work_struct *work);
-
 static DEFINE_SPINLOCK(p9_poll_lock);
 static LIST_HEAD(p9_poll_pending_list);
 static DECLARE_WORK(p9_poll_work, p9_poll_workfn);
@@ -765,7 +658,7 @@ static int parse_opts(char *params, struct p9_fd_opts *opts)
 		int r;
 		if (!*p)
 			continue;
-		token = match_token(p, tokens, args);
+		token = match_token(p, trans_tokens, args);
 		if ((token != Opt_err) && (token != Opt_privport)) {
 			r = match_int(&args[0], &option);
 			if (r < 0) {
-- 
2.11.0
