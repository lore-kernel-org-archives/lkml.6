Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653738-2-9546813140960597502
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653737; b=S7YGabVMCnyrP9EmRLytA3OMTN6xzk/mPL56z5CRbG2rXM2UXx
    zGwZqrUAaT2XGz2NlxTLJ+zfoh86rtDQYDv7iBOYrTtBUYM/EWIvCFM/JtXRrIbn
    s6VwSWzI9R8pGsC2oA/umRt4WZQB1NBKnP43BAOFeRLlo3TGS+FWb8/Saw2OwWQy
    yaSNW8ITA85opdDtDO/CWfHkhbZZUj7gBO4iL14f0xpl5fKFgY6y/gWXHm5KkdI+
    cMvTQfr36r7LZTDELl8I1S5Gb+ZwUFU9N1VeLPe/w9hkseTe0zshjhoorlSmSLT7
    6PbH5O03XP55lvi5XshTxeLVA65Tk1ZWeRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653737; bh=aOnVQLtdLIdPlCmin3UPiitvWj7x67
    wGFqFm6dg+g24=; b=lvQjsNEk8uF/Gz8oiPBKAcaUdTxJKYQjfLKP4ZChnLwCuy
    Xu8+3rdzyNZDj+dxKkoIcwT4XJOpL88NDLJ5xRJHau6MWUVon0I3MMP6+09brZfZ
    1oIp59g4TcEB5hF6yNGuRwngN0brc/7hqB4HZWb47jbXzpwM3chC35hDyl25juE8
    Sity1IEQVrxMBBPI5DpqaJzu2opF3SNgysoobXTFOpLPdUPmqUqUtx79edKScgew
    9DKcakubKt8aw1hPEdXozrai97447R25QULkG6qipD5tC84ZvsZJvP0iV2BwZfgs
    4/APNKbjQ84SMfm8gnucykHdjIoc/gLpZpZ8An6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNcm2VTg/JE9Y92yN+xi4kMzYODxNNQ6YWaxgyiNFwkAPYl8Do//IVGyMbDcWfdZV58jvTUAZ32HahpZvkJtZuXGh5nTvqlkZh2R84kyFtTtl2C2bwq+
    R8unike9tqK8zggyldDhStbQNqo8HUIC7yRrcL8R31Y3L8O3hE/92mRTgbQkc9DHyun642fRCB+i3Ln3MFjf/d6T5qTcDYvQzMgiefSmRSirBqe9T81C9r+8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=o8Bf2xIQAAAA:8 a=IXr_WNlcAAAA:8
    a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=UtV5FjuMAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=9QFRiMXo_QA8-fxtALUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=kLeBEu5l8tkQtVp4YdQK:22 a=K24ECnMRWNUKRqF_MnsZ:22
    a=ehT88nhQmDs7a44Z_RBH:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbeDYKnS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:43:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeDYKnO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Piao <piaojun@huawei.com>,
        Alex Chen <alex.chen@huawei.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 109/183] ocfs2/acl: use ip_xattr_sem to protect getting extended attribute
Date: Wed, 25 Apr 2018 12:35:29 +0200
Message-Id: <20180425103246.832974235@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: piaojun <piaojun@huawei.com>


[ Upstream commit 16c8d569f5704a84164f30ff01b29879f3438065 ]

The race between *set_acl and *get_acl will cause getting incomplete
xattr data as below:

  processA                                    processB

  ocfs2_set_acl
    ocfs2_xattr_set
      __ocfs2_xattr_set_handle

                                              ocfs2_get_acl_nolock
                                                ocfs2_xattr_get_nolock:

processB may get incomplete xattr data if processA hasn't set_acl done.

So we should use 'ip_xattr_sem' to protect getting extended attribute in
ocfs2_get_acl_nolock(), as other processes could be changing it
concurrently.

Link: http://lkml.kernel.org/r/5A5DDCFF.7030001@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/acl.c   |    6 ++++++
 fs/ocfs2/xattr.c |    2 ++
 2 files changed, 8 insertions(+)

--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -311,7 +311,9 @@ struct posix_acl *ocfs2_iop_get_acl(stru
 	if (had_lock < 0)
 		return ERR_PTR(had_lock);
 
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl = ocfs2_get_acl_nolock(inode, type, di_bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
 
 	ocfs2_inode_unlock_tracker(inode, 0, &oh, had_lock);
 	brelse(di_bh);
@@ -330,7 +332,9 @@ int ocfs2_acl_chmod(struct inode *inode,
 	if (!(osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL))
 		return 0;
 
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl = ocfs2_get_acl_nolock(inode, ACL_TYPE_ACCESS, bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
 	if (IS_ERR(acl) || !acl)
 		return PTR_ERR(acl);
 	ret = __posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
@@ -361,8 +365,10 @@ int ocfs2_init_acl(handle_t *handle,
 
 	if (!S_ISLNK(inode->i_mode)) {
 		if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
+			down_read(&OCFS2_I(dir)->ip_xattr_sem);
 			acl = ocfs2_get_acl_nolock(dir, ACL_TYPE_DEFAULT,
 						   dir_bh);
+			up_read(&OCFS2_I(dir)->ip_xattr_sem);
 			if (IS_ERR(acl))
 				return PTR_ERR(acl);
 		}
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -638,9 +638,11 @@ int ocfs2_calc_xattr_init(struct inode *
 						     si->value_len);
 
 	if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
+		down_read(&OCFS2_I(dir)->ip_xattr_sem);
 		acl_len = ocfs2_xattr_get_nolock(dir, dir_bh,
 					OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT,
 					"", NULL, 0);
+		up_read(&OCFS2_I(dir)->ip_xattr_sem);
 		if (acl_len > 0) {
 			a_size = ocfs2_xattr_entry_real_size(0, acl_len);
 			if (S_ISDIR(mode))
