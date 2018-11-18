Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1071C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0A02075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Cax8mrMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0A02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeKSCDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:03:14 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35275 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKSCDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:03:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,249,1539673200"; 
   d="scan'208";a="20534737"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Nov 2018 08:42:37 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 18 Nov 2018 08:42:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWbvHeULobWs77zVTyMjUYvSHcx2vmpZLMaHTy+x1hk=;
 b=Cax8mrMiMX7ADzNLU4Neacn15hoZ7mfzgHK4RQqUkwGHzAYpxhNivPMF+zQPSySfHxRpLujdGyFa82S27FzngNfwZpm2MVCOLOYobn5aOpDPGBilrWBJ2/kCma6uZ7Yk8v/ARAUZsitafUxi70pSBWxkSRHaqrB7+OMS7o/CrmA=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1917.namprd11.prod.outlook.com (10.175.54.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Sun, 18 Nov 2018 15:42:35 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::f55a:dbdf:f578:ac79]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::f55a:dbdf:f578:ac79%3]) with mapi id 15.20.1339.026; Sun, 18 Nov 2018
 15:42:34 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <brgl@bgdev.pl>, <nsekhar@ti.com>, <khilman@kernel.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <marek.vasut@gmail.com>, <richard@nod.at>, <davem@davemloft.net>,
        <grygorii.strashko@ti.com>, <srinivas.kandagatla@linaro.org>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <wsa@the-dreams.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 11/25] net: cadence: switch to using
 nvmem_get_mac_address()
Thread-Topic: [PATCH v2 11/25] net: cadence: switch to using
 nvmem_get_mac_address()
Thread-Index: AQHUf1VTm7TSrNH62UeuPGqbhWWWWw==
Date:   Sun, 18 Nov 2018 15:42:34 +0000
Message-ID: <bd51c2fb-9f86-450a-74d1-0cba5c9e9cee@microchip.com>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-12-brgl@bgdev.pl>
In-Reply-To: <20181113140133.17385-12-brgl@bgdev.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::33)
 To MWHPR11MB1662.namprd11.prod.outlook.com (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a01:cb1c:767:3c00:80b4:e483:399:a037]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1917;6:8VW2eu4j7827BPkYulZuejXWU5M28O7KQ3okIsSExC2jv4fA3WPyqFm9tOs7UEws5/LfUD+ICNCnInqDnbS8Ey88X8bjvDmDNJCY8XsoMF22hwMG2pcazpNqFc4IfjwXxJWWTcDEijTB5Ijo/leRLBHacm05UQh+aQuU/1oKWiisHc0fb302w60u8Ptlm3rTX9mJpKzrLhlEtz9B2hDkS95M22olRF8/YwwN2evZEkPIT6Ofp8I12aaedXWGT0Az6mR5OneFERS0jw7Yb2ybTt22j8MMLB1+IJ72t3khEWmfkpXEUJKgtoWjER24fZK/7gkW7M+X8onKw7ABfYJduTfFb2T/sLz28dNKiIAcOHYj9IxywnA0eFDfT2VZasZLUtBEgQWkQZmwq3kxm7UyAQadwviuBmK7eTtQ1CVVSAFZ7uE5PqmIHCCe4EhiXNuir+gSjVW6VFDLOUDqyhonXw==;5:eB6fe8u/jaydXUWKpdXWU8nejD6TV7PUX5gbrhOHeCPyTuFFm5awQY0ojNTq6D7IvsLSjkKIxLTs25Dg23FczPgYZWLTtFQ1bgbn1WZ5AUcE3IsZF4e6WJUpoKhHTAlmmqoTVYvIZsimhwfDzgA/lZ0MGBF7nydc1pE7jKcG2ZE=;7:sng+mbZHiMk98Cq2pXLwdb4sWuRL1wDqLtEopBtzT8Mvds5SzXfOjoB6Th0e00sCpQJ3ro0cHvV6ybUdafF29euaWh92peDh28ykEt5vip96OoYupAbDD9vnWg50tWBULFgSrWGpRicIkfSqZ0OT1g==
