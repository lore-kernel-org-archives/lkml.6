Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86552070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Q6LMjt/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfAIOof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:44:35 -0500
Received: from mail-eopbgr40131.outbound.protection.outlook.com ([40.107.4.131]:34847
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731479AbfAIOof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD0RrPLvPWybY3jumgXwBdcbiT3xo3040FSqoBj8iY4=;
 b=Q6LMjt/lMOGs2KD/XOJ1QpVHQJsRJDDN12iprnWEF883LYMMKV4Xmd0vu/T9cyW9lCEjMO3tv6gXG++FF0Ra/KLwQiKw0Jtzb8F2ZEIsOqgS/gdUmoscdgj3pwJQmmrLKsUpGWXoRavACvSqFDSRhjp4LNxzbG+oQDz2ALgCzV4=
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com (52.133.24.160) by
 AM6PR0702MB3831.eurprd07.prod.outlook.com (52.133.25.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.10; Wed, 9 Jan 2019 14:44:27 +0000
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b]) by AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b%5]) with mapi id 15.20.1537.005; Wed, 9 Jan 2019
 14:44:26 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Subject: RE: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Thread-Topic: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Thread-Index: AdSCPskxr2Sna9MEQ4KkOAtgpIpvmglAAIIAAA80LwAAJtCNsA==
