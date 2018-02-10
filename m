Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AH8x226QusWHXnD2M1VsIkS71tW94BAPdww+fEnnPqBiRKKcsSveSz0H9kz9FDA6gxLMS3dwMzMX
ARC-Seal: i=1; a=rsa-sha256; t=1518276376; cv=none;
        d=google.com; s=arc-20160816;
        b=QoJlPfGMH/EBfUzt2EbLCIXoFd5DLYmnlVKZsqhQKscO8BmcCgJBhh4010jugoHbOd
         Ps+P/mmUTpuEZY4Th1pmb+YSu8Oj5xxNjSg9X6tnjiYcgQcblJtSTMF7/SuSll9NdSzS
         RFC9XlD8hjYCKolqvXFGNVA17MsAhffTB8zZgJQZ/B/Sg5VoYeNlyfWMl1tjzoBsEksY
         da1TPdwgNKTfwY9NG1ob5zh/6whzve2OlrIg7Hq5VujqBi9HYp5IoypuSex7HnlMdqHr
         j9c2fuDnSLwz6u9jMw2HznaLCXF5qwYTyqFHsnVXOhZsnyYbOSnm4eHXLfM8CiZh4rqo
         JcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=W6T9Gx71UHWQRMOZM4PWSwxY4q+o9K+LM1DslrL+buw=;
        b=v1ItNTAyVgmGW4KizWA1TroU5KvrIxxhgj1h4/Aj0HrYMHXoJLncjNIypUogo/PNXn
         EeZ41EwOAj9ny5e4U/7aZAQlVc9VN6YkP00Vf0GA+dd1jpU7OeKtjVuMFfIYy6o7IEtD
         seFBJdW39uHLwThiyDvgBmU5XMQLlk9JyAvpLyK1IdcMtyiGS2FwYybS8KLOROMOOYEp
         6FYr3kId3eDIoO2XydlUptwnmwc6izla7AFu/oBlKsDWTc0lxs6yJD6lfqFv0Rl9JauA
         PwByQZgmrsF1PqvlyWK8dvEekh772ZGwffyCUOy4+ZtybP34btR89oUdyfsnabgG07p2
         us2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.193 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.193 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: 'Denys Vlasenko' <dvlasenk@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Joerg Roedel <joro@8bytes.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm
	<linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>, Dave Hansen
	<dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross
	<jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov
	<bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>, "Eduardo
 Valentin" <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>, "Will
 Deacon" <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel
	<jroedel@suse.de>
Subject: RE: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
Thread-Topic: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline
 stack
Thread-Index: AQHTocn4duOBYzH6Y06ZOLi7EtO7oqOcWD/A
Date: Sat, 10 Feb 2018 15:26:51 +0000
Message-ID: <50431bff2cda445490f5242c1189c8cd@AcuMS.aculab.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org>
 <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <aa52108c-4874-9810-8ff5-e6415189cd73@redhat.com>
