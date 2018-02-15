Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1212837-1518689134-2-8633983186578949576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518689134; b=n6yEGv3q8NN4eXWQTwgk8W+eRzksuzqLSr/1lFH4ViglUON
    xVGIUcEBnClAzw/B2DXTUXGNxONo6P20Urib41EG386HOmovTQtIKG5DXFcg2I/Y
    7jJmOppD9Oh9wcBXIxau+8+sY9eY88whatfcGHrDmRCvdVzzm3r1im+3Q6ML7I/4
    vJ4PO02aFQDnIeS5ktcpRfs8rKTs1vXlcxvblhxO1uC4qKMRj/FusFa+N/YM+SbP
    7BUPNF/UzCMu4heRSvEIbd6dw5y+ra4AuKTdYWXoC3FBen4DT2cH/44Z1qEj7jhw
    Ph+Nkb5qG6E/xCXONDPspY4q1km1/rVnmUR5uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1518689134; bh=JZNvmA
    Dmiw9zEuRjlm48269BbtBR2NykJNkIMtn9xkc=; b=w0Ao93R5I1Qiih9FOp6tEw
    5Vwx5FcnM6h3cmyJ7Su4/8EqRwNmUQYeb663qIGrfdStGrAS1bp1OXR4M0Fyu6X/
    JRTK2fjTi/UtQHPaW5RNywKVpr5cwQByNUK+vsej09c37LFLYJX5CVB3jyaWCzry
    8GugR3X2ExR1TDXrukLSV9JqhzJu8GOPym/HWuO2/TUp3pCxwaogs7Vxchp9i5i4
    N9AtjH1l1zI37Qvez5ZUrTcEui+iOCM1w6uVe7121v5vUSGshZb6PQT9b+lJ7/Ov
    vT3CjhZpsfAIfYl9J749ZvAWoQtsmPawaWjQKNv+SuHgzMxznuBPXv/RCGAawRSw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755267AbeBOKF2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:05:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:32509 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755240AbeBOKFZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 15 Feb 2018 05:05:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,516,1511856000";
   d="scan'208";a="34893637"
From: "Wu, Hao" <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
CC: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        "Whisonant, Tim" <tim.whisonant@intel.com>,
        "Luebbers, Enno" <enno.luebbers@intel.com>,
        "Rao, Shiva" <shiva.rao@intel.com>,
        "Rauer, Christopher" <christopher.rauer@intel.com>
Subject: RE: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Thread-Topic: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Thread-Index: AQHTpK4DVba3ru3Qfk6Vgd/PbQo+oqOj3wKAgAAC9QCAAVknQA==
Date: Thu, 15 Feb 2018 10:05:20 +0000
Message-ID: <BE8371DA886269458E0220A16DC1F8277E154EC0@SHSMSX104.ccr.corp.intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-8-git-send-email-hao.wu@intel.com>
 <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
 <CANk1AXRksJum6s5yB5727136DBLHs4UPW7xaLn_dT5qMEfqm9A@mail.gmail.com>
