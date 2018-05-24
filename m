Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163286-2-14557970844551689398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163284; b=as2JwWZqY1uPHiJw/KCL8qvwYRoDQcyzWUTTLYL8PzhrLcOYvY
    Mbh8hxb9WMGuqrboX8woOJh5CUJSEI3t35hQX2ma2nLXVEJ8YNSVoPwzo7UwDd6U
    m9pEZMyBG5FKy9waqG90adoMSi2dMkVnMjN5cFMV9k3B+j+IRaVwnVnYbKlsWgPw
    jw30xUi2XmJpWSoenc6jcj4uQpUuh1BK1QPdfcAKez5V8dHjnxHljd8e34vCBhwe
    1BJWOe52GCjng3AYkyL75PalzRCUMMJmRLWEgKxjlxwIh8/cr+NhWWTT1jv6eimL
    gqV63/jrasIKVK3CiNWkp4ksNU6yFXK/QtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163284; bh=qoOBhIzX/RlSM+bPqdQQ3VgwmE7M/C
    8xxYwtqwNkrK0=; b=RTb3NIrhHJFt/rN76WymYESW+66Pg6fF3GgWmbbWigut2e
    x8UsAzbFw4PVaq2PL1MW2BBjwpSJiALDz9uad0ZQ+zHhciu5IDmpRJM+AiTxt2zQ
    DLwmG04B4VquvhmVPFMP8E5b+kkTiETZDhW5ewUMdnFdbUVc2TOhTuVAn7QHyrDT
    7K0bC3gQ/HceUZV9SA0RLeBkJTmp4OH7fjdx5hYhGUkfuunjTnWak8NDpQNOCcQQ
    cfYXFUwni3B8n300h1F2ZLg2BBrjo5Y0xkwAIhqjaPAjdamvc02pVRyop9Ob+zy2
    FIgu+z9tfSwzEH906Gr0FiXOt4/i9IRECjejDFEQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mhnCOgFJ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=mhnCOgFJ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFUdBkxzcsZbOJ3EsZx2DT6JbLt5vPqhCVdB0frFSPOgVazscdDKjHW7DBVvuTx9da+7Y+xXRYZnCEaFMA///vnYA8fSpoo96V/wl7HYZ2h2t8dJdr4V
    ajKhN4xvNJFy56Udzm5/8vpFovyuiJFuf+ghrtkx70HhIUtPkOvm61DyNJ0mattES/ozaIUhmodcO9d4kwCQBcbs5wZaL7+C0bcEMF8lZUSEzT93XPIfjsts
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=cm27Pg_UAAAA:8 a=drOt6m5kAAAA:8
    a=6rqHouBjAAAA:8 a=pGLkceISAAAA:8 a=DfNHnWVPAAAA:8 a=KKAkSRfTAAAA:8
    a=FOH2dFAWAAAA:8 a=O6nNToy4AAAA:8 a=ag1SF4gXAAAA:8 a=9aXN0AnECsDKHPtgd0YA:9
    a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=xmb-EsYY8bH0VWELuYED:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=Hx1yvPaMooE3kwe23bt7:22 a=rjTVMONInIDnV1a_A2c_:22
    a=cvBusfyB2V15izCimMoJ:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=WHP_vYRDmbjazZPeRM4b:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966802AbeEXMAr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966098AbeEXJo7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        David Rientjes <rientjes@google.com>,
        Minfei Huang <mnfhuang@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Calvin Owens <calvinowens@fb.com>, Jann Horn <jann@thejh.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 55/92] procfs: fix pthread cross-thread naming if !PR_DUMPABLE
Date: Thu, 24 May 2018 11:38:32 +0200
Message-Id: <20180524093204.603778122@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

From: Janis Danisevskis <jdanis@google.com>

commit 1b3044e39a89cb1d4d5313da477e8dfea2b5232d upstream.

The PR_DUMPABLE flag causes the pid related paths of the proc file
system to be owned by ROOT.

The implementation of pthread_set/getname_np however needs access to
/proc/<pid>/task/<tid>/comm.  If PR_DUMPABLE is false this
implementation is locked out.

This patch installs a special permission function for the file "comm"
that grants read and write access to all threads of the same group
regardless of the ownership of the inode.  For all other threads the
function falls back to the generic inode permission check.

[akpm@linux-foundation.org: fix spello in comment]
Signed-off-by: Janis Danisevskis <jdanis@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Minfei Huang <mnfhuang@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Calvin Owens <calvinowens@fb.com>
Cc: Jann Horn <jann@thejh.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/base.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3083,6 +3083,44 @@ int proc_pid_readdir(struct file *file,
 }
 
 /*
+ * proc_tid_comm_permission is a special permission function exclusively
+ * used for the node /proc/<pid>/task/<tid>/comm.
+ * It bypasses generic permission checks in the case where a task of the same
+ * task group attempts to access the node.
+ * The rationale behind this is that glibc and bionic access this node for
+ * cross thread naming (pthread_set/getname_np(!self)). However, if
+ * PR_SET_DUMPABLE gets set to 0 this node among others becomes uid=0 gid=0,
+ * which locks out the cross thread naming implementation.
+ * This function makes sure that the node is always accessible for members of
+ * same thread group.
+ */
+static int proc_tid_comm_permission(struct inode *inode, int mask)
+{
+	bool is_same_tgroup;
+	struct task_struct *task;
+
+	task = get_proc_task(inode);
+	if (!task)
+		return -ESRCH;
+	is_same_tgroup = same_thread_group(current, task);
+	put_task_struct(task);
+
+	if (likely(is_same_tgroup && !(mask & MAY_EXEC))) {
+		/* This file (/proc/<pid>/task/<tid>/comm) can always be
+		 * read or written by the members of the corresponding
+		 * thread group.
+		 */
+		return 0;
+	}
+
+	return generic_permission(inode, mask);
+}
+
+static const struct inode_operations proc_tid_comm_inode_operations = {
+		.permission = proc_tid_comm_permission,
+};
+
+/*
  * Tasks
  */
 static const struct pid_entry tid_base_stuff[] = {
@@ -3100,7 +3138,9 @@ static const struct pid_entry tid_base_s
 #ifdef CONFIG_SCHED_DEBUG
 	REG("sched",     S_IRUGO|S_IWUSR, proc_pid_sched_operations),
 #endif
-	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
+	NOD("comm",      S_IFREG|S_IRUGO|S_IWUSR,
+			 &proc_tid_comm_inode_operations,
+			 &proc_pid_set_comm_operations, {}),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",   S_IRUSR, proc_pid_syscall),
 #endif
