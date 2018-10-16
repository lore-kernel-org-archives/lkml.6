Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5289AC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B612089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fKSsF79z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B612089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeJPKmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:42:32 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:36928
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726928AbeJPKmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8wHUaA3mQ0nie9fLqs92UgsJkuHGuwCDNPFiH6Pezc=;
 b=fKSsF79z9NmfvnGUhtc/+Ju7CuBTA8lI0s+sLqZf4eQtjZoxHMqmfBUX7YhphEuVkxrB8W6pNFfdxpNFw0RKvZXojbMooau9oUUnEi/BPe4iEMCFVIqXHbG26Q1rr+tXciS+rg/OR9zoJzuXyDM0Brfh3Y3A7WiE2MWdEJusavA=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.191.158) by
 AM4PR08MB0737.eurprd08.prod.outlook.com (10.164.82.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Tue, 16 Oct 2018 02:54:20 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::fc13:4daf:d472:2eb]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::fc13:4daf:d472:2eb%4]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 02:54:20 +0000
From:   "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Will Deacon <Will.Deacon@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, "jdike@addtoit.com" <jdike@addtoit.com>,
        "Bin Lu (Arm Technology China)" <Bin.Lu@arm.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gYXJtNjQvcHRyYWNlOiBhZGQgUFRS?=
 =?utf-8?B?QUNFX1NZU0VNVSBhbmQgUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIHN1cHBv?=
 =?utf-8?Q?rt?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0L3B0cmFjZTogYWRkIFBUUkFDRV9TWVNF?=
 =?utf-8?B?TVUgYW5kIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCBzdXBwb3J0?=
Thread-Index: AQHUQ06Z76IemXQPGUiVctTXT3fxI6TewGWAgAACvYCAAASiAIAAldKQgAErWwCAQOJj8A==
Date:   Tue, 16 Oct 2018 02:54:20 +0000
Message-ID: <AM4PR08MB2929E6207681A78C615C174085FE0@AM4PR08MB2929.eurprd08.prod.outlook.com>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903165726.GJ6954@arm.com>
 <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
 <3641125.aEYyuDiOni@blindfold>
