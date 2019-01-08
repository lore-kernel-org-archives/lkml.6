Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CBBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D572087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="aJB2cT4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfAHKD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:03:26 -0500
Received: from mail-eopbgr820083.outbound.protection.outlook.com ([40.107.82.83]:21472
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbfAHKDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahx7qfCera35HjApEewTwsweJ51Ku/Wd5k0fuPiuvzQ=;
 b=aJB2cT4QKOJynW3/pZkyCoLzrsB9YTrc3CK2u7Prxwli7EPu2luMojX0Ak86jpsgtoNPXL6ncsqGhrdU++vXBRAWV3CaYsjn1OxFmvNQTGOrNo1u4l1yzLOHWPAYJ+BigO8xidqq27gV0zxG/u2ccWNPGgcFUMSUi7dIRxVT0E8=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB4806.namprd05.prod.outlook.com (52.135.235.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.7; Tue, 8 Jan 2019 10:03:18 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919%4]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 10:03:18 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs
Thread-Topic: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs
Thread-Index: AQHUpMzbNXAv44HEJkWekrP09zgtYaWlKSaA
Date:   Tue, 8 Jan 2019 10:03:18 +0000
Message-ID: <182509fca5848141f1db96d32781d2c0daf0d206.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
         <20190105080108.14837-3-hch@lst.de>
In-Reply-To: <20190105080108.14837-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4806;20:2brlzVtv4wHRmUXfgB1NtLVBYw+P1ocmOVHtTLFELW5Kmq0BnCt2XF142QbTAHcPdvgAFd2GU2gxqooAME8P8CSMNrjsly9RefzXXT96Cj2ojumopyldSdbtIq3bNinoFK41MCn8cm20kNp4n7XUE7KQTIWbZpK+VqZQJcGp4K4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f59cf264-6402-4d9c-5fa9-08d6755083b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4806;
x-ms-traffictypediagnostic: BYAPR05MB4806:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB4806FF72C0636A0E63A2ACE2A18A0@BYAPR05MB4806.namprd05.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(189003)(229853002)(5660300001)(316002)(6486002)(186003)(99286004)(6506007)(97736004)(66066001)(4326008)(118296001)(2906002)(256004)(102836004)(71190400001)(71200400001)(8936002)(6246003)(25786009)(6916009)(54906003)(86362001)(2351001)(106356001)(105586002)(6436002)(3846002)(68736007)(36756003)(6116002)(14454004)(486006)(476003)(81166006)(81156014)(8676002)(1730700003)(7736002)(26005)(53936002)(305945005)(76176011)(2501003)(2616005)(6512007)(5640700003)(11346002)(446003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4806;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nCvZOMiWBS8a1nDGSm43szpj1uBMLkqf+8AYMxowhc6A7zsxlpgJi2usklpHFFYBuKbTszT7jAVYsQp560W1qspbyxBqUEtIi+hKcNrNmPvHk3AQHsvAjYigWwem2jGuYeXQo+Ygv7dsYZBxOytAhUhevPf753zSXxTZ17h4q9hkrQ7UVeL10CqsKyNGBkaROdakZCB6tuS00+rrbH8CxxvxDqbgqlHBWhA87cIq8QQKsYlsJia4qEbJ6sBUEBiZ7xYtDA0nrYAlX+27HFsO9PT1cyo5aHTSiiZtqYynVipzKBmvKdbjgrxdwQUXE+vW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CE4D785C13AE942ABC8EF2E355CE681@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59cf264-6402-4d9c-5fa9-08d6755083b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:03:18.5104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFRob21hcyBIZWxsc3Ryb20gPHRoZWxsc3Ryb21Adm13YXJlLmNvbT4NCg0K
T24gU2F0LCAyMDE5LTAxLTA1IGF0IDA5OjAxICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gaW50ZWxfaW9tbXVfZW5hYmxlZCBpcyBkZWZpbmVkIGFzIGFsd2F5cyBmYWxzZSBmb3IN
Cj4gIUNPTkZJR19JTlRFTF9JT01NVSwNCj4gc28gcmVtb3ZlIHRoZSBpZmRlZnMgYXJvdW5kIGl0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmMgfCAxOCAtLS0tLS0t
LS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jDQo+IGluZGV4IDY5ZTMyNWIyZDk1NC4uMjM2
MDUyYWQyMzNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9k
cnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KPiBAQCAt
NTY3LDEyICs1NjcsMTAgQEAgc3RhdGljIGludCB2bXdfZG1hX3NlbGVjdF9tb2RlKHN0cnVjdA0K
PiB2bXdfcHJpdmF0ZSAqZGV2X3ByaXYpDQo+ICAJCVt2bXdfZG1hX21hcF9iaW5kXSA9ICJHaXZp
bmcgdXAgRE1BIG1hcHBpbmdzIGVhcmx5LiJ9Ow0KPiAgCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29w
cyAqZG1hX29wcyA9IGdldF9kbWFfb3BzKGRldl9wcml2LT5kZXYtDQo+ID5kZXYpOw0KPiAgDQo+
IC0jaWZkZWYgQ09ORklHX0lOVEVMX0lPTU1VDQo+ICAJaWYgKGludGVsX2lvbW11X2VuYWJsZWQp
IHsNCj4gIAkJZGV2X3ByaXYtPm1hcF9tb2RlID0gdm13X2RtYV9tYXBfcG9wdWxhdGU7DQo+ICAJ
CWdvdG8gb3V0X2ZpeHVwOw0KPiAgCX0NCj4gLSNlbmRpZg0KPiAgDQo+ICAJaWYgKCEodm13X2Zv
cmNlX2lvbW11IHx8IHZtd19mb3JjZV9jb2hlcmVudCkpIHsNCj4gIAkJZGV2X3ByaXYtPm1hcF9t
b2RlID0gdm13X2RtYV9waHlzOw0KPiBAQCAtNTg5LDkgKzU4Nyw3IEBAIHN0YXRpYyBpbnQgdm13
X2RtYV9zZWxlY3RfbW9kZShzdHJ1Y3Qgdm13X3ByaXZhdGUNCj4gKmRldl9wcml2KQ0KPiAgCQlk
ZXZfcHJpdi0+bWFwX21vZGUgPSB2bXdfZG1hX21hcF9wb3B1bGF0ZTsNCj4gICNlbmRpZg0KPiAg
DQo+IC0jaWZkZWYgQ09ORklHX0lOVEVMX0lPTU1VDQo+ICBvdXRfZml4dXA6DQo+IC0jZW5kaWYN
Cj4gIAlpZiAoZGV2X3ByaXYtPm1hcF9tb2RlID09IHZtd19kbWFfbWFwX3BvcHVsYXRlICYmDQo+
ICAJICAgIHZtd19yZXN0cmljdF9pb21tdSkNCj4gIAkJZGV2X3ByaXYtPm1hcF9tb2RlID0gdm13
X2RtYV9tYXBfYmluZDsNCj4gQEAgLTU5OSwxMyArNTk1LDYgQEAgc3RhdGljIGludCB2bXdfZG1h
X3NlbGVjdF9tb2RlKHN0cnVjdA0KPiB2bXdfcHJpdmF0ZSAqZGV2X3ByaXYpDQo+ICAJaWYgKHZt
d19mb3JjZV9jb2hlcmVudCkNCj4gIAkJZGV2X3ByaXYtPm1hcF9tb2RlID0gdm13X2RtYV9hbGxv
Y19jb2hlcmVudDsNCj4gIA0KPiAtI2lmICFkZWZpbmVkKENPTkZJR19TV0lPVExCKSAmJiAhZGVm
aW5lZChDT05GSUdfSU5URUxfSU9NTVUpDQo+IC0JLyoNCj4gLQkgKiBObyBjb2hlcmVudCBwYWdl
IHBvb2wNCj4gLQkgKi8NCj4gLQlpZiAoZGV2X3ByaXYtPm1hcF9tb2RlID09IHZtd19kbWFfYWxs
b2NfY29oZXJlbnQpDQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiAtI2VuZGlmDQo+ICAJRFJNX0lO
Rk8oIkRNQSBtYXAgbW9kZTogJXNcbiIsIG5hbWVzW2Rldl9wcml2LT5tYXBfbW9kZV0pOw0KPiAg
DQo+ICAJcmV0dXJuIDA7DQo+IEBAIC02MTksNyArNjA4LDYgQEAgc3RhdGljIGludCB2bXdfZG1h
X3NlbGVjdF9tb2RlKHN0cnVjdCB2bXdfcHJpdmF0ZQ0KPiAqZGV2X3ByaXYpDQo+ICAgKiBXaXRo
IDMyLWJpdCB3ZSBjYW4gb25seSBoYW5kbGUgMzIgYml0IFBGTnMuIE9wdGlvbmFsbHkgc2V0IHRo
YXQNCj4gICAqIHJlc3RyaWN0aW9uIGFsc28gZm9yIDY0LWJpdCBzeXN0ZW1zLg0KPiAgICovDQo+
IC0jaWZkZWYgQ09ORklHX0lOVEVMX0lPTU1VDQo+ICBzdGF0aWMgaW50IHZtd19kbWFfbWFza3Mo
c3RydWN0IHZtd19wcml2YXRlICpkZXZfcHJpdikNCj4gIHsNCj4gIAlzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2ID0gZGV2X3ByaXYtPmRldjsNCj4gQEAgLTYzMSwxMiArNjE5LDYgQEAgc3RhdGljIGlu
dCB2bXdfZG1hX21hc2tzKHN0cnVjdCB2bXdfcHJpdmF0ZQ0KPiAqZGV2X3ByaXYpDQo+ICAJfQ0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtI2Vsc2UNCj4gLXN0YXRpYyBpbnQgdm13X2RtYV9tYXNr
cyhzdHJ1Y3Qgdm13X3ByaXZhdGUgKmRldl9wcml2KQ0KPiAtew0KPiAtCXJldHVybiAwOw0KPiAt
fQ0KPiAtI2VuZGlmDQo+ICANCj4gIHN0YXRpYyBpbnQgdm13X2RyaXZlcl9sb2FkKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGxvbmcNCj4gY2hpcHNldCkNCj4gIHsNCg==
