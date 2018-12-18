Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83C3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EF0218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XHAtmvd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeLRTdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:33:13 -0500
Received: from mail-eopbgr710060.outbound.protection.outlook.com ([40.107.71.60]:12925
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbeLRTdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgQxnd4x2okF2okxsQh1Dx9xDhPu0Z5/2UdqOFO03wQ=;
 b=XHAtmvd+YFGfGOncAKBbmOhOFOhRPqfh1v0t0d2axs42qV5CRuIZ3f3ez1ZN/pU4krwiqdICmFlK0Y8H19rVN637dt3tTyCScl3a4H212FMmxtJHJHR67xJ51+r1Ajo5MBL5vChzNTZTZyYpD56MkYRYk8r33gLqUl5WojwdiHg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5064.namprd05.prod.outlook.com (20.177.230.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.15; Tue, 18 Dec 2018 19:33:08 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 19:33:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Thread-Topic: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Thread-Index: AQHUksVBZzHOPXiLTkuUqtDHy4jwBqWCrNsAgAI+mgA=
Date:   Tue, 18 Dec 2018 19:33:07 +0000
Message-ID: <A6321F73-0084-423B-8BEE-C23BF6BD1544@vmware.com>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+icZUUnkGBp-3pJxE_s_Oc+pdNBrVc_ngYUwpv7zLEbtE_eVg@mail.gmail.com>
In-Reply-To: <CA+icZUUnkGBp-3pJxE_s_Oc+pdNBrVc_ngYUwpv7zLEbtE_eVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5064;20:obmPZL1SPc6sBp5edV1GnWH95oa+Vvq9UuwUuBRP2HVRvDE7tfaaeyBpqU1Rj02BVyEvUX/fJ9lBwPw90MpTX2K4c3jk3dHR0RYdOldyGSImkSqH+eQbQ8rpbqjkDXVKYVMBG7xuoX1f9yYU0sXxE+arw4FWRgTs3s5/epfNnoc=
x-ms-office365-filtering-correlation-id: fb67348f-dcf8-4bfb-74c8-08d6651fa394
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5064;
x-ms-traffictypediagnostic: BYAPR05MB5064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB5064B14CA6343731C5045037D0BD0@BYAPR05MB5064.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5064;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5064;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(51914003)(7416002)(14444005)(3846002)(71190400001)(71200400001)(256004)(6506007)(106356001)(53936002)(102836004)(53546011)(83716004)(105586002)(446003)(6246003)(11346002)(6512007)(33656002)(6306002)(486006)(476003)(2616005)(186003)(39060400002)(76176011)(36756003)(6116002)(26005)(4326008)(7736002)(97736004)(99286004)(66066001)(305945005)(478600001)(45080400002)(316002)(54906003)(966005)(82746002)(6916009)(25786009)(6486002)(229853002)(5660300001)(68736007)(6436002)(8936002)(8676002)(81166006)(575784001)(86362001)(81156014)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5064;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 248K8SkUsozHsvXscHbVe+PUQ0lSk/nhnOL7/mTLHgV8JrXNJ3efbjyfaw2XI2Yzu3q5VCfBu38R0H9fzKJ1/OiXLiDU0r7FCLUquJptdFo6gQR/JrkYk/QoxhEF7bTq9WS9aFtsyMR1TWsgR7yujp3g2ECUBfgju5gIQ7NM7p3LM9E1yRO86WWRSJMaogQMo8/JSVp7Wnf+bMletdh2ppDD8RFEjATWqRoHjhD4lIpe2iKY4A4Tdi1R3x56+/p4AT22HE4dxHAxyBevpYoO1VyXqLN8OewE8i+DNuZpdKE6VUx15R3MLzFyhhw8B530
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A9EC197CE14A34A9CB0F37FE152FCC3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb67348f-dcf8-4bfb-74c8-08d6651fa394
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 19:33:07.8788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTcsIDIwMTgsIGF0IDE6MTYgQU0sIFNlZGF0IERpbGVrIDxzZWRhdC5kaWxla0Bn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMTA6MTkgQU0g
TWFzYWhpcm8gWWFtYWRhDQo+IDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4gd3JvdGU6
DQo+PiBSZXZlcnQgdGhlIGZvbGxvd2luZyBjb21taXRzOg0KPj4gDQo+PiAtIDViZGNkNTEwYzJh
YzllZmFmNTVjNGNiZDhkNDY0MjFkOGUyMzIwY2QNCj4+ICAoIng4Ni9qdW1wLWxhYmVsczogTWFj
cm9meSBpbmxpbmUgYXNzZW1ibHkgY29kZSB0byB3b3JrIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVn
cyIpDQo+PiANCj4+IC0gZDVhNTgxZDg0YWU2YjhhNGE3NDA0NjRiODBkOGQ5Y2YxZTc5NDdiMg0K
Pj4gICgieDg2L2NwdWZlYXR1cmU6IE1hY3JvZnkgaW5saW5lIGFzc2VtYmx5IGNvZGUgdG8gd29y
ayBhcm91bmQgR0NDIGlubGluaW5nIGJ1Z3MiKQ0KPj4gDQo+PiAtIDA0NzRkNWQ5ZDJmN2YzYjEx
MjYyZjdiZjg3ZDBlNzMxNGVhZDkyMDAuDQo+PiAgKCJ4ODYvZXh0YWJsZTogTWFjcm9meSBpbmxp
bmUgYXNzZW1ibHkgY29kZSB0byB3b3JrIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVncyIpDQo+PiAN
Cj4+IC0gNDk0YjUxNjhmMmRlMDA5ZWI4MGYxOThmNjY4ZGEzNzQyOTUwOThkZC4NCj4+ICAoIng4
Ni9wYXJhdmlydDogV29yayBhcm91bmQgR0NDIGlubGluaW5nIGJ1Z3Mgd2hlbiBjb21waWxpbmcg
cGFyYXZpcnQgb3BzIikNCj4+IA0KPj4gLSBmODFmOGFkNTZmZDFjN2I5OWIyZWQxYzMxNDUyN2Y3
ZDlhYzQ0N2M2Lg0KPj4gICgieDg2L2J1ZzogTWFjcm9meSB0aGUgQlVHIHRhYmxlIHNlY3Rpb24g
aGFuZGxpbmcsIHRvIHdvcmsgYXJvdW5kIEdDQyBpbmxpbmluZyBidWdzIikNCj4+IA0KPj4gLSA3
N2Y0OGVjMjhlNGNjZmY5NGQyZTVmNDI2MGE4M2FjMjdhN2YzMDk5Lg0KPj4gICgieDg2L2FsdGVy
bmF0aXZlczogTWFjcm9meSBsb2NrIHByZWZpeGVzIHRvIHdvcmsgYXJvdW5kIEdDQyBpbmxpbmlu
ZyBidWdzIikNCj4+IA0KPj4gLSA5ZTE3MjViNDEwNTk0OTExY2M1OTgxYjZjN2I0Y2VhNGVjMDU0
Y2E4Lg0KPj4gICgieDg2L3JlZmNvdW50OiBXb3JrIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVnIikN
Cj4+ICAoQ29uZmxpY3RzOiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZWZjb3VudC5oKQ0KPj4gDQo+
PiAtIGMwNmM0ZDgwOTA1MTNmMjk3NGRmZGJlZDJhYzk4NjM0MzU3YWM0NzUuDQo+PiAgKCJ4ODYv
b2JqdG9vbDogVXNlIGFzbSBtYWNyb3MgdG8gd29yayBhcm91bmQgR0NDIGlubGluaW5nIGJ1Z3Mi
KQ0KPj4gDQo+PiAtIDc3YjBiZjU1YmM2NzUyMzNkMjJjZDVkZjk3NjA1ZDUxNmQ2NDUyNWUuDQo+
PiAgKCJrYnVpbGQvTWFrZWZpbGU6IFByZXBhcmUgZm9yIHVzaW5nIG1hY3JvcyBpbiBpbmxpbmUg
YXNzZW1ibHkgY29kZSB0byB3b3JrIGFyb3VuZCBhc20oKSByZWxhdGVkIEdDQyBpbmxpbmluZyBi
dWdzIikNCj4+IA0KPj4gQSBmZXcgZGF5cyBhZnRlciB0aG9zZSBjb21taXRzIGFwcGxpZWQsIGRp
c2N1c3Npb24gc3RhcnRlZCB0byBzb2x2ZQ0KPj4gdGhlIGlzc3VlIG1vcmUgZWxlZ2FudGx5IG9u
IHRoZSBjb21waWxlciBzaWRlOg0KPj4gDQo+PiAgaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLm9yZyUyRmxrbWwlMkYy
MDE4JTJGMTAlMkY3JTJGOTImYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3
QzQwYjVkZjhhMzhlNTRmMzEwYWI3MDhkNjY0MDA1ZWUwJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZj
ZDgzZDlkZDYyZjAlN0MwJTdDMSU3QzYzNjgwNjM1MDExMzEzNjIyMyZhbXA7c2RhdGE9UmxZWFN5
aHpNNkhMUXVLQzJOdXlEcXZrZTlxWjExdHZNRE5kMzJOaUYyVSUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
Pj4gDQo+PiBUaGUgImFzbSBpbmxpbmUiIHdhcyBpbXBsZW1lbnRlZCBieSBTZWdoZXIgQm9lc3Nl
bmtvb2wsIGFuZCBub3cgcXVldWVkDQo+PiB1cCBmb3IgR0NDIDkuIChQZW9wbGUgd2VyZSBwb3Np
dGl2ZSBldmVuIGZvciBiYWNrLXBvcnRpbmcgaXQgdG8gb2xkZXINCj4+IGNvbXBpbGVycykuDQo+
PiANCj4+IFNpbmNlIHRoZSBpbi1rZXJuZWwgd29ya2Fyb3VuZHMgbWVyZ2VkLCBzb21lIGlzc3Vl
cyBoYXZlIGJlZW4gcmVwb3J0ZWQ6DQo+PiBicmVha2FnZSBvZiBidWlsZGluZyB3aXRoIGRpc3Rj
Yy9pY2VjYywgYnJlYWthZ2Ugb2YgZGlzdHJvIHBhY2thZ2VzIGZvcg0KPj4gbW9kdWxlIGJ1aWxk
aW5nLiAoTW9yZSBmdW5kYW1lbnRhbGx5LCB3ZSBjYW5ub3QgYnVpbGQgZXh0ZXJuYWwgbW9kdWxl
cw0KPj4gYWZ0ZXIgJ21ha2UgY2xlYW4nKQ0KPj4gDQo+PiBQYXRjaGluZyBhcm91bmQgdGhlIGJ1
aWxkIHN5c3RlbSB3b3VsZCBtYWtlIHRoZSBjb2RlIGV2ZW4gdWdsaWVyLg0KPj4gDQo+PiBHaXZl
biB0aGF0IHRoaXMgaXNzdWUgd2lsbCBiZSBzb2x2ZWQgaW4gYSBjbGVhbmVyIHdheSBzb29uZXIg
b3IgbGF0ZXIsDQo+PiBsZXQncyByZXZlcnQgdGhlIGluLWtlcm5lbCB3b3JrYXJvdW5kcywgYW5k
IHdhaXQgZm9yIEdDQyA5Lg0KPj4gDQo+PiBSZXBvcnRlZC1ieTogTG9nYW4gR3VudGhvcnBlIDxs
b2dhbmdAZGVsdGF0ZWUuY29tPiAjIGRpc3RjYw0KPj4gUmVwb3J0ZWQtYnk6IFNlZGF0IERpbGVr
IDxzZWRhdC5kaWxla0BnbWFpbC5jb20+ICMgZGViaWFuL3JwbSBwYWNrYWdlDQo+IA0KPiBIaSwN
Cj4gDQo+IEkgcmVwb3J0ZWQgdGhlIGlzc3VlIHdpdGggZGViaWFuIHBhY2thZ2UgYnJlYWthZ2Ug
aW4gWzFdLg0KPiANCj4gSSBhbSBub3Qgc3Vic2NyaWJlZCB0byBhbnkgaW52b2x2ZWQgbWFpbGlu
Zy1saXN0IGFuZCBub3QgZm9sbG93aW5nIGFsbA0KPiB0aGUgZGlzY3Vzc2lvbnMuDQo+IEkgc2Vl
IHRoZSBzaXR1YXRpb24gaXMgbm90IGVhc3kgYXMgdGhlcmUgaXMgZXNwZWNpYWxseSBsaW51eC1r
YnVpbGQNCj4gYW5kIGxpbnV4L3g4NiBpbnZvbHZlZCBhbmQgbWF5YmUgb3RoZXIgaW50ZXJlc3Rz
Lg0KPiBCdXQgSSBhbSBpbnRlcmVzdGVkIGluIGhhdmluZyBhIGZpeCBpbiB2NC4yMCBmaW5hbCBh
bmQgaG9wZSB0aGlzIGFsbA0KPiBzdGlsbCB3b3JrcyB3aXRoIExMVk0vQ2xhbmcuDQo+IA0KPiBJ
IGNhbiBvZmZlciBteSBoZWxwIGluIHRlc3RpbmcgLSBhZ2FpbnN0IExpbnV4IHY0LjIwLXJjNy4N
Cj4gTm90IHN1cmUgaWYgYWxsIGRpc2N1c3NlZCBtYXRlcmlhbCBpcyBpbiB1cHN0cmVhbSBvciBl
bHNld2hlcmUuDQo+IFdoYXQgaXMgeW91ciBzdWdnZXN0aW9uIGZvciBtZSBhcyBhIHRlc3Rlcj8N
Cj4gDQo+IFdpbGwgd2UgaGF2ZSBhIHNvbHV0aW9uIGluIExpbnV4IHY0LjIwIGZpbmFsPw0KDQpU
aGFua3MgZm9yIHRoZSByZWZlcmVuY2UuIEkgc2VlIHNvbHV0aW9ucyBoYXZlIGFscmVhZHkgYmVl
biBkZXZlbG9wZWQuIFNvDQppdOKAmXMgTWFzYWhpcm/igJlzIGNhbGwuDQoNCg==
