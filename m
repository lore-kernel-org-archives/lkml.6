Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF95FC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6CD216F6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6CD216F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHOEdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:33:50 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:59277
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbeHOEdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:33:49 -0400
X-ASG-Debug-ID: 1534297428-093b7e070010470001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id gBExAc9crzLaiQdo (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO); Wed, 15 Aug 2018 09:43:48 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.847.32; Wed, 15 Aug 2018 09:43:56 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.0847.030; Wed, 15 Aug 2018 09:43:38 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Thread-Topic: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for
 non-strict mode
X-ASG-Orig-Subj: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Thread-Index: AQHULSVfvpgJoo0nvEihhr7Wc+EfZ6S+cpuAgAAAX4CAABiMAIABBouA
Date:   Wed, 15 Aug 2018 01:43:37 +0000
Message-ID: <7a2dedda98aa9e677eb7f85b6b55e34e0128d2d9.camel@hxt-semitech.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
         <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
         <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
         <5B597628.2020103@huawei.com>
         <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
         <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
         <5B7293E5.7040702@huawei.com> <20180814083500.GA28101@arm.com>
         <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
In-Reply-To: <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E537546CE3891F45BCB0B612902F0F8B@hxt-semitech.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1534297428
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5832 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.55695
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYmluLA0KDQpPbiBUdWUsIDIwMTgtMDgtMTQgYXQgMTE6MDIgKzAxMDAsIFJvYmluIE11
cnBoeSB3cm90ZToNCj4gT24gMTQvMDgvMTggMDk6MzUsIFdpbGwgRGVhY29uIHdyb3RlOg0KPiA+
IE9uIFR1ZSwgQXVnIDE0LCAyMDE4IGF0IDA0OjMzOjQxUE0gKzA4MDAsIExlaXpoZW4gKFRodW5k
ZXJUb3duKQ0KPiA+IHdyb3RlOg0KPiA+ID4gT24gMjAxOC84LzYgOTozMiwgWWFuZywgU2h1bnlv
bmcgd3JvdGU6DQo+ID4gPiA+IE9uIDIwMTgvNy8yNiAyMjozNywgUm9iaW4gTXVycGh5IHdyb3Rl
Og0KPiA+ID4gPiA+IEJlY2F1c2UgRE1BIGNvZGUgaXMgbm90IHRoZSBvbmx5IGNhbGxlciBvZiBp
b21tdV9tYXAvdW5tYXAuDQo+ID4gPiA+ID4gSXQncw0KPiA+ID4gPiA+IHBlcmZlY3RseSBsZWdh
bCBpbiB0aGUgSU9NTVUgQVBJIHRvIHBhcnRpYWxseSB1bm1hcCBhDQo+ID4gPiA+ID4gcHJldmlv
dXMgbWFwcGluZw0KPiA+ID4gPiA+IHN1Y2ggdGhhdCBhIGJsb2NrIGVudHJ5IG5lZWRzIHRvIGJl
IHNwbGl0LiBUaGUgRE1BIEFQSSwNCj4gPiA+ID4gPiBob3dldmVyLCBpcyBhDQo+ID4gPiA+ID4g
bG90IG1vcmUgY29uc3RyaW5lZCwgYW5kIHRodXMgYnkgY29uc3RydWN0aW9uIHRoZSBpb21tdS1k
bWENCj4gPiA+ID4gPiBsYXllciB3aWxsDQo+ID4gPiA+ID4gbmV2ZXIgZ2VuZXJhdGUgYSBibG9j
ay1zcGxpdHRpbmcgaW9tbXVfdW5tYXAoKSBleGNlcHQgYXMgYQ0KPiA+ID4gPiA+IHJlc3VsdCBv
Zg0KPiA+ID4gPiA+IGlsbGVnYWwgRE1BIEFQSSB1c2FnZSwgYW5kIHdlIG9idmlvdXNseSBkbyBu
b3QgbmVlZCB0bw0KPiA+ID4gPiA+IG9wdGltaXNlIGZvciB0aGF0DQo+ID4gPiA+ID4gKHlvdSB3
aWxsIGdldCBhIHdhcm5pbmcgYWJvdXQgbWlzbWF0Y2hlZCB1bm1hcHMgdW5kZXIgZG1hLQ0KPiA+
ID4gPiA+IGRlYnVnLCBidXQNCj4gPiA+ID4gPiBpdCdzIGEgYml0IHRvbyBleHBlbnNpdmUgdG8g
cG9saWNlIGluIHRoZSBnZW5lcmFsIGNhc2UpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+
ID4gV2hlbiBJIHdhcyByZWFkaW5nIHRoZSBjb2RlIGFyb3VuZCBhcm1fbHBhZV9zcGxpdF9ibGtf
dW5tYXAoKSwNCj4gPiA+ID4gSSB3YXMNCj4gPiA+ID4gY3VyaW91cyBpbiB3aGljaCBzY2VuYXJp
byBhIGJsb2NrIHdpbGwgYmUgc3BsaXQuIE5vdyB3aXRoIHlvdXINCj4gPiA+ID4gY29tbWVudHMN
Cj4gPiA+ID4gIkJlY2F1c2UgRE1BIGNvZGUgaXMgbm90IHRoZSBvbmx5IGNhbGxlciBvZiBpb21t
dV9tYXAvdW5tYXAiLA0KPiA+ID4gPiBpdCBzZWVtcw0KPiA+ID4gPiBkZXBlbmRpbmcgb24gdGhl
IHVzZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBXb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gdGhpcyBm
dXJ0aGVyPyBJIG1lYW4gYmVzaWRlcyBETUEsDQo+ID4gPiA+IHdoaWNoIHVzZXINCj4gPiA+ID4g
d2lsbCB1c2UgaW9tbXVfbWFwL3VtYXAgYW5kIGhvdyBpdCBzcGxpdCBhIGJsb2NrLg0KPiA+ID4g
DQo+ID4gPiBJIGFsc28gdGhpbmsgdGhhdCBhcm1fbHBhZV9zcGxpdF9ibGtfdW5tYXAoKSBzY2Vu
YXJpbyBpcyBub3QNCj4gPiA+IGV4aXN0LCBtYXliZQ0KPiA+ID4gd2Ugc2hvdWxkIHJlbW92ZSBp
dCwgYW5kIGdpdmUgYSB3YXJuaW5nIGZvciB0aGlzIHdyb25nIHVzYWdlLg0KPiA+IA0KPiA+IENh
bid0IGl0IGhhcHBlbiB3aXRoIFZGSU8/DQo+IA0KPiAuLi5vciBHUFUgZHJpdmVycywgb3IgYW55
b25lIGVsc2UgbWFuYWdpbmcgdGhlaXIgb3duIElPTU1VIGRvbWFpbiANCj4gZGlyZWN0bHkuIEEg
c2VxdWVuY2UgbGlrZSB0aGlzIGlzIHBlcmZlY3RseSBsZWdhbDoNCj4gDQo+IAlpb21tdV9tYXAo
ZG9tYWluLCBpb3ZhLCBwYWRkciwgU1pfOE0sIHByb3QpOw0KPiAJLi4uDQo+IAlpb21tdV91bm1h
cChkb21haW4sIGlvdmEgKyBTWl8xTSAqIDUsIFNaXzFNICogMyk7DQo+IA0KPiB3aGVyZSBpZiBp
b3ZhIGFuZCBwYWRkciBoYXBwZW4gdG8gYmUgc3VpdGFibHkgYWxpZ25lZCwgdGhlIG1hcCB3aWxs
DQo+IGxheSANCj4gZG93biBibG9ja3MsIGFuZCB0aGUgdW5tYXAgd2lsbCB0aGVuIGhhdmUgdG8g
c3BsaXQgb25lIG9mIHRoZW0gaW50byANCj4gcGFnZXMgdG8gcmVtb3ZlIGhhbGYgb2YgaXQuIFdl
IGRvbid0IHRlYXIgb3VyIGhhaXIgb3V0IG1haW50YWluaW5nIA0KPiBzcGxpdF9ibGtfdW5tYXAo
KSBmb3IgdGhlIGZ1biBvZiBpdCA6KA0KDQpUaGFuayB5b3UgZm9yIHRoZSBHUFUgZXhhbXBsZS4g
QnV0IGZvciBWRklPLCBJIHJlbWVtYmVyIGFsbCBtZW1vcnkgd2lsbA0KYmUgICBwaW5uZWQgaW4g
dGhlIGVhcmx5IHN0YWdlIG9mIGVtdWxhdG9yIChzdWNoIGFzIHFlbXUpIHN0YXJ0LiBTbywNCnRo
ZSBzcGxpdCB3aWxsIG9jY3VyIGF0IHdoaWNoIG9wZXJhdGlvbj8gTWF5YmUgdmlydGlvIGJhbGxv
b24gaW5mbGF0ZT8NCg0KVGhhbmtzLg0KU2h1bnlvbmcuDQoNCj4gDQo+IFJvYmluLg==
