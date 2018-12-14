Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96671C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E627C206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbeLNOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:37:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42450 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbeLNOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:37:20 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBEEZvon001961;
        Fri, 14 Dec 2018 15:36:54 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p85qkm0kw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Dec 2018 15:36:54 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E2853A;
        Fri, 14 Dec 2018 14:36:53 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D2FC5121;
        Fri, 14 Dec 2018 14:36:53 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec
 2018 15:36:52 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 14 Dec 2018 15:36:52 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Thread-Topic: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Thread-Index: AQHUiJLeeq7QfrCAGEO3Ka1UbW9pkA==
Date:   Fri, 14 Dec 2018 14:36:52 +0000
Message-ID: <5C13C004.9060504@st.com>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181214124701.GZ4497@dell>
In-Reply-To: <20181214124701.GZ4497@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6BF6915D0936E40BD5E128ADF17C378@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGVlLA0KDQpMZSAxMi8xNC8yMDE4IDAxOjQ3IFBNLCBMZWUgSm9uZXMgYSDDqWNyaXQg
Og0KPiBjaGFuZ2VzIGluIHY3Og0KPiAqIHJlYmFzZSBvbiByZWd1bC9mb3ItbmV4dA0KPg0KPiAg
ICBkdC1iaW5kaW5nczogbWZkOiBkb2N1bWVudCBzdHBtaWMxDQo+ICAgIG1mZDogc3RwbWljMTog
YWRkIHN0cG1pYzEgZHJpdmVyDQo+ICAgIGR0LWJpbmRpbmdzOiBpbnB1dDogZG9jdW1lbnQgc3Rw
bWljMSBwbWljIG9ua2V5DQo+ICAgIGlucHV0OiBzdHBtaWMxOiBhZGQgc3RwbWljMSBvbmtleSBk
cml2ZXINCj4gICAgZHQtYmluZGluZ3M6IHdhdGNoZG9nOiBkb2N1bWVudCBzdHBtaWMxIHBtaWMg
d2F0Y2hkb2cNCj4gICAgd2F0Y2hkb2c6IHN0cG1pYzE6IGFkZCBzdHBtaWMxIHdhdGNoZG9nIGRy
aXZlcg0KPiAgICByZWd1bGF0b3I6IHN0cG1pYzE6IGZpeCByZWd1bGF0b3JfbG9jayB1c2FnZQ0K
PiBDb3VsZCB5b3UgcGxlYXNlIHJlbW92ZSBhbnkgcGF0Y2hlcyB3aGljaCBoYXZlIGJlZW4gYXBw
bGllZCBhbmQNCj4gW1JFU0VORF0/DQpET05FLCBJIGhhdmUgcmVzZW50IGEgVjggd2l0aG91dCAg
dGhlIHJlZ3VsYXRvciBwYXRjaC4NCg0KPiBBbHNvLCBpcyBEbWl0cnkgcGxhbm5pbmcgb24gQWNr
aW5nOg0KPg0KPiAgICBkdC1iaW5kaW5nczogaW5wdXQ6IGRvY3VtZW50IHN0cG1pYzEgcG1pYyBv
bmtleQ0KPg0KPiAuLi4gb3IgaXMgUm9iJ3MgQWNrIGVub3VnaD8NCj4NCg0KDQp0aGFuayB5b3Us
DQpwYXNjYWwNCg==
