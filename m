Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44590C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1254A20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfAKKfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:35:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbfAKKe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:34:59 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 164435B35F258B12420C;
        Fri, 11 Jan 2019 10:34:58 +0000 (GMT)
Received: from FRAEML702-CAH.china.huawei.com (10.206.14.33) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 10:34:57 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.121]) by
 fraeml702-cah.china.huawei.com ([10.206.14.33]) with mapi id 14.03.0415.000;
 Fri, 11 Jan 2019 11:34:45 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "shankerd@codeaurora.org" <shankerd@codeaurora.org>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
Thread-Topic: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory
 allocation for ITS tables
Thread-Index: AQHUqZIBwIWl/QL5rUuwxGPeyFHYR6Wp3fuA
Date:   Fri, 11 Jan 2019 10:34:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8388B37D4@FRAEML521-MBS.china.huawei.com>
References: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
 <9046beb6-36e7-8890-5d09-fc03b6d2728c@arm.com>
In-Reply-To: <9046beb6-36e7-8890-5d09-fc03b6d2728c@arm.com>
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

SGkgU3V6dWtpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1enVr
aSBLIFBvdWxvc2UgW21haWx0bzpzdXp1a2kucG91bG9zZUBhcm0uY29tXQ0KPiBTZW50OiAxMSBK
YW51YXJ5IDIwMTkgMDk6NDINCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1l
ZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+IG1hcmMuenluZ2llckBhcm0uY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBzaGFua2VyZEBjb2RlYXVyb3Jh
Lm9yZzsgZ2FuYXBhdHJhby5rdWxrYXJuaUBjYXZpdW0uY29tOw0KPiBSb2JlcnQuUmljaHRlckBj
YXZpdW0uY29tOyBHdW9oYW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNv
bT47IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGlycWNoaXA6IGdpY3YzLWl0czogVXNlIE5VTUEgYXdh
cmUgbWVtb3J5IGFsbG9jYXRpb24NCj4gZm9yIElUUyB0YWJsZXMNCj4gDQoNClsuLi5dDQoNCj4g
PiAgIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy5jIHwgMjAgKysrKysrKysrKysrLS0t
LS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0
cy5jIGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMNCj4gPiBpbmRleCBkYjIwZTk5
Li5hYjAxMDYxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0
cy5jDQo+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMNCj4gPiBAQCAt
MTc0OSw3ICsxNzQ5LDggQEAgc3RhdGljIGludCBpdHNfc2V0dXBfYmFzZXIoc3RydWN0IGl0c19u
b2RlICppdHMsDQo+IHN0cnVjdCBpdHNfYmFzZXIgKmJhc2VyLA0KPiA+ICAgCQlvcmRlciA9IGdl
dF9vcmRlcihHSVRTX0JBU0VSX1BBR0VTX01BWCAqIHBzeik7DQo+ID4gICAJfQ0KPiA+DQo+ID4g
LQliYXNlID0gKHZvaWQgKilfX2dldF9mcmVlX3BhZ2VzKEdGUF9LRVJORUwgfCBfX0dGUF9aRVJP
LCBvcmRlcik7DQo+ID4gKwliYXNlID0gKHZvaWQgKilwYWdlX2FkZHJlc3MoYWxsb2NfcGFnZXNf
bm9kZShpdHMtPm51bWFfbm9kZSwNCj4gPiArCQkJCSAgICBHRlBfS0VSTkVMIHwgX19HRlBfWkVS
Tywgb3JkZXIpKTsNCj4gDQo+IElmIGFsbG9jX3BhZ2VzX25vZGUoKSBmYWlscywgdGhlIHBhZ2Vf
YWRkcmVzcygpIGNvdWxkIGNyYXNoIHRoZSBzeXN0ZW0uDQo+IA0KPiA+IC0JaXRzLT5jbWRfYmFz
ZSA9ICh2b2lkICopX19nZXRfZnJlZV9wYWdlcyhHRlBfS0VSTkVMIHwgX19HRlBfWkVSTywNCj4g
PiAtCQkJCQkJZ2V0X29yZGVyKElUU19DTURfUVVFVUVfU1opKTsNCj4gPiArCWl0cy0+Y21kX2Jh
c2UgPSAodm9pZA0KPiAqKXBhZ2VfYWRkcmVzcyhhbGxvY19wYWdlc19ub2RlKGl0cy0+bnVtYV9u
b2RlLA0KPiA+ICsJCQkJCSAgICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8sDQo+ID4gKwkJCQkJ
ICAgICBnZXRfb3JkZXIoSVRTX0NNRF9RVUVVRV9TWikpKTsNCj4gDQo+IFNpbWlsYXJseSBoZXJl
LiBXZSBtYXkgd2FudCB0byBoYW5kbGUgaXQgcHJvcGVybHkuDQoNCkFoLi5nb29kIGNhdGNoLiBJ
IHdpbGwgY2hhbmdlIGl0IGFuZCByZWJhc2Ugb24gdG9wIG9mIDUuMC1yYzEgYXMgc3VnZ2VzdGVk
IGJ5IE1hcmMuDQoNClRoYW5rcywNClNoYW1lZXINCg==
