Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832276-2-15645014642563585020
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
    t=1519832275; b=sVtVEexJshYKBuxbkw7Jb9tD/zOQNYUagvFMDRr7/InlzAO
    s+vl7aHwTa5dzQRfa9lUuLjSc1LbRRcTNIasO3pcQYw3RqNOQtmu77J/rrSlUwFT
    UJfgw2Uf7+W92qvHnjdxaaiQs0OkJT1ag2kvyziY8aOfcj3hQRHy/QNMTg0kOIYI
    rap5fuKWaaunThf052GpIEckQEUIfcg2ORZwehUDmgP2okTwFzF0Og1Rxcm3zkX8
    gHttxnMy9Lt4GXXWRqbG1sMX1aX+4wYf0NFqNNED1Q9IviXJfvay+XlmNDOiVp1G
    wmTtJzNLYqiqzjEShvZlyMd0kIrjGbk5xIlG2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832275; bh=7M1tUzs2e9LzQ2xm+99
    3TPJgFPjHJWV1nFU1Q0nuFc0=; b=vWHW1UQ3zZZVsSBWhZuJw6oYjWqKA+Nhb/a
    z1NsQJCkeYmYrdR3b3pNsJbKNzhj6e7lpYB1fxeC0C/a33eDVVYI9SA+uAdewjhS
    O7XYJo25cQSKMsMBqYg3VndXrSNJnD+NG2XzRn/vMUXfBu35zrvFW4OpqSHH2poK
    lvevz9sSAxyYu9arF6jXEkN66WeSG9e17ev7sLZfV40UkNkxWWn/HTSnHdsP2r6j
    vdbGPgFkwj4a+k2sSzZdQfiYD5j6V9b1KeU0jh1Ij3s+s8lvX0IcVRx29kqRL2gx
    SWog0qQddG1vN0b+3ZbLZ4jICCHT4Cr3brEWdNSaMojhVpx8JoQ==
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
        id S933271AbeB1Pgm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:36:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752738AbeB1PWe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Laurent Caumont" <lcaumont2@gmail.com>,
        "Sean Young" <sean@mess.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.430110147@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 040/254] media: dvb: i2c transfers over usb cannot be
 done from stack
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

From: Laurent Caumont <lcaumont2@gmail.com>

commit 6d33377f2abbf9f0e561b116dd468d1c3ff36a6a upstream.

Signed-off-by: Laurent Caumont <lcaumont2@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/dvb-usb/dibusb-common.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/dvb-usb/dibusb-common.c
+++ b/drivers/media/usb/dvb-usb/dibusb-common.c
@@ -179,8 +179,20 @@ EXPORT_SYMBOL(dibusb_i2c_algo);
 
 int dibusb_read_eeprom_byte(struct dvb_usb_device *d, u8 offs, u8 *val)
 {
-	u8 wbuf[1] = { offs };
-	return dibusb_i2c_msg(d, 0x50, wbuf, 1, val, 1);
+	u8 *buf;
+	int rc;
+
+	buf = kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = offs;
+
+	rc = dibusb_i2c_msg(d, 0x50, &buf[0], 1, &buf[1], 1);
+	*val = buf[1];
+	kfree(buf);
+
+	return rc;
 }
 EXPORT_SYMBOL(dibusb_read_eeprom_byte);
 
