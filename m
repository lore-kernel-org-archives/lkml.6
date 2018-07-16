Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EACCECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A81208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2KI3fJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A81208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeGPKvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:51:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36882 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeGPKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:51:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id a26-v6so3979537pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFZdqlRGvlNd+Ddj36XHLchaOKtAZgsLsHBaxkEJeFw=;
        b=k2KI3fJuo2K3/TA0hhyg7gF6/iLy63v4h4IUf8NRvhiO4mW943+LIS6DDE56rmeeiS
         xQGcW9FByh/lFxIrdZoDv7Bz55KwIWTIgsjYdeFMl69TCV8zFXAMu6gLMMFRS+FfDVSL
         aUdbWKpHJysVPv+rKoFkskHQ88B/DcMHkplXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFZdqlRGvlNd+Ddj36XHLchaOKtAZgsLsHBaxkEJeFw=;
        b=VEQNe1qZjXe5CTSI7tfTL03ppmecWoLbTswJ0TYD+iv7t+nsuWpRWMpzLcvxtOfWrv
         j31l62wN6Yft/TY5BIOXqX9nieJBiaQA4lezar6EL5zVhYqc0wOSSRrlS9HpCoW5dsFr
         MWEyiIWrxHNa1j5OnDjkxuWGt8pzAE+auWqg8P9ZcB9UoYrFBxM8Arfjp4/vHoOMpieT
         zSQ56zOiLNgbFSX4WrljA/D5gW5wokkkhfPqc4ITOC8n63JrARtH+UgUFaRJ6+miF6Cj
         D+3xMiRjYqZsJXyPQOoRKDWnwlbMaGimVxFuJdhpc3HqdJvt6mjrgY0A30WiFfoupQFA
         Azrw==
X-Gm-Message-State: AOUpUlGEn/JGzNXu5TSLJQp1vtJjl2RfBGDXajwPzfDjCOtSZipDYiDS
        5/geE82LKx9aOJMcvUFjn+WXzg==
X-Google-Smtp-Source: AAOMgpevxoiyzjzgZFGo21+rgDeZvt7T21eWiR02EDjkDwH1NEYwbYHc9T2OHW9ANKhQElQcFkekWg==
X-Received: by 2002:a62:49cf:: with SMTP id r76-v6mr17063936pfi.235.1531736691030;
        Mon, 16 Jul 2018 03:24:51 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17808087pfi.42.2018.07.16.03.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 03:24:50 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 3/6] alpha: Unify the not-implemented system call entry name
Date:   Mon, 16 Jul 2018 15:53:55 +0530
Message-Id: <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

systbl.S contain two types of system call entry name which are
alpha_ni_syscall and sys_ni_syscall. So this patch will unify
the not-implemented system call entry name as alpha_ni_syscall.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/kernel/systbls.S | 320 ++++++++++++++++++++++----------------------
 1 file changed, 161 insertions(+), 159 deletions(-)

diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index fcf2f60..7ef6925 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -7,97 +7,99 @@
 
 #include <asm/unistd.h>
 
+#define sys_ni_syscall alpha_ni_syscall
+
 	.data
 	.align 3
 	.globl sys_call_table
 sys_call_table:
-	.quad alpha_ni_syscall			/* 0 */
+	.quad sys_ni_syscall			/* 0 */
 	.quad sys_exit
 	.quad alpha_fork
 	.quad sys_read
 	.quad sys_write
-	.quad alpha_ni_syscall			/* 5 */
+	.quad sys_ni_syscall			/* 5 */
 	.quad sys_close
 	.quad sys_osf_wait4
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_link
 	.quad sys_unlink			/* 10 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_chdir
 	.quad sys_fchdir
 	.quad sys_mknod
 	.quad sys_chmod				/* 15 */
 	.quad sys_chown
 	.quad sys_osf_brk
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_lseek
 	.quad sys_getxpid			/* 20 */
 	.quad sys_osf_mount
 	.quad sys_umount
 	.quad sys_setuid
 	.quad sys_getxuid
