Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3794194-1519933916-2-15165324150021745972
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519933915; b=TpQ7QCbUYnMy/zKGpWdljuhBJKfUzciWYNryzsF/4mztNfr
    jH8WOkp5wOGaOSYVrhycFW5rjqF3pXb9/AsNyJqoFqUT1bSsxovHQB6vCeQI6Ouy
    7UPUqzj17sv2pBjejvcyQxnJmT75lT7DYe4NSYBqN5FprnEP60+ZzDNoEtsI/Dkk
    rd1+yb9gU1eV10AB7vUFSqoYz1Yp7UGxktxFqztmT+42FFGZSP2+7Ki+0vkq5JZK
    epxFaQRYPF7DG+dyfazuJS8mMik9rx3ODVnvEvlDCO2p8JXvxIWsPLwyX5pm51Uf
    vl6T/8571gFHZjz/pRw6e2Dg19ruWcKtr23KV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933915; bh=IgjiuwWA/FpBdR3YMQ/pYfFTRUH5e+qLx3r
    whVnaFF8=; b=SNekNa9q2f2vi595ai03rA8jCJpmqdzkteLvijFa0smClIXls7m
    KE6yr3Rh7+Xzit8QCGTI7oh3cX3kmdoCEl/6UImUIzttzOSg9Ob+EDK92DmgryWb
    eKTXVNo9xWcCfGuhI9zso4pEvbmriy21UO5F63RFecIze/L04bvQMvR1tp2LjZXV
    hgQ/BAA+pkW0rjc0Kx16P75CYtCiB5Tl2tAcYg72QUbyRDeTW8Kj4Rifv9uYtrvV
    Ri9bpB8SS258NOdv1hJLI/83Envj9OdI0Np67UjdeTm8XzJJ1rRMpLTwtJccAlqv
    RDqIQabWppx8BlaawKjyaMipLB8pbntq0eA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161433AbeCATqb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:46:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033234AbeCATqZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:46:25 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: mszeredi@redhat.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, trondmy@primarydata.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com, madzcar@gmail.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH V1 02/12] audit: log container info of syscalls
Date: Thu,  1 Mar 2018 14:41:05 -0500
Message-Id: <db19aa79f3350247462ce8c46493f839b497a989.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Create a new audit record AUDIT_CONTAINER_INFO to document the container
ID of a process if it is present.

Called from audit_log_exit(), syscalls are covered.

A sample raw event:
type=SYSCALL msg=audit(1519924845.499:257): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=56374e1cef30 a2=241 a3=1b6 items=2 ppid=606 pid=635 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="bash" exe="/usr/bin/bash" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="tmpcontainerid"
type=CWD msg=audit(1519924845.499:257): cwd="/root"
type=PATH msg=audit(1519924845.499:257): item=0 name="/tmp/" inode=13863 dev=00:27 mode=041777 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype= PARENT cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
type=PATH msg=audit(1519924845.499:257): item=1 name="/tmp/tmpcontainerid" inode=17729 dev=00:27 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
type=PROCTITLE msg=audit(1519924845.499:257): proctitle=62617368002D6300736C65657020313B206563686F2074657374203E202F746D702F746D70636F6E7461696E65726964
type=UNKNOWN[1332] msg=audit(1519924845.499:257): op=task contid=123458

See: https://github.com/linux-audit/audit-kernel/issues/32
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h      |  5 +++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 20 ++++++++++++++++++++
 kernel/auditsc.c           |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index fe4ba3f..3acbe9d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -154,6 +154,8 @@ extern void		    audit_log_link_denied(const char *operation,
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab,
 				struct task_struct *tsk);
+extern int audit_log_container_info(struct task_struct *tsk,
+				     struct audit_context *context);
 
 extern int		    audit_update_lsm_rules(void);
 
@@ -205,6 +207,9 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 static inline void audit_log_task_info(struct audit_buffer *ab,
 				       struct task_struct *tsk)
 { }
+static inline int audit_log_container_info(struct task_struct *tsk,
+					    struct audit_context *context);
+{ }
 #define audit_enabled 0
 #endif /* CONFIG_AUDIT */
 
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 921a71f..e83ccbd 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -115,6 +115,7 @@
 #define AUDIT_REPLACE		1329	/* Replace auditd if this packet unanswerd */
 #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
+#define AUDIT_CONTAINER_INFO	1332	/* Container ID information */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/audit.c b/kernel/audit.c
index 5c25449..8dc745f 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1996,6 +1996,26 @@ void audit_log_session_info(struct audit_buffer *ab)
 	audit_log_format(ab, " auid=%u ses=%u", auid, sessionid);
 }
 
+/*
+ * audit_log_container_info - report container info
+ * @tsk: task to be recorded
+ * @context: task or local context for record
+ */
+int audit_log_container_info(struct task_struct *tsk, struct audit_context *context)
+{
+	struct audit_buffer *ab;
+
+	if (!audit_containerid_set(tsk))
+		return 0;
+	/* Generate AUDIT_CONTAINER_INFO with container ID */
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER_INFO);
+	if (!ab)
+		return -ENOMEM;
+	audit_log_format(ab, "contid=%llu", audit_get_containerid(tsk));
+	audit_log_end(ab);
+	return 0;
+}
+
 void audit_log_key(struct audit_buffer *ab, char *key)
 {
 	audit_log_format(ab, " key=");
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0ee1e59..f015c25 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1453,6 +1453,8 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
 
 	audit_log_proctitle(tsk, context);
 
+	audit_log_container_info(tsk, context);
+
 	/* Send end of event record to help user space know we are finished */
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
 	if (ab)
-- 
1.8.3.1

