Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB4C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDC320867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDC320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thalesgroup.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeLBBN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:13:28 -0500
Received: from thsbbfxrt02p.thalesgroup.com ([192.93.158.29]:38412 "EHLO
        thsbbfxrt02p.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726570AbeLBBN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:13:27 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Dec 2018 20:13:26 EST
Received: from thsbbfxrt02p.thalesgroup.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 436Xp829CnzJpb5;
        Sat,  1 Dec 2018 14:55:28 +0100 (CET)
From:   JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dw_mmc: IDMAC Invalidate cache after read
Thread-Topic: dw_mmc: IDMAC Invalidate cache after read
Thread-Index: AQHUgW3NJS3s6fdIZ0u0s1IZXxrnfqVdbwKAgAVRt4CAByatAA==
Date:   Sat, 1 Dec 2018 13:56:39 +0000
Message-ID: <1543672526.26115.154.camel@atviedlbe741.rss.d3s.at.thales>
References: <1542786115.18775.83.camel@atviedlbe741.rss.d3s.at.thales>
         <a45eca28-fd89-e595-5b34-689bc3a09b9c@arm.com>
         <d20a3c39-dea7-e324-e677-ec416c16559c@rock-chips.com>
In-Reply-To: <d20a3c39-dea7-e324-e677-ec416c16559c@rock-chips.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.10.4-0ubuntu2 
x-originating-ip: [10.177.70.240]
x-pmwin-version: 4.0.3, Antivirus-Engine: 3.73.0, Antivirus-Data: 5.57
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E11C2B3D53EB847A10FEE3F17FE30FB@iris.infra.thales>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIGxhdGUgYW5zd2VyLA0KDQoNClRoZSBwcm9ibGVtIGFwcGVhcnMgZHVyaW5nIGNh
bGN1bGF0aW9uIG9mIG1kNXN1bSBvZiBlTU1DICgxNkdCKSBpbiB0aGUNCmxvb3AuDQpBZnRlciBz
b21lIHRpbWUgKGUuZy4gMS0yIGhvdXJzKSwgbWQ1c3VtIG1heSBiZSBkaWZmZXJlbnQNCg0KRm9y
IGV4YW1wbGU6DQo1YzJiM2M3YTZkNjlhMmY2YzRjMWRkZmRkM2JmMWVkNSAgL2Rldi9tbWNibGsw
ICAgICB0aW1lIDc0NiBbc10NCjVjMmIzYzdhNmQ2OWEyZjZjNGMxZGRmZGQzYmYxZWQ1ICAvZGV2
L21tY2JsazAgICAgIHRpbWUgNzM4IFtzXQ0KYzVmMmJiOGU5ZDgzNzQ0ZDQwODc0NTBkNjI3NDIw
OGUgIC9kZXYvbW1jYmxrMCAgICAgdGltZSA2OTEgW3NdDQouLi4gDQoNCg0KDQo+IEl0IGxvb2tz
IHZlcnkgZHViaW91cyB3aGV0aGVyIHRoaXMgaXMgYWN0dWFsbHkgdGhlIHJpZ2h0IHRoaW5nIHRv
IGRvLiANCj4gPiBKdXN0IGNvbnNpZGVyaW5nIHRoaXMgZHJpdmVyLCBlZG1hIGhhcyBhbiBjb21w
bGVtZW50YXJ5IHN5bmNfc2cgY2FsbCBpbiANCj4gPiBpdHMgLnN0YXJ0IG1ldGhvZCwgc28gaWYg
aWRtYSBuZWVkZWQgdGhpcyBvbmUsIGxvZ2ljYWxseSBzaG91bGRuJ3QgaXQgDQo+ID4gYWxzbyBu
ZWVkIHRoZSBvdGhlciBvbmUgYXMgd2VsbD8NCg0KDQpJZiB0aGVyZSBpcyBzb21lIGNvaGVyZW5j
eSBpc3N1ZSBvbiBDb3J0ZXgtQTkgLSBQcm9iYWJseSB5ZXMsDQpJIGhhdmUgdG8gdGVzdCBpdA0K
DQoNCj4gSG93ZXZlciwgZnJvbSBhIERNQSBBUEkgcG9pbnQgb2YgdmlldywgdGhlc2Ugc3luY3Mg
bWFrZSBubyBzZW5zZSBlaXRoZXIgDQo+ID4gd2F5IC0gdGhlIHZlcnkgbmV4dCB0aGluZyB3ZSBk
byBoZXJlIGlzIGNhbGwgaG9zdC0+ZG1hX29wcy0+Y2xlYW51cCgpLCANCj4gPiB3aGljaCBjYWxs
cyBkbWFfdW5tYXBfc2coKSwgd2hpY2ggd2lsbCBwZXJmb3JtIHRoZSBhcHByb3ByaWF0ZSBjYWNo
ZSANCj4gPiBtYWludGVuYW5jZSBhbnl3YXkuIFRodXMgSSBjYW4ndCBzZWUgd2h5IHRoaXMgY29k
ZSBpcyBldmVuIGhlcmUgdG8gYmVnaW4gDQo+ID4gd2l0aC4gU2ltaWxhcmx5IG9uIHRoZSByZXF1
ZXN0IHBhdGggLSB0aGUgc2cgbGlzdCByZWFsbHkgc2hvdWxkbid0IGhhdmUgDQo+ID4gYmVlbiB0
b3VjaGVkIHNpbmNlIGJlaW5nIG1hcHBlZCBpbiBkd19tY2lfcHJlX2RtYV90cmFuc2ZlcigpLCBz
byB0aGF0IA0KPiA+IHN5bmMgc2hvdWxkIGFsc28gYmUgYW4gZWZmZWN0aXZlIG5vLW9wIHVubGVz
cyBpdCdzIHBhcGVyaW5nIG92ZXIgc29tZSANCj4gPiByYWNlIGNvbmRpdGlvbiBlbHNld2hlcmUu
DQoNCkkgYWdyZWUsIA0KDQpCdXQgaWYgdGhlcmUgaXMgc29tZSBjb2hlcmVuY3kgaXNzdWUgd2l0
aCBSSzMxeHggU29DcyAoQ29ydGV4LUE5LCBFRE1BKQ0KYW5kIEFsdGVyYSBTb0MgRlBHQSAoQ29y
dGV4LUE5LCBJRE1BKSA/DQpCZWNhdXNlIEkgc2VlIHBvc2l0aXZlIHJlc3VsdHMsIGFmdGVyIGFw
cGx5aW5nIG1lbnRpb25lZCBwYXRjaA0KKEFsdGVyYSBTb0MgRlBHQSAtIENvcnRleC1BOSwgSURN
QSkuDQpQcm9iYWJseSB1c2luZyBzeW5jLW9wcyBmdW5jdGlvbnMgYmVmb3JlIERNQSB0cmFuc2Fj
dGlvbiBhbmQgYWZ0ZXIgRE1BDQp0cmFuc2FjdGlvbiBpbiB0aGlzIGNhc2UgbWFrZSBzZW5zZQ0K
DQoNCg0KU2hhd24NCkNvdWxkIHlvdSBwbGVhc2UgYWxzbyBzaGFyZSBzb21lIGRldGFpbHMsIHRo
YXQgeW91IHJlbWVtYmVyDQooc3luYy1vcHMgYW5kIFJLMzF4eCBTb0NzKSA/DQpJIHdvdWxkIHJl
YWxseSBhcHByZWNpYXRlIGl0Lg0KDQpUaGFua3MNCg0KDQoNCk9uIERpLCAyMDE4LTExLTI3IGF0
IDA4OjQzICswODAwLCBTaGF3biBMaW4gd3JvdGU6DQo+IE9uIDIwMTgvMTEvMjMgMjM6MjksIFJv
YmluIE11cnBoeSB3cm90ZToNCj4gPiBIaSBKYW4sDQo+ID4gDQo+ID4gW3JlcGVhdGluZyBzb21l
IG9mIHRoZSBkaXNjdXNzaW9uIGZyb20geW91ciBvdGhlciB0aHJlYWQgZm9yIHRoZSBiZW5lZml0
IA0KPiA+IG9mIHRoZSBNTUMgYXVkaWVuY2VdDQo+ID4gDQo+ID4gT24gMjEvMTEvMjAxOCAwNzo0
MiwgSkFCTE9OU0tZIEphbiB3cm90ZToNCj4gPj4gQ1BVIG1heSBub3Qgc2VlIG1vc3QgdXAtdG8t
ZGF0ZSBhbmQgY29ycmVjdCBjb3B5IG9mIERNQSBidWZmZXIsIHdoZW4NCj4gPj4gaW50ZXJuYWwg
RE1BIGNvbnRyb2xsZXIgaXMgaW4gdXNlLg0KPiA+PiBQcm9ibGVtIGFwcGVhcnMgb24gVGhlIEFs
dGVyYSBTb0MgRlBHQSAodXNlcyBpbnRlZ3JhdGVkIERNQSBjb250cm9sbGVyKSwNCj4gPj4gZHVy
aW5nIGhpZ2hlciBDUFUgYW5kIHN5c3RlbSBtZW1vcnkgbG9hZA0KPiA+Pg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBKYW4gSmFibG9uc2t5IDxqYW4uamFibG9uc2t5QHRoYWxlc2dyb3VwLmNvbT4NCj4g
Pj4gLS0tDQo+ID4+ICAgZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYyB8IDMgKy0tDQo+ID4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYyBiL2RyaXZlcnMvbW1jL2hv
c3QvZHdfbW1jLmMNCj4gPj4gaW5kZXggODBkYzJmZC4uNjM4NzNkOSAxMDA2NDQNCj4gPj4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYw0KPiA+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0
L2R3X21tYy5jDQo+ID4+IEBAIC00OTksOCArNDk5LDcgQEAgc3RhdGljIHZvaWQgZHdfbWNpX2Rt
YWNfY29tcGxldGVfZG1hKHZvaWQgKmFyZykNCj4gPj4gICAgICAgZGV2X3ZkYmcoaG9zdC0+ZGV2
LCAiRE1BIGNvbXBsZXRlXG4iKTsNCj4gPj4gLSAgICBpZiAoKGhvc3QtPnVzZV9kbWEgPT0gVFJB
TlNfTU9ERV9FRE1BQykgJiYNCj4gPj4gLSAgICAgICAgZGF0YSAmJiAoZGF0YS0+ZmxhZ3MgJiBN
TUNfREFUQV9SRUFEKSkNCj4gPj4gKyAgICBpZiAoZGF0YSAmJiAoZGF0YS0+ZmxhZ3MgJiBNTUNf
REFUQV9SRUFEKSkNCj4gPj4gICAgICAgICAgIC8qIEludmFsaWRhdGUgY2FjaGUgYWZ0ZXIgcmVh
ZCAqLw0KPiA+PiAgICAgICAgICAgZG1hX3N5bmNfc2dfZm9yX2NwdShtbWNfZGV2KGhvc3QtPnNs
b3QtPm1tYyksDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5zZywNCj4gPiANCj4g
PiBJdCBsb29rcyB2ZXJ5IGR1YmlvdXMgd2hldGhlciB0aGlzIGlzIGFjdHVhbGx5IHRoZSByaWdo
dCB0aGluZyB0byBkby4gDQo+ID4gSnVzdCBjb25zaWRlcmluZyB0aGlzIGRyaXZlciwgZWRtYSBo
YXMgYW4gY29tcGxlbWVudGFyeSBzeW5jX3NnIGNhbGwgaW4gDQo+ID4gaXRzIC5zdGFydCBtZXRo
b2QsIHNvIGlmIGlkbWEgbmVlZGVkIHRoaXMgb25lLCBsb2dpY2FsbHkgc2hvdWxkbid0IGl0IA0K
PiA+IGFsc28gbmVlZCB0aGUgb3RoZXIgb25lIGFzIHdlbGw/DQo+ID4gDQo+ID4gSG93ZXZlciwg
ZnJvbSBhIERNQSBBUEkgcG9pbnQgb2YgdmlldywgdGhlc2Ugc3luY3MgbWFrZSBubyBzZW5zZSBl
aXRoZXIgDQo+ID4gd2F5IC0gdGhlIHZlcnkgbmV4dCB0aGluZyB3ZSBkbyBoZXJlIGlzIGNhbGwg
aG9zdC0+ZG1hX29wcy0+Y2xlYW51cCgpLCANCj4gPiB3aGljaCBjYWxscyBkbWFfdW5tYXBfc2co
KSwgd2hpY2ggd2lsbCBwZXJmb3JtIHRoZSBhcHByb3ByaWF0ZSBjYWNoZSANCj4gPiBtYWludGVu
YW5jZSBhbnl3YXkuIFRodXMgSSBjYW4ndCBzZWUgd2h5IHRoaXMgY29kZSBpcyBldmVuIGhlcmUg
dG8gYmVnaW4gDQo+ID4gd2l0aC4gU2ltaWxhcmx5IG9uIHRoZSByZXF1ZXN0IHBhdGggLSB0aGUg
c2cgbGlzdCByZWFsbHkgc2hvdWxkbid0IGhhdmUgDQo+ID4gYmVlbiB0b3VjaGVkIHNpbmNlIGJl
aW5nIG1hcHBlZCBpbiBkd19tY2lfcHJlX2RtYV90cmFuc2ZlcigpLCBzbyB0aGF0IA0KPiA+IHN5
bmMgc2hvdWxkIGFsc28gYmUgYW4gZWZmZWN0aXZlIG5vLW9wIHVubGVzcyBpdCdzIHBhcGVyaW5n
IG92ZXIgc29tZSANCj4gPiByYWNlIGNvbmRpdGlvbiBlbHNld2hlcmUuDQo+ID4gDQo+ID4gU2hh
d24gLSBkbyB5b3UgcmVtZW1iZXIgd2h5IHRoZXNlIHN5bmNzIHdlcmUgYWRkZWQgaW4gM2ZjN2Vh
ZWY0NGRiYz8gDQo+ID4gV2VyZSB5b3Ugc2VlaW5nIGFjdHVhbCBjb2hlcmVuY3kgaXNzdWVzIG9u
IFJLMzF4eCBTb0NzLCBvciB3YXMgaXQgDQo+ID4gcGVyaGFwcyBqdXN0IHNvbWUgbGVmdG92ZXIg
b3IgbWlzdW5kZXJzdGFuZGluZyB3aGljaCBtaXNzZWQgZ2V0dGluZyANCj4gPiBjbGVhbmVkIHVw
Pw0KPiANCj4gSSAgY2FuJ3QgcmVtZW1iZXIgdG9vIG11Y2ggZGV0YWlscyBidXQgbG9va2luZyBh
dCB0aGUgZG1hLW1hcHBpbmcgY29kZSANCj4gYWdhaW4sIGl0IHNlZW1zIHRoZSBjb21wbGVtZXRh
cnkgc3luYy1vcCBoZXJlIGlzIHVzZWxlc3MuDQo+IA0KPiA+IA0KPiA+IFJvYmluLg0KPiA+IA0K
PiA+IA0KPiA+IA0KPiANCj4gDQoNCg==
