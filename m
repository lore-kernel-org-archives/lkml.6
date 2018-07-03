Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65133C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228422075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228422075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeGCLCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:02:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62603 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752292AbeGCLCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:02:47 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w63B2283015428;
        Tue, 3 Jul 2018 13:02:39 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k03gx1ce2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 03 Jul 2018 13:02:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A10B538;
        Tue,  3 Jul 2018 11:02:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F2F22CF4;
        Tue,  3 Jul 2018 11:02:38 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Jul
 2018 13:02:38 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 3 Jul 2018 13:02:38 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: rework reset sequence
Thread-Topic: [PATCH] drm/stm: ltdc: rework reset sequence
Thread-Index: AQHUD5t82z/X2PnOW027W5VKoG9fvKR9OfaA
Date:   Tue, 3 Jul 2018 11:02:38 +0000
Message-ID: <ff27f873-3d9b-373e-344d-6cd186cf384f@st.com>
References: <1530271355-5608-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1530271355-5608-1-git-send-email-yannick.fertre@st.com>
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
Content-ID: <0EEF523B4047AC439A84F8ABFBFEB968@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWWFubmljaywNCg0KDQpPbiAwNi8yOS8yMDE4IDAxOjIyIFBNLCBZYW5uaWNrIEZlcnRyZSB3
cm90ZToNCj4gUmVzZXQgbXVzdCBiZSBwcm9wZXJseSBhc3NlcnQgYmVmb3JlIGRlYXNzZXJ0Lg0K
PiBUaGlzIGlzIGltcG9ydGFudCBpZiB0aGVyZSBpcyBhbiBlYXJseSBib290IHNwbGFzaCBzY3Jl
ZW4NCj4gYmVmb3JlIHRoZSBrZXJuZWwgc3RhcnQgdXAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZ
YW5uaWNrIEZlcnRyZSA8eWFubmljay5mZXJ0cmVAc3QuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJz
L2dwdS9kcm0vc3RtL2x0ZGMuYyB8IDUgKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3N0bS9sdGRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiBpbmRleCA5NmQy
MGMyLi44ZjQ2MDZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiBAQCAtMTEzMCw4ICsxMTMwLDEx
IEBAIGludCBsdGRjX2xvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYpDQo+ICAgCQl9DQo+ICAg
CX0NCj4gICANCj4gLQlpZiAoIUlTX0VSUihyc3RjKSkNCj4gKwlpZiAoIUlTX0VSUihyc3RjKSkg
ew0KPiArCQlyZXNldF9jb250cm9sX2Fzc2VydChyc3RjKTsNCj4gKwkJdXNsZWVwX3JhbmdlKDEw
LCAyMCk7DQo+ICAgCQlyZXNldF9jb250cm9sX2RlYXNzZXJ0KHJzdGMpOw0KPiArCX0NCg0KVGhh
bmsgeW91IGZvciB5b3VyIHBhdGNoLA0KDQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgQ29ybnUgPHBo
aWxpcHBlLmNvcm51QHN0LmNvbT4NClRlc3RlZC1ieTogUGhpbGlwcGUgQ29ybnUgPHBoaWxpcHBl
LmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0pDQoNCj4gICANCj4gICAJLyogRGlzYWJsZSBp
bnRlcnJ1cHRzICovDQo+ICAgCXJlZ19jbGVhcihsZGV2LT5yZWdzLCBMVERDX0lFUiwNCj4g