-	.quad alpha_ni_syscall			/* 25 */
+	.quad sys_ni_syscall			/* 25 */
 	.quad sys_ptrace
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 30 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 30 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_access
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 35 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 35 */
 	.quad sys_sync
 	.quad sys_kill
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_setpgid
-	.quad alpha_ni_syscall			/* 40 */
+	.quad sys_ni_syscall			/* 40 */
 	.quad sys_dup
 	.quad sys_alpha_pipe
 	.quad sys_osf_set_program_attributes
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_open				/* 45 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getxgid
 	.quad sys_osf_sigprocmask
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 50 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 50 */
 	.quad sys_acct
 	.quad sys_sigpending
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_ioctl
-	.quad alpha_ni_syscall			/* 55 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall			/* 55 */
+	.quad sys_ni_syscall
 	.quad sys_symlink
 	.quad sys_readlink
 	.quad sys_execve
 	.quad sys_umask				/* 60 */
 	.quad sys_chroot
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getpgrp
 	.quad sys_getpagesize
-	.quad alpha_ni_syscall			/* 65 */
+	.quad sys_ni_syscall			/* 65 */
 	.quad alpha_vfork
 	.quad sys_newstat
 	.quad sys_newlstat
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 70 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 70 */
 	.quad sys_osf_mmap
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_munmap
 	.quad sys_mprotect
 	.quad sys_madvise			/* 75 */
 	.quad sys_vhangup
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getgroups
 	/* map BSD's setpgrp to sys_setpgid for binary compatibility: */
 	.quad sys_setgroups			/* 80 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_setpgid
 	.quad sys_osf_setitimer
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 85 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 85 */
 	.quad sys_osf_getitimer
 	.quad sys_gethostname
 	.quad sys_sethostname
@@ -119,19 +121,19 @@ sys_call_table:
 	.quad sys_bind
 	.quad sys_setsockopt			/* 105 */
 	.quad sys_listen
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 110 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 110 */
 	.quad sys_sigsuspend
 	.quad sys_osf_sigstack
 	.quad sys_recvmsg
 	.quad sys_sendmsg
-	.quad alpha_ni_syscall			/* 115 */
+	.quad sys_ni_syscall			/* 115 */
 	.quad sys_osf_gettimeofday
 	.quad sys_osf_getrusage
 	.quad sys_getsockopt
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_readv			/* 120 */
 	.quad sys_osf_writev
 	.quad sys_osf_settimeofday
@@ -151,66 +153,66 @@ sys_call_table:
 	.quad sys_mkdir
 	.quad sys_rmdir
 	.quad sys_osf_utimes
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 140 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 140 */
 	.quad sys_getpeername
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getrlimit
 	.quad sys_setrlimit			/* 145 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_setsid
 	.quad sys_quotactl
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getsockname			/* 150 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 155 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 155 */
 	.quad sys_osf_sigaction
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_getdirentries
 	.quad sys_osf_statfs			/* 160 */
 	.quad sys_osf_fstatfs
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_getdomainname		/* 165 */
 	.quad sys_setdomainname
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 170 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 175 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 180 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 185 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 190 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 195 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 170 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 175 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 180 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 185 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 190 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 195 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	/* The OSF swapon has two extra arguments, but we ignore them.  */
 	.quad sys_swapon
 	.quad sys_msgctl			/* 200 */
@@ -226,93 +228,93 @@ sys_call_table:
 	.quad sys_shmctl			/* 210 */
 	.quad sys_shmdt
 	.quad sys_shmget
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 215 */
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 215 */
+	.quad sys_ni_syscall
 	.quad sys_msync
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 220 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 220 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_stat
 	.quad sys_osf_lstat			/* 225 */
 	.quad sys_osf_fstat
 	.quad sys_osf_statfs64
 	.quad sys_osf_fstatfs64
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 230 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 230 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_getpgid
 	.quad sys_getsid
 	.quad sys_sigaltstack			/* 235 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 240 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 240 */
 	.quad sys_osf_sysinfo
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_osf_proplist_syscall
-	.quad alpha_ni_syscall			/* 245 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 250 */
+	.quad sys_ni_syscall			/* 245 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 250 */
 	.quad sys_osf_usleep_thread
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 	.quad sys_sysfs
-	.quad alpha_ni_syscall			/* 255 */
+	.quad sys_ni_syscall			/* 255 */
 	.quad sys_osf_getsysinfo
 	.quad sys_osf_setsysinfo
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 260 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 265 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 270 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 275 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 280 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 285 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 290 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall			/* 295 */
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
-	.quad alpha_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 260 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 265 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 270 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 275 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 280 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 285 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 290 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall			/* 295 */
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
+	.quad sys_ni_syscall
 /* linux-specific system calls start at 300 */
 	.quad sys_bdflush			/* 300 */
 	.quad sys_sethae
-- 
2.7.4

