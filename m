Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E25BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ADC20578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="MDQ7Dzuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405958AbfAPRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:22:43 -0500
Received: from mail-eopbgr690100.outbound.protection.outlook.com ([40.107.69.100]:21952
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387981AbfAPRWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZOMISEhY0nrH6P7ELSydhhV6T/hI+MU0cAnjro2NxY=;
 b=MDQ7Dzuf6VNLKLckYvI5sm9YfRhjs5ChGSGTrBiBqaeNe7MbKnPkRhrYEGayQ2vtGEI0c0BdqHRhScs5Hp9OFI3fYOsu6cyLfCn6Pmu1AXfvBfcTuKgYJWxQJ6jHsfxRCUlj8ricXDzbN52R8oiYzCNk2emdbhkWAbbB/MgEC60=
Received: from DM6PR02MB5978.namprd02.prod.outlook.com (20.179.69.142) by
 DM6PR02MB4492.namprd02.prod.outlook.com (20.176.107.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Wed, 16 Jan 2019 17:22:37 +0000
Received: from DM6PR02MB5978.namprd02.prod.outlook.com
 ([fe80::443d:c354:514a:a682]) by DM6PR02MB5978.namprd02.prod.outlook.com
 ([fe80::443d:c354:514a:a682%4]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 17:22:37 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>
CC:     "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH lora-next 2/4] dt-bindings: lora: sx125x: add basic
 documentation
Thread-Topic: [PATCH lora-next 2/4] dt-bindings: lora: sx125x: add basic
 documentation
Thread-Index: AQHUpy4ag5vdTIUsLUiehCu2BeCdD6WrBREAgAciLJA=
Date:   Wed, 16 Jan 2019 17:22:37 +0000
Message-ID: <DM6PR02MB5978A80E5B4BEF52B8E13E95E7820@DM6PR02MB5978.namprd02.prod.outlook.com>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
 <20190108084132.10214-2-ben.whitten@gmail.com>
 <20191f9a-46b9-2ad1-d56b-7af302589f93@suse.de>
In-Reply-To: <20191f9a-46b9-2ad1-d56b-7af302589f93@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4492;6:fnGwckM5kuKGrD9hhx4V5QeBbuQ4IqQ4g/daYJz6eIOeWqNx9oaaIX7S5xAiZDVR7EFxRh7ALLdDv9Z7d7ozBRv189+ttFmdllvGcsqTyd1t2JqYjhF6dlZtvHWkZQzykp/wHXVl8XJEft+um/4oAkHD3OfeMRTQVBah/XZFkvPpU8b0Al4m5PIspNWZljgKCTLh4p01+mT3vjy58H+238fGvsJfIMUg69l0vEuRRxhbtZ2JQpjPdObieFXHcblZ0+aohvIh7FOOnJ29HZn0YRLkFdYRLAyEJlgXW0XKpkhAHd7gx4LmS3/pkS/MWJZdIP6+EOKkG47NlHRPbsU71aFD8r7puBsW6hi7Y1C/GjKFUo0QQO/4s4DrR1Td8S/Zo1K+jqfCqYHsw6fp0yFWD1Bdohwo9FqhiTBhCQK6oGF89EyIXlEuyOoaYVs+TU/d4ZXgDFeDtdZkc4aqbJTxfw==;5:TfxH31lNP5f1xLhpkzRK3DJwn0Fvm8CQ3ys3RaKGTyI2xk3ZRcXcJ9c8uP2FBv1IFgZQW12Sefzzj3/VpGQh/lGNnCXGa4ZptKH5J8XaCzHd2kOuLF8Fe6qhDN+9FFBlz0YeMYd1izCUSBy6QtA03Yeuz4G6HfumXxq1diE0gyqFfzMVwm6OwEDJnhWUCZzJn7C/gKR/5mlTqNesXQTRUw==;7:ql3KhaJ2sH0+T94Ds6Y0DVHGHvPMYD83JtWoLH/9VcfBgbrILiSeGkaFVHTVy0rpe/xAQUTTBUL4uR1Sd8CNdrISpDVDaYgxeHn3gt79G4YITFOFUGLl3tejf1/zn8oFk7rxK7V62mNoLDWI7zpc9g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 426c3397-d3f5-4c92-ce19-08d67bd735fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4492;
x-ms-traffictypediagnostic: DM6PR02MB4492:
x-microsoft-antispam-prvs: <DM6PR02MB4492C3D1FC18E1ABC7F7ACC9E7820@DM6PR02MB4492.namprd02.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(71190400001)(6506007)(72206003)(6116002)(186003)(7696005)(66574012)(3846002)(8936002)(478600001)(54906003)(305945005)(76176011)(9686003)(81166006)(25786009)(6246003)(5660300001)(8676002)(71200400001)(55016002)(7736002)(316002)(14454004)(966005)(53936002)(6306002)(99286004)(110136005)(81156014)(476003)(6436002)(2906002)(66066001)(256004)(26005)(446003)(11346002)(33656002)(229853002)(68736007)(14444005)(53376002)(105586002)(4326008)(86362001)(97736004)(39060400002)(74316002)(486006)(106356001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR02MB4492;H:DM6PR02MB5978.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r9ljsFx3ZzHYhN1lqFh314d07YZbJy26xku70r7fIAkQJo36ryLZ9mscIddDxh9k3R/MiziKmHJRsYvi7/urDr9OpvWqVxIYTSJssscyLxVvyV5oJS32yZKI59IftieXhFx1Apr/10PjLHW8hRYs59gKFqGkbf0vONLUpWcR0e68hyImKuJicu+RbwPugUraB5ucNAf9UWAR1yeqYhIDXYwLz1DcQSRchzo6J6veomiunKhxb2/OpmnuGgUXCXx9+/IMxwFQFED1uEmzf9Kg61Rv55Llq3DFDkHK2g/ces5QOA7m19Qb5kS3JwayRLmIvpJsmyPc/4z3svCHF6sdCGEPKF0gOnP38M9zGt+8nZO/lbAzQ9ZrD8GmrARiNiDM6WPGaiTVb1nVhH2QDxt7nzLSOzRb99zLfTZajBxDqrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426c3397-d3f5-4c92-ce19-08d67bd735fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 17:22:37.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiBBbSAwOC4wMS4xOSB1bSAwOTo0MSBzY2hyaWViIEJlbiBXaGl0dGVu
Og0KPiA+IFRoZSBzeDEyNXggZmFtaWx5IGFyZSBJUSByYWRpbyB0cmFuc2NlaXZlcnMgZnJvbSBT
ZW10ZWNoIGNvbmZpZ3VyZWQgb3Zlcg0KPiA+IFNQSSwgdGhleSBhcmUgdHlwaWNhbGx5IGNvbm5l
Y3RlZCB0byBhbiBzeDEzMHggc2VyaWVzIGNvbmNlbnRyYXRvciBob3dldmVyDQo+ID4gbWF5IGJl
IGNvbm5lY3RlZCB0byBhIGhvc3QgZGlyZWN0bHkuDQo+IA0KPiAiU1gxMjV4IiBhbmQgIlNYMTMw
eCINCj4gDQo+ID4NCj4gPiBSZXF1aXJlZCBwcm9wZXJ0aWVzIGluY2x1ZGUgdGhlIHJhZGlvIG51
bWJlciBvZiB0aGUgaG9zdCBvciBjb25jZW50cmF0b3INCj4gPiBidXMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBCZW4gV2hpdHRlbiA8YmVuLndoaXR0ZW5AZ21haWwuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYmluZGluZ3MvbG9yYS9zZW10ZWNoLHN4MTI1eC55YW1sICAgICAgICAgfCA0NSAr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbG9yYS9zZW10ZWNoLHN4MTI1eC55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2xvcmEvc2VtdGVjaCxzeDEyNXgueWFtbA0K
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9sb3JhL3NlbXRlY2gsc3gxMjV4
LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4u
NWVhZGVjODYwYjcwDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9sb3JhL3NlbXRlY2gsc3gxMjV4LnlhbWwNCj4gPiBAQCAtMCww
ICsxLDQ1IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiAr
JVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL2xvcmEvc2VtdGVjaCxzeDEyNXgueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogU2Vt
dGVjaCBJUSBtb2R1bGF0b3IvZGUtbW9kdWxhdG9yIHRyYW5zZWl2ZXINCj4gPiArDQo+ID4gK21h
aW50YWluZXJzOg0KPiA+ICsgIC0gQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0K
PiA+ICsgIC0gQmVuIFdoaXR0ZW4gPGJlbi53aGl0dGVuQGdtYWlsLmNvbT4NCj4gPiArDQo+ID4g
K2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhlIHN4MTI1eCBmYW1pbHkgYXJlIGhpZ2hseSBpbnRl
Z3JhdGVkIFJGIGZyb250LWVuZCB0byBkaWdpdGFsIEkgYW5kIFENCj4gPiArICBtb2R1bGF0b3Iv
ZGVtb2R1bGF0b3IgTXVsdGktUEhZIG1vZGUgdHJhbnNjZWl2ZXIgY2FwYWJsZSBvZg0KPiBzdXBw
b3J0aW5nDQo+ID4gKyAgbXVsdGlwbGUgY29uc3RhbnQgYW5kIG5vbi1jb25zdGFudCBlbnZlbG9w
ZSBtb2R1bGF0aW9uIHNjaGVtZXMuDQo+IA0KPiAiU1gxMjV4Ig0KPiANCj4gImFyZSAuLi4gdHJh
bnNjZWl2ZXJzIg0KPiANCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJs
ZToNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgLSBz
ZW10ZWNoLHN4MTI1NQ0KPiA+ICsgICAgICAgIC0gc2VtdGVjaCxzeDEyNTcNCj4gPiArICAgICAg
ICAtIHNlbXRlY2gsc3gxMjU4DQo+IA0KPiBEbyB3ZSBuZWVkIGFsbCB0aHJlZT8gUHJvYmFibHkg
eWVzIGZvciB0aGUgY29uY2VudHJhdG9yIHRvIG1ha2UgZGVjaXNpb25zPw0KDQpXZSBjYW4gcHJv
YmUgdGhlIGRldmljZSB2ZXJzaW9uIGZyb20gdGhlIGNvbmNlbnRyYXRvciBvciBhIGhvc3QsIGJ1
dCBpZiBJIHJlY2FsbA0KZnJvbSBhIHByZXZpb3VzIHJldmlldyB3ZSBzaG91bGQgbm90IHJlbHkg
b24gdGhlIHZlcnNpb24gcmVnaXN0ZXIgZm9yIG1ha2luZw0KZGVjaXNpb25zLg0KVGhlIHZlcnNp
b24gcmVnaXN0ZXIgb2YgdGhlIFNYMTI1NyBoYXMgYmVlbiBtaXNzZWQgZnJvbSB0aGUgcHVibGlj
IGRhdGFzaGVldA0KKGFsdGhvdWdoIGV4aXN0cykgYW5kIHRoZSBleGlzdGluZyBjb25jZW50cmF0
b3IgSEFMIGRvZXMgbm90IG1ha2UgZGVjaXNpb25zDQpiYXNlZCBvbiB0aGUgdmVyc2lvbiByZWdp
c3RlciB2YWx1ZS4NCkJldHRlciB0byBiZSBleHBsaWNpdCBpbiB0aGUgRFQgYW5kIGxldCB0aGUg
ZHJpdmVyIHVzZSB0aGF0Lg0KDQo+IA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBjaGlwIHNlbGVjdCBvbiB0aGUgU1BJ
IGJ1cyBvciByYWRpbyBudW1iZXIgaW4NCj4gY29uY2VudHJhdG9yLg0KPiANCj4gIiwgd2l0aCBy
YWRpbyBBID0gMCBhbmQgcmFkaW8gQiA9IDEuIg0KPiANCj4gPiArDQo+ID4gKyAgc3BpLW1heC1m
cmVxdWVuY3k6DQo+ID4gKyAgICBtYXhpbXVtOiAxMDAwMDAwMA0KPiA+ICsgICAgZGVmYXVsdDog
ODAwMDAwMA0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBmcmVxdWVuY3kgb2YgdGhlIFNQSSBj
b21tdW5pY2F0aW9uIHRvIHRoZSByYWRpbywNCj4gPiArICAgICAgaW4gSHouIE1heGltdW0gU1BJ
IGZyZXF1ZW5jeSBpcyAxME1Iei4NCj4gDQo+IElmIG9uIHRoZSBjb25jZW50cmF0b3IncyBTUEkg
YnVzIHRoZW4gdGhpcyBpcyB1bnVzZWQuIFlvdSBkb24ndCBtYXJrIGl0DQo+IHJlcXVpcmVkIGJl
bG93LCBzbyBtYXliZSBhZGQgYSB0ZXh0dWFsIG5vdGU/DQoNCkFzIHdpdGggU1gxMzB4IGNvbW1l
bnQsIHRoaXMgc2hvdWxkIGJlIGNvdmVyZWQgaW4gY29tbW9uIFNQSSBiaW5kaW5ncw0KYW55b25l
IGNvbm5lY3RpbmcgZGlyZWN0bHkgdG8gc3BpIHdpbGwgaW5oZXJpdCB0aGF0LCBhbmQgdGhlbiBh
bnlvbmUgdXNpbmcNCmNvbmNlbnRyYXRvciB3aWxsIG5vdCByZXF1aXJlIGl0IHNvIHdlIGNhbiBk
cm9wIHRoaXMuDQoNCj4gDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGli
bGUNCj4gPiArICAtIHJlZw0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4g
KyAgICByYWRpbzA6IGxvcmFAMCB7DQo+ID4gKyAgICAgIGNvbXBhdGlibGUgPSAic2VtdGVjaCxz
eDEyNTciOw0KPiA+ICsgICAgICByZWcgPSA8MD47DQo+ID4gKyAgICB9Ow0KPiANCj4gSWYgeW91
IGNvbXBhcmUgbXkgc3gxMjd4IGltcGxlbWVudGF0aW9uLCBzaG91bGQgd2UgcHJlcGFyZSBhDQo+
ICJyYWRpby1mcmVxdWVuY3kiIChvciAicmFkaW8tY2VudGVyLWZyZXF1ZW5jeSIpIHByb3BlcnR5
IGZvciB0aGUNCj4gYW50ZW5uYSwgdG8gcHJlY29uZmlndXJlIHRoZSBkcml2ZXIgZHVyaW5nIHBy
b2JlPyBDb250ZW50cyB3b3VsZCB0aGVuIGJlDQo+IDw4NjgwMDAwMDA+LCBmb3IgZXhhbXBsZS4N
Cg0KSSBkb27igJl0IGtub3cgdGhlIHBvbGljeSBvZiBjb25maWd1cmF0aW9uIGluIERULg0KSXMg
dGhlIHZhbHVlIGEgaGFyZHdhcmUgcHJvcGVydHkgb2YgdGhlIGFudGVubmE/IENvdWxkIHdlIGNh
bGwgaXQNCiJhbnRlbm5hLWZyZXF1ZW5jeSIgb3IgImJhbmR3aWR0aCIgYW5kIGdpdmUgaXQgYSBo
aWdoIGxvdyBwb2ludD8NCldoaWxzdCBjb25zaWRlcmluZyBhbnRlbm5hIHByb3BlcnRpZXMgd2Ug
c2hvdWxkIGluY2x1ZGUgYSBnYWluIHZhbHVlIGFzDQp0aGF0IGFmZmVjdHMgdGhlIHJhZGlhdGVk
IHBvd2VyIGF0IGEgZ2l2ZW4gdHJhbnNtaXQgcG93ZXIsIGZvb2QgZm9yIHRob3VnaA0Kd2hlbiB3
ZSBjb21lIHRvIHJlZ3VsYXRvcnkgZGIuDQoNClRoYW5rcywNCkJlbiBXaGl0dGVuDQo=
