Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C965C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B3A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EuRQKg+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B3A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIYFqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:46:16 -0400
Received: from mail-bn3nam01on0079.outbound.protection.outlook.com ([104.47.33.79]:63776
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbeIYFqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hOjui3cMNt4H+8U8vsvqNYfwrLUMeBC+l1GwJQbtZU=;
 b=EuRQKg+92VzCmpJyNAzDo97m2gafTrdhPBuG4b9K73cnK6rgbnco86/yCHu5vCm57mCORroUEOnA/6KP0a8+dIWBk4KkZw34CWsgKi6qju2bvaj3gMiU9JWCYxi8pCduvihF0AqiXAnBUr1KgdDtCiILIkh9zE4o0ox6hVKVtx8=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1484.namprd12.prod.outlook.com (10.172.38.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 23:41:32 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 23:41:32 +0000
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
Thread-Index: AQHUVCu+pP0dlJnsRUaui4HOI4H1AaT/eo2AgABmWQD//72mgIAAWJwAgAAgvAA=
Date:   Mon, 24 Sep 2018 23:41:32 +0000
Message-ID: <1aa08776-da0c-6cec-22f3-44f11e608f80@amd.com>
References: <20180924172615.25591-1-natechancellor@gmail.com>
 <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
 <CAKwvOdkc=OymUoszBR7+QLiOfV2T_GiQ2Oom_C=Ebz76YU_sPw@mail.gmail.com>
 <a0640c0d-6186-01d5-fa56-74be64f9895a@amd.com>
 <CAKwvOdkf4pBpoLSHiWg0CZfnmCzMvUAT_Zsc4QFOUk9No5qGrA@mail.gmail.com>
In-Reply-To: <CAKwvOdkf4pBpoLSHiWg0CZfnmCzMvUAT_Zsc4QFOUk9No5qGrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:910:14::17) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1484;20:ijrTlsHdVw948HRccfETftJWGiMDz7D9unjuEmYZJhTg6S/+q3TEvKc9eikDLj+3MhJWcSEkGKSLaEoFwtGS6LoICzN3Rq/AKwZ6QMuapJTuh04kW7EBOsD4pSU3GCAXqIqK2oMrosWchzGa2mLgJeSIJ5bBOFbEIwmkLMIuA8TMn50jUi8H/dH8DOz34Gl195GkQsKhpWFLReZlBk9DaFyXsFgotnaoH37ydK4NTkP1ha0RmHqryi1MqaQ3Mkxs
x-ms-office365-filtering-correlation-id: e830f766-8634-45ca-d5bc-08d6227741f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1484;
x-ms-traffictypediagnostic: DM5PR12MB1484:
x-microsoft-antispam-prvs: <DM5PR12MB1484E405A483F82221F76BA9FD170@DM5PR12MB1484.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(211936372134217)(153496737603132)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1484;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1484;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(54906003)(81166006)(5250100002)(31696002)(72206003)(8936002)(6246003)(14454004)(575784001)(478600001)(66066001)(2900100001)(106356001)(25786009)(31686004)(7736002)(4326008)(8676002)(5660300001)(305945005)(3846002)(6116002)(39060400002)(105586002)(68736007)(102836004)(2906002)(76176011)(316002)(6506007)(386003)(6916009)(26005)(52116002)(6486002)(53936002)(186003)(11346002)(446003)(71190400001)(93886005)(486006)(476003)(2616005)(99286004)(81156014)(71200400001)(36756003)(256004)(14444005)(53546011)(6436002)(229853002)(6512007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1484;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wd61722/Lno64UD2ESkYxsG4u+tjR93mLg1RgvgeE58x9fuBDzKLvQXB959a3a4HKUHSegkkrLtTfUnMtuP3amNtzw6kQh0x8MEdf941XC5KJiu9oSRcDUxtHh7oEEJCpKebYx1CXHEO4ZRLxijgewKZoeHPqu1vy8XxOzyTum5aiKDygB7jXfXaGM5JLsLlUls9TUImJat8rLr3cklFaDmpbAlJjNVnAjDQnFPR6yWJ7lnPwT7kx3HQHqJmheY5tnP9jwnaukk9V0aalpZOo0zTHhLX1PbfYd/cd+7eiiNlXXeojlk8HUCMsqz/xPdXK8IuNq8tmHDJRinxZ/xc6fvmwBRl7MLJF8Dda2Gga08=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <74ADBE379B73664FBA7C0BA942EB2C62@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e830f766-8634-45ca-d5bc-08d6227741f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 23:41:32.8105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjQvMjAxOCAwNDo0NCBQTSwgTmljayBEZXNhdWxuaWVycyB3cm90ZToNCj4gT24gTW9u
LCBTZXAgMjQsIDIwMTggYXQgMjoyNyBQTSBHYXJ5IFIgSG9vayA8Z2hvb2tAYW1kLmNvbT4gd3Jv
dGU6DQo+Pg0KPj4gT24gMDkvMjQvMjAxOCAwMzoyNCBQTSwgTmljayBEZXNhdWxuaWVycyB3cm90
ZToNCj4+PiBPbiBNb24sIFNlcCAyNCwgMjAxOCBhdCAxMjoxOCBQTSBHYXJ5IFIgSG9vayA8Z2hv
b2tAYW1kLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IE9uIDA5LzI0LzIwMTggMTI6MjYgUE0sIE5h
dGhhbiBDaGFuY2VsbG9yIHdyb3RlOg0KPj4+Pj4gQ2xhbmcgZW1pdHMgYSB3YXJuaW5nIGFib3V0
IHRoaXMgY29uc3RydWN0Og0KPj4+Pj4NCj4+Pj4+IGRyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0
Zm9ybS5jOjM2OjM2OiB3YXJuaW5nOiB0ZW50YXRpdmUgYXJyYXkNCj4+Pj4+IGRlZmluaXRpb24g
YXNzdW1lZCB0byBoYXZlIG9uZSBlbGVtZW50DQo+Pj4+PiBzdGF0aWMgY29uc3Qgc3RydWN0IGFj
cGlfZGV2aWNlX2lkIHNwX2FjcGlfbWF0Y2hbXTsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KPj4+Pj4gMSB3YXJuaW5nIGdlbmVyYXRlZC4NCj4+Pj4+DQo+
Pj4+PiBKdXN0IHJlbW92ZSB0aGUgZm9yd2FyZCBkZWNsYXJhdGlvbnMgYW5kIG1vdmUgdGhlIGlu
aXRpYWxpemF0aW9ucyB1cA0KPj4+Pj4gc28gdGhhdCB0aGV5IGNhbiBiZSB1c2VkIGluIHNwX2dl
dF9vZl92ZXJzaW9uIGFuZCBzcF9nZXRfYWNwaV92ZXJzaW9uLg0KPj4+Pg0KPj4+PiBJJ20gbm90
IGdvaW5nIHRvIG91dCBhbmQgb3V0IG9iamVjdCB0byB0aGlzIGp1c3QgeWV0Lg0KPj4+DQo+Pj4g
VGVudGF0aXZlIGFycmF5IGRlZmluaXRpb25zIG5lZWQgdG8gaGF2ZSB0aGUgY29ycmVjdCBsZW5n
dGggc3BlY2lmaWVkOw0KPj4+IGl0IHNob3VsZCBlaXRoZXIgYmUgZm9yd2FyZCBkZWNsYXJlZCBh
cyB0aGUgY29ycmVjdCBsZW5ndGgsIG9yIGFzIHRoaXMNCj4+PiBwYXRjaCBkb2VzLCBza2lwIHRo
ZSBmb3J3YXJkIGRlY2xhcmUgYW5kIG1vdmUgdXAgdGhlIGRlZmluaXRpb24uDQo+Pj4gVGhhbmtz
IGZvciB0aGlzIHBhdGNoIE5hdGhhbi4NCj4+PiBSZXZpZXdlZC1ieTogTmljayBEZXNhdWxuaWVy
cyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+Pg0KPj4NCj4+IENoZWNrZWQgbXkgQzk5LCBh
bmQgdXNpbmcgYm90aCBzdGF0aWMgYW5kIFtdIHRvIGNyZWF0ZSBhIGRlY2xhcmF0aW9uDQo+IA0K
PiBOb3RlIHRoYXQgdGhlIGtlcm5lbCB1c2VzIGdudTg5LCB3aGljaCBpcyBJU08gQzkwICsgZ251
IGV4dGVuc2lvbnMgKElJVUMpLg0KDQpJIHVuZGVyc3RhbmQgdGhhdCAoYW5kIGFwcHJlY2lhdGUg
dGhhdCB1YmlxdWl0b3VzbmVzcyBvZiB0aGUgZGlhbGVjdCkgDQpidXQgaW4gdGhpcyBjYXNlIGl0
IHNvdW5kcyBsaWtlIHdlIGFyZSBpbnRlcmVzdGVkIGluIHRoZSB3aWRlc3QgcG9zc2libGUgDQpj
b21wYXRpYmlsaXR5LiBXaGljaCBtYWtlcyB0aGUgb3JpZ2luYWwgcGF0Y2ggcHJvYmxlbWF0aWMs
IGFuZCB0aGUgZml4IA0Kc3VnZ2VzdGVkIGhlcmVpbiBzdWl0YWJsZS4NCg0KPiANCj4+IChiZWNh
dXNlIGl0J3MgcmVhbGx5IGEgZGVmaW5pdGlvbikgYXBwYXJlbnRseSBpc24ndCB2YWxpZC4gSSBz
aG91bGQgaGF2ZQ0KPj4ga25vd24gdGhhdC4gU2luY2UgSSdtIG9sZCBzY2hvb2wuLi4NCj4+DQo+
PiBBY2tlZC1ieTogR2FyeSBSIEhvb2sgPGdhcnkuaG9va0BhbWQuY29tPg0KPj4NCj4+DQo+Pj4N
Cj4+Pj4NCj4+Pj4gSSBhbSBub3QgYSBjbGFuZyBleHBlcnQuIENhbiB5b3UgcGxlYXNlIHByb3Zp
ZGUgYSBtYWtlIGNvbW1hbmQgdGhhdA0KPj4+PiB3b3VsZCBleHBsYWluIGhvdyB5b3UgcHJlY2lw
aXRhdGVkIHRoaXMgY29tcGxhaW50Pw0KPj4+Pg0KPj4+Pg0KPj4+Pj4gUmVwb3J0ZWQtYnk6IE5p
Y2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPg0KPj4+Pj4gU2lnbmVkLW9m
Zi1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4NCj4+Pj4+
IC0tLQ0KPj4+Pj4gICAgIGRyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0Zm9ybS5jIHwgNTMgKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwg
MjUgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0Zm9ybS5jIGIvZHJpdmVycy9jcnlwdG8vY2Nw
L3NwLXBsYXRmb3JtLmMNCj4+Pj4+IGluZGV4IDcxNzM0ZjI1NGZkMS4uYjc1ZGM3ZGIyZDRhIDEw
MDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2NwL3NwLXBsYXRmb3JtLmMNCj4+Pj4+
ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0Zm9ybS5jDQo+Pj4+PiBAQCAtMzMsOCAr
MzMsMzEgQEAgc3RydWN0IHNwX3BsYXRmb3JtIHsNCj4+Pj4+ICAgICAgICAgdW5zaWduZWQgaW50
IGlycV9jb3VudDsNCj4+Pj4+ICAgICB9Ow0KPj4+Pj4NCj4+Pj4+IC1zdGF0aWMgY29uc3Qgc3Ry
dWN0IGFjcGlfZGV2aWNlX2lkIHNwX2FjcGlfbWF0Y2hbXTsNCj4+Pj4+IC1zdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBzcF9vZl9tYXRjaFtdOw0KPj4+Pj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgc3BfZGV2X3ZkYXRhIGRldl92ZGF0YVtdID0gew0KPj4+Pj4gKyAgICAgew0KPj4+Pj4g
KyAgICAgICAgICAgICAuYmFyID0gMCwNCj4+Pj4+ICsjaWZkZWYgQ09ORklHX0NSWVBUT19ERVZf
U1BfQ0NQDQo+Pj4+PiArICAgICAgICAgICAgIC5jY3BfdmRhdGEgPSAmY2NwdjNfcGxhdGZvcm0s
DQo+Pj4+PiArI2VuZGlmDQo+Pj4+PiArICAgICB9LA0KPj4+Pj4gK307DQo+Pj4+PiArDQo+Pj4+
PiArI2lmZGVmIENPTkZJR19BQ1BJDQo+Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2Rl
dmljZV9pZCBzcF9hY3BpX21hdGNoW10gPSB7DQo+Pj4+PiArICAgICB7ICJBTURJMEMwMCIsIChr
ZXJuZWxfdWxvbmdfdCkmZGV2X3ZkYXRhWzBdIH0sDQo+Pj4+PiArICAgICB7IH0sDQo+Pj4+PiAr
fTsNCj4+Pj4+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGFjcGksIHNwX2FjcGlfbWF0Y2gpOw0KPj4+
Pj4gKyNlbmRpZg0KPj4+Pj4gKw0KPj4+Pj4gKyNpZmRlZiBDT05GSUdfT0YNCj4+Pj4+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzcF9vZl9tYXRjaFtdID0gew0KPj4+Pj4gKyAg
ICAgeyAuY29tcGF0aWJsZSA9ICJhbWQsY2NwLXNlYXR0bGUtdjFhIiwNCj4+Pj4+ICsgICAgICAg
LmRhdGEgPSAoY29uc3Qgdm9pZCAqKSZkZXZfdmRhdGFbMF0gfSwNCj4+Pj4+ICsgICAgIHsgfSwN
Cj4+Pj4+ICt9Ow0KPj4+Pj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHNwX29mX21hdGNoKTsN
Cj4+Pj4+ICsjZW5kaWYNCj4+Pj4+DQo+Pj4+PiAgICAgc3RhdGljIHN0cnVjdCBzcF9kZXZfdmRh
dGEgKnNwX2dldF9vZl92ZXJzaW9uKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4+
PiAgICAgew0KPj4+Pj4gQEAgLTIwMSwzMiArMjI0LDYgQEAgc3RhdGljIGludCBzcF9wbGF0Zm9y
bV9yZXN1bWUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+Pj4+ICAgICB9DQo+Pj4+
PiAgICAgI2VuZGlmDQo+Pj4+Pg0KPj4+Pj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BfZGV2X3Zk
YXRhIGRldl92ZGF0YVtdID0gew0KPj4+Pj4gLSAgICAgew0KPj4+Pj4gLSAgICAgICAgICAgICAu
YmFyID0gMCwNCj4+Pj4+IC0jaWZkZWYgQ09ORklHX0NSWVBUT19ERVZfU1BfQ0NQDQo+Pj4+PiAt
ICAgICAgICAgICAgIC5jY3BfdmRhdGEgPSAmY2NwdjNfcGxhdGZvcm0sDQo+Pj4+PiAtI2VuZGlm
DQo+Pj4+PiAtICAgICB9LA0KPj4+Pj4gLX07DQo+Pj4+PiAtDQo+Pj4+PiAtI2lmZGVmIENPTkZJ
R19BQ1BJDQo+Pj4+PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBzcF9hY3Bp
X21hdGNoW10gPSB7DQo+Pj4+PiAtICAgICB7ICJBTURJMEMwMCIsIChrZXJuZWxfdWxvbmdfdCkm
ZGV2X3ZkYXRhWzBdIH0sDQo+Pj4+PiAtICAgICB7IH0sDQo+Pj4+PiAtfTsNCj4+Pj4+IC1NT0RV
TEVfREVWSUNFX1RBQkxFKGFjcGksIHNwX2FjcGlfbWF0Y2gpOw0KPj4+Pj4gLSNlbmRpZg0KPj4+
Pj4gLQ0KPj4+Pj4gLSNpZmRlZiBDT05GSUdfT0YNCj4+Pj4+IC1zdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBzcF9vZl9tYXRjaFtdID0gew0KPj4+Pj4gLSAgICAgeyAuY29tcGF0aWJs
ZSA9ICJhbWQsY2NwLXNlYXR0bGUtdjFhIiwNCj4+Pj4+IC0gICAgICAgLmRhdGEgPSAoY29uc3Qg
dm9pZCAqKSZkZXZfdmRhdGFbMF0gfSwNCj4+Pj4+IC0gICAgIHsgfSwNCj4+Pj4+IC19Ow0KPj4+
Pj4gLU1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHNwX29mX21hdGNoKTsNCj4+Pj4+IC0jZW5kaWYN
Cj4+Pj4+IC0NCj4+Pj4+ICAgICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzcF9wbGF0
Zm9ybV9kcml2ZXIgPSB7DQo+Pj4+PiAgICAgICAgIC5kcml2ZXIgPSB7DQo+Pj4+PiAgICAgICAg
ICAgICAgICAgLm5hbWUgPSAiY2NwIiwNCj4+Pj4+DQo+Pj4+DQo+Pj4NCj4+Pg0KPj4NCj4gDQo+
IA0KDQo=
