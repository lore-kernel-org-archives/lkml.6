Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451E32098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451E32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJCPkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:40:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2093 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeJCPkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:40:10 -0400
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A0ABF1BB4221;
        Wed,  3 Oct 2018 09:52:42 +0100 (IST)
Received: from FRAEML702-CAH.china.huawei.com (10.206.14.33) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Wed, 3 Oct 2018 09:52:43 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 fraeml702-cah.china.huawei.com ([10.206.14.33]) with mapi id 14.03.0399.000;
 Wed, 3 Oct 2018 10:52:36 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHUUb0pQn5upG3YtUCPh5BgR8Q9BqUL7psAgAAjqICAAASWAIABMN9Q
Date:   Wed, 3 Oct 2018 08:52:35 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838793F64@FRAEML521-MBX.china.huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
 <1dc554eb-7ed2-45b3-109f-8cec286b4525@arm.com>
 <1cdc3c01-e8f9-fd60-da88-cc49d22fe0be@arm.com>
In-Reply-To: <1cdc3c01-e8f9-fd60-da88-cc49d22fe0be@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDAyIE9jdG9iZXIgMjAxOCAxNzoz
NQ0KPiBUbzogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlLmJydWNrZXJAYXJt
LmNvbT47IFNoYW1lZXJhbGkNCj4gS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gQ2M6IG1h
cmsucnV0bGFuZEBhcm0uY29tOyB2a2lsYXJpQGNvZGVhdXJvcmEub3JnOw0KPiBuZWlsLm0ubGVl
ZGVyQGdtYWlsLmNvbTsgcGFiYmFAY29kZWF1cm9yYS5vcmc7IEpvaG4gR2FycnkNCj4gPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT47IHdpbGwuZGVhY29uQGFybS5jb207IHJydWlncm9rQGNvZGVhdXJv
cmEub3JnOw0KPiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBH
dW9oYW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzNdIHBlcmY6
IGFkZCBhcm02NCBzbW11djMgcG11IGRyaXZlcg0KPiANCj4gT24gMDIvMTAvMTggMTc6MTksIEpl
YW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToNCj4gPiBPbiAwMi8xMC8yMDE4IDE1OjExLCBKZWFu
LVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6DQo+ID4+PiArCWNmZ3IgPSByZWFkbF9yZWxheGVkKHNt
bXVfcG11LT5yZWdfYmFzZSArIFNNTVVfUE1DR19DRkdSKTsNCj4gPg0KPiA+IFNvbWV0aGluZyBJ
IG1pc3NlZCBwcmV2aW91c2x5OiB3aGVuIFNNTVVfUE1DR19DRkdSLlNJRF9GSUxURVJfVFlQRQ0K
PiBpcyAxLA0KPiA+IGZpbHRlcmluZyBmb3IgYWxsIGNvdW50ZXJzIGlzIGNvbmZpZ3VyZWQgYnkg
U01NVV9QTUNHX1NNUjAgYW5kDQo+ID4gU01NVV9QTUNHX0VWVFlQRVIwIChpbnN0ZWFkIG9mIGhh
dmluZyBvbmUgc2VwYXJhdGUgZmlsdGVyIHBlciBjb3VudGVyKS4NCj4gDQo+IE9oLCBJIGhhZG4n
dCBldmVuIG5vdGljZWQgaXQgaGFkIHRoYXQgbW9kZSBhcyB3ZWxsLi4uDQoNClRoYW5rcyBKZWFu
LiBNaXNzZWQgdGhhdCBjb21wbGV0ZWx5LiANCiANCj4gPiBJbiB0aGF0IG1vZGUgd2l0aCB5b3Vy
IHBhdGNoLCBpZiB0aGUgdXNlciBhcHBsaWVzIGEgZmlsdGVyIHRvIHRoZSBmaXJzdA0KPiA+IGV2
ZW50IGluIHRoZSBsaXN0IHBhc3NlZCB0byBwZXJmLCBpdCB3aWxsIGJlIGFwcGxpZWQgdG8gYWxs
IGV2ZW50cy4NCj4gPiBGaWx0ZXIgYXBwbGllZCBvbiBhbnkgc3Vic2VxdWVudCBldmVudCB3aWxs
IGJlIGlnbm9yZWQuIENvdWxkIHdlIG1ha2UNCj4gPiB0aGlzIG1vcmUgZXhwbGljaXQ/IE1heWJl
IGluIHRoZSBwcm9iZSBwcmludCB0aGF0IHRoZSBQTUNHIGlzDQo+ID4gZ2xvYmFsLWZpbHRlcmlu
ZywgYW5kIHdoZW4gYXR0ZW1wdGluZyB0byBhcHBseSBhIGZpbHRlciB0byBzb21ldGhpbmcNCj4g
PiBlbHNlIHRoYW4gRVZDTlRSMCwgcmV0dXJuIGFuIGVycm9yPw0KPiANCj4gRldJVyBmaWx0ZXJp
bmcgaXMgYWx3YXlzIHBlci1jb3VudGVyLWdyb3VwIG9uIHRoZSBTTU1VdjIgUE1VLCBhbmQgaXQn
cw0KPiBhY3R1YWxseSBwcmV0dHkgc3RyYWlnaHRmb3J3YXJkIHRvIGNvcGUgd2l0aCAtIHBtdS0+
YWRkKCkganVzdCBuZWVkcyB0bw0KPiByZWplY3QgdGhlIGV2ZW50IGlmIG9uZSB3aXRoIGFuIGlu
Y29tcGF0aWJsZSBjb25maWd1cmF0aW9uIGlzIGFscmVhZHkNCj4gc2NoZWR1bGVkLCBzbyBwZXJm
IGNvcmUgaGFuZGxlcyBpdCBtdWNoIGxpa2UgaGF2aW5nIG1vcmUgZXZlbnRzIHRoYW4NCj4gY291
bnRlcnMsIGJ5IHJvdGF0aW5nIHRoZSBtdXR1YWxseS1leGNsdXNpdmUgc2V0cy4NCg0KSSB3aWxs
IHRha2UgYSBsb29rIGFuZCBhZGRyZXNzIHRoaXMgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3Ms
DQpTaGFtZWVyDQo=
