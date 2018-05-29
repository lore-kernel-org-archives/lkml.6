Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220212-1527605453-2-3308187597147290376
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605452; b=SRObk+SpRrNiPxMUysOmSJ+sOAE6bMTSzjYTDx5bd5fJWd82cR
    yxtJbry5OGYba3HcoBvh/idNnboQj4K5x/cb4qihWoBgOC77x690m/80a5sJJJPu
    9uFuAZlqCz4yejgWRsRalVyp1jDxijaN9+h2fZGjRjd4AAmoHmzl0G1Xm6sneljN
    qwMZFfMyNC/qq94R7Roa+NIzbNYgiOInUymG4PPXh3w8Hwmsm/rbinKD6+N96zIO
    tUgaySRxzYD+2SHA5jgVu0enF+ahUEnJ5EHsZP4WbE5hFa6bfTiLyTUjgb57RmVJ
    PP5Y4eDfHv3bkDV+zphgSbn3l1z4RVlzW6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605452; bh=
    qAcMfB8axqtMPyfvE/mHGgT2K12GWLuk3/aVO2RHtQM=; b=HO+RAcYo82d9pfZL
    rjXwayrsVEeu4NlOiZXR3mIROaNPGOBX9gBRI19ZQ8YDj2Fbq8AKG8JFpX+kB4Zl
    TuPO38ovY+cuoCVPRtEOF+89quZtsUc5QvCkl3BLb3uD5N7GIAt7vo1voBi4DEGR
    jXc60LnBrDSZLKwX+PNkt4LNZ5XnnSGY8HRfWwutVC7BH74DDmKA33UdTqfiFvGw
    /WoTskrLU0RMDVhtoSoMcbR6KfsML8IcbQAspx0d5geU4lJUwTtJDA00SmCWwn9d
    Lcd7syWE9fR8RPTZ8TiqO6nkY0yaoufWhOhIIrkBXVsenbxdkh1iqqZqCxgMWCps
    2/s+Dg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=D2uqt5wO;
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
      header.i=@1e100.net header.b=D2uqt5wO;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNYAD3dEWV4mwaUhMaA03IiqhFmmbRchEJfz2qFynU7o5VNJTqIfU2lcmiOzPIBot0qard2MkL2a7UVntdXg5rGfR4fiapzsM5G2ibO1cLzUrBkBEKDK
    S5IgzyohjfQJDsV+UsozTlDbcEankh+SYbpbKvMl6krd/KQUvssFoHDB5tvS7emaodTSA1FN2CV8i1OQAJUiqwclB0q5NRpdV92rprQnF5oZjHwEMUBaqULl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=Wqoy82ayJtmvth7ypYkA:9 a=xXcJMSfwO6gA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935495AbeE2Ouf (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:50:35 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35769 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936643AbeE2Oqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:42 -0400
X-Google-Smtp-Source: ADUXVKIc5vRa4GSRs4tbzMx2GdWTP2+S3dh/ckEr0aamz/tL7pB3tV2tGUWiLcgYjadjiuwb1I6W7Q==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/28] ovl: Do not set dentry type ORIGIN for broken hardlinks
Date: Tue, 29 May 2018 16:46:05 +0200
Message-Id: <20180529144612.16675-22-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

If a dentry has copy up origin, we set flag OVL_PATH_ORIGIN.  So far this
decision was easy that we had to check only for oe->numlower and if it is
non-zero, we knew there is copy up origin.  (For non-dir we installed
origin dentry in lowerstack[0]).

But we don't create ORGIN xattr for broken hardlinks (index=off).  And with
metacopy feature it is possible that we will install lowerstack[0] but
ORIGIN xattr is not there.  It is data dentry of upper metacopy dentry
which has been found using regular name based lookup or using REDIRECT.  So
with addition of this new case, just presence of oe->numlower is not
sufficient to guarantee that ORIGIN xattr is present.

So to differentiate between two cases, look at OVL_CONST_INO flag.  If this
flag is set and upperdentry is there, that means it can be marked as type
ORIGIN.  OVL_CONST_INO is not set if lower hardlink is broken or will be
broken over copy up.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 61ace2de3019..1aa9e0c5a327 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -133,7 +133,8 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry)
 		 * Non-dir dentry can hold lower dentry of its copy up origin.
 		 */
 		if (oe->numlower) {
-			type |= __OVL_PATH_ORIGIN;
+			if (ovl_test_flag(OVL_CONST_INO, d_inode(dentry)))
+				type |= __OVL_PATH_ORIGIN;
 			if (d_is_dir(dentry) ||
 			    !ovl_has_upperdata(d_inode(dentry)))
 				type |= __OVL_PATH_MERGE;
-- 
2.14.3
