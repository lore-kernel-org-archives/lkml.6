Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832757-2-7595089833580942724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521832756; b=oIOaSHkEt6yStM30Nwez/hq7Bb6996FEcWdnsbsvJB4pkYu
    WLVMkD6evWgRqO4ZQHUX7xvUvoETg5k/YtaK7tFDoCggIdUFhfZALHGnp7gV+/WV
    ohSGxidv3sLeyo7vEGj9oZ6SigJWo3I3D0voTkvvybGSqSu+5wdWc8aMHUaywjUZ
    L1w1xLJBUwCsvbm1yO6hM0VBGp5UJv4wvq6yP6EFj6PSmZyqOHl4PlLoUbts5n0Z
    3a4/+GF3fS8KCh21dAoOucIpbHNvMbsGCg6AF9AGYvTKWQaa4O/t3M2ciARxPnem
    d30l+TLLrQJhaEv+PPokhOETH1jfxbErRabHwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832756; bh=
    uLXobIc/jdWN0JquWeZkiS6Nifly4d4CwfUDGqn5C5o=; b=DKOZADuP3dKSQ+Sy
    P+P9Toxp9BgmcABFqsyTnbb7gy8vtGy5m4xNYPIORNsUSWYBuxcOWY0aLWRHtHRJ
    +SN/XL/ZPsiMZu6vsVjQIck2moEg3o+Z30L5wuWZofqLPcnFp+lqpOySz3LzEivx
    F0vOejCab/HVJ0RgaMXxS8PCIgMJhG6BMhj0/vmhTacjvt5ecNBfxzGuNjV53CnL
    qcjKGHEubgkFJjcAUVJpD2c6REIb/oJEORkgweBmu7ipIXelZEIwj6J+OOrlEU9j
    0KLpQHlThV0hG6wpmq8fHJ4hkUFqIP636BtHxwqUw696YaBB5slpEf/da/dsk4Ld
    WJyAEw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeCWTS7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:18:59 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50646 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeCWTSM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:18:12 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 23 Mar 2018 14:16:11 -0500
Message-Id: <20180323191614.32489-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCY-00033I-9W;;;mid=<20180323191614.32489-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/8obNEmDIE/UTYDZWfwPis/hNPbcStVXU=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ***
X-Remote-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 300 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (0.9%), b_tie_ro: 1.95 (0.6%), parse: 1.10 (0.4%),
        extract_message_metadata: 12 (4.1%), get_uri_detail_list: 2.3 (0.8%),
        tests_pri_-1000: 5 (1.8%), tests_pri_-950: 1.13 (0.4%), tests_pri_-900: 0.98
        (0.3%), tests_pri_-400: 25 (8.2%), check_bayes: 24 (7.8%), b_tokenize: 9
        (2.9%), b_tok_get_all: 8 (2.6%), b_comp_prob: 2.5 (0.8%), b_tok_touch_all:
        2.6 (0.9%), b_finish: 0.65 (0.2%), tests_pri_0: 245 (81.8%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 2.5 (0.8%),
        tests_pri_500: 3.5 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 08/11] ipc/util: Helpers for making the sysvipc operations pid namespace aware
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Capture the pid namespace when /proc/sysvipc/msg /proc/sysvipc/shm
and /proc/sysvipc/sem are opened, and make it available through
the new helper ipc_seq_pid_ns.

This makes it possible to report the pids in these files in the
pid namespace of the opener of the files.

Implement ipc_update_pid.  A simple impline helper that will only update
a struct pid pointer if the new value does not equal the old value.  This
removes the need for wordy code sequences like:

	old = object->pid;
	object->pid = new;
	put_pid(old);

and

	old = object->pid;
	if (old != new) {
		object->pid = new;
		put_pid(old);
	}

Allowing the following to be written instead:

	ipc_update_pid(&object->pid, new);

Which is easier to read and ensures that the pid reference count is
not touched the old and the new values are the same.  Not touching
the reference count in this case is important to help avoid issues
like af_unix experienced, where multiple threads of the same
process managed to bounce the struct pid between cpu cache lines,
but updating the pids reference count.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 ipc/util.c |  9 +++++++++
 ipc/util.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/ipc/util.c b/ipc/util.c
index 4ed5a17dd06f..3783b7991cc7 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -747,9 +747,16 @@ int ipc_parse_version(int *cmd)
 #ifdef CONFIG_PROC_FS
 struct ipc_proc_iter {
 	struct ipc_namespace *ns;
+	struct pid_namespace *pid_ns;
 	struct ipc_proc_iface *iface;
 };
 
+struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
+{
+	struct ipc_proc_iter *iter = s->private;
+	return iter->pid_ns;
+}
+
 /*
  * This routine locks the ipc structure found at least at position pos.
  */
@@ -872,6 +879,7 @@ static int sysvipc_proc_open(struct inode *inode, struct file *file)
 
 	iter->iface = PDE_DATA(inode);
 	iter->ns    = get_ipc_ns(current->nsproxy->ipc_ns);
+	iter->pid_ns = get_pid_ns(task_active_pid_ns(current));
 
 	return 0;
 }
@@ -881,6 +889,7 @@ static int sysvipc_proc_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct ipc_proc_iter *iter = seq->private;
 	put_ipc_ns(iter->ns);
+	put_pid_ns(iter->pid_ns);
 	return seq_release_private(inode, file);
 }
 
diff --git a/ipc/util.h b/ipc/util.h
index 959c10eb9cc1..e39ed9705f99 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -23,6 +23,7 @@ int msg_init(void);
 void shm_init(void);
 
 struct ipc_namespace;
+struct pid_namespace;
 
 #ifdef CONFIG_POSIX_MQUEUE
 extern void mq_clear_sbinfo(struct ipc_namespace *ns);
@@ -86,6 +87,7 @@ int ipc_init_ids(struct ipc_ids *);
 #ifdef CONFIG_PROC_FS
 void __init ipc_init_proc_interface(const char *path, const char *header,
 		int ids, int (*show)(struct seq_file *, void *));
+struct pid_namespace *ipc_seq_pid_ns(struct seq_file *);
 #else
 #define ipc_init_proc_interface(path, header, ids, show) do {} while (0)
 #endif
@@ -150,6 +152,15 @@ struct kern_ipc_perm *ipcctl_pre_down_nolock(struct ipc_namespace *ns,
 					     struct ipc_ids *ids, int id, int cmd,
 					     struct ipc64_perm *perm, int extra_perm);
 
+static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
+{
+	struct pid *old = *pos;
+	if (old != pid) {
+		*pos = get_pid(pid);
+		put_pid(old);
+	}
+}
+
 #ifndef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
 /* On IA-64, we always use the "64-bit version" of the IPC structures.  */
 # define ipc_parse_version(cmd)	IPC_64
-- 
2.14.1

