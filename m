Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DAC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26B0218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Y6WaNq3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26B0218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeHNKHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:07:39 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:31184
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728209AbeHNKHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CY6eBH+CsLJxKfqaGlLTWX1ST7+jAbX5flQN2FseWI=;
 b=Y6WaNq3jjwF+40LqAhqkXKEy1pU2cpYvM4tjTTluzcCquold3bDx7vqKVCmlaNxmpR/KilYjdcYFdLGAAmrlJ6v/u+YEzwcNuM80H4MrdScri6fzGSn0zprcr/EiXDzVxvMPWitOIBaHr59O8A9gvknvy8tRn8xI0i2gmk0ufrI=
Received: from BN7PR07MB4676.namprd07.prod.outlook.com (52.135.249.153) by
 BN7PR07MB4547.namprd07.prod.outlook.com (52.135.253.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Tue, 14 Aug 2018 07:21:41 +0000
Received: from BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::e94b:eb6e:2766:3208]) by BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::e94b:eb6e:2766:3208%3]) with mapi id 15.20.1017.022; Tue, 14 Aug 2018
 07:21:40 +0000
From:   Janek Kotas <jank@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     Janek Kotas <jank@cadence.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: ufs: Add bindings for Cadence UFS
Thread-Topic: [PATCH v3 1/2] dt-bindings: ufs: Add bindings for Cadence UFS
Thread-Index: AQHUL+RojYplStHgSUimg9p+QzGwSKS9+PiAgADmIYA=
Date:   Tue, 14 Aug 2018 07:21:40 +0000
Message-ID: <38727B36-5200-4A3A-B3D1-88ADC5381622@global.cadence.com>
References: <F39BF38C-FD85-4115-975C-8D923518A541@global.cadence.com>
 <20180813173759.GA7302@rob-hp-laptop>
