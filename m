Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6866C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661D121741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F8t0+dlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeLTNFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:05:18 -0500
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:48320
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbeLTNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nbPiXuZKoWmD4Kxerz+UIgmEHlak2XR9RvdrpbL898=;
 b=F8t0+dlpAWFkO8T0I/Yn/bKzYWpj3TD+3KaUaWYgwKgtQ9LOiOWjBhvsnGkM/hZ1SEg8jPA22GRB8ArLgkPSSSx+gWDed8bcw+nIlcpKwe4D3LXPKRJu+sLX+E/ypFoDQoYIaSUyY4R9YYkvJ/Bwshkz0+LECjlycX1CR8zOdAM=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 20 Dec 2018 13:05:11 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%6]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 13:05:11 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3] drivers/base: add sysfs entries for suppliers and
 consumers
Thread-Topic: [PATCH v3] drivers/base: add sysfs entries for suppliers and
 consumers
Thread-Index: AQHUmGSkRwTK/POd80i7w57AHl+skg==
Date:   Thu, 20 Dec 2018 13:05:11 +0000
Message-ID: <1545311096-29321-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0033.eurprd07.prod.outlook.com
 (2603:10a6:800:90::19) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3600;6:n2s9zACdl4UpvmA87hN1bRxc9QVng8Cv6EU3XDAh8l1OccYufn70CnWIF4kd5NCjDJ+ez2M9RXW0FRjH15ZfFtnsYAZxPSV534fsXwFCr5fhi63aQWzsAgw0RgO2px2l2xpfZ9RG5dtTqknBprqd1Sz+rF7vo3bqKx5g7sz9ZahxLtImBuxt7813QzDycgJiDADarKCehlwXyZa/a/Bc7EfQLwitC3mLVv8trFVdqV3m6aUkx/Ct7ZUvh3/QXCnC7r7k6jIeunZ/CFmGyK1TbRqmi2njU+hGaI0IuA3nEhRiV8p1w3Wb/tZg4/aewvkoVCH7QlMNMQLq9+W7Hy2sBEahY4Wg0SV/35lSzfTCrsDhT3G2T6neoC1TVZi2Zzvul4Ep1ekazbSCFh9mOGEw33WivK+rtYzgz9E0aiud7KWtgmx1uSouFmGo21IJRonOQc0YIcrmsJ6vUS2uKI588Q==;5:QNYXGXoPlef9PVHhtZqG+cBuGrCKjQVscgHFiBdnvGYWV0Vbs8qDyN+ejwNzPlZP42Dy56ALGgBRNCkV0XKSzn1VuLLV4ZzVlt1uR3rT6y6rLvUCOV+PtX+1WlzWTls73d13oeYV5+lMyqlX1eQSUPM2stHeBjLSm0FtU9f1iKA=;7:xt1SvzPzgMVB9QMOnEdkmuV1vbr2OZ4SeNuxaAYfx6PuNMSm0cCVa7tC6dlVqDrmSzrcO+AERWMwUm0dxQAVRyR08CPIeIk0c/91qPwxIhhhSsIsDsHa2CQAJxK4e+ghP9tVIKVSp3M179kW0Jk9Sg==