In-Reply-To: <CANk1AXRksJum6s5yB5727136DBLHs4UPW7xaLn_dT5qMEfqm9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGVjY2E2MzQtMWY2Mi00MjdlLTg1ODYtNTJlMGQ1ZGJjZjlmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJnSnpMR3R6K1dRSE1vXC9XaEN5TjBlTjU2bjU3ME1iMXdRZUZPRUtvU01mOWtiSmNHNWFBV3J2WkVvVXhVK1wvWnMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBPbiBXZWQsIEZlYiAxNCwgMjAxOCBhdCAzOjAzIFBNLCBNb3JpdHogRmlzY2hlciA8bWRmQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gSGkgTW9yaXR6LA0KPiANCj4gPiBISSBIYW8sDQo+ID4N
Cg0KSGkgQWxhbiBhbmQgTW9yaXR6DQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIGNvZGUgcmV2aWV3
IGFuZCBjb21tZW50cy4NCg0KPiA+IE9uIFR1ZSwgRmViIDEzLCAyMDE4IGF0IDA1OjI0OjM2UE0g
KzA4MDAsIFd1IEhhbyB3cm90ZToNCj4gPj4gRnJvbTogWGlhbyBHdWFuZ3JvbmcgPGd1YW5ncm9u
Zy54aWFvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4NCj4gPj4gVGhpcyBwYXRjaCBhYnN0cmFjdHMg
dGhlIGNvbW1vbiBvcGVyYXRpb25zIG9mIHRoZSBzdWIgZmVhdHVyZXMsIGFuZCBkZWZpbmVzDQo+
ID4+IHRoZSBmZWF0dXJlX29wcyBkYXRhIHN0cnVjdHVyZSwgaW5jbHVkaW5nIGluaXQsIHVpbml0
IGFuZCBpb2N0bCBmdW5jdGlvbg0KPiA+PiBwb2ludGVycy4gQW5kIHRoaXMgcGF0Y2ggYWRkcyBz
b21lIGNvbW1vbiBoZWxwZXIgZnVuY3Rpb25zIGZvciBGTUUgYW5kDQo+IEFGVQ0KPiA+PiBkcml2
ZXJzLCBlLmcgZmVhdHVyZV9kZXZfdXNlX2JlZ2luL2VuZCB3aGljaCBhcmUgdXNlZCB0byBlbnN1
cmUgZXhjbHVzaXZlDQo+ID4+IHVzYWdlIG9mIHRoZSBmZWF0dXJlIGRldmljZSBmaWxlLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBUaW0gV2hpc29uYW50IDx0aW0ud2hpc29uYW50QGludGVs
LmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRW5ubyBMdWViYmVycyA8ZW5uby5sdWViYmVyc0Bp
bnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNoaXZhIFJhbyA8c2hpdmEucmFvQGludGVs
LmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZXIgUmF1ZXIgPGNocmlzdG9waGVy
LnJhdWVyQGludGVsLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogS2FuZyBMdXdlaSA8bHV3ZWku
a2FuZ0BpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFlpIDx5aS56LnpoYW5n
QGludGVsLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWGlhbyBHdWFuZ3JvbmcgPGd1YW5ncm9u
Zy54aWFvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogV3UgSGFvIDxoYW8u
d3VAaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gdjI6IHJlYmFzZWQNCj4gPj4gdjM6IHVzZSBj
b25zdCBmb3IgZmVhdHVyZV9vcHMuDQo+ID4+ICAgICByZXBsYWNlIHBjaSByZWxhdGVkIGZ1bmN0
aW9uLg0KPiA+PiB2NDogcmViYXNlIGFuZCBhZGQgbW9yZSBjb21tZW50cyBpbiBjb2RlLg0KPiA+
PiAtLS0NCj4gPj4gIGRyaXZlcnMvZnBnYS9kZmwuYyB8IDU5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPj4gIGRyaXZlcnMvZnBnYS9kZmwuaCB8IDg1DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+PiAg
MiBmaWxlcyBjaGFuZ2VkLCAxNDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0K
PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC5jIGIvZHJpdmVycy9mcGdhL2RmbC5j
DQo+ID4+IGluZGV4IDM4ZGM4MTkuLmMwYWFkODcgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMv
ZnBnYS9kZmwuYw0KPiA+PiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPj4gQEAgLTc0LDYg
Kzc0LDY1IEBAIHN0YXRpYyBlbnVtIGZwZ2FfaWRfdHlwZSBmZWF0dXJlX2Rldl9pZF90eXBlKHN0
cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+ICAgICAgIHJldHVybiBGUEdBX0lE
X01BWDsNCj4gPj4gIH0NCj4gPj4NCj4gPj4gK3ZvaWQgZnBnYV9kZXZfZmVhdHVyZV91aW5pdChz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiArew0KPiA+PiArICAgICBzdHJ1Y3Qg
ZmVhdHVyZSAqZmVhdHVyZTsNCj4gPj4gKyAgICAgc3RydWN0IGZlYXR1cmVfcGxhdGZvcm1fZGF0
YSAqcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2LT5kZXYpOw0KPiA+IFNlZSBjb21tZW50
IGJlbG93IHcuci50IG9yZGVyaW5nIGRlY2xhcmF0aW9ucy4gTm90IGEgbXVzdCBmb3Igc3VyZS4N
Cj4gPj4gKw0KPiA+PiArICAgICBmcGdhX2Rldl9mb3JfZWFjaF9mZWF0dXJlKHBkYXRhLCBmZWF0
dXJlKQ0KPiA+PiArICAgICAgICAgICAgIGlmIChmZWF0dXJlLT5vcHMpIHsNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgIGZlYXR1cmUtPm9wcy0+dWluaXQocGRldiwgZmVhdHVyZSk7DQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICBmZWF0dXJlLT5vcHMgPSBOVUxMOw0KPiA+PiArICAgICAg
ICAgICAgIH0NCj4gPj4gK30NCj4gPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGZwZ2FfZGV2X2ZlYXR1
cmVfdWluaXQpOw0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW50DQo+ID4+ICtmZWF0dXJlX2luc3Rh
bmNlX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPj4gKyAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgZmVhdHVyZSAqZmVhdHVyZSwgc3RydWN0IGZlYXR1cmVfZHJp
dmVyICpkcnYpDQo+ID4+ICt7DQo+ID4+ICsgICAgIGludCByZXQ7DQo+ID4+ICsNCj4gPj4gKyAg
ICAgV0FSTl9PTighZmVhdHVyZS0+aW9hZGRyKTsNCj4gPg0KPiA+IE5vdCBzdXJlIEkgdW5kZXJz
dGFuZCBjb3JyZWN0bHksIGlzIHRoZSAhZmVhdHVyZS0+aW9hZGRyIGEgdXNlLWNhc2UgdGhhdA0K
PiA+IGhhcHBlbnM/IElmIG5vdCBqdXN0IHJldHVybiBlYXJseS4NCg0KQWN0dWFsbHkgdGhpcyBz
aG91bGQgbmV2ZXIgaGFwcGVuIChpbml0IGEgZmVhdHVyZSB3aXRob3V0IG1hcHBlZCBtbWlvDQpy
ZXNvdXJjZSBhZGRyZXNzKS4gSWYgdGhpcyB3YXJuaW5nIGlzIHNlZW4sIHRoYXQgbWVhbnMgdGhl
cmUgc2hvdWxkIGJlDQpjcml0aWNhbCBpc3N1ZXMgc29tZXdoZXJlIGluIGRyaXZlciBlbnVtZXJh
dGlvbiBjb2RlLiBCdXQgc3VyZSwgSSBjYW4ganVzdA0KdXNlIGlmICgpIHJldHVybiBpbnN0ZWFk
LiA6ICkNCg0KPiA+PiArDQo+ID4+ICsgICAgIHJldCA9IGRydi0+b3BzLT5pbml0KHBkZXYsIGZl
YXR1cmUpOw0KPiA+PiArICAgICBpZiAocmV0KQ0KPiA+PiArICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ID4+ICsNCj4gPj4gKyAgICAgZmVhdHVyZS0+b3BzID0gZHJ2LT5vcHM7DQo+ID4+ICsN
Cj4gPj4gKyAgICAgcmV0dXJuIHJldDsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAraW50IGZwZ2Ff
ZGV2X2ZlYXR1cmVfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+PiArICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZmVhdHVyZV9kcml2ZXIgKmZlYXR1cmVfZHJ2cykN
Cj4gPj4gK3sNCj4gPj4gKyAgICAgc3RydWN0IGZlYXR1cmUgKmZlYXR1cmU7DQo+ID4+ICsgICAg
IHN0cnVjdCBmZWF0dXJlX2RyaXZlciAqZHJ2ID0gZmVhdHVyZV9kcnZzOw0KPiA+PiArICAgICBz
dHJ1Y3QgZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGRldl9nZXRfcGxhdGRhdGEoJnBk
ZXYtPmRldik7DQo+ID4+ICsgICAgIGludCByZXQ7DQo+ID4gV2UgZG9uJ3QgaGF2ZSBjbGVhciBn
dWlkZWxpbmVzIGhlcmUsIGJ1dCBzb21lIHN1YnN5c3RlbXMgd2FudCByZXZlcnNlDQo+ID4gWC1N
YXMgdHJlZSBkZWNsYXJhdGlvbnMuDQo+IA0KPiBTb3VuZHMgZ29vZCEgIEkgYWdyZWUuDQoNCkRv
IHlvdSBtZWFuIHdlIHNob3VsZCByZXZlcnNlIGZwZ2FfeHh4IGRlZmluaXRpb25zPyBJZiB5ZXMs
IHRoZW4gSSBjYW4gdXBkYXRlDQp0aGUgY29kZSB0byB1c2UgZnBnYV9kZmxfeHh4IG9yIGRmbF94
eHggaW5zdGVhZC4gOiApDQoNClRoYW5rcw0KSGFvDQoNCj4gDQo+IEFsYW4NCg==
