Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA2BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F394F2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="n3DVVkYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbeLNUi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:38:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43270 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeLNUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:38:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so3351008pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIL5MoHVVuSxBBC4nxmZ91YUlP2AwdnMAwNEVyYgpK0=;
        b=n3DVVkYPdVm2Wibb9duwQn9N9P6PLcmu187QfG9OutdVwhffe+6qz++k9QUtrSPUtE
         GZyFhmr+C2yDvVDz737Cc0nNfcDq6VOoUcJ3lPKBoEILLo+4SelwWPZE33CbaIjtqKgc
         oE4NWFj862XTu9k5ngkGF5PEqF37Y/C4tII1+Tv+JsqMZz9ZkcyFWoIcm+9PbUBGi9Xv
         j4SZ2unoT8lbCXyKa61Tf057ePOWOkYm2jOUgjSRaCNGzsOKzeTXrx82nUpbHJeNQvmX
         X9DK/xwdqrO8KrX2n0iCPCGJ/+Mq4U2gOTMbkDvOEtiQ2QgzCkwHtNrtrwGRSNn3nqUJ
         hKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIL5MoHVVuSxBBC4nxmZ91YUlP2AwdnMAwNEVyYgpK0=;
        b=kCRXqTLR4azv3i7Jf9UCs/typuhNmqHvTqRY3CTq2Dr29DSljVWhmPbxuIBKQb0ffT
         zT5CwTc45FVFvZA8ATswq6YBX4oGmLww+28DI0D0DUI/tLUIOoP1SaIzHCH12/R6+bdl
         NpWh9x5wJCUhjSuk1qIZ1NMwT5J/J31ORb1j3lY+RbK8wsE3CvI2BXayJNjRwJnWdbus
         JDRpvth3wChhux4WAkFj/B484nE1CqebWHdwYEkinNcglxBV+nYnd/MhLfHn/9kQNBdi
         RNTaEk76SuEE65sg/+ZOr2uSl37ooOs8zlG7xZVdmGR5kCqZDMfeswVEPD15ZnxyxVEE
         Fq3Q==
X-Gm-Message-State: AA+aEWa6PxiP2jh6K5mG62ooZJcR8jU+Ed6lrKSzCp5+HR1p94CF7n3Q
        fy2P/X1BEX+7LD0ROepWL0P7xw==
X-Google-Smtp-Source: AFSGD/W7SxP2RbgfQAQ55htawYcPDMm2QjFzN6O4tqrtaV1G/4l5U3xWwL0Di2CkqyYCs1iFkMgZoA==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr4346201pfx.204.1544819906501;
        Fri, 14 Dec 2018 12:38:26 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id f6sm8242185pfg.188.2018.12.14.12.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 12:38:25 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, viro@zeniv.linux.org.uk
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2] binder: fix use-after-free due to ksys_close() during fdget()
Date:   Fri, 14 Dec 2018 12:38:15 -0800
Message-Id: <20181214203815.217014-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

44d8047f1d8 ("binder: use standard functions to allocate fds")
exposed a pre-existing issue in the binder driver.

fdget() is used in ksys_ioctl() as a performance optimization.
One of the rules associated with fdget() is that ksys_close() must
not be called between the fdget() and the fdput(). There is a case
where this requirement is not met in the binder driver which results
in the reference count dropping to 0 when the device is still in
use. This can result in use-after-free or other issues.

If userpace has passed a file-descriptor for the binder driver using
a BINDER_TYPE_FDA object, then kys_close() is called on it when
handling a binder_ioctl(BC_FREE_BUFFER) command. This violates
the assumptions for using fdget().

The problem is fixed by deferring the fd close using task_work_add()
so ksys_close() is called after returning from binder_ioctl().

Fixes: 44d8047f1d87a ("binder: use standard functions to allocate fds")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2:
- simplified code

If possible, please add to 4.20-final

 drivers/android/binder.c | 60 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c525b164d39d2f..5d0233ca852c5d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,6 +72,7 @@
 #include <linux/spinlock.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/task_work.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -2184,6 +2185,61 @@ static bool binder_validate_fixup(struct binder_buffer *b,
 	return (fixup_offset >= last_min_offset);
 }
 
+/**
+ * struct binder_task_work_cb - for deferred close
+ *
+ * @twork:                callback_head for task work
+ * @fd:                   fd to close
+ *
+ * Structure to pass task work to be handled after
+ * returning from binder_ioctl() via task_work_add().
+ */
+struct binder_task_work_cb {
+	struct callback_head twork;
+	int fd;
+};
+
+/**
+ * binder_do_fd_close() - close list of file descriptors
+ * @twork:	callback head for task work
+ *
+ * It is not safe to call ksys_close() during the binder_ioctl()
+ * function if there is a chance that binder's own file descriptor
+ * might be closed. This is to meet the requirements for using
+ * fdget() (see comments for __fget_light()). Therefore use
+ * task_work_add() to schedule the close operation once we have
+ * returned from binder_ioctl(). This function is a callback
+ * for that mechanism and does the actual ksys_close() on the
+ * given file descriptor.
+ */
+static void binder_do_fd_close(struct callback_head *twork)
+{
+	struct binder_task_work_cb *twcb = container_of(twork,
+			struct binder_task_work_cb, twork);
+
+	ksys_close(twcb->fd);
+	kfree(twcb);
+}
+
+/**
+ * binder_deferred_fd_close() - schedule a close for the given file-descriptor
+ * @fd:		file-descriptor to close
+ *
+ * See comments in binder_do_fd_close(). This function is used to schedule
+ * a file-descriptor to be closed after returning from binder_ioctl().
+ */
+static void binder_deferred_fd_close(int fd)
+{
+	struct binder_task_work_cb *twcb;
+
+	twcb = kzalloc(sizeof(*twcb), GFP_KERNEL);
+	if (!twcb)
+		return;
+	init_task_work(&twcb->twork, binder_do_fd_close);
+	twcb->fd = fd;
+	task_work_add(current, &twcb->twork, true);
+}
+
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_buffer *buffer,
 					      binder_size_t *failed_at)
@@ -2323,7 +2379,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			}
 			fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
 			for (fd_index = 0; fd_index < fda->num_fds; fd_index++)
-				ksys_close(fd_array[fd_index]);
+				binder_deferred_fd_close(fd_array[fd_index]);
 		} break;
 		default:
 			pr_err("transaction release %d bad object type %x\n",
@@ -3942,7 +3998,7 @@ static int binder_apply_fd_fixups(struct binder_transaction *t)
 		} else if (ret) {
 			u32 *fdp = (u32 *)(t->buffer->data + fixup->offset);
 
-			ksys_close(*fdp);
+			binder_deferred_fd_close(*fdp);
 		}
 		list_del(&fixup->fixup_entry);
 		kfree(fixup);
-- 
2.20.0.405.gbc1bbc6f85-goog

