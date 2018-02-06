Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900111-1517914761-2-18415945280435358811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='COM', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517914760; b=JNbrB0Cu06eyskyerVOpgQLKjNB3fkc1jp4PRW2rjsCj9gU
    prrSYvMvqsWVszidhIuNzWbFs1vcSB3MjNW851XDk/P7REWLRh9olKSMTjqlrMBY
    +Evz1DTufJpozDcBNsMydNm9kyV3yAudCUjObL6P7eSBFFC/wyJv0jKXPyAuHloF
    7vyswi1Q8FSq2dw9XAUNBt7mL+CUvmtvkjIQY9AhzoGNuKOsE+QZY/0qOka6lWy5
    idiO2hXA2DoxKmUAAT6oqxI66xlrjr/7trekO62pY/l6x77LqGgzDUOnWnIa07jf
    mtSHYsj4oOHIua0hZTHV+bwTeBrVeCmhflquH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517914760; bh=wcMuKi
    2N/kvrHNIdUPIaN2kYjxSIkSBrwdAk5xzrafM=; b=Xe0DkztGv1hq0P/bfPSN/x
    6aoUMc3vWVBbXXxk8RdEbKkoE8xsLQpS2Y6OgsJjrcuHMFkaFCCehQngtFkDmJAn
    vddSzoS7dg1t6G9OBxKf9G1jT2Yeaqu39/UhBN68qW9Wso6RY8Yz5rw/pi87ZCoM
    boZNRMzxRtb73U6hfHxTGTHIGNGnPY9Fl7dNV51zCm0KKMatw0FJG5A5ujloIssp
    5aaUO1cGOwlWsq7srz4mGx4lKn8/fDVGl3+z5JSfV8EPvIeLBpYaJlp+pgl++lrU
    FNTk2cNIS5lefyfL2WNfdUy1MOJPA3vDL02rqpmTqzpvkJK6SFkwpiUae9T+fUng
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=aculab.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=aculab.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeBFK7S (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:59:18 -0500
Received: from smtp-out6.electric.net ([192.162.217.181]:57978 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFK7R (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 05:59:17 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Xin Long' <lucien.xin@gmail.com>
CC: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [PATCH AUTOSEL for 4.14 019/110] sctp: fix the issue that a __u16
 variable may overflow in sctp_ulpq_renege
Thread-Topic: [PATCH AUTOSEL for 4.14 019/110] sctp: fix the issue that a
 __u16 variable may overflow in sctp_ulpq_renege
Thread-Index: AQHTnRjkYeYOzvAZ1EalFmrzR8HiFaOVsB5ggAGEEACAAASuAA==
Date: Tue, 6 Feb 2018 11:00:04 +0000
Message-ID: <0e6f6c848c3340579c6ee99ba46c4df1@AcuMS.aculab.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-19-alexander.levin@microsoft.com>
 <4eedae3f4cb14e178c073c183ef134c6@AcuMS.aculab.com>
 <CADvbK_eMWn+QbyVqk7yxN4c9+VBV2m8SKK7nUyVWZHMGmmprtw@mail.gmail.com>
In-Reply-To: <CADvbK_eMWn+QbyVqk7yxN4c9+VBV2m8SKK7nUyVWZHMGmmprtw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogWGluIExvbmcNCj4gU2VudDogMDYgRmVicnVhcnkgMjAxOCAxMDo0Mw0KPiBUbzogRGF2
aWQgTGFpZ2h0DQo+IA0KPiBPbiBNb24sIEZlYiA1LCAyMDE4IGF0IDc6MzUgUE0sIERhdmlkIExh
aWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+IEZyb206IFNhc2hhIExl
dmluDQo+ID4+IFNlbnQ6IDAzIEZlYnJ1YXJ5IDIwMTggMTg6MDENCj4gPj4gWyBVcHN0cmVhbSBj
b21taXQgNWM0Njg2NzRkMTcwNTYxNDhkYTA2MjE4ZDRkYTVkMDRiYWYyMmVhYyBdDQo+ID4+DQo+
ID4+IE5vdyB3aGVuIHJlbmVnaW5nIGV2ZW50cyBpbiBzY3RwX3VscHFfcmVuZWdlKCksIHRoZSB2
YXJpYWJsZSBmcmVlZA0KPiA+PiBjb3VsZCBiZSBpbmNyZWFzZWQgYnkgYSBfX3UxNiB2YWx1ZSB0
d2ljZSB3aGlsZSBmcmVlZCBpcyBvZiBfX3UxNg0KPiA+PiB0eXBlLiBJdCBtZWFucyBmcmVlZCBt
YXkgb3ZlcmZsb3cgYXQgdGhlIHNlY29uZCBhZGRpdGlvbi4NCj4gPj4NCj4gPj4gVGhpcyBwYXRj
aCBpcyB0byBmaXggaXQgYnkgdXNpbmcgX191MzIgdHlwZSBmb3IgJ2ZyZWVkJywgd2hpbGUgYXQN
Cj4gPj4gaXQsIGFsc28gdG8gcmVtb3ZlICdpZiAoY2h1bmspJyBjaGVjaywgYXMgYWxsIHJlbmVn
ZSBjb21tYW5kcyBhcmUNCj4gPj4gZ2VuZXJhdGVkIGluIHNjdHBfZWF0X2RhdGEgYW5kIGl0IGNh
bid0IGJlIE5VTEwuDQo+ID4+DQo+ID4+IFJlcG9ydGVkLWJ5OiBNYXJjZWxvIFJpY2FyZG8gTGVp
dG5lciA8bWFyY2Vsby5sZWl0bmVyQGdtYWlsLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWGlu
IExvbmcgPGx1Y2llbi54aW5AZ21haWwuY29tPg0KPiA+PiBBY2tlZC1ieTogTmVpbCBIb3JtYW4g
PG5ob3JtYW5AdHV4ZHJpdmVyLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgUy4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZp
biA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgbmV0L3Nj
dHAvdWxwcXVldWUuYyB8IDI0ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAgMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9uZXQvc2N0cC91bHBxdWV1ZS5jIGIvbmV0L3NjdHAvdWxwcXVldWUuYw0KPiA+
PiBpbmRleCBhNzFiZTMzZjNhZmUuLmUzNmVjNWRkNjRjNiAxMDA2NDQNCj4gPj4gLS0tIGEvbmV0
L3NjdHAvdWxwcXVldWUuYw0KPiA+PiArKysgYi9uZXQvc2N0cC91bHBxdWV1ZS5jDQo+ID4+IEBA
IC0xMDg0LDI5ICsxMDg0LDIxIEBAIHZvaWQgc2N0cF91bHBxX3BhcnRpYWxfZGVsaXZlcnkoc3Ry
dWN0IHNjdHBfdWxwcSAqdWxwcSwNCj4gPj4gIHZvaWQgc2N0cF91bHBxX3JlbmVnZShzdHJ1Y3Qg
c2N0cF91bHBxICp1bHBxLCBzdHJ1Y3Qgc2N0cF9jaHVuayAqY2h1bmssDQo+ID4+ICAgICAgICAg
ICAgICAgICAgICAgZ2ZwX3QgZ2ZwKQ0KPiA+PiAgew0KPiA+PiAtICAgICBzdHJ1Y3Qgc2N0cF9h
c3NvY2lhdGlvbiAqYXNvYzsNCj4gPj4gLSAgICAgX191MTYgbmVlZGVkLCBmcmVlZDsNCj4gPj4g
LQ0KPiA+PiAtICAgICBhc29jID0gdWxwcS0+YXNvYzsNCj4gPj4gKyAgICAgc3RydWN0IHNjdHBf
YXNzb2NpYXRpb24gKmFzb2MgPSB1bHBxLT5hc29jOw0KPiA+PiArICAgICBfX3UzMiBmcmVlZCA9
IDA7DQo+ID4+ICsgICAgIF9fdTE2IG5lZWRlZDsNCj4gPj4NCj4gPj4gLSAgICAgaWYgKGNodW5r
KSB7DQo+ID4+IC0gICAgICAgICAgICAgbmVlZGVkID0gbnRvaHMoY2h1bmstPmNodW5rX2hkci0+
bGVuZ3RoKTsNCj4gPj4gLSAgICAgICAgICAgICBuZWVkZWQgLT0gc2l6ZW9mKHN0cnVjdCBzY3Rw
X2RhdGFfY2h1bmspOw0KPiA+PiAtICAgICB9IGVsc2UNCj4gPj4gLSAgICAgICAgICAgICBuZWVk
ZWQgPSBTQ1RQX0RFRkFVTFRfTUFYV0lORE9XOw0KPiA+PiAtDQo+ID4+IC0gICAgIGZyZWVkID0g
MDsNCj4gPj4gKyAgICAgbmVlZGVkID0gbnRvaHMoY2h1bmstPmNodW5rX2hkci0+bGVuZ3RoKSAt
DQo+ID4+ICsgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3Qgc2N0cF9kYXRhX2NodW5rKTsNCj4g
Pj4NCj4gPj4gICAgICAgaWYgKHNrYl9xdWV1ZV9lbXB0eSgmYXNvYy0+YmFzZS5zay0+c2tfcmVj
ZWl2ZV9xdWV1ZSkpIHsNCj4gPj4gICAgICAgICAgICAgICBmcmVlZCA9IHNjdHBfdWxwcV9yZW5l
Z2Vfb3JkZXIodWxwcSwgbmVlZGVkKTsNCj4gPj4gLSAgICAgICAgICAgICBpZiAoZnJlZWQgPCBu
ZWVkZWQpIHsNCj4gPj4gKyAgICAgICAgICAgICBpZiAoZnJlZWQgPCBuZWVkZWQpDQo+ID4+ICAg
ICAgICAgICAgICAgICAgICAgICBmcmVlZCArPSBzY3RwX3VscHFfcmVuZWdlX2ZyYWdzKHVscHEs
IG5lZWRlZCAtIGZyZWVkKTsNCj4gPj4gLSAgICAgICAgICAgICB9DQo+ID4+ICAgICAgIH0NCj4g
Pj4gICAgICAgLyogSWYgYWJsZSB0byBmcmVlIGVub3VnaCByb29tLCBhY2NlcHQgdGhpcyBjaHVu
ay4gKi8NCj4gPj4gLSAgICAgaWYgKGNodW5rICYmIChmcmVlZCA+PSBuZWVkZWQpKSB7DQo+ID4+
IC0gICAgICAgICAgICAgaW50IHJldHZhbDsNCj4gPj4gLSAgICAgICAgICAgICByZXR2YWwgPSBz
Y3RwX3VscHFfdGFpbF9kYXRhKHVscHEsIGNodW5rLCBnZnApOw0KPiA+PiArICAgICBpZiAoZnJl
ZWQgPj0gbmVlZGVkKSB7DQo+ID4+ICsgICAgICAgICAgICAgaW50IHJldHZhbCA9IHNjdHBfdWxw
cV90YWlsX2RhdGEodWxwcSwgY2h1bmssIGdmcCk7DQo+ID4+ICAgICAgICAgICAgICAgLyoNCj4g
Pj4gICAgICAgICAgICAgICAgKiBFbnRlciBwYXJ0aWFsIGRlbGl2ZXJ5IGlmIGNodW5rIGhhcyBu
b3QgYmVlbg0KPiA+PiAgICAgICAgICAgICAgICAqIGRlbGl2ZXJlZDsgb3RoZXJ3aXNlLCBkcmFp
biB0aGUgcmVhc3NlbWJseSBxdWV1ZS4NCj4gPg0KPiA+IEhtbW0uLi4NCj4gPiBJU1RNIHRoYXQg
YWxsIHRoZSBtYXRocyBzaG91bGQgYmUgZG9uZSB1c2luZyAndW5zaWduZWQgaW50JyB0byBhdm9p
ZCBob3JyaWQNCj4gPiBtYXNraW5nIG9wZXJhdGlvbnMgb24gbWFueSBjcHVzLi4uLg0KPiBZb3Ug
bWVhbnQgJ2lmICh1MzIgPj0gdTE2KScgaXMgbm90IGdvb2QgPw0KPiBJZiBzbywgSSBkaWQgc29t
ZSB0ZXN0czoNCj4gDQo+ICMgeC5jDQo+IGludCBtYWluKCkNCj4gew0KPiB1bnNpZ25lZCBpbnQg
YSA9IDE7DQo+IHVuc2lnbmVkIHNob3J0IGIgPSAxOw0KPiANCj4gaWYgKGEgPiBiKSA8LS0tLQ0K
PiBhKys7DQo+IH0NCj4gDQo+ICMgeS5jDQo+IGludCBtYWluKCkNCj4gew0KPiB1bnNpZ25lZCBp
bnQgYSA9IDE7DQo+IHVuc2lnbmVkIGludCBiID0gMTsNCj4gDQo+IGlmIChhID4gYikgIDwtLS0t
DQo+IGErKzsNCj4gfQ0KPiANCj4gIyB4LnMNCj4gbW92bCAkMSwgLTQoJXJicCkNCj4gbW92dyAk
MSwgLTYoJXJicCkNCj4gbW92endsIC02KCVyYnApLCAlZWF4DQo+IGNtcGwgLTQoJXJicCksICVl
YXgNCj4gDQo+ICMgeS5zDQo+IG1vdmwgJDEsIC00KCVyYnApDQo+IG1vdmwgJDEsIC04KCVyYnAp
DQo+IG1vdmwgLTQoJXJicCksICVlYXgNCj4gY21wbCAtOCglcmJwKSwgJWVheA0KPiANCj4gDQo+
IFNvIGxvb2tzIGxpa2UgeC5jIHZzIHkuYyBpczoNCj4gbW92endsIHZzIG1vdmwNCj4gDQo+IGRv
ZXMgaXQgbWF0dGVyPw0KDQpDb21waWxlIGl0IGZvciBzb21ldGhpbmcgb3RoZXIgdGhhbiB4ODYu
DQoNCglEYXZpZA0K
