Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B81DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A122150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gFveRUye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A122150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeITCai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41816 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbeITCah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so6029101edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=scu1bFxVDh3KPsOHiZlETrumb5Bby17MXGXfbnfCbqU=;
        b=gFveRUyeyD1arfgw0PQcTyAtbgUJDcF22poqj4MGrBW19fJukRASTWZANFkaZMKmU5
         U2Dl0YZ+wdBr0RlZintmIw57dhuHrwK9HFNxBZhtBsGqFhF0gEDV/kYqM81GTlPd01Q2
         TZbhmqQRmd/A74qY8vMv9CuCVy5yqBtFP/N1pUpqUPRW8i0dJBFv+6jncPVD1XziNQBI
         h85D5e+7Al3aUeK/m25vsqBq5dmmtGuxCuE1doIh7qBf45nCkzUPUiDDn5KWmkCyRES/
         dWhw2ECdmAiCww8ra2ws8qXwKnQH7cINq+uj5L7zwWFJ9x2iuKU3EB5Ys6dv2OqwY2Qw
         U3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scu1bFxVDh3KPsOHiZlETrumb5Bby17MXGXfbnfCbqU=;
        b=rxWSCY+w0G4p7aFmdOi3JfocYDe3egXLzy/N3pQfbiKf8IrWHjbNOJdlo/7jX2surR
         uM54ydfJ3wlish5+Kc1lnbACak/V+NjSGFbz6tL8IZLpxwJL/NsFNDB/oPdFN+4HqX3s
         WaiP96v3isWMHH6xgp9S3IWMou+tPtepWcTAmBjn8b+cLMVituwFI6/cabx+oz65HS6F
         N5X5hsHpE6qNaigOQy3bmJELlGmL3d2KJEHZbBkNg2AniUEptk2BA6wxRhhp0HQ3YSrT
         QmjeevwcSiS9tMWmqgqCVRn+Gmb0VpDsNw7QsPeIcXlG2yRdjdzdqkpW/G6QJjKUMmqp
         kwjw==
X-Gm-Message-State: APzg51DEk6xturHV5oHdyIjyXfg9rziy3V3RQDtm5Yw5d3fH7g03xWoA
        7z18B8WTbtTUhv4Ev11UN/Dq/kPNgS8=
X-Google-Smtp-Source: ANB0VdZc8pYYIWyURNLNd7GAHbZyhXrSw4fkUt4EVGVMFc88RjKUahb1vuPzQpWJc9E4WiTVeTwIig==
X-Received: by 2002:a50:e40d:: with SMTP id d13-v6mr60898848edm.263.1537390255613;
        Wed, 19 Sep 2018 13:50:55 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 11/20] x86/vdso: Purge timens page on setns()/unshare()/clone()
Date:   Wed, 19 Sep 2018 21:50:28 +0100
Message-Id: <20180919205037.9574-12-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Find page with timens offsets on vvar and flush mapping for it during
entering/creating another time namespace.
Prevents application to have stale mapping from old namespace.
(as old namespace might be destroyed on the moment of userspace access,
it also prevents leaks from kernel).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c   | 31 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/vdso.h |  1 +
 kernel/time_namespace.c     | 12 ++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 0f92227a4a7e..90eadcfcb7f5 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
 #include <asm/page.h>
+#include <asm/tlbflush.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -158,6 +159,36 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 	return VM_FAULT_SIGBUS;
 }
 
+static void clear_flush_timens_pte(struct mm_struct *mm, unsigned long addr)
+{
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	if (follow_pte_pmd(mm, addr, NULL, NULL, &ptep, NULL, &ptl))
+		return; /* no pte found */
+	ptep_get_and_clear(mm, addr, ptep);
+	pte_unmap_unlock(ptep, ptl);
+	flush_tlb_mm_range(mm, addr, addr + PAGE_SIZE, VM_NONE);
+}
+
+int vvar_purge_timens(struct task_struct *task)
+{
+	struct mm_struct *mm = task->mm;
+	const struct vdso_image *image;
+	unsigned long addr;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	image = mm->context.vdso_image;
+
+	addr = (unsigned long)mm->context.vdso + image->sym_timens_page;
+	clear_flush_timens_pte(mm, addr);
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+
 static const struct vm_special_mapping vdso_mapping = {
 	.name = "[vdso]",
 	.fault = vdso_fault,
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 619322065b8e..98b02481137c 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -45,6 +45,7 @@ extern const struct vdso_image vdso_image_32;
 extern void __init init_vdso_image(const struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
+extern int vvar_purge_timens(struct task_struct *task);
 
 #endif /* __ASSEMBLER__ */
 
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index f96871cb8124..f88ae0e17d92 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -14,6 +14,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 #include <linux/mm.h>
+#include <asm/vdso.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -91,9 +92,15 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 struct time_namespace *copy_time_ns(unsigned long flags,
 	struct user_namespace *user_ns, struct time_namespace *old_ns)
 {
+	int ret;
+
 	if (!(flags & CLONE_NEWTIME))
 		return get_time_ns(old_ns);
 
+	ret = vvar_purge_timens(current);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return clone_time_ns(user_ns, old_ns);
 }
 
@@ -138,11 +145,16 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int ret;
 
 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	ret = vvar_purge_timens(current);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
-- 
2.13.6

