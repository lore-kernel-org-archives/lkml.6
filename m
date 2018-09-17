Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65989ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027CB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VjOeHNWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027CB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeIQIvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:51:41 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728760AbeIQI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcWnes6JvLZmdRt7U8m9HCdwkd1K/yWw5UVddaWEXWs=;
 b=VjOeHNWRbnra3PANOyafj8tQNvOk8h3G3IlsiSnVZp6mAdpDc+z3d7pB/jbN1U8zk05aJ2fVSwa7gDkWCfqqmZyyvFDBtysFvCiw5mthZOuW7vpmbPRIb3ZGcLYpp2Ny+6Kl4lvAKniq3JCttjmcfdjoZNj6RGp/vbz7nKDmjRM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/87] Bluetooth: Add a new Realtek 8723DE ID
 0bda:b009
Thread-Topic: [PATCH AUTOSEL 4.14 13/87] Bluetooth: Add a new Realtek 8723DE
 ID 0bda:b009
Thread-Index: AQHUTjLgDUmkYYapy0KNhcdv1I0wJA==
Date:   Mon, 17 Sep 2018 03:02:32 +0000
Message-ID: <20180917030220.245686-13-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:RXyLq4CvCtYa/oVPNukkbvU9z/x3W2PMWHz9otjarU8aZOW+VhkG8PGxdvqP3VTlpY9E9Z6GTWsaZEuhXZ++J9qTtsnOZSPo+cPDygnW324xYTokFcTdDq6PVbJNJ920A5CLj0v98hV93HK8cT6CraAaeMWytnnxf/HHUCpM0H0tNRUeK04TX+I1E7TTZ0yUC9q6bmJ56JwFqU/4+nbVkkeXOjNPJMz4Ys8SJ64NTQZcq99hojgd5+EpAMNPy0GyVeDPLEoM9enjAvI1FUHOXHHO1kUmWlbdVY16suWwwuk4EuR/FpDQzPU27ujRNljslO3GNVhhKSw5DE6tdfz3rVnFwURnnFbETH5diGJzg+Wco3DyVnVhuJNvTWYN5v1DQQw1ZiFZ47oJ3n9c27HWA7RT5tEr1OUnRwvWLtVsGj3DIMZhk00V0afrICzRPdUNNpbKkDJKrIxECvECwA/J1Q==;5:53lqUcZr6yXEJI4wcgEx6npAMDqH/M1PcqaAVF4P22PL8KCUK3DjYyftmZ4MPzaF64aqN0DP9w+yTIoIyyRfAgvBCXQNZ0AorkoU7N4vFOUpTXM4NYy13ZIw7I6qTbvteb+B6+GTyLQgHeyguGjrEnrWmtxxFdcuOMdF6XhF8pM=;7:v68111JcqRpFj1IJUdx5FqzhLTVjMaxkQ5ggOI6ni+tWh7sv+Va/AnEK6afbixNXVtHgrkoPCqdc+3lIDsqeMxvLzzUKRh96DwpTUiFtG2wtZ36TUW0pAtdJ5hP7Tq4hck8ake0twAbAfJGtqzkz1CSeL9LciXgkNQbIKvILq5avFv93gsr6o1033G9/TjOi/eoZcPbhfpolc43tuTh3qrsUKdXgwb4QgYnIKUcbpGpK3klsvy2wxWi2h4XMfcFF
x-ms-office365-filtering-correlation-id: 6be7b741-310d-44e6-e1bb-08d61c4a27eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08558EC2298F961EF2436E1FFB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ga+WjFriBG73isECDKi549zJi/lLbJ3Tlt0HEBGshFRN07qIL+Q3LbLonEpFjLtRE8X+jjkbBMG5/6XKCJujrjBwjVA/hseRuh/owt1Q1oapFA+bXkhbsaT877Y1ClNF2o6WzEDZbLWPv5WI+tVBoklV8nQc5y80Mq+R6vBL1xpI4IU5wZZg2kGCJaLnD7mNWzEE/HYWKxOlxFCLZQ4jvRPW39prqzMH8TCB5CkdEvqvgAeTlyO2QlQlF3dABqrZI2FqCf1JxNAvJGUenVQ3m7EGryigRo4ZlcsYuNlwUz9WFFn+dRZGlduXezO7FBqrXDZwfQjchwVStiBr7oL9UGxj+TWxowueV0YrX7gEk5c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be7b741-310d-44e6-e1bb-08d61c4a27eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:32.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

[ Upstream commit 45ae68b8cfc25bdbffc11248001c47ab1b76ff6e ]

Without this patch we cannot turn on the Bluethooth adapter on HP
14-bs007la.

T:  Bus=3D01 Lev=3D02 Prnt=3D03 Port=3D00 Cnt=3D01 Dev#=3D  4 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0bda ProdID=3Db009 Rev=3D 2.00
S:  Manufacturer=3DRealtek
S:  Product=3D802.11n WLAN Adapter
S:  SerialNumber=3D00e04c000001
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 819521d5895e..b8dffe937f4f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -375,6 +375,7 @@ static const struct usb_device_id blacklist_table[] =3D=
 {
 	{ USB_DEVICE(0x7392, 0xa611), .driver_info =3D BTUSB_REALTEK },
=20
 	/* Additional Realtek 8723DE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb009), .driver_info =3D BTUSB_REALTEK },
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info =3D BTUSB_REALTEK },
=20
 	/* Additional Realtek 8821AE Bluetooth devices */
--=20
2.17.1
