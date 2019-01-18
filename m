Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7179A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JRB2d0z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfARCTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:19:07 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:25863
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfARCTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wttMYe+e8eJwLtqPgAPcvBBMRtYf9ag/S1tdJqnf+uY=;
 b=JRB2d0z/wTxzu6vHCMyZdBnRHDieeBT3l/k223s4yug5w6SEdNnYK3WsrhHqfmsDVw7CcJWH5JAYQ6CFNwCPFYZWHldWuCLvfdHR8XdfVdS1S/GGLzj7AfNRwqpDhB9qU5m7l1NFqlRnPPQlvTojGPXV5Q85dw4pTQ52QLCucHI=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB2095.eurprd04.prod.outlook.com (10.166.43.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Fri, 18 Jan 2019 02:19:00 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::482:b606:281d:ebf5]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::482:b606:281d:ebf5%4]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 02:19:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle first
Thread-Topic: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Index: AQHUrYPo518BHyRfCUSvmK4xVZBUOKWxuH4AgAArxACAAAPqgIAACqsAgADD+UCAAPQ3gIAAoTYg
Date:   Fri, 18 Jan 2019 02:18:59 +0000
Message-ID: <VI1PR04MB5327613BC3BE3F579017E6EE8B9C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190116101051.21202-1-paul.kocialkowski@bootlin.com>
         <20190116115350.3daa9b4f@windsurf>
         <554a5b4f463df6551846cfdc3b043d3f1d99381f.camel@bootlin.com>
         <20190116144429.7df1d0c5@windsurf>
         <b42e37ab06ae3efa244a35df801e2126fd692bb7.camel@bootlin.com>
         <VI1PR04MB5327030D855A1FEBC9BC9E638B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <1f8dcb9848a2da0eb87a0227913033d299d4e4a9.camel@bootlin.com>
