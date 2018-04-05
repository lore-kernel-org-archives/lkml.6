Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3984730-1522968887-2-15570392510826559946
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
    1522968887; b=hRR5RSUCannV0LvK207EiiowH5DxNamzfGZvK/38blQGRd9Ale
    IMwKOiSj9gz0PeSCqVZ9pQ/r0tCuBfu1sDsvoM73DeBazhgsqKHFIJnQ1UWTTDBT
    /6gUFX1dboAYNmLJdc+gJSf4QqAqX7OAxcgrCKTq2YFg3/XmQoezl9D80s6I2H5W
    gMDkA5E2XXMkmFCKVhcVklT2JSA+Eeyt4KLKr4nUaEI43dYzrqJLICMQkNF6LB6x
    YHgztk/f1obOdZwRrSgiWbzOQ+lRi4BNI9f+YfZ59TltLnvS0WpPKY82ND7LtjBd
    Cm6Zwfsd3OA1kYi7gDLFqbydtLJ36BgLrLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522968887; bh=rx4zsSF/iY1G/lVWi+FY4jyLlmvJFh1XhgRPemAfbqI=; b=
    bDcDH70+PUBtqZlcbBzkb9cIRv4ly1/wWYGr3OnfLZRvFfuWDvj1d78W+nBsX6KV
    NQ/u341hQnMmB7pWeiqxs/QaAs3MncphtTysEp8e1sx+mcOVGFDferSGnpXSlIBr
    Y3dit/0MGG8XBZmk8f7N6s4h1Giy2qT2Hy+PZZPaYa6nODfH7E2652I/IPC6erW2
    v+zsck3a3LzOjbPz9QzmKijWFFiheHGRIfICgOOB2CxJCny49nD/fMmlRB5NfKKu
    WpDfwZH1n3+WKEy9VBWuRSBEW7bqOfuiXwm9mqmztymCVRwWE+N4Ue+n1VnQL5zH
    n79k5/0X3gQNgLtg+j+4Hw==
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
X-CM-Envelope: MS4wfP6ccQBUGv7FR+ncDtX058HQqH/0F9AhSGJwWnfbFdDpPEVrW4Zuvx1DdBnsCVeL+vGg+R7QUdbWjHIAqFExi2Uu9vYD0bCPi0mYdQsElO+CWO8em0Fp
    FssMxdhq5paFB0HuMKah2ErP1FEXmC8Xr1IVbqBn/pAfE5Qt11rySs7hs+UHC9ypQhz1LIJ1BRygFw4UraW9XYw/0nhaxU1yImdcW9sChlfUQpg5c+hEtbxE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=J1NWn22cQj0A:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=1Yo2vfLtYH_QzLFqMCgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeDEWyo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 18:54:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:25150 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeDEWyn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 18:54:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,412,1517904000";
   d="scan'208";a="218036321"
From: "Pandiyan, Dhinakaran" <dhinakaran.pandiyan@intel.com>
To: "lyude@redhat.com" <lyude@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "labbott@redhat.com" <labbott@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v3] drm/i915/dp: Send DPCD ON for MST before
 phy_up
Thread-Topic: [Intel-gfx] [PATCH v3] drm/i915/dp: Send DPCD ON for MST
 before phy_up
Thread-Index: AQHTzSPzf9pEco9CVEKJR/nOt9S1saPzRAMA
Date: Thu, 5 Apr 2018 22:54:41 +0000
Message-ID: <1522970338.2418.50.camel@dk-H97M-D3H>
References: <20180405203601.23242-1-lyude@redhat.com>
         <20180405211930.1209-1-lyude@redhat.com>
