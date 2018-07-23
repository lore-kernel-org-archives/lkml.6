Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D27ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE6C20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kBS6hzGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE6C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbeGWI1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:27:37 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:40509 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbeGWI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:27:37 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BEDF324E2524;
        Mon, 23 Jul 2018 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532330866; bh=8PF3OTMhZQTlHGLuA4dQXhUC+W6O/gvLVOsKZq7aids=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kBS6hzGostuZz+cr9ndJz5Pi59FZMec8gwtljwVUA5ULzXTvJGZxoPKnuI6N6ARy4
         qzUTOlCEYaNUtxXq0OHSlfSeilC+kxtaNuODi/bsRccUVGUmgpqyjuMvRFMVDUUNKd
         469qDq7hhHJ5i7cQB5d6FWsr+c2kIu/t83phSRutFopHyE81jN7PBr58Ca5D6BmFXG
         PtKj+Rrr5i+8P+vxOrBLXeHoiq3o7aSJg0oT6XWZl3P94ezDCRTIJ9pvshw4dcGYW6
         D+Z4MRTmTIbKcv0UnfPsPzu+j8XOHg++4eUt4a9x2eNd9Vpbw0d4cGrdY1at68s9Lk
         mBmyiqN/ifkiw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 909DE3FD9;
        Mon, 23 Jul 2018 00:27:46 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 23 Jul 2018 00:27:46 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 23 Jul 2018 09:27:44 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "ericp@nextivr.com" <ericp@nextivr.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Dell TB16 dock: xHCI host controller dies on USB device
 connection
Thread-Topic: Dell TB16 dock: xHCI host controller dies on USB device
 connection
