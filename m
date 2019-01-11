Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7E5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7915321841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="qZPjFtam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbfAKRXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:23:10 -0500
Received: from mail-eopbgr770084.outbound.protection.outlook.com ([40.107.77.84]:41136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731446AbfAKRXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28pJqAXSk9Cl1ebDKYCqDp5GIDk88h9x2V3b2g3j+hs=;
 b=qZPjFtamGjQjaaurQwTg9rN0d5tpsFEyNXURRd8/kA+SZlpOQRzMckG7y5pgaA8QcfcQlUMprYo2+2iKh0vzbaZ4NKAaBEuN0tlxbiEfuvMm54ZXqkynEZLWii+Cz0Nt3bE79AflMJQkAhuwrzbTF8Cn/1qx4MaMr+LbdLG/RCk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4437.namprd05.prod.outlook.com (52.135.203.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.3; Fri, 11 Jan 2019 17:23:03 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 17:23:03 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAACWAAgAAFOICAABUQAA==
Date:   Fri, 11 Jan 2019 17:23:03 +0000
Message-ID: <CCF7D3C7-9D12-489B-B778-C2156D2DBF47@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <F6735FF5-4D62-4C4E-A145-751E6469CE9E@vmware.com>
 <20190111160739.h3zyn2sakiq3ci3e@treble>
In-Reply-To: <20190111160739.h3zyn2sakiq3ci3e@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4437;20:CzCPvovaT/NkplAUlJolNps9xbgEyNQyTZm9Rb6AxPw8+EqCRNaUvVkCXk/4Kwdq8hb32qh9xDjdQADRyhD+COOWMpw6nNsmC9UbqftEvDdHsLKDTxxXc9DYXtyEcXdnTym+dbWQVP6sazzKG9ffeZwGj74r1/frxuY0kINpsUM=
x-ms-office365-filtering-correlation-id: 05ab8b70-fabb-4740-f8d9-08d677e9717b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4437;
x-ms-traffictypediagnostic: BYAPR05MB4437:
x-microsoft-antispam-prvs: <BYAPR05MB443748C354B61D8985C247EED0850@BYAPR05MB4437.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(66066001)(11346002)(4326008)(53936002)(7416002)(6436002)(6246003)(8676002)(6116002)(81156014)(5660300001)(6916009)(71200400001)(36756003)(83716004)(71190400001)(229853002)(105586002)(68736007)(6512007)(305945005)(7736002)(6486002)(106356001)(82746002)(81166006)(33656002)(86362001)(54906003)(93886005)(486006)(2906002)(476003)(53546011)(2616005)(14454004)(478600001)(186003)(3846002)(25786009)(316002)(99286004)(14444005)(76176011)(6506007)(446003)(26005)(256004)(102836004)(8936002)(6346003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4437;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X5DHhSaXRl3z9FC3Q8RTuiha6uZQBgbddhZiEgDGEbb6qIp7uucT1eVtxQ/f33qWFIj67EzYh9noLL3Esy6P4nuTrXPxIZ19L/jWMynwKd9qAvVoNPb6Pv3nhK8kDoFp6/blQsKZVhQomufkTi0yAkN67+4PrT47TIR0r6BjUSxbkkTVNbkvHty2vTSMZvPQPfaOKiBvmlHmgpujH2U8BSdj6Q8AnVq5hrDDZrt/pTnGGA7uq4dlDS8XDPzlO0qsvUl9+8cUk0b1Lpllbx/ibGOTIScZaS0mBX3ecHZbd3uX7DZDjY/VocMTlo5+8gA1jBjIMVmWCfYdRDjUP925RHpmG6CMXOJXNw+ntUydXCHpZWXnmDvp3C9owpsu+jCGVkw76NYFl38BWOhqzdRgwpXp17LH26Vm3H6cj25xieI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <12C9DABAC030E242ABC262046D35EC6A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ab8b70-fabb-4740-f8d9-08d677e9717b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 17:23:03.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTEsIDIwMTksIGF0IDg6MDcgQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDAzOjQ4OjU5
UE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gSSBsaWtlZCB0aGUgaWRlYSwgQlVULCBo
b3cgd291bGQgaXQgd29yayBmb3IgY2FsbGVlLXNhdmVkIFBWIG9wcz8gIEluDQo+Pj4gdGhhdCBj
YXNlIHRoZXJlJ3Mgb25seSBvbmUgY2xvYmJlcmVkIHJlZ2lzdGVyIHRvIHdvcmsgd2l0aCAocmF4
KS4NCj4+IA0KPj4gVGhhdOKAmXMgd291bGQgYmUgbW9yZSB0cmlja3kuIEhvdyBhYm91dCB1c2lu
ZyBhIHBlci1DUFUgdHJhbXBvbGluZSBjb2RlIHRvDQo+PiBob2xkIGEgZGlyZWN0IGNhbGwgdG8g
dGhlIHRhcmdldCBhbmQgdGVtcG9yYXJpbHkgZGlzYWJsZSBwcmVlbXB0aW9uICh3aGljaA0KPj4g
bWlnaHQgYmUgc2ltcGxlciBieSBkaXNhYmxpbmcgSVJRcyk6DQo+PiANCg0KQWxsb3cgbWUgdG8g
c2ltcGxpZnkvY29ycmVjdDoNCg0KPj4gU3RhdGljLWNhbGwgbW9kaWZpZXI6DQo+PiANCj4+ICAg
ICAgICAxLiBzeW5jaHJvbml6ZV9zY2hlZCgpIHRvIGVuc3VyZSBwZXItY3B1IHRyYW1wb2xpbmUg
aXMgbm90IHVzZWQNCk5vIG5lZWQgZm9yICgxKSAoV2UgYXJlIGdvaW5nIHRvIHN5bmMgdXNpbmcg
SVBJKS4NCg0KPj4gCTIuIFBhdGNoZXMgdGhlIGptcCBpbiBhIHBlci1jcHUgdHJhbXBvbGluZSAo
c2VlIGJlbG93KQ0KPj4gCTMuIFNhdmVzIHRoZSBjYWxsIHNvdXJjZSBSSVAgaW4gW3Blci1jcHUg
c2NyYXRjaHBhZCBSSVBdIChiZWxvdykNCkJvdGggZG8gbm90IG5lZWQgdG8gYmUgcGVyLWNwdQ0K
DQo+PiAJNC4gQ29uZmlndXJlcyB0aGUgaW50MyBoYW5kbGVyIHRvIHVzZSBzdGF0aWMtY2FsbCBp
bnQzIGhhbmRsZXINCj4+IAk1LiBQYXRjaGVzIHRoZSBjYWxsIHRhcmdldCAoYXMgaXQgY3VycmVu
dGx5IGRvZXMpLg0KTm90ZSB0aGF0IHRleHRfcG9rZV9icCgpIHdvdWxkIGRvIGV2ZW50dWFsbHk6
DQoNCglvbl9lYWNoX2NwdShkb19zeW5jX2NvcmUsIE5VTEwsIDEpOw0KDQpTbyB5b3Ugc2hvdWxk
IGtub3cgbm8gY29yZXMgcnVuIHRoZSB0cmFtcG9saW5lIGFmdGVyICg1KS4NCg0K
