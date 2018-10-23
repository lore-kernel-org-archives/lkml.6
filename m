Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9271FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B60D20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B60D20813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeJXENS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:13:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46839 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725740AbeJXENS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:13:18 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9NJdDV0015972;
        Tue, 23 Oct 2018 21:48:23 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n7sg6424n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Oct 2018 21:48:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DD2A31;
        Tue, 23 Oct 2018 19:48:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F246158C6;
        Tue, 23 Oct 2018 19:48:22 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Oct
 2018 21:48:22 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Tue, 23 Oct 2018 21:48:22 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v4 06/17] remoteproc: introduce rproc_add_carveout
 function
Thread-Topic: [PATCH v4 06/17] remoteproc: introduce rproc_add_carveout
 function
Thread-Index: AQHUJavg0ZTjSUq+aEy+qgIgpjwiZ6UteFIAgABONZA=
Date:   Tue, 23 Oct 2018 19:48:22 +0000
Message-ID: <415434350e194ee78811629fa41aa7d2@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-7-git-send-email-loic.pallardy@st.com>
 <8f6737ec-6132-25df-107c-b646310b2dce@ti.com>
In-Reply-To: <8f6737ec-6132-25df-107c-b646310b2dce@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-23_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4gQW5uYSA8cy1h
bm5hQHRpLmNvbT4NCj4gU2VudDogbWFyZGkgMjMgb2N0b2JyZSAyMDE4IDE5OjA1DQo+IFRvOiBM
b2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFuZGVyc3NvbkBsaW5h
cm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90ZXByb2NAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBBcm5hdWQgUE9VTElR
VUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdhaWduYXJkQGxpbmFy
by5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8xN10gcmVtb3RlcHJvYzogaW50cm9k
dWNlIHJwcm9jX2FkZF9jYXJ2ZW91dA0KPiBmdW5jdGlvbg0KPiANCj4gSGkgQmpvcm4sIExvaWMs
DQo+IA0KPiBPbiA3LzI3LzE4IDg6MTQgQU0sIExvaWMgUGFsbGFyZHkgd3JvdGU6DQo+ID4gVGhp
cyBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IEFQSSB0byBhbGxvdyBwbGF0Zm9ybSBkcml2ZXIgdG8g
cmVnaXN0ZXINCj4gPiBwbGF0Zm9ybSBzcGVjaWZpYyBjYXJ2ZW91dCByZWdpb25zLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTG9pYyBQYWxsYXJkeSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+DQo+
ID4gQWNrZWQtYnk6IEJqb3JuIEFuZGVyc3NvbiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+
DQo+IA0KPiBIbW0sIEkgZG8gbm90IHByZWZlciB0aGF0IHRoaXMgZnVuY3Rpb24gYmUgZXhwb3J0
ZWQuIEl0IGFkZHMgbm8gdmFsdWUsDQo+IGFuZCB0aGlzIGFkZHMgYW4gYXN5bW1ldHJpYyBBUEkg
Zm9yIHJlbW90ZXByb2MgZHJpdmVycyB0byBhZGQgYSBtZW0NCj4gZW50cnkgdG8gdGhlIGludGVy
bmFsIHJlbW90ZXByb2MgbGlzdHMsIHdoaWxlIHJlbHlpbmcgb24gdGhlIHJlbW90ZXByb2MNCj4g
Y29yZSB0byByZW1vdmUgdGhlbS4gVGhlIGNhcnZlb3V0IGxpc3QgbWFpbnRlbmFuY2UgaXMgYSBy
ZW1vdGVwcm9jDQo+IGludGVybmFsIHNjaGVtZSwgYW5kIHNvIHNob3VsZCBiZSBtYWludGFpbmVk
IHRoYXQgd2F5LiBGdXJ0aGVyIG1vcmUsIG9uDQo+IHRoZSBjdXJyZW50IHNlcmllcywgYWxsIHRo
ZSBleGlzdGluZyBjYWxscyBhcmUgaW1tZWRpYXRlbHkgYWZ0ZXIgYQ0KPiBycHJvY19vZl9yZXNt
X21lbV9lbnRyeV9pbml0KCkgb3IgYSBycHJvY19tZW1fZW50cnlfaW5pdCgpIGZ1bmN0aW9uLA0K
PiB3aGljaCBtZWFucyB0aGlzIGNvdWxkIHZlcnkgd2VsbCBiZSBmb2xkZWQgaW50byB0aG9zZSBp
bmRpdmlkdWFsIGZ1bmN0aW9ucy4NCj4gDQpJIHRoaW5rIGl0IGhhcyBiZWVuIGludHJvZHVjZWQg
aW4gZmlyc3Qgc2VyaWVzLiBMb29rIHRoYXQgcnByb2NfYWRkX2NhcnZlb3V0KCkgY2FsbCBjb3Vs
ZCBiZSBpbnRlZ3JhdGVkIGluIGhlbHBlciBmdW5jdGlvbnMgbm93Lg0KSSBjYW4gcHJvcG9zZSBh
IHBhdGNoIHRvIGNvcnJlY3QgdGhpcy4NCg0KUmVnYXJkcywNCkxvaWMNCj4gcmVnYXJkcw0KPiBT
dW1hbg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29y
ZS5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3JlbW90ZXByb2Mu
aCAgICAgICAgICAgfCAgMiArKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlbW90ZXBy
b2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19j
b3JlLmMNCj4gPiBpbmRleCBiNzY3NjBlLi5mZTZjNGU0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3Rl
cHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+IEBAIC03NDcsNyArNzQ3LDcgQEAgc3RhdGljIGlu
dCBycHJvY19oYW5kbGVfY2FydmVvdXQoc3RydWN0IHJwcm9jDQo+ICpycHJvYywNCj4gPiAgCWlm
ICghY2FydmVvdXQpDQo+ID4gIAkJZ290byBmcmVlX2NhcnY7DQo+ID4NCj4gPiAtCWxpc3RfYWRk
X3RhaWwoJmNhcnZlb3V0LT5ub2RlLCAmcnByb2MtPmNhcnZlb3V0cyk7DQo+ID4gKwlycHJvY19h
ZGRfY2FydmVvdXQocnByb2MsIGNhcnZlb3V0KTsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4N
Cj4gPiBAQCAtNzYxLDYgKzc2MSwyMCBAQCBzdGF0aWMgaW50IHJwcm9jX2hhbmRsZV9jYXJ2ZW91
dChzdHJ1Y3QgcnByb2MNCj4gKnJwcm9jLA0KPiA+ICB9DQo+ID4NCj4gPiAgLyoqDQo+ID4gKyAq
IHJwcm9jX2FkZF9jYXJ2ZW91dCgpIC0gcmVnaXN0ZXIgYW4gYWxsb2NhdGVkIGNhcnZlb3V0IHJl
Z2lvbg0KPiA+ICsgKiBAcnByb2M6IHJwcm9jIGhhbmRsZQ0KPiA+ICsgKiBAbWVtOiBtZW1vcnkg
ZW50cnkgdG8gcmVnaXN0ZXINCj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlvbiByZWdpc3Rl
cnMgc3BlY2lmaWVkIG1lbW9yeSBlbnRyeSBpbiBAcnByb2MgY2FydmVvdXRzIGxpc3QuDQo+ID4g
KyAqIFNwZWNpZmllZCBjYXJ2ZW91dCBzaG91bGQgaGF2ZSBiZWVuIGFsbG9jYXRlZCBiZWZvcmUg
cmVnaXN0ZXJpbmcuDQo+ID4gKyAqLw0KPiA+ICt2b2lkIHJwcm9jX2FkZF9jYXJ2ZW91dChzdHJ1
Y3QgcnByb2MgKnJwcm9jLCBzdHJ1Y3QgcnByb2NfbWVtX2VudHJ5DQo+ICptZW0pDQo+ID4gK3sN
Cj4gPiArCWxpc3RfYWRkX3RhaWwoJm1lbS0+bm9kZSwgJnJwcm9jLT5jYXJ2ZW91dHMpOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0wocnByb2NfYWRkX2NhcnZlb3V0KTsNCj4gPiArDQo+ID4g
Ky8qKg0KPiA+ICAgKiBycHJvY19tZW1fZW50cnlfaW5pdCgpIC0gYWxsb2NhdGUgYW5kIGluaXRp
YWxpemUgcnByb2NfbWVtX2VudHJ5IHN0cnVjdA0KPiA+ICAgKiBAZGV2OiBwb2ludGVyIG9uIGRl
dmljZSBzdHJ1Y3QNCj4gPiAgICogQHZhOiB2aXJ0dWFsIGFkZHJlc3MNCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9yZW1vdGVwcm9jLmggYi9pbmNsdWRlL2xpbnV4L3JlbW90ZXByb2Mu
aA0KPiA+IGluZGV4IDRiYzk2MWYuLjU1ZjMwZmMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9yZW1vdGVwcm9jLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3JlbW90ZXByb2MuaA0K
PiA+IEBAIC01NTgsNiArNTU4LDggQEAgc3RydWN0IHJwcm9jICpycHJvY19hbGxvYyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIGNvbnN0DQo+IGNoYXIgKm5hbWUsDQo+ID4gIGludCBycHJvY19kZWwoc3Ry
dWN0IHJwcm9jICpycHJvYyk7DQo+ID4gIHZvaWQgcnByb2NfZnJlZShzdHJ1Y3QgcnByb2MgKnJw
cm9jKTsNCj4gPg0KPiA+ICt2b2lkIHJwcm9jX2FkZF9jYXJ2ZW91dChzdHJ1Y3QgcnByb2MgKnJw
cm9jLCBzdHJ1Y3QgcnByb2NfbWVtX2VudHJ5DQo+ICptZW0pOw0KPiA+ICsNCj4gPiAgc3RydWN0
IHJwcm9jX21lbV9lbnRyeSAqDQo+ID4gIHJwcm9jX21lbV9lbnRyeV9pbml0KHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4gPiAgCQkgICAgIHZvaWQgKnZhLCBkbWFfYWRkcl90IGRtYSwgaW50IGxlbiwg
dTMyIGRhLA0KPiA+DQoNCg==
