Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405350-2-2902420087838382757
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405350; b=UutgXuzBYDCf+EXbqgBN1/ypY3d8ftJ6pUV61i379DWMISOqyp
    og0K7ZFonWtEhYpJlah+T3FF6FPdT1U+AQmAG+ojbkhIBJK50DIPWYJjuLhQosFQ
    0QYs3w/fa6L0KwG9zxsaEyUDPoHYNn2Jkk+/hlj3YME3o1/AFVtJt/x+RHUM+uXU
    O260YDd6Clf5i4Viu5ecE+V3v24kxOlSO4QC1buNds8OXsEHOLGlc/NhIQ5Yl38P
    sqO7qf6OKpQTcPpKYkgDTSkmXqBVDqT/SK63udX8eyx+pTAO18VwIJtq/JR3qhJ+
    oDJySjYLtsAHK3UtvGjTv886+6Acy+rXIfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405350; bh=jF/+kdMhcr+dq5yu1TYpB7T0Q2QBOc
    XErw/kmIpTUos=; b=iCJD/zQDI554ud0J0G2qV1CeGKzMnuxiLIApzQn2HAmctb
    HW0vZ+hUVaRw6NOgVAfX5v7jnERcAaEW2bf4O0UnElBdwyvOrPJPC7JY4elIhj7t
    0kPsigTiWedVkNzrAO2tCaCMSciJBVZWJbNwfSQII8FCQPCzFZaOq6IwpSah1jVc
    JTKLx9WYLBXFnywzVT2pEXd5oXuLBqrwJLhO/ugv9Oc/zAkcJxSrWx6QTRL05tHf
    ErSbzU9F4wSzH7RPegyo+fKhPcy1ONs66/5hg66XZ1yZrX+JdDwMdH7dEPlSGSWN
    YtF5YyODksh4sbtJJkkIT6ugzmHhuKwbTX05xpWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfObcEXkvtlefEaUkF84ywqEKUnu/KlyQOZgQgSpOEJiBoTBW4eVIDbIoaUv5GlFp1rORu1qHcUbi/A/u9342Jvy7rCKEyuAmjzaqkz5YVEvZHJN8waX4
    YfnAY/xb8YXbMBjINEY3OsQHI1nMoB9/oS2m7On6HFMbmgMU7IA+uhoEvKGKHXURWAqKbR55Fo/3VTGQHaa9heWT1AFxYFi+zib1AcPaf9kn9NqZ5KK52AJ7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AUd_NHdVAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8
    a=ag1SF4gXAAAA:8 a=mGXApyF1NEALweIKoLoA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeDVNzp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:55:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeDVNzn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:55:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.16 031/196] media: atomisp_fops.c: disable atomisp_compat_ioctl32
Date: Sun, 22 Apr 2018 15:50:51 +0200
Message-Id: <20180422135105.711303591@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil@xs4all.nl>

commit 57e6b6f2303e596a6493078b53be14b789e7b79f upstream.

The atomisp_compat_ioctl32() code has problems. This patch disables the
compat_ioctl32 support until those issues have been fixed.

Contact Sakari or me for more details.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.12 and up
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c
@@ -1279,7 +1279,10 @@ const struct v4l2_file_operations atomis
 	.mmap = atomisp_mmap,
 	.unlocked_ioctl = video_ioctl2,
 #ifdef CONFIG_COMPAT
+	/*
+	 * There are problems with this code. Disable this for now.
 	.compat_ioctl32 = atomisp_compat_ioctl32,
+	 */
 #endif
 	.poll = atomisp_poll,
 };
@@ -1291,7 +1294,10 @@ const struct v4l2_file_operations atomis
 	.mmap = atomisp_file_mmap,
 	.unlocked_ioctl = video_ioctl2,
 #ifdef CONFIG_COMPAT
+	/*
+	 * There are problems with this code. Disable this for now.
 	.compat_ioctl32 = atomisp_compat_ioctl32,
+	 */
 #endif
 	.poll = atomisp_poll,
 };
