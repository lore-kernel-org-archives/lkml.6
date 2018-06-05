Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2539887-1528205400-2-13442652765898922530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528205400; b=Tdg5ZgoqqNuSCdPTSERzrF4fWQcENlVKdoFn8rp7mSOtI/75/K
    7mRMH5+NfR51upDblwggn9YLetnmZ7AbYi5vjzQ9PZl9xE+w/PwwCpJNFRQxFdaN
    eZsYE7wb6HtSi0rfO7jbHrnDlWfhrBDXPEF0DmeqQElrJtP5W3VgRoHmMgmji99A
    Lfz8jHmVnKdDILb6daKeqBpAFdx/r5QXFlg6jXqi55oXEbpA/sjYGxEYLMK37y7J
    25TjeWJMipjRwDLuHhNb+m3+2CILmr/QLEAkSPw1mQtS9US59uJMmZniAF6//7QM
    ICnwwCr2UlbFoLr57/e2ahYCjKW0z4g+C7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1528205400; bh=
    gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=; b=SC0O6wCHMSU2qepY
    z0COBO/cvkFZtkGVnEkHofF4zo1pTN28Z/PZ/F+rpC7h6S02+dTnDfddfJcsTn3e
    GxATBJoFAG5Gcv8A4E8DfRIL5Pjje7rhcc2PCFxvW0zF+uKYT7RDoVSzjjoxDtwb
    RuKYXhNq53AbDnZJW4H+puawsmTP+crbx3aw7Ya2ExcP8cSFqoUjj07fzWe5J+t5
    ewvEa+Wq11Q9fDashnl93GbTBq1SUJ+5edjhuHOSIfTC7n1ujh3cfBHXt4IJn8T/
    GfJUpRVdcKv570+nylmwMWgzjln47ggMqtBavhGVhrul7Luzpu58Jg1oYuai25Ke
    IXHj5Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=toxicpanda-com.20150623.gappssmtp.com
    header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=g/aypdOH
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=EsyQVaSB;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=toxicpanda.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=toxicpanda-com.20150623.gappssmtp.com
      header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=g/aypdOH
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=EsyQVaSB;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=toxicpanda.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKkHduuQiSz5ZZkxMStZEeQGEYrK+xvp+FtFgGpDQS5YOwkV2SIUmiZElZHkGOpu11ZvRidjMSUXjUnvz0nHT7I1l6PjPdlteweXzMDid6eEy8tKMS+7
    rVAyUAHt2qdE22QhipsG3OoJ96aZgxjLfsbiElnjP8ngVdzNpXbobHKQEnFptz7/iCPSHv7AYJ5Nway9Ne+bBixCEg/Em/io7mgvmEvAouNeIwPtGFXmApc8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=FOH2dFAWAAAA:8
    a=VwQbUJbxAAAA:8 a=BeL8SKAei5ND_Z2dT88A:9 a=i3VuKzQdj-NEYjvDI-p3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeFEN3z (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 09:29:55 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38867 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbeFEN3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:29:54 -0400
X-Google-Smtp-Source: ADUXVKJxzeq4laEnJ31hb0Alq20thTOACtbPLhrZ8BwZz2HJvXZcQ/kaO2ihRN5Yxmiy77FSkHjl8w==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 02/13] block: introduce bio_issue_as_root_blkg
Date: Tue,  5 Jun 2018 09:29:37 -0400
Message-Id: <20180605132948.1664-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605132948.1664-1-josef@toxicpanda.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

Instead of forcing all file systems to get the right context on their
bio's, simply check for REQ_META to see if we need to issue as the root
blkg.  We don't want to force all bio's to have the root blkg associated
with them if REQ_META is set, as some controllers (blk-iolatency) need
to know who the originating cgroup is so it can backcharge them for the
work they are doing.  This helper will make sure that the controllers do
the proper thing wrt the IO priority and backcharging.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..69aa71dc0c04 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -238,6 +238,22 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
+/**
+ * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
+ * @return: true if this bio needs to be submitted with the root blkg context.
+ *
+ * In order to avoid priority inversions we sometimes need to issue a bio as if
+ * it were attached to the root blkg, and then backcharge to the actual owning
+ * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
+ * bio and attach the appropriate blkg to the bio.  Then we call this helper and
+ * if it is true run with the root blkg for that queue and then do any
+ * backcharging to the originating cgroup once the io is complete.
+ */
+static inline bool bio_issue_as_root_blkg(struct bio *bio)
+{
+	return (bio->bi_opf & REQ_META);
+}
+
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
-- 
2.14.3