In-Reply-To: <20180405211930.1209-1-lyude@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.17]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDD9B0EA06E9BA448A9B446E9F77F363@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCg0KT24gVGh1LCAyMDE4LTA0LTA1IGF0IDE3OjE5IC0wNDAwLCBMeXVkZSBQYXVsIHdyb3Rl
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
ZXRyaWNhbA0KPiAtIEltcHJvdmUgY29tbWl0IG1lc3NhZ2UgLSBkaG5rcm4NCj4gQ2hhbmdlcyBz
aW5jZSB2MjoNCj4gLSBPbmx5IHNlbmQgRFBNUyBvZmYgd2hlbiB3ZSdyZSBkaXNhYmxpbmcgdGhl
IGxhc3Qgc2luaywgYW5kIG9ubHkgc2VuZA0KPiAgIERQTVMgb24gd2hlbiB3ZSdyZSBlbmFibGlu
ZyB0aGUgZmlyc3Qgc2luayAtIGRobmtybg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHl1ZGUgUGF1
bCA8bHl1ZGVAcmVkaGF0LmNvbT4NCj4gQ2M6IERoaW5ha2FyYW4gUGFuZGl5YW4gPGRoaW5ha2Fy
YW4ucGFuZGl5YW5AaW50ZWwuY29tPg0KPiBDYzogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJq
YWxhQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IExhdXJhIEFiYm90dCA8bGFiYm90dEByZWRoYXQu
Y29tPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhlczogYWQyNjBhYjMyYTRk
OSAoImRybS9pOTE1L2RwOiBXcml0ZSB0byBTRVRfUE9XRVIgZHBjZCB0byBlbmFibGUgTVNUIGh1
Yi4iKQ0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RkaS5jICAgIHwgNiAr
KysrLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RwX21zdC5jIHwgOCArKysrKysr
LQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RkaS5jIGIvZHJp
dmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZGRpLmMNCj4gaW5kZXggYTY2NzJhOWFiZDg1Li5jMGJm
NzQxOWUxYzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RkaS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RkaS5jDQo+IEBAIC0yMzI0LDcg
KzIzMjQsOCBAQCBzdGF0aWMgdm9pZCBpbnRlbF9kZGlfcHJlX2VuYWJsZV9kcChzdHJ1Y3QgaW50
ZWxfZW5jb2RlciAqZW5jb2RlciwNCj4gIAkJaW50ZWxfcHJlcGFyZV9kcF9kZGlfYnVmZmVycyhl
bmNvZGVyLCBjcnRjX3N0YXRlKTsNCj4gIA0KPiAgCWludGVsX2RkaV9pbml0X2RwX2J1Zl9yZWco
ZW5jb2Rlcik7DQo+IC0JaW50ZWxfZHBfc2lua19kcG1zKGludGVsX2RwLCBEUk1fTU9ERV9EUE1T
X09OKTsNCj4gKwlpZiAoIWludGVsX2RwLT5pc19tc3QpDQo+ICsJCWludGVsX2RwX3NpbmtfZHBt
cyhpbnRlbF9kcCwgRFJNX01PREVfRFBNU19PTik7DQoNCg0KDQpJIGJlbGlldmUgVmlsbGUgcmVj
b21tZW5kZWQgdG8gY2hlY2sgZm9yDQoJaXNfbXN0ID0gaW50ZWxfY3J0Y19oYXNfdHlwZShjcnRj
X3N0YXRlLCBJTlRFTF9PVVRQVVRfRFBfTVNUKQ0KaGVyZS4gVGhlIHF1ZXN0aW9uIGlzLCBhcmUg
dGhlcmUgY2FzZXMgd2hlcmUgDQppbnRlbF9kcC0+aXNfbXN0ICE9IGlzX21zdD8gQSBkaXNjb25u
ZWN0IGluIHRoZSBtaWRkbGUgb2YgYSBtb2Rlc2V0DQp3b3VsZCBjYXVzZSBpbnRlbF9kcC0+aXNf
bXN0IHRvIGJlIGZhbHNlLCB3b3VsZG4ndCBpdD8NCg0KDQoNCg0KDQoNCg==
