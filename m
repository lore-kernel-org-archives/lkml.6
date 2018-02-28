Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835549-2-17475217031483135753
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
    t=1519835549; b=hIZ8eqIkMptAvi6PdYm6qcA6xCSThcq86K6q6weFI3aoII/
    A7Susm5922pURzRw4WRy9/lOOWO3tNe5YYwBmGypJB2UDiGTf7S6VaeP0zZvdNBp
    1yirqo5UslmdW//7Aa4z4Zk8qGsA+GdM4x1RzskOB0OjuN8uNsZIx+lULXbirWmO
    HcwB1o3GuDnIK+3Ye7lQTDxCpgtnovulRFxrRB2MmaZmP4AaPeWSiwoZXsSWH6AO
    fuUwhtY09vtwb7GE4Tn+tAWqPDuVVBldvayKC+liEwtyAy/nmXg4jC9ZVzgQD979
    kQC0XkaYEk4vHYUOWpcSCk9YbI83WBtg58H5tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835549; bh=RUAWTWZacs/+H+ITN6u
    GJ23aZY0HZWYslFUVMDHo0fA=; b=KA3b9LrOa6J2dY1Y/0eDlZBPP/o3h7ApYyl
    DFHT0liVHGlGiLiPhlv0nL66ssZfC3mc3o4ji5DJsHbnuBrB4oYF2LoN9mghf4vt
    H4BQaqnEEdRdBxOX4tUHqj6i1S4OjKoAH6lAuTn5hijVFfg3DJVhHsOaglpDpFrv
    Dk24uHYYM8o33fQB8orawvphI/lYcs4sHMD7qw820BACEuXtzFY0NrxQqy54QgvS
    nUXLg0g84r5fW8pkLDQM8u3a78KA18YN9TbC5EOnfjog2hrxz7P9/v/A+yO1g+Hd
    5XuWiuWaOSkKD+0Eg9/+VxAzJGlxeThgViw/OIxQJ9EbSrRiRrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeB1QOY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35104 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753118AbeB1QOT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:19 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.186100743@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 240/254] media: v4l2-ioctl.c: don't copy back the
 result for -ENOTTY
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 181a4a2d5a0a7b43cab08a70710d727e7764ccdd upstream.

If the ioctl returned -ENOTTY, then don't bother copying
back the result as there is no point.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 16bffd851bf9..e2f71def945a 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2402,8 +2402,11 @@ video_usercopy(struct file *file, unsigned int cmd, unsigned long arg,
 
 	/* Handles IOCTL */
 	err = func(file, cmd, parg);
-	if (err == -ENOIOCTLCMD)
+	if (err == -ENOTTY || err == -ENOIOCTLCMD) {
 		err = -ENOTTY;
+		goto out;
+	}
+
 	if (err == 0) {
 		if (cmd == VIDIOC_DQBUF)
 			trace_v4l2_dqbuf(video_devdata(file)->minor, parg);
