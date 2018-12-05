Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8EA2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="AI5Fq5OQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8EA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeLEVQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:16:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43056 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeLEVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:16:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so10647066plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzlyMr4gV6alg0ML5kLvRz/5I637k7fZn3qThSG6Ggg=;
        b=AI5Fq5OQgUWQkQ25phnBZukk3hFX9R+SFH6/znOG3A2JSmwMtFLhbN2ZlmwYv3y+7S
         UL6z7Jzz2EQ0kId9iSXSJeLB1kav4Uw5+sn8hUmURxbKhOkVdFjL+83vaNsFeGovRcYn
         UDmxRaUskwNLeNpq8I8neZ6k0+rk+gZSYSCz0KbE8x2uOQnsY0xjlyyTLTzSRYo5B+HN
         LSWJEtmDjON2hEKC8Ae7PQ9fDH3w97LBKMCI+qKL5ffTNX4vt2IOdYH/sK1pf013+DWA
         lrgmO3abrrmf6I1Yz9yVGqVN6AfMRCnwT3kNA+EizoBpQ0I3z919mbwpAW9s7IphcYtc
         gDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzlyMr4gV6alg0ML5kLvRz/5I637k7fZn3qThSG6Ggg=;
        b=GOKWN3MvM0bLerlFF7G5txPeUQ74Y9WCRyGjsJNDOFypttO8Uxu+54D5lnLpX1Nrsv
         OYFXpUATB7nIr/Pxq6QSEhbDx1O/CnIo7JokcOYYT0rGH64F/ZsXjgq8SjIeAM0jZVJt
         8CKG4pZyEIub1LV52TeMQnjxJQDjBxDRkXliBZTw3kc69e3VJvzKTd/k63xqiBlh3Efr
         vtF1FmqN0pS0yeywiXdiMYPOE9ZMiftH7xvbFAMcJcrYjYhOKfO0CwlIx6lonsa6pv27
         IPQJhNv41CZpN9MOCVhZuPK8/o/UlmqYDxm4pjrYCrRzBg2SgNuON17Sw9x85auWSm9K
         tf0A==
X-Gm-Message-State: AA+aEWZ7SnB9jrdLKN70D0vsZDASGNb5aQfhOb3tKMEcf8XObrYenVYQ
        FMaRm0iLQrCh7F/QjY6j/ymiXg==
X-Google-Smtp-Source: AFSGD/WkbXnJkEe8GYc1PeUWnSxrT/HVgmb3SVmYquTAGyPjenEv/mowjRDMgJZHTln2u6CvJGTf9Q==
X-Received: by 2002:a17:902:5a86:: with SMTP id r6mr24686979pli.301.1544044571093;
        Wed, 05 Dec 2018 13:16:11 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id v13sm28276885pff.20.2018.12.05.13.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:16:10 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com, Jann Horn <jannh@google.com>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v2] binder: fix use-after-free due to fdget() optimization
Date:   Wed,  5 Dec 2018 13:16:01 -0800
Message-Id: <20181205211601.75856-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

44d8047f1d87a ("binder: use standard functions to allocate fds")
exposed a pre-existing issue in the binder driver.

fdget() is used in ksys_ioctl() as a performance optimization.
One of the rules associated with fdget() is that ksys_close() must
not be called between the fdget() and the fdput(). There is a case
where this requirement is not met in the binder driver (and possibly
other drivers) which results in the reference count dropping to 0
when the device is still in use. This can result in use-after-free
or other issues.

This was observed with the following sequence of events:

Task A and task B are connected via binder; task A has /dev/binder open at
file descriptor number X. Both tasks are single-threaded.

1. task B sends a binder message with a file descriptor array
   (BINDER_TYPE_FDA) containing one file descriptor to task A
2. task A reads the binder message with the translated file
   descriptor number Y
3. task A uses dup2(X, Y) to overwrite file descriptor Y with
   the /dev/binder file
4. task A unmaps the userspace binder memory mapping; the reference
   count on task A's /dev/binder is now 2
5. task A closes file descriptor X; the reference count on task
   A's /dev/binder is now 1
6. task A forks off a child, task C, duplicating the file descriptor
   table; the reference count on task A's /dev/binder is now 2
7. task A invokes the BC_FREE_BUFFER command on file descriptor X
   to release the incoming binder message
8. fdget() in ksys_ioctl() suppresses the reference count increment,
   since the file descriptor table is not shared
9. the BC_FREE_BUFFER handler removes the file descriptor table
   entry for X and decrements the reference count of task A's
   /dev/binder file to 1
10.task C calls close(X), which drops the reference count of
   task A's /dev/binder to 0 and frees it
11.task A continues processing of the ioctl and accesses some
   property of e.g. the binder_proc => KASAN-detectable UAF

Fixed by using get_file() / fput() in binder_ioctl().

Fixes: 44d8047f1d87a ("binder: use standard functions to allocate fds")
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
Acked-by: Martijn Coenen <maco@android.com>
---
v2: added "Fixes:" tag
Should be added to 4.20-final if possible

 drivers/android/binder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9f1000d2a40c7..d6979cf7b2dad 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4733,6 +4733,13 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
 
+	/*
+	 * Need a reference on filp since ksys_close() could
+	 * be called on binder fd and the fdget() used in
+	 * ksys_ioctl() might have optimized out the reference.
+	 */
+	get_file(filp);
+
 	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
 			proc->pid, current->pid, cmd, arg);*/
 
@@ -4844,6 +4851,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		pr_info("%d:%d ioctl %x %lx returned %d\n", proc->pid, current->pid, cmd, arg, ret);
 err_unlocked:
 	trace_binder_ioctl_done(ret);
+	fput(filp);
 	return ret;
 }
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

