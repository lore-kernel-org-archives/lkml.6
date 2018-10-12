Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A3C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FCA20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FCA20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeJLXJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:09:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728857AbeJLXJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:09:18 -0400
Received: from DGGEMA404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id C3AE77E66F73D;
        Fri, 12 Oct 2018 23:36:13 +0800 (CST)
Received: from DGGEMA523-MBX.china.huawei.com ([169.254.5.64]) by
 DGGEMA404-HUB.china.huawei.com ([10.3.20.45]) with mapi id 14.03.0399.000;
 Fri, 12 Oct 2018 23:36:14 +0800
From:   gengdongjiu <gengdongjiu@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "drjones@redhat.com" <drjones@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events
 support
Thread-Topic: [PATCH v3 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events
 support
Thread-Index: AdRiQUxxY2Cemze1RYKUxcsJHL0hRg==
Date:   Fri, 12 Oct 2018 15:36:14 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201ECC805@dggema523-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.54.63]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNCj4gSGkgRG9uZ2ppdSBHZW5nLA0KPiANCj4gT24gMTEvMTAvMjAxOCAyMDow
NywgRG9uZ2ppdSBHZW5nIHdyb3RlOg0KPiA+IFRoZSBjb21taXQgNTM5YWVlMGVkYjlmICgiS1ZN
OiBhcm02NDogU2hhcmUgdGhlIHBhcnRzIG9mIGdldC9zZXQNCj4gPiBldmVudHMgdXNlZnVsIHRv
IDMyYml0Iikgc2hhcmVzIHRoZSBnZXQvc2V0IGV2ZW50cyBoZWxwZXIgZm9yIGFybTY0DQo+ID4g
YW5kIGFybTMyLA0KPiANCj4gT29wcy4gSSBldmlkZW50bHkgZGlkbid0IHRlc3QgdGhpcyBiaXQu
IExvb2tzIGxpa2UgSSBqdXN0IGRlcGVuZGVkIG9uIHRoZSBzeW1ib2wgdG8gYmUgZGVmaW5lZCwg
SSBkaWRuJ3QgY2hlY2sgdGhlIENBUCB3YXMgZXhwb3NlZC4NCg0KWWVzLCB5b3UgZG8gbm90IGNo
ZWNrIHRoZSBDQVAgd2hlbiB5b3UgdGVzdCBpdC4NCg0KPiANCj4gDQo+ID4gaXQgaXMgYmV0dGVy
IGFsc28gc2hhcmUgdGhlIGNoZWNrDQo+ID4gZm9yIHZjcHUgZXZlbnRzIGNhcGFiaWxpdHkgdG8g
ZW5hYmxlIDMyIGJpdCBrdm0gdmNwdSBldmVudHMgc3VwcG9ydC4NCj4gDQo+IG5vdCBqdXN0IGJl
dHRlciwgbmVjZXNzYXJ5IGZvciBjb3JyZWN0bHktd3JpdHRlbiB1c2VyLXNwYWNlIHRvIGtub3cg
dGhlIGZlYXR1cmUgaXMgc3VwcG9ydGVkLiBUaGlzIGxhc3QgYml0IHdvdWxkIGJlIGNsZWFyZXIg
YXM6ICJidXQgZm9yZ290IHRvDQo+IHNoYXJlIHRoZSBjYXAgZXh0ZW5zaW9uIGNvZGUuIg0KDQpP
aywgd2lsbCB1cGRhdGUgaXQuDQoNCj4gDQo+IA0KPiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMh
DQoNCllvdSBhcmUgd2VsY29tZQ0KDQo+IA0KPiBBY2tlZC1ieTogSmFtZXMgTW9yc2UgPGphbWVz
Lm1vcnNlQGFybS5jb20+DQo+IA0KPiANCj4gVGhhbmtzLA0KPiANCj4gSmFtZXMNCg0K
