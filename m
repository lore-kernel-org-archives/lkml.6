Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6757DC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EA3213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EA3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJCSQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:16:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726547AbeJCSQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:16:28 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C01E8EE71949;
        Wed,  3 Oct 2018 12:28:25 +0100 (IST)
Received: from FRAEML702-CAH.china.huawei.com (10.206.14.33) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Wed, 3 Oct 2018 12:28:27 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 fraeml702-cah.china.huawei.com ([10.206.14.33]) with mapi id 14.03.0399.000;
 Wed, 3 Oct 2018 13:28:19 +0200
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
Thread-Index: AQHUUb0pQn5upG3YtUCPh5BgR8Q9BqUNRQ6AgAAtONA=
Date:   Wed, 3 Oct 2018 11:28:19 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838794127@FRAEML521-MBX.china.huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
In-Reply-To: <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
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
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDAzIE9jdG9iZXIgMjAxOCAxMToz
Nw0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogd2ls
bC5kZWFjb25AYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IEd1b2hhbmp1biAoSGFuanVu
IEd1bykNCj4gPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgSm9obiBHYXJyeSA8am9obi5nYXJyeUBo
dWF3ZWkuY29tPjsNCj4gcGFiYmFAY29kZWF1cm9yYS5vcmc7IHZraWxhcmlAY29kZWF1cm9yYS5v
cmc7IHJydWlncm9rQGNvZGVhdXJvcmEub3JnOw0KPiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBuZWls
Lm0ubGVlZGVyQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gcGVyZjog
YWRkIGFybTY0IHNtbXV2MyBwbXUgZHJpdmVyDQo+IA0KPiBPbiAyMS8wOS8xOCAxNjowOCwgU2hh
bWVlciBLb2xvdGh1bSB3cm90ZToNCj4gWy4uLl0NCj4gPiArDQo+ID4gKwllcnIgPSBjcHVocF9z
dGF0ZV9hZGRfaW5zdGFuY2Vfbm9jYWxscyhjcHVocF9zdGF0ZV9udW0sDQo+ID4gKwkJCQkJICAg
ICAgICZzbW11X3BtdS0+bm9kZSk7DQo+IA0KPiBJbiB0aGVvcnkgYSBob3RwbHVnIGV2ZW50IGNv
dWxkIGhhcHBlbiBhcyBzb29uIGFzIHRoZSBpbnN0YW5jZSBpcw0KPiByZWdpc3RlcmVkLi4uDQo+
IA0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiRXJyb3IgJWQgcmVnaXN0
ZXJpbmcgaG90cGx1ZywgUE1VIEAlcGFcbiIsDQo+ID4gKwkJCWVyciwgJnJlc18wLT5zdGFydCk7
DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBQaWNrIG9uZSBD
UFUgdG8gYmUgdGhlIHByZWZlcnJlZCBvbmUgdG8gdXNlICovDQo+ID4gKwlzbW11X3BtdS0+b25f
Y3B1ID0gZ2V0X2NwdSgpOw0KPiANCj4gLi4uc28gdGhpcyBsb29rcyB0b28gbGF0ZSwgaS5lLiBh
IHJhY2UgaGVyZSBjYW4gcmVzdWx0IGluIGEgYm9ndXMgY2FsbA0KPiB0byBwZXJmX3BtdV9taWdy
YXRlX2NvbnRleHQoKSB3aXRoIGFuIHVuaW5pdGlhbGlzZWQgcG11Lg0KDQpUaGFua3MgUm9iaW4u
IEkgd2lsbCByZW9yZGVyIHRoZW0uDQoNClNoYW1lZXINCg0KPiBSb2Jpbi4gDQo+ID4gKwlXQVJO
X09OKGlycV9zZXRfYWZmaW5pdHkoc21tdV9wbXUtPmlycSwgY3B1bWFza19vZihzbW11X3BtdS0N
Cj4gPm9uX2NwdSkpKTsNCj4gPiArDQo+ID4gKwllcnIgPSBwZXJmX3BtdV9yZWdpc3Rlcigmc21t
dV9wbXUtPnBtdSwgbmFtZSwgLTEpOw0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRldl9lcnIo
ZGV2LCAiRXJyb3IgJWQgcmVnaXN0ZXJpbmcgUE1VIEAlcGFcbiIsDQo+ID4gKwkJCWVyciwgJnJl
c18wLT5zdGFydCk7DQo+ID4gKwkJZ290byBvdXRfdW5yZWdpc3RlcjsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlwdXRfY3B1KCk7DQo=
