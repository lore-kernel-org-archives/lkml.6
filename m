Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AIpwx492iSEucGSMyLio5CZ4LcMw3nYPBUjytZgRcRwhKRP/Y/qvCXVgH4m42Gtacucvc2qRUF4V
ARC-Seal: i=1; a=rsa-sha256; t=1523942809; cv=none;
        d=google.com; s=arc-20160816;
        b=qYP+b4jcLH9Yk8ZHq3fjn06i8Vkj1AGn4d1Q6tUyf20TkiiodWU03YrmNEgxcg7IvQ
         1mGiofJFsJYTR4hHeCRMQSzfl/K89I0Cv5n205AsvxHRG6HT86qTOdWtYGFLpHYxM7ga
         pu5xv+KXjT+/z3wYqabdNYBW1UcuvFB5Oc7/x4GA8bZ3bDE6F7LpK5+fFIceiAocYSiU
         nYgWpblbgdOQ64SFDJfUA9vl+sy0zxmZwykuYgBl16vLGVE/NeiHmtpuUsF08hwuOtEJ
         Qmhyhdz2qTCswgsDqIU/A2TiJVX3vh5oHCm0D+8GMRA7QNAb4SYUMBq3r0RXSmV2Vabh
         C86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=tVPAbIcC903aXJtsYJVEUklplkE+rgZ4SwjaiQhRGg4=;
        b=YIq2kXDmg8BISwrq59r0pm2gkPrmrrr9ecers/ZDduTapbfT+iIP0hM35fQkR4yTq5
         pWWPBKKWpooU8wRQW1Varj5QQY9g4tqcaEChtAv/qMaCM5IW6KKwFsO4aFqXOzOUn3bc
         /IgQjAn+R9h5eRBFPNvw9Bm0zN7U30Vk+K51cIvUq7RUR8y9SRXCymxdBPCNUZcrVfA1
         pRJ4nDbxWSVzEskD+SpKb4096GhxqQ+7tlPNXfFNEFZhFZcbwyG+QXfljYgA1CfY41Bc
         YfxDPjwsG2hHfBI9IoDtifG4GaC9zpPgwh0yeaCLxcTIIwatH6FQETsm/3J4SyOVd4Ru
         ghlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,462,1517904000";
   d="scan'208";a="42502053"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Doug Oucharek <doucharek@cray.com>
CC: James Simmons <jsimmons@infradead.org>, "Drokin, Oleg"
	<oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Lustre
 Development List" <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-check
 macros to libcfs_debug.h
Thread-Topic: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-check
 macros to libcfs_debug.h
Thread-Index: AQHT1Rvl928i1BYJU0WmEXSQPafoe6QDNq0AgADDcgCAAHlqgIAAAbgAgABvO4A=
Date: Tue, 17 Apr 2018 05:26:47 +0000
Message-ID: <A380CFB4-E33C-4D94-AA83-628A2A9F52C5@intel.com>
References: <152383910760.23409.2327082725637657049.stgit@noble>
 <152383935730.23409.6748888065027051683.stgit@noble>
 <alpine.LFD.2.21.1804160438220.16188@casper.infradead.org>
 <6D3C7935-E7ED-4826-B459-0C4888D6048E@cray.com>
 <alpine.LFD.2.21.1804162336220.14398@casper.infradead.org>
 <44671B46-27F6-4CFA-8E3A-7AD62B4C597E@cray.com>
