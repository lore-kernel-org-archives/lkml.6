Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE85C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E04E2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E04E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeJXV0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:26:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45008 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727411AbeJXV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:26:25 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9OCmmw0030579;
        Wed, 24 Oct 2018 14:58:19 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nan9y24j0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Oct 2018 14:58:19 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3530134;
        Wed, 24 Oct 2018 12:58:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10E424519;
        Wed, 24 Oct 2018 12:58:19 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Oct
 2018 14:58:18 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Wed, 24 Oct 2018 14:58:18 +0200
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
Thread-Index: AQHUJaveAWmdax4c9E2Z2KFgg/o396UtdC0AgABTcJCAAFw9AIAAwwPg
Date:   Wed, 24 Oct 2018 12:58:18 +0000
Message-ID: <ba92141e939f47699ebf7181fda51a85@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-3-git-send-email-loic.pallardy@st.com>
 <91e489e7-86c3-6ee3-918d-151ef1697429@ti.com>
 <68acbbf905384f6c80b646330a3d1344@SFHDAG7NODE2.st.com>
 <8f19b68f-10f5-b21f-9143-eadb0103999b@ti.com>
In-Reply-To: <8f19b68f-10f5-b21f-9143-eadb0103999b@ti.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4gQW5uYSA8cy1h
bm5hQHRpLmNvbT4NCj4gU2VudDogbWVyY3JlZGkgMjQgb2N0b2JyZSAyMDE4IDA1OjE5DQo+IFRv
OiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFuZGVyc3NvbkBs
aW5hcm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90ZXByb2NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBBcm5hdWQgUE9V
TElRVUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdhaWduYXJkQGxp
bmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMi8xN10gcmVtb3RlcHJvYzogYWRk
IHJwcm9jX3ZhX3RvX3BhIGZ1bmN0aW9uDQo+IA0KPiBPbiAxMC8yMy8xOCAyOjUxIFBNLCBMb2lj
IFBBTExBUkRZIHdyb3RlOg0KPiA+IEhpIFN1bWFuLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFN1bWFuIEFubmEgPHMtYW5uYUB0aS5jb20+DQo+ID4+
IFNlbnQ6IG1hcmRpIDIzIG9jdG9icmUgMjAxOCAxODo1MQ0KPiA+PiBUbzogTG9pYyBQQUxMQVJE
WSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+OyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsNCj4g
Pj4gb2hhZEB3aXplcnkuY29tDQo+ID4+IENjOiBsaW51eC1yZW1vdGVwcm9jQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gQXJuYXVkIFBPVUxJUVVF
TiA8YXJuYXVkLnBvdWxpcXVlbkBzdC5jb20+Ow0KPiA+PiBiZW5qYW1pbi5nYWlnbmFyZEBsaW5h
cm8ub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDIvMTddIHJlbW90ZXByb2M6IGFk
ZCBycHJvY192YV90b19wYSBmdW5jdGlvbg0KPiA+Pg0KPiA+PiBIaSBMb2ljLCBCam9ybiwNCj4g
Pj4NCj4gPj4gT24gNy8yNy8xOCA4OjE0IEFNLCBMb2ljIFBhbGxhcmR5IHdyb3RlOg0KPiA+Pj4g
VGhpcyBuZXcgZnVuY3Rpb24gdHJhbnNsYXRlcyBDUFUgdmlydHVhbCBhZGRyZXNzIGluDQo+ID4+
PiBDUFUgcGh5c2ljYWwgb25lIGFjY29yZGluZyB0byB2aXJ0dWFsIGFkZHJlc3MgbG9jYXRpb24u
DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTG9pYyBQYWxsYXJkeSA8bG9pYy5wYWxsYXJk
eUBzdC5jb20+DQo+ID4+PiBBY2tlZC1ieTogQmpvcm4gQW5kZXJzc29uIDxiam9ybi5hbmRlcnNz
b25AbGluYXJvLm9yZz4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvcmVtb3RlcHJvYy9yZW1v
dGVwcm9jX2NvcmUuYyB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiA+Pj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+PiBiL2RyaXZl
cnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+Pj4gaW5kZXggNDM3ZmFiZi4uOGU1
ZmUxZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2Nv
cmUuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jDQo+
ID4+PiBAQCAtMTQwLDYgKzE0MCwyMiBAQCBzdGF0aWMgdm9pZCBycHJvY19kaXNhYmxlX2lvbW11
KHN0cnVjdCBycHJvYw0KPiA+PiAqcnByb2MpDQo+ID4+PiAgCWlvbW11X2RvbWFpbl9mcmVlKGRv
bWFpbik7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+ICtzdGF0aWMgcGh5c19hZGRyX3QgcnByb2Nf
dmFfdG9fcGEodm9pZCAqY3B1X2FkZHIpDQo+ID4+PiArew0KPiA+Pj4gKwkvKg0KPiA+Pj4gKwkg
KiBSZXR1cm4gcGh5c2ljYWwgYWRkcmVzcyBhY2NvcmRpbmcgdG8gdmlydHVhbCBhZGRyZXNzIGxv
Y2F0aW9uDQo+ID4+PiArCSAqIC0gaW4gdm1hbGxvYzogaWYgcmVnaW9uIGlvcmVtYXBwZWQgb3Ig
ZGVmaW5lZCBhcw0KPiA+PiBkbWFfYWxsb2NfY29oZXJlbnQNCj4gPj4+ICsJICogLSBpbiBrZXJu
ZWw6IGlmIHJlZ2lvbiBhbGxvY2F0ZWQgaW4gZ2VuZXJpYyBkbWEgbWVtb3J5IHBvb2wNCj4gPj4+
ICsJICovDQo+ID4+PiArCWlmIChpc192bWFsbG9jX2FkZHIoY3B1X2FkZHIpKSB7DQo+ID4+PiAr
CQlyZXR1cm4gcGFnZV90b19waHlzKHZtYWxsb2NfdG9fcGFnZShjcHVfYWRkcikpICsNCj4gPj4+
ICsJCQkJICAgIG9mZnNldF9pbl9wYWdlKGNwdV9hZGRyKTsNCj4gPj4+ICsJfQ0KPiA+Pj4gKw0K
PiA+Pj4gKwlXQVJOX09OKCF2aXJ0X2FkZHJfdmFsaWQoY3B1X2FkZHIpKTsNCj4gPj4+ICsJcmV0
dXJuIHZpcnRfdG9fcGh5cyhjcHVfYWRkcik7DQo+ID4+PiArfQ0KPiA+Pj4gKw0KPiA+Pj4gIC8q
Kg0KPiA+Pj4gICAqIHJwcm9jX2RhX3RvX3ZhKCkgLSBsb29rdXAgdGhlIGtlcm5lbCB2aXJ0dWFs
IGFkZHJlc3MgZm9yIGEgcmVtb3RlcHJvYw0KPiA+PiBhZGRyZXNzDQo+ID4+PiAgICogQHJwcm9j
OiBoYW5kbGUgb2YgYSByZW1vdGUgcHJvY2Vzc29yDQo+ID4+PiBAQCAtNzExLDcgKzcyNyw3IEBA
IHN0YXRpYyBpbnQgcnByb2NfaGFuZGxlX2NhcnZlb3V0KHN0cnVjdCBycHJvYw0KPiA+PiAqcnBy
b2MsDQo+ID4+PiAgCSAqIEluIHRoaXMgY2FzZSwgdGhlIGRldmljZSBhZGRyZXNzIGFuZCB0aGUg
cGh5c2ljYWwgYWRkcmVzcw0KPiA+Pj4gIAkgKiBhcmUgdGhlIHNhbWUuDQo+ID4+PiAgCSAqLw0K
PiA+Pj4gLQlyc2MtPnBhID0gZG1hOw0KPiA+Pj4gKwlyc2MtPnBhID0gKHUzMilycHJvY192YV90
b19wYSh2YSk7DQo+ID4+DQo+ID4+IFdoaWxlIEkgYWdyZWUgd2l0aCB0aGUgZGlyZWN0aW9uIGhl
cmUsIHdlIG91Z2h0IHRvIGFkZCBhIGNoZWNrIGhlcmUNCj4gPj4gd2FybmluZyB1c2VycyBpZiBz
b21lIGFkZHJlc3MgYml0cyBhcmUgZ2V0dGluZyBsb3N0IGFzIGEgcmVzdWx0IG9mIHRoZQ0KPiA+
PiB0eXBlY2FzdC4gR3JhbnRlZCB0aGUgaXNzdWUgbWF5IGhhdmUgYmVlbiBwcmVzZW50IHByZXZp
b3VzbHkgd2l0aA0KPiA+PiBkbWFfYWRkcl90IGFzIHdlbGwsIGJ1dCBtb3N0IHBsYXRmb3JtcyB3
ZXJlIHVzaW5nIDMyLWJpdCBkbWEgYWRkcmVzc2VzLA0KPiA+PiBzbyB0aGlzIHdhcyBraW5kYSBt
YXNrZWQuIFRoZXJlIGFyZSBBUk12NyBwbGF0Zm9ybXMgd2l0aCBMUEFFIGVuYWJsZWQNCj4gPj4g
YWxsb3dpbmcgcGh5c2ljYWwgYWRkcmVzc2VzID4gMzItYml0cy4NCj4gPj4NCj4gPj4gSW4gYW55
Y2FzZSwgd2UgZGVmaW5pdGVseSBoYXZlIGEgbmVlZCBmb3IgYSB2MiBmb3IgdGhlIGZ3X3JzY19j
YXJ2ZW91dA0KPiA+PiBzdHJ1Y3R1cmUgdG8gZGVhbCB3aXRoIDY0LWJpdCBhZGRyZXNzZXMuDQo+
ID4+DQo+ID4NCj4gPiBBZ3JlZSB3aXRoIHlvdS4NCj4gPiBBc3N1bXB0aW9uIGZvciB0aGlzIHNl
cmllcyB3YXMgdG8ga2VlcCByZXNvdXJjZSB0YWJsZSBhcyBpdCBpcy4gUmVzb3VyY2UNCj4gdGFi
bGUgaW1wcm92ZW1lbnQgaXMgcGxhbm5lZCBpbiBhIHNlY29uZCBzdGVwLg0KPiANCj4gUGVyaGFw
cywgd2Ugc2hvdWxkIGFkZCBhIFdBUk5fT04gZm9yIHRoZSB0aW1lIGJlaW5nIHVudGlsIHdlIGVu
aGFuY2UNCj4gdGhlDQo+IHJlc291cmNlIHRhYmxlIGZvciA2NC1iaXQgcGxhdGZvcm1zL2FkZHJl
c3Nlcy4NCg0KT0sgSSB3aWxsIHByb3Bvc2UgYSBwYXRjaCB0byBhZGQgV0FSTl9PTiBvbiBjYXN0
IGFwcGxpZWQgb24gcmVzb3VyY2UgdGFibGUgZmllbGQNClJlZ2FyZHMsDQpMb2ljDQo+IA0KPiBy
ZWdhcmRzDQo+IFN1bWFuDQo+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gTG9pYw0KPiA+DQo+ID4+IHJl
Z2FyZHMNCj4gPj4gU3VtYW4NCj4gPj4NCj4gPj4+DQo+ID4+PiAgCWNhcnZlb3V0LT52YSA9IHZh
Ow0KPiA+Pj4gIAljYXJ2ZW91dC0+bGVuID0gcnNjLT5sZW47DQo+ID4+Pg0KPiA+DQoNCg==
