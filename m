Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF0220878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="nLzWOLHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAKVhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:37:05 -0500
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:46144
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfAKVhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J64OoM2fGtoANPQw8EJxvxb/d9iMaVdjAfKPq0oIGIw=;
 b=nLzWOLHeioMIITD6KX/AYAJo06wptHfnSBRalDZSBsyfSBGtJ5osJau0wGbrNLPIYtpaHrRcnljLt6BOgHbicpK+Vrq+2ViElAFGwIIYq7dASZWDK7zjmwlBjXtlbaH/LZfeRkenpZ4OIPjWSM0mcUhTVW1dfif981p8qKMGAO8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6213.namprd05.prod.outlook.com (20.178.55.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.16; Fri, 11 Jan 2019 21:36:59 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 21:36:59 +0000
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
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAAP7oAgAAQ/wCAAAJIAIAABVWAgAAENoCAAAnsAIAABCIA
Date:   Fri, 11 Jan 2019 21:36:59 +0000
Message-ID: <6B0B7437-0577-4FE7-A0BC-EFB5D94B8C21@vmware.com>
References: <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
 <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <20190111212210.veyfn5vvjswcwacm@treble>
In-Reply-To: <20190111212210.veyfn5vvjswcwacm@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6213;20:ksYreg/N3hyFs0Pj9kxL8gaXXyagVCOc5EUIiSeaLSNucp/v7QDETcljqehupAT409a3MhGVsCwsyT63Glxs3yAGx6qLhCJcTs7wuGiTyFchUP/5hbVg75FH1fUUvv51ICNEQ+YKhElFcMNYUGpuL/9RRovv2WWnmjNOmyv9i8w=
x-ms-office365-filtering-correlation-id: 751ba38d-0e16-426b-e4a6-08d6780ceb1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6213;
x-ms-traffictypediagnostic: BYAPR05MB6213:
x-microsoft-antispam-prvs: <BYAPR05MB62131F992B61E919D9BCD1E8D0850@BYAPR05MB6213.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(189003)(199004)(106356001)(99286004)(8676002)(33656002)(6116002)(54906003)(97736004)(2906002)(316002)(3846002)(93886005)(66066001)(6916009)(36756003)(14454004)(82746002)(486006)(25786009)(2616005)(476003)(11346002)(105586002)(446003)(6436002)(7416002)(5660300001)(102836004)(7736002)(53936002)(6506007)(53546011)(26005)(6486002)(6512007)(229853002)(478600001)(81156014)(86362001)(256004)(76176011)(68736007)(186003)(4326008)(83716004)(71190400001)(71200400001)(305945005)(8936002)(81166006)(14444005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6213;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M2hoS4icUEHEKVhkV2vaWyPZCqRh1PtxHXjeZ5ayaSogP7im8zhEmGiDOa5Bi8skwE2Bgz+0UekjFLBlFRiYpDBTrxfjS1ezc0HpXkXtTULhR15trznm5th/RwmIIh0PTLmee5hKYMchZjtBrGkWNosYMLfj5W40bL19fnsntMhvRfBug9giW3cmwUj4zrzSIOAS/v572a7PcRHgMHBlVb4jCNC0YpB0ga3v1X7Eohx0fKHvo4nwOT731ChpRUB0OJiXn9yJPrfLqZxsQEUj90nfjc41U2EBk+jkPUo6br9dZcZtVMJaXKa8/bCYDGLg+3iXNlFzPbvUwml7QdXtU86iA9ua8yEvfYr59Y1KJ8wyK/dU8+izfMy8eisn9USX23uiRd2Jt8DTcNgPv+fT29WTCTe5vxu3g2CQ0BkicD8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D45AA51AF7E6498CFAC21F133BDAE2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751ba38d-0e16-426b-e4a6-08d6780ceb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 21:36:59.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTEsIDIwMTksIGF0IDE6MjIgUE0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDEyOjQ2OjM5
UE0gLTA4MDAsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPj4gT24gRnJpLCBKYW4gMTEsIDIwMTkg
YXQgMTI6MzEgUE0gSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+IHdyb3RlOg0K
Pj4+IEkgd2FzIHJlZmVycmluZyB0byB0aGUgZmFjdCB0aGF0IGEgc2luZ2xlIHN0YXRpYyBjYWxs
IGtleSB1cGRhdGUgd2lsbA0KPj4+IHVzdWFsbHkgcmVzdWx0IGluIHBhdGNoaW5nIG11bHRpcGxl
IGNhbGwgc2l0ZXMuICBCdXQgeW91J3JlIHJpZ2h0LCBpdCdzDQo+Pj4gb25seSAxLTIgdHJhbXBv
bGluZXMgcGVyIHRleHRfcG9rZV9icCgpIGludm9jYXRpb24uICBUaG91Z2ggZXZlbnR1YWxseQ0K
Pj4+IHdlIG1heSB3YW50IHRvIGJhdGNoIGFsbCB0aGUgd3JpdGVzIGxpa2Ugd2hhdCBEYW5pZWwg
aGFzIHByb3Bvc2VkIGZvcg0KPj4+IGp1bXAgbGFiZWxzLCB0byByZWR1Y2UgSVBJcy4NCj4+IA0K
Pj4gWWVhaCwgbXkgc3VnZ2VzdGlvbiBkb2Vzbid0IGFsbG93IGZvciBiYXRjaGluZywgc2luY2Ug
aXQgd291bGQNCj4+IGJhc2ljYWxseSBnZW5lcmF0ZSBvbmUgdHJhbXBvbGluZSBmb3IgZXZlcnkg
cmV3cml0dGVuIGluc3RydWN0aW9uLg0KPiANCj4gQXMgQW5keSBzYWlkLCBJIHRoaW5rIGJhdGNo
aW5nIHdvdWxkIHN0aWxsIGJlIHBvc3NpYmxlLCBpdCdzIGp1c3QgdGhhdA0KPiB3ZSdkIGhhdmUg
dG8gY3JlYXRlIG11bHRpcGxlIHRyYW1wb2xpbmVzIGF0IGEgdGltZS4NCj4gDQo+IE9yLi4uIHdl
IGNvdWxkIGRvIGEgaHlicmlkIGFwcHJvYWNoOiBjcmVhdGUgYSBzaW5nbGUgY3VzdG9tIHRyYW1w
b2xpbmUNCj4gd2hpY2ggaGFzIHRoZSBjYWxsIGRlc3RpbmF0aW9uIHBhdGNoZWQgaW4sIGJ1dCBw
dXQgdGhlIHJldHVybiBhZGRyZXNzIGluDQo+ICVyYXggLS0gd2hpY2ggaXMgYWx3YXlzIGNsb2Ji
ZXJlZCwgZXZlbiBmb3IgY2FsbGVlLXNhdmVkIFBWIG9wcy4gIExpa2U6DQo+IA0KPiB0cmFtcG9s
aW5lOg0KPiAJcHVzaCAlcmF4DQo+IAljYWxsIHBhdGNoZWQtZGVzdA0KPiANCj4gVGhhdCB3YXkg
dGhlIGJhdGNoaW5nIGNvdWxkIGJlIGRvbmUgd2l0aCBhIHNpbmdsZSB0cmFtcG9saW5lDQo+IChw
YXJ0aWN1bGFybHkgaWYgdXNpbmcgcmN1LXNjaGVkIHRvIGF2b2lkIHRoZSBzdGkgaGFjaykuDQoN
CkkgZG9u4oCZdCBzZWUgUkNVLXNjaGVkIHNvbHZlcyB0aGUgcHJvYmxlbSBpZiB5b3UgZG9u4oCZ
dCBkaXNhYmxlIHByZWVtcHRpb24uIE9uDQphIGZ1bGx5IHByZWVtcHRhYmxlIGtlcm5lbCwgeW91
IGNhbiBnZXQgcHJlZW1wdGVkIGJldHdlZW4gdGhlIHB1c2ggYW5kIHRoZQ0KY2FsbCAoam1wKSBv
ciBiZWZvcmUgdGhlIHB1c2guIFJDVS1zY2hlZCBjYW4gdGhlbiBmaW5pc2gsIGFuZCB0aGUgcHJl
ZW1wdGVkDQp0YXNrIG1heSBsYXRlciBqdW1wIHRvIGEgd3JvbmcgcGF0Y2hlZC1kZXN0Lg0KDQo=
