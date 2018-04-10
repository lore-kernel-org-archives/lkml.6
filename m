Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402328-2-4720816074669696021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523402328; b=SZO6YAAfCicXoahh2ExVub4XT95tpZ7dvW8SudynwfZm319D+P
    +8AkgHPoqC36zdam6m1N/73ZpM9KvaLMCc09y0liuvUdxfAg8sYjECsSjhCbXI2N
    8pgwBelOoaPbiOwzvXg2JwJKEbmVn0ruAtLmIP+0WgCXyUd9g0l9ahcVXIvBO5j3
    +cjoKflSefx+iNelATmTQnWNwxt9enpo+ed06XiNTp4KEYbKEp286t1Ws/ry6lvv
    XE/+4PHyl0Mk5eu/d460OQbWC8W8mLrAIA4BQBppeP0BU7CEKf5cmNtMCbSa7Apx
    F4NgmpcRWhpkrbE+F2lvui3nQljTSgS3GNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402328; bh=4mjljQKNgwViFTHl0J0DW6WDMeBh19
    PEYRgWbzTnhpA=; b=t1JQbpkDwyDbKIcuM/gdffCVfoBad8ievCBxBpssfWLgIk
    UtbOF13IJ8QBdzEzzHzx7RTmpIwGvFbrh4KpTdNIQ42HQLPCEZfhp8GnGS8RXZmO
    c9hwyQzUdv11FlyN+pSZcVphTDkI7zGR7eU9TEwtYbbHQjBICSsrIB80+z8BiToA
    osslOSZ/UF9DoNBuaJdrNf5lZPUAgndeBNUFinFFh/40A3L+dUR5DE4NUQlLJ1IS
    U2nSgj8gl7fzC1Y79MC3Ca/9tW6WqwpoQm3i8/CQ21/OZ8F6ygjbj9De0nwQh9be
    jhQzMb47Qz8BumHgn2HxWKUPU9ETyk+DzPpQuTXA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNHgmrnDBkOnDN/+Kg5fvuXuByS2fgerGM8aomBFdQi3fU5fPbTW2PS8ldkFSiOm9wEFrwoQSiwZigHgSWNCPL7E8leo36JaZWCVxxPx7Oakg5b4Zaqd
    yG7OVnUayF3lnzrCahvnZW/Md6wOm8Y9F36JyY1k22Zy/FVbIkuNPAfVVRfbMZ3lEP34N11m/VY+KeM9OCEuOZZRX5dDC1Glq28l4Z9F4KQd/DLqz2jGYHWs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=XYAwZIGsAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=xjiEcAeqPzjcIN34KbYA:9 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754785AbeDJWbX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:31:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40340 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754763AbeDJWbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Raghuram Chary J <raghuramchary.jallipalli@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 123/168] lan78xx: Crash in lan78xx_writ_reg (Workqueue: events lan78xx_deferred_multicast_write)
Date: Wed, 11 Apr 2018 00:24:25 +0200
Message-Id: <20180410212805.809495859@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>


[ Upstream commit 2d2d99ec13f62d5d2cecb6169dfdb6bbe05356d0 ]

Description:
Crash was reported with syzkaller pointing to lan78xx_write_reg routine.

Root-cause:
Proper cleanup of workqueues and init/setup routines was not happening
in failure conditions.

Fix:
Handled the error conditions by cleaning up the queues and init/setup
routines.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2863,8 +2863,7 @@ static int lan78xx_bind(struct lan78xx_n
 	if (ret < 0) {
 		netdev_warn(dev->net,
 			    "lan78xx_setup_irq_domain() failed : %d", ret);
-		kfree(pdata);
-		return ret;
+		goto out1;
 	}
 
 	dev->net->hard_header_len += TX_OVERHEAD;
@@ -2872,14 +2871,32 @@ static int lan78xx_bind(struct lan78xx_n
 
 	/* Init all registers */
 	ret = lan78xx_reset(dev);
+	if (ret) {
+		netdev_warn(dev->net, "Registers INIT FAILED....");
+		goto out2;
+	}
 
 	ret = lan78xx_mdio_init(dev);
+	if (ret) {
+		netdev_warn(dev->net, "MDIO INIT FAILED.....");
+		goto out2;
+	}
 
 	dev->net->flags |= IFF_MULTICAST;
 
 	pdata->wol = WAKE_MAGIC;
 
 	return ret;
+
+out2:
+	lan78xx_remove_irq_domain(dev);
+
+out1:
+	netdev_warn(dev->net, "Bind routine FAILED");
+	cancel_work_sync(&pdata->set_multicast);
+	cancel_work_sync(&pdata->set_vlan);
+	kfree(pdata);
+	return ret;
 }
 
 static void lan78xx_unbind(struct lan78xx_net *dev, struct usb_interface *intf)
@@ -2891,6 +2908,8 @@ static void lan78xx_unbind(struct lan78x
 	lan78xx_remove_mdio(dev);
 
 	if (pdata) {
+		cancel_work_sync(&pdata->set_multicast);
+		cancel_work_sync(&pdata->set_vlan);
 		netif_dbg(dev, ifdown, dev->net, "free pdata");
 		kfree(pdata);
 		pdata = NULL;
