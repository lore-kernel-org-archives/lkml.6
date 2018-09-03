Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD096C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6347E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMecFWhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6347E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeIDDDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:03:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42836 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeIDDDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8w4TRiBDdTppAAJY1uhKNnL7Aru2Z+PYdvGrKI79cgo=; b=rMecFWhY+aIfyoiTM5fuiSX5x/
        thn9K2bSsLbNwzOiuARLD99IvdJbINWxdqembaZFRiMJPN9VaMwXD5IxAFQfeE7UEzJE1NdyRD0eU
        le44e9fDwLEgNqkcQKLIO0TzKR+9zqSNFu6N69pRohrkrh2FYARnWxfB24WTd5pyhIbiFZbHSxfKd
        IT4BD2xiOo3QDp+L0jT7946XAGQ1DL8oxvTPPVu0jo8RYglv56T9UnmLB0BDH6Ubay0Lbd0FonsjC
        QvpHXToTOVrUJbPIrp4ofK8k2/XEX7iismw9Dyi1d6Wgw0YHUntSgSQ+5HT+rXmVMeDWggdRN1cyO
        S+qAy3Jw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwxWP-0002kC-N9; Mon, 03 Sep 2018 22:40:37 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] fs/posix_acl.c: fix kernel-doc warnings, formatting, and
 typo
Message-ID: <722f4cf6-9b51-f7c9-e645-ca1f79dc7a67@infradead.org>
Date:   Mon, 3 Sep 2018 15:40:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in fs/posic_acl.c.
Also fix one typo (setgit -> setgid).

../fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
../fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
../fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'

Fixes: 073931017b49d ("posix_acl: Clear SGID bit when setting file permissions")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Acked-by: Andreas Gruenbacher <agruenba@redhat.com>
---
v2: change *acl to *@acl

 fs/posix_acl.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- lnx-419-rc2.orig/fs/posix_acl.c
+++ lnx-419-rc2/fs/posix_acl.c
@@ -630,12 +630,15 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
 
 /**
  * posix_acl_update_mode  -  update mode in set_acl
+ * @inode: target inode
+ * @mode_p: mode (pointer) for update
+ * @acl: acl pointer
  *
  * Update the file mode when setting an ACL: compute the new file permission
  * bits based on the ACL.  In addition, if the ACL is equivalent to the new
- * file mode, set *acl to NULL to indicate that no ACL should be set.
+ * file mode, set *@acl to NULL to indicate that no ACL should be set.
  *
- * As with chmod, clear the setgit bit if the caller is not in the owning group
+ * As with chmod, clear the setgid bit if the caller is not in the owning group
  * or capable of CAP_FSETID (see inode_change_ok).
  *
  * Called from set_acl inode operations.


