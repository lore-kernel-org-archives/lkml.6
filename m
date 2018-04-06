Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021291-2-5552906281080387304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021290; b=VbaTOJMumpzJEDFCMnoo4dBrJfvKOexg+neL17FuWm0U7nxoXb
    r2WP1pbJH1LrqUonEQCRqj6l6TUxW4cslmwJaU2c8BsJ7ILICUEocwveSDDp/Swa
    5+KytGH1n1oX73nFxEIRU6iRlQXqkCFw317QAl/N29JQeDYVci87gRLe1QVHyFel
    bwu2bNK34m6dGIDOctEns8cyIdVIzCII76MLoCLrtR4iq5yHNvbdTqWUgYm0TrJI
    NqXYe6JGv/o3x08eSJ5YzZzsfHbrE/AkBhZbVhkhNIrpBlRPBYoDy0H/LMeichHc
    34oyYMBY07a0fD/ZceMtPdnGUwfHc/fYfD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021290; bh=pt/H61kbHV39mVQHLPupr3Gab0wXSi
    RrlFBTwgxR+Kw=; b=DI+twJYrVa9VMJ5rvZdN4b8mz5c1XXOvHX1W1whhqD0Dm0
    kW80I1ZEfhyIQ1kDYSEjv3QxjdvpTbW52zUQzhp8s1II685xbnPt4JGYvpb2j6PP
    sJmR3vAScBIFzWo+cXe9ArmCRRiOkQkoQ26YkT19xDs+f6EO33Mdy/HBIj8G7Sqq
    pVK8eFF5ZNdgi0U2j4u/EvYsW7c/66qofCbcqfC9r2X9v1M4WLrMdlFopWjL5B79
    MlDlIvPXjqTtdJSIC0axe/AGrbhskw9AerrFUC3lO7VdDXjFQ6BspKQN7pBBnOeH
    MW45WPykwB2wQe/0JfuX/5w/nVunuKEgzKpbB6Xg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXPrloSSrb2lTG/lCXZ/Y1U0hFpK2VgGNDVm1TjHwDqcpo3AL6XZDt6yDefdivOa9F4X5LfaH4aBWS1Sy8qB9NN5pu5oQtSePra4T7FuxfZPinxsI/Q
    Po9HqS9ibhAhvv1ah3l/6DACrdDi2M3UdL0DNQ1H16ywSBUIiijYTxiM98XzmG6He+x1LCUSvlet3iOUSJvdlBj3DSL0+J0cqOk7nPouTrSKKP2bJbKRJxxq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vQBBkBfzAAAA:8 a=ag1SF4gXAAAA:8 a=Jh8bM-ib2ic79ZFQoF0A:9 a=QEXdDO2ut3YA:10
    a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeDFN2E (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:28:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754287AbeDFN2E (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:28:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 3.18 74/93] media: v4l2-compat-ioctl32: initialize a reserved field
Date: Fri,  6 Apr 2018 15:23:43 +0200
Message-Id: <20180406084228.313537673@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
