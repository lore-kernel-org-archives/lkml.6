Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-840750-1518038512-2-12301246007603302903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518038511; b=qsDt7FlqbN/SWobvq3qJ18qiliGMYidD/sS15J3aPj/1na7
    MQ7yeFDOP/5qZpCJVMBlFNdPf6MUA+OftnolU0FIeXXGDTSIp6GEp/sWwSLETxXZ
    y6HYhTbfsUoulI0dgd8jY7QiY+WitsXdjYOeEgTbCDPi25o6+s/TupNSqUXpqMo/
    CEjrAgTX4yaHDBYHZkFD8JAlnHYE9DwNf90ewKkXLRs6oDa69FUoLCU3Nto9fun0
    fnfx+YlwJMO6o9l4EhoYvib3gd/I8ZWs5H/PK77WXKVeG8O3+PEVjSbfJITpV+oC
    1FR0uam7wWaVLaGmKtPm1i7aJrgLgUqhfhPh05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038511; bh=2SJMuKNVeyMMcY7TCBiH4QI7yLHfgC1mCy8
    Trj9+Kjo=; b=qftOe/1lGy1DY+jCQSuXlBUvSSXV5jTngv/cXHPgqDPejKEYqPL
    H383+/VY28Tnx9IMpJRVLZfJFWMtqrZwJFOAoKnqD67FjHcxvzwoFRaPaMzwRbnB
    JJlxZoJL7PUTCe4o73MVRlxrtPSfBJVvT3AGYz4u+KS1RwoYVHo7vJqxRvDSyy/o
    7J+YvocA8K3YCaNQNVpSNoPP6v1TAmLS/v7+E6tqnYyAVCP1FB55YQhKCzTwNoV9
    i9Dl4kwqTCflyHtjNC4BYzGL7NEvDFswi3LWmgcr+A48Pa82Sysk//cy/FhnvmNO
    9gU5zq6GyNF8kF7wuEHBgXQfdXqJZQTm+oA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932327AbeBGVVG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:21:06 -0500
Received: from osg.samsung.com ([64.30.133.232]:57658 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932202AbeBGVVC (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:02 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 3/9] usbip: prevent vhci_hcd driver from leaking a socket pointer address
Date: Wed,  7 Feb 2018 14:20:26 -0700
Message-Id: <6ef62df7d7e421dbd71d065f7c1472a8d7c187e6.1518036867.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 2f2d0088eb93 ("usbip: prevent vhci_hcd driver from leaking a
socket pointer address")

When a client has a USB device attached over IP, the vhci_hcd driver is
locally leaking a socket pointer address via the

/sys/devices/platform/vhci_hcd/status file (world-readable) and in debug
output when "usbip --debug port" is run.

Fix it to not leak. The socket pointer address is not used at the moment
and it was made visible as a convenient way to find IP address from
socket pointer address by looking up /proc/net/{tcp,tcp6}.

As this opens a security hole, the fix replaces socket pointer address
with sockfd.

Reported-by: Secunia Research <vuln@secunia.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/usbip_common.h     |  1 +
 drivers/usb/usbip/vhci_sysfs.c       | 26 +++++++++++++++-----------
 tools/usb/usbip/libsrc/vhci_driver.c |  8 ++++----
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 86b08475c254..f875ccaa55f9 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -261,6 +261,7 @@ struct usbip_device {
 	/* lock for status */
 	spinlock_t lock;
 
+	int sockfd;
 	struct socket *tcp_socket;
 
 	struct task_struct *tcp_rx;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 211f43f67ea2..f05f1e0a2baf 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -39,16 +39,20 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 
 	/*
 	 * output example:
-	 * prt sta spd dev socket           local_busid
-	 * 000 004 000 000         c5a7bb80 1-2.3
-	 * 001 004 000 000         d8cee980 2-3.4
+	 * prt  sta spd dev      sockfd local_busid
+	 * 0000 004 000 00000000 000003 1-2.3
+	 * 0001 004 000 00000000 000004 2-3.4
 	 *
-	 * IP address can be retrieved from a socket pointer address by looking
-	 * up /proc/net/{tcp,tcp6}. Also, a userland program may remember a
-	 * port number and its peer IP address.
+	 * Output includes socket fd instead of socket pointer address to
+	 * avoid leaking kernel memory address in:
+	 *	/sys/devices/platform/vhci_hcd.0/status and in debug output.
+	 * The socket pointer address is not used at the moment and it was
+	 * made visible as a convenient way to find IP address from socket
+	 * pointer address by looking up /proc/net/{tcp,tcp6}. As this opens
+	 * a security hole, the change is made to use sockfd instead.
 	 */
 	out += sprintf(out,
-		       "prt sta spd bus dev socket           local_busid\n");
+		       "prt sta spd dev      sockfd local_busid\n");
 
 	for (i = 0; i < VHCI_NPORTS; i++) {
 		struct vhci_device *vdev = port_to_vdev(i);
@@ -59,12 +63,11 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 		if (vdev->ud.status == VDEV_ST_USED) {
 			out += sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
+			out += sprintf(out, "%06u ", vdev->ud.sockfd);
 			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));
 
-		} else {
-			out += sprintf(out, "000 000 000 0000000000000000 0-0");
-		}
+		} else
+			out += sprintf(out, "000 00000000 000000 0-0");
 
 		out += sprintf(out, "\n");
 		spin_unlock(&vdev->ud.lock);
@@ -223,6 +226,7 @@ static ssize_t store_attach(struct device *dev, struct device_attribute *attr,
 
 	vdev->devid         = devid;
 	vdev->speed         = speed;
+	vdev->ud.sockfd     = sockfd;
 	vdev->ud.tcp_socket = socket;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
 
diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index ad9204773533..1274f326242c 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -55,12 +55,12 @@ static int parse_status(const char *value)
 
 	while (*c != '\0') {
 		int port, status, speed, devid;
-		unsigned long socket;
+		int sockfd;
 		char lbusid[SYSFS_BUS_ID_SIZE];
 
-		ret = sscanf(c, "%d %d %d %x %lx %31s\n",
+		ret = sscanf(c, "%d %d %d %x %u %31s\n",
 				&port, &status, &speed,
-				&devid, &socket, lbusid);
+				&devid, &sockfd, lbusid);
 
 		if (ret < 5) {
 			dbg("sscanf failed: %d", ret);
@@ -69,7 +69,7 @@ static int parse_status(const char *value)
 
 		dbg("port %d status %d speed %d devid %x",
 				port, status, speed, devid);
-		dbg("socket %lx lbusid %s", socket, lbusid);
+		dbg("sockfd %u lbusid %s", sockfd, lbusid);
 
 
 		/* if a device is connected, look at it */
-- 
2.14.1

