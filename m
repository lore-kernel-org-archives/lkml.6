Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325815-2-14379197494050957871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325814; b=pZ1JbMn90CrdtFsPdOjh1J0qRhJhO33xPQOHFEgiJNCkXF3
    h368mi9MzSYs5mweaSMMmYIygqwHVeUtrf+tl92k+mC2bRHubrOoq3TGUgzCLODa
    crWzL6ivefh4bEG5KTIRAad0fMDmLt0hadznNwafirtnqidD3gDeeN+gjRO/FuP+
    dpajSF+yAyyiHlSIfLa1YQxDS4yx77NEgOGlty+OBL0T9Z8mRuPdn7IltNtGdYb5
    HXo/zBXJgNZUjI5GRVj0udJ0NXfnbCep/6Hj1NlPHhtlLO2cYyFQQkSeRfuIYhWF
    N62tv2N3u0NTiKSPT8Bw3dBLEvxpwxtBhizxEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325814; bh=aG6/P4xuObV5J5Q5Ucx
    49nNizrmmI2h3RPv34sOoSvU=; b=vgwdqBr6sYGRm0Z7TxbIorFVI9onQjEOt2p
    bucBny2Cors72aNoYFIlsL3FfG5CoJ3kTOwHwVbL7NzACFBo+qJqbose+tYdAuTo
    Jn7vpBLWqCJgtldLB0qTcA7Rc+1P8nrPVNW9HROfs52pHNZ/JblLiYq38PBkt9Mn
    3/5jX5Capv4gW6wlP6S+9z+tcOJANURKU0vdimSFpaw8M3O+IicvCdmWNGnZgnJt
    e7X5QnHVoeD+PmjmcBz30k3DCQ4/E7QGrsKjvsAO2iaPuc9YKNFicD5ITSSWgGca
    vLPZUx6HAn5yACGf2iiOX3IPoULMR/1wCoOQ4Sz8YONLlxAOf6A==
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
        id S1753430AbeBKFJ2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:09:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41441 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752648AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.945573344@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 72/79] usb: add helper to extract bits 12:11 of
 wMaxPacketSize
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit 541b6fe63023f3059cf85d47ff2767a3e42a8e44 upstream.

According to USB Specification 2.0 table 9-4,
wMaxPacketSize is a bitfield. Endpoint's maxpacket
is laid out in bits 10:0. For high-speed,
high-bandwidth isochronous endpoints, bits 12:11
contain a multiplier to tell us how many
transactions we want to try per uframe.

This means that if we want an isochronous endpoint
to issue 3 transfers of 1024 bytes per uframe,
wMaxPacketSize should contain the value:

	1024 | (2 << 11)

or 5120 (0x1400). In order to make Host and
Peripheral controller drivers' life easier, we're
adding a helper which returns bits 12:11. Note that
no care is made WRT to checking endpoint type and
gadget's speed. That's left for drivers to handle.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/usb/ch9.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -390,6 +390,11 @@ struct usb_endpoint_descriptor {
 #define USB_ENDPOINT_XFER_INT		3
 #define USB_ENDPOINT_MAX_ADJUSTABLE	0x80
 
+#define USB_EP_MAXP_MULT_SHIFT	11
+#define USB_EP_MAXP_MULT_MASK	(3 << USB_EP_MAXP_MULT_SHIFT)
+#define USB_EP_MAXP_MULT(m) \
+	(((m) & USB_EP_MAXP_MULT_MASK) >> USB_EP_MAXP_MULT_SHIFT)
+
 #define USB_ENDPOINT_SYNCTYPE		0x0c
 #define USB_ENDPOINT_SYNC_NONE		(0 << 2)
 #define USB_ENDPOINT_SYNC_ASYNC		(1 << 2)
@@ -592,6 +597,20 @@ static inline int usb_endpoint_maxp(cons
 	return __le16_to_cpu(epd->wMaxPacketSize);
 }
 
+/**
+ * usb_endpoint_maxp_mult - get endpoint's transactional opportunities
+ * @epd: endpoint to be checked
+ *
+ * Return @epd's wMaxPacketSize[12:11] + 1
+ */
+static inline int
+usb_endpoint_maxp_mult(const struct usb_endpoint_descriptor *epd)
+{
+	int maxp = __le16_to_cpu(epd->wMaxPacketSize);
+
+	return USB_EP_MAXP_MULT(maxp) + 1;
+}
+
 /*-------------------------------------------------------------------------*/
 
 /* USB_DT_SS_ENDPOINT_COMP: SuperSpeed Endpoint Companion descriptor */
