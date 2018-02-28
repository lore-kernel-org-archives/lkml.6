Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839824-2-9910208490571220393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839824; b=mwpRToiTrH6DHOU4oG/P+3pto0TKmnv/O2A7yFS+fN5OEtR
    zVdj9E17KZv8/gUkHhkJqCRR7o2B3AXpu9+vD36lIGo0BAhs/XVohJ+XQC6sq0lv
    7cHvFS8xxcrA8/3lhfoCggvMAgkkEGeTuJq/Z2SaWJVFFECmOYX9sckdwjNj4uF3
    7WBcKIgwNgOHSz51zDc4kNJJ2RIenfxomiJsLn3d10j5MV8zsLl4Im+vTY2bYPcf
    mJsLXKGZICutYuNvymjN1NKIEre5irqjXA/7erHsBKY0bPMSno/WdQB3N2LczM4q
    zlhn+tzVPpFxprHFIu6cyPOB6ia83BMp+Dz8LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839824; bh=cDKm5P/ZwWUOH5fWZPR
    cvf8RS4OZIBURY27CdObeRwk=; b=j5oawSLeQXs4DpRo9m3fNeB5+H872sWgJls
    ufVvEgWTSMC0aOyN8ecAlfg8jvN5f37vbT6fSdqxs+MMhqszPIGIh0j1tQnEotZW
    E2jHmQsLgmEzewXlxPrggds5ahINpc3dXI+owgJIUgzvPz4yERVx+zTlU19SFzmU
    a8VIRFmYhsumXRe8XBlGR8GP/eLl4agEXPzHQoVtjo6zRwcVl71FCuCBwUb/5tt4
    ekTXgW9Ph6a00b4BUHngAlr7PzJHXm9UE3d0JcgaT31UmCSoPk7ho4R4HPZbqeGS
    qKcoPFObOkjGx6O83AVZqxNK2iO0Ou7pn2XALhX6L71R8QWf0/w==
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
        id S932953AbeB1Rnl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:43:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33131 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932490AbeB1PWM (ORCPT
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
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Hans Verkuil" <hverkuil@xs4all.nl>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.825418476@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 127/140] media: v4l2-ioctl.c: don't copy back the
 result for -ENOTTY
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

From: Hans Verkuil <hverkuil@xs4all.nl>

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 181a4a2d5a0a7b43cab08a70710d727e7764ccdd upstream.

If the ioctl returned -ENOTTY, then don't bother copying
back the result as there is no point.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/video/v4l2-ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/v4l2-ioctl.c b/drivers/media/video/v4l2-ioctl.c
index 639abeee3392..bae5dd776d82 100644
--- a/drivers/media/video/v4l2-ioctl.c
+++ b/drivers/media/video/v4l2-ioctl.c
@@ -2308,8 +2308,10 @@ video_usercopy(struct file *file, unsigned int cmd, unsigned long arg,
 
 	/* Handles IOCTL */
 	err = func(file, cmd, parg);
-	if (err == -ENOIOCTLCMD)
-		err = -EINVAL;
+	if (err == -ENOTTY || err == -ENOIOCTLCMD) {
+		err = -ENOTTY;
+		goto out;
+	}
 
 	if (has_array_args) {
 		*kernel_ptr = user_ptr;
