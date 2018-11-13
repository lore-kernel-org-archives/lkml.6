Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F80C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0435208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hFU7kIMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0435208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeKNDyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:54:50 -0500
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:55770
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731537AbeKNDyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0G71TMDuDtmFU4JlnGvTnWZwSLlPDRUBZowZihMNiA=;
 b=hFU7kIMQyc1TIEzLJ8YPYr5kArpDHOyDvf6hqru5NWcNR86w/t87d7XH0Tv7aJ7h5hZ1MEhK+pCjBeq9W7mvEp/LhGhON1EK8oKiXig87dc/h3YLnRtlc2nxvZD4Z7kjQni9KyhPYDcJDNxP+FbgJzEO13yuK4cvepWjpXtoHiY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5079.namprd05.prod.outlook.com (20.177.230.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.11; Tue, 13 Nov 2018 17:55:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.021; Tue, 13 Nov 2018
 17:55:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Topic: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Index: AQHUetXZ1x6cjbBfk0ugZnU2RuWk66VNksAAgABrugA=
Date:   Tue, 13 Nov 2018 17:55:36 +0000
Message-ID: <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
In-Reply-To: <20181113113000.GB4788@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5079;20:y/vLIVHr3Df84QoKsmYEr4iJP693df0mm+jcp2Jj/TrmsS+Sj5nOhM47e7R/vsbBFl8LNy9O8jnosyre5JXmm8tisfyMDXf4uxXw3Q9ZTZqBTlYf0FBjD6DwRQZSbSookjL1XQSi8DsYFKS+J4H4auN57yLcmu0ey/wFSn/lioU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 84ef892b-28c2-4a2c-0186-08d64991379d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5079;
x-ms-traffictypediagnostic: BYAPR05MB5079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB50795AA31A4BCD50C9686434D0C20@BYAPR05MB5079.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231406)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5079;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5079;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(4326008)(5660300001)(33656002)(2906002)(25786009)(86362001)(106356001)(6916009)(53546011)(102836004)(105586002)(6506007)(76176011)(99286004)(36756003)(14454004)(6246003)(2900100001)(478600001)(256004)(66066001)(6116002)(3846002)(6436002)(6486002)(6512007)(229853002)(53936002)(316002)(54906003)(186003)(2616005)(11346002)(446003)(26005)(476003)(486006)(68736007)(8936002)(83716004)(97736004)(7416002)(7736002)(81166006)(8676002)(81156014)(82746002)(305945005)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5079;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tb0BE8/YzW+5xpUlFMpJ8Mqr6wjK+6WgkLCL2RFdmc72wEQEoIkVRcv0dkaYfkkbk1Re2Spel3wNDA3ubNOI2fngQE/LCV+FfVe6RNTN+ePTDE/piZkI4Ftb4AY+WsXdUKNrMLXCf+MESLgTtWQKRHYGwxChGJIWChT8Q+TzHYLhbbrpIZxvedfyprgK8fJhr6mBDHUrjO4EE9RefGhNQ0si7bani7fZ1Gxwp3eFPYzTNEmyOVpsgcJgnepN3Copr65ITYMPCyAfMlNvzsShM7HZVFUPP9misyTOlP6AXaqD3xgcq/IuvkU18l0UwFQa5AKJWlN1+VhDJNK37eoBbU31S1svqgO/oE+J69YRG1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7350B89C4D60EB41A074B7F28CBABEE8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ef892b-28c2-4a2c-0186-08d64991379d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 17:55:36.9594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSW5nbyBNb2xuYXINClNlbnQ6IE5vdmVtYmVyIDEzLCAyMDE4IGF0IDExOjMwOjAwIEFN
IEdNVA0KPiBUbzogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gQ2M6IEluZ28gTW9s
bmFyIDxtaW5nb0ByZWRoYXQuY29tPiwgTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9A
c29jaW9uZXh0LmNvbT4sIE1pY2hhbCBNYXJlayA8bWljaGFsLmxrbWxAbWFya292aS5uZXQ+LCBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPiwgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+LCB4ODZAa2VybmVsLm9y
ZywgbGludXgta2J1aWxkQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gTWFrZWZpbGU6IEZpeCBkaXN0Y2MgY29t
cGlsYXRpb24gd2l0aCB4ODYgbWFjcm9zDQo+IA0KPiANCj4gDQo+ICogTmFkYXYgQW1pdCA8bmFt
aXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+IA0KPj4gSW50cm9kdWNpbmcgdGhlIHVzZSBvZiBhc20g
bWFjcm9zIGluIGMtY29kZSBicm9rZSBkaXN0Y2MsIHNpbmNlIGl0IG9ubHkNCj4+IHNlbmRzIHRo
ZSBwcmVwcm9jZXNzZWQgc291cmNlIGZpbGUuIFRoZSBzb2x1dGlvbiBpcyB0byBicmVhayB0aGUN
Cj4+IGNvbXBpbGF0aW9uIGludG8gdHdvIHNlcGFyYXRlIHBoYXNlcyBvZiBjb21waWxhdGlvbiBh
bmQgYXNzZW1ibHksIGFuZA0KPj4gYmV0d2VlbiB0aGUgdHdvIGNvbmNhdGFuYXRlIHRoZSBhc3Nl
bWJseSBtYWNyb3MgYW5kIHRoZSBjb21waWxlZCAoeWV0DQo+IA0KPiBzL2NvbmNhdGVuYXRlDQo+
IA0KPj4gbm90IGFzc2VtYmxlZCkgc291cmNlIGZpbGUuIFNpbmNlIHRoaXMgaXMgbGVzcyBlZmZp
Y2llbnQsIHRoaXMNCj4+IGNvbXBpbGF0aW9uIG1vZGUgaXMgb25seSB1c2VkIHdoZW4gbWFrZSBp
cyBjYWxsZWQgd2l0aCB0aGUgIkRJU1RDQz15Ig0KPj4gcGFyYW1ldGVyLg0KPj4gDQo+PiBOb3Rl
IHRoYXQgdGhlIGFzc2VtYmx5IHN0YWdlIHNob3VsZCBhbHNvIGJlIGRpc3RyaWJ1dGVkLCBpZiBk
aXN0Y2MgaXMNCj4+IGNvbmZpZ3VyZWQgdXNpbmcgIkNGTEFHUz0tREVOQUJMRV9SRU1PVEVfQVNT
RU1CTEUiLg0KPiANCj4gSXQncyBhIGJpdCBzYWQgdGhhdCB3ZSByZWdyZXNzZWQgZGlzdGNjIHBl
cmZvcm1hbmNlIOKApg0KDQpJIGRvbuKAmXQga25vdyB3aGF0IHRoZSBhY3R1YWwgaW1wYWN0IGlz
LCBidXQgTG9nYW4sIHdobyByZXBvcnRlZCB0aGUgYnVnIHNheXMNCnRoZXJlIGlzIGFuIGFsdGVy
bmF0aXZlIHNvbHV0aW9uIGZvciB3aGVuIGRpc3RjYy1wdW1wIGlzIHVzZWQgKHdoaWNoDQpwcmVz
dW1hYmx5IHdvdWxkIGhhdmUgfnplcm8gcGVyZm9ybWFuY2UgZGVncmFkYXRpb24pLiBkaXN0Y2Mg
aXMgcmVhbGx5DQpmcmFnaWxlIElNSE8gLSBpdOKAmXMgZW5vdWdoIHRoYXQgaXQgZmluZHMgd2hh
dCBsb29rcyBsaWtlIHR3byBzb3VyY2UgZmlsZXMgaW4NCnRoZSBjb21waWxlciBjb21tYW5kIGFy
Z3VtZW50cyBmb3IgaXQgdG8gZmFsbCBiYWNrIHRvIGxvY2FsIGNvbXBpbGF0aW9uLg0KDQpbIElu
IHRoaXMgcmVnYXJkLCB0aGUgZGlzdGNjLXB1bXAgc29sdXRpb24gd291bGQgKm5vdCogd29yayBp
ZiBkaXN0Y2MgaXMNCmJ1aWx0IHdpdGggc3VwcG9ydCBmb3IgZGlzdHJpYnV0ZWQgYXNzZW1ibHks
IHNpbmNlIGl0IHdpbGwgY29uc2lkZXIgdGhlIC5zDQpmaWxlIGFzIGEgc2Vjb25kIHNvdXJjZSBm
aWxlLiBdDQoNCj4+ICsjIElmIGRpc3RjYyBpcyB1c2VkLCB0aGVuIHdoZW4gYW4gYXNzZW1ibHkg
bWFjcm8gZmlsZXMgaXMgbmVlZGVkLCB0aGUNCj4+ICsjIGNvbXBpbGF0aW9uIHN0YWdlIGFuZCB0
aGUgYXNzZW1ibHkgc3RhZ2UgbmVlZCB0byBiZSBzZXBhcmF0ZWQuIFByb3ZpZGluZw0KPj4gKyMg
IkRJU1RDQz15IiBvcHRpb24gZW5hYmxlcyB0aGUgc2VwYXJhdGUgY29tcGlsYXRpb24gYW5kIGFz
c2VtYmx5Lg0KPiANCj4gTGV0J3MgZml4IHRoZSB2YXJpb3VzIHR5cG9zOg0KPiANCj4+ICsjIElm
IGRpc3RjYyBpcyB1c2VkLCBhbmQgd2hlbiBhc3NlbWJseSBtYWNybyBmaWxlcyBhcmUgbmVlZGVk
LCB0aGUNCj4+ICsjIGNvbXBpbGF0aW9uIHN0YWdlIGFuZCB0aGUgYXNzZW1ibHkgc3RhZ2UgbmVl
ZHMgdG8gYmUgc2VwYXJhdGVkLiANCj4+ICsjIFByb3ZpZGluZyB0aGUgIkRJU1RDQz15IiBvcHRp
b24gZW5hYmxlcyBzZXBhcmF0ZSBjb21waWxhdGlvbiBhbmQgDQo+PiArIyBhc3NlbWJseS4NCg0K
VGhhdOKAmXMgZ3JhbW1hciwgbm90IHR5cG9zIDstKQ0KDQpTb3JyeSBmb3IgdGhhdCAtIEkgd2ls
bCBmaXggaXQgYW4gc2VuZCB2MiAoYXMgd2VsbCBhcyB0aGUgd2hpdGVzcGFjZSBub2lzZSkuDQoN
ClJlZ2FyZHMsDQpOYWRhdg==
