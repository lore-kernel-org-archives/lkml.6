Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3852358-1525646974-5-15472311380468678976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525646973; b=aNXRrXBiQQDxU29ww6BlsHCldnI1soxkSZmXReLIZ0xuXNOqUf
    q1RwJFMOjeaSINr2ydLUs0SKjfYS7OwWl9gygjYquWGlMpzzK6Z/Pad9Uwk/d9Yw
    c84z+/F4lITxa4b7oZDsIbCGdIfHkEiI47I0Cr+vXRPOy9TBWvnjRABNyy0kQCmF
    F5cZAHS1buXdVsf3VHnIenTI7Rs0TgHym7N2iPnw7FAoc4oZMsfcSN58Xoe9XYwQ
    7bdjZdT6rj5/YgZWET6Y905JSmwZ6/RM9fwwYvYSsV3qScVd2w9/fEfLyu2L9pJI
    ixhX0r7bHGGvXxRkUdMib8ipVoNJR02EhKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525646973; bh=
    QZqQKqe5aaRSrbAieUOWa6z0wmIm2g+nBPaj5GJXk1Y=; b=AufjzQnxAjvv3DZU
    JGl+nNrVkeyRcocNldWB7Lu4L066Sew/ZqWZv6oyPPDR9liWtM44rNtnEvXU2Kff
    GrfdMN+V4EcJcTUeFq+fRj4UmTloLdlFMdLUjdW1j0zkEcNVPnG6TkUz98IOCnT/
    KWdP1O+i+av20p6y3MisAexzU9nb48TCrbC8XgHWpgjbGAfVTJ/+vPC/IggF/oxW
    nh3p5DsrYhQ003UNOhsONYH6Sw+PNC6+B+uxhfE1PJZMgDmAEwIB0udIGeawuLSX
    RTP15VM0saXHCpGlMOSFDmOaHEw34gl6851ZxgOqOpFt+QTLo455AULW4HxYguoH
    ivqC4g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=jlidZP3C;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=jlidZP3C;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD9RQRi5l5ViZ8GlIeM2LOv8CtBAVXIHNWHg5PGnTGlF58lesiCKf17Ktodgcap5xOyiWtWSciOjDdA7fdDHi4Ke7u2T+ELY/4i5sRx24HfTjpDeuSh7
    DtQPWAxSabUgap6eTdlGQMZcjbuE8FAe1x7gmIhR4+rGzxzeg4RQ6VObY10q4yqueo5Z+BwQg+haDce81QYAdSaqADz8Oh9bGKuw/0JcaiRnCCF+fEWYU9bn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=fxJcL_dCAAAA:8 a=VwQbUJbxAAAA:8 a=V5zyGy9ClZnDF-sAG1AA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEFWsu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 18:48:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44518 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeEFWsN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 May 2018 18:48:13 -0400
X-Google-Smtp-Source: AB8JxZpC+d0+qGJXPoJDlf0Qlf9HEVD3uxfkwZZfERiGRDzK6tCv1pqkFoEDfAf+wGZ2CiOq145lxQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 4/6 v1] statfs: add ST_SHARED
Date: Mon,  7 May 2018 00:47:02 +0200
Message-Id: <20180506224704.14669-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506224704.14669-1-christian.brauner@ubuntu.com>
References: <20180506224704.14669-1-christian.brauner@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently userspace can only determine whether a mountpoint is shared
by parsing /proc/<pid>/mountinfo. It would be convenient to simply retrieve
this property with a statvfs() call.
This let's userspace avoid costly parsing, supports cases where /proc is
not mounted, and supports usecases where file descriptors to mountpoints
are passed between processes that are inspected via fstatvfs().
This is especially helpful in all cases where userspace is not interested
in specific propagation properties but rather just wants to either turn on
or turn off propagation for specific mountpoints.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v0->v1:
* non-functional changes: extend commit message
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 61b3063d3921..2fc6f9c3793c 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -31,6 +31,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_RELATIME;
 	if (mnt_flags & MNT_UNBINDABLE)
 		flags |= ST_UNBINDABLE;
+	if (mnt_flags & MNT_SHARED)
+		flags |= ST_SHARED;
 	return flags;
 }
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index e1b84d0388c1..5416b2936dd9 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,5 +41,6 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_SHARED	(1<<20)	/* change to shared */
 
 #endif
-- 
2.17.0