In-Reply-To: <44671B46-27F6-4CFA-8E3A-7AD62B4C597E@cray.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.135.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E2ED798D0EACE43BFC44CDBD493D306@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861409409058351?=
X-GMAIL-MSGID: =?utf-8?q?1597969855340215929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gQXByIDE2LCAyMDE4LCBhdCAxNjo0OCwgRG91ZyBPdWNoYXJlayA8ZG91Y2hhcmVrQGNyYXku
Y29tPiB3cm90ZToNCj4gDQo+PiANCj4+IE9uIEFwciAxNiwgMjAxOCwgYXQgMzo0MiBQTSwgSmFt
ZXMgU2ltbW9ucyA8anNpbW1vbnNAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+PiANCj4+IA0KPj4+
IEphbWVzLA0KPj4+IA0KPj4+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHlvdSdyZSBzYXlp
bmcgeW91IHdhbnQgdG8gYmUgYWJsZSB0byBidWlsZCB3aXRob3V0IGRlYnVnIHN1cHBvcnQuLi4/
ICBJJ20gbm90IGNvbnZpbmNlZCB0aGF0IGJ1aWxkaW5nIGEgY2xpZW50IHdpdGhvdXQgZGVidWcg
c3VwcG9ydCBpcyBpbnRlcmVzdGluZyBvciB1c2VmdWwuICBJbiBmYWN0LCBJIHRoaW5rIGl0IHdv
dWxkIGJlIGhhcm1mdWwsIGFuZCB3ZSBzaG91bGRuJ3Qgb3BlbiB1cCB0aGUgcG9zc2liaWxpdHkg
LSB0aGlzIGlzIHN3aXRjaGFibGUgZGVidWcgd2l0aCB2ZXJ5IGxvdyBvdmVyaGVhZCB3aGVuIG5v
dCBhY3R1YWxseSAib24iLiAgSXQgd291bGQgYmUgcmVhbGx5IGF3ZnVsIHRvIGdldCBhIHByb2Js
ZW0gb24gYSBydW5uaW5nIHN5c3RlbSBhbmQgZGlzY292ZXIgdGhlcmUncyBubyBkZWJ1ZyBzdXBw
b3J0IC0gdGhhdCB5b3UgY2FuJ3QgZXZlbiBlbmFibGUgZGVidWcgd2l0aG91dCBhIHJlaW5zdGFs
bC4NCj4+PiANCj4+PiBJZiBJJ3ZlIHVuZGVyc3Rvb2QgeW91IGNvcnJlY3RseSwgdGhlbiBJIHdv
dWxkIHdhbnQgdG8gc2VlIHByb29mIG9mIGEgc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgY29zdCB3
aGVuIGRlYnVnIGlzIGJ1aWx0IGJ1dCAqb2ZmKiBiZWZvcmUgYWdyZWVpbmcgdG8gZXZlbiBleHBv
c2luZyB0aGlzIG9wdGlvbi4gIChJIGtub3cgaXQncyBhIGNob2ljZSB0aGV5J2QgaGF2ZSB0byBt
YWtlLCBidXQgaWYgaXQncyBub3QgcmVhbGx5IHVzZWZ1bCB3aXRoIGEgc2lkZSBvcmRlciBvZiBw
b3RlbnRpYWxseSBoYXJtZnVsLCB3ZSBzaG91bGRuJ3QgZXZlbiBnaXZlIHBlb3BsZSB0aGUgY2hv
aWNlLikNCj4+IA0KPj4gSSdtIG5vdCBzYXlpbmcgYWRkIHRoZSBvcHRpb24gdG9kYXkgYnV0IHRo
aXMgaXMgbW9yZSBmb3IgdGhlIGxvbmcgZ2FtZS4NCj4+IFdoaWxlIHRoZSBJbnRlbCBsdXN0cmUg
ZGV2ZWxvcGVycyBkZWVwbHkgbG92ZSBsdXN0cmUncyBkZWJ1Z2dpbmcgDQo+PiBpbmZyYXN0cnVj
dHVyZSBJIHNlZSBhIGZ1dHVyZSB3aGVyZSBzb21ldGhpbmcgYmV0dGVyIHdpbGwgY29tZSBhbG9u
ZyB0bw0KPj4gcmVwbGFjZSBpdC4gV2hlbiB0aGF0IGRheSBjb21lcyB3ZSB3aWxsIGhhdmUgYSBw
ZXJpb2Qgd2hlcmUgYm90aA0KPj4gZGVidWdnaW5nIGluZnJhc3RydWN0dXJzIHdpbGwgZXhpc3Qg
YW5kIHNvbWUgZGVwbG95ZXJzIG9mIGx1c3RyZSB3aWxsDQo+PiB3YW50IHRvIHR1cm4gb2ZmIHRo
ZSBvbGQgZGVidWdnaW5nIGluZnJhc3RydWN0dXJlIGFuZCBqdXN0IHVzZSB0aGUgbmV3Lg0KPj4g
VGhhdCBpcyB3aGF0IEkgaGF2ZSBpbiBtaW5kLiBBIHN3aXRjaCB0byBmbGlwIGJldHdlZW4gb3B0
aW9ucy4NCj4gDQo+IFllcyBwbGVhc2UhISAgQW4gb3B0aW9uIGZvciB1c2VycyB3aGljaCBzYXlz
IOKAnG5vLCB5b3UgZG8gbm90IGhhdmUgdGhlIHJpZ2h0IHRvIHBhbmljIG15IHN5c3RlbSB2aWEg
TEFTU0VSVCB3aGVuZXZlciB5b3UgbGlrZeKAnSB3b3VsZCBiZSBhIGJsZXNzaW5nLg0KDQpOb3Rl
IHRoYXQgTEFTU0VSVCgpIGl0c2VsZiBkb2VzIG5vdCBwYW5pYyB0aGUgc3lzdGVtLCB1bmxlc3Mg
eW91IGNvbmZpZ3VyZSBpdA0Kd2l0aCBwYW5pY19vbl9sYnVnPTEuICBPdGhlcndpc2UsIGl0IGp1
c3QgYmxvY2tzIHRoYXQgdGhyZWFkICh0aG91Z2ggdGhpcyBjYW4NCmFsc28gaGF2ZSBhbiBpbXBh
Y3Qgb24gb3RoZXIgdGhyZWFkcyBpZiB5b3UgYXJlIGhvbGRpbmcgbG9ja3MgYXQgdGhhdCB0aW1l
KS4NCg0KVGhhdCBzYWlkLCB0aGUgTEFTU0VSVCgpIHNob3VsZCBub3QgYmUgaGl0IHVubGVzcyB0
aGVyZSBpcyBiYWQgY29kZSwgZGF0YQ0KY29ycnVwdGlvbiwgb3IgdGhlIExBU1NFUlQoKSBpdHNl
bGYgaXMgaW5jb3JyZWN0IChlc3NlbnRpYWxseSBiYWQgY29kZSBhbHNvKS4NCg0KU28gIndoZW5l
dmVyIHlvdSBsaWtlIiBpcyAid2hlbmV2ZXIgdGhlIHN5c3RlbSBpcyBhYm91dCB0byBjb3JydXB0
IHlvdXIgZGF0YSIsDQphbmQgcGVvcGxlIGFyZSBub3QgdmVyeSBmb3JnaXZpbmcgaWYgYSBmaWxl
c3lzdGVtIGNvcnJ1cHRzIHRoZWlyIGRhdGEuLi4NCg0KQ2hlZXJzLCBBbmRyZWFzDQotLQ0KQW5k
cmVhcyBEaWxnZXINCkx1c3RyZSBQcmluY2lwYWwgQXJjaGl0ZWN0DQpJbnRlbCBDb3Jwb3JhdGlv
bg0KDQoNCg0KDQoNCg0KDQo=
