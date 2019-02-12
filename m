Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD66C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA62190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDMlVK15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfBLSLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:11:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46104 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfBLSLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:11:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so1647121pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H3EZ/k5eiFC2++zTp5N9yx8Otatv/oYuG+NtBDOrENM=;
        b=NDMlVK15avwTx8RDzfhY98wKBKk/ztrvpzrarPvlz0KpiaJsQv7YEnTCzKEteHy8+B
         oWPyffDHxFjvgQYKPeWztEeycgdCySUOaEij+5+gt4Prp/ia07vqLXtxDKW7Kh1fXPFa
         j2IgpHuZ1EqfWmFNtEx49WWHt03zt8e6qdWD93caNzZIzOKnSxuA4dbQYS00NOWffiCA
         5UPlB+2KfKGeZ4LXlleH8+7ApIueAMAcTKY0JFDMEWV5+EJSJYLF95XCIsTGbJiOYDF5
         Yh/gCtmWRWyJ3h18v3rQhagy3cY/xTAXnUzETCtjEXorNC+sHS3wCujif0JO99CWFFmH
         KmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H3EZ/k5eiFC2++zTp5N9yx8Otatv/oYuG+NtBDOrENM=;
        b=sP+m3cJENkd2osiIe2cJY5/vD425TKxY+WCEikrh+byujwlc+Fd60/2T5G6GkbXguI
         LSnkjLCU5IxPatMOkwFNfS/MbpMz5e2rnwv86ibA0/wVu8RQXvU+yLJD2o1vPPLMwzDi
         nIGVa22GRtMCnkhICPf1QxsPCYzbGIJCuxmCHS5hvOWia6YPGeWysNs+4YlXVmdoxBWX
         5oFUAk58Z5Hd6iQ7dGmjx7/MRElARe2vwhXQKc9GjnJvBT6X7PHOgKx+l41oz/8YjARo
         zQg/cAagUus0b65yVmESCUfVqlkVle93PNN1+eJTkk58iPSOvUQdg+s1lnGCaUKP9jB4
         /bhg==
X-Gm-Message-State: AHQUAuYLlK9xqoQSfDMK/UY1tl6aDKLQGmx7IJbKeIszSevC86HJmV7A
        wIy7wPdSeufaeS8+RhBlJKg=
X-Google-Smtp-Source: AHgI3Ia5tSS2jObDCcKuxh2ToolBYEJnRENAlX3GISMDC8ARkMoD4X5Ho15ylCb5TgoVme3cy6Ve8A==
X-Received: by 2002:a63:2ad4:: with SMTP id q203mr4860732pgq.43.1549995074739;
        Tue, 12 Feb 2019 10:11:14 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id n11sm908486pff.32.2019.02.12.10.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 10:11:14 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Date:   Wed, 13 Feb 2019 02:11:05 +0800
Message-Id: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because log may already add the timestamp sometime

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 include/linux/kern_levels.h | 2 ++
 include/linux/printk.h      | 1 +
 kernel/printk/printk.c      | 7 ++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index d237fe8..ed2aec6 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -23,6 +23,8 @@
  */
 #define KERN_CONT	KERN_SOH "c"
 
+#define KERN_NOTIME	KERN_SOH "t"	/* don't print the timestamp */
+
 /* integer equivalents of KERN_<LEVEL> */
 #define LOGLEVEL_SCHED		-2	/* Deferred messages from sched code
 					 * are set to this special level */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a5..be12ac4 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -20,6 +20,7 @@ static inline int printk_get_level(const char *buffer)
 		case '0' ... '7':
 		case 'd':	/* KERN_DEFAULT */
 		case 'c':	/* KERN_CONT */
+		case 't':	/* KERN_NOTIME */
 			return buffer[1];
 		}
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d1703..0688cf2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -346,6 +346,7 @@ enum log_flags {
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
 	LOG_PREFIX	= 4,	/* text started with a prefix */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
+	LOG_NOTIME	= 16,	/* don't print the timestamp */
 };
 
 struct printk_log {
@@ -1247,7 +1248,7 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 
 	if (syslog)
 		len = print_syslog((msg->facility << 3) | msg->level, buf);
-	if (time)
+	if (time && !(msg->flags & LOG_NOTIME))
 		len += print_time(msg->ts_nsec, buf + len);
 	return len;
 }
@@ -1873,6 +1874,10 @@ int vprintk_store(int facility, int level,
 				break;
 			case 'c':	/* KERN_CONT */
 				lflags |= LOG_CONT;
+				break;
+			case 't':	/* KERN_NOTIME */
+				lflags |= LOG_NOTIME;
+				break;
 			}
 
 			text_len -= 2;
-- 
2.7.4

