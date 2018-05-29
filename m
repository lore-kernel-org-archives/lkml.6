Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2266183-1527607048-2-9110496217603046169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527607048; b=MZchIb9uSmdyS1pfrYdIsP02UTKSaMMCHdBdNuuIalj21d9kLf
    sRFNGhA2999k1h6ae4mVHOgWW1NevSmNpMHUM1ZrWp4AZiHELE+Q03EDhJb5ROg6
    9+FkNBv1GzW21b0A4WsVHBqqxjdE+q6Ui/ZyQLBz5EvN3RI+LtoHla/e+FUHg/tU
    1mTvs0RiEpRJncpLnzBWkZO4WK37DVE9EbeYhiJvaHZq57ecpIOZZHwp/XBQsSaT
    HCtPmsTHJkfq2t6r9Tn5UTBbyDBNXMs1+3S1ufjWsZ8sZMkr7tAVwiTuDmef96xf
    djODIFKhS66Pke8kBdr+2+pgBjwC8oxSbsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527607048; bh=
    j3FkgtHWNO7DF/r/Zz49vsxAaVEsFcvlr1N8qV55l0s=; b=kDBx/GOQ7eK+seR3
    9gZuwAwMq5a4Mkard8ojyGssQR6vrTzlRkhbUdTlJc8T5wbhzYnsFfVws3QMnqjY
    S6pIP2wiWw5z8tIZF+u3B/IPRHWe8lR6jxQU2hVvXI9voc9XtrysisOFVdo6yU3o
    qB23MAnoR5GU//ZsDRq+IEaI35/QVyZ0dh2UvQB9PBzS6e8hE3Xz3qzLDSY0XvIm
    aAPyvrk6Lo+0Ik82K88iXCD6Mk3ifbnevTj3lwSpuOhCJe7h3FcqSdqqgUF+pBHu
    U48n+GsrUHAWUlNzPXqro+mIZ3gIT9RLh07rfNZS28d9FM0VAH+xcMYBPR/e7LWs
    5uBg+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=CSiOdt+1;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=CSiOdt+1;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNB2ifOvWzlX5W31uBtJO32FocMkwiCn/uzpg5b7DR8UWgDNx+XCbXVCh6mqAqKIemppcJ7IGsn/4z767jL8v5Ebd6JXk3G0Wt9gdRywqqxDo2Hg0VWi
    fqrr6XBcSK04Q0ndHhQhqvZ0+CBcIA1IgJLIyBGVWQ5H1yDAXATfq3+aw1ZQz1McpdD/n5RTauVjauIbFX7W4eUFfGNW/0OoygXW1aGfXAiFPvT/9yPgGE03
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=gVocdEXu7pXj5AOg9YQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935233AbeE2PQu (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:16:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41450 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935243AbeE2Onp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:45 -0400
X-Google-Smtp-Source: AB8JxZqVHmFFKyS2ihngK7X4slfDu5HB/uKBzdkfL97l8JWhVCV00M407zf1esjVhWFRua2I+UnOzQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/39] vfs: dedupe: extract helper for a single dedup
Date: Tue, 29 May 2018 16:43:03 +0200
Message-Id: <20180529144339.16538-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Extract vfs_dedupe_file_range_one() helper to deal with a single dedup
request.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/read_write.c | 89 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1818581cadf6..82a53c44c0aa 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1964,6 +1964,44 @@ int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
 
+static s64 vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
+				     struct file *dst_file, loff_t dst_pos,
+				     u64 len)
+{
+	s64 ret;
+
+	ret = mnt_want_write_file(dst_file);
+	if (ret)
+		return ret;
+
+	ret = clone_verify_area(dst_file, dst_pos, len, true);
+	if (ret < 0)
+		goto out_drop_write;
+
+	ret = -EINVAL;
+	if (!(capable(CAP_SYS_ADMIN) || (dst_file->f_mode & FMODE_WRITE)))
+		goto out_drop_write;
+
+	ret = -EXDEV;
+	if (src_file->f_path.mnt != dst_file->f_path.mnt)
+		goto out_drop_write;
+
+	ret = -EISDIR;
+	if (S_ISDIR(file_inode(dst_file)->i_mode))
+		goto out_drop_write;
+
+	ret = -EINVAL;
+	if (!dst_file->f_op->dedupe_file_range)
+		goto out_drop_write;
+
+	ret = dst_file->f_op->dedupe_file_range(src_file, src_pos,
+						dst_file, dst_pos, len);
+out_drop_write:
+	mnt_drop_write_file(dst_file);
+
+	return ret;
+}
+
 int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 {
 	struct file_dedupe_range_info *info;
@@ -1972,10 +2010,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	u64 len;
 	int i;
 	int ret;
-	bool is_admin = capable(CAP_SYS_ADMIN);
 	u16 count = same->dest_count;
-	struct file *dst_file;
-	loff_t dst_off;
 	loff_t deduped;
 
 	if (!(file->f_mode & FMODE_READ))
@@ -2010,54 +2045,28 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	}
 
 	for (i = 0, info = same->info; i < count; i++, info++) {
-		struct inode *dst;
 		struct fd dst_fd = fdget(info->dest_fd);
+		struct file *dst_file = dst_fd.file;
 
-		dst_file = dst_fd.file;
 		if (!dst_file) {
 			info->status = -EBADF;
 			goto next_loop;
 		}
-		dst = file_inode(dst_file);
-
-		ret = mnt_want_write_file(dst_file);
-		if (ret) {
-			info->status = ret;
-			goto next_loop;
-		}
-
-		dst_off = info->dest_offset;
-		ret = clone_verify_area(dst_file, dst_off, len, true);
-		if (ret < 0) {
-			info->status = ret;
-			goto next_file;
-		}
-		ret = 0;
 
 		if (info->reserved) {
 			info->status = -EINVAL;
-		} else if (!(is_admin || (dst_file->f_mode & FMODE_WRITE))) {
-			info->status = -EINVAL;
-		} else if (file->f_path.mnt != dst_file->f_path.mnt) {
-			info->status = -EXDEV;
-		} else if (S_ISDIR(dst->i_mode)) {
-			info->status = -EISDIR;
-		} else if (dst_file->f_op->dedupe_file_range == NULL) {
-			info->status = -EINVAL;
-		} else {
-			deduped = dst_file->f_op->dedupe_file_range(file, off,
-							dst_file,
-							info->dest_offset, len);
-			if (deduped == -EBADE)
-				info->status = FILE_DEDUPE_RANGE_DIFFERS;
-			else if (deduped < 0)
-				info->status = deduped;
-			else
-				info->bytes_deduped += deduped;
+			goto next_loop;
 		}
 
-next_file:
-		mnt_drop_write_file(dst_file);
+		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
+						    info->dest_offset, len);
+		if (deduped == -EBADE)
+			info->status = FILE_DEDUPE_RANGE_DIFFERS;
+		else if (deduped < 0)
+			info->status = deduped;
+		else
+			info->bytes_deduped += deduped;
+
 next_loop:
 		fdput(dst_fd);
 
-- 
2.14.3
