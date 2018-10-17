Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C268FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFDA21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gVC545aQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFDA21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeJQVuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:50:35 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:38334 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJQVuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:50:35 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8A2A224E1364;
        Wed, 17 Oct 2018 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539784486; bh=3XUP/aNOaVCxZBxMcQ8JgIF3jZ3UiSuE29jWNckYLPk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gVC545aQE55/ibmLMIsh+Ag1pnmWLWjEAUZoC60EzC41TCSeOtVQs2tHanqUp1PtH
         LikY0gwpEj44zNwC5JIvkMhY1/G7MBQ6oH6x/MyC2FMfRNvM/h4L0P8ll9Vu2flm9P
         dVyOP9SBMFzG5EABOQaif8baAi3ImT9tqvKanpzzPIn4LrLmdXkisuV8xTpcItEFhp
         yxIJucaislx+mpeEo661oLgERNsj/zfrdYobIzz8OkamOKKQiNpQOsKtpI2iNqEMyB
         6O6tjXPv36fh3UPa+q4T/gkGNeV1p0CrY7viQAqFy8N8WNH5zAFpmUMqeSn9hEvlF5
         tbupzBbRkD0pw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 446CA3FA4;
        Wed, 17 Oct 2018 06:54:46 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Oct 2018 06:54:46 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 17 Oct 2018 15:54:43 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] ARC: HSDK: improve reset driver
Thread-Topic: [PATCH v2] ARC: HSDK: improve reset driver
Thread-Index: AQHUV0hfm6bb3R5LokSm5PE/k/eP1KUbeIAAgAf5UAA=
Date:   Wed, 17 Oct 2018 13:54:43 +0000
Message-ID: <1539784482.4199.35.camel@synopsys.com>
References: <20180928162856.4726-1-Eugeniy.Paltsev@synopsys.com>
         <1539346114.6204.5.camel@pengutronix.de>
