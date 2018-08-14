Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A51C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40301216E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40301216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHNKTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:19:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6405 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731231AbeHNKTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:19:09 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 066A844F0B10F;
        Tue, 14 Aug 2018 15:33:06 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.26]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0399.000;
 Tue, 14 Aug 2018 15:33:02 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Roger Quadros <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "joe@perches.com" <joe@perches.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Topic: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Index: AQHUMHhu69J7qZINb0WTPExaubbbVKS4SOuAgAaUR1A=
Date:   Tue, 14 Aug 2018 07:33:01 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C9B129B@dggemm526-mbx.china.huawei.com>
References: <1533913304-15737-1-git-send-email-prime.zeng@hisilicon.com>
 <a29afa26-22b4-3188-f9ee-993e44df7703@ti.com>
In-Reply-To: <a29afa26-22b4-3188-f9ee-993e44df7703@ti.com>
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

SGkgUm9nZXI6DQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPkZyb206IFJvZ2VyIFF1YWRyb3MgW21haWx0bzpyb2dlcnFAdGkuY29tXQ0KPlNl
bnQ6IEZyaWRheSwgQXVndXN0IDEwLCAyMDE4IDY6NTEgUE0NCj5UbzogWmVuZ3RhbyAoQikgPHBy
aW1lLnplbmdAaGlzaWxpY29uLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPnN0
ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU7IG1hdGhpYXMubnltYW5AbGludXguaW50ZWwuY29tOw0K
PmRyaW5rY2F0QGNocm9taXVtLm9yZzsgZmVsaXBlLmJhbGJpQGxpbnV4LmludGVsLmNvbTsgZHJh
a2VAZW5kbGVzc20uY29tOw0KPm1pa2UubG9vaWptYW5zQHRvcGljLm5sOyBqb2VAcGVyY2hlcy5j
b20NCj5DYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogaHViOiB0cnkgb2xkIGVudW1lcmF0
aW9uIHNjaGVtZSBmaXJzdCBmb3IgaGlnaCBzcGVlZA0KPmRldmljZXMNCj4NCj5IaSwNCj4NCj5P
biAxMC8wOC8xOCAxODowMSwgWmVuZyBUYW8gd3JvdGU6DQo+PiBUaGUgbmV3IHNjaGVtZSBpcyBy
ZXF1aXJlZCBqdXN0IHRvIHN1cHBvcnQgbGVnYWN5IGxvdyBhbmQgZnVsbC1zcGVlZA0KPj4gZGV2
aWNlcy4gRm9yIGhpZ2ggc3BlZWQgZGV2aWNlcywgaXQgd2lsbCBzbG93ZXIgdGhlIGVudW1lcmF0
aW9uIHNwZWVkLg0KPj4gU28gaW4gdGhpcyBwYXRjaCB3ZSB0cnkgdGhlICJvbGQiIGVudW1lcmF0
aW9uIHNjaGVtZSBmaXJzdCBmb3IgaGlnaA0KPj4gc3BlZWQgZGV2aWNlcy4NCj4NCj5Ib3cgc2xv
dyBkb2VzIGl0IGdldD8gSXMgaXQgc2lnbmlmaWNhbnQ/DQo+RG8gd2UgcmlzayBicmVha2luZyBl
eGlzdGluZyBIUyBkZXZpY2VzIHRoYXQgd29yaz8gSSBkb24ndCB0aGluayB3ZSBjYW4gYmUgc3Vy
ZQ0KPnRpbGwgd2UgcnVuIHRoaXMgdGhyb3VnaCB0ZXN0aW5nLg0KPg0KDQpXZSBhZGRlZCB0aGUg
bmV3IHNjaGVtZSBiZWNhdXNlIHRoaXMgaXMgd2hhdCB0aGUgd2luZG93cyBkaWQgLCBhbmQgbWFp
bmx5IGZvciANCmxlZ2FjeSBsb3cgYW5kIGZ1bGwgc3BlZWQgZGV2aWNlcy4NCk5vdyBmb3IgbmV3
IHdpbmRvd3MgdmVyc2lvbig4LjEgYW5kIGxhdGVyKSwgdGhlIHNlY29uZCBwb3J0IHJlc2V0IGhh
cyBhbHJlYWR5IGJlZW4NCnJlbW92ZWQgZm9yIGhpZ2ggc3BlZWQgZGV2aWNlcyBmb3IgYmV0dGVy
IGVudW1lcmF0aW9uIHNwZWVkLg0KQW5kIEluIHRoaXMgcGF0Y2ggaWYgdXNlX2JvdGhfc2NoZW1l
cyBpcyB0cnVlLCBpdCB3aWxsIGZhbGxiYWNrIHRvIG5ldyBzY2hlbWUgaWYgdGhlIG9sZA0Kc2No
ZW1lIGZhaWxzLg0KDQpTbyBJIHRoaW5rIGl0J3MgcmVhc29uYWJsZSB0byBmb2xsb3cgdGhlIHdp
bmRvd3MgYmVoYXZpb3IgYWdhaW4uDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaZW5nIFRhbyA8
cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy91c2IvY29yZS9o
dWIuYyB8IDUgKysrKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMgYi9k
cml2ZXJzL3VzYi9jb3JlL2h1Yi5jIGluZGV4DQo+PiAxZmIyNjY4Li5kMjY1YjE5IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy91c2IvY29yZS9odWIuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvY29y
ZS9odWIuYw0KPj4gQEAgLTI2NjEsMTAgKzI2NjEsMTMgQEAgc3RhdGljIGJvb2wgdXNlX25ld19z
Y2hlbWUoc3RydWN0IHVzYl9kZXZpY2UNCj4qdWRldiwgaW50IHJldHJ5LA0KPj4gIAlpbnQgb2xk
X3NjaGVtZV9maXJzdF9wb3J0ID0NCj4+ICAJCXBvcnRfZGV2LT5xdWlya3MgJiBVU0JfUE9SVF9R
VUlSS19PTERfU0NIRU1FOw0KPj4NCj4+ICsJaW50IHF1aWNrX2VudW1lcmF0aW9uID0gKHVkZXYt
PnNwZWVkID09IFVTQl9TUEVFRF9ISUdIKTsNCj4+ICsNCj4+ICAJaWYgKHVkZXYtPnNwZWVkID49
IFVTQl9TUEVFRF9TVVBFUikNCj4+ICAJCXJldHVybiBmYWxzZTsNCj4NCj5ob3cgYWJvdXQgcmVw
bGFjaW5nIHRoZSBhYm92ZSBpZiB3aXRoDQo+DQo+CWlmICh1ZGV2LT5zcGVlZCA+PSBVU0JfU1BF
RURfSElHSCkNCj4JCXJldHVybiBmYWxzZTsNCg0KTm8sIGZvciBTUyBkZXZpY2UsIG9ubHkgdXNl
IG9sZCBzY2hlbWUsIGJ1dCBmb3Igc3BlZWQgZGV2aWNlLCB3ZSBjYW4gZmFsbGJhY2sgdG8gbmV3
IA0Kc2NoZW1lIGlmIHRoZSBvbGQgZmFpbHMuDQoNCj4+DQo+PiAtCXJldHVybiBVU0VfTkVXX1ND
SEVNRShyZXRyeSwgb2xkX3NjaGVtZV9maXJzdF9wb3J0IHx8DQo+b2xkX3NjaGVtZV9maXJzdCk7
DQo+PiArCXJldHVybiBVU0VfTkVXX1NDSEVNRShyZXRyeSwgb2xkX3NjaGVtZV9maXJzdF9wb3J0
IHx8DQo+b2xkX3NjaGVtZV9maXJzdA0KPj4gKwkJCSAgICAgIHx8IHF1aWNrX2VudW1lcmF0aW9u
KTsNCj4+ICB9DQo+DQo+Tm93IHdlIG5vIGxvbmdlciByZXNwZWN0IHRoZSAib2xkX3NjaGVtZV9m
aXJzdCIgcGFyYW1ldGVyIGZvciBtb3N0IG9mIHRoZQ0KPmRldmljZXMuDQo+DQo+SXQgc2hvdWxk
IGJlIGNsYXJpZmllZCBpbiBEb2N1bWVudGF0aW9uL2FkbWluL2tlcm5lbC1wYXJhbWV0ZXJzLnR4
dCB0aGF0DQo+Im9sZF9zY2hlbWVfZmlyc3QiIGlzIG9ubHkgYXBwbGljYWJsZSB0byBMT1cvRlVM
TCBzcGVlZCBkZXZpY2VzLg0KPg0KDQpPbiB0aGUgY29udHJhcnksIG5ldyBzY2hlbWUgaXMgb25s
eSBhcHBsaWNhYmxlIGZvciBMT1cvRlVMTCBzcGVlZCBkZXZpY2VzPyANCg0KPj4NCj4+ICAvKiBJ
cyBhIFVTQiAzLjAgcG9ydCBpbiB0aGUgSW5hY3RpdmUgb3IgQ29tcGxpYW5jZSBNb2RlIHN0YXRl
Pw0KPj4NCj4NCj4tLQ0KPlRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmth
dHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQu
IEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
