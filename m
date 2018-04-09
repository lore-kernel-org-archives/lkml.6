Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234339-2-14585871882133506963
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
    1523234338; b=Lx4+j9R0AwKbgqA5OKv2i67aV9CNdFbwOO8wmrnTlbaxexRfSC
    kzYGstpB+ZZQmH3MDXNtB19o8G3zy2S6IaScwmGN3Vv0Z/CaBw7exeK3CfHt7H72
    QDrdwJY+0SEDM/76bcFel4h/0ptGbWEwxH7uVYkx4gQ4P9iPJoQmc0Dez8kx2lKu
    a4Ur6cXqEUoXJ+1T6Nn5nsasENyoLk1odYJaOY4RQ9R1f6IBNM1YXmsShkqvjQhE
    TiSkQHkyrKIdN2R78fhtp3TnSykCWoGvTNjXgiriZFbQyjdDYtumtfGaCSQOe9a7
    8IGQGzp5RnOo6skLTaTswmZRv5CEm4Z9t7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234338; bh=7nLDTwy7lF
    k0OZCl6vadrXo/Fur0X1/RoczpNT5y3JI=; b=Qjlnm9xQfDAJivOLn221HWyEWv
    mq3Yabw1nverhPN9u8JgypJ7pyKpEQQXfZ833LuT+lV0zLywp6sSPNWdqWOaMTij
    ChZ9gCni4DfMHxz/8k/nYdqt+ALDsENGgKh2k+bZkjfKEFQeRYfGY4Df8dptGmRj
    FDrTKMJ5I6wz7hg0xVBLbJPnlQ5NgZqkS9Yv018P0mT4+biRto7FT8tzIDjdzC4Y
    2CmqobbQ45PC7hU3AuEZ5y4dEKn9PYzg0+ISaMMuUEHPdGCgrbxhM0m3X0DjCw0z
    di3Fej06X9/scYBIgrJtlNzexVE3Hv09O8mrrlx21Ha93O5BlHjDXWEOn2kA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fB3gwDwM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fB3gwDwM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHmiIoPQ8wDWQVXdsF9Svgp9Y9v5XVd8h+BxUpd3SCpaERajp/87WHT+lQjz0+fjiaWo40nXUsIIbU9rQHTxHaKX6WR9ivSedCqFBU/CPBdLv3RwMB47
    mHepnI8u6ICIWRMQ2ZED02i/jRcdn7NIJeUTe1NDMtFHGn/JlO2gz5N8Mz4ZR7QbP4ZHBerQCe99D6Y5M0IX1qmENTEjcZo9YXnqT4aZYBlQqXOOJrqGnw7M
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=7001LfjWaACk81qKMQIA:9 a=bCt254BP69NXPnct:21
    a=0qU56kgW7rI0cwCI:21 a=wPNLvfGTeEIA:10 a=Z52K5TbU17EcDgFyT5Ki:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933005AbeDIAiz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:55 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:64416
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933061AbeDIAix (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 149/162] xen-netfront: Fix race between device
 setup and open
Thread-Topic: [PATCH AUTOSEL for 4.4 149/162] xen-netfront: Fix race between
 device setup and open
