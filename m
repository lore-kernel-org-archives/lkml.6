Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527604941-2-4080745212365784816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527604941; b=NqLgD2JCREb3a6wwmSlws+t3XOqsIdyQ2TORe5fN1X59OlcN7v
    kf++XVixkH1PuZrQ/7Swez8DoFqEBXTKmrc90LFgk99J18NmYcHUclhPoJxP7flv
    8Ftm4TwMunzzE8W/FjV9n4t1GapqXkas2936JL16FmuQnXHLTTXLzQr7bVvI0m1+
    1lxYCHc6rk9OMsMLr/683WynnZaqm9s6dKpqPWu1UaPmEQRkjMjaUBc0xbMJRpBy
    a6ypIr4MQccp9QuSFDTn3Q1WxsmIHmpjmj2BDZEWHgIznGpWKd7y0D3pJjeESHTa
    s03hOcTFv7s2Nn5XcvEhyiEcxYNS3fBun4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527604941; bh=
    iehAG4s408LqtFAVcD/jVCvfKtvn+GFiDM89ZuQvj8w=; b=XpqXPnr0f6BxIgai
    PCtQDwRiANUFGoP9KzBcCQgL/P0VkYSjsYt3dWj3N+XPpf1IIT9C8+FzlDuqKDJi
    SPLXMDbvFT7LpRHDdDySpSPQmO6H1RmbRhB/I4qw9trqkpqbcDolKWfrym8xdjIE
    Q33oUeTYHdg0FJDnxRwurdv6pzvyH88Qx3fELy+Bnbd6sp8dXN5nNtcuj4gMzndD
    dkpk3hpXNeiYImHtL1eK4NiITUg4ufni9T2btcgK4xTxY99USdYdl8nKOFcyIk67
    qo+9Chw942W2bjt7gi9SVzqmYaZ3wiEOM6SS4x/D43JtFxXksXvIToyAEfCxhqzd
    UfYIbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=hMWmJRWp;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=hMWmJRWp;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCvqa4kRg4mril5RnD7Xb9+Dy3Lu3XBIjzA7IagfYXo//M/KrY2SC4pLir/PBLIQzcLmpsXD09t6YQtp5M2/LO9leYmfqzucnCjDVkvRXul1vnd/9oxe
    qEeRZTkUIkC47shaJw3TlU7FS4/IzBQ2PAc/DazryUnUctRCW0BkVPR1TMyE3JNeHrbCv87vaVmPmDVTvg7nRGyo7awv+VDW6FDK3TtnrS+60uUz08PAJAR6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=drOt6m5kAAAA:8 a=20KFwNOVAAAA:8 a=IXLtcRePUa_BfBxVTWsA:9
    a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935131AbeE2OmF (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:42:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35152 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935107AbeE2Ol5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:41:57 -0400
X-Google-Smtp-Source: AB8JxZquq7qyRCODMnHPZJjONX3ZCf8sivCGcBviAZhXaNFONt3lH2y+93NU0yureA+hT5OEP1koVw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ovl: make ovl_create_real() cope with vfs_mkdir() safely
Date: Tue, 29 May 2018 16:41:39 +0200
Message-Id: <20180529144143.16378-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144143.16378-1-mszeredi@redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Goldstein <amir73il@gmail.com>

vfs_mkdir() may succeed and leave the dentry passed to it unhashed and
negative.  ovl_create_real() is the last caller breaking when that
happens.

[amir: split re-factoring of ovl_create_temp() to prep patch
       add comment about unhashed dir after mkdir
       add pr_warn() if mkdir succeeds and lookup fails]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/dir.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1b181292a624..b33d37d1a87c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -114,6 +114,37 @@ int ovl_cleanup_and_whiteout(struct dentry *workdir, struct inode *dir,
 	goto out;
 }
 
+static struct dentry *ovl_mkdir_real(struct inode *dir, struct dentry *dentry,
+				     umode_t mode)
+{
+	int err;
+
+	err = ovl_do_mkdir(dir, dentry, mode);
+	if (err) {
+		dput(dentry);
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * vfs_mkdir() may succeed and leave the dentry passed
+	 * to it unhashed and negative. If that happens, try to
+	 * lookup a new hashed and positive dentry.
+	 */
+	if (unlikely(d_unhashed(dentry))) {
+		struct dentry *d;
+
+		d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
+				   dentry->d_name.len);
+		if (IS_ERR(d)) {
+			pr_warn("overlayfs: failed lookup after mkdir (%pd2, err=%i).\n",
+				dentry, err);
+		}
+		dput(dentry);
+		dentry = d;
+	}
+	return dentry;
+}
+
 struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr)
 {
@@ -135,8 +166,8 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 			break;
 
 		case S_IFDIR:
-			err = ovl_do_mkdir(dir, newdentry, attr->mode);
-			break;
+			/* mkdir is special... */
+			return ovl_mkdir_real(dir, newdentry, attr->mode);
 
 		case S_IFCHR:
 		case S_IFBLK:
-- 
2.14.3
