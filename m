Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519127472-2-11503448373746540704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127471; b=j4Wec3s89tpvDvtZMKlUUCaEEVXV4KmCnPVLQDKjxppRAFF
    iqXq4SP3gSTkhQAE9LDa17VQ7YjqY3cmO6yaF+Vb+8ZF5Ef3DJwI8eNLbbvziUNU
    q3Pv1NwRN+Plr330h7KvZzsEAJGxnT73xkK4sZqeP4I1lEKopdWJyJNU+mLol7s1
    Jh6dDax+DxzqpPBqfcfrVLy5cLFX5Fm5gu7LZg+Dz6pHvwq66FF5V6zllOxIp2Gm
    svmMI1HAYOIKotGW0UkveLsSP2qnt2/9USQcNXZFWFtMZfhjwfTlS3SBJP0wwGuc
    hfkcJyC0u//4gyOV5ZD1QnYTDjWulVad7EiCTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519127471; bh=nbY2g7DdpM1oHCrKHEno3Fw/dj
    A7KXatjeCMY6aji8I=; b=q6Zoq+maSm8N1vJSVEPJ5INLnmzrZzyTxCjrR0KNGF
    2qr4bsE53Bai0UkuGZxUtroiF2VlWoWpAj6qb8Tjd5GfRwnvwkCK7HppPtdCaiet
    alLVnFqPRKGKDUVGSVOWtWIwjzYe9zex4udwm9QwATs5KuEEioQg2y22bQsRu8T+
    AHZiOdqDJT4Hz0vgw5gQxvZgqd/dPsNivAJ0Y9ZAySaJxmh7SyRfEFYGnqKiKqqa
    t320ek0pTBginailEsY1EuIZ3Nhpj64ybVhkYte+4ehua/GSTkjOsWuceAjzFrPT
    tRaGpto0EVeujYeeoSx85KP9FFh7Z7S5QR+quqD4Vejg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=g0hl1n.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=g0hl1n.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=g0hl1n.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=g0hl1n.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBTLu4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:50:56 -0500
Received: from relay12.alfahosting-server.de ([109.237.142.232]:5252 "EHLO
        relay12.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751435AbeBTLuz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 06:50:55 -0500
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
Subject: [PATCH v2] usb: core: introduce per-port over-current counters
Date: Tue, 20 Feb 2018 12:50:33 +0100
Message-Id: <20180220115033.29496-1-dev@g0hl1n.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

For some userspace applications information on the number of
over-current conditions at specific USB hub ports is relevant.

In our case we have a series of USB hardware (using the cp210x driver)
which communicates using a proprietary protocol. These devices sometimes
trigger an over-current situation on some hubs. In case of such an
over-current situation the USB devices offer an interface for reducing
the max used power. As these conditions are quite rare and imply
performance reductions of the device we don't want to reduce the max
power always.

Therefore give user-space applications the possibility to react
adequately by introducing an over_current_counter in the usb port struct
which is exported via sysfs.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
Tested on an i.MX6DL based board

Changes v2:
	- rename oc_count to over_current_count
	- add entry to Documentation/ABI
	- add detailled description to commit message
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++++
 drivers/usb/core/hub.c                  |  4 +++-
 drivers/usb/core/hub.h                  |  1 +
 drivers/usb/core/port.c                 | 10 ++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 0bd731cbb50c..27020293c85b 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -189,6 +189,15 @@ Description:
 		The file will read "hotplug", "wired" and "not used" if the
 		information is available, and "unknown" otherwise.
 
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
+Date:		February 2018
+Contact:	Richard Leitner <richard.leitner@skidata.com>
+Description:
+		Most hubs are able to detect over-current situations on their
+		ports and report them to the kernel. This attribute is to expose
+		the number of over-current situation occurred on a specific port
+		to user space. This file will contain an unsigned int.
+
 What:		/sys/bus/usb/devices/.../(hub interface)/portX/usb3_lpm_permit
 Date:		November 2015
 Contact:	Lu Baolu <baolu.lu@linux.intel.com>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c5c1f6cf3228..6f779b518e75 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
 
 	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
 		u16 status = 0, unused;
+		port_dev->over_current_count++;
 
-		dev_dbg(&port_dev->dev, "over-current change\n");
+		dev_dbg(&port_dev->dev, "over-current change #%u\n",
+			port_dev->over_current_count);
 		usb_clear_port_feature(hdev, port1,
 				USB_PORT_FEAT_C_OVER_CURRENT);
 		msleep(100);	/* Cool down */
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 2a700ccc868c..78d7f4dad618 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -100,6 +100,7 @@ struct usb_port {
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
+	unsigned int over_current_count;
 };
 
 #define to_usb_port(_dev) \
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 1a01e9ad3804..6979bde87d31 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -41,6 +41,15 @@ static ssize_t connect_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(connect_type);
 
+static ssize_t over_current_count_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	return sprintf(buf, "%u\n", port_dev->over_current_count);
+}
+static DEVICE_ATTR_RO(over_current_count);
+
 static ssize_t usb3_lpm_permit_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -109,6 +118,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
 
 static struct attribute *port_dev_attrs[] = {
 	&dev_attr_connect_type.attr,
+	&dev_attr_over_current_count.attr,
 	NULL,
 };
 
-- 
2.11.0

