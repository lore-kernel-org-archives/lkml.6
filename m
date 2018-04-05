Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3756588-1522961485-2-9701440144403018878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522961485; b=MHZr2JQbBeKFA0uYef6vyiDt+BJVdslWgJ6fjs9cPIcKIOSPD9
    8rdxQY/TjBo9CJogUUMjvzoluBBy6oeXBIOR3u3VkhPa5tIBkbiYICqrgBqw0qLC
    3Mn5J1sldXlCEgbOaLvCWZL3YFDBAC6rAfbwnNLnV42T/8v4cDvOabzW4GPR1xYK
    ZW2ds23vYjhKZkv/Uc/hFxPX7i9NB1Yyop3gje5t3WTBto3xXbmojSm8c+3AHMom
    WhidhuJwgDUPoQd6mDxAiNAphsSu1L46H+5L/8RiKmmDu+rPQsUz7LJi3WS7Gf+p
    zEN3yKhvH3JFEHHFZWDUfci1hZqcGWW1I+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522961485; bh=xkh9WbKy06JfqGdqfYLsAGUHI7snYQIoa9SNKhAZza8=; b=
    pPu4sxIsvTWdatma+abmUTx4ztnCLUapMFINFj3LTcrJPvCdAyFInukH5WiMDdds
    6jH9skQPFOphe4jzDlwraLMac/HZ2gqr7R9wxHE3vJynS0lrbnVP2Mm6KIgBMVvw
    sAQYy7KmON6f7w5oTYfO93ZSEQKUPlPh/kpCaqV/+oqKvgK3gnl00qBUQOO8lnro
    pnCaDOs6ktD1tOx4PzRF56ZWEtIBwg/d3o29snM+PDKPHZ4hND3cdwcBZKmgSYPY
    XWahZieW1JRY36OAGp0WUervYcmU8v02fCtpH6N6APLSeuDfDSfidsx3t1pizLoF
    oDPMBVbj+sy97MliSG4JOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNJOrBmW9DnTfrQprBqdjhYqZNwbUHgM5ucmtkiLO4bKq09rpKmXC/5dtwIMWrHlTqBUHeya3pqgD0jZUPEsNhgKddoaWe6+V/xfCjxpVdKZ5ljz5cAk
    b/YZjps2eQ+w9KVZvesnIqKFQzVMhzZHIHlGKu31i6yU/c/j4ZAnZfiutSiLDqPwSR4DpjVAOnAR7zs1vw/EZX/hVnAKTqhIP1J4K9vU7RBexYh98tIJ0N1L
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=J1NWn22cQj0A:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=NTfZxkeiJG3UAG_HXy8A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDEUvW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 16:51:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:31072 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbeDEUvV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 16:51:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,412,1517904000";
   d="scan'208";a="214275950"
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
Subject: Re: [PATCH v2] drm/i915/dp: Send DPCD ON for MST before phy_up
Thread-Topic: [PATCH v2] drm/i915/dp: Send DPCD ON for MST before phy_up
Thread-Index: AQHTzR2+J4wyIPMXgE+y3+d6rvHWe6PzIZcA
Date: Thu, 5 Apr 2018 20:51:20 +0000
Message-ID: <1522962936.2418.21.camel@dk-H97M-D3H>
References: <20180405203601.23242-1-lyude@redhat.com>
In-Reply-To: <20180405203601.23242-1-lyude@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.17]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0FF6FB3EC8FD147B4A3186C5E14E694@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCg0KT24gVGh1LCAyMDE4LTA0LTA1IGF0IDE2OjM2IC0wNDAwLCBMeXVkZSBQYXVsIHdyb3Rl
Og0KPiBXaGVuIGRvaW5nIGEgbW9kZXNldCB3aGVyZSB0aGUgc2luayBpcyB0cmFuc2l0aW9uaW5n
IGZyb20gRDMgdG8gRDAgLCBpdA0KPiB3b3VsZCBzb21ldGltZXMgYmUgcG9zc2libGUgZm9yIHRo
ZSBpbml0aWFsIHBvd2VyX3VwX3BoeSgpIHRvIHN0YXJ0DQo+IHRpbWluZyBvdXQuIFRoaXMgd291
bGQgb25seSBiZSBvYnNlcnZlZCBpbiB0aGUgbGFzdCBhY3Rpb24gYmVmb3JlIHRoZQ0KPiBzaW5r
IHdlbnQgaW50byBEMyBtb2RlIHdhcyBpbnRlbF9kcF9zaW5rX2RwbXMoRFJNX01PREVfRFBNU19P
RkYpLiBXZQ0KPiBvcmlnaW5hbGx5IHRob3VnaHQgdGhpcyBtaWdodCBiZSBhbiBpc3N1ZSB3aXRo
IHVzIGFjY2lkZW50YWxseSBzaHV0dGluZw0KPiBvZmYgdGhlIGF1eCBibG9jayB3aGVuIHB1dHRp
bmcgdGhlIHNpbmsgaW50byBEMywgYnV0IHNpbmNlIHRoZSBEUCBzcGVjDQo+IG1hbmRhdGVzIHRo
YXQgc2lua3MgbXVzdCB3YWtlIHVwIHdpdGhpbiAxbXMgd2hpbGUgd2UgaGF2ZSAxMDBtcyB0bw0K
PiByZXNwb25kIHRvIGFuIEVTSSBpcnEsIHRoaXMgZGlkbid0IHJlYWxseSBhZGQgdXAuIFR1cm5z
IG91dCB0aGF0IHRoZQ0KPiBwcm9ibGVtIGlzIG1vcmUgc3VidGxlIHRoZW4gdGhhdDoNCj4gDQo+
IEl0IHR1cm5zIG91dCB0aGF0IHRoZSB0aW1lb3V0IGlzIGZyb20gdXMgbm90IGVuYWJsaW5nIERQ
TVMgb24gdGhlIE1TVA0KPiBodWIgYmVmb3JlIGFjdHVhbGx5IHRyeWluZyB0byBpbml0aWF0ZSBz
aWRlYmFuZCBjb21tdW5pY2F0aW9ucy4gVGhpcw0KPiB3b3VsZCBjYXVzZSB0aGUgZmlyc3Qgc2lk
ZWJhbmQgY29tbXVuaWNhdGlvbiAocG93ZXJfdXBfcGh5KCkpLCB0byBzdGFydA0KPiB0aW1pbmcg
b3V0IGJlY2F1c2UgdGhlIHNpbmsgd2Fzbid0IHJlYWR5IHRvIHJlc3BvbmQuIEFmdGVyd2FyZHMs
IHdlDQo+IHdvdWxkIGNhbGwgaW50ZWxfZHBfc2lua19kcG1zKERSTV9NT0RFX0RQTVNfT04pIGlu
DQo+IGludGVsX2RkaV9wcmVfZW5hYmxlX2RwKCksIHdoaWNoIHdvdWxkIGFjdHVhbGx5IHJlc3Vs
dCBpbiB3YWtpbmcgdXAgdGhlDQo+IHNpbmsgc28gdGhhdCBzaWRlYmFuZCByZXF1ZXN0cyB3b3Vs
ZCB3b3JrIGFnYWluLg0KPiANCj4gU2luY2UgRFBNUyBpcyB3aGF0IGxldHMgdXMgYWN0dWFsbHkg
YnJpbmcgdGhlIGh1YiB1cCBpbnRvIGEgc3RhdGUgd2hlcmUNCj4gc2lkZWJhbmQgY29tbXVuaWNh
dGlvbnMgYmVjb21lIGZ1bmN0aW9uYWwgYWdhaW4sIHdlIGp1c3QgbmVlZCB0byBtYWtlDQo+IHN1
cmUgdG8gZW5hYmxlIERQTVMgb24gdGhlIGRpc3BsYXkgYmVmb3JlIGF0dGVtcHRpbmcgdG8gcGVy
Zm9ybSBzaWRlYmFuZA0KPiBjb21tdW5pY2F0aW9ucy4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6
DQo+IC0gUmVtb3ZlIGNvbW1lbnQgYWJvdmUgaWYgKCFpbnRlbF9kcC0+aXNfbXN0KSAtIHZzcnlq
YWxhDQo+IC0gTW92ZSBpbnRlbF9kcF9zaW5rX2RwbXMoKSBmb3IgTVNUIGludG8gaW50ZWxfZHBf
cG9zdF9kaXNhYmxlX21zdCgpIHRvDQo+ICAga2VlcCBlbmFibGUvZGlzYWJsZSBwYXRocyBzeW1t
ZXRyaWNhbA0KPiAtIEltcHJvdmUgY29tbWl0IG1lc3NhZ2UgLSBkaG5rcm4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+DQo+IENjOiBEaGluYWthcmFu
IFBhbmRpeWFuIDxkaGluYWthcmFuLnBhbmRpeWFuQGludGVsLmNvbT4NCj4gQ2M6IFZpbGxlIFN5
cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBMYXVyYSBBYmJv
dHQgPGxhYmJvdHRAcmVkaGF0LmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
Rml4ZXM6IGFkMjYwYWIzMmE0ZDkgKCJkcm0vaTkxNS9kcDogV3JpdGUgdG8gU0VUX1BPV0VSIGRw
Y2QgdG8gZW5hYmxlIE1TVCBodWIuIikNCj4gLS0tDQo+IFRoaXMgZW1haWwgc2hvdWxkIGhvcGVm
dWxseSBhY3R1YWxseSBiZSBwaWNrZWQgdXAgYnkgcGF0Y2h3b3JrIHRoaXMNCj4gdGltZSwgaG9v
cmF5IQ0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RkaS5jICAgIHwgNiArKysr
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RwX21zdC5jIHwgMiArKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZGRpLmMgYi9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9pbnRlbF9kZGkuYw0KPiBpbmRleCBhNjY3MmE5YWJkODUuLmMwYmY3NDE5ZTFjMSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZGRpLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZGRpLmMNCj4gQEAgLTIzMjQsNyArMjMyNCw4IEBA
IHN0YXRpYyB2b2lkIGludGVsX2RkaV9wcmVfZW5hYmxlX2RwKHN0cnVjdCBpbnRlbF9lbmNvZGVy
ICplbmNvZGVyLA0KPiAgCQlpbnRlbF9wcmVwYXJlX2RwX2RkaV9idWZmZXJzKGVuY29kZXIsIGNy
dGNfc3RhdGUpOw0KPiAgDQo+ICAJaW50ZWxfZGRpX2luaXRfZHBfYnVmX3JlZyhlbmNvZGVyKTsN
Cj4gLQlpbnRlbF9kcF9zaW5rX2RwbXMoaW50ZWxfZHAsIERSTV9NT0RFX0RQTVNfT04pOw0KPiAr
CWlmICghaW50ZWxfZHAtPmlzX21zdCkNCj4gKwkJaW50ZWxfZHBfc2lua19kcG1zKGludGVsX2Rw
LCBEUk1fTU9ERV9EUE1TX09OKTsNCj4gIAlpbnRlbF9kcF9zdGFydF9saW5rX3RyYWluKGludGVs
X2RwKTsNCj4gIAlpZiAocG9ydCAhPSBQT1JUX0EgfHwgSU5URUxfR0VOKGRldl9wcml2KSA+PSA5
KQ0KPiAgCQlpbnRlbF9kcF9zdG9wX2xpbmtfdHJhaW4oaW50ZWxfZHApOw0KPiBAQCAtMjQyNyw3
ICsyNDI4LDggQEAgc3RhdGljIHZvaWQgaW50ZWxfZGRpX3Bvc3RfZGlzYWJsZV9kcChzdHJ1Y3Qg
aW50ZWxfZW5jb2RlciAqZW5jb2RlciwNCj4gIAkgKiBQb3dlciBkb3duIHNpbmsgYmVmb3JlIGRp
c2FibGluZyB0aGUgcG9ydCwgb3RoZXJ3aXNlIHdlIGVuZA0KPiAgCSAqIHVwIGdldHRpbmcgaW50
ZXJydXB0cyBmcm9tIHRoZSBzaW5rIG9uIGRldGVjdGluZyBsaW5rIGxvc3MuDQo+ICAJICovDQo+
IC0JaW50ZWxfZHBfc2lua19kcG1zKGludGVsX2RwLCBEUk1fTU9ERV9EUE1TX09GRik7DQo+ICsJ
aWYgKCFpbnRlbF9kcC0+aXNfbXN0KQ0KPiArCQlpbnRlbF9kcF9zaW5rX2RwbXMoaW50ZWxfZHAs
IERSTV9NT0RFX0RQTVNfT0ZGKTsNCj4gIA0KPiAgCWludGVsX2Rpc2FibGVfZGRpX2J1ZihlbmNv
ZGVyKTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHBf
bXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kcF9tc3QuYw0KPiBpbmRleCBjM2Rl
MDkxOGVlMTMuLjI0OTNiZDFlMGU1OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5
MTUvaW50ZWxfZHBfbXN0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHBf
bXN0LmMNCj4gQEAgLTE3Niw2ICsxNzYsNyBAQCBzdGF0aWMgdm9pZCBpbnRlbF9tc3RfcG9zdF9k
aXNhYmxlX2RwKHN0cnVjdCBpbnRlbF9lbmNvZGVyICplbmNvZGVyLA0KPiAgCSAqLw0KPiAgCWRy
bV9kcF9zZW5kX3Bvd2VyX3VwZG93bl9waHkoJmludGVsX2RwLT5tc3RfbWdyLCBjb25uZWN0b3It
PnBvcnQsDQo+ICAJCQkJICAgICBmYWxzZSk7DQo+ICsJaW50ZWxfZHBfc2lua19kcG1zKGludGVs
X2RwLCBEUk1fTU9ERV9EUE1TX09GRik7DQoNCk5lZWRlZCBvbmx5IHdoZW4gX2xpbmtzIGdvZXMg
ZnJvbSAxIC0+IDANCj4gIA0KPiAgCWludGVsX2RwLT5hY3RpdmVfbXN0X2xpbmtzLS07DQo+ICAN
Cj4gQEAgLTIyMyw2ICsyMjQsNyBAQCBzdGF0aWMgdm9pZCBpbnRlbF9tc3RfcHJlX2VuYWJsZV9k
cChzdHJ1Y3QgaW50ZWxfZW5jb2RlciAqZW5jb2RlciwNCj4gIA0KPiAgCURSTV9ERUJVR19LTVMo
ImFjdGl2ZSBsaW5rcyAlZFxuIiwgaW50ZWxfZHAtPmFjdGl2ZV9tc3RfbGlua3MpOw0KPiAgDQo+
ICsJaW50ZWxfZHBfc2lua19kcG1zKGludGVsX2RwLCBEUk1fTU9ERV9EUE1TX09OKTsNCk5lZWRl
ZCBvbmx5IHdoZW4gX2xpbmtzIGdvZXMgZnJvbSAwIC0+IDENCj4gIAlkcm1fZHBfc2VuZF9wb3dl
cl91cGRvd25fcGh5KCZpbnRlbF9kcC0+bXN0X21nciwgY29ubmVjdG9yLT5wb3J0LCB0cnVlKTsN
Cj4gIAlpZiAoaW50ZWxfZHAtPmFjdGl2ZV9tc3RfbGlua3MgPT0gMCkNCj4gIAkJaW50ZWxfZGln
X3BvcnQtPmJhc2UucHJlX2VuYWJsZSgmaW50ZWxfZGlnX3BvcnQtPmJhc2UsDQo=
