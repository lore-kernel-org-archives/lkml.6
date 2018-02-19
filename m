Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4182733-1519043167-2-15877106238525238352
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519043166; b=gviBkUvwIXzkgABRx9pUK2aoiV6Vu7p4o8KB1N/2qDx/b+K
    G19drplg8p4YrMkL9XYjM88fDT83d7A7HLsNpkhSaAW0jVIbrJ6VPc/G4r9mLkOe
    /iJ/R05+MtlXxVYcri4SpNqSOXgA166DJCmNkL+gL4ZU/zCoyh5yLbNnJE3BFumK
    GDipWX3sThRxMipHnPnRNqNRKVwKEYLomUar4eJNSVPVCUhFrGZay77AaaWBtrJo
    v9Am6loLmsf3VFd470rxbp/9sOL2jxzz8MLzQaWVoa3WcjduSZSxzfiKpjUwqtlN
    yOn2199Z2R6wM+ljlMqGDQHZFWdfxOAMPLcThNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519043166; bh=y82s61debmGN1xS1s/BwgQqYQ6
    uVWqEpSB2xX9RZGhY=; b=JWRqw/Pb6UrFNQMt8Ydrpq15Ut/jNrODm2VrtRl0se
    iBBvywUXWGMELyvSL6I1VmO7rINVWF2jJVDvyVrWvOhDUKPwJtsygOZvcyzyON0Y
    M3IVof8pBpJmg7m8lXFJgLW4Z/SN9T+sEl24OlXIx1q0k0fBynC/DekOWOCn+x1G
    vs6u49ks4lqvr4v/wxVAt0C62L2/xT8UTpdC4AdM7Cyi8NgLDyUwi4687fVU+AJ7
    Unv8A5kUIbnjMVLBZ59Zf1LRJrrExxToILiBocrcWgsxpy/Kf5w/f/ZltRTGtYtg
    vZF9ZGWhtBKmQy4yYNdXCbwPHh/pDfWeKexKHFmyYP1Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=g0hl1n.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=g0hl1n.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=g0hl1n.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=g0hl1n.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeBSMZz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 07:25:55 -0500
Received: from relay04.alfahosting-server.de ([109.237.142.240]:29625 "EHLO
        relay04.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752659AbeBSMZx (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 07:25:53 -0500
X-Remote-Spam-DCC: : 
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1000.0 required=7.0 tests=BAYES_50,D_SENT_WITH_SASL
        autolearn=disabled version=3.2.5
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux@roeck-us.net, mathias.nyman@linux.intel.com,
        johan@kernel.org, felipe.balbi@linux.intel.com,
        ekorenevsky@gmail.com, peter.chen@nxp.com, drake@endlessm.com,
        joe@perches.com, Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH] usb: core: introduce per-port over-current counters
Date: Mon, 19 Feb 2018 13:01:07 +0100
Message-Id: <20180219120107.20434-1-dev@g0hl1n.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

For some userspace applications information on the number of
over-current conditions at specific USB hub ports is relevant. Therefore
introduce a oc_counter in the usb port struct which is exported via
sysfs.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
Tested on an i.MX6DL based board.
---
 drivers/usb/core/hub.c  |  4 +++-
 drivers/usb/core/hub.h  |  1 +
 drivers/usb/core/port.c | 10 ++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c5c1f6cf3228..448fba1e1827 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
 
 	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
 		u16 status = 0, unused;
+		port_dev->oc_count++;
 
-		dev_dbg(&port_dev->dev, "over-current change\n");
+		dev_dbg(&port_dev->dev, "over-current change #%u\n",
+			port_dev->oc_count);
 		usb_clear_port_feature(hdev, port1,
 				USB_PORT_FEAT_C_OVER_CURRENT);
 		msleep(100);	/* Cool down */
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 2a700ccc868c..b5cf567bf9e2 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -100,6 +100,7 @@ struct usb_port {
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
+	unsigned int oc_count;
 };
 
 #define to_usb_port(_dev) \
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 1a01e9ad3804..0bfe410eb8a7 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -41,6 +41,15 @@ static ssize_t connect_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(connect_type);
 
+static ssize_t oc_count_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	return sprintf(buf, "%u\n", port_dev->oc_count);
+}
+static DEVICE_ATTR_RO(oc_count);
+
 static ssize_t usb3_lpm_permit_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -109,6 +118,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
 
 static struct attribute *port_dev_attrs[] = {
 	&dev_attr_connect_type.attr,
+	&dev_attr_oc_count.attr,
 	NULL,
 };
 
-- 
2.11.0

