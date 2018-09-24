Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA0ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFA12145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q537QmEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFA12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeIYDbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:31:43 -0400
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:27830
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbeIYDbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZFXzUtE13fCI0wFe3Ttw0xh8rLT3z2hM7sjp0sWeOk=;
 b=q537QmEkR6P+QcdJpDBHYkxBxUaUSf5aBgk+IFiSGghLOkQQLRxf75YvmY7hRQhfuxI/AtjC39jwfPQZYQO6eemZ/B3jm1a/l3/kMh8596WX3r+6N9TdPfC3fbKp+mKToGeujB3c/utegWTT6Y0J7bNIfXnOQgtZRJgqJkHX8mw=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1738.namprd12.prod.outlook.com (10.175.89.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Mon, 24 Sep 2018 21:27:14 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 21:27:14 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
Thread-Topic: [PATCH] crypto: ccp: Remove forward declaration
Thread-Index: AQHUVCu+pP0dlJnsRUaui4HOI4H1AaT/eo2AgABmWQCAABF3gA==
Date:   Mon, 24 Sep 2018 21:27:14 +0000
Message-ID: <a0640c0d-6186-01d5-fa56-74be64f9895a@amd.com>
References: <20180924172615.25591-1-natechancellor@gmail.com>
 <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
 <CAKwvOdkc=OymUoszBR7+QLiOfV2T_GiQ2Oom_C=Ebz76YU_sPw@mail.gmail.com>
In-Reply-To: <CAKwvOdkc=OymUoszBR7+QLiOfV2T_GiQ2Oom_C=Ebz76YU_sPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:404:b9::25) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1738;20:jX/p6vqkxx4tmkDMblaR8FVdrUp3uEMY5+nb0XF4uEE1NCJL07jP3N0HURwKXVI+8k2Gh+4S+y1fhR8K585jbnAfC67dW9qykytbYdj/xvRDX+tb/cS75+Nb/mJBfb74taQ6HaqjItghBNR/598jHQFk24oOCUcHrBr0JLorRDVjb0UC4cnmoZB/DT3vT1rFvKF4jmn+tfzxGbfu+FD4+kyYCWfmaolaXHMthIIFOjEU5To8mRNWnAAXS0zrlGGC
x-ms-office365-filtering-correlation-id: ea4a5af3-8866-4804-a67f-08d622647eb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1738;
x-ms-traffictypediagnostic: DM5PR12MB1738:
x-microsoft-antispam-prvs: <DM5PR12MB1738FAA2A910712EE6D110DFFD170@DM5PR12MB1738.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(211936372134217)(153496737603132)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB1738;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1738;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(189003)(199004)(99286004)(71190400001)(71200400001)(72206003)(478600001)(5250100002)(97736004)(486006)(76176011)(31696002)(8936002)(6436002)(6246003)(6916009)(6512007)(8676002)(4326008)(316002)(575784001)(68736007)(25786009)(39060400002)(5660300001)(53936002)(7736002)(31686004)(14444005)(256004)(2900100001)(105586002)(2906002)(81166006)(6486002)(81156014)(305945005)(54906003)(36756003)(3846002)(6116002)(106356001)(102836004)(186003)(66066001)(53546011)(386003)(6506007)(14454004)(446003)(2616005)(26005)(476003)(229853002)(11346002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1738;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yG5cLtgpjByMleYAq0jMJ46sQjP5JwMExrG8PlHfIliduO631Pn4vc3CtDGUhd57H9ORb8OKMwHynG8QtpIgWzCWwEuSVnAg2gSKqSxaaUcd0fDg92pLz4p1mwnlK3jL3fK7BKz0il30Om9tPZhTLwF8D+gdJXNlFdnBH93vHvMUGqyIJbFInS8GFEqgRBTng71xyWvFhOE9nusti555xpjPCVX2IcpnG8TfsLiVAxsC8wFU2saayw/voXXzbG4mu0zdf4buQf6Ke2S3gdbMoRekN0dXFUv2UzH9mejJHLniFNueoAH5HOtxx8JdThrooZfZ/HPVVtaN+9oruKMKkmUAbOnxS8SCOhOIwhnMi/8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C180124ABD872478B26F84A417C0977@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4a5af3-8866-4804-a67f-08d622647eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 21:27:14.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjQvMjAxOCAwMzoyNCBQTSwgTmljayBEZXNhdWxuaWVycyB3cm90ZToNCj4gT24gTW9u
LCBTZXAgMjQsIDIwMTggYXQgMTI6MTggUE0gR2FyeSBSIEhvb2sgPGdob29rQGFtZC5jb20+IHdy
b3RlOg0KPj4NCj4+IE9uIDA5LzI0LzIwMTggMTI6MjYgUE0sIE5hdGhhbiBDaGFuY2VsbG9yIHdy
b3RlOg0KPj4+IENsYW5nIGVtaXRzIGEgd2FybmluZyBhYm91dCB0aGlzIGNvbnN0cnVjdDoNCj4+
Pg0KPj4+IGRyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0Zm9ybS5jOjM2OjM2OiB3YXJuaW5nOiB0
ZW50YXRpdmUgYXJyYXkNCj4+PiBkZWZpbml0aW9uIGFzc3VtZWQgdG8gaGF2ZSBvbmUgZWxlbWVu
dA0KPj4+IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgc3BfYWNwaV9tYXRjaFtd
Ow0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+Pj4gMSB3YXJu
aW5nIGdlbmVyYXRlZC4NCj4+Pg0KPj4+IEp1c3QgcmVtb3ZlIHRoZSBmb3J3YXJkIGRlY2xhcmF0
aW9ucyBhbmQgbW92ZSB0aGUgaW5pdGlhbGl6YXRpb25zIHVwDQo+Pj4gc28gdGhhdCB0aGV5IGNh
biBiZSB1c2VkIGluIHNwX2dldF9vZl92ZXJzaW9uIGFuZCBzcF9nZXRfYWNwaV92ZXJzaW9uLg0K
Pj4NCj4+IEknbSBub3QgZ29pbmcgdG8gb3V0IGFuZCBvdXQgb2JqZWN0IHRvIHRoaXMganVzdCB5
ZXQuDQo+IA0KPiBUZW50YXRpdmUgYXJyYXkgZGVmaW5pdGlvbnMgbmVlZCB0byBoYXZlIHRoZSBj
b3JyZWN0IGxlbmd0aCBzcGVjaWZpZWQ7DQo+IGl0IHNob3VsZCBlaXRoZXIgYmUgZm9yd2FyZCBk
ZWNsYXJlZCBhcyB0aGUgY29ycmVjdCBsZW5ndGgsIG9yIGFzIHRoaXMNCj4gcGF0Y2ggZG9lcywg
c2tpcCB0aGUgZm9yd2FyZCBkZWNsYXJlIGFuZCBtb3ZlIHVwIHRoZSBkZWZpbml0aW9uLg0KPiBU
aGFua3MgZm9yIHRoaXMgcGF0Y2ggTmF0aGFuLg0KPiBSZXZpZXdlZC1ieTogTmljayBEZXNhdWxu
aWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQoNCg0KQ2hlY2tlZCBteSBDOTksIGFuZCB1
c2luZyBib3RoIHN0YXRpYyBhbmQgW10gdG8gY3JlYXRlIGEgZGVjbGFyYXRpb24gDQooYmVjYXVz
ZSBpdCdzIHJlYWxseSBhIGRlZmluaXRpb24pIGFwcGFyZW50bHkgaXNuJ3QgdmFsaWQuIEkgc2hv
dWxkIGhhdmUgDQprbm93biB0aGF0LiBTaW5jZSBJJ20gb2xkIHNjaG9vbC4uLg0KDQpBY2tlZC1i
eTogR2FyeSBSIEhvb2sgPGdhcnkuaG9va0BhbWQuY29tPg0KDQoNCj4gDQo+Pg0KPj4gSSBhbSBu
b3QgYSBjbGFuZyBleHBlcnQuIENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgYSBtYWtlIGNvbW1hbmQg
dGhhdA0KPj4gd291bGQgZXhwbGFpbiBob3cgeW91IHByZWNpcGl0YXRlZCB0aGlzIGNvbXBsYWlu
dD8NCj4+DQo+Pg0KPj4+IFJlcG9ydGVkLWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmll
cnNAZ29vZ2xlLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0
ZWNoYW5jZWxsb3JAZ21haWwuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGRyaXZlcnMvY3J5cHRvL2Nj
cC9zcC1wbGF0Zm9ybS5jIHwgNTMgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+
Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2NwL3NwLXBsYXRmb3JtLmMgYi9k
cml2ZXJzL2NyeXB0by9jY3Avc3AtcGxhdGZvcm0uYw0KPj4+IGluZGV4IDcxNzM0ZjI1NGZkMS4u
Yjc1ZGM3ZGIyZDRhIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0
Zm9ybS5jDQo+Pj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2NwL3NwLXBsYXRmb3JtLmMNCj4+PiBA
QCAtMzMsOCArMzMsMzEgQEAgc3RydWN0IHNwX3BsYXRmb3JtIHsNCj4+PiAgICAgICAgdW5zaWdu
ZWQgaW50IGlycV9jb3VudDsNCj4+PiAgICB9Ow0KPj4+DQo+Pj4gLXN0YXRpYyBjb25zdCBzdHJ1
Y3QgYWNwaV9kZXZpY2VfaWQgc3BfYWNwaV9tYXRjaFtdOw0KPj4+IC1zdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBzcF9vZl9tYXRjaFtdOw0KPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IHNwX2Rldl92ZGF0YSBkZXZfdmRhdGFbXSA9IHsNCj4+PiArICAgICB7DQo+Pj4gKyAgICAgICAg
ICAgICAuYmFyID0gMCwNCj4+PiArI2lmZGVmIENPTkZJR19DUllQVE9fREVWX1NQX0NDUA0KPj4+
ICsgICAgICAgICAgICAgLmNjcF92ZGF0YSA9ICZjY3B2M19wbGF0Zm9ybSwNCj4+PiArI2VuZGlm
DQo+Pj4gKyAgICAgfSwNCj4+PiArfTsNCj4+PiArDQo+Pj4gKyNpZmRlZiBDT05GSUdfQUNQSQ0K
Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIHNwX2FjcGlfbWF0Y2hbXSA9
IHsNCj4+PiArICAgICB7ICJBTURJMEMwMCIsIChrZXJuZWxfdWxvbmdfdCkmZGV2X3ZkYXRhWzBd
IH0sDQo+Pj4gKyAgICAgeyB9LA0KPj4+ICt9Ow0KPj4+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGFj
cGksIHNwX2FjcGlfbWF0Y2gpOw0KPj4+ICsjZW5kaWYNCj4+PiArDQo+Pj4gKyNpZmRlZiBDT05G
SUdfT0YNCj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc3Bfb2ZfbWF0Y2hb
XSA9IHsNCj4+PiArICAgICB7IC5jb21wYXRpYmxlID0gImFtZCxjY3Atc2VhdHRsZS12MWEiLA0K
Pj4+ICsgICAgICAgLmRhdGEgPSAoY29uc3Qgdm9pZCAqKSZkZXZfdmRhdGFbMF0gfSwNCj4+PiAr
ICAgICB7IH0sDQo+Pj4gK307DQo+Pj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHNwX29mX21h
dGNoKTsNCj4+PiArI2VuZGlmDQo+Pj4NCj4+PiAgICBzdGF0aWMgc3RydWN0IHNwX2Rldl92ZGF0
YSAqc3BfZ2V0X29mX3ZlcnNpb24oc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+PiAg
ICB7DQo+Pj4gQEAgLTIwMSwzMiArMjI0LDYgQEAgc3RhdGljIGludCBzcF9wbGF0Zm9ybV9yZXN1
bWUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+PiAgICB9DQo+Pj4gICAgI2VuZGlm
DQo+Pj4NCj4+PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBzcF9kZXZfdmRhdGEgZGV2X3ZkYXRhW10g
PSB7DQo+Pj4gLSAgICAgew0KPj4+IC0gICAgICAgICAgICAgLmJhciA9IDAsDQo+Pj4gLSNpZmRl
ZiBDT05GSUdfQ1JZUFRPX0RFVl9TUF9DQ1ANCj4+PiAtICAgICAgICAgICAgIC5jY3BfdmRhdGEg
PSAmY2NwdjNfcGxhdGZvcm0sDQo+Pj4gLSNlbmRpZg0KPj4+IC0gICAgIH0sDQo+Pj4gLX07DQo+
Pj4gLQ0KPj4+IC0jaWZkZWYgQ09ORklHX0FDUEkNCj4+PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBh
Y3BpX2RldmljZV9pZCBzcF9hY3BpX21hdGNoW10gPSB7DQo+Pj4gLSAgICAgeyAiQU1ESTBDMDAi
LCAoa2VybmVsX3Vsb25nX3QpJmRldl92ZGF0YVswXSB9LA0KPj4+IC0gICAgIHsgfSwNCj4+PiAt
fTsNCj4+PiAtTU9EVUxFX0RFVklDRV9UQUJMRShhY3BpLCBzcF9hY3BpX21hdGNoKTsNCj4+PiAt
I2VuZGlmDQo+Pj4gLQ0KPj4+IC0jaWZkZWYgQ09ORklHX09GDQo+Pj4gLXN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNwX29mX21hdGNoW10gPSB7DQo+Pj4gLSAgICAgeyAuY29tcGF0
aWJsZSA9ICJhbWQsY2NwLXNlYXR0bGUtdjFhIiwNCj4+PiAtICAgICAgIC5kYXRhID0gKGNvbnN0
IHZvaWQgKikmZGV2X3ZkYXRhWzBdIH0sDQo+Pj4gLSAgICAgeyB9LA0KPj4+IC19Ow0KPj4+IC1N
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBzcF9vZl9tYXRjaCk7DQo+Pj4gLSNlbmRpZg0KPj4+IC0N
Cj4+PiAgICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzcF9wbGF0Zm9ybV9kcml2ZXIg
PSB7DQo+Pj4gICAgICAgIC5kcml2ZXIgPSB7DQo+Pj4gICAgICAgICAgICAgICAgLm5hbWUgPSAi
Y2NwIiwNCj4+Pg0KPj4NCj4gDQo+IA0KDQo=
