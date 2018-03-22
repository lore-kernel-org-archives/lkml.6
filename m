Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1321235-1521685356-2-9063260692324811579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521685356; b=I+hdFxPgN7a1YhPxuteIoJfcx5HEm7Xx0TWN1Cr/W5gkrpR
    bEcJOmCEaiXohe4aWHq2KHVbVJVBWQsoEHijs5UwU3wkivkpyH92GQd799EfVoUR
    wB7/vCkrCIZlbcs0Mq2GZDPfCbKhPhQAAHVH4YVomDCIRJX/udvQgL9OXzpvUxA4
    FxI/RotjhLRYdfEuB51NoeJmU5IdYbNvE6eza1iwK+VENlI0u9I/tPqxa+YFeaUW
    42Y0vQG9BGgXwqkUzKHEwR1IRmlylmTkvVly4OoQj/fuvq2SVCi/1sqLR+9xkbjc
    mT9+d5qKt7ZKr8VRMtVCK3LR0CgkE57rMIe4fWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521685356; bh=8xM9aPRJR+7igo0WJtxutYl//S
    oEQPpcrskEcsWN1ec=; b=XSwfLEyEYoOvVg2UP59U8AeSVHWgwHVlWWX8YzTAxf
    5gq3ASfSr4WURoZhVxvKkDd94gPrNy6ZSei67YKvLmxhEyLXIuZdoHpCfNShHTZb
    LZSejm7DJqZMfGfgwUh0T+8Q1X3GUiklKw8z0lpFGyqOVdKquMVCiN+tNdwcgxf7
    v2JQjUy8YTi35n5OW7SwTlLqp8NGfHRKEfs8OlViu/KGxp2jOLotKZw1DMXZvWgv
    bDzghtjfVSgf6cs+lJv3nMmunp9yG7xsm3V30BBiJHqLZfE0roRs5Ac0zMV6M0Ba
    po6FSmn0jB+tDcOz5Iz45AKYkAc58KnSRulsFZgev6jg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeCVCWX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 22:22:23 -0400
Received: from osg.samsung.com ([64.30.133.232]:62994 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeCVCWV (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 21 Mar 2018 22:22:21 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
        julien.boibessot@armadeus.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: tools: usbipd: exclude exported devices from exportable device list
Date: Wed, 21 Mar 2018 20:21:56 -0600
Message-Id: <20180322022156.27585-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

usbipd includes exported devices in response to exportable device list.
Exclude exported devices from exportable device list to avoid:

- import requests for devices that are exported only to fail the request.
- revealing devices that are imported by a client to another client.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/usb/usbip/src/usbipd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
index f8ff735eb100..32864c52942d 100644
--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -175,10 +175,21 @@ static int send_reply_devlist(int connfd)
 	struct list_head *j;
 	int rc, i;
 
+	/*
+	 * Exclude devices that are already exported to a client from
+	 * the exportable device list to avoid:
+	 *	- import requests for devices that are exported only to
+	 *	  fail the request.
+	 *	- revealing devices that are imported by a client to
+	 *	  another client.
+	 */
+
 	reply.ndev = 0;
 	/* number of exported devices */
 	list_for_each(j, &driver->edev_list) {
-		reply.ndev += 1;
+		edev = list_entry(j, struct usbip_exported_device, node);
+		if (edev->status != SDEV_ST_USED)
+			reply.ndev += 1;
 	}
 	info("exportable devices: %d", reply.ndev);
 
@@ -197,6 +208,9 @@ static int send_reply_devlist(int connfd)
 
 	list_for_each(j, &driver->edev_list) {
 		edev = list_entry(j, struct usbip_exported_device, node);
+		if (edev->status == SDEV_ST_USED)
+			continue;
+
 		dump_usb_device(&edev->udev);
 		memcpy(&pdu_udev, &edev->udev, sizeof(pdu_udev));
 		usbip_net_pack_usb_device(1, &pdu_udev);
-- 
2.14.1

