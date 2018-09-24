Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AB1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1657D2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MHVeGi16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1657D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeIYBWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:05 -0400
Received: from mail-sn1nam01on0079.outbound.protection.outlook.com ([104.47.32.79]:4928
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730681AbeIYBWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uODk2J+KPyFcEm4R8sNIsPEbC9xLlI2N3ZE+6oP/hp4=;
 b=MHVeGi16r9ZxJcJ/2d9RuxhwIuJtl2Hyjy1vkuJSSf6gsPp/kJP/TOhFAM65lDFBKiSVkei8qiga6lHUBBwrZyZsA0FzqjMbBxj39zaqmkdyndSVC102gFXgtwa03rQWxBAswhL30JEEbYw0Gp0J04IDM2dQaLYcNcko3bsrcYQ=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1947.namprd12.prod.outlook.com (10.175.90.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:18:24 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:18:24 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
Thread-Topic: [PATCH] crypto: ccp: Remove forward declaration
Thread-Index: AQHUVCu+pP0dlJnsRUaui4HOI4H1AaT/zl6A
Date:   Mon, 24 Sep 2018 19:18:23 +0000
Message-ID: <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
References: <20180924172615.25591-1-natechancellor@gmail.com>
In-Reply-To: <20180924172615.25591-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:903:33::28) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1947;20:AgHuN7PKu00Hj0PuHTjJA/4Rfb9lC6wFY1ns2JjtzQfCJfc5mbdlDBn2uxlpoZgLaKr7NSriJn5uCGvJdv2Ks6HElignOXTA85/z50n0/Fnkm267pAwVghsIodjQW8ttp6DdGDoDlvIC7NZzzHfN8zXbANnvh2DDxiD/xKWcdn2zIcvoLYGLHJ/8KSb45Eo1BmueNWjszNOpXQ382zXQfrqCu6xNSvXVBGNKyY4/gQ45SE1uZlWtQZ0Hs6qeqqov
x-ms-office365-filtering-correlation-id: c7a64b0b-00fb-4a6e-84c7-08d622527eec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1947;
x-ms-traffictypediagnostic: DM5PR12MB1947:
x-microsoft-antispam-prvs: <DM5PR12MB1947C3F0EA3B7EC3159B61E3FD170@DM5PR12MB1947.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB1947;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1947;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(366004)(189003)(199004)(229853002)(575784001)(186003)(478600001)(72206003)(26005)(31686004)(5250100002)(66066001)(446003)(3846002)(110136005)(2616005)(2900100001)(5660300001)(54906003)(6506007)(53546011)(99286004)(486006)(52116002)(36756003)(386003)(102836004)(53936002)(256004)(11346002)(476003)(316002)(76176011)(97736004)(81166006)(14454004)(6512007)(2906002)(106356001)(25786009)(6436002)(6246003)(81156014)(8936002)(8676002)(4326008)(305945005)(105586002)(68736007)(31696002)(6486002)(7736002)(71200400001)(14444005)(39060400002)(6116002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1947;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1O9KtApmDR9IufQqwbdybC6FoSc9WP4rFXkefVFEn6jWJWA49CqWwi1Pwjqi5BBktXAchU6MYticcel7o00f+aiCKpByNkKxVn3D7E0PXdw+qRmNtjnMEHsyeO4hXGXLdTazI1boOTYR3Hu0D9RkUtKau2MXVqxDMdBjSp0kCY/1+aarqbDZ19o/iS73VzYveDlxeLH6oxnBgCzGMr8QP7TTsW/giJFR1RW902oUEr1j9SAy8IWRsXtH4Ktr428r70wl/ig3SJz8XbZDXdmOD7CG41pajGPN1oTnQFGr3v4gISx3CSMAzSinOxe80fMJXxBK53L5o6c7lv7PMFHFp1boQaARsXJ44wiwXy+8Xgk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <56836D7413406F4191B4356291A47C5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a64b0b-00fb-4a6e-84c7-08d622527eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:18:23.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjQvMjAxOCAxMjoyNiBQTSwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6DQo+IENsYW5n
IGVtaXRzIGEgd2FybmluZyBhYm91dCB0aGlzIGNvbnN0cnVjdDoNCj4gDQo+IGRyaXZlcnMvY3J5
cHRvL2NjcC9zcC1wbGF0Zm9ybS5jOjM2OjM2OiB3YXJuaW5nOiB0ZW50YXRpdmUgYXJyYXkNCj4g
ZGVmaW5pdGlvbiBhc3N1bWVkIHRvIGhhdmUgb25lIGVsZW1lbnQNCj4gc3RhdGljIGNvbnN0IHN0
cnVjdCBhY3BpX2RldmljZV9pZCBzcF9hY3BpX21hdGNoW107DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF4NCj4gMSB3YXJuaW5nIGdlbmVyYXRlZC4NCj4gDQo+IEp1c3Qg
cmVtb3ZlIHRoZSBmb3J3YXJkIGRlY2xhcmF0aW9ucyBhbmQgbW92ZSB0aGUgaW5pdGlhbGl6YXRp
b25zIHVwDQo+IHNvIHRoYXQgdGhleSBjYW4gYmUgdXNlZCBpbiBzcF9nZXRfb2ZfdmVyc2lvbiBh
bmQgc3BfZ2V0X2FjcGlfdmVyc2lvbi4NCg0KSSdtIG5vdCBnb2luZyB0byBvdXQgYW5kIG91dCBv
YmplY3QgdG8gdGhpcyBqdXN0IHlldC4NCg0KSSBhbSBub3QgYSBjbGFuZyBleHBlcnQuIENhbiB5
b3UgcGxlYXNlIHByb3ZpZGUgYSBtYWtlIGNvbW1hbmQgdGhhdCANCndvdWxkIGV4cGxhaW4gaG93
IHlvdSBwcmVjaXBpdGF0ZWQgdGhpcyBjb21wbGFpbnQ/DQoNCg0KPiBSZXBvcnRlZC1ieTogTmlj
ayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0Zm9ybS5jIHwgNTMgKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMjgg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2NwL3NwLXBs
YXRmb3JtLmMgYi9kcml2ZXJzL2NyeXB0by9jY3Avc3AtcGxhdGZvcm0uYw0KPiBpbmRleCA3MTcz
NGYyNTRmZDEuLmI3NWRjN2RiMmQ0YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2Nw
L3NwLXBsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2NwL3NwLXBsYXRmb3JtLmMN
Cj4gQEAgLTMzLDggKzMzLDMxIEBAIHN0cnVjdCBzcF9wbGF0Zm9ybSB7DQo+ICAgCXVuc2lnbmVk
IGludCBpcnFfY291bnQ7DQo+ICAgfTsNCj4gICANCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNw
aV9kZXZpY2VfaWQgc3BfYWNwaV9tYXRjaFtdOw0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgc3Bfb2ZfbWF0Y2hbXTsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BfZGV2X3Zk
YXRhIGRldl92ZGF0YVtdID0gew0KPiArCXsNCj4gKwkJLmJhciA9IDAsDQo+ICsjaWZkZWYgQ09O
RklHX0NSWVBUT19ERVZfU1BfQ0NQDQo+ICsJCS5jY3BfdmRhdGEgPSAmY2NwdjNfcGxhdGZvcm0s
DQo+ICsjZW5kaWYNCj4gKwl9LA0KPiArfTsNCj4gKw0KPiArI2lmZGVmIENPTkZJR19BQ1BJDQo+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIHNwX2FjcGlfbWF0Y2hbXSA9IHsN
Cj4gKwl7ICJBTURJMEMwMCIsIChrZXJuZWxfdWxvbmdfdCkmZGV2X3ZkYXRhWzBdIH0sDQo+ICsJ
eyB9LA0KPiArfTsNCj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgc3BfYWNwaV9tYXRjaCk7
DQo+ICsjZW5kaWYNCj4gKw0KPiArI2lmZGVmIENPTkZJR19PRg0KPiArc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgc3Bfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0g
ImFtZCxjY3Atc2VhdHRsZS12MWEiLA0KPiArCSAgLmRhdGEgPSAoY29uc3Qgdm9pZCAqKSZkZXZf
dmRhdGFbMF0gfSwNCj4gKwl7IH0sDQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwg
c3Bfb2ZfbWF0Y2gpOw0KPiArI2VuZGlmDQo+ICAgDQo+ICAgc3RhdGljIHN0cnVjdCBzcF9kZXZf
dmRhdGEgKnNwX2dldF9vZl92ZXJzaW9uKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAgew0KPiBAQCAtMjAxLDMyICsyMjQsNiBAQCBzdGF0aWMgaW50IHNwX3BsYXRmb3JtX3Jlc3Vt
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIH0NCj4gICAjZW5kaWYNCj4gICAN
Cj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BfZGV2X3ZkYXRhIGRldl92ZGF0YVtdID0gew0KPiAt
CXsNCj4gLQkJLmJhciA9IDAsDQo+IC0jaWZkZWYgQ09ORklHX0NSWVBUT19ERVZfU1BfQ0NQDQo+
IC0JCS5jY3BfdmRhdGEgPSAmY2NwdjNfcGxhdGZvcm0sDQo+IC0jZW5kaWYNCj4gLQl9LA0KPiAt
fTsNCj4gLQ0KPiAtI2lmZGVmIENPTkZJR19BQ1BJDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGFj
cGlfZGV2aWNlX2lkIHNwX2FjcGlfbWF0Y2hbXSA9IHsNCj4gLQl7ICJBTURJMEMwMCIsIChrZXJu
ZWxfdWxvbmdfdCkmZGV2X3ZkYXRhWzBdIH0sDQo+IC0JeyB9LA0KPiAtfTsNCj4gLU1PRFVMRV9E
RVZJQ0VfVEFCTEUoYWNwaSwgc3BfYWNwaV9tYXRjaCk7DQo+IC0jZW5kaWYNCj4gLQ0KPiAtI2lm
ZGVmIENPTkZJR19PRg0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc3Bfb2Zf
bWF0Y2hbXSA9IHsNCj4gLQl7IC5jb21wYXRpYmxlID0gImFtZCxjY3Atc2VhdHRsZS12MWEiLA0K
PiAtCSAgLmRhdGEgPSAoY29uc3Qgdm9pZCAqKSZkZXZfdmRhdGFbMF0gfSwNCj4gLQl7IH0sDQo+
IC19Ow0KPiAtTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc3Bfb2ZfbWF0Y2gpOw0KPiAtI2VuZGlm
DQo+IC0NCj4gICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzcF9wbGF0Zm9ybV9kcml2
ZXIgPSB7DQo+ICAgCS5kcml2ZXIgPSB7DQo+ICAgCQkubmFtZSA9ICJjY3AiLA0KPiANCg0K
