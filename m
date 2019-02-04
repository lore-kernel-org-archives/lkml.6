Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA03C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554442083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zSY12mR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfBDO2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:28:32 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4535 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfBDO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:28:32 -0500
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="26116977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 04 Feb 2019 07:28:31 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 07:28:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiVLK7PlMUkqvgJCCVHEbfkiyus8ZuAYgl2vwLC3KX4=;
 b=zSY12mR8LafEgKlrmkQGaAx2rSfxD8Ho77MJS5DpfavB7U7t+75neafjqihXRLMEBUfXMYiQFPd5HhudtCdE9uk7hFKyIJ5KxEsoOU9uyAY31oSSqId1Z6tuAJoRgjVEFEt5jj1Kzd0jylBBPBDYMNjKylprTcS+aa9zmasbS6Q=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1764.namprd11.prod.outlook.com (10.175.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 14:28:28 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 14:28:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUvHHWdNk7TDcc4kmbhc3k/0wcZ6XPr56AgAADPYA=
Date:   Mon, 4 Feb 2019 14:28:27 +0000
Message-ID: <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
 <20190204100910.26701-14-tudor.ambarus@microchip.com>
 <20190204151643.0354180d@bbrezillon>
In-Reply-To: <20190204151643.0354180d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0086.eurprd09.prod.outlook.com
 (2603:10a6:802:29::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1764;6:/3BML+dUdLFRALaHgPsgwX1YAReodw5GihmDnocQXVCnoGl/9e0b8zqFH8wTdA4dNRN1Y0UemizZn5Fs5tQqqXQYK777HT/Dk3ekGwQUBJNm162UqQFbtYrBEWiL+53eboEnbf/4yTCM/IW0HcC6ey+d0E86WguMey1fSEU/ZPhrxq7ffw1dBGR8GyFKQfuzmK+lOS/qUYbObPOcWcsd4DhIrl/wKGEvanplu3nZcNaq6ifZsim7iihMloocP1tUB3oYh/8mtWlBQMXCnNxI94JaKqdfpNoHvGiunRXnqr9o6OiDOxZwKTnOUholdG2iPo8+ynboTYJpF2WkvNLleh8XWB+6rGAZBzL/w2IJEoAUz1Ve9gvfFbzjxz9MqlZPkDtZRPVmUBAzTQ8RXWPut6AR6mbfP3l3KKM2pVyBn2DPgdPo9PVIaGmvkCI8Wco1bta1z2yqIj/zqBI3OPQEEw==;5:1RR9Uu6WC0dT7kR6wXGWXLkX8ngJ5zDv7KDS+SDUgOGRcvGCkaNjGuus4gx8IlD149dM+AJj18L6Tg+MZhQMZxgwEmgEZ05/z2CDoJd42nMHM7cI9LMNzwCgsQluejN9SgaHr/VNQ/DEOLmkjih/QBLKHWpZRsM/T2Pp9Wjp4wfy4bP3S+Po2dL95W4WUqbY89uSpQB2MQX4XyPdtCz8Yg==;7:T31l9Cb9JqPkRjL8E0c24Rm2bXVIGDDRa5hygGF7lNXexr2rsi/P+UASnrR8lxPJD6r4zV2Z0zrvWRZmO+sTI5r5XA6TyceTdbBpIX9IlFjBrysbqslyzKL8728U1c1RdMNZ3MDWMO0p2aMOa1IeSA==
x-ms-office365-filtering-correlation-id: fe0f56bb-8c53-4576-67a8-08d68aad071d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1764;
x-ms-traffictypediagnostic: BN6PR11MB1764:
x-microsoft-antispam-prvs: <BN6PR11MB1764890D4E1354ED32075C89F06D0@BN6PR11MB1764.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(189003)(2906002)(53936002)(4326008)(8936002)(52116002)(76176011)(36756003)(39060400002)(6246003)(7416002)(26005)(186003)(31696002)(68736007)(97736004)(6506007)(53546011)(386003)(316002)(6916009)(31686004)(54906003)(2616005)(66066001)(476003)(6486002)(486006)(102836004)(99286004)(105586002)(71200400001)(446003)(3846002)(86362001)(6116002)(71190400001)(11346002)(6512007)(478600001)(72206003)(305945005)(7736002)(14454004)(14444005)(256004)(6436002)(229853002)(106356001)(8676002)(81156014)(81166006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1764;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xNC7EtdEh3IJiDSKD3M2U1YYyDu8Y/K0aHiyivBn88FU4fmrge7i74LjITOsphdYvUtwtqgPXDiiqzW7gtEk666TVj5cejl02WgsvXaxyte88/WfUcRTAE0xc87sEyt7f0yocmvxyI2tZUAjjePfN4I95IR6av5daYqm0CWlcvsgyb/NMXz0AX2gp/xJymUzXX1OE4lxE8d4BI+8hI82pz8IWDWjdQX9t5C1AdpNeEcZHl4qCWqgST3XE8mnXXkmOiqfanQtyztr6C6KM6vSv8IBmgJXOM9xW/zrUoJZ6eWESkvf3+yz0J2T1EKEA3CFQxPsvclcyCuN68WpPH0m//oDYGDTN8cTOviPbycUQl7vt3FOAYXpMv7iugJIeN8u2jPxDQgr17qmf+qw+239g8VqIFWLSWp/u2gTZQApg4w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76203A191EB89340847F683DC537E571@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f56bb-8c53-4576-67a8-08d68aad071d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:28:25.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1764
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzA0LzIwMTkgMDQ6MTYgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
TW9uLCA0IEZlYiAyMDE5IDEwOjEwOjIxICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBhdG1lbF9xc3BpX3NhbTl4
NjBfd3JpdGVfcmVncyhjb25zdCBzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEsDQo+PiArCQkJCQkgIGNv
bnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCwNCj4+ICsJCQkJCSAgY29uc3Qgc3RydWN0IGF0bWVs
X3FzcGlfY2ZnICpjZmcpDQo+PiArew0KPj4gKwkvKiBDbGVhciBwZW5kaW5nIGludGVycnVwdHMg
Ki8NCj4+ICsJKHZvaWQpcmVhZGxfcmVsYXhlZChhcS0+cmVncyArIFFTUElfU1IpOw0KPj4gKw0K
Pj4gKwkvKiBTZXQgUVNQSSBJbnN0cnVjdGlvbiBGcmFtZSByZWdpc3RlcnMgKi8NCj4+ICsJd3Jp
dGVsX3JlbGF4ZWQoY2ZnLT5pYXIsIGFxLT5yZWdzICsgUVNQSV9JQVIpOw0KPj4gKwlpZiAob3At
PmRhdGEuZGlyID09IFNQSV9NRU1fREFUQV9JTikNCj4+ICsJCXdyaXRlbF9yZWxheGVkKGNmZy0+
aWNyLCBhcS0+cmVncyArIFFTUElfUklDUik7DQo+PiArCWVsc2UNCj4+ICsJCXdyaXRlbF9yZWxh
eGVkKGNmZy0+aWNyLCBhcS0+cmVncyArIFFTUElfSUNSKTsNCj4gDQo+IENhbiB5b3UgdXNlIFdJ
Q1IgaGVyZSAoZXZlbiBpZiBJQ1IgPT0gV0lDUik/DQoNCnllcywgZ29vZCBjYXRjaC4NCj4gDQo+
PiArCXdyaXRlbF9yZWxheGVkKGNmZy0+aWZyLCBhcS0+cmVncyArIFFTUElfSUZSKTsNCj4+ICt9
DQo+IA0KPiBIbSwgc28gdGhlIG9ubHkgZGlmZmVyZW5jZSB3ZSBoYXZlIGlzIHRoZSBSSUNSIHZz
IElDUiByZWcgYW5kIHRoZQ0KPiBBUEJURlJUWVBfUkVBRCB2cyBTQU1BNUQyX1dSSVRFX1RSU0ZS
IGJpdC4gTm90IHN1cmUgaXQgZGVzZXJ2ZXMNCj4gY3JlYXRpbmcgMiBob29rcyBmb3IgdGhhdC4g
Q2FuIHdlIGhhdmUgc29tZXRoaW5nIGxpa2UgLT5oYXNfcmljciBpbg0KPiB0aGUgY2FwcyBhbmQg
dGhlbiBoYXZlIGFuIGlmL2Vsc2UgYmxvY2sgZGlyZWN0bHkgaW4NCj4gYXRtZWxfcXNwaV9zZXRf
Y2ZnKCk/DQo+IA0KDQpDb3JyZWN0LiBJdCBpcyBhIGNvc3Qgb2YgYW4gZXh0cmEgaWYsIEkgdHJp
ZWQgdG8gYXZvaWQgaXQuIEkgbGlrZSBpdCBiZXR0ZXIgd2l0aA0KdGhlc2UgdHdvIGhvb2tzLCBi
dXQgaWYgeW91IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBJJ2xsIGRvIGl0LCBqdXN0IGNvbmZpcm0g
aXQgYWdhaW4uDQoNClRoYW5rcywNCnRhDQo=
