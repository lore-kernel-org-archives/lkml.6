Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234090-2-4965799174020386870
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234089; b=mzndY5FgMakOa442AwIPLgeAseXoM4faF+8DYmBlDlblAgTM0W
    9VjBQ7vuu/Mp5WVq+gtzZzm3O6bp2TZry0wPmzvOoVfbDoHcP0rKIErujsayjU0F
    9ShDj//B21uRyoQKKScCHxqlBavipCC0BiFE17Dcqt3Z6hBKbi4RjgV23QSEpUMw
    o6RSR9YcZNdPW8ph4oqjl0HSUl29O7IOQSnw9/hFv7dDiAB8uqrxAy0PJLhLrFG9
    f7D28LIpx1BnvoAFS4uZuKRJG74CMQVFjFsQuvhf6g3tJ2nr8YbyvdLqA2kVJ8jX
    XTKVetNy5L9g5O+w8mi069jGMYhSjEDYVfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234089; bh=nvr270l4qD
    u/jnQh+ttvTniVviD7li7UUnnoISXqCwg=; b=AtRitvXmddmIEK78MhV7Vd9x+0
    E0OXcvmbAfyg5hSxhMjkUUKWl17sfFaFN9NMfa5tYUqhpaVKOIVAd0+HQ8CktX4y
    mHyjZFewwQyURBQSj/StuJG/HZMa1qrOYEY7rwR7wk5rNbWSYa7FwMEavlOO+aNO
    NXyhAt0QANTY3oUaseUd3HpL0DqGWa5AbR8wQiFneHQK46kUn5+G0QJNUn0zAfKI
    vOn1dvkvqbSi08tbW5kdaEV5cwAMRgu4rs0AFUBBqunnUqqDeroAfIa8PUJLPGgw
    2pQ6LZW3EMH1GNfL/CzO3ozbW7ATnSuayK+seu4Y+DH4H43FB1r0rB8TpEUg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CxYsArl2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CxYsArl2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKe0ulUdjCjA+mOhzWi2TrePt//JhpRBWkvJBd7N1YSjh4fZySRLKJM4QPNNBE69T4uRhy4OC51KWqiBulpU6twpdMjeWcU7dfwwyd2IjPvlexRvWvgF
    soAQyQBCXnzEIzvvuGYaf0YfZPdDMt1bED6URJy0hjvQMD/sVxPcNuqytQmFxhJGutRYuQ2/H2wLiry/KnFtEHEHezxNaUAjdMG8Ar3bDRzncYFaZzyZP2JU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=7001LfjWaACk81qKMQIA:9 a=8tSMwnbz8a-ecZk5:21
    a=0qU56kgW7rI0cwCI:21 a=wPNLvfGTeEIA:10 a=Z52K5TbU17EcDgFyT5Ki:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932511AbeDIAeq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:46 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:14317
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932468AbeDIAem (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 275/293] xen-netfront: Fix race between device
 setup and open
Thread-Topic: [PATCH AUTOSEL for 4.9 275/293] xen-netfront: Fix race between
 device setup and open
Thread-Index: AQHTz5lnkDpwLSRCtEeE8TUbEcotNA==
Date: Mon, 9 Apr 2018 00:26:30 +0000
Message-ID: <20180409002239.163177-275-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:3dvw6jOmcLEWXz6SdLbVmLteKV7whZtz7t+acL5tbtJRLThNrpsUWO9x0bXtVNJri90ilS3vr+k9CefYF8apNgqGQEe1jxengqXYwvEHt+b1Im1suvu6pUa8n6TX/EuH1axUAIBwVdwX5UzauaONao6nyiJnvZ2ZBwOxsQOVyI9AcDjjHgMJTv9eyNKxmW+mnTbtX2KLeGXjbzLPLUlK+tG0WgyV5zgnbRIlRn5C/EVHXhw1CjuIYtbhj8KPL1nm;20:WWOPgYD22KrwnkB+5eDQwU/sdfTIIObYu+9+Hk/fcmPlUKSGcd3VRH0dnfI+A086GypJBhm0oCwyDsjhyBc7HmckkSzmZOoGJ2c+/1bK4S1GT9+I4H4dZeRKombvWh9nDcOhOwQWzgZ7hWfpXfZASdqrn+WAEN20FnTD68KOVnA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c2e3e80-1bdb-48a8-9168-08d59db1ad12
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984E4039D50727E2F43DC1DFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(55674003)(26005)(99286004)(2906002)(551934003)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(8666007)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0c3h6O+y6dov3fhRxDlcIyRznuz0yeoi2C6JmdwcJFHD6uTm0ULCVd6drI43oBdUdYzH6998n1XlGT5EUJHopFmfn82Ptz4JSG5PuznfsWGX1RBRqpq5G2w2w5aWkSv4hRLSXYejoLDMq3eud4mSkx2m3XQ0GGAs6Eu98TG9v4rXzIEqAzlSnV/LcSnGsHWllAPAaPJvq5lz8aSU7Z1mA5GLvXewtG5nHpROCtwWvnKk+Wn7kLwU9dk/xCJ7uMEx7ouFEpx6S8l8L9SJnOPf5tdQNOaw3dSr3pLQsGWbRXAeocoEwtJ+6fYT9mN/G1OZ3WTD2vHoRt7Gz4AOnVQhqg6CAAfq62T3BUuhu9bBhtbZ8Pj6BDiwuQLgz3Zh/MtFt2LsB0wtCbFA2MTVEGcK8yTn2zK4u5bHmEA8VvFFiBo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2e3e80-1bdb-48a8-9168-08d59db1ad12
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:30.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/net/xen-netfront.c | 46 ++++++++++++++++++++++++------------------=
----
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index b09c81e882b4..9a583f862109 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -350,6 +350,9 @@ static int xennet_open(struct net_device *dev)
 	unsigned int i =3D 0;
 	struct netfront_queue *queue =3D NULL;
