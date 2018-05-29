Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605122-2-16195385669180494477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605122; b=ZylJXQ894ZoGP4+uMEBHfA+FzBawIt5BfGlUdzYxZZndbfz6CJ
    43fafaW2EFpNcjasKQYBcFc/+BANtl10S91HKq/1kVFinoOm3zxxqF7nzL+SR//h
    FtSB6D9r8WNfZBGB5q4/u4s53HhABUNxnTwgERSd2ncfyPhtFjeJlxWMehakYtmp
    zUpJ6xnPYGyTlzEAOawHorURPuLCsdDJs91a2yRNaemJ8c4/jhqp8GxpnKmqiAWR
    gjj/aUkvroFzhklIxXzUv4TKjrehazWJg5XVQcBJDVxfqBus/Uwlu9mGE2wfmlgL
    fn/KnBIY3Wx2QAzqw/1Gk8+XyZczak3vp2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605122; bh=
    V2OmmVFBuUSgQckE8B0XrGIAQg/4IsUcPqZSEaSvA5o=; b=TJruREHZPeTWrmQf
    3i+CupRs8wOLlbQyCsmg3MJ4Ylkw6252UAcogUmANGFolfy0CwfCJYECi2+/TaT1
    yl3++QqwjgBpOUkJ9Xe0fJsJzaHSftQCvvgSL/XCzIeGQjVl0SP7Z3Caqv0coUWZ
    N6bVzwqclECE6JT/3VpCkYvxgKKwvqVbud2wz+MpeBj6cc/tfHg85Itl5pJVk9fO
    Mc6S+DthORNuk++b5Jb+iQtmpBj5jBzoXfNi3JZ7YB0ZkLhsseq/Bk3sd6GMB0yx
    hX/mq+xZU9yS5kcSgJ3vaPByWWmSRESYDukfPjde/XkVb4lZsssZPDap1ycbvc7k
    60RkbA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=STsYJ5Mq;
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
      header.i=@1e100.net header.b=STsYJ5Mq;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBBix6JmOidGdkXrkRtyeLpkNETCegtv6x9a6ShIJ4xvBa8HruFuaFinpFFKRVI5sw5lZtEz7q8FT5s6nxKQsltVdKpil6gzabkQ1OxSebcFEqUk49Ts
    f+PS+/qf8kad7rvnL+C0MWWWmm1uikfo59Xn1OG4RaZHbwPRlg4OeMzuUiE6p6/asufu0chXLHU8GZQEWDzysdxHhmR0hMqWwvkwFbeEqXaWsyGuDbfUh4L+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=Kw2C7IlGw84V2FLLsU0A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936504AbeE2OpD (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:45:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38188 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935738AbeE2OoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:12 -0400
X-Google-Smtp-Source: ADUXVKJNYZMTG2hoqbWv+uFvhjFKQPME7czahmzcod+S4qi1NQRuTnFcGGjf+epfukY/9vjLjrE4lQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/39] vfs: don't open real
Date: Tue, 29 May 2018 16:43:25 +0200
Message-Id: <20180529144339.16538-26-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Let overlayfs do its thing when opening a file.

This enables stacking and fixes the corner case when a file is opened for
read, modified through a writable open, and data is read from the read-only
file.  After this patch the read-only open will not return stale data even
in this case.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/open.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 6e52fd6fea7c..244cd2ecfefd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -897,13 +897,8 @@ EXPORT_SYMBOL(file_path);
 int vfs_open(const struct path *path, struct file *file,
 	     const struct cred *cred)
 {
-	struct dentry *dentry = d_real(path->dentry, NULL, file->f_flags, 0);
-
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-
 	file->f_path = *path;
-	return do_dentry_open(file, d_backing_inode(dentry), NULL, cred);
+	return do_dentry_open(file, d_backing_inode(path->dentry), NULL, cred);
 }
 
 /**
-- 
2.14.3
