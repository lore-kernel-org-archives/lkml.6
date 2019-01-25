Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083B6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1BD218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wXj57zru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAYK2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:28:47 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18046 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYK2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:28:46 -0500
X-IronPort-AV: E=Sophos;i="5.56,520,1539673200"; 
   d="scan'208";a="25924130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Jan 2019 03:28:45 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 25 Jan 2019 03:28:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY3iQeiTzgH56NAKKYdjMfeiHrKBdVyuAReRJor/oi0=;
 b=wXj57zru7TWO/t9diD6dudL9tIMy/2L3hQLvsNteZmLcb7AOtp22oCpXxB33axSJSKorMyp3TrpfpXjmPY3+/Aj+VMoqyCVZwEMImZL0Gb0hhe76VlRetFm/YIr9D3DeYohhuVx0h2Xh6Rzm7p1FObpaPJePapStyPoOnSa5vfg=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1408.namprd11.prod.outlook.com (10.169.234.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Fri, 25 Jan 2019 10:28:42 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 10:28:42 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <harini.katakam@xilinx.com>, <davem@davemloft.net>,
        <Claudiu.Beznea@microchip.com>, <brandon.streiff@ni.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>
Subject: Re: [PATCH] net: macb: Apply RXUBR workaround only to versions with
 errata
Thread-Topic: [PATCH] net: macb: Apply RXUBR workaround only to versions with
 errata
Thread-Index: AQHUtJi+3Kb7HJEqs0W9CTiVc8ntxA==
Date:   Fri, 25 Jan 2019 10:28:42 +0000
Message-ID: <e9c3ae69-a0cb-3862-c01d-d8d1fc3c68e8@microchip.com>
References: <1548337111-31184-1-git-send-email-harini.katakam@xilinx.com>
In-Reply-To: <1548337111-31184-1-git-send-email-harini.katakam@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0117.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::33) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1408;6:a+49FS0uC5c1YnvsI/sq2W9PEA7oZfesWpxMqc0aoEWRk8++B09p73NvNwJfA/hOe/YpjUPT7K9iItIQ7ZGWT7hAL0ZljS4iYMzmJy1SnGr4LMIxEBL7bDFqeAGZAr/eIRcbJdw63DUOtCatDEWulYSgQaEWro+Xmc69q+F+MZ/oBO8gyVnav3JxQLQgixgBwZvQfxmP5rVkDi33pEmj1vf1kX08R1d5SaT3Y9IPWIZnghwvmabRsLUjv0OwoQzgQ0wG21Mg6rdiobi6zcBPZgNzS0HORl5l5rnzc19Rm+7toBdxzkYj/lLYO96CncgPepOmbIbrUhph6koflCIPJMMtJpXqc4BsdFutBR/D97jkjCVTcGBFgPxxypSBIsXLd3n3T/wqOO0a/1yayK6rZ9DWxDnNGZnTig9/ZlbjFNw3557B6gDJBoTMVUuw+6H4/Z+QEnKU7VYauTeNLe4oZQ==;5:Iu8Nc9sFsR8IOqtLEzERgP2MNoEfI18YYHw61jKqUJK5gcrJVk63R3HItKe6CSJzfK/OK6jwwAQHqwdO2DijCiEvJPaZcuOTs+dBb5MuJ6eHSYgOv/SesYorRINx5hOJ0mkdfGZJWB1pSgdZGyKzqQiQxLxynanlVthVc7f1etiprdMTKEGAgxvzP8E3X8wMmhbJc2rhQvdtdFD/eW0yrw==;7:q7iAovRnOLL/fRN4IwW4C01eFiIXad5dxhKWBkCvHofWkn+h8uIbnUSt1G91+2ytxzJ/vum3SAlh40wAEC/diLtlIg1H+SwVtq+6QDemBoQpi7vS4H5L+6uAJrQwsPCz2d6N/ArL38yl6FbGX+D42g==
x-ms-office365-filtering-correlation-id: b9b8f715-bf8c-466b-2ed6-08d682afe0e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1408;
x-ms-traffictypediagnostic: MWHPR11MB1408:
x-microsoft-antispam-prvs: <MWHPR11MB140825AC5DF5DB1857D3F387E09B0@MWHPR11MB1408.namprd11.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(52116002)(25786009)(256004)(31686004)(6486002)(102836004)(6436002)(76176011)(486006)(6506007)(53546011)(386003)(97736004)(99286004)(71190400001)(71200400001)(36756003)(66066001)(6512007)(305945005)(316002)(81166006)(81156014)(8676002)(4326008)(53936002)(7736002)(105586002)(6116002)(3846002)(106356001)(39060400002)(54906003)(110136005)(8936002)(229853002)(478600001)(72206003)(6246003)(14454004)(31696002)(186003)(86362001)(2501003)(68736007)(26005)(2906002)(2616005)(446003)(11346002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1408;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IKx0j18txBJyusihLequLM2GM+tIUcfcNM6GWdAZHenf4E5n0+2zUeFGO6S5Of4cMbQI7i7AhQJ41478ydOR/7vcKfz7Ro7IIHVDlp4/CLyIM/g9hbJ7VwcnQ1MP2D9hWl2uqyG8QK0Cijy+2epcU0bPxe382GLna1ZnSPBbTJflfI2dndElejajRVNQ+9lZ0yaXWoCEEBwzdm1pJPWgPn9e1Is4WBkWbcdJNU/rTolLUC8sB1Eqn7qj1teErl0hqdWIYt8G8++oarIFJX3bJOzf7TDACVyHz/DbaWlSI4n5oajNi2in4+5c3lFQAk1FCIbftGjkphnTnfVKYariD5ZGvBRgPvA6p4Bl9Xd7NtHvigC5PQcMlBUfbtE6CRmc2wqcDmp2bjVVx80su9lkR88yIJBFCNlfyEJB7bFLSBc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D85EA8E03935CF4688B212FFCC2137DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b8f715-bf8c-466b-2ed6-08d682afe0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 10:28:40.5891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1408
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDEvMjAxOSBhdCAxNDozOCwgSGFyaW5pIEthdGFrYW0gd3JvdGU6DQo+IFRoZSBpbnRl
cnJ1cHQgaGFuZGxlciBjb250YWlucyBhIHdvcmthcm91bmQgZm9yIFJYIGhhbmcgYXBwbGljYWJs
ZQ0KPiB0byBaeW5xIGFuZCBBVDkxIG9ubHkuIFN1YnNlcXVlbnQgdmVyc2lvbnMgZG8gbm90IG5l
ZWQgdGhpcw0KDQpBVDkxUk05MjAwIG9ubHkuIEl0J3Mgbm90IHRoZSBjYXNlIGZvciBvdGhlciBB
VDkxIFNvQ3MgKHJlYWRpbmcgZXJyYXRhIA0KbGlzdCBmb3IgdGhlbSkuDQoNClRoYXQgYmVpbmcg
c2FpZCBJIGhhdmUgdG8gYWRkIGEgcGF0Y2ggZm9yIG1ha2luZyB0aGlzIHBlcmZlY3RseSBjbGVh
ciBpbiANCnRoZSBjb21tZW50IGp1c3QgYWJvdmUgdGhlIGZsYWcncyB0ZXN0Lg0KDQo+IHdvcmth
cm91bmQuIFRoaXMgd29ya2Fyb3VuZCB1bmVjZXNzYXJpbHkgcmVzZXRzIFJYIHdoZW5ldmVyIFJY
IHVzZWQNCg0KVHlwbzogdW5uZWNlc3NhcmlseQ0KDQo+IGJpdCByZWFkIGlzIG9ic2VydmVkLCB3
aGljaCBjYW4gYmUgb2Z0ZW4gdW5kZXIgaGVhdnkgdHJhZmZpYy4gSGVuY2UNCj4gaW50cm9kdWNl
IGFuIENBUFMgbWFzayBhbmQgYSBjaGVjayB0byBlbmFibGUgdGhpcyB3b3JrYXJvdW5kLg0KDQpO
YWNrIGZvciB0aGlzIG9uZSwgc2VlIGJlbG93Li4uDQoNCj4gU2lnbmVkLW9mZi1ieTogSGFyaW5p
IEthdGFrYW0gPGhhcmluaS5rYXRha2FtQHhpbGlueC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGZy
b20gUkZDOg0KPiAtIFVzZSBDQVBTIG1hc2sgaW5zdGVhZCBpbnRyb2R1Y2luZyBhbmQgZXJyYXRh
IGZpZWxkLg0KPiAtIFVzZSBjaGVjayBvbmx5IG9uIFJYIHJlc2V0IHBhcnQ7IElTUiBzaG91bGQg
c3RpbGwgYmUgY2xlYXJlZC4NCj4gDQo+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9t
YWNiLmggICAgICB8ICAxICsNCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2Jf
bWFpbi5jIHwgMTYgKysrKysrKysrKy0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2Uv
bWFjYi5oDQo+IGluZGV4IDNkNDVmNGMuLjJiNDEyZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2NhZGVuY2UvbWFjYi5oDQo+IEBAIC02NDMsNiArNjQzLDcgQEANCj4gICAjZGVmaW5lIE1BQ0Jf
Q0FQU19KVU1CTwkJCQkweDAwMDAwMDIwDQo+ICAgI2RlZmluZSBNQUNCX0NBUFNfR0VNX0hBU19Q
VFAJCQkweDAwMDAwMDQwDQo+ICAgI2RlZmluZSBNQUNCX0NBUFNfQkRfUkRfUFJFRkVUQ0gJCTB4
MDAwMDAwODANCj4gKyNkZWZpbmUgTUFDQl9DQVBTX05FRURTX1JTVE9OVUJSCQkweDAwMDAwMTAw
DQo+ICAgI2RlZmluZSBNQUNCX0NBUFNfRklGT19NT0RFCQkJMHgxMDAwMDAwMA0KPiAgICNkZWZp
bmUgTUFDQl9DQVBTX0dJR0FCSVRfTU9ERV9BVkFJTEFCTEUJMHgyMDAwMDAwMA0KPiAgICNkZWZp
bmUgTUFDQl9DQVBTX1NHX0RJU0FCTEVECQkJMHg0MDAwMDAwMA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gaW5kZXggNjZjYzc5Mi4uMGJkYTFjZCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IEBAIC0xNDE2LDEw
ICsxNDE2LDEyIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtYWNiX2ludGVycnVwdChpbnQgaXJxLCB2
b2lkICpkZXZfaWQpDQo+ICAgCQkgKiBzZWN0aW9uIDE2LjcuNCBmb3IgZGV0YWlscy4NCj4gICAJ
CSAqLw0KPiAgIAkJaWYgKHN0YXR1cyAmIE1BQ0JfQklUKFJYVUJSKSkgew0KPiAtCQkJY3RybCA9
IG1hY2JfcmVhZGwoYnAsIE5DUik7DQo+IC0JCQltYWNiX3dyaXRlbChicCwgTkNSLCBjdHJsICYg
fk1BQ0JfQklUKFJFKSk7DQo+IC0JCQl3bWIoKTsNCj4gLQkJCW1hY2Jfd3JpdGVsKGJwLCBOQ1Is
IGN0cmwgfCBNQUNCX0JJVChSRSkpOw0KPiArCQkJaWYgKGJwLT5jYXBzICYgTUFDQl9DQVBTX05F
RURTX1JTVE9OVUJSKSB7DQo+ICsJCQkJY3RybCA9IG1hY2JfcmVhZGwoYnAsIE5DUik7DQo+ICsJ
CQkJbWFjYl93cml0ZWwoYnAsIE5DUiwgY3RybCAmIH5NQUNCX0JJVChSRSkpOw0KPiArCQkJCXdt
YigpOw0KPiArCQkJCW1hY2Jfd3JpdGVsKGJwLCBOQ1IsIGN0cmwgfCBNQUNCX0JJVChSRSkpOw0K
PiArCQkJfQ0KDQpBcyB0aGlzIGludGVycnVwdCByb3V0aW5lIGlzIG5vdCBkb2luZyBhbnl0aGlu
ZyBlbHNlIHRoYW4ganVzdCBiZWluZyANCmNhbGxlZCBub3csIHdoYXQgYWJvdXQganVzdCByZW1v
dmluZyB0aGUgdXNlIG9mIHRoaXMgc3RhdHVzIGJpdCBmb3IgDQpwbGF0Zm9ybXMgd2hpY2ggZG9u
J3QgbmVlZCB0aGlzIFJYIHJlc2V0Pw0KDQo+ICAgCQkJaWYgKGJwLT5jYXBzICYgTUFDQl9DQVBT
X0lTUl9DTEVBUl9PTl9XUklURSkNCj4gICAJCQkJcXVldWVfd3JpdGVsKHF1ZXVlLCBJU1IsIE1B
Q0JfQklUKFJYVUJSKSk7DQo+IEBAIC0zODY0LDcgKzM4NjYsOCBAQCBzdGF0aWMgaW50IGF0OTFl
dGhlcl9pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgfQ0KPiAgIA0KPiAg
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWFjYl9jb25maWcgYXQ5MXNhbTkyNjBfY29uZmlnID0gew0K
PiAtCS5jYXBzID0gTUFDQl9DQVBTX1VTUklPX0hBU19DTEtFTiB8IE1BQ0JfQ0FQU19VU1JJT19E
RUZBVUxUX0lTX01JSV9HTUlJLA0KPiArCS5jYXBzID0gTUFDQl9DQVBTX1VTUklPX0hBU19DTEtF
TiB8DQo+ICsJCU1BQ0JfQ0FQU19VU1JJT19ERUZBVUxUX0lTX01JSV9HTUlJIHwgTUFDQl9DQVBT
X05FRURTX1JTVE9OVUJSLA0KPiAgIAkuY2xrX2luaXQgPSBtYWNiX2Nsa19pbml0LA0KPiAgIAku
aW5pdCA9IG1hY2JfaW5pdCwNCg0KQWN0dWFsbHkgaXQgc2VlbXMgbm90IHRoZSBwcm9wZXIgY29u
ZmlndXJhdGlvbiBzdHJ1Y3R1cmUgdG8gbW9kaWZ5OiBZb3UgDQptdXN0IGNoYW5nZSB0aGUgZW1h
Y19jb25maWcgaW5zdGVhZC4NCg0KDQo+ICAgfTsNCj4gQEAgLTM5MjgsNyArMzkzMSw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbWFjYl9jb25maWcgenlucW1wX2NvbmZpZyA9IHsNCj4gICB9Ow0K
PiAgIA0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWFjYl9jb25maWcgenlucV9jb25maWcgPSB7
DQo+IC0JLmNhcHMgPSBNQUNCX0NBUFNfR0lHQUJJVF9NT0RFX0FWQUlMQUJMRSB8IE1BQ0JfQ0FQ
U19OT19HSUdBQklUX0hBTEYsDQo+ICsJLmNhcHMgPSBNQUNCX0NBUFNfR0lHQUJJVF9NT0RFX0FW
QUlMQUJMRSB8IE1BQ0JfQ0FQU19OT19HSUdBQklUX0hBTEYgfA0KPiArCQlNQUNCX0NBUFNfTkVF
RFNfUlNUT05VQlIsDQo+ICAgCS5kbWFfYnVyc3RfbGVuZ3RoID0gMTYsDQo+ICAgCS5jbGtfaW5p
dCA9IG1hY2JfY2xrX2luaXQsDQo+ICAgCS5pbml0ID0gbWFjYl9pbml0LA0KDQoNCkJlc3QgcmVn
YXJkcywNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
