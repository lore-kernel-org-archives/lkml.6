Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E7DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D2E2175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D2E2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeHCNGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:06:22 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:55562 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727184AbeHCNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:06:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-22-6NjIHZlePjGB6OJdcNaijQ-1; Fri, 03 Aug 2018 12:10:30 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 3 Aug 2018 12:12:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 Aug 2018 12:12:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'maninder1.s@samsung.com'" <maninder1.s@samsung.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: RE: [PATCH 1/1] selftest/net: fix FILE_SIZE for 32 bit architecture.
Thread-Topic: [PATCH 1/1] selftest/net: fix FILE_SIZE for 32 bit architecture.
Thread-Index: AQHUKtvZkUY9sIl4kkCbZJKY4M717aSt33bA
Date:   Fri, 3 Aug 2018 11:12:06 +0000
Message-ID: <4f2c8d694dce4125a609e8d5383ebe36@AcuMS.aculab.com>
References: <4a412194-99aa-7969-54a4-727368fbf82c@gmail.com>
        <20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0~HCuTv0d7l2131721317epcas5p4u@epcas5p4.samsung.com>
        <CGME20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0@epcms5p1>
 <20180803033159epcms5p1dd2f5a6834268e9a22efa15421795fa0@epcms5p1>
In-Reply-To: <20180803033159epcms5p1dd2f5a6834268e9a22efa15421795fa0@epcms5p1>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: 6NjIHZlePjGB6OJdcNaijQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFuaW5kZXIgU2luZ2gNCj4gU2VudDogMDMgQXVndXN0IDIwMTggMDQ6MzINCj4gPk9u
IDA4LzAyLzIwMTggMDM6MzEgQU0sIE1hbmluZGVyIFNpbmdoIHdyb3RlOg0KPiA+PiBGSUxFX1Na
IGlzIGRlZmluZWQgYXMgKDFVTCA8PCAzNSksIGl0IHdpbGwgb3ZlcmZsb3cNCj4gPj4gZm9yIDMy
IGJpdCBzeXN0ZW0gYW5kIGxvZ2ljIHdpbGwgYnJlYWsuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IE1hbmluZGVyIFNpbmdoIDxtYW5pbmRlcjEuc0BzYW1zdW5nLmNvbT4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogVmFuZWV0IE5hcmFuZyA8di5uYXJhbmdAc2Ftc3VuZy5jb20+DQo+ID4+IC0tLQ0K
PiA+PiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3RjcF9tbWFwLmMgfCA4ICsrKystLS0t
DQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3RjcF9t
bWFwLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvdGNwX21tYXAuYw0KPiA+PiBpbmRl
eCBlOGM1ZGZmLi4xZDZjYTEyIDEwMDY0NA0KPiA+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9uZXQvdGNwX21tYXAuYw0KPiA+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9u
ZXQvdGNwX21tYXAuYw0KPiA+PiBAQCAtODUsNyArODUsNyBAQA0KPiA+PiAgI2RlZmluZSBNU0df
WkVST0NPUFkgICAgMHg0MDAwMDAwDQo+ID4+ICAjZW5kaWYNCj4gPj4NCj4gPj4gLSNkZWZpbmUg
RklMRV9TWiAoMVVMIDw8IDM1KQ0KPiA+PiArI2RlZmluZSBGSUxFX1NaICgxVUxMIDw8IDM1KQ0K
PiANCj4gLi4uDQo+IC4uLg0KPiA+PiBAQCAtNDMxLDcgKzQzMSw3IEBAIGludCBtYWluKGludCBh
cmdjLCBjaGFyICphcmd2W10pDQo+ID4+ICAgICAgICAgICAgICAgICAgemZsZyA9IDA7DQo+ID4+
ICAgICAgICAgIH0NCj4gPj4gICAgICAgICAgd2hpbGUgKHRvdGFsIDwgRklMRV9TWikgew0KPiA+
PiAtICAgICAgICAgICAgICAgIGxvbmcgd3IgPSBGSUxFX1NaIC0gdG90YWw7DQo+ID4+ICsgICAg
ICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBsb25nIHdyID0gRklMRV9TWiAtIHRvdGFsOw0KPiA+
Pg0KPiA+PiAgICAgICAgICAgICAgICAgIGlmICh3ciA+IGNodW5rX3NpemUpDQo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICB3ciA9IGNodW5rX3NpemU7DQo+ID4+DQo+ID4NCj4gPldoYXQg
YWJvdXQgdXNpbmcgbW9yZSBjb252ZW50aW9uYWwgc2l6ZV90IGluc3RlYWQgb2YgInVuc2lnbmVk
IGxvbmcgbG9uZyIgPw0KPiANCj4gc2l6ZV90IGlzIGFsc28gZXF1aXZhbGVudCB0byB1bnNpZ25l
ZCBsb25nIGFuZCBpdCB3aWxsIG5vdCBob2xkIHZhbHVlIG9mICgxIDw8IDM1KSBmb3IgMzIgYml0
IHN5c3RlbS4NCj4gU28gd2UgY2FuIGRvIHR3byB0aGluZ3MuDQoNCldvdWxkbid0IHRoZSAnY29y
cmVjdCcgdHlwZSBiZSBvZmZfdCA/DQpJbiBhbnkgY2FzZSwgSUlSQywgeW91IGhhdmUgdG8gZG8g
cmVhbGx5IGhvcnJpZCB0aGluZ3MgaW4gTGludXggdG8NCmFjY2VzcyBmaWxlcyBsYXJnZXIgdGhh
biAyRyBvbiAzMmJpdCBzeXN0ZW1zLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

