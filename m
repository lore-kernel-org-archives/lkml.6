Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeCIW34 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:29:56 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34446 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932810AbeCIW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:29:52 -0500
X-Google-Smtp-Source: AG47ELv2mZ4vST4LOn9fga0lPx8tehSl2FwTCYq1GIengKko552KF5lU394mYcNesFugqmLWC2Pl5Q==
Date: Sat, 10 Mar 2018 01:29:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: faster /proc/cmdline
Message-ID: <20180309222948.GB3843@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use seq_puts() and skip format string processing.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/cmdline.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/proc/cmdline.c
+++ b/fs/proc/cmdline.c
@@ -6,7 +6,8 @@
 
 static int cmdline_proc_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "%s\n", saved_command_line);
+	seq_puts(m, saved_command_line);
+	seq_putc(m, '\n');
 	return 0;
 }
 
