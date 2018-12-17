Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39492206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeLQByp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:54:45 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:6519 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbeLQByo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:54:44 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id D604BFD8A5CE2;
        Mon, 17 Dec 2018 09:54:39 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.137]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0415.000;
 Mon, 17 Dec 2018 09:54:32 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     liangshengjun <liangshengjun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Topic: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Index: AQHUk4cxG7ymgFtVv0SioeUwSrP51KV9kB2AgASfOMA=
Date:   Mon, 17 Dec 2018 01:54:31 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24E217CD@dggemm526-mbx.china.huawei.com>
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
 <67af347c-39fb-a11c-ab95-7741c58b6dd6@cogentembedded.com>
In-Reply-To: <67af347c-39fb-a11c-ab95-7741c58b6dd6@cogentembedded.com>
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

SGkgU2VyZ2VpOg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBTZXJnZWkg
U2h0eWx5b3YgW21haWx0bzpzZXJnZWkuc2h0eWx5b3ZAY29nZW50ZW1iZWRkZWQuY29tXQ0KPlNl
bnQ6IEZyaWRheSwgRGVjZW1iZXIgMTQsIDIwMTggNzoxOCBQTQ0KPlRvOiBaZW5ndGFvIChCKSA8
cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgYmFsYmlAa2VybmVsLm9yZw0KPkNjOiBsaWFuZ3No
ZW5nanVuIDxsaWFuZ3NoZW5nanVuQGhpc2lsaWNvbi5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4N
Cj48Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
Ow0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSB1
c2I6IGR3YzM6IGdhZGdldDogZml4IG1pc3MgaXNvYyBpc3N1ZSBpbnRyb2R1Y2VkIGJ5DQo+SVJR
IGxhdGVuY3kNCj4NCj5IZWxsbyENCj4NCj5PbiAxMi8xNC8yMDE4IDA3OjMyIFBNLCBaZW5nIFRh
byB3cm90ZToNCj4NCj4+IElmIGl0J3MgYSBidXN5IHN5c3RlbSwgc29tZSB0aW1lcyB3aGVuIHdl
IHN0YXJ0IGFuIGlzb2MgdHJhbnNmZXIsIHRoZQ0KPj4gZnJhbWVudW1iZXIgZ2V0IGZyb20gdGhl
IGV2ZW50IGJ1ZmZlciBtYXkgYmUgYWxyZWFkeSBlbGFzcGVkLCBpbiB0aGlzDQo+DQo+ICAgRnJh
bWUgbnVtYmVyPyBFbHNlIG15IHNwZWxsIGNoZWNrZXIgdHJpcHMuIDotKQ0KPg0KPj4gIGNhc2Us
IHdlIHdpbGwgZ2V0IGFsbCB0aGUgcGFja2V0cyBkcm9wcGVkIGR1ZSB0byBtaXNzIGlzb2MuIEFu
ZCB3ZQ0KPj4gdHVybg0KPg0KPiAgIFJlbW92ZSB0aGUgbGVhZGluZyBzcGFjZSwgcGxlYXNlLg0K
Pg0KPj4gaW50byB0cmFuc2ZlciBub3RoaW5nLCB0byBmaXggdGhpcyBpc3N1ZSwgd2UgbmVlZCB0
byBmaXggdGhlDQo+PiBmcmFtZW51bWJlciB0byBtYWtlIHN1cmUgdGhhdCBpdCdzIG5vdCBvdXQg
b2YgZGF0ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBTaGVuZ2p1biA8bGlhbmdzaGVu
Z2p1bkBoaXNpbGljb24uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmVuZyBUYW8gPHByaW1lLnpl
bmdAaGlzaWxpY29uLmNvbT4NCj5bLi4uXQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+PiBpbmRleCA5ZjkyZWUw
Li5iNjNiZDcyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4gQEAgLTEyNjMsNiArMTI2MywxNSBA
QCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKHN0cnVjdA0KPmR3YzMgKmR3YykN
Cj4+ICAJcmV0dXJuIERXQzNfRFNUU19TT0ZGTihyZWcpOw0KPj4gIH0NCj4+DQo+PiArc3RhdGlj
IGJvb2wgX19kd2MzX2dhZGdldF90YXJnZXRfZnJhbWVfZWxhcHNlZChzdHJ1Y3QgZHdjM19lcA0K
PipkZXApIHsNCj4+ICsJdTE2IGNmcmFtZSA9ICBfX2R3YzNfZ2FkZ2V0X2dldF9mcmFtZShkZXAt
PmR3Yyk7DQo+PiArCXUxNiBlZnJhbWUgPSBkZXAtPmZyYW1lX251bWJlciAmDQo+RFdDM19FVkVO
VF9QUkFNX1NPRkZOX01BU0s7DQo+PiArDQo+PiArCXJldHVybiAoKChlZnJhbWUgLSBjZnJhbWUp
ICYgRFdDM19FVkVOVF9QUkFNX1NPRkZOX01BU0spDQo+PiArCQk+IERXQzNfRVZFTlRfUFJBTV9N
QVhfU09GRk4gLyAyKTsNCj4NCj4gICBQbGVhc2UgbGVhdmUgPiBvbiB0aGUgcHJldmlvdXMgbGlu
ZS4NCj4gICBBbmQgeW91IHN1cmVseSBrbm93IHRoYXQgdGhlIG91dGVyIHBhcmVucyBhcmUgdW5u
ZWNlc3Nhcnk/IDotKQ0KPg0KDQpUaGFua3MgZm9yIHlvdXIga2luZGx5IGNvcnJlY3Rpb25zLiA6
LSksIEkgd2lsbCBhcHBseSB0aGVtIGluIHRoZSBwYXRjaCBpZiB3ZSBuZWVkLg0KDQo+Wy4uLl0N
Cj4NCj5NQlIsIFNlcmdlaQ0K
