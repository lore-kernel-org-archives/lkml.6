Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC74FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA6A20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA6A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=med.uni-goettingen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeICME6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:04:58 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:39410 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbeICME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:04:58 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 08:04:56 EDT
Received: from umg-exc-2.ads.local.med.uni-goettingen.de ([10.76.100.69]:16362)
        by mail1.med.uni-goettingen.de with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Uecker@med.uni-goettingen.de>)
        id 1fwjSP-0007dH-0Z; Mon, 03 Sep 2018 09:39:33 +0200
Received: from UMG-EXC-1.ads.local.med.uni-goettingen.de
 ([fe80::c97f:60fd:6a2d:e4b9]) by umg-exc-2.ads.local.med.uni-goettingen.de
 ([fe80::40b1:448:7be6:e2cf%13]) with mapi id 14.03.0361.001; Mon, 3 Sep 2018
 09:39:32 +0200
From:   "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VLAs and security
Thread-Topic: VLAs and security
Thread-Index: AQHUQpQcK6e7hvTWREaSPdTt5naSaqTdIVGAgADqgQA=
Date:   Mon, 3 Sep 2018 07:39:31 +0000
Message-ID: <1535960372.32005.1.camel@med.uni-goettingen.de>
References: <1535875700.17858.3.camel@med.uni-goettingen.de>
         <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
