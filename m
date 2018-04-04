Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CqKyh87vUDAQMZXE1cT2u7RKTsjLeSoe8OdKiE8uWXs0KdXX06A5U7CJqo4fCcy6OPyDp
ARC-Seal: i=1; a=rsa-sha256; t=1522855959; cv=none;
        d=google.com; s=arc-20160816;
        b=guV2Bip8VZuHTZlLlxsP7hXcGjg5O7Zop9VkGI5YNodUig92IkGQmQ+GHeBzaUDbd/
         isLcZszX+FCbsS+NQz9LXtsXtyFvdGluMzXZnnh3MFJ0gaC3R/uRntuqvuVmdfL5ugCk
         hfovKolrEe0GwMQTGoU2gL7FJK8h6DDU2gnadF6VZ8KnJP94DudQsQc1CXspmcaz9Frr
         40vS1GEYSHtjHlzjNasoKQxBUej3jaSzYoadNJhBjv7tTERIzdPujv9ZinmKwcVHhwQL
         IOEJolbmwR6Sqs2WdTfV9VEVtHNHgN09MyfCPKzpQgxE3aEwHSseoFCYtVncto3q3vA+
         EC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :from:cc:to:subject:arc-authentication-results;
        bh=KxvowzqmOP39PSwgXuFU3oicsvtKtNeKkOagWmcOvYY=;
        b=C6xK+oN+E5zJ8QM/oQU+kyRsrPUWRmlUecn7IKZP1XAA7RG1gNRWWAex3OoktWVV/X
         6cw1arqhWsU+twkm20PdWepB1/+YBJTLy4j51jGVvxi+S4cNH1S10xf3miEVRnd9izzt
         4jyBN6SRylZB9GO29VbIdGl3O33QPuWM/OGLagf99L7kMulQ41TOY52amlqS6C3JN8Rc
         sxkQGfUdhc07KVcnfzcPd+2ZSfeXVt3GSlqgYX3AFEXZyX6mlZDCB0arN6OMnMiaxItW
         eQMIkxxVOv2B1hizMcbYTcCzdMN3YEFZTBdEgMfBcGFCx096MM7LxO6jhKFO/1o8i5nE
         050w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Subject: Patch "media: media/v4l2-ctrls: volatiles should not generate CH_VALUE" has been added to the 3.18-stable tree
To: mchehab@s-opensource.com,gregkh@linuxfoundation.org,hans.verkuil@cisco.com,linux-kernel@vger.kernel.org,linux-media@vger.kernel.org,mchehab@infradead.org,mchehab@osg.samsung.com,ricardo.ribalda@gmail.com
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Apr 2018 17:32:38 +0200
In-Reply-To: <1663cf48e2eb96405c5d6d874020aa9925ee217f.1522260310.git.mchehab@s-opensource.com>
Message-ID: <15228559581742@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596830210453367963?=
X-GMAIL-MSGID: =?utf-8?q?1596830210453367963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    media: media/v4l2-ctrls: volatiles should not generate CH_VALUE

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     media-media-v4l2-ctrls-volatiles-should-not-generate-ch_value.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Apr  4 17:30:18 CEST 2018
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Wed, 28 Mar 2018 15:12:35 -0300
Subject: media: media/v4l2-ctrls: volatiles should not generate CH_VALUE
To: Linux Media Mailing List <linux-media@vger.kernel.org>, stable@vger.kernel.org
Cc: Ricardo Ribalda <ricardo.ribalda@gmail.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
Message-ID: <1663cf48e2eb96405c5d6d874020aa9925ee217f.1522260310.git.mchehab@s-opensource.com>

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

Volatile controls should not generate CH_VALUE events.

Set has_changed to false to prevent this happening.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1619,6 +1619,15 @@ static int cluster_changed(struct v4l2_c
 
 		if (ctrl == NULL)
 			continue;
+		/*
+		 * Set has_changed to false to avoid generating
+		 * the event V4L2_EVENT_CTRL_CH_VALUE
+		 */
+		if (ctrl->flags & V4L2_CTRL_FLAG_VOLATILE) {
+			ctrl->has_changed = false;
+			continue;
+		}
+
 		for (idx = 0; !ctrl_changed && idx < ctrl->elems; idx++)
 			ctrl_changed = !ctrl->type_ops->equal(ctrl, idx,
 				ctrl->p_cur, ctrl->p_new);


Patches currently in stable-queue which might be from mchehab@s-opensource.com are

queue-3.18/media-v4l2-compat-ioctl32.c-copy-m.userptr-in-put_v4l2_plane32.patch
queue-3.18/media-v4l2-compat-ioctl32.c-avoid-sizeof-type.patch
queue-3.18/media-v4l2-compat-ioctl32.c-drop-pr_info-for-unknown-buffer-type.patch
queue-3.18/media-v4l2-compat-ioctl32-use-compat_u64-for-video-standard.patch
queue-3.18/media-v4l2-compat-ioctl32.c-add-missing-vidioc_prepare_buf.patch
queue-3.18/vb2-v4l2_buf_flag_done-is-set-after-dqbuf.patch
queue-3.18/media-v4l2-compat-ioctl32.c-refactor-compat-ioctl32-logic.patch
queue-3.18/media-v4l2-ctrls-fix-sparse-warning.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-ctrl_is_pointer.patch
queue-3.18/media-v4l2-compat-ioctl32.c-move-helper-functions-to-__get-put_v4l2_format32.patch
queue-3.18/media-media-v4l2-ctrls-volatiles-should-not-generate-ch_value.patch
queue-3.18/media-v4l2-compat-ioctl32.c-don-t-copy-back-the-result-for-certain-errors.patch
queue-3.18/media-v4l2-compat-ioctl32.c-make-ctrl_is_pointer-work-for-subdevs.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-the-indentation.patch
queue-3.18/media-v4l2-compat-ioctl32-copy-v4l2_window-global_alpha.patch
queue-3.18/media-v4l2-ioctl.c-don-t-copy-back-the-result-for-enotty.patch
queue-3.18/media-v4l2-compat-ioctl32.c-copy-clip-list-in-put_v4l2_window32.patch
queue-3.18/media-v4l2-compat-ioctl32-initialize-a-reserved-field.patch
