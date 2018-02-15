Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1936761-1518711443-2-6092925134766172386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711442; b=EJgjjZeahtypGXPq0nhbeVLfb1DIYoG70WQR84oIY+GKuwy
    hG/Y0cucgupVR4fh5UnwLlfVv7HhOgPszaqJnhvkSVltvYjlKNDCJMK1e7OKKAQJ
    iB0TIo2Syjuh3tTJEoFOPRSyvctA2RC0WJvLjvakwGhnMxbFhykq36r0dr+PIKfr
    XRPkHZiqgpyCUK6Sc7nbNooooC+f050VyZt9izJfHEsnwimZVY2yeY3tnYhQAJmo
    fcTPs7a/kIdftP8y9JN3n+NcbL/odEINsZZFsL1rtruRI3hJNRfuysEC3B5XHup3
    gcD2Fh/12HveJT/4kHzuRCR+FI1wJe5XZ++23eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711442; bh=hgxU0TtHmIxszWxx0QcTN1OWjM
    8vo4dDTSXUn+c4nrw=; b=s73H094mxJVXDJD5F8z5VOHAACNmDBF747OMewAdhF
    l8YYWlMz9Lg44FblW6Q4ESkRq3Gv6A0T2sqNYPBr+5BLRzo0zrlElZXihc8Oydz6
    3k80+NiH5ydmOumpSC/BdI8i6O8fLoXBv3f7MbB+eLbMlVYKQMkYfKzqOdHtVuba
    TU9P7SnyHVOwmiqpxprlMKsyxH+0dwG8NILLEFDKw/wZmy6Ot8Ud6SleoL7I9z/T
    5lnMjx2/jal2dwcPF+tgkjgPnSqK1mx8JlJeTVwBuUSKYmJD7TgPuXTiLOQmTwzT
    JqvKRi1zeRE501hgCjqBX3fd3+XBUXYeTVh27RxSrMdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424324AbeBOQQ7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:16:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165442AbeBOPoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:17 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 123/202] media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
Date: Thu, 15 Feb 2018 16:17:03 +0100
Message-Id: <20180215151719.692726426@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 169f24ca68bf0f247d111aef07af00dd3a02ae88 upstream.

There is nothing wrong with using an unknown buffer type. So
stop spamming the kernel log whenever this happens. The kernel
will just return -EINVAL to signal this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -179,8 +179,6 @@ static int __get_v4l2_format32(struct v4
 		return copy_from_user(&kp->fmt.meta, &up->fmt.meta,
 				      sizeof(kp->fmt.meta)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }
@@ -233,8 +231,6 @@ static int __put_v4l2_format32(struct v4
 		return copy_to_user(&up->fmt.meta, &kp->fmt.meta,
 				    sizeof(kp->fmt.meta)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }
