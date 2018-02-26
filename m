Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3776141-1519677569-2-13951350585931846564
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519677569; b=F+D7j9TDiz4kwkfacxuWxyPC/D78DVRTZoE8b3H7SIu7FKk
    egPadVAh2/kVgXnzVAHYLMvQ9TzDWY2LWQvkvqk+A72nZUb2jhb4eovQgM+hcNAx
    ZQ0eww1oNj/GTTIaGVlJtLvBd3JNDcsvKO3CVvxrvbafvr3sjGmiWQZtcooZTchy
    Rz9NQpRwp20wSj1I2f7aIAbJ5RiP1lJOeI+ZGqyJx5JBMBLsAihRmXDHEG0AMt+r
    5mQ0hEHvx4Ss/Pqm9VcoxD9xHxm5P6vHkep35epqrCftVrf+2L9pPk2ZQMRwAsY2
    8o2fkCuwJwcv5AUSFYs4jnIUo55qVsquzYR9eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1519677569; bh=V8hpo2t8KHRoF6WYKG3HjJh6w0MlQKTd5mStRw
    VdlYw=; b=TzwvCqRUj/3eDU+taqFKjos20bpWCtffxZcwVrny7Lxm+CF8C9ilmH
    0yxswfBD/ZoGtmwDiPABKT80o3z85Gp8+K2X8vPvjwRmkYv7lBsTNjDSSgcAhJ0y
    7kgjHnl8uZubkVl1qXyFTOhk69+0X9eBMg2sOVoj4wZCws7YqbhWgUZDnbBkdKSo
    zK12OXNQYVrQbclB9ryh/1DxOoAqEvLAfUe6PvW1VFEOpW8D4CCEQAQfyT44fimv
    xR8uLZ0XXEOzSDTSuoXtrQIC/RSf2go8goqMYjZnVGc+E4+RLsveVv7lNi05gnw+
    1Jp6TE0Fla4g1RDhUcX4abWv9kUVFGjw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeBZUjN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:39:13 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:42745 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753690AbeBZU10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:26 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Thread-Topic: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Thread-Index: AQHTrw7tWDAAHPvgcUiuoIWh24plxKO2sHSAgAAJn4CAABvJAIAABcQAgAAVToCAACCYgA==
Date: Mon, 26 Feb 2018 20:27:22 +0000
Message-ID: <1519676841.2997.7.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
         <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
         <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
         <1519658060.31245.4.camel@synopsys.com>
         <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
         <1519665265.31245.6.camel@synopsys.com>
         <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
