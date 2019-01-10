Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D7DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E28208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="aFtTj0xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfAJRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:32:17 -0500
Received: from mail-eopbgr730042.outbound.protection.outlook.com ([40.107.73.42]:38063
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729799AbfAJRcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwuV8jTqIoUNo3Y+KyL7lF/wGdph5WhGl+9mTnXli/o=;
 b=aFtTj0xv5qgPtYYF6jx66japREEuX+p5IOCNoMTPUzKUgpK6QIKc8HxMXSLaLLyUsRhsYbay9uJG2s9/y1/vv68I1PJEuF1E33BFwBBEz54qwykrJZ6M3bS0JFeKfKnwp8yX2g/vizcgam+JMOQnTPqJ6nO7f9M0+p0UtaKz9Sk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5559.namprd05.prod.outlook.com (20.177.186.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.4; Thu, 10 Jan 2019 17:32:08 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 17:32:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWntJ6AgAEB5ICAAA1xgA==
Date:   Thu, 10 Jan 2019 17:32:08 +0000
Message-ID: <D8481FBB-4873-43B2-9187-C0896E859191@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <A42784EF-3215-4ED9-8D35-1A2C38A0711F@vmware.com>
 <20190110164401.g747vifrppbhbo3o@treble>
In-Reply-To: <20190110164401.g747vifrppbhbo3o@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5559;20:9U+CcVb/XcR2yEpY3D7VXq090AYDU42Lo+OilgksJ5AyGdgK+O82LoYhziqdwLzRNP3HKYRxvKr2X0whRzfARa+MmDIO5c38RSh4DJYJSJAWU8yd6pB3kMEwL0oik6egBLa4yUAY93hFdnVxIcFfKofChuiOHWGBhF02RlqMFDM=
x-ms-office365-filtering-correlation-id: 5db0fc6c-f18e-4720-ee2e-08d677218bfe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5559;
x-ms-traffictypediagnostic: BYAPR05MB5559:
x-microsoft-antispam-prvs: <BYAPR05MB555958C710A45AC991C698D3D0840@BYAPR05MB5559.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(82746002)(14444005)(106356001)(105586002)(229853002)(54906003)(14454004)(256004)(99286004)(316002)(53546011)(33656002)(478600001)(2616005)(446003)(476003)(11346002)(76176011)(6506007)(561944003)(68736007)(102836004)(81166006)(8936002)(36756003)(81156014)(186003)(7736002)(567974002)(83716004)(6346003)(486006)(6916009)(86362001)(305945005)(8676002)(26005)(97736004)(7416002)(66066001)(6486002)(5660300001)(6436002)(71190400001)(6116002)(53936002)(25786009)(6512007)(3846002)(6246003)(2906002)(4326008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5559;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rtFmG15CiLgnX9TSNljCpHN5tDDdnSEDR8Zgx77fBjb0xoS0ZUtF/GsWUhIofLsUI5OfEsm1Ly+xvmlLkfnjt79nzrVISEHUrN2V20j0FEg4nRReMLzqTvq3Tt6Vcr2G6KYbXTqJA/sKjLRGZMBPQwcIV4SkcvxcBWdHoZNmjul0xiZh+eLaZZhjmqhsdQdiBP3d1UGM9CVnMCg81f2yAEqSmF1nmiVGK+SbuR4v0nHzVWZ2+twwmnQmZJ6Cv+LDO01CAez/N6rIujZlE3f69AJSmziBIovG0TrczwP3hds27GVZAvBwEvEwiwClz5Tr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <725599D00E36FC4595B8EB557B56B685@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db0fc6c-f18e-4720-ee2e-08d677218bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 17:32:08.3370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTAsIDIwMTksIGF0IDg6NDQgQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSmFuIDEwLCAyMDE5IGF0IDAxOjIxOjAw
QU0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gT24gSmFuIDksIDIwMTksIGF0IDI6NTkg
UE0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+
PiBXaXRoIHRoaXMgdmVyc2lvbiwgSSBzdG9wcGVkIHRyeWluZyB0byB1c2UgdGV4dF9wb2tlX2Jw
KCksIGFuZCBpbnN0ZWFkDQo+Pj4gd2VudCB3aXRoIGEgZGlmZmVyZW50IGFwcHJvYWNoOiBpZiB0
aGUgY2FsbCBzaXRlIGRlc3RpbmF0aW9uIGRvZXNuJ3QNCj4+PiBjcm9zcyBhIGNhY2hlbGluZSBi
b3VuZGFyeSwganVzdCBkbyBhbiBhdG9taWMgd3JpdGUuICBPdGhlcndpc2UsIGtlZXANCj4+PiB1
c2luZyB0aGUgdHJhbXBvbGluZSBpbmRlZmluaXRlbHkuDQo+Pj4gDQo+Pj4gTk9URTogQXQgbGVh
c3QgZXhwZXJpbWVudGFsbHksIHRoZSBjYWxsIGRlc3RpbmF0aW9uIHdyaXRlcyBzZWVtIHRvIGJl
DQo+Pj4gYXRvbWljIHdpdGggcmVzcGVjdCB0byBpbnN0cnVjdGlvbiBmZXRjaGluZy4gIE9uIE5l
aGFsZW0gSSBjYW4gZWFzaWx5DQo+Pj4gdHJpZ2dlciBjcmFzaGVzIHdoZW4gd3JpdGluZyBhIGNh
bGwgZGVzdGluYXRpb24gYWNyb3NzIGNhY2hlbGluZXMgd2hpbGUNCj4+PiByZWFkaW5nIHRoZSBp
bnN0cnVjdGlvbiBvbiBvdGhlciBDUFU7IGJ1dCBJIGdldCBubyBzdWNoIGNyYXNoZXMgd2hlbg0K
Pj4+IHJlc3BlY3RpbmcgY2FjaGVsaW5lIGJvdW5kYXJpZXMuDQo+Pj4gDQo+Pj4gQlVULCB0aGUg
U0RNIGRvZXNuJ3QgZG9jdW1lbnQgdGhpcyBhcHByb2FjaCwgc28gaXQgd291bGQgYmUgZ3JlYXQg
aWYgYW55DQo+Pj4gQ1BVIHBlb3BsZSBjYW4gY29uZmlybSB0aGF0IGl0J3Mgc2FmZSENCj4+IA0K
Pj4gSSAoc3RpbGwpIHRoaW5rIHRoYXQgaGF2aW5nIGEgY29tcGlsZXIgcGx1Z2luIGNhbiBtYWtl
IHRoaW5ncyBtdWNoIGNsZWFuZXINCj4+IChhcyBkb25lIGluIFsxXSkuIFRoZSBjYWxsZXJzIHdv
dWxkIG5vdCBuZWVkIHRvIGJlIGNoYW5nZWQsIGFuZCB0aGUga2V5IGNhbg0KPj4gYmUgcHJvdmlk
ZWQgdGhyb3VnaCBhbiBhdHRyaWJ1dGUuDQo+PiANCj4+IFVzaW5nIGEgcGx1Z2luIHNob3VsZCBh
bHNvIGFsbG93IHRvIHVzZSBTdGV2ZW7igJlzIHByb3Bvc2FsIGZvciBkb2luZw0KPj4gdGV4dF9w
b2tlKCkgc2FmZWx5OiBieSBjaGFuZ2luZyAnZnVuYygpJyBpbnRvICdhc20gKOKAnGNhbGwgZnVu
Y+KAnSknLCBhcyBkb25lDQo+PiBieSB0aGUgcGx1Z2luLCB5b3UgY2FuIGJlIGd1YXJhbnRlZWQg
dGhhdCByZWdpc3RlcnMgYXJlIGNsb2JiZXJlZC4gVGhlbiwgeW91DQo+PiBjYW4gc3RvcmUgaW4g
dGhlIGFzc2VtYmx5IGJsb2NrIHRoZSByZXR1cm4gYWRkcmVzcyBpbiBvbmUgb2YgdGhlc2UNCj4+
IHJlZ2lzdGVycy4NCj4gDQo+IEknbSBubyBHQ0MgZXhwZXJ0ICh3aHkgZG8gSSBmaW5kIG15c2Vs
ZiBzYXlpbmcgdGhpcyBhIGxvdCBsYXRlbHk/KSwgYnV0DQo+IHRoaXMgc291bmRzIHRvIG1lIGxp
a2UgaXQgY291bGQgYmUgdHJpY2t5IHRvIGdldCByaWdodC4NCj4gDQo+IEkgc3VwcG9zZSB5b3Un
ZCBoYXZlIHRvIGRvIGl0IGluIGFuIGVhcmx5IHBhc3MsIHRvIGFsbG93IEdDQyB0byBjbG9iYmVy
DQo+IHRoZSByZWdpc3RlcnMgaW4gYSBsYXRlciBwYXNzLiAgU28gaXQgd291bGQgbmVjZXNzYXJp
bHkgaGF2ZSBzaWRlDQo+IGVmZmVjdHMsIGJ1dCBJIGRvbid0IGtub3cgd2hhdCB0aGUgcmlza3Mg
YXJlLg0KDQpJ4oCZbSBub3QgR0NDIGV4cGVydCBlaXRoZXIgYW5kIHdyaXRpbmcgdGhpcyBjb2Rl
IHdhcyBub3QgbWFraW5nIG1lIGZ1bGwgb2YNCmpveSwgZXRjLi4gSeKAmWxsIGJlIGhhcHB5IHRo
YXQgbXkgY29kZSB3b3VsZCBiZSByZXZpZXdlZCwgYnV0IGl0IGRvZXMgd29yay4gSQ0KZG9u4oCZ
dCB0aGluayBhbiBlYXJseSBwYXNzIGlzIG5lZWRlZCwgYXMgbG9uZyBhcyBoYXJkd2FyZSByZWdp
c3RlcnMgd2VyZSBub3QNCmFsbG9jYXRlZC4NCg0KPiBXb3VsZCBpdCB3b3JrIHdpdGggbW9yZSB0
aGFuIDUgYXJndW1lbnRzLCB3aGVyZSBhcmdzIGdldCBwYXNzZWQgb24gdGhlDQo+IHN0YWNrPw0K
DQpJdCBkb2VzLg0KDQo+IA0KPiBBdCB0aGUgdmVyeSBsZWFzdCwgaXQgd291bGQgKGF0IGxlYXN0
IHBhcnRpYWxseSkgZGVmZWF0IHRoZSBwb2ludCBvZiB0aGUNCj4gY2FsbGVlLXNhdmVkIHBhcmF2
aXJ0IG9wcy4NCg0KQWN0dWFsbHksIEkgdGhpbmsgeW91IGNhbiBldmVuIGRlYWwgd2l0aCBjYWxs
ZWUtc2F2ZWQgZnVuY3Rpb25zIGFuZCByZW1vdmUNCmFsbCB0aGUgKHRlcnJpYmxlKSBtYWNyb3Mu
IFlvdSB3b3VsZCBuZWVkIHRvIHRlbGwgdGhlIGV4dGVuc2lvbiBub3QgdG8NCmNsb2JiZXIgdGhl
IHJlZ2lzdGVycyB0aHJvdWdoIGEgbmV3IGF0dHJpYnV0ZS4NCg0KPiBXaGF0IGlmIHdlIGp1c3Qg
dXNlZCBhIHBsdWdpbiBpbiBhIHNpbXBsZXIgZmFzaGlvbiAtLSB0byBkbyBjYWxsIHNpdGUNCj4g
YWxpZ25tZW50LCBpZiBuZWNlc3NhcnksIHRvIGVuc3VyZSB0aGUgaW5zdHJ1Y3Rpb24gZG9lc24n
dCBjcm9zcw0KPiBjYWNoZWxpbmUgYm91bmRhcmllcy4gIFRoaXMgY291bGQgYmUgZG9uZSBpbiBh
IGxhdGVyIHBhc3MsIHdpdGggbm8gc2lkZQ0KPiBlZmZlY3RzIG90aGVyIHRoYW4gY29kZSBsYXlv
dXQuICBBbmQgaXQgd291bGQgYWxsb3cgdXMgdG8gYXZvaWQNCj4gYnJlYWtwb2ludHMgYWx0b2dl
dGhlciAtLSBhZ2FpbiwgYXNzdW1pbmcgc29tZWJvZHkgY2FuIHZlcmlmeSB0aGF0DQo+IGludHJh
LWNhY2hlbGluZSBjYWxsIGRlc3RpbmF0aW9uIHdyaXRlcyBhcmUgYXRvbWljIHdpdGggcmVzcGVj
dCB0bw0KPiBpbnN0cnVjdGlvbiBkZWNvZGVyIHJlYWRzLg0KDQpUaGUgcGx1Z2luIHNob3VsZCBu
b3QgYmUgYWJsZSB0byBkbyBzby4gTGF5b3V0IG9mIHRoZSBieXRlY29kZSBpcyBkb25lIGJ5DQp0
aGUgYXNzZW1ibGVyLCBzbyBJIGRvbuKAmXQgdGhpbmsgYSBwbHVnaW4gd291bGQgaGVscCB5b3Ug
d2l0aCB0aGlzIG9uZS4=
