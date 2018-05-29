Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2266183-1527606553-2-561412793083171118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527606553; b=WigBDub3nGt8ZnOD3lxCBn8nZLjKIEUwSOCVtTWQVVWfhYnwY2
    W61/jVakGLLpPf3HIy2AOQ9YrLjWqbQ7kaUjIMZJ/Pt6qO8U4vfVTgyobcfqqU1w
    iE9z/B27A3MkjN94UthN6kTSX+1yUJWoPpB+24PsXp761ihh5LvIRv8r83uXW+mT
    YPFaf3We2ENL+tHGR77t3OlwUnUzM2aU8O64PGtZER0iwa9XnOcIMTYG4n9qZ7Ot
    G772iBeTFDoWhqx3t7AgjjSPXyX4lBT2PFhI0SiB7G2OcR5K/2Cv347jvHbJrN2s
    kQQgCrLYNsga1Ke7av2Ih+PqvaKvJTEfhrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527606553; bh=
    RGIJZSifsy2xeQFppSvaFIOe9Z45/3FzZqM+RWq8UFE=; b=Hap4lnPY7En0vCBN
    sFN2LliqVJw7LCKLO/KfbkJ/0PDrx69XF5I9VSsQWkiZjbOAiayEfynnY4M6KRI6
    vA+sHuag4i8bbx9YrD2I/3UNiXze3zOEsnD10H1mul+I1EcIQb87uuI0FVp44IhJ
    kr3zUE+OSqUC5zHi2kU8lxVD0sLiWo0lv8NpcELo2EXZM/CM4x38DgICy8dTnzY+
    2WxQ3ceO2o5xrtWriHSWv3hUWR3bJ5uhgqN9vo9Tk0lod+IW8jiDJcfJ8ScfylLg
    Gta9kzF+e1q3/7GJOdQ+4QECP5y7yscn7f6ZI2Ref2QSlDyYjQjcL89HPxfFsZ1S
    sL9drg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=mps6yMXr;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=mps6yMXr;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfElVcW9u3ERd8t0RBOT0gBr/4N7tup+JFARlvbA/HOQLbuaWE0bCRnsVLWuuYLHluweii5GLondWB+cx41bLxr+mIDIwfIe6p9hdVZEnumW/jSF1tV1Y
    +FD4W8PrQK9jdtC71Pvxyyz9X1kAqOxmj2VnEq0r18K5AzQGAx2N4z4HD5vkmJSsbdYV/LW+Jant/K6ozq3PmC3zSyjJejxMlXtZoe8KkGe4m4tVoJ+JHtzd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=20KFwNOVAAAA:8 a=8AGs6ylmPEHxZOE-dfkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936649AbeE2PJH (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:09:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53951 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935816AbeE2OoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:22 -0400
X-Google-Smtp-Source: ADUXVKIISOBlNycqYriEosiG6vWyVH1ZRUpgbfFyhYdu29BoIX69fYkqfn+GomVOUEZ2lVdjP+1xpQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/39] vfs: fix freeze protection in mnt_want_write_file() for overlayfs
Date: Tue, 29 May 2018 16:43:32 +0200
Message-Id: <20180529144339.16538-33-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The underlying real file used by overlayfs still contains the overlay path.
This results in mnt_want_write_file() calls by the filesystem getting
freeze protection on the wrong inode (the overlayfs one instead of the real
one).

Fix by using file_inode(file)->i_sb instead of file->f_path.mnt->mnt_sb.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5286c5313e67..0d9023a9af4f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -441,10 +441,10 @@ int mnt_want_write_file(struct file *file)
 {
 	int ret;
 
-	sb_start_write(file->f_path.mnt->mnt_sb);
+	sb_start_write(file_inode(file)->i_sb);
 	ret = __mnt_want_write_file(file);
 	if (ret)
-		sb_end_write(file->f_path.mnt->mnt_sb);
+		sb_end_write(file_inode(file)->i_sb);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mnt_want_write_file);
@@ -486,7 +486,8 @@ void __mnt_drop_write_file(struct file *file)
 
 void mnt_drop_write_file(struct file *file)
 {
-	mnt_drop_write(file->f_path.mnt);
+	__mnt_drop_write_file(file);
+	sb_end_write(file_inode(file)->i_sb);
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
-- 
2.14.3
