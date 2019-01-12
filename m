Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73C820836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="RFlhbROx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfALSYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:24:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55410 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:24:52 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so7650042ith.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGdc6ZAHO71r4iEGIQRpzdsd9638cgOO1tSjP/bGKak=;
        b=RFlhbROx7aNot7KsfcbtJ2UQAffPOeOOGK7CQF41bUUPIhK9An0q86JRDPQoppMVfK
         RDHiKUC6k3ObfEchtaY6xuAawmP6xUWarpYRjxO/5kme/WlBVzp1O1TLtmAV6oDhTU9b
         Pl3ZWRkmMUeMWnv5Ul1puxtY70KYSYCjGM5HdrP4R9t8hXm1RUC52qiMtzCGO3zBZQFE
         zCClgoLs0J2CtQMXvJLlr+XlVQnAtX0GKNetF4s5SDwjsjzjKmCn128LWYo+405ziS5u
         OLYpGEdikadzocLUpX65mjtZ176TktkrLXmp9rzZBBkAvmfvxSg2JXZUEaqmemssA37u
         1PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGdc6ZAHO71r4iEGIQRpzdsd9638cgOO1tSjP/bGKak=;
        b=UjBSCx4Z6bLxan0BR3O36ws2E6WJBphLmLmzwOhqWUQeSj0WfcbdmgSaDe2zheLZtU
         4KiIXBGujquJdIYpmpa37T8sRv6N7GIpFXq8/MqTuYM/QDl4t+T1LWLoHPN/+oxus3+9
         NNzs5oVpMe7iJXylhc9wU358tHdrUmmSHqkGiBCl4GHppO+X+fNdUUpUjV/CxYxpy/oC
         KyLHt29c0zFsQGPiql3IVYJghaTNf/Z1RsVyBNOwcwRtWn2YS0JpbhSjUoq5qxrEY+7E
         FzXQO7l0paq1vOwORgJlJe+L/F+Wt68pQTN3kAOs7zxp8FmMdFUvwgobwcocyYTKpIsQ
         CvwA==
X-Gm-Message-State: AJcUuke0+nbFuj9i64GFXaZQBtcM0kIILWOoLBAhzck3HCGPo43meWF7
        YjD93yULIQPsXCtI4CEUnMtmhhhWyL+tZTP5
X-Google-Smtp-Source: ALg8bN5kcwiYVommAv22zEZ5+/lgziY11qeKa08SHbwuElHDHk6KikP5SvZ/Omkick6WQYQ8WdXrxg==
X-Received: by 2002:a24:fdc4:: with SMTP id m187mr4135396ith.75.1547317491262;
        Sat, 12 Jan 2019 10:24:51 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2601:282:901:dd7b:c69:9cc7:f9cf:ff1b])
        by smtp.gmail.com with ESMTPSA id g186sm10968125ite.39.2019.01.12.10.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 10:24:50 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] seccomp: fix UAF in user-trap code
Date:   Sat, 12 Jan 2019 11:24:20 -0700
Message-Id: <20190112182420.4669-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CAGXu5j+9ETYcavj2x3Up0FhvkopZohbJcS4CMvrrCWOwDurSFw@mail.gmail.com>
References: <CAGXu5j+9ETYcavj2x3Up0FhvkopZohbJcS4CMvrrCWOwDurSFw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the failure path, we do an fput() of the listener fd if the filter fails
to install (e.g. because of a TSYNC race that's lost, or if the thread is
killed, etc.). fput() doesn't actually release the fd, it just ads it to a
work queue. Then the thread proceeds to free the filter, even though the
listener struct file has a reference to it.

To fix this, on the failure path let's set the private data to null, so we
know in ->release() to ignore the filter.

Reported-by: syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
This is a little ugly, but I can't really think of a better way (other than
force freeing, but the fput function that does the actual work is declared
static with four underscores :).
---
 kernel/seccomp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d7f538847b84..e815781ed751 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -976,6 +976,9 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	struct seccomp_filter *filter = file->private_data;
 	struct seccomp_knotif *knotif;
 
+	if (!filter)
+		return 0;
+
 	mutex_lock(&filter->notify_lock);
 
 	/*
@@ -1300,6 +1303,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 out_put_fd:
 	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
 		if (ret < 0) {
+			listener_f->private_data = NULL;
 			fput(listener_f);
 			put_unused_fd(listener);
 		} else {
-- 
2.19.1