Date:   Wed, 9 Jan 2019 14:44:26 +0000
Message-ID: <AM6PR0702MB37997C0FA1670DD1AF4C25C7FA8B0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
In-Reply-To: <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0702MB3831;6:RF0rV9E3oqxDjbtfeFtQcczme1mEijxyGx9eJzaq0SECDgeq72n1jvSYL4vOoWdP4Vr5/0+0efy++Zv/rZcLyLZTSK00T5RwsWynWBJAfMiQfcUrx6i8GLw+SgBVgAawdGdy+Tnz5mI4hKEMC+jARXXPFrSyU2AA/YoAca67/LHsHtxUO7+s5/mrsNkRKgxCf2h/e6TUEmgFQKb0p6yI1aLhQOSeY25PZULoXgCZqzE7kMKVpSwqnTnnkUg/N0KNlmoPeosgAouYxaHx3m9x4slaGgfCKKDVU2vEUu2ifjuGiMTRGqyqwUH1fnesxKHMKFweE3GjO4k9z7us2cWSJTbVcOZMJbZJPN0JbMMd09wKay+cgFakJ1FhzbAn0fRNHOeU9iyFsD7mrdrmkspFhNwfgNywFVWBk2vAmO8LUdwlpBIxK1NJGZRU9ZRJL73FgsdiwZtvGWyV6VtxbhZSng==;5:eHA6vq30k1LbfONIU+g+IE+Nv1j7ANM6Hy/Uyp0xzFDuURPD5pnKTT7X44U6Y3LUzhonxDulJITvKYtDq13Kb7Df1/sxbmUEXH7H56xne9CK1C3xNfsnfVDbhxuD41WvMGMePPiLAtm3xaENPn+eLOJGRdMWY+r2E8+UbQGWT1M3ABu7auHC2XsgVy7IYQbV/7Hj/jdk2YYwQdY5zoY4lQ==;7:4zl9toNCm8i23Secj1z2q9dn1LzAs0WhjV8AZOofVMsBPEnxS0jGi7Ll+/RaFlSVih3ARdm8T83i2AofCEoAvtkw8wG62m/tDV53UmsgPRjYEOuLutmFRC7tr+mE7X6yAewf9ejszjw3FTlj7V+iOg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(366004)(13464003)(189003)(199004)(33656002)(486006)(66066001)(76176011)(7696005)(106356001)(99286004)(105586002)(26005)(102836004)(74316002)(186003)(6506007)(53546011)(14454004)(5660300001)(7416002)(305945005)(316002)(7736002)(11346002)(478600001)(53936002)(110136005)(476003)(2906002)(9686003)(6246003)(107886003)(25786009)(3846002)(6116002)(256004)(14444005)(4326008)(68736007)(446003)(71200400001)(71190400001)(229853002)(97736004)(55016002)(8936002)(81156014)(81166006)(8676002)(54906003)(86362001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0702MB3831;H:AM6PR0702MB3799.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 8a33aa06-9605-442a-849b-08d67640f43a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR0702MB3831;
x-ms-traffictypediagnostic: AM6PR0702MB3831:
x-microsoft-antispam-prvs: <AM6PR0702MB38319A0384B919C2181B8C9BFA8B0@AM6PR0702MB3831.eurprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(806100)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0702MB3831;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0702MB3831;
x-forefront-prvs: 0912297777
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JRyQYSEsu4GuHwGcdTO1Jl8frQMzSkdzsh9KLc2Qzu1wYty9ENgOrDNiXHorsMTngOvrxdk0l7zknC9ECGVLJl8fNLRi9co9lnx//uD9dTEzbW/0kbCL/0nnlDeMIF/M7cDaoa1xv3O6nRuDIJoexSH+SgpQoUBhv8Ya8mlojHuVUkVGX3zKIGIlyjdkbl4uOoPH3aGOBQLlepJUTcpAeaIIco5zmD7HHX9n/8S9+8uw4A68j95x5peSJsumRJwTUFv/Okim6vKiCj3KwN67F+WeQCjMlD4Tf2nQ4jBVl8O0EJjBnIuGN+3hb0s7ELu8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a33aa06-9605-442a-849b-08d67640f43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:44:26.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNCmZpcnN0IG9mIGFsbCB0aGFua3MgYSBsb3QgZm9yIHRoZSBjb25zdHJ1Y3Rp
dmUgYW5kIGZhc3QgZmVlZGJhY2shDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXks
IEphbnVhcnkgMDgsIDIwMTkgNjo1NyBQTQ0KPiANCj4gSGkgQm9yaXMsIFdsYWRpc2xhdiwNCj4g
DQo+IE9uIDA4LzAxLzIwMTkgMTA6NDIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiArIEph
bWVzIGFuZCBsZWF2aW5nIGluIHRoZSByZXN0IGZvciByZWZlcmVuY2UuDQo+IA0KPiAodGhhbmtz
ISkNCj4gDQo+ID4gU28gdGhlIGZpcnN0IHRoaW5nIHRvIGZpZ3VyZSBvdXQgaGVyZSBpcyBob3cg
Z2VuZXJpYyBpcyB0aGlzIGFuZCBpZg0KPiA+IHNvLCB0byBtYWtlIGl0IGEgY29ydGV4X2ExNV9l
ZGFjLmMgZHJpdmVyIHdoaWNoIGNvbnRhaW5zIGFsbCB0aGUgUkFTDQo+ID4gZnVuY3Rpb25hbGl0
eSBmb3IgQTE1LiBEZWZpbml0ZWx5IG5vdCBhbiBFREFDIGRyaXZlciBwZXIgZnVuY3Rpb25hbA0K
PiA+IHVuaXQgYnV0IHJhdGhlciBwZXIgdmVuZG9yIG9yIGV2ZW4gQVJNIGNvcmUuDQo+IA0KPiBU
aGlzIGlzIGltcGxlbWVudGF0aW9uLWRlZmluZWQvc3BlY2lmaWMtdG8tQTE1IGFuZCBpcyBkb2N1
bWVudGVkIGluIHRoZQ0KPiBUUk0gWzBdLg0KPiAoT24gdGhlICdhbGwgdGhlIFJBUyBmdW5jdGlv
bmFsaXR5IGZvciBBMTUnIGZyb250OiB0aGVyZSBhcmUgdHdvIG1vcmUgcmVnaXN0ZXJzOg0KPiBM
Mk1FUlJTUiBhbmQgQ1BVTUVSUlNSLiBUaGVzZSBhcmUgYm90aCBhY2Nlc3NpYmxlIGZyb20gdGhl
IG5vcm1hbC0NCj4gd29ybGQsIGFuZCBkb24ndCBhcHBlYXIgdG8gbmVlZCBlbmFibGluZy4pDQo+
IA0KPiANCj4gQnV0IHdlIGhhdmUgdGhlIHVzdWFsIHByZS12OC4yIHByb2JsZW1zLCBhbmQgaW4g
YWRkaXRpb24gY2x1c3Rlci1pbnRlcnJ1cHRzLA0KPiBhcyB0aGlzIHNpZ25hbCBtaWdodCBiZSBw
ZXItY2x1c3Rlciwgb3IgaXQgbWlnaHQgYmUgY29tYmluZWQuDQo+IA0KPiBXbGFkaXNsYXYsIEkn
bSBhZnJhaWQgd2UndmUgaGFkIGEgZmV3IGF0dGVtcHRzIGF0IHByZS04LjIgRURBQyBkcml2ZXJz
LCB0aGUNCj4gYmVsb3cgbGlzdCBvZiBwcm9ibGVtcyBpcyB3aGF0IHdlJ3ZlIGxlYXJudCBhbG9u
ZyB0aGUgd2F5LiBUaGUgdXBzaG90IGlzIHRoYXQNCj4gYmVmb3JlIHRoZSBhcmNoaXRlY3RlZCBS
QVMgZXh0ZW5zaW9ucywgdGhlIGV4cGVjdGF0aW9uIGlzIGZpcm13YXJlIHdpbGwNCj4gaGFuZGxl
IGFsbCB0aGlzLCBhcyBpdHMgZGlmZmljdWx0IGZvciB0aGUgT1MgdG8gZGVhbCB3aXRoLg0KPiAN
Cj4gDQo+IE15IGZpcnN0IHF1ZXN0aW9uIGlzIGhvdyB1c2VmdWwgaXMgYSAnc29tZXRoaW5nIGJh
ZCBoYXBwZW5lZCcgZWRhYyBldmVudD8NCg0KV2UgZXhwZXJpZW5jZWQgc29tZXRpbWVzIHJhbmRv
bSB1c2VyLXNwYWNlIGNyYXNoZXMgd2hlcmUgd2UgZGlkbid0IA0KZXhwZWN0IGEgYnVnIGluIHRo
ZSBhcHBsaWNhdGlvbiBjb2RlLiBJZiB0aGVyZSB3b3VsZCBiZSBhIG5vdGlmaWNhdGlvbiANCmJ5
IHN1Y2ggZWRhYyBldmVudCwgd2Ugd291bGQgYXQgbGVhc3Qga25vdyB0aGF0IHNvbWV0aGluZyBi
YWQgaGFwcGVuZWQgYmVmb3JlLg0KDQo+IEJlZm9yZSB0aGUgdjguMiBleHRlbnNpb25zIHdpdGgg
aXRzIGNsYXNzaWZpY2F0aW9uIG9mIGVycm9ycywgd2UgZG9uJ3Qga25vdw0KPiBhbnl0aGluZyBt
b3JlLg0KPiANCj4gVGhlIHVzdWFsIHN1c3BlY3RzIGFyZSwgKHBhcnRseSB0YWtlbiBmcm9tIHRo
ZSB0aHJlYWQgYXQgWzFdKToNCj4gKiBBMTUgZXhpc3RzIGluIGJpZy9saXR0bGUgY29uZmlndXJh
dGlvbnMuIFdlIG5lZWQgdG8ga25vdyB3aGljaCBDUFVzIGFyZQ0KPiBBMTUuDQo+ICogV2UgbmVl
ZCB0byBrbm93IHdlIGFyZW4ndCBydW5uaW5nIHVuZGVyIGEgaHlwZXJ2aXNvciwgKGEgaHlwZXJ2
aXNvciBjYW4NCj4gdHJhcA0KPiAgIGFjY2Vzc2VzIHRvIHRoZXNlIGltcC1kZWYgcmVnaXN0ZXIs
IEtWTSBkb2VzKS4NCj4gKiBOb3RoaW5nIGVsc2Ugc2hvdWxkIGJlIGNsZWFyaW5nIHRoZXNlIGJp
dHMsIGUuZy4gc2VjdXJlLXdvcmxkIHNvZnR3YXJlLCBvcg0KPiAgIGFub3RoZXIgQ1BVLg0KPiAq
IFNlY3VyZS13b3JsZCBuZWVkcyB0byBlbmFibGUgd3JpdGUtYWNjZXNzIHRvIEwyRUNUTFIsIGFu
ZCB3ZSBuZWVkIHRvDQo+ICAga25vdyBpdHMgZG9uZSBpdC4gVGhpcyBuZWVkcyBkb2luZyBvbiBl
dmVyeSBDUFUsIGFuZCBuZWVkcyB0byBub3QgJ2dvDQo+IG1pc3NpbmcnDQo+ICAgb3ZlciBjcHUt
aG90cGx1ZyBvciBjcHUtaWRsZS4NCj4gDQo+IFRoZXNlIGFyZSB0aGluZ3MgdGhhdCBkb24ndCBu
YXR1cmFsbHkgbGl2ZSBpbiB0aGUgRFQuDQo+IA0KPiANCj4gVGhlIG5ldy1vbmUgaXMgdGhlc2Ug
Y2x1c3Rlci1pbnRlcnJ1cHRzOiBIb3cgZG8gd2Uga25vdyB3aGljaCBzZXQgb2YgQ1BVcw0KPiBl
YWNoIGludGVycnVwdCBnb2VzIHdpdGg/IFdoYXQgaGFwcGVucyBpZiB1c2VyLXNwYWNlIHRyaWVz
IHRvIHJlYmFsYW5jZQ0KPiB0aGVtPw0KDQpWYWxpZCBxdWVzdGlvbiAtIHNvIGZhciwgSSBkaWRu
J3QgY29uc2lkZXIgdGhpcyBjYXNlLg0KIA0KPiBBbm90aGVyIFNvQyB3aXRoIEExNSBtYXkgY29t
YmluZSBhbGwgdGhlIGNsdXN0ZXItaW50ZXJydXB0cyBpbnRvIGEgc2luZ2xlDQo+ICdzb21ldGhp
bmcgYmFkIGhhcHBlbmVkJyBpbnRlcnJ1cHQuIERvbmUgbGlrZSB0aGlzLCB3ZSB3b3VsZCBuZWVk
IHRvIGNyb3NzLQ0KPiBjYWxsIHRvIHRoZSBvdGhlciBDUFVzIHdoZW4gd2UgdGFrZSBhbiBpbnRl
cnJ1cHQgLSB3aGljaCBpcyBub3Qgc29tZXRoaW5nIHdlDQo+IGNhbiBkby4NCj4gDQo+IElzIHRo
aXMgYSBsZXZlbCBvciBlZGdlIGludGVycnVwdD8gSXMgaXQgbmVjZXNzYXJ5IHRvIGNsZWFyIHRo
YXQgYml0IGluIHRoZSByZWdpc3Rlcg0KPiB0byBsb3dlciB0aGUgaW50ZXJydXB0IGxpbmU/DQo+
IFRoZSBUUk0gdGFsa3MgYWJvdXQgJ3BlbmRpbmcgTDIgaW50ZXJuYWwgYXN5bmNocm9ub3VzIGVy
cm9yJywgcGVuZGluZw0KPiBtYWtlcyBtZSBzdXNwZWN0IHRoaXMgaXMgYXQgbGVhc3QgcG9zc2li
bGUuIElmIGl0IGlzLCBhIGxldmVsLWludGVycnVwdCB0byBvbmUNCj4gQ1BVLCB0aGF0IGNhbiBv
bmx5IGJlIGNsZWFyZWQgYnkgYW5vdGhlciBsZWFkcyB0byBkZWFkbG9jay4NCj4gDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBKYW1lcw0KPiANCj4gPiBPbiBUdWUsIEphbiAwOCwgMjAxOSBhdCAwODox
MDo0NUFNICswMDAwLCBXaWViZSwgV2xhZGlzbGF2IChOb2tpYSAtDQo+IERFL1VsbSkgd3JvdGU6
DQo+ID4+IFRoaXMgZHJpdmVyIGFkZHMgc3VwcG9ydCBmb3IgTDIgaW50ZXJuYWwgYXN5bmNocm9u
b3VzIGVycm9yIGRldGVjdGlvbg0KPiA+PiBjYXVzZWQgYnkgTDIgUkFNIGRvdWJsZS1iaXQgRUND
IGVycm9yIG9yIGlsbGVnYWwgd3JpdGVzIHRvIHRoZQ0KPiA+PiBJbnRlcnJ1cHQgQ29udHJvbGxl
ciBtZW1vcnktbWFwIHJlZ2lvbiBvbiB0aGUgQ29ydGV4IEExNS4NCj4gDQo+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2VkYWMvY29ydGV4X2ExNV9sMl9hc3luY19lZGFjLmMNCj4gPj4gYi9kcml2
ZXJzL2VkYWMvY29ydGV4X2ExNV9sMl9hc3luY19lZGFjLmMNCj4gPj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yNjI1MjU2OGU5NjENCj4gPj4gLS0tIC9k
ZXYvbnVsbA0KPiA+PiArKysgYi9kcml2ZXJzL2VkYWMvY29ydGV4X2ExNV9sMl9hc3luY19lZGFj
LmMNCj4gPj4gQEAgLTAsMCArMSwxMzQgQEANCj4gPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wDQo+ID4+ICsvKg0KPiA+PiArICogQ29weXJpZ2h0IChDKSAyMDE4IE5va2lh
IENvcnBvcmF0aW9uDQo+IA0KPiAoYm9pbGVyIHBsYXRlIG5vdCBuZWVkZWQgd2l0aCB0aGUgU1BE
WCBoZWFkZXIpDQo+IA0KPiA+PiArICovDQo+ID4+ICsNCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPj4gKyNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9vZi5o
Pg0KPiA+PiArDQo+ID4+ICsjaW5jbHVkZSAiZWRhY19tb2R1bGUuaCINCj4gPj4gKw0KPiA+PiAr
I2RlZmluZSBEUklWRVJfTkFNRSAiY29ydGV4X2ExNV9sMl9hc3luY19lZGFjIg0KPiA+PiArDQo+
ID4+ICsjZGVmaW5lIEwyRUNUTFJfTDJfQVNZTkNfRVJSIEJJVCgzMCkNCj4gPj4gKw0KPiA+PiAr
c3RhdGljIGlycXJldHVybl90IGNvcnRleF9hMTVfbDJfYXN5bmNfZWRhY19lcnJfaGFuZGxlcihp
bnQgaXJxLA0KPiA+PiArdm9pZCAqZGV2X2lkKSB7DQo+ID4+ICsJc3RydWN0IGVkYWNfZGV2aWNl
X2N0bF9pbmZvICpkY2kgPSBkZXZfaWQ7DQo+ID4+ICsJdTMyIHN0YXR1cyA9IDA7DQo+ID4+ICsN
Cj4gPj4gKwkvKg0KPiA+PiArCSAqIFJlYWQgYW5kIGNsZWFyIEwyRUNUTFIgTDIgQVNZTkMgZXJy
b3IgYml0IGNhdXNlZCBieSBJTlRFUlJJUlEuDQo+ID4+ICsJICogUmVhc29uIGNvdWxkIGJlIGEg
TDIgUkFNIGRvdWJsZS1iaXQgRUNDIGVycm9yIG9yIGlsbGVnYWwgd3JpdGVzDQo+ID4+ICsJICog
dG8gdGhlIEludGVycnVwdCBDb250cm9sbGVyIG1lbW9yeS1tYXAgcmVnaW9uLg0KPiA+PiArCSAq
Lw0KPiA+PiArCWFzbSgibXJjIHAxNSwgMSwgJTAsIGM5LCBjMCwgMyIgOiAiPXIiIChzdGF0dXMp
KTsNCj4gDQo+ICJMMiBpbnRlcm5hbCBhc3luY2hyb25vdXMgZXJyb3IgY2F1c2VkIGJ5IEwyIFJB
TSBkb3VibGUtYml0IEVDQyBlcnJvciINCj4gZG9lc24ndCB0ZWxsIHVzIGlmIGEgQ1BVIGNvbnN1
bWVkIHRoZSBlcnJvciwgb3IgaWYgdGhlIGVycm9yIGhhcyBjYXVzZWQgYSB3cml0ZQ0KPiB0byBn
byBtaXNzaW5nLiBXaXRob3V0IHRoZSBjbGFzc2lmaWNhdGlvbiwgdGhpcyBtZWFucyAnc29tZXRo
aW5nIGJhZA0KPiBoYXBwZW5lZCcuDQo+IA0KPiBJJ2QgcHJlZmVyIHRvIHBhbmljKCkgd2hlbiB3
ZSBzZWUgb25lIG9mIHRoZXNlLiBJJ2QgbGlrZSBpdCBldmVuIG1vcmUgaWYNCj4gZmlybXdhcmUg
cmVib290ZWQgZm9yIHVzLg0KDQpUaGUgRURBQyBzdWJzeXN0ZW0gYWxsb3dzIHRvIGNvbmZpZ3Vy
ZSBhIHBhbmljKCkgZnJvbSB1c2Vyc3BhY2Uvc3lzZnMuDQpTbyB3ZSBjYW4gYmUgZmxleGlibGUg
YXQgdGhpcyBwb2ludCBJIHRoaW5rLg0KDQo+IA0KPiA+PiArCWlmIChzdGF0dXMgJiBMMkVDVExS
X0wyX0FTWU5DX0VSUikgew0KPiA+PiArCQlzdGF0dXMgJj0gfkwyRUNUTFJfTDJfQVNZTkNfRVJS
Ow0KPiA+PiArCQlhc20oIm1jciBwMTUsIDEsICUwLCBjOSwgYzAsIDMiIDogOiAiciIgKHN0YXR1
cykpOw0KPiANCj4gNC4zLjQ5ICJMMiBFeHRlbmRlZCBDb250cm9sIFJlZ2lzdGVyIiBvZiB0aGUg
QTE1IFRSTSBzYXlzIHRoaXMgZmllbGQgY2FuIGJlDQo+IHJlYWQtb25seS93cml0ZS1pZ25vcmVk
IGZvciB0aGUgbm9ybWFsIHdvcmxkIGlmIE5TQUNSLk5TX0wyRVJSIGlzIDAuDQo+IA0KPiBIb3cg
ZG8gd2Uga25vdyBpZiBmaXJtd2FyZSBoYXMgc2V0IHRoaXMgYml0IG9uIGFsbCBDUFVzPyBXZSBj
YW4ndCBjbGVhciB0aGUNCj4gZXJyb3Igb3RoZXJ3aXNlLg0KDQpWYWxpZCBwb2ludCENCiANCj4g
DQo+ID4+ICsJCWVkYWNfcHJpbnRrKEtFUk5fRU1FUkcsIERSSVZFUl9OQU1FLA0KPiA+PiArCQkJ
ICAgICJMMiBpbnRlcm5hbCBhc3luY2hyb25vdXMgZXJyb3Igb2NjdXJyZWQhXG4iKTsNCj4gPj4g
KwkJZWRhY19kZXZpY2VfaGFuZGxlX3VlKGRjaSwgMCwgMCwgZGNpLT5jdGxfbmFtZSk7DQo+IA0K
PiA+PiArDQo+ID4+ICsJCXJldHVybiBJUlFfSEFORExFRDsNCj4gPj4gKwl9DQo+ID4+ICsNCj4g
Pj4gKwlyZXR1cm4gSVJRX05PTkU7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBpbnQg
Y29ydGV4X2ExNV9sMl9hc3luY19lZGFjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4g
Pj4gKypwZGV2KSB7DQo+ID4+ICsJc3RydWN0IGVkYWNfZGV2aWNlX2N0bF9pbmZvICpkY2k7DQo+
ID4+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+PiAr
CWNoYXIgKmN0bF9uYW1lID0gKGNoYXIgKilucC0+bmFtZTsNCj4gPj4gKwlpbnQgaSA9IDAsIHJl
dCA9IDAsIGVycl9pcnEgPSAwLCBpcnFfY291bnQgPSAwOw0KPiA+PiArDQo+ID4+ICsJLyogV2Ug
Y2FuIGhhdmUgbXVsdGlwbGUgQ1BVIGNsdXN0ZXJzIHdpdGggb25lIElOVEVSUklSUSBwZXIgY2x1
c3Rlcg0KPiA+PiArKi8NCj4gDQo+IFN1cmVseSB0aGlzIGFuIGludGVncmF0aW9uIGNob2ljZT8N
Cj4gDQo+IFlvdSdyZSBhY2Nlc3NpbmcgdGhlIGNsdXN0ZXIgdGhyb3VnaCBhIGNwdSByZWdpc3Rl
ciBpbiB0aGUgaGFuZGxlciwgd2hhdA0KPiBoYXBwZW5zIGlmIHRoZSBpbnRlcnJ1cHQgaXMgZGVs
aXZlcmVkIHRvIHRoZSB3cm9uZyBjbHVzdGVyPw0KPiBIb3cgZG8gd2Uga25vdyB3aGljaCBpbnRl
cnJ1cHQgbWFwcyB0byB3aGljaCBjbHVzdGVyPw0KPiBIb3cgZG8gd2Ugc3RvcCB1c2VyLXNwYWNl
ICdiYWxhbmNpbmcnIHRoZSBpbnRlcnJ1cHRzPw0KDQpZb3UgYXJlIHJpZ2h0LCBiYXNlZCBvbiBh
bGwgeW91ciBpbnB1dHMgSSB0aGluayB3ZSBjYW4gc3RvcCB1c2luZyB0aGlzIGRyaXZlcg0KYXMg
Z2VuZXJpYyBBMTUgc29sdXRpb24gKGF0IGxlYXN0IEkgd291bGQgbmVlZCBtb3JlIHRpbWUgdG8g
ZG8NCnRoZSByZWZhY3RvcmluZyBjb25zaWRlcmluZyBhbGwgcG9pbnRzIHlvdSBzdGF0ZWQgYW5k
IGV4cGVyaWVuY2VkIGFscmVhZHkpLg0KDQpUaGFua3MgYSBsb3QhDQoNCi0gV2xhZGlzbGF2DQoN
Cg==
