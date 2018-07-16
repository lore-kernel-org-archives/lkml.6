Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B67ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EFA208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EFA208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeGPIVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:21:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11726 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbeGPIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:21:45 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6G7sOJD019566;
        Mon, 16 Jul 2018 09:55:09 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k85reb1wx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Jul 2018 09:55:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E55C731;
        Mon, 16 Jul 2018 07:55:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B53D9A6BB;
        Mon, 16 Jul 2018 07:55:08 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Jul
 2018 09:55:08 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 16 Jul 2018 09:55:08 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Srinivas Kandagatla <srinivas.kandagatla@st.com>
CC:     Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: STi: at least warn if of_iomap fails
Thread-Topic: [PATCH] ARM: STi: at least warn if of_iomap fails
Thread-Index: AQHUGfhqsrlFtPu/lESYrSPAF/fd9KSRXyeA
Date:   Mon, 16 Jul 2018 07:55:08 +0000
Message-ID: <50a1ccc1-e64a-a35e-a7b5-eeb7082478e9@st.com>
References: <1531410530-24163-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1531410530-24163-1-git-send-email-hofrat@osadl.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F065DD1A4819B4DBE08FC2DB75CCF68@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljaG9sYXMNCg0KT24gMDcvMTIvMjAxOCAwNTo0OCBQTSwgTmljaG9sYXMgTWMgR3VpcmUg
d3JvdGU6DQo+IFRoZSBjYWxsIHRvIG9mX2lvbWFwKCkgaXMgdW5jaGVja2VkIGJ1dCBzY3VfZW5h
YmxlKCksIHdoaWNoIHRoZSByZXR1cm5lZA0KPiBhZGRyZXNzIGlzIHBhc3NlZCBvbiB0bywgYXNz
dW1lcyBhIHZhbGlkIG1hcHBpbmcuIElmIHRoZSBtYXBwaW5nIGlzDQo+IGludmFsaWQgdGhpcyBj
b3VsZCBwcm9iYWJseSBsZWFkIHRvIHVuZGVmaW5lZCBzeXN0ZW0gc3RhdGUgc28gYXQgbGVhc3QN
Cj4gYSB3YXJuaW5nIHNob3VsZCBiZSBpc3N1ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNo
b2xhcyBNYyBHdWlyZSA8aG9mcmF0QG9zYWRsLm9yZz4NCj4gRml4ZXM6IGNvbW1pdCA2NWViY2Mx
MTU4ODkgKCJBUk06IHN0aTogQWRkIFNUaUg0MTUgU09DIHN1cHBvcnQiKQ0KPiAtLS0NCj4gUHJv
YmxlbSB3YXMgZm91bmQgYnkgYW4gZXhwZXJpbWVudGFsIGNvY2NpbmVsbGUgc2NyaXB0DQo+IA0K
PiBQYXRjaCB3YXMgY29tcGlsZSB0ZXN0ZWQgd2l0aDogbXVsdGlfdjdfZGVmY29uZmlnIChpbXBs
aWVzDQo+IENPTkZJR19BUkNIX1NUST15LCBDT05GSUdfU01QPXkpDQo+IA0KPiBQYXRjaCBpcyBh
Z2FpbnN0IDQuMTgtcmMzIChsb2NhbHZlcnNpb24tbmV4dCBpcyBuZXh0LTIwMTgwNzEyKQ0KPiAN
Cj4gICBhcmNoL2FybS9tYWNoLXN0aS9wbGF0c21wLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXN0aS9w
bGF0c21wLmMgYi9hcmNoL2FybS9tYWNoLXN0aS9wbGF0c21wLmMNCj4gaW5kZXggMjMxZjE5ZS4u
ODlhZTc2ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1zdGkvcGxhdHNtcC5jDQo+ICsr
KyBiL2FyY2gvYXJtL21hY2gtc3RpL3BsYXRzbXAuYw0KPiBAQCAtMTA5LDYgKzEwOSw3IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBzdGlfc21wX3ByZXBhcmVfY3B1cyh1bnNpZ25lZCBpbnQgbWF4X2Nw
dXMpDQo+ICAgDQo+ICAgCWlmIChucCkgew0KPiAgIAkJc2N1X2Jhc2UgPSBvZl9pb21hcChucCwg
MCk7DQo+ICsJCVdBUk5fT04oIXNjdV9iYXNlKTsNCj4gICAJCXNjdV9lbmFibGUoc2N1X2Jhc2Up
Ow0KPiAgIAkJb2Zfbm9kZV9wdXQobnApOw0KPiAgIAl9DQo+IA0KDQpJIHNob3VsZCBwcmVmZXIg
dG8gZXhpdCB3aXRoIGFuIGVycm9yIHRvIGF2b2lkIHVucHJlZGljdGFibGUgYmVoYXZpb3IsDQpz
b21ldGhpbmcgbGlrZSB0aGlzIGlzIGJldHRlciA6DQoNCnNjdV9iYXNlID0gb2ZfaW9tYXAobnAs
IDApOw0Kb2Zfbm9kZV9wdXQobnApOw0KaWYgKCFzY3VfYmFzZSkgew0KCXByX2VycigiTm8gU0NV
IHJlbWFwXG4iKTsNCglyZXR1cm47DQp9DQoNCnNjdV9lbmFibGUoc2N1X2Jhc2UpOw0KDQoNClRo
YW5rcw==
