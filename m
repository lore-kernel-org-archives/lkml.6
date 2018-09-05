Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F7DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E02920857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="T5mK/SzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E02920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeIEOv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:51:29 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:53664
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbeIEOv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYN5sBJrceVS94+IM+XQeEoZT/YKPvxCCIrub6l2Go0=;
 b=T5mK/SzS2Hzru9X29FfohPa7k26EipOzxQ/6DLf+73zjCgcWR3SE70Jwjp4xOhADUGo7DGKQ+FUDVT24qqcsS/U49eX0DN7E4wyGo52ptGFf4QR9HKI3cqIA+KmiWKe/CrrekKKyJdJMl+8OdZ5Qgu2xUcVv6YBOD6dfGWcJdxI=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.191.158) by
 AM4PR08MB0932.eurprd08.prod.outlook.com (10.166.133.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 10:21:51 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::1594:9b9e:28b0:1a63]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::1594:9b9e:28b0:1a63%2]) with mapi id 15.20.1101.019; Wed, 5 Sep 2018
 10:21:51 +0000
From:   "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Will Deacon <Will.Deacon@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, "jdike@addtoit.com" <jdike@addtoit.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gYXJtNjQvcHRyYWNlOiBhZGQgUFRS?=
 =?utf-8?B?QUNFX1NZU0VNVSBhbmQgUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIHN1cHBv?=
 =?utf-8?Q?rt?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0L3B0cmFjZTogYWRkIFBUUkFDRV9TWVNF?=
 =?utf-8?B?TVUgYW5kIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCBzdXBwb3J0?=
Thread-Index: AQHUQ06Z76IemXQPGUiVctTXT3fxI6TewGWAgAACvYCAAASiAIAAldKQgAErWwCAAOrDUA==
Date:   Wed, 5 Sep 2018 10:21:51 +0000
Message-ID: <AM4PR08MB29293D6F75396394B56D05E085020@AM4PR08MB2929.eurprd08.prod.outlook.com>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903165726.GJ6954@arm.com>
 <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
 <3641125.aEYyuDiOni@blindfold>
