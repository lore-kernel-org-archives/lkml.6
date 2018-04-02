Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4066542-1522708222-2-12502358305488481146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522708221; b=RuRGApncwrW8+nWcvYBOjjo4IuY6nzEiRzuL2M3ptLavnreMip
    wbBZYYCcGQBp3A+mUwqQKojMDJor280AHIQYh9PU7KUSqLP6pjW0dm6QzOjfff8b
    uGsOeuU72RO8i0rD7pZjyXQjoe2hJ3sPiCaH5ZezKuIRp71X36H6QZPg7BbC0IGh
    mO7VQC1NGZDuXQcXrQoSguQF2JMTn2Oo46+ETIYdVtl8kKjqVpXnhpLeKz1oUkgp
    ZYFOVqkUoX9SptZSDLg/daiL01foosJAjt1xuaW55T8f9Vy+IbL3b8dKjYOvGRGj
    KFaJOzADoGTP8QcleMsG4obMtZ4vDcPxqipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522708221; bh=KMnLnujoAIsNLD/I/aD7HCNnxyYk2Qxg7EgCWM263E0=; b=
    NKNbpkFYTsEV2UU1uf7k4gM3E5PkLvbyFwuKJPIMgwcvhmVdZFVDL0OddnhAbopA
    MfqnBquV7s+Qboa/OzMF/HpzFAh2bNguWu8NDJV0L11KKwmDoKULF46KNv9ORw1o
    ChT/OdD42Pe6X3TWzBaCb50qYBxSAmchcVScDSOo5EO75yGvfIOflDsyRMcotg1O
    QAh8E3Z1a4UG2O56useJ3O8/NZsLm5i4fLNUMCCgdDmmTXzqyt/s4Fgcr+ooSG8R
    SebiQNzPscxxSeisPmtNWE0Ny9vZQhV3TSpz1vhpVay3d5BnhqmECDvZv4Jvedr8
    8x4h3S60JqVEcFaUKVqTrg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKWDu53OP7bqWhOXeIaWcsRIvjMTjtVrs7lyelLqSFEaC/5EygtYurK6VUtzKyglghjR+vjQu9Y0jVv3oJXtRZ/VgI4Sr1NLYPaMqn8FAaMjjkBk7h1x
    KQqhfFan60n74FL4+Zo/LRaVL4bAKbAjEcnAhKHXG0wnz1oY7AC9NzJsdwEkgUXp2FQ9BUPyunnYzgBIaVe357FAeaLkiEKBWqNr8yK8dUYit0M/n2w6VOaQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=J1NWn22cQj0A:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=67ItXobqrRmG5zamyXQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeDBWaS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 18:30:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:34633 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754457AbeDBWaS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 18:30:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,397,1517904000";
   d="scan'208";a="30172958"