x-ms-office365-filtering-correlation-id: 532a2dd8-729e-4fa7-453b-08d64d6c7547
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1917;
x-ms-traffictypediagnostic: MWHPR11MB1917:
x-microsoft-antispam-prvs: <MWHPR11MB191729ADAF97B824B8EB0F81E0DF0@MWHPR11MB1917.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1917;
x-forefront-prvs: 0860FE717F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39850400004)(366004)(189003)(199004)(6116002)(102836004)(2616005)(71190400001)(71200400001)(25786009)(6486002)(2906002)(53936002)(486006)(386003)(6506007)(476003)(4326008)(6246003)(53546011)(7736002)(305945005)(11346002)(7416002)(14454004)(446003)(76176011)(39060400002)(31686004)(5660300001)(2900100001)(6436002)(316002)(256004)(14444005)(186003)(99286004)(46003)(68736007)(8676002)(52116002)(36756003)(110136005)(86362001)(97736004)(106356001)(229853002)(105586002)(31696002)(8936002)(72206003)(6512007)(478600001)(54906003)(81156014)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1917;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rtznDoX+FyaPaescMHxLt86NqoijjDD1NSLg+kVYNHQrPql49bSYUCqlPCo3jqTTPonR7iKSACc+L1gNz5/tF+hw7jpckwvc2NHbdl/569NwDuXFDHdbsWkXkCuFdCf76+xyRnD0wGPZwlkkG1/vJJjCj8mwwteGsaXn7HMtXs9VKJyXMW3kbv88D+T0UoiYlVmH57YtwHTJDArZYYFWO7X8I0cD60cAmOa94c4TvcXsG7Y3vX9++wjugdpcnMaR3PoO7pGvuQ5zyQ4mk1lZkGCF54SoTX23/4ffCko4viHuixQX75dw20xzMD+tPygqHp4XBZLe+TylxdUaxP+qurzPGTdoAOS0HJh4qVAHa7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <79F765BA4327334388470161DA7A66DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a2dd8-729e-4fa7-453b-08d64d6c7547
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2018 15:42:34.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1917
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMTEvMjAxOCBhdCAxNTowMSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToNCj4gRnJv
bTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4NCj4gDQo+
IFdlIG5vdyBoYXZlIGEgZ2VuZXJhbGl6ZWQgaGVscGVyIHJvdXRpbmUgdG8gcmVhZCB0aGUgTUFD
IGFkZHJlc3MgZnJvbQ0KPiBudm1lbSB3aGljaCB0YWtlcyBzdHJ1Y3QgZGV2aWNlIGFzIGFyZ3Vt
ZW50LiBUaGUgbnZtZW0gc3Vic3lzdGVtIHdpbGwNCj4gdGhlbiB0cnkgZGV2aWNlIHRyZWUgZmly
c3QgYmVmb3JlIGFsbCBvdGhlciBwb3RlbnRpYWwgcHJvdmlkZXJzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4NCg0K
QWNrZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCg0K
PiAtLS0NCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jIHwgMiAr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IGluZGV4IDFkODZi
NGQ1NjQ1YS4uZDlhMjA4ZjdiYjQwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVu
Y2UvbWFjYl9tYWluLmMNCj4gQEAgLTQwNTUsNyArNDA1NSw3IEBAIHN0YXRpYyBpbnQgbWFjYl9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAlpZiAobWFjKSB7DQo+ICAg
CQlldGhlcl9hZGRyX2NvcHkoYnAtPmRldi0+ZGV2X2FkZHIsIG1hYyk7DQo+ICAgCX0gZWxzZSB7
DQo+IC0JCWVyciA9IG9mX2dldF9udm1lbV9tYWNfYWRkcmVzcyhucCwgYnAtPmRldi0+ZGV2X2Fk
ZHIpOw0KPiArCQllcnIgPSBudm1lbV9nZXRfbWFjX2FkZHJlc3MoJnBkZXYtPmRldiwgYnAtPmRl
di0+ZGV2X2FkZHIpOw0KPiAgIAkJaWYgKGVycikgew0KPiAgIAkJCWlmIChlcnIgPT0gLUVQUk9C
RV9ERUZFUikNCj4gICAJCQkJZ290byBlcnJfb3V0X2ZyZWVfbmV0ZGV2Ow0KPiANCg0KDQotLSAN
Ck5pY29sYXMgRmVycmUNCg==
