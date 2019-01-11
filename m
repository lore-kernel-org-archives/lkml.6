Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176A921841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="V1PmQsof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfAKV4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:56:23 -0500
Received: from mail-eopbgr700045.outbound.protection.outlook.com ([40.107.70.45]:10424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfAKV4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a4vYUYzS5fOOQUfyPs41af6kQzrPROnk/fvJEfYu18=;
 b=V1PmQsofEVohwCAeN4l8UukyXrDOmG/E6AA2rFCOofMlfSP3Jg6P0ZO4LAZifD85WT7duUJc4Z7EdigsDPbOwz4glFIgbIiyjfwitG2kYCqAxQEpGTUSv1aa31XSX0ELqr9dKRZpWWAGgnQUiTCGdjd8E3OL3YUj8p/ZyVpbw+M=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4709.namprd05.prod.outlook.com (52.135.233.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.16; Fri, 11 Jan 2019 21:56:06 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 21:56:06 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAAP7oAgAAQ/wCAAAJIAIAABVWAgAAENoCAAAnsAIAABCIAgAABOwCAAAQcAA==
Date:   Fri, 11 Jan 2019 21:56:05 +0000
Message-ID: <835C279A-815E-448F-9337-673F9A47CDAC@vmware.com>
References: <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
 <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <20190111212210.veyfn5vvjswcwacm@treble>
 <6B0B7437-0577-4FE7-A0BC-EFB5D94B8C21@vmware.com>
 <20190111214122.dzye2mg32aksuyo3@treble>
In-Reply-To: <20190111214122.dzye2mg32aksuyo3@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4709;20:iwA3qsbbFssVTWOhOYmcHHj9wQrl2EuOtfeT6TfXyx3dPgV/kTb9sjPvbUO1pE97Hoto8ffAnBlb4iz0yszHaSaGQEEy6Y/XqyfSO/STmClZRaALoxqAPY1MCUcBg515IpY/1Z1xO9kAOZ9czhKXuP5Iw2JlZ9fBA7mUhbrY4Ww=
x-ms-office365-filtering-correlation-id: 0c31a489-87ca-4f06-9414-08d6780f9659
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4709;
x-ms-traffictypediagnostic: BYAPR05MB4709:
x-microsoft-antispam-prvs: <BYAPR05MB470959BA4997A02EA6B9E6B6D0850@BYAPR05MB4709.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(7416002)(486006)(316002)(2616005)(8936002)(6436002)(25786009)(3846002)(6116002)(305945005)(66066001)(446003)(4326008)(53546011)(11346002)(14454004)(476003)(81156014)(81166006)(8676002)(2906002)(256004)(71200400001)(14444005)(71190400001)(83716004)(6916009)(99286004)(93886005)(105586002)(6506007)(26005)(68736007)(36756003)(106356001)(33656002)(97736004)(966005)(6306002)(5660300001)(86362001)(6346003)(186003)(82746002)(6246003)(76176011)(102836004)(478600001)(7736002)(6486002)(54906003)(229853002)(6512007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4709;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NXXAQ1z53e6Did2WLA3a3Ph86LF9sJ/+HSlW39UrBXL3CCxoq0AfyCMzQBc3ob4yFYJZDJeziqezRTQuMr6ebTFEUDXX8qRxqs2H6yOCcYlQYGdlxMDM3UII4UOpmuTR33VflFo8cdx3AqB49B4MV3rOUeRtXiMSKg3iCEZB1YRuSANHGzJmbbVPGMvOrRDjoq2Pw5I86krX5iauZ+iggm9YP+z3HdcVlFr6SGDxyl+wA3vI8bTKSwhf7nENBlmAwjMSqI573Oe3/NskD+TELyQIUU33KsnxENjdv86gTmnU0UIyvwh2nRAKnNSFETNm0kS3R+y5QIX7HDB/QhW5v/+48tjYDMVKb/ZgQGPC6FxqfQ3gvMR6Yw28B1RkxVQ7F4pMD5JjbyEjVPOakMHp0nEi8uOg8/4kf7I42nCN1iY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF6F7E457844384EB5BBEA961A50CF36@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c31a489-87ca-4f06-9414-08d6780f9659
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 21:56:05.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTEsIDIwMTksIGF0IDE6NDEgUE0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDA5OjM2OjU5
UE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gT24gSmFuIDExLCAyMDE5LCBhdCAxOjIy
IFBNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4gDQo+
Pj4gT24gRnJpLCBKYW4gMTEsIDIwMTkgYXQgMTI6NDY6MzlQTSAtMDgwMCwgTGludXMgVG9ydmFs
ZHMgd3JvdGU6DQo+Pj4+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDEyOjMxIFBNIEpvc2ggUG9p
bWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+IEkgd2FzIHJlZmVycmlu
ZyB0byB0aGUgZmFjdCB0aGF0IGEgc2luZ2xlIHN0YXRpYyBjYWxsIGtleSB1cGRhdGUgd2lsbA0K
Pj4+Pj4gdXN1YWxseSByZXN1bHQgaW4gcGF0Y2hpbmcgbXVsdGlwbGUgY2FsbCBzaXRlcy4gIEJ1
dCB5b3UncmUgcmlnaHQsIGl0J3MNCj4+Pj4+IG9ubHkgMS0yIHRyYW1wb2xpbmVzIHBlciB0ZXh0
X3Bva2VfYnAoKSBpbnZvY2F0aW9uLiAgVGhvdWdoIGV2ZW50dWFsbHkNCj4+Pj4+IHdlIG1heSB3
YW50IHRvIGJhdGNoIGFsbCB0aGUgd3JpdGVzIGxpa2Ugd2hhdCBEYW5pZWwgaGFzIHByb3Bvc2Vk
IGZvcg0KPj4+Pj4ganVtcCBsYWJlbHMsIHRvIHJlZHVjZSBJUElzLg0KPj4+PiANCj4+Pj4gWWVh
aCwgbXkgc3VnZ2VzdGlvbiBkb2Vzbid0IGFsbG93IGZvciBiYXRjaGluZywgc2luY2UgaXQgd291
bGQNCj4+Pj4gYmFzaWNhbGx5IGdlbmVyYXRlIG9uZSB0cmFtcG9saW5lIGZvciBldmVyeSByZXdy
aXR0ZW4gaW5zdHJ1Y3Rpb24uDQo+Pj4gDQo+Pj4gQXMgQW5keSBzYWlkLCBJIHRoaW5rIGJhdGNo
aW5nIHdvdWxkIHN0aWxsIGJlIHBvc3NpYmxlLCBpdCdzIGp1c3QgdGhhdA0KPj4+IHdlJ2QgaGF2
ZSB0byBjcmVhdGUgbXVsdGlwbGUgdHJhbXBvbGluZXMgYXQgYSB0aW1lLg0KPj4+IA0KPj4+IE9y
Li4uIHdlIGNvdWxkIGRvIGEgaHlicmlkIGFwcHJvYWNoOiBjcmVhdGUgYSBzaW5nbGUgY3VzdG9t
IHRyYW1wb2xpbmUNCj4+PiB3aGljaCBoYXMgdGhlIGNhbGwgZGVzdGluYXRpb24gcGF0Y2hlZCBp
biwgYnV0IHB1dCB0aGUgcmV0dXJuIGFkZHJlc3MgaW4NCj4+PiAlcmF4IC0tIHdoaWNoIGlzIGFs
d2F5cyBjbG9iYmVyZWQsIGV2ZW4gZm9yIGNhbGxlZS1zYXZlZCBQViBvcHMuICBMaWtlOg0KPj4+
IA0KPj4+IHRyYW1wb2xpbmU6DQo+Pj4gCXB1c2ggJXJheA0KPj4+IAljYWxsIHBhdGNoZWQtZGVz
dA0KPj4+IA0KPj4+IFRoYXQgd2F5IHRoZSBiYXRjaGluZyBjb3VsZCBiZSBkb25lIHdpdGggYSBz
aW5nbGUgdHJhbXBvbGluZQ0KPj4+IChwYXJ0aWN1bGFybHkgaWYgdXNpbmcgcmN1LXNjaGVkIHRv
IGF2b2lkIHRoZSBzdGkgaGFjaykuDQo+PiANCj4+IEkgZG9u4oCZdCBzZWUgUkNVLXNjaGVkIHNv
bHZlcyB0aGUgcHJvYmxlbSBpZiB5b3UgZG9u4oCZdCBkaXNhYmxlIHByZWVtcHRpb24uIE9uDQo+
PiBhIGZ1bGx5IHByZWVtcHRhYmxlIGtlcm5lbCwgeW91IGNhbiBnZXQgcHJlZW1wdGVkIGJldHdl
ZW4gdGhlIHB1c2ggYW5kIHRoZQ0KPj4gY2FsbCAoam1wKSBvciBiZWZvcmUgdGhlIHB1c2guIFJD
VS1zY2hlZCBjYW4gdGhlbiBmaW5pc2gsIGFuZCB0aGUgcHJlZW1wdGVkDQo+PiB0YXNrIG1heSBs
YXRlciBqdW1wIHRvIGEgd3JvbmcgcGF0Y2hlZC1kZXN0Lg0KPiANCj4gQXJnaCwgSSBtaXNzcG9r
ZSBhYm91dCBSQ1Utc2NoZWQuICBXb3JkcyBhcmUgaGFyZC4NCj4gDQo+IEkgbWVhbnQgc3luY2hy
b25pemVfcmN1X3Rhc2tzKCksIHdoaWNoIGlzIGEgY29tcGxldGVseSBkaWZmZXJlbnQgYW5pbWFs
Lg0KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQgd2FpdHMgdW50aWwgYWxsIHJ1bm5hYmxl
IHRhc2tzIChpbmNsdWRpbmcNCj4gcHJlZW1wdGVkIHRhc2tzKSBoYXZlIGdvdHRlbiBhIGNoYW5j
ZSB0byBydW4uDQoNCkFjdHVhbGx5LCBJIGp1c3QgdXNlZCB0aGUgdGVybSB5b3UgdXNlZCwgYW5k
IHRob3VnaHQgYWJvdXQNCnN5bmNocm9uaXplX3NjaGVkKCkuIElmIHlvdSBsb29rIGF0IG15IHBh
dGNoIFsxXSwgeW914oCZbGwgc2VlIEkgZGlkIHNvbWV0aGluZw0Kc2ltaWxhciB1c2luZyBzeW5j
aHJvbml6ZV9zY2hlZCgpLiBCdXQgdGhpcyByZXF1aXJlZCBzb21lIGRlbGljYXRlIHdvcmsgb2YN
CnJlc3RhcnRpbmcgYW55IHByZWVtcHRlZCDigJxvcHRwb2xpbmXigJ0gKG9yIHdoYXRldmVyIG5h
bWUgeW91IHdhbnQpIGJsb2NrLiANCg0KW05vdGUgdGhhdCBteSBpbXBsZW1lbnRhdGlvbiBoYXMg
YSB0ZXJyaWJsZSBidWcgaW4gdGhpcyByZXNwZWN0XS4NCg0KVGhpcyBpcyByZXF1aXJlZCBzaW5j
ZSBydW5uaW5nIGEgcHJlZW1wdGVkIHRhc2sgdG8gZG9lcyBub3cgcHJldmVudCBpdCBmcm9tDQpi
ZWluZyBwcmVlbXB0ZWQgYWdhaW4gd2l0aG91dCBkb2luZyBhbnkg4oCccmVhbOKAnSBwcm9ncmVz
cy4NCg0KSWYgd2Ugd2FudCB0byBhZGFwdCB0aGUgc2FtZSBzb2x1dGlvbiB0byBzdGF0aWNfY2Fs
bHMsIHRoaXMgbWVhbnMgdGhhdCBpbg0KcmV0aW50X2tlcm5lbCAoZW50cnlfNjQuUyksIHlvdSBu
ZWVkIGNoZWNrIHdoZXRoZXIgeW91IGdvdCBwcmVlbXB0ZWQgaW5zaWRlDQp0aGUgdHJhbXBvbGlu
ZSBhbmQgY2hhbmdlIHRoZSBzYXZlZCBSSVAgaW4gc3VjaCBjYXNlIGJhY2ssIGJlZm9yZSB0aGUN
CnN0YXRpY19jYWxsLg0KDQpJTUhPLCBzdGkram1wIGlzIHNpbXBsZXIuDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgxMjMxMDcyMTEyLjIxMDUxLTYtbmFtaXRAdm13YXJl
LmNvbS8=
