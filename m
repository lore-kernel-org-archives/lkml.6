Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91136C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5312080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1Kg7Onf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5312080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbeKVGvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:51:45 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:33328 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389115AbeKVGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:51:44 -0500
Received: by mail-io1-f73.google.com with SMTP id u13-v6so6353272iob.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xIMtPBW8a0JPaAEp9wLSnMQUqC2A5vjNXxobCvOXQ3E=;
        b=N1Kg7OnfSXuDOEDZPe9dwII7GqEoo8PVROF/zyTGpDzWwoyv0qCvfuML8wo4JLkN6X
         wg/o5RJwV1uiSn7JLevvz6yT6IRLunmNNgyrIGA490tzYKIJoPgWzaszqDVo906MGgPJ
         gPTCOo1lQnTrDY+8rxY2CF6A1yIRNFzXagGj07ha6bUs7/HYaUklmulx53L57NOpBnRn
         kwAWbOpgFEQOLm0cPCj79kTXvqA3fgZvBe5KhtkxaK/y7zLr8fG+1phyLpQpFcRcFEIj
         NGy77dUUHGumbVgj5Lc91i0/pbPp6S9q/d2nMHMFPjelqk5HrHDorzEZ4P+HpoIe1fgH
         ajJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xIMtPBW8a0JPaAEp9wLSnMQUqC2A5vjNXxobCvOXQ3E=;
        b=bzCN5haIrELDtXdoXyJZk2lQkSrUCtU2b7oy6cnDX3ibDjuXryT3BYIXRTqN54LTxP
         Ktq1w6jWjxuIiFrF17g5Cp1hLW6LO7zCCW4/6PotDYJRSoWm6cprzM6opX5j0IJ4i82K
         xMDWR7AOR6q+/8eAwnjoX0mThDoKirPHz5G1S5z2b0IWJPGgL2hUUEXkQv+sLZZ2TfEU
         ldeIZIlq9BZUg262op8sy6XCM0uzMG7Yh6+o+ccmcCBQ7bEt2NgJzQ53GLYAC869uwN3
         TQ33akOyVHH3Bdnj2cn4cZO8GeVfa6DASoMybs2Uwqy4qIi1et0LuPioPLCHysUY1+mi
         +W5w==
X-Gm-Message-State: AA+aEWZaJEiY96deZKlKn2Juc42atH5YnUgivV6InWEBK436U9JjsgE5
        FFoFZfcOpBVCsO6J4O/unLXs8v0SWQ2AzuZziWcaVILMPwWL87lZT3zK8rn2OC1t0LNhT4V246J
        LhWmIJxR3gUF/bnRdgju/10kuCPKK5rDMo3PoMIjs5XNdDWdR1ieCgQ03RwJjbKWyWUhRoQ==
X-Google-Smtp-Source: AFSGD/Vz5mfdEfE8M906XDadAPhakNipUTOMEDEpWIi7jzu2CTxtsptkrPvgmQ16D9vYN4mkTsM3nBe2+RU=
X-Received: by 2002:a24:2c11:: with SMTP id i17-v6mr5140974iti.21.1542831356162;
 Wed, 21 Nov 2018 12:15:56 -0800 (PST)
Date:   Wed, 21 Nov 2018 12:14:44 -0800
Message-Id: <20181121201452.77173-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH] Add /proc/pid_generation
From:   Daniel Colascione <dancol@google.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     timmurray@google.com, primiano@google.com, joelaf@google.com,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace analysis code needs a coherent picture of the set of processes
and threads running on a system. While it's possible to enumerate all
tasks via /proc, this enumeration is not atomic. If PID numbering
rolls over during snapshot collection, the resulting snapshot of the
process and thread state of the system may be incoherent, confusing
trace analysis tools. The fundamental problem is that if a PID is
reused during a userspace scan of /proc, it's impossible to tell, in
post-processing, whether a fact that the userspace /proc scanner
reports regarding a given PID refers to the old or new task named by
that PID, as the scan of that PID may or may not have occurred before
the PID reuse, and there's no way to "stamp" a fact read from the
kernel with a trace timestamp.

This change adds a per-pid-namespace 64-bit generation number,
incremented on PID rollover, and exposes it via a new proc file
/proc/pid_generation. By examining this file before and after /proc
enumeration, user code can detect the potential reuse of a PID and
restart the task enumeration process, repeating until it gets a
coherent snapshot.

