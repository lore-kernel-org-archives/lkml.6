Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1788C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518EC20C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518EC20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeHTFM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:12:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6025 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbeHTFM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:12:56 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 376FB5EF0FD8D;
        Mon, 20 Aug 2018 09:59:15 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Mon, 20 Aug 2018 09:59:16 +0800
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.48]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0399.000;
 Mon, 20 Aug 2018 09:59:12 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "joe@perches.com" <joe@perches.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v2] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Topic: [PATCH v2] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Index: AQHUNdWsdSodxxVthkm8sVFiQ00YKKTDeMqAgARskpA=
Date:   Mon, 20 Aug 2018 01:59:11 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C9CAC39@DGGEMM506-MBX.china.huawei.com>
References: <1534503120-1226-1-git-send-email-prime.zeng@hisilicon.com>
 <Pine.LNX.4.44L0.1808171018220.1451-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1808171018220.1451-100000@iolanthe.rowland.org>
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

SGkgQWxhbjoNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj5Gcm9tOiBBbGFuIFN0ZXJuIFttYWlsdG86c3Rlcm5Acm93bGFuZC5oYXJ2YXJk
LmVkdV0NCj5TZW50OiBGcmlkYXksIEF1Z3VzdCAxNywgMjAxOCAxMDoxOSBQTQ0KPlRvOiBaZW5n
dGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KPkNjOiBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgbWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb207DQo+ZHJpbmtjYXRAY2hy
b21pdW0ub3JnOyBmZWxpcGUuYmFsYmlAbGludXguaW50ZWwuY29tOw0KPmRyYWtlQGVuZGxlc3Nt
LmNvbTsgbWlrZS5sb29pam1hbnNAdG9waWMubmw7IGpvZUBwZXJjaGVzLmNvbTsNCj5Kb25hdGhh
biBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+Ow0KPkluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPjsgUmFmYWVsIEouIFd5c29j
a2kNCj48cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBNYXJjIFp5bmdpZXIgPG1hcmMuenlu
Z2llckBhcm0uY29tPjsNCj5LYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5j
b20+OyBUaHltbyB2YW4gQmVlcnMNCj48dGh5bW92YW5iZWVyc0BnbWFpbC5jb20+OyBGcmVkZXJp
YyBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPjsNCj5Lb25yYWQgUnplc3p1dGVrIFdp
bGsgPGtvbnJhZC53aWxrQG9yYWNsZS5jb20+OyBEYXZpZCBSaWVudGplcw0KPjxyaWVudGplc0Bn
b29nbGUuY29tPjsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gdXNiOiBodWI6IHRyeSBvbGQgZW51bWVyYXRpb24gc2NoZW1lIGZpcnN0IGZvciBo
aWdoDQo+c3BlZWQgZGV2aWNlcw0KPg0KPk9uIEZyaSwgMTcgQXVnIDIwMTgsIFplbmcgVGFvIHdy
b3RlOg0KPg0KPj4gVGhlIG5ldyBzY2hlbWUgaXMgcmVxdWlyZWQganVzdCB0byBzdXBwb3J0IGxl
Z2FjeSBsb3cgYW5kIGZ1bGwtc3BlZWQNCj4+IGRldmljZXMuIEZvciBoaWdoIHNwZWVkIGRldmlj
ZXMsIGl0IHdpbGwgc2xvd2VyIHRoZSBlbnVtZXJhdGlvbiBzcGVlZC4NCj4+IFNvIGluIHRoaXMg
cGF0Y2ggd2UgdHJ5IHRoZSAib2xkIiBlbnVtZXJhdGlvbiBzY2hlbWUgZmlyc3QgZm9yIGhpZ2gN
Cj4+IHNwZWVkIGRldmljZXMsIGFuZCB0aGlzIGlzIHdoYXQgV2luZG93cyBkb2VzIHNpbmNlIFdp
bmRvd3MgOC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaZW5nIFRhbyA8cHJpbWUuemVuZ0BoaXNp
bGljb24uY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4gMS4gQXMgc3VnZ2VzdGVk
IGJ5IEFsYW4sIG1lbnRpb24gaW4gdGhlIGNvbW1pdCBsb2cgdGhhdCB0aGlzIGNoYW5nZSBpcw0K
Pj4gZm9sbG93IHdoYXQgdGhlIFdpbmRvdyBkb2VzLg0KPj4gMi4gQXMgc3VnZ2VzdGVkIGJ5IFJv
Z2VyLCB1cGRhdGUgdGhlIGtlcm5lbC1wYXJhbWV0ZXIgZGVzY3JpcHRpb24uDQo+PiAtLS0NCj4+
ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8IDMgKyst
DQo+PiAgZHJpdmVycy91c2IvY29yZS9odWIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCA1
ICsrKystDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVs
LXBhcmFtZXRlcnMudHh0DQo+PiBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBh
cmFtZXRlcnMudHh0DQo+PiBpbmRleCA1MzNmZjVjLi45NWRiMjNjIDEwMDY0NA0KPj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+PiBAQCAt
NDQ1Myw3ICs0NDUzLDggQEANCj4+DQo+PiAgCXVzYmNvcmUub2xkX3NjaGVtZV9maXJzdD0NCj4+
ICAJCQlbVVNCXSBTdGFydCB3aXRoIHRoZSBvbGQgZGV2aWNlIGluaXRpYWxpemF0aW9uDQo+PiAt
CQkJc2NoZW1lIChkZWZhdWx0IDAgPSBvZmYpLg0KPj4gKwkJCXNjaGVtZSwgIGFwcGxpZXMgb25s
eSB0byBsb3cgYW5kIGZ1bGwtc3BlZWQgZGV2aWNlcw0KPj4gKwkJCSAoZGVmYXVsdCAwID0gb2Zm
KS4NCj4+DQo+PiAgCXVzYmNvcmUudXNiZnNfbWVtb3J5X21iPQ0KPj4gIAkJCVtVU0JdIE1lbW9y
eSBsaW1pdCAoaW4gTUIpIGZvciBidWZmZXJzIGFsbG9jYXRlZCBieSBkaWZmIC0tZ2l0DQo+PiBh
L2RyaXZlcnMvdXNiL2NvcmUvaHViLmMgYi9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jIGluZGV4DQo+
PiAxZmIyNjY4Li5kMjY1YjE5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvY29yZS9odWIu
Yw0KPj4gKysrIGIvZHJpdmVycy91c2IvY29yZS9odWIuYw0KPj4gQEAgLTI2NjEsMTAgKzI2NjEs
MTMgQEAgc3RhdGljIGJvb2wgdXNlX25ld19zY2hlbWUoc3RydWN0DQo+dXNiX2RldmljZSAqdWRl
diwgaW50IHJldHJ5LA0KPj4gIAlpbnQgb2xkX3NjaGVtZV9maXJzdF9wb3J0ID0NCj4+ICAJCXBv
cnRfZGV2LT5xdWlya3MgJiBVU0JfUE9SVF9RVUlSS19PTERfU0NIRU1FOw0KPj4NCj4+ICsJaW50
IHF1aWNrX2VudW1lcmF0aW9uID0gKHVkZXYtPnNwZWVkID09IFVTQl9TUEVFRF9ISUdIKTsNCj4N
Ck9rZXksIHdpbGwgZml4IGluIHYzDQoNCj5NaW5vciBzdHlsZSBwb2ludDogdGhlIHByZWNlZGlu
ZyBibGFuayBsaW5lIHNob3VsZCBiZSBlbGltaW5hdGVkLg0KPg0KPj4gKw0KPj4gIAlpZiAodWRl
di0+c3BlZWQgPj0gVVNCX1NQRUVEX1NVUEVSKQ0KPj4gIAkJcmV0dXJuIGZhbHNlOw0KPj4NCj4+
IC0JcmV0dXJuIFVTRV9ORVdfU0NIRU1FKHJldHJ5LCBvbGRfc2NoZW1lX2ZpcnN0X3BvcnQgfHwN
Cj5vbGRfc2NoZW1lX2ZpcnN0KTsNCj4+ICsJcmV0dXJuIFVTRV9ORVdfU0NIRU1FKHJldHJ5LCBv
bGRfc2NoZW1lX2ZpcnN0X3BvcnQgfHwNCj5vbGRfc2NoZW1lX2ZpcnN0DQo+PiArCQkJICAgICAg
fHwgcXVpY2tfZW51bWVyYXRpb24pOw0KPj4gIH0NCj4+DQo+PiAgLyogSXMgYSBVU0IgMy4wIHBv
cnQgaW4gdGhlIEluYWN0aXZlIG9yIENvbXBsaWFuY2UgTW9kZSBzdGF0ZT8NCj4NCj5Bc2lkZSBm
cm9tIHRoYXQ6DQo+DQo+QWNrZWQtYnk6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFy
ZC5lZHU+DQoNCk9rYXkgLCB0YWcgd2lsbCBiZSBhcHBsaWVkIGluIHYzLg0KDQoNCg==
