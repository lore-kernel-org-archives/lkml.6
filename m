Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021415-2-11784345751561379187
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021415; b=ID2lPbC7ztu25C8H9JqcrDLEEtsABOBPIoeMiwWUBnqPWiHvay
    IBWEZPb6WV6Cz7gjm3s6NdTHRTD9mFXPXhl2sg2A2PAyJ536ywzagUk6KBL7SVJi
    BEpRJY6CoDiTnONm8B+LzrQqaBrulqrO05sTR1aTTVRMDUN6aijdnFeZUdx3/r57
    nldd3Zano2+R74NpmKYSB37r+SXql7TYpvPWB7rQs8W3KE7DccXI5iJSqhnsdr7C
    WipXn/KWHzMKEFB6RaIEwrFcVE5/8Y8Um7NTKhFHZZyIrWelROrzxGgNJvxFvKB5
    iXQJMqiQLluYrTwuWeUxcGIn/947sN4uYV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021415; bh=PqiBAEN1O1mq2cJ9MoKlbesr9fQHjZ
    xxl/lKR+YAQPM=; b=roSAS+TZEamznVNRnjjLxw7vWjVciahVp2LOyLrgpk1ERR
    NhnZgVYW0IV1s/ZXJ4Q0ITRMsAdUfsTs0bDrVSQeRR8DBCI+MamHymBqQjXq65Sn
    b+7k8S2AXVi3wKodaU0/+hJbCR0ooQIKoDo6sF/UtPlbSdc9qXctXBmn8YK9QIkc
    9cbuyhOnNReQrZywVeJiNAKeB1XESaajw0SCucWLbP5cwHeOHRPlsCfIz+KBVGpv
    a5KOk9VodSd13zLBgQQQVdZGULX/jLNh6u3ze9tx6711FNd2XmS5K4idE/QxCxLv
    g+ASAM+1w5oJpAJEsR8I9OUzlDGeIOUqCFctfTbA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHjGJmTIiqge4iHSoZgEClH1ALqx7Yh9a5TLHgoZpYI2+bYiLHE2odc+1IB0ycECv3LV98CJML2WnQBvEyrcAGjyiGHIXhA1KVmCjy7W0OWJvkZ1z2bK
    46oQ/JMHJgJpg0rEvGS9vrKbGjUGZvFaAUZksMi6+g4J8M74pTXKcfv0So0p76VuJOBwh3GbrPEF6/kpA4QZeHtcZxipnFhmzQuX8tJIO7LNkGUO2nDQSdLu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=ag1SF4gXAAAA:8 a=fcK138BwrBjk7aqrDIUA:9
    a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754693AbeDFNaI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:30:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754775AbeDFNaE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:30:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.4 24/72] audit: add tty field to LOGIN event
Date: Fri,  6 Apr 2018 15:23:25 +0200
Message-Id: <20180406084307.173351538@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Guy Briggs <rgb@redhat.com>

commit db0a6fb5d97afe01fd9c47d37c6daa82d4d4001d upstream.

The tty field was missing from AUDIT_LOGIN events.

Refactor code to create a new function audit_get_tty(), using it to
replace the call in audit_log_task_info() and to add it to
audit_log_set_loginuid().  Lock and bump the kref to protect it, adding
audit_put_tty() alias to decrement it.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/audit.h |   24 ++++++++++++++++++++++++
 kernel/audit.c        |   18 +++++-------------
 kernel/auditsc.c      |    8 ++++++--
 3 files changed, 35 insertions(+), 15 deletions(-)

--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <uapi/linux/audit.h>
+#include <linux/tty.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -239,6 +240,23 @@ static inline unsigned int audit_get_ses
 	return tsk->sessionid;
 }
 
+static inline struct tty_struct *audit_get_tty(struct task_struct *tsk)
+{
+	struct tty_struct *tty = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tsk->sighand->siglock, flags);
+	if (tsk->signal)
+		tty = tty_kref_get(tsk->signal->tty);
+	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+	return tty;
+}
+
+static inline void audit_put_tty(struct tty_struct *tty)
+{
+	tty_kref_put(tty);
+}
+
 extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
 extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, umode_t mode);
 extern void __audit_bprm(struct linux_binprm *bprm);
@@ -410,6 +428,12 @@ static inline unsigned int audit_get_ses
 {
 	return -1;
 }
+static inline struct tty_struct *audit_get_tty(struct task_struct *tsk)
+{
+	return NULL;
+}
+static inline void audit_put_tty(struct tty_struct *tty)
+{ }
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 { }
 static inline void audit_ipc_set_perm(unsigned long qbytes, uid_t uid,
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -64,7 +64,6 @@
 #include <linux/security.h>
 #endif
 #include <linux/freezer.h>
-#include <linux/tty.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
 
@@ -1876,21 +1875,14 @@ void audit_log_task_info(struct audit_bu
 {
 	const struct cred *cred;
 	char comm[sizeof(tsk->comm)];
-	char *tty;
+	struct tty_struct *tty;
 
 	if (!ab)
 		return;
 
 	/* tsk == current */
 	cred = current_cred();
-
-	spin_lock_irq(&tsk->sighand->siglock);
-	if (tsk->signal && tsk->signal->tty && tsk->signal->tty->name)
-		tty = tsk->signal->tty->name;
-	else
-		tty = "(none)";
-	spin_unlock_irq(&tsk->sighand->siglock);
-
+	tty = audit_get_tty(tsk);
 	audit_log_format(ab,
 			 " ppid=%d pid=%d auid=%u uid=%u gid=%u"
 			 " euid=%u suid=%u fsuid=%u"
@@ -1906,11 +1898,11 @@ void audit_log_task_info(struct audit_bu
 			 from_kgid(&init_user_ns, cred->egid),
 			 from_kgid(&init_user_ns, cred->sgid),
 			 from_kgid(&init_user_ns, cred->fsgid),
-			 tty, audit_get_sessionid(tsk));
-
+			 tty ? tty_name(tty) : "(none)",
+			 audit_get_sessionid(tsk));
+	audit_put_tty(tty);
 	audit_log_format(ab, " comm=");
 	audit_log_untrustedstring(ab, get_task_comm(comm, tsk));
-
 	audit_log_d_path_exe(ab, tsk->mm);
 	audit_log_task_context(ab);
 }
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1976,6 +1976,7 @@ static void audit_log_set_loginuid(kuid_
 {
 	struct audit_buffer *ab;
 	uid_t uid, oldloginuid, loginuid;
+	struct tty_struct *tty;
 
 	if (!audit_enabled)
 		return;
@@ -1983,14 +1984,17 @@ static void audit_log_set_loginuid(kuid_
 	uid = from_kuid(&init_user_ns, task_uid(current));
 	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
 	loginuid = from_kuid(&init_user_ns, kloginuid),
+	tty = audit_get_tty(current);
 
 	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_LOGIN);
 	if (!ab)
 		return;
 	audit_log_format(ab, "pid=%d uid=%u", task_pid_nr(current), uid);
 	audit_log_task_context(ab);
-	audit_log_format(ab, " old-auid=%u auid=%u old-ses=%u ses=%u res=%d",
-			 oldloginuid, loginuid, oldsessionid, sessionid, !rc);
+	audit_log_format(ab, " old-auid=%u auid=%u tty=%s old-ses=%u ses=%u res=%d",
+			 oldloginuid, loginuid, tty ? tty_name(tty) : "(none)",
+			 oldsessionid, sessionid, !rc);
+	audit_put_tty(tty);
 	audit_log_end(ab);
 }
 
