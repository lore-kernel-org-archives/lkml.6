Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653903-2-10031729407709737310
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
    1524653903; b=nfz5cCMnb223k9zUW1eQazEPN6bw28SIeVm84spz0z5J9IC3SP
    H5Bjpou646DcdYbeLfQQmHAW0nmHn8tDRbsVj3OnUQPxYc0rYA7a/bZBTvbTovXB
    bch9THUvgdTxFCh5KPOep0pzJ8y3nSqHSfUkYJNeQhMYVU7/Y8VJcNPBAXiiCil7
    IlSvk9c8SlYMbD5K7dnBUVqkgD1iMI4QSIsg1Kmo7oolr3bQ8sVzCg08M30Mjqvx
    B5/oK6zpddgDFrbFhVJQYjGcUoGqP40naqEO6OMYiA36rXoiCaiuaOTC2lKTW88w
    +1S1Rk10vwuc4wGdVnKUepRxaWMIgpvu9MnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653903; bh=pArgkhnvEniiFO09pr4AY1H4cwQCwa
    opfLx1piKpNiM=; b=VN80aeVmN9jkEMu1p4tD123sU/2eUTWD66OrQMpgP4Ny60
    oWUgFg28h6yLqsfU1/F8ua0vjviHzvi2aUyYO8v9rGk/IxPMJNalwqx+fOAHzrLg
    Doywl3OiI9RsD7dm0AUMdYDUtjAHGq1r9lqoZs4zTzokZxuxGY/p+u2+3ghkohnG
    GNtqxe3WZGj5le8PzPwBFT1UhFw9G/fg9zYgvBY29dUFtdd7E0bT3gdjETppJhbr
    c2//XzHbkpXlpyYYRO9o8+bM5Ox22ixShfw3lWdYJJqv9ZUCJy/i8twoVa7Ujvo/
    0W5TsbcdRe3QRs2Q3IamtXIv7+4Z6DRgzDwFxk6g==
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
X-CM-Envelope: MS4wfPjKNtLVbJ04LWQlKDtT+XVY+5+YYSyF1PSJVfy/4EsmAntAApW6V5udQbc5Ab1NIfoZ3vBNig7SqXcKpTHln7pOQ2nVidJe+WhNw/IyKdMXqqEdXp+I
    I0IQ3XGDWyXqGY5V7wDpt0dlbcZNIlJE5PeoYol1yYCuySVhN9OQi+bX6yRvLSkIpHW+d2aMllSDhagMAR/wH2r8u26XeFWPVBnc26DNUhkN0B0pF1/ueowK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=7001LfjWaACk81qKMQIA:9 a=fnp-WNGPlxY1zwUh:21
    a=ZH3kPFvJVTI6XJkI:21 a=QEXdDO2ut3YA:10 a=Z52K5TbU17EcDgFyT5Ki:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeDYK6I (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:58:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754161AbeDYKnB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 139/183] xen-netfront: Fix race between device setup and open
Date: Wed, 25 Apr 2018 12:35:59 +0200
Message-Id: <20180425103248.130971244@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit f599c64fdf7d9c108e8717fb04bc41c680120da4 ]

When a netfront device is set up it registers a netdev fairly early on,
before it has set up the queues and is actually usable. A userspace tool
like NetworkManager will immediately try to open it and access its state
as soon as it appears. The bug can be reproduced by hotplugging VIFs
until the VM runs out of grant refs. It registers the netdev but fails
to set up any queues (since there are no more grant refs). In the
meantime, NetworkManager opens the device and the kernel crashes trying
to access the queues (of which there are none).

