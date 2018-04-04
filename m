Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49UdEBWiVUXctxpo/DkXBOpg9+BX3hRT0GH/AvvOmuMKq4aJ98oXv2nUzSDvnF5hWGETBki
ARC-Seal: i=1; a=rsa-sha256; t=1522855964; cv=none;
        d=google.com; s=arc-20160816;
        b=fPVf7zqbRF9DojbxfJPfT1eWUfX7kxIjY/or9IlbXWYa1vxGrZeHs1Un11LM6Pj9Md
         Vj1leZ5ZT5YbjTiIvU/wJZSyUdokapNsUIrlw6VQtiL1MCeNycQ5ghiCDLtlxQT5yX+4
         KYH4ytsWS34whaxqGaWN3DJmLZxk9cyZWgPOFwzlm8Nnsoh61oNF8Urz1wtZHWkUe75G
         9qhshU1MA7CXf8huHz5YnNmBwxcvsaV2gWhaVj8PMfVNv8pSs2tphpyR0pRrQ5AOuQZN
         Sq6lhCxPG0jSGMA1YXiA+uUDLEUvvywKo0ARROP3oexWdn0HFXK+BMVqMGKU7aaKZsUu
         o5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :from:cc:to:subject:arc-authentication-results;
        bh=/6CsFiIFVS+xahbb0HlAE+BJkyi5E05P3myH58rpgiA=;
        b=bcpPjwy4Qn4lK+F2ZErdDBbqpELV5k5V3dHeQf+mbQbJgXAiK/O8UoH9n6ktFhs40B
         NJuYqf797szEkbgtN5v0mNA4v83TR/fFY4uc2YFWYQQcRtYMkXTZ1eM9wlEr397/cWat
         HdjxW/e+/lIpPNCxvBdJtKFc5L/h7xR6Ne8hnlHx+A/e7ku9p4ql/U5izTgpTa/AfUjy
         9VmfIvHskODxa52PraIC0R5CIUzSBtZ6hxBBSZzu0kgXjBEGU+lVA72l9e2WrUayt8Cp
         JVblf/SGJsIdOyLQyWIS9L1YsBdYFQxuOsjC6AmMrvGqgulMKfvduGjXAOAosXMVsuAS
         VoSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Subject: Patch "media: v4l2-compat-ioctl32: initialize a reserved field" has been added to the 3.18-stable tree
To: mchehab@s-opensource.com,gregkh@linuxfoundation.org,linux-kernel@vger.kernel.org,linux-media@vger.kernel.org,mchehab@infradead.org
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Apr 2018 17:32:40 +0200
In-Reply-To: <d8a647b26822fb0a86f6ee7dff4d6eb1e85e1398.1522260310.git.mchehab@s-opensource.com>
Message-ID: <1522855960120189@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596830215476788640?=
X-GMAIL-MSGID: =?utf-8?q?1596830215476788640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    media: v4l2-compat-ioctl32: initialize a reserved field

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     media-v4l2-compat-ioctl32-initialize-a-reserved-field.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Apr  4 17:30:18 CEST 2018
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Wed, 28 Mar 2018 15:12:37 -0300
Subject: media: v4l2-compat-ioctl32: initialize a reserved field
To: Linux Media Mailing List <linux-media@vger.kernel.org>, stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <d8a647b26822fb0a86f6ee7dff4d6eb1e85e1398.1522260310.git.mchehab@s-opensource.com>

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

The get_v4l2_create32() function is missing a logic with
would be cleaning a reserved field, causing v4l2-compliance
to complain:

 Buffer ioctls (Input 0):
		fail: v4l2-test-buffers.cpp(506): check_0(crbufs.reserved, sizeof(crbufs.reserved))
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -247,7 +247,8 @@ static int get_v4l2_create32(struct v4l2
 {
 	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    copy_in_user(kp, up,
-			 offsetof(struct v4l2_create_buffers32, format)))
+			 offsetof(struct v4l2_create_buffers32, format)) ||
+	    copy_in_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return __get_v4l2_format32(&kp->format, &up->format,
 				   aux_buf, aux_space);


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
