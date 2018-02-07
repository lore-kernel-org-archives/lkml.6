Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-841976-1518038615-2-7458478605279136453
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
    t=1518038614; b=KFvjX3xdxHithPAyOgYo2JbBxFfWeX6g2Cm6zYZzHBr7vqY
    4D7wInfzgBg1HMHK3uak4DWAO2iBQD99CksFUNzDrGQ4/FGgXS4EbngU66gLisyA
    2HLNHicM2LLh5fmlh8nfZ4vf5XFGKqtehhO+Wrx/xoGVnsEn2OOui04CxNnT0Au+
    2ELRUHTU+c+gG1YE65vF2akBUVHB5j3VlyyvK6UUpGoe2re8G8EYNAph78LHiJpH
    3VXf6bDB5b003qaX8CFCFZPzQZ9lMjrictrBACr4IBW4IqhX08EKzHW+BWWD+J02
    EKy8kHO5Zp5ITef80DbRx+a619BliP5ItWXqwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038614; bh=q+PSIkM7wDV5Q9sveP6Ah5s6QIiH5QGOmDc
    iLpRRaW0=; b=XXDPA821+AGtPM7UmnG/gUVyDgd7DUwlAhq1v49amq5pPHvu4QN
    mfjbCueX4XM6qtvBNFp1v1ia2iFI7l2rVVdHfHyHxLwmUKnF+HLL99hmwbePWfUY
    G2+4+9Wa+r4Wj5uSPvJPrhiLaboNLKQGsZH6KL6EO2OkDxw62UcimXRAZ5sJgkUm
    RUES5LAnW//WxSRiqsvLUyvdxJsc4RBYTB3H+tfCmmE0eyGsj6geZvBrLakAgqsU
    7VV0BsNBmZejET9rZDgKbdlAWxDaZo/VAf6RkIUsjM1JLcAvrXgoF6uEfFq4FbDY
    yFhwx737/rSsEj+joghVrXldsJaJSr/PwkQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754924AbeBGVXR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:23:17 -0500
Received: from osg.samsung.com ([64.30.133.232]:64463 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932247AbeBGVVC (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:02 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, jdieter@lesbg.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, peter.senna@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 4/9] usbip: Fix potential format overflow in userspace tools
Date: Wed,  7 Feb 2018 14:20:27 -0700
Message-Id: <b05468923d65eb114fff87a5e93e819133f94e2f.1518036867.git.shuahkh@osg.samsung.com>
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

Upstream commit e5dfa3f902b9 ("usbip: Fix potential format overflow in
userspace tools")

The usbip userspace tools call sprintf()/snprintf() and don't check for
the return value which can lead the paths to overflow, truncating the
final file in the path.

More urgently, GCC 7 now warns that these aren't checked with
-Wformat-overflow, and with -Werror enabled in configure.ac, that makes
these tools unbuildable.

This patch fixes these problems by replacing sprintf() with snprintf()
in one place and adding checks for the return value of snprintf().

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/usb/usbip/libsrc/usbip_common.c      |  9 ++++++++-
 tools/usb/usbip/libsrc/usbip_host_driver.c | 27 ++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/usb/usbip/libsrc/usbip_common.c b/tools/usb/usbip/libsrc/usbip_common.c
index ac73710473de..8000445ff884 100644
--- a/tools/usb/usbip/libsrc/usbip_common.c
+++ b/tools/usb/usbip/libsrc/usbip_common.c
@@ -215,9 +215,16 @@ int read_usb_interface(struct usbip_usb_device *udev, int i,
 		       struct usbip_usb_interface *uinf)
 {
 	char busid[SYSFS_BUS_ID_SIZE];
+	int size;
 	struct udev_device *sif;
 
-	sprintf(busid, "%s:%d.%d", udev->busid, udev->bConfigurationValue, i);
+	size = snprintf(busid, sizeof(busid), "%s:%d.%d",
+			udev->busid, udev->bConfigurationValue, i);
+	if (size < 0 || (unsigned int)size >= sizeof(busid)) {
+		err("busid length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(busid));
+		return -1;
+	}
 
 	sif = udev_device_new_from_subsystem_sysname(udev_context, "usb", busid);
 	if (!sif) {
diff --git a/tools/usb/usbip/libsrc/usbip_host_driver.c b/tools/usb/usbip/libsrc/usbip_host_driver.c
index bef08d5c44e8..071b9ce99420 100644
--- a/tools/usb/usbip/libsrc/usbip_host_driver.c
+++ b/tools/usb/usbip/libsrc/usbip_host_driver.c
@@ -39,13 +39,19 @@ struct udev *udev_context;
 static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
 {
 	char status_attr_path[SYSFS_PATH_MAX];
+	int size;
 	int fd;
 	int length;
 	char status;
 	int value = 0;
 
-	snprintf(status_attr_path, SYSFS_PATH_MAX, "%s/usbip_status",
-		 udev->path);
+	size = snprintf(status_attr_path, SYSFS_PATH_MAX, "%s/usbip_status",
+			udev->path);
+	if (size < 0 || (unsigned int)size >= sizeof(status_attr_path)) {
+		err("usbip_status path length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(status_attr_path));
+		return -1;
+	}
 
 	fd = open(status_attr_path, O_RDONLY);
 	if (fd < 0) {
@@ -225,6 +231,7 @@ int usbip_host_export_device(struct usbip_exported_device *edev, int sockfd)
 {
 	char attr_name[] = "usbip_sockfd";
 	char sockfd_attr_path[SYSFS_PATH_MAX];
+	int size;
 	char sockfd_buff[30];
 	int ret;
 
@@ -244,10 +251,20 @@ int usbip_host_export_device(struct usbip_exported_device *edev, int sockfd)
 	}
 
 	/* only the first interface is true */
-	snprintf(sockfd_attr_path, sizeof(sockfd_attr_path), "%s/%s",
-		 edev->udev.path, attr_name);
+	size = snprintf(sockfd_attr_path, sizeof(sockfd_attr_path), "%s/%s",
+			edev->udev.path, attr_name);
+	if (size < 0 || (unsigned int)size >= sizeof(sockfd_attr_path)) {
+		err("exported device path length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(sockfd_attr_path));
+		return -1;
+	}
 
-	snprintf(sockfd_buff, sizeof(sockfd_buff), "%d\n", sockfd);
+	size = snprintf(sockfd_buff, sizeof(sockfd_buff), "%d\n", sockfd);
+	if (size < 0 || (unsigned int)size >= sizeof(sockfd_buff)) {
+		err("socket length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(sockfd_buff));
+		return -1;
+	}
 
 	ret = write_sysfs_attribute(sockfd_attr_path, sockfd_buff,
 				    strlen(sockfd_buff));
-- 
2.14.1

