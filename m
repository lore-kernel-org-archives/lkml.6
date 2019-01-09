Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9DDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EC5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rD0BjB0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfAIREC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:04:02 -0500
Received: from mail-eopbgr800048.outbound.protection.outlook.com ([40.107.80.48]:62592
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfAIREC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABVMoQiPBxT/chUD12ug435ZfTDhwImDIG6A0HCyj34=;
 b=rD0BjB0swS5gPzfKdXhBMygCk/AveWO8k4XvCmI+8o+zNw1MNVSaagFiSif1rmXrZ4JWTU/b3nC39BskUdxfYc+HP2I8REmI2Y2+2najtrRoadYgTVa1Alax3j06gYbyTg1zNN4+xinlHTpVCqyrCaWn+XtxGGk9yKarsG+6QR8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1740.namprd12.prod.outlook.com (10.175.89.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.10; Wed, 9 Jan 2019 17:03:55 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::18e3:137e:93c9:ca26]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::18e3:137e:93c9:ca26%2]) with mapi id 15.20.1516.015; Wed, 9 Jan 2019
 17:03:55 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: RE: [PATCH] x86/cache: Rename config option to CONFIG_X86_RESCTRL
Thread-Topic: [PATCH] x86/cache: Rename config option to CONFIG_X86_RESCTRL
Thread-Index: AQHUp3WUCPC0ux0F6UmgyF6e8H6xlqWnK62A
Date:   Wed, 9 Jan 2019 17:03:55 +0000
Message-ID: <3dea50d8-0e14-d2e5-d1ce-ab9db7ee78ab@amd.com>
References: <20181223124859.GA26860@zn.tnic>
 <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
 <20181226205616.GA4557@zn.tnic> <20181228124904.GC20003@gmail.com>
 <20190108171401.GC12235@zn.tnic>
