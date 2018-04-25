Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672620-2-4792335395980596871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672619; b=aPRa/XX9/Td5G+gi8pY7xmcAlSyCNYW/QDsh5X3DHkvfAiaSjX
    1WZFO0/KlKbVa/2BX8/rPR086b+LH4CAMUoX6cpHUT4ag46g7G6+QXlgEpklKgLc
    am9VdtLkQUJLTgWVrWmFaEkiU8MjDlJiqEUjb5wtSMFRWadmdMxKdBv70r/CIOgX
    ZdH6rjZ2PV7ZCqMbiNjE8OgT4mTL5/1dQwtG8NRxf3+QTk2fJJFC+fiUUOK8KDxu
    JbCvYCJB3ti7HMUvljyTyHA7eiqYiZHmjIufYmbHimI/NtcYP2coc/mKt5uC/Vhf
    prDsldrFvMhS2GAwij9JBXETKmsqFj0nlZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672619; bh=
    Dl+pswBd867ZFG0X8kkcAPHcMan7Wp7b9Bo0yCN5+ac=; b=IR/5iB1Tw2a+zD9d
    4/0f7IhA913LW7mKwvYdG6Umc+cqU2JJi88cVTMWY4OKv9+HrrmmU9BFON9CJ+52
    sj/yIgmbKLA+6gAQx3pQjW57oJ5+H3VIrGn9yodkDA1bChlZR2bdfoUSYY9z27Pj
    jmkJy67KHv6IppcaVrhEN2EJNXp7Ps4EDEwBqWwm1v2eS2WATGL/eSbBV2B/AccA
    wBRdHT+uIvYdlSU9HgGjzyrlEEHNE5AniUvwwPKKaIhnFvpT/1EHY7v2nSz5P4GB
    LEUQ1katT7qWp/ot/IK1tV0fIB295XFruCrwo92WifMx91MakveHfaAwVOha8/Zh
    a4IeyA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM7c7cE12MHcRMZBCEgWi0Frf7/WdBj9jsHZww73AlX6PimiaqlBgDqZ/6FRWt/5bsRXa3uiJYlMN6x008ffRWJMRyw7h9HL0sNJD8R8mkGYarYKPcip
    T0WguNrzuDVXpPYF7tUDfsnj2dy7aCmIF/LB5u42c1lCxu0SUAWEZn50lGXCgHasgKWH25vFYlcjWuMrwWBsVeNWDoQ5IYq4tSdf8N8YzSBdkqbh3Srl1S4P
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=NRFBaNzY50zIQ_F0qBgA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755815AbeDYQEj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:04:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755653AbeDYQE3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 13/17] y2038: socket: Convert recvmmsg to __kernel_timespec
Date: Wed, 25 Apr 2018 18:03:07 +0200
Message-Id: <20180425160311.2718314-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:u8I4/ifwv54gz2zYUq6Xuvk5zDxXm6OSSB+5PjgVleud71vt1hN
 M0CCbSrE4YhLMlwWvw0aVvDQS8TF3KDrceOV4H2KPqtH4PN0rXyiFGKfrNBaWGtxtnbs8b4
 NK/Kkfq7mnhxWUPl+WQ0xZDn0dCIYBSHJQ1iO/jupfnSwELu4PUaBQh0rQMgkyXdo07yh2c
 np8O5w/otQ3frpfTe08UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sglwVHXxeSY=:vNscQiXXHEevXWKGq26INQ
 JlvCBlREy160DQwhPUWb9YmHwtXKjUguqzxLKj5iFVXuua4KbKrB0OFD9F3FxqmdjOoqMfrMj
 equvKsFysjIEYWngTZlAWR8qK5oAOLYwup6gVx6HhYq/LdxEPkWjjD268zrDspzFoj4yrCOCS
 9uoA7tAHoz3IBvkqyFQ7g7Nk4NMwFCkV/eUK3hETxkryhmYHa83GHVSQdmnFvI+T7T6rXLzgd
 IUj+I0G8zVipJ7bCPPxohsGnPXbc9Otf9bhzw8xgL59xynnK6WV4VtTl+V/9wQMpDZLn0IyQu
 0XlK1b18QQDYuk9Hm0Ypn/pPGnbVNWU1LOoNzStl6MvNDNeM6ShlvxnSrdZI5bThO1HOUvfOr
 9lJLsl2nxtziFbfH1TwtFxfD5USK3WwyK/THEKylBNFt8HwhVcjH+lq5wTaNLF7D5w3He/GEH
 suyKD+65UEowYTuxaGAEUSjXt0rK0u7SmekmPP69NsWfw1QrLzGW+HHjzHP10jdnVXzqcjWsy
 tg71DCyMJa5rBtyrE3z5W09pCGJRjBINNVhBeOzxE3LCU2WOJDaNXrOLWRuQVnUBglbZYwcro
 LAJczieX1mL6TbXSAtQ2T3kiNeQPbgveo8u5gF7UKPPCN/jZrVAjsHJOmkz8W9hXjIukJqch4
 ExNRUtr/p/Dfq/FWCx3Bb3C0+Js0bt/DM/38FcxsAeS32guXjGYZANLHAopOkTeQ/xQg=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This converts the recvmmsg() system call in all its variations to use
