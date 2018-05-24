Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159479-2-15937150743639104784
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
    1527159478; b=WPovMnqFDO+VStG+n5KtWbGNSgtUKF6uNZxS8P9XJFd4dFINQ9
    Pw5WfYp+pfyAKkkbB333LKxVy+xr5YNvOqZU219jKVQYI1732bzlsxVJfzDr0egb
    5g7ridT9MLw66Ko/EP70pqd8wCxW4LJckHUSjzChULLvPMcg8ZJSsFKARcjSq9AM
    +GuMTB3S3iqr2yi/TvYtP1Aj/iFr3dVES88+IZyecagDNdijqGg4Kvy4URnC9no0
    W3eCurrjd/2/GJbciVexioQ0Gvu3OL8ylI/2iWIaPaEJL0s3NTJGPRp65MFZ01AO
    NIDayPU3RDk6Z53ZjCkjTs7aHfpSRhzF6PEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159478; bh=Rj71z00e5sEZgHYb2B/G+/DVNjeJsu
    Yp2uyaVVdNKvk=; b=m5SRapU/rv4sfkFlF1R8Vi2BgyvCjwjsFquVCywgw3nH+x
    dwjBWI0X0wtRkNzxHZrUy8c1EeHEsXuHVgFyEogYntg7Xtw1TCo//DuKdJqBq5VX
    G8202Ye+Q2WK+/TVLH5F1/+XWEsFCAHIZKVtoafJDpHPVX99s229cmAHnokAOVk3
    gFGeStnorgKl2wqPg7DwHicc/9SmxMDXPlrBQQ9Nu0fzjQYybj4/FS6RU/vB6MsJ
    WY2jD0/seoSy97x5T6TTkD7jnNiYGcP+uZRTxD4gxDrO//jJsUR3L75iTRWzEHyL
    BNtS+iClJ3ncZoLxYpr4UJz2EEk0v7XOFgnTR5Ow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=lex2a0jy x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=lex2a0jy x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDXAHsZ8yCvHPNh7AOfR39mmUwfmZ191ceE4wxg6wmh5JYHOIneokmzj/MzFFvdXfUDRh8F6MQeSldvDRAbZ73vwRzZZOHNgawkV8aB5j4naEXte9BZ5
    st4lxKbb7GnMXSbjdKNCtM70t58Nr+uAjl9bLpbttj1IFNTri+DYPJ+q2YYS6D8C+MuUEFbWvd6WkDAhDyI2Hl1wvquMJ+DXC2pjA1Ba529wNqFhdhVk2r3d
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=KtuSVvygwG24pxXr48oA:9 a=NsFYcnmvi5UWX7ow:21 a=h_NTAUzmfRHWsXK-:21
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030248AbeEXJ4H (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030210AbeEXJ4D (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Dickens <christopher.a.dickens@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 080/165] usb: gadget: composite: fix incorrect handling of OS desc requests
Date: Thu, 24 May 2018 11:38:06 +0200
Message-Id: <20180524093625.256494987@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Dickens <christopher.a.dickens@gmail.com>

[ Upstream commit 5d6ae4f0da8a64a185074dabb1b2f8c148efa741 ]

When handling an OS descriptor request, one of the first operations is
to zero out the request buffer using the wLength from the setup packet.
There is no bounds checking, so a wLength > 4096 would clobber memory
adjacent to the request buffer. Fix this by taking the min of wLength
and the request buffer length prior to the memset. While at it, define
the buffer length in a header file so that magic numbers don't appear
throughout the code.

When returning data to the host, the data length should be the min of
the wLength and the valid data we have to return. Currently we are
returning wLength, thus requests for a wLength greater than the amount
of data in the OS descriptor buffer would return invalid (albeit zero'd)
data following the valid descriptor data. Fix this by counting the
number of bytes when constructing the data and using this when
determining the length of the request.

Signed-off-by: Chris Dickens <christopher.a.dickens@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |   40 +++++++++++++++++++---------------------
 include/linux/usb/composite.h  |    3 +++
 2 files changed, 22 insertions(+), 21 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1425,7 +1425,7 @@ static int count_ext_compat(struct usb_c
 	return res;
 }
 
-static void fill_ext_compat(struct usb_configuration *c, u8 *buf)
+static int fill_ext_compat(struct usb_configuration *c, u8 *buf)
 {
 	int i, count;
 
@@ -1452,10 +1452,12 @@ static void fill_ext_compat(struct usb_c
 				buf += 23;
 			}
 			count += 24;
-			if (count >= 4096)
-				return;
+			if (count + 24 >= USB_COMP_EP0_OS_DESC_BUFSIZ)
+				return count;
 		}
 	}
+
+	return count;
 }
 
 static int count_ext_prop(struct usb_configuration *c, int interface)
