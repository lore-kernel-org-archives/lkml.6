Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B39ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F57208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SyPr5Ncy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F57208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeIQIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:43:27 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730107AbeIQIbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgpskGl/r+ZR3GZl8kDlqC/RrQ0uP1nRymHDaTlVnq8=;
 b=SyPr5Ncydw7C+rySGoC0aW4+GagBVgWsQud4M2Z5XZr1ypIuerZgD3h1Uo+6ZyT2Xg5uYTJdImQBJnxiR9e1qEvMCyVl4rPqBlaxfpNnjHG9p6wBpDYzt5dTgD4Ekce008ToHvWGFGqNlWCcSx7D3OQAcyYPf3r3+Za6mlpFrSs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 09/57] Bluetooth: Add a new Realtek 8723DE ID
 0bda:b009
Thread-Topic: [PATCH AUTOSEL 4.9 09/57] Bluetooth: Add a new Realtek 8723DE ID
 0bda:b009
Thread-Index: AQHUTjMO7jZm9+pmE0e1Zqu2OwngkQ==
Date:   Mon, 17 Sep 2018 03:03:49 +0000
Message-ID: <20180917030340.378-9-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:yuua+XUWsV1JB9MnRB2oYZclwn0aFhDpT8M/+5x7Y0oAkG6b4dUD9rFNFhi9q+egQJ/WFx6i8dNa+WCjE89tvL5LzuW5SiBxdyW9rfgPCU9hdE09X46o9tFfn3W+8x/zIfXDTrFL6vgSrPHu7HxSZgoR/+yQAzlUyUmZglF8WmH5g+IqYTpkkyy/wf64rNZWJt7NqapCwcwx+r39WLOj6ALtHhLX7rjvdi0cSXWwJf/Fsc8Pmwvw/RujelxYEY8wjJci8LUQOuZOKL6vdcLVP6x4EZPxsBD3HM2UgqGtAIvwevkPzMOWHddXnTJUw6p0Kx3xjjhL5sHuWvbhjTluBFT3Z7lFY+8EZV3lMp1CJEhCtNMUKhALd6Cf3ShzD5isn79tQjTpv7L8El01HYWURQdjTiOqaT2oic+zhFNwawS5qEEEQg7DBCjPz0szO+nee1cpl7jwdUkuzccxzVr95g==;5:OPiSKSLtc018SED4ErYwqPY7xzyYByMKjl3/LPyjyz76oZ+18uEg9NsSeo/PHUZC4gP3j3AQtN3CQLzFjOqvUd31BnjhEfPTCYTc9wah6uEQFbr9z4qKRHLluogPKQK4TXhYhn9tNJSb6DTNItftm3ssN0PRSk4/dtQXz39rhVQ=;7:Y4l0/m0/SajzpyP4NgoQbNC7I1xjC3mlfFOkNSC6ufLdF4oX4cSrvYi6p1HGBtQFRyuY88I9xm5Mg9Qy+bGD0smPEf06roQVwY/txeZk2c5sK1nPPFylacVghu/y3YaUrx8fpigynkFWineABdw5lNYRjn8PfPaaJ1RGSF3lI+eRhPlr46qpN3ZaDhs6JkC8lM0CXXLUfU3LT1iKFkgl63MTdY5jSdUJYJPm8tcPIBjCJ7Y+z2YuzIPNx9LNlPvi
x-ms-office365-filtering-correlation-id: e90f9b79-b219-481b-967c-08d61c4a71d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01202C52D550099A23CE86F1FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pn+v7ufqU8VlJUPGpgXFg6t0YJRPPZqHdSCSga4u99hgpQHUAa7+Bc+mEwHcQ2E/BbjqmUOh3eQW+GGpmDR9pfAIiz7L/WHvXy4kxzysqFOxTKQem+1/UfvIx+iSG8jTWTZFkJsbG26Cuvo1WHUJe8gi0pdGz+Rb+vMuhwnk6I7KZJc2OWGQpYPYkyx5qDP3zvm1Fb0KGZH3R1mDAJuyXhFw3MxHMbLqdQLpO2fYvvlzxvfVuV9Td0KeNCFuD3IVMjNJ9QtxnDDhgS5mgCBGq/L+QIAXWGVAAgMFaEhueXlZSwQHSavzvfxyHdiL3uRypoWCAxIg5Sef2N49rJ0hFSEZCTzBTUSD9xEievnyB2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90f9b79-b219-481b-967c-08d61c4a71d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:49.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 44bccb1afa06..8dce1a890078 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -349,6 +349,7 @@ static const struct usb_device_id blacklist_table[] =3D=
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
