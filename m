Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727090-1517912134-2-6877711062380630395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517912133; b=JPLactIgmIt2jOj1AAZYrTwEeyaqQeziaByHyzaifROxnYD
    H+waN+huZ2j94uEbLAAW0pTdNxd0FyvDwRxA9IgTFyGGgxlZz48/ayOgG+/fD+No
    DJ9iwkOmiiJBCn0W4UEXW+Pt8M4RsCymlcJLQGjd/qTebbN3JwKEdU8YkavUBAIb
    SrgALvjxJN12JwcLUBUtTVSt5ve2WSqb8ZzoXj0vKlPpAdCeN+L0kQyODBhZNpAw
    OhKu8JUoR6CNp5yYaW7aXHMhIVogNbiOdJSwgU/RDL1HJMqtfClo2THcEcL6ys+E
    u/Wh834uu9jS0tXhF1Fdkm06CxGUdWx+mhzF3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517912133;
    bh=gjx521YQ6DafvFnwyiCr1I9K4eQbNt0X/0rSvxg+qRw=; b=QlUTC1fbgtx2
    KZWaRxgbmRxAo7Tj+fPY7uX+LeYi1cXWMozDiCrVD2+8Kwamwi8FmCJK60+GRpo3
    TpBgnWiuII/n6ZfWwvMBmbBmakuP2RlKCBbBoc0Zg1PO/lQXkjiYBpxcpCiWdGbS
    nxHKufXM0kqOh3sUCSFrq3FsFbZ22uqHzDHvuVKlYDPb9E1fcbg/FIsUe+ICFtZ4
    tFDjRy2ZdcAmCQKz1MtcHIVfXe+Tskl1J9tSpQrHYLpMYa5Z8gMuUX8N0C7t72wi
    TaSyXKuMtDQ7H1pmoyNrWdckYvVzhC0PC6e9h+jTDQZ0PrMt5H4WuhTplhmIC4ET
    XlUYSBcx4A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeBFKPQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:15:16 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:45486 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeBFKPD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 05:15:03 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 3/6] usb: gadget: Add NO_DMA dummies for DMA mapping API
Date: Tue,  6 Feb 2018 11:14:49 +0100
Message-Id: <1517912092-15470-4-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for usb_gadget_{,un}map_request{,_by_dev}(), to allow
compile-testing if NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "usb_gadget_unmap_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
    ERROR: "usb_gadget_map_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
    ERROR: "usb_gadget_map_request" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "usb_gadget_unmap_request" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "usb_gadget_map_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!
    ERROR: "usb_gadget_unmap_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/usb/gadget.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 66a5cff7ee142d6a..b68e7f9b210be122 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -805,6 +805,7 @@ int usb_otg_descriptor_init(struct usb_gadget *gadget,
 
 /* utility to simplify map/unmap of usb_requests to/from DMA */
 
+#ifdef	CONFIG_HAS_DMA
 extern int usb_gadget_map_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in);
 extern int usb_gadget_map_request(struct usb_gadget *gadget,
@@ -814,6 +815,17 @@ extern void usb_gadget_unmap_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in);
 extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in);
+#else /* !CONFIG_HAS_DMA */
+static inline int usb_gadget_map_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in) { return -ENOSYS; }
+static inline int usb_gadget_map_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in) { return -ENOSYS; }
+
+static inline void usb_gadget_unmap_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in) { }
+static inline void usb_gadget_unmap_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in) { }
+#endif /* !CONFIG_HAS_DMA */
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.7.4

