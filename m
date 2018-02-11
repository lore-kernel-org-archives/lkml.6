Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323926-2-12868227178871486095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323926; b=evIi4LttjFbBvx8A6N/LN+HRtGm+HjE7ddPVStP9NKDL1+5
    k1A49dkqnQxS5wnQAvWzi4ihhj515l0GG4YUqBj1hIPs6ZFjJnCyeQWZupUGmUxt
    WcLrrC4kEx6hpoAbGrbDTkYIUfhALZWL981X5tHtpM9MrAev/i9Foc1jVBPIHFUM
    u0vOixynxGQSABy8nj4ZYAygJoOGEmtMUYVSVnqcDdWnR3mpj7p6LyO2Abxl8Vsn
    4OOXMwT89txygEgE2k8VDsPk79fmsaYnUAVYCTyaRoj4RcqfKkoqrdV8HcO4/Y/h
    xuSuAUMU/aH6FvvAMJaOArISW3wGsqygoPFJTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323926; bh=yXsAdB8RSdcXpgP+Npe
    c5oi4qZuA+9p7b8wbBIBfXFI=; b=rbqJ1YCExKnbDHZSrl0JGnezYWcQfJ/IhDw
    Qsvg9lDvBl3mCZodrJfkn/ioPrlJaTpIHOABAv8Tojbj/5w83AHTalDKHi5gWEvX
    F+KUPSkQ/7bSA9wPQz5RajPkdAryn0aH5T5Cis1RY0lSq+CuwZx32ZMPRFuUOq6X
    0ix+NCyXHon8R1loDjsA5FX8QEMjddA5zqkkrn3xfJbKZyFfDFj37R1dROAteEQf
    gwklKP0RJ8W/zjjzYANcqf+ts2y/H4t3WLI0umdLx4GZ+jHfeC0TvqvVO+j+BYxN
    hj0jj1cX9kzVyPXQR8E+OY3WCleTxwUNVNj9/nhgcB/4lVb3Srw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeBKEi0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41730 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752967AbeBKEeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Markus Elfring" <elfring@users.sourceforge.net>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.830968840@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 042/136] media: omap_vout: Fix a possible null
 pointer dereference in omap_vout_open()
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Elfring <elfring@users.sourceforge.net>

commit bfba2b3e21b9426c0f9aca00f3cad8631b2da170 upstream.

Move a debug message so that a null pointer access can not happen
for the variable "vout" in this function.

Fixes: 5c7ab6348e7b3fcca2b8ee548306c774472971e2 ("V4L/DVB: V4L2: Add support for OMAP2/3 V4L2 display driver on top of DSS2")

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/platform/omap/omap_vout.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -1017,11 +1017,12 @@ static int omap_vout_open(struct file *f
 	struct omap_vout_device *vout = NULL;
 
 	vout = video_drvdata(file);
-	v4l2_dbg(1, debug, &vout->vid_dev->v4l2_dev, "Entering %s\n", __func__);
 
 	if (vout == NULL)
 		return -ENODEV;
 
+	v4l2_dbg(1, debug, &vout->vid_dev->v4l2_dev, "Entering %s\n", __func__);
+
 	/* for now, we only support single open */
 	if (vout->opened)
 		return -EBUSY;
