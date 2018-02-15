Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719870-5-7937403865464226202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719870; b=G3kJavVnV8HhjrcJ/Jo2zy385yUSzixD92s3Bm26W1L9veR
    3jDhDyt7V8b8fc3DgT5q/LE7ICxNSdXlDj+R0SsnNZCt6kJdsPbgUy8yrqPidwRm
    wP9TewIYJ4g2hqboNUYoiMXYYLGcwItjrCWNwwQuNspyHGP0cqDgdwp5xhCXU5Zr
    icVmTIEk2gKZ7wlHtipFH8dRv7AtfyO7BlkW79WcBDQ4LZVdcM8dKhAICB+kUAEY
    BoCGE6YrvW/JwfB+uHLF+nKScRPK+7T12vb3QEuClopk/rlA/SWyquWuk/Z3zE+K
    VX2ohmxECOA5hg9Ej32UlWCum77YY3xonMCPjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719870; bh=hR12dcbe1DovXSKCPFj4+A5gxm
    a4y1uekhbzD5bQvCQ=; b=ih5Bitod5ZfaOLh/DuTPAPzkVEyqSuBmToTYYEzK7g
    u61CgH6GIa7vk5ebjiB7YSdzG5ot8XdTyIMnokafHws4OetJ4ha0aPvMywq97cub
    53mY535L4zy/Q58u1kE0Ry5H6JLBA22xYWSI0Tw4gK6tp704XyDRTM6ykQmZ0NeR
    C9YE5zMf79ZyY1PmuYSI3frJcv0hDyZMcsyXKQ/MBGj8K+oDGKAzW2b70HG6JLyp
    wHUEW7/BhjrEce4cQu1gXo2VsgtByOJl3K+8CUD7mM1G745FS7bDzz94YXG4UYBn
    3mkKxPzfiCtODEWrJ6M8yhNLeeNOawZyH5WLW/gflxMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033899AbeBOPYG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:24:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033898AbeBOPYE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mentz <danielmentz@google.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 080/108] media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
Date: Thu, 15 Feb 2018 16:17:17 +0100
Message-Id: <20180215151233.445418148@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mentz <danielmentz@google.com>

commit 025a26fa14f8fd55d50ab284a30c016a5be953d0 upstream.

Commit b2787845fb91 ("V4L/DVB (5289): Add support for video output
overlays.") added the field global_alpha to struct v4l2_window but did
not update the compat layer accordingly. This change adds global_alpha
to struct v4l2_window32 and copies the value for global_alpha back and
forth.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -45,6 +45,7 @@ struct v4l2_window32 {
 	compat_caddr_t		clips; /* actually struct v4l2_clip32 * */
 	__u32			clipcount;
 	compat_caddr_t		bitmap;
+	__u8                    global_alpha;
 };
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
@@ -53,7 +54,8 @@ static int get_v4l2_window32(struct v4l2
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
 	    get_user(kp->chromakey, &up->chromakey) ||
-	    get_user(kp->clipcount, &up->clipcount))
+	    get_user(kp->clipcount, &up->clipcount) ||
+	    get_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
@@ -86,7 +88,8 @@ static int put_v4l2_window32(struct v4l2
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->chromakey, &up->chromakey) ||
-	    put_user(kp->clipcount, &up->clipcount))
+	    put_user(kp->clipcount, &up->clipcount) ||
+	    put_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	return 0;
 }