In-Reply-To: <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8764BF844B235A41BBB47E9CED6584B5@ads.local.med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gU29ubnRhZywgZGVuIDAyLjA5LjIwMTgsIDEwOjQwIC0wNzAwIHNjaHJpZWIgS2VlcyBDb29r
Og0KPiBPbiBTdW4sIFNlcCAyLCAyMDE4IGF0IDE6MDggQU0sIFVlY2tlciwgTWFydGluDQo+IDxN
YXJ0aW4uVWVja2VyQG1lZC51bmktZ29ldHRpbmdlbi5kZT4gd3JvdGU6DQo+ID4gSSBkbyBub3Qg
YWdyZWUgdGhhdCBWTEFzIGFyZSBnZW5lcmFsbHkgYmFkIGZvciBzZWN1cml0eS4NCj4gPiBJIHRo
aW5rIHRoZSBvcHBvc2l0ZSBpcyB0cnVlLiBBIFZMQSB3aXRoIHRoZSByaWdodCBzaXplDQo+ID4g
YWxsb3dzIHRoZSBjb21waWxlciB0byBhdXRvbWF0aWNhbGx5IHBlcmZvcm0gb3IgaW5zZXJ0DQo+
ID4gbWVhbmluZ2Z1bCBib3VuZHMgY2hlY2tzLCB3aGlsZSBhIGZpeGVkIHVwcGVyIGJvdW5kIGRv
ZXMgbm90Lg0KPiANCj4gV2hpbGUgSSBzZWUgd2hhdCB5b3UgbWVhbiwgdGhlIHRyb3VibGUgaXMg
dGhhdCB0aGUgY29tcGlsZXIgaGFzIG5vDQo+IGlkZWEgd2hhdCB0aGUgdXBwZXIgYm91bmRzIG9m
IHRoZSBfYXZhaWxhYmxlXyBzdGFjayBpcy4gVGhpcyBtZWFucw0KPiB0aGF0IGEgbGFyZ2UgVkxB
IG1pZ2h0IGFsbG93IGNvZGUgdG8gcmVhZC93cml0ZSBiZXlvbmQgdGhlIHN0YWNrDQo+IGFsbG9j
YXRpb24sIHdoaWNoIGFsc28gYnlwYXNzZXMgdGhlICJzdGFuZGFyZCIgc3RhY2sgYnVmZmVyIG92
ZXJmbG93DQo+IGNoZWNrcy4gQWRkaXRpb25hbGx5LCBWTEFzIGJ5cGFzcyB0aGUgZXhpc3Rpbmcg
c3RhY2stc2l6ZSBjaGVja3Mgd2UndmUNCj4gYWRkZWQgdG8gdGhlIGtlcm5lbC4NCg0KTGltaXRp
bmcgdGhlIHNpemUgb2YgdGhlIFZMQSBzaG91bGQgYmUgc3VmZmljaWVudCB0byBhdm9pZCB0aGlz
Lg0KDQpJIGRvbid0IGtub3cgYWJvdXQgeW91ciBzcGVjaWZpYyBzdGFjay1zaXplIGNoZWNrcw0K
aW4gdGhlIGtlcm5lbCwgYnV0IGZvciBnZW5lcmFsIHByb2dyYW1taW5nLCB0aGUgZnVsbCBzb2x1
dGlvbg0KaXMgZm9yIHRoZSBjb21waWxlciB0byBwcm9iZSB0aGUgc3RhY2sgd2hlbiBncm93aW5n
Lg0KDQpCdXQgSSB3YXMgbm90IHRhbGtpbmcgYWJvdXQgdGhlIGJvdW5kcyBvZiB0aGUgc3RhY2ss
IGJ1dCBvZiB0aGUNCmFycmF5IGl0c2VsZi4NCg0KPiA+IEZvciBleGFtcGxlOg0KPiA+IA0KPiA+
IGNoYXIgYnVmW05dOw0KPiA+IGJ1ZltuXSA9IDE7DQo+ID4gDQo+ID4gSGVyZSwgYSBjb21waWxl
ciAvIGFuYWx5c2lzIHRvb2wgY2FuIGZvcsKgwqBuIDwgTsKgwqB1c2luZw0KPiA+IHN0YXRpYyBh
bmFseXNpcyBvciBpbnNlcnQgYSBydW4tdGltZSBjaGVjay4NCj4gPiANCj4gPiBSZXBsYWNpbmcg
dGhpcyB3aXRoDQo+ID4gDQo+ID4gY2hhciBidWZbTUFYX1NJWkVdDQo+ID4gDQo+ID4gaGlkZXMg
dGhlIGluZm9ybWF0aW9uIGFib3V0IHRoZSB0cnVlIHVwcGVyIGJvdW5kDQo+ID4gZnJvbSBhdXRv
bWF0aWMgdG9vbHMuDQo+IA0KPiBXaGlsZSB0aGlzIG1heSBiZSB0cnVlIGZvciBzb21lIHRvb2xz
LCBJIGRvbid0IGFncmVlIFZMQXMgYXJlIGJldHRlcg0KPiBpbiBnZW5lcmFsLiBGb3IgZXhhbXBs
ZSwgdGhlIGNvbXBpbGVyIGFjdHVhbGx5IGtub3dzIHRoZSB1cHBlciBib3VuZA0KPiBhdCBidWls
ZCB0aW1lIG5vdywgYW5kIHRoaW5ncyBsaWtlIHRoZSBwcmludGYgZm9ybWF0IHNpemUgY2hlY2tz
IGFuZA0KPiBDT05GSUdfRk9SVElGWV9TT1VSQ0UgYXJlIG5vdyBhYmxlIHRvIHByb2R1Y2UgY29t
cGlsZS10aW1lIHdhcm5pbmdzDQo+IChzaW5jZSAic2l6ZW9mKGJ1ZikiIGlzbid0IGEgcnVudGlt
ZSB2YWx1ZSkuIFdpdGggYSBWTEEsIHRoaXMgaXMNCj4gaGlkZGVuIGZyb20gdGhvc2UgdG9vbHMs
IGFuZCBkZXRlY3Rpb24gZGVwZW5kcyBvbiBydW50aW1lIGFuYWx5c2lzLg0KDQpJZiB0aGUgY29y
cmVjdCBib3VuZCBpcyBhY3R1YWxseSBhIGNvbnN0YW50IGFuZCB0aGUgYXJyYXkNCm9ubHkgZW5k
cyB1cCBiZWluZyBhIFZMQSBmb3Igc29tZSByYW5kb20gcmVhc29uLCBJIGZ1bGx5IGFncmVlLg0K
DQpCdXQgaWYgdGhlIHRydWUgYm91bmQgaXMgc21hbGxlciwgdGhlbiBJTUhPIGl0IGlzIHJlYWxs
eSBiYWQgYWR2aXNlDQp0byB0ZWxsIHByb2dyYW1tZXJzIHRvIHVzZQ0KDQpjaGFyIGJ1ZltNQVhf
U0laRV0NCg0KaW5zdGVhZCBvZiBzb21ldGhpbmcgbGlrZQ0KDQphc3NlcnQoTiA8PSBNQVhfU0la
RSk7wqANCmNoYXIgYnVmW05dDQoNCmJlY2F1c2UgdGhlbiBlcnJvcnMgb2YgdGhlIGZvcm3CoA0K
DQpidWZbbl0gPSAxDQoNCndpdGggTiA8IG4gPCBNQVhfU0laRSBjYW4gbm90IGJlIGRldGVjdGVk
IGFueW1vcmUuIEFsc28gdGhlDQpjb2RlIHVzdWFsbHkgZW5kcyB1cCBiZWluZyBsZXNzIHJlYWRh
YmxlLCB3aGljaCBpcyBhbHNvIGEgY2xlYXINCmRpc2FkdmFudGFnZSBpbiBteSBvcGluaW9uLg0K
DQoNCj4gSXQgc2hvdWxkIGJlIG5vdGVkIHRoYXQgVkxBcyBhcmUgYWxzbyBzbG93WzFdLCBzbyBy
ZW1vdmluZyB0aGVtIG5vdA0KPiBvbmx5IGltcHJvdmVzIHJvYnVzdG5lc3MgYnV0IGFsc28gaW1w
cm92ZXMgcGVyZm9ybWFuY2UuDQoNCkkgaGF2ZSB0byBhZG1pdCB0aGF0IEkgYW0gYWx3YXlzIGEg
Yml0IHNrZXB0aWNhbCBpZiBzb21lYm9keSBtYWtlcw0KZ2VuZXJpYyBjbGFpbXMgc3VjaCBhcyAi
VkxBcyBhcmUgc2xvdyIgYW5kIHRoZW4gY2l0ZXMgb25seSBhDQpzaW5nbGUgZXhhbXBsZS4gQnV0
IEkgYW0gbm90IHRvbyBzdXJwcmlzZWQgaWYgY29tcGlsZXJzIHByb2R1Y2UNCmNyYXBweSBjb2Rl
IGZvciBWTEFzIGFuZCB0aGF0IHRoaXMgY2FuIGh1cnQgcGVyZm9ybWFuY2UgaW4gc29tZQ0KZXhh
bXBsZXMuIEJ1dCBjb21wYXJlZCB0byBkeW5hbWljIGFsbG9jYXRpb24gVkxBcyBzaG91bGQgYmUg
bXVjaA0KZmFzdGVyLiBUaGV5IGFsc28gcmVkdWNlIHN0YWNrIHVzYWdlIGNvbXBhcmVkIHRvIGFs
d2F5cyBhbGxvY2F0aW5nDQphcnJheSB3aXRoIGEgZml4ZWQgbWF4aW11bSBzaXplIG9uIHRoZSBz
dGFjay4NCg0KPiA+IE9mIGNvdXJzZSwgaGF2aW5nIHByZWRpY3RhYmxlIHN0YWNrIHVzYWdlIG1p
Z2h0IGJlIG1vcmUNCj4gPiBpbXBvcnRhbnQgaW4gdGhlIGtlcm5lbCBhbmQgbWlnaHQgYmUgYSBn
b29kIGFyZ3VtZW50DQo+ID4gdG8gc3RpbGwgcHJlZmVyIHRoZSBjb25zdGFudCBib3VuZC4NCj4g
DQo+IEJldHdlZW4gaW1wcm92ZWQgY29tcGlsZS10aW1lIGNoZWNraW5nLCBmYXN0ZXIgcnVudGlt
ZSBwZXJmb3JtYW5jZSwNCj4gYW5kIGltcHJvdmVkIHJvYnVzdG5lc3MgYWdhaW5zdCBzdGFjayBl
eGhhdXN0aW9uLCBJIHN0cm9uZ2x5IGJlbGlldmUNCj4gdGhlIGtlcm5lbCB0byBiZSBiZXR0ZXIg
b2ZmIHdpdGggVkxBcyBlbnRpcmVseSByZW1vdmVkLiBBbmQgd2UgYXJlDQo+IGNsb3NlOiBvbmx5
IDYgcmVtYWluIChvdXQgb2YgdGhlIDExNSBJIGNvdW50ZWQgaW4gdjQuMTUpLg0KDQpMb29raW5n
IGF0IHNvbWUgb2YgdGhlIHBhdGNoZXMsIEkgd291bGQgc2F5IGl0IGlzIG5vdCANCmNsZWFyIHRv
IG1lIHRoYXQgdGhpcyBpcyBhbHdheSBhbiBpbXByb3ZlbWVudC4NCg0KPiA+IEJ1dCBsb29zaW5n
IHRoZSB0aWdodGVyIGJvdW5kcyBpcyBjbGVhcmx5IGEgZGlzYWR2YW50YWdlDQo+ID4gd2l0aCBy
ZXNwZWN0IHRvIHNlY3VyaXR5IHRoYXQgb25lIHNob3VsZCBrZWVwIGl0IG1pbmQuDQo+IA0KPiBZ
ZXM6IHdpdGhvdXQgVkxBcywgc3RhY2sgYXJyYXkgdXNhZ2UgaXMgcmVkdWNlZCB0byAic3RhbmRh
cmQiIHN0YWNrDQo+IGJ1ZmZlciBvdmVyZmxvdyBjb25jZXJucy4gUmVtb3ZpbmcgdGhlIFZMQSBk
b2Vzbid0IGludHJvZHVjZSBhIG5ldw0KPiByaXNrOiB3ZSBhbHJlYWR5IGhhZCB0byB3b3JyeSBh
Ym91dCBmaXhlZC1zaXplIGFycmF5cy4gUmVtb3ZpbmcgVkxBc2Fsd2F5cw0KPiBtZWFucyB3ZSBk
b24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0IHRoZSBWTEEtc3BlY2lmaWMgcmlza3MgYW55bW9yZS4N
Cg0KSXQgaW50cm9kdWNlcyB0aGUgbmV3IHJpc2sgdGhhdCBjZXJ0YWluIGxvZ2ljIGVycm9yIGNh
bg0Kbm90IGJlIGRldGVjdGVkIGFueW1vcmUgYnkgc3RhdGljIGFuYWx5c2lzIG9yIHJ1bi10aW1l
IGJvdW5kcw0KY2hlY2tpbmcuDQoNCkJlc3QsDQpNYXJ0aW4NCg==
