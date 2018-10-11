Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183C6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAC72077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAC72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJKTQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:16:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbeJKTQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:16:22 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5318E543E2806;
        Thu, 11 Oct 2018 12:49:26 +0100 (IST)
Received: from FRAEML703-CAH.china.huawei.com (10.206.14.34) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Thu, 11 Oct 2018 12:49:27 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 fraeml703-cah.china.huawei.com ([10.206.14.34]) with mapi id 14.03.0399.000;
 Thu, 11 Oct 2018 13:49:18 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
Subject: RE: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHUUb0pQn5upG3YtUCPh5BgR8Q9BqUZ5U6AgAAiGGA=
Date:   Thu, 11 Oct 2018 11:49:18 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83879AD29@FRAEML521-MBX.china.huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <d649de4e-e0cc-4188-5e56-fea1488b9d6b@arm.com>
In-Reply-To: <d649de4e-e0cc-4188-5e56-fea1488b9d6b@arm.com>
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
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDExIE9jdG9iZXIgMjAxOCAxMjoy
Ng0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogd2ls
bC5kZWFjb25AYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IEd1b2hhbmp1biAoSGFuanVu
IEd1bykNCj4gPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgSm9obiBHYXJyeSA8am9obi5nYXJyeUBo
dWF3ZWkuY29tPjsNCj4gcGFiYmFAY29kZWF1cm9yYS5vcmc7IHZraWxhcmlAY29kZWF1cm9yYS5v
cmc7IHJydWlncm9rQGNvZGVhdXJvcmEub3JnOw0KPiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBuZWls
Lm0ubGVlZGVyQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gcGVyZjog
YWRkIGFybTY0IHNtbXV2MyBwbXUgZHJpdmVyDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT25l
IG1vcmUgdGhpbmcuLi4NCj4gDQo+IE9uIDIxLzA5LzE4IDE2OjA4LCBTaGFtZWVyIEtvbG90aHVt
IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ICtzdGF0aWMgaW50IHNtbXVfcG11X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBzbW11X3BtdSAqc21t
dV9wbXU7DQo+ID4gKwlzdHJ1Y3QgcmVzb3VyY2UgKnJlc18wLCAqcmVzXzE7DQo+ID4gKwl1MzIg
Y2ZnciwgcmVnX3NpemU7DQo+ID4gKwl1NjQgY2VpZF82NFsyXTsNCj4gPiArCWludCBpcnEsIGVy
cjsNCj4gPiArCWNoYXIgKm5hbWU7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+
ZGV2Ow0KPiA+ICsNCj4gPiArCXNtbXVfcG11ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpz
bW11X3BtdSksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFzbW11X3BtdSkNCj4gPiArCQlyZXR1
cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlzbW11X3BtdS0+ZGV2ID0gZGV2Ow0KPiA+ICsNCj4g
PiArCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHNtbXVfcG11KTsNCj4gPiArCXNtbXVfcG11
LT5wbXUgPSAoc3RydWN0IHBtdSkgew0KPiA+ICsJCS50YXNrX2N0eF9uciAgICA9IHBlcmZfaW52
YWxpZF9jb250ZXh0LA0KPiA+ICsJCS5wbXVfZW5hYmxlCT0gc21tdV9wbXVfZW5hYmxlLA0KPiA+
ICsJCS5wbXVfZGlzYWJsZQk9IHNtbXVfcG11X2Rpc2FibGUsDQo+ID4gKwkJLmV2ZW50X2luaXQJ
PSBzbW11X3BtdV9ldmVudF9pbml0LA0KPiA+ICsJCS5hZGQJCT0gc21tdV9wbXVfZXZlbnRfYWRk
LA0KPiA+ICsJCS5kZWwJCT0gc21tdV9wbXVfZXZlbnRfZGVsLA0KPiA+ICsJCS5zdGFydAkJPSBz
bW11X3BtdV9ldmVudF9zdGFydCwNCj4gPiArCQkuc3RvcAkJPSBzbW11X3BtdV9ldmVudF9zdG9w
LA0KPiA+ICsJCS5yZWFkCQk9IHNtbXVfcG11X2V2ZW50X3JlYWQsDQo+ID4gKwkJLmF0dHJfZ3Jv
dXBzCT0gc21tdV9wbXVfYXR0cl9ncnBzLA0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlyZXNfMCA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gKwlz
bW11X3BtdS0+cmVnX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXNfMCk7DQo+
IA0KPiBXZSBzdGlsbCBuZWVkIHRvIHNvbHZlIHRoZSByZXNvdXJjZS1jbGFpbWluZyBpc3N1ZSB3
aGVuIG9uZSAob3IgYm90aCkgb2YNCj4gdGhlIFBNQ0cgcGFnZXMgYmVsb25ncyB0byB0aGUgcGFy
ZW50IGRldmljZSdzIHJlZ2lzdGVyIHNwYWNlLiBJIHJlY2FsbA0KPiB3ZSBjaHVja2VkIGEgZmV3
IG5hc2NlbnQgaWRlYXMgYWJvdXQgYmVmb3JlOyBkaWQgYW55b25lIG1hbmFnZSB0byBjb21lDQo+
IHVwIHdpdGggYW55dGhpbmcgY29uY3JldGU/DQoNClJpZ2h0LiBXZSBoYWQgYW4gZWFybHkgdmVy
c2lvbiBvZiBhbiBldmFsdWF0aW9uIGJvYXJkIHdoZXJlIHdlIGhhZCB0aGlzIGlzc3VlLCANCmJ1
dCB0aGlzIGhhcyBiZWVuIGZpeGVkIGluIGFuIHVwZGF0ZWQgcmV2aXNpb24gYW5kIGlzIG5vdCBh
IHByaW9yaXR5IGZvciBub3cuIA0KDQpBZ3JlZSB0aGF0IHRoaXMgaXMgYW4gaXNzdWUgYXMgdGhl
IHNwZWMgZG9lc27igJl0IGZvcmJpZCB1c2luZyBwYXJlbnQgU01NVSByZWdpc3Rlcg0Kc3BhY2Ug
YW5kIGl0IGxvb2tzIGxpa2Ugbm90IGFuIGVhc3kgb25lIHRvIHNvbHZlIGVpdGhlci4gVGhlIGlu
aXRpYWwgaWRlYSB3YXMgc2V0dGluZw0KdGhlIFBNQ0cgYXMgYSBjaGlsZCBkZXYsIGJ1dCB0aGF0
IGRpZG7igJl0IGhlbHAuDQoNCkkgaGFkIGFuIG9mZiBsaXN0IGRpc2N1c3Npb24gd2l0aCBMb3Jl
bnpvIG9uIHRoaXMsIGJ1dCBub3RoaW5nIGNvbmNyZXRlLg0KDQpMb3JlbnpvLCANCg0KUGxlYXNl
IHVwZGF0ZSBpZiB5b3UgaGF2ZSBhbnkgbmV3IGlkZWFzL3Rob3VnaHRzIG9uIHRoaXMuDQoNClRo
YW5rcywNClNoYW1lZXINCg0KPiBSb2Jpbi4NCg==
