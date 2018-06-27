Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF200C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBA623C29
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicroFocusInternational.onmicrosoft.com header.i=@MicroFocusInternational.onmicrosoft.com header.b="jUNpB33X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBA623C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeF0Gnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:43:42 -0400
Received: from prvmx04.microfocus.com ([130.57.1.219]:7373 "EHLO
        prvmx04.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeF0Gnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:43:40 -0400
Received: from prvxcaht04.microfocus.com (Not Verified[137.65.248.138]) by prvmx04.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5b33321b0000>; Wed, 27 Jun 2018 00:43:39 -0600
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (137.65.224.21)
 by mail.microfocus.com (137.65.248.138) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Wed, 27 Jun 2018 00:43:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-suse-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aykrQ9S5S4DEU9xk8CzwgSEK4dx4bFJcO+f3uFtSbb4=;
 b=jUNpB33XwaiEfraoe9atwkQhrCChPwTcIECAcWoDw9FGXhOKe+U+xib5gcJvnFx5QtohyyO7X4Vbcy64FFmQXeOrJ3D+vlq6JR2jTjxLsapuvi9DTLa71s8SgIQZnSyvNM/0uFRqQXev6jIg7RyiCvUnv/s9d0wJX3cHzPmHQQw=
Received: from SN1PR18MB2143.namprd18.prod.outlook.com (52.132.197.14) by
 SN1PR18MB0527.namprd18.prod.outlook.com (10.165.30.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Wed, 27 Jun 2018 06:43:36 +0000
Received: from SN1PR18MB2143.namprd18.prod.outlook.com
 ([fe80::dc8a:26c5:6c72:88fc]) by SN1PR18MB2143.namprd18.prod.outlook.com
 ([fe80::dc8a:26c5:6c72:88fc%2]) with mapi id 15.20.0906.023; Wed, 27 Jun 2018
 06:43:36 +0000
From:   Guomin Chen <guomin.chen@suse.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>, "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Subject: RE: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Thread-Topic: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Thread-Index: AQHUCiEKcTPx3XGobUmybR5M4UYpSqRs6q4AgATBFQCAAf/cUA==
Date:   Wed, 27 Jun 2018 06:43:36 +0000
Message-ID: <SN1PR18MB2143231E715365031B3ACDD99C480@SN1PR18MB2143.namprd18.prod.outlook.com>
References: <20180622120138.5411-1-guomin.chen@suse.com>
         <20180622231930.GA2834@bhelgaas-glaptop.roam.corp.google.com>
 <1529970820.14039.224.camel@hpe.com>
In-Reply-To: <1529970820.14039.224.camel@hpe.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR18MB0527;7:THbieywXlaXVC8eQ7x6stHyRcDhKoLd9CS1zNCsz0WvMgKc57RvoiHHIVl+sG8P8WN95TbAg3eX3I8zgcDVtKke81h7mlJjbnpvEGksya1i8U9/pEnHTNoq4XmkhduT8BXz89BISX/Bwus7Wd/I1DXA69l0NI9J230wcvz78xmfBtJAI3p6y/EQbFRX/+/APvzemIMlPI+wXvYl8JRystZ9/h5gQYxPnrrcitNnhgnVgT+bIoMt77gJkl9YRXzFB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 42cd6921-e4e8-4cf9-2ab9-08d5dbf94f52
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR18MB0527;
x-ms-traffictypediagnostic: SN1PR18MB0527:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=guomin.chen@suse.com; 
x-microsoft-antispam-prvs: <SN1PR18MB0527126E5EC35B7BB38DE91F9C480@SN1PR18MB0527.namprd18.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227479698468861)(173505980823694)(9452136761055)(767451399110)(211936372134217)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201703031522075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR18MB0527;BCL:0;PCL:0;RULEID:;SRVR:SN1PR18MB0527;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(13464003)(33656002)(229853002)(74316002)(5660300001)(305945005)(9686003)(5250100002)(81156014)(81166006)(68736007)(7416002)(316002)(296002)(8676002)(106356001)(14454004)(54906003)(7736002)(76176011)(110136005)(2501003)(55016002)(105586002)(7696005)(6436002)(25786009)(8936002)(478600001)(256004)(476003)(44832011)(186003)(11346002)(4326008)(14444005)(2906002)(66066001)(6116002)(446003)(2900100001)(102836004)(53936002)(97736004)(99286004)(53546011)(486006)(6506007)(3846002)(86362001)(575784001)(345774005)(6246003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB0527;H:SN1PR18MB2143.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RlLbxd5xcW2IH+gJLjetEOtg2aiZiM5L6hAD8P8m1vWFnmXabnbtNkmLSYoyX12VsdMt3z0kD2NOP5+WU0BPRpJ6XM/gs+pcPp43yh7u822VGykFdWLs/cPnHgfQJiTnh8rA8wbmhDgcrA+rtEewLHFIquOHF1d2BzwtpebARDhMwWcsk0d6DOszxLlv40wwpJ1wV4jcl/t2ZOzvM1QZ0SWhi3FhTSeBqAgNj/QFD0hHQfo0opUbGIqapo0ugFAXEwkzk67mM7s03mYZt4YX1Js43YKfjQGYGiz9L7qMX65eoqm8x/XxSFzwDH/qjuf77HL7/PBCfkfd9L3xfh05JOsRRMrBqE/0qmBBKXMnvbM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cd6921-e4e8-4cf9-2ab9-08d5dbf94f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 06:43:36.5296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB0527
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVG9zaGkNCglUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkgYW5kIHN1Z2dlc3Rpb25zLg0KCUkg
d2lsbCBjb250aW51ZSB0byBmb2xsb3cgYW5kIGludmVzdGlnYXRpb24gdGhpcyBpc3N1ZS4gdGhh
bmtzIA0KDQpUaGFua3MgYW5kIHJlZ2FyZHMNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEthbmksIFRvc2hpIFttYWlsdG86dG9zaGkua2FuaUBocGUuY29tXQ0KPiBT
ZW50OiAyMDE45bm0NuaciDI25pelIDc6NTYNCj4gVG86IEd1b21pbiBDaGVuIDxndW9taW4uY2hl
bkBzdXNlLmNvbT47IGhlbGdhYXNAa2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgSm9leSBMZWUgPEpMZWVAc3VzZS5jb20+OyBicEBzdXNlLmRlOw0KPiB0Z2x4
QGxpbnV0cm9uaXguZGU7IHRpd2FpQHN1c2UuZGU7IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7
DQo+IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgbGludXgtZWZpQHZnZXIua2VybmVsLm9yZzsg
YmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gdGhvbWFzLmxlbmRhY2t5QGFtZC5jb207IGJyaWplc2gu
c2luZ2hAYW1kLmNvbTsNCj4gYmFpeWFvd2VpQGNtc3MuY2hpbmFtb2JpbGUuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8xXSByZXNvdXJjZTogRml4ZWQgaW9tZW0gcmVzb3VyY2UgcmVsZWFz
ZSBmYWlsZWQgb24NCj4gcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoKSB3aGVuIG1lbW9y
eSBub2RlIG9yIGNwdSBub2RlDQo+IGhvdC1yZW1vdmUuDQo+IA0KPiBPbiBGcmksIDIwMTgtMDYt
MjIgYXQgMTg6MTkgLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gWytjYyBUb3NoaV0N
Cj4gPg0KPiA+IE9uIEZyaSwgSnVuIDIyLCAyMDE4IGF0IDA4OjAxOjM4UE0gKzA4MDAsIGd1b21p
biBjaGVuIHdyb3RlOg0KPiA+ID4gV2UndmUgZ290IGEgYnVnIHJlcG9ydCBpbmRpY2F0aW5nIHRo
ZSBob3QtcmVtb3ZlIG5vZGUgcmVzb3VyY2UNCj4gPiA+IHJlbGVhc2UgZmFpbGVkLHdoZW4gdGhl
IG1lbW9yeSBvbiB0aGlzIG5vZGUgaXMgZGl2aWRlZCBpbnRvIHNldmVyYWwNCj4gPiA+IHNlY3Rp
b25zLmJlY2F1c2UgdGhlIHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkgY2FuIG9ubHkN
Cj4gPiA+IHJlbGVhc2Ugb25lIHJlc291cmNlIHRoYXQgbXVzdCBiZSBbc3RhcnQsZW5kXS4NCj4g
Pg0KPiA+IENhbiB5b3UgcGxlYXNlIGluY2x1ZGUgYSBVUkwgZm9yIHRoZSBidWcgcmVwb3J0PyAg
VGhhdCdzIHVzZWZ1bCBmb3INCj4gPiBhZGRpdGlvbmFsIGRldGFpbHMgYW5kIGdpdmVzIGhpbnRz
IGFib3V0IGhvdyBmdXR1cmUgY2hhbmdlcyBpbiB0aGlzDQo+ID4gYXJlYSBtaWdodCBiZSB0ZXN0
ZWQuDQo+ID4NCj4gPiByZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0YWJsZSgpIGFuZCB0aGUgb25s
eSBjYWxsIHRvIGl0IHdlcmUgYWRkZWQgYnkNCj4gPiBUb3NoaSAoY2MnZCk6DQo+ID4NCj4gPiAg
IDgyNWY3ODdiYjQ5NiAoInJlc291cmNlOiBhZGQgcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFi
bGUoKSIpDQo+ID4gICBmZTc0ZWJiMTA2YTUgKCJtbTogY2hhbmdlIF9fcmVtb3ZlX3BhZ2VzKCkg
dG8gY2FsbA0KPiA+IHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkiKQ0KPiA+DQo+ID4g
PiBJbiBteSBjYXNlLCB0aGUgQklPUyBzdXBwb3J0cyBmYXVsdHkgbWVtb3J5IGlzb2xhdGlvbi4g
aWYgQklPUw0KPiA+ID4gZGV0ZWN0ZWQgYmFkIG1lbW9yeSBibG9jaywgdGhlIEJJT1Mgd2lsbCBp
c29sYXRlcyB0aGlzIGJhZGJsb2NrLg0KPiA+ID4gQW5kIHNldCB0aGlzIGJhZGJsb2NrIG1lbW9y
eSB0byBFZmlVbnVzYWJsZU1lbW9yeSBpbiBFRkkgbWVtb3J5IG1hcA0KPiA+ID4gYmFzZSBvbiBV
RUZJIDIuNyBzcGVjLkZvciBleGFtcGxlIGluIG15IHN5c3RlbSwgdGhlIG1lbW9yeSByYW5nZSBv
bg0KPiA+ID4gbm9kZTIgaXMgW21lbSAweDAwMDAwODAwMDAwMDAwMDAtMHgwMDAwMDgwN2ZmZmZm
ZmZmXS5idXQgdGhlIEJJT1MNCj4gPiA+IGRldGVjdGVkIHRoZSBbODAwNGUwMDAwMDAtODAwNGUw
ZmZmZmZdIGlzIGEgYmFkYmxvY2sgbWVtb3J5Lg0KPiA+ID4gU28gdGhlIG1lbW9yeSBvbiBub2Rl
MiBzZWVtIGxpa2UgdGhpczoNCj4gPiA+ICAgIAkJODAwMDAwMDAwMDAtODAwNGRmZmZmZmYgOiBT
eXN0ZW0gUkFNDQo+ID4gPiAJCTgwMDRlMDAwMDAwLTgwMDRlMGZmZmZmIDogVW51c2FibGUgbWVt
b3J5DQo+ID4gPiAJCTgwMDRlMTAwMDAwLTgwN2ZmZmZmZmZmIDogU3lzdGVtIFJBTQ0KPiA+ID4N
Cj4gPiA+IE5vdywgd2hlbiBvZmZsaW5lIHRoZSBjcHUgbm9kZTIsdGhlIGtlcm5lbCB3aWxsIHRy
eSB0byByZWxlYXNlDQo+ID4gPiBpb3Jlc291cmNlIFttZW0gMHgwMDAwMDgwMDAwMDAwMDAwLTB4
MDAwMDA4MDdmZmZmZmZmZl0uIGF0IHRoaXMNCj4gPiA+IHRpbWUsIHRoZSBrZXJuZWwgd2lsbCBy
ZWxlYXNlIGZhaWxlZCxhbmQgb3V0cHV0IGVycm9yIG1lc3NhZ2U6DQo+ID4gPiAiVW5hYmxlIHRv
IHJlbGVhc2UgcmVzb3VyY2UgPDB4MDAwMDA4MDAwMDAwMDAwMC0weDAwMDAwODA3ZmZmZmZmZmY+
DQo+ID4gPiAoLTIyKSIuDQo+IA0KPiBIbW0uLi4gdGhpcyBCSU8gaW1wbGVtZW50YXRpb24gZG9l
cyBub3Qgc291bmQgcmlnaHQgdG8gbWUuICBXaGVuIEVGSQ0KPiBtZW1vcnkgbWFwIGhhcyBhIGhv
bGUsIEFDUEkgbWVtb3J5IG9iamVjdCBzaG91bGQgaGF2ZSB0aGUgc2FtZSBob2xlIGluIGl0cw0K
PiByZXNvdXJjZSBpbmZvLiAgSWYgc28sIHRoaXMgbm9kZTIgbWVtb3J5IGhvdC1kZWxldGUgd291
bGQgaGF2ZSByZXF1ZXN0ZWQgYQ0KPiBkZWxldGlvbiBvZiAyIHNlcGFyYXRlIFN5c3RlbSBSQU0g
cmFuZ2VzLCBub3QgYSBzaW5nbGUgcmFuZ2UgaW5jbHVkaW5nIHRoaXMNCj4gaG9sZS4gIFRoaXMg
aXMgYWxzbyBpbXBvcnRhbnQgZm9yIG1lbW9yeSBob3QtYWRkLiAgQUNQSSBtZW1vcnkgb2JqZWN0
IG5lZWRzDQo+IHRvIGRlc2NyaWJlIHRoaXMgaG9sZSBpbiBvcmRlciBmb3IgdGhlIE9TIHRvIGF2
b2lkIGFkZGluZyB0aGlzIGJhZGJsb2NrIG1lbW9yeS4NCj4gDQo+IFRoYW5rcywNCj4gLVRvc2hp
DQo=
