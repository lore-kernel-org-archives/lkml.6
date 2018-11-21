Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC99214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vHjLLIuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC99214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeKVDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:22:47 -0500
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:25908
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726941AbeKVDWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3pYz8hrZOpidM+HN6bxh2aV+3f6BQn9jmvYjTkvQb8=;
 b=vHjLLIuI8SsdgunbSpwZp4PpQhF8HkqbnkeemrqDv7K/2B5Udc84P3EHbS9xD3/xQDdAU2PNfWbVRpkGa0La1HW3rikcEvnbMFl2DSz8A70YSbPNMQYLVQSapSt6JP5Zuw7K8RvM7NlvlsjztTqqX25SdVU0C8aayqkzo3Y3fLA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1307.namprd12.prod.outlook.com (10.168.237.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 16:47:31 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 16:47:31 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
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
Subject: RE: [PATCH v8 06/13] arch/resctrl: Initialize the resource functions
 that are different
Thread-Topic: [PATCH v8 06/13] arch/resctrl: Initialize the resource functions
 that are different
Thread-Index: AQHUfe6TCpevkO+y4E+Sg4r2ehYjAaVYc4kAgAAjNwCAAeD9UA==
Date:   Wed, 21 Nov 2018 16:47:30 +0000
Message-ID: <DM5PR12MB24713B1A0FB97FAF2CCCB9A895DA0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-7-babu.moger@amd.com> <20181120095918.GD2527@zn.tnic>
 <20181120120519.GE2527@zn.tnic>
In-Reply-To: <20181120120519.GE2527@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1307;20:nUDmXUuJsSHG/BREjiuTIDuZ31/CMLXN75gtLAJ6SQv9hGVOcm1isLSq64aqnw0RcEe7myorEWi2wdRscqmuXxwE07KhUtCJwmxY3aFPr1SdfXvS1tBARgbLDm2SgB9fDcjdJgBrNRX3mI3NwT93EavckZbUtDFcK/rzJ+CpT0lQ7zAcZBq4dnBqw4m3hz0EfyiFE75hzSz06JSTvc0fgDhhqg1QfjUmYbGD92WBAZ16B4aHaClsVCNtGkFmLXOz
x-ms-office365-filtering-correlation-id: 20577a20-fece-4041-7774-08d64fd1078f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1307;
x-ms-traffictypediagnostic: DM5PR12MB1307:
x-microsoft-antispam-prvs: <DM5PR12MB130764ED1BDE432D7BD86B8B95DA0@DM5PR12MB1307.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1307;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1307;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(13464003)(74316002)(5660300001)(7416002)(6116002)(33656002)(68736007)(7406005)(7696005)(7736002)(305945005)(3846002)(6916009)(6436002)(99286004)(229853002)(14454004)(72206003)(53936002)(6246003)(9686003)(478600001)(25786009)(76176011)(55016002)(105586002)(71190400001)(26005)(106356001)(97736004)(446003)(11346002)(102836004)(2900100001)(71200400001)(2906002)(476003)(256004)(81156014)(66066001)(81166006)(6506007)(8676002)(53546011)(93886005)(86362001)(8936002)(486006)(316002)(54906003)(4326008)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1307;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: myf3lueUWVnpOaLt5tDsFXPZoQpxxIOUWHTIBrSUPZ3m27Rrw7Eweds6Zjk3qpXLfgsqit6IIQiiW7z2dvMr2jjMk9lPcIOemcuJpJN6K8iBMNQ/jbUj6WNVpMFmxxm9XlGuNNY4Q0Yhz2bmvoECsgvoOlag6YBwV/crqwImZ2xvdGQkvonrP9HJNw43GtBYj82SHzRK9Wk4CdEN4/j91/zTz0a4FnOky+N3tu+Bt/DnzHtZrglDqOntbpSD5MM+lrxcGG0jHwuD1ivYw7e+2Fo3/0PaH0uxY6M05d2Hz4pov0h267VLN5/BcA8jQYYO2A/s03ZX2Ssnl9756+4XYvWN71cHsPhCGtRW3Ji2kJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20577a20-fece-4041-7774-08d64fd1078f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 16:47:31.1543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIwLCAyMDE4IDY6MDUg
QU0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+IENjOiB0Z2x4QGxp
bnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGNvcmJldEBsd24ubmV0Ow0KPiBmZW5naHVh
Lnl1QGludGVsLmNvbTsgcmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbTsgcGV0ZXJ6QGluZnJhZGVh
ZC5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0
OyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgaHBhQHp5dG9yLmNvbTsgeDg2QGtlcm5l
bC5vcmc7DQo+IG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3JnOyBhcm5kQGFybmRiLmRlOw0KPiBr
c3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBwb21icmVkYW5uZUBuZXhiLmNvbTsNCj4gcmFm
YWVsQGtlcm5lbC5vcmc7IGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb207IHRvbnkubHVj
a0BpbnRlbC5jb207DQo+IHFpYW55dWUuempAYWxpYmFiYS1pbmMuY29tOyB4aWFvY2hlbi5zaGVu
QGludGVsLmNvbTsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgU2luZ2gsIEJyaWplc2ggPGJyaWpl
c2guc2luZ2hAYW1kLmNvbT47IEh1cndpdHosDQo+IFNoZXJyeSA8c2hlcnJ5Lmh1cndpdHpAYW1k
LmNvbT47IGR3bXcyQGluZnJhZGVhZC5vcmc7IExlbmRhY2t5LA0KPiBUaG9tYXMgPFRob21hcy5M
ZW5kYWNreUBhbWQuY29tPjsgbHV0b0BrZXJuZWwub3JnOyBqb3JvQDhieXRlcy5vcmc7DQo+IGph
bm5oQGdvb2dsZS5jb207IHZrdXpuZXRzQHJlZGhhdC5jb207IHJpYW5AYWx1bS5taXQuZWR1Ow0K
PiBqcG9pbWJvZUByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDA2LzEz
XSBhcmNoL3Jlc2N0cmw6IEluaXRpYWxpemUgdGhlIHJlc291cmNlIGZ1bmN0aW9ucw0KPiB0aGF0
IGFyZSBkaWZmZXJlbnQNCj4gDQo+IE9uIFR1ZSwgTm92IDIwLCAyMDE4IGF0IDEwOjU5OjE4QU0g
KzAxMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiBTbyBJJ20gd29uZGVyaW5nOiBpbnN0
ZWFkIG9mIGhhdmluZyBtYmFfd3Jtc3JfaW50ZWwoKSBhbmQNCj4gPiBtYmFfd3Jtc3JfYW1kKCkg
YW5kIGFkZGluZyB0aG9zZSBwZXItdmVuZG9yIGluaXRpYWxpemF0aW9uIGZ1bmN0aW9ucywNCj4g
PiB3aHkgZG9uJ3QgeW91IHB1c2ggZG93biB0aGUgdmVuZG9yIGRpZmZlcmVudGlhdGlvbiBpbnRv
IG1iYV93cm1zcigpPw0KPiA+DQo+ID4gVGhlbiBpbiB0aGF0IGZ1bmN0aW9uIHlvdSBkbw0KPiA+
DQo+ID4gCWlmICh2ZW5kb3IgPT0gWDg2X1ZFTkRPUl9JTlRFTCkNCj4gPiAJCV9fbWJhX3dybXNy
X2ludGVsKCk7DQo+ID4gCWVsc2UgaWYgKHZlbmRvciA9PSBYODZfVkVORE9SX0FNRCkNCj4gPiAJ
CV9fbWJhX3dybXNyX2FtZCgpOw0KPiA+DQo+ID4gYW5kIHNvIG9uIGFuZCB0aGVuIHlvdSBkb24n
dCBoYXZlIHRvIGRvIGFueSBvZiB0aGF0IGluaXRpYWxpemF0aW9uIGRhbmNlDQo+ID4gaGVyZSBh
bmQgdGhlIHN0cnVjdCByZHRfcmVzb3VyY2UgYXNzaWdubWVudCBmb3IgdGhlIE1CQSB3aWxsIHJl
bWFpbg0KPiA+IG5pY2VseSBzaW1pbGFyIHRvIHRoZSBvdGhlciBvbmVzLi4uDQo+ID4NCj4gPiBI
bW1tPw0KPiANCj4gWWVhaCwgYWZ0ZXIgaGF2aW5nIGxvb2sgYXQgdGhlIHBhdGNoc2V0IGZ1cnRo
ZXIsIHRoYXQgbWlnaHQgbm90IGJlIGENCj4gZ29vZCBpZGVhIGFzIHlvdSBuZWVkIHRvIGFzc2ln
biBtb3JlIHBlci12ZW5kb3Igc3R1ZmYgdGhhbiBqdXN0IGFuIE1TUg0KPiBhY2Nlc3NvciBmdW5j
dGlvbi4uLg0KDQpPay4gTm8gY2hhbmdlcyBoZXJlLiBUaGFua3MNCg0KPiANCj4gLS0NCj4gUmVn
YXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gR29vZCBtYWlsaW5nIHByYWN0aWNlcyBm
b3IgNDAwOiBhdm9pZCB0b3AtcG9zdGluZyBhbmQgdHJpbSB0aGUgcmVwbHkuDQo=
