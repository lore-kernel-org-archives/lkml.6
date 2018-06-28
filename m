Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4B5277D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpydZ2RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4B5277D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030546AbeF1SkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:40:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38086 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934003AbeF1SkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:40:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id j17-v6so2999282pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=k6lgf5xSFlRWOnN3RpSVDIW4vpmspmDdWvYcqmRBN8U=;
        b=LpydZ2RVfQMAx7UNFVsAs+xku5G+YlfnvInnorQYx0WmrXT/xzvwAaRL17+ShXFOzi
         swMn6MPmotoUfygKMAAvKyU/wIhkTOw1+i+GD5bMk+iyIP5Os9ifFhO0f265ktkywCQz
         g7A5mhSv+lzfKow8X3e5qsvJMbLd8DPFY30ZEB6JuhMUg5U6e8BvLhf183xQEZSwwniN
         Q4LQefhlwfcaMZyjZRuJM0p5EPt2x3doM1YCHLWvZyOb8E/b8rhu3JZiRzgQQTmcLBwx
         i4BUVWzBD86W2zDvJUC7MY9YmEUQZVv+F1wGJONBfVyLw0+Dkrs22U1NBjx1O3UZb+Yf
         ajrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=k6lgf5xSFlRWOnN3RpSVDIW4vpmspmDdWvYcqmRBN8U=;
        b=VIhui/Mo0UzPSTLNglc+WP4yNLDnA8S+xwZ2WJl9VT+Slh8iN187EBS7mw3C872l3L
         P5JbyJ7b3QOHGpcWLWNYW6ydbc07anO94XupetlawprWPWtg+1RQp1jDrLfaSPY3e2U2
         OU26y56nWDkNb0VrJVL4tJQAxUIW8uvwWd7TABlZkAWIcSS4YnaxipIL3nvAc+AIeTvx
         qGiu41NqKYLX91X5q60T9f/DHIBL7vYrvTW9A8tgGq6O9wwwnnBi5l4ZL3LS7PHw2/4A
         3zS4TQiwzXJ/4hL9Cexx9bd49SVUHFCL16Kmx1Q2GsEEYvpe4g52lg80g/q5IdV9a8au
         PATQ==
X-Gm-Message-State: APt69E2OFcZo5/XrDqLRGxujZ8tl2EXKzIkjAvoJ1SCWwghYU30vQ7ig
        LO7QLxcQ8dOi2AQg+ndm/wrSeA==
X-Google-Smtp-Source: ADUXVKJQqQZnsk7nCeHbY839Hj/a9/ORKfcy44ldsbBJQM17x1Or2fU5tk3H0cJx03D01dMQlywDrA==
X-Received: by 2002:a63:a319:: with SMTP id s25-v6mr9854589pge.62.1530211212954;
        Thu, 28 Jun 2018 11:40:12 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.128])
        by smtp.gmail.com with ESMTPSA id a27-v6sm12817631pfc.18.2018.06.28.11.40.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 11:40:11 -0700 (PDT)
Date:   Fri, 29 Jun 2018 00:12:40 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: Adding new return type vm_fault_t
Message-ID: <20180628184240.GA17183@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For now,
this is just documenting that the function returns a VM_FAULT
value rather than an errno. Once all instances are converted,
vm_fault_t will become a distinct type.

See the following
commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Fixed checkpatch.pl warning.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/orangefs/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index db0b521..a5a2fe7 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -528,18 +528,19 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	return ret;
 }
 
-static int orangefs_fault(struct vm_fault *vmf)
+static vm_fault_t orangefs_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
-	int rc;
-	rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
+	int ret;
+
+	ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
 	    STATX_SIZE);
-	if (rc == -ESTALE)
-		rc = -EIO;
-	if (rc) {
-		gossip_err("%s: orangefs_inode_getattr failed, "
-		    "rc:%d:.\n", __func__, rc);
-		return rc;
+	if (ret == -ESTALE)
+		ret = -EIO;
+	if (ret) {
+		gossip_err("%s: orangefs_inode_getattr failed, ret:%d:.\n",
+				__func__, ret);
+		return VM_FAULT_SIGBUS;
 	}
 	return filemap_fault(vmf);
 }
-- 
1.9.1

