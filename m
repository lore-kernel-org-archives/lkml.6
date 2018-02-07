Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842223-1518038531-2-9004887826502189482
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
    t=1518038531; b=DSTU9e+PajzzC+92+xMFh7BG9m6vKX9r8hfDOqQR5NmKVlL
    1Pa5Gry/wES62HoK3X5CQYRqlaMGcStY71fKMZalY5Z4bZXtFXJyTwiOkHo+QVAo
    QB+RQBxhDvo9NKzCf3t7H6LARFR+njHCHIcjU6DnUDurnKp6IjoqdfmbrB2wSPow
    cJZBlXx/TVEw+KSG8XuShuYb+FwIJq+DR+EOpDdABpmvXe5FrYjvahChhJ+BdhAs
    NRbwOmwLa/wzXrjk8Rh3Qhdr5gH0Fx9OwflKU0Xt/k9NiWh7//BxeVOmeUbwNIm9
    xiCrtdExnBLkcygU7dIoHQydu0SMhw00ro7iQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1518038531; bh=WCkhh1dF0+k+c2946njjzNsu/vGO8WADZQY
    0xfOL8pI=; b=FHcON+w5cFoEKtLVzq10+jo3kAoRIGmtTWgPQobAG8ErUMzTgvH
    ogl+Cad3kJEvtUnvLjnseondhq8AqjeAhGDt2I8gEKc6+AwQxubsnDXkUJDvBXCn
    W5kWU/ED2pWU2wwZH6HlgCw6V/QWIxPATRVfMq0x+FwY4uIw1A528SsD/IlnGnLy
    LclpIToIyE7HIwHtZtIR2F5cnhKOqH5zoCryRDzkgwq91CEdIM55Unla5N4qyWZn
    1cbwXyhsi1Td9PZ2D1WKhFYgLKXWtlJC7qkXvw7TSiPV33w3oRGUEW8olyGMvkk1
    5MeyCwjIWWLcHqTWKjEKALnGN3qWsQ1ASHw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeBGVVw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:21:52 -0500
Received: from osg.samsung.com ([64.30.133.232]:38688 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932315AbeBGVVF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:21:05 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 8/9] usbip: stub: stop printing kernel pointer addresses in messages
Date: Wed,  7 Feb 2018 14:20:31 -0700
Message-Id: <74bef3a186e17a578c3317781a9bd348bd78c905.1518036867.git.shuahkh@osg.samsung.com>
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

Upstream commit 248a22044366 ("usbip: stub: stop printing kernel
pointer addresses in messages")

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/stub_main.c | 5 +++--
 drivers/usb/usbip/stub_rx.c   | 7 ++-----
 drivers/usb/usbip/stub_tx.c   | 4 ++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index af10f7b131a4..325b4c05acdd 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -252,11 +252,12 @@ void stub_device_cleanup_urbs(struct stub_device *sdev)
 	struct stub_priv *priv;
 	struct urb *urb;
 
-	dev_dbg(&sdev->udev->dev, "free sdev %p\n", sdev);
+	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
 
 	while ((priv = stub_priv_pop(sdev))) {
 		urb = priv->urb;
-		dev_dbg(&sdev->udev->dev, "free urb %p\n", urb);
+		dev_dbg(&sdev->udev->dev, "free urb seqnum %lu\n",
+			priv->seqnum);
 		usb_kill_urb(urb);
 
 		kmem_cache_free(stub_priv_cache, priv);
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index f5533c99cd48..56cacb68040c 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -230,9 +230,6 @@ static int stub_recv_cmd_unlink(struct stub_device *sdev,
 		if (priv->seqnum != pdu->u.cmd_unlink.seqnum)
 			continue;
 
-		dev_info(&priv->urb->dev->dev, "unlink urb %p\n",
-			 priv->urb);
-
 		/*
 		 * This matched urb is not completed yet (i.e., be in
 		 * flight in usb hcd hardware/driver). Now we are
@@ -271,8 +268,8 @@ static int stub_recv_cmd_unlink(struct stub_device *sdev,
 		ret = usb_unlink_urb(priv->urb);
 		if (ret != -EINPROGRESS)
 			dev_err(&priv->urb->dev->dev,
-				"failed to unlink a urb %p, ret %d\n",
-				priv->urb, ret);
+				"failed to unlink a urb # %lu, ret %d\n",
+				priv->seqnum, ret);
 
 		return 0;
 	}
diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
index af858d52608a..f4dd30c56f36 100644
--- a/drivers/usb/usbip/stub_tx.c
+++ b/drivers/usb/usbip/stub_tx.c
@@ -201,8 +201,8 @@ static int stub_send_ret_submit(struct stub_device *sdev)
 
 		/* 1. setup usbip_header */
 		setup_ret_submit_pdu(&pdu_header, urb);
-		usbip_dbg_stub_tx("setup txdata seqnum: %d urb: %p\n",
-				  pdu_header.base.seqnum, urb);
+		usbip_dbg_stub_tx("setup txdata seqnum: %d\n",
+				  pdu_header.base.seqnum);
 		usbip_header_correct_endian(&pdu_header, 1);
 
 		iov[iovnum].iov_base = &pdu_header;
-- 
2.14.1

