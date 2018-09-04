Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE30620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lm+azyZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE30620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeIDGeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:34:03 -0400
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:31702
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbeIDGeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIM6NIYgEwaXLeWGNV+OkBX52y70lt+949lHgVdGiHo=;
 b=lm+azyZV23jbUoX39iUrSoAJ56RcjjJrO8I60h7REZuxAV50cYFAXg9bx0rR74+ZMC4LtVL0x4uL/8e45ugoXuMXx5oUxopZ+65aeHpTqmKhmymABqxhqaKw7KYAx2pS148IUuuBFQYtoWUXe+O6Ipv5KrFhRnav51EEyJfkdm0=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.191.158) by
 AM4PR08MB1236.eurprd08.prod.outlook.com (10.167.92.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Tue, 4 Sep 2018 02:11:08 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::1594:9b9e:28b0:1a63]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::1594:9b9e:28b0:1a63%2]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 02:11:08 +0000
From:   "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To:     Will Deacon <Will.Deacon@arm.com>,
        Richard Weinberger <richard@nod.at>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, "jdike@addtoit.com" <jdike@addtoit.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0L3B0cmFjZTogYWRkIFBUUkFDRV9TWVNF?=
 =?utf-8?B?TVUgYW5kIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCBzdXBwb3J0?=
Thread-Topic: [PATCH] arm64/ptrace: add PTRACE_SYSEMU and
 PTRACE_SYSEMU_SINGLESTEP support
Thread-Index: AQHUQ06Z76IemXQPGUiVctTXT3fxI6TewGWAgAACvYCAAASiAIAAldKQ
Date:   Tue, 4 Sep 2018 02:11:07 +0000
Message-ID: <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903163103.GC6954@arm.com> <102400624.EOB2phcGqB@blindfold>
 <20180903165726.GJ6954@arm.com>
