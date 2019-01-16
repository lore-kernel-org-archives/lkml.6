Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FDBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDF820657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="Xqg0qX9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394067AbfAPQlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:41:22 -0500
Received: from mail-eopbgr680137.outbound.protection.outlook.com ([40.107.68.137]:48655
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfAPQlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhPx34U/RuBQqtU0XNnsGtED8h+qHJLqtoI9grELGOI=;
 b=Xqg0qX9X4J5pfsQZfjy1zc/P0ECcSkdEuBnwXgddkU6DDcoZ1gvxCyx/h/v7rB6PT1XARA8IdbVsV13QXTKCvMXQXsolI0UCXL0i+U0TEu1ly6iMJlfisWxiTbvFTUSh1EYEhgTX+JKsWtlNAxQifQLb/BsA6hZHtM+yCo9cXik=
Received: from DM6PR02MB5978.namprd02.prod.outlook.com (20.179.69.142) by
 DM6PR02MB4396.namprd02.prod.outlook.com (20.176.105.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Wed, 16 Jan 2019 16:41:14 +0000
Received: from DM6PR02MB5978.namprd02.prod.outlook.com
 ([fe80::443d:c354:514a:a682]) by DM6PR02MB5978.namprd02.prod.outlook.com
 ([fe80::443d:c354:514a:a682%4]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 16:41:14 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>
CC:     "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH lora-next 1/4] dt-bindings: lora: sx130x: add basic
 documentation
Thread-Topic: [PATCH lora-next 1/4] dt-bindings: lora: sx130x: add basic
 documentation
Thread-Index: AQHUpy4SFKuEJhtnEEusbRzGn58PjqWrAdQAgAcQ9CA=
Date:   Wed, 16 Jan 2019 16:41:14 +0000
Message-ID: <DM6PR02MB597816191903B0D13262EE99E7820@DM6PR02MB5978.namprd02.prod.outlook.com>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
 <3a998d80-1ebd-3105-6517-69e78a04f1bf@suse.de>
In-Reply-To: <3a998d80-1ebd-3105-6517-69e78a04f1bf@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4396;6:ztAESEdbxl2S+zjlXgKG+xj8VZNEYoegX3WH6xQ2K9HIrJy7Mb7GjdCkHK5yqzyxmwQ0fVDW+CR66gFCvimkiQbS0M7lNunjDu/uDZigB3sF0jIjyzGf41dmSulbzVpsmMEf+0ZXafPlxvaH9A7lCvsKA8PHSjn7XzprNb9dYVYkpTn+ELesKhC2dWF9t1KNjbV1uO2Mkfu5KN1m1mpjaS+vPNFvQu7fqD33Oy2zy5O0yr9fRR5kCg4u798WpxE/G2EvI+8SxYD/FIoqZeVU5ni8HKvRa6g94vwWjsvFrl5/WHGJjhJZvC9yhI9M7SUppksuehR8MZZf50VzcrIqdDkee/W+6bIRiKTWS6tPn7gq40g2hhPu55UBq/pMfvsupK8aNXGqyvv1pqbUX8a8pPYFKLlm8ICuIb5fO9/wLaHvrYcx2ZuklisXPhTThbHGnt4+jKEUqi8D8pyquOTVWg==;5:ob5BamCbFSIHKNpIX9E4SsCereNH6FOo8xf/VsLWKxGf/+jguoE+aR5W61i2iMYpAL4vHvQ/N8dTHqGuTLuaH3GjPLOdzk1m2JNJ0geMHauHxEtgizMPsBVGX9VE1B8jv4wwcUGRCillMMZ6Q1nv4XN9Da1NDWbefXV/3CwRqMqctj2iqM7C0lH2bD4ETMTyMyNBVnBa6PjmhvMVD1/XWQ==;7:pgb95b8nSVEXGkpdYRCuNCkM9hXMG6bODCyjW9dRugOMixxZ61QZ3ISJOtbgFCH2CD9e9xwCfKwbHGTse4v6N+nB9gEfePz+XjrH7khbB4cXb5FaX8IjPKGtbtiS0V4YAMPTxD8dVEfZ4Q0bJJ3R3g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b217facc-5af0-4b5f-2e22-08d67bd16e23
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4396;
x-ms-traffictypediagnostic: DM6PR02MB4396:
x-microsoft-antispam-prvs: <DM6PR02MB4396DFD3E25F3758877B28D6E7820@DM6PR02MB4396.namprd02.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(74316002)(476003)(6436002)(81156014)(8676002)(53376002)(6306002)(4326008)(99286004)(5660300001)(53936002)(25786009)(6246003)(39060400002)(71190400001)(186003)(71200400001)(305945005)(55016002)(105586002)(106356001)(7696005)(9686003)(76176011)(8936002)(102836004)(11346002)(81166006)(446003)(316002)(33656002)(7736002)(54906003)(110136005)(256004)(6506007)(26005)(14444005)(14454004)(3846002)(6116002)(2906002)(68736007)(478600001)(86362001)(229853002)(97736004)(66066001)(72206003)(66574012)(486006)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR02MB4396;H:DM6PR02MB5978.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yzwq1ZLA9ag1/Ux/J3Qh9uwNBjwt4O5Sm65wRhFOo7kzpefh7vWIoqxCSSEaV9YJB+wBIoYgt5GE4YZ/47je4GaBPSpfALDiHtGdG48WvJgczH978wi4VKfTsr0FjibNNNu2I3OUPhenwAVR+wPqota8rduh/618D1og+VE7rBEQUbSa1k0wxZE4TnYrNEbIIw5ZGOcoKwUNnB4/MtrYM4HNrWOaxLmGruj4ITGErgRoUsJSq/r52akDJLYJR+NimwDqMOs/cvOAPhjS8Fogn2ldJoeK+/lnQIqkJJu7AwvMJCnbJnXpLeVOZgDQPV6p4P/84y9xEVU7yb8SDaJzwjZP+OwdkENTAB3p2OtU71u7azhU0tpTMzCycQ5a8rCPamBydQQur4fT1jHsGwgZdaFVwVmufL81khP34jDmreI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b217facc-5af0-4b5f-2e22-08d67bd16e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 16:41:14.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiBBbSAwOC4wMS4xOSB1bSAwOTo0MSBzY2hyaWViIEJlbiBXaGl0dGVu
Og0KPiA+IEFkZCBiYXNpYyBkb2N1bWVudGF0aW9uIGluIFlBTUwgZm9ybWF0IGZvciB0aGUgc3gx
MzB4IHNlcmllcyBjb25jZW50cmF0b3JzDQo+ID4gZnJvbSBTZW10ZWNoLg0KPiA+IFJlcXVpcmVk
IGlzOyB0aGUgbG9jYXRpb24gb24gdGhlIFNQSSBidXMsIHRoZSByZXNldCBncGlvIGFuZCB0aGUg
bm9kZSBmb3INCj4gPiBkb3duc3RyZWFtIElRIHJhZGlvcywgdHlwaWNhbGx5IHN4MTI1eC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlbiBXaGl0dGVuIDxiZW4ud2hpdHRlbkBnbWFpbC5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9sb3JhL3NlbXRlY2gsc3gxMzB4LnlhbWwgICAg
ICAgICB8IDg3ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDg3IGlu
c2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9sb3JhL3NlbXRlY2gsc3gxMzB4LnlhbWwNCj4gDQo+IFBhdGNoIDMv
NCBtb3ZlcyB0aGlzIHRvIG5ldC9sb3JhLywgd2hpY2ggSSB0aGluayBpcyBtb3JlIGFwcHJvcHJp
YXRlLg0KDQpBZ3JlZWQsIEkgdGhpbmsgaXQgd2FzIGEgY2hhbmdlIG1lcmdlZCBpbnRvIHRoZSB3
cm9uZyBjb21taXRzIGJ5IG1pc3Rha2UNCg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9sb3JhL3NlbXRlY2gsc3gxMzB4LnlhbWwNCj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbG9yYS9zZW10ZWNoLHN4MTMweC55YW1s
DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmFkMjYz
YmM0ZTYwZA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbG9yYS9zZW10ZWNoLHN4MTMweC55YW1sDQo+ID4gQEAgLTAsMCArMSw4
NyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKyVZQU1M
IDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9s
b3JhL3NlbXRlY2gsc3gxMzB4LnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFNlbXRlY2gg
TG9SYSBjb25jZW50cmF0b3INCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQW5k
cmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KPiA+ICsgIC0gQmVuIFdoaXR0ZW4gPGJl
bi53aGl0dGVuQGdtYWlsLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAg
U2VtdGVjaCBMb1JhIGNvbmNlbnRyYXRvciBzeDEzMHggZGlnaXRhbCBiYXNlYmFuZCBjaGlwIGlz
IGNhcGFibGUgb2YNCj4gDQo+IFNYMTMweCBvciBTWDEzMDEvU1gxMzA4LCB0byBkaXN0aW5ndWlz
aCBmcm9tIGRyaXZlciBuYW1lIHN4MTMweCBhbmQgdG8NCj4gYXZvaWQgYW1iaWd1aXRpZXMgb2Yg
d2hpY2ggeCBpcyBhIHdpbGRjYXJkLg0KPiANCj4gPiArICBkZW1vZHVsYXRpbmcgTG9SYSBzaWdu
YWxzIG9uIDggY2hhbm5lbHMgc2ltdWx0YW5lb3VzbHkuDQo+ID4gKw0KPiA+ICsgIEl0IGlzIHR5
cGljYWxseSBwYWlyZWQgd2l0aCB0d28gc3gxMjV4IElRIHJhZGlvcyBjb250cm9sbGVkIG92ZXIg
YW4NCj4gDQo+IERpdHRvLCBTWDEyNXgNCj4gDQo+ID4gKyAgU1BJIGRpcmVjdGx5IGZyb20gdGhl
IGNvbmNlbnRyYXRvci4NCj4gPiArDQo+ID4gKyAgVGhlIGNvbmNlbnRyYXRvciBpdHNlbGYgaXQg
Y29udHJvbGxlZCBvdmVyIFNQSS4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29t
cGF0aWJsZToNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAg
ICAgLSBzZW10ZWNoLHN4MTMwMQ0KPiA+ICsgICAgICAgIC0gc2VtdGVjaCxzeDEzMDgNCj4gDQo+
IFdlIHNob3VsZCBvbmx5IGxpc3QgYm90aCBpZiB3ZSBleHBlY3QgZGlmZmVyZW5jZXMgYmV0d2Vl
biB0aGUgdHdvDQo+IG1vZGVscy4gT3RoZXJ3aXNlIFNYMTMwOCBjYW4gcmV1c2UgdGhlIFNYMTMw
MSBjb21wYXRpYmxlLiBJZiB3ZSB3YW50IHRvDQo+IG1hcmsgaXQgdXAganVzdCBpbiBjYXNlIHRo
ZW4gcmVhcnJhbmdpbmcgdGhlIGFib3ZlIHRvIGJlIGEgc2VxdWVuY2Ugb2YNCj4gInNlbXRlY2gs
c3gxMzA4IiwgInNlbXRlY2gsc3gxMzAxIiB3b3VsZCBiZSBhbiBhbHRlcm5hdGl2ZS4NCg0KSXQg
d2FzIG15IHVuZGVyc3RhbmRpbmcgdGhhdCB3ZSBzaG91bGQgbmFtZSBlYWNoIGRldmljZSB0aGF0
IGlzIGNvbXBhdGlibGUsDQphdm9pZGluZyB3aWxkY2FyZCAneCcgaW4gY29tcGF0aWJsZSBuYW1l
cy4gVGhpcyBhbGxvd3MgdGhlIGRldmljZSB0cmVlIHRvIGJlDQptb3JlIGFjY3VyYXRlIHRvIHRo
ZSBoYXJkd2FyZSB0aGF0IGl0IGlzIGRlc2NyaWJpbmcuDQoNCkkgZG8gbm90IGV4cGVjdCB0aGVy
ZSB0byBiZSBtdWNoIGRpZmZlcmVuY2UsIGJ1dCB0aGVyZSBtYXkgYmUgc29tZSB0aGF0IEkgDQph
bSB1bmF3YXJlIG9mLg0KDQpOb3Qgc3VyZSBJIGZvbGxvdyBoZXJlLCBkbyB5b3Ugd2lzaCBmb3Ig
dGhlIG9yZGVyIHRvIGJlIGZsaXBwZWQgaWYgd2UgZG8gd2FudA0KdG8gc3RhdGUgZXZlcnkgZGV2
aWNlPyBJIHNlZSB0aGF0IGV4YW1wbGUtc2NoZW1hIGRvZXMgaW5kZWVkIGhhdmUgZW50cmllcw0K
aW4gcmV2ZXJzZS4NCg0KPiANCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6
IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgY2hpcCBzZWxlY3Qgb24gdGhlIFNQSSBidXMu
DQo+IA0KPiBJcyB0aGlzIG1hbmRhdG9yeSBub3cgb3Igbm90IHdpdGggbWF4SXRlbXM/DQoNCm1p
bi9tYXhJdGVtcyBpcyBpbXBsaWVkIGlmIHlvdSBoYXZlIGEgbGlzdCBidXQgZm9yIG91ciBjaGlw
c2VsZWN0IHdlIGhhdmUgbm8NCmxpc3QuIEkgZm9sbG93ZWQgY2hpbGQtbm9kZS1leGFtcGxlLnlh
bWwgaW4geWFtbC1iaW5kaW5ncyBhbmQNCnRyaXZpYWwtZGV2aWNlcy55YW1sIGluIGJlaW5nIGV4
cGxpY2l0IGFuZCBzdGF0aW5nIGl0IGJlIG9uZSBlbGVtZW50IGFuZCBtYWtpbmcNCnJlZyByZXF1
aXJlZC4NCg0KPiANCj4gPiArDQo+ID4gKyAgcmVzZXQtZ3Bpb3M6DQo+ID4gKyAgICBtYXhJdGVt
czogMQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IEEgY29ubmVjdGlvbiBvZiB0aGUgcmVzZXQgZ3Bp
byBsaW5lLg0KPiANCj4gVGhpcyBuZWVkcyB0byBiZSBvcHRpb25hbCwgd2hpY2ggSSB0aGluayB0
aGUgbWF4SXRlbXMgc3ludGF4IHNheXMgdW5saWtlDQo+IHRoZSBjb21taXQgbWVzc2FnZT8NCj4g
T24gYW4gbVBDSWUgY2FyZCB5b3Ugd29uJ3QgaGF2ZSBzdWNoIGEgR1BJTywgZm9yIGluc3RhbmNl
LiBXZSBkbyBhIFNvZnQNCj4gUmVzZXQsIHNvIGl0J3Mgbm90IGZ1bmN0aW9uYWxseSBtYW5kYXRv
cnkuDQoNCkknbGwgZHJvcCB0aGlzIGZyb20gcmVxdWlyZWQgYW5kIGZyb20gdGhlIGNvbW1pdCBt
ZXNzYWdlLg0KDQo+ID4gKw0KPiA+ICsgIHNwaS1tYXgtZnJlcXVlbmN5Og0KPiA+ICsgICAgbWF4
aW11bTogMTAwMDAwMDANCj4gPiArICAgIGRlZmF1bHQ6IDgwMDAwMDANCj4gPiArICAgIGRlc2Ny
aXB0aW9uOiBUaGUgZnJlcXVlbmN5IG9mIHRoZSBTUEkgY29tbXVuaWNhdGlvbiB0byB0aGUgY29u
Y2VudHJhdG9yLA0KPiA+ICsgICAgICBpbiBIei4gTWF4aW11bSBTUEkgZnJlcXVlbmN5IGlzIDEw
TUh6IGFsdGhvdWdoIDhNSHogaXMgdHlwaWNhbGx5IHVzZWQNCj4gPiArICAgICAgb24gYSBudW1i
ZXIgb2YgY2FyZHMuDQo+IA0KPiBEbyB3ZSByZWFsbHkgbmVlZCB0byBkZXNjcmliZSB0aGlzIGhl
cmU/IEl0IHNob3VsZCBiZSBjb3ZlcmVkIGluIHRoZQ0KPiBjb21tb24gU1BJIGJpbmRpbmdzLCBh
bmQgb25seSBhcHBsaWVzIHRvIFNQSSBidXMsIG5vdCBVU0IgcGljb0dXLg0KDQpUcnVlLCBJJ2xs
IGRyb3AgdGhpcy4NCg0KPiANCj4gPiArDQo+ID4gKyAgcmFkaW8tc3BpOg0KPiA+ICsgICAgZGVz
Y3JpcHRpb246IFRoZSBjb25jZW50cmF0b3IgaGFzIHR3byByYWRpb3MgY29ubmVjdGVkIHdoaWNo
IGFyZQ0KPiBjb250YWluZWQNCj4gPiArICAgICAgd2l0aGluIHRoZSBmb2xsb3dpbmcgbm9kZS4N
Cj4gDQo+ICJjYW4gaGF2ZSINCj4gDQo+ID4gKw0KPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiAr
ICAgICAgJyNhZGRyZXNzLWNlbGxzJzoNCj4gPiArICAgICAgICBjb25zdDogMQ0KPiA+ICsNCj4g
PiArICAgICAgJyNzaXplLWNlbGxzJzoNCj4gPiArICAgICAgICBjb25zdDogMA0KPiA+ICsNCj4g
PiArICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAtICcjYWRkcmVzcy1jZWxscycNCj4gPiArICAg
ICAgLSAnI3NpemUtY2VsbHMnDQo+IA0KPiBJJ20gcHJldHR5IHN1cmUgdGhhdCBSb2Igd291bGQg
bGlrZSB0byBoYXZlIGEgY29tcGF0aWJsZSBoZXJlLCBldmVuIGlmDQo+IHVubmVlZGVkIGluIG91
ciBMaW51eCBkcml2ZXI/DQo+IA0KPiBCVFcgaWYgc29tZW9uZSBoYXMgYmV0dGVyIG5hbWluZyBz
dWdnZXN0aW9ucyB0aGFuICJyYWRpby1zcGkiLi4uIEkganVzdA0KPiB3YW50ZWQgdG8gYXZvaWQg
aGF2aW5nIGl0IGluIHRoZSBtYWluIG5vZGUgZGlyZWN0bHksIGluIGNhc2Ugd2UgbmVlZA0KPiBv
dGhlciBzdWItbm9kZXMsIHRvby4NCg0KSnVzdCBsaWtlIGFoYiBhbmQgYXBiIGl0IG1ha2VzIHNl
bnNlIHRvIHNlcGFyYXRlIHRoZSBidXMgZnJvbSB0aGUgZGV2aWNlDQpBbiBhbHRlcm5hdGl2ZSBj
b3VsZCBiZSAidHJhbnNjZWl2ZXItYnVzIiBvciAicmFkaW8tYnVzIiBhcyB0aGUgZmFjdCBpdHMN
CnNwaSBpcyBtYXNrZWQgYXdheSBhbnl3YXkuDQpXaGF0IHdvdWxkIGl0J3MgY29tcGF0aWJsZSBz
dHJpbmcgYmUsIG1hdGNoIHRoZSBub2RlIG5hbWU/DQpXb3VsZCB0aGUgc3gxMzB4X3JhZGlvIGJ1
cyB0eXBlIG1hdGNoIGFnYWluc3QgaXQ/DQoNCj4gDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4g
PiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gcmVzZXQtZ3Bpb3MNCj4g
DQo+IE11c3QgYmUgb3B0aW9uYWwuDQo+IA0KPiA+ICsgIC0gcmFkaW8tc3BpDQo+IA0KPiBTaG91
bGQgYmUgb3B0aW9uYWwuIChEcml2ZXIgbmVlZHMgaXQgdG9kYXksIGJ1dCB0aGF0J3MgYW5vdGhl
ciBwcm9ibGVtLikNCj4gDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiAr
ICAgIGNvbmNlbnRyYXRvcjA6IGxvcmFAMCB7DQo+ID4gKyAgICAgIGNvbXBhdGlibGUgPSAic2Vt
dGVjaCxzeDEzMDEiOw0KPiA+ICsgICAgICByZWcgPSA8MD47DQo+ID4gKyAgICAgIHJlc2V0LWdw
aW9zID0gPCZwaW9CIDI3IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICsgICAgICBzcGktbWF4LWZy
ZXF1ZW5jeSA9IDw4MDAwMDAwPjsNCj4gPiArDQo+ID4gKyAgICAgIHJhZGlvLXNwaSB7DQo+ID4g
KyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMg
PSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAgIHJhZGlvMDogbG9yYUAwIHsNCj4gPiArICAgICAg
ICAgIGNvbXBhdGlibGUgPSAic2VtdGVjaCxzeDEyNTciOw0KPiA+ICsgICAgICAgICAgcmVnID0g
PDA+Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgIHJhZGlvMTogbG9yYUAx
IHsNCj4gPiArICAgICAgICAgIGNvbXBhdGlibGUgPSAic2VtdGVjaCxzeDEyNTciOw0KPiA+ICsg
ICAgICAgICAgcmVnID0gPDE+Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICAgIH07DQo+ID4g
KyAgICB9Ow0KPiANCj4gVGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcywNCj4gDQo+IEFuZHJl
YXMNCj4gDQoNClRoYW5rcywNCkJlbiBXaGl0dGVuDQo=
