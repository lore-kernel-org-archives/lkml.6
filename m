Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2266183-1527606808-2-11748811046704121609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527606808; b=YII23J8QxUa42l2LhZi/+89CkAIekeriOuyQrrD7meUf1YpvxU
    4tKv4UBja64KDMSZwtIN4JbFBJTlfKKNCp1686Ynk9XjcUfZcIvaYrd/3DW6wB7U
    6uuIVJespkaoQMcU71BIhYPUBdSsYWwuBcdjzm8OVJ5/wyAuB7Jc41D0sIoETN41
    zLdadO1n21hTjssD5pYEhrfbGQ96xRJQo2S0s7d17mvE45wjGBo+bEJC+A8W8ftn
    lRLnamivQBjUTuH5nlJAzU14psjPkjuXV1o+kGXuES6BmCDwW/MxS9hlrlxjgug/
    0e7FVe5I1ZiGI7NO50HzLcvXHQ23bmfHvTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527606808; bh=
    3z5BGnZ1dMsqKneG2l6CPh5OVWM/P4fbH813ml2k080=; b=WZlhx0Me/iN0s0Nv
    hzjBNmZGVogHiiG5h5t/Rwwyr/HpRxoTcE4zIzyOAJ+3Tbx/YUm+MP3FcaT5lVOZ
    WM6+3xQ5xen6JGHg3a75LIJOwG++updKBQJmV3vnXykMqicAHvcHiZNsW7AdR0Fh
    1BM5QnV6ENGJl0RycNEsqXdQq2cTr0aIf1fujAmhP00wzxAIhJzIkewrr7vOmm31
    3sESkjMdXOqL6PPNqG4TlTCFxHtGDu/UsACJsxbaFo6jrLk1xomjaqgxTkq9HmTm
    LjKty8lL6S1W7t6VDARNGAaE5H+62DDsWSbPgZhdJ3TAp2s7vmso7pTNDjykrmjj
    Z68oog==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=tgPBsQ2P;
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
      header.i=@1e100.net header.b=tgPBsQ2P;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwqUU0sdMgG11J3YfsjMNMC8fWaN0L2097/GAtPNOwchp6pziqnu+OAYMiyyFcTEVjFGL7r9EGGPS2vDKG1LiIWE3c9SV+SYIeuq7to4Kg6Lgwa2KXl
    L1kbt+ef4ebr5bDqYEz7MWKn+AFnc32AX1uIt7VxjxYmRtsFNEm7uTnEyERLoD3bcTNxDkkmAZJhSMbzITmJc803oyS9wdNYjD7f0qpF5Gs/ByNmB8TUm26r
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=aDEGPfzhpcUtIpsYiqsA:9 a=qiGbVALeC94A:10 a=qzgJG8r8dzAA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935621AbeE2PNT (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:13:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51022 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934941AbeE2OoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:02 -0400
X-Google-Smtp-Source: AB8JxZqlFkCaHT+u94fXRN7WHv9F0zZijqUZlFB5lR0hkyQWbTecYdfd4D0r4uHz1vkMwyue1/G77Q==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/39] ovl: add ovl_write_iter()
Date: Tue, 29 May 2018 16:43:17 +0200
Message-Id: <20180529144339.16538-18-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement stacked writes.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index bbc40a14acf8..a7af56861aa5 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -195,9 +195,48 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct fd real;
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	inode_lock(inode);
+	/* Update mode */
+	ovl_copyattr(ovl_inode_real(inode), inode);
+	ret = file_remove_privs(file);
+	if (ret)
+		goto out_unlock;
+
+	ret = ovl_real_fdget(file, &real);
+	if (ret)
+		goto out_unlock;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
+			     ovl_iocb_to_rwf(iocb));
+	revert_creds(old_cred);
+
+	/* Update size */
+	ovl_copyattr(ovl_inode_real(inode), inode);
+
+	fdput(real);
+
+out_unlock:
+	inode_unlock(inode);
+
+	return ret;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
 	.llseek		= ovl_llseek,
 	.read_iter	= ovl_read_iter,
+	.write_iter	= ovl_write_iter,
 };
-- 
2.14.3