In-Reply-To: <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3651F71BBF0E724AB1BD729E3381FBE2@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgQW5keSwNCg0KT24gTW9uLCAyMDE4LTAyLTI2IGF0IDIwOjMwICswMjAwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6DQo+IE9uIE1vbiwgRmViIDI2LCAyMDE4IGF0IDc6MTQgUE0sIEV2Z2VuaXkg
RGlkaW4NCj4gPEV2Z2VuaXkuRGlkaW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBPbiBNb24s
IDIwMTgtMDItMjYgYXQgMTg6NTMgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+
IE9uIE1vbiwgRmViIDI2LCAyMDE4IGF0IDU6MTQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPiA+IDxF
dmdlbml5LkRpZGluQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAxOC0w
Mi0yNiBhdCAxNjozOSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gPiA+IE9u
IE1vbiwgRmViIDI2LCAyMDE4IGF0IDQ6MzQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPiA+ID4gPiA8
RXZnZW5peS5EaWRpbkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gSW4gY29tbWl0
IDRjMjM1N2Y1N2RkNSAoIm1tYzogZHdfbW1jOiBGaXggdGhlIENUTyB0aW1lb3V0IGNhbGN1bGF0
aW9uIikNCj4gPiA+ID4gPiA+IGhhdmUgYmVlbiBtYWRlIGNoYW5nZXMgd2hpY2ggY2FuIGNhdXNl
IG11bHRpcGx5IG92ZXJmbG93IGZvciAzMi1iaXQgc3lzdGVtcy4NCj4gPiA+ID4gPiA+IFRoZSB2
YWx1ZSBvZiBjdG9fbXMgaXMgbG93ZXIgdGhlIGRydG9fbXMsIGJ1dCBuZXZlcnRoZWxlc3Mgb3Zl
cmZsb3cgY2FuIG9jY3VyLg0KPiA+ID4gPiA+ID4gTGV0cyBjYXN0IHRoaXMgbXVsdGlwbHkgdG8g
dTY0IHR5cGUgd2hpY2ggcHJldmVudHMgb3ZlcmZsb3cuDQo+ID4gPiA+ID4gPiAtICAgICAgIGN0
b19tcyA9IERJVl9ST1VORF9VUChNU0VDX1BFUl9TRUMgKiBjdG9fY2xrcyAqIGN0b19kaXYsIGhv
c3QtPmJ1c19oeik7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIGN0b19tcyA9
IERJVl9ST1VORF9VUCgodTY0KU1TRUNfUEVSX1NFQyAqIGN0b19jbGtzICogY3RvX2RpdiwgaG9z
dC0+YnVzX2h6KTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJSVJDLCBzb21lb25lIGNvbW1lbnRl
ZCBvbiB0aGlzIG9yIHNpbWlsYXIsIGkuZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBESVZfUk9V
TkRfVVBfVUxMKCkgPw0KPiA+ID4gPiANCj4gPiA+ID4gU3dpdGNoIERJVl9ST1VORF9VUCBtYWNy
byB0byBESVZfUk9VTkRfVVBfVUxMIGlzIG5vdCByZWFzb25hYmxlDQo+ID4gPiA+IGJlY2F1c2Ug
b3ZlcmZsb3cgaGFwcGVucyBvbiBtdWx0aXBseSBhbmQgRElWX1JPVU5EX1VQX1VMTCBoZWxwcw0K
PiA+ID4gPiB3aXRoIHN1bSBvdmVyZmxvdy4NCj4gPiA+IA0KPiA+ID4gRGlkIHlvdSB0cnkgdG8g
Y29tcGlsZSB5b3VyIGNvZGUgZm9yIDMyLWJpdCB0YXJnZXQ/DQo+ID4gDQo+ID4gWWVzLCB3ZSBo
YXZlIGNvbXBpbGVkIGNvZGUgZm9yIDMyLWJpdCBzeXN0ZW0uDQo+ID4gSSBhbSB3b25kZXJpbmcg
d2h5IGFyZSB5b3UgYXNraW5nIHRoYXQ/DQo+IA0KPiBCZWNhdXNlIEkgc2ltcGxlIGRpZG4ndCBi
ZWxpZXZlIHlvdS4NCg0KV2VsbCB3b3JsZCBhcm91bmQgdXMgaXMgbXVjaCBtb3JlIGNvbXBsaWNh
dGVkIHRoYW4gaXQgc29tZXRpbWVzIGxvb2tzIGxpa2UgOikNCg0KPiBFUlJPUjogIl9fdWRpdmRp
MyIgW2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLmtvXSB1bmRlZmluZWQhDQo+IC4uLnNjcmlwdHMv
TWFrZWZpbGUubW9kcG9zdDo5MjogcmVjaXBlIGZvciB0YXJnZXQgJ19fbW9kcG9zdCcgZmFpbGVk
DQo+IG1ha2VbMl06ICoqKiBbX19tb2Rwb3N0XSBFcnJvciAxDQoNClRoYXQncyByaWdodCBfX3Vk
aXZkaTMoKSBpcyBub3QgZGVmaW5lZCBmb3Igc29tZSBhcmNoaXRlY3R1cmVzIGJ1dCBpdCBpcyBk
ZWZpbmVkIGZvcg0Kc29tZSBvdGhlcnMgaW5jbHVkaW5nIEFSQywgWHRlbnNhIGV0Yywgc2VlDQpo
dHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3QvaWRlbnQvX191ZGl2ZGkzDQoN
CldoYXQgaGFwcGVucyBfX3VkaXZkaTMoKSBpcyBpbXBsZW1lbnRlZCBpbiBsaWJnY2MgaW4gb25l
IGZvcm0gb3IgYW5vdGhlciBmb3JtDQpiZSBpdCBwdXJlIGFzc2VtYmx5IG9yIGdlbmVyaWMgaW1w
bGVtZW50YXRpb24gd3JpdHRlbiBpbiBDLg0KDQpTbyBtYXliZSB3ZSBuZWVkIHRvIGFkZCBleHBv
cnQgb2YgX191ZGl2ZGkzKCkgZm9yIG90aGVyIGFyY2hlcywgd2hhdCBkbyB5b3UgdGhpbms/DQoN
Ci1BbGV4ZXk=
