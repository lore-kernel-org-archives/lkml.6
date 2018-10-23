Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E069C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC086207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC086207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJXEFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:05:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47899 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725266AbeJXEFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:05:33 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9NJcaWV019858;
        Tue, 23 Oct 2018 21:40:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n7u8g3m1e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Oct 2018 21:40:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02ED534;
        Tue, 23 Oct 2018 19:40:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D711A5899;
        Tue, 23 Oct 2018 19:40:39 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Oct
 2018 21:40:39 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Tue, 23 Oct 2018 21:40:39 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v4 01/17] remoteproc: configure IOMMU only if device
 address requested
Thread-Topic: [PATCH v4 01/17] remoteproc: configure IOMMU only if device
 address requested
Thread-Index: AQHUJavck1XwVjelzEqQ/N6+FFsiGaUtfgKAgAA/deA=
Date:   Tue, 23 Oct 2018 19:40:39 +0000
Message-ID: <c23ecc9e33fd477c9afa03066b245644@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-2-git-send-email-loic.pallardy@st.com>
 <f6af2ded-dfcd-7cb9-6557-a17c40166836@ti.com>
In-Reply-To: <f6af2ded-dfcd-7cb9-6557-a17c40166836@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-23_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VtYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4g
QW5uYSA8cy1hbm5hQHRpLmNvbT4NCj4gU2VudDogbWFyZGkgMjMgb2N0b2JyZSAyMDE4IDE5OjI2
DQo+IFRvOiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFuZGVy
c3NvbkBsaW5hcm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90ZXBy
b2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBBcm5h
dWQgUE9VTElRVUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdhaWdu
YXJkQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMS8xN10gcmVtb3RlcHJv
YzogY29uZmlndXJlIElPTU1VIG9ubHkgaWYgZGV2aWNlDQo+IGFkZHJlc3MgcmVxdWVzdGVkDQo+
IA0KPiBIaSBMb2ljLA0KPiANCj4gT24gNy8yNy8xOCA4OjE0IEFNLCBMb2ljIFBhbGxhcmR5IHdy
b3RlOg0KPiA+IElmIHRoZXJlIGlzIG5vIElPTU1VIGFzc29jaWF0ZSB0byByZW1vdGUgcHJvY2Vz
c29yIGRldmljZSwNCj4gPiByZW1vdGVwcm9jX2NvcmUgd29uJ3QgYmUgYWJsZSB0byBzYXRpc2Z5
IGRldmljZSBhZGRyZXNzIHJlcXVlc3RlZA0KPiA+IGluIGZpcm13YXJlIHJlc291cmNlIHRhYmxl
Lg0KPiA+IFJldHVybiBhbiBlcnJvciBhcyBjb25maWd1cmF0aW9uIHdvbid0IGJlIGNvaGVyZW50
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9pYyBQYWxsYXJkeSA8bG9pYy5wYWxsYXJkeUBz
dC5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGlzIGJyZWFraW5nIG15IERhdmluY2kgcGxhdGZvcm1z
LiBJdCBpcyBub3QgcmVhbGx5IHJlcXVpcmVkDQo+IHRoYXQgeW91IF9zaG91bGRfIGhhdmUgSU9N
TVVzIHdoZW4gYSB2YWxpZCBEQSBpcyBtZW50aW9uZWQuIFBsZWFzZSBzZWUNCj4gdGhlIGV4aXN0
aW5nIGRlc2NyaXB0aW9uIChwYXJhcyA0IGFuZCA1KSBvbiB0aGUgZndfcnNjX2NhcnZlb3V0DQo+
IGtlcm5lbGRvYyBpbiByZW1vdGVwcm9jLmggZmlsZS4NCg0KVGhhbmtzIGZvciBwb2ludGluZyB0
aGlzIGNvbW1lbnQuIEluZGVlZCBzTU1VIGlzIG5vdCBtYW5kYXRvcnksIGFuZCBhdCBmaXJzdCBz
aWdodCBJIGFncmVlIHdlIHNob3VsZCByZW1vdmUgdGhlIHJlc3RyaWN0aW9uIGludHJvZHVjZWQg
YnkgdGhlIHBhdGNoLg0KRHJpdmVyIHBvcnRpbmcgb24gdGhlIHNlcmllcyBzaG91bGQgYmUgZG9u
ZSBiZWZvcmUgYWRkaW5nIHRoaXMuDQo+IA0KPiBXZSBkbyBoYXZlIHBsYXRmb3JtcyB3aGVyZSB3
ZSBoYXZlIHNvbWUgaW50ZXJuYWwgc3ViLW1vZHVsZXMgd2l0aGluIHRoZQ0KPiByZW1vdGUgcHJv
Y2Vzc29yIHN1Yi1zeXN0ZW0gdGhhdCBwcm92aWRlcyBzb21lIGxpbmVhcg0KPiBhZGRyZXNzLXRy
YW5zbGF0aW9uIChtb3N0IGNvbW1vbiBjYXNlIHdpdGggMzItYml0IHByb2Nlc3NvcnMgc3VwcG9y
dGluZw0KPiA2NC1iaXQgYWRkcmVzc2VzKS4gQWxzbywgd2UgaGF2ZSBzb21lIHVwY29taW5nIFNv
Q3Mgd2hlcmUgd2UgaGF2ZSBhbg0KPiBNTVUNCj4gYnV0IGlzIG5vdCBwcm9ncmFtbWFibGUgYnkg
TGludXguDQo+IA0KPiBUaGVyZSBpcyBvbmUgY29tbWVudCB0aGVyZSwgYnV0IEkgZG9uJ3QgdGhp
bmsgdGhpcyBpcyBhY3R1YWxseSBoYW5kbGVkDQo+IGluIHRoZSBjdXJyZW50IHJlbW90ZXByb2Mg
Y29yZS4NCj4gIklmIEBkYSBpcyBzZXQgdG8NCj4gICogRldfUlNDX0FERFJfQU5ZLCB0aGVuIHRo
ZSBob3N0IHdpbGwgZHluYW1pY2FsbHkgYWxsb2NhdGUgaXQsIGFuZCB0aGVuDQo+ICAqIG92ZXJ3
cml0ZSBAZGEgd2l0aCB0aGUgZHluYW1pY2FsbHkgYWxsb2NhdGVkIGFkZHJlc3MuIg0KPiANCkkg
ZG9uJ3QgcmVtZW1iZXIgaXQgd2FzIGltcGxlbWVudGVkIGxpa2UgZGVzY3JpYmVkLg0KDQpJIGhh
dmUgcmVtYXJrcyBhYm91dCB0aGUgY29tbWVudDoNCiIqIFdlIHdpbGwgYWx3YXlzIHVzZSBAZGEg
dG8gbmVnb3RpYXRlIHRoZSBkZXZpY2UgYWRkcmVzc2VzLCBldmVuIGlmIGl0DQogKiBpc24ndCB1
c2luZyBhbiBpb21tdS4gSW4gdGhhdCBjYXNlLCB0aG91Z2gsIGl0IHdpbGwgb2J2aW91c2x5IGNv
bnRhaW4NCiAqIHBoeXNpY2FsIGFkZHJlc3Nlcy4iDQoNCldoZW4gdGhlcmUgaXMgbm8gc01NVSwg
d2UgY2FuJ3QgY29uc2lkZXIgdGhhdCBkYSBjb250YWlucyBhIHBoeXNpY2FsIGFkZHJlc3MgYmVj
YXVzZSBjb3Byb2Nlc3NvciBjYW4gaGF2ZSBpdHMgb3duIG1lbW9yeSBtYXAganVzdCBiZWNhdXNl
IGl0IGlzIGEgMzJiaXQgcHJvY2Vzc29yIGFjY2Vzc2luZyBvbmx5IGEgcGFydCBvZiB0aGUgbWVt
b3J5IGFuZCB0aGUgbWFpbiBpcyA2NGJpdCBvbmUuIFRoZSAyIHByb2Nlc3NvcnMgd29uJ3Qgc2Vl
IHRoZSBpbnRlcm5hbCBtZW1vcnkgYXQgdGhlIHNhbWUgYmFzZSBhZGRyZXNzIGZvciBleGFtcGxl
Lg0KDQpTbyB3aGF0IHNob3VsZCB3ZSBkbyB3aGVuIGNhcnZlb3V0IGFsbG9jYXRlZCBieSBob3N0
IGlzIG5vdCBmaXR0aW5nIHdpdGggcmVzb3VyY2UgdGFibGUgcmVxdWVzdD8NCi0gcHV0IGEgd2Fy
bmluZyBhbmQgb3ZlcndyaXRlIGRhIGFkZHJlc3MgaW4gdGhlIHJlc291cmNlIHRhYmxlPw0KLSBz
dG9wIHJwcm9jIHByb2JlIGFzIG5vIG1hdGNoIGRldGVjdGVkPw0KDQpMYXRlciBpbiB0aGUgc2Vy
aWVzLCBjYXJ2ZW91dCBhbGxvY2F0aW9uIGlzIGNoYW5nZWQuIFJlc291cmNlIHRhYmxlIGNhcnZl
b3V0IGFyZSBlaXRoZXIgbGlua2VkIHdpdGggYW4gZXhpc3RpbmcgY2FydmVvdXQgcmVnaXN0ZXJl
ZCBieSBkcml2ZXIgb3IgYWRkZWQgdG8gY2FydmVvdXQgbGlzdCBmb3IgYWxsb2NhdGlvbnMuDQpJ
biB0aGUgY2FzZSB5b3UgZGVzY3JpYmVkLCBUSSBkcml2ZXIgc2hvdWxkIGZpcnN0IHJlZ2lzdGVy
IHRoZSBzcGVjaWZpYyBjYXJ2ZW91dCByZWdpb25zIHRoYW5rIHRvIHRoZSBoZWxwZXIuDQoNClJl
Z2FyZHMsDQpMb2ljDQoNCj4gcmVnYXJkcw0KPiBTdW1hbg0KPiANCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jIHwgMTAgKysrKysrKysrLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jDQo+IGIvZHJp
dmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jDQo+ID4gaW5kZXggNGNkMWE4ZS4uNDM3
ZmFiZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3Jl
LmMNCj4gPiArKysgYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gPiBA
QCAtNjU3LDcgKzY1NywxNSBAQCBzdGF0aWMgaW50IHJwcm9jX2hhbmRsZV9jYXJ2ZW91dChzdHJ1
Y3QgcnByb2MNCj4gKnJwcm9jLA0KPiA+ICAJICogdG8gdXNlIHRoZSBpb21tdS1iYXNlZCBETUEg
QVBJOiB3ZSBleHBlY3QgJ2RtYScgdG8gY29udGFpbiB0aGUNCj4gPiAgCSAqIHBoeXNpY2FsIGFk
ZHJlc3MgaW4gdGhpcyBjYXNlLg0KPiA+ICAJICovDQo+ID4gLQlpZiAocnByb2MtPmRvbWFpbikg
ew0KPiA+ICsNCj4gPiArCWlmIChyc2MtPmRhICE9IEZXX1JTQ19BRERSX0FOWSAmJiAhcnByb2Mt
PmRvbWFpbikgew0KPiA+ICsJCWRldl9lcnIoZGV2LT5wYXJlbnQsDQo+ID4gKwkJCSJCYWQgY2Fy
dmVvdXQgcnNjIGNvbmZpZ3VyYXRpb25cbiIpOw0KPiA+ICsJCXJldCA9IC1FTk9NRU07DQo+ID4g
KwkJZ290byBkbWFfZnJlZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAocnNjLT5kYSAhPSBG
V19SU0NfQUREUl9BTlkgJiYgcnByb2MtPmRvbWFpbikgew0KPiA+ICAJCW1hcHBpbmcgPSBremFs
bG9jKHNpemVvZigqbWFwcGluZyksIEdGUF9LRVJORUwpOw0KPiA+ICAJCWlmICghbWFwcGluZykg
ew0KPiA+ICAJCQlyZXQgPSAtRU5PTUVNOw0KPiA+DQoNCg==
