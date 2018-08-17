Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1798C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F39B2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F39B2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeHQFR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:17:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbeHQFR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:17:26 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 350256C1606D;
        Fri, 17 Aug 2018 10:15:55 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.26]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0399.000;
 Fri, 17 Aug 2018 10:15:52 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Roger Quadros <rogerq@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "joe@perches.com" <joe@perches.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Topic: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Index: AQHUMHhu69J7qZINb0WTPExaubbbVKS4SOuAgAA6VQCABl4BAP//8QSAgAMd8CD//4ruAIAAwyzQ//9/CQAAEjpdIA==
Date:   Fri, 17 Aug 2018 02:15:52 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C9B382F@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED0C9B12B9@dggemm526-mbx.china.huawei.com>
 <Pine.LNX.4.44L0.1808141022450.1466-100000@iolanthe.rowland.org>
 <678F3D1BB717D949B966B68EAEB446ED0C9B2CC0@dggemm526-mbx.china.huawei.com>
 <f4372b12-327c-ee51-76ae-2e2bc5cdceed@ti.com>
 <678F3D1BB717D949B966B68EAEB446ED0C9B33C7@dggemm526-mbx.china.huawei.com>
 <69b675eb-ed6a-8df3-a39f-e985f6a6df22@ti.com>
In-Reply-To: <69b675eb-ed6a-8df3-a39f-e985f6a6df22@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXI6DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJvZ2VyIFF1
YWRyb3MgW21haWx0bzpyb2dlcnFAdGkuY29tXQ0KPlNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTYs
IDIwMTggNzoxNCBQTQ0KPlRvOiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29t
PjsgQWxhbiBTdGVybg0KPjxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPkNjOiBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgbWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb207DQo+ZHJp
bmtjYXRAY2hyb21pdW0ub3JnOyBmZWxpcGUuYmFsYmlAbGludXguaW50ZWwuY29tOw0KPmRyYWtl
QGVuZGxlc3NtLmNvbTsgbWlrZS5sb29pam1hbnNAdG9waWMubmw7IGpvZUBwZXJjaGVzLmNvbTsN
Cj5saW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBodWI6IHRyeSBvbGQgZW51bWVyYXRpb24gc2No
ZW1lIGZpcnN0IGZvciBoaWdoDQo+c3BlZWQgZGV2aWNlcw0KPg0KPk9uIDE2LzA4LzE4IDEzOjU5
LCBaZW5ndGFvIChCKSB3cm90ZToNCj4+IEhpIFJvZ2VyOg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IFJvZ2VyIFF1YWRyb3MgW21haWx0bzpyb2dlcnFAdGku
Y29tXQ0KPj4+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTYsIDIwMTggMzoxNyBQTQ0KPj4+IFRv
OiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgQWxhbiBTdGVybg0KPj4+
IDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPj4+IENjOiBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsgbWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb207DQo+Pj4gZHJpbmtjYXRAY2hy
b21pdW0ub3JnOyBmZWxpcGUuYmFsYmlAbGludXguaW50ZWwuY29tOw0KPj4+IGRyYWtlQGVuZGxl
c3NtLmNvbTsgbWlrZS5sb29pam1hbnNAdG9waWMubmw7IGpvZUBwZXJjaGVzLmNvbTsNCj4+PiBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBodWI6IHRyeSBvbGQgZW51bWVyYXRpb24gc2No
ZW1lIGZpcnN0IGZvcg0KPj4+IGhpZ2ggc3BlZWQgZGV2aWNlcw0KPj4+DQo+Pj4gT24gMTYvMDgv
MTggMDk6MjEsIFplbmd0YW8gKEIpIHdyb3RlOg0KPj4+PiBIaSBhbGFuOg0KPj4+Pg0KPj4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IEFsYW4gU3Rlcm4gW21haWx0
bzpzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1XQ0KPj4+Pj4gU2VudDogVHVlc2RheSwgQXVndXN0
IDE0LCAyMDE4IDEwOjQwIFBNDQo+Pj4+PiBUbzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlz
aWxpY29uLmNvbT4NCj4+Pj4+IENjOiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAdGkuY29tPjsgZ3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+Pj4+PiBtYXRoaWFzLm55bWFuQGxpbnV4LmludGVs
LmNvbTsgZHJpbmtjYXRAY2hyb21pdW0ub3JnOw0KPj4+Pj4gZmVsaXBlLmJhbGJpQGxpbnV4Lmlu
dGVsLmNvbTsgZHJha2VAZW5kbGVzc20uY29tOw0KPj4+Pj4gbWlrZS5sb29pam1hbnNAdG9waWMu
bmw7IGpvZUBwZXJjaGVzLmNvbTsNCj4+Pj4+IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHVz
YjogaHViOiB0cnkgb2xkIGVudW1lcmF0aW9uIHNjaGVtZSBmaXJzdCBmb3INCj4+Pj4+IGhpZ2gg
c3BlZWQgZGV2aWNlcw0KPj4+Pj4NCj4+Pj4+IE9uIFR1ZSwgMTQgQXVnIDIwMTgsIFplbmd0YW8g
KEIpIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+PiBIaSBhbGFuOg0KPj4+Pj4+DQo+Pj4+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+Pj4+IEZyb206IGxpbnV4LXVzYi1vd25lckB2Z2Vy
Lmtlcm5lbC5vcmcNCj4+Pj4+Pj4gW21haWx0bzpsaW51eC11c2Itb3duZXJAdmdlci5rZXJuZWwu
b3JnXSBPbiBCZWhhbGYgT2YgQWxhbiBTdGVybg0KPj4+Pj4+PiBTZW50OiBGcmlkYXksIEF1Z3Vz
dCAxMCwgMjAxOCAxMDoyMCBQTQ0KPj4+Pj4+PiBUbzogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRp
LmNvbT4NCj4+Pj4+Pj4gQ2M6IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+
Ow0KPj4+Pj4+PiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbWF0aGlhcy5ueW1hbkBsaW51
eC5pbnRlbC5jb207DQo+Pj4+Pj4+IGRyaW5rY2F0QGNocm9taXVtLm9yZzsgZmVsaXBlLmJhbGJp
QGxpbnV4LmludGVsLmNvbTsNCj4+Pj4+Pj4gZHJha2VAZW5kbGVzc20uY29tOyBtaWtlLmxvb2lq
bWFuc0B0b3BpYy5ubDsNCj5qb2VAcGVyY2hlcy5jb207DQo+Pj4+Pj4+IGxpbnV4LXVzYkB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+Pj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gdXNiOiBodWI6IHRyeSBvbGQgZW51bWVyYXRpb24gc2NoZW1lIGZpcnN0
DQo+Pj4+Pj4+IGZvciBoaWdoIHNwZWVkIGRldmljZXMNCj4+Pj4+Pj4NCj4+Pj4+Pj4gT24gRnJp
LCAxMCBBdWcgMjAxOCwgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4+Pj4+Pj4NCj4+Pj4+Pj4+IEhp
LA0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IE9uIDEwLzA4LzE4IDE4OjAxLCBaZW5nIFRhbyB3cm90ZToN
Cj4+Pj4+Pj4+PiBUaGUgbmV3IHNjaGVtZSBpcyByZXF1aXJlZCBqdXN0IHRvIHN1cHBvcnQgbGVn
YWN5IGxvdyBhbmQNCj4+Pj4+Pj4+PiBmdWxsLXNwZWVkIGRldmljZXMuIEZvciBoaWdoIHNwZWVk
IGRldmljZXMsIGl0IHdpbGwgc2xvd2VyIHRoZQ0KPj4+Pj4+Pj4+IGVudW1lcmF0aW9uDQo+Pj4+
PiBzcGVlZC4NCj4+Pj4+Pj4+PiBTbyBpbiB0aGlzIHBhdGNoIHdlIHRyeSB0aGUgIm9sZCIgZW51
bWVyYXRpb24gc2NoZW1lIGZpcnN0IGZvcg0KPj4+Pj4+Pj4+IGhpZ2ggc3BlZWQgZGV2aWNlcy4N
Cj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBIb3cgc2xvdyBkb2VzIGl0IGdldD8gSXMgaXQgc2lnbmlmaWNh
bnQ/DQo+Pj4+Pj4+PiBEbyB3ZSByaXNrIGJyZWFraW5nIGV4aXN0aW5nIEhTIGRldmljZXMgdGhh
dCB3b3JrPyBJIGRvbid0IHRoaW5rDQo+Pj4+Pj4+PiB3ZSBjYW4gYmUgc3VyZSB0aWxsIHdlIHJ1
biB0aGlzIHRocm91Z2ggdGVzdGluZy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSW5kZWVkLiAgSSBhbSBl
eHRyZW1lbHkgc2tlcHRpY2FsIGFib3V0IGEgcGF0Y2ggbGlrZSB0aGlzLCB1bmxlc3MNCj4+Pj4+
Pj4gc29tZWJvZHkgY2FuIHNob3cgdGhhdCBXaW5kb3dzIHVzZXMgdGhlICJvbGQiIHNjaGVtZSBm
b3INCj4+PiBoaWdoLXNwZWVkDQo+Pj4+PiBkZXZpY2VzLg0KPj4+Pj4+DQo+Pj4+Pj4gWWVzLCB0
aGlzIGlzIHdoYXQgdGhlIHdpbmRvd3MgaGFzIGRvbmUsIHlvdSBjYW4gcmVmZXIgdG8NCj4+Pj4+
Pg0KPj4+IGh0dHBzOi8vYmxvZ3MubXNkbi5taWNyb3NvZnQuY29tL3VzYmNvcmVibG9nLzIwMTMv
MDQvMTEvdXNiLTItMS0yLTAtDQo+Pj4+Pj4gMS0gMS1kZXZpY2UtZW51bWVyYXRpb24tY2hhbmdl
cy1pbi13aW5kb3dzLTgvDQo+Pj4+Pg0KPj4+Pj4gQW5kIHRoYXQgYmxvZyBwb3N0IGlzIDUgeWVh
cnMgb2xkIQ0KPj4+Pj4NCj4+Pj4+IE9rYXksIEkgdGhpbmsgd2UgY2FuIGdvIGFoZWFkIGFuZCBt
YWtlIHRoaXMgY2hhbmdlLiAgSG93ZXZlciwgeW91DQo+Pj4+PiBzaG91bGQgdXBkYXRlIHRoZSBw
YXRjaCBkZXNjcmlwdGlvbiB0byBtZW50aW9uIHdoYXQgTWljcm9zb2Z0IGRpZA0KPj4+Pj4gaW4g
V2luZG93cyA4IGFuZCBzYXkgdGhhdCB0aGUgbmV3IGJlaGF2aW9yIG1hdGNoZXMgdGhlaXJzLg0K
Pj4+Pj4NCj4+Pj4gT2theSwgSSB3aWxsIHVwZGF0ZSBpdCB0aGUgY2hhbmdlIGxvZyBpbiB2Mi4N
Cj4+Pj4NCj4+Pj4+IEFsc28sIGFzIFJvZ2VyIG1lbnRpb25lZCwgeW91IHNob3VsZCB1cGRhdGUg
dGhlIGRvY3VtZW50YXRpb24gdG8NCj4+Pj4+IHNheSB0aGF0IHRoZSBvbGRfc2NoZW1lX2ZpcnN0
IG1vZHVsZSBwYXJhbWV0ZXIgbm93IGFwcGxpZXMgb25seSB0bw0KPj4+Pj4gbG93LSBhbmQgZnVs
bC1zcGVlZCBkZXZpY2VzLCBzaW5jZSBoaWdoLSBhbmQgU3VwZXJTcGVlZCBkZXZpY2VzDQo+Pj4+
PiBhbHdheXMgdXNlDQo+Pj4gdGhlIG9sZCBzY2hlbWUgZmlyc3QuDQo+Pj4+Pg0KPj4+Pg0KPj4+
PiBTaW5jZSB3ZSBzaG91bGQgaGF2ZSBkZWRpY2F0ZWQgZW51bWVyYXRpb24gZmxvdyBmb3IgU1Ms
IEhJR0gsIGxvdw0KPj4+PiBhbmQgZnVsbCBzcGVlZCBkZXZpY2VzLCBTbyBJIHRoaW5rIHRoZSBv
bGRfc2NoZW1lX2ZpcnN0IGFuZA0KPj4+PiB1c2VfYm90aF9zY2hlbWVzDQo+Pj4gcGFyYW1ldGVy
cyBzaG91bGQgYmUgcmVtb3ZlZC4NCj4+Pj4gV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgaXQ/DQo+
Pj4NCj4+PiBJIHRoaW5rIHdlIHNob3VsZCByZXRhaW4gdGhlbSBhcyBzb21lIGhvc3QgY29udHJv
bGxlcnMgY2FuIGhhdmUNCj4+PiBpc3N1ZXMgYW5kIHRoZXNlIHBhcmFtZXRlcnMgZ2l2ZSBzb21l
IGNvbnRyb2wgdG8gc3lzdGVtIGludGVncmF0b3JzDQo+Pj4gdG8gd29ya2Fyb3VuZCBpZiByZXF1
aXJlZC4NCj4+Pg0KPj4+IEknbSBhd2FyZSBvZiBvbmUgZXJyYXRhIFsxXSB0aGF0IHJlcXVpcmVz
IHRoZSBvbGRfc2NoZW1lX2ZpcnN0IHRvIGJlDQo+Pj4gc2V0IGluIGNlcnRhaW4gY2lyY3Vtc3Rh
bmNlcy4NCj4+Pg0KPj4+IFsxXSBodHRwOi8vd3d3LnRpLmNvbS9saXQvZXIvc3ByejQyOWwvc3By
ejQyOWwucGRmDQo+Pj4gU2VjdGlvbiBpODk3DQo+Pg0KPj4gSSAnZCByYXRoZXIgdG8gdXNlIGEg
cXVpcmsgdG8gd29ya2Fyb3VuZC4NCj4+IEFuZCB0aGUgbWFpbiBpZGVhIGlzIHRvIGtlZXAgdGhl
IGVudW1lcmF0aW9uIGZsb3cgYXMgc2ltcGxlIGFzIHBvc3NpYmxlLg0KPg0KPlRoZSB3b3JrYXJv
dW5kIGlzbid0IGFsd2F5cyByZXF1aXJlZC4gT25seSBpbiBjZXJ0YWluIGNpcmN1bXN0YW5jZXMN
Cj5kZWNpZGVkIGJ5IHRoZSB1c2VyLg0KPkhvdyBjYW4gYSB1c2VyIHNldCB0aGUgcXVpcms/IE5v
dyBpdCBpcyBhcyBlYXN5IGFzIHNldHRpbmcgaXQgaW4gdGhlIGtlcm5lbA0KPmNvbW1hbmQgbGlu
ZS4NCj4NCj5PbmUgb3B0aW9uIHdvdWxkIGJlIHRvIHVzZSB0aGUgb2xkX3NjaGVtZV9maXJzdF9w
b3J0IHZpYSBzeXNmcy4NCj4vc3lzL2J1cy91c2IvZGV2aWNlcy8uLi4vKGh1YiBpbnRlcmZhY2Up
L3BvcnRYL3F1aXJrcw0KPg0KPkJ1dCB0aGF0IHdvbid0IHdvcmsgaWYgZGV2aWNlcyBhcmUgaGFy
ZC13aXJlZCBpbiB0aGUgc3lzdGVtIGFuZCBnZXQNCj5lbnVtZXJhdGVkIGJlZm9yZSB1c2VyIGdl
dHMgYWNjZXNzIHRvIHN5c2ZzLiBXZSBuZWVkIGEgd2F5IHRvIGZvcmNlIG9uZQ0KPnR5cGUgb2Yg
c2NoZW1lIGJlZm9yZSBkZXZpY2VzIGFyZSBlbnVtZXJhdGVkLg0KPg0KDQpPa2F5LCBtYWtlIHNl
bnNlLCB0aGFuayB5b3UgZm9yIHRoZSBleHBsYW5hdGlvbi4NCg0KPi0tDQo+Y2hlZXJzLA0KPi1y
b2dlcg0KPg0KPlRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIs
IDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlw
YWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
