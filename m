Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605091-2-8195055930887389697
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605091; b=hInCYQ864FxbtNRr5ZEly1Z3DKdG5VpRd9Jc0iUUCbsUZNHusp
    r1Hzz9eK0g1Dvh1zltbjqxjsjNwG7Rz7zd8/94KUBwTcx5QMbMTCAn4Turll+Pv3
    q9iu55bUWPICemVlxeuSwejFTYuEYKPtOdDnImmxSAAb8hZTejtdDgaOEGTF4Sw4
    bk2md/nM7WPm55yQUhq6r35E20JdSrIREFE7ohcrpW12Vn9EowMPys2MotuE/zpe
    11DcjdwA3X+CKVRiJ/JhEvUx1+3Csy+lEXTTBd2OaBOajXv9cRJ0b5VE1JIExxoK
    Oz0Km2KIwsb9xMYRQhLeZOxwDtUG7Y+RgS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605091; bh=
    XAqtlJKk0KFtCftADSZIIfBbqS7mvtSTKiWscehsItY=; b=CgoUwLKVZXOO2LsW
    jsVbCBO91ea9RhCkSK1o8Lbpi5KbHQIBYtQgMP5yKFlwSj8y9ZIalvcaKbnypqUu
    E+Y/yuUklEQu+RIfg4c4JYnrQDdxK716+lkRJ7FiRhQWFKXnJBykNc6TayKVTP+r
    DK915reFT7QbE/tAi0Trdt5/1u0xEb4kuN0oGe9+U8nsNYilWJsx8ErXbM1ThEFu
    N0BvzrwJiJ9Vdnz55GhSNo+N67cG8EddefH3TnLkhAnFHiWmsbEiz8fCHUb91Ptq
    kGlaEFtPeo1igdf2C9V6my+DbzDjDNVkZBp+rhylA4QkJenb+fNJ/7K5o39BVaVD
    zLQ1hQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=OETPiSr3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=OETPiSr3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEULYiRVjRi4udrt8RYB7/FUaGkXsu+W7wpiJhMzHgPnv1DqWewrkyJ6KzQZBxzuSGbsjqhK8a194AmzlC1PVnuHgz0Q44XTal6dev2LxqXOT8udVBGA
    k/JWv67ojcX6xDV9Mi+uB+d0aQPpU8hVR0MR+09DzGOL9yWIJhRPvXioBwwX6+nKpM5k3f62BxnacB1JMnlwy3s5dFWctPOOZ8vZuOWLLp1+LTkKoCkNvymj
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=E4uoPQmSNzoQQWsFL_4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935115AbeE2Oos (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:44:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52271 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935810AbeE2OoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:20 -0400
X-Google-Smtp-Source: ADUXVKKPiDesnReF6XCd6woEaJs2kDJYHZUj4CIPXUzXiC8O0LwP7fLAdSXZD8d48ur19/d6SxYlxA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/39] Revert "ovl: fix may_write_real() for overlayfs directories"
Date: Tue, 29 May 2018 16:43:30 +0200
Message-Id: <20180529144339.16538-31-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 954c736f865d6c0c68ae4263a2f3502ee7c447a3.

Overlayfs no longer relies on the vfs for checking writability of files.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5f75969adff1..c3f7152a8419 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -468,9 +468,7 @@ static inline int may_write_real(struct file *file)
 
 	/* File refers to upper, writable layer? */
 	upperdentry = d_real(dentry, NULL, 0, D_REAL_UPPER);
-	if (upperdentry &&
-	    (file_inode(file) == d_inode(upperdentry) ||
-	     file_inode(file) == d_inode(dentry)))
+	if (upperdentry && file_inode(file) == d_inode(upperdentry))
 		return 0;
 
 	/* Lower layer: can't write to real file, sorry... */
-- 
2.14.3