In-Reply-To: <aa52108c-4874-9810-8ff5-e6415189cd73@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1592028170187479874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogRGVueXMgVmxhc2Vua28NCj4gU2VudDogMDkgRmVicnVhcnkgMjAxOCAxNzoxNw0KPiBP
biAwMi8wOS8yMDE4IDA2OjA1IFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gPiBPbiBGcmks
IEZlYiA5LCAyMDE4IGF0IDE6MjUgQU0sIEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPiB3
cm90ZToNCj4gPj4gKw0KPiA+PiArICAgICAgIC8qIENvcHkgb3ZlciB0aGUgc3RhY2stZnJhbWUg
Ki8NCj4gPj4gKyAgICAgICBjbGQNCj4gPj4gKyAgICAgICByZXAgbW92c2INCj4gPg0KPiA+IFVn
aC4gVGhpcyBpcyBnb2luZyB0byBiZSBob3JyZW5kb3VzLiBNYXliZSBub3Qgbm90aWNlYWJsZSBv
biBtb2Rlcm4NCj4gPiBDUFUncywgYnV0IHRoZSB3aG9sZSAzMi1iaXQgY29kZSBpcyBraW5kIG9m
IHBvaW50bGVzcyBvbiBhIG1vZGVybiBDUFUuDQo+ID4NCj4gPiBBdCBsZWFzdCB1c2UgInJlcCBt
b3ZzbCIuIElmIHRoZSBrZXJuZWwgc3RhY2sgaXNuJ3QgNC1ieXRlIGFsaWduZWQsDQo+ID4geW91
IGhhdmUgaXNzdWVzLg0KDQpUaGUgYWxpZ25tZW50IGRvZXNuJ3QgbWF0dGVyLCAncmVwIG1vdnNs
JyB3aWxsIHN0aWxsIHdvcmsuDQoNCj4gSW5kZWVkLCAicmVwIG1vdnMiIGhhcyBzb21lIHNldHVw
IG92ZXJoZWFkIHRoYXQgbWFrZXMgaXQgdW5kZXNpcmFibGUNCj4gZm9yIHNtYWxsIHNpemVzLiBJ
biBteSB0ZXN0aW5nLCBtb3ZpbmcgbGVzcyB0aGFuIDEyOCBieXRlcyB3aXRoICJyZXAgbW92cyIN
Cj4gaXMgYSBsb3NzLg0KDQpJdCB2ZXJ5IG11Y2ggZGVwZW5kcyBvbiB0aGUgY3B1Lg0KDQpSZWNl
bnQgKEhhc3dlbGw/KSBJbnRlbCBjcHVzIGhhdmUgaGFyZHdhcmUgc3VwcG9ydCBmb3Igb3B0aW1p
c2luZyAncmVwIG1vdnNiJw0KZm9yIGNhY2hlZCBtZW1vcnkgbG9jYXRpb25zIHNvIHRoYXQgaXQg
aXMgZmFzdCByZWdhcmRsZXNzIG9mIHRoZSBhbGlnbm1lbnRzLg0KVGhlIHNldHVwIGNvc3QgaXMg
ZmFpcmx5IHNtYWxsLg0KDQpUaGUgcHJldmlvdXMgZ2VuZXJhdGlvbiBoYWQgYW4gb3B0aW1pc2F0
aW9uIGZvciAncmVwIG1vdnNiJyBmb3IgbGVzcyB0aGFuDQo3IGJ5dGVzLCBidXQgZm9yIGxhcmdl
ciB2YWx1ZXMgdGhlIHNldHVwIGNvc3Qgd2FzIHNpZ25pZmljYW50bHkgaGlnaGVyLg0KT24gdGhl
c2UgY3B1IHlvdSBuZWVkZWQgdG8gdXNlICdyZXAgbW92c2QnICg2NCBiaXRzIGlzIGJlc3QpIGZv
ciB0aGUgYnVsaw0Kb2YgYSBjb3B5Lg0KDQpBY3R1YWxseSwgaW5zdGVhZCBvZiB1c2luZyAncmVw
IG1vdnNiJyB0byBjb3B5IHRoZSBvZGQgZmV3IGJ5dGVzLCBmb3INCm1lbWNweSgpIHlvdSBjYW4g
Y29weSB0aGUgbGFzdCAobWlzYWxpZ25lZCkgOCBieXRlcyBmaXJzdCB0aGVuIHVzZQ0KJ3JlcCBt
b3ZzZCcgZm9yIHRoZSBidWxrIG9mIHRoZSBjb3B5Lg0KDQpPbiBOZXRidXJzdCBQNCB0aGUgc2V0
dXAgY29zdCBmb3IgYW55ICdyZXAgbW92cycgd2FzIHNvbWV0aGluZyBsaWtlIDQ1IGNsb2Nrcy4N
CllvdSByZWFsbHkgZGlkbid0IHdhbnQgdG8gdXNlIHRoZW0gZm9yIHNob3J0IGNvcGllcy4NCihB
IEMgY29tcGlsZXIgZnJvbSBhIHdlbGwga25vd24gT1Mgc3VwcGxpZXIgd2lsbCAnb3B0aW1pc2Un
IGFueSBjb3B5IGxvb3ANCmludG8gJ3JlcCBtb3ZzYicgLSBub3QgZW50aXJlbHkgdGhlIGJlc3Qg
b2Ygb3B0aW1pc2F0aW9ucyEpDQoNCkkgYWxzbyBtYW5hZ2VkIHRvIG1hdGNoIHRoZSBwZXItY3lj
bGUgY29zdCBvZiAncmVwIG1vdnNsJyB3aXRoIGEgY29weQ0KbG9vcCBvbiBteSBBdGhsb24tNzAw
IChidXQgbm90IHRoZSBzZXR1cCBjb3N0LCBvbiBhIFA0IEkgbWlnaHQgaGF2ZQ0KYmVhdGVuIHRo
ZSBzZXR1cCBjb3N0IGFzIHdlbGwpLg0KDQoJRGF2aWQNCg0K
