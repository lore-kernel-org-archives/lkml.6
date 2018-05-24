Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161583-3-11972179881981783164
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161582; b=T6J3Ml5LB4nURHq2M4bLR52nbUTys0j7wCqRn+EIMDVKfzO+GB
    tthWtvA1ljvNzyuV9ZI4AoT59sUOkIgsmSRlzU74r/q9TFmp32pCi5gnoGiR5hQA
    M/Jmud15ZFo8xlei8ZWyQ9mLJbxa76hoxpMWIo8KHsXQHZgiLwiHAErOMt1w7IG3
    341GNG8HgMiohuslOWBKltCTbf1wiFwUr1d/Pp+xZo8QXAgYAkZc89kt8ctRo6sc
    aXjGx5AlCN63ThLYnqncym9nvpIFYDD9Hu4TKz+lV5HMZG8ZJUkfDPtywC9z6iHY
    Zs5M19nu9Ga/Z1ivxaYF+RtN+jOYFJAK2Xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161582; bh=3IVZ6e7hrpKB8cZioekUOHoL+K2qy6
    BOp3Gv/s8nBSs=; b=T10M9BhZenQrnrw6IYCsQOq6ig2XMTRAPF8lYl7NwqrokY
    LN6HHSBPNWASP++UQCJNyX63X5O14MpofSn1YaRM/CyJmx+AimIwsvS3nZ1cGCLT
    vb8gN3+ty5k2+4dRSiLAQVU6r6RkoPxJ7dlUULjBVmDQ2cGlpMPG++1xX/DR4PGh
    GzufQIjJVqXLowoVkyrcM2mU4oxBDXtFBUDxmYfw+MbuMn8DvDdy34vp3GDjkShF
    Nn/gPSLHic5rOCwYQ6U8G0drMBw0LoK6NtlA6+Ws+/OAutuVaDC7KgWDNflVMo1v
    Zni7auvlOSmZvQxEKB7xCSBOs48ef7qj7StIC3sw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=eiWyYSPE x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=eiWyYSPE x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEdCIEzAekhaUW0lOHbajTk9JDjMWFx/5bzL+F+9jXKAKVf0BPMJI/LyndlbVULTz9QcGcMT2+njQ3KWK1+PbIDy2sYgeSxDzMIMK11ZGL70QsIcHOGq
    5hu+7cBUCEviRBr9eft8QtsXuYnHLJCeaZWA4ZWk1kUx6RpCHcm6kQKbCY7I1JmxjjH/gNTRhkF1dYWD4XeVKrz1C8YiOLb5ocyyV2MN4qH4ZU7nAx3GzaUn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mDV3o1hIAAAA:8 a=P1BnusSwAAAA:8 a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=sQARDKgQixnSql7upBYA:9 a=QEXdDO2ut3YA:10
    a=_FVE-zBwftR9WsbkzFJk:22 a=D0XLA9XvdZm18NrgonBM:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967595AbeEXJuf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967553AbeEXJuc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 83/96] media: s3c-camif: fix out-of-bounds array access
Date: Thu, 24 May 2018 11:39:06 +0200
Message-Id: <20180524093610.159820625@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a398e043637a4819a0e96467bfecaabf3224dd62 ]

While experimenting with older compiler versions, I ran
into a warning that no longer shows up on gcc-4.8 or newer:

drivers/media/platform/s3c-camif/camif-capture.c: In function '__camif_subdev_try_format':
drivers/media/platform/s3c-camif/camif-capture.c:1265:25: error: array subscript is below array bounds

This is an off-by-one bug, leading to an access before the start of the
array, while newer compilers silently assume this undefined behavior
cannot happen and leave the loop at index 0 if no other entry matches.

As Sylvester explains, we actually need to ensure that the
value is within the range, so this reworks the loop to be
easier to parse correctly, and an additional check to fall
back on the first format value for any unexpected input.

I found an existing gcc bug for it and added a reduced version
of the function there.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69249#c3
Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/s3c-camif/camif-capture.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1256,16 +1256,17 @@ static void __camif_subdev_try_format(st
 {
 	const struct s3c_camif_variant *variant = camif->variant;
 	const struct vp_pix_limits *pix_lim;
-	int i = ARRAY_SIZE(camif_mbus_formats);
+	unsigned int i;
 
 	/* FIXME: constraints against codec or preview path ? */
 	pix_lim = &variant->vp_pix_limits[VP_CODEC];
 
-	while (i-- >= 0)
+	for (i = 0; i < ARRAY_SIZE(camif_mbus_formats); i++)
 		if (camif_mbus_formats[i] == mf->code)
 			break;
 
-	mf->code = camif_mbus_formats[i];
+	if (i == ARRAY_SIZE(camif_mbus_formats))
+		mf->code = camif_mbus_formats[0];
 
 	if (pad == CAMIF_SD_PAD_SINK) {
 		v4l_bound_align_image(&mf->width, 8, CAMIF_MAX_PIX_WIDTH,
