Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB237C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8707421903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5VoNMU7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeLUB3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:29:37 -0500
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:23433
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731379AbeLUB3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e63wd8Zd2GH7RwEsiOg18be3WuhRHbKksqXyoLDDB4Y=;
 b=5VoNMU7euD4FWEYJn25XRHIo16xJhI8Mr1Xvz/9KPC4TZ0W2AradCLq9S90bsFdB4pPG3GAtGu93aKgYYKDDsgA3CH1IxmhZg08rehtuQYRgiOO9QTB6kIYj1PWbPMj3QTcgW0H1d4eAjmhBPK5ffUfn9US5qsmSyT7aqNqEHek=
Received: from BYAPR12MB2597.namprd12.prod.outlook.com (20.176.255.158) by
 BYAPR12MB3320.namprd12.prod.outlook.com (20.178.55.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Fri, 21 Dec 2018 01:29:31 +0000
Received: from BYAPR12MB2597.namprd12.prod.outlook.com
 ([fe80::b55e:6c0:7c93:41c]) by BYAPR12MB2597.namprd12.prod.outlook.com
 ([fe80::b55e:6c0:7c93:41c%2]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 01:29:18 +0000
From:   "Zhang, Jerry" <Jerry.Zhang@amd.com>
To:     =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm: Use drm_debug_printer for all
 ttm_bo_mem_space_debug output
Thread-Topic: [PATCH] drm/ttm: Use drm_debug_printer for all
 ttm_bo_mem_space_debug output
Thread-Index: AQHUmFZGo6LE/eW5tkqbwd1rP82n0KWIaK8A
Date:   Fri, 21 Dec 2018 01:29:18 +0000
Message-ID: <E6378BBE-6AB0-4B75-B59F-81315DB397E5@amd.com>
References: <20181220112209.8063-1-michel@daenzer.net>
In-Reply-To: <20181220112209.8063-1-michel@daenzer.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerry.Zhang@amd.com; 
x-originating-ip: [140.207.236.70]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3320;20:urgW0hIgvG1Hd5Gf1gAzUaupcAYueeYy+byeGFpFcIs1VjVQlh9ZhI35j4BIEPRTHQ6oX3pQXDZVCec0LDA+O5eINTkdzgodox9JPwYs3iqVpoIXppOsAGqP2lO9nLfBCsnhTk8aiZyvKa+wXLAVm1EmNMVoST8ADKz+fFJTcHfeBNlFIM9mhQClhKzj8VAFR7g/VMa5hjkMsObMBYZ9XR2g7nP2bpIXlUBeYvvmrerxiaudUIDzdn/vh+Fdahhv
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(6512007)(99286004)(6916009)(102836004)(26005)(476003)(2906002)(2616005)(53936002)(82746002)(316002)(11346002)(54906003)(66066001)(229853002)(446003)(72206003)(68736007)(25786009)(5660300001)(186003)(7736002)(36756003)(106356001)(6246003)(8936002)(71190400001)(71200400001)(8676002)(33656002)(305945005)(14454004)(86362001)(97736004)(4326008)(81156014)(81166006)(6436002)(256004)(6116002)(478600001)(6506007)(105586002)(3846002)(6486002)(76176011)(486006)(83716004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3320;H:BYAPR12MB2597.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 509b4052-11c0-4cf7-8231-08d666e3b9f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3320;
x-ms-traffictypediagnostic: BYAPR12MB3320:
x-microsoft-antispam-prvs: <BYAPR12MB33201A87D7018579D3D31DDEFFB80@BYAPR12MB3320.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB3320;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB3320;
x-forefront-prvs: 0893636978
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IRVK91wDeXuSJ6f3QnVQly95XMs17zKs1ucyl95N5wz3TGvqV/Dcb1rJhepMZSVg1ICGUZwgWnYVax7OtU0Vqv5ubkwsGTRP6iZdGZ36gCBtnBE0PJTQZoZK/ZOCLQ5biuJ/kZhnC9fOiuEy6F3rhQFBlOqm1VerSydj3f5GBESN9GDXDiooO7CZHvdf7PFSzIM5Wnj7vGlHahFrekkvNCPRduLDPeIV/2j7iHQ1hKyeGWlp8tsIgbsUHiPH9b5zbljscbz8OR/RhEEHFCAPgheiLes3nojfLMylTsGaq0EJnNfTh0hcbzQ8j14FpYJ0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2892442BCD41264EADD8A7AA7B9AA718@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509b4052-11c0-4cf7-8231-08d666e3b9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 01:29:18.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IOWcqCAyMDE45bm0MTLmnIgyMOaXpe+8jDE5OjIy77yMTWljaGVsIETDpG56ZXIgPG1pY2hl
bEBkYWVuemVyLm5ldD4g5YaZ6YGT77yaDQo+IA0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWlj
aGVsLmRhZW56ZXJAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5Llpo
YW5nQGFtZC5jb20+DQoNCj4gDQo+IE5vIG5lZWQgZm9yIHByX2VyciBoZXJlLCB0aGUgcHJfZXJy
IG1lc3NhZ2UgaW4gdHRtX2JvX2V2aWN0IGlzIGVub3VnaA0KPiB0byBkcmF3IGF0dGVudGlvbiB0
byBzb21ldGhpbmcgbm90IGdvaW5nIGFzIHBsYW5uZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
aWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4NCj4gLS0tDQo+IA0KPiBTaW1p
bGFyIHRvIGEgcHJldmlvdXMgcGF0Y2gsIGJ1dCB0aGlzIG9uZSBsZWF2ZXMgdGhlIHByX2VyciBt
ZXNzYWdlcyBpbg0KPiB0dG1fYm9fZXZpY3QgdW50b3VjaGVkLg0KPiANCj4gZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYyB8IDMzICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0K
PiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvLmMNCj4gaW5kZXggZDg3OTM1YmY4ZTMwLi4wZWMwODM5NGUxN2EgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiBAQCAtNzcsMzggKzc3LDM5IEBAIHN0YXRpYyBpbmxp
bmUgaW50IHR0bV9tZW1fdHlwZV9mcm9tX3BsYWNlKGNvbnN0IHN0cnVjdCB0dG1fcGxhY2UgKnBs
YWNlLA0KPiAJcmV0dXJuIDA7DQo+IH0NCj4gDQo+IC1zdGF0aWMgdm9pZCB0dG1fbWVtX3R5cGVf
ZGVidWcoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsIGludCBtZW1fdHlwZSkNCj4gK3N0YXRp
YyB2b2lkIHR0bV9tZW1fdHlwZV9kZWJ1ZyhzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwgc3Ry
dWN0IGRybV9wcmludGVyICpwLA0KPiArCQkJICAgICAgIGludCBtZW1fdHlwZSkNCj4gew0KPiAJ
c3RydWN0IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4gPSAmYmRldi0+bWFuW21lbV90eXBlXTsN
Cj4gLQlzdHJ1Y3QgZHJtX3ByaW50ZXIgcCA9IGRybV9kZWJ1Z19wcmludGVyKFRUTV9QRlgpOw0K
PiANCj4gLQlwcl9lcnIoIiAgICBoYXNfdHlwZTogJWRcbiIsIG1hbi0+aGFzX3R5cGUpOw0KPiAt
CXByX2VycigiICAgIHVzZV90eXBlOiAlZFxuIiwgbWFuLT51c2VfdHlwZSk7DQo+IC0JcHJfZXJy
KCIgICAgZmxhZ3M6IDB4JTA4WFxuIiwgbWFuLT5mbGFncyk7DQo+IC0JcHJfZXJyKCIgICAgZ3B1
X29mZnNldDogMHglMDhsbFhcbiIsIG1hbi0+Z3B1X29mZnNldCk7DQo+IC0JcHJfZXJyKCIgICAg
c2l6ZTogJWxsdVxuIiwgbWFuLT5zaXplKTsNCj4gLQlwcl9lcnIoIiAgICBhdmFpbGFibGVfY2Fj
aGluZzogMHglMDhYXG4iLCBtYW4tPmF2YWlsYWJsZV9jYWNoaW5nKTsNCj4gLQlwcl9lcnIoIiAg
ICBkZWZhdWx0X2NhY2hpbmc6IDB4JTA4WFxuIiwgbWFuLT5kZWZhdWx0X2NhY2hpbmcpOw0KPiAr
CWRybV9wcmludGYocCwgIiAgICBoYXNfdHlwZTogJWRcbiIsIG1hbi0+aGFzX3R5cGUpOw0KPiAr
CWRybV9wcmludGYocCwgIiAgICB1c2VfdHlwZTogJWRcbiIsIG1hbi0+dXNlX3R5cGUpOw0KPiAr
CWRybV9wcmludGYocCwgIiAgICBmbGFnczogMHglMDhYXG4iLCBtYW4tPmZsYWdzKTsNCj4gKwlk
cm1fcHJpbnRmKHAsICIgICAgZ3B1X29mZnNldDogMHglMDhsbFhcbiIsIG1hbi0+Z3B1X29mZnNl
dCk7DQo+ICsJZHJtX3ByaW50ZihwLCAiICAgIHNpemU6ICVsbHVcbiIsIG1hbi0+c2l6ZSk7DQo+
ICsJZHJtX3ByaW50ZihwLCAiICAgIGF2YWlsYWJsZV9jYWNoaW5nOiAweCUwOFhcbiIsIG1hbi0+
YXZhaWxhYmxlX2NhY2hpbmcpOw0KPiArCWRybV9wcmludGYocCwgIiAgICBkZWZhdWx0X2NhY2hp
bmc6IDB4JTA4WFxuIiwgbWFuLT5kZWZhdWx0X2NhY2hpbmcpOw0KPiAJaWYgKG1lbV90eXBlICE9
IFRUTV9QTF9TWVNURU0pDQo+IC0JCSgqbWFuLT5mdW5jLT5kZWJ1ZykobWFuLCAmcCk7DQo+ICsJ
CSgqbWFuLT5mdW5jLT5kZWJ1ZykobWFuLCBwKTsNCj4gfQ0KPiANCj4gc3RhdGljIHZvaWQgdHRt
X2JvX21lbV9zcGFjZV9kZWJ1ZyhzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLA0KPiAJCQkJ
CXN0cnVjdCB0dG1fcGxhY2VtZW50ICpwbGFjZW1lbnQpDQo+IHsNCj4gKwlzdHJ1Y3QgZHJtX3By
aW50ZXIgcCA9IGRybV9kZWJ1Z19wcmludGVyKFRUTV9QRlgpOw0KPiAJaW50IGksIHJldCwgbWVt
X3R5cGU7DQo+IA0KPiAtCXByX2VycigiTm8gc3BhY2UgZm9yICVwICglbHUgcGFnZXMsICVsdUss
ICVsdU0pXG4iLA0KPiAtCSAgICAgICBibywgYm8tPm1lbS5udW1fcGFnZXMsIGJvLT5tZW0uc2l6
ZSA+PiAxMCwNCj4gLQkgICAgICAgYm8tPm1lbS5zaXplID4+IDIwKTsNCj4gKwlkcm1fcHJpbnRm
KCZwLCAiTm8gc3BhY2UgZm9yICVwICglbHUgcGFnZXMsICVsdUssICVsdU0pXG4iLA0KPiArCQkg
ICBibywgYm8tPm1lbS5udW1fcGFnZXMsIGJvLT5tZW0uc2l6ZSA+PiAxMCwNCj4gKwkJICAgYm8t
Pm1lbS5zaXplID4+IDIwKTsNCj4gCWZvciAoaSA9IDA7IGkgPCBwbGFjZW1lbnQtPm51bV9wbGFj
ZW1lbnQ7IGkrKykgew0KPiAJCXJldCA9IHR0bV9tZW1fdHlwZV9mcm9tX3BsYWNlKCZwbGFjZW1l
bnQtPnBsYWNlbWVudFtpXSwNCj4gCQkJCQkJJm1lbV90eXBlKTsNCj4gCQlpZiAocmV0KQ0KPiAJ
CQlyZXR1cm47DQo+IC0JCXByX2VycigiICBwbGFjZW1lbnRbJWRdPTB4JTA4WCAoJWQpXG4iLA0K
PiAtCQkgICAgICAgaSwgcGxhY2VtZW50LT5wbGFjZW1lbnRbaV0uZmxhZ3MsIG1lbV90eXBlKTsN
Cj4gLQkJdHRtX21lbV90eXBlX2RlYnVnKGJvLT5iZGV2LCBtZW1fdHlwZSk7DQo+ICsJCWRybV9w
cmludGYoJnAsICIgIHBsYWNlbWVudFslZF09MHglMDhYICglZClcbiIsDQo+ICsJCQkgICBpLCBw
bGFjZW1lbnQtPnBsYWNlbWVudFtpXS5mbGFncywgbWVtX3R5cGUpOw0KPiArCQl0dG1fbWVtX3R5
cGVfZGVidWcoYm8tPmJkZXYsICZwLCBtZW1fdHlwZSk7DQo+IAl9DQo+IH0NCj4gDQo+IC0tIA0K
PiAyLjIwLjENCj4gDQoNCg==
