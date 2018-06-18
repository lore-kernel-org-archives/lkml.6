Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8390EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B36820863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B36820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbeFRP6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:58:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42290 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752765AbeFRP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:58:46 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5IFsQ43021275;
        Mon, 18 Jun 2018 17:58:29 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jpbex13xu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 17:58:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92DCA38;
        Mon, 18 Jun 2018 15:58:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70B70110A;
        Mon, 18 Jun 2018 15:58:25 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 17:58:25 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 18 Jun 2018 17:58:24 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Vincent ABRIOU" <vincent.abriou@st.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1 2/7] drm: add hook to print encoder status
Thread-Topic: [PATCH v1 2/7] drm: add hook to print encoder status
Thread-Index: AQHUBw9xCOwZCgKFj02WZ4XuKc4IM6RmCrkA
Date:   Mon, 18 Jun 2018 15:58:24 +0000
Message-ID: <7cceb2e2-79fe-b93e-e5c4-7b936a12e61d@st.com>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
 <20180605135407.20214-3-benjamin.gaignard@linaro.org>
In-Reply-To: <20180605135407.20214-3-benjamin.gaignard@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <49A7C7E04004DE458E28B6C547DF9115@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNCk9uIDA2LzA1LzIwMTggMDM6NTQgUE0sIEJlbmphbWluIEdhaWduYXJk
IHdyb3RlOg0KPiBFdmVuIGlmIGVuY29kZXJzIGRvbid0IGhhdmUgc3RhdGUgaXQgY291bGQgYmUg
dXNlZnVsIHRvIGdldCBpbmZvcm1hdGlvbg0KPiBmcm9tIHRoZW0gd2hlbiBkdW1waW5nIG9mIHRo
ZSBvdGhlciBlbGVtZW50cyBzdGF0ZS4NCj4gQWRkIGFuIG9wdGlvbmFsIGhvb2sgaW4gZHJtX2Vu
Y29kZXJfZnVuY3Mgc3RydWN0dXJlIGFuZCBjYWxsIGl0IGFmdGVyIGNydGMNCj4gcHJpbnQgc3Rh
dGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2Fp
Z25hcmRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWMu
YyB8IDE1ICsrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvZHJtL2RybV9lbmNvZGVyLmggICAg
fCAxMiArKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pYy5jIGIvZHJpdmVy
cy9ncHUvZHJtL2RybV9hdG9taWMuYw0KPiBpbmRleCBjZDFkNjc3NjE3YzguLjZhOWY1YmUwMTE3
MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWMuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pYy5jDQo+IEBAIC0yOCw2ICsyOCw3IEBADQo+ICAgDQo+
ICAgI2luY2x1ZGUgPGRybS9kcm1QLmg+DQo+ICAgI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljLmg+
DQo+ICsjaW5jbHVkZSA8ZHJtL2RybV9lbmNvZGVyLmg+DQo+ICAgI2luY2x1ZGUgPGRybS9kcm1f
bW9kZS5oPg0KPiAgICNpbmNsdWRlIDxkcm0vZHJtX3ByaW50Lmg+DQo+ICAgI2luY2x1ZGUgPGxp
bnV4L3N5bmNfZmlsZS5oPg0KPiBAQCAtMTc5OSw2ICsxODAwLDE1IEBAIGludCBkcm1fYXRvbWlj
X25vbmJsb2NraW5nX2NvbW1pdChzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpDQo+ICAg
fQ0KPiAgIEVYUE9SVF9TWU1CT0woZHJtX2F0b21pY19ub25ibG9ja2luZ19jb21taXQpOw0KPiAg
IA0KPiArc3RhdGljIHZvaWQgZHJtX2F0b21pY19lbmNvZGVyX3ByaW50KHN0cnVjdCBkcm1fcHJp
bnRlciAqcCwNCj4gKwkJCQkgICAgIHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlcikNCj4gK3sN
Cj4gKwlkcm1fcHJpbnRmKHAsICJlbmNvZGVyWyV1XTogJXNcbiIsIGVuY29kZXItPmJhc2UuaWQs
IGVuY29kZXItPm5hbWUpOw0KPiArDQo+ICsJaWYgKGVuY29kZXItPmZ1bmNzLT5hdG9taWNfcHJp
bnQpDQo+ICsJCWVuY29kZXItPmZ1bmNzLT5hdG9taWNfcHJpbnQocCwgZW5jb2Rlcik7DQo+ICt9
DQo+ICsNCj4gICBzdGF0aWMgdm9pZCBkcm1fYXRvbWljX3ByaW50X3N0YXRlKGNvbnN0IHN0cnVj
dCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkNCj4gICB7DQo+ICAgCXN0cnVjdCBkcm1fcHJpbnRl
ciBwID0gZHJtX2luZm9fcHJpbnRlcihzdGF0ZS0+ZGV2LT5kZXYpOw0KPiBAQCAtMTgyOCw2ICsx
ODM4LDcgQEAgc3RhdGljIHZvaWQgX19kcm1fc3RhdGVfZHVtcChzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LCBzdHJ1Y3QgZHJtX3ByaW50ZXIgKnAsDQo+ICAgCXN0cnVjdCBkcm1fbW9kZV9jb25maWcg
KmNvbmZpZyA9ICZkZXYtPm1vZGVfY29uZmlnOw0KPiAgIAlzdHJ1Y3QgZHJtX3BsYW5lICpwbGFu
ZTsNCj4gICAJc3RydWN0IGRybV9jcnRjICpjcnRjOw0KPiArCXN0cnVjdCBkcm1fZW5jb2RlciAq
ZW5jb2RlcjsNCj4gICAJc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcjsNCj4gICAJc3Ry
dWN0IGRybV9jb25uZWN0b3JfbGlzdF9pdGVyIGNvbm5faXRlcjsNCj4gICANCj4gQEAgLTE4NTAs
NiArMTg2MSwxMCBAQCBzdGF0aWMgdm9pZCBfX2RybV9zdGF0ZV9kdW1wKHN0cnVjdCBkcm1fZGV2
aWNlICpkZXYsIHN0cnVjdCBkcm1fcHJpbnRlciAqcCwNCj4gICAJCQlkcm1fbW9kZXNldF91bmxv
Y2soJmNydGMtPm11dGV4KTsNCj4gICAJfQ0KPiAgIA0KPiArCWRybV9mb3JfZWFjaF9lbmNvZGVy
KGVuY29kZXIsIGRldikgew0KPiArCQlkcm1fYXRvbWljX2VuY29kZXJfcHJpbnQocCwgZW5jb2Rl
cik7DQo+ICsJfQ0KPiArDQo+ICAgCWRybV9jb25uZWN0b3JfbGlzdF9pdGVyX2JlZ2luKGRldiwg
JmNvbm5faXRlcik7DQo+ICAgCWlmICh0YWtlX2xvY2tzKQ0KPiAgIAkJZHJtX21vZGVzZXRfbG9j
aygmZGV2LT5tb2RlX2NvbmZpZy5jb25uZWN0aW9uX211dGV4LCBOVUxMKTsNCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvZHJtL2RybV9lbmNvZGVyLmggYi9pbmNsdWRlL2RybS9kcm1fZW5jb2Rlci5o
DQo+IGluZGV4IGZiMjk5Njk2YzdjNC4uYjg0N2RhZDgxN2IwIDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2RybS9kcm1fZW5jb2Rlci5oDQo+ICsrKyBiL2luY2x1ZGUvZHJtL2RybV9lbmNvZGVyLmgN
Cj4gQEAgLTgwLDYgKzgwLDE4IEBAIHN0cnVjdCBkcm1fZW5jb2Rlcl9mdW5jcyB7DQo+ICAgCSAq
IGJlZm9yZSBkYXRhIHN0cnVjdHVyZXMgYXJlIHRvcm5kb3duLg0KPiAgIAkgKi8NCj4gICAJdm9p
ZCAoKmVhcmx5X3VucmVnaXN0ZXIpKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2Rlcik7DQo+ICsN
Cj4gKwkvKioNCj4gKwkgKiBAYXRvbWljX3ByaW50DQo+ICsJICoNCj4gKwkgKiBJZiBkcml2ZXIg
Y291bGQgaW1wbGVtZW50IHRoaXMgb3B0aW9uYWwgaG9vayBmb3IgcHJpbnRpbmcNCj4gKwkgKiBh
ZGRpdGlvbmFsIGRyaXZlciBzcGVjaWZpYyBpbmZvcm1hdGlvbi4NCj4gKwkgKg0KPiArCSAqIERv
IG5vdCBjYWxsIHRoaXMgZGlyZWN0bHksIHVzZSBkcm1fYXRvbWljX2VuY29kZXJfcHJpbnQoKQ0K
PiArCSAqIGluc3RlYWQuDQo+ICsJICovDQo+ICsJdm9pZCAoKmF0b21pY19wcmludCkoc3RydWN0
IGRybV9wcmludGVyICpwLA0KPiArCQkJICAgICBzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIp
Ow0KDQpzb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuDQpkcm1fY29ubmVjdG9yLmgsIGRybV9jcnRj
LmggJiBkcm1fcGxhbmUuaCB1c2UgImF0b21pY19wcmludF9zdGF0ZSIgDQppbnN0ZWFkIG9mICJh
dG9taWNfcHJpbnQiLiBZb3UgbWF5IGNvbnNpZGVyIHJlbmFtaW5nIGl0Li4uIG9yIG5vdCA6ICkN
Cg0KV2l0aCBvciB3aXRob3V0IHRoYXQsDQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgQ29ybnUgPHBo
aWxpcHBlLmNvcm51QHN0LmNvbT4NCk1hbnkgdGhhbmtzDQpQaGlsaXBwZSA6LSkNCg0KPiAgIH07
DQo+ICAgDQo+ICAgLyoqDQo+IA==