PID rollover ought to be rare, so in practice, scan repetitions will
be rare.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 Documentation/filesystems/proc.txt |  1 +
 include/linux/pid.h                |  1 +
 include/linux/pid_namespace.h      |  2 ++
 init/main.c                        |  1 +
 kernel/pid.c                       | 36 +++++++++++++++++++++++++++++-
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 12a5e6e693b6..f58a359f9a2c 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -615,6 +615,7 @@ Table 1-5: Kernel info in /proc
  partitions  Table of partitions known to the system           
  pci	     Deprecated info of PCI bus (new way -> /proc/bus/pci/,
              decoupled by lspci					(2.4)
+ pid_gen     PID rollover count
  rtc         Real time clock                                   
  scsi        SCSI info (see text)                              
  slabinfo    Slab pool info                                    
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 14a9a39da9c7..2e4b41a32e86 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -112,6 +112,7 @@ extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
 int next_pidmap(struct pid_namespace *pid_ns, unsigned int last);
 
 extern struct pid *alloc_pid(struct pid_namespace *ns);
+extern u64 read_pid_generation(struct pid_namespace *ns);
 extern void free_pid(struct pid *pid);
 extern void disable_pid_allocation(struct pid_namespace *ns);
 
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 49538b172483..fa92ae66fb98 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -44,6 +44,7 @@ struct pid_namespace {
 	kgid_t pid_gid;
 	int hide_pid;
 	int reboot;	/* group exit code if this pidns was rebooted */
+	u64 generation;  /* incremented on wraparound */
 	struct ns_common ns;
 } __randomize_layout;
 
@@ -99,5 +100,6 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
 void pidhash_init(void);
 void pid_idr_init(void);
+void pid_proc_init(void);
 
 #endif /* _LINUX_PID_NS_H */
diff --git a/init/main.c b/init/main.c
index ee147103ba1b..20c595e852c6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -730,6 +730,7 @@ asmlinkage __visible void __init start_kernel(void)
 	cgroup_init();
 	taskstats_init_early();
 	delayacct_init();
+	pid_proc_init();
 
 	check_bugs();
 
diff --git a/kernel/pid.c b/kernel/pid.c
index b2f6c506035d..cd5f4aa8eb55 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -174,6 +174,7 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 
 	for (i = ns->level; i >= 0; i--) {
 		int pid_min = 1;
+		unsigned int old_cursor;
 
 		idr_preload(GFP_KERNEL);
 		spin_lock_irq(&pidmap_lock);
@@ -182,7 +183,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 		 * init really needs pid 1, but after reaching the maximum
 		 * wrap back to RESERVED_PIDS
 		 */
-		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
+		old_cursor = idr_get_cursor(&tmp->idr);
+		if (old_cursor > RESERVED_PIDS)
 			pid_min = RESERVED_PIDS;
 
 		/*
@@ -191,6 +193,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 		 */
 		nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
 				      pid_max, GFP_ATOMIC);
+		if (unlikely(idr_get_cursor(&tmp->idr) <= old_cursor))
+			tmp->generation += 1;
 		spin_unlock_irq(&pidmap_lock);
 		idr_preload_end();
 
@@ -246,6 +250,16 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 	return ERR_PTR(retval);
 }
 
+u64 read_pid_generation(struct pid_namespace *ns)
+{
+	u64 generation;
+
+	spin_lock_irq(&pidmap_lock);
+	generation = ns->generation;
+	spin_unlock_irq(&pidmap_lock);
+	return generation;
+}
+
 void disable_pid_allocation(struct pid_namespace *ns)
 {
 	spin_lock_irq(&pidmap_lock);
@@ -449,6 +463,17 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 	return idr_get_next(&ns->idr, &nr);
 }
 
+#ifdef CONFIG_PROC_FS
+static int pid_generation_show(struct seq_file *m, void *v)
+{
+	u64 generation =
+		read_pid_generation(proc_pid_ns(file_inode(m->file)));
+	seq_printf(m, "%llu\n", generation);
+	return 0;
+
+};
+#endif
+
 void __init pid_idr_init(void)
 {
 	/* Verify no one has done anything silly: */
@@ -465,4 +490,13 @@ void __init pid_idr_init(void)
 
 	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+
+}
+
+void __init pid_proc_init(void)
+{
+	/* pid_idr_init is too early, so get a separate init function. */
+#ifdef CONFIG_PROC_FS
+	WARN_ON(!proc_create_single("pid_gen", 0, NULL, pid_generation_show));
+#endif
 }
-- 
2.19.1.1215.g8438c0b245-goog