=20
+	if (!np->queues)
+		return -ENODEV;
+
 	for (i =3D 0; i < num_queues; ++i) {
 		queue =3D &np->queues[i];
 		napi_enable(&queue->napi);
@@ -1377,18 +1380,8 @@ static int netfront_probe(struct xenbus_device *dev,
 #ifdef CONFIG_SYSFS
 	info->netdev->sysfs_groups[0] =3D &xennet_dev_group;
 #endif
-	err =3D register_netdev(info->netdev);
-	if (err) {
-		pr_warn("%s: register_netdev err=3D%d\n", __func__, err);
-		goto fail;
-	}
=20
 	return 0;
-
- fail:
-	xennet_free_netdev(netdev);
-	dev_set_drvdata(&dev->dev, NULL);
-	return err;
 }
=20
 static void xennet_end_access(int ref, void *page)
@@ -1757,8 +1750,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 {
 	unsigned int i;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1767,8 +1758,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 		netif_napi_del(&queue->napi);
 	}
=20
-	rtnl_unlock();
-
 	kfree(info->queues);
 	info->queues =3D NULL;
 }
@@ -1784,8 +1773,6 @@ static int xennet_create_queues(struct netfront_info =
*info,
 	if (!info->queues)
 		return -ENOMEM;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < *num_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1794,7 +1781,7 @@ static int xennet_create_queues(struct netfront_info =
*info,
=20
 		ret =3D xennet_init_queue(queue);
 		if (ret < 0) {
-			dev_warn(&info->netdev->dev,
+			dev_warn(&info->xbdev->dev,
 				 "only created %d queues\n", i);
 			*num_queues =3D i;
 			break;
@@ -1808,10 +1795,8 @@ static int xennet_create_queues(struct netfront_info=
 *info,
=20
 	netif_set_real_num_tx_queues(info->netdev, *num_queues);
=20
-	rtnl_unlock();
-
 	if (*num_queues =3D=3D 0) {
-		dev_err(&info->netdev->dev, "no queues\n");
+		dev_err(&info->xbdev->dev, "no queues\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -1853,6 +1838,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		goto out;
 	}
=20
+	rtnl_lock();
 	if (info->queues)
 		xennet_destroy_queues(info);
=20
@@ -1863,6 +1849,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		info->queues =3D NULL;
 		goto out;
 	}
+	rtnl_unlock();
=20
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i =3D 0; i < num_queues; ++i) {
@@ -1959,8 +1946,10 @@ abort_transaction_no_dev_fatal:
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
@@ -1996,6 +1985,15 @@ static int xennet_connect(struct net_device *dev)
 	netdev_update_features(dev);
 	rtnl_unlock();
=20
+	if (dev->reg_state =3D=3D NETREG_UNINITIALIZED) {
+		err =3D register_netdev(dev);
+		if (err) {
+			pr_warn("%s: register_netdev err=3D%d\n", __func__, err);
+			device_unregister(&np->xbdev->dev);
+			return err;
+		}
+	}
+
 	/*
 	 * All public and private state should now be sane.  Get
 	 * ready to start sending and receiving packets and give the driver
@@ -2181,10 +2179,14 @@ static int xennet_remove(struct xenbus_device *dev)
=20
 	xennet_disconnect_backend(info);
=20
-	unregister_netdev(info->netdev);
+	if (info->netdev->reg_state =3D=3D NETREG_REGISTERED)
+		unregister_netdev(info->netdev);
=20
-	if (info->queues)
+	if (info->queues) {
+		rtnl_lock();
 		xennet_destroy_queues(info);
+		rtnl_unlock();
+	}
 	xennet_free_netdev(info->netdev);
=20
 	return 0;
--=20
2.15.1
