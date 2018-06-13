Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1992DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CEE208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CEE208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbeFMAbd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:31:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934860AbeFMAba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:31:30 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 8C412A11FB3B0;
        Wed, 13 Jun 2018 08:31:17 +0800 (CST)
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.61]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0382.000; Wed, 13 Jun 2018 08:31:11 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     Farhan Ali <alifm@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        longpeng <longpeng2@huawei.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
Subject: RE: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if
 it's supported
Thread-Topic: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if
 it's supported
Thread-Index: AQHT/1w9irxqESt7g0CZ2KZ6/sbWPKRawPbggAGZ84CAAQDvIA==
Date:   Wed, 13 Jun 2018 00:31:10 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB018593@dggeml511-mbx.china.huawei.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
 <a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
 <33183CC9F5247A488A2544077AF19020DB015ABF@dggeml511-mbx.china.huawei.com>
 <7957a36b-6881-1967-fa60-eaeaa38256c0@linux.ibm.com>
In-Reply-To: <7957a36b-6881-1967-fa60-eaeaa38256c0@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.18.62]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFyaGFuIEFsaSBbbWFp
bHRvOmFsaWZtQGxpbnV4LmlibS5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMywgMjAx
OCAxOjA4IEFNDQo+IFRvOiBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrdm1Admdlci5rZXJuZWwub3JnDQo+
IENjOiBtc3RAcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBsb25ncGVuZw0KPiA8
bG9uZ3BlbmcyQGh1YXdlaS5jb20+OyBwYXNpY0BsaW51eC5pYm0uY29tOyBmcmFua2phQGxpbnV4
LmlibS5jb207DQo+IGJvcm50cmFlZ2VyQGRlLmlibS5jb20NCj4gU3ViamVjdDogUmU6IFtSRkMg
djEgMi8yXSBjcnlwdG8vdmlydGlvLWNyeXB0bzogUmVnaXN0ZXIgYW4gYWxnbyBvbmx5IGlmIGl0
J3MNCj4gc3VwcG9ydGVkDQo+IA0KPiANCj4gDQo+IE9uIDA2LzExLzIwMTggMDQ6NDggQU0sIEdv
bmdsZWkgKEFyZWkpIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogRmFyaGFuIEFsaSBbbWFpbHRvOmFsaWZtQGxpbnV4LmlibS5jb21d
DQo+ID4+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDA5LCAyMDE4IDM6MDkgQU0NCj4gPj4gVG86IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6
IG1zdEByZWRoYXQuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IEdvbmdsZWkgKEFyZWkpDQo+
ID4+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IGxvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2Vp
LmNvbT47DQo+ID4+IHBhc2ljQGxpbnV4LmlibS5jb207IGZyYW5ramFAbGludXguaWJtLmNvbTsg
Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbTsNCj4gPj4gYWxpZm1AbGludXguaWJtLmNvbQ0KPiA+PiBT
dWJqZWN0OiBbUkZDIHYxIDIvMl0gY3J5cHRvL3ZpcnRpby1jcnlwdG86IFJlZ2lzdGVyIGFuIGFs
Z28gb25seSBpZiBpdCdzDQo+IHN1cHBvcnRlZA0KPiA+Pg0KPiA+PiBGcm9tOiBGYXJoYW4gQWxp
IDxhbGlmbUBsaW51eC52bmV0LmlibS5jb20+DQo+ID4+DQo+ID4+IFJlZ2lzdGVyIGEgY3J5cHRv
IGFsZ28gd2l0aCB0aGUgTGludXggY3J5cHRvIGxheWVyIG9ubHkgaWYNCj4gPj4gdGhlIGFsZ29y
aXRobSBpcyBzdXBwb3J0ZWQgYnkgdGhlIGJhY2tlbmQgdmlydGlvLWNyeXB0bw0KPiA+PiBkZXZp
Y2UuDQo+ID4+DQo+ID4+IEFsc28gcm91dGUgY3J5cHRvIHJlcXVlc3RzIHRvIGEgdmlydGlvLWNy
eXB0bw0KPiA+PiBkZXZpY2UsIG9ubHkgaWYgaXQgY2FuIHN1cHBvcnQgdGhlIHJlcXVlc3RlZCBz
ZXJ2aWNlIGFuZA0KPiA+PiBhbGdvcml0aG0uDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEZh
cmhhbiBBbGkgPGFsaWZtQGxpbnV4LmlibS5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMv
Y3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2FsZ3MuYyAgIHwgMTEwDQo+ID4+ICsrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KPiA+PiAgIGRyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9f
Y3J5cHRvX2NvbW1vbi5oIHwgIDExICsrLQ0KPiA+PiAgIGRyaXZlcnMvY3J5cHRvL3ZpcnRpby92
aXJ0aW9fY3J5cHRvX21nci5jICAgIHwgIDgxDQo+ICsrKysrKysrKysrKysrKysrKy0tDQo+ID4+
ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNTggaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQo+
ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by92aXJ0aW8vdmlydGlvX2NyeXB0
b19hbGdzLmMNCj4gPj4gYi9kcml2ZXJzL2NyeXB0by92aXJ0aW8vdmlydGlvX2NyeXB0b19hbGdz
LmMNCj4gPj4gaW5kZXggYmExOTBjZi4uZmVmMTEyYSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9jcnlwdG8vdmlydGlvL3ZpcnRpb19jcnlwdG9fYWxncy5jDQo+ID4+ICsrKyBiL2RyaXZlcnMv
Y3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2FsZ3MuYw0KPiA+PiBAQCAtNDksMTIgKzQ5LDE4
IEBAIHN0cnVjdCB2aXJ0aW9fY3J5cHRvX3N5bV9yZXF1ZXN0IHsNCj4gPj4gICAJYm9vbCBlbmNy
eXB0Ow0KPiA+PiAgIH07DQo+ID4+DQo+ID4+ICtzdHJ1Y3QgdmlydGlvX2NyeXB0b19hbGdvIHsN
Cj4gPj4gKwl1aW50MzJfdCBhbGdvbnVtOw0KPiA+PiArCXVpbnQzMl90IHNlcnZpY2U7DQo+ID4+
ICsJdW5zaWduZWQgaW50IGFjdGl2ZV9kZXZzOw0KPiA+PiArCXN0cnVjdCBjcnlwdG9fYWxnIGFs
Z287DQo+ID4+ICt9Ow0KPiA+PiArDQo+ID4+ICAgLyoNCj4gPj4gICAgKiBUaGUgYWxnc19sb2Nr
IHByb3RlY3RzIHRoZSBiZWxvdyBnbG9iYWwgdmlydGlvX2NyeXB0b19hY3RpdmVfZGV2cw0KPiA+
PiAgICAqIGFuZCBjcnlwdG8gYWxnb3JpdGhtcyByZWdpc3Rpb24uDQo+ID4+ICAgICovDQo+ID4+
ICAgc3RhdGljIERFRklORV9NVVRFWChhbGdzX2xvY2spOw0KPiA+PiAtc3RhdGljIHVuc2lnbmVk
IGludCB2aXJ0aW9fY3J5cHRvX2FjdGl2ZV9kZXZzOw0KPiA+PiAgIHN0YXRpYyB2b2lkIHZpcnRp
b19jcnlwdG9fYWJsa2NpcGhlcl9maW5hbGl6ZV9yZXEoDQo+ID4+ICAgCXN0cnVjdCB2aXJ0aW9f
Y3J5cHRvX3N5bV9yZXF1ZXN0ICp2Y19zeW1fcmVxLA0KPiA+PiAgIAlzdHJ1Y3QgYWJsa2NpcGhl
cl9yZXF1ZXN0ICpyZXEsDQo+ID4+IEBAIC0zMTIsMTMgKzMxOCwxOSBAQCBzdGF0aWMgaW50IHZp
cnRpb19jcnlwdG9fYWJsa2NpcGhlcl9zZXRrZXkoc3RydWN0DQo+ID4+IGNyeXB0b19hYmxrY2lw
aGVyICp0Zm0sDQo+ID4+ICAgCQkJCQkgdW5zaWduZWQgaW50IGtleWxlbikNCj4gPj4gICB7DQo+
ID4+ICAgCXN0cnVjdCB2aXJ0aW9fY3J5cHRvX2FibGtjaXBoZXJfY3R4ICpjdHggPQ0KPiBjcnlw
dG9fYWJsa2NpcGhlcl9jdHgodGZtKTsNCj4gPj4gKwl1aW50MzJfdCBhbGc7DQo+ID4+ICAgCWlu
dCByZXQ7DQo+ID4+DQo+ID4+ICsJcmV0ID0gdmlydGlvX2NyeXB0b19hbGdfdmFsaWRhdGVfa2V5
KGtleWxlbiwgJmFsZyk7DQo+ID4+ICsJaWYgKHJldCkNCj4gPj4gKwkJcmV0dXJuIHJldDsNCj4g
Pj4gKw0KPiA+PiAgIAlpZiAoIWN0eC0+dmNyeXB0bykgew0KPiA+PiAgIAkJLyogTmV3IGtleSAq
Lw0KPiA+PiAgIAkJaW50IG5vZGUgPSB2aXJ0aW9fY3J5cHRvX2dldF9jdXJyZW50X25vZGUoKTsN
Cj4gPj4gICAJCXN0cnVjdCB2aXJ0aW9fY3J5cHRvICp2Y3J5cHRvID0NCj4gPj4gLQkJCQkgICAg
ICB2aXJ0Y3J5cHRvX2dldF9kZXZfbm9kZShub2RlKTsNCj4gPj4gKwkJCQkgICAgICB2aXJ0Y3J5
cHRvX2dldF9kZXZfbm9kZShub2RlLA0KPiA+PiArCQkJCSAgICAgIFZJUlRJT19DUllQVE9fU0VS
VklDRV9DSVBIRVIsIGFsZyk7DQo+ID4+ICAgCQlpZiAoIXZjcnlwdG8pIHsNCj4gPj4gICAJCQlw
cl9lcnIoInZpcnRpb19jcnlwdG86IENvdWxkIG5vdCBmaW5kIGEgdmlydGlvIGRldmljZSBpbiB0
aGUNCj4gPj4gc3lzdGVtXG4iKTsNCj4gPg0KPiA+IFdlJ2QgYmV0dGVyIGNoYW5nZSB0aGUgYWJv
dmUgZXJyb3IgbWVzc2FnZSBub3cuIFdoYXQgYWJvdXQ6DQo+ID4gICAiIHZpcnRpb19jcnlwdG86
IENvdWxkIG5vdCBmaW5kIGEgdmlydGlvIGRldmljZSBpbiB0aGUgc3lzdGVtIG9yIHVuc3VwcG9y
dGVkDQo+IGFsZ28iID8NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gLUdvbmdsZWkNCj4gDQo+IA0K
PiBTdXJlLCBJIHdpbGwgdXBkYXRlIHRoZSBlcnJvciBtZXNzYWdlLiBCdXQgb3RoZXIgdGhhbiB0
aGF0IGRvZXMgdGhlIHJlc3QNCj4gb2YgdGhlIGNvZGUgbG9va3MgZ29vZCB0byB5b3U/DQo+IA0K
WWVzLCBnb29kIHdvcmsuIFlvdSBjYW4gYWRkIG15IGFjayBpbiB2MjoNCg0KQWNrZWQtYnk6IEdv
bmdsZWkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPg0KDQpSZWdhcmRzLA0KLUdvbmdsZWkNCg0K
DQoNCg==
