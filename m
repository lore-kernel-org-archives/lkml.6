Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605621-2-9757996587513903755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605621; b=YmWYS7fF4p/oPXD++KnHDWlvQfZgtm+md2BGp/g/Jvq+fv5Ryy
    zLEGQafFz7Xxu1g6fKlDHNm+BkdobJPdv6Wm/U8AcBXT+7C2IoF7QYGwAGm9lp27
    a/FIIgG8vqzQdhyeQqDx3DzVR5iMoXkN/bpSSGKZwNAVwDDbFjuCd51w+IVG7qO6
    54YMlbG7eXsEm+J7Z0JmxeClXQgTzybW+VzPox2gmsqeefj/yQpda5NHOyfSvRsZ
    sjkUYf9PNbRv2LMA9589fphK6Lz5FkBfQXnXiPJzEYXqCDgpSVdgqnoMrw807Zre
    JFJaCn+Zi7pmNa4BiZ5JKl1zkMG3nImYiHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605621; bh=
    i9xqLL9YlFuu8rvFxb/N5aIkc9LvneQle6Fwc7e270Y=; b=TY80Y+6dbly60RNp
    NqbcSJC7kygKqQUjymvJAi9wfVnK8JjGRud5ZbOtptFC8n1MvAwpNasmgiCe1Gm+
    pbmtPzHImAVTdITI82vuRPJW/SkaroFTGgwKGg8F+WE44cccvyNOqfc7OvgQkUMS
    6LPWn1t48NMXz4uYT/VSCG25jfjYCvwotejQuJtTqRHFQ46qv9TI6i9ZbXZqVAHw
    fR9hXf50zguBfTIY5agldlKeEHShXu+9sm5XNWDnWiQW65NbnnD5By1IM2uCEnCh
    0JBbirsj/x+iFiZKRIYK0cwDKy9MI//29ZH4L0bflS++bJda4oFr59A5Bk7RlM0a
    o1oN7Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=VL8xCEvI;
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
      header.i=@1e100.net header.b=VL8xCEvI;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCnz2Li0BIDiHYen4bK6rnlO41xPOb587brIXjHDA52IeeqKv75ij50aFPTBIxFACmHteqwBoyJJEqhJvv+c3hatY1Ejzh6zPsCabAT0+k1jPZE8U68l
    qCZC3i9otkI99Zl3QZBeztKcWcN/QoEf1Ir2rd2Bj9U2kH/4d1xcCtgItcxD0OsLkafhedvdr8JmHYo4A+jyMXScTjwwlWjZZ9Qrmhw+pn2jU57pJTTKzgrv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=sFi_zC9hjaoMbk92sI8A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936550AbeE2Oxe (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:53:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55279 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936593AbeE2Oq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:29 -0400
X-Google-Smtp-Source: ADUXVKLIBTuPzZHoVB36VJRXBb/suaHmvffSDksqmyV9zUMjx4L3gJ3+hTLCv0WZlgJkaZFp+UCMGg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/28] ovl: Add helper ovl_dentry_lowerdata() to get lower data dentry
Date: Tue, 29 May 2018 16:45:55 +0200
Message-Id: <20180529144612.16675-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

Now we have the notion of data dentry and metacopy dentry.
ovl_dentry_lower() will return uppermost lower dentry, but it could be
either data or metacopy dentry.  Now we support metacopy dentries in lower
layers so it is possible that lowerstack[0] is metacopy dentry while
lowerstack[1] is actual data dentry.

So add an helper which returns lowest most dentry which is supposed to be
data dentry.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/util.c      | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 31795c041d61..13b2151cf4df 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -221,6 +221,7 @@ void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
 struct dentry *ovl_dentry_lower(struct dentry *dentry);
+struct dentry *ovl_dentry_lowerdata(struct dentry *dentry);
 struct ovl_layer *ovl_layer_lower(struct dentry *dentry);
 struct dentry *ovl_dentry_real(struct dentry *dentry);
 struct dentry *ovl_i_dentry_upper(struct inode *inode);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 32ff67fa0bfb..7c7b95d5da1f 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -207,6 +207,19 @@ struct ovl_layer *ovl_layer_lower(struct dentry *dentry)
 	return oe->numlower ? oe->lowerstack[0].layer : NULL;
 }
 
+/*
+ * ovl_dentry_lower() could return either a data dentry or metacopy dentry
+ * dependig on what is stored in lowerstack[0]. At times we need to find
+ * lower dentry which has data (and not metacopy dentry). This helper
+ * returns the lower data dentry.
+ */
+struct dentry *ovl_dentry_lowerdata(struct dentry *dentry)
+{
+	struct ovl_entry *oe = dentry->d_fsdata;
+
+	return oe->numlower ? oe->lowerstack[oe->numlower - 1].dentry : NULL;
+}
+
 struct dentry *ovl_dentry_real(struct dentry *dentry)
 {
 	return ovl_dentry_upper(dentry) ?: ovl_dentry_lower(dentry);
-- 
2.14.3
