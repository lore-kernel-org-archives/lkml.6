Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C7DE606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFFS12 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:27:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:25084 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbeFFS11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:27:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="205877205"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] x86/vdso: Move out the CPU number store
Thread-Topic: [PATCH v2 8/8] x86/vdso: Move out the CPU number store
Thread-Index: AQHT/bLMYx8EjGCUCUKH/sMAu+9L7aRT39mA//+cAAA=
Date: Wed, 6 Jun 2018 18:27:21 +0000
Message-ID: <1D572EBD-5B82-4828-AE3E-8CB9E1FA054E@intel.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
 <1528302199-29619-9-git-send-email-chang.seok.bae@intel.com>
 <CALCETrVkFvC4R6dfrUL5B9iN1v3X6hE3QNHBrAHjPBrA9S7FWg@mail.gmail.com>
In-Reply-To: <CALCETrVkFvC4R6dfrUL5B9iN1v3X6hE3QNHBrAHjPBrA9S7FWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.1.180523
x-originating-ip: [10.254.13.187]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9614E037F86A8343A98B824D91E54C36@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gNiwgMjAxOCBhdCAxMDoyNSBBTSBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IE9uIFdlZCwgSnVuIDYsIDIwMTggYXQgOToyMyBBTSBDaGFuZyBT
LiBCYWUgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhlIENQVSAo
YW5kIG5vZGUpIG51bWJlciB3aWxsIGJlIHdyaXR0ZW4sIGFzIGVhcmx5IGVub3VnaCwNCj4+IHRv
IHRoZSBzZWdtZW50IGxpbWl0IG9mIHBlciBDUFUgZGF0YSBhbmQgVFNDX0FVWCBNU1IgZW50cnku
DQo+PiBUaGUgaW5mb3JtYXRpb24gaGFzIGJlZW4gcmV0cmlldmVkIGJ5IHZnZXRjcHUgaW4gdXNl
ciBzcGFjZQ0KPj4gYW5kIHdpbGwgYmUgYWxzbyBsb2FkZWQgZnJvbSB0aGUgcGFyYW5vaWQgZW50
cnksIHdoZW4NCj4+IEZTR1NCQVNFIGVuYWJsZWQuIFNvLCBpdCBpcyBtb3ZlZCBvdXQgZnJvbSB2
RFNPIHRvIHRoZSBDUFUNCj4+IGluaXRpYWxpemF0aW9uIHBhdGggd2hlcmUgSVNUIHNldHVwIGlz
IHNlcmlhbGl6ZWQuDQo+Pg0KPiBQbGVhc2Ugc3BsaXQgdGhpcyBpbnRvIHR3byBwYXRjaGVzLiAg
T25lIHBhdGNoIHNob3VsZCBkbyB0aGUgY2xlYW51cHMNCj4gYW5kIG9uZSBwYXRjaCBzaG91bGQg
bW92ZSB0aGUgY29kZS4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZnZXRj
cHUuYyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmdldGNwdS5jDQo+PiBpbmRleCA4ZWMzZDFmLi4z
Mjg0MDY5IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvZW50cnkvdmRzby92Z2V0Y3B1LmMNCj4+
ICsrKyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmdldGNwdS5jDQo+PiBAQCAtMTgsOSArMTgsOSBA
QCBfX3Zkc29fZ2V0Y3B1KHVuc2lnbmVkICpjcHUsIHVuc2lnbmVkICpub2RlLCBzdHJ1Y3QgZ2V0
Y3B1X2NhY2hlICp1bnVzZWQpDQo+PiAgICAgICAgIHAgPSBfX2dldGNwdSgpOw0KPj4NCj4+ICAg
ICAgICAgaWYgKGNwdSkNCj4+IC0gICAgICAgICAgICAgICAqY3B1ID0gcCAmIFZHRVRDUFVfQ1BV
X01BU0s7DQo+PiArICAgICAgICAgICAgICAgKmNwdSA9IGxzbF90c2NwX3RvX2NwdShwKTsNCj4+
ICAgICAgICAgaWYgKG5vZGUpDQo+PiAtICAgICAgICAgICAgICAgKm5vZGUgPSBwID4+IDEyOw0K
Pj4gKyAgICAgICAgICAgICAgICpub2RlID0gbHNsX3RzY3BfdG9fbm9kZShwKTsNCj4+ICAgICAg
ICAgcmV0dXJuIDA7DQo+IFRoaXMgZ29lcyBpbiB0aGUgY2xlYW51cCBwYXRjaC4NCj4+ICsvKiBC
aXQgc2l6ZSBhbmQgbWFzayBvZiBDUFUgbnVtYmVyIHN0b3JlZCBpbiB0aGUgcGVyIENQVSBkYXRh
IChhbmQgVFNDX0FVWCkgKi8NCj4+ICsjZGVmaW5lIExTTF9UU0NQX0NQVV9TSVpFICAgICAgICAg
ICAgICAxMg0KPj4gKyNkZWZpbmUgTFNMX1RTQ1BfQ1BVX01BU0sgICAgICAgICAgICAgIDB4ZmZm
DQo+PiArDQo+PiArI2lmbmRlZiBfX0FTU0VNQkxZX18NCj4+ICsNCj4+ICsvKiBIZWxwZXIgZnVu
Y3Rpb25zIHRvIHN0b3JlL2xvYWQgQ1BVIGFuZCBub2RlIG51bWJlcnMgKi8NCj4+ICsNCj4+ICtz
dGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgbWFrZV9sc2xfdHNjcChpbnQgY3B1LCB1bnNpZ25l
ZCBsb25nIG5vZGUpDQo+PiArew0KPj4gKyAgICAgICByZXR1cm4gKChub2RlIDw8IExTTF9UU0NQ
X0NQVV9TSVpFKSB8IGNwdSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWdu
ZWQgaW50IGxzbF90c2NwX3RvX2NwdSh1bnNpZ25lZCBsb25nIHgpDQo+PiArew0KPj4gKyAgICAg
ICByZXR1cm4gKHggJiBMU0xfVFNDUF9DUFVfTUFTSyk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRp
YyBpbmxpbmUgdW5zaWduZWQgaW50IGxzbF90c2NwX3RvX25vZGUodW5zaWduZWQgbG9uZyB4KQ0K
Pj4gK3sNCj4+ICsgICAgICAgcmV0dXJuICh4ID4+IExTTF9UU0NQX0NQVV9TSVpFKTsNCj4+ICt9
DQo+IEFzIGRvIHRoZXNlLiAgQnV0IG1heWJlIHRoZXkgc2hvdWxkIGJlICNpZmRlZiBDT05GSUdf
WDg2XzY0IHRvIG1ha2UgaXQNCj4gY2xlYXIgdGhhdCB0aGV5IGFyZSBub3QgcHJlc2VudGx5IHN1
cHBvcnRlZCBvbiAzMi1iaXQgc3lzdGVtcy4NCj4gKFVubGVzcyBJJ20gd3JvbmcgYW5kIHRoZXkg
YXJlIHN1cHBvcnRlZC4pDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4+IGluZGV4IDM4Mjc2ZjUuLmM3
YjU0ZjAgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+PiBAQCAtMTY2NSw2ICsxNjY1LDEx
IEBAIHZvaWQgY3B1X2luaXQodm9pZCkNCj4+DQo+PiAgICAgICAgIHdybXNybChNU1JfRlNfQkFT
RSwgMCk7DQo+PiAgICAgICAgIHdybXNybChNU1JfS0VSTkVMX0dTX0JBU0UsIDApOw0KPj4gKyNp
ZmRlZiBDT05GSUdfTlVNQQ0KPj4gKyAgICAgICB3cml0ZV9yZHRzY3BfYXV4KG1ha2VfbHNsX3Rz
Y3AoY3B1LCBlYXJseV9jcHVfdG9fbm9kZShjcHUpKSk7DQo+PiArI2Vsc2UNCj4+ICsgICAgICAg
d3JpdGVfcmR0c2NwX2F1eChtYWtlX2xzbF90c2NwKGNwdSwgMCkpOw0KPj4gKyNlbmRpZg0KPiBX
aHkgdGhlIGlmZGVmPyAgZWFybHlfY3B1X3RvX25vZGUoKSBzaG91bGQgcmV0dXJuIDAgaWYgIUNP
TkZJR19OVU1BLg0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzZXR1cF9jcHVfbnVtYmVyX3NlZ21l
bnQoaW50IGNwdSkNCj4+ICt7DQo+PiArI2lmZGVmIENPTkZJR19OVU1BDQo+PiArICAgICAgIHVu
c2lnbmVkIGxvbmcgbm9kZSA9IGVhcmx5X2NwdV90b19ub2RlKGNwdSk7DQo+PiArI2Vsc2UNCj4+
ICsgICAgICAgdW5zaWduZWQgbG9uZyBub2RlID0gMDsNCj4+ICsjZW5kaWYNCj4gVGhpcyBkdXBs
aWNhdGVzIGhhbGYgdGhlIHJkdHNjcF9hdXggY29kZS4gIEhvdyBhYm91dCBtYWtpbmcgdGhpcyBv
bmUNCj4gZnVuY3Rpb24gc2V0dXBfY3B1X251bWJlcigpIHRoYXQgZG9lcyBhbGwgb2YgaXQ/DQo+
PiArICAgICAgIHN0cnVjdCBkZXNjX3N0cnVjdCBkID0gR0RUX0VOVFJZX0lOSVQoMHg0MGY1LCAw
eDAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICBtYWtlX2xzbF90c2NwKGNwdSwgbm9k
ZSkpOw0KPiBQbGVhc2UgZ2V0IHJpZCBvZiB0aGUgR0RUX0VOVFJZX0lOSVQgc3R1ZmYgYW5kIGp1
c3QgZmlsbCBvdXQgYWxsIHRoZQ0KPiBmaWVsZHMsIGp1c3QgbGlrZSBpdCBpcyBpbiB0aGUgY29k
ZSB0aGF0IHlvdSdyZSBtb3ZpbmcuICBObyBvbmUgZW5qb3lzDQo+IGRlY29kaW5nIGhleCBzZWdt
ZW50IGRlc2NyaXB0b3JzLiAgKFdlbGwsIExpbnVzIGFuZCBocGEgcHJvYmFibHkNCj4gKmxvdmUq
IGRvaW5nIGl0IGp1c3QgdG8gc2hvdyBvZmYuKQ0KDQpXaWxsIGFwcGx5IGFzIHdoYXQgeW91IGNv
bW1lbnRlZC4NCg0KVGhhbmtzDQpDaGFuZw0KDQo=
