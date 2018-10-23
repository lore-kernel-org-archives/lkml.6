Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B122C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDC420813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDC420813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJXEQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:16:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48491 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725740AbeJXEQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:16:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9NJoZjH027206;
        Tue, 23 Oct 2018 21:51:31 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n7u8g3npe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Oct 2018 21:51:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 966EC31;
        Tue, 23 Oct 2018 19:51:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 814CF58F6;
        Tue, 23 Oct 2018 19:51:30 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Oct
 2018 21:51:30 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Tue, 23 Oct 2018 21:51:30 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v4 02/17] remoteproc: add rproc_va_to_pa function
Thread-Topic: [PATCH v4 02/17] remoteproc: add rproc_va_to_pa function
Thread-Index: AQHUJaveAWmdax4c9E2Z2KFgg/o396UtdC0AgABTcJA=
Date:   Tue, 23 Oct 2018 19:51:30 +0000
Message-ID: <68acbbf905384f6c80b646330a3d1344@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-3-git-send-email-loic.pallardy@st.com>
 <91e489e7-86c3-6ee3-918d-151ef1697429@ti.com>
In-Reply-To: <91e489e7-86c3-6ee3-918d-151ef1697429@ti.com>
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

SGkgU3VtYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4g
QW5uYSA8cy1hbm5hQHRpLmNvbT4NCj4gU2VudDogbWFyZGkgMjMgb2N0b2JyZSAyMDE4IDE4OjUx
DQo+IFRvOiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFuZGVy
c3NvbkBsaW5hcm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90ZXBy
b2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBBcm5h
dWQgUE9VTElRVUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdhaWdu
YXJkQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMi8xN10gcmVtb3RlcHJv
YzogYWRkIHJwcm9jX3ZhX3RvX3BhIGZ1bmN0aW9uDQo+IA0KPiBIaSBMb2ljLCBCam9ybiwNCj4g
DQo+IE9uIDcvMjcvMTggODoxNCBBTSwgTG9pYyBQYWxsYXJkeSB3cm90ZToNCj4gPiBUaGlzIG5l
dyBmdW5jdGlvbiB0cmFuc2xhdGVzIENQVSB2aXJ0dWFsIGFkZHJlc3MgaW4NCj4gPiBDUFUgcGh5
c2ljYWwgb25lIGFjY29yZGluZyB0byB2aXJ0dWFsIGFkZHJlc3MgbG9jYXRpb24uDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBMb2ljIFBhbGxhcmR5IDxsb2ljLnBhbGxhcmR5QHN0LmNvbT4NCj4g
PiBBY2tlZC1ieTogQmpvcm4gQW5kZXJzc29uIDxiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZz4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jIHwgMTgg
KysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9j
L3JlbW90ZXByb2NfY29yZS5jDQo+IGIvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29y
ZS5jDQo+ID4gaW5kZXggNDM3ZmFiZi4uOGU1ZmUxZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3JlbW90ZXBy
b2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gPiBAQCAtMTQwLDYgKzE0MCwyMiBAQCBzdGF0aWMgdm9p
ZCBycHJvY19kaXNhYmxlX2lvbW11KHN0cnVjdCBycHJvYw0KPiAqcnByb2MpDQo+ID4gIAlpb21t
dV9kb21haW5fZnJlZShkb21haW4pOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHBoeXNfYWRk
cl90IHJwcm9jX3ZhX3RvX3BhKHZvaWQgKmNwdV9hZGRyKQ0KPiA+ICt7DQo+ID4gKwkvKg0KPiA+
ICsJICogUmV0dXJuIHBoeXNpY2FsIGFkZHJlc3MgYWNjb3JkaW5nIHRvIHZpcnR1YWwgYWRkcmVz
cyBsb2NhdGlvbg0KPiA+ICsJICogLSBpbiB2bWFsbG9jOiBpZiByZWdpb24gaW9yZW1hcHBlZCBv
ciBkZWZpbmVkIGFzDQo+IGRtYV9hbGxvY19jb2hlcmVudA0KPiA+ICsJICogLSBpbiBrZXJuZWw6
IGlmIHJlZ2lvbiBhbGxvY2F0ZWQgaW4gZ2VuZXJpYyBkbWEgbWVtb3J5IHBvb2wNCj4gPiArCSAq
Lw0KPiA+ICsJaWYgKGlzX3ZtYWxsb2NfYWRkcihjcHVfYWRkcikpIHsNCj4gPiArCQlyZXR1cm4g
cGFnZV90b19waHlzKHZtYWxsb2NfdG9fcGFnZShjcHVfYWRkcikpICsNCj4gPiArCQkJCSAgICBv
ZmZzZXRfaW5fcGFnZShjcHVfYWRkcik7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJV0FSTl9PTigh
dmlydF9hZGRyX3ZhbGlkKGNwdV9hZGRyKSk7DQo+ID4gKwlyZXR1cm4gdmlydF90b19waHlzKGNw
dV9hZGRyKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIHJwcm9jX2RhX3RvX3Zh
KCkgLSBsb29rdXAgdGhlIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MgZm9yIGEgcmVtb3RlcHJvYw0K
PiBhZGRyZXNzDQo+ID4gICAqIEBycHJvYzogaGFuZGxlIG9mIGEgcmVtb3RlIHByb2Nlc3Nvcg0K
PiA+IEBAIC03MTEsNyArNzI3LDcgQEAgc3RhdGljIGludCBycHJvY19oYW5kbGVfY2FydmVvdXQo
c3RydWN0IHJwcm9jDQo+ICpycHJvYywNCj4gPiAgCSAqIEluIHRoaXMgY2FzZSwgdGhlIGRldmlj
ZSBhZGRyZXNzIGFuZCB0aGUgcGh5c2ljYWwgYWRkcmVzcw0KPiA+ICAJICogYXJlIHRoZSBzYW1l
Lg0KPiA+ICAJICovDQo+ID4gLQlyc2MtPnBhID0gZG1hOw0KPiA+ICsJcnNjLT5wYSA9ICh1MzIp
cnByb2NfdmFfdG9fcGEodmEpOw0KPiANCj4gV2hpbGUgSSBhZ3JlZSB3aXRoIHRoZSBkaXJlY3Rp
b24gaGVyZSwgd2Ugb3VnaHQgdG8gYWRkIGEgY2hlY2sgaGVyZQ0KPiB3YXJuaW5nIHVzZXJzIGlm
IHNvbWUgYWRkcmVzcyBiaXRzIGFyZSBnZXR0aW5nIGxvc3QgYXMgYSByZXN1bHQgb2YgdGhlDQo+
IHR5cGVjYXN0LiBHcmFudGVkIHRoZSBpc3N1ZSBtYXkgaGF2ZSBiZWVuIHByZXNlbnQgcHJldmlv
dXNseSB3aXRoDQo+IGRtYV9hZGRyX3QgYXMgd2VsbCwgYnV0IG1vc3QgcGxhdGZvcm1zIHdlcmUg
dXNpbmcgMzItYml0IGRtYSBhZGRyZXNzZXMsDQo+IHNvIHRoaXMgd2FzIGtpbmRhIG1hc2tlZC4g
VGhlcmUgYXJlIEFSTXY3IHBsYXRmb3JtcyB3aXRoIExQQUUgZW5hYmxlZA0KPiBhbGxvd2luZyBw
aHlzaWNhbCBhZGRyZXNzZXMgPiAzMi1iaXRzLg0KPiANCj4gSW4gYW55Y2FzZSwgd2UgZGVmaW5p
dGVseSBoYXZlIGEgbmVlZCBmb3IgYSB2MiBmb3IgdGhlIGZ3X3JzY19jYXJ2ZW91dA0KPiBzdHJ1
Y3R1cmUgdG8gZGVhbCB3aXRoIDY0LWJpdCBhZGRyZXNzZXMuDQo+IA0KDQpBZ3JlZSB3aXRoIHlv
dS4NCkFzc3VtcHRpb24gZm9yIHRoaXMgc2VyaWVzIHdhcyB0byBrZWVwIHJlc291cmNlIHRhYmxl
IGFzIGl0IGlzLiBSZXNvdXJjZSB0YWJsZSBpbXByb3ZlbWVudCBpcyBwbGFubmVkIGluIGEgc2Vj
b25kIHN0ZXAuDQpSZWdhcmRzLA0KTG9pYw0KDQo+IHJlZ2FyZHMNCj4gU3VtYW4NCj4gDQo+ID4N
Cj4gPiAgCWNhcnZlb3V0LT52YSA9IHZhOw0KPiA+ICAJY2FydmVvdXQtPmxlbiA9IHJzYy0+bGVu
Ow0KPiA+DQoNCg==
