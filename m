Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4BAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E069269FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E069269FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964813AbeFZLro (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:47:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23362 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934543AbeFZLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:47:42 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5QBhvsL003354;
        Tue, 26 Jun 2018 13:47:14 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jummdg2ru-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 13:47:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D40E3D;
        Tue, 26 Jun 2018 11:47:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44C512893;
        Tue, 26 Jun 2018 11:47:13 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 13:47:12 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Tue, 26 Jun 2018 13:47:12 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ARM: multi_v7_defconfig: enable STM32 SPI
Thread-Topic: [PATCH 3/3] ARM: multi_v7_defconfig: enable STM32 SPI
Thread-Index: AQHT7eptOwDllYtLF0+of4VdkPk8oqRyVnEAgAAzCgA=
Date:   Tue, 26 Jun 2018 11:47:12 +0000
Message-ID: <120d8997-3184-bfed-26b7-e0ac7d995b74@st.com>
References: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
 <1526566904-24514-4-git-send-email-amelie.delaunay@st.com>
 <e3bd3097-fbde-b790-e2b3-d78fb34b849d@st.com>
In-Reply-To: <e3bd3097-fbde-b790-e2b3-d78fb34b849d@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <55F46414EAD27E4693744497095E9276@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleA0KDQpPbiAwNi8yNi8yMDE4IDEwOjQ0IEFNLCBBbGV4YW5kcmUgVG9yZ3VlIHdyb3Rl
Og0KPiBIaSBBbcOpbGllDQo+IA0KPiBPbiAwNS8xNy8yMDE4IDA0OjIxIFBNLCBBbWVsaWUgRGVs
YXVuYXkgd3JvdGU6DQo+PiBFbmFibGUgdGhlIFNUTTMyIFNQSSBkcml2ZXIsIGltcGxlbWVudGVk
IG9uIFNUTTMyTVAxIFNvQy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbWVsaWUgRGVsYXVuYXkg
PGFtZWxpZS5kZWxhdW5heUBzdC5jb20+DQo+PiAtLS0NCj4+IMKgIGFyY2gvYXJtL2NvbmZpZ3Mv
bXVsdGlfdjdfZGVmY29uZmlnIHwgMSArDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZj
b25maWcgDQo+PiBiL2FyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnDQo+PiBpbmRl
eCA4OTE2N2NkLi5mOTkwMzM1IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vY29uZmlncy9tdWx0
aV92N19kZWZjb25maWcNCj4+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29u
ZmlnDQo+PiBAQCAtNDExLDYgKzQxMSw3IEBAIENPTkZJR19TUElfUzNDNjRYWD1tDQo+PiDCoCBD
T05GSUdfU1BJX1NIX01TSU9GPW0NCj4+IMKgIENPTkZJR19TUElfU0hfSFNQST15DQo+PiDCoCBD
T05GSUdfU1BJX1NJUkY9eQ0KPj4gK0NPTkZJR19TUElfU1RNMzI9eQ0KPj4gwqAgQ09ORklHX1NQ
SV9TVU40ST15DQo+PiDCoCBDT05GSUdfU1BJX1NVTjZJPXkNCj4+IMKgIENPTkZJR19TUElfVEVH
UkExMTQ9eQ0KPj4NCj4gDQo+IERyaXZlciB3aGljaCBhcmUgYXJlIG5vdCAidml0YWwiIHRvIGJv
b3QgU1RNMzIgcGxhdGZvcm0gc2hvdWxkIGJlIA0KPiBkZWZpbmVkIGFzIG1vZHVsZS4gSXQncyB0
aGUgY2FzZSBmb3IgdGhpcyBvbmUuIElzbid0ID8NCj4gDQoNCllvdSdyZSByaWdodC4gSSdsbCBz
ZW5kIHYyIHdpdGggQ09ORklHX1NQSV9TVE0zMj1tIEFTQVAuIFNob3VsZCBJIHJlc2VuZCANCnRo
ZSB3aG9sZSBwYXRjaHNldCAod2l0aCBEVCksIG9yIGp1c3QgdGhpcyBwYXRjaCBhbmQgeW91IHRh
a2UgdGhlIERUIA0KcGF0Y2hlcyBhcyB0aGV5IGFyZSA/DQoNClJlZ2FyZHMsDQpBbWVsaWU=