x-ms-office365-filtering-correlation-id: e245506d-4b64-4225-e0ac-08d6667bc65b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3600;
x-ms-traffictypediagnostic: VI1PR0402MB3600:
x-microsoft-antispam-prvs: <VI1PR0402MB3600489B338AF77DABBAE9DCE0BF0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3600;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3600;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(366004)(136003)(199004)(189003)(26005)(3846002)(2906002)(8936002)(102836004)(106356001)(6506007)(386003)(8676002)(1730700003)(186003)(71190400001)(71200400001)(52116002)(7736002)(81156014)(2616005)(6116002)(54906003)(5640700003)(86362001)(81166006)(2351001)(105586002)(4326008)(14454004)(5660300001)(44832011)(2501003)(25786009)(6916009)(476003)(305945005)(97736004)(486006)(53936002)(68736007)(256004)(6512007)(66066001)(478600001)(6486002)(36756003)(6436002)(316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3600;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3eIDfwy8qrcBdG1skQUlVgEQpWyKOfTwgVR+Vk9gq8XHQ1ic8ZigpRoEKSEojUpD+vifYjJBPRJ1HYD1In+0tQGKhYHrMg4QN7ffCpquXN4DygOoz1DubdRLaSbIolj60X4XMA5S/ehP5NGRIhBVY2yr+FZqOfPp+m8OqsyKLQ4T4RAtEfwlGKWHwuu9FJPuVFfLFX+prllsK8EqXL8WssGaApjekC8JZWhwXeUQ607uCB+cFWSfRG14Z1IBz50ej1WobDUi4mdHytVqdFO+kEeRSOou1amhRV4O5GgPr+LmwnFCEjJi4psv9H7Lk7j+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e245506d-4b64-4225-e0ac-08d6667bc65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 13:05:11.6768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of scraping dmesg for messages such as 'Linked as a consumer to'
or 'Dropping the link to' export two new sysfs entries in the device
folder that contain a list of the consumer and supplier devices.

Also, lower the log level of the prints since the same information
is available in the sysfs entries.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
  - lower the log level of prints
Changes in v2:
  - add documentation entries for the new sysfs files

 Documentation/ABI/testing/sysfs-devices-links | 13 +++++++
 drivers/base/core.c                           | 52 +++++++++++++++++++++++=
+---
 2 files changed, 60 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-links

diff --git a/Documentation/ABI/testing/sysfs-devices-links b/Documentation/=
ABI/testing/sysfs-devices-links
new file mode 100644
index 0000000..d3951c5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-links
@@ -0,0 +1,13 @@
+What:		/sys/devices/.../consumers
+Date:		December 2018
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:
+		Read-only attribute that lists the current "consumers" of
+		a specific device.
+
+What:		/sys/devices/.../suppliers
+Date:		December 2018
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:
+		Read-only attribute that lists the current "suppliers" of
+		a specific device.
diff --git a/drivers/base/core.c b/drivers/base/core.c
index a4ced33..5339bcf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -301,7 +301,7 @@ struct device_link *device_link_add(struct device *cons=
umer,
 	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
 	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
=20
-	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
+	dev_dbg(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
=20
  out:
 	device_pm_unlock();
@@ -327,8 +327,8 @@ static void __device_link_del(struct kref *kref)
 {
 	struct device_link *link =3D container_of(kref, struct device_link, kref)=
;
=20
-	dev_info(link->consumer, "Dropping the link to %s\n",
-		 dev_name(link->supplier));
+	dev_dbg(link->consumer, "Dropping the link to %s\n",
+		dev_name(link->supplier));
=20
 	if (link->flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_drop_link(link->consumer);
@@ -342,8 +342,8 @@ static void __device_link_del(struct kref *kref)
 {
 	struct device_link *link =3D container_of(kref, struct device_link, kref)=
;
=20
-	dev_info(link->consumer, "Dropping the link to %s\n",
-		 dev_name(link->supplier));
+	dev_dbg(link->consumer, "Dropping the link to %s\n",
+		dev_name(link->supplier));
=20
 	if (link->flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_drop_link(link->consumer);
@@ -1117,6 +1117,34 @@ static ssize_t online_store(struct device *dev, stru=
ct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
=20
+static ssize_t suppliers_show(struct device *dev, struct device_attribute =
*attr,
+			      char *buf)
+{
+	struct device_link *link;
+	size_t count =3D 0;
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node)
+		count +=3D scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+				   dev_name(link->supplier));
+
+	return count;
+}
+static DEVICE_ATTR_RO(suppliers);
+
+static ssize_t consumers_show(struct device *dev, struct device_attribute =
*attr,
+			      char *buf)
+{
+	struct device_link *link;
+	size_t count =3D 0;
+
+	list_for_each_entry(link, &dev->links.consumers, s_node)
+		count +=3D scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+				   dev_name(link->consumer));
+
+	return count;
+}
+static DEVICE_ATTR_RO(consumers);
+
 int device_add_groups(struct device *dev, const struct attribute_group **g=
roups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -1288,8 +1316,20 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_groups;
 	}
=20
+	error =3D device_create_file(dev, &dev_attr_suppliers);
+	if (error)
+		goto err_remove_online;
+
+	error =3D device_create_file(dev, &dev_attr_consumers);
+	if (error)
+		goto err_remove_suppliers;
+
 	return 0;
=20
+ err_remove_suppliers:
+	device_remove_file(dev, &dev_attr_suppliers);
+ err_remove_online:
+	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
 	device_remove_groups(dev, dev->groups);
  err_remove_type_groups:
@@ -1307,6 +1347,8 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class =3D dev->class;
 	const struct device_type *type =3D dev->type;
=20
+	device_remove_file(dev, &dev_attr_consumers);
+	device_remove_file(dev, &dev_attr_suppliers);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
=20
--=20
1.9.1

