Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242544-2-9830328308920235708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242543; b=C1zFXBJZ1tLMdVnWvL18kIASQJwOKyvdoHzOYXrhC4SMfVk33C
    Qb1osvKtxIMxIUVr8KqMEctRbkqlkmcPWPhgfCVspyP8Iztprw0EtPvguPg1G6+n
    6geFNsEBSi4NB3QeOKvY50qCApoENyWuF2tMo4OR6+YGcV2Aqt6DC93hPo6ixSEr
    M3wzB0rnvaK0W1IkLPt883CrHKN/hFmfrb8tyqsBHgKwgNCovY1tS8mAXtEjBOGv
    piGfAHfQuX2psNltAZPRv4OzFCMyMZJc0OtzeQ4o46PXIJJFBTLcqON9UiFMAmJY
    f5xcxKBBg9WkfufmAGk/VsvEsyEVXrwh1Kiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242543; bh=XqNOyTysWC
    kTQ08t7TAhQHDUu/FnmMOuNOmnF0YJ9P4=; b=JjqxcVuZo8LLWZA7iJxhzAVZgM
    5/GKOBrWw99EgMQF6gkovAGjPvJ0pACeg6I7VHUMD9Sv1GhbG4AZQ6lITnd9btOd
    pqo76aeuqgxuN3V2PjkAOQPgPTbptd8wut5K2WAmQl1NjMm5zYesoQUYRMmxq5JG
    qp2jllYIsWqmw3HZzI8agRVOzX4Bw2q+gQVqG7xZ5jX6m8YzSIXPrd/tquBym7+k
    vDvYFFLrSzfgJVEAJfLrYUHc5Llv+XoWdmxdX7PFhwy7T+zsN6a1mEs4d1TrrNWy
    z4kvlIPHzdBu3MVdldeATI/5vi+z+i9ns7rcsYqd2eBfUTGx7MUYTWGAz4Tg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WkKntx8C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WkKntx8C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAG+kCQ5Dette6geFFFJUgBmR6G5IIYTAUKQK13svzTdtJ4MPt0D/pLKJ9/yRxe1nF4ZmOuhlXXOLMgv0Xe36LMCIhhZZAaVha2PwyA3+2I497eEJjia
    C9wlAnWRaQ5kxumLEvry4ra2PNeEvTfg1Z8icBp4UC380mD8TlJgynBtX2f5uH+V8m4/iTv3HDgZ2m/Vj6B8rhGq70Z5xgGbGXVhb7aA2TTaOpOCyQdec6AK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=7001LfjWaACk81qKMQIA:9 a=UGPXKIqkR3HkfttO:21
    a=0qU56kgW7rI0cwCI:21 a=wPNLvfGTeEIA:10 a=Z52K5TbU17EcDgFyT5Ki:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755245AbeDIAZq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:46 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755225AbeDIAZj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 128/161] xen-netfront: Fix race between
 device setup and open
Thread-Topic: [PATCH AUTOSEL for 4.14 128/161] xen-netfront: Fix race between
 device setup and open
Thread-Index: AQHTz5i5LwFl/fmoVEGO+rD2kQy3Lg==
Date: Mon, 9 Apr 2018 00:21:38 +0000
Message-ID: <20180409001936.162706-128-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:LLjQs4sODi2mWIXZPW+qHYxrKnbgUYAT4saBAEEN3yabRu+SvZTYycm0SaVqHqSKJmNONVUyMfiXKf9GIwnJgsPy5MACftjeZEQqkpkZO7RKBDpbBuJzWpBAJjL58arBcBYQsCYmtA846nAvx/siFLNcekrr0XVNDvDoAkcZL7Q0wk/6Zk48hCkzng2xV8pp86AAMIHO0iOAlIKIU9hxYLFXlXiUDBJ+CRrG2nQ4Z8UlkwwnCrbVoGBLgZtYNnC/;20:Xe4ue+zqlk/OdvzIXSrFFHiQnviABaeZv9Ui6GSbLppXseFEVExAXnoj4pvvpRH2hNDh5v6fvpOPLAKalKZ5jarA2SdeCNE2EzTOxx6spMnkapodOPerI7wnu63WFPqzrq9B2yI6SovryB+UiUXkOuuBJYhAWJDMioX9QWE4Ye8=
X-MS-Office365-Filtering-Correlation-Id: afd8ce5b-babf-475e-6111-08d59db069cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013866C74ECADBC839028ACFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(55674003)(3280700002)(2616005)(8666007)(8936002)(7736002)(476003)(446003)(11346002)(551934003)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: f6wxdE7fJeUY+EgWISAw8XO3b8AAAjAY1z52bp0ocqiL+U4qMobpuHFUltQHyVfh2oTu6Kx8amHl16uG2FJW6b7C6bXBjjHSaXv7oq5uhYwYkmf+oMkDBBNnnstUQ575DZBOEuXkdxazehfWD+ShJMI2Lg2uuzdFajxwYyPbJTEdkTe10RUtj/kRJq91JCB8AzaIBMNbVv/GE7v8tf4t2du9nueMuuXRrEhCoi33DcsW5lScLzQofZLkf6LMQT3+q6Gwqfnw2Uc4K05q6hEHMtni5wsQYE96CAGGAw1kCL6ONZ5IkNR04FOS3sKyvLLA5d3WVK9nhRczPz61kQmEpu/y3jLEiQxJ5D/A61iP/zrGG8U/Cx8PqM8/4qRhu98GZuEuS5VDftVZEYnnCHmhonwdnNWFkNGyFgWzCDeDqjw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd8ce5b-babf-475e-6111-08d59db069cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:38.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index c980cdbd6e53..25b4a856f0bb 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -351,6 +351,9 @@ static int xennet_open(struct net_device *dev)
 	unsigned int i =3D 0;
 	struct netfront_queue *queue =3D NULL;
=20
+	if (!np->queues)
+		return -ENODEV;
+
 	for (i =3D 0; i < num_queues; ++i) {
 		queue =3D &np->queues[i];
 		napi_enable(&queue->napi);
@@ -1358,18 +1361,8 @@ static int netfront_probe(struct xenbus_device *dev,
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
@@ -1738,8 +1731,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 {
 	unsigned int i;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1748,8 +1739,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 		netif_napi_del(&queue->napi);
 	}
=20
-	rtnl_unlock();
-
 	kfree(info->queues);
 	info->queues =3D NULL;
 }
@@ -1765,8 +1754,6 @@ static int xennet_create_queues(struct netfront_info =
*info,
 	if (!info->queues)
 		return -ENOMEM;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < *num_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1775,7 +1762,7 @@ static int xennet_create_queues(struct netfront_info =
*info,
=20
 		ret =3D xennet_init_queue(queue);
 		if (ret < 0) {
-			dev_warn(&info->netdev->dev,
+			dev_warn(&info->xbdev->dev,
 				 "only created %d queues\n", i);
 			*num_queues =3D i;
 			break;
@@ -1789,10 +1776,8 @@ static int xennet_create_queues(struct netfront_info=
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
@@ -1829,6 +1814,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		goto out;
 	}
=20
+	rtnl_lock();
 	if (info->queues)
 		xennet_destroy_queues(info);
=20
@@ -1839,6 +1825,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		info->queues =3D NULL;
 		goto out;
 	}
+	rtnl_unlock();
=20
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i =3D 0; i < num_queues; ++i) {
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
@@ -1966,6 +1955,15 @@ static int xennet_connect(struct net_device *dev)
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
@@ -2151,10 +2149,14 @@ static int xennet_remove(struct xenbus_device *dev)
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