From: "Pandiyan, Dhinakaran" <dhinakaran.pandiyan@intel.com>
To: "lyude@redhat.com" <lyude@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] i915/dp_mst: Keep AUX block running when disabling DPMS
Thread-Topic: [PATCH] i915/dp_mst: Keep AUX block running when disabling DPMS
Thread-Index: AQHTysirMYufonocYUqvhybcy2dpS6PuivoA
Date: Mon, 2 Apr 2018 22:30:16 +0000
Message-ID: <1522709688.10101.30.camel@dk-H97M-D3H>
References: <20180402212142.19841-1-lyude@redhat.com>
In-Reply-To: <20180402212142.19841-1-lyude@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.17]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C05622EC5B2C0A4DB321FC264264453E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCg0KT24gTW9uLCAyMDE4LTA0LTAyIGF0IDE3OjIxIC0wNDAwLCBMeXVkZSBQYXVsIHdyb3Rl
Og0KPiBXaGlsZSBlbmFibGluZy9kaXNhYmxpbmcgRFBNUyBiZWZvcmUgbGluayB0cmFpbmluZyB3
aXRoIE1TVCBodWJzIGlzDQo+IHBlcmZlY3RseSB2YWxpZDsgdW5mb3J0dW5hdGVseSBkaXNhYmxp
bmcgRFBNUyByZXN1bHRzIGluIHNvbWUgZGV2aWNlcw0KPiBkaXNhYmxpbmcgdGhlaXIgQVVYIENI
IGJsb2NrIGFzIHdlbGwuIEZvciBTU1QgdGhpcyBpc24ndCBhcyBtdWNoIG9mIGENCj4gcHJvYmxl
bSwgYnV0IGZvciBNU1Qgd2UgbmVlZCB0byBiZSBhYmxlIHRvIGNvbnRpbnVlIGhhbmRsaW5nIGF1
eA0KPiB0cmFuc2FjdGlvbnMgZXZlbiB3aGVuIG5vbmUgb2YgdGhlIHNpbmtzIGFyZSB0dXJuZWQg
b24gc2luY2UgaXQncw0KPiBwb3NzaWJsZSBmb3IgdXMgdG8gaGF2ZSBhIHNpbmdsZSBhdG9taWMg
Y29tbWl0IHdoaWNoIHJlc3VsdHMgaW4NCj4gZGlzYWJsaW5nIGVhY2ggZG93bnN0cmVhbSBzaW5r
LCBmb2xsb3dlZCBieSBzdWJzZXF1ZW50bHkgcmUtZW5hYmxpbmcNCj4gZWFjaCBzaW5rLg0KPiAN
Cj4gSWYgd2UgZG9uJ3QgZG8gdGhpcywgd2UnbGwgZW5kIHVwIHN0YWxsaW5nIGFueSBwZW5kaW5n
IEVTSSBpbnRlcnJ1cHRzDQo+IGZyb20gdGhlIHNpbmsgZm9yIHVwIHRvIDFtcy4gVW5mb3J0dW5h
dGVseSwgZHJvcHBpbmcgRVNJcyBkdXJpbmcgdGhpcw0KPiB0aW1lc3BhbiBtYWtlcyBpdCBzbyB0
aGF0IGxpbmsgZmFsbGJhY2sgcmV0cmFpbmluZyBmb3IgTVNUICh3aGljaCBJIHdpbGwNCj4gYmUg
c3VibWl0dGluZyB0byB0aGUgTUwgc2hvcnRseSkgZmFpbHMgZHVlIHRvIHRoZSBjaGFubmVsIEVR
IGZhaWx1cmUNCj4gaW50ZXJydXB0cyBwb3RlbnRpYWxseSBnZXR0aW5nIGRyb3BwZWQuIEFkZGl0
aW9uYWxseSwgd2hlbiBwZXJmb3JtaW5nIGENCj4gbW9kZXNldCB0aGF0IGJyaW5ncyB0aGUgaHVi
IHN0YXR1cydzIGxpbmsgc3RhdHVzIGZyb20gYmFkIC0+IGdvb2QgaGF2aW5nDQo+IEVTSXMgZGlz
YWJsZWQgZm9yIHRoYXQgbG9uZyBjYXVzZXMgdXMgdG8gbWlzcyB0aGUgaHViJ3MgcmVzcG9uc2Ug
dG8gdXMNCj4gdHJ5aW5nIHRvIHN0YXJ0IGxpbmsgdHJhaW5pbmcgYXMgd2VsbC4NCj4gDQo+IFNp
bmNlIGFueSBzaW5rIHdpdGggTVNUIGlzIGdvaW5nIHRvIHN1cHBvcnQgRGlzcGxheVBvcnQgMS4y
IGFueXdheSwgc2F2ZQ0KPiB1cyB0aGUgaGFzc2xlIG9mIHRyeWluZyB0byB3YWl0IHVudGlsIHRo
ZSBzaW5rIGNvbWVzIGJhY2sgdXAgYW5kIGp1c3QNCj4gbmV2ZXIgc2h1dCB0aGUgYXV4IGJsb2Nr
IGRvd24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29t
Pg0KPiBDYzogTGF1cmEgQWJib3R0IDxsYWJib3R0QHJlZGhhdC5jb20+DQo+IENjOiBEaGluYWth
cmFuIFBhbmRpeWFuIDxkaGluYWthcmFuLnBhbmRpeWFuQGludGVsLmNvbT4NCj4gQ2M6IFZpbGxl
IFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiBhZDI2MGFiMzJhNGQ5ICgiZHJtL2k5MTUvZHA6IFdy
aXRlIHRvIFNFVF9QT1dFUiBkcGNkIHRvIGVuYWJsZSBNU1QgaHViLiIpDQoNCldlJ3ZlIGNvbWUg
YSBmdWxsIGNpcmNsZSBvbiB0aGlzIG9uZSA6KQ0KDQoxKSBPcmlnaW5hbGx5LCB3ZSBoYWQgZGlz
YWJsZV9kZGkoKSBzZXR0aW5nIHRoZSBicmFuY2ggcG93ZXIgc3RhdGUgdG8NCkQzLg0KMikgVGhl
biAiVXNlIE1TVCBzaWRlYmFuZCBtZXNzYWdlIHRyYW5zYWN0aW9ucyBmb3IgZHBtcyBjb250cm9s
IiByZW1vdmVkDQp0aGF0IGFzIGEgYnVnIGZpeCBmb3Igc29tZSBkZXZpY2VzLiBUaGUgc2lkZWJh
bmQgc29sdXRpb24gd2FzIGNob3Nlbg0Kb3ZlciB0aGUgRDNfQVVYX09OIGFwcHJvYWNoIHRoaXMg
cGF0Y2ggdGFrZXMuDQozKSBOZXh0LCAiV3JpdGUgdG8gU0VUX1BPV0VSIGRwY2QgdG8gZW5hYmxl
IE1TVCBodWIiIGVmZmVjdGl2ZWx5IHRvb2sgdXMNCmJhY2sgdG8gdGhlIG9yaWdpbmFsIHN0YXRl
IGR1ZSB0byBhIHJlZ3Jlc3Npb24uDQo0KSBOb3csIHdlIGFyZSBjYWxsaW5nICgzKSBhIHJlZ3Jl
c3Npb24gYW5kIGltcGxlbWVudGluZyBEM19BVVhfT04uDQoNCg0KSSBndWVzcywgdGhpcyBjb21i
aW5hdGlvbiBzaG91bGQgd29yayBmb3IgbW9zdCBkZXZpY2VzLiBCdXQsIHdlIHNob3VsZA0KdGVz
dCB0aGlzIG9uIGEgZmV3IGRpZmZlcmVudCBNU1QgaHVicyBiZWZvcmUgZ29pbmcgYWhlYWQuDQoN
Ci1ESw0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kcC5jIHwgNiAr
KysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RwLmMNCj4gaW5kZXggNjJmODJjNDI5OGFjLi4wNDc5
YzM3Nzk4MWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RwLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHAuYw0KPiBAQCAtMjU4OSwxMSAr
MjU4OSwxMyBAQCB2b2lkIGludGVsX2RwX3NpbmtfZHBtcyhzdHJ1Y3QgaW50ZWxfZHAgKmludGVs
X2RwLCBpbnQgbW9kZSkNCj4gIAkJcmV0dXJuOw0KPiAgDQo+ICAJaWYgKG1vZGUgIT0gRFJNX01P
REVfRFBNU19PTikgew0KPiArCQl1bnNpZ25lZCBjaGFyIGRhdGEgPSBpbnRlbF9kcC0+aXNfbXN0
ID8NCj4gKwkJCURQX1NFVF9QT1dFUl9EM19BVVhfT04gOiBEUF9TRVRfUE9XRVJfRDM7DQo+ICsN
Cj4gIAkJaWYgKGRvd25zdHJlYW1faHBkX25lZWRzX2QwKGludGVsX2RwKSkNCj4gIAkJCXJldHVy
bjsNCj4gIA0KPiAtCQlyZXQgPSBkcm1fZHBfZHBjZF93cml0ZWIoJmludGVsX2RwLT5hdXgsIERQ
X1NFVF9QT1dFUiwNCj4gLQkJCQkJIERQX1NFVF9QT1dFUl9EMyk7DQo+ICsJCXJldCA9IGRybV9k
cF9kcGNkX3dyaXRlYigmaW50ZWxfZHAtPmF1eCwgRFBfU0VUX1BPV0VSLCBkYXRhKTsNCj4gIAl9
IGVsc2Ugew0KPiAgCQlzdHJ1Y3QgaW50ZWxfbHNwY29uICpsc3Bjb24gPSBkcF90b19sc3Bjb24o
aW50ZWxfZHApOw0KPiAgDQo=
