Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031221AbeBPQRm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:17:42 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51931 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031162AbeBPQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:17:36 -0500
X-Google-Smtp-Source: AH8x225gIL4Vu8POcDCDno8gB0WmBCLuX8ASjgDga5TOFBONL8pDr+jdIsrRLvhlRGezZ10suj8zcg==
Date: Fri, 16 Feb 2018 19:17:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: move /proc/sysvipc creation to where it belongs
Message-ID: <20180216161732.GA10297@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/root.c |    4 ----
 ipc/util.c     |    1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -136,10 +136,6 @@ void __init proc_root_init(void)
 	proc_symlink("mounts", NULL, "self/mounts");
 
 	proc_net_init();
-
-#ifdef CONFIG_SYSVIPC
-	proc_mkdir("sysvipc", NULL);
-#endif
 	proc_mkdir("fs", NULL);
 	proc_mkdir("driver", NULL);
 	proc_create_mount_point("fs/nfsd"); /* somewhere for the nfsd filesystem to be mounted */
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -89,6 +89,7 @@ static int __init ipc_init(void)
 {
 	int err_sem, err_msg;
 
+	proc_mkdir("sysvipc", NULL);
 	err_sem = sem_init();
 	WARN(err_sem, "ipc: sysv sem_init failed: %d\n", err_sem);
 	err_msg = msg_init();