In-Reply-To: <3641125.aEYyuDiOni@blindfold>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR08MB0737;6:iIqRgAZsSb+V+Jm2IOJIS+aHn6+ryPlVGdLs17Q+gJfmP4R3vtaixizlQtqxLqkx6okAO0ONTgrug2XhZqbFFQmk8r3VvNhFZBbNeH56pDU5/4omaYqNWegsK9Z7tabQAD3FI16QbTpdlzA7dLHl0VLSFkSYSnWHeAebH/ytucu7SJttuhpe4ub7/ET+pGst6yjBq0CGvAfnZNI+kL/XlayfkWWjAjgy5ziaUlfaCLAlUv6d/pwV6ipVI/MlBZ8QmWEjLlOaSLjYcCDlvrE77DT6BUZcsD2ulmQOlxYNQhSUB+NDiGzaMmTmfTCsUp1VWVr56q5pDlmL71Fogd8CpH35Khwv3mQ1nXsc+0yNt2JhovFCyTd069BkJ30+P7VlyyCx7L1JVzeehQBbfT0kcYTzflBqKxJJRn9Dw26MOyfqI26/FvgHkAT4oDONUfyFM95MPgZLxjVQ11dxS4CMtQ==;5:0mS758xCJd3lShqKmghO8rsQKpGy1vWG/BjbOWrnI8k5262FmWo6o0DIup/zkrbqh2dArUIZ+oCAs3FB7hvzOXK58PnHebOpGOgYERTKZD36Mvc4vNQwkph0HqnDbLrrtyehVGBYElf8GJGu37w7kKoVVbNeoXeYeHPCTObhlMQ=;7:ChLisPVBCOpitsODQnsL+BqD3ARprYKJSaWjiMNE0rJynVeYa9XPBuXtF/n+RoEvdTdaYP4Ea0tDcM6hsKrhYGabscWQmY5b0H6U2f6I5vDfoVF5OJi6U+f3+VFp3wp8lDVoO+HwEMsSQ8pw6DFnJAYEkc8j0ak2rbz4EEitsL7+9DCjUqZfMFnhXtRdIqOwyYtSWBGQ5CKxzqdzuJaBG6ZN0qA8gO6SfBsWZeq75M2JIbcaiGtLG2cpFMABKz8g
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: faf6d8d8-adee-4db1-3bd3-08d63312aba8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:AM4PR08MB0737;
x-ms-traffictypediagnostic: AM4PR08MB0737:
x-microsoft-antispam-prvs: <AM4PR08MB073792643FBC71F8F569010585FE0@AM4PR08MB0737.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(4983020)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:AM4PR08MB0737;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB0737;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(136003)(396003)(40434004)(189003)(199004)(68736007)(256004)(14444005)(486006)(5024004)(6506007)(476003)(305945005)(97736004)(7736002)(55236004)(4326008)(99286004)(86362001)(76176011)(14454004)(106356001)(7696005)(72206003)(93886005)(224303003)(105586002)(74316002)(25786009)(26005)(6916009)(71190400001)(71200400001)(54906003)(99936001)(6116002)(2900100001)(8936002)(5250100002)(478600001)(316002)(3846002)(186003)(66066001)(5660300001)(2906002)(55016002)(446003)(6436002)(53936002)(81166006)(81156014)(11346002)(33656002)(102836004)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB0737;H:AM4PR08MB2929.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NDqEApY22VJK0IvksYkbtNcZlQRXQV/AJsgN98VGbhLk4auFAt4DItN1aTUJIsfRHZUIfd/i2yRaCwnPHmv+MGDMxOlzUhBykmH5/H0ffAnfaSHKs9yz3OhS/x1bXp/Vsrmkui3IIlC0rQ9I0N4YNiaeAZc4/OVi6d5A/B2t4kY3IgZFknPdfX4Okcm1TZc7cCTjZtpV7SWpT+oAA6mOCfDU63MetePFmgy3FA3NuTsaFavBS8eCJzxxmHLtVx01A5WXUdksnUTu4jJBYnsN3xoA81LJfmTSLxgjv0OS9KWw5Z2OQE93jGFCuc6fPPSodFLTl5qePO6D+zawCH35dFYM3Lhwkl2Tia9xidhM178=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/mixed;
        boundary="_002_AM4PR08MB2929E6207681A78C615C174085FE0AM4PR08MB2929eurp_"
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf6d8d8-adee-4db1-3bd3-08d63312aba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 02:54:20.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_AM4PR08MB2929E6207681A78C615C174085FE0AM4PR08MB2929eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBTZXAgMDUsIDIwMTggYXQgMDM6NDU6NTFBTSArMDIwMCwgUmljaGFyZCBXZWluYmVy
Z2VyIHdyb3RlOg0KPiBBbSBEaWVuc3RhZywgNC4gU2VwdGVtYmVyIDIwMTgsIDA0OjExOjA3IENF
U1Qgc2NocmllYiBIYWlibyBYdSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpOg0KPiA+IEhpIFJpY2hh
cmQsDQo+ID4NCj4gPiBXaGF0IGRvIHlvdSBtZWFuIGJ5IGRvbmUgaXQgaW4gdGhlIGNvcmU/IG1v
dmluZyBtYWNybyBkZWZpbml0aW9uIHRvIGluY2x1ZGUvdWFwaS9saW51eC9wdHJhY2UuaD8NCj4g
PlRoZSBwYXRjaCBpcyBzdHJpY3RseSBmb2xsb3cgeDg2J3Mgc2VtYXRpYyBvbiBQVFJBQ0VfU1lT
RU1VL1NJTkdMRVNURVAgc3VwcG9ydC4NCj4NCj4gV2VsbCwgdGhlIGZlYXR1cmUgaXRzZWxmIGlz
IG5vdCByZWFsbHkgYXJjaGl0ZWN0dXJlIHNwZWNpZmljLg0KPiBKdXN0IGJlY2F1c2UgeDg2IGRv
ZXMgaXQgaW4gYXJjaC94ODYsIGl0IGRvZXMgbm90IG1lYW4gdGhhdCB0aGlzIGlzIHRoZSBiZXN0
IHdheS4NCj4gSSBndWVzcyB0aGlzIGlzIGFsc28gd2hhdCBXaWxsIHRyaWVkIHRvIHNheS4NCj4g
SWYgd2UgY2FuLCB3ZSBzaG91bGQgaW1wbGVtZW50IFBUUkFDRV9TWVNFTVUgaW4gdGhlIGNvcmUg
cHRyYWNlIGNvZGUgYW5kIG5vdCBwZXIgYXJjaGl0ZWN0dXJlLg0KPg0KDQpBZnRlciByZS1ldmFs
dWF0aW5nIHRoZSB3b3JrbG9hZCB0byB1bmlmeSB0aGUgUFRSQUNFX1NZU0VNVSBpbiB0aGUgY29y
ZSBwdHJhY2UgY29kZSBvbiBib3RoIEFSTSBhbmQgeDg2IGFyY2hpdGVjdHVyZSwNCldlIHRoaW5r
IHdlIGFyZSBub3QgYWJsZSB0byB3b3JrIG9uIGl0IHJlY2VudGx5KHdlIG9ubHkgaGF2ZSAxLjUg
cGVyc29uIHdvcmsgb24gdGhlIEd2aXNvciBwcm9qZWN0KS4NCg0KPiA+ID4gPiBJIHdvbmRlciB3
aGF0IEhhaWJvIFh1IHdhbnQgdG8gZG8gd2l0aCBQVFJBQ0VfU1lTRU1VIG9uIGFybTY0Lg0KPiA+
ID4gPiBBcmUgeW91IHBvcnRpbmcgVU1MIG9yIGd2aXNvciB0byBhcm02ND8NCj4gPiA+DQo+ID4g
PiBUaGF0J3MgYSBnb29kIHF1ZXN0aW9uLiBIYWlibz8NCj4gPg0KPiA+IFRoZSBzdG9yeSBpcyB3
ZSBhcmUgd29ya2luZyBvbiBhIGNvbnRhaW5lciBydW50aW1lKEdvb2dsZSBHdmlzb3IpDQo+ID4g
c3VwcG9ydCBvbiBBUk02NCBwbGF0Zm9ybSwgYW5kIHRoZSBHdmlzb3IgZGVwZW5kIG9uIExpbnV4
IGtlcm5lbCBQVFJBQ0VfU1lTRU1VL1NJTkdMRVNURVAgc3VwcG9ydC4NCj4NCj4gR3Zpc29yIGFs
c28gc3VwcG9ydHMgYSBrdm0gYmFja2VuZCB3aGljaCBzaG91bGQgYmUgKm11Y2gqIGZhc3RlciB0
aGFuIFBUUkFDRV9TWVNFTVUuDQo+IE90aGVyd2lzZSBndmlzb3Igc3VmZmVycyBmcm9tIHRoZSBz
YW1lIHBlcmZvcm1hbmNlIGRyYXdiYWNrcyBhcyBVTUwgZG9lcy4NCj4gUGFnZWZhdWx0cyB2aWEg
U0lHU0VHVi9tbWFwLCBzeXNjYWxsIGdhdGUgdmlhIHB0cmFjZSgpLg0KPg0KPiBEaWQgeW91IGNo
ZWNrLCBpcyBQVFJBQ0VfU1lTRU1VIHJlYWxseSB0aGUgd2F5IHRvIGdvIGZvciBndmlzb3I/DQo+
IExhc3QgdGltZSBJIGNoZWNrZWQgdGhlIEtWTSBiYWNrZW5kIGxvb2tlZCBwcm9taXNpbmcgYnV0
IHN0aWxsIFdJUCwgdGhvdWdoLg0KPg0KDQpHdmlzb3IgZG8gc3VwcG9ydCB0d28gcGxhdGZvcm1z
LCBwdHJhY2UgYW5kIGt2bS4gVG8gc3VwcG9ydCBwdHJhY2UgcGxhdGZvcm0gb24gQVJNNjQgaXMg
b3VyIGZpcnN0IHN0ZXAuDQpGcm9tIHRoZSBsb25nIHJ1biwgS1ZNIHdvdWxkIGJlIGEgYmV0dGVy
IGNob2ljZSwgYW5kIHdlIHdpbGwgd29yayBvbiBpdCBhZnRlciBwdHJhY2UgcGxhdGZvcm0gZ2V0
IHdvcmtlZC4NCg0KQ3VycmVudGx5LCAgb3VyIGluaXRpYWwgcGF0Y2hlcyBmb3IgR3Zpc29yIEFS
TTY0IHN1cHBvcnQgYXJlIHJlYWR5IGZvciB0aGUgc21hbGwgImhlbGxvLXdvcmxkIiBjb250YWlu
ZXINCihwbGVhc2UgcmVmZXIgdG8gdGhlIGF0dGFjaG1lbnQgZm9yIHRoZSB0ZXN0IGxvZ3MpLCAg
YW5kIHdlIGFyZSBpbiB0aGUgcHJvY2VzcyBvZiB1cHN0cmVhbWluZyB0aGUgY29kZS4NCkNvdWxk
IHlvdSBoZWxwIG1lcmdlIHRoaXMgcGF0Y2ggdG8gdGhlIExpbnV4IGtlcm5lbCBmb3IgdGhlIHRp
bWUgYmVpbmc/ICBXZSBjYW4gcmVzY2hlZHVsZSB0aGUgcmVzb3VyY2UNCnRvIHVuaWZ5IHRoZSBv
dmVyYWxsIFB0cmFjZSBjb2RlcyBpbiB0aGUga2VybmVsIGxhdGUuDQoNCj4gSSBhbHNvIHdvbmRl
ciB3aGV0aGVyIFBUUkFDRV9TWVNFTVUgaXMgcmVhbGx5IHRoZSBvbmx5IG1pc3NpbmcgYml0IHRv
IHN1cHBvcnQgZ3Zpc29yIG9uIGFybTY0LiBEaWQgeW91IGNoZWNrIGhvdyB0byB3b3JrIGFyb3Vu
ZCBWSVBUL1ZJVlQgY2FjaGluZyBpc3N1ZXM/DQo+IFVNTCAoYW5kIGd2aXNvciBpbiB0aGlzIGNv
bnRleHQpIGhhdmUgbG90cyBvZiBpbXBsaWNpdCB4ODYgZGVwZW5kZW5jaWVzLg0KDQpBcyBmYXIg
YXMgd2Uga25vdywgIFBUUkFDRV9TWVNFTVUgaXMgdGhlIG9ubHkgbWlzc2luZyBiaXQgdGhhdCBu
ZWVkZWQgaW4gTGludXgga2VybmVsIHRvIHN1cHBvcnQgR3Zpc29yIHB0cmFjZSBwbGF0Zm9ybSBv
biBBUk02NC4NCg0KVGhhbmtzLA0KDQpIYWlibw0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrl
j5Hku7bkuro6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+DQrlj5HpgIHml7bp
l7Q6IDIwMTjlubQ55pyINeaXpSAzOjQ1DQrmlLbku7bkuro6IEhhaWJvIFh1IChBcm0gVGVjaG5v
bG9neSBDaGluYSkgPEhhaWJvLlh1QGFybS5jb20+DQrmioTpgIE6IFdpbGwgRGVhY29uIDxXaWxs
LkRlYWNvbkBhcm0uY29tPjsgQ2F0YWxpbiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJtLmNv
bT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbmQgPG5kQGFybS5jb20+OyBqZGlrZUBhZGR0b2l0LmNvbQ0K5Li76aKY
OiBSZTog562U5aSNOiBbUEFUQ0hdIGFybTY0L3B0cmFjZTogYWRkIFBUUkFDRV9TWVNFTVUgYW5k
IFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCBzdXBwb3J0DQoNCkFtIERpZW5zdGFnLCA0LiBTZXB0
ZW1iZXIgMjAxOCwgMDQ6MTE6MDcgQ0VTVCBzY2hyaWViIEhhaWJvIFh1IChBcm0gVGVjaG5vbG9n
eSBDaGluYSk6DQo+IEhpIFJpY2hhcmQsDQo+DQo+IFdoYXQgZG8geW91IG1lYW4gYnkgZG9uZSBp
dCBpbiB0aGUgY29yZT8gbW92aW5nIG1hY3JvIGRlZmluaXRpb24gdG8gaW5jbHVkZS91YXBpL2xp
bnV4L3B0cmFjZS5oPw0KPiBUaGUgcGF0Y2ggaXMgc3RyaWN0bHkgZm9sbG93IHg4NidzIHNlbWF0
aWMgb24gUFRSQUNFX1NZU0VNVS9TSU5HTEVTVEVQIHN1cHBvcnQuDQoNCldlbGwsIHRoZSBmZWF0
dXJlIGl0c2VsZiBpcyBub3QgcmVhbGx5IGFyY2hpdGVjdHVyZSBzcGVjaWZpYy4NCkp1c3QgYmVj
YXVzZSB4ODYgZG9lcyBpdCBpbiBhcmNoL3g4NiwgaXQgZG9lcyBub3QgbWVhbiB0aGF0IHRoaXMg
aXMgdGhlIGJlc3Qgd2F5Lg0KSSBndWVzcyB0aGlzIGlzIGFsc28gd2hhdCBXaWxsIHRyaWVkIHRv
IHNheS4NCklmIHdlIGNhbiwgd2Ugc2hvdWxkIGltcGxlbWVudCBQVFJBQ0VfU1lTRU1VIGluIHRo
ZSBjb3JlIHB0cmFjZSBjb2RlIGFuZCBub3QgcGVyIGFyY2hpdGVjdHVyZS4NCg0KPiA+ID4gSSB3
b25kZXIgd2hhdCBIYWlibyBYdSB3YW50IHRvIGRvIHdpdGggUFRSQUNFX1NZU0VNVSBvbiBhcm02
NC4NCj4gPiA+IEFyZSB5b3UgcG9ydGluZyBVTUwgb3IgZ3Zpc29yIHRvIGFybTY0Pw0KPiA+DQo+
ID4gVGhhdCdzIGEgZ29vZCBxdWVzdGlvbi4gSGFpYm8/DQo+DQo+IFRoZSBzdG9yeSBpcyB3ZSBh
cmUgd29ya2luZyBvbiBhIGNvbnRhaW5lciBydW50aW1lKEdvb2dsZSBHdmlzb3IpDQo+IHN1cHBv
cnQgb24gQVJNNjQgcGxhdGZvcm0sIGFuZCB0aGUgR3Zpc29yIGRlcGVuZCBvbiBMaW51eCBrZXJu
ZWwgUFRSQUNFX1NZU0VNVS9TSU5HTEVTVEVQIHN1cHBvcnQuDQoNCkd2aXNvciBhbHNvIHN1cHBv
cnRzIGEga3ZtIGJhY2tlbmQgd2hpY2ggc2hvdWxkIGJlICptdWNoKiBmYXN0ZXIgdGhhbiBQVFJB
Q0VfU1lTRU1VLg0KT3RoZXJ3aXNlIGd2aXNvciBzdWZmZXJzIGZyb20gdGhlIHNhbWUgcGVyZm9y
bWFuY2UgZHJhd2JhY2tzIGFzIFVNTCBkb2VzLg0KUGFnZWZhdWx0cyB2aWEgU0lHU0VHVi9tbWFw
LCBzeXNjYWxsIGdhdGUgdmlhIHB0cmFjZSgpLg0KDQpEaWQgeW91IGNoZWNrLCBpcyBQVFJBQ0Vf
U1lTRU1VIHJlYWxseSB0aGUgd2F5IHRvIGdvIGZvciBndmlzb3I/DQpMYXN0IHRpbWUgSSBjaGVj
a2VkIHRoZSBLVk0gYmFja2VuZCBsb29rZWQgcHJvbWlzaW5nIGJ1dCBzdGlsbCBXSVAsIHRob3Vn
aC4NCg0KSSBhbHNvIHdvbmRlciB3aGV0aGVyIFBUUkFDRV9TWVNFTVUgaXMgcmVhbGx5IHRoZSBv
bmx5IG1pc3NpbmcgYml0IHRvIHN1cHBvcnQgZ3Zpc29yIG9uIGFybTY0LiBEaWQgeW91IGNoZWNr
IGhvdyB0byB3b3JrIGFyb3VuZCBWSVBUL1ZJVlQgY2FjaGluZyBpc3N1ZXM/DQpVTUwgKGFuZCBn
dmlzb3IgaW4gdGhpcyBjb250ZXh0KSBoYXZlIGxvdHMgb2YgaW1wbGljaXQgeDg2IGRlcGVuZGVu
Y2llcy4NCg0KVGhhbmtzLA0KLy9yaWNoYXJkDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNv
bnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFs
IGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5v
dCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBh
bnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1
bS4gVGhhbmsgeW91Lg0K

