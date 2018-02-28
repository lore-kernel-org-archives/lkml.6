Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835770-2-15588523519305066298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835769; b=tRvKDhi7/+QyuLmmpnBFIDsOOWYGwyQBmf0GoGI+b3h/heg
    /u9xnRdzgTTsKz5IxDKYDhyPsDuwNXrb4BbDRpcT7FgEErX8MQkWRo2oM1+Qz/ev
    KAGNBbWifkbsHeshmHPaC86jwECoc+kZ42Pk8amWKgu793yhOVi6fqYP2l6eAFHB
    1vA1kdpBq9j49QJ6WgBY5/NxD9h29tWN+AIq/zuTbSzw7n8TEG/mLdJgYmn2fdob
    wkKN9STRtOJ7t6I98DS0HeCezAvX0vn8WImQX6biOwvmMM76HJkjMcbLUHmu3MPM
    mJFxFBEm5pLPoQ/VJw8BDC4DJPnNN6+QJuvmx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835769; bh=677rKUCgGpytzO0BlNP
    1NF9kUU4WPiUikYQTlPxLchc=; b=jAMMAeooLKWbvtCoDbP9yR9HJ1Mm1PmU1CJ
    2x2/xg5jhz9qm30miPrqNjoVUjqBTtgIwQjH8o1bhoNtlX7fVd6a6VL8imNK3iV8
    hvS49O2RzVPCmnQYubkBu+kkBNC5zAsa2eOyQ/6pgecMtgaZ0raUqZxQZBHITwLD
    pMIrWrGNvCvME98lCJcHG5YMjlYk6F7FvlKO2yeGgb1Xe4aa7raMy93v/chwCaor
    boRVVaSsDYHeoY7KB+bNulJ21y7sOrrCiDBevNiP9gFfemL8dUikU3IZ0Kaoir9l
    i/uqvdVyDB33jjIYJ1cCXBQ8cWvGrD3NG9SzmGO+bbaVWRj4anA==
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
        id S1752893AbeB1QLs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:11:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34946 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934524AbeB1QI0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:26 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Daniel Mentz" <danielmentz@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.259950080@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 248/254] media: v4l2-compat-ioctl32: Copy
 v4l2_window->global_alpha
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

From: Daniel Mentz <danielmentz@google.com>

commit 025a26fa14f8fd55d50ab284a30c016a5be953d0 upstream.

Commit b2787845fb91 ("V4L/DVB (5289): Add support for video output
overlays.") added the field global_alpha to struct v4l2_window but did
not update the compat layer accordingly. This change adds global_alpha
to struct v4l2_window32 and copies the value for global_alpha back and
forth.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -45,6 +45,7 @@ struct v4l2_window32 {
 	compat_caddr_t		clips; /* actually struct v4l2_clip32 * */
 	__u32			clipcount;
 	compat_caddr_t		bitmap;
+	__u8                    global_alpha;
 };
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
@@ -53,7 +54,8 @@ static int get_v4l2_window32(struct v4l2
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
 	    get_user(kp->chromakey, &up->chromakey) ||
-	    get_user(kp->clipcount, &up->clipcount))
+	    get_user(kp->clipcount, &up->clipcount) ||
+	    get_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
@@ -86,7 +88,8 @@ static int put_v4l2_window32(struct v4l2
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->chromakey, &up->chromakey) ||
-	    put_user(kp->clipcount, &up->clipcount))
+	    put_user(kp->clipcount, &up->clipcount) ||
+	    put_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	return 0;
 }
