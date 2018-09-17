Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDAAECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870F8208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VmqmrEu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870F8208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbeIQJCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:02:11 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727130AbeIQIZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40a66NP47r+nu5jl2Em0lnbd/Nwm4HF/n/pGFAvIEuc=;
 b=VmqmrEu0mdkaSdpJlRgNu34FjoRvXn0MVhNoxjNzgPPH7vnje5+6ApkTDfHLWdvygVMHNXPaqFMPFqfrsDs5ATEPBXh2yfPW1YWqBPVkj3BsAnaiuKkI8ms+OSx0J1a9Ysfse3UsmE69msHrGwgbgQ5PQyDfZusJwPWqlVcuC6E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 019/136] Bluetooth: Add a new Realtek 8723DE ID
 0bda:b009
Thread-Topic: [PATCH AUTOSEL 4.18 019/136] Bluetooth: Add a new Realtek 8723DE
 ID 0bda:b009
Thread-Index: AQHUTjKTFR3ug8/s70Wv9PVIJKb8AA==
Date:   Mon, 17 Sep 2018 03:00:23 +0000
Message-ID: <20180917030006.245495-19-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:VNRJHTuQWYrtWQoRcyyHL1CT/2pr9CLkbF1/BPjQVO5tkk+yDy9JJfA0An3GUEt5RznxGHdl0nJHrYHSZMxnTz58LV7adUmjUDdh248NUUQwFpRgh+N3Fz1c7BhsAfreJd9Py+isPamSBFIhjTWIAaCu8cbdS+FrJ/B1Y2SvOmhVMcvGcVxvBgqqjqtgFPd+XFztSuNUs2sPde7jZv/acqD1sIsk42n4UbIZct/iYZqTjxkRs0eZKe9qVYGlwiAnoyI3xPGIX63ypFbyfbNcxaWJqqClbRnUkN5qlQeIE45r6Vy3N05Rt7U9rln/1By7kgf1gLaQFojlSjL4X1a3sOuL7hPuDxbVoo5GgHT4+q152N6JR8D2pBcpmmBHNID7aY5n2XLgUcIc6LY9G4P4i56GyPvIntnDGHmRkDK3Ea6otF+xnOfzY2k+5NaHW9Xf9lefoy+bedB+KcSbIVaVpg==;5:kz38eNLPvKLpRmaDG3NTWsk+lx4/CJW5oS0Hf7pn9uykc6YH5zUoag1Eb+hP7rs2dcBaPMJneN9mlsL/5ZwhDGzq3vwCIeBd4KoFja6kIdMuA+0pgy4Nrs+Q5fSOBvI6tfVC/KAgHg5fFo3aQj69PzjggzO7tDWi4EbijwZRLWM=;7:GoDgHnsPpXZycl/bzjx279GRjgjj382x6MuA1eOY2Sw1Bb8yp4XYhGV7FJ4USFe4A4CyOniW/cK3JMshI+iETJm1Tqt/6+wzDK6WIfFEm5GMrI4e0Qd9cNpYNEy9V+8zuOvkn0P1za8i+8uq605RDDAMd8CjpyK+q9R4t0X37KMCrLEJgOKSaDq+c3/Qo+5+XZjjA/CK471kysUwoRRb0ylqM5/kpnbxV4enigT78I24Z/m1j56+12FWCBgcu2Vt
x-ms-office365-filtering-correlation-id: c38677e5-1986-47da-cc6b-08d61c49b774
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277582B7E78B4CCF5ECE056FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xgrjSQ06xdTB3hsOYg9/Zun9FuJoFB/JGbMj09sgt9VEPgZ4sa7L27sDs0Eb2SDxcvfmaFepRZxYw2jIK58O5Iv6BB8DTT7D0tumA4FbaYzZRHf82bHR8F8yOH7GYGZ039iV7qgU6c0u3x2idgREwJ3UhbohpcvcdR1KATWXF90YWKFVDNlvyEiQbI4Ub51XIe/Qi0R6gYwREqo5natq5QIrPbPPLe5JOXvAv3JDb0AGvDDTS5630pyxjBshf2HjPtUdbLhQzUFKKcWrsQWDoHdHwwKDr8lk/GaLu+6xOUsXkpKI5mvCS3RSKPM0hsPD3tXiY/K/rOYgnGTZwECMXhGRAEVsOv2prbQyl1s0fmQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38677e5-1986-47da-cc6b-08d61c49b774
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:23.2298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
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
index f73a27ea28cc..75947f04fc75 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -374,6 +374,7 @@ static const struct usb_device_id blacklist_table[] =3D=
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
