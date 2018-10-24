Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D89C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314D72082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314D72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJXVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:05:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10622 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727149AbeJXVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:05:08 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9OCY66I016709;
        Wed, 24 Oct 2018 14:37:06 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nan40j33s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Oct 2018 14:37:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7540C38;
        Wed, 24 Oct 2018 12:37:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53C0B2D19;
        Wed, 24 Oct 2018 12:37:05 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Oct
 2018 14:37:05 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Wed, 24 Oct 2018 14:37:04 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v4 16/17] remoteproc: st: add reserved memory support
Thread-Topic: [PATCH v4 16/17] remoteproc: st: add reserved memory support
Thread-Index: AQHUJavmwddZr0G2YECHT4Rnnwh8dKUuHugAgADBQYA=
Date:   Wed, 24 Oct 2018 12:37:04 +0000
Message-ID: <e378b52d446b4b87a17dc2f24374791a@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-17-git-send-email-loic.pallardy@st.com>
 <369c47bb-6ef1-d694-cf14-39bce87dfd0c@ti.com>
In-Reply-To: <369c47bb-6ef1-d694-cf14-39bce87dfd0c@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VtYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4g
QW5uYSA8cy1hbm5hQHRpLmNvbT4NCj4gU2VudDogbWVyY3JlZGkgMjQgb2N0b2JyZSAyMDE4IDA1
OjAyDQo+IFRvOiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90
ZXByb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBB
cm5hdWQgUE9VTElRVUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdh
aWduYXJkQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxNi8xN10gcmVtb3Rl
cHJvYzogc3Q6IGFkZCByZXNlcnZlZCBtZW1vcnkgc3VwcG9ydA0KPiANCj4gSGkgTG9pYywNCj4g
DQo+IE9uIDcvMjcvMTggODoxNCBBTSwgTG9pYyBQYWxsYXJkeSB3cm90ZToNCj4gPiBTVCByZW1v
dGUgcHJvY2Vzc29yIG5lZWRzIHNvbWUgc3BlY2lmaWVkIG1lbW9yeSByZWdpb25zIGZvcg0KPiA+
IGZpcm13YXJlIGFuZCBJUEMuDQo+ID4gTWVtb3J5IHJlZ2lvbnMgYXJlIGRlZmluZWQgYXMgcmVz
ZXJ2ZWQgbWVtb3J5IGFuZCBzaG91bGQNCj4gPiBiZSByZWdpc3RlcmVkIGluIHJlbW90ZXByb2Mg
Y29yZSB0aGFua3MgdG8gcnByb2NfYWRkX2NhcnZlb3V0DQo+ID4gZnVuY3Rpb24gYmVmb3JlIHJw
cm9jX3N0YXJ0LiBGb3IgdGhpcywgc3QgcnByb2MgZHJpdmVyIGltcGxlbWVudHMNCj4gPiBwcmVw
YXJlIG9wcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExvaWMgUGFsbGFyZHkgPGxvaWMucGFs
bGFyZHlAc3QuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3JlbW90ZXByb2Mvc3RfcmVtb3Rl
cHJvYy5jIHwgOTYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9zdF9yZW1vdGVwcm9jLmMNCj4g
Yi9kcml2ZXJzL3JlbW90ZXByb2Mvc3RfcmVtb3RlcHJvYy5jDQo+ID4gaW5kZXggYWFjZWYwZS4u
NDU5NThkNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2Mvc3RfcmVtb3RlcHJv
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL3N0X3JlbW90ZXByb2MuYw0KPiA+IEBA
IC0xOSw2ICsxOSw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9v
Zl9kZXZpY2UuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX3Jlc2VydmVkX21lbS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gQEAgLTkxLDYgKzkyLDgy
IEBAIHN0YXRpYyB2b2lkIHN0X3Jwcm9jX2tpY2soc3RydWN0IHJwcm9jICpycHJvYywgaW50IHZx
aWQpDQo+ID4gIAkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gc2VuZCBtZXNzYWdlIHZpYSBtYm94
OiAlZFxuIiwgcmV0KTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgc3RfcnByb2NfbWVt
X2FsbG9jKHN0cnVjdCBycHJvYyAqcnByb2MsDQo+ID4gKwkJCSAgICAgIHN0cnVjdCBycHJvY19t
ZW1fZW50cnkgKm1lbSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gcnByb2Mt
PmRldi5wYXJlbnQ7DQo+ID4gKwl2b2lkICp2YTsNCj4gPiArDQo+ID4gKwl2YSA9IGlvcmVtYXBf
d2MobWVtLT5kbWEsIG1lbS0+bGVuKTsNCj4gPiArCWlmICghdmEpIHsNCj4gPiArCQlkZXZfZXJy
KGRldiwgIlVuYWJsZSB0byBtYXAgbWVtb3J5IHJlZ2lvbjogJXBhKyV6eFxuIiwNCj4gPiArCQkJ
Jm1lbS0+ZG1hLCBtZW0tPmxlbik7DQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJLyogVXBkYXRlIG1lbW9yeSBlbnRyeSB2YSAqLw0KPiA+ICsJbWVtLT52YSA9
IHZhOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IHN0X3Jwcm9jX21lbV9yZWxlYXNlKHN0cnVjdCBycHJvYyAqcnByb2MsDQo+ID4gKwkJCQlz
dHJ1Y3QgcnByb2NfbWVtX2VudHJ5ICptZW0pDQo+ID4gK3sNCj4gPiArCWlvdW5tYXAobWVtLT52
YSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgc3RfcnByb2NfcGFyc2VfZncoc3RydWN0IHJwcm9jICpycHJvYywgY29uc3Qgc3RydWN0IGZp
cm13YXJlDQo+ICpmdykNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gcnByb2Mt
PmRldi5wYXJlbnQ7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2Rl
Ow0KPiA+ICsJc3RydWN0IHJwcm9jX21lbV9lbnRyeSAqbWVtOw0KPiA+ICsJdm9pZCAqdmE7DQo+
ID4gKwlzdHJ1Y3QgcmVzZXJ2ZWRfbWVtICpybWVtOw0KPiA+ICsJc3RydWN0IG9mX3BoYW5kbGVf
aXRlcmF0b3IgaXQ7DQo+ID4gKwlpbnQgZXJyLCBpbmRleCA9IDA7DQo+ID4gKw0KPiA+ICsJb2Zf
cGhhbmRsZV9pdGVyYXRvcl9pbml0KCZpdCwgbnAsICJtZW1vcnktcmVnaW9uIiwgTlVMTCwgMCk7
DQo+ID4gKwl3aGlsZSAoKGVyciA9IG9mX3BoYW5kbGVfaXRlcmF0b3JfbmV4dCgmaXQpKSA9PSAw
KSB7DQo+ID4gKwkJdmEgPSBOVUxMOw0KPiA+ICsJCXJtZW0gPSBvZl9yZXNlcnZlZF9tZW1fbG9v
a3VwKGl0Lm5vZGUpOw0KPiA+ICsNCj4gPiArCQkvKiAgTm8gbmVlZCB0byBtYXAgdmRldiBidWZm
ZXIgKi8NCj4gPiArCQlpZiAoc3RyY21wKGl0Lm5vZGUtPm5hbWUsICJ2ZGV2MGJ1ZmZlciIpKSB7
DQo+ID4gKwkJCXZhID0gZGV2bV9pb3JlbWFwX3djKGRldiwgcm1lbS0+YmFzZSwgcm1lbS0NCj4g
PnNpemUpOw0KPiA+ICsJCQlpZiAoIXZhKSB7DQo+ID4gKwkJCQlkZXZfZXJyKGRldiwgIlVuYWJs
ZSB0byBtYXAgbWVtb3J5DQo+IHJlZ2lvbjogJXBhKyV6eFxuIiwNCj4gPiArCQkJCQkmcm1lbS0+
YmFzZSwgcm1lbS0+c2l6ZSk7DQo+ID4gKwkJCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArCQkJfQ0K
PiA+ICsNCj4gPiArCQkJLyogUmVnaXN0ZXIgbWVtb3J5IHJlZ2lvbiAqLw0KPiA+ICsJCQltZW0g
PSBycHJvY19tZW1fZW50cnlfaW5pdChkZXYsIHZhLA0KPiA+ICsJCQkJCQkgICAoZG1hX2FkZHJf
dClybWVtLT5iYXNlLA0KPiA+ICsJCQkJCQkgICBybWVtLT5zaXplLCBybWVtLT5iYXNlLA0KPiA+
ICsJCQkJCQkgICBzdF9ycHJvY19tZW1fYWxsb2MsDQo+ID4gKwkJCQkJCSAgIHN0X3Jwcm9jX21l
bV9yZWxlYXNlLA0KPiANCj4gWW91IHNlZW0gdG8gYmUgZG91YmxlLW1hcHBpbmcsIGZpcnN0IGp1
c3QgYWJvdmUgdG8gc3VwcGx5IHRoZSB2YSB0bw0KPiBtZW1fZW50cnlfaW5pdCBhbmQgdGhlbiB0
aHJvdWdoIHRoZSBhbGxvYyBmdW5jdGlvbi4NCj4gDQo+IFRoaXMgaXMgRFQgcGFyc2luZyBhbmQg
aXMgZml4ZWQgaXJyZXNwZWN0aXZlIG9mIGZpcm13YXJlIGFuZCBvbmx5IG5lZWRzDQo+IHRvIGJl
IGRvbmUgb25jZSByZWFsbHkgaW4gdGhlIHBsYXRmb3JtIGRyaXZlciBwcm9iZS4gSSB0aGluayB0
aGlzIHdob2xlDQo+IGxvZ2ljIGlzIHVubmVjZXNzYXJpbHkgY29tcGxpY2F0ZWQgaW4gdGhlIG5h
bWUgb2YgbGV0dGluZyB0aGUgcmVtb3RlcHJvYw0KPiBjb3JlIGhhbmRsZSB0aGUgYWxsb2MgYW5k
IGZyZWUgZm9yIGZpeGVkIG1lbW9yeSBjYXJ2ZW91dHMgZHVyaW5nIGV2ZXJ5DQo+IGJvb3QgYW5k
IHNodXRkb3duLCBhbmQgaGF2aW5nIHRvIHJlZG8gdGhlIG1hcHBpbmcgZXZlcnl0aW1lIGR1cmlu
ZyB0aGUNCj4gZmlybXdhcmUgcGFyc2UuIEkgYW0gbm90IGEgYmlnIGZhbiBvZiBvdmVybG9hZGlu
ZyB0aGUgcGFyc2VfZncgdG8gZG8NCj4gdGhpcyBydW50aW1lIHJlbWFwcGluZyBldmVyeXRpbWUg
Zm9yIHNvbWV0aGluZyB0aGF0IHNob3VsZCBoYXZlIGJlZW4NCj4gZG9uZSBvbmNlLiBJIHRoaW5r
IHlvdSBoYXZlIGRvbmUgdGhpcyBpbiB5b3VyIHYyLCBhbmQgc29tZXdoZXJlIGFsb25nIGluDQo+
IHYzIGdvdCBtb2RpZmllZCBpbnRvIHRoaXMuDQogDQpEb3VibGUgbWFwcGluZyBpcyBkZWZpbml0
aXZlbHkgYW4gZXJyb3IuIEZvcmdldCBpdC4NCkJlaW5nIGFibGUgdG8gYWxsb2NhdGUgYWxsIGNh
cnZlb3V0cyBhdCBjb3Byb2Nlc3NvciBzdGFydCB3YXMgYSByZW1hcmsgZnJvbSBCam9ybi4NClRo
YXQncyB3aHkgSSBpbnRyb2R1Y2VkIGFsbG9jIGFuZCBmcmVlIG9wcyB0byBkbyB0aGUgYWxsb2Nh
dGlvbiBhdCBlYWNoIGNvcHJvY2Vzc29yIHN0YXJ0IGFuZCBzbyBzdF9ycHJvY19tZW1fYWxsb2Mo
KSBpbiB0aGlzIGRyaXZlci4NCg0KUmVnYXJkcywNCkxvaWMNCj4gDQo+IHJlZ2FyZHMNCj4gU3Vt
YW4NCj4gDQo+ID4gKwkJCQkJCSAgIGl0Lm5vZGUtPm5hbWUpOw0KPiA+ICsJCX0gZWxzZSB7DQo+
ID4gKwkJCS8qIFJlZ2lzdGVyIHJlc2VydmVkIG1lbW9yeSBmb3IgdmRldiBidWZmZXINCj4gYWxs
b2NhdGlvbiAqLw0KPiA+ICsJCQltZW0gPSBycHJvY19vZl9yZXNtX21lbV9lbnRyeV9pbml0KGRl
diwgaW5kZXgsDQo+ID4gKwkJCQkJCQkgICBybWVtLT5zaXplLA0KPiA+ICsJCQkJCQkJICAgcm1l
bS0+YmFzZSwNCj4gPiArCQkJCQkJCSAgIGl0Lm5vZGUtPm5hbWUpOw0KPiA+ICsJCX0NCj4gPiAr
DQo+ID4gKwkJaWYgKCFtZW0pDQo+ID4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiAr
CQlycHJvY19hZGRfY2FydmVvdXQocnByb2MsIG1lbSk7DQo+ID4gKwkJaW5kZXgrKzsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gcnByb2NfZWxmX2xvYWRfcnNjX3RhYmxlKHJwcm9jLCBm
dyk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgc3RfcnByb2Nfc3RhcnQoc3RydWN0
IHJwcm9jICpycHJvYykNCj4gPiAgew0KPiA+ICAJc3RydWN0IHN0X3Jwcm9jICpkZGF0YSA9IHJw
cm9jLT5wcml2Ow0KPiA+IEBAIC0xNTgsOSArMjM1LDE0IEBAIHN0YXRpYyBpbnQgc3RfcnByb2Nf
c3RvcChzdHJ1Y3QgcnByb2MgKnJwcm9jKQ0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBycHJvY19vcHMgc3RfcnByb2Nfb3BzID0gew0KPiA+IC0JLmtpY2sJCT0gc3RfcnBy
b2Nfa2ljaywNCj4gPiAtCS5zdGFydAkJPSBzdF9ycHJvY19zdGFydCwNCj4gPiAtCS5zdG9wCQk9
IHN0X3Jwcm9jX3N0b3AsDQo+ID4gKwkua2ljawkJCT0gc3RfcnByb2Nfa2ljaywNCj4gPiArCS5z
dGFydAkJCT0gc3RfcnByb2Nfc3RhcnQsDQo+ID4gKwkuc3RvcAkJCT0gc3RfcnByb2Nfc3RvcCwN
Cj4gPiArCS5wYXJzZV9mdwkJPSBzdF9ycHJvY19wYXJzZV9mdywNCj4gPiArCS5sb2FkCQkJPSBy
cHJvY19lbGZfbG9hZF9zZWdtZW50cywNCj4gPiArCS5maW5kX2xvYWRlZF9yc2NfdGFibGUJPSBy
cHJvY19lbGZfZmluZF9sb2FkZWRfcnNjX3RhYmxlLA0KPiA+ICsJLnNhbml0eV9jaGVjawkJPSBy
cHJvY19lbGZfc2FuaXR5X2NoZWNrLA0KPiA+ICsJLmdldF9ib290X2FkZHIJCT0gcnByb2NfZWxm
X2dldF9ib290X2FkZHIsDQo+ID4gIH07DQo+ID4NCj4gPiAgLyoNCj4gPiBAQCAtMjU0LDEyICsz
MzYsNiBAQCBzdGF0aWMgaW50IHN0X3Jwcm9jX3BhcnNlX2R0KHN0cnVjdA0KPiBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIAl9DQo+ID4NCj4gPiAt
CWVyciA9IG9mX3Jlc2VydmVkX21lbV9kZXZpY2VfaW5pdChkZXYpOw0KPiA+IC0JaWYgKGVycikg
ew0KPiA+IC0JCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIG9idGFpbiBzaGFyZWQgbWVtb3J5XG4i
KTsNCj4gPiAtCQlyZXR1cm4gZXJyOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAgCWVyciA9IGNsa19w
cmVwYXJlKGRkYXRhLT5jbGspOw0KPiA+ICAJaWYgKGVycikNCj4gPiAgCQlkZXZfZXJyKGRldiwg
ImZhaWxlZCB0byBnZXQgY2xvY2tcbiIpOw0KPiA+IEBAIC0zODcsOCArNDYzLDYgQEAgc3RhdGlj
IGludCBzdF9ycHJvY19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
Pg0KPiA+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkYXRhLT5jbGspOw0KPiA+DQo+ID4gLQlv
Zl9yZXNlcnZlZF9tZW1fZGV2aWNlX3JlbGVhc2UoJnBkZXYtPmRldik7DQo+ID4gLQ0KPiA+ICAJ
Zm9yIChpID0gMDsgaSA8IFNUX1JQUk9DX01BWF9WUklORyAqIE1CT1hfTUFYOyBpKyspDQo+ID4g
IAkJbWJveF9mcmVlX2NoYW5uZWwoZGRhdGEtPm1ib3hfY2hhbltpXSk7DQo+ID4NCj4gPg0KDQo=
