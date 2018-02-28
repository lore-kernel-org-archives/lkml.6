Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838145-2-1641477475344263591
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
    t=1519838144; b=vhdosCU+kbh4P0zKJESBtZDhUYNNzabL7jvc7cCS0liN0nX
    xB0t2eAXzPHBJ2+hPqUF11vZeQPxi44udaxf/iBGhXkDBqUG8YCUxIm2hsXykY0F
    z4sKoSvqGtAATnz1BasxLExOD40XcJ4RXwpl4ff0LrXL06BnszLCew6tYJ4eKLlx
    l4gQPQbFbWc80FPv1FwK9Tx2n7WOQeWf3DKEynDhMe+eLzdimz2d1VdbBPb4beha
    TDckaLHtAhoTRBDMPrvxrlGZkGPTHtXKPSGfeLrNb3MuDXjd8qEExpyN3U7cR51O
    NX9S5eAFovs1HaOlxBSqsPgvhEvvxV87O+LDNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838144; bh=o3n/5qqWgQQweeAM+qR
    z1M4E5cDkiGhvfJDgBV8pnT8=; b=Yvmiw+sprLIVpAsbgp5pK/NVq7OLOd7NsXA
    Gj7CK7g4uqJjITJ7/G3e4OWHNXO2Q5cZW87o9iL0RnQMvsXZyzpSboYo9zuVpNL6
    YV+1DB/1QZLn//DukqWW/bLQsfGkSZNlg3lbr9Vy+pxLHZIoBv6RECBftpKnbdmH
    rfEWaC+YIMdonY+vMSLQpQYHQpeKFpjz7ktwvvNSb5Di0vXKqYlQIPmePo5G6aBW
    Z3JtQsojkKg7n/r7oyqn6PcbNhqaavkeaxVV1xSsPVBEkBvk2gL8+0R+tomZqsw2
    hJiLFi3m3TwYZl6tG5qTN69O+LGLX0fWXHzkbnouwX8DKrRATXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeB1PsO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:48:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34243 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933190AbeB1PsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:48:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hans Verkuil" <hverkuil@xs4all.nl>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.34421302@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 238/254] media: v4l2-compat-ioctl32.c: add
 capabilities field to, v4l2_input32
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

From: Hans Verkuil <hverkuil@xs4all.nl>

commit 037e0865c2ecbaa4558feba239ece08d7e457ec0 upstream.

The v4l2_input32 struct wasn't updated when this field was added.
It didn't cause a failure in the compat code, but it is better to
keep it in sync with v4l2_input to avoid confusion.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -576,7 +576,8 @@ struct v4l2_input32 {
 	__u32        tuner;             /*  Associated tuner */
 	compat_u64   std;
 	__u32	     status;
-	__u32	     reserved[4];
+	__u32	     capabilities;
+	__u32	     reserved[3];
 };
 
 /* The 64-bit v4l2_input struct has extra padding at the end of the struct.
