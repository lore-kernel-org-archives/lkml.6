Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B4ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C9C208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vgu/Amm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C9C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeIQIuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:50:44 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728040AbeIQI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjaKqpySGZhMf5q2CIQNAu44eRFr2RYeBQnHOL5ZCNA=;
 b=Vgu/Amm4t85cMBGs9ebAtWigSh3geRU7eQ3PRDnWqT8eO6uwRw46378eZJi/K5cXHmZhtYdOLdEa7Xul/nG7rDiao5UZ2pOKh3AJMU20UkXwxZDJBwz4kx+eihaW9G57O6VysjgvwG4lbRTfL9kXclcLflQ5Ja+ZFCaRlUxvICE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 129/136] Input: xen-kbdfront - fix multi-touch
 XenStore node's locations
Thread-Topic: [PATCH AUTOSEL 4.18 129/136] Input: xen-kbdfront - fix
 multi-touch XenStore node's locations
Thread-Index: AQHUTjK9bx6t93d0p0SW0e4ZDqJf6A==
Date:   Mon, 17 Sep 2018 03:01:33 +0000
Message-ID: <20180917030006.245495-129-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:2tuErkDDmK7EcJYKxerz/+pQDqM9EWTsGgPpYlHkkKMLMjfnW89T+s8y8yBKBuYhSlymW9+/KMpcOD5Ck3IqzFq+HPUtsqeF0ut4rfUCYJn6ptyu7/awadSlv9vrMYceCYBf5y2qZeGoZHQl4fQqZSG7pS3979GXUKGxXHc2659Ci1egq1A0eJtPAvcrZ+b1a39tg02Czpw53CJbNTNtq8kDCx859UIGo57AJ6A6R9zuQ923as01GUUc7IjJLhM3h4slYPYYbNDqV7THisHiZ0zCo70s4ToAJVMjxzUBvrouHiAZmigK1cSC5GN12cYR3Odu4E6c0bX0j9VdF3F0mAddfHRXVu+ebu65ggQ5fGlqLne6fWrGx7FJdciAW/AtK1O8PkEbhU95Z6pHgdU6ESF4/6nWSK764uwkLIA1DAKvJhvkb3diLkc3iWJp7KNKxygbBDJBpcr8ZYyHpHkigw==;5:byqRS9yGZjTQQhwX9o/KqFa+M6fMGpFizUBgOQpHkkxAJeXhnOp+YlC1Hil0usu233NJ8u8D0vGYdavz6JVEhoKNYucGbo1IJP241D+AnpJDgJKrP6hPLZ0CDkLgGR0diT0D5CfWLhwGwZOkyRFaaYGz3LErZRkZN2mjcP81oxY=;7:ivTsvzvSL039KUEbChZZKtMOqLpsN/zhzUaGYRjSGpklzg+107jTNd4RLg71Iul33Iazn4KNMUmTwOnroks+nyFVI7+ifFGPmSdjE3/eENXjPQ+tAeTzhUnwUMpZMC0jNfIb9vIsqaekALU07m1BnkDUyENNly5ohkgqOs8PNimR5eKkpQd3q/xdIHBLQFqPC4pwSZWG+ygCyYjsO7KQ2kx0t5zUq+nVCv837cNB4+5ltswzbxDlb7BGw1NG1lnq
x-ms-office365-filtering-correlation-id: b9b49e42-8520-439f-4ce9-08d61c4a20f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB0118F5E0C684C631023E6C22FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(4114951738403)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(39060400002)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RNrtVDNOzUyudS8Z0tYsG9dsrLGkH2FtL3TbL4uq0bg9AqiTWL8Y66izAwVTa9yDOgRbrCPgTKtTEy8YYRXuiR1uicbS/5D/63m2pICoTQsNDJMOYKxVZYHvIphxi+6/CMCkC/d9kl5X6bs6TYePrIQlD4Il79Rmh1f03W7/4e9g6MXZeciXV1yRom0fwczV3ce2rBSzZOeW+QCP6YMDDWy+uvTjswn4uMpN++wN2pcg9hiAtEo0G9rB8FrAzCb0Sja95gSVlIeupxDCT+0hdzdguu4K2LiEoqC+Oiiz8HvzAvxrtca4AXlaZksBr9QJ3VpBphSuY2/itXBD4hRsUrSkJ5he6xhcOo8t2zXEtOI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b49e42-8520-439f-4ce9-08d61c4a20f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:33.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

[ Upstream commit ce6f7d087e2b037f47349c1c36ac97678d02e394 ]

kbdif protocol describes multi-touch device parameters as a
part of frontend's XenBus configuration nodes while they
belong to backend's configuration. Fix this by reading the
parameters as defined by the protocol.

Fixes: 49aac8204da5 ("Input: xen-kbdfront - add multi-touch support")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/misc/xen-kbdfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbd=
front.c
index d91f3b1c5375..92d739649022 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -229,7 +229,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		}
 	}
=20
-	touch =3D xenbus_read_unsigned(dev->nodename,
+	touch =3D xenbus_read_unsigned(dev->otherend,
 				     XENKBD_FIELD_FEAT_MTOUCH, 0);
 	if (touch) {
 		ret =3D xenbus_write(XBT_NIL, dev->nodename,
@@ -304,13 +304,13 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		if (!mtouch)
 			goto error_nomem;
=20
-		num_cont =3D xenbus_read_unsigned(info->xbdev->nodename,
+		num_cont =3D xenbus_read_unsigned(info->xbdev->otherend,
 						XENKBD_FIELD_MT_NUM_CONTACTS,
 						1);
-		width =3D xenbus_read_unsigned(info->xbdev->nodename,
+		width =3D xenbus_read_unsigned(info->xbdev->otherend,
 					     XENKBD_FIELD_MT_WIDTH,
 					     XENFB_WIDTH);
-		height =3D xenbus_read_unsigned(info->xbdev->nodename,
+		height =3D xenbus_read_unsigned(info->xbdev->otherend,
 					      XENKBD_FIELD_MT_HEIGHT,
 					      XENFB_HEIGHT);
=20
--=20
2.17.1
