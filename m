Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2478A2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZWL8FW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2478A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeKNXKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:10:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35294 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeKNXKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:10:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so318902wrb.2;
        Wed, 14 Nov 2018 05:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jY/UFCz8PIRjByHlsuj/mXPL0j5ejHSHK+uh3DIbbNM=;
        b=aZWL8FW4yXYu8oqV/AM4BhNybsj8Ivji6xTdEPM9it7a6N9hR5//9iyMS64zuedKjg
         zPJy515qFP9xG/7sHm365y9V00bF7ut/xjIUTOYPvTSxZVKLNZL8GSOPIwDtzi/VXRMn
         UBtwxVQ/Dx45FmQjg5nIEkjWk4v72SfHBpdsCO4ii7JgNmZeBpLj6mbV7CNfRyZPyfKE
         MMWIwm2GOx/lqj8d7mE+Dx6JW4Rcl54qezuqBg86y8oC5UncB83JgH1Jkh710Rp+EZ/d
         Rrmc7jwzKiW/VNzxkdLZHJWRN2o/tbyV5iyaIFYsHfqo3MhVp8vQnkgZHGBIFP4zel+4
         csAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jY/UFCz8PIRjByHlsuj/mXPL0j5ejHSHK+uh3DIbbNM=;
        b=NF5KwlxCyucKnSocAa6WMDeuZ3tlBaWJCsHC7J4MERTXand4hUoKuZfAM0wFZ0VsyG
         loyZdxX/5ypam0TPND4I6Xw4UfDYDEHJanaMZWIFedihRb40Zv4qDqVnEOV/yWe221X+
         oCuhYLC2WPXZV70jDpVpZriF6kM+DMHhXE9DuOtZa+FLUqZhu9I5qazztWOQ4nKKfcAe
         1Ae5EizFtGredmyBwCizfS24/D1ifWuyAO2vKhV5nWAK48DY9PVScB2eywhbhQZIfOEX
         p8Nm2mJuImrp4lOAS4ZyzFx7iyKxi1UxagjIeqj4Elp/8V7iMS/IdhTjuSi7/7/mXL5F
         R9kw==
X-Gm-Message-State: AGRZ1gKW2rM6qd8PVNau4OPbN4yqePoKLmJ1eOJUNEz3ZyRcQjU/3VOa
        MVjMgLdgPgIVs3mRceJI5R5l1Kts
X-Google-Smtp-Source: AJdET5c5uy5es4HRMB1Rj3aLX63X7h/fVIx8we5sRDm6RrV1X0mOoHGoI/Nu+vs3Rk3TQBlJFDXsJw==
X-Received: by 2002:adf:9170:: with SMTP id j103-v6mr1877263wrj.217.1542200851052;
        Wed, 14 Nov 2018 05:07:31 -0800 (PST)
Received: from david-x1.fritz.box (p200300C2A7086500829F3F8E4928CB10.dip0.t-ipconnect.de. [2003:c2:a708:6500:829f:3f8e:4928:cb10])
        by smtp.gmail.com with ESMTPSA id r19-v6sm14154473wmh.0.2018.11.14.05.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 05:07:30 -0800 (PST)
From:   David Herrmann <dh.herrmann@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com,
        David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: uhid: prevent splice(2)
Date:   Wed, 14 Nov 2018 14:07:12 +0100
Message-Id: <20181114130712.21028-1-dh.herrmann@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has a default implementation of splice(2) for writing from a
pipe into an arbitrary file. This behavior can be overriden by
providing an f_op.splice_write() callback.

Unfortunately, the default implementation of splice_write() takes page
by page from the source pipe, calls kmap() and passes the mapped page
as kernel-address to f_op.write(). Thus, it uses standard write(2) to
implement splice(2). However, since the page is kernel-mapped, they
have to `set_fs(get_ds())`. This is mostly fine, but UHID takes
command-streams through write(2), and thus it might interpret the data
taken as pointers. If called with KERNEL_DS, you can trick UHID to
allow kernel-space pointers as well.

As a simple fix, prevent splice(2) on UHID. It is unsecure, but it is
also non-functional. We need a linear mapping of the input in UHID, so
chunked input from splice(2) makes no sense, anyway.

Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3c5507313606..fefedc0b4dc6 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -753,6 +753,15 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	return ret ? ret : count;
 }
 
+static ssize_t uhid_char_splice_write(struct pipe_inode_info *pipe,
+				      struct file *out,
+				      loff_t *ppos,
+				      size_t len,
+				      unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static __poll_t uhid_char_poll(struct file *file, poll_table *wait)
 {
 	struct uhid_device *uhid = file->private_data;
@@ -771,6 +780,7 @@ static const struct file_operations uhid_fops = {
 	.release	= uhid_char_release,
 	.read		= uhid_char_read,
 	.write		= uhid_char_write,
+	.splice_write	= uhid_char_splice_write,
 	.poll		= uhid_char_poll,
 	.llseek		= no_llseek,
 };
-- 
2.19.1

