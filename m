Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4010AC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA158206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fuLpKRz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA158206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeILS3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:29:24 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:60192
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbeILS3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8T2cXGIKwr8gDHd5yLFpQQilOeaRRtiDH3DfrP6JdA=;
 b=fuLpKRz8+pu08+tmxrwP5Eetvxe5/MEdJlDh0xCbwC2iQxWrXBYXFgC1xtzQFmCepU02F4BrgWQxvkQg6gb6G9bMzggvVA1Yudp7E2wJoUVpaTC4JV+kyNp6p2I8uu266GDCnIscIu0MAnlKh52O/t69eRYiQzMmc9mTyOba2ps=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0825.namprd21.prod.outlook.com (10.173.172.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Wed, 12 Sep 2018 13:24:46 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Wed, 12 Sep 2018
 13:24:46 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
Thread-Topic: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
Thread-Index: AQHUSWAeSChqLALUF0mBg+l7iw5UuaTspTCA
Date:   Wed, 12 Sep 2018 13:24:46 +0000
Message-ID: <f7ec05ea-d16a-ded1-ceb7-5405eb32b40b@microsoft.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234341.4068.26882.stgit@localhost.localdomain>
In-Reply-To: <20180910234341.4068.26882.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0825;6:Y1tFXc3zNdmVX9seOy4NF/GVA8V8kMzNqoKj+7cSjXlSqMKZnXuh09Pj1z/O4lDacfiu9itBJBZQrygccL0f1aiAiwMMExIUBL6rU+c5Qbf+M5H1goEBy5YsxTlkWf+GVfeLbWpAUzknh5ahx8Ob2r5iVNgYOiRbE70oxFOrdJP5ATEWapaGczLna1DALI8zJnPVtSqmZOlovGjbWiia20Qa86NnZvuc11m/BReePHxLkm9U+cISPR1VU/yoggjNMoCnxADNjQ6vhEPKXisitxu2tLaSFLcePgXUAm72gFNl6ehvVmvVseZWKbbfIgwktZ3Pb4viEK2x5d7+Gfr2ZHZHUyh+lAsgQPuv61BO7swvyIzHmGEw2IczOtNLhkS7l13JIuizgkn+D0p/F99PjpwoWyhF+qcG60pjoJmRhnptuRpkHnLl2+HatazJXKEFSV2QPgrdg6zH8LNt0YfkmQ==;5:h/WvDUVHt1850sDRKrjuDJPdGxkOCU+ZY3NRnqjVQVhjjIw7vBHirUodbOeXrnb6C89JzbzlYQq1NB1U3w6S+YokOsOHQncu1ISNKpsyHrjhUe6Mtbi94cwSHtUYkW9AZU4fcaeteAm1S8crgvt7hmP9jsVxsFE7bF1hLPAIZA4=;7:aFiwvi0XkehJwJzxrzM4c4x/Oime/Xwep21GQiYPpu43RoVNAJ47Sm1htK5Kb5n+049yHkYvIUq1yAV4w3xxkQBhW0lWTxIqw1TsZA0IgCwV2o5mXzngzYANkqH8TQIapEnu/vc0B+eHhU1kXxQ6cYo43ce+96Xwveq8WEy1HvEXD9jqz1m4NLeh9nYchcKqfdMh/fNAx+usVvw+RetNsV3AdHcF9duKnJka/SVu3OzM+1bxzDpjcsti6+BDa0kX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8389a296-f357-409a-8c9d-08d618b31c20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0825;
x-ms-traffictypediagnostic: DM5PR21MB0825:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0825C597B3827AF3896DCA659D1B0@DM5PR21MB0825.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0825;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0825;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(14444005)(256004)(6486002)(446003)(229853002)(6436002)(11346002)(2201001)(86362001)(575784001)(54906003)(36756003)(110136005)(31696002)(86612001)(4326008)(10290500003)(72206003)(478600001)(6246003)(14454004)(99286004)(39060400002)(97736004)(486006)(25786009)(476003)(2616005)(2501003)(76176011)(5250100002)(2900100001)(316002)(106356001)(31686004)(105586002)(26005)(81156014)(81166006)(186003)(66066001)(102836004)(10090500001)(22452003)(6506007)(53546011)(2906002)(8936002)(3846002)(6116002)(53936002)(8676002)(5660300001)(7736002)(7416002)(305945005)(6512007)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0825;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 02AvR/SL5ko1q1HKheOcmRPC9MBMpCOwPrQaO7XjkAVRcotidvjrGbX1+ponB8pjvnefUeYBv48xssyUnvL+vLVX8QC3igQK6/MxKM55D7ZpekXUPLZHYF33f/KGubOrOIAStgHXl3MU2Os1lloAAuaqtoEqcLKCn9equcTw9BM51dmYtuWNSnA7Q3TynDcD4qRR2BNECYHfMVZrg9fKGgNeLFTSo4tJvvAD26BfWYWNdasMKQ/Zdj4dp4QxY6qIzPLdXvecMvg4YZUgBV5+MJaL7eg1i9ETEHx9XnZYhI4/zbgSukg2inS0T/6sELoXrrFg0LBPbtQQtupZDU6Vyy32PFI0kJ0cjb0Z2W9rKK4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D396A1328C7D45A6C1B457324FB838@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8389a296-f357-409a-8c9d-08d618b31c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 13:24:46.8210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0825
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTAvMTggNzo0MyBQTSwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPiBGcm9tOiBB
bGV4YW5kZXIgRHV5Y2sgPGFsZXhhbmRlci5oLmR1eWNrQGludGVsLmNvbT4NCj4gDQo+IE9uIHN5
c3RlbXMgd2l0aCBhIGxhcmdlIGFtb3VudCBvZiBtZW1vcnkgaXQgY2FuIHRha2UgYSBzaWduaWZp
Y2FudCBhbW91bnQNCj4gb2YgdGltZSB0byBpbml0aWFsaXplIGFsbCBvZiB0aGUgcGFnZSBzdHJ1
Y3RzIHdpdGggdGhlIFBBR0VfUE9JU09OX1BBVFRFUk4NCj4gdmFsdWUuIEkgaGF2ZSBzZWVuIGl0
IHRha2Ugb3ZlciAyIG1pbnV0ZXMgdG8gaW5pdGlhbGl6ZSBhIHN5c3RlbSB3aXRoDQo+IG92ZXIg
MTJHQiBvZiBSQU0uDQo+IA0KPiBJbiBvcmRlciB0byB3b3JrIGFyb3VuZCB0aGUgaXNzdWUgSSBo
YWQgdG8gZGlzYWJsZSBDT05GSUdfREVCVUdfVk0gYW5kIHRoZW4NCj4gdGhlIGJvb3QgdGltZSBy
ZXR1cm5lZCB0byBzb21ldGhpbmcgbXVjaCBtb3JlIHJlYXNvbmFibGUgYXMgdGhlDQo+IGFyY2hf
YWRkX21lbW9yeSBjYWxsIGNvbXBsZXRlZCBpbiBtaWxsaXNlY29uZHMgdmVyc3VzIHNlY29uZHMu
IEhvd2V2ZXIgaW4NCj4gZG9pbmcgdGhhdCBJIGhhZCB0byBkaXNhYmxlIGFsbCBvZiB0aGUgb3Ro
ZXIgVk0gZGVidWdnaW5nIG9uIHRoZSBzeXN0ZW0uDQo+IA0KPiBJbiBvcmRlciB0byB3b3JrIGFy
b3VuZCBhIGtlcm5lbCB0aGF0IG1pZ2h0IGhhdmUgQ09ORklHX0RFQlVHX1ZNIGVuYWJsZWQgb24N
Cj4gYSBzeXN0ZW0gdGhhdCBoYXMgYSBsYXJnZSBhbW91bnQgb2YgbWVtb3J5IEkgaGF2ZSBhZGRl
ZCBhIG5ldyBrZXJuZWwNCj4gcGFyYW1ldGVyIG5hbWVkICJwYWdlX2luaXRfcG9pc29uIiB0aGF0
IGNhbiBiZSBzZXQgdG8gIm9mZiIgaW4gb3JkZXIgdG8NCj4gZGlzYWJsZSBpdC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyLmguZHV5Y2tAaW50ZWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogUGF2ZWwgVGF0YXNoaW4gPHBhdmVsLnRhdGFzaGluQG1pY3Jvc29m
dC5jb20+DQoNClRoYW5rIHlvdSwNClBhdmVsDQoNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2Fk
bWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8ICAgIDggKysrKysrKysNCj4gIGluY2x1
ZGUvbGludXgvcGFnZS1mbGFncy5oICAgICAgICAgICAgICAgICAgICAgIHwgICAgOCArKysrKysr
Kw0KPiAgbW0vZGVidWcuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDE2ICsrKysrKysrKysrKysrKysNCj4gIG1tL21lbWJsb2NrLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgNSArKy0tLQ0KPiAgbW0vc3BhcnNlLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0ICstLS0NCj4gIDUgZmlsZXMgY2hhbmdlZCwg
MzUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+IGluZGV4IDY0YTNiZjU0Yjk3
NC4uN2IyMWUwYjljMzk0IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiBAQCAtMzA0Nyw2ICszMDQ3LDE0IEBADQo+ICAJCQlv
ZmY6IHR1cm4gb2ZmIHBvaXNvbmluZyAoZGVmYXVsdCkNCj4gIAkJCW9uOiB0dXJuIG9uIHBvaXNv
bmluZw0KPiAgDQo+ICsJcGFnZV9pbml0X3BvaXNvbj0JW0tOTF0gQm9vdC10aW1lIHBhcmFtZXRl
ciBjaGFuZ2luZyB0aGUNCj4gKwkJCXN0YXRlIG9mIHBvaXNvbmluZyBvZiBwYWdlIHN0cnVjdHVy
ZXMgZHVyaW5nIGVhcmx5DQo+ICsJCQlib290LiBVc2VkIHRvIHZlcmlmeSBwYWdlIG1ldGFkYXRh
IGlzIG5vdCBhY2Nlc3NlZA0KPiArCQkJcHJpb3IgdG8gaW5pdGlhbGl6YXRpb24uIEF2YWlsYWJs
ZSB3aXRoDQo+ICsJCQlDT05GSUdfREVCVUdfVk09eS4NCj4gKwkJCW9mZjogdHVybiBvZmYgcG9p
c29uaW5nDQo+ICsJCQlvbjogdHVybiBvbiBwb2lzb25pbmcgKGRlZmF1bHQpDQo+ICsNCj4gIAlw
YW5pYz0JCVtLTkxdIEtlcm5lbCBiZWhhdmlvdXIgb24gcGFuaWM6IGRlbGF5IDx0aW1lb3V0Pg0K
PiAgCQkJdGltZW91dCA+IDA6IHNlY29uZHMgYmVmb3JlIHJlYm9vdGluZw0KPiAgCQkJdGltZW91
dCA9IDA6IHdhaXQgZm9yZXZlcg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wYWdlLWZs
YWdzLmggYi9pbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaA0KPiBpbmRleCA3NGJlZThjZWNmNGMu
LmQwMDIxNmNmMDBmOCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgNCj4gQEAgLTE2Miw2ICsxNjIsMTQg
QEAgc3RhdGljIGlubGluZSBpbnQgUGFnZVBvaXNvbmVkKGNvbnN0IHN0cnVjdCBwYWdlICpwYWdl
KQ0KPiAgCXJldHVybiBwYWdlLT5mbGFncyA9PSBQQUdFX1BPSVNPTl9QQVRURVJOOw0KPiAgfQ0K
PiAgDQo+ICsjaWZkZWYgQ09ORklHX0RFQlVHX1ZNDQo+ICt2b2lkIHBhZ2VfaW5pdF9wb2lzb24o
c3RydWN0IHBhZ2UgKnBhZ2UsIHNpemVfdCBzaXplKTsNCj4gKyNlbHNlDQo+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgcGFnZV9pbml0X3BvaXNvbihzdHJ1Y3QgcGFnZSAqcGFnZSwgc2l6ZV90IHNpemUp
DQo+ICt7DQo+ICt9DQo+ICsjZW5kaWYNCj4gKw0KPiAgLyoNCj4gICAqIFBhZ2UgZmxhZ3MgcG9s
aWNpZXMgd3J0IGNvbXBvdW5kIHBhZ2VzDQo+ICAgKg0KPiBkaWZmIC0tZ2l0IGEvbW0vZGVidWcu
YyBiL21tL2RlYnVnLmMNCj4gaW5kZXggMzhjOTI2NTIwYzk3Li5jNTQyMDQyMmMwYjUgMTAwNjQ0
DQo+IC0tLSBhL21tL2RlYnVnLmMNCj4gKysrIGIvbW0vZGVidWcuYw0KPiBAQCAtMTc1LDQgKzE3
NSwyMCBAQCB2b2lkIGR1bXBfbW0oY29uc3Qgc3RydWN0IG1tX3N0cnVjdCAqbW0pDQo+ICAJKTsN
Cj4gIH0NCj4gIA0KPiArc3RhdGljIGJvb2wgcGFnZV9pbml0X3BvaXNvbmluZyBfX3JlYWRfbW9z
dGx5ID0gdHJ1ZTsNCj4gKw0KPiArc3RhdGljIGludCBfX2luaXQgcGFnZV9pbml0X3BvaXNvbl9w
YXJhbShjaGFyICpidWYpDQo+ICt7DQo+ICsJaWYgKCFidWYpDQo+ICsJCXJldHVybiAtRUlOVkFM
Ow0KPiArCXJldHVybiBzdHJ0b2Jvb2woYnVmLCAmcGFnZV9pbml0X3BvaXNvbmluZyk7DQo+ICt9
DQo+ICtlYXJseV9wYXJhbSgicGFnZV9pbml0X3BvaXNvbiIsIHBhZ2VfaW5pdF9wb2lzb25fcGFy
YW0pOw0KPiArDQo+ICt2b2lkIHBhZ2VfaW5pdF9wb2lzb24oc3RydWN0IHBhZ2UgKnBhZ2UsIHNp
emVfdCBzaXplKQ0KPiArew0KPiArCWlmIChwYWdlX2luaXRfcG9pc29uaW5nKQ0KPiArCQltZW1z
ZXQocGFnZSwgUEFHRV9QT0lTT05fUEFUVEVSTiwgc2l6ZSk7DQo+ICt9DQo+ICtFWFBPUlRfU1lN
Qk9MX0dQTChwYWdlX2luaXRfcG9pc29uKTsNCj4gICNlbmRpZgkJLyogQ09ORklHX0RFQlVHX1ZN
ICovDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1ibG9jay5jIGIvbW0vbWVtYmxvY2suYw0KPiBpbmRl
eCAyMzc5NDQ0NzlkMjUuLmE4NTMxNTA4M2I1YSAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtYmxvY2su
Yw0KPiArKysgYi9tbS9tZW1ibG9jay5jDQo+IEBAIC0xNDQ0LDEwICsxNDQ0LDkgQEAgdm9pZCAq
IF9faW5pdCBtZW1ibG9ja192aXJ0X2FsbG9jX3RyeV9uaWRfcmF3KA0KPiAgDQo+ICAJcHRyID0g
bWVtYmxvY2tfdmlydF9hbGxvY19pbnRlcm5hbChzaXplLCBhbGlnbiwNCj4gIAkJCQkJICAgbWlu
X2FkZHIsIG1heF9hZGRyLCBuaWQpOw0KPiAtI2lmZGVmIENPTkZJR19ERUJVR19WTQ0KPiAgCWlm
IChwdHIgJiYgc2l6ZSA+IDApDQo+IC0JCW1lbXNldChwdHIsIFBBR0VfUE9JU09OX1BBVFRFUk4s
IHNpemUpOw0KPiAtI2VuZGlmDQo+ICsJCXBhZ2VfaW5pdF9wb2lzb24ocHRyLCBzaXplKTsNCj4g
Kw0KPiAgCXJldHVybiBwdHI7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL21tL3NwYXJzZS5j
IGIvbW0vc3BhcnNlLmMNCj4gaW5kZXggMTBiMDdlZWE5YTZlLi42N2FkMDYxZjdmYjggMTAwNjQ0
DQo+IC0tLSBhL21tL3NwYXJzZS5jDQo+ICsrKyBiL21tL3NwYXJzZS5jDQo+IEBAIC02OTYsMTMg
KzY5NiwxMSBAQCBpbnQgX19tZW1pbml0IHNwYXJzZV9hZGRfb25lX3NlY3Rpb24oc3RydWN0IHBn
bGlzdF9kYXRhICpwZ2RhdCwNCj4gIAkJZ290byBvdXQ7DQo+ICAJfQ0KPiAgDQo+IC0jaWZkZWYg
Q09ORklHX0RFQlVHX1ZNDQo+ICAJLyoNCj4gIAkgKiBQb2lzb24gdW5pbml0aWFsaXplZCBzdHJ1
Y3QgcGFnZXMgaW4gb3JkZXIgdG8gY2F0Y2ggaW52YWxpZCBmbGFncw0KPiAgCSAqIGNvbWJpbmF0
aW9ucy4NCj4gIAkgKi8NCj4gLQltZW1zZXQobWVtbWFwLCBQQUdFX1BPSVNPTl9QQVRURVJOLCBz
aXplb2Yoc3RydWN0IHBhZ2UpICogUEFHRVNfUEVSX1NFQ1RJT04pOw0KPiAtI2VuZGlmDQo+ICsJ
cGFnZV9pbml0X3BvaXNvbihtZW1tYXAsIHNpemVvZihzdHJ1Y3QgcGFnZSkgKiBQQUdFU19QRVJf
U0VDVElPTik7DQo+ICANCj4gIAlzZWN0aW9uX21hcmtfcHJlc2VudChtcyk7DQo+ICAJc3BhcnNl
X2luaXRfb25lX3NlY3Rpb24obXMsIHNlY3Rpb25fbnIsIG1lbW1hcCwgdXNlbWFwKTsNCj4g