Thread-Index: AQHUIlSRkH0J+EgXHU2LCJcN3HS/uKScRxgA
Date:   Mon, 23 Jul 2018 07:27:43 +0000
Message-ID: <76cfa7afa7489d4fa6433dd49dc00a413a7dd499.camel@synopsys.com>
References: <2ec8a6e3447011297ffd7c08e13a8817702ceb64.camel@synopsys.com>
In-Reply-To: <2ec8a6e3447011297ffd7c08e13a8817702ceb64.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <015045F104B4414C8F166F2814E7E61E@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIE1vbiwgMjAxOC0wNy0yMyBhdCAxMDoxMiArMDMwMCwgQWxleGV5IEJyb2Rr
aW4gd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gSSB1c2UgRGVsbCA3NDgwIGxhcHRvcCBjb25uZWN0
ZWQgdG8gRGVsbCBUQjE2IFRodW5kZXJib2x0IGRvY2tpbmcgc3RhdGlvbi4NCj4gT25jZSBpbiBh
IHdoaWxlIHdoZW4gVVNCIGRldmljZSBnZXRzIGNvbm5lY3RlZCB0byBEZWxsIFRCMTYgZG9jayBp
dHMgeEhDSSBjb250cm9sbGVyICJkaWVzIi4NCj4gVG8gcmVjb3ZlciBpdHMgZnVuY3Rpb25hbGl0
eSBpdCdzIHJlcXVpcmVkIHRvIHJlY29ubmVjdCBUaHVuZGVyYm9sdCBjYWJsZS4NCj4gDQo+IFdo
YXQncyBpbnRlcmVzdGluZyB2aWRlbyBvdXRwdXQgdG8gZXh0ZXJuYWwgbW9uaXRvciBjb25uZWN0
ZWQgdG8gdGhlIHNhbWUgb25lIGRvY2sgd29ya3MgYWxsIHRoZSB0aW1lIGZsYXdsZXNzbHkuDQo+
IA0KPiBWZXJzaW9uLVJlbGVhc2UgbnVtYmVyIG9mIHNlbGVjdGVkIGNvbXBvbmVudCAoaWYgYXBw
bGljYWJsZSk6DQo+IEN1cnJlbnRseSBJJ20gb24gRmVkb3JhLTI4IHdpdGgga2VybmVsIDQuMTcu
My0yMDAuZmMyOC54ODZfNjQgYnV0IHRoYXQgaXNzdWVzIGhhcyBiZWVuIHNlZW4gZnJvbSB0aGUg
dmVyeSBiZWdpbm5pbmcNCj4gKGNhbm5vdCByZWNhbGwgZXhhY3Qga2VybmVsIHZlcnNpb24gSSBz
dGFydGVkIGZyb20gd2l0aCB0aGF0IGxhcHRvcCwgSSBndWVzcyBpdCB3YXMgNC4xNC55IG9yIDQu
MTUueSkuDQo+IA0KPiBIb3cgcmVwcm9kdWNpYmxlOg0KPiBPbmNlIGluIGEgd2hpbGUsIGkuZS4g
bm90IG9uIGV2ZXJ5IGNvbm5lY3Rpb24gb2YgVVNCIGRldmljZSBidXQgcHJldHR5IG9mdGVuLiBM
aWtlIGV2ZXJ5IDEwdGggdGltZS4NCj4gDQo+IFN0ZXBzIHRvIFJlcHJvZHVjZToNCj4gMS4gUGx1
Zy1pbiBVU0IgZGV2aWNlIChjb3VsZCBiZSBhbnl0aGluZyBsaWtlIEZUREkgVVNCLXRvLVNlcmlh
bCBjYWJsZSwgc21hcnRwaG9uZSwgYW55dGhpbmcpcmVwZWF0Lg0KPiANCj4gMi4gV2FpdCBmb3Ig
YXQgbGVhc3QgYSBtaW51dGUgKGZvciBVU0IgZGV2aWNlIGdldHMgcmVjb2duaXplZCBhbmQgaWYg
eEhDSSBjb250cm9sbGVyIHN0b3BzIHRvIHJlc3BvbmQga2VybmVsIHdpbGwgZGlzYWJsZSBpdCB3
aGljaCB3aWxsIGJlIHZpc2libGUNCj4gaWYNCj4gdGhlcmUncyBzb21ldGhpbmcgbGlrZSBtb3Vz
ZS9rZXlib2FyZC9hdWRpb2NhcmQgaXMgY29ubmVjdGVkIHRvIHRoZSBkb2NrIGFzIHdlbGwgLSBz
byBpdCB3aWxsIHN0b3AgdG8gd29yaykNCj4gDQo+IDMuIElmIG5vdGhpbmcgaGFwcGVucyAtIHVu
cGx1ZyBhbmQgcmVwZWF0IGZyb20gKDEpLg0KPiANCj4gQWN0dWFsIHJlc3VsdHM6DQo+IEluIGRt
ZXNnIHRoZSBmb2xsb3dpbmcgd2lsbCBhcHBlYXI6DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBbIDYxNjMu
NzEzMzQxXSB1c2IgMy0xLjM6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDkgdXNp
bmcgeGhjaV9oY2QNCj4gWyA2MTY5LjQyMTQxOF0gdXNiIDMtMS4zOiBkZXZpY2UgZGVzY3JpcHRv
ciByZWFkL2FsbCwgZXJyb3IgLTExMA0KPiBbIDYxNzUuOTY2MzYyXSB4aGNpX2hjZCAwMDAwOjBi
OjAwLjA6IHhIQ0kgaG9zdCBub3QgcmVzcG9uZGluZyB0byBzdG9wIGVuZHBvaW50IGNvbW1hbmQu
DQo+IFsgNjE3Ni4wNTcyMTNdIHhoY2lfaGNkIDAwMDA6MGI6MDAuMDogSG9zdCBoYWx0IGZhaWxl
ZCwgLTExMA0KPiBbIDYxNzYuMDU3MjE0XSB4aGNpX2hjZCAwMDAwOjBiOjAwLjA6IHhIQ0kgaG9z
dCBjb250cm9sbGVyIG5vdCByZXNwb25kaW5nLCBhc3N1bWUgZGVhZA0KPiBbIDYxNzYuMDU3MjI0
XSByODE1MiA0LTEuMToxLjAgZW5wMTFzMHUxdTE6IFN0b3Agc3VibWl0dGluZyBpbnRyLCBzdGF0
dXMgLTEwOA0KPiBbIDYxNzYuMDU3MjI3XSByODE1MiA0LTEuMjoxLjAgZW5wMTFzMHUxdTI6IFN0
b3Agc3VibWl0dGluZyBpbnRyLCBzdGF0dXMgLTEwOA0KPiBbIDYxNzYuMDU3MjM1XSB4aGNpX2hj
ZCAwMDAwOjBiOjAwLjA6IEhDIGRpZWQ7IGNsZWFuaW5nIHVwDQo+IFsgNjE3Ni4wNTczMDBdIHVz
YiAzLTEtcG9ydDM6IGNhbm5vdCBkaXNhYmxlIChlcnIgPSAtMTEwKQ0KPiBbIDYxNzYuMDU3MzMy
XSB1c2IgMy0xLXBvcnQzOiBjb3VsZG4ndCBhbGxvY2F0ZSB1c2JfZGV2aWNlDQo+IFsgNjE3Ni4w
NTczMzhdIHVzYiAzLTEuNTogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIgMw0KPiBbIDYx
NzYuMDU3Mzg2XSB1c2IgMy0xOiBVU0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciAyDQo+IFsg
NjE3Ni4wNTc3MTNdIHVzYiA0LTE6IFVTQiBkaXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDINCj4g
WyA2MTc2LjA1NzcxNV0gdXNiIDQtMS4xOiBVU0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciAz
DQo+IFsgNjE3Ni4wNTgzMzVdIHVzYiAzLTEuNzogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1i
ZXIgNA0KPiBbIDYxNzYuMDU4MzM2XSB1c2IgMy0xLjcuMTogVVNCIGRpc2Nvbm5lY3QsIGRldmlj
ZSBudW1iZXIgNQ0KPiBbIDYxNzYuMDgwMzA5XSB1c2IgNC0xLjI6IFVTQiBkaXNjb25uZWN0LCBk
ZXZpY2UgbnVtYmVyIDQNCj4gWyA2MTc2LjA4MDc3Nl0gdXNiIDMtMS43LjM6IFVTQiBkaXNjb25u
ZWN0LCBkZXZpY2UgbnVtYmVyIDYNCj4gWyA2MTc2LjEwNTIxMV0gdXNiIDMtMS43LjQ6IFVTQiBk
aXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDgNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCk1heWJlIEkgc2Vu
dCBwcmV2aW91cyBlbWFpbCBhIGJpdCB0b28gc29vbiBhcyB0aGVyZSdzIGFscmVhZHkNCmEgZml4
IGZyb20gTWF0aGlhcyBbMV0gaW4gTGludXMnIHRyZWUuDQoNCk9uY2UgaXQgZ2V0cyBiYWNrLXBv
cnRlZCB0byA0LjE3LnkgYnJhbmNoIGFuZCBjb3JyZXNwb25kaW5nIGtlcm5lbCB1cGRhdGUNCmhp
dHMgRmVkb3JhJ3MgcmVwb3Mgd2UnbGwgc2VlIGlmIGl0IG1ha2VzIGFueSBkaWZmZXJlbmNlLg0K
DQpTb3JyeSBmb3IgdGhlIG5vaXNlIHRob3VnaC4NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lk
PTIyOWJjMTlmZDdhY2E0ZjM3OTY0YWYwNmUzNTgzYzFjOGYzNmI1ZDYNCg0KLUFsZXhleQ==
