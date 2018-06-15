Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EDAAEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDA0208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDA0208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965763AbeFOOwO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:52:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756127AbeFOOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:52:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5FEnCM8002709;
        Fri, 15 Jun 2018 16:50:56 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jjp8pw9ra-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 15 Jun 2018 16:50:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5CE531;
        Fri, 15 Jun 2018 14:50:54 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A87C2D35;
        Fri, 15 Jun 2018 14:50:54 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Jun
 2018 16:50:54 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 15 Jun 2018 16:50:54 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Vincent ABRIOU" <vincent.abriou@st.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1 1/7] drm: print plane state normalized zpos value
Thread-Topic: [PATCH v1 1/7] drm: print plane state normalized zpos value
Thread-Index: AQHT/NS6fJeyEYi8VUKDam19fTKSKKRhVVOA
Date:   Fri, 15 Jun 2018 14:50:54 +0000
Message-ID: <364658e2-8f98-dedd-0841-15b0d07479ad@st.com>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
 <20180605135407.20214-2-benjamin.gaignard@linaro.org>
In-Reply-To: <20180605135407.20214-2-benjamin.gaignard@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C00B26C9CEDD847AB45CB73EDC3A415@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNCg0KT24gMDYvMDUvMjAxOCAwMzo1NCBQTSwgQmVuamFtaW4gR2FpZ25h
cmQgd3JvdGU6DQo+IFdoZW4gZHVtcGluZyBwbGFuZSBzdGF0ZSBwcmludCBub3JtYWxpemVkIHpw
b3MgdmFsdWUgYXMgZG9uZSBmb3INCj4gdGhlIG90aGVyIHBsYW5lIHN0YXRlIGZpZWxkcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBs
aW5hcm8ub3JnPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pYy5jIHwgMSAr
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWlj
LmMNCj4gaW5kZXggMDdmZWY0Mjg2OWFhLi5jZDFkNjc3NjE3YzggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9h
dG9taWMuYw0KPiBAQCAtOTg4LDYgKzk4OCw3IEBAIHN0YXRpYyB2b2lkIGRybV9hdG9taWNfcGxh
bmVfcHJpbnRfc3RhdGUoc3RydWN0IGRybV9wcmludGVyICpwLA0KPiAgIAlkcm1fcHJpbnRmKHAs
ICJcdGNydGMtcG9zPSIgRFJNX1JFQ1RfRk1UICJcbiIsIERSTV9SRUNUX0FSRygmZGVzdCkpOw0K
PiAgIAlkcm1fcHJpbnRmKHAsICJcdHNyYy1wb3M9IiBEUk1fUkVDVF9GUF9GTVQgIlxuIiwgRFJN
X1JFQ1RfRlBfQVJHKCZzcmMpKTsNCj4gICAJZHJtX3ByaW50ZihwLCAiXHRyb3RhdGlvbj0leFxu
Iiwgc3RhdGUtPnJvdGF0aW9uKTsNCj4gKwlkcm1fcHJpbnRmKHAsICJcdG5vcm1hbGl6ZWQtenBv
cz0leFxuIiwgc3RhdGUtPm5vcm1hbGl6ZWRfenBvcyk7DQo+ICAgCWRybV9wcmludGYocCwgIlx0
Y29sb3ItZW5jb2Rpbmc9JXNcbiIsDQo+ICAgCQkgICBkcm1fZ2V0X2NvbG9yX2VuY29kaW5nX25h
bWUoc3RhdGUtPmNvbG9yX2VuY29kaW5nKSk7DQo+ICAgCWRybV9wcmludGYocCwgIlx0Y29sb3It
cmFuZ2U9JXNcbiIsDQo+IA0KDQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgQ29ybnUgPHBoaWxpcHBl
LmNvcm51QHN0LmNvbT4NCk1hbnkgdGhhbmtzDQpQaGlsaXBwZSA6LSk=
