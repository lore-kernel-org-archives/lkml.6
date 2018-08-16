Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33169C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD322147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD322147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbeHPJRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:17:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbeHPJRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:17:50 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id E806E6C3B3C4F;
        Thu, 16 Aug 2018 14:21:33 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.26]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0399.000;
 Thu, 16 Aug 2018 14:21:33 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Roger Quadros <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHUMHhu69J7qZINb0WTPExaubbbVKS4SOuAgAA6VQCABl4BAP//8QSAgAMd8CA=
Date:   Thu, 16 Aug 2018 06:21:33 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C9B2CC0@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED0C9B12B9@dggemm526-mbx.china.huawei.com>
 <Pine.LNX.4.44L0.1808141022450.1466-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1808141022450.1466-100000@iolanthe.rowland.org>
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

SGkgYWxhbjoNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQWxhbiBTdGVy
biBbbWFpbHRvOnN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHVdDQo+U2VudDogVHVlc2RheSwgQXVn
dXN0IDE0LCAyMDE4IDEwOjQwIFBNDQo+VG86IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2ls
aWNvbi5jb20+DQo+Q2M6IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUB0aS5jb20+OyBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZzsNCj5tYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbTsgZHJpbmtj
YXRAY2hyb21pdW0ub3JnOw0KPmZlbGlwZS5iYWxiaUBsaW51eC5pbnRlbC5jb207IGRyYWtlQGVu
ZGxlc3NtLmNvbTsgbWlrZS5sb29pam1hbnNAdG9waWMubmw7DQo+am9lQHBlcmNoZXMuY29tOyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
U3ViamVjdDogUkU6IFtQQVRDSF0gdXNiOiBodWI6IHRyeSBvbGQgZW51bWVyYXRpb24gc2NoZW1l
IGZpcnN0IGZvciBoaWdoIHNwZWVkDQo+ZGV2aWNlcw0KPg0KPk9uIFR1ZSwgMTQgQXVnIDIwMTgs
IFplbmd0YW8gKEIpIHdyb3RlOg0KPg0KPj4gSGkgYWxhbjoNCj4+DQo+PiA+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBsaW51eC11c2Itb3duZXJAdmdlci5rZXJuZWwub3Jn
DQo+PiA+W21haWx0bzpsaW51eC11c2Itb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYg
T2YgQWxhbiBTdGVybg0KPj4gPlNlbnQ6IEZyaWRheSwgQXVndXN0IDEwLCAyMDE4IDEwOjIwIFBN
DQo+PiA+VG86IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUB0aS5jb20+DQo+PiA+Q2M6IFplbmd0YW8g
KEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+Ow0KPj4gPmdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyBtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbTsNCj4+ID5kcmlua2NhdEBjaHJv
bWl1bS5vcmc7IGZlbGlwZS5iYWxiaUBsaW51eC5pbnRlbC5jb207DQo+PiA+ZHJha2VAZW5kbGVz
c20uY29tOyBtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubDsgam9lQHBlcmNoZXMuY29tOw0KPj4gPmxp
bnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+
ID5TdWJqZWN0OiBSZTogW1BBVENIXSB1c2I6IGh1YjogdHJ5IG9sZCBlbnVtZXJhdGlvbiBzY2hl
bWUgZmlyc3QgZm9yDQo+PiA+aGlnaCBzcGVlZCBkZXZpY2VzDQo+PiA+DQo+PiA+T24gRnJpLCAx
MCBBdWcgMjAxOCwgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4+ID4NCj4+ID4+IEhpLA0KPj4gPj4N
Cj4+ID4+IE9uIDEwLzA4LzE4IDE4OjAxLCBaZW5nIFRhbyB3cm90ZToNCj4+ID4+ID4gVGhlIG5l
dyBzY2hlbWUgaXMgcmVxdWlyZWQganVzdCB0byBzdXBwb3J0IGxlZ2FjeSBsb3cgYW5kDQo+PiA+
PiA+IGZ1bGwtc3BlZWQgZGV2aWNlcy4gRm9yIGhpZ2ggc3BlZWQgZGV2aWNlcywgaXQgd2lsbCBz
bG93ZXIgdGhlIGVudW1lcmF0aW9uDQo+c3BlZWQuDQo+PiA+PiA+IFNvIGluIHRoaXMgcGF0Y2gg
d2UgdHJ5IHRoZSAib2xkIiBlbnVtZXJhdGlvbiBzY2hlbWUgZmlyc3QgZm9yDQo+PiA+PiA+IGhp
Z2ggc3BlZWQgZGV2aWNlcy4NCj4+ID4+DQo+PiA+PiBIb3cgc2xvdyBkb2VzIGl0IGdldD8gSXMg
aXQgc2lnbmlmaWNhbnQ/DQo+PiA+PiBEbyB3ZSByaXNrIGJyZWFraW5nIGV4aXN0aW5nIEhTIGRl
dmljZXMgdGhhdCB3b3JrPyBJIGRvbid0IHRoaW5rIHdlDQo+PiA+PiBjYW4gYmUgc3VyZSB0aWxs
IHdlIHJ1biB0aGlzIHRocm91Z2ggdGVzdGluZy4NCj4+ID4NCj4+ID5JbmRlZWQuICBJIGFtIGV4
dHJlbWVseSBza2VwdGljYWwgYWJvdXQgYSBwYXRjaCBsaWtlIHRoaXMsIHVubGVzcw0KPj4gPnNv
bWVib2R5IGNhbiBzaG93IHRoYXQgV2luZG93cyB1c2VzIHRoZSAib2xkIiBzY2hlbWUgZm9yIGhp
Z2gtc3BlZWQNCj5kZXZpY2VzLg0KPj4NCj4+IFllcywgdGhpcyBpcyB3aGF0IHRoZSB3aW5kb3dz
IGhhcyBkb25lLCB5b3UgY2FuIHJlZmVyIHRvDQo+PiBodHRwczovL2Jsb2dzLm1zZG4ubWljcm9z
b2Z0LmNvbS91c2Jjb3JlYmxvZy8yMDEzLzA0LzExL3VzYi0yLTEtMi0wLTEtDQo+PiAxLWRldmlj
ZS1lbnVtZXJhdGlvbi1jaGFuZ2VzLWluLXdpbmRvd3MtOC8NCj4NCj5BbmQgdGhhdCBibG9nIHBv
c3QgaXMgNSB5ZWFycyBvbGQhDQo+DQo+T2theSwgSSB0aGluayB3ZSBjYW4gZ28gYWhlYWQgYW5k
IG1ha2UgdGhpcyBjaGFuZ2UuICBIb3dldmVyLCB5b3Ugc2hvdWxkDQo+dXBkYXRlIHRoZSBwYXRj
aCBkZXNjcmlwdGlvbiB0byBtZW50aW9uIHdoYXQgTWljcm9zb2Z0IGRpZCBpbiBXaW5kb3dzIDgg
YW5kDQo+c2F5IHRoYXQgdGhlIG5ldyBiZWhhdmlvciBtYXRjaGVzIHRoZWlycy4NCj4NCk9rYXks
IEkgd2lsbCB1cGRhdGUgaXQgdGhlIGNoYW5nZSBsb2cgaW4gdjIuDQoNCj5BbHNvLCBhcyBSb2dl
ciBtZW50aW9uZWQsIHlvdSBzaG91bGQgdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIHRvIHNheSB0
aGF0IHRoZQ0KPm9sZF9zY2hlbWVfZmlyc3QgbW9kdWxlIHBhcmFtZXRlciBub3cgYXBwbGllcyBv
bmx5IHRvIGxvdy0gYW5kIGZ1bGwtc3BlZWQNCj5kZXZpY2VzLCBzaW5jZSBoaWdoLSBhbmQgU3Vw
ZXJTcGVlZCBkZXZpY2VzIGFsd2F5cyB1c2UgdGhlIG9sZCBzY2hlbWUgZmlyc3QuDQo+DQoNClNp
bmNlIHdlIHNob3VsZCBoYXZlIGRlZGljYXRlZCBlbnVtZXJhdGlvbiBmbG93IGZvciBTUywgSElH
SCwgbG93IGFuZCBmdWxsIHNwZWVkIGRldmljZXMsDQpTbyBJIHRoaW5rIHRoZSBvbGRfc2NoZW1l
X2ZpcnN0IGFuZCB1c2VfYm90aF9zY2hlbWVzIHBhcmFtZXRlcnMgc2hvdWxkIGJlIHJlbW92ZWQu
DQpXaGF0IGRvIHlvdSB0aGluayBhYm91dCBpdD8NCg0KPkFsYW4gU3Rlcm4NCg0K
