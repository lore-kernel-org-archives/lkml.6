Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C959DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6C1207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfBFIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:40:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13723 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbfBFIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:40:08 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x168cVXm016576;
        Wed, 6 Feb 2019 09:39:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qd1v0b643-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Feb 2019 09:39:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B0B2F34;
        Wed,  6 Feb 2019 08:39:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 369401637;
        Wed,  6 Feb 2019 08:39:47 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 09:39:46 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 6 Feb 2019 09:39:46 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Yizhuo <yzhai003@ucr.edu>
CC:     "csong@cs.ucr.edu" <csong@cs.ucr.edu>,
        "zhiyunq@cs.ucr.edu" <zhiyunq@cs.ucr.edu>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: Variable "val" in function miphy_osc_is_ready()
 could be uninitialized
Thread-Topic: [PATCH] phy: Variable "val" in function miphy_osc_is_ready()
 could be uninitialized
Thread-Index: AQHUvcxdxo2TQI+a9kuNUuZktxriraXSYqmA
Date:   Wed, 6 Feb 2019 08:39:46 +0000
Message-ID: <a5bf0f11-3428-92de-e37a-96cce1952b36@st.com>
References: <20190206033036.22729-1-yzhai003@ucr.edu>
In-Reply-To: <20190206033036.22729-1-yzhai003@ucr.edu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AC3181D1CAB18499B9C4EC0B6633370@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWWl6aHVvDQoNCk9uIDIvNi8xOSA0OjMwIEFNLCBZaXpodW8gd3JvdGU6DQo+IEluIGZ1bmN0
aW9uIG1pcGh5X29zY19pc19yZWFkeSgpLCBsb2NhbCB2YXJpYWJsZSAidmFsIg0KPiBjb3VsZCBi
ZSB1bmluaXRhbGl6ZWQuIGlmIGZ1bmN0aW9uIHJlZ21hcF9yZWFkKCkgcmV0dXJucw0KPiAtRUlO
VkFMLiBIb3dldmVyLCB0aGlzIHZhbHVlIGlzIHVzZWQgaW4gaWYgc3RhdGVtZW50Lg0KPiBUaGlz
IGlzIHBvdGVudGlhbGx5IHVuc2FmZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlpemh1byA8eXpo
YWkwMDNAdWNyLmVkdT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BoeS9zdC9waHktbWlwaHkyOGxwLmMg
fCA3ICsrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvc3QvcGh5LW1pcGh5MjhscC5j
IGIvZHJpdmVycy9waHkvc3QvcGh5LW1pcGh5MjhscC5jDQo+IGluZGV4IDIxM2UyZTE1MzM5Yy4u
NDBjN2MwYTYxMWEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9zdC9waHktbWlwaHkyOGxw
LmMNCj4gKysrIGIvZHJpdmVycy9waHkvc3QvcGh5LW1pcGh5MjhscC5jDQo+IEBAIC04MzUsNyAr
ODM1LDggQEAgc3RhdGljIGludCBtaXBoeV9vc2NfaXNfcmVhZHkoc3RydWN0IG1pcGh5MjhscF9w
aHkgKm1pcGh5X3BoeSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbWlwaHkyOGxwX2RldiAqbWlwaHlfZGV2
ID0gbWlwaHlfcGh5LT5waHlkZXY7DQo+ICAJdW5zaWduZWQgbG9uZyBmaW5pc2ggPSBqaWZmaWVz
ICsgNSAqIEhaOw0KPiAtCXUzMiB2YWw7DQo+ICsJdTMyIHZhbCA9IDA7DQo+ICsJaW50IHJldDsN
Cj4gIA0KPiAgCWlmICghbWlwaHlfcGh5LT5vc2NfcmR5KQ0KPiAgCQlyZXR1cm4gMDsNCj4gQEAg
LTg0NCw4ICs4NDUsMTAgQEAgc3RhdGljIGludCBtaXBoeV9vc2NfaXNfcmVhZHkoc3RydWN0IG1p
cGh5MjhscF9waHkgKm1pcGh5X3BoeSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4gIAlk
byB7DQo+IC0JCXJlZ21hcF9yZWFkKG1pcGh5X2Rldi0+cmVnbWFwLA0KPiArCQlyZXQgPSByZWdt
YXBfcmVhZChtaXBoeV9kZXYtPnJlZ21hcCwNCj4gIAkJCQltaXBoeV9waHktPnN5c2NmZ19yZWdb
U1lTQ0ZHX1NUQVRVU10sICZ2YWwpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJcmV0dXJuIHJldDsN
Cj4gIA0KPiAgCQlpZiAoKHZhbCAmIE1JUEhZX09TQ19SRFkpICE9IE1JUEhZX09TQ19SRFkpDQo+
ICAJCQljcHVfcmVsYXgoKTsNCj4gDQoNClJldmlld2VkLWJ5OiBQYXRyaWNlIENob3RhcmQgPHBh
dHJpY2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw==