Fix this in two ways:
* For initial setup, register the netdev much later, after the queues
are setup. This avoids the race entirely.
* During a suspend/resume cycle, the frontend reconnects to the backend
and the queues are recreated. It is possible (though highly unlikely) to
race with something opening the device and accessing the queues after
they have been destroyed but before they have been recreated. Extend the
region covered by the rtnl semaphore to protect against this race. There
is a possibility that we fail to recreate the queues so check for this
in the open function.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |   46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -351,6 +351,9 @@ static int xennet_open(struct net_device
 	unsigned int i = 0;
 	struct netfront_queue *queue = NULL;
 
+	if (!np->queues)
+		return -ENODEV;
+
 	for (i = 0; i < num_queues; ++i) {
 		queue = &np->queues[i];
 		napi_enable(&queue->napi);
@@ -1358,18 +1361,8 @@ static int netfront_probe(struct xenbus_
 #ifdef CONFIG_SYSFS
 	info->netdev->sysfs_groups[0] = &xennet_dev_group;
 #endif
-	err = register_netdev(info->netdev);
-	if (err) {
-		pr_warn("%s: register_netdev err=%d\n", __func__, err);
-		goto fail;
-	}
 
 	return 0;
-
- fail:
-	xennet_free_netdev(netdev);
-	dev_set_drvdata(&dev->dev, NULL);
-	return err;
 }
 
 static void xennet_end_access(int ref, void *page)
@@ -1738,8 +1731,6 @@ static void xennet_destroy_queues(struct
 {
 	unsigned int i;
 
-	rtnl_lock();
-
 	for (i = 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue = &info->queues[i];
 
@@ -1748,8 +1739,6 @@ static void xennet_destroy_queues(struct
 		netif_napi_del(&queue->napi);
 	}
 
-	rtnl_unlock();
-
 	kfree(info->queues);
 	info->queues = NULL;
 }
@@ -1765,8 +1754,6 @@ static int xennet_create_queues(struct n
 	if (!info->queues)
 		return -ENOMEM;
 
-	rtnl_lock();
-
 	for (i = 0; i < *num_queues; i++) {
 		struct netfront_queue *queue = &info->queues[i];
 
@@ -1775,7 +1762,7 @@ static int xennet_create_queues(struct n
 
 		ret = xennet_init_queue(queue);
 		if (ret < 0) {
-			dev_warn(&info->netdev->dev,
+			dev_warn(&info->xbdev->dev,
 				 "only created %d queues\n", i);
 			*num_queues = i;
 			break;
@@ -1789,10 +1776,8 @@ static int xennet_create_queues(struct n
 
 	netif_set_real_num_tx_queues(info->netdev, *num_queues);
 
-	rtnl_unlock();
-
 	if (*num_queues == 0) {
-		dev_err(&info->netdev->dev, "no queues\n");
+		dev_err(&info->xbdev->dev, "no queues\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -1829,6 +1814,7 @@ static int talk_to_netback(struct xenbus
 		goto out;
 	}
 
+	rtnl_lock();
 	if (info->queues)
 		xennet_destroy_queues(info);
 
@@ -1839,6 +1825,7 @@ static int talk_to_netback(struct xenbus
 		info->queues = NULL;
 		goto out;
 	}
+	rtnl_unlock();
 
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i = 0; i < num_queues; ++i) {
@@ -1935,8 +1922,10 @@ abort_transaction_no_dev_fatal:
 	xenbus_transaction_end(xbt, 1);
  destroy_ring:
 	xennet_disconnect_backend(info);
+	rtnl_lock();
 	xennet_destroy_queues(info);
  out:
+	rtnl_unlock();
 	device_unregister(&dev->dev);
 	return err;
 }
@@ -1966,6 +1955,15 @@ static int xennet_connect(struct net_dev
 	netdev_update_features(dev);
 	rtnl_unlock();
 
+	if (dev->reg_state == NETREG_UNINITIALIZED) {
+		err = register_netdev(dev);
+		if (err) {
+			pr_warn("%s: register_netdev err=%d\n", __func__, err);
+			device_unregister(&np->xbdev->dev);
+			return err;
+		}
+	}
+
 	/*
 	 * All public and private state should now be sane.  Get
 	 * ready to start sending and receiving packets and give the driver
@@ -2156,10 +2154,14 @@ static int xennet_remove(struct xenbus_d
 
 	xennet_disconnect_backend(info);
 
-	unregister_netdev(info->netdev);
+	if (info->netdev->reg_state == NETREG_REGISTERED)
+		unregister_netdev(info->netdev);
 
-	if (info->queues)
+	if (info->queues) {
+		rtnl_lock();
 		xennet_destroy_queues(info);
+		rtnl_unlock();
+	}
 	xennet_free_netdev(info->netdev);
 
 	return 0;
