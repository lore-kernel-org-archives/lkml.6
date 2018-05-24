Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156479-2-10779683534489464479
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
    1527156479; b=kgnrd2QYXm6BbgQa+Yixqw3nTyE5jVafM2rR1twN6xXKXeHkBc
    tzQyRjzMJWM0ERXX8DWGEQog/E/R3ArmBtt4LRiCJqQxMUBY7W/oGh3soh+8BXjv
    +3+s3O/a+yt1oIfyp3vKG6gAkdZEnlYdyORSjBFyEWd5A9Y628cDSf/1cKwf59h+
    EV/olCBlekM09n1Zkpw461ZdDX41/8DEhQEQMKR5EGAedSS4bt/0Uj0RRJfscu4+
    OqkTCJ9fT69pEroxMLG07JxwnU4J/UfRpbmPTyudqTqcXCXFsJNwRb6w1I9a8JhW
    spoP8DP8Y6L6HE/cft24FZmmId32IyKFInDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156479; bh=QmSuHcjRHDlkIkclg0D09ADVMutpzB
    Vu1T06xaQvV9U=; b=nUhywQ6mQnEwO6NYe+Bj1v0SXu5MLlHq5g+neCydiwo4E7
    HzCnWLNUBoqtohu7Y+OZmaWW9uHl2dNep0sGAVfxtHbQyh07oFAeg74/WsowsiMi
    SzWC07Z4DsiHi6a5zJFvCbEzStHRLVJDNYm+0+lL1jfuNYNfozOuQ3DTZX0H+1/l
    gmxl5s0IzrZaBFse64oeh09RjAIEHvfOYXMbQQe/sNNd6buPnkNc5RPo37ke+Pjb
    vo/KdFJLePl2UMSWf+WGbU1KX5K3I7Y5TIEAwTcjJFsjbUKMF2jRvH5VZCjfMwcN
    x+8lMELk6sVQXC4XbJ7swVao1wzuZvOBMFskCTyA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=zHbM4XJj x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=zHbM4XJj x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHoUovNnGqvoPhpyUHOU90LaEvmFdghJiKSURXtoV18rVIBm2blKzs0AhoXAsCeXODLj9lVj++KejVVLFtlUW5iY3/1//ZNCl8pSbX29lN/m7JepaHUw
    V8cXx5OboX8uri311nKZZz3raCBBW55QrQIy9GyI+flLgD7AePTvKfg19MpipTmX+gZsv2xfTGclCF4+3an8urwIo83eqfNYZEo/vIgvLJt10Dxh+1G2r46u
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mDV3o1hIAAAA:8 a=P1BnusSwAAAA:8 a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=sQARDKgQixnSql7upBYA:9 a=QEXdDO2ut3YA:10
    a=_FVE-zBwftR9WsbkzFJk:22 a=D0XLA9XvdZm18NrgonBM:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031409AbeEXKH4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031688AbeEXKGK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 137/161] media: s3c-camif: fix out-of-bounds array access
Date: Thu, 24 May 2018 11:39:22 +0200
Message-Id: <20180524093034.772463817@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
