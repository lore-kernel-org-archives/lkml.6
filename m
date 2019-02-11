Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D62C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D6B222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfBKPL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:11:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21439 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403970AbfBKPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:10:45 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BF1T0V016107;
        Mon, 11 Feb 2019 16:09:48 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qhurutqcc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Feb 2019 16:09:48 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 094DB3F;
        Mon, 11 Feb 2019 15:09:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4CB52BFE;
        Mon, 11 Feb 2019 15:09:46 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 Feb
 2019 16:09:46 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 11 Feb 2019 16:09:45 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Wen Yang <yellowriver2010@hotmail.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Topic: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Index: AQHUwGP3BFaM6L9X70mSmjxl1QacOaXapgiA
Date:   Mon, 11 Feb 2019 15:09:45 +0000
Message-ID: <18decbe3-5a7c-1b75-4c64-0b16fdd0efec@st.com>
References: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
In-Reply-To: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABCA28EC5FF04745816A6E3ADDD618BB@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VuLA0KDQpPbiAyLzkvMTkgMTE6NDEgQU0sIFdlbiBZYW5nIHdyb3RlOg0KPiBUaGUgb2Zf
ZmluZF9kZXZpY2VfYnlfbm9kZSgpIHRha2VzIGEgcmVmZXJlbmNlIHRvIHRoZSB1bmRlcmx5aW5n
IGRldmljZQ0KPiBzdHJ1Y3R1cmUsIHdlIHNob3VsZCByZWxlYXNlIHRoYXQgcmVmZXJlbmNlLg0K
PiANCj4gRml4ZXM6IDdkZDBkODM1NTgyZiAoIkFTb0M6IHN0bTMyOiBzYWk6IHNpbXBsaWZ5IHN5
bmMgbW9kZXMgbWFuYWdlbWVudCIpDQo+IFNpZ25lZC1vZmYtYnk6IFdlbiBZYW5nIDx5ZWxsb3dy
aXZlcjIwMTBAaG90bWFpbC5jb20+DQo+IC0tLQ0KPiAgIHNvdW5kL3NvYy9zdG0vc3RtMzJfc2Fp
LmMgfCAxMSArKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3N0bS9zdG0zMl9z
YWkuYyBiL3NvdW5kL3NvYy9zdG0vc3RtMzJfc2FpLmMNCj4gaW5kZXggYmNiMzVjYS4uMTRjOTU5
MSAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL3N0bS9zdG0zMl9zYWkuYw0KPiArKysgYi9zb3Vu
ZC9zb2Mvc3RtL3N0bTMyX3NhaS5jDQo+IEBAIC0xMTIsMTYgKzExMiwyMSBAQCBzdGF0aWMgaW50
IHN0bTMyX3NhaV9zZXRfc3luYyhzdHJ1Y3Qgc3RtMzJfc2FpX2RhdGEgKnNhaV9jbGllbnQsDQoN
CmdvdG8gZXJyb3IgYWxzbyBpbiBwcmV2aW91cyB0ZXN0DQoJaWYgKCFwZGV2KSB7DQoJCS4uLg0K
CQlyZXQgPSAtRU5PREVWOw0KCQlnb3RvIGVycm9yOw0KCX0NCg0KPiAgIAlpZiAoIXNhaV9wcm92
aWRlcikgew0KPiAgIAkJZGV2X2Vycigmc2FpX2NsaWVudC0+cGRldi0+ZGV2LA0KPiAgIAkJCSJT
QUkgc3luYyBwcm92aWRlciBkYXRhIG5vdCBmb3VuZFxuIik7DQo+IC0JCXJldHVybiAtRUlOVkFM
Ow0KPiArCQlyZXQgPSAtRUlOVkFMOw0KPiArCQlnb3RvIG91dF9wdXRfZGV2Ow0KPiAgIAl9DQo+
ICAgDQo+ICAgCS8qIENvbmZpZ3VyZSBzeW5jIGNsaWVudCAqLw0KPiAgIAlyZXQgPSBzdG0zMl9z
YWlfc3luY19jb25mX2NsaWVudChzYWlfY2xpZW50LCBzeW5jaSk7DQo+ICAgCWlmIChyZXQgPCAw
KQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiArCQlnb3RvIG91dF9wdXRfZGV2Ow0KPiAgIA0KPiAgIAkv
KiBDb25maWd1cmUgc3luYyBwcm92aWRlciAqLw0KPiAtCXJldHVybiBzdG0zMl9zYWlfc3luY19j
b25mX3Byb3ZpZGVyKHNhaV9wcm92aWRlciwgc3luY28pOw0KPiArCXJldCA9IHN0bTMyX3NhaV9z
eW5jX2NvbmZfcHJvdmlkZXIoc2FpX3Byb3ZpZGVyLCBzeW5jbyk7DQo+ICsNCj4gK291dF9wdXRf
ZGV2Og0KPiArCXB1dF9kZXZpY2UoJnBkZXYtPmRldik7DQo+ICsJcmV0dXJuIHJldDsNCg0KSGVy
ZSBJIHByb3Bvc2U6DQplcnJvcjoNCglvZl9ub2RlX3B1dChucF9wcm92aWRlcik7DQoJcmV0dXJu
IHJldDsNCg0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgaW50IHN0bTMyX3NhaV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiANCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLiBQ
bGVhc2UsIHNlZSBteSBjb21tZW50cyBhYm92ZS4NCg0KUmVnYXJkcw0KT2xpdmllcg0KDQoNCg==