In-Reply-To: <3641125.aEYyuDiOni@blindfold>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR08MB0932;6:hVhCtjw95pLB1YnHSMNTf4Vz9nKu+e7iBssQeO9AzcCvsGWXPeIbfe4mjCxVmkIZDd1Ao/vyBUvSp8LUs84OJEjA/GfQG9Qq6u9zBiwLD2q9fRf12S0eYrx0Q8GloBXwPQwae2u0c5uffB4xjPhpQHY04xWIBBbbCq/p35tsxPGWPxU54krjBpz/PpBj2+uzYpVb/hPT+E7UY57xuEBylJjwqxobDkOt3JE1yfcZjDG7Nw4B3Bw+9RNRLFIAG8ubdY1cM3emQN+tj1YOoz2mgKIafH1WLAiTPLTlgCthuUkebNOr735L3UFi3iuf9ta0iQZjKdDHUCnppgsf9xhIo4VF2B9WkiXtIxPT55oUuq3swgq0s/xaCdu67Sd4ZtDU8Aehg/3H6K4gpOh8NaIXfEFOBmRcDnoqnt2x0gBe2wIbBbOGSiZdzKlgzJ502pTirNfP83sX5Znx9pwKpuqvXw==;5:3dpF8SCF55C35LrCJLwprXZf7Kh7I1O5283+uTRyCPB7ckwXddlcDIgGFJ6f269/Z8IxVGMIMx0kUUsNu5dOCgJEA2Aroi2/jTCH4Z4yvGGMVBcLMGg4XoJMHwK/eCAdLCLvJW4JCdUozcH9rsGq0f3k0h+EpbyHmeuStoyQaVE=;7:2uHbYt4+laUDjDKG8Lb4+sotC/582V0vMYp/9eczT7LpkJK5MhFzgqgFix1DpF/d8bn+eVJzG5x2u1EAkkqI0dq/cms+GEv1iROlIl1uYtpOMI2I2yPegdEhbcji63llD0Lazh0RizpmTWtUIDaPHOHqCjBsJtE7QztadQIpj5yn7C8X0v/hYPQO8C5butONb+iCMhobIfClpQarfsUYvnpY05wuANK5fM3mqt7so8kg/KEjkx99SLlmWWEVh9zV
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e5a5135b-4b5c-4cd6-821a-08d61319656f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB0932;
x-ms-traffictypediagnostic: AM4PR08MB0932:
x-microsoft-antispam-prvs: <AM4PR08MB09320186C76DAC74CDB9095E85020@AM4PR08MB0932.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(103651359005742)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:AM4PR08MB0932;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB0932;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(40434004)(4326008)(5250100002)(6916009)(5024004)(74316002)(7736002)(305945005)(99286004)(2900100001)(224303003)(106356001)(2906002)(316002)(68736007)(54906003)(7696005)(76176011)(8936002)(86362001)(66066001)(81156014)(14444005)(81166006)(256004)(25786009)(3846002)(6116002)(6436002)(93886005)(55016002)(478600001)(446003)(33656002)(14454004)(476003)(11346002)(102836004)(6506007)(55236004)(53936002)(5660300001)(97736004)(72206003)(105586002)(186003)(26005)(9686003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB0932;H:AM4PR08MB2929.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z0JHYQOPe6aHyHMUhkLwi2xIxC6srS5tVhF9uEh6zSKlp+oP9hv1NhL+i/74X1Rds16vOoXBnIQnXrjyTukd84weYqmrYRz0gA1ao4q6zUZvgo1he7RXzRiZZ07wg248fi2K/uG02tg69WB6u4EsOAjVFwP7BTdnkPcApHzQIYN8VZNeN7IfQRDl1jY9AGcO56xEQXiu/2Sd+unW0nILkGbGyXp7LxzjR3lsTuz+BxSvJQAG8Y+fGAd3+gxWGYlS0gdGwlnVyHejGSdTt8JO/CgTgwtMisviVKmo9Yw6hEf/RabJn5TRdLfuJGzJf8R61GNI9alrGm7IkZhT3oohVhXFT3e+53RcjufC7vLkwZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a5135b-4b5c-4cd6-821a-08d61319656f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 10:21:51.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
cHRyYWNlIGNvZGUgYW5kIG5vdCBwZXIgYXJjaGl0ZWN0dXJlLg0KPg0KDQpZZXMsIHRoZSBmZWF0
dXJlIGlzIGNvbW1vbiBvbiB4ODYvQVJNNjQsIGFuZCB0aGVyZSBhcmUgbWFueSBkdXBsaWNhdGVk
IGNvZGVzDQpvbiBib3RoIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBwdHJhY2UgY29kZXMuIEJ1dCB0
byB1bmlmeSB0aGVzZSBjb2RlcyBtYXkgdGFrZSBtb3JlIHRpbWUsDQp3ZSBuZWVkIHRvIHJlLWV2
YWx1YXRlIHRoZSB3b3JrbG9hZC4NCg0KPiA+ID4gPiBJIHdvbmRlciB3aGF0IEhhaWJvIFh1IHdh
bnQgdG8gZG8gd2l0aCBQVFJBQ0VfU1lTRU1VIG9uIGFybTY0Lg0KPiA+ID4gPiBBcmUgeW91IHBv
cnRpbmcgVU1MIG9yIGd2aXNvciB0byBhcm02ND8NCj4gPiA+DQo+ID4gPiBUaGF0J3MgYSBnb29k
IHF1ZXN0aW9uLiBIYWlibz8NCj4gPg0KPiA+IFRoZSBzdG9yeSBpcyB3ZSBhcmUgd29ya2luZyBv
biBhIGNvbnRhaW5lciBydW50aW1lKEdvb2dsZSBHdmlzb3IpDQo+ID4gc3VwcG9ydCBvbiBBUk02
NCBwbGF0Zm9ybSwgYW5kIHRoZSBHdmlzb3IgZGVwZW5kIG9uIExpbnV4IGtlcm5lbCBQVFJBQ0Vf
U1lTRU1VL1NJTkdMRVNURVAgc3VwcG9ydC4NCj4NCj4gR3Zpc29yIGFsc28gc3VwcG9ydHMgYSBr
dm0gYmFja2VuZCB3aGljaCBzaG91bGQgYmUgKm11Y2gqIGZhc3RlciB0aGFuIFBUUkFDRV9TWVNF
TVUuDQo+IE90aGVyd2lzZSBndmlzb3Igc3VmZmVycyBmcm9tIHRoZSBzYW1lIHBlcmZvcm1hbmNl
IGRyYXdiYWNrcyBhcyBVTUwgZG9lcy4NCj4gUGFnZWZhdWx0cyB2aWEgU0lHU0VHVi9tbWFwLCBz
eXNjYWxsIGdhdGUgdmlhIHB0cmFjZSgpLg0KPg0KPiBEaWQgeW91IGNoZWNrLCBpcyBQVFJBQ0Vf
U1lTRU1VIHJlYWxseSB0aGUgd2F5IHRvIGdvIGZvciBndmlzb3I/DQo+IExhc3QgdGltZSBJIGNo
ZWNrZWQgdGhlIEtWTSBiYWNrZW5kIGxvb2tlZCBwcm9taXNpbmcgYnV0IHN0aWxsIFdJUCwgdGhv
dWdoLg0KPg0KDQpHdmlzb3IgZG8gc3VwcG9ydCB0d28gcGxhdGZvcm1zLCBwdHJhY2UgYW5kIGt2
bS4gVG8gc3VwcG9ydCBwdHJhY2UgcGxhdGZvcm0gb24gQVJNNjQgaXMgb3VyIGZpcnN0IHN0ZXAu
DQpGcm9tIHRoZSBsb25nIHJ1biwgS1ZNIHdvdWxkIGJlIGEgYmV0dGVyIGNob2ljZSwgYW5kIHdl
IHdpbGwgd29yayBvbiBpdCBhZnRlciBwdHJhY2UgcGxhdGZvcm0gZ2V0IHdvcmtlZC4NCg0KPiBJ
IGFsc28gd29uZGVyIHdoZXRoZXIgUFRSQUNFX1NZU0VNVSBpcyByZWFsbHkgdGhlIG9ubHkgbWlz
c2luZyBiaXQgdG8gc3VwcG9ydCBndmlzb3Igb24gYXJtNjQuIERpZCB5b3UgY2hlY2sgaG93IHRv
IHdvcmsgYXJvdW5kIFZJUFQvVklWVCBjYWNoaW5nIGlzc3Vlcz8NCj4gVU1MIChhbmQgZ3Zpc29y
IGluIHRoaXMgY29udGV4dCkgaGF2ZSBsb3RzIG9mIGltcGxpY2l0IHg4NiBkZXBlbmRlbmNpZXMu
DQoNCkFzIGZhciBhcyB3ZSBrbm93LCAgUFRSQUNFX1NZU0VNVSBpcyB0aGUgb25seSBtaXNzaW5n
IGJpdCB0aGF0IG5lZWRlZCBpbiBMaW51eCBrZXJuZWwgdG8gc3VwcG9ydCBHdmlzb3Igb24gQVJN
NjQuDQpGb3IgdGhlIFZJUFQvVklWVCBjYWNoaW5nIGlzc3Vlcywgd2UgaGF2ZW4ndCBsb29rIGlu
dG8gaXQuICBDb3VsZCB5b3UgaGVscCBzaGFyZSBtb3JlIGluZm8gYWJvdXQgdGhlIGlzc3VlPw0K
DQpUaGFua3MsDQoNCkhhaWJvDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujog
UmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4NCuWPkemAgeaXtumXtDogMjAxOOW5
tDnmnIg15pelIDM6NDUNCuaUtuS7tuS6ujogSGFpYm8gWHUgKEFybSBUZWNobm9sb2d5IENoaW5h
KSA8SGFpYm8uWHVAYXJtLmNvbT4NCuaKhOmAgTogV2lsbCBEZWFjb24gPFdpbGwuRGVhY29uQGFy
bS5jb20+OyBDYXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBuZCA8bmRAYXJtLmNvbT47IGpkaWtlQGFkZHRvaXQuY29tDQrkuLvpopg6IFJlOiDnrZTl
pI06IFtQQVRDSF0gYXJtNjQvcHRyYWNlOiBhZGQgUFRSQUNFX1NZU0VNVSBhbmQgUFRSQUNFX1NZ
U0VNVV9TSU5HTEVTVEVQIHN1cHBvcnQNCg0KQW0gRGllbnN0YWcsIDQuIFNlcHRlbWJlciAyMDE4
LCAwNDoxMTowNyBDRVNUIHNjaHJpZWIgSGFpYm8gWHUgKEFybSBUZWNobm9sb2d5IENoaW5hKToN
Cj4gSGkgUmljaGFyZCwNCj4NCj4gV2hhdCBkbyB5b3UgbWVhbiBieSBkb25lIGl0IGluIHRoZSBj
b3JlPyBtb3ZpbmcgbWFjcm8gZGVmaW5pdGlvbiB0byBpbmNsdWRlL3VhcGkvbGludXgvcHRyYWNl
Lmg/DQo+IFRoZSBwYXRjaCBpcyBzdHJpY3RseSBmb2xsb3cgeDg2J3Mgc2VtYXRpYyBvbiBQVFJB
Q0VfU1lTRU1VL1NJTkdMRVNURVAgc3VwcG9ydC4NCg0KV2VsbCwgdGhlIGZlYXR1cmUgaXRzZWxm
IGlzIG5vdCByZWFsbHkgYXJjaGl0ZWN0dXJlIHNwZWNpZmljLg0KSnVzdCBiZWNhdXNlIHg4NiBk
b2VzIGl0IGluIGFyY2gveDg2LCBpdCBkb2VzIG5vdCBtZWFuIHRoYXQgdGhpcyBpcyB0aGUgYmVz
dCB3YXkuDQpJIGd1ZXNzIHRoaXMgaXMgYWxzbyB3aGF0IFdpbGwgdHJpZWQgdG8gc2F5Lg0KSWYg
d2UgY2FuLCB3ZSBzaG91bGQgaW1wbGVtZW50IFBUUkFDRV9TWVNFTVUgaW4gdGhlIGNvcmUgcHRy
YWNlIGNvZGUgYW5kIG5vdCBwZXIgYXJjaGl0ZWN0dXJlLg0KDQo+ID4gPiBJIHdvbmRlciB3aGF0
IEhhaWJvIFh1IHdhbnQgdG8gZG8gd2l0aCBQVFJBQ0VfU1lTRU1VIG9uIGFybTY0Lg0KPiA+ID4g
QXJlIHlvdSBwb3J0aW5nIFVNTCBvciBndmlzb3IgdG8gYXJtNjQ/DQo+ID4NCj4gPiBUaGF0J3Mg
YSBnb29kIHF1ZXN0aW9uLiBIYWlibz8NCj4NCj4gVGhlIHN0b3J5IGlzIHdlIGFyZSB3b3JraW5n
IG9uIGEgY29udGFpbmVyIHJ1bnRpbWUoR29vZ2xlIEd2aXNvcikNCj4gc3VwcG9ydCBvbiBBUk02
NCBwbGF0Zm9ybSwgYW5kIHRoZSBHdmlzb3IgZGVwZW5kIG9uIExpbnV4IGtlcm5lbCBQVFJBQ0Vf
U1lTRU1VL1NJTkdMRVNURVAgc3VwcG9ydC4NCg0KR3Zpc29yIGFsc28gc3VwcG9ydHMgYSBrdm0g
YmFja2VuZCB3aGljaCBzaG91bGQgYmUgKm11Y2gqIGZhc3RlciB0aGFuIFBUUkFDRV9TWVNFTVUu
DQpPdGhlcndpc2UgZ3Zpc29yIHN1ZmZlcnMgZnJvbSB0aGUgc2FtZSBwZXJmb3JtYW5jZSBkcmF3
YmFja3MgYXMgVU1MIGRvZXMuDQpQYWdlZmF1bHRzIHZpYSBTSUdTRUdWL21tYXAsIHN5c2NhbGwg
Z2F0ZSB2aWEgcHRyYWNlKCkuDQoNCkRpZCB5b3UgY2hlY2ssIGlzIFBUUkFDRV9TWVNFTVUgcmVh
bGx5IHRoZSB3YXkgdG8gZ28gZm9yIGd2aXNvcj8NCkxhc3QgdGltZSBJIGNoZWNrZWQgdGhlIEtW
TSBiYWNrZW5kIGxvb2tlZCBwcm9taXNpbmcgYnV0IHN0aWxsIFdJUCwgdGhvdWdoLg0KDQpJIGFs
c28gd29uZGVyIHdoZXRoZXIgUFRSQUNFX1NZU0VNVSBpcyByZWFsbHkgdGhlIG9ubHkgbWlzc2lu
ZyBiaXQgdG8gc3VwcG9ydCBndmlzb3Igb24gYXJtNjQuIERpZCB5b3UgY2hlY2sgaG93IHRvIHdv
cmsgYXJvdW5kIFZJUFQvVklWVCBjYWNoaW5nIGlzc3Vlcz8NClVNTCAoYW5kIGd2aXNvciBpbiB0
aGlzIGNvbnRleHQpIGhhdmUgbG90cyBvZiBpbXBsaWNpdCB4ODYgZGVwZW5kZW5jaWVzLg0KDQpU
aGFua3MsDQovL3JpY2hhcmQNCg0KDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2Yg
dGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBh
bHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQs
IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3Nl
IHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3Nl
LCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5
b3UuDQo=