Thread-Index: AQHTz5ncqVMo8cT+bU2htnQO2xuoFA==
Date: Mon, 9 Apr 2018 00:29:46 +0000
Message-ID: <20180409002738.163941-149-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:kBelbnzWgaMUwSEwsnLL4W3214O8VhW9PKuhMzGk0ujTWpfUfGPbkXt7hfQgzctlu8cySoKoilOA2D00bScZseQ5i5BFksAqu5Lwp9h/RgStWPOg5a22xX5TL9DMYOlepWjm4FR+08IgR554cZVpJPzmtHwjJ9jiB6pqvltVOHnEZxlx3Uq4vuXnCsmDhMyH2i0XMdJsdpHgm27svjdNa4A6jnIJa7Bik5QnZpe8tpsmwcd5i15Z5I0Pe3q3MrJb;20:l6KLGjBxmT4kLFDgnxznblcElzNS2Or/G01TO7+b0PaeL+sGbgSNGTafDf5s5htSYvqlERmzfd+nu/Zym+iX4WFHM5L7hLXJbpiC50DJjQ3fwl1xpv3litPL/cPgkzpKFYpfzfgw5InGixENJeImwXtS79b4zVgEtUZcopBNT18=
X-MS-Office365-Filtering-Correlation-Id: c1953583-7a20-4218-49c4-08d59db2416a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125EB32668786DD4DCF44C4FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(55674003)(2906002)(25786009)(6512007)(10090500001)(551934003)(8666007)(3280700002)(10290500003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(575784001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LWsGptI6ytbuu63Jy1Phatwulj0fA/NRwhlSLE1T/yGrQ4+TF0o4Fd/EAkzsR+N/ymyzZtGkWLZQQNxg4h1GGzOlev+YwLXOfxvp4Vp/b4E0P4TEsccC7MLRqL+/8Ll2QmQBaoHoqR+ce46ijfSqRyDyiQCDRHUiLJQeB7YAqUz6nbmGoDzu3nNyrtQPAV1D3O3nevGI3njo2zv3djEgLxBOWttQRP6flDUvtcTf0fn3bkQo/NJNMZc1sVPbKeHbRXrl4aYwGJTNf6kmjI4Hrmh/31RzMNwlhfRkzUD+3OQAghfsvVYA/9LrSJyZeGmvtECyZChlg+lQIYuq1YWUE5bSJniiKQDawwrL9IAJ9BW+ql26Iz3WeGisZHuhsPvYnxyilQuFQtqwv/nL9QjThsZx6fsvBcIVdSRxlsTSleI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1953583-7a20-4218-49c4-08d59db2416a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:46.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 0b8d2655985f..d612ed0a821c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -342,6 +342,9 @@ static int xennet_open(struct net_device *dev)
 	unsigned int i =3D 0;
 	struct netfront_queue *queue =3D NULL;
=20
+	if (!np->queues)
+		return -ENODEV;
+
 	for (i =3D 0; i < num_queues; ++i) {
 		queue =3D &np->queues[i];
 		napi_enable(&queue->napi);
@@ -1363,18 +1366,8 @@ static int netfront_probe(struct xenbus_device *dev,
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
@@ -1743,8 +1736,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 {
 	unsigned int i;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1753,8 +1744,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 		netif_napi_del(&queue->napi);
 	}
=20
-	rtnl_unlock();
-
 	kfree(info->queues);
 	info->queues =3D NULL;
 }
@@ -1770,8 +1759,6 @@ static int xennet_create_queues(struct netfront_info =
*info,
 	if (!info->queues)
 		return -ENOMEM;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < *num_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1780,7 +1767,7 @@ static int xennet_create_queues(struct netfront_info =
*info,
=20
 		ret =3D xennet_init_queue(queue);
 		if (ret < 0) {
-			dev_warn(&info->netdev->dev,
+			dev_warn(&info->xbdev->dev,
 				 "only created %d queues\n", i);
 			*num_queues =3D i;
 			break;
@@ -1794,10 +1781,8 @@ static int xennet_create_queues(struct netfront_info=
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
@@ -1839,6 +1824,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		goto out;
 	}
=20
+	rtnl_lock();
 	if (info->queues)
 		xennet_destroy_queues(info);
=20
@@ -1849,6 +1835,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		info->queues =3D NULL;
 		goto out;
 	}
+	rtnl_unlock();
=20
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i =3D 0; i < num_queues; ++i) {
@@ -1945,8 +1932,10 @@ abort_transaction_no_dev_fatal:
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
@@ -1982,6 +1971,15 @@ static int xennet_connect(struct net_device *dev)
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
@@ -2167,10 +2165,14 @@ static int xennet_remove(struct xenbus_device *dev)
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
