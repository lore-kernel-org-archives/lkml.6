Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB2BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C2A20868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C2A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbeKMTNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:13:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12058 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730986AbeKMTNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:13:55 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAD9E3LM007102;
        Tue, 13 Nov 2018 10:16:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nnnp28aw3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 13 Nov 2018 10:16:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 03CF13D;
        Tue, 13 Nov 2018 09:16:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC9762626;
        Tue, 13 Nov 2018 09:16:16 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 13 Nov
 2018 10:16:16 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Tue, 13 Nov 2018 10:16:16 +0100
From:   Bich HEMON <bich.hemon@st.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH] ARM: stm32: debug: add low-level debug support
Thread-Topic: [PATCH] ARM: stm32: debug: add low-level debug support
Thread-Index: AQHTBvhu7ZuVgRQin0SIqpXfFjas8qVPSqoAgAD5r4A=
Date:   Tue, 13 Nov 2018 09:16:16 +0000
Message-ID: <f244c67b-de86-b0e7-7283-7b27f9591cf9@st.com>
References: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
 <1501174209-27550-2-git-send-email-bich.hemon@st.com>
 <20181112182236.s7cs6dol4dmxkp7u@localhost>
In-Reply-To: <20181112182236.s7cs6dol4dmxkp7u@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <19F57A189CB64146BDC81474E6B41D83@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8xMi8xOCA3OjIyIFBNLCBPbG9mIEpvaGFuc3NvbiB3cm90ZToNCj4gT24gVGh1LCBK
dWwgMjcsIDIwMTcgYXQgMDQ6NTA6MjBQTSArMDAwMCwgQmljaCBIRU1PTiB3cm90ZToNCj4+IEZy
b206IEdlcmFsZCBCYWV6YSA8Z2VyYWxkLmJhZXphQHN0LmNvbT4NCj4+DQo+PiBUaGlzIGFkZHMg
bG93LWxldmVsIGRlYnVnIHN1cHBvcnQgb24gVVNBUlQxIGZvciBTVE0zMkY0DQo+PiBhbmQgU1RN
MzJGNy4NCj4+IENvbXBpbGVkIHZpYSAnQ09ORklHX0RFQlVHX0xMJyBhbmQgJ0NPTkZJR19FQVJM
WV9QUklOVEsnLg0KPj4gRW5hYmxlZCB2aWEgJ2Vhcmx5cHJpbnRrJyBpbiBib290YXJncy4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBHZXJhbGQgQmFlemEgPGdlcmFsZC5iYWV6YUBzdC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBCaWNoIEhlbW9uIDxiaWNoLmhlbW9uQHN0LmNvbT4NCj4gDQo+IEhp
LA0KPiANCj4gVGhpcyBoYWQgZmFsbGVuIGJldHdlZW4gdGhlIGNoYWlycyBpdCBzZWVtcy4gSSBo
YXZlIGFwcGxpZWQgaXQgdG8gYXJtLXNvYw0KPiBuZXh0L3NvYyBub3csIGZvciA0LjIxIG1lcmdl
IHdpbmRvdy4NCj4gDQo+IEl0IGVuZGVkIHVwIGJlaW5nIHBhdGNoZWQgdXAgbWFudWFsbHkgdG8g
Y29uc29saWRhdGUgdGhlIHZlcnNpb24gaW4NCj4gUnVzc2VsbCdzIHBhdGNoIHRyYWNrZXIgd2l0
aCB0aGlzIHBvc3RlZCB2ZXJzaW9uLCBhbmQgSSB0d2Vha2VkIHdoaXRlc3BhY2UNCj4gYSBiaXQu
IExldCBtZSBrbm93IGlmIEkgbWlzc2VkIHNvbWV0aGluZy4NCj4gDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiAtT2xvZg0KPiANCg0KSGkgT2xvZiwNCg0KUGxlYXNlIG5vdGUgdGhhdCB0aGlzIHBhdGNo
IGhhcyB0byBiZSBhYmFuZG9uZWQgYXMgTHVkb3ZpYyBCQVJSRSBwdXNoZWQgDQphIG5ldyB2ZXJz
aW9uIG9mIHRoaXMgY2hhbmdlOg0KaHR0cHM6Ly9wYXRjaHdvcmsuY29kZWF1cm9yYS5vcmcvcGF0
Y2gvNDAwNTYzLw0KDQpZb3UgY2FuIGZpbmQgaXQgaW4gUnVzc2VsbCdzIHRyYWNrZXIgaGVyZToN
Cmh0dHA6Ly93d3cuYXJtLmxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy92aWV3cGF0Y2gu
cGhwP2lkPTg4MDMvMQ0KDQpCZXN0IHJlZ2FyZHMsDQoNCkJpY2g=
