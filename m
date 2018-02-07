Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-841976-1518038572-2-15345460385229233278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518038572; b=kYJvjRWD6hIoabcnygcBECEXziAskaPBuUPggwAydkRcXRF
    n803cujHPshBDWn0/oaKN21b08z6HJ7eQJV6fVj7Pj9ypRv1mgfwbT1fN2/EOC3X
    EpDoCRfSHZz+SGsJZMW/rjhTTN+PyEqvEwMYOuM7itAQGMx6d1SOXiy5CNnIuvZe
    g2Z8ouX4q4ctnDS4o/pTPxSYbju9H3Fiyrr4m6HaVpEfQvBf4qMzzgz5WGPzFhDa
    rVV6n6z/nU1btmnhZCmj3kpvfjIw11y3kfrCw1eDx01rR1WjZaXjfmn5ugowfv6j
    dxeQc68rFSpYfPaQ/6My7womn1D9nWr6vxLfZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038572; bh=BLpCq/GzBKpQj6L3vJ9FnAY+3Sa+xUZVUgk
    PdPHf5ZE=; b=D7IfiIyE3EDoelckAJRNpOTrhfvj/Ea6a3QE/oA3Ka3jklfFdys
    qeVShl7h+upoLz5BooG5F3Xf66ZHOEIG0WAGDGNqv1Om+eHo3jVMV/DkPzcJrLaA
    IskhtnkyyvUEglBlGaA5zY3jva8i/q956s89sOZ0UxrySoi1i6uL1GulI7dKqQ5D
    RWuOdkGPJadLZiUMPj1k1VfFBcBZwbxgLThtjFRQLvToDs72lLDlpfrZS71KKCUp
    Yqs7LQOXu0qJ6ngtHxJqo+3cKhHwLw9ZotxwYcP1FmprFyNLBao7AXY0416SrItc
    y1ExjSzORZyejNOWj5+HI1U4cHE+eali0Uw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbeBGVWf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:22:35 -0500
Received: from osg.samsung.com ([64.30.133.232]:64463 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932300AbeBGVVE (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:04 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 7/9] usbip: prevent leaking socket pointer address in messages
Date: Wed,  7 Feb 2018 14:20:30 -0700
Message-Id: <2b452aeab8b5dbf9aace7c1bb95fec75cbab2c61.1518036867.git.shuahkh@osg.samsung.com>
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

Upstream commit 90120d15f4c3 ("usbip: prevent leaking socket pointer
address in messages")

usbip driver is leaking socket pointer address in messages. Remove
the messages that aren't useful and print sockfd in the ones that
are useful for debugging.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/stub_dev.c     |  3 +--
 drivers/usb/usbip/usbip_common.c | 15 ++++-----------
 drivers/usb/usbip/vhci_hcd.c     |  2 +-
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index fac20e0434c0..8123a6b2eade 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -163,8 +163,7 @@ static void stub_shutdown_connection(struct usbip_device *ud)
 	 * step 1?
 	 */
 	if (ud->tcp_socket) {
-		dev_dbg(&sdev->udev->dev, "shutdown tcp_socket %p\n",
-			ud->tcp_socket);
+		dev_dbg(&sdev->udev->dev, "shutdown sockfd %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 9752b93f754e..1838f1b2c2fa 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -317,18 +317,14 @@ int usbip_recv(struct socket *sock, void *buf, int size)
 	struct msghdr msg;
 	struct kvec iov;
 	int total = 0;
-
 	/* for blocks of if (usbip_dbg_flag_xmit) */
 	char *bp = buf;
 	int osize = size;
 
-	usbip_dbg_xmit("enter\n");
-
-	if (!sock || !buf || !size) {
-		pr_err("invalid arg, sock %p buff %p size %d\n", sock, buf,
-		       size);
+	if (!sock || !buf || !size)
 		return -EINVAL;
-	}
+
+	usbip_dbg_xmit("enter\n");
 
 	do {
 		sock->sk->sk_allocation = GFP_NOIO;
@@ -341,11 +337,8 @@ int usbip_recv(struct socket *sock, void *buf, int size)
 		msg.msg_flags      = MSG_NOSIGNAL;
 
 		result = kernel_recvmsg(sock, &msg, &iov, 1, size, MSG_WAITALL);
-		if (result <= 0) {
-			pr_debug("receive sock %p buf %p size %u ret %d total %d\n",
-				 sock, buf, size, result, total);
+		if (result <= 0)
 			goto err;
-		}
 
 		size -= result;
 		buf += result;
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index e480b924a04c..a57843e1173f 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -782,7 +782,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
-		pr_debug("shutdown tcp_socket %p\n", ud->tcp_socket);
+		pr_debug("shutdown sockfd %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
-- 
2.14.1

