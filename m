Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3715724-1520442788-2-11597984488982104944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520442787; b=MDGnCPUcsmBAnSwmfnUv7zlKvH7UiPzXP5aGUydnTiv3bDd
    7nnXP7gaS5EdrzCF880qPjYx5u6rLk2HK61Xa1uHY5wCbX9kCqwt3tPPE1BgXdji
    LSOV6foFxCvVWLySVEHULI6uUx0m709hiHjSjBaK6QIVJ+y9niUUmFctDprigFX2
    lDb+JLocoUF5qeocRYCHZkDGrVnq8AQptn2fjF01XLbLs7pgVafEkKwyWu68P1Kn
    DVekzukor4taoAqTKrYVWTlConZBZEWFuiouBnStElWno8Eg63b7l7Okpv1RIaNK
    FW3y304CmhpSWOcU+UDcowGnoZ2oR6qikQQ5Tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520442787; bh=iKJ/2zkqD70sVlqIvaxOgIB/6E3bG8GIiSjYeX
    wFbfI=; b=F5LpwcxRHWBg7nmMCC47PB7Z5yqk4qELWeg6mU1fQVhcLZIWwNwN45
    KKNliVGp+ymwQRhxz/Uvm2CdUAK/L8ReXQ9WTexLovy2V7E+z4t+KXdErEI7LKLs
    wjG4HCXhtrnbp/Xvrb7UalHZVPtJqmwQJ02RBsuRDIRMH4zEg0zak44QVtu8U0oD
    6tGkoV/aBvMzf+q0r0+8iFsc8OGYvNIJrhL2Mr/AqrM3qwQwdIQzwoJ4o9rbZPWN
    A3G5RLCR3icyTnM6SxzGsu3G0uvl+sR4+QkxP+485EVfYFI55y69FfCORzhyS5Kk
    SO9vmqnnb7nAvMhnaQMuR4fo8z7pFnUw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933655AbeCGRMj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 12:12:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16246 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933487AbeCGRMi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 12:12:38 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] ARM: dts: STi: Fix aliases property name for STi
 boards
Thread-Topic: [PATCH v3 1/3] ARM: dts: STi: Fix aliases property name for STi
 boards
Thread-Index: AQHTtfFHkP+gNBEQOEij8KTS6pdoKKPE4nkAgAAPjYA=
Date: Wed, 7 Mar 2018 17:11:31 +0000
Message-ID: <8edca499-d31a-19b6-946b-503489054f6d@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
 <1520412597-30545-2-git-send-email-patrice.chotard@st.com>
 <CAL_JsqKBkfCsx4pyjUebwkV0q+S5LhwePWw59-7ibt77qdAGbw@mail.gmail.com>
