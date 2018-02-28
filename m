Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835177-2-6540698573134580788
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
    t=1519835176; b=VRCh0ZuySWubYYKw5cApyDbr8mtRoHb1mg3O3OnjvIkJJ+L
    jJjb91xx4NOdGlxsYTKqZ7CZNnh/Jp68NMTTxnlUJFhS5F7Z4j7NqDKURE4DPWPZ
    CZqQzpl8MUKKalsrjsX42dTuVCx20sAnunIVtbfBK7JFB+O4Tw7YTQtG/nr9Gccq
    dQ+w6QDw4AO2mMrLFMl5yqNEbgYDi2Me24EGOvWnRkJi7u6HVGKgf0nAnyWeYbB7
    Q1B6qaG0EMNHINpPuKMzkf6i9FraCSZc5JYWflLyVspFdT0KLNLjdUWzbK8cANB0
    rtcGgIehUk/yghr9LRMwi1qdkA2p4Z/QV2+grLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835176; bh=YCEMt5XwXI46u82hfhV
    YmaW4Ngir1Yc7gN7Z8VAD8vg=; b=V5tleyMnQMElNC6oWe3eHMlvHBC05jIowbO
    vgcMA0sQ4atwiZtec/Nbk7oSpc3Ykd673V09zzbIuuxjUpB8mSON8zdhTklltmTf
    5m6/N7Wtk5cpOaBGTZqfNzfT61xqdQbMKoG8QBE9jkqguNH6YiqeX56MYy84D6YA
    lZftaAv+SRqC4uGj0na0+YPRloebKpK3HCsZ6lDaKGEJbdVTjAwVm4VYcHgWdRdQ
    AApMr5R4hQZr3+rXq7O0qy8qJf3aYXY71NEaGZp1rw0AdPCBGuq8ZuhEXx+N+C2e
    /g3t7Qh3uth+ByAQp0pVa9CgaPVfsXIshfKJvUpRiRxPTG5A13g==
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
        id S934998AbeB1QUP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35324 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932479AbeB1QUN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:13 -0500
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
Message-ID: <lsq.1519831218.80070526@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 251/254] media: v4l2-compat-ioctl32.c: don't copy
 back the result for certain errors
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

commit d83a8243aaefe62ace433e4384a4f077bed86acb upstream.

Some ioctls need to copy back the result even if the ioctl returned
an error. However, don't do this for the error code -ENOTTY.
It makes no sense in that cases.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -933,6 +933,9 @@ static long do_video_ioctl(struct file *
 		set_fs(old_fs);
 	}
 
+	if (err == -ENOTTY)
+		return err;
+
 	/* Special case: even after an error we need to put the
 	   results back for these ioctls since the error_idx will
 	   contain information on which control failed. */
