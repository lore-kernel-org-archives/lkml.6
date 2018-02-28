Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839500-2-2369811607076965398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839499; b=O4BVMGGwzIf2dAKP9Pp3ugBUT71x1ceNwszM2eIhA7lPggr
    EXPFsnII7joCEZ8ahDJYQWsGE4ZT1eOfjvsLy7Cdbl9YuTOuOR2eBqBcjfGP/LxQ
    yVIEXRYQmXmDuerT5GRsZFFfhpPBejQBIHnjGnXBjeY6jVjtkcYb3fuo5rb7DtV/
    4ek1i0dc9pNeFhCafQNsTrt8iNq9v2XPqc6/ukfffj9jd2MfxwdWP7akV1/ZSHh8
    i9jrYxuFL2dfDocpgDHMMJfeb6AL9tFP72F6lteIO1BO01KNIvdRESUWLsx+ZQWP
    MLGg8vzZHYXRngYQCvZr9lE92SQcSS4tUjA6H9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839499; bh=ojJNoHQyo+gKK9eicKk
    O8Y9AY3w26JudKDvMr/N8GHU=; b=cwyhMBuc2NXEtVRZm9ErdBmuY64gtWSLSIx
    QzzuEPD9VEHha7jMPqLs+RsIjJvMJcp2f1pemvuv5AsqDZmGm50Mm6//5fPsn8Q+
    p+LInCanmSViYqzYf8C6QSXBlyLMtwnE5dhD4ZNWCvD45DSgzpNaP8xPd4H9hPLU
    tyyHixGLWPniG6leo04hsuDMuzI3VhG34DFIxJN7NlVXzR9Sa+SCUs6AAGcf0YW0
    a5CdSu4XjQa1mmyslQmL77TZaXv7vZ2wBLi5cPjClWOtNY3513tq0ukbPJKHcluF
    qoeBhKlqpZx54hSmVQQAsyGYibQlomu11SbkNrBhOCRPJqm4p+w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeB1Rg1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:36:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33187 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932541AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andrzej Hajda" <a.hajda@samsung.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.166387891@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 124/140] [media] v4l2-compat-ioctl32: fix alignment
 for ARM64
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

From: Andrzej Hajda <a.hajda@samsung.com>

commit 655e9780ab913a3a06d4a164d55e3b755524186d upstream.

Alignment/padding rules on AMD64 and ARM64 differs. To allow properly match
compatible ioctls on ARM64 kernels without breaking AMD64 some fields
should be aligned using compat_s64 type and in one case struct should be
unpacked.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
[hans.verkuil@cisco.com: use compat_u64 instead of compat_s64 in v4l2_input32]
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/video/v4l2-compat-ioctl32.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -274,7 +274,7 @@ static int put_v4l2_create32(struct v4l2
 
 struct v4l2_standard32 {
 	__u32		     index;
-	__u32		     id[2]; /* __u64 would get the alignment wrong */
+	compat_u64	     id;
 	__u8		     name[24];
 	struct v4l2_fract    frameperiod; /* Frames, not fields */
 	__u32		     framelines;
@@ -294,7 +294,7 @@ static int put_v4l2_standard32(struct v4
 {
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_standard32)) ||
 		put_user(kp->index, &up->index) ||
-		copy_to_user(up->id, &kp->id, sizeof(__u64)) ||
+		put_user(kp->id, &up->id) ||
 		copy_to_user(up->name, kp->name, 24) ||
 		copy_to_user(&up->frameperiod, &kp->frameperiod, sizeof(kp->frameperiod)) ||
 		put_user(kp->framelines, &up->framelines) ||
@@ -569,10 +569,10 @@ struct v4l2_input32 {
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
 	__u32        tuner;             /*  Associated tuner */
-	v4l2_std_id  std;
+	compat_u64   std;
 	__u32	     status;
 	__u32	     reserved[4];
-} __attribute__ ((packed));
+};
 
 /* The 64-bit v4l2_input struct has extra padding at the end of the struct.
    Otherwise it is identical to the 32-bit version. */
@@ -720,6 +720,7 @@ static int put_v4l2_ext_controls32(struc
 struct v4l2_event32 {
 	__u32				type;
 	union {
+		compat_s64		value64;
 		__u8			data[64];
 	} u;
 	__u32				pending;