@@ -1500,25 +1502,20 @@ static int fill_ext_prop(struct usb_conf
 	struct usb_os_desc *d;
 	struct usb_os_desc_ext_prop *ext_prop;
 	int j, count, n, ret;
-	u8 *start = buf;
 
 	f = c->interface[interface];
+	count = 10; /* header length */
 	for (j = 0; j < f->os_desc_n; ++j) {
 		if (interface != f->os_desc_table[j].if_id)
 			continue;
 		d = f->os_desc_table[j].os_desc;
 		if (d)
 			list_for_each_entry(ext_prop, &d->ext_prop, entry) {
-				/* 4kB minus header length */
-				n = buf - start;
-				if (n >= 4086)
-					return 0;
-
-				count = ext_prop->data_len +
+				n = ext_prop->data_len +
 					ext_prop->name_len + 14;
-				if (count > 4086 - n)
-					return -EINVAL;
-				usb_ext_prop_put_size(buf, count);
+				if (count + n >= USB_COMP_EP0_OS_DESC_BUFSIZ)
+					return count;
+				usb_ext_prop_put_size(buf, n);
 				usb_ext_prop_put_type(buf, ext_prop->type);
 				ret = usb_ext_prop_put_name(buf, ext_prop->name,
 							    ext_prop->name_len);
@@ -1544,11 +1541,12 @@ static int fill_ext_prop(struct usb_conf
 				default:
 					return -EINVAL;
 				}
-				buf += count;
+				buf += n;
+				count += n;
 			}
 	}
 
-	return 0;
+	return count;
 }
 
 /*
@@ -1830,6 +1828,7 @@ unknown:
 			req->complete = composite_setup_complete;
 			buf = req->buf;
 			os_desc_cfg = cdev->os_desc_config;
+			w_length = min_t(u16, w_length, USB_COMP_EP0_OS_DESC_BUFSIZ);
 			memset(buf, 0, w_length);
 			buf[5] = 0x01;
 			switch (ctrl->bRequestType & USB_RECIP_MASK) {
@@ -1853,8 +1852,8 @@ unknown:
 					count += 16; /* header */
 					put_unaligned_le32(count, buf);
 					buf += 16;
-					fill_ext_compat(os_desc_cfg, buf);
-					value = w_length;
+					value = fill_ext_compat(os_desc_cfg, buf);
+					value = min_t(u16, w_length, value);
 				}
 				break;
 			case USB_RECIP_INTERFACE:
@@ -1883,8 +1882,7 @@ unknown:
 							      interface, buf);
 					if (value < 0)
 						return value;
-
-					value = w_length;
+					value = min_t(u16, w_length, value);
 				}
 				break;
 			}
@@ -2159,8 +2157,8 @@ int composite_os_desc_req_prepare(struct
 		goto end;
 	}
 
-	/* OS feature descriptor length <= 4kB */
-	cdev->os_desc_req->buf = kmalloc(4096, GFP_KERNEL);
+	cdev->os_desc_req->buf = kmalloc(USB_COMP_EP0_OS_DESC_BUFSIZ,
+					 GFP_KERNEL);
 	if (!cdev->os_desc_req->buf) {
 		ret = -ENOMEM;
 		usb_ep_free_request(ep0, cdev->os_desc_req);
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -53,6 +53,9 @@
 /* big enough to hold our biggest descriptor */
 #define USB_COMP_EP0_BUFSIZ	1024
 
+/* OS feature descriptor length <= 4kB */
+#define USB_COMP_EP0_OS_DESC_BUFSIZ	4096
+
 #define USB_MS_TO_HS_INTERVAL(x)	(ilog2((x * 1000 / 125)) + 1)
 struct usb_configuration;
 