In-Reply-To: <20190108171401.GC12235@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1740;20:tivCOryQh7CnvESg79f5di26I4IU1a2VcA/GBZpPQbDvwyKMVU4XW4iOWhz0bGnpVCw5mQgoZzioCSI//a1LUh3jQ1/NY3k/EbPqyRBKg4/xq5oVcgoF0FSVtjDHnuLaUaP8yWuHoWVgpppQR/vg415pKG8MThCg5CtGkmiAPNUDJm4V1rWn0q5drQudlkXtDEYKgOIyA0E9/ZwmnezIRZ8iOWvWuhfEBXIxyYp6IteamPkviJjlkYRhNTA+vw9x
x-ms-office365-filtering-correlation-id: f089abea-8632-4eb5-8ce7-08d67654701b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1740;
x-ms-traffictypediagnostic: DM5PR12MB1740:
x-microsoft-antispam-prvs: <DM5PR12MB174031FF4A61242716719AF9958B0@DM5PR12MB1740.namprd12.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(13464003)(54906003)(86362001)(31696002)(6246003)(53546011)(110136005)(5660300001)(2906002)(7736002)(36756003)(446003)(186003)(105586002)(2616005)(8936002)(26005)(6116002)(14444005)(25786009)(256004)(99286004)(102836004)(66574012)(316002)(305945005)(11346002)(229853002)(93886005)(476003)(72206003)(478600001)(14454004)(52116002)(53936002)(106356001)(6512007)(3846002)(76176011)(4326008)(6486002)(81166006)(81156014)(6506007)(66066001)(8676002)(386003)(6436002)(68736007)(97736004)(486006)(71190400001)(31686004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1740;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zimrEO7i2jcLKrqVJexiUX1nInwPS7XAOj239cBJRHOo3QErUVUFZG87p0nLon9mxnBqjz5/ajo3kTJ7BML/6TKnu6j+cEG+z7ULs+549/6YGKvrQqqfeAm4zFh3+4QEwQKBKsxzDJiE8/hnwvgsdWn88yXL11euDD7gpcMF/TAY/l0/4INCfxrakok2RpAE9aA+GBsdlQE7PRj9oZlNqPRJDFg2mO6ta5/riHtjwDvrTFEnKMPCZ9GY0tE6YYjHVZTkfu/S0dYMSyPCyWdJ6/kOcMp4lNx3JkCNfNHPfvZAiNoHfz23uVGdw5BaW2oE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C045EFE035CBE448B013E1ED29A65E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f089abea-8632-4eb5-8ce7-08d67654701b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 17:03:55.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCB0byBtZS4gU2FuaXR5IHRlc3RlZCB0aGUgcGF0Y2guDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0K
PiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDgsIDIwMTkgMTE6MTQgQU0NCj4gVG86IEluZ28gTW9s
bmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxp
bnV4LWZvdW5kYXRpb24ub3JnPjsgeDg2LW1sDQo+IDx4ODZAa2VybmVsLm9yZz47IGxrbWwgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBKYW1lcyBNb3JzZQ0KPiA8amFtZXMubW9yc2VA
YXJtLmNvbT47IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+Ow0KPiBGZW5naHVhIFl1
IDxmZW5naHVhLnl1QGludGVsLmNvbT47IFJlaW5ldHRlIENoYXRyZQ0KPiA8cmVpbmV0dGUuY2hh
dHJlQGludGVsLmNvbT47IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gU3ViamVj
dDogW1BBVENIXSB4ODYvY2FjaGU6IFJlbmFtZSBjb25maWcgb3B0aW9uIHRvIENPTkZJR19YODZf
UkVTQ1RSTA0KPiANCj4gV2lsbCBxdWV1ZSB0byB4ODYvdXJnZW50IGlmIG5vIGlzc3Vlcy4NCj4g
DQo+IC0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+IA0KPiBDT05G
SUdfUkVTQ1RSTCBpcyB0b28gZ2VuZXJpYy4gVGhlIGZpbmFsIGdvYWwgaXMgdG8gaGF2ZSBhIGdl
bmVyaWMNCj4gb3B0aW9uIGNhbGxlZCBsaWtlIHRoaXMgd2hpY2ggaXMgc2VsZWN0ZWQgYnkgdGhl
IGFyY2gtc3BlY2lmaWMgb25lcw0KPiBDT05GSUdfWDg2X1JFU0NUUkwgYW5kIENPTkZJR19BUk02
NF9SRVNDVFJMLiBUaGUgZ2VuZXJpYyBvbmUgd2lsbA0KPiBjb3ZlciB0aGUgcmVzY3RybCBmaWxl
c3lzdGVtIGFuZCBvdGhlciBnZW5lcmljIGFuZCBzaGFyZWQgYml0cyBvZg0KPiBmdW5jdGlvbmFs
aXR5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0K
PiBTdWdnZXN0ZWQtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiBSZXF1ZXN0
ZWQtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCg0K
VGVzdGVkLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQoNCj4gQ2M6IEJhYnUg
TW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gQ2M6IEZlbmdodWEgWXUgPGZlbmdodWEueXVA
aW50ZWwuY29tPg0KPiBDYzogSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+DQo+IENj
OiBSZWluZXR0ZSBDaGF0cmUgPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQo+IENjOiBUb255
IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IENjOiB4ODZAa2VybmVsLm9yZw0KPiAtLS0N
Cj4gIERvY3VtZW50YXRpb24veDg2L3Jlc2N0cmxfdWkudHh0ICAgICB8IDIgKy0NCj4gIGFyY2gv
eDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gIGFyY2gveDg2L2luY2x1
ZGUvYXNtL3Jlc2N0cmxfc2NoZWQuaCB8IDQgKystLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9N
YWtlZmlsZSAgICAgICAgIHwgMiArLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL01h
a2VmaWxlIHwgNCArKy0tDQo+ICBpbmNsdWRlL2xpbnV4L3NjaGVkLmggICAgICAgICAgICAgICAg
fCAyICstDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsX3VpLnR4dA0K
PiBiL0RvY3VtZW50YXRpb24veDg2L3Jlc2N0cmxfdWkudHh0DQo+IGluZGV4IGQ5YWVkODMwMzk4
NC4uZThlOGQxNGQzYzRlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJs
X3VpLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsX3VpLnR4dA0KPiBAQCAt
OSw3ICs5LDcgQEAgRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5jb20+DQo+ICBUb255IEx1
Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+ICBWaWthcyBTaGl2YXBwYSA8dmlrYXMuc2hpdmFw
cGFAaW50ZWwuY29tPg0KPiANCj4gLVRoaXMgZmVhdHVyZSBpcyBlbmFibGVkIGJ5IHRoZSBDT05G
SUdfUkVTQ1RSTCBhbmQgdGhlIFg4NiAvcHJvYy9jcHVpbmZvDQo+ICtUaGlzIGZlYXR1cmUgaXMg
ZW5hYmxlZCBieSB0aGUgQ09ORklHX1g4Nl9SRVNDVFJMIGFuZCB0aGUgeDg2DQo+IC9wcm9jL2Nw
dWluZm8NCj4gIGZsYWcgYml0czoNCj4gIFJEVCAoUmVzb3VyY2UgRGlyZWN0b3IgVGVjaG5vbG9n
eSkgQWxsb2NhdGlvbiAtICJyZHRfYSINCj4gIENBVCAoQ2FjaGUgQWxsb2NhdGlvbiBUZWNobm9s
b2d5KSAtICJjYXRfbDMiLCAiY2F0X2wyIg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvS2NvbmZp
ZyBiL2FyY2gveDg2L0tjb25maWcNCj4gaW5kZXggNjE4NWQ0ZjMzMjk2Li4xNWFmMDkxNjExZTIg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L0tjb25maWcNCj4gKysrIGIvYXJjaC94ODYvS2NvbmZp
Zw0KPiBAQCAtNDQ2LDcgKzQ0Niw3IEBAIGNvbmZpZyBSRVRQT0xJTkUNCj4gIAkgIGJyYW5jaGVz
LiBSZXF1aXJlcyBhIGNvbXBpbGVyIHdpdGggLW1pbmRpcmVjdC1icmFuY2g9dGh1bmstZXh0ZXJu
DQo+ICAJICBzdXBwb3J0IGZvciBmdWxsIHByb3RlY3Rpb24uIFRoZSBrZXJuZWwgbWF5IHJ1biBz
bG93ZXIuDQo+IA0KPiAtY29uZmlnIFJFU0NUUkwNCj4gK2NvbmZpZyBYODZfUkVTQ1RSTA0KPiAg
CWJvb2wgIlJlc291cmNlIENvbnRyb2wgc3VwcG9ydCINCj4gIAlkZXBlbmRzIG9uIFg4NiAmJiAo
Q1BVX1NVUF9JTlRFTCB8fCBDUFVfU1VQX0FNRCkNCj4gIAlzZWxlY3QgS0VSTkZTDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZXNjdHJsX3NjaGVkLmgNCj4gYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9yZXNjdHJsX3NjaGVkLmgNCj4gaW5kZXggNTQ5OTBmZTJhM2FlLi40MGVi
ZGRkZTZhYzIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Jlc2N0cmxfc2No
ZWQuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZXNjdHJsX3NjaGVkLmgNCj4gQEAg
LTIsNyArMiw3IEBADQo+ICAjaWZuZGVmIF9BU01fWDg2X1JFU0NUUkxfU0NIRURfSA0KPiAgI2Rl
ZmluZSBfQVNNX1g4Nl9SRVNDVFJMX1NDSEVEX0gNCj4gDQo+IC0jaWZkZWYgQ09ORklHX1JFU0NU
UkwNCj4gKyNpZmRlZiBDT05GSUdfWDg2X1JFU0NUUkwNCj4gDQo+ICAjaW5jbHVkZSA8bGludXgv
c2NoZWQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9qdW1wX2xhYmVsLmg+DQo+IEBAIC04OCw2ICs4
OCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCByZXNjdHJsX3NjaGVkX2luKHZvaWQpDQo+IA0KPiAg
c3RhdGljIGlubGluZSB2b2lkIHJlc2N0cmxfc2NoZWRfaW4odm9pZCkge30NCj4gDQo+IC0jZW5k
aWYgLyogQ09ORklHX1JFU0NUUkwgKi8NCj4gKyNlbmRpZiAvKiBDT05GSUdfWDg2X1JFU0NUUkwg
Ki8NCj4gDQo+ICAjZW5kaWYgLyogX0FTTV9YODZfUkVTQ1RSTF9TQ0hFRF9IICovDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L01ha2VmaWxlIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9NYWtlZmlsZQ0KPiBpbmRleCBhYzc4ZjkwYWVhNTYuLmI2ZmEwODY5ZjdhYSAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9NYWtlZmlsZQ0KPiArKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L01ha2VmaWxlDQo+IEBAIC0zOSw3ICszOSw3IEBAIG9iai0kKENPTkZJR19DUFVfU1VQ
X1VNQ18zMikJCSs9DQo+IHVtYy5vDQo+ICBvYmotJChDT05GSUdfWDg2X01DRSkJCQkrPSBtY2Uv
DQo+ICBvYmotJChDT05GSUdfTVRSUikJCQkrPSBtdHJyLw0KPiAgb2JqLSQoQ09ORklHX01JQ1JP
Q09ERSkJCQkrPSBtaWNyb2NvZGUvDQo+IC1vYmotJChDT05GSUdfUkVTQ1RSTCkJCQkrPSByZXNj
dHJsLw0KPiArb2JqLSQoQ09ORklHX1g4Nl9SRVNDVFJMKQkJKz0gcmVzY3RybC8NCj4gDQo+ICBv
YmotJChDT05GSUdfWDg2X0xPQ0FMX0FQSUMpCQkrPSBwZXJmY3RyLXdhdGNoZG9nLm8NCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvTWFrZWZpbGUNCj4gYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvTWFrZWZpbGUNCj4gaW5kZXggNjg5NTA0OWNlZWY3
Li4xY2FiZTZmZDhlMTEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3Ry
bC9NYWtlZmlsZQ0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvTWFrZWZpbGUN
Cj4gQEAgLTEsNCArMSw0IEBADQo+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
DQo+IC1vYmotJChDT05GSUdfUkVTQ1RSTCkJKz0gY29yZS5vIHJkdGdyb3VwLm8gbW9uaXRvci5v
DQo+IC1vYmotJChDT05GSUdfUkVTQ1RSTCkJKz0gY3RybG1vbmRhdGEubyBwc2V1ZG9fbG9jay5v
DQo+ICtvYmotJChDT05GSUdfWDg2X1JFU0NUUkwpCSs9IGNvcmUubyByZHRncm91cC5vIG1vbml0
b3Iubw0KPiArb2JqLSQoQ09ORklHX1g4Nl9SRVNDVFJMKQkrPSBjdHJsbW9uZGF0YS5vIHBzZXVk
b19sb2NrLm8NCj4gIENGTEFHU19wc2V1ZG9fbG9jay5vID0gLUkkKHNyYykNCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc2NoZWQuaCBiL2luY2x1ZGUvbGludXgvc2NoZWQuaA0KPiBpbmRl
eCA4OTU0MWQyNDg4OTMuLjIyNDY2NjIyNmU4NyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51
eC9zY2hlZC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQuaA0KPiBAQCAtOTk1LDcgKzk5
NSw3IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCB7DQo+ICAJLyogY2dfbGlzdCBwcm90ZWN0ZWQgYnkg
Y3NzX3NldF9sb2NrIGFuZCB0c2stPmFsbG9jX2xvY2s6ICovDQo+ICAJc3RydWN0IGxpc3RfaGVh
ZAkJY2dfbGlzdDsNCj4gICNlbmRpZg0KPiAtI2lmZGVmIENPTkZJR19SRVNDVFJMDQo+ICsjaWZk
ZWYgQ09ORklHX1g4Nl9SRVNDVFJMDQo+ICAJdTMyCQkJCWNsb3NpZDsNCj4gIAl1MzIJCQkJcm1p
ZDsNCj4gICNlbmRpZg0KPiAtLQ0KPiAyLjE5LjENCj4gDQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3Ms
DQo+ICAgICBCb3Jpcy4NCj4gDQo+IFNVU0UgTGludXggR21iSCwgR0Y6IEZlbGl4IEltZW5kw7Zy
ZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwNCj4gSFJCIDIxMjg0IChBRyBOw7xy
bmJlcmcpDQo=
