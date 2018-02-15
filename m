Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719844-2-3955587432458323189
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719843; b=ibn70DwivM6cC0g6iMIsh9VWzuL7o8IvEj8fqOVZAtlGQqT
    lBIUIlXTyQcerbvo8KKFZ+CxhsgcbnpNLqJc/IRdbAX5oavvU2PBYbpbOFYDtn/0
    spS3Ux6dmGwZ0ug/779BPF2EgImBJo8AFtJPzZIWtjUZULzp1ozH535TtEoFoOHB
    PtTj4QRkE2k37tixiW1g30aESJ2yfy1FTlQZXRXIZuLdG+N2ZLB2ba5Ryk2qyNiT
    J1wZt4LMQbxhccaPHU+jkFGjlb/kazEp6XAtCafNgQMUoE8jSSopr8K6UW2l61dQ
    j3Iwo+kacCCblmr2xjYa/wt3Rf95gkJWJTzYeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719843; bh=8Hkv24nNxG4zfqnUQiYLpCM9Z7
    BtOrMSGlqz0l6S/XI=; b=NwuaWr22iBtcbB0ltrg0/Xk2VQlyMyVkxuPYfd+nqT
    ASVJkLadsPWHbW+ffNZ+YLf+HmoasBJw3AKSzQzTA8CTj/UEUX0XglUqLZe1PMhn
    CHVh2B28zIqk2YDZjMqNqxTHS/Wc/SB4dBfLYke5iccCIH4S+6n88KSg/ExWluSt
    1KkyIJoJ3xZ7N1bQn/IFtUOdL01RqVIRYAv2o22+WDzfMPL9guY+QI2/WqXqT97F
    GhRsOePhnC5sZgoiBltn2IMz+F528EaMWj6mli2HGzOPfusgSfvXOjIRp5eAirCP
    2f5z2yD70eoCCP+QyukaMBDaQ1LBQoedUiG6E+bn+pKw==
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
        id S1033919AbeBOPYM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:24:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033898AbeBOPYK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 082/108] media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
Date: Thu, 15 Feb 2018 16:17:19 +0100
Message-Id: <20180215151233.742548060@linuxfoundation.org>
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
@@ -175,8 +175,6 @@ static int __get_v4l2_format32(struct v4
 		return copy_from_user(&kp->fmt.sdr, &up->fmt.sdr,
 				      sizeof(kp->fmt.sdr)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }
@@ -226,8 +224,6 @@ static int __put_v4l2_format32(struct v4
 		return copy_to_user(&up->fmt.sdr, &kp->fmt.sdr,
 				    sizeof(kp->fmt.sdr)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }
