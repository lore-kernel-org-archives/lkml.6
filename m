Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605051-2-524926027803368377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605051; b=KV2Q9iKPX4bh7+BMc7EQ5QJoTKUqef7ECgqPQMxid+asBoHx7/
    3lI+xLi2AC1RCkq7rT1sNpsab3y5AiIYvegTaYgM10zUV//rBDW7SdyMuDXtcAPB
    Pd4tlKClXeiOg31yxXGp5CbKFGljx1YoLkPAmkFpuRiFLBK9z62cknkfZ2UzP7TS
    VU823i2ADCexuovMAkbOCEUrKjwaa8RtZkiJjK5mwdm51gqePKTql6MsmuUEW2Sw
    sH3aVBGD8XXFylnGmk0R6uF2q3g3JDY7uI+KZOfNZFAwBxrlMITePp7eL+FvJAQB
    gdvGyYMHE9D6AYdJfJza670OVnzakgxKIWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605051; bh=
    amDQEDaddka9sPHz/9W7dccYu3CzZdN6llMb84YNbYk=; b=Djs0ADO355Q4p6KA
    o35xEROwOwP7S5AnjCpWU2gWHIOvAEnf3BkhNXx+E7DXbZ51KGVhzmIgKj4FHrju
    yEwkZ/+SVHq8m4RqUnKaSMp2+xjIV10kfiJ5eP12Z1N4GATwPwpadOVSOfY3LDHe
    iNcv8xEKuEtZIO2wa2HIViLst1IVNhHa9W4cu3bg+5BfTa2omNKy4Ycvfn5plL87
    8kE6KYPNUdHezk3S2fXhhPC1MVux69fWwR5aD6oBs4XSp/39yhwZA728rMw9GmrU
    YfdC3JggzMclxVuh27moxKR8ZayW9kw79kELtn44BLv+y/h8e+AX8fx3rM7GGLes
    hYk82Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Wiaq0IQG;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Wiaq0IQG;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAIZPbkJCt1V2eZUqSr5pNss5CltqE2l/lsIIn6X0tEOMxIGuQt22yTBkPqTP1SkCsaasaXvMJubiiBkv+4Iq+flqBKN1dh7OKw45s/BNjnLvcq/zUt1
    pSJQsfzg/oddz9gN+AKQm8IJMiz7GvqysKmfvDpvDLaZ85T4LAbUCVd/V0FGMdzlKiOeS6Ds8A8JJ/kthQZ9ZhpFSw2UkJ4GNMjqLlnKreVFYELqI3+G1qoC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=C-zsn8Ri-qWl_ZaUxfYA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935700AbeE2OoJ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:44:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42025 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935557AbeE2Onw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:52 -0400
X-Google-Smtp-Source: ADUXVKIqam11FbUdD6rJKACZr/Ot/tjWOxKK3JO6qjr374G2jlBBsZawKwoBnh0Sm+gNuCum8WXfqQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/39] vfs: export vfs_dedupe_file_range_one() to modules
Date: Tue, 29 May 2018 16:43:08 +0200
Message-Id: <20180529144339.16538-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is needed by the stacked dedupe implementation in overlayfs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/read_write.c    | 6 +++---
 include/linux/fs.h | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 82a53c44c0aa..4d61375a0de4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1964,9 +1964,8 @@ int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
 
-static s64 vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
-				     struct file *dst_file, loff_t dst_pos,
-				     u64 len)
+s64 vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
+			      struct file *dst_file, loff_t dst_pos, u64 len)
 {
 	s64 ret;
 
@@ -2001,6 +2000,7 @@ static s64 vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 
 	return ret;
 }
+EXPORT_SYMBOL(vfs_dedupe_file_range_one);
 
 int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 598c60092c11..6961feda6915 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1817,6 +1817,10 @@ extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 					 loff_t len, bool *is_same);
 extern int vfs_dedupe_file_range(struct file *file,
 				 struct file_dedupe_range *same);
+extern s64 vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
+				     struct file *dst_file, loff_t dst_pos,
+				     u64 len);
+
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
-- 
2.14.3
