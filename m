Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C2DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F2820872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HydZsyvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfAKPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:49:04 -0500
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:42400
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730850AbfAKPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHeJry1lBaCUx4PWxf/P5iHemYDc/Di4YLI3rNm6AmY=;
 b=HydZsyvLfmEB8LpvHev0pv2OSZX4lx3zRHVr3hmP9l+TZiHsC9ublsxbVGTLVXxmFxE/yUpPxpV02Vt27/ESqzAyR6NEQsqWhkJfyW9kNIOhGqVcFOlG6jWLspp6vYzr5ueS0MqPU18U+dBDl5W6NIrgw9qOjpPvVjZ/FC+/IRg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6632.namprd05.prod.outlook.com (20.179.60.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.6; Fri, 11 Jan 2019 15:49:00 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 15:48:59 +0000
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
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAACWAA
Date:   Fri, 11 Jan 2019 15:48:59 +0000
Message-ID: <F6735FF5-4D62-4C4E-A145-751E6469CE9E@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
In-Reply-To: <20190111151525.tf7lhuycyyvjjxez@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4580:b719:9579:68ac:696b:81fe]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6632;20:ZWKFf8byEzs3u002WmTqTNJOKJ3E2lm77VVtBFX449FfHFjhHkeJP7m121a/Uf48pUyscrCywlK9c7R8opt4o5+2wZCi3lVR/lhnOqOpPnYdZ++W6YN2T5AcarSNZsYv9Z9y/BBmacTjYEyCCiOiNUgu8df6xoqQL5KyOg58BF0=
x-ms-office365-filtering-correlation-id: a3943cf8-19c6-4919-4fcf-08d677dc4db6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6632;
x-ms-traffictypediagnostic: BYAPR05MB6632:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB66329D8B4018CAB7D5148992D0850@BYAPR05MB6632.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(6246003)(53936002)(6512007)(6306002)(14454004)(2906002)(5660300001)(305945005)(4326008)(7416002)(33656002)(76176011)(6506007)(54906003)(46003)(316002)(8936002)(102836004)(53546011)(186003)(8676002)(81156014)(93886005)(83716004)(6116002)(71200400001)(71190400001)(81166006)(7736002)(6916009)(97736004)(14444005)(68736007)(256004)(476003)(11346002)(2616005)(45080400002)(99286004)(105586002)(106356001)(25786009)(446003)(6486002)(36756003)(86362001)(229853002)(6436002)(575784001)(486006)(478600001)(966005)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6632;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Swv6cZsh0l+ADaNdvhP69a+Yp7iNz4JLe5dEzRbvT2W5TCBkduDXg54TeN91gbNTQlCuxXeaYniF8sC9p411ZMe6WVQGpjPBVP9Kkfr5emfeko0h7SoIKv46Nm8+/qVehGri2S9BzInUvuznesQ8pJgxxnegs5rMmOO4M3kKTEEG3S4EBqu2jZZLnsbdrjto9XewuYhV9jRUBM3qIMA65qOL2R8BoI+3OMr5BTBmrWB0ev1r6U2fMUsDJ8as6GGm3suEQ7/PJR55IKNgHKe0NaoYMY+LwhsHCRT55AY7DLg5kLLN8MB8FwzOPZaKHbn2QY0dvzucu8MkSHiM+wpgh2UQX3qRGXvDI45p5vSB7ClMlbdEpLMwGXDIG4NEpmy/rG+MLMvHDo5keR2O35K7sXdgbdqR1n7qCj0K9lNkd8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C96ACA2E41B6459586F0C9AA0DB9DF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3943cf8-19c6-4919-4fcf-08d677dc4db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:48:59.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTEsIDIwMTksIGF0IDc6MTUgQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDAxOjQ3OjAx
QU0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBIZXJlIGlzIGFuIGFsdGVybmF0aXZlIGlk
ZWEgKGFsdGhvdWdoIHNpbWlsYXIgdG8gU3RldmVu4oCZcyBhbmQgbXkgY29kZSkuDQo+PiANCj4+
IEFzc3VtZSB0aGF0IHdlIGFsd2F5cyBjbG9iYmVyIFIxMCwgUjExIG9uIHN0YXRpYy1jYWxscyBl
eHBsaWNpdGx5LCBhcyBhbnlob3cNCj4+IHNob3VsZCBiZSBkb25lIGJ5IHRoZSBjYWxsaW5nIGNv
bnZlbnRpb24gKGFuZCBnY2MgcGx1Z2luIHNob3VsZCBhbGxvdyB1cyB0bw0KPj4gZW5mb3JjZSku
IEFsc28gYXNzdW1lIHRoYXQgd2UgaG9sZCBhIHRhYmxlIHdpdGggYWxsIHNvdXJjZSBSSVAgYW5k
IHRoZQ0KPj4gbWF0Y2hpbmcgdGFyZ2V0Lg0KPj4gDQo+PiBOb3csIGluIHRoZSBpbnQzIGhhbmRs
ZXIgY2FuIHlvdSB0YWtlIHRoZSBmYXVsdGluZyBSSVAgYW5kIHNlYXJjaCBmb3IgaXQgaW4NCj4+
IHRoZSDigJxzdGF0aWMtY2FsbHPigJ0gdGFibGUsIHdyaXRpbmcgdGhlIFJJUCs1IChvZmZzZXQp
IGludG8gUjEwIChyZXR1cm4NCj4+IGFkZHJlc3MpIGFuZCB0aGUgdGFyZ2V0IGludG8gUjExLiBZ
b3UgbWFrZSB0aGUgaW50MyBoYW5kbGVyIHRvIGRpdmVydCB0aGUNCj4+IGNvZGUgZXhlY3V0aW9u
IGJ5IGNoYW5naW5nIHB0X3JlZ3MtPnJpcCB0byBwb2ludCB0byBhIG5ldyBmdW5jdGlvbiB0aGF0
IGRvZXM6DQo+PiANCj4+IAlwdXNoIFIxMA0KPj4gCWptcCBfX3g4Nl9pbmRpcmVjdF90aHVua19y
MTENCj4+IA0KPj4gQW5kIHRoZW4geW91IGFyZSBkb25lLiBObz8NCj4gDQo+IElJVUMsIHRoYXQg
c291bmRzIHByZXR0eSBtdWNoIGxpa2Ugd2hhdCBTdGV2ZW4gcHJvcG9zZWQ6DQo+IA0KPiAgaHR0
cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsa21sLmtlcm5lbC5vcmclMkZyJTJGMjAxODExMjkxMjIwMDAuN2ZiNGZiMDQlNDBnYW5k
YWxmLmxvY2FsLmhvbWUmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2Uz
ZjBiOTZhMWU4MzQxN2FmNDg4MDhkNjc3ZDdhMTQ3JTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgz
ZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjgyODE2NTM3MDkwODI5MiZhbXA7c2RhdGE9UEZ6ckpRem9h
MjFJUlltRXVxSFNTR1lyTlp0MHpJbzhUR09aYTNOV2JPRSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpT
dHVwaWQgbWUuIEnigJl2ZSByZW1lbWJlcmVkIGl0IHNsaWdodGx5IGRpZmZlcmVudCAodGhlIGNh
bGxlciBzYXZpbmcgdGhlDQp0YXJnZXQgaW4gYSByZWdpc3RlcikuDQoNCj4gSSBsaWtlZCB0aGUg
aWRlYSwgQlVULCBob3cgd291bGQgaXQgd29yayBmb3IgY2FsbGVlLXNhdmVkIFBWIG9wcz8gIElu
DQo+IHRoYXQgY2FzZSB0aGVyZSdzIG9ubHkgb25lIGNsb2JiZXJlZCByZWdpc3RlciB0byB3b3Jr
IHdpdGggKHJheCkuDQoNClRoYXTigJlzIHdvdWxkIGJlIG1vcmUgdHJpY2t5LiBIb3cgYWJvdXQg
dXNpbmcgYSBwZXItQ1BVIHRyYW1wb2xpbmUgY29kZSB0bw0KaG9sZCBhIGRpcmVjdCBjYWxsIHRv
IHRoZSB0YXJnZXQgYW5kIHRlbXBvcmFyaWx5IGRpc2FibGUgcHJlZW1wdGlvbiAod2hpY2gNCm1p
Z2h0IGJlIHNpbXBsZXIgYnkgZGlzYWJsaW5nIElSUXMpOg0KDQpTdGF0aWMtY2FsbCBtb2RpZmll
cjoNCg0KICAgICAgICAxLiBzeW5jaHJvbml6ZV9zY2hlZCgpIHRvIGVuc3VyZSBwZXItY3B1IHRy
YW1wb2xpbmUgaXMgbm90IHVzZWQNCgkyLiBQYXRjaGVzIHRoZSBqbXAgaW4gYSBwZXItY3B1IHRy
YW1wb2xpbmUgKHNlZSBiZWxvdykNCgkzLiBTYXZlcyB0aGUgY2FsbCBzb3VyY2UgUklQIGluIFtw
ZXItY3B1IHNjcmF0Y2hwYWQgUklQXSAoYmVsb3cpIA0KCTQuIENvbmZpZ3VyZXMgdGhlIGludDMg
aGFuZGxlciB0byB1c2Ugc3RhdGljLWNhbGwgaW50MyBoYW5kbGVyDQoJNS4gUGF0Y2hlcyB0aGUg
Y2FsbCB0YXJnZXQgKGFzIGl0IGN1cnJlbnRseSBkb2VzKS4NCg0KU3RhdGljLWNhbGwgaW50MyBo
YW5kbGVyOg0KCTEuIENoYW5nZXMgZmxhZ3Mgb24gdGhlIHN0YWNrIHRvIGtlZXAgSVJRcyBkaXNh
YmxlZCBvbiByZXR1cm4NCgkyLiBKdW1wcyB0byBwZXItY3B1IHRyYW1wb2xpbmUgb24gcmV0dXJu
DQoNClBlci1jcHUgdHJhbXBvbGluZToNCglwdXNoIFtwZXItQ1BVIHNjcmF0Y2hwYWQgUklQXQ0K
CXN0aQ0KCWptcCBbIHRhcmdldCBdICh0aGlzIG9uZSBpcyBwYXRjaGVkKQ0KDQpOb3RlIHRoYXQg
bm8gSVJRIHNob3VsZCBiZSBwb3NzaWJsZSBiZXR3ZWVuIHRoZSBTVEkgYW5kIHRoZSBKTVAgZHVl
IHRvIFNUSQ0KYmxvY2tpbmcuDQoNCldoYXQgZG8geW91IHNheT8NCg0K
