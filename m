Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4125C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935A1206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O6ABrCyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935A1206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeKRCvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:51:12 -0500
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:7440
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbeKRCvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2MB4GT79jhW0AqW8reyGGpZmouDHp756PZwJjcwX7k=;
 b=O6ABrCyvxGvMYmP35Mbu12iwTtoidEAK4+71m9OSe4cyzGY0MaryN9DkofI+40+7AY4PoAwrnELr9vGPbMoDCq/lZbUfsD0wb+N8QqkrWmVKv9vRK/QfSZRXAek/IoKs13qNXoJKnewzIVC7cqhDrH4x+MC38//AeJ0zIo5qux0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1898.namprd12.prod.outlook.com (10.175.88.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Sat, 17 Nov 2018 16:31:01 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Sat, 17 Nov 2018
 16:31:01 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v8 09/13] arch/resctrl: Update the RESCTRL config
 parameter
Thread-Topic: [PATCH v8 09/13] arch/resctrl: Update the RESCTRL config
 parameter
Thread-Index: AQHUfe6XZhXn+cShck2xKML8ztcZU6VS58MAgAFBuFA=
Date:   Sat, 17 Nov 2018 16:30:56 +0000
Message-ID: <DM5PR12MB24715C9965DF98A97A8C9BC095DE0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-10-babu.moger@amd.com>
 <99946ea2-dceb-b274-2434-2e9e1c211582@infradead.org>
