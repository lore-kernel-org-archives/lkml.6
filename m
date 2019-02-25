Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B206BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860752087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbfBYII2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:08:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:6109 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfBYII1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:08:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 00:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="149700532"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2019 00:08:25 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 25 Feb 2019 00:08:25 -0800
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.212]) by
 FMSMSX155.amr.corp.intel.com ([169.254.5.88]) with mapi id 14.03.0415.000;
 Mon, 25 Feb 2019 00:08:25 -0800
From:   "Brown, Len" <len.brown@intel.com>
To:     Brice Goglin <Brice.Goglin@inria.fr>, Len Brown <lenb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Like Xu <like.xu@linux.intel.com>
Subject: RE: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
Thread-Topic: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
Thread-Index: AQHUzChcVlqtZssCY0GgoMB6HEOS36XwJ88w
Date:   Mon, 25 Feb 2019 08:08:24 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9485C5BA396@FMSMSX126.amr.corp.intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
 <3ac80787-f282-ce94-77dc-f0e6ea9d4431@inria.fr>
In-Reply-To: <3ac80787-f282-ce94-77dc-f0e6ea9d4431@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTYxZmYyNjEtZmE1Ny00YWY0LWE0YjItZGY0NTZjODQyMWQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibHpVeVpMeVQ5Nzhwa203bkdKamVmQVwvMGFJb0lpOG5YOE1SZzJGcUxPcGZ0UjRySEh3UDlqVEpJRnRUXC85XC9nMSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQnJpY2UsDQoNClllcywgeW91IHJlLWRpc2NvdmVyZWQgdGhlIGJ1ZyB0aGF0IEthbiBMaWFu
ZyBwb2ludGVkIG91dCBsYXN0IHdlZWsuDQoNCkkgaGF2ZSB1cGRhdGVkIHRoaXMgcGF0Y2ggc2V0
LCBhbmQgdGhlIGxhdGVzdCBmb3IgdGVzdGluZyBpcyBpbiBteSBnaXQgdHJlZSBvbiBrZXJuZWwu
b3JnIG9yDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9sZW5iL2xpbnV4LmdpdCB4ODYNCg0KTm90ZSB0
aGF0IEkgdG9vayB5b3VyIGFkdmljZSBhbmQgbGVmdCB0aGUgY29yZV9zaWJsaW5ncyB3aXRoIGl0
cyBvcmlnaW5hbCBkZWZpbml0aW9uLA0KQW5kIGNyZWF0ZWQgcGFja2FnZV90aHJlYWRzIGFzIGEg
c3lub255bS4gIEkgd2lsbCBlLW1haWwgb3V0IHRoZSBwYXRjaCBzZXQgYWdhaW4NCldoZW4gSSBk
byAyIG1vcmUgdGhpbmdzOg0KDQoxLiBhZGQgY29yZV90aHJlYWRzIG1hcCB0byBzeXNmcw0KMi4g
cmVwbGFjZSB1bmlxdWVfZGllX2lkIHdpdGggbG9naWNhbF9kaWVfaWQgLS0gdHVybnMgb3V0IGl0
IGlzIHVzZWZ1bCBmb3Igc2FtZSByZWFzb24gYXMgbG9naWNhbF9wYWNrYWdlX2lkLg0KDQpUaGFu
a3MsDQotTGVuDQoNCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCcmlj
ZSBHb2dsaW4gW21haWx0bzpCcmljZS5Hb2dsaW5AaW5yaWEuZnJdIA0KU2VudDogU3VuZGF5LCBG
ZWJydWFyeSAyNCwgMjAxOSA1OjA0IEFNDQpUbzogTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+
OyB4ODZAa2VybmVsLm9yZw0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEJyb3du
LCBMZW4gPGxlbi5icm93bkBpbnRlbC5jb20+OyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBM
aWtlIFh1IDxsaWtlLnh1QGxpbnV4LmludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMDMv
MTFdIHg4NiB0b3BvbG9neTogQWRkIENQVUlELjFGIG11bHRpLWRpZS9wYWNrYWdlIHN1cHBvcnQN
Cg0KTGUgMTkvMDIvMjAxOSDDoCAwNDo0MCwgTGVuIEJyb3duIGEgw6ljcml0wqA6DQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jIGIvYXJjaC94ODYva2VybmVsL3NtcGJv
b3QuYyANCj4gaW5kZXggY2NkMWYyYThlNTU3Li40MjUwYTg3ZjU3ZGIgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3NtcGJv
b3QuYw0KPiBAQCAtMzkzLDYgKzM5Myw3IEBAIHN0YXRpYyBib29sIG1hdGNoX3NtdChzdHJ1Y3Qg
Y3B1aW5mb194ODYgKmMsIHN0cnVjdCBjcHVpbmZvX3g4NiAqbykNCj4gIAkJaW50IGNwdTEgPSBj
LT5jcHVfaW5kZXgsIGNwdTIgPSBvLT5jcHVfaW5kZXg7DQo+ICANCj4gIAkJaWYgKGMtPnBoeXNf
cHJvY19pZCA9PSBvLT5waHlzX3Byb2NfaWQgJiYNCj4gKwkJICAgIGMtPmNwdV9kaWVfaWQgPT0g
by0+Y3B1X2RpZV9pZCAmJg0KPiAgCQkgICAgcGVyX2NwdShjcHVfbGxjX2lkLCBjcHUxKSA9PSBw
ZXJfY3B1KGNwdV9sbGNfaWQsIGNwdTIpKSB7DQo+ICAJCQlpZiAoYy0+Y3B1X2NvcmVfaWQgPT0g
by0+Y3B1X2NvcmVfaWQpDQo+ICAJCQkJcmV0dXJuIHRvcG9sb2d5X3NhbmUoYywgbywgInNtdCIp
OyBAQCAtNDA0LDYgKzQwNSw3IEBAIHN0YXRpYyANCj4gYm9vbCBtYXRjaF9zbXQoc3RydWN0IGNw
dWluZm9feDg2ICpjLCBzdHJ1Y3QgY3B1aW5mb194ODYgKm8pDQo+ICAJCX0NCj4gIA0KPiAgCX0g
ZWxzZSBpZiAoYy0+cGh5c19wcm9jX2lkID09IG8tPnBoeXNfcHJvY19pZCAmJg0KPiArCQkgICBj
LT5jcHVfZGllX2lkID09IG8tPmNwdV9kaWVfaWQgJiYNCj4gIAkJICAgYy0+Y3B1X2NvcmVfaWQg
PT0gby0+Y3B1X2NvcmVfaWQpIHsNCj4gIAkJcmV0dXJuIHRvcG9sb2d5X3NhbmUoYywgbywgInNt
dCIpOw0KPiAgCX0NCj4gQEAgLTQ2MSw3ICs0NjMsNyBAQCBzdGF0aWMgYm9vbCBtYXRjaF9sbGMo
c3RydWN0IGNwdWluZm9feDg2ICpjLCBzdHJ1Y3QgY3B1aW5mb194ODYgKm8pDQo+ICAgKi8NCj4g
IHN0YXRpYyBib29sIG1hdGNoX2RpZShzdHJ1Y3QgY3B1aW5mb194ODYgKmMsIHN0cnVjdCBjcHVp
bmZvX3g4NiAqbykgIA0KPiB7DQo+IC0JaWYgKGMtPnBoeXNfcHJvY19pZCA9PSBvLT5waHlzX3By
b2NfaWQpDQo+ICsJaWYgKGMtPmNwdV9kaWVfaWQgPT0gby0+Y3B1X2RpZV9pZCkNCj4gIAkJcmV0
dXJuIHRydWU7DQo+ICAJcmV0dXJuIGZhbHNlOw0KPiAgfQ0KDQpIZWxsbyBMZW4sDQoNCkkgYW0g
dGVzdGluZyB5b3VyIHBhdGNoZXMgaW4gYSBWTSB3aXRoIENQVUlELjFmIFFFTVUgcGF0Y2hlcyAo
YXV0aG9yIExpa2UgWHUgaXMgQ0MnZWQpLCBib290ZWQgdG8gZ2V0IDIgcGFja2FnZXMgd2l0aCAx
IE5VTUEgbm9kZSBlYWNoIGFuZCAyIGRpZXMgZWFjaDoNCg0KLXNtcCBjcHVzPTE2LHRocmVhZHM9
Mixjb3Jlcz0yLGRpZXM9Mixzb2NrZXRzPTIgLW51bWEgbm9kZSxjcHVzPTAtNyxub2RlaWQ9MCAt
bnVtYSBub2RlLGNwdXM9OC0xNSxub2RlaWQ9MQ0KDQpzeXNmcyBmaWxlcyBleHBvc2Ugd3Jvbmcg
aW5mb3JtYXRpb246DQpjb3JlX3NpYmxpbmdzIGNvbnRhaW5zIHRocmVhZHMgb2YgdGhlIGxvY2Fs
IGRpZSBBTkQgb2YgZGllIHdpdGggc2FtZSBudW1iZXIgaW4gb3RoZXIgcHJvY2Vzc29ycywgZWcg
Y3B1IDAtMyBhbmQgOC0xMSBpbnN0ZWFkIG9mIDAtMyBvbmx5Lg0KDQpUaGUgaXNzdWUgaXMgdGhh
dCB5b3Ugc2VlbSB0byBhc3N1bWUgdGhhdCBkaWUgaWRzIHdpbGwgYWx3YXlzIGJlIHVuaXF1ZSBh
Y3Jvc3MgbXVsdGlwbGUgcGFja2FnZXMuDQpJcyB0aGlzIGEgdmFsaWQgYXNzdW1wdGlvbj8gSWYg
c28sIFFFTVUgcGF0Y2hlcyBzaG91bGQgYmUgZml4ZWQuDQpJZiBub3QsIEkgZml4ZWQgdGhlIGlz
c3VlIGJ5IGNoYW5naW5nIG1hdGNoX2RpZSgpIHRvIGNoZWNrIGJvdGggcGh5c19wcm9jX2lkIGFu
ZCBjcHVfZGllX2lkOg0KDQpzdGF0aWMgYm9vbCBtYXRjaF9kaWUoc3RydWN0IGNwdWluZm9feDg2
ICpjLCBzdHJ1Y3QgY3B1aW5mb194ODYgKm8pIHsNCglpZiAoYy0+cGh5c19wcm9jX2lkID09IG8t
PnBoeXNfcHJvY19pZCAmJiBjLT5jcHVfZGllX2lkID09IG8tPmNwdV9kaWVfaWQpDQogCQlyZXR1
cm4gdHJ1ZTsNCglyZXR1cm4gZmFsc2U7DQp9DQoNClRoYW5rcw0KQnJpY2UNCg0KDQo=
