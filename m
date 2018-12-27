Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A77BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C097214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U3uxqVzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbeL0QF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:05:27 -0500
Received: from mail-eopbgr00126.outbound.protection.outlook.com ([40.107.0.126]:64249
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbeL0QF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 11:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me8jkYuVSX5fLupRg/jLn3Ntvou6A3lIbsXZ2COgaiI=;
 b=U3uxqVzTABsluhcfwSq33fPO9B1Q/BfHxEdIsYroTyYddnBgURgW9Iw+/RQ5Gps+vYTTOFAc3qyA5MiDinazLbZUb9FCJe7v63LsF520mQHMHN5dVO27sgu63EHTqti97P0zYBNQ9Rb+fuYfLmzIwgM4dhlJqPJnFiMJtvGO0QI=
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com (52.133.15.22) by
 VI1PR08MB2832.eurprd08.prod.outlook.com (10.175.245.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Thu, 27 Dec 2018 16:05:18 +0000
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067]) by VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067%4]) with mapi id 15.20.1446.027; Thu, 27 Dec 2018
 16:05:18 +0000
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] mm/page_alloc: add a warning about high order
 allocations
Thread-Topic: [PATCH 1/1] mm/page_alloc: add a warning about high order
 allocations
Thread-Index: AQHUnGgIyodB/Y8cUEqX+oBj8nW9U6WQtJmAgAIOgYA=
Date:   Thu, 27 Dec 2018 16:05:18 +0000
Message-ID: <12c71c7a-7896-df73-7ab4-eab5b6fc1fb0@virtuozzo.com>
References: <20181225153927.2873-1-khorenko@virtuozzo.com>
 <20181225153927.2873-2-khorenko@virtuozzo.com>
 <20181226084051.GH16738@dhcp22.suse.cz>
