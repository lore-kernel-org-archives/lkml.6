Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE934C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B29213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pQd8UkTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfBZGIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:08:50 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:18592
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfBZGIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIWu80M0XyfLHOkzM8/XQY5SVSc7RzWup8paEZJO0Ss=;
 b=pQd8UkTXPHhHCymMi4tOxQmjghQqT2qZd2nXAGN0Lve9waKpXeVjEwq2mWEIylCL81OGiPrF7wUGJfe8ILK0vg4CReDoIf6Tl+JrvHv6owrSeJfJHa0Ch8rBsZ0M6Q+nIpA4vT5ewxTJxhOyIyboCm6hErMqUG7PuQfp+BsOLZU=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2493.eurprd04.prod.outlook.com (10.168.65.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 06:08:42 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 06:08:42 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Peter Rosin <peda@axentia.se>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUzBrGTwclQk5U+0yy4Jt60r8AY6XwmNkAgAEBkIA=
Date:   Tue, 26 Feb 2019 06:08:42 +0000
Message-ID: <VI1PR0401MB24963EE1460E0FF47CDF066CF17B0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190224135143.24770-1-pankaj.bansal@nxp.com>
 <20190224135143.24770-2-pankaj.bansal@nxp.com>
 <ea09336d-465f-aef1-ba7a-c80364a39f90@axentia.se>
In-Reply-To: <ea09336d-465f-aef1-ba7a-c80364a39f90@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b102935e-4a95-415a-65af-08d69bb0dc05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2493;
x-ms-traffictypediagnostic: VI1PR0401MB2493:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDFNQjI0OTM7MjM6VXJlenhsa3RMUEFkMVNxUGIyVkFXYWNF?=
 =?utf-8?B?eWQ4ZDFRdXNwczYvUkFVR0VVZjRCN2JuL3hxOEpFRzR1Tlc3aFBSTmIzMEFV?=
 =?utf-8?B?ZnZZMEVFb3BGSHVLTVBpRlhKaHBHWExEUVJiOGZZWW1GNnJBa2hzNjZYb0d0?=
 =?utf-8?B?S29lL3A4K2Ztc2RoU1BYZmJibnVHM2RDNEx2TnA2L2tuMm5JK0huREZjZXNq?=
 =?utf-8?B?V051YzRFZDBVWG8xT3FseFV6cHRqcW9HUTNyMnFwV3FTT1lpbDlCRmx6aUhv?=
 =?utf-8?B?cER1OEw5UFNDWnhkNEhYdzVuRVpIVFlLZ1ZzZmFGMys2cStGanZOSmhTcG5l?=
 =?utf-8?B?eHdCdm9xU0dkWG5rL3RJbG1NS0M1d2tzY2tjYWhkRTVtUEx2WEtLWjVlSFEz?=
 =?utf-8?B?TG1VMUFIcFVXNTNlVytwZ2FIV3RsditJWVRYT29qNGExemVSb1dEV2VjTi9v?=
 =?utf-8?B?MWlLT056dXJGUXo5WnNkaDhtVlpnNm5nbnJMSEtjamFFeGNlQkZUSGdkakc5?=
 =?utf-8?B?elB4SDV1ZWtvTlE4a3hJdE5WSTE4eUloZEl0bnFUMFBHaUFYbmljN3FvQnAw?=
 =?utf-8?B?K1ltTGFaWXJrU04wNXZrb01TS2grY2tMODZWQU5IdkxEWDlIdmhZQnBPb3hQ?=
 =?utf-8?B?VENPcGphZzk4akdReGV4WXoyRjU3V1ZQYWJJQ1ZkT0VhQjVEaWhXYWxzbHMw?=
 =?utf-8?B?a1BnWVpDSkhwUkh1Y3REMmpTV0o1Nmsrd3dRdGIwVjlFNVJ0WmZZOG9ndEd5?=
 =?utf-8?B?WlR0SzNtQjcrSHl3dk52UE5vVFdST0p0bEdDRm9sUW9TcEY2Z085WVYxd29O?=
 =?utf-8?B?dUZHbDlWYXBra0lOVjNQcG1CNUl3cTFRNjNLUmplQWVZVUdYT3lvN3FjRlR5?=
 =?utf-8?B?MitGdkFiM0h0MHhGeU52VDh4SDFDWGQ3VFJ2SEk2WTR3c2c3NGpnMVBLQTdS?=
 =?utf-8?B?T0JzOTdTbk1FUE16RkRPQVF3Rnlya1Q0R3lNSkVHTmJIZ09YQi9aNE40QXNn?=
 =?utf-8?B?dmtSYVBSQVJveXB6b3IrSDBrSkp3cFBpWXl2TXoyeHoxWi85T2JpNkNJaUhj?=
 =?utf-8?B?VzFlTHc1UTRNOS9PbGFld3FNUkE5d1hxQkNsaWtvbER2WDBGcW5iYjh5bWRz?=
 =?utf-8?B?L2lvOEdpbWpuenhFQ3lSeU1aUmtBNDN4amVyK01JeHFBTm5GT2RBVUlHRDVp?=
 =?utf-8?B?MTZmR1Q0UUZlZ2MyUlZNKzFRMG1IQUZpY3l2S21NaENqSUZteDBVV09GcEtL?=
 =?utf-8?B?NlArTXFMNjhreSs3akJhR1FaMTlTWkl6cXdjcTFSQUlpeXNSc213Uno0RHNV?=
 =?utf-8?B?N3FVMEF2ZkhlTG5xN09JdHBDaTZ2RHo2WTg2aG5uT2JNc3AvaGtYa21PU29O?=
 =?utf-8?B?d3pjRXBpMUVkTDBqM0NPZ0pNZllLZDhibHUvVkRqbkJrSHQrM3Jyb2JPRGY5?=
 =?utf-8?B?QjdtM21UdlRnMlFvd0h3SHhPdmRLTjVaUno2Z3lNTnZOeXFQUEJIWXlSSHZk?=
 =?utf-8?B?SE9EeDZQWlA4ZnNIdlp4WEROYnRldzc5MVVNZ1FOOC9FcUl4RVVKVEZOVytP?=
 =?utf-8?B?bmxINTByNXU1aUVMbzhyRHdsN1daTXExMFZFb0J4cmdJbVJYZEl5eTdBdk1J?=
 =?utf-8?B?eHkzcjRPczN5eFVCVldEQ1lyVEpHQkI0U0xoTS9UaDBHbm43NzdPZEVQdVpm?=
 =?utf-8?B?RE1Ld25kN24yT2dzcjNvMEJKRWNjVWxnT20vMkNEcjIyejFjUGVSL1A2QTFG?=
 =?utf-8?B?S3drNEVQZTFUOWc3NC8xZnFVcno3ekY2RDlSaFNWOS9JR2pSUXUzWTk5N2xi?=
 =?utf-8?Q?qB8NZFXBDBb7JpW?=
x-microsoft-antispam-prvs: <VI1PR0401MB24930D9848117B34DA1815B6F17B0@VI1PR0401MB2493.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(13464003)(189003)(199004)(229853002)(105586002)(106356001)(2906002)(76176011)(53546011)(6506007)(5660300002)(186003)(102836004)(26005)(6306002)(7696005)(6436002)(52536013)(6636002)(14454004)(99286004)(9686003)(55016002)(53936002)(33656002)(97736004)(966005)(74316002)(305945005)(316002)(71190400001)(71200400001)(66066001)(81166006)(3846002)(44832011)(6116002)(86362001)(7736002)(256004)(486006)(110136005)(478600001)(4326008)(476003)(11346002)(25786009)(8936002)(446003)(6246003)(8676002)(68736007)(81156014)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2493;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YEvr4M+7pY7UJYkMSi1BRnCBrTi7xVMJA7tkxjLwBk/ixGsjV2gW2Y35vjYYEY4Y2f3Xgo4MsqFvP6v1NiGBCFgZdtFKwzB5bksp4lKItAjFkWcMDEcSjLryoworRUGVfiN5pC4DjZSDGncaAdHAgpzh6/heRYXjq9r9WkedOQ51fd9vUfb9DAW7ZKRB5SNimt9v8PUejD3TU/zlFR+qM1y5dYKvLv/78BzISt2cCYebdkBGi4WLhEMqDfRhoZd45fwX4KxSy6Vf2tkfXvV8ED6YBA8sasX1QCXPLAq8lpryF0OlI0jnnSlGpPa6Y/Zb75Z4tfZSlDsHoONzUV++5LDclrcSl1Frb7lHZCpnBU2aIbNMHtLRcrovSPErlscx+H8FYJCcTTQKpXxk2kzIcVbwd1JaBIRFVqWFjxVneik=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b102935e-4a95-415a-65af-08d69bb0dc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 06:08:42.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
Um9zaW4gW21haWx0bzpwZWRhQGF4ZW50aWEuc2VdDQo+IFNlbnQ6IE1vbmRheSwgMjUgRmVicnVh
cnksIDIwMTkgMDg6MTQgUE0NCj4gVG86IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxAbnhw
LmNvbT47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gZHJpdmVyczogbXV4
OiBBZGQgR2VuZXJpYyByZWdtYXAgYml0ZmllbGQtYmFzZWQNCj4gbXVsdGlwbGV4ZXIgaW4gbW1p
by1tdXgNCj4gDQo+IE9uIDIwMTktMDItMjQgMDk6MjcsIFBhbmthaiBCYW5zYWwgd3JvdGU6DQo+
ID4gR2VuZXJpYyByZWdpc3RlciBiaXRmaWVsZC1iYXNlZCBtdWx0aXBsZXhlciB0aGF0IGNvbnRy
b2xzIHRoZQ0KPiA+IG11bHRpcGxleGVyIHByb2R1Y2VyIGRlZmluZWQgdW5kZXIgYSBwYXJlbnQg
bm9kZS4NCj4gPiBUaGUgZHJpdmVyIGNvcnJlc3BvbmRpbmcgdG8gcGFyZW50IG5vZGUgcHJvdmlk
ZXMgcmVnaXN0ZXIgcmVhZC93cml0ZQ0KPiA+IGNhcGFiaWxpdGllcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxAbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPg0KPiA+IE5vdGVzOg0KPiA+ICAgICBWMzoNCj4gPiAgICAgLSBBZGRlZCB0aGUgcGF0Y2gg
aW4gc2VyaWVzIHdpdGggZGV2aWNlIHRyZWUgYmluZGluZyBwYXRjaA0KPiA+ICAgICAtIEFkZGVk
IHRoZSBOVUxMIHJldHVybiBoYW5kbGluZyBmb3IgcmVnbWFwDQo+ID4gICAgIFYyOg0KPiA+ICAg
ICAtIHJlbW92ZWQgc2VwZXJhdGUgZHJpdmVyIHJlZ21hcC5jIGFuZCBhZGRlZCB0aGUgcmVnbWFw
IGZ1bmN0aW9uIGluDQo+IG1taW8uYw0KPiA+ICAgICAgIGJhc2VkIG9uIGNvbXBhdGlibGUgZmll
bGQsIHRoZSBzeXNjb24gb3IgcmVnbWFwIGZ1bmN0aW9uIHdvdWxkIGJlIGNhbGxlZA0KPiA+ICAg
ICAtIE1vZGlmaWVkIHRoZSBLQ29uZmlnIGFzIHBlciBQZXRlcidzIGNvbW1lbnRzDQo+ID4NCj4g
PiAgZHJpdmVycy9tdXgvS2NvbmZpZyB8IDEyICsrKysrKy0tLS0tLSAgZHJpdmVycy9tdXgvbW1p
by5jICB8IDEwDQo+ID4gKysrKysrKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dXgvS2NvbmZpZyBiL2RyaXZlcnMvbXV4L0tjb25maWcgaW5kZXgNCj4gPiA3NjU5ZDZjNWY3MTgu
LmU1YzU3MWZkMjMyYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL211eC9LY29uZmlnDQo+ID4g
KysrIGIvZHJpdmVycy9tdXgvS2NvbmZpZw0KPiA+IEBAIC00NiwxNCArNDYsMTQgQEAgY29uZmln
IE1VWF9HUElPDQo+ID4gIAkgIGJlIGNhbGxlZCBtdXgtZ3Bpby4NCj4gPg0KPiA+ICBjb25maWcg
TVVYX01NSU8NCj4gPiAtCXRyaXN0YXRlICJNTUlPIHJlZ2lzdGVyIGJpdGZpZWxkLWNvbnRyb2xs
ZWQgTXVsdGlwbGV4ZXIiDQo+ID4gLQlkZXBlbmRzIG9uIChPRiAmJiBNRkRfU1lTQ09OKSB8fCBD
T01QSUxFX1RFU1QNCj4gPiArCXRyaXN0YXRlICJNTUlPL1JlZ21hcCByZWdpc3RlciBiaXRmaWVs
ZC1jb250cm9sbGVkIE11bHRpcGxleGVyIg0KPiA+ICsJZGVwZW5kcyBvbiBPRiB8fCBDT01QSUxF
X1RFU1QNCj4gPiAgCWhlbHANCj4gPiAtCSAgTU1JTyByZWdpc3RlciBiaXRmaWVsZC1jb250cm9s
bGVkIE11bHRpcGxleGVyIGNvbnRyb2xsZXIuDQo+ID4gKwkgIE1NSU8vUmVnbWFwIHJlZ2lzdGVy
IGJpdGZpZWxkLWNvbnRyb2xsZWQgTXVsdGlwbGV4ZXIgY29udHJvbGxlci4NCj4gPg0KPiA+IC0J
ICBUaGUgZHJpdmVyIGJ1aWxkcyBtdWx0aXBsZXhlciBjb250cm9sbGVycyBmb3IgYml0ZmllbGRz
IGluIGEgc3lzY29uDQo+ID4gLQkgIHJlZ2lzdGVyLiBGb3IgTiBiaXQgd2lkZSBiaXRmaWVsZHMs
IHRoZXJlIHdpbGwgYmUgMl5OIHBvc3NpYmxlDQo+ID4gLQkgIG11bHRpcGxleGVyIHN0YXRlcy4N
Cj4gPiArCSAgVGhlIGRyaXZlciBidWlsZHMgbXVsdGlwbGV4ZXIgY29udHJvbGxlcnMgZm9yIGJp
dGZpZWxkcyBpbiBlaXRoZXINCj4gPiArCSAgYSBzeXNjb24gcmVnaXN0ZXIgb3IgYSBkcml2ZXIg
cmVnbWFwIHJlZ2lzdGVyLiBGb3IgTiBiaXQgd2lkZQ0KPiA+ICsJICBiaXRmaWVsZHMsIHRoZXJl
IHdpbGwgYmUgMl5OIHBvc3NpYmxlIG11bHRpcGxleGVyIHN0YXRlcy4NCj4gPg0KPiA+ICAJICBU
byBjb21waWxlIHRoZSBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZSBtb2R1
bGUgd2lsbA0KPiA+ICAJICBiZSBjYWxsZWQgbXV4LW1taW8uDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXV4L21taW8uYyBiL2RyaXZlcnMvbXV4L21taW8uYyBpbmRleA0KPiA+IDkzNWFjNDRh
YTIwOS4uY2MwMjE1NWU0NjQ0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXV4L21taW8uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbXV4L21taW8uYw0KPiA+IEBAIC0yOCw2ICsyOCw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXV4X2NvbnRyb2xfb3BzIG11eF9tbWlvX29wcyA9IHsNCj4gPg0KPiA+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdXhfbW1pb19kdF9pZHNbXSA9IHsN
Cj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibW1pby1tdXgiLCB9LA0KPiA+ICsJeyAuY29tcGF0aWJs
ZSA9ICJyZWctbXV4IiwgfSwNCj4gPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiA+ICB9Ow0KPiA+
ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdXhfbW1pb19kdF9pZHMpOyBAQCAtNDMsOSArNDQs
MTIgQEANCj4gc3RhdGljDQo+ID4gaW50IG11eF9tbWlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAlpbnQgcmV0Ow0KPiA+ICAJaW50IGk7DQo+ID4NCj4gPiAtCXJl
Z21hcCA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChucC0+cGFyZW50KTsNCj4gPiAtCWlmIChJU19F
UlIocmVnbWFwKSkgew0KPiA+IC0JCXJldCA9IFBUUl9FUlIocmVnbWFwKTsNCj4gPiArCWlmIChv
Zl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgIm1taW8tbXV4IikpDQo+ID4gKwkJcmVnbWFwID0g
c3lzY29uX25vZGVfdG9fcmVnbWFwKG5wLT5wYXJlbnQpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJl
Z21hcCA9IGRldl9nZXRfcmVnbWFwKGRldi0+cGFyZW50LCBOVUxMKTsNCj4gPiArCWlmIChJU19F
UlJfT1JfTlVMTChyZWdtYXApKSB7DQo+ID4gKwkJcmV0ID0gUFRSX0VSUl9PUl9aRVJPKHJlZ21h
cCkgPyBQVFJfRVJSKHJlZ21hcCkgOiAtDQo+IEVOT0RFVjsNCj4gDQo+IFRoZSBhYm92ZSBpcyBu
b3QgY29ycmVjdCwgdGhpcyBzaG91bGQgYmUgYmV0dGVyICh1bnRlc3RlZCk6DQo+IA0KPiAJCXJl
dCA9IFBUUl9FUlIocmVnbWFwKSA/OiAtRU5PREVWOw0KDQpPbWl0dGluZyB0aGUgc2Vjb25kIG9w
ZXJhbmQgaW4gdGVybmFyeSBvcGVyYXRvciBpcyBub3Qgc3RhbmRhcmQuIGh0dHBzOi8vc3RhY2tv
dmVyZmxvdy5jb20vcXVlc3Rpb25zLzM0NTU5NzA1L3Rlcm5hcnktb3BlcmF0b3Itd2l0aG91dC10
aGUtbWlkZGxlLWV4cHJlc3Npb24NCg0KQWx0aG91Z2gsIGl0ICpoYXMgYmVlbiogdXNlZCBpbiBr
ZXJuZWwgaW4gbWFueSBwbGFjZXMNCmh0dHBzOi8vbGl2ZWdyZXAuY29tL3NlYXJjaC9saW51eD9x
PWZpbGUlM0ElNUMuYyUyNCUyMCU1QyUzRiU1QyUzQSZmb2xkX2Nhc2U9YXV0byZyZWdleD10cnVl
JmNvbnRleHQ9dHJ1ZQ0KDQoNCj4gDQo+IENoZWVycywNCj4gUGV0ZXINCj4gDQo+ID4gIAkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IHJlZ21hcDogJWRcbiIsIHJldCk7DQo+ID4gIAkJcmV0
dXJuIHJldDsNCj4gPiAgCX0NCj4gPg0KDQo=
