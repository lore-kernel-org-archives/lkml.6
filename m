Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF33C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3068520869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kC6jPXH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfBBIrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 03:47:04 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46171 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfBBIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 03:47:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="25780655"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Feb 2019 01:47:03 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sat, 2 Feb 2019 01:47:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pn1N7N3j6fKiCmRQVk6neSq0EoKARTIsuHv8vx7QEM=;
 b=kC6jPXH6Q6Xvkn058Zw5dzOavPL10UEHYqTO/Gx8KQxJX223iG1gCHfMB3WRzoxB6qjj6K9l9wc6pqOLl07O5NWAXNgqIsyVWrGWXp55HwWcnIjgDBSkYMO28tlTT6zDc1MLNa61EkySySi3gQqtNzO++jrKeaOBOKWuKT1N0YA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1683.namprd11.prod.outlook.com (10.173.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 08:47:00 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:47:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Topic: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Index: AQHUuqzWMMnmbraYeUy6BKjmB0h60qXMGK0AgAAZp4A=
Date:   Sat, 2 Feb 2019 08:47:00 +0000
Message-ID: <25ed6e19-4fe6-7b8c-4eeb-5bd5be1075fe@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-11-tudor.ambarus@microchip.com>
 <20190202081502.47ca404d@bbrezillon>
In-Reply-To: <20190202081502.47ca404d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0060.eurprd03.prod.outlook.com
 (2603:10a6:803:50::31) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1683;6:kaUc/EWRjl8y/D8tPFNrNXvrB8Oa1suMbyHuq/sefz/txCa7Mh5LhmJ6TGybvwFuyLFMePJOqMXFOPNl6GMgLxZUEwDOVaIPKA+xHviS0iIxLX2f8fGofF4WdBXssfQmcwhwJ+7JfRvo6EQ/3fZH5835M0lS4BsJqUm8CsUN8qJPey3VjIISC6BM29cgDEh0Y+8Y8YkgRdKEEQY61ob4R3VU4Vu2Lqj+UiQtgsIbJKF5+GXm8N6ckivM/2ZFbYw9M2+7JieV8rJeV+pasgpzzPPLgUoqVXjvPSoEoXIDnwCeBt7elurTMdki+umWkKDHu+jkH2F2d3QpaaqwmtZ6vCnbUFccmlR3vAbFE059iQ1TXYEbHOnZlA55XwZ16440qv2NnaBeAcEVawtMjxarqWjhq1sLCddAB2xyAqkWuLZLLnIlEHATkbQePxi2IhO9YvzLVVknxJgxof2r6jAcFA==;5:p0G8Mb2puCNYSK7LInJPf/tOKfrR8unhNLskTvld5apWM7OsAjNXasMSmkjHQAEeCKi/tlG1z64xjmeFuxDoklQCiH8Gg5ugKTTsZxVlST+E78p0F7KGhU/BON6tW2in5Ti9j39GB8TqZFoc+3oiTen+d9ZUjO8rezTyAMoZCu1sLWVVl4ft0vv3GPu+zHVt/WAHEyWbjB2DkxWFrBcM8w==;7:3pT+J/t6O5bLg4d8jZFKd/FScMIRlQVOlmPho90YF9faTGZWygcNq25DpSfPcGux387MNorA91fEqxzZIqX71GB77zNhvrRB4XcLJRMyPIh6ioEth24kyfeScg/ylvP53pYYpQjY/gVcTCjfvshmSw==
x-ms-office365-filtering-correlation-id: 4689e1b7-f483-44e5-4077-08d688eafece
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1683;
x-ms-traffictypediagnostic: BN6PR11MB1683:
x-microsoft-antispam-prvs: <BN6PR11MB1683DC372F7C7D349B58F846F0930@BN6PR11MB1683.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(14454004)(25786009)(66066001)(486006)(97736004)(256004)(446003)(6116002)(3846002)(106356001)(476003)(105586002)(11346002)(39060400002)(53936002)(36756003)(6246003)(6486002)(4326008)(316002)(229853002)(386003)(6506007)(186003)(102836004)(6436002)(6916009)(53546011)(478600001)(72206003)(7416002)(6512007)(31686004)(6306002)(2616005)(966005)(26005)(7736002)(76176011)(8936002)(71190400001)(31696002)(8676002)(81156014)(99286004)(71200400001)(81166006)(2906002)(52116002)(86362001)(54906003)(305945005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1683;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BolOYz4tT3eBpCuri+4GNNa835yvmjmiQGQNg2l16mmVMPw9TT995PrqwGyNE/kD5BP6yZrGS038YdwLBK2Kny0iJpJMb11WrdynR/uLkhvZzbOPk127wYd1eXRz+6LoYxWcZsM/phZw4KA2ZJYxeBrcka4y9me3tXzoYrKR8YfRhOGr0kERIEDT6wAdRvBKSi1RVs7mBDfFAJgO8nwyhvcZiGCfdTIAwwqqaAOKxSk+lGDoSoR8R38EcoZWZC3I//++mhth0Er/dd6/sbjow0NfjoCgP+ILPRBic5/PZP2dhz50Uu8foqoa5iAyEvikrNEH2TEc60QvhDaYIx/BWbZZrN9ozPpv8qK32oYeFY2tGq4FX3ZJP/MlfB65Bf9y/+8gwvr3aSRcazgEMw2KXkQfTzAi/sSClZXkbFbS4NI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99E80F55C8520C429E271364A66E5D0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4689e1b7-f483-44e5-4077-08d688eafece
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:46:57.3317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMTkgMDk6MTUgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
U2F0LCAyIEZlYiAyMDE5IDA0OjA3OjM5ICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNA
bWljcm9jaGlwLmNvbT4NCj4+DQo+PiBOYW1pbmcgY2xvY2tzIGlzIGEgZ29vZCBwcmFjdGljZS4g
TWFrZSAicGNsayIgbWFkYXRvcnkgZXZlbiBpZg0KPj4gd2Ugc3VwcG9ydCB1bm5hbWVkIGNsb2Nr
IGluIHRoZSBkcml2ZXIsIHRvIGJlIGJhY2t3YXJkIGNvbXBhdGlibGUNCj4+IHdpdGggb2xkIERU
cy4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8YmJyZXppbGxvbkBrZXJu
ZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0Bt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiB2MzogbmV3IHBhdGNoDQo+Pg0KPj4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwtcXVhZHNwaS50eHQgfCAyICsrDQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLXF1YWRzcGkudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbC1xdWFkc3BpLnR4dA0K
Pj4gaW5kZXggZTlkYWU2MjY0ZDg5Li4xZGU1NGU4N2Y1ZDYgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLXF1YWRzcGkudHh0DQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLXF1YWRzcGku
dHh0DQo+PiBAQCAtOSw2ICs5LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICAgICAgICAg
ICAgICAgICAgICAtIHFzcGlfbW1hcDogbWVtb3J5IG1hcHBlZCBhZGRyZXNzIHNwYWNlDQo+PiAg
LSBpbnRlcnJ1cHRzOiAgICAgU2hvdWxkIGNvbnRhaW4gdGhlIGludGVycnVwdCBmb3IgdGhlIGRl
dmljZS4NCj4+ICAtIGNsb2NrczogICAgICAgICBUaGUgcGhhbmRsZSBvZiB0aGUgY2xvY2sgbmVl
ZGVkIGJ5IHRoZSBRU1BJIGNvbnRyb2xsZXIuDQo+PiArLSBjbG9jay1uYW1lczogICAgU2hvdWxk
IGNvbnRhaW4gInBjbGsiIGZvciB0aGUgcGVyaXBoZXJhbCBjbG9jay4NCj4+ICAtICNhZGRyZXNz
LWNlbGxzOiBTaG91bGQgYmUgPDE+Lg0KPj4gIC0gI3NpemUtY2VsbHM6ICAgIFNob3VsZCBiZSA8
MD4uDQo+PiAgDQo+PiBAQCAtMjAsNiArMjEsNyBAQCBzcGlAZjAwMjAwMDAgew0KPj4gIAlyZWct
bmFtZXMgPSAicXNwaV9iYXNlIiwgInFzcGlfbW1hcCI7DQo+PiAgCWludGVycnVwdHMgPSA8NTIg
SVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4+ICAJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVS
SVBIRVJBTCA1Mj47DQo+PiArCWNsb2NrLW5hbWVzID0gInBjbGsiDQo+IA0KPiBNaXNzaW5nIHNl
bWljb2xvbi4gT25jZSBmaXhlZCB5b3UgY2FuIGFkZA0KPiANCj4gUmV2aWV3ZWQtYnk6IEJvcmlz
IEJyZXppbGxvbiA8YmJyZXppbGxvbkBrZXJuZWwub3JnPg0KDQp3aWxsIGRvLCB0aGFua3MhDQoN
Cj4gDQo+PiAgCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gIAkjc2l6ZS1jZWxscyA9IDwwPjsN
Cj4+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gDQo+IA0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXggTVREIGRp
c2N1c3Npb24gbWFpbGluZyBsaXN0DQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbXRkLw0KPiANCg==