In-Reply-To: <1539346114.6204.5.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE9256A8329AA54F81FD7F54C6B50A6A@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDE0OjA4ICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSBFdWdlbml5LA0KPiANCj4gdGhhbmsgeW91IGZvciB0aGUgdXBkYXRlLg0KPiANCj4gT24g
RnJpLCAyMDE4LTA5LTI4IGF0IDE5OjI4ICswMzAwLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+
ID4gQXMgZm9yIHRvZGF5IEhTREsgcmVzZXQgZHJpdmVyIGltcGxlbWVudHMgb25seQ0KPiA+IC5y
ZXNldCgpIGNhbGxiYWNrLg0KPiA+IA0KPiA+IEluIGNhc2Ugb2YgZHJpdmVyIHdoaWNoIGltcGxl
bWVudHMgb25lIG9mIHN0YW5kYXJkDQo+ID4gcmVzZXQgY29udHJvbGxlciB1c2FnZSBwYXR0ZXJu
DQo+ID4gKGNhbGwgKl9kZWFzc2VydCgpIGluIHByb2JlKCksIGNhbGwgKl9hc3NlcnQoKSBpbiBy
ZW1vdmUoKSkNCj4gPiB0aGF0IGxlYWRzIHRvIGlub3BlcmFiaWxpdHkgb2YgdGhpcyByZXNldCBk
cml2ZXIuDQo+ID4gDQo+ID4gSW1wcm92ZSBIU0RLIHJlc2V0IGRyaXZlciBieSBjYWxsaW5nIC5y
ZXNldCgpIGNhbGxiYWNrIGluc2lkZSBvZg0KPiA+IC5kZWFzc2VydCgpIGNhbGxiYWNrIHRvIGF2
b2lkIGVhY2ggcmVzZXQgY29udHJvbGxlcg0KPiA+IHVzZXIgYWRhcHRhdGlvbiBmb3Igd29yayB3
aXRoIGJvdGggcmVzZXQgbWV0aG9kcw0KPiA+IChyZXNldCgpIGFuZCB7LmFzc2VydCgpICYgLmRl
YXNzZXJ0KCl9IHBhaXIpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5peSBQYWx0c2V2
IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgdjEt
PnYyOg0KPiA+ICAqIERvbid0IGNhbGwgaHNka19yZXNldF9yZXNldCBpbiAuYXNzZXJ0IGNhbGxi
YWNrLg0KPiA+IA0KPiA+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWhzZGsuYyB8IDEzICsrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC1oc2RrLmMgYi9kcml2ZXJzL3Jlc2V0L3Jl
c2V0LWhzZGsuYw0KPiA+IGluZGV4IDhiY2UzOTFjNjk0My4uMzk5NDQwZjE5N2M1IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtaHNkay5jDQo+ID4gKysrIGIvZHJpdmVycy9y
ZXNldC9yZXNldC1oc2RrLmMNCj4gPiBAQCAtODQsOCArODQsMjEgQEAgc3RhdGljIGludCBoc2Rr
X3Jlc2V0X3Jlc2V0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gIAly
ZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgaW50IGhzZGtfcmVzZXRfZHVt
bXkoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2QsIHVuc2lnbmVkIGxvbmcgaWQpDQo+
ID4gK3sNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBE
b2luZyByZWFsIHJlc2V0IGZyb20gLmFzc2VydCBpc24ndCBuZWNlc3NhcnkvdXNlZnVsIGhlcmUu
IFNvIHdlIHBhc3MNCj4gPiArICogJ2hzZGtfcmVzZXRfZHVtbXknIHRvIC5hc3NlcnQgY2FsbGJh
Y2sgdG8gcHJldmVudCAtRU5PVFNVUFAgcmV0dXJuaW5nIGJ5DQo+ID4gKyAqIHJlc2V0X2NvbnRy
b2xfYXNzZXJ0KCkgdG8gbWFrZSBoYXBweSBkcml2ZXJzIHdoaWNoIGNoZWNrDQo+ID4gKyAqIHJl
c2V0X2NvbnRyb2xfe2Fzc2VydCB8IGRlYXNzZXJ0fSByZXR1cm4gc3RhdHVzLg0KPiA+ICsgKi8N
Cj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyBoc2RrX3Jlc2V0X29w
cyA9IHsNCj4gPiAgCS5yZXNldAk9IGhzZGtfcmVzZXRfcmVzZXQsDQo+ID4gKwkuYXNzZXJ0ID0g
aHNka19yZXNldF9kdW1teSwNCj4gDQo+IElzIHRoaXMgcGFydCByZWFsbHkgbmVjZXNzYXJ5IHRo
b3VnaD8gcmVzZXRfY29udHJvbF9hc3NlcnQgYWxyZWFkeQ0KPiByZXR1cm5zIDAgaW4gc2hhcmVk
IG1vZGUsIHNvIHRoZSBvbmx5IHRoaW5nIHRoaXMgZG9lcyBpcyBtYWtlDQo+IHJlc2V0X2NvbnRy
b2xfYXNzZXJ0IHJldHVybiAwIGluc3RlYWQgb2YgLUVOT1RTVVBQIGluIGV4Y2x1c2l2ZSBtb2Rl
Lg0KPiANCj4gVGhlIGRvY3VtZW50YXRpb24gc3RhdGVzIHRoYXQgY2FsbGluZyByZXNldF9jb250
cm9sX2Fzc2VydCAib24gYW4NCj4gZXhjbHVzaXZlIHJlc2V0IGNvbnRyb2xsZXIgZ3VhcmFudGVl
cyB0aGF0IHRoZSByZXNldCB3aWxsIGJlIGFzc2VydGVkLiINCj4gU2luY2UgdGhpcyBpcyBjbGVh
cmx5IG5vdCB0aGUgY2FzZSB3aXRoIHRoaXMgZHJpdmVyLCBpdCBpcyBhcHByb3ByaWF0ZQ0KPiB0
byBrZWVwIHJldHVybmluZyBhbiBlcnJvciBpbiB0aGlzIGNhc2UuDQo+IA0KPiBJZiB0aGVyZSBp
cyBhIGRyaXZlciB0aGF0IHJlcXVlc3RzIGFuIGV4Y2x1c2l2ZSByZXNldCBjb250cm9sLCBjYWxs
cw0KPiByZXNldF9jb250cm9sX2Fzc2VydCwgYW5kIHRoZW4gY2hlY2tzIHRoZSBlcnJvciB2YWx1
ZSB0byBzZWUgd2hldGhlcg0KPiBhc3NlcnRpbmcgdGhlIHJlc2V0IHN1Y2NlZWRlZCwgaXQgc2hv
dWxkIGJlIG1hZGUgYXdhcmUgdGhhdA0KPiB3ZSBjb3VsZG4ndCBhY3R1YWxseSBhc3NlcnQgdGhl
IHJlc2V0IGxpbmUgYXMgcmVxdWVzdGVkLiBJZiB0aGUgZHJpdmVyDQo+IGNhbiBjb250aW51ZSBv
cGVyYXRpb24gZXZlbiB0aG91Z2ggdGhlIHJlc2V0IGxpbmUgd2FzIG5vdCBhc3NlcnRlZCwNCj4g
aXQgc2hvdWxkIGlnbm9yZSB0aGUgZXJyb3IuDQo+IA0KPiBTbyBpZiB5b3UgbmVlZCB0byBoaWRl
IHRoaXMgZXJyb3IsIEknZCBsaWtlIHRvIGtub3cgdGhlIGFjdHVhbCBjYXNlIHRoYXQNCj4gaXMg
Zml4ZWQgYnkgdGhpcywgdG8gc2VlIGlmIHdlIGNhbid0IGZpeCBpdCBpbiBhIGJldHRlciB3YXku
DQoNCk9rLCBJIGNhbiBkcm9wIGl0IGluIG15IGNhc2UgYXMgaXQgd2lsbCB3b3JrIGZpbmUgd2l0
aCBjZXJ0YWluIGRyaXZlcnM6DQooc2V2ZXJhbCBkcml2ZXJzIHVzZSBzaGFyZWQgcmVzZXQgY29u
dHJvbCwgb3RoZXIgZHJpdmVycyB1c2UgZXhjbHVzaXZlIHJlc2V0DQpjb250cm9sIGJ1dCBkb24n
dCBjaGVjayByZXNldF9jb250cm9sX2Fzc2VydCgpIHJldHVybiB2YWx1ZSkNCg0KSSBzaW1wbHkg
d2FudCB0byBzYXkgdGhhdCB0aGlzIHdvdWxkbid0IHdvcmsgaW4gYWxsIGNhc2VzICh3aXRob3V0
IGNoYW5nZXMNCmluIGRyaXZlciB3aGljaCB1c2UgcmVzZXQgY29udHJvbCkuDQoNCkknbGwgcmVz
cGluIHBhdGNoIHdpdGggdGhpcyBwYXJ0IGRyb3BwZWQuDQoNCj4gPiArCS5kZWFzc2VydCA9IGhz
ZGtfcmVzZXRfcmVzZXQsDQo+IA0KPiBUaGlzIHBhcnQgaXMgZmluZS4NCj4gDQo+ID4gIH07DQo+
ID4gIA0KPiA+ICBzdGF0aWMgaW50IGhzZGtfcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gDQo+IHJlZ2FyZHMNCj4gUGhpbGlwcA0KLS0gDQogRXVnZW5peSBQYWx0
c2V2
