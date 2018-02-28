Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836397-2-7747700698393343205
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
    t=1519836396; b=j6NUWoM2y3VvCLnS/FQJqxWN6QQVmbytHryeh3wwRj1LUoH
    KTEmUFUTorX7bFv5kjXn6bAaGNBXzeSAH5me3uW2OksTXy/Xc2MwwHwvVTtfK1rv
    axJVui6RvvJFplHBQyTYpivACafMQrzDm7YfTi6OVurl/NEYYB2baCQaqBRRNpj3
    1IFMLkTq1wnnimvoHxwSJbJgYsU1IY7bBM0vAJyw4YQQjbPqJjn0zUI8TA8xCBNS
    N52eEMB3S27yguWvWbUNXMBUt/E+lx/xZqqKR4DqgcdS7IjDZlr4dkv3iigXxrQ7
    UELWKSM4jLSoDXuPyxCnk8ZKWQDVOhf1XXX4iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836396; bh=5K4GN3N2L/oIBgXdhg4
    mWnpC+YtYEcX9KTs6hFaL694=; b=uUUvknZqhPvEmgT5ymGdQz9t4ta4cHnQ586
    +KZmWViK6Kds42aZM/wSNdE9MGrFyuhukyBwEycEViKXGdBUuCQKWZiNpYgber7M
    r3sljMQdLImQFR3V/KKToX4VhIOnyN39OWA7FuUqQMAodOpynTLsAehxfmr4GjwG
    rMexvbmzzfnRaHTikdDHJyU07LUt2eEBJiwRf3GWBNNNGNXP0UZf0oTVlJnwC+27
    4IloifCuP7wFBfwZVJvKILqnHUiZZEAF8LqfF+w9Vh2PppY09F+BZZIvWkqeQXkV
    9v2mpUlLxaZD/+DM8f7fkbJmvQ09fBDF/nVHqRNhU7Iwkxnlnww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeB1QAL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:00:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34637 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752450AbeB1QAJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:09 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Sean Young" <sean@mess.org>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Laurent Caumont" <lcaumont2@gmail.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.208773313@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 022/140] media: dvb: i2c transfers over usb cannot be
 done from stack
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

From: Laurent Caumont <lcaumont2@gmail.com>

commit 6d33377f2abbf9f0e561b116dd468d1c3ff36a6a upstream.

Signed-off-by: Laurent Caumont <lcaumont2@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/dvb/dvb-usb/dibusb-common.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/media/dvb/dvb-usb/dibusb-common.c
+++ b/drivers/media/dvb/dvb-usb/dibusb-common.c
@@ -169,8 +169,20 @@ EXPORT_SYMBOL(dibusb_i2c_algo);
 
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
 