In-Reply-To: <20181226084051.GH16738@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:7:67::17) To VI1PR08MB3117.eurprd08.prod.outlook.com
 (2603:10a6:803:46::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB2832;20:M2xkp/CTEZzpz4c2Szz4NvX8OqfvGYPL8CgtoKh+l+wkq2eMhAZDZnTYdbVZ3bCLDX5/KY9wZQbDDPU/UiazPuNBCvweWaGyXTtLe0uF0sJt+Z3PS3JcdDpY8MLC3BokHdEe5OnW4adnE9IxWKpUNxDVWl7sDJm+gqoGHZT4nVo=
x-ms-office365-filtering-correlation-id: dbae7d81-a2ec-4b3e-abda-08d66c151897
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2832;
x-ms-traffictypediagnostic: VI1PR08MB2832:
x-microsoft-antispam-prvs: <VI1PR08MB28327B79F2E95B3D5CF6A41CC8B60@VI1PR08MB2832.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220047)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB2832;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2832;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(376002)(346002)(136003)(54534003)(199004)(189003)(99286004)(97736004)(486006)(478600001)(6436002)(476003)(2616005)(14454004)(446003)(11346002)(3846002)(6116002)(86362001)(54906003)(31696002)(6486002)(6916009)(2906002)(66066001)(71200400001)(36756003)(5660300001)(71190400001)(102836004)(4326008)(6246003)(6512007)(26005)(305945005)(76176011)(52116002)(386003)(25786009)(81156014)(106356001)(105586002)(186003)(256004)(14444005)(229853002)(68736007)(7736002)(31686004)(316002)(53546011)(6506007)(8936002)(81166006)(53936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2832;H:VI1PR08MB3117.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OLTVL/MafXO+KYINARLurJAzLYLNlQ/gnZ5G2CmLI00csYTsZncBPgymUhJVwK7w+0uih2ZCgVA8AGNrepgUSiz6KnFjrJ9B5RSkaEv09THq5YbEd6tCFJ7T72M+nqrx4V04ifT0d8inLNLqGp9+b+nwEW/5OjsIbcR6Yvy3loS8s1ODRP1WlUvSe7s2t6H4KfZLRqmi1Vq/mJQgyS6/8YdywBltAdnhD51sOMFP6ctxTZsSuczwKPtrJ7UQGjAmVY1aOWWrdRShO2VAggJdZgzaWXOZinZxres7GohkAOQpBKx+8Mzc4diuU+ntrRNU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5DA047DB146DC41AC1145435191EEC7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbae7d81-a2ec-4b3e-abda-08d66c151897
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 16:05:18.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjYvMjAxOCAxMTo0MCBBTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiBBcHBhcnQgZnJv
bSBnZW5lcmFsIGNvbW1lbnRzIGFzIGEgcmVwbHkgdG8gdGhlIGNvdmVyIChidHcuIHRoaXMgYWxs
DQo+IHNob3VsZCBiZSBpbiB0aGUgY2hhbmdlbG9nIGJlY2F1c2UgdGhpcyBpcyB0aGUgX3doeV8g
cGFydCBvZiB0aGUNCj4ganVzdGlmaWNhdGlvbiB3aGljaCBzaG91bGQgYmUgX2Fsd2F5c18gcGFy
dCBvZiB0aGUgY2hhbmdlbG9nKS4NCg0KVGhhbmsgeW91LCB3aWxsIGFkZCBpbiB0aGUgbmV4dCB2
ZXJzaW9uIG9mIHRoZSBwYXRjaCBhbGx0b2dldGhlcg0Kd2l0aCBvdGhlciBjaGFuZ2VzIGlmIGFu
eS4NCg0KPiBPbiBUdWUgMjUtMTItMTggMTg6Mzk6MjcsIEtvbnN0YW50aW4gS2hvcmVua28gd3Jv
dGU6DQo+IFsuLi5dDQo+PiArY29uZmlnIFdBUk5fSElHSF9PUkRFUg0KPj4gKwlib29sICJFbmFi
bGUgY29tcGxhaW5zIGFib3V0IGhpZ2ggb3JkZXIgbWVtb3J5IGFsbG9jYXRpb25zIg0KPj4gKwlk
ZXBlbmRzIG9uICFMT0NLREVQDQo+DQo+IFdoeT8NCg0KTE9DS0RFUCBtYWtlcyBzdHJ1Y3R1cmVz
IGJpZywgc28gaWYgd2Ugc2VlIGEgaGlnaCBvcmRlciBhbGxvY2F0aW9uIHdhcm5pbmcNCm9uIGEg
ZGVidWcga2VybmVsIHdpdGggbG9ja2RlcCwgaXQgZG9lcyBub3QgZ2l2ZSB1cyBhIGxvdCAtIGxv
Y2tkZXAgZW5hYmxlZA0Ka2VybmVsIHBlcmZvcm1hbmNlIGlzIG5vdCBvdXIgdGFyZ2V0Lg0KaSBj
YW4gcmVtb3ZlICFMT0NLREVQIGRlcGVuZGVuY2UgaGVyZSwgYnV0IHRoZW4gbmVlZCB0byBhZGp1
c3QgZGVmYXVsdA0Kd2FybmluZyBsZXZlbCBpIHRoaW5rLCBvciBsb2dzIHdpbGwgYmUgc3BhbW1l
ZC4NCg0KPj4gKwlkZWZhdWx0IG4NCj4+ICsJaGVscA0KPj4gKwkgIEVuYWJsZXMgd2FybmluZ3Mg
b24gaGlnaCBvcmRlciBtZW1vcnkgYWxsb2NhdGlvbnMuIFRoaXMgYWxsb3dzIHRvDQo+PiArCSAg
ZGV0ZXJtaW5lIHVzZXJzIG9mIGxhcmdlIG1lbW9yeSBjaHVua3MgYW5kIHJld29yayB0aGVtIHRv
IGRlY3JlYXNlDQo+PiArCSAgYWxsb2NhdGlvbiBsYXRlbmN5LiBOb3RlLCBzb21lIGRlYnVnIG9w
dGlvbnMgbWFrZSBrZXJuZWwgc3RydWN0dXJlcw0KPj4gKwkgIGZhdC4NCj4+ICsNCj4+ICtjb25m
aWcgV0FSTl9ISUdIX09SREVSX0xFVkVMDQo+PiArCWludCAiRGVmaW5lIHBhZ2Ugb3JkZXIgbGV2
ZWwgY29uc2lkZXJlZCBhcyB0b28gaGlnaCINCj4+ICsJZGVwZW5kcyBvbiBXQVJOX0hJR0hfT1JE
RVINCj4+ICsJZGVmYXVsdCAzDQo+PiArCWhlbHANCj4+ICsJICBEZWZpbmVzIHBhZ2Ugb3JkZXIg
c3RhcnRpbmcgd2hpY2ggdGhlIHN5c3RlbSB0byBjb21wbGFpbiBhYm91dC4NCj4+ICsJICBEZWZh
dWx0IGlzIGN1cnJlbnQgUEFHRV9BTExPQ19DT1NUTFlfT1JERVIuDQo+PiArDQo+PiAgY29uZmln
IEhXUE9JU09OX0lOSkVDVA0KPj4gIAl0cmlzdGF0ZSAiSFdQb2lzb24gcGFnZXMgaW5qZWN0b3Ii
DQo+PiAgCWRlcGVuZHMgb24gTUVNT1JZX0ZBSUxVUkUgJiYgREVCVUdfS0VSTkVMICYmIFBST0Nf
RlMNCj4+IGRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdlX2FsbG9jLmMNCj4+
IGluZGV4IGU5NWI1YjdjOWMzZC4uMjU4ODkyYWRiODYxIDEwMDY0NA0KPj4gLS0tIGEvbW0vcGFn
ZV9hbGxvYy5jDQo+PiArKysgYi9tbS9wYWdlX2FsbG9jLmMNCj4+IEBAIC00MzQxLDYgKzQzNDEs
MzAgQEAgc3RhdGljIGlubGluZSB2b2lkIGZpbmFsaXNlX2FjKGdmcF90IGdmcF9tYXNrLCBzdHJ1
Y3QgYWxsb2NfY29udGV4dCAqYWMpDQo+PiAgCQkJCQlhYy0+aGlnaF96b25laWR4LCBhYy0+bm9k
ZW1hc2spOw0KPj4gIH0NCj4+DQo+PiArI2lmZGVmIENPTkZJR19XQVJOX0hJR0hfT1JERVINCj4+
ICtpbnQgd2Fybl9vcmRlciA9IENPTkZJR19XQVJOX0hJR0hfT1JERVJfTEVWRUw7DQo+PiArDQo+
PiArLyoNCj4+ICsgKiBDb21wbGFpbiBpZiB3ZSBhbGxvY2F0ZSBhIGhpZ2ggb3JkZXIgcGFnZSB1
bmxlc3MgdGhlcmUgaXMgYSBfX0dGUF9OT1dBUk4NCj4+ICsgKiBmbGFnIHByb3ZpZGVkLg0KPj4g
KyAqDQo+PiArICogU2h1dHMgdXAgYWZ0ZXIgMzIgY29tcGxhaW5zLg0KPj4gKyAqLw0KPj4gK3N0
YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCB3YXJuX2hpZ2hfb3JkZXIoaW50IG9yZGVyLCBnZnBf
dCBnZnBfbWFzaykNCj4+ICt7DQo+PiArCXN0YXRpYyBhdG9taWNfdCB3YXJuX2NvdW50ID0gQVRP
TUlDX0lOSVQoMzIpOw0KPj4gKw0KPj4gKwlpZiAob3JkZXIgPj0gd2Fybl9vcmRlciAmJiAhKGdm
cF9tYXNrICYgX19HRlBfTk9XQVJOKSkNCj4+ICsJCVdBUk4oYXRvbWljX2RlY19pZl9wb3NpdGl2
ZSgmd2Fybl9jb3VudCkgPj0gMCwNCj4+ICsJCSAgICAgIm9yZGVyICVkID49ICVkLCBnZnAgMHgl
eFxuIiwNCj4+ICsJCSAgICAgb3JkZXIsIHdhcm5fb3JkZXIsIGdmcF9tYXNrKTsNCj4+ICt9DQo+
DQo+IFdlIGRvIGhhdmUgcmF0ZWxpbWl0IGZ1bmN0aW9uYWxpdHksIHNvIHdoeSBjYW5ub3QgeW91
IHVzZSBpdD8NCg0KV2VsbCwgbXkgaWRlYSB3YXMgdG8gcmVhbGx5IHNodXQgdXAgdGhlIHdhcm5p
bmcgYWZ0ZXIgc29tZSBudW1iZXIgb2YgbWVzc2FnZXMNCihpZiBhIG5vZGUgaXMgaW4gcHJvZHVj
dGlvbiBhbmQgaXRzIHVwdGltZSwgc2F5LCBhIHllYXIsIGkgZG9uJ3Qgd2FudCB0byBzZWUNCm1h
bnkgd2FybmluZ3MgaW4gbG9ncywgZmlyc3Qgc2V2ZXJhbCBpcyBlbm91Z2ggLSBsZXQncyBmaXgg
dGhlbSBmaXJzdCkuDQoNCklmIGkgdXNlIHByaW50a19yYXRlbGltaXRlZCgpIGkgY291bGQgZ2V0
IDI0IGRheXMgZGVsYXkgYXQgbW9zdCBBRkFJSywNCmJ1dCBva2F5LCBpIGNhbiBzd2l0Y2ggdG8g
cHJpbnRrX3JhdGVsaW1pdGVkKCkgaWYgeW91IHByZWZlci4NCg0Kc3RydWN0IHJhdGVsaW1pdF9z
dGF0ZSB7DQogICAgICAgICBpbnQgICAgICAgICAgICAgaW50ZXJ2YWw7DQoNCihnZGIpIHAgKCgx
TEw8PDMxKSAtMSkvMTAwMC82MC82MC8yNA0KJDExID0gMjQNCg0KPj4gKyNlbHNlDQo+PiArc3Rh
dGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHdhcm5faGlnaF9vcmRlcihpbnQgb3JkZXIsIGdmcF90
IGdmcF9tYXNrKQ0KPj4gK3sNCj4+ICt9DQo+PiArI2VuZGlmDQo+PiArDQo+PiAgLyoNCj4+ICAg
KiBUaGlzIGlzIHRoZSAnaGVhcnQnIG9mIHRoZSB6b25lZCBidWRkeSBhbGxvY2F0b3IuDQo+PiAg
ICovDQo+PiBAQCAtNDM2MSw2ICs0Mzg1LDcgQEAgX19hbGxvY19wYWdlc19ub2RlbWFzayhnZnBf
dCBnZnBfbWFzaywgdW5zaWduZWQgaW50IG9yZGVyLCBpbnQgcHJlZmVycmVkX25pZCwNCj4+ICAJ
CVdBUk5fT05fT05DRSghKGdmcF9tYXNrICYgX19HRlBfTk9XQVJOKSk7DQo+PiAgCQlyZXR1cm4g
TlVMTDsNCj4+ICAJfQ0KPj4gKwl3YXJuX2hpZ2hfb3JkZXIob3JkZXIsIGdmcF9tYXNrKTsNCj4+
DQo+PiAgCWdmcF9tYXNrICY9IGdmcF9hbGxvd2VkX21hc2s7DQo+PiAgCWFsbG9jX21hc2sgPSBn
ZnBfbWFzazsNCj4NCj4gV2h5IGRvIHlvdSB3YXJuIGFib3V0IGFsbCBhbGxvY2F0aW9ucyBpbiB0
aGUgaG90IHBhdGg/IEkgdGhvdWdodCB5b3UNCj4gd2FudCB0byBjYXRjaCBleHBlbnNpdmUgYWxs
b2NhdGlvbnMgc28gSSB3b3VsZCBhc3N1bWUgdGhhdCB5b3Ugd291bGQNCj4gc3RpY2sgdGhhdCBp
bnRvIGEgc2xvdyBwYXRoIGFmdGVyIHdlIGFyZSBub3QgYWJsZSB0byBhbGxvY2F0ZSBhbnl0aGlu
Zw0KPiBhZnRlciB0aGUgZmlyc3Qgcm91bmQgb2YgY29tcGFjdGlvbi4NCg0KVGhlIGlkZWEgaXMg
dG8gY2F0Y2ggYmlnIGFsbG9jYXRpb25zIHNvb24gYW5kIHByZWZlcmFibHkgZHVyaW5nIHRlc3Rp
bmcsDQpub3Qgb24gcHJvZHVjdGlvbiBub2RlcyB1bmRlciBoaWdoIGxvYWQsIHRoYXQncyB3aHkg
aSd2ZSBjaG9zZW4gaG90IHBhdGguDQoNCkFuZCBpZiB3ZSBzd2l0Y2ggdG8gdGhlIHNsb3cgcGF0
aCwgd2UnbGwgaGF2ZSB0byBydW4gYWxsIHRlc3RzIHVuZGVyDQphZGRpdGlvbmFsIHNlcmlvdXMg
bG9hZCAtIHRvIGdlbmVyYXRlIG1lbW9yeSBmcmFnbWVudGF0aW9uLg0KTm90IHNvIGNvbnZlbmll
bnQuDQoNCj4gQWxzbyBkbyB5b3Ugd2FudCB0byB3YXJuIGFib3V0IG9wcG9ydHVuaXN0aWMgR0ZQ
X05PV0FJVCBhbGxvY2F0aW9ucyB0aGF0DQo+IGhhdmUgYSByZWFzb25hYmxlIGZhbGxiYWNrPw0K
DQpZZXMsIGkgd291bGQgbGlrZSB0by4gU29tZXRpbWVzIGFsbG9jYXRpb24gZmxhZ3MgY29tZSBm
cm9tIHVwcGVyIGxldmVsIGFuZA0KaXQncyBub3QgYWx3YXlzIGV2aWRlbnQgaWYgdGhlcmUgaXMg
R0ZQX05PV0FJVCBmbGFnIG9yIG5vdCwgc28gbGV0J3Mgd2UNCmFyZSBub3RpY2VkIGFib3V0IHN1
Y2ggYSBjYXNlIGFuZCB2ZXJpZnkgaWYgaXQncyBsZWdhbCBhbmQgbm90IGNhbGxlZCBvZnRlbi4N
CklmIHllcyAtIHdlJ2xsIGp1c3QgbWFyayBpdCB3aXRoIE5PX1dBUk4uDQoNCg0KID4gQW5kIGZv
cmdvdCB0byBtZW50aW9uIG90aGVyIG9wcG9ydHVuaXN0aWMgYWxsb2NhdGlvbnMgbGlrZSBUSFAg
b2YNCiA+IGNvdXJzZS4NCg0KaHVnZXBhZ2VzIGFyZSBhbGxvY2F0ZWQgd2l0aCBOT1dBUk4gYWxy
ZWFkeSwgQUZBSUsuDQphbGxvY19mcmVzaF9odWdlX3BhZ2Vfbm9kZSgpLCBfX2h1Z2V0bGJfYWxs
b2NfYnVkZHlfaHVnZV9wYWdlKCkNCg0KDQpUaGFuayB5b3Ugb25jZSBhZ2FpbiwgTWljaGFsLg0K
DQotLQ0KQmVzdCByZWdhcmRzLA0KDQpLb25zdGFudGluIEtob3JlbmtvLA0KVmlydHVvenpvIExp
bnV4IEtlcm5lbCBUZWFtDQo=
