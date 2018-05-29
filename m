Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220212-1527605311-2-11391608407830244909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605310; b=kvEqCKt7wvZFShQASQyG3GWcNyXETHfeVGdzCHM5caF7hWjpI2
    BYAT2f3ZNgHCAlBJSSgIkFlzGpQgG4D/KL4Fwy0ESjoVeRvDnhSV90iGOQVnXma+
    5V0dgwTC0HMCSCQ0/nRs5nXfoq61Cubdw7wPW1bt8d4gEGEO3gZ5xY4im0Xu+OdZ
    1BJrNT3Kez1JpgkFG2F8PcaghpCMRqjz6AUPZ+oic4XOIiveVGAWD0+MH3VQUiNp
    wOlVJywanWXtiKvNKv15H5ykHoGCyuehaGVDXizqt14s37vMdD5Ug8wyLZeCKZkK
    YD1aCpPtgLM+8t2C+I4iuJS2HfYiCojsLqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605310; bh=
    W07LBnJ/tBx7rhhLSkVFLGqSTze5RhHtD01gjcJ5qCg=; b=SNMRufr1zjq2wofo
    16I5okLCt6wadYcaDw5KxuclbzFWb9QLewWrnuu2EbGPl0j+ana06++C9jjfm8XR
    StKrmvTkkw8qz0z1A9h65D/rdmFGB8UJ09BDest9024v2uAUK3hH1IRi391kSZVg
    xhlwS5EhpyCYzHPtYJxtZu+KXm5gP5egTyclxycSSlgR9yRSDY11BdrmTFB94fJe
    2f6EOx27VkZGltcjhb5kf8leWGdL2/3J+5ZVrpGn3haE9fa7LON8sVy/aDgjqTxQ
    aKKwGD/b/G8MoBwZ0PV2X8KLSWzVI05Vqi1XPuPiaoHrGQu5g9DyXYSeN5IFwzJo
    RVN9vg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=smiGdOBP;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=smiGdOBP;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH4Cwmrs2Ngex0Yq59BKno/fhawht67mZlf7lgvZoTTzlpKE4jlFQoorZ8bV/Cb1sGsqc6dhrvW8POea+3sXbm7mzq/PQ5M/3ESMsFc3beMEGYyxP7J3
    cdfA+tL1eOYeVp4SIH/GhWFtxSvUG4E+j/hI0TIo621ajX0JL5I9P0n3zphINuQsk4nBdHBFs2zvygn6o8pOXsaBAu1IcyepO7q7u+jI4n7AlyQywfc8xU+V
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=2ANCPRANSbm623xOnzkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936494AbeE2Os0 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:48:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50828 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935583AbeE2Oqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:47 -0400
X-Google-Smtp-Source: ADUXVKKxg9+J4BvriV8wC0tXec3QUcZWH9spw1S/RuvqxGJTLOELDHRoNSWvYXa/Mb2sm4SW0HaV/g==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/28] ovl: Disbale metacopy for MAP_SHARED mmap()
Date: Tue, 29 May 2018 16:46:09 +0200
Message-Id: <20180529144612.16675-26-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

When user chose the option of copying up a file when mmap(MAP_SHARED)
happens, then do full copy up and not just metacopy.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 5 +++++
 fs/overlayfs/file.c      | 2 +-
 fs/overlayfs/overlayfs.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 8c05e9ad9782..c31f198bed99 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -867,6 +867,11 @@ int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags)
 	return err;
 }
 
+int ovl_copy_up_with_data(struct dentry *dentry)
+{
+	return ovl_copy_up_flags(dentry, O_WRONLY);
+}
+
 int ovl_copy_up(struct dentry *dentry)
 {
 	return ovl_copy_up_flags(dentry, 0);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c7738ef492c8..953295774471 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -296,7 +296,7 @@ static int ovl_pre_mmap(struct file *file, unsigned long prot,
 	 * later.
 	 */
 	if ((flag & MAP_SHARED) && ovl_copy_up_shared(file_inode(file)->i_sb))
-		err = ovl_copy_up(file_dentry(file));
+		err = ovl_copy_up_with_data(file_dentry(file));
 
 	return err;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 24f1d0e8a178..93c84929d422 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -414,6 +414,7 @@ extern const struct file_operations ovl_file_operations;
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
+int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_copy_up_flags(struct dentry *dentry, int flags);
 int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags);
 int ovl_copy_xattr(struct dentry *old, struct dentry *new);
-- 
2.14.3