In-Reply-To: <20180903165726.GJ6954@arm.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR08MB1236;6:WfdpNBJHhvSuhFa2POaWbZMw1dhxdCU6BiUHRlHFyWovRFH8BCJ4KC/dMU0pw5YOw3d8353WgwYq9IiGkLVs9P1ZpEs1soRhD38G7FzyHwImcut0OZrYgyW3ybAoDY2N88mXKLa6NVgRRGtN1Ta7oAd0L4bdVhJpMfpKag0tQ5hfeO7R4drkRTWMAeqbhXjua+Sa58AJOnbmc+2sVSHkdgZUK0HqELyJrysT2cE+Tw9odx68LpntqUgh5mp8oo49jQOcUmVwXhi+/ocw1LQ7Qj5AwaywBaFtFMpprFDgrYkyu695JA61GiCH+EueNRQdFU+R8wCEpOYEZNX2HP4oVr+Nskc0Zm34JXAattIKqudFPpU3b3JcfUOltGQO3ZPFkPQOxqxts4o6NvPCtJDxEv6ki7SIBDHbijfupR+iiKIolW/dCfYTrr8lYfIcDLJD+2c0MyrhInIm9L9iCZMS2Q==;5:oS6YHCQTdR1Jb/Ps0M+SWlhXm5LREjb8EZBjyCS7csioN0jyP5xrP++Xx2UezwV4C3zKd2dmFJJ3g4SPZLHE2Dp0+deUiaf4UZYbChxxKtiw04Y6UwRYuFa7zzZkjyPqZFi85736+pHZQZEE1SHh7LvQU8+j5XVTj+0wotNdWqA=;7:KHv77YZj/2e2aZIwtLqmCYI0TCSa0EfxL8O0TOovPX9b65tcGaXP2Ird6aWGcL65yqZZfzVZmKJRC5qJJ4VaB40gaiMoRglNatbBd0Q0TkC5ahk9SQ7FXoPMfKqrQ1kINtVsmAJNIRnS5HLgEeVk9XmGi3XnCIAPnvPcQyEoALZOtp4fKYea7di9TtJ1O7fnA/CGsQW4w8W6LU3FM1zTw6QPP0X7aZ09J61D6G0JqNaLhHRFYB6NF6F12j1MfseR
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 13e924ec-0c8d-4698-7b44-08d6120bad66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB1236;
x-ms-traffictypediagnostic: AM4PR08MB1236:
x-microsoft-antispam-prvs: <AM4PR08MB12369A5BDE12542C74CABE1F85030@AM4PR08MB1236.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(155532106045638);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:AM4PR08MB1236;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB1236;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(136003)(346002)(40434004)(51914003)(189003)(199004)(14454004)(68736007)(99286004)(2906002)(8936002)(6436002)(476003)(3846002)(93886005)(53936002)(6116002)(486006)(7696005)(33656002)(11346002)(446003)(9686003)(4326008)(5250100002)(76176011)(74316002)(55016002)(316002)(6506007)(106356001)(224303003)(105586002)(7736002)(66066001)(26005)(102836004)(25786009)(72206003)(305945005)(86362001)(81156014)(2900100001)(478600001)(54906003)(256004)(81166006)(5024004)(5660300001)(14444005)(97736004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB1236;H:AM4PR08MB2929.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F1b8SSKf8AgFB/z1zPcmsbeHYuovK5eA6Q4pb70oGKPShWlvHO1KPdmCYEKL5VxK8Lh9hpwK1zYBMST/jssNK1NH/2tKQ3egHuBJlK/9uvT/jk4uv2sMjg+2SW9kVyoDPfqgWvBZJc710XFcAc3ksqqs3V/C+SAM7f3p9aAVoLC/jQ43WqBv+vhx51EzzYALY1rWvZ5wrfWc20MvFvKGw8jt8lL9nnpc2Mhkhzi7vxpZJ9tnJjVrDXyrsTWedpgWrSfeByG029HxrTRkfOiwckNHe+JL5Gs8/B+7qN5KSwcaDuwR0fYq1EeYDnEvSFWSQf6Kye92xKyR4N/ZoCoDg5ERZ+tc2tSnI7JjEO6ryDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e924ec-0c8d-4698-7b44-08d6120bad66
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 02:11:08.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB1236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCwNCg0KPiBPbiBNb24sIFNlcCAwMywgMjAxOCBhdCAwNjo0MDo1MVBNICswMjAwLCBS
aWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6DQo+ID4gQW0gTW9udGFnLCAzLiBTZXB0ZW1iZXIgMjAx
OCwgMTg6MzE6MDMgQ0VTVCBzY2hyaWViIFdpbGwgRGVhY29uOg0KPiA+ID4gT24gTW9uLCBTZXAg
MDMsIDIwMTggYXQgMDI6MjM6MTdQTSArMDgwMCwgSGFpYm8uWHUgd3JvdGU6DQo+ID4gPiA+IEFk
ZCBQVFJBQ0VfU1lTRU1VIGFuZCBQVFJBQ0VfU1lTRU1VX1NJTkdMRVNURVAgc3VwcG9ydCBvbiBB
Uk02NC4NCj4gPiA+ID4gVGhpcyBjb3BpZXMgdGhlIHg4NiBzZW1hbnRpY3MgZm9yIGludm9raW5n
IHB0cmFjZSBob29rcywgYW5kIGhhdmUNCj4gPiA+ID4gYmVlbiB2ZXJpZmllZCBvbiBBUk02NCBt
YWNoaW5lLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWliby5YdSA8aGFpYm8u
eHVAYXJtLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmluLkx1IDxiaW4ubHVAYXJtLmNv
bT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3RocmVhZF9p
bmZvLmggfCAgNSArKysrLQ0KPiA+ID4gPiBhcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20vcHRy
YWNlLmggfCAgMiArKw0KPiA+ID4gPiAgYXJjaC9hcm02NC9rZXJuZWwvcHRyYWNlLmMgICAgICAg
ICAgIHwgMTcgKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IFdoYXQgaXMgUFRSQUNF
X1NZU0VNVSBhbmQgd2hhdCBpcyBpdHMgc2VtYW50aWNzPyBXaHkgaXNuJ3QgaXQgZG9uZQ0KPiA+
ID4gaW4gdGhlIGNvcmUgcHRyYWNlIGNvZGU/DQo+ID4NCj4gPiBJdCBpcyBhbiBvcHRpbWl6YXRp
b24gYWRkZWQgZm9yIFVzZXJNb2RlTGludXggbWFueSB5ZWFycyBhZ28uDQo+ID4gUFRSQUNFX1NZ
U0VNVSBiYXNpY2FsbHkgYWxsb3dzIHlvdSB0byBoYW5kbGUgc3lzdGVtIGNhbGxzIGluIHVzZXIN
Cj4gPiBzcGFjZSB3aXRob3V0IHRoZSBrZXJuZWwgc2VlaW5nIHRoZW0uDQo+ID4gQmVmb3JlIHRo
YXQgVU1MIGhhZCB0byByZW5kZXIgZXZlcnkgc3lzdGVtIGNhbGwgaW50byBhIG5vLW9wLCBlLmgu
IGdldHBpZCgpLg0KPiA+IFRoaXMgd2FzIGNvbXBsaWNhdGVkIGFuZCBzbG93Lg0KPg0KPiBPaywg
dGhhbmtzIGZvciB0aGUgaW5zaWdodCENCj4NCg0KVGhhbmtzIGZvciBSaWNoYXJkJ3MgY29tbWVu
dHMhDQoNCj4gPiBUaGUgcHRyYWNlKCkgbWFucGFnZSBoYXMgYSBzZWN0aW9uIG9uIFBUUkFDRV9T
WVNFTVUsIG1vcmUNCj4gPiBkb2N1bWVudGF0aW9uIG9uIHRoZSBzZW1hbnRpY3MgaXMgbm90IGF2
YWlsYWJsZS4NCj4NCj4gOiggV2UgYWxyZWFkeSBoYXZlIHRyYWNlaG9vaywgc2VjY29tcCwgdHJh
Y2Vwb2ludCBhbmQgYXVkaXQgZmlnaHRpbmcgd2l0aCBlYWNoIG90aGVyIG9uIHN5c2NhbGwgZW50
cnksIHNvIEknbSByZWFsbHkgbm90IGtlZW4gdG8gYWRkIGFub3RoZXIgcGxheWVyIHRvIHRoZSBn
YW1lIHVubGVzcyB3ZSByZWFsbHkgaGF2ZSB0by4NCj4NCj4gSGFzIGFueWJvZHkgdHJpZWQgaW1w
bGVtZW50aW5nIHRoaXMgdXNpbmcgdHJhY2Vob29rPw0KPg0KDQpDdXJyZW50bHksIGl0IHNlZW1z
IG5vYm9keSBoYXMgdHJpZWQgaXQuDQoNCj4gPiBBbmQgeWVzLCBJIHRoaW5rIHRoaXMgc2hvdWxk
IGFsc28gZG9uZSBpbiB0aGUgY29yZS4gTGlrZSBtYW55IG90aGVyDQo+ID4gcHRyYWNlKCkgYXJl
YXMgdGhpcyBuZWVkcyBhIGNsZWFudXAuIDstKQ0KPiA+DQoNCkhpIFJpY2hhcmQsDQoNCldoYXQg
ZG8geW91IG1lYW4gYnkgZG9uZSBpdCBpbiB0aGUgY29yZT8gbW92aW5nIG1hY3JvIGRlZmluaXRp
b24gdG8gaW5jbHVkZS91YXBpL2xpbnV4L3B0cmFjZS5oPw0KVGhlIHBhdGNoIGlzIHN0cmljdGx5
IGZvbGxvdyB4ODYncyBzZW1hdGljIG9uIFBUUkFDRV9TWVNFTVUvU0lOR0xFU1RFUCBzdXBwb3J0
Lg0KDQo+ID4gSSB3b25kZXIgd2hhdCBIYWlibyBYdSB3YW50IHRvIGRvIHdpdGggUFRSQUNFX1NZ
U0VNVSBvbiBhcm02NC4NCj4gPiBBcmUgeW91IHBvcnRpbmcgVU1MIG9yIGd2aXNvciB0byBhcm02
ND8NCj4NCj4gVGhhdCdzIGEgZ29vZCBxdWVzdGlvbi4gSGFpYm8/DQoNClRoZSBzdG9yeSBpcyB3
ZSBhcmUgd29ya2luZyBvbiBhIGNvbnRhaW5lciBydW50aW1lKEdvb2dsZSBHdmlzb3IpIHN1cHBv
cnQgb24gQVJNNjQgcGxhdGZvcm0sDQphbmQgdGhlIEd2aXNvciBkZXBlbmQgb24gTGludXgga2Vy
bmVsIFBUUkFDRV9TWVNFTVUvU0lOR0xFU1RFUCBzdXBwb3J0Lg0KDQpIYWlibw0KLS0tLS3pgq7k
u7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNv
bT4NCuWPkemAgeaXtumXtDogMjAxOOW5tDnmnIg05pelIDA6NTcNCuaUtuS7tuS6ujogUmljaGFy
ZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4NCuaKhOmAgTogSGFpYm8gWHUgKEFybSBUZWNo
bm9sb2d5IENoaW5hKSA8SGFpYm8uWHVAYXJtLmNvbT47IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxp
bi5NYXJpbmFzQGFybS5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5kIDxuZEBhcm0uY29tPjsgamRpa2VAYWRk
dG9pdC5jb20NCuS4u+mimDogUmU6IFtQQVRDSF0gYXJtNjQvcHRyYWNlOiBhZGQgUFRSQUNFX1NZ
U0VNVSBhbmQgUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIHN1cHBvcnQNCg0KSGkgUmljaGFyZCwN
Cg0KT24gTW9uLCBTZXAgMDMsIDIwMTggYXQgMDY6NDA6NTFQTSArMDIwMCwgUmljaGFyZCBXZWlu
YmVyZ2VyIHdyb3RlOg0KPiBBbSBNb250YWcsIDMuIFNlcHRlbWJlciAyMDE4LCAxODozMTowMyBD
RVNUIHNjaHJpZWIgV2lsbCBEZWFjb246DQo+ID4gT24gTW9uLCBTZXAgMDMsIDIwMTggYXQgMDI6
MjM6MTdQTSArMDgwMCwgSGFpYm8uWHUgd3JvdGU6DQo+ID4gPiBBZGQgUFRSQUNFX1NZU0VNVSBh
bmQgUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIHN1cHBvcnQgb24gQVJNNjQuDQo+ID4gPiBUaGlz
IGNvcGllcyB0aGUgeDg2IHNlbWFudGljcyBmb3IgaW52b2tpbmcgcHRyYWNlIGhvb2tzLCBhbmQg
aGF2ZQ0KPiA+ID4gYmVlbiB2ZXJpZmllZCBvbiBBUk02NCBtYWNoaW5lLg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEhhaWJvLlh1IDxoYWliby54dUBhcm0uY29tPg0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogQmluLkx1IDxiaW4ubHVAYXJtLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gv
YXJtNjQvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaCB8ICA1ICsrKystDQo+ID4gPiBhcmNoL2Fy
bTY0L2luY2x1ZGUvdWFwaS9hc20vcHRyYWNlLmggfCAgMiArKw0KPiA+ID4gIGFyY2gvYXJtNjQv
a2VybmVsL3B0cmFjZS5jICAgICAgICAgICB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ID4gPiAg
MyBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBXaGF0IGlzIFBUUkFDRV9TWVNFTVUgYW5kIHdoYXQgaXMgaXRzIHNlbWFudGljcz8gV2h5IGlz
bid0IGl0IGRvbmUNCj4gPiBpbiB0aGUgY29yZSBwdHJhY2UgY29kZT8NCj4NCj4gSXQgaXMgYW4g
b3B0aW1pemF0aW9uIGFkZGVkIGZvciBVc2VyTW9kZUxpbnV4IG1hbnkgeWVhcnMgYWdvLg0KPiBQ
VFJBQ0VfU1lTRU1VIGJhc2ljYWxseSBhbGxvd3MgeW91IHRvIGhhbmRsZSBzeXN0ZW0gY2FsbHMg
aW4gdXNlcg0KPiBzcGFjZSB3aXRob3V0IHRoZSBrZXJuZWwgc2VlaW5nIHRoZW0uDQo+IEJlZm9y
ZSB0aGF0IFVNTCBoYWQgdG8gcmVuZGVyIGV2ZXJ5IHN5c3RlbSBjYWxsIGludG8gYSBuby1vcCwg
ZS5oLiBnZXRwaWQoKS4NCj4gVGhpcyB3YXMgY29tcGxpY2F0ZWQgYW5kIHNsb3cuDQoNCk9rLCB0
aGFua3MgZm9yIHRoZSBpbnNpZ2h0IQ0KDQo+IFRoZSBwdHJhY2UoKSBtYW5wYWdlIGhhcyBhIHNl
Y3Rpb24gb24gUFRSQUNFX1NZU0VNVSwgbW9yZQ0KPiBkb2N1bWVudGF0aW9uIG9uIHRoZSBzZW1h
bnRpY3MgaXMgbm90IGF2YWlsYWJsZS4NCg0KOiggV2UgYWxyZWFkeSBoYXZlIHRyYWNlaG9vaywg
c2VjY29tcCwgdHJhY2Vwb2ludCBhbmQgYXVkaXQgZmlnaHRpbmcgd2l0aCBlYWNoIG90aGVyIG9u
IHN5c2NhbGwgZW50cnksIHNvIEknbSByZWFsbHkgbm90IGtlZW4gdG8gYWRkIGFub3RoZXIgcGxh
eWVyIHRvIHRoZSBnYW1lIHVubGVzcyB3ZSByZWFsbHkgaGF2ZSB0by4NCg0KSGFzIGFueWJvZHkg
dHJpZWQgaW1wbGVtZW50aW5nIHRoaXMgdXNpbmcgdHJhY2Vob29rPw0KDQo+IEFuZCB5ZXMsIEkg
dGhpbmsgdGhpcyBzaG91bGQgYWxzbyBkb25lIGluIHRoZSBjb3JlLiBMaWtlIG1hbnkgb3RoZXIN
Cj4gcHRyYWNlKCkgYXJlYXMgdGhpcyBuZWVkcyBhIGNsZWFudXAuIDstKQ0KPg0KPiBJIHdvbmRl
ciB3aGF0IEhhaWJvIFh1IHdhbnQgdG8gZG8gd2l0aCBQVFJBQ0VfU1lTRU1VIG9uIGFybTY0Lg0K
PiBBcmUgeW91IHBvcnRpbmcgVU1MIG9yIGd2aXNvciB0byBhcm02ND8NCg0KVGhhdCdzIGEgZ29v
ZCBxdWVzdGlvbi4gSGFpYm8/DQoNCldpbGwNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50
cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQg
bWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlz
Y2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1
cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRo
YW5rIHlvdS4NCg==
