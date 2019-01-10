Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9029AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428C1213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="USo/F/t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfAJUsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:48:40 -0500
Received: from mail-eopbgr770047.outbound.protection.outlook.com ([40.107.77.47]:43980
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729355AbfAJUsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6AGe1S+O6pbhqXRHAbQjU1EF8pHP9rptyC/ntPDdyE=;
 b=USo/F/t+njO7VP9HXNKDwkaXWL7FR7TJTekvYYni8NGdXVsdpImEwsbpMcfcCSoU9/ofClfyj6BxoOr8+fsCc6uDy3bXg2hPApOlRvagtYkhBIkrFro50jS7D16Is+fN63Rc8WQqor0wWU+VT0ADAC6mwtGhd3415uqQ/8KMivc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6088.namprd05.prod.outlook.com (20.178.54.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.3; Thu, 10 Jan 2019 20:48:32 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 20:48:32 +0000
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
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWntJ6AgAEB5ICAAA1xgIAADNqAgAAYZICAAA0MgIAABJWA
Date:   Thu, 10 Jan 2019 20:48:31 +0000
Message-ID: <F773CB3F-992B-4BC9-9376-72300BBA550B@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <A42784EF-3215-4ED9-8D35-1A2C38A0711F@vmware.com>
 <20190110164401.g747vifrppbhbo3o@treble>
 <D8481FBB-4873-43B2-9187-C0896E859191@vmware.com>
 <20190110181807.irh2b7fk6at43rdl@treble>
 <3F89FB6B-DA8B-4C71-B825-2B7EB86F274E@vmware.com>
 <20190110203207.3k43gt4kcvry7us7@treble>
In-Reply-To: <20190110203207.3k43gt4kcvry7us7@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6088;20:WTvcr1MdahhfkO6UomIXZZEjciVzw1vGh0NlgvMhaqNWj88ADUUpZBuusN/wbWZv8QVirXHFy0BsluBUv+sSMMlh2t8IZqMbW9unIqxm1adjFWnTgUFouoaiKLbl7QkyLRsOnNPvCWeZC7H1lJ4k2RI/BFLbPqRQASXMjCMNQsM=
x-ms-office365-filtering-correlation-id: 4c311360-b621-4983-6cb2-08d6773cfba0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6088;
x-ms-traffictypediagnostic: BYAPR05MB6088:
x-microsoft-antispam-prvs: <BYAPR05MB6088D6273E9C00BA5D2DBDB8D0840@BYAPR05MB6088.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(305945005)(256004)(7736002)(14444005)(4326008)(81156014)(25786009)(316002)(81166006)(33656002)(6306002)(14454004)(105586002)(68736007)(8936002)(6512007)(8676002)(53936002)(106356001)(6246003)(71200400001)(71190400001)(476003)(2616005)(446003)(26005)(86362001)(229853002)(83716004)(966005)(2906002)(6436002)(575784001)(76176011)(53546011)(186003)(66066001)(478600001)(97736004)(6506007)(93886005)(5660300001)(82746002)(486006)(6916009)(7416002)(3846002)(102836004)(6116002)(45080400002)(36756003)(99286004)(6486002)(11346002)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6088;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SiU9YdwY22Mwu7FG66O5SBGvY3+PuupuZB+EtKUU64Yp8u0wu1JpcPXj+9WJtgvtqL84PC4bMxlmIJnchtSng3hYUDCSIIp/NCTTCjmAcS1/TMgCS1HvGbA4xQ7F1HN7Tz4AplU1h9diBSvlwDunxfS5+xfU10SryF7Vo8D+xQdSDKg8Xve5pSKn5EmTQxiFcyEUWcYQgpBthwL+LKCIdkZIBb+nOxUKAAiz5EsQSySQU1jIb6j1yM+smkq0iOFZsE/wxeqKZ+6op7KN/2BjCX//9UvGz3jyY6+nxLgUX2SFqQstpqMCP0Qc+OWeUKmSO7g386y24dZ8gq2Zqt1WedeKUMp9Uqejv97rft6ECClLjq0YlsqBkedJAtPOlnBOtJLYMZDl+cCKzzn9uNhdWnvQLuhXdIJPdvanxLoGqIdOASWfgLnFFxcMmuJoSSy6TyPFMio7n7UlCOi/qxf/UA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F75850B40DC77C4BA966226EB1AAEEB7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c311360-b621-4983-6cb2-08d6773cfba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 20:48:31.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTAsIDIwMTksIGF0IDEyOjMyIFBNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiAxMCwgMjAxOSBhdCAwNzo0NToy
NlBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+PiBJ4oCZbSBub3QgR0NDIGV4cGVydCBl
aXRoZXIgYW5kIHdyaXRpbmcgdGhpcyBjb2RlIHdhcyBub3QgbWFraW5nIG1lIGZ1bGwgb2YNCj4+
Pj4gam95LCBldGMuLiBJ4oCZbGwgYmUgaGFwcHkgdGhhdCBteSBjb2RlIHdvdWxkIGJlIHJldmll
d2VkLCBidXQgaXQgZG9lcyB3b3JrLiBJDQo+Pj4+IGRvbuKAmXQgdGhpbmsgYW4gZWFybHkgcGFz
cyBpcyBuZWVkZWQsIGFzIGxvbmcgYXMgaGFyZHdhcmUgcmVnaXN0ZXJzIHdlcmUgbm90DQo+Pj4+
IGFsbG9jYXRlZC4NCj4+Pj4gDQo+Pj4+PiBXb3VsZCBpdCB3b3JrIHdpdGggbW9yZSB0aGFuIDUg
YXJndW1lbnRzLCB3aGVyZSBhcmdzIGdldCBwYXNzZWQgb24gdGhlDQo+Pj4+PiBzdGFjaz8NCj4+
Pj4gDQo+Pj4+IEl0IGRvZXMuDQo+Pj4+IA0KPj4+Pj4gQXQgdGhlIHZlcnkgbGVhc3QsIGl0IHdv
dWxkIChhdCBsZWFzdCBwYXJ0aWFsbHkpIGRlZmVhdCB0aGUgcG9pbnQgb2YgdGhlDQo+Pj4+PiBj
YWxsZWUtc2F2ZWQgcGFyYXZpcnQgb3BzLg0KPj4+PiANCj4+Pj4gQWN0dWFsbHksIEkgdGhpbmsg
eW91IGNhbiBldmVuIGRlYWwgd2l0aCBjYWxsZWUtc2F2ZWQgZnVuY3Rpb25zIGFuZCByZW1vdmUN
Cj4+Pj4gYWxsIHRoZSAodGVycmlibGUpIG1hY3Jvcy4gWW91IHdvdWxkIG5lZWQgdG8gdGVsbCB0
aGUgZXh0ZW5zaW9uIG5vdCB0bw0KPj4+PiBjbG9iYmVyIHRoZSByZWdpc3RlcnMgdGhyb3VnaCBh
IG5ldyBhdHRyaWJ1dGUuDQo+Pj4gDQo+Pj4gT2ssIGl0IGRvZXMgc291bmQgaW50ZXJlc3Rpbmcg
dGhlbi4gIEkgYXNzdW1lIHlvdSdsbCBiZSBzaGFyaW5nIHRoZQ0KPj4+IGNvZGU/DQo+PiANCj4+
IE9mIGNvdXJzZS4gSWYgdGhpcyB3aGF0IGlzIGdvaW5nIHRvIGNvbnZpbmNlLCBJ4oCZbGwgbWFr
ZSBhIHNtYWxsIHZlcnNpb24gZm9yDQo+PiBQViBjYWxsZWUtc2F2ZWQgZmlyc3QuDQo+IA0KPiBJ
dCB3YXNuJ3QgKm9ubHkqIHRoZSBQViBjYWxsZWUtc2F2ZWQgcGFydCB3aGljaCBpbnRlcmVzdGVk
IG1lLCBzbyBpZiB5b3UNCj4gYWxyZWFkeSBoYXZlIHNvbWV0aGluZyB3aGljaCBpbXBsZW1lbnRz
IHRoZSBvdGhlciBwYXJ0cywgSSdkIHN0aWxsIGxpa2UNCj4gdG8gc2VlIGl0Lg0KDQpEaWQgeW91
IGhhdmUgYSBsb29rIGF0IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxODEyMzEwNzIx
MTIuMjEwNTEtNC1uYW1pdEB2bXdhcmUuY29tLyA/DQoNClNlZSB0aGUgY2hhbmdlcyB0byB4ODZf
Y2FsbF9tYXJrdXBfcGx1Z2luLmMgLg0KDQpUaGUgbWlzc2luZyBwYXJ0ICh0aGF0IEkganVzdCBm
aW5pc2hlZCBidXQgbmVlZCB0byBjbGVhbnVwKSBpcyBhdHRyaWJ1dGVzDQp0aGF0IGFsbG93IHlv
dSB0byBwcm92aWRlIGtleSBhbmQgZHluYW1pY2FsbHkgZW5hYmxlIHRoZSBwYXRjaGluZy4NCg0K
Pj4+Pj4gV2hhdCBpZiB3ZSBqdXN0IHVzZWQgYSBwbHVnaW4gaW4gYSBzaW1wbGVyIGZhc2hpb24g
LS0gdG8gZG8gY2FsbCBzaXRlDQo+Pj4+PiBhbGlnbm1lbnQsIGlmIG5lY2Vzc2FyeSwgdG8gZW5z
dXJlIHRoZSBpbnN0cnVjdGlvbiBkb2Vzbid0IGNyb3NzDQo+Pj4+PiBjYWNoZWxpbmUgYm91bmRh
cmllcy4gIFRoaXMgY291bGQgYmUgZG9uZSBpbiBhIGxhdGVyIHBhc3MsIHdpdGggbm8gc2lkZQ0K
Pj4+Pj4gZWZmZWN0cyBvdGhlciB0aGFuIGNvZGUgbGF5b3V0LiAgQW5kIGl0IHdvdWxkIGFsbG93
IHVzIHRvIGF2b2lkDQo+Pj4+PiBicmVha3BvaW50cyBhbHRvZ2V0aGVyIC0tIGFnYWluLCBhc3N1
bWluZyBzb21lYm9keSBjYW4gdmVyaWZ5IHRoYXQNCj4+Pj4+IGludHJhLWNhY2hlbGluZSBjYWxs
IGRlc3RpbmF0aW9uIHdyaXRlcyBhcmUgYXRvbWljIHdpdGggcmVzcGVjdCB0bw0KPj4+Pj4gaW5z
dHJ1Y3Rpb24gZGVjb2RlciByZWFkcy4NCj4+Pj4gDQo+Pj4+IFRoZSBwbHVnaW4gc2hvdWxkIG5v
dCBiZSBhYmxlIHRvIGRvIHNvLiBMYXlvdXQgb2YgdGhlIGJ5dGVjb2RlIGlzIGRvbmUgYnkNCj4+
Pj4gdGhlIGFzc2VtYmxlciwgc28gSSBkb27igJl0IHRoaW5rIGEgcGx1Z2luIHdvdWxkIGhlbHAg
eW91IHdpdGggdGhpcyBvbmUuDQo+Pj4gDQo+Pj4gQWN0dWFsbHkgSSB0aGluayB3ZSBjb3VsZCB1
c2UgLmJ1bmRsZV9hbGlnbl9tb2RlIGZvciB0aGlzIHB1cnBvc2U6DQo+Pj4gDQo+Pj4gaHR0cHM6
Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZzb3VyY2V3YXJlLm9yZyUyRmJpbnV0aWxzJTJGZG9jcy0yLjMxJTJGYXMlMkZCdW5kbGUtZGly
ZWN0aXZlcy5odG1sJmFtcDtkYXRhPTAyJTdDMDElN0NuYW1pdCU0MHZtd2FyZS5jb20lN0NiYzRk
Y2M1NDE0NzQ0NjJkYTAwYjA4ZDY3NzNhYjYxZiU3Q2IzOTEzOGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5
ZGQ2MmYwJTdDMCU3QzAlN0M2MzY4Mjc0OTEzODgwNTEyNjMmYW1wO3NkYXRhPUhaTlBONFV5Z3dR
Q3FzWDhkT2FqYU5lRFp5eTFPME80Y1llU3d1JTJCSWRPMCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPj4g
DQo+PiBIbeKApiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB3aGF0IHlvdSBoYXZlIGluIG1pbmQgKGku
ZS4sIHdoZW4gd291bGQgdGhpcw0KPj4gYXNzZW1ibHkgZGlyZWN0aXZlcyB3b3VsZCBiZSBlbWl0
dGVkKS4NCj4gDQo+IEZvciBleGFtcGxlLCBpdCBjb3VsZCByZXBsYWNlDQo+IA0KPiAgY2FsbHEg
X19fX3N0YXRpY19jYWxsX3RyYW1wX215X2tleQ0KPiANCj4gd2l0aA0KPiANCj4gIC5idW5kbGVf
YWxpZ25fbW9kZSA2DQo+ICBjYWxscSBfX19fc3RhdGljX2NhbGxfdHJhbXBfbXlfa2V5DQo+ICAu
YnVuZGxlX2FsaWduX21vZGUgMA0KPiANCj4gd2hpY2ggZW5zdXJlcyB0aGUgaW5zdHJ1Y3Rpb24g
aXMgd2l0aGluIGEgY2FjaGUgbGluZSwgYWxpZ25pbmcgaXQgd2l0aA0KPiBOT1BzIGlmIG5lY2Vz
c2FyeS4gIFRoYXQgd291bGQgYWxsb3cgbXkgY3VycmVudCBpbXBsZW1lbnRhdGlvbiB0bw0KPiB1
cGdyYWRlIG91dC1vZi1saW5lIGNhbGxzIHRvIGlubGluZSBjYWxscyAxMDAlIG9mIHRoZSB0aW1l
LCBpbnN0ZWFkIG9mDQo+IDk1JSBvZiB0aGUgdGltZS4NCg0KSGVoLiBJIGFsbW9zdCB3cm90ZSBi
YXNlZCBubyB0aGUgZmVhdHVyZSBkZXNjcmlwdGlvbiB0aGF0IHRoaXMgd2lsbCBhZGQNCnVubmVj
ZXNzYXJ5IHBhZGRpbmcgbm8gbWF0dGVyIHdoYXQsIGJ1dCBhY3R1YWxseSAoZXhwZXJpbWVudGFs
bHkpIGl0IHdvcmtzDQp3ZWxs4oCmDQoNCg0K