In-Reply-To: <20180813173759.GA7302@rob-hp-laptop>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jank@cadence.com; 
x-originating-ip: [199.43.4.28]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4547;20:g2BnFFCqC0nIGRUL9Mx9w8Zmdxl4xeI4wFBN3w9rTwUC8FHKPG9eEqdObiyNQXAj70zbilvXC5oI1l5ISMaWFeugZt5Di56hL47VT8AdsO5pdvO6W2alYFgWBvwQzF4k+YRfgghwHLN+prj0sBU/sS6uqK2KYqfL67moS58QxK51V3EeS8+ifBhxgcAESNMTHA4T5P2hNBigouEXf+UvMZN3+DVj2PqohTPUdLAwt84McVcdEB1IGNI+MlEGP+YA
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(36092001)(189003)(199004)(68736007)(186003)(53936002)(26005)(5660300001)(76176011)(99286004)(6306002)(39060400002)(6506007)(53546011)(6512007)(102836004)(83716003)(478600001)(6916009)(256004)(446003)(14444005)(11346002)(229853002)(486006)(8936002)(8676002)(305945005)(81166006)(6436002)(81156014)(476003)(6486002)(7736002)(4326008)(66066001)(86362001)(575784001)(33656002)(25786009)(14454004)(2900100001)(6116002)(3846002)(82746002)(6246003)(316002)(97736004)(966005)(54906003)(106356001)(105586002)(5250100002)(2906002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4547;H:BN7PR07MB4676.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: d73c2e11-424e-40c5-0930-08d601b69465
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4547;
x-ms-traffictypediagnostic: BN7PR07MB4547:
x-microsoft-antispam-prvs: <BN7PR07MB45478174F18AD52BEE7E81F0D0380@BN7PR07MB4547.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110)(10436049006162)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4547;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4547;
x-forefront-prvs: 0764C4A8CD
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qxu+dfbFJ8OYCH2UxWTa00uaYKq3h96Oz1U9r2f6wMmJyeXZgjMKDbtl/7PeLLiMPAVlE4m9cJyw+sriqQr9CDGdt6H0XMU03u4Ayhyy7pFBRHGiaYdW9o4HIuxQ6TG5yQqPpvphNDSO4pq04u/t6ItOfj/FeZUcY56qj9z0xf1Z7XR/R4Z8R7oshWo7klkO4MmfWd3aAefsUOR45JD7LZ+efKHdBLejsoJZ5rB/ptgKRYaHeGEkDfLz53O/8s7Oz5DU5fF6pWwVTpQ3NKGEfE3CmtTWoFprWIvvvEOGCVtNAyDqha0F52sxANewImcMm9QlgCB6Izh/1Pz7eERzH8dP+yrDbm1QTeEhWkwyMHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <56140F381512A04882BAFD1BAAF4A1F6@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73c2e11-424e-40c5-0930-08d601b69465
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 07:21:40.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTMgQXVnIDIwMTgsIGF0IDE5OjM3LCBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPiB3cm90ZToNCj4gDQoNCj4gDQo+IE9uIFRodSwgQXVnIDA5LCAyMDE4IGF0IDAxOjI1OjE1
UE0gKzAwMDAsIEphbmVrIEtvdGFzIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBhZGRzIGEgRFQgYmlu
ZGluZyBkb2N1bWVudGF0aW9uIGZvcg0KPj4gQ2FkZW5jZSBVRlMgSG9zdCBDb250cm9sbGVyLg0K
Pj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKYW4gS290YXMgPGphbmtAY2FkZW5jZS5jb20+DQo+PiAt
LS0NCj4+IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vmcy9jZG5zLHVmc2hjLnR4dCAgICAgICAg
IHwgMzEgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gMSBmaWxlIGNoYW5nZWQsIDMxIGluc2Vy
dGlvbnMoKykNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdWZzL2NkbnMsdWZzaGMudHh0DQo+PiANCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdWZzL2NkbnMsdWZzaGMudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vmcy9jZG5zLHVmc2hjLnR4dA0KPj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwLi5hMDRhNDk4OQ0KPj4gLS0tIC9kZXYvbnVs
bA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vmcy9jZG5zLHVm
c2hjLnR4dA0KPj4gQEAgLTAsMCArMSwzMSBAQA0KPj4gKyogQ2FkZW5jZSBVbml2ZXJzYWwgRmxh
c2ggU3RvcmFnZSAoVUZTKSBDb250cm9sbGVyDQo+PiArDQo+PiArVUZTIG5vZGVzIGFyZSBkZWZp
bmVkIHRvIGRlc2NyaWJlIG9uLWNoaXAgVUZTIGhvc3QgY29udHJvbGxlcnMuDQo+PiArRWFjaCBV
RlMgY29udHJvbGxlciBpbnN0YW5jZSBzaG91bGQgaGF2ZSBpdHMgb3duIG5vZGUuDQo+PiArUGxl
YXNlIHNlZSB0aGUgdWZzaGNkLXBsdGZybS50eHQgZm9yIGEgbGlzdCBvZiBhbGwgYXZhaWxhYmxl
IHByb3BlcnRpZXMuDQo+PiArDQo+PiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICstIGNvbXBh
dGlibGUJOiBDb21wYXRpYmxlIGxpc3QsIGNvbnRhaW5zIHRoZSBmb2xsb3dpbmcgY29udHJvbGxl
cjoNCj4+ICsJCQkiY2Rucyx1ZnNoYyINCj4+ICsJCSAgY29tcGxlbWVudGVkIHdpdGggdGhlIEpF
REVDIHZlcnNpb246DQo+PiArCQkJImplZGVjLHVmcy0yLjAiDQo+PiArDQo+PiArLSByZWcJCTog
QWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBVRlMgcmVnaXN0ZXIgc2V0Lg0KPj4gKy0gaW50ZXJy
dXB0cwk6IE9uZSBpbnRlcnJ1cHQgbWFwcGluZy4NCj4+ICstIGZyZXEtdGFibGUtaHoJOiBDbG9j
ayBmcmVxdWVuY3kgdGFibGUuDQo+PiArCQkgIFNlZSB0aGUgdWZzaGNkLXBsdGZybS50eHQgZm9y
IGRldGFpbHMuDQo+PiArLSBjbG9ja3MJOiBMaXN0IG9mIHBoYW5kbGUgYW5kIGNsb2NrIHNwZWNp
ZmllciBwYWlycy4NCj4+ICstIGNsb2NrLW5hbWVzCTogTGlzdCBvZiBjbG9jayBpbnB1dCBuYW1l
IHN0cmluZ3Mgc29ydGVkIGluIHRoZSBzYW1lDQo+PiArCQkgIG9yZGVyIGFzIHRoZSBjbG9ja3Mg
cHJvcGVydHkuICJjb3JlX2NsayIgaXMgbWFuZGF0b3J5Lg0KPj4gKwkJICBEZXBlbmRpbmcgb24g
YSB0eXBlIG9mIGEgUEhZLA0KPj4gKwkJICB0aGUgInBoeV9jbGsiIGNsb2NrIGNhbiBhbHNvIGJl
IGFkZGVkLCBpZiBuZWVkZWQuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCB5b3Ugd2VudCB0aGUgd3Jv
bmcgZGlyZWN0aW9uLiBUaGUgJ19jbGsnIHBhcnQgaXMgDQo+IHJlZHVuZGFudC4gSnVzdCDigJhj
b3Jl4oCZIGFuZCAncGh5Jy4NCg0KSSB1bmRlcnN0YW5kLCBob3dldmVyIHRoZSByZXN0IG9mIHRo
ZSB1ZnMgZnJhbWV3b3JrIHVzZXMgdGhlICdfY2xrJyBzdWZmaXg6DQpkcml2ZXJzL3Njc2kvdWZz
L3Vmc2hjZC5jOjY5OTk6DQoNCmlmICghSVNfRVJSX09SX05VTEwoY2xraS0+Y2xrKSkgewkJCQ0K
CWlmIChza2lwX3JlZl9jbGsgJiYgIXN0cmNtcChjbGtpLT5uYW1lLCAicmVmX2NsayIpKQkJCQ0K
CQljb250aW51ZTsNCg0KSSB3YW50ZWQgaXQgdG8gYmUgY29uc2lzdGVudCwgd2l0aCB0aGUgcmVz
dCBvZiB0aGUgVUZTIGRyaXZlcnMuDQoNClJlZ2FyZHMsDQpKYW4NCg0KPiBXaXRoIHRoYXQsDQo+
IA0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gDQo+PiAr
DQo+PiArRXhhbXBsZToNCj4+ICsJdWZzQGZkMDMwMDAwIHsNCj4+ICsJCWNvbXBhdGlibGUgPSAi
Y2Rucyx1ZnNoYyIsICJqZWRlYyx1ZnMtMi4wIjsNCj4+ICsJCXJlZyA9IDwweGZkMDMwMDAwIDB4
MTAwMDA+Ow0KPj4gKwkJaW50ZXJydXB0cyA9IDwwIDEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+
PiArCQlmcmVxLXRhYmxlLWh6ID0gPDAgMD4sIDwwIDA+Ow0KPj4gKwkJY2xvY2tzID0gPCZ1ZnNf
Y29yZV9jbGs+LCA8JnVmc19waHlfY2xrPjsNCj4+ICsJCWNsb2NrLW5hbWVzID0gImNvcmVfY2xr
IiwgInBoeV9jbGsiOw0KPj4gKwl9Ow0KPj4gLS0gDQo+PiAyLjE1LjANCj4+IA0KPj4gDQo+PiAt
LQ0KPj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vi
c2NyaWJlIGRldmljZXRyZWUiIGluDQo+PiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jk
b21vQHZnZXIua2VybmVsLm9yZw0KPj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cHM6Ly91
cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHAtM0FfX3ZnZXIua2VybmVsLm9y
Z19tYWpvcmRvbW8tMkRpbmZvLmh0bWwmZD1Ed0lCQWcmYz1hVXE5ODNMMnB1ZTJGcUtGb1A2UEdI
TUpReW9KN2tsM3MzR1otX2hhWHFZJnI9ZzdHQVFFTlZYeF9SUWR5WEhJblBNZyZtPWVjam15MlV2
bDNoQnBNdVVRWUZtNEhTRndwWk9Oa1QyUXI4ci0tN2cxdzgmcz1EYlFSdjFvR2xydTB3bUhaSmhG
WHpwN3l3a0dWODk1UFBQX0xBeS1XQmtNJmU9DQoNCg==
