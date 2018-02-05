Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517852812-2-11655590961627889200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517852811; b=p6a2iN/uo6q7t4P4hvtdnUShy1P6w6nhre//7OiUrO54kkG
    6cAZpHOC6tPUFA7T5I0NRyUvYNpIkyFdT+G8fIoSVt0lkVNoxvjNM8txljuTB19f
    xkeUmFJYklKCVfmZ9l07L5KpPMlrq+l5ycrFPwoYruiZwya1xtG9/fungVOLYNpk
    13oIEtrita3GHIgjgcxAbW9Ir9m9u1NXmtInMPmHdoA/2G7/1BxQZPWDvqRIkQJL
    Xypv9YBoSfsdsNp1cInJ7jZ+O8R69BFqwW2mSDNs7iYR8EAUBxPCORXBMJjfZrIf
    +3yMsQITSdaUleCA0FQdVAb+Zf0I0wjFS3tnp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1517852811; bh=zb9RU0il1IatmxJVW6UofDsQirZc7PLev8g
    B6iReAJQ=; b=nP0wFH2ZkF5myEvVyT4ZM6IHQb6vORGGlnnT83YnFq4Fzxhtp5b
    cVZQ0XKg4cRmgqRC+25tRT7jT8xX33BL+ateOAWggztHjgoC6L1O8tH2kdXPaGve
    7bwkV/vDYnHKkBniJedHWKMNh3KFcfgZOJsjpQ76J3VkzoU1RIUMikUcbDYTsLCB
    iCMvU2MqeiemQVX6LA91sU515JmXMehjrgTXOYYRBCDOQhkTTywPfrFdhQ5yXF+J
    HsIzOSU9ZtJL7dgch3AKMjamMPL35m0cjDlmVFtgvormDNX15dwo4NIhMuhvMND1
    xfaa/UChfmYkEghSWDu6kvVKgpl8grADgJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeBERqs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 12:46:48 -0500
Received: from osg.samsung.com ([64.30.133.232]:37454 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753236AbeBERqV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Feb 2018 12:46:21 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, ebiggers3@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 v2 2/2] usbip: fix 3eee23c3ec14 tcp_socket address still in the status file
Date: Mon,  5 Feb 2018 10:45:56 -0700
Message-Id: <920dbeada86c864f5280c363188125481399d109.1517852038.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1517852037.git.shuahkh@osg.samsung.com>
References: <cover.1517852037.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1517852037.git.shuahkh@osg.samsung.com>
References: <cover.1517852037.git.shuahkh@osg.samsung.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 3eee23c3ec14 ("usbip: prevent vhci_hcd driver from leaking a
socket pointer address") backported the following commit from mailine.
However, backport error caused the tcp_socket address to still leak.

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

Reported-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/vhci_sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 1c7f41a65565..b9432fdec775 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -53,7 +53,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	 * a security hole, the change is made to use sockfd instead.
 	 */
 	out += sprintf(out,
-		       "prt sta spd bus dev sockfd local_busid\n");
+		       "prt sta spd dev      sockfd local_busid\n");
 
 	for (i = 0; i < VHCI_NPORTS; i++) {
 		struct vhci_device *vdev = port_to_vdev(i);
@@ -64,12 +64,11 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 		if (vdev->ud.status == VDEV_ST_USED) {
 			out += sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
-			out += sprintf(out, "%06u", vdev->ud.sockfd);
+			out += sprintf(out, "%06u ", vdev->ud.sockfd);
 			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));
 
 		} else
-			out += sprintf(out, "000 000 000 000000 0-0");
+			out += sprintf(out, "000 00000000 000000 0-0");
 
 		out += sprintf(out, "\n");
 		spin_unlock(&vdev->ud.lock);
-- 
2.14.1