'timespec64' internally for its timeout, and have a __kernel_timespec64
argument in the native entry point. This lets us change the type to use
64-bit time_t at a later point while using the 32-bit compat system call
emulation for existing user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/socket.h   |  4 ++--
 include/linux/syscalls.h |  2 +-
 net/compat.c             |  6 +++---
 net/socket.c             | 18 ++++++++----------
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ea50f4a65816..d36a6c1bdbaf 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -345,7 +345,7 @@ struct ucred {
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
-struct timespec;
+struct timespec64;
 
 /* The __sys_...msg variants allow MSG_CMSG_COMPAT iff
  * forbid_cmsg_compat==false
@@ -355,7 +355,7 @@ extern long __sys_recvmsg(int fd, struct user_msghdr __user *msg,
 extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
 			  unsigned int flags, bool forbid_cmsg_compat);
 extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
-			  unsigned int flags, struct timespec *timeout);
+			  unsigned int flags, struct timespec64 *timeout);
 extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  bool forbid_cmsg_compat);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index ffd8674e9df7..eaa32317f573 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -817,7 +817,7 @@ asmlinkage long sys_perf_event_open(
 asmlinkage long sys_accept4(int, struct sockaddr __user *, int __user *, int);
 asmlinkage long sys_recvmmsg(int fd, struct mmsghdr __user *msg,
 			     unsigned int vlen, unsigned flags,
-			     struct timespec __user *timeout);
+			     struct __kernel_timespec __user *timeout);
 
 asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
 				int options, struct rusage __user *ru);
diff --git a/net/compat.c b/net/compat.c
index 5ae7437d3853..93b80a3d967c 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -815,18 +815,18 @@ static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				 struct compat_timespec __user *timeout)
 {
 	int datagrams;
-	struct timespec ktspec;
+	struct timespec64 ktspec;
 
 	if (timeout == NULL)
 		return __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				      flags | MSG_CMSG_COMPAT, NULL);
 
-	if (compat_get_timespec(&ktspec, timeout))
+	if (compat_get_timespec64(&ktspec, timeout))
 		return -EFAULT;
 
 	datagrams = __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				   flags | MSG_CMSG_COMPAT, &ktspec);
-	if (datagrams > 0 && compat_put_timespec(&ktspec, timeout))
+	if (datagrams > 0 && compat_put_timespec64(&ktspec, timeout))
 		datagrams = -EFAULT;
 
 	return datagrams;
diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..4510e6269764 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2343,7 +2343,7 @@ SYSCALL_DEFINE3(recvmsg, int, fd, struct user_msghdr __user *, msg,
  */
 
 int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
-		   unsigned int flags, struct timespec *timeout)
+		   unsigned int flags, struct timespec64 *timeout)
 {
 	int fput_needed, err, datagrams;
 	struct socket *sock;
@@ -2408,8 +2408,7 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 		if (timeout) {
 			ktime_get_ts64(&timeout64);
-			*timeout = timespec64_to_timespec(
-					timespec64_sub(end_time, timeout64));
+			*timeout = timespec64_sub(end_time, timeout64);
 			if (timeout->tv_sec < 0) {
 				timeout->tv_sec = timeout->tv_nsec = 0;
 				break;
@@ -2455,10 +2454,10 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			   unsigned int vlen, unsigned int flags,
-			   struct timespec __user *timeout)
+			   struct __kernel_timespec __user *timeout)
 {
 	int datagrams;
-	struct timespec timeout_sys;
+	struct timespec64 timeout_sys;
 
 	if (flags & MSG_CMSG_COMPAT)
 		return -EINVAL;
@@ -2466,13 +2465,12 @@ static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 	if (!timeout)
 		return __sys_recvmmsg(fd, mmsg, vlen, flags, NULL);
 
-	if (copy_from_user(&timeout_sys, timeout, sizeof(timeout_sys)))
+	if (get_timespec64(&timeout_sys, timeout))
 		return -EFAULT;
 
 	datagrams = __sys_recvmmsg(fd, mmsg, vlen, flags, &timeout_sys);
 
-	if (datagrams > 0 &&
-	    copy_to_user(timeout, &timeout_sys, sizeof(timeout_sys)))
+	if (datagrams > 0 && put_timespec64(&timeout_sys, timeout))
 		datagrams = -EFAULT;
 
 	return datagrams;
@@ -2480,7 +2478,7 @@ static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 
 SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
 		unsigned int, vlen, unsigned int, flags,
-		struct timespec __user *, timeout)
+		struct __kernel_timespec __user *, timeout)
 {
 	return do_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
 }
@@ -2603,7 +2601,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_RECVMMSG:
 		err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
-				      a[3], (struct timespec __user *)a[4]);
+				      a[3], (struct __kernel_timespec __user *)a[4]);
 		break;
 	case SYS_ACCEPT4:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
-- 
2.9.0

