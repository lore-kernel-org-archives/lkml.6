Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB27C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E307620824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E307620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJXVsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:48:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbeJXVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:48:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9ODIns9006018;
        Wed, 24 Oct 2018 15:19:59 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n7stx2hug-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Oct 2018 15:19:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E24C31;
        Wed, 24 Oct 2018 13:19:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB2614E3F;
        Wed, 24 Oct 2018 13:19:57 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Oct
 2018 15:19:57 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Wed, 24 Oct 2018 15:19:57 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v4 15/17] remoteproc: da8xx: declare reserved memory
 region for vdev device
Thread-Topic: [PATCH v4 15/17] remoteproc: da8xx: declare reserved memory
 region for vdev device
Thread-Index: AQHUJavli4hSURdctUqSKQ4RD5ZzhaUuHcuAgADJ8NA=
Date:   Wed, 24 Oct 2018 13:19:57 +0000
Message-ID: <039aad0dc35d4d919bb10a9e37a860f7@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-16-git-send-email-loic.pallardy@st.com>
 <d62a0299-1966-887e-05fd-96a26e0aa838@ti.com>
In-Reply-To: <d62a0299-1966-887e-05fd-96a26e0aa838@ti.com>
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
bm5hQHRpLmNvbT4NCj4gU2VudDogbWVyY3JlZGkgMjQgb2N0b2JyZSAyMDE4IDA0OjU4DQo+IFRv
OiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFuZGVyc3NvbkBs
aW5hcm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90ZXByb2NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBBcm5hdWQgUE9V
TElRVUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdhaWduYXJkQGxp
bmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxNS8xN10gcmVtb3RlcHJvYzogZGE4
eHg6IGRlY2xhcmUgcmVzZXJ2ZWQgbWVtb3J5DQo+IHJlZ2lvbiBmb3IgdmRldiBkZXZpY2UNCj4g
DQo+IEhpIExvaWMsDQo+IA0KPiBPbiA3LzI3LzE4IDg6MTQgQU0sIExvaWMgUGFsbGFyZHkgd3Jv
dGU6DQo+ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGRhOHh4X3Jwcm9jX3BhcnNlX2Z3KCkgdG8g
ZGVjbGFyZSBhDQo+ID4gY2FydmVvdXQgcmVnaW9uIGJhc2VkIG9uIHJlc2VydmVkIG1lbW9yeSBm
b3IgdmRldiBidWZmZXINCj4gPiBhbGxvY2F0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TG9pYyBQYWxsYXJkeSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcmVtb3RlcHJvYy9kYTh4eF9yZW1vdGVwcm9jLmMgfCAzOA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9kYTh4eF9yZW1vdGVw
cm9jLmMNCj4gYi9kcml2ZXJzL3JlbW90ZXByb2MvZGE4eHhfcmVtb3RlcHJvYy5jDQo+ID4gaW5k
ZXggYjY2OGUzMi4uNjc5YTA3NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2Mv
ZGE4eHhfcmVtb3RlcHJvYy5jDQo+ID4gKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL2RhOHh4X3Jl
bW90ZXByb2MuYw0KPiA+IEBAIC0xNiw2ICsxNiw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9p
cnEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gICNp
bmNsdWRlIDxsaW51eC9vZl9yZXNlcnZlZF9tZW0uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVtb3RlcHJvYy5oPg0KPiA+
IEBAIC0xNzksMTAgKzE4MCw0NyBAQCBzdGF0aWMgdm9pZCBkYTh4eF9ycHJvY19raWNrKHN0cnVj
dCBycHJvYyAqcnByb2MsDQo+IGludCB2cWlkKQ0KPiA+ICAJd3JpdGVsKFNZU0NGR19DSElQU0lH
MiwgZHJwcm9jLT5jaGlwc2lnKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgZGE4eHhf
cnByb2NfcGFyc2VfZncoc3RydWN0IHJwcm9jICpycHJvYywgY29uc3Qgc3RydWN0IGZpcm13YXJl
DQo+ICpmdykNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gcnByb2MtPmRldi5w
YXJlbnQ7DQo+ID4gKwlzdHJ1Y3QgcnByb2NfbWVtX2VudHJ5ICptZW07DQo+ID4gKwlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5vZGU7DQo+ID4gKwlzdHJ1Y3QgcmVzb3VyY2UgcmVzOw0KPiA+ICsJaW50
IGVycjsNCj4gPiArDQo+ID4gKwlub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUs
ICJtZW1vcnktcmVnaW9uIiwgMCk7DQo+ID4gKwlpZiAoIW5vZGUpIHsNCj4gPiArCQlkZXZfZXJy
KGRldiwgIk5vIG1lbW9yeS1yZWdpb24gc3BlY2lmaWVkXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwllcnIgPSBvZl9hZGRyZXNzX3RvX3Jlc291cmNl
KG5vZGUsIDAsICZyZXMpOw0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAi
QmFkIG1lbW9yeS1yZWdpb24gZGVmaW5pdGlvblxuIik7DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwkvKiBSZWdpc3RlciBtZW1vcnkgcmVnaW9uIGZvciB2ZGV2IGJ1
ZmZlciBhbGxvY2F0aW9uICovDQo+ID4gKwltZW0gPSBycHJvY19vZl9yZXNtX21lbV9lbnRyeV9p
bml0KGRldiwgMCwNCj4gcmVzb3VyY2Vfc2l6ZSgmcmVzKSwNCj4gPiArCQkJCQkgICByZXMuc3Rh
cnQsICJ2ZGV2MGJ1ZmZlciIpOz4gKw0KPiA+ICsJaWYgKCFtZW0pDQo+ID4gKwkJcmV0dXJuIC1F
Tk9NRU07DQo+ID4gKw0KPiA+ICsJcnByb2NfYWRkX2NhcnZlb3V0KHJwcm9jLCBtZW0pOw0KPiA+
ICsNCj4gPiArCXJldHVybiBycHJvY19lbGZfbG9hZF9yc2NfdGFibGUocnByb2MsIGZ3KTsNCj4g
PiArfQ0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2gsIGJ1dCB0aGlzIGNyZWF0ZXMgYSBrZXJu
ZWwgY3Jhc2ggZm9yIG1lIGR1ZSB0bw0KPiBvdmVybGFwcyB3aXRoIG1hbnVhbGx5IGNyZWF0ZWQg
Y2FydmVvdXRzLiBJIGN1cnJlbnRseSBoYXZlIGEgc2luZ2xlDQo+IG1lbW9yeS1yZWdpb24gYW5k
IGFsbCBhbGxvY2F0aW9ucyBjb21lIGZyb20gdGhlIHNhbWUgRE1BIHBvb2wsIGJ1dCB0aGUNCj4g
cnByb2Nfb2ZfcmVzbV9tZW1fZW50cnlfaW5pdCgpIGNyZWF0ZXMgYW4gb3ZlcmFsbCBtZW0gZW50
cnkgd2l0aG91dCB0aGUNCj4gdmEgYmVpbmcgc2V0IChubyBhbGxvYyBmdW5jdGlvbiBwbHVtYmVk
IGluKS4gSW4gZ2VuZXJhbCwgaXQgaXMgcGVybWl0dGVkDQo+IHRvIHVzZSB0aGUgc2FtZSByZXNl
cnZlZC1tZW1vcnkgbm9kZSB3aXRoIG11bHRpcGxlIGRldmljZXMsIHNvIHRoZSBpbmRleA0KPiB1
c2FnZSBzaG91bGQgaGF2ZSBhbGxvd2VkIGl0IHRvIGRvIERNQSBhbGxvY2F0aW9ucyB3aXRoIHZk
ZXYgZGV2aWNlcywNCj4gYnV0IHRoZSBsb2FkaW5nIGlzIHBlcmZvcm1lZCBldmVuIGJlZm9yZSB0
aGUgdmRldiBhbGxvY2F0aW9ucyBhbmQgdGhlDQo+IGRhX3RvX3ZhIG1hdGNoZXMgdGhlIGZpcnN0
IGVudHJ5IHdpdGggbm8gdmEgc2V0IGNhdXNpbmcgdGhlIGNyYXNoLg0KDQpIdW1tbSwgSSBkaWRu
J3QgZmFsbCBpbiB0aGlzIGNhc2UsIGJ1dCBjbGVhcmx5IGRhX3RvX3ZhIHNob3VsZCBub3QgY3Jh
c2hlZC4gDQpOb3QgYWxsb2NhdGVkIGNhcnZlb3V0IHNob3VsZCBiZSBieXBhc3NlZCBpbiB0aGUg
bG9vcC4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlzLiBJIG5lZWQgdG8gZml4IGl0Lg0KDQpUaGUg
cnByb2Nfb2ZfcmVzbV9tZW1fZW50cnlfaW5pdCgpIGlzIHNpbXBseSByZWdpc3RlcmluZyB0aGUg
cmVzZXJ2ZWQgbWVtb3J5IHRvIGJlIGF0dGFjaGVkIHRvIHZkZXYgZGV2aWNlLg0KU28gdGhhdCBu
b3JtYWwgaXQgd29uJ3QgYmUgYWxsb2NhdGVkIGJ5IHJwcm9jIGNvcmUgKHRoZXJlIGlzIG5vIGFs
bG9jL2ZyZWUgZnVuY3Rpb24gc3BlY2lmaWNpZWQgaW4gdGhpcyBoZWxwZXIpLiANCg0KUmVnYXJk
cywNCkxvaWMNCj4gDQo+IEhlcmUncyBteSBkZWJ1Z2ZzIG91dHB1dCBvZiB0aGUgY2FydmVvdXRf
bWVtb3JpZXMgZm9yIHJlZmVyZW5jZSwNCj4gDQo+IENhcnZlb3V0IG1lbW9yeSBlbnRyeToNCj4g
ICAgICAgICBOYW1lOiB2ZGV2MGJ1ZmZlcg0KPiAgICAgICAgIFZpcnR1YWwgYWRkcmVzczogMDAw
MDAwMDANCj4gICAgICAgICBETUEgYWRkcmVzczogMHgwMDAwMDAwMA0KPiAgICAgICAgIERldmlj
ZSBhZGRyZXNzOiAweGMzMDAwMDAwDQo+ICAgICAgICAgTGVuZ3RoOiAweDEwMDAwMDAgQnl0ZXMN
Cj4gDQo+IENhcnZlb3V0IG1lbW9yeSBlbnRyeToNCj4gICAgICAgICBOYW1lOiB2ZGV2MHZyaW5n
MA0KPiAgICAgICAgIFZpcnR1YWwgYWRkcmVzczogYzMwMDAwMDANCj4gICAgICAgICBETUEgYWRk
cmVzczogMHhjMzAwMDAwMA0KPiAgICAgICAgIERldmljZSBhZGRyZXNzOiAweGMzMDAwMDAwDQo+
ICAgICAgICAgTGVuZ3RoOiAweDMwMDAgQnl0ZXMNCj4gDQo+IENhcnZlb3V0IG1lbW9yeSBlbnRy
eToNCj4gICAgICAgICBOYW1lOiB2ZGV2MHZyaW5nMQ0KPiAgICAgICAgIFZpcnR1YWwgYWRkcmVz
czogYzMwMDQwMDANCj4gICAgICAgICBETUEgYWRkcmVzczogMHhjMzAwNDAwMA0KPiAgICAgICAg
IERldmljZSBhZGRyZXNzOiAweGMzMDA0MDAwDQo+ICAgICAgICAgTGVuZ3RoOiAweDMwMDAgQnl0
ZXMNCj4gDQo+IENhcnZlb3V0IG1lbW9yeSBlbnRyeToNCj4gICAgICAgICBOYW1lOiBEU1BfTUVN
X0RBVEENCj4gICAgICAgICBWaXJ0dWFsIGFkZHJlc3M6IGMzMTAwMDAwDQo+ICAgICAgICAgRE1B
IGFkZHJlc3M6IDB4YzMxMDAwMDANCj4gICAgICAgICBEZXZpY2UgYWRkcmVzczogMHhjMzEwMDAw
MA0KPiAgICAgICAgIExlbmd0aDogMHhmMDAwMDAgQnl0ZXMNCj4gDQo+IFlvdSBjYW4gZHJvcCBi
b3RoIHRoaXMgcGF0Y2ggYW5kIHRoZSBrZXlzdG9uZV9yZW1vdGVwcm9jIHBhdGNoIGZyb20gdGhl
DQo+IHNlcmllcy4gSSBkaWQgbm90IHJ1biBpbnRvIGFueSBpc3N1ZXMgdGhlcmUgc2luY2UgSSBk
aWQgbm90IGhhdmUgYW55DQo+IFJTQ19DQVJWRU9VVCBlbnRyaWVzIHRoZXJlLiBBbHNvLCBzZWUg
bXkgY29tbWVudHMgb24gdGhlIG5leHQgcGF0Y2gNCj4gKHRoZQ0KPiBjaGFuZ2VzIGluIFNUKSBp
biBnZW5lcmFsIHJlZ2FyZGluZyB0aGVzZSBBUEkuIExvb2tzIGxpa2UgdGhpcyBuZWVkcw0KPiBz
b21lIG1vcmUgdGltZSBpbiBpcm9uaW5nIG91dCB0aGUgaXNzdWVzLg0KPiANCj4gcmVnYXJkcw0K
PiBTdW1hbg0KPiANCj4gDQo+IA0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBycHJv
Y19vcHMgZGE4eHhfcnByb2Nfb3BzID0gew0KPiA+ICAJLnN0YXJ0ID0gZGE4eHhfcnByb2Nfc3Rh
cnQsDQo+ID4gIAkuc3RvcCA9IGRhOHh4X3Jwcm9jX3N0b3AsDQo+ID4gIAkua2ljayA9IGRhOHh4
X3Jwcm9jX2tpY2ssDQo+ID4gKwkucGFyc2VfZncgPSBkYTh4eF9ycHJvY19wYXJzZV9mdywNCj4g
PiArCS5sb2FkID0gcnByb2NfZWxmX2xvYWRfc2VnbWVudHMsDQo+ID4gKwkuZmluZF9sb2FkZWRf
cnNjX3RhYmxlID0gcnByb2NfZWxmX2ZpbmRfbG9hZGVkX3JzY190YWJsZSwNCj4gPiArCS5zYW5p
dHlfY2hlY2sgPSBycHJvY19lbGZfc2FuaXR5X2NoZWNrLA0KPiA+ICsJLmdldF9ib290X2FkZHIg
PSBycHJvY19lbGZfZ2V0X2Jvb3RfYWRkciwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50
IGRhOHh4X3Jwcm9jX2dldF9pbnRlcm5hbF9tZW1vcmllcyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2LA0KPiA+DQoNCg==
