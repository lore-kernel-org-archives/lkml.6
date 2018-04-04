Return-Path: <stable-commits-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375845-1522855989-2-5640079817822671332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ANSI_X3.4-1968'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-commits-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522855989; b=iPti10/G+Z1M/OqcXdAeDb8OpAW8gPNlR2ILmD+ygvnqX0RxQc
    ed2LAQNg3hiZrd9aGtg2OfqYRPuGnuvUT3fYw1lYXt3mf6o6SNYgcV43U7Jl333O
    tlt7rfiNGCqOiliZDfcLhOmzSagQNuwTdGxnGUMnj3aVnu3y9x4ZB4pdsjdZiK6h
    A5Rm4rfGw0b4cA0kzpXZ0yBuP6o2NqD7ukus/ZlhyHOQWYKXiQiaJ+87AKINp57F
    Ht+D7560Q4CjuccgfR+YQdq5IFfmiF53pEDi6ygckqH/2gPBrAD/WT2tEMeTItQz
    jV18D0k25L48YVbK64KSK4+ViYVnobujlnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:date:in-reply-to
    :message-id:mime-version:content-type:content-transfer-encoding
    :sender:reply-to:list-id; s=fm2; t=1522855989; bh=34ZEmJkXU394WG
    8+jD1RPEDvVzXEAWEwrOymjJTjrbs=; b=lbHQ4O07Sy+CHHadjolr/cJkEI31vv
    0G2qVi6/JmUl7Y3BCyWRyiCt0tMVQdqYfK2Z/m+2x6KSZMpD4+ftUBxbg/sN9d33
    oE0qwlN/8V4+l6xsY0k/791YcZlqGgKYWaq55crTT/ZdGbh/cPhgFcjEJUz26zxR
    3MF08c5qahs75vlOkWpJSpgDDrnhofWhthEA7ejFySxdAgTJsmT+IleyWf5usv1H
    tGf7pjoHRHoaE7NqOM2fGFtSo9rqfqN2WLR7X/CqK/PH7GdQ7L50+CuFurpJt2Yr
    ANlqyRLYHrMY2comP+rzo0m7FRaSa0phJouHWMJKHPNSioEHMJYKZyyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-commits-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-commits-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/87pfiIxt8AGDzbCtdckA0eIqmMfpI4NsiZo2h0bxdAyBnRLj05jyAcylCsRpGI/eMt2NCe2ba0zMAPp0SDfv70UpzwQHQkWqpxRLOdwZmiH4OMLLf
    LWiyVt3dnbhrSMdc4fBNycf/F1y7ZbeMiObUFy0JMz6mO94o7u3A5zj/EqBZgQwjc09Pb0XfR0J4ggcNkuCVL8B9mCcLVohIWILeR2rlYgU7ZuGLRz7TclIF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=m6qU47vR8oQA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vQBBkBfzAAAA:8 a=AUd_NHdVAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=IBDtAxeMHrX5alZo45AA:9
    a=57urXIHmFmcA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=NGXS0kB0m_rannUenejW:22 a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeDDPdG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:33:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeDDPdE (ORCPT
        <rfc822;stable-commits@vger.kernel.org>);
        Wed, 4 Apr 2018 11:33:04 -0400
Subject: Patch "media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type" has been added to the 3.18-stable tree
To: mchehab@s-opensource.com, alexander.levin@microsoft.com,
        gregkh@linuxfoundation.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@infradead.org, sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Apr 2018 17:32:47 +0200
In-Reply-To: <8f000de7f9babd3f104eacbd7e79fbd72372c9d1.1522260310.git.mchehab@s-opensource.com>
Message-ID: <152285596736133@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Sender: stable-commits-owner@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org
X-Mailing-List: stable-commits@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     media-v4l2-compat-ioctl32.c-drop-pr_info-for-unknown-buffer-type.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Apr  4 17:30:18 CEST 2018
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Wed, 28 Mar 2018 15:12:31 -0300
Subject: media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
To: Linux Media Mailing List <linux-media@vger.kernel.org>, stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Sasha Levin <alexander.levin@microsoft.com>
Message-ID: <8f000de7f9babd3f104eacbd7e79fbd72372c9d1.1522260310.git.mchehab@s-opensource.com>

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 169f24ca68bf0f247d111aef07af00dd3a02ae88 upstream.

There is nothing wrong with using an unknown buffer type. So
stop spamming the kernel log whenever this happens. The kernel
will just return -EINVAL to signal this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -170,8 +170,6 @@ static int __get_v4l2_format32(struct v4
 		return copy_from_user(&kp->fmt.sliced, &up->fmt.sliced,
 				      sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }
@@ -214,8 +212,6 @@ static int __put_v4l2_format32(struct v4
 		return copy_to_user(&up->fmt.sliced, &kp->fmt.sliced,
 				    sizeof(kp->fmt.sliced)) ?  -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }


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
