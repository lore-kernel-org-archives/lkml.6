Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FBEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF536206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeLQBpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:45:46 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:6510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbeLQBpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:45:46 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 6455A5CCC469C;
        Mon, 17 Dec 2018 09:45:42 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.137]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0415.000;
 Mon, 17 Dec 2018 09:45:33 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     liangshengjun <liangshengjun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Topic: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Index: AQHUk4cxG7ymgFtVv0SioeUwSrP51KWCKqFw
Date:   Mon, 17 Dec 2018 01:45:33 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24E217B3@dggemm526-mbx.china.huawei.com>
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
 <87efaklcd1.fsf@linux.intel.com>
 <678F3D1BB717D949B966B68EAEB446ED24E20BE5@dggemm526-mbx.china.huawei.com>
 <878t0sl5br.fsf@linux.intel.com>
 <30102591E157244384E984126FC3CB4F639AA2A3@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639AA2A3@us01wembx1.internal.synopsys.com>
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

SGkgVGhpbmg6DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFRoaW5oIE5n
dXllbiBbbWFpbHRvOnRoaW5oLm5ndXllbkBzeW5vcHN5cy5jb21dDQo+U2VudDogU2F0dXJkYXks
IERlY2VtYmVyIDE1LCAyMDE4IDU6NDMgQU0NCj5UbzogRmVsaXBlIEJhbGJpIDxiYWxiaUBrZXJu
ZWwub3JnPjsgWmVuZ3RhbyAoQikNCj48cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KPkNjOiBs
aWFuZ3NoZW5nanVuIDxsaWFuZ3NoZW5nanVuQGhpc2lsaWNvbi5jb20+OyBHcmVnIEtyb2FoLUhh
cnRtYW4NCj48Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBsaW51eC11c2JAdmdlci5rZXJu
ZWwub3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRoaW5oIE5ndXllbg0KPjx0
aGluaC5uZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdj
MzogZ2FkZ2V0OiBmaXggbWlzcyBpc29jIGlzc3VlIGludHJvZHVjZWQgYnkNCj5JUlEgbGF0ZW5j
eQ0KPg0KPkhpIFplbmd0YW8sDQo+DQo+T24gMTIvMTQvMjAxOCAzOjI0IEFNLCBGZWxpcGUgQmFs
Ymkgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiAiWmVuZ3RhbyAoQikiIDxwcmltZS56ZW5nQGhpc2ls
aWNvbi5jb20+IHdyaXRlczoNCj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4g
RnJvbTogRmVsaXBlIEJhbGJpIFttYWlsdG86YmFsYmlAa2VybmVsLm9yZ10NCj4+Pj4gU2VudDog
RnJpZGF5LCBEZWNlbWJlciAxNCwgMjAxOCA0OjUyIFBNDQo+Pj4+IFRvOiBaZW5ndGFvIChCKSA8
cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KPj4+PiBDYzogbGlhbmdzaGVuZ2p1biA8bGlhbmdz
aGVuZ2p1bkBoaXNpbGljb24uY29tPjsgWmVuZ3RhbyAoQikNCj4+Pj4gPHByaW1lLnplbmdAaGlz
aWxpY29uLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPj4+PiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOw0KPj4+PiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzogZ2Fk
Z2V0OiBmaXggbWlzcyBpc29jIGlzc3VlDQo+Pj4+IGludHJvZHVjZWQgYnkgSVJRIGxhdGVuY3kN
Cj4+Pj4NCj4+Pj4gKiBQR1AgU2lnbmVkIGJ5IGFuIHVua25vd24ga2V5DQo+Pj4+DQo+Pj4+IFpl
bmcgVGFvIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+IHdyaXRlczoNCj4+Pj4NCj4+Pj4+IElm
IGl0J3MgYSBidXN5IHN5c3RlbSwgc29tZSB0aW1lcyB3aGVuIHdlIHN0YXJ0IGFuIGlzb2MgdHJh
bnNmZXIsDQo+Pj4+PiB0aGUgZnJhbWVudW1iZXIgZ2V0IGZyb20gdGhlIGV2ZW50IGJ1ZmZlciBt
YXkgYmUgYWxyZWFkeSBlbGFzcGVkLA0KPj4+Pj4gaW4gdGhpcyBjYXNlLCB3ZSB3aWxsIGdldCBh
bGwgdGhlIHBhY2tldHMgZHJvcHBlZCBkdWUgdG8gbWlzcyBpc29jLg0KPj4+Pj4gQW5kIHdlIHR1
cm4gaW50byB0cmFuc2ZlciBub3RoaW5nLCB0byBmaXggdGhpcyBpc3N1ZSwgd2UgbmVlZCB0bw0K
Pj4+Pj4gZml4IHRoZSBmcmFtZW51bWJlciB0byBtYWtlIHN1cmUgdGhhdCBpdCdzIG5vdCBvdXQg
b2YgZGF0ZS4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBTaGVuZ2p1biA8bGlh
bmdzaGVuZ2p1bkBoaXNpbGljb24uY29tPg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogWmVuZyBUYW8g
PHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT4NCj4+Pj4gVGhlcmUncyBhIHBhdGNoIGdvaW5nIHVw
c3RyZWFtIGFscmVhZHkgZG9pbmcgdGhpczoNCj4+Pj4NCj4+Pj4NCj5odHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9iYWxiaS91c2IuZ2l0L2NvbW1pdA0KPj4+
PiAvP2gNCj4+Pj4gPW5leHQmaWQ9ZDUzNzAxMDY3ZjA0OGI4YjExNjM1ZTk2NGI2ZDNiZDlhMjQ4
YzYyMg0KPj4+Pg0KPj4+IFNvcnJ5LCBJIHRoaW5rIEkgbWlzc2VkIHRvIHVwZGF0ZSB0byB0aGUg
bGF0ZXN0IHZlcnNpb24uIEJ1dCBJIHRoaW5rDQo+Pj4gbXkgcGF0Y2ggaXMgbW9yZSBlZmZpY2ll
bnQuIEJlY2F1c2UgSSBqdXN0IHN5bmMgdGhlIGZyYW1lIGZyb20gdGhlDQo+Pj4gSFcsIGl0ICB3
b24ndCBmYWlsIGFuZCB0aGVyZSBpcyBubyBuZWVkIHRvIGV4dHJhIHRyaWVzLg0KPj4+DQo+Pj4g
V2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgaXQ/DQo+PiB0aGUgMTQgYml0cyB5b3UgdXNlIGZvciB5
b3VyIGNoZWNrIGlzIG5vdCByZXByZXNlbnRhdGl2ZSBvZiB0aGUgYWN0dWFsDQo+PiBtaWNyby1m
cmFtZSB5b3UncmUgY3VycmVudGx5IGluLiBUaGluaCBleHBsYWluZWQgdGhhdCBpbiB0aGUNCj4+
IGRpc2N1c3Npb24gd2UgaGFkIHVudGlsIHdlIGNhbWUgdG8gdGhlIHBhdGNoIEkgcG9pbnRlZCB5
b3UgdG8gYWJvdmUuDQo+PiBQbGVhc2UgbG9vayBhdCB0aGUgbWFpbGluZyBsaXN0IGFyY2hpdmVz
IGZvciBkZXRhaWxzLg0KPj4NCj4NCj5UaGVyZSBhcmUgc2V2ZXJhbCBpc3N1ZXMgd2l0aCB0aGlz
IHBhdGNoLg0KPjEpIFlvdXIgZnJhbWUgZWxhcHNlZCB0aW1lIGNoZWNrIGlzIG5vdCBiYXNlZCBv
biBpbnRlcnZhbCBidXQgc3RhdGljYWxseQ0KPkRXQzNfRVZFTlRfUFJBTV9TT0ZGTiAvIDIuIFRo
YXQncyBhYm91dCAxIHNlY29uZC4gU28gaXQgZG9lc24ndA0KPmFjY291bnQgZm9yIGlzb2MgdHJh
bnNmZXJzIHdpdGggbGFyZ2Ugc2VydmljZSBpbnRlcnZhbCBvZiAxIHNlYyBvciBtb3JlLg0KDQoN
ClRoaXMgaXMganVzdCBmb3IgY2hlY2tpbmcgd2hldGhlciB0aGUgRnJhbWUgbnVtYmVyIGlzIG92
ZXJmbG93IG9yIG5vdC4gU28NCjEgc2Vjb25kIHNob3VsZCBhIHJlYXNvbiB2YWx1ZS4NCg0KPjIp
IFRoaXMgZnVuY3Rpb24gX19kd2MzX2dhZGdldF90YXJnZXRfZnJhbWVfZWxhcHNlZCgpIHNob3Vs
ZCBoYXZlDQo+Y29tbWVudHMgZm9yIHdoYXQgaXQgZG9lcy4gVGhlIG5hbWUgaW1wbGllcyB0aGF0
IHRoaXMgZnVuY3Rpb24gY2hlY2tzDQo+Zm9yIGVmcmFtZSA+IGNmcmFtZSwgYW5kIG5vdCBlZnJh
bWUgPiBjZnJhbWUgKyAxcy4NCmVmcmFtZSA+IGNmcmFtZSArIDFzIGlzIHVzZWQgdG8gZGVhbCB3
aXRoIHRoZSBGcmFtZSBudW1iZXIgb3ZlcmZsb3cuDQoNCj4zKSBJZiB0aGlzIGNoZWNrIGZhaWxz
LCB0aGVuIGl0IHdpbGwgZG8gRFdDM19BTElHTl9GUkFNRSgpIGF0IGxlYXN0IHR3aWNlLg0KPlRo
ZSBpc29jIHRyYW5zZmVyIHdpbGwgc3RhcnQgMSBtb3JlIGludGVydmFsIGludG8gdGhlIGZ1dHVy
ZSB0aGFuIGl0IG5lZWRzIHRvLg0KPg0KSWYgdGhlIGludGVydmFsIGlzIG9uZSwgMSBtb3JlIGlu
dGVydmFsIHNob3VsZCBiZSBtb3JlIHJlYXNvbmFibGUgYmVjYXVzZSB0aGUNCmNvcmUgYWx3YXlz
IGZldGNoIHRoZSB0cmIgb25lIGZyYW1lIGFoZWFkLg0KDQo+QWxzbywgSSB0aGluayB0aGUgcm9s
ZSBvZiB0aGlzIGNoZWNrIHNob3VsZCBiZSBmcm9tIHRoZSBjb250cm9sbGVyIGFzIGl0IGhhcw0K
Pm1vcmUgaW5mb3JtYXRpb24gYW5kIGl0cyBvd24gbG9naWMgdG8gZGVjaWRlIGlmIHRoZSBzZWxl
Y3RlZCBmdXR1cmUgdWZyYW1lDQo+aGFzIGVsYXBzZWQuDQoNClllcywgYWdyZWUsIGJ1dCBJIHRo
aW5rIGlmIHRoZSBzdyBjYW4gYmUgdXNlZCB0byBkbyB0aGUgc2FtZSB0aGluZyBhbmQgbW9yZQ0K
ZWZmZWN0aXZlLCBXaHkgbm90PyANCg0KQlINClplbmd0YW8gDQo=
