Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AA7C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ECF21726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaegSKSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfAUQpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:45:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbfAUQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:45:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so11461323wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 08:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpb3TdNzivvPpafuEo3Wjtiu9ELYuWvt1CuuE83rj60=;
        b=vaegSKSInY8vX8tPA6p7wW+AMxCZGBKc27lm4974pHlDE6346Cm6yMB7FIjodDlanm
         cz5xToNMlOb9TlEXVf8V+A7O1e+lztOyTyovMLtKWLH7MvpN2zs5Iuy2vZmLm8vt4r6R
         l1JsclT1r6Bmz5/nly4mxfe23jPn3W7Fk5EnfnfL1Cp0B2aSTDrC+wsWv8tCkNL7+8Lr
         lPSZfFlRCaV+rPThe6YqHTPYo5oLDTfjhMtWcERqOFHbf3/ulIccX0LZMsjnLJHzmSyY
         9wYx3tiW+njN4YUNPGCHnS5AJrSr1//ei04BB2h5fEQOvfBqfYRVAW5oItpHR+XhBtDk
         WNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpb3TdNzivvPpafuEo3Wjtiu9ELYuWvt1CuuE83rj60=;
        b=q25Hyog5St7L60aot3lUf+z5Cp/pU0ms+N1aem/zf6BTCfjgxmctxldBskzBnrVNu7
         Zq6j+vj7OCn4NTUIlyLX1uy5VEINXtaP6nMjLyeeHttHJA0m5Ma582l+62OooASUqKWo
         ObnfMGQBcyFSUTrrghxIhZ2cBCFHJ/lclV9nbtPHMAopu2DvGUZ2mm4o2cQnjIB+hv03
         WNtEHwkHgj5qvmn2Em9ukjO4t81uWe+IjKP0lk+fr/TTGlgk6Fl2gYGq+1wGjDs6k1yS
         stUqGWMaqpXxcwQC77h2y2Ydb+8xsSTdA01GjHJs0fEQFgzgpS+b/FwELzw8iF+2qfmK
         t+TA==
X-Gm-Message-State: AJcUukfW6tChoFSgYhbjI0KUcCV3MIa8x7+D0ev97xUXSd9/29EsqLy9
        I9Cbn2es7Ko8/oEYTp4QYXA=
X-Google-Smtp-Source: ALg8bN5uXxjPq4xakjC/s8SHp17ryXBYbrdnuHIgW+dqv5GcmmP223O/TUxtBkYOy0+tFOqWR+p28Q==
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr140446wmf.85.1548089118561;
        Mon, 21 Jan 2019 08:45:18 -0800 (PST)
Received: from localhost.localdomain (148.45.16.95.dynamic.jazztel.es. [95.16.45.148])
        by smtp.gmail.com with ESMTPSA id o3sm73806473wrs.30.2019.01.21.08.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 08:45:17 -0800 (PST)
From:   Albert Vaca Cintora <albertvaka@gmail.com>
To:     jack@suse.cz, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        nsaenzjulienne@suse.de
Cc:     Albert Vaca Cintora <albertvaka@gmail.com>
Subject: [PATCH 1/1] kernel/ucounts: expose current inotify watch count
Date:   Mon, 21 Jan 2019 17:45:11 +0100
Message-Id: <20190121164511.10822-2-albertvaka@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121164511.10822-1-albertvaka@gmail.com>
References: <20190121164511.10822-1-albertvaka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
The handler for this entry is a custom function that ends calling
proc_dointvec.

Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
---
 kernel/ucount.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index f48d1b6376a4..afa3b89e3373 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -57,6 +57,11 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };

+#ifdef CONFIG_INOTIFY_USER
+int proc_read_inotify_watches(struct ctl_table *table, int write,
+		     void __user *buffer, size_t *lenp, loff_t *ppos);
+#endif
+
 static int zero = 0;
 static int int_max = INT_MAX;
 #define UCOUNT_ENTRY(name)				\
@@ -79,6 +84,12 @@ static struct ctl_table user_table[] = {
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
+	{
+		.procname	= "current_inotify_watches",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_read_inotify_watches,
+	},
 #endif
 	{ }
 };
@@ -226,6 +237,24 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 	put_ucounts(ucounts);
 }

+#ifdef CONFIG_INOTIFY_USER
+int proc_read_inotify_watches(struct ctl_table *table, int write,
+		     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ucounts *ucounts;
+	struct ctl_table fake_table;
+	int count;
+
+	ucounts = get_ucounts(current_user_ns(), current_euid());
+	count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
+	put_ucounts(ucounts);
+
+	fake_table.data = &count;
+	fake_table.maxlen = sizeof(count);
+	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
+}
+#endif
+
 static __init int user_namespace_sysctl_init(void)
 {
 #ifdef CONFIG_SYSCTL
--
2.20.1