--_002_AM4PR08MB2929E6207681A78C615C174085FE0AM4PR08MB2929eurp_
Content-Type: text/plain; name="Gvisor logs.txt"
Content-Description: Gvisor logs.txt
Content-Disposition: attachment; filename="Gvisor logs.txt"; size=622;
	creation-date="Tue, 16 Oct 2018 02:48:49 GMT";
	modification-date="Tue, 16 Oct 2018 02:08:09 GMT"
Content-Transfer-Encoding: base64

Wz8yMDE4Lz8xMC8/MTUgMTg6MTVdICBCaW4gTHUgKEFybSBUZWNobm9sb2d5IENoaW5hKTogIA0K
cm9vdEBlbnRvczE6L2dvL3NyYy9naXRodWIuY29tL2dvb2dsZS9ndmlzb3IjIHVuYW1lIC1wDQph
YXJjaDY0DQpyb290QGVudG9zMTovZ28vc3JjL2dpdGh1Yi5jb20vZ29vZ2xlL2d2aXNvciMgZG9j
a2VyIHJ1biAtLXJ1bnRpbWU9cnVuc2MgaGVsbG8td29ybGQNClcxMDEwIDE3OjQ2OjE2LjUxMDU2
MSAzMDM1OSB4OjBdIENvdWxkIG5vdCBwYXJzZSAvcHJvYy9jcHVpbmZvLCBpdCBpcyBlbXB0eSBv
ciBkb2VzIG5vdCBjb250YWluIGNwdSBNSHoNClcxMDEwIDE3OjQ2OjE2LjUzNzAwNyAzMDM3MCB4
OjBdIENvdWxkIG5vdCBwYXJzZSAvcHJvYy9jcHVpbmZvLCBpdCBpcyBlbXB0eSBvciBkb2VzIG5v
dCBjb250YWluIGNwdSBNSHoNClcxMDEwIDE3OjQ2OjE2LjU1NjkxOSAzMDM3MCB4OjBdIENvdWxk
IG5vdCBwYXJzZSAvcHJvYy9jcHVpbmZvLCBpdCBpcyBlbXB0eSBvciBkb2VzIG5vdCBjb250YWlu
IGNwdSBNSHoNCg0KSGVsbG8gZnJvbSBEb2NrZXIhDQpUaGlzIG1lc3NhZ2Ugc2hvd3MgdGhhdCB5
b3VyIGluc3RhbGxhdGlvbiBhcHBlYXJzIHRvIGJlIHdvcmtpbmcgY29ycmVjdGx5LiANCg==

--_002_AM4PR08MB2929E6207681A78C615C174085FE0AM4PR08MB2929eurp_--
