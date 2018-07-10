Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA096C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4325B2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4325B2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeGJFUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:20:21 -0400
Received: from asrmicro.com ([210.13.118.86]:6183 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeGJFUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:20:18 -0400
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 10 Jul
 2018 13:04:53 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Tue, 10 Jul 2018 13:04:53 +0800
From:   =?utf-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= 
        <hongjiefang@asrmicro.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Bastian Stender" <bst@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chanho Min <chanho.min@lge.com>,
        "Kyle Roeschley" <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: improve rationality of bus width setting for
 HS400es
Thread-Topic: [PATCH] mmc: core: improve rationality of bus width setting
 for HS400es
Thread-Index: AQHUF1C1UTyNnhfPe06ky8JfBeUWZqSGO/IAgAGhJWA=
Date:   Tue, 10 Jul 2018 05:04:53 +0000
Message-ID: <86aa8215d6e44e578cd34f0625c5ebef@mail2012.asrmicro.com>
References: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
 <CAPDyKFpzJV-UQbMa7_tHms7o3hMn9_g=H_M0jW+ZN9G=8XCqRg@mail.gmail.com>
In-Reply-To: <CAPDyKFpzJV-UQbMa7_tHms7o3hMn9_g=H_M0jW+ZN9G=8XCqRg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.170.195]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA5IEp1bHkgMjAxOCBhdCAwODo0NywgSG9uZ2ppZSBGYW5nIDxob25namllZmFuZ0Bhc3Jt
aWNyby5jb20+IHdyb3RlOg0KPiA+IG1tY19zZWxlY3RfaHM0MDBlcygpIGNhbGxzIG1tY19zZWxl
Y3RfYnVzX3dpZHRoKCkgd2hpY2ggd2lsbCB0cnkgdG8NCj4gPiBzZXQgNGJpdCB0cmFuc2ZlciBt
b2RlIGlmIGZhaWwgdG8gc2V0IDhiaXQgbW9kZS4gVGhlIHByb2JsZW0gaXMgdGhhdA0KPiA+IHRo
ZSBidXMgd2lkdGggc2hvdWxkIG5vdCBiZSBzZXQgdG8gNGJpdCBpbiBIUzQwMGVzIG1vZGUuDQo+
IA0KPiBJIGd1ZXNzIGl0IGZhaWxzIGJlY2F1c2UgdGhlcmUgaXMgc29tZXRoaW5nIHdyb25nLiBD
YW4geW91IHBsZWFzZQ0KPiBlbGFib3JhdGUgdW5kZXIgd2hhdCBjaXJjdW1zdGFuY2UgdGhlIHBy
b2JsZW0gb2NjdXJzPw0KPiANClRoaXMgcHJvYmxlbSB2ZXJ5IG9jY2FzaW9uYWxseSBvY2N1cnJl
ZCB3aGVuIHN5c3RlbSByZXN1bWUgZnJvbQ0Kc3VzcGVuZCBzdGF0ZS4gVGhlIGNhcmQgc3R1Y2sg
aW4gdGhlIHByb2dyYW1taW5nIHN0YXRlIGFmdGVyIHNldHRpbmcNCjhiaXQgbW9kZS4gQWZ0ZXIg
dGhhdCwgbW1jX3NlbGVjdF9idXNfd2lkdGgoKSB3aWxsIGNvbnRpbnVlIHRvIHNldA0KNGJpdCBt
b2RlIGFuZCByZXR1cm4gd2l0aG91dCBlcnJvcnMuIE9mIGNvdXJzZSwgdGhlIGZvbGxvd2luZyBS
L1cNCnJlcXVlc3RzIHdpbGwgYmUgYWxsIGZhaWxpbmcuDQoNClRoZSBwcm9ibGVtIHNjZW5lIGlz
IGhhcmQgdG8gcmVwcm9kdWNlLiBNYXliZSBpdCBoYXBwZW5lZA0KYmVjYXVzZSB0aGVyZSBpcyBz
b21ldGhpbmcgd3JvbmcgYWJvdXQgYnVzIGNsb2NrIG9yIGNvcmUgdm9sdGFnZQ0Kc3RhYmlsaXR5
IHdoZW4gc3lzdGVtIGRvIHJlc3VtZS4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG9uZ2pp
ZSBGYW5nIDxob25namllZmFuZ0Bhc3JtaWNyby5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
bW1jL2NvcmUvbW1jLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0K
PiA+IGluZGV4IDQ0NjZmNWQuLjk0YzNjYzUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMv
Y29yZS9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiBAQCAtMTMz
Nyw5ICsxMzM3LDI4IEBAIHN0YXRpYyBpbnQgbW1jX3NlbGVjdF9oczQwMGVzKHN0cnVjdCBtbWNf
Y2FyZCAqY2FyZCkNCj4gPiAgICAgICAgIGlmIChlcnIpDQo+ID4gICAgICAgICAgICAgICAgIGdv
dG8gb3V0X2VycjsNCj4gPg0KPiA+IC0gICAgICAgZXJyID0gbW1jX3NlbGVjdF9idXNfd2lkdGgo
Y2FyZCk7DQo+ID4gLSAgICAgICBpZiAoZXJyIDwgMCkNCj4gPiArICAgICAgIC8qIFN3aXRjaCBj
YXJkIHRvIDggYml0IG1vZGUgKi8NCj4gPiArICAgICAgIGVyciA9IG1tY19zd2l0Y2goY2FyZCwg
RVhUX0NTRF9DTURfU0VUX05PUk1BTCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgRVhU
X0NTRF9CVVNfV0lEVEgsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIEVYVF9DU0RfQlVT
X1dJRFRIXzgsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGNhcmQtPmV4dF9jc2QuZ2Vu
ZXJpY19jbWQ2X3RpbWUpOw0KPiA+ICsgICAgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAgICAg
ICAgICBwcl9lcnIoIiVzOiBzd2l0Y2ggdG8gOCBiaXQgbW9kZSBmb3IgaHM0MDBlcyBmYWlsZWQs
IGVycjolZFxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtbWNfaG9zdG5hbWUoaG9z
dCksIGVycik7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0X2VycjsNCj4gPiArICAgICAg
IH0NCj4gPiArDQo+ID4gKyAgICAgICBtbWNfc2V0X2J1c193aWR0aChob3N0LCBNTUNfQlVTX1dJ
RFRIXzgpOw0KPiA+ICsNCj4gPiArICAgICAgIGlmICghKGhvc3QtPmNhcHMgJiBNTUNfQ0FQX0JV
U19XSURUSF9URVNUKSkNCj4gPiArICAgICAgICAgICAgICAgZXJyID0gbW1jX2NvbXBhcmVfZXh0
X2NzZHMoY2FyZCwgTU1DX0JVU19XSURUSF84KTsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAg
ICAgICAgICAgICAgZXJyID0gbW1jX2J1c190ZXN0KGNhcmQsIE1NQ19CVVNfV0lEVEhfOCk7DQo+
ID4gKyAgICAgICBpZiAoZXJyKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHByX2VycigiJXM6IHRl
c3QgOCBiaXQgbW9kZSBmb3IgaHM0MDBlcyBmYWlsZWQsIGVycjolZFxuIiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBtbWNfaG9zdG5hbWUoaG9zdCksIGVycik7DQo+ID4gICAgICAgICAg
ICAgICAgIGdvdG8gb3V0X2VycjsNCj4gDQo+IExvdCdzIG9wZW4gY29kaW5nLCBubyBJIGRvbid0
IGxpa2UgaXQuDQo+IA0KPiBXb3VsZG4ndCBpdCBpbnN0ZWFkIGJlIHBvc3NpYmxlIHRvIGNoZWNr
IHRoZSByZXR1cm4gdmFsdWUgZnJvbQ0KPiBtbWNfc2VsZWN0X2J1c193aWR0aCgpLCBhcyBpdCBz
aG91bGQgdGVsbCB3aGF0IHdpZHRoIGl0IG1hbmFnZSB0bw0KPiBzZWxlY3QuIFRoZW4gaWYgaXQg
aXNuJ3QgOC1iaXQsIHRoZW4gd2Ugc2hvdWxkIGJhaWwgb3V0LiBEb2VzIHRoYXQNCj4gd29yaz8N
Cj4gDQpBZnRlciBzZXR0aW5nIDRiaXQgbW9kZSwgaXQgY2FuJ3Qgd29yayBiZWNhdXNlIGl0IGNh
bm5vdCBiYWNrIHRvDQpIUzIwMCBtb2RlIGxpa2UgdGhlIEhTNDAwIG1vZGUuDQpGb3IgSFM0MDBl
cywgaWYgZmFpbCB0byBzZXQgOGJpdCBtb2RlLCBtYXliZSBpdCBpcyBtb3JlIHJlYXNvbmFibGUN
CnRoYXQgcmV0dXJuIGVycm9yIGRpcmVjdGx5Lg0KDQo+ID4gKyAgICAgICB9DQo+ID4NCj4gPiAg
ICAgICAgIC8qIFN3aXRjaCBjYXJkIHRvIEhTIG1vZGUgKi8NCj4gPiAgICAgICAgIGVyciA9IF9f
bW1jX3N3aXRjaChjYXJkLCBFWFRfQ1NEX0NNRF9TRVRfTk9STUFMLA0KPiA+IC0tDQo+ID4gMS45
LjENCj4gPg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg0KDQpCJlINCkhvbmdqaWUNCg==
