Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8986AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55895218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSrsw3DR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfBAUmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:42:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44432 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfBAUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:42:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so8449261wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRp7GW2R1eHUEaYduVkGymg4xCQV+n+a45Fdf0/7cJ4=;
        b=iSrsw3DR94BDEHNtYKWj8GE8H2GAk2C3RPGkMF6e9xc/oicXZsVyHkx8ukZxWfqjXU
         FzGUKMoxLreMRsM5zd59ZQX1rxbPOAsWszEtRVh5pYmnPd8vgB70/FL42tRdvn9h9xgh
         yYyYLOz7OG4ViZaHcCdN6oM8HplEkuEjYJuCp6+rqpqui2ihZHHE4LRn1YmZ4r4WAog6
         gb8tVyFbS9v7mI6duAFMVDYOB2HCspMZP8nGswh/H5bd2vRrs8tlD5DIOca2vhISU8iV
         pyfYBl/sNkEw2NbH6kwnMUIURgSHyU2oRdqlhlB9zJZptl8i4BoyJ4br0Djs7heRRgb8
         vdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRp7GW2R1eHUEaYduVkGymg4xCQV+n+a45Fdf0/7cJ4=;
        b=RCbSojJyTQV6uBA2Nm/+8SVh69F4uMIIQnSq5Ux1BQ9pfkHY7sxJaOBa26t16I+zYK
         mpYn/Yc2t3Hgip5elh48fEzy399WdgbHV9tyCxp1K6sVHB7NlsBrbxEmyUaJJWNA+NVA
         DTbMuX4Qcp3gRjB0kdjAbG3awJjSuVWjGLIzMpOOKLmKgVBaiZ/p8Nn+5G+Y6VZ3hQtv
         qAsBs7tI9vakxhvK1vFPllTIs5TLtDL1av1xAq3M5ClcGXmsR5pETCQjPMhxFnoTiwKu
         NURzLlDVYgznjGKfkpoWhfeJsKIy6/mH4NkVBmK4xfVGl/T9019AzFyUnetvwINNpR8B
         KFBQ==
X-Gm-Message-State: AJcUukfULeF8mJtWfx3GaFVU8eDA+OtYcBOPdD49qLarT/u1eCeteVit
        sSjLbpSxXGtwvIy2GIhTOmc=
X-Google-Smtp-Source: ALg8bN7Whxm8i3uc9fMYJMPZABS57Xw6mW3oghCAPaKhNPlDa4XQW+ScngngOdKINISl+KNKBsRIlQ==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr38611858wru.270.1549053739869;
        Fri, 01 Feb 2019 12:42:19 -0800 (PST)
Received: from localhost.localdomain (159.77.223.87.dynamic.jazztel.es. [87.223.77.159])
        by smtp.gmail.com with ESMTPSA id h135sm3234353wmd.21.2019.02.01.12.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 12:42:19 -0800 (PST)
From:   Albert Vaca Cintora <albertvaka@gmail.com>
To:     albertvaka@gmail.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, mingo@kernel.org, jack@suse.cz,
        ebiederm@xmission.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel/ucounts: expose count of inotify watches in use
Date:   Fri,  1 Feb 2019 21:39:59 +0100
Message-Id: <20190201203959.10050-1-albertvaka@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
The handler for this entry is a custom function that ends up calling
proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
and it gets mounted under /proc/sys/user/.

Inotify watches are a finite resource, in a similar way to available file
descriptors. The motivation for this patch is to be able to set up
monitoring and alerting before an application starts failing because
it runs out of inotify watches.

Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/ucount.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index f48d1b6376a4..d8b11e53f098 100644
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

