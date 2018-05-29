Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605478-2-14428886442762194666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605478; b=C3oCMzMfDf9rtMMcSGput8KtaudRpaUzshgUQA4zGNeAQh6VPY
    O3CE2q/rYMr//qVFJwlxqH7MIEzOajwK3k/P0K2cVJaGfrqlUC2VrEFFh7GnY79Y
    PB8iqSkdlTFBW3jif6Yl6KkGwF1iMDo0cg5e/wJRsspGgCaC9iqAR3PkZTUs2mIc
    SAt4MoApVrNG74FsZSCZVwNYruXSyu/ZEVa9O8RQm5KiWeTw2bqLKTqil6yWb8lL
    PllGK6+iKVEd1qDw1g32ww/X6zO9jMUnF9ebMSkVL1Gf+DfS+Zr81J4mKyww+RhX
    pVgDgBdl73BtPFNB9f2VoBTVth2CSS3qmYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605478; bh=
    2FJD4FVMNZyj4+zku4PRxgxKsyyTUvCMBBNHA2j/fw4=; b=BOx139DDKPrFizhl
    1mJu6eggbiy6DkToHEP+LU0pQBdADWv2VX9tVGY6FtfN85VmrNbJBWImJPSKOK11
    CtyFx1Pm9IXRRf73z8WFCX8p/YCyHOA0RDe0uaCffQXjG9Fj3StWI5eC+6HNskUU
    XX7dILhKOuFCgaOPZfWAJPyQ1TnKScbuebZ1Z97xnnrDifyvzTf8iPaJcCn/uFJg
    fp6PPSuWmudQqxtToSPFLGassa1YsYKhcCJGL+urVgXu6XPsVyH/EqSIyVB1OnVo
    jyZXl0TtAg1UDxaBQEgRhP+0/C42X5SG3++Jl9fzXv7BJDYmwLCjCZrplXD3uIh4
    dSRR6A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=VMfnSU5T;
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
      header.i=@1e100.net header.b=VMfnSU5T;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCz+oso651UyTpJ7auZtWXoGetZtjU5RTohONWy3R9ZXp91TepfIbF37e1hFPRyIvsZST7ubpM8ZRsjt/GrG+Ny/CDRiC6xC1sFV6GHP7PlqNiF3ypjB
    +HlGlC7ia7XNstkmFfzl6Tv7tgiDhkW3CQ6no3Ms/3+niFafsjJhkjW1JIKR9Wo8mRtrsV1lHbEoT2Ks5zPJf7kgGuigD8VCWXcux0ge8CDazlJDvwM81ceu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=2ANCPRANSbm623xOnzkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964871AbeE2Oui (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:50:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40398 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936633AbeE2Oqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:39 -0400
X-Google-Smtp-Source: ADUXVKIGZ4dyO1nSePeL/UU4mLvDPhhXsacaZvT7ZR0ai2PHz+O7qiRxDjgzR7b0yTj6HyHtcwOAeQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/28] ovl: Treat metacopy dentries as type OVL_PATH_MERGE
Date: Tue, 29 May 2018 16:46:03 +0200
Message-Id: <20180529144612.16675-20-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

Right now OVL_PATH_MERGE is used only for merged directories.  But
conceptually, a metacopy dentry (backed by a lower data dentry) is a merged
entity as well.

So mark metacopy dentries as OVL_PATH_MERGE and ovl_rename() makes use of
this property later to set redirect on a metacopy file.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 73939e08d8bf..61ace2de3019 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -134,7 +134,8 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry)
 		 */
 		if (oe->numlower) {
 			type |= __OVL_PATH_ORIGIN;
-			if (d_is_dir(dentry))
+			if (d_is_dir(dentry) ||
+			    !ovl_has_upperdata(d_inode(dentry)))
 				type |= __OVL_PATH_MERGE;
 		}
 	} else {
-- 
2.14.3
