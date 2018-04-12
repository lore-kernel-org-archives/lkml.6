Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3729524-1523494322-2-10358738276754027011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_SBL 1.623, URIBL_SBL_A 0.1,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494321; b=RcWZXkg9tgkC6ZBTqLbd4yJ8vxipCxKGJuWaLGxZQmkCeKBA5t
    jzUr1P/qAj9QZPZg7O2VACW7S5YsGHfMLiIvManwmDO7/Fi3D9+hgkXDXQSzc0S+
    mJcC8ly/0PdPU5kuPWAPn9b7tPuL4nhTqltVnrtNoMAtUZ0JuIerJEhkz0QWzjgP
    9LAeswsRwtTG8lkd6vXocpGImKw4M9duXsc3X4NLRBJM1MkChV8bOvV3NFoNAcE4
    K+s1MygiLPE0ao251+vP5jqMwrGQHjsNLG5gJMT8LhOIsAin35PzvYLBaBQFOQH+
    UQLzrJqktAtyLCn4btpPaBsbSRJyum4CSWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494321; bh=7nrZL
    rvxFTZ3zGnVQR8trOyZMQNOQnmh1b7S0IW5HD0=; b=YK65fdC90p6SVHPP2qJim
    CcrXYUmYrnGdXTPcb4FuI+SvMbqFySiLGcIVuNREAr9PT1klRHlWiRD8yv+c7/Jv
    V8120lPostItqLgXE7Xtul9jKg2SHTrXoQRYbn3h6yypSckoLckX7ZsDerMtcN6+
    91ZWu5PZEtZ7wBdcydT7ZSDfmFFIr6tDg8evqqdraW0M33bSKIw+GrCmxM+rrN1H
    T2O/GryVnFxUdTXZS4mPdobDE3Rog3OGjYY6uY5C1Lr5UJXp14VJty9UAcTXlN/R
    D1Q2uq1J3HPsfXY1kkh1bCUa8SxYes5L3ZteoK0uakMMolV9wJRTc9nLhhC86YmB
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDCdvKfPLDR9XC7Q9isrCLjFclP/nVH2FL8SQ1dc9xBKAof2Tfw7Ue2UTBsLkHF8tJnvHLIHfodoEn0F9vaBuwe/NaXXKiBeA9EMWj2uatFmzv53X2v9
    uJssKzKPdHy9oRXV6ZiSwE+LlMK7vrCAB4mQ/MuodDS30tTknA+gl+Z27r8v6EWBC9ZL4BaGcFmDk2rZxHVCE33EpHV4pwl+bwkAh4Xe65xRc+NoegWm7YeU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=tBb2bbeoAAAA:8
    a=a-mGyd2leMk8HqkiN-IA:9 a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeDLAvc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:51:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39812 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752501AbeDLAuQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:16 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <4c79abea0211e267bdd2f290b0a0b83ebf3de609.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 06/10] block/swim: Don't log an error message for an
 invalid ioctl
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The 'eject' shell command may send various different ioctl commands.
This leads to error messages on the console even though the FDEJECT
ioctl succeeds.

~# eject floppy
SWIM floppy_ioctl: unknown cmd 21257
SWIM floppy_ioctl: unknown cmd 1

Don't log an error message for an invalid ioctl, just do as the
swim3 driver does and return -ENOTTY.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/swim.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0258a96e0c46..7b847170cf71 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -727,14 +727,9 @@ static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
 		if (copy_to_user((void __user *) param, (void *) &floppy_type,
 				 sizeof(struct floppy_struct)))
 			return -EFAULT;
-		break;
-
-	default:
-		printk(KERN_DEBUG "SWIM floppy_ioctl: unknown cmd %d\n",
-		       cmd);
-		return -ENOSYS;
+		return 0;
 	}
-	return 0;
+	return -ENOTTY;
 }
 
 static int floppy_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-- 
2.16.1
