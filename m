Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DB4206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCmQVILj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfANUFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:05:50 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:54829 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfANUFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:05:50 -0500
Received: by mail-wm1-f49.google.com with SMTP id a62so937424wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=juHERBI2Pyr9Z+AdMxWULwvXR5fu0+7WgdHqG8oVV4Q=;
        b=rCmQVILjlk+ldQdiMbF4o6XISCwqficcBWJ3tRrx5EMkYo1OJG1wRnorx+vlxQjy0x
         iovHVfeSIT/BwsPpTPxvEkIYyLSIIHa+6UTt3mEVV5NVSU6Ukc3Z01yjV4wlTfulzCZM
         oTN6dmZSV+VDiHECM9wgUPeS6BTf5Lc89wIJ3N8UolHYO+sccDQ608aBZbpszB7zItGj
         ANw3emZOveG/q6txX/gIdUYdQPB3zYoNvd1QSyalgByFuQMJkKxG8BcJvvea+zRRtnVU
         uupJlmkqLff4lRq09yMTlUNXzl0am3MlgTSCFn0VJDUkpzOcc0/Blq+USOOmkjgb2q8c
         +lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=juHERBI2Pyr9Z+AdMxWULwvXR5fu0+7WgdHqG8oVV4Q=;
        b=CKraKn165jJpxGgvEHx//eoJ89yr42hzi/2wt4g0CUfPw3ANVDLreAIhwxITQfJwM2
         tAR8tqf0Qc1Y2XsihDQLR3Pm0pl2u2ujiiAAacOi+rGE55RtPgb2bRRKx8h+VeDAxAIB
         hPGgvmXDZ7aSaFPaKRivLUWCA+YUb/U3ZYwL8H50l2x5LAEzfDcj6U5ocWAvT1Kw4Jpt
         lUQepoRndEnDDXexwirEjfScH9YktALksc27lAr8/tbZEHDtrfnRFqBJuNPqHCV6qK5k
         gDXfPdCHFVtpLoioiwraR3AEab2Iicpwn3xaNOVLw/4MYtF+WkgEGQJin6p0REypTe41
         l0uw==
X-Gm-Message-State: AJcUukc/8fNNaeVt47OFF8mKKcEtfPqYvYiFtRsd+VB2gVq/Yg5d1bzT
        5jXQCMw6GBDbgQCgD2jZdo0AykQ=
X-Google-Smtp-Source: ALg8bN7iUMSoG247s+k8oALIjUVHXs4dMHFuiYWBL1u2jm9jv1J4ihIyuctyENzJYkAZW8ssSworQA==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr626657wmf.8.1547496348122;
        Mon, 14 Jan 2019 12:05:48 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id k19sm105272313wre.5.2019.01.14.12.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:05:47 -0800 (PST)
Date:   Mon, 14 Jan 2019 23:05:45 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use seq_puts() everywhere
Message-ID: <20190114200545.GC9680@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_printf() without format specifiers == faster seq_puts()

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/array.c      |   16 ++++++++--------
 fs/proc/base.c       |    2 +-
 fs/proc/task_nommu.c |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -343,28 +343,28 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
+	seq_puts(m, "\nSpeculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
-		seq_printf(m, "unknown");
+		seq_puts(m, "unknown");
 		break;
 	case PR_SPEC_NOT_AFFECTED:
-		seq_printf(m, "not vulnerable");
+		seq_puts(m, "not vulnerable");
 		break;
 	case PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE:
-		seq_printf(m, "thread force mitigated");
+		seq_puts(m, "thread force mitigated");
 		break;
 	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
-		seq_printf(m, "thread mitigated");
+		seq_puts(m, "thread mitigated");
 		break;
 	case PR_SPEC_PRCTL | PR_SPEC_ENABLE:
-		seq_printf(m, "thread vulnerable");
+		seq_puts(m, "thread vulnerable");
 		break;
 	case PR_SPEC_DISABLE:
-		seq_printf(m, "globally mitigated");
+		seq_puts(m, "globally mitigated");
 		break;
 	default:
-		seq_printf(m, "vulnerable");
+		seq_puts(m, "vulnerable");
 		break;
 	}
 	seq_putc(m, '\n');
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -456,7 +456,7 @@ static int proc_pid_schedstat(struct seq_file *m, struct pid_namespace *ns,
 			      struct pid *pid, struct task_struct *task)
 {
 	if (unlikely(!sched_info_on()))
-		seq_printf(m, "0 0 0\n");
+		seq_puts(m, "0 0 0\n");
 	else
 		seq_printf(m, "%llu %llu %lu\n",
 		   (unsigned long long)task->se.sum_exec_runtime,
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -178,7 +178,7 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 		seq_file_path(m, file, "");
 	} else if (mm && is_stack(vma)) {
 		seq_pad(m, ' ');
-		seq_printf(m, "[stack]");
+		seq_puts(m, "[stack]");
 	}
 
 	seq_putc(m, '\n');
