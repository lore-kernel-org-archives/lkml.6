Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839822-2-16201242517318626101
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
    t=1519839822; b=fHN6XfgLdOmQP5vJAEYq1Ns/gbmszNRA394Q2gakUTsfEkG
    WHxJY85EXcIxu6h/PR+FFzjRFFILw+9TmJe57mDpvns0MsIDpYjMwFYlJwWKDql6
    XZgCeBxXqJLfpUj4Lq+IaBh9Uw1E4rUZyKL43BBpW4gthES6cQOK7CeMwDWX3Atc
    5jhbA0w45T9KOXLyMR7Jyf7wo7yH6QgYwLLwT7yj/8eRB07x/99qp0Fx1+2HHnPI
    BJkZcfbkTFvdsZhxWq5geYBwM+Mrmg8JeH+872AxmCD44ZmQWQdT87PrjEXabn2C
    pv0KOr8QKs/OJNmeSxEH/KFwUue5DxuKShOm4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839822; bh=3NL8NN1hCMx5Id7wEi+
    7O6NK7CG1hHObTu6mBgucnNI=; b=IUq7ak5UovRSqJpnT4DdEIn1KsFgcqmIYDA
    Du4kPb3YjNPFp+JDDW1fhpCnrJ/PkEfWaSKLmTM9s0lbK5y96Mb+58MVJxXFxyT+
    MbCCzoUyRs48ernE4gW774k/iFiE7Y5ZX4MXHW6uGGr6gNLSn41Vp8PP8nVQ76MU
    s3/YOl7QSd4HIGUNs82L3REmB6Ma4Jzc2aqiUJE460kzSH3JdBuon87Hzl3aCO0x
    Mt19+QpYhxSuHtjmTUqi7QwBTrRLBB5pwMJzUyRTU8huPfIjuLS9w7hHwEHZ8mrI
    bzobgVbPrxze9bcK81gI6eFPW8Xu048kQRdiPVLON63Z/z0rGYQ==
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
        id S932254AbeB1Rkd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:40:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33138 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932510AbeB1PWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.114283904@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 128/140] media: v4l2-compat-ioctl32.c: add missing
 VIDIOC_PREPARE_BUF
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

commit 3ee6d040719ae09110e5cdf24d5386abe5d1b776 upstream.

The result of the VIDIOC_PREPARE_BUF ioctl was never copied back
to userspace since it was missing in the switch.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/video/v4l2-compat-ioctl32.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -933,6 +933,7 @@ static long do_video_ioctl(struct file *
 		err = put_v4l2_create32(&karg.v2crt, up);
 		break;
 
+	case VIDIOC_PREPARE_BUF:
 	case VIDIOC_QUERYBUF:
 	case VIDIOC_QBUF:
 	case VIDIOC_DQBUF:
