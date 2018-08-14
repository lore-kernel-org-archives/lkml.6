Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF04C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F6221706
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F6221706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeHNKVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:21:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbeHNKVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:21:03 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 0601C8C75F387;
        Tue, 14 Aug 2018 15:35:02 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.26]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0399.000;
 Tue, 14 Aug 2018 15:35:00 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <rogerq@ti.com>
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
Thread-Index: AQHUMHhu69J7qZINb0WTPExaubbbVKS4SOuAgAA6VQCABl4BAA==
Date:   Tue, 14 Aug 2018 07:35:00 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C9B12B9@dggemm526-mbx.china.huawei.com>
References: <a29afa26-22b4-3188-f9ee-993e44df7703@ti.com>
 <Pine.LNX.4.44L0.1808101017050.1425-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1808101017050.1425-100000@iolanthe.rowland.org>
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

SGkgYWxhbjogDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGxpbnV4LXVz
Yi1vd25lckB2Z2VyLmtlcm5lbC5vcmcNCj5bbWFpbHRvOmxpbnV4LXVzYi1vd25lckB2Z2VyLmtl
cm5lbC5vcmddIE9uIEJlaGFsZiBPZiBBbGFuIFN0ZXJuDQo+U2VudDogRnJpZGF5LCBBdWd1c3Qg
MTAsIDIwMTggMTA6MjAgUE0NCj5UbzogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRpLmNvbT4NCj5D
YzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnOw0KPm1hdGhpYXMubnltYW5AbGludXguaW50ZWwuY29tOyBkcmlua2NhdEBj
aHJvbWl1bS5vcmc7DQo+ZmVsaXBlLmJhbGJpQGxpbnV4LmludGVsLmNvbTsgZHJha2VAZW5kbGVz
c20uY29tOyBtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubDsNCj5qb2VAcGVyY2hlcy5jb207IGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJq
ZWN0OiBSZTogW1BBVENIXSB1c2I6IGh1YjogdHJ5IG9sZCBlbnVtZXJhdGlvbiBzY2hlbWUgZmly
c3QgZm9yIGhpZ2ggc3BlZWQNCj5kZXZpY2VzDQo+DQo+T24gRnJpLCAxMCBBdWcgMjAxOCwgUm9n
ZXIgUXVhZHJvcyB3cm90ZToNCj4NCj4+IEhpLA0KPj4NCj4+IE9uIDEwLzA4LzE4IDE4OjAxLCBa
ZW5nIFRhbyB3cm90ZToNCj4+ID4gVGhlIG5ldyBzY2hlbWUgaXMgcmVxdWlyZWQganVzdCB0byBz
dXBwb3J0IGxlZ2FjeSBsb3cgYW5kIGZ1bGwtc3BlZWQNCj4+ID4gZGV2aWNlcy4gRm9yIGhpZ2gg
c3BlZWQgZGV2aWNlcywgaXQgd2lsbCBzbG93ZXIgdGhlIGVudW1lcmF0aW9uIHNwZWVkLg0KPj4g
PiBTbyBpbiB0aGlzIHBhdGNoIHdlIHRyeSB0aGUgIm9sZCIgZW51bWVyYXRpb24gc2NoZW1lIGZp
cnN0IGZvciBoaWdoDQo+PiA+IHNwZWVkIGRldmljZXMuDQo+Pg0KPj4gSG93IHNsb3cgZG9lcyBp
dCBnZXQ/IElzIGl0IHNpZ25pZmljYW50Pw0KPj4gRG8gd2UgcmlzayBicmVha2luZyBleGlzdGlu
ZyBIUyBkZXZpY2VzIHRoYXQgd29yaz8gSSBkb24ndCB0aGluayB3ZQ0KPj4gY2FuIGJlIHN1cmUg
dGlsbCB3ZSBydW4gdGhpcyB0aHJvdWdoIHRlc3RpbmcuDQo+DQo+SW5kZWVkLiAgSSBhbSBleHRy
ZW1lbHkgc2tlcHRpY2FsIGFib3V0IGEgcGF0Y2ggbGlrZSB0aGlzLCB1bmxlc3Mgc29tZWJvZHkg
Y2FuDQo+c2hvdyB0aGF0IFdpbmRvd3MgdXNlcyB0aGUgIm9sZCIgc2NoZW1lIGZvciBoaWdoLXNw
ZWVkIGRldmljZXMuDQoNClllcywgdGhpcyBpcyB3aGF0IHRoZSB3aW5kb3dzIGhhcyBkb25lLCB5
b3UgY2FuIHJlZmVyIHRvIA0KaHR0cHM6Ly9ibG9ncy5tc2RuLm1pY3Jvc29mdC5jb20vdXNiY29y
ZWJsb2cvMjAxMy8wNC8xMS91c2ItMi0xLTItMC0xLTEtZGV2aWNlLWVudW1lcmF0aW9uLWNoYW5n
ZXMtaW4td2luZG93cy04Lw0KDQo+DQo+QWxhbiBTdGVybg0KDQo=