In-Reply-To: <CAL_JsqKBkfCsx4pyjUebwkV0q+S5LhwePWw59-7ibt77qdAGbw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <40730739F791D04CA56449536E107BE1@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgUm9iDQoNCk9uIDAzLzA3LzIwMTggMDU6MTUgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBP
biBXZWQsIE1hciA3LCAyMDE4IGF0IDI6NDkgQU0sICA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4g
d3JvdGU6DQo+PiBGcm9tOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+
DQo+Pg0KPj4gVXBkYXRlIHNlcmlhbCBhbGlhc2VzIGZyb20gInR0eUFTTiIgdG8gbW9yZSBjb21t
b24gInNlcmlhbE4iLg0KPj4NCj4+IFNpbmNlIGR0YyB2MS40LjYtOS1nYWFkZDBiNjVjOTg3LCBh
bGlhc2VzIHByb3BlcnR5IG5hbWUgbXVzdA0KPj4gYmUgbG93ZXJjYXNlIG9ubHkuIFRoaXMgYWxs
b3dzIHRvIGZpeCBmb2xsb3dpbmcgZHRjIHdhcm5pbmdzOg0KPj4NCj4+IGFyY2gvYXJtL2Jvb3Qv
ZHRzL3N0aWg0MTgtYjIxOTkuZHRiOiBXYXJuaW5nIChhbGlhc19wYXRocyk6IC9hbGlhc2VzOiBh
bGlhc2VzIHByb3BlcnR5IG5hbWUgbXVzdCBpbmNsdWRlIG9ubHkgbG93ZXJjYXNlIGFuZCAnLScN
Cj4+IGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRiOiBXYXJuaW5nIChhbGlhc19w
YXRocyk6IC9hbGlhc2VzOiBhbGlhc2VzIHByb3BlcnR5IG5hbWUgbXVzdCBpbmNsdWRlIG9ubHkg
bG93ZXJjYXNlIGFuZCAnLScNCj4+IGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAtYjIyNjAuZHRi
OiBXYXJuaW5nIChhbGlhc19wYXRocyk6IC9hbGlhc2VzOiBhbGlhc2VzIHByb3BlcnR5IG5hbWUg
bXVzdCBpbmNsdWRlIG9ubHkgbG93ZXJjYXNlIGFuZCAnLScNCj4+IGFyY2gvYXJtL2Jvb3QvZHRz
L3N0aWg0MTAtYjIxMjAuZHRiOiBXYXJuaW5nIChhbGlhc19wYXRocyk6IC9hbGlhc2VzOiBhbGlh
c2VzIHByb3BlcnR5IG5hbWUgbXVzdCBpbmNsdWRlIG9ubHkgbG93ZXJjYXNlIGFuZCAnLScNCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5j
b20+DQo+PiAtLS0NCj4+DQo+PiB2MzogXyBub25lDQo+PiB2MjogXyB1c2Ugc2VyaWFsTiBpbnN0
ZWFkIG9mIHR0eWFzTiBhbGlhc2VzIHRvIG5vdCBicmVhayBBQkkNCj4+DQo+PiAgIGFyY2gvYXJt
L2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRzIHwgNCArKy0tDQo+PiAgIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3N0aWg0MTAtYjIxMjAuZHRzIHwgNCArKy0tDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0
aWg0MTAtYjIyNjAuZHRzIHwgNCArKy0tDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTgt
YjIxOTkuZHRzIHwgNCArKy0tDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9z
dGloNDA3LWIyMTIwLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRzDQo+
PiBpbmRleCBkZTNjOGJmMTI5YjUuLjJjNGQ2MDMzYjQ0OCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRzDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0
cy9zdGloNDA3LWIyMTIwLmR0cw0KPj4gQEAgLTE0LDcgKzE0LDcgQEANCj4+ICAgICAgICAgIGNv
bXBhdGlibGUgPSAic3Qsc3RpaDQwNy1iMjEyMCIsICJzdCxzdGloNDA3IjsNCj4+DQo+PiAgICAg
ICAgICBjaG9zZW4gew0KPj4gLSAgICAgICAgICAgICAgIGJvb3RhcmdzID0gImNvbnNvbGU9dHR5
QVMwLDExNTIwMCBjbGtfaWdub3JlX3VudXNlZCI7DQo+PiArICAgICAgICAgICAgICAgYm9vdGFy
Z3MgPSAiY29uc29sZT1zZXJpYWwwLDExNTIwMCBjbGtfaWdub3JlX3VudXNlZCI7DQo+IA0KPiBU
aGVzZSBodW5rcyBmb3IgYm9vdGFyZ3MgYXJlIHN0aWxsIHdyb25nLiBZb3Ugd291bGRuJ3QgYm9v
dCB3aXRoIGENCj4gY29uc29sZSBpZiB5b3Ugb25seSBhcHBseSBwYXRjaCAxLiBUaGVzZSBodW5r
cyBzaG91bGQgYmUgc3F1YXNoZWQgd2l0aA0KPiBwYXRjaCAyLg0KDQpUaGFua3MgZm9yIHBvaW50
aW5nIHRoaXMsIGkgZXZlbiBub3RpY2VkIHRoYXQgcGF0Y2hlcyBtdXN0IGJlIHJlb3JkZXJlZCwg
DQpmaXJzdCBzdC1hc2MgZHJpdmVyIHVwZGF0ZSBhbmQgdGhlbiBEVFMgcGF0Y2hlcy4NCg0KVGhh
bmtzDQoNClBhdHJpY2UNCg0KPiANCj4+ICAgICAgICAgICAgICAgICAgc3Rkb3V0LXBhdGggPSAm
c2JjX3NlcmlhbDA7DQo+PiAgICAgICAgICB9Ow0KPj4NCj4+IEBAIC0yNCw3ICsyNCw3IEBADQo+
PiAgICAgICAgICB9Ow0KPj4NCj4+ICAgICAgICAgIGFsaWFzZXMgew0KPj4gLSAgICAgICAgICAg
ICAgIHR0eUFTMCA9ICZzYmNfc2VyaWFsMDsNCj4+ICsgICAgICAgICAgICAgICBzZXJpYWwwID0g
JnNiY19zZXJpYWwwOw0KPj4gICAgICAgICAgICAgICAgICBldGhlcm5ldDAgPSAmZXRoZXJuZXQw
Ow0KPj4gICAgICAgICAgfTsNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
c3RpaDQxMC1iMjEyMC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMTIwLmR0cw0K
Pj4gaW5kZXggMGE1OWI3YjBmNGIyLi41NDIyODUwNjQxZTggMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L2FybS9ib290L2R0cy9zdGloNDEwLWIyMTIwLmR0cw0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvc3RpaDQxMC1iMjEyMC5kdHMNCj4+IEBAIC0xNCw3ICsxNCw3IEBADQo+PiAgICAgICAgICBj
b21wYXRpYmxlID0gInN0LHN0aWg0MTAtYjIxMjAiLCAic3Qsc3RpaDQxMCI7DQo+Pg0KPj4gICAg
ICAgICAgY2hvc2VuIHsNCj4+IC0gICAgICAgICAgICAgICBib290YXJncyA9ICJjb25zb2xlPXR0
eUFTMCwxMTUyMDAgY2xrX2lnbm9yZV91bnVzZWQiOw0KPj4gKyAgICAgICAgICAgICAgIGJvb3Rh
cmdzID0gImNvbnNvbGU9c2VyaWFsMCwxMTUyMDAgY2xrX2lnbm9yZV91bnVzZWQiOw0KPj4gICAg
ICAgICAgICAgICAgICBzdGRvdXQtcGF0aCA9ICZzYmNfc2VyaWFsMDsNCj4+ICAgICAgICAgIH07
DQo+Pg0KPj4gQEAgLTI0LDcgKzI0LDcgQEANCj4+ICAgICAgICAgIH07DQo+Pg0KPj4gICAgICAg
ICAgYWxpYXNlcyB7DQo+PiAtICAgICAgICAgICAgICAgdHR5QVMwID0gJnNiY19zZXJpYWwwOw0K
Pj4gKyAgICAgICAgICAgICAgIHNlcmlhbDAgPSAmc2JjX3NlcmlhbDA7DQo+PiAgICAgICAgICAg
ICAgICAgIGV0aGVybmV0MCA9ICZldGhlcm5ldDA7DQo+PiAgICAgICAgICB9Ow0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMjYwLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL3N0aWg0MTAtYjIyNjAuZHRzDQo+PiBpbmRleCBmZWI4ODM0NDc4ZmEuLmNhMzQ3
MTYwZTM1ZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAtYjIyNjAu
ZHRzDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMjYwLmR0cw0KPj4gQEAg
LTE1LDcgKzE1LDcgQEANCj4+ICAgICAgICAgIGNvbXBhdGlibGUgPSAic3Qsc3RpaDQxMC1iMjI2
MCIsICJzdCxzdGloNDEwIjsNCj4+DQo+PiAgICAgICAgICBjaG9zZW4gew0KPj4gLSAgICAgICAg
ICAgICAgIGJvb3RhcmdzID0gImNvbnNvbGU9dHR5QVMxLDExNTIwMCBjbGtfaWdub3JlX3VudXNl
ZCI7DQo+PiArICAgICAgICAgICAgICAgYm9vdGFyZ3MgPSAiY29uc29sZT1zZXJpYWwxLDExNTIw
MCBjbGtfaWdub3JlX3VudXNlZCI7DQo+PiAgICAgICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0g
JnVhcnQxOw0KPj4gICAgICAgICAgfTsNCj4+DQo+PiBAQCAtMjUsNyArMjUsNyBAQA0KPj4gICAg
ICAgICAgfTsNCj4+DQo+PiAgICAgICAgICBhbGlhc2VzIHsNCj4+IC0gICAgICAgICAgICAgICB0
dHlBUzEgPSAmdWFydDE7DQo+PiArICAgICAgICAgICAgICAgc2VyaWFsMSA9ICZ1YXJ0MTsNCj4+
ICAgICAgICAgICAgICAgICAgZXRoZXJuZXQwID0gJmV0aGVybmV0MDsNCj4+ICAgICAgICAgIH07
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTgtYjIxOTkuZHRz
IGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxOC1iMjE5OS5kdHMNCj4+IGluZGV4IDM5YjRkYjJl
MzUwNy4uZGJmN2JiNzA0YTFhIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc3Rp
aDQxOC1iMjE5OS5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTgtYjIxOTku
ZHRzDQo+PiBAQCAtMTQsNyArMTQsNyBAQA0KPj4gICAgICAgICAgY29tcGF0aWJsZSA9ICJzdCxz
dGloNDE4LWIyMTk5IiwgInN0LHN0aWg0MTgiOw0KPj4NCj4+ICAgICAgICAgIGNob3NlbiB7DQo+
PiAtICAgICAgICAgICAgICAgYm9vdGFyZ3MgPSAiY29uc29sZT10dHlBUzAsMTE1MjAwIGNsa19p
Z25vcmVfdW51c2VkIjsNCj4+ICsgICAgICAgICAgICAgICBib290YXJncyA9ICJjb25zb2xlPXNl
cmlhbDAsMTE1MjAwIGNsa19pZ25vcmVfdW51c2VkIjsNCj4+ICAgICAgICAgICAgICAgICAgc3Rk
b3V0LXBhdGggPSAmc2JjX3NlcmlhbDA7DQo+PiAgICAgICAgICB9Ow0KPj4NCj4+IEBAIC0yNCw3
ICsyNCw3IEBADQo+PiAgICAgICAgICB9Ow0KPj4NCj4+ICAgICAgICAgIGFsaWFzZXMgew0KPj4g
LSAgICAgICAgICAgICAgIHR0eUFTMCA9ICZzYmNfc2VyaWFsMDsNCj4+ICsgICAgICAgICAgICAg
ICBzZXJpYWwwID0gJnNiY19zZXJpYWwwOw0KPj4gICAgICAgICAgICAgICAgICBldGhlcm5ldDAg
PSAmZXRoZXJuZXQwOw0KPj4gICAgICAgICAgfTsNCj4+DQo+PiAtLQ0KPj4gMS45LjENCj4+
