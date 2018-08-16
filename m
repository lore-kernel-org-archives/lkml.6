Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A31C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6A2208AD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6A2208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeHPTzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:55:03 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:55192 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbeHPTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:55:03 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-74-F1LuNzHWOlSzF6yoS0JSCQ-1; Thu, 16 Aug 2018 17:55:20 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 16 Aug 2018 17:57:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 16 Aug 2018 17:56:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'James Bottomley' <James.Bottomley@HansenPartnership.com>,
        David Howells <dhowells@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        "yannik@sembritzki.me" <yannik@sembritzki.me>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: RE: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
Thread-Topic: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
Thread-Index: AQHUNXn4ODgxaBfgD0OOj1lwNa9r7KTCl2Eg
Date:   Thu, 16 Aug 2018 16:56:59 +0000
Message-ID: <b29ce8375b454440b7b019ac20cfe726@AcuMS.aculab.com>
References: <1534432615.3166.5.camel@HansenPartnership.com>
         <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com>
 <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <20628.1534427487@warthog.procyon.org.uk>
         <30607.1534434597@warthog.procyon.org.uk>
 <1534435000.3166.9.camel@HansenPartnership.com>
In-Reply-To: <1534435000.3166.9.camel@HansenPartnership.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: F1LuNzHWOlSzF6yoS0JSCQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFtZXMgQm90dG9tbGV5DQo+IFNlbnQ6IDE2IEF1Z3VzdCAyMDE4IDE2OjU3DQo+IE9u
IFRodSwgMjAxOC0wOC0xNiBhdCAxNjo0OSArMDEwMCwgRGF2aWQgSG93ZWxscyB3cm90ZToNCj4g
PiBKYW1lcyBCb3R0b21sZXkgPEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gPiA+IFRoZSBwcm9ibGVtIHdpdGggdGhhdCBpcyB0aGF0IGl0IG1l
YW5zIHlvdSBjYW4ndCBsb2FkIHRoaXJkIHBhcnR5DQo+ID4gPiA+IG1vZHVsZXMgLSBzdWNoIGFz
IHRoZSBOVmlkaWEgZHJpdmVyLsKgwqBUaGF0J3MgZmluZSBpZiB5b3UNCj4gPiA+ID4gYWJzb2x1
dGVseSByZWplY3QgdGhlIHJpZ2h0IG9mIHBlb3BsZSB0byBwcm9kdWNlIHRoaXJkIHBhcnR5DQo+
ID4gPiA+IGRyaXZlcnMgZm9yIHRoZSBMaW51eCBrZXJuZWwgYW5kIGFic29sdXRlbHkgcmVxdWly
ZSB0aGF0IHRoZXkNCj4gPiA+ID4gb3BlbiBhbmQgdXBzdHJlYW0gdGhlaXIgY29kZSBpZiB0aGV5
IHdhbnQgaW4uDQo+ID4gPg0KPiA+ID4gU28gaWYgeW91IGJ1aWxkIHlvdXIgb3duIGtlcm5lbCBh
bmQgd2FudCB0byBsb2FkIHRoZSBuVmlkaWEgbW9kdWxlLA0KPiA+ID4geW91IGhhdmUgdGhlIGtl
eSB0byBzaWduIGl0Lg0KPiA+DQo+ID4gSSB0aGluayB5b3UgaGF2ZSB0byBhc3N1bWUgdGhhdCBk
b2luZyB0aGlzIGlzIGJleW9uZCBtb3N0IHBlb3BsZS4NCj4gDQo+IEFzIGEgc3RlcCBieSBzdGVw
IHByb2Nlc3MsIEkgYWdyZWUuICBIb3dldmVyLCBJIHRoaW5rIHdlIGNhbiBhdXRvbWF0ZQ0KPiBp
dCB0byB0aGUgcG9pbnQgd2hlcmUgeW91IGluc3RhbGwgYSBwYWNrYWdlIGFuZCBpdCBzYXlzICJp
bnNlcnQgeW91cg0KPiB5dWJpa2V5IiBldmVyeSB0aW1lIHlvdSB1cGdyYWRlIHRoZSBrZXJuZWwN
Cg0KV2hhdCBhYm91dCAzcmQgcGFydGllcyB0aGF0IHdhbnQgdG8gcmVsZWFzZSBkcml2ZXJzIHRo
YXQgY2FuIGJlIGxvYWRlZA0KaW50byAnZGlzdHJpYnV0aW9uJyBrZXJuZWxzPw0KV2UgY2FuIGRv
IHRoYXQgZm9yIHdpbmRvd3MgKHByb3ZpZGVkIHdlJ3ZlIHBhaWQgdGhlICdkcml2ZXIgc2lnbmlu
ZyB0YXgnKQ0KYmVjYXVzZSB3aW5kb3dzIGhhcyBhIHN0YWJsZSBrZXJuZWwgRERJL0RLSS4NCkZv
ciBMaW51eCB3ZSBoYXZlIHRvIHJlbGVhc2UgbW9zdCBvZiB0aGUgZHJpdmVyIGFzIGEgYmluYXJ5
ICdibG9iJyBhbmQNCmNvbXBpbGUgd3JhcHBlciBjb2RlIG9uIHRoZSB0YXJnZXQgc3lzdGVtIHdp
dGggdGhlIGNvcnJlY3Qga2VybmVsIGhlYWRlcnMuDQpUaGVyZSBpcyBubyB3YXkgd2UgY291bGQg
Z2VuZXJhdGUgc2lnbmVkIGNvcGllcyBmb3IgZXZlcnkgJ2Rpc3RyaWJ1dGlvbicNCmtlcm5lbCAt
IGV2ZW4gaWYgdGhlcmUgd2FzIGEgd2F5IHRvIGdldCB0aGVtIHNpZ25lZC4NCkV2ZW4gaWYgd2Ug
YWdyZWVkIHRvIG1ha2Ugb3VyIHNvdXJjZSBjb2RlIGF2YWlsYWJsZSBpdCB3b3VsZG4ndCBiZQ0K
YWNjZXB0ZWQgZm9yIGluY2x1c2lvbiBpbiB0aGUga2VybmVsIHNvdXJjZSB0cmVlLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

