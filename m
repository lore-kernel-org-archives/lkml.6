Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A031C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB222082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bC2UnYiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB222082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeLCU0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:26:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34723 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLCU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:26:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so7051261plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+IcBgKidvB6Yvsd9O5agQ00SaFZhpKEVo7T4GK5Mo8=;
        b=bC2UnYiWvt7hgtzcApdsxeBdkGfwKLEkbP4hAGnE2B99jGkmSYd5ny139BiGKwKQSu
         6beoN8tcXxF9xfC8dVu7DM6H2geBuRMRe8dvQMt704jqzJM7oPlMdLLMZ9and+jMLvsQ
         toG9Q1P+N3VykvQ8KkG4q8DhQHsm90In+RnBr2Bt7X4lUV6V18gA3g+nqL9WUrQYfsXg
         WWhVnytMAoZeSKUJZ0RLNCrrbJU0cO+4PulrdIzOH5UAdWd9Z44RFal7zXrR5tWix7uz
         Y88Ud1LONwPJilg5CNDEBzA8YhqLL/efV/PGZEhFVrJNJIlWLjtveoMQyIHuP8bOJGVb
         TBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+IcBgKidvB6Yvsd9O5agQ00SaFZhpKEVo7T4GK5Mo8=;
        b=Uom0dR8hWzbYv/xOSVxnhazX2BSaUd6ctO7qC9DZf1/PTphrvkF5EDKdmM1SuI9mLF
         NScBTUrTJlR+DCCdzIe/fbEsmQ54thMZVAUaEKDCH7MsM0UyaG7TFZOLA4kKuD9gRe7r
         m0RtH8kIeEVwGUPI2LaBHARvHRs3wbysBoq1rv98ZpuR6KZ+il0x2tR0QYmN1uElQ+rd
         Xxspl2g8P2Dqhy/vt+EU4Vs1NCcOc4T6l+6Rwh2spGohHOUphOs55uX2bzoiglut4wuL
         FJWZByZM8kw0CzxmpXetospvCoaEuPF7sDeXSfTX/tFcfWmN+WcBlPB7dAP4sIQQ0H7X
         bmdw==
X-Gm-Message-State: AA+aEWZAnPwfVl3+AMUeYUg1vPdzSBOBtE2j85snbP/cNvMKrsZn+w+Z
        Zg9MagJ2k0qLw8svXlAm8uXiIA==
X-Google-Smtp-Source: AFSGD/VtUj0bXphvnXyQvgPMnIKbgiJf3ZHlh51Utv0n0QANnXFONjpamFMn4OFvrZ28Zq0YicE+Zw==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr17856836plf.202.1543868776317;
        Mon, 03 Dec 2018 12:26:16 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id q7sm16562725pgp.40.2018.12.03.12.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:26:15 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com, Jann Horn <jannh@google.com>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] binder: fix use-after-free due to fdget() optimization
Date:   Mon,  3 Dec 2018 12:24:57 -0800
Message-Id: <20181203202457.228972-4-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181203202457.228972-1-tkjos@google.com>
References: <20181203202457.228972-1-tkjos@google.com>
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

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
Acked-by: Martijn Coenen <maco@android.com>
---
 drivers/android/binder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c525b164d39d2..cbaef3b0d3078 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4774,6 +4774,13 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
 
@@ -4885,6 +4892,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		pr_info("%d:%d ioctl %x %lx returned %d\n", proc->pid, current->pid, cmd, arg, ret);
 err_unlocked:
 	trace_binder_ioctl_done(ret);
+	fput(filp);
 	return ret;
 }
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