In-Reply-To: <99946ea2-dceb-b274-2434-2e9e1c211582@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:ecbc:5b4b:777f:b4cd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1898;20:EbXGDCZN5qBhXYEAX24LtzRfNNqaTdyfwJpTswuHf9J3/hLhQTASTaeU4386KznZS91MQ8ZLs1lAhI8ic0DgjVLZMHcdXCXFRELWcp8TyK71GlxVNszqyVr4yh+Pgg9QyAdRQOItiBc6ThOvM0I+4mbWoFY6w/OQ4WmYPQE0HmKjnLbgCBS5ZB19dpgX3ziOtMqOaS3O7e6B6Fo/pOE5pcTHK6+aCD0T/0B6AkrIbuerrtKOY1oS4ddKa4xq42Hi
x-ms-office365-filtering-correlation-id: c7e74440-5cdf-4776-2891-08d64caa0fb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1898;
x-ms-traffictypediagnostic: DM5PR12MB1898:
x-microsoft-antispam-prvs: <DM5PR12MB18989442669CFDC403B2026295DE0@DM5PR12MB1898.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1898;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1898;
x-forefront-prvs: 085956473E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(396003)(346002)(13464003)(189003)(199004)(43544003)(51914003)(14444005)(6246003)(6116002)(446003)(11346002)(256004)(46003)(25786009)(15650500001)(2201001)(476003)(33656002)(14454004)(68736007)(486006)(86362001)(229853002)(105586002)(305945005)(71190400001)(7416002)(7406005)(53936002)(71200400001)(6436002)(2906002)(76176011)(8676002)(102836004)(81156014)(81166006)(74316002)(8936002)(97736004)(186003)(106356001)(478600001)(316002)(4326008)(7696005)(6506007)(53546011)(6666004)(2501003)(54906003)(110136005)(7736002)(5660300001)(9686003)(72206003)(55016002)(2900100001)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1898;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jRdKRh8yzHMvG7m0bNJO43dNwwxbqSW5TpwJhupw45t0vgoS9xCOsYFKTPJXoluhClbFgC1DDaoUrSlErnMKihRjuHe8E1j0vN3g5q1IgvDYlzUZhNAkmaFXCgx7x5uOANmv9nvfei6kcfRMeUYwPDGhAcamoMwnmf5IHQiBm2kiTmbahKTdcRzi6YYw/Yvz2YQjp0nOXLtP6idAccFk7+/5yMdsFSOKTYfM8omNlTQZNygWamFbfqhEiSGnnPmabn8NaAAXpnUrFFm3YglXtESiwBGSalb7tkKChhze6Is6xPUfjYlpgJ3IHgiAqBPYx0qIZ4hfLZSZqSHB6SUBZrQP+Bf+4z/2SJ0PxwJWVdQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e74440-5cdf-4776-2891-08d64caa0fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2018 16:31:00.8764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmFuZHksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2Vy
bmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtl
cm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBSYW5keSBEdW5sYXANCj4gU2VudDogRnJpZGF5LCBOb3Zl
bWJlciAxNiwgMjAxOCAzOjE4IFBNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQu
Y29tPjsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjgu
ZGU7IGNvcmJldEBsd24ubmV0Ow0KPiBmZW5naHVhLnl1QGludGVsLmNvbTsgcmVpbmV0dGUuY2hh
dHJlQGludGVsLmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9u
Lm9yZw0KPiBDYzogaHBhQHp5dG9yLmNvbTsgeDg2QGtlcm5lbC5vcmc7IG1jaGVoYWIrc2Ftc3Vu
Z0BrZXJuZWwub3JnOw0KPiBhcm5kQGFybmRiLmRlOyBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24u
b3JnOyBwb21icmVkYW5uZUBuZXhiLmNvbTsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7IGtpcmlsbC5z
aHV0ZW1vdkBsaW51eC5pbnRlbC5jb207IHRvbnkubHVja0BpbnRlbC5jb207DQo+IHFpYW55dWUu
empAYWxpYmFiYS1pbmMuY29tOyB4aWFvY2hlbi5zaGVuQGludGVsLmNvbTsNCj4gcGJvbnppbmlA
cmVkaGF0LmNvbTsgU2luZ2gsIEJyaWplc2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT47IEh1cndp
dHosDQo+IFNoZXJyeSA8c2hlcnJ5Lmh1cndpdHpAYW1kLmNvbT47IGR3bXcyQGluZnJhZGVhZC5v
cmc7IExlbmRhY2t5LA0KPiBUaG9tYXMgPFRob21hcy5MZW5kYWNreUBhbWQuY29tPjsgbHV0b0Br
ZXJuZWwub3JnOyBqb3JvQDhieXRlcy5vcmc7DQo+IGphbm5oQGdvb2dsZS5jb207IHZrdXpuZXRz
QHJlZGhhdC5jb207IHJpYW5AYWx1bS5taXQuZWR1Ow0KPiBqcG9pbWJvZUByZWRoYXQuY29tOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDA5LzEzXSBhcmNoL3Jlc2N0cmw6IFVwZGF0ZSB0
aGUgUkVTQ1RSTCBjb25maWcNCj4gcGFyYW1ldGVyDQo+IA0KPiBPbiAxMS8xNi8xOCAxMjo1NCBQ
TSwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+ID4gQ09ORklHX1JFU0NUUkwgd2lsbCBiZSB1c2VkIGZv
ciBib3RoIEludGVsIGFuZCBBTUQgdG8gZW5hYmxlDQo+ID4gUmVzb3VyY2UgQ29udHJvbCBmZWF0
dXJlLiBVcGRhdGUgdGhlIGRldGFpbHMgYW5kIGNvbmRpdGlvbiBhY2NvcmRpbmdseS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgYXJjaC94ODYvS2NvbmZpZyB8IDE5ICsrKysrKysrKysrKysrLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvS2NvbmZpZyBiL2FyY2gveDg2L0tjb25maWcNCj4gPiBp
bmRleCA0YWFlN2FiYTRkNjEuLmM1ZWYzYWZhODlhNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4
Ni9LY29uZmlnDQo+ID4gKysrIGIvYXJjaC94ODYvS2NvbmZpZw0KPiA+IEBAIC00NDgsMTMgKzQ0
OCwyMiBAQCBjb25maWcgUkVUUE9MSU5FDQo+ID4gIGNvbmZpZyBSRVNDVFJMDQo+ID4gIAlib29s
ICJSZXNvdXJjZSBDb250cm9sIGZlYXR1cmUgc3VwcG9ydCINCj4gPiAgCWRlZmF1bHQgbg0KPiA+
IC0JZGVwZW5kcyBvbiBYODYgJiYgQ1BVX1NVUF9JTlRFTA0KPiA+ICsJZGVwZW5kcyBvbiBYODYg
JiYgKENQVV9TVVBfSU5URUwgfHwgQ1BVX1NVUF9BTUQpDQo+ID4gIAlzZWxlY3QgS0VSTkZTDQo+
ID4gIAloZWxwDQo+ID4gLQkgIFNlbGVjdCB0byBlbmFibGUgcmVzb3VyY2UgYWxsb2NhdGlvbiBh
bmQgbW9uaXRvcmluZyB3aGljaCBhcmUNCj4gPiAtCSAgc3ViLWZlYXR1cmVzIG9mIEludGVsIFJl
c291cmNlIERpcmVjdG9yIFRlY2hub2xvZ3koUkRUKS4gTW9yZQ0KPiA+IC0JICBpbmZvcm1hdGlv
biBhYm91dCBSRFQgY2FuIGJlIGZvdW5kIGluIHRoZSBJbnRlbCB4ODYNCj4gPiAtCSAgQXJjaGl0
ZWN0dXJlIFNvZnR3YXJlIERldmVsb3BlciBNYW51YWwuDQo+ID4gKwkgIFNlbGVjdCB0byBlbmFi
bGUgUmVzb3VyY2UgQ29udHJvbCBmZWF0dXJlIHN1cHBvcnQuDQo+ID4gKw0KPiA+ICsJICBUaGVz
ZSBmZWF0dXJlcyBhcmUgaW50ZW5kZWQgdG8gcHJvdmlkZSB0aGUgc3VwcG9ydCBmb3IgdGhlDQo+
IGFsbG9jYXRpb24NCj4gPiArCSAgYW5kIG1vbml0b3JpbmcgdGhlIHVzYWdlIG9mIGNlcnRhaW4g
c3lzdGVtIHJlc291cmNlcyBieSBvbmUgb3INCj4gbW9yZQ0KPiANCj4gCSAgYW5kIG1vbml0b3Jp
bmcgb2YgdGhlIHVzYWdlDQogDQpTdXJlLiBXaWxsIHRha2UgY2FyZSBvZiB0aGlzIG5leHQgcmV2
aXNpb24uDQo+IA0KPiA+ICsJICBwcm9jZXNzb3JzLg0KPiA+ICsNCj4gPiArCSAgSW50ZWwgcmVm
ZXJzIHRoaXMgZmVhdHVyZSBhcyBJbnRlbCBSZXNvdXJjZSBEaXJlY3RvciBUZWNobm9sb2d5DQo+
IA0KPiAJICAgICAgICByZWZlcnMgdG8gdGhpcyBmZWF0dXJlDQoNClllcy4gV2lsbCB0YWtlIGNh
cmUuDQoNCj4gDQo+ID4gKwkgIChJbnRlbChSKSBSRFQpLiBNb3JlIGluZm9ybWF0aW9uIGFib3V0
IFJEVCBjYW4gYmUgZm91bmQgaW4gdGhlDQo+ID4gKwkgIEludGVsIHg4NiBBcmNoaXRlY3R1cmUg
U29mdHdhcmUgRGV2ZWxvcGVyIE1hbnVhbC4NCj4gPiArDQo+ID4gKwkgIEFNRCByZWZlcnMgdGhp
cyBmZWF0dXJlIGFzIEFNRCBQbGF0Zm9ybSBRdWFsaXR5IG9mIFNlcnZpY2UoQU1EDQo+IFFvUyku
DQo+IA0KPiAJICAgICAgcmVmZXJzIHRvIHRoaXMgZmVhdHVyZQ0KDQpTdXJlLiBXaWxsIGZpeC4g
VGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj4gDQo+ID4gKwkgIE1vcmUgaW5mb3JtYXRpb24g
YWJvdXQgQU1EIFFvUyBjYW4gYmUgZm91bmQgaW4gQU1ENjQNCj4gVGVjaG5vbG9neQ0KPiA+ICsJ
ICBQbGF0Zm9ybSBRdWFsaXR5IG9mIFNlcnZpY2UgRXh0ZW5zaW9ucyBtYW51YWwuDQo+ID4NCj4g
PiAgCSAgU2F5IE4gaWYgdW5zdXJlLg0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiB+UmFuZHkN
Cg==
