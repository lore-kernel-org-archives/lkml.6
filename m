Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245309-2-6053342873453677970
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
    1523245308; b=ENl2DUSVA/wdf7MGqP9FSIk6/EweaSVMVda1DsOF3pOZcBSBSU
    libM2AE+5DpbpFucBJp8B2HLuopJNZQr6UoW+i3j8eW5gp2V7ifsuLmvki/Y3I2O
    BxbpcKmB3k48qAtvcxhcEE7GqJyxoFUu3Pmd6gS+mTsf29qNPCbzGCe/NMdgjSZa
    M11stp6KoDD8hm3g14Cu+OAsFyO91kzipy0Z3df6z0BEJszLLEgPNDXj7BJ8PG4Y
    sSwI3isFqJLnFhXTmwamD0754olvslnFg9izat66OhgeE8c3BG0lX9MbchG1W1fI
    8579Drbq31sqAp3Kza+oH5Jq8oXF0fKXfs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245308; bh=IlUm2TjEUx
    8/bshXi2a0c9etDSHDkdyOvP8qMUwYubo=; b=AgiW9YEuBr+zrRzrqLe+bj20jF
    uTt64GtLcR3gHnz4vJCs1+VrhRhqV5TFIPA+LFJhYiXhA+2U5P4yc9oYMLjkbAJV
    AkJsXfvaMdvPPX94Kmeaj4Ix7FGg/DVSpI3/NgtxHdetQVePCCKIH0tPWwJmfYs3
    4GrrZJII4LonsQfoPxxy9x6cwOsegSA43X2zpFrBLRHpojJphXd8hTBboH0ISyaF
    o0ui6uH0gwm/MnTg18UmSwbDKmbuJ5VRcaraEB9r1aO2NREOP84raYyyKuuHVou7
    b0+jNPM9WlY5PepOAmWsEkERGFkvXXP7UqNj5NvT0jT2w5KvdxosU8Y0rOyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aOyj6rGi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aOyj6rGi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNw9c6N/2CqlNS72rzbD/9SAb27g1tvcQih5t5kW+9ZtqiwIzCImcrAGzSCoecEpmpw/5rUVB48DwvLVJ4NIvEyo01Y5Bss+5m14SqsFRnBWoVPH2QxK
    GNk2BzDd0WmNjz6qf16FsF7t5w1Herpzq0x90fAUUDfPPZr0nXlWbhzLYT5lf3ikGtETZ8aaxX4/dqwUmzJlD+OFCVfb9YYtuI2SQqzsoeJlaH97h2ipbhJv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=7001LfjWaACk81qKMQIA:9 a=UGPXKIqkR3HkfttO:21
    a=T7zJXufAWDG7XLcC:21 a=wPNLvfGTeEIA:10 a=Z52K5TbU17EcDgFyT5Ki:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeDIDlp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:41:45 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:12752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754343AbeDIAVA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 152/189] xen-netfront: Fix race between
 device setup and open
Thread-Topic: [PATCH AUTOSEL for 4.15 152/189] xen-netfront: Fix race between
 device setup and open
Thread-Index: AQHTz5hVN8UmwVdfhkSNilH39N6E7Q==
Date: Mon, 9 Apr 2018 00:18:50 +0000
Message-ID: <20180409001637.162453-152-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:h6ubmhv1AOftDEj/AKdqnn/HgMr+Vmkxyrv30lAXTahge4mBjWvnFL8pLGSCfBPlMjOuXtoDiSQy6Fnu27rBfZNTjF/lFbN3XlIv4RdXtS06Q8wV3b0uDQxmr/phTm/8Cf1nZia44mIbco04tZdlvlFBIO7f2wyglPaqLc8IjGyHRmM10gDrIifNvHIpLzpdF1uPVMCFVzhq1zaUfB4mnj2zvmH1MWRsr180saQpCyT3p+k5XnunAw3K79OqVLBN;20:ElduxkORbozt9pCXACGExF3twIUfkcRa9BczVcjArPuDRzqr1giQRr9ITYFI117doZP7FZVRM2GTv39EJ1T/vYAcw7TgeH9UEY/8/uE5OkodFALIjX5a+Iiq7+LkZMtAGImwWEyhMrDGDvSAH387KNyofLxdhjQfNFVVxk1KbRU=
X-MS-Office365-Filtering-Correlation-Id: de6822ba-0d93-48a3-0305-08d59dafc40c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920D923A1D92AAD33342888FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(55674003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(551934003)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(8666007)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TA1kEl1NrgrEU94GA8rQRyh6Hm08sWlg/N5pl1Fh1sS+BgbCcsiOMuU2bOc/67/9qH41c3yP4YUXWOxNjMIuxokMM4V4rpJfqT1m8TQWNybvEbDKN+5T7321+B8gkeoeuSgaT98QdH9ePq+h19mfBBmDN2XpkrO2UpH8NgPshegydsWTLmxl4xd+YQ83V318OBEdkryw9i9eptI2tjEO412VZUywGR0H9QlTfIUVgBeTCyewsqwp+MMLV298WSKze5hcvsTIGrTg4CoSt9/VYDuXwy9nuVnYagNp075Z+UBsVEnelIeSH8HAPsHC7Ezh76u4Qrpxl3GlTfsEPTY+XNXYME6XzigESMm7b2Tb5b4h6C0ygfBKizBJFrjS5Wo8QaSwrFcElrcRieWplvplZXxwiVpyiDntof1EIVFBmlk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6822ba-0d93-48a3-0305-08d59dafc40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:50.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 9bd7ddeeb6a5..8328d395e332 100644
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
@@ -1737,8 +1730,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 {
 	unsigned int i;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1747,8 +1738,6 @@ static void xennet_destroy_queues(struct netfront_inf=
o *info)
 		netif_napi_del(&queue->napi);
 	}
=20
-	rtnl_unlock();
-
 	kfree(info->queues);
 	info->queues =3D NULL;
 }
@@ -1764,8 +1753,6 @@ static int xennet_create_queues(struct netfront_info =
*info,
 	if (!info->queues)
 		return -ENOMEM;
=20
-	rtnl_lock();
-
 	for (i =3D 0; i < *num_queues; i++) {
 		struct netfront_queue *queue =3D &info->queues[i];
=20
@@ -1774,7 +1761,7 @@ static int xennet_create_queues(struct netfront_info =
*info,
=20
 		ret =3D xennet_init_queue(queue);
 		if (ret < 0) {
-			dev_warn(&info->netdev->dev,
+			dev_warn(&info->xbdev->dev,
 				 "only created %d queues\n", i);
 			*num_queues =3D i;
 			break;
@@ -1788,10 +1775,8 @@ static int xennet_create_queues(struct netfront_info=
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
@@ -1828,6 +1813,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		goto out;
 	}
=20
+	rtnl_lock();
 	if (info->queues)
 		xennet_destroy_queues(info);
=20
@@ -1838,6 +1824,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 		info->queues =3D NULL;
 		goto out;
 	}
+	rtnl_unlock();
=20
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i =3D 0; i < num_queues; ++i) {
@@ -1934,8 +1921,10 @@ abort_transaction_no_dev_fatal:
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
@@ -1965,6 +1954,15 @@ static int xennet_connect(struct net_device *dev)
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
@@ -2150,10 +2148,14 @@ static int xennet_remove(struct xenbus_device *dev)
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
