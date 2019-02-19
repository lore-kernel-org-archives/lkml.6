Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0972521479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfBSSn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:43:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:3335 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfBSSnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:43:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 10:43:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="144791494"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2019 10:43:55 -0800
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.212]) by
 fmsmsx104.amr.corp.intel.com ([169.254.3.27]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 10:43:54 -0800
From:   "Brown, Len" <len.brown@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Len Brown <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 05/11] x86 topology: export die_siblings
Thread-Topic: [PATCH 05/11] x86 topology: export die_siblings
Thread-Index: AQHUyHQp/4DC6RHerUacd/UcWcTzV6XnbFLg
Date:   Tue, 19 Feb 2019 18:43:54 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9485C5B75B9@FMSMSX126.amr.corp.intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <0d54a56186fb9be7a8f622a4625a41dc600dd7a4.1550545163.git.len.brown@intel.com>
 <59e07a24-dc44-c21b-91d4-ea04e8d0653e@linux.intel.com>
In-Reply-To: <59e07a24-dc44-c21b-91d4-ea04e8d0653e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjZjZGNkZmItZWExYy00MzhjLThlNDctNjNiNmNhY2I5MjliIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOVhnUWMrVU1Ibk9MWExrbHhMeTd4ZVI4YTNhYU1OXC9sQTBYRCtDMXBXcEhvajEreXhmZEk3WWJoQXl2UGxyakgifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgY29tbWVudHMsIEthbiwNCg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vY3B1dG9wb2xvZ3kudHh0IA0KPj4gYi9Eb2N1bWVudGF0aW9uL2NwdXRvcG9sb2d5LnR4
dCBpbmRleCAyODcyMTNiNDUxN2IuLjdkZDJhZTNkZjIzMyANCj4+IDEwMDY0NA0KPj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9jcHV0b3BvbG9neS50eHQNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vY3B1
dG9wb2xvZ3kudHh0DQo+PiBAQCAtNTYsNiArNTYsMTYgQEAgY29yZV9zaWJsaW5nc19saXN0Og0K
Pj4gICAJaHVtYW4tcmVhZGFibGUgbGlzdCBvZiBjcHVYJ3MgaGFyZHdhcmUgdGhyZWFkcyB3aXRo
aW4gdGhlIHNhbWUNCj4+ICAgCWRpZV9pZC4NCj4+ICAgDQo+PiArZGllX3NpYmxpbmdzOg0KPj4g
Kw0KPj4gKwlpbnRlcm5hbCBrZXJuZWwgbWFwIG9mIGNwdVgncyBoYXJkd2FyZSB0aHJlYWRzIHdp
dGhpbiB0aGUgc2FtZQ0KPj4gKwlwaHlzaWNhbF9wYWNrYWdlX2lkLg0KPj4gKw0KPj4gK2RpZV9z
aWJsaW5nc19saXN0Og0KPj4gKw0KPj4gKwlodW1hbi1yZWFkYWJsZSBsaXN0IG9mIGNwdVgncyBo
YXJkd2FyZSB0aHJlYWRzIHdpdGhpbiB0aGUgc2FtZQ0KPj4gKwlwaHlzaWNhbF9wYWNrYWdlX2lk
Lg0KPj4gKw0KPj4gICBib29rX3NpYmxpbmdzOg0KPj4gICANCj4+ICAgCWludGVybmFsIGtlcm5l
bCBtYXAgb2YgY3B1WCdzIGhhcmR3YXJlIHRocmVhZHMgd2l0aGluIHRoZSBzYW1lIGRpZmYgDQoN
Cj4gQ291bGQgeW91IHBsZWFzZSB1cGRhdGUgdGhlIGRvY3VtZW50IHJlZ2FyZGluZyB0byB0b3Bv
bG9neV9kaWVfY3B1bWFzayBhbmQgdG9wb2xvZ3lfY29yZV9jcHVtYXNrIGluIERvY3VtZW50YXRp
b24veDg2L3RvcG9sb2d5LnR4dA0KIA0KSSBhZ3JlZSB0aGF0IHRoZSB0b3AgcGFydCBvZiB0aGlz
IGZpbGUsIGFzIHVwZGF0ZWQgYWJvdmUsIHNob3VsZCBkb2N1bWVudCB0aGUgZXh0ZXJuYWwgc3lz
ZnMgaW50ZXJmYWNlLi4uDQoNCkknbSBsZXNzIGV4Y2l0ZWQgYWJvdXQgdGhlIGNlbnRlciBvZiB0
aGUgZmlsZSB0cnlpbmcgdG8gZG9jdW1lbnQgdGhlIGludGVybmFsIGltcGxlbWVudGF0aW9uIC0t
IGFzIHRoZSBzb3VyY2UgY29kZQ0KaXMgYWN0dWFsbHkgbW9yZSBjbGVhciB0aGFuIHRoZSBkb2N1
bWVudCwgYnV0IGhlcmUgaXMgYW4gdXBkYXRlLCBjb25zaXN0ZW50IHdpdGggdGhlIGV4aXN0aW5n
IGZpbGUuDQpMZXQgbWUga25vdyBpZiBpdCBkb2VzIG5vdCBmdWxseSBhZGRyZXNzIHlvdXIgY29t
bWVudC4NCg0KVGhhbmtzLA0KLUxlbg0KLS0tDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2NwdXRvcG9sb2d5LnR4dCBiL0RvY3VtZW50YXRpb24vY3B1dG9wb2xvZ3kudHh0DQppbmRleCA3
ZGQyYWUzLi5mMzljNzU5IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9jcHV0b3BvbG9neS50
eHQNCisrKyBiL0RvY3VtZW50YXRpb24vY3B1dG9wb2xvZ3kudHh0DQpAQCAtMTAyLDYgKzEwMiw3
IEBAIHRoZXNlIG1hY3JvcyBpbiBpbmNsdWRlL2FzbS1YWFgvdG9wb2xvZ3kuaDo6DQogICAgICAg
ICNkZWZpbmUgdG9wb2xvZ3lfZHJhd2VyX2lkKGNwdSkNCiAgICAgICAgI2RlZmluZSB0b3BvbG9n
eV9zaWJsaW5nX2NwdW1hc2soY3B1KQ0KICAgICAgICAjZGVmaW5lIHRvcG9sb2d5X2NvcmVfY3B1
bWFzayhjcHUpDQorICAgICAgICNkZWZpbmUgdG9wb2xvZ3lfZGllX2NwdW1hc2soY3B1KQ0KICAg
ICAgICAjZGVmaW5lIHRvcG9sb2d5X2Jvb2tfY3B1bWFzayhjcHUpDQogICAgICAgICNkZWZpbmUg
dG9wb2xvZ3lfZHJhd2VyX2NwdW1hc2soY3B1KQ0KDQpAQCAtMTE0LDEwICsxMTUsMTEgQEAgVG8g
YmUgY29uc2lzdGVudCBvbiBhbGwgYXJjaGl0ZWN0dXJlcywgaW5jbHVkZS9saW51eC90b3BvbG9n
eS5oDQogcHJvdmlkZXMgZGVmYXVsdCBkZWZpbml0aW9ucyBmb3IgYW55IG9mIHRoZSBhYm92ZSBt
YWNyb3MgdGhhdCBhcmUNCiBub3QgZGVmaW5lZCBieSBpbmNsdWRlL2FzbS1YWFgvdG9wb2xvZ3ku
aDoNCg0KLTEpIHBoeXNpY2FsX3BhY2thZ2VfaWQ6IC0xDQotMikgY29yZV9pZDogMA0KLTMpIHNp
YmxpbmdfY3B1bWFzazoganVzdCB0aGUgZ2l2ZW4gQ1BVDQotNCkgY29yZV9jcHVtYXNrOiBqdXN0
IHRoZSBnaXZlbiBDUFUNCisxKSB0b3BvbG9neV9waHlzaWNhbF9wYWNrYWdlX2lkOiAtMQ0KKzIp
IHRvcG9sb2d5X2NvcmVfaWQ6IDANCiszKSB0b3BvbG9neV9zaWJsaW5nX2NwdW1hc2s6IGp1c3Qg
dGhlIGdpdmVuIENQVQ0KKzQpIHRvcG9sb2d5X2NvcmVfY3B1bWFzazoganVzdCB0aGUgZ2l2ZW4g
Q1BVDQorNSkgdG9wb2xvZ3lfZGllX2NwdW1hc2s6IGp1c3QgdGhlIGdpdmVuIENQVQ0KDQogRm9y
IGFyY2hpdGVjdHVyZXMgdGhhdCBkb24ndCBzdXBwb3J0IGJvb2tzIChDT05GSUdfU0NIRURfQk9P
SykgdGhlcmUgYXJlIG5vDQogZGVmYXVsdCBkZWZpbml0aW9ucyBmb3IgdG9wb2xvZ3lfYm9va19p
ZCgpIGFuZCB0b3BvbG9neV9ib29rX2NwdW1hc2soKS4NCg0KDQo=
