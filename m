Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40319C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060E420989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qE8Cja9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfA2O1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:27:54 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3014 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA2O1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:27:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="25895027"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 29 Jan 2019 07:27:52 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 29 Jan 2019 07:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXLTfSCgOxTz49TvZec9yUEqMqoI2GobRAnzLlalWMA=;
 b=qE8Cja9LQG+SlkRysDe3guGmbaiMiTwxMCFa25E6/wT1tkR8dloaUDPSMaNhbh6aFdCqCWpoq/CKlLIjIXxgm3IkKoR/OWr53Zl2wwN6A7CfzVQC7lbBpCr2tuXRkbzD292JNfPubqzjxam3w1+i0AFtXGdOmiQWTRQDrmBhzko=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1693.namprd11.prod.outlook.com (10.169.231.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 14:27:50 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 14:27:50 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <jonas@norrbonn.se>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v4 2/2] spi-atmel: support inter-word delay
Thread-Topic: [PATCH v4 2/2] spi-atmel: support inter-word delay
Thread-Index: AQHUt97QlH7O0YtX50uZ4B6TyEb/dg==
Date:   Tue, 29 Jan 2019 14:27:50 +0000
Message-ID: <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-3-jonas@norrbonn.se>
In-Reply-To: <20190129083844.20572-3-jonas@norrbonn.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::29) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1693;6:C+PlLJxqVxrNu5q9yz9A/JSaBnHh0ykdsuQwHaipWsn7tOxl5iNCUd33uNSAROqrjgClZnj6CZuaXlyAw8KQNN/PL1N5070ZMJd7M8AXXvBWjVCa5gF0/NJh21W/XMDe1A8mh3LA54rb1gBab8OnC0mTPa2rCstdndFNaqRJmEnsEtfKozTQy+/KWxi0WS8MQxE1noVrp/dHN4vXhPvZJjU4EYzh7v8jVDXdI9ZPaL/GKSvsQgSXEJwqXWOW+G/+ZbbEKKDKJyBgQ2B7prxz5azX4n964TMtg/ytFk9vwZ3Yg3sYIzNuDiHtiojEjS67Ur75ep7uWlpu0bl7T+47Y69wDrIBaNY5AuzQvMgXg9siP3yp/jDd5quC6UXtndblVzGzID7qvTUOqPWuu0W7gRU248hSweqz7MRXUOnHpuvE2LTdhGKvHdZtMU4L4F0dLy240l1cLNdoR/EPrd2kiw==;5:WdZEX0drYahv1HV8bY5rPlnJCwZl4E1THPJefwCtPzbeGE8erE24fwsoDcuNB6xknxu/UdUhBTXa0igoRB5OlfhUZ56DKn7xoTnKvjbv/3+Hn6aluU6B3Q6JyGbEVMFL1TlN7wTq1NwQY4GmqyhDQcv7mf48jjW3Z2CcvKHB/aplSkFdVEzAYctG8+Dw5Zwxv9TRN4aCJO1VgCALpAS5IQ==;7:6+6fwpHbPOPQa9R9QEpre+PYwLYv7mbaQRcHI1rVO8YMInHjyXHeSQgyuGlVZo1BZZivZrHx2wN1jxEAK2vvzDWyTBWYXDWORQnQyWndHsFacfZFluu/I9ffaxx6h4isvsQRaOffq3WdZ/HGSI72zA==
x-ms-office365-filtering-correlation-id: 6ce775d6-45ab-4d89-0086-08d685f5f299
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1693;
x-ms-traffictypediagnostic: MWHPR11MB1693:
x-microsoft-antispam-prvs: <MWHPR11MB169316417E72DD7609B917A0E0970@MWHPR11MB1693.namprd11.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(53936002)(476003)(486006)(97736004)(446003)(31686004)(2616005)(11346002)(105586002)(31696002)(71200400001)(26005)(186003)(4326008)(86362001)(6486002)(81156014)(71190400001)(6246003)(107886003)(81166006)(106356001)(8676002)(6436002)(8936002)(36756003)(66066001)(25786009)(256004)(52116002)(2501003)(76176011)(386003)(6506007)(68736007)(6512007)(99286004)(14454004)(316002)(7736002)(53546011)(6116002)(478600001)(305945005)(110136005)(54906003)(229853002)(3846002)(102836004)(2906002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1693;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZkbNVIYS1tG4nK3Vm8t2Tk/b0aBbq9rG7y65cB+oyGim2zcp36pijDVzWW3lpohviAkUBO42f35DyDpltQ0YPeycD/V2rWcCPaaaV+Xg+9zgt02Lz8hx+aRh4KWlbGbFg4MyZZKeuir0DUo00YpwMlfXo7PqnWN3osPpaes97rihi+HjKyQoRCo6tSyTVG+xYjSUFBI3UOXi52UzLyEYDWm9K8uqG+kvV8Zd9wGUzhNMK9h3w3tDDjOBb8bB91ZCjEaePhZYu0QFmkhHhWc5b7apCFOQbZvYSwzo8fUh8I233CNQByk8J3sJ+ix/36FQzE/+P8CBqMdDtgaoR4MbtK3QgZ5+L4D5MIzJZtBexCOLqP0WK8Y0uziv9JR/fZ2hX1VbvR9QMX9QdKqwMW+dspUquGra00cJzQme0WcSRqg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F49B008FA53E043A2C06EAF1D5FC410@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce775d6-45ab-4d89-0086-08d685f5f299
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 14:27:47.7161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1693
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDEvMjAxOSBhdCAwOTozOCwgSm9uYXMgQm9ubiB3cm90ZToNCj4gSWYgdGhlIFNQSSBz
bGF2ZSByZXF1aXJlcyBhbiBpbnRlci13b3JkIGRlbGF5LCBjb25maWd1cmUgdGhlIERMWUJDVA0K
PiByZWdpc3RlciBhY2NvcmRpbmdseS4NCj4gDQo+IFRlc3RlZCBvbiBhIFNBTUE1RDIgYm9hcmQg
KGRlcml2ZWQgZnJvbSBTQU1BNUQyLVhwbGFpbmVkIHJlZmVyZW5jZQ0KPiBib2FyZCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKb25hcyBCb25uIDxqb25hc0Bub3JyYm9ubi5zZT4NCj4gQ0M6IE5p
Y29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4gQ0M6IE1hcmsgQnJv
d24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ0M6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5k
cmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gQ0M6IEx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmlj
LmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KPiBDQzogbGludXgtc3BpQHZnZXIua2VybmVsLm9y
Zw0KPiBDQzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IC0tLQ0KPiAg
IGRyaXZlcnMvc3BpL3NwaS1hdG1lbC5jIHwgMTggKysrKysrKysrKysrKy0tLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMgYi9kcml2ZXJzL3NwaS9zcGktYXRtZWwu
Yw0KPiBpbmRleCA3NGZkZGNkMzI4MmIuLjYzODlhMjI4ZDJmNSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4g
QEAgLTEyMDksMTMgKzEyMDksMjEgQEAgc3RhdGljIGludCBhdG1lbF9zcGlfc2V0dXAoc3RydWN0
IHNwaV9kZXZpY2UgKnNwaSkNCj4gICAJCWNzciB8PSBTUElfQklUKENTQUFUKTsNCj4gICANCj4g
ICAJLyogRExZQlMgaXMgbW9zdGx5IGlycmVsZXZhbnQgc2luY2Ugd2UgbWFuYWdlIGNoaXBzZWxl
Y3QgdXNpbmcgR1BJT3MuDQo+IC0JICoNCj4gLQkgKiBETFlCQ1Qgd291bGQgYWRkIGRlbGF5cyBi
ZXR3ZWVuIHdvcmRzLCBzbG93aW5nIGRvd24gdHJhbnNmZXJzLg0KPiAtCSAqIEl0IGNvdWxkIHBv
dGVudGlhbGx5IGJlIHVzZWZ1bCB0byBjb3BlIHdpdGggRE1BIGJvdHRsZW5lY2tzLCBidXQNCj4g
LQkgKiBpbiB0aG9zZSBjYXNlcyBpdCdzIHByb2JhYmx5IGJlc3QgdG8ganVzdCB1c2UgYSBsb3dl
ciBiaXRyYXRlLg0KPiAgIAkgKi8NCj4gICAJY3NyIHw9IFNQSV9CRihETFlCUywgMCk7DQo+IC0J
Y3NyIHw9IFNQSV9CRihETFlCQ1QsIDApOw0KPiArDQo+ICsJLyogRExZQkNUIGFkZHMgZGVsYXlz
IGJldHdlZW4gd29yZHMuICBUaGlzIGlzIHVzZWZ1bCBmb3Igc2xvdyBkZXZpY2VzDQo+ICsJICog
dGhhdCBuZWVkIGEgYml0IG9mIHRpbWUgdG8gc2V0dXAgdGhlIG5leHQgdHJhbnNmZXIuDQo+ICsJ
ICovDQo+ICsJaWYgKHNwaS0+d29yZF9kZWxheV91cykgew0KDQpXZWxsLi4uDQoNCj4gKwkJY3Ny
IHw9IFNQSV9CRihETFlCQ1QsDQo+ICsJCQljbGFtcF90KHU4LA0KPiArCQkJCShhcy0+c3BpX2Ns
ay8xMDAwMDAwKnNwaS0+d29yZF9kZWxheV91cyk+PjUsDQo+ICsJCQkJMSwgMjU1KSk7DQoNCi4u
LiB3aHkgbm90IHNpbXBsaWZ5aW5nIHRvOg0KKwkJCQkwLCAyNTUpKTsNCmFuZCByZW1vdmUgdGhl
IHRlc3QgYWx0b2dldGhlciwgYWZ0ZXIgYWxsPw0KDQo+ICsJfSBlbHNlIHsNCj4gKwkJY3NyIHw9
IFNQSV9CRihETFlCQ1QsIDApOw0KPiArCX0NCj4gKw0KPiAgIA0KPiAgIAkvKiBjaGlwc2VsZWN0
IG11c3QgaGF2ZSBiZWVuIG11eGVkIGFzIEdQSU8gKGUuZy4gaW4gYm9hcmQgc2V0dXApICovDQo+
ICAgCW5wY3NfcGluID0gKHVuc2lnbmVkIGxvbmcpc3BpLT5jb250cm9sbGVyX2RhdGE7DQo+IA0K
DQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