In-Reply-To: <1f8dcb9848a2da0eb87a0227913033d299d4e4a9.camel@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB2095;6:B3ZUnWxqOyOSvJKw+bsTq25A248WArtbJbU50rrQXv1+JxMVCBJ9te8Rvvc8zwB00BFgO3u88oodABQTpXNMAtQx4LnrUYJ8639wNcuqe0o3yFjrICpzbFdS9y6pq+cfnnoEwbv9RYS/1rBl6lqWDsScygBmlKSNI75/3EZMjiNHfiM7CcGi7jzSLGIT/aQyu170544ARLxvMRpW5IRzWGf8abWjEb1dJLflENgvDJEe2P1XHtBYsJgCSXoCtbj7y/ijgIrrpc8qfQEFgKAFbQq/drCRkKO/+KwIMKy2xyjwpOYtaXGi6Pu1g6xXHNyfDdlosN8pRbjjJjizyL/1qtEggqZn1TcSW8lnsmI0mvgUX2dNoh0nMuZ7VyWZ9Vgx5A0E1xcvxwGfFv0tjRBd8M/+46XHFIJG+2ad4cbIFArOZNE0Zduxvp3yN4jh212L/UneWjXbEVzALLLwoOJYFg==;5:qA2BgDsdQLXE4kkGsR+XzTTj/jQBzfAgeQIIQn5Y48gp49LR32VMk3HsGh2Wz32dx4W97uVdi6LCam7fH4JTq7dM1sbDCPVHxG3KVPQxPu5wVyaHW6owpaZpqXIzVNORyTTGk8SoZjcKT+KFn9LwLfI3h//4k8/KTxkeaT6aceyG9hIxwcGwMrtgL/HxXY5qR2nslqb7aJIzsUGOuLcrcg==;7:exCuPCHXWC+AXFG/6LqS8v/KLDuWKZPkbjIJS4qQM5ShNKBYoIzfIC9gg1No2NLJRu78zWCijOAPF2jPy8gHMxN7bPKlp9wd5gUctiFGAjqvUczTkSwWeK1P9W/MTtfA1QzhLNvfXAPDCeOs7W1qkw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b9673d2f-a736-4f12-aee1-08d67ceb4f51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2095;
x-ms-traffictypediagnostic: VI1PR04MB2095:
x-microsoft-antispam-prvs: <VI1PR04MB2095085BCF9541424D00B3928B9C0@VI1PR04MB2095.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(97736004)(486006)(53936002)(71190400001)(71200400001)(217873002)(99286004)(7696005)(305945005)(7736002)(4326008)(74316002)(68736007)(25786009)(81156014)(81166006)(8676002)(76176011)(8936002)(6306002)(9686003)(45080400002)(66066001)(93886005)(186003)(105586002)(6346003)(478600001)(2906002)(3846002)(5660300001)(6116002)(14454004)(966005)(26005)(229853002)(6506007)(55016002)(446003)(110136005)(6246003)(256004)(33656002)(6436002)(11346002)(86362001)(102836004)(44832011)(316002)(106356001)(54906003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2095;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /nsfd+GVdUCtOLkGxuVkGjLEBgqXN1M7d84NzNyfYyxCzRMIlPv9JBG+Hsgw+OdDB1yiM3SBu7kZ/NHZ2eINxugmZeJvdfTEoinaWLD7/zu/U0XNDyCyx92n1M5pSBZpLa68jgtEhX1aEHBpr3sjawcYW00p89p6meDx9FhrVv33I0+GBtgCVhy7JytNVnyNMwZi4mCTXCFr9Lt4e3aqUcnTRxfQDzFj8BK3ZjZ3WSIDBCYl1KRwpcRkC5vea/Av/M1xl+zoMxUzuXvxlbjLpuim+Pkhknx8wB7IhFfOU46+k+nahaywvDM9G24wfi8f8xBcc/czDOpgSVuNp3MUr6L5rlU7WEOd1TvsZSWm7HcMq90ZQQoPEWgb17GsnOgUrCdGq9qO5SfBz0zZcZxd8wUEWcTxSbhFrK9xPu4lO8Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9673d2f-a736-4f12-aee1-08d67ceb4f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 02:19:00.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiBUaHUsIDIwMTktMDEtMTcgYXQgMDY6NDQgKzAwMDAsIFBldGVyIENoZW4gd3JvdGU6
DQo+ID4NCj4gPiA+IE9uIFdlZCwgMjAxOS0wMS0xNiBhdCAxNDo0NCArMDEwMCwgVGhvbWFzIFBl
dGF6em9uaSB3cm90ZToNCj4gPiA+ID4gV2VsbCBwcmlvciB0byB5b3VyIGNvZGUsIHRoZXJlIHdh
cyBhbHJlYWR5IGEgcG9zc2liaWxpdHkgZm9yIGJvdGgNCj4gPiA+ID4gY2ktPnBoeSBhbmQgY2kt
PnVzYl9waHkgdG8gYmUgdmFsaWQuIEkgZG9uJ3QgdGhpbmsgaXQncyByZWFsbHkNCj4gPiA+ID4g
Y2ktPnVzZWZ1bA0KPiA+ID4gPiB0byBhdm9pZCB0aGUgZmFsbGJhY2sgd2hlbiBhIGdlbmVyaWMg
UEhZIGhhcyBhbHJlYWR5IGJlZW4gZm91bmQsDQo+ID4gPiA+IGl0J3MgY29uZnVzaW5nLiBJZiBy
ZWFsbHkgeW91IHdhbnQgdG8gY2xhcmlmeSB0aGF0LCBpdCBzaG91bGQgYmU6DQo+ID4gPiA+DQo+
ID4gPiA+IAkvKiBMZXQncyBmaXJzdCB0cnkgdG8gZmluZCBhIGdlbmVyaWMgUEhZICovDQo+ID4g
PiA+IAljaS0+cGh5ID0gZGV2bV9waHlfZ2V0KGRldi0+cGFyZW50LCAidXNiLXBoeSIpOw0KPiA+
ID4gPiAJaWYgKElTX0VSUihjaS0+cGh5KSkgew0KPiA+DQo+ID4gUGxlYXNlIGNvbnNpZGVyIC1F
UFJPQkVfREVGRVIgY2FzZQ0KPiA+DQo+ID4gPiA+IAkJLyogRmFsbCBiYWNrIHRvIGxlZ2FjeSBV
U0IgUEhZICovDQo+ID4gPiA+IAkJY2ktPnVzYl9waHkgPSBkZXZtX3VzYl9nZXRfcGh5X2J5X3Bo
YW5kbGUoZGV2LT5wYXJlbnQsICJwaHlzIiwNCj4gPiA+IDApOw0KPiA+DQo+ID4gUGxlYXNlIGNv
bnNpZGVyIC1FUFJPQkVfREVGRVIgY2FzZQ0KPiA+DQo+ID4gPiA+IAkJaWYgKElTX0VSUihjaS0+
dXNiX3BoeSkpDQo+ID4gPiA+IAkJCWNpLT51c2JfcGh5ID0gZGV2bV91c2JfZ2V0X3BoeShkZXYt
PnBhcmVudCwNCj4gPiA+IFVTQl9QSFlfVFlQRV9VU0IyKTsNCj4gPiA+ID4gCX0NCj4gPiA+ID4N
Cj4gPg0KPiA+IEJlbG93IGNvZGUNCj4gPiAgICAgICAgICAgICAgICAgaWYgKElTX0VSUihjaS0+
cGh5KSAmJiBJU19FUlIoY2ktPnVzYl9waHkpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0ID0gLUVQUk9CRV9ERUZFUjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IHVscGlfZXhpdDsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gbmVlZHMgdG8gY2hh
bmdlIGFzOg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIGlmIChQVFJfRVJSKGNpLT5waHkpID09
LUVQUk9CRV9ERUZFUiAgfHwgIFBUUl9FUlIoY2ktPnVzYl9waHkpDQo+ID09IC1FUFJPQkVfREVG
RVIpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRVBST0JFX0RFRkVSOw0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdWxwaV9leGl0Ow0KPiA+ICAgICAgICAg
ICAgICAgICB9DQo+IA0KPiBXZWxsIEkgdGhpbmsgdGhpcyB3YXMgbW9yZSBvZiBhIGdlbmVyYWwg
b3V0bGluZSB0aGFuIHByb3BlciBjb2RlIHRvIGJlIGluY2x1ZGVkIGluDQo+IHRoZSBkcml2ZXIg
YW55d2F5IDopDQo+IA0KPiBJJ20gcmF0aGVyIGNvbnNpZGVyaW5nIGltcGxlbWVudGluZyB3aGF0
IFRob21hcyBzdWdnZXN0ZWQgYXQgZmlyc3QsIHdoaWNoIGlzIGdvaW5nDQo+IGZvciB0aGUgZmFs
bGJhY2sgZXZlbiBpZiBhIGdlbmVyaWMgUEhZIHdhcyBmb3VuZCwgYXMgdG8gc3RpY2sgbW9yZSBj
bG9zZWx5IHRvIHRoZQ0KPiBleGlzdGluZyBiZWhhdmlvci4NCj4gDQoNClNpbmNlIG9uZSBVU0Iy
IGNvbnRyb2xsZXIgaXMgaW1wb3NzaWJsZSBoYXMgdHdvIFVTQiBQSFlzLCBpZiBib3RoIFBIWXMg
KGdlbmVyaWMgUEhZDQphbmQgVVNCIFBIWSkgYXJlIGZvdW5kLCB0aGVyZSBtdXN0IGJlIGVycm9y
IGF0IGNvZGUgb3IgZHRzLiBCZXNpZGVzLCAtRVBST0JFX0RFRkVSDQppcyBub3QgYW4gcmVhbCBl
cnJvciwgaXQgbWVhbnMgdGhlIFBIWShVU0ItUEhZKSBpcyBleGlzdGVkLCBqdXN0IG5vdCBiZSBy
ZWFkeS4NCg0KUGV0ZXINCg0KPiBDaGVlcnMsDQo+IA0KPiBQYXVsDQo+IA0KPiA+IFBldGVyDQo+
ID4NCj4gPiA+ID4gV2l0aCB0aGF0LCB5b3Ugd291bGQgb25seSBoYXZlIGVpdGhlciBjaS0+cGh5
IG9yIGNpLT51c2JfcGh5IGJlDQo+ID4gPiA+IHZhbGlkLCBhbmQgbmV2ZXIgYm90aC4gV2l0aCAg
eW91ciBjaGFuZ2UsIHlvdSBjYW4gaGF2ZSBjaS0+cGh5IGFuZA0KPiA+ID4gPiBjaS0+dXNiX3Bo
eSBib3RoIGJlIHZhbGlkIGlmIHRoZSBsZWdhY3kgVVNCIFBIWSB3YXMgZm91bmQgdXNpbmcNCj4g
PiA+ID4gZGV2bV91c2JfZ2V0X3BoeV9ieV9waGFuZGxlKCksIGJ1dCBub3QgaWYgd2UgZmVsbCBi
YWNrIHRvDQo+ID4gPiA+IGRldm1fdXNiX2dldF9waHkoKS4NCj4gPiA+DQo+ID4gPiBPa2F5IHRo
YXQgbWFrZXMgc2Vuc2UsIHlvdXIgc3VnZ2VzdGlvbiBpcyBpbmRlZWQgbW9yZSBjb25zaXN0ZW50
DQo+ID4gPiB3aXRoIHRoZSBleGlzdGluZyBiZWhhdmlvci4gSSdsbCBnbyB3aXRoIHRoYXQgaW4g
dGhlIG5leHQgcmV2aXNpb24hDQo+ID4gPg0KPiA+DQo+ID4NCj4gLS0NCj4gUGF1bCBLb2NpYWxr
b3dza2ksIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIGtlcm5lbCBlbmdpbmVlcmluZw0K
PiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGYm9vdGxpbi5jb20NCj4gJmFtcDtkYXRhPTAyJTdDMDElN0NwZXRlci5jaGVu
JTQwbnhwLmNvbSU3QzMwMzAyYTFjMGI0MTQ5NjVhZjI2MDhkDQo+IDY3YzlhMzBmNiU3QzY4NmVh
MWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY4MzMzOTkwDQo+IDIxMTgy
NDIwJmFtcDtzZGF0YT1sRDdrdCUyRiUyRm1VV3A3RmZMRDlpTWx4amZ2UzRlZGl2NHVBJTJCRm9y
YkRTVw0KPiBrRSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQo=
