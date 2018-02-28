Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839876-2-10468476365314979819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839875; b=Uvf0c4TBqVJGHmeqP/GftGJjCdsi0f3cGyCjQ6iF1A+lAF3
    tjbJusFGe8u/P7zK+18DD6vNaBCQOrrhGWzZ7eU9h1Yn0DRZyPDHAYEBnQG4ABEg
    Z67cfCpYvgxQPe8XFufTB2Oo/i9VuK76KYwaqrrY24fK/Cvmo1pYpvFa4VsUxoOu
    xTnE7FxhSRXDRtPCP6axDYqN4qZERJNm0ld4oIh+gr3YNOJw5bZvj0W9kf7Ne58g
    8nGS4c/OEn8qnDLmqa9aOiV4nlNNL3Uuy8Y/Vtd5Zs+kB5enztklKci2yjbWJhNh
    jjDvp5LiDb8OV5THbHCGn8t/CyYqbA54MJgRRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839875; bh=N7yg+rBkclrRG4MwEme
    6Lu3tT0G+BG30Vsr1hqhdMxc=; b=X69RL0nGiFsnCuE7VWu1+sXIpvfKBCtMyEj
    m7d1kYx+REGNJJWWxZ7G+TGSuoyJEcP5I0/PXXPs3sxxMr4B7w1ptvG8GrRYFcWp
    DVhD9aSkmMRtOFreFkc8pGHndPXVepNelKzga1vm8Q5CfCX4lt7gX9elyI241SQO
    kiK2ENw55IArGuD2Z6blgKJHm6DisbLjBV8A5C6CCWbP9U5JfbQXHsDb6f2TYRJi
    nYWxMzR0cksI33N8E30UhHeheiN4sJePc7MpWvV+vt8ebFrRI6BEMweGW6jbxEZa
    6UfVw27scBRbZNHG8EKS0VG+UHNV6n9veBOb3qlRRIDvADN3PKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbeB1Rnn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:43:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33123 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932482AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.648822602@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 136/140] media: v4l2-compat-ioctl32.c: drop pr_info
 for unknown buffer type
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 169f24ca68bf0f247d111aef07af00dd3a02ae88 upstream.

There is nothing wrong with using an unknown buffer type. So
stop spamming the kernel log whenever this happens. The kernel
will just return -EINVAL to signal this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/video/v4l2-compat-ioctl32.c | 4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -175,8 +175,6 @@ static int __get_v4l2_format32(struct v4
 			return -EFAULT;
 		return 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }
@@ -226,8 +224,6 @@ static int __put_v4l2_format32(struct v4
 			return -EFAULT;
 		return 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }
