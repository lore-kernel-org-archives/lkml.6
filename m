Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998FC2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438373AbfBNKj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:39:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53061 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389903AbfBNKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:39:54 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EAbD0a007461;
        Thu, 14 Feb 2019 11:39:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qn0jwsy2c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:39:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B69333A;
        Thu, 14 Feb 2019 10:39:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7205F4EAF;
        Thu, 14 Feb 2019 10:39:30 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 11:39:30 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 14 Feb 2019 11:39:30 +0100
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
Thread-Index: AQHUwGP3BFaM6L9X70mSmjxl1QacOaXapgiAgAMsmOaAAT70gA==
Date:   Thu, 14 Feb 2019 10:39:29 +0000
Message-ID: <c62d0064-93b4-7839-7042-47a15c78b909@st.com>
References: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <18decbe3-5a7c-1b75-4c64-0b16fdd0efec@st.com>
 <HK0PR02MB3634F3A1A0C8BF4EEC5C3874B2660@HK0PR02MB3634.apcprd02.prod.outlook.com>
In-Reply-To: <HK0PR02MB3634F3A1A0C8BF4EEC5C3874B2660@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C67A01B8471844D9B1833C9434BB5A4@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IE9saXZpZXIgTW95c2FuIDxvbGl2aWVyLm1veXNhbkBzdC5jb20+DQoNCk9uIDIv
MTMvMTkgMzo0MSBQTSwgV2VuIFlhbmcgd3JvdGU6DQo+IEZyb206IE9saXZpZXIgTU9ZU0FOIDxv
bGl2aWVyLm1veXNhbkBzdC5jb20+DQo+IFNlbnQ6IDExIEZlYnJ1YXJ5IDIwMTkgMTU6MDkNCj4g
VG86IFdlbiBZYW5nOyBBcm5hdWQgUE9VTElRVUVOOyBMaWFtIEdpcmR3b29kOyBNYXJrIEJyb3du
OyBKYXJvc2xhdiBLeXNlbGE7IFRha2FzaGkgSXdhaTsgTWF4aW1lIENvcXVlbGluOyBBbGV4YW5k
cmUgVE9SR1VFDQo+IENjOiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxpbnV4LXN0bTMy
QHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBBU29DOiBzdG0zMjogc2FpOiBhZGQgbWlzc2luZyBwdXRfZGV2aWNlKCkNCj4gDQo+
PiBPbiAyLzkvMTkgMTE6NDEgQU0sIFdlbiBZYW5nIHdyb3RlOg0KPj4+IFRoZSBvZl9maW5kX2Rl
dmljZV9ieV9ub2RlKCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIHVuZGVybHlpbmcgZGV2aWNl
DQo+Pj4gc3RydWN0dXJlLCB3ZSBzaG91bGQgcmVsZWFzZSB0aGF0IHJlZmVyZW5jZS4NCj4+Pg0K
Pj4+IEZpeGVzOiA3ZGQwZDgzNTU4MmYgKCJBU29DOiBzdG0zMjogc2FpOiBzaW1wbGlmeSBzeW5j
IG1vZGVzIG1hbmFnZW1lbnQiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IFdlbiBZYW5nIDx5ZWxsb3dy
aXZlcjIwMTBAaG90bWFpbC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgc291bmQvc29jL3N0bS9zdG0z
Ml9zYWkuYyB8IDExICsrKysrKysrLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
c3RtL3N0bTMyX3NhaS5jIGIvc291bmQvc29jL3N0bS9zdG0zMl9zYWkuYw0KPj4+IGluZGV4IGJj
YjM1Y2EuLjE0Yzk1OTEgMTAwNjQ0DQo+Pj4gLS0tIGEvc291bmQvc29jL3N0bS9zdG0zMl9zYWku
Yw0KPj4+ICsrKyBiL3NvdW5kL3NvYy9zdG0vc3RtMzJfc2FpLmMNCj4+PiBAQCAtMTEyLDE2ICsx
MTIsMjEgQEAgc3RhdGljIGludCBzdG0zMl9zYWlfc2V0X3N5bmMoc3RydWN0IHN0bTMyX3NhaV9k
YXRhICpzYWlfY2xpZW50LA0KPj4NCj4+IGdvdG8gZXJyb3IgYWxzbyBpbiBwcmV2aW91cyB0ZXN0
DQo+PiAgICAgICAgaWYgKCFwZGV2KSB7DQo+PiAgICAgICAgICAgICAgICAuLi4NCj4+ICAgICAg
ICAgICAgICAgIHJldCA9IC1FTk9ERVY7DQo+PiAgICAgICAgICAgICAgICAgZ290byBlcnJvcjsN
Cj4+ICAgICAgICAgfQ0KPj4NCj4+PiAgICAgICAgaWYgKCFzYWlfcHJvdmlkZXIpIHsNCj4+PiAg
ICAgICAgICAgICAgICBkZXZfZXJyKCZzYWlfY2xpZW50LT5wZGV2LT5kZXYsDQo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAiU0FJIHN5bmMgcHJvdmlkZXIgZGF0YSBub3QgZm91bmRcbiIpOw0K
Pj4+IC0gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKyAgICAgICAgICAgICByZXQg
PSAtRUlOVkFMOw0KPj4+ICsgICAgICAgICAgICAgZ290byBvdXRfcHV0X2RldjsNCj4+PiAgICAg
ICAgfQ0KPj4+DQo+Pj4gICAgICAgIC8qIENvbmZpZ3VyZSBzeW5jIGNsaWVudCAqLw0KPj4+ICAg
ICAgICByZXQgPSBzdG0zMl9zYWlfc3luY19jb25mX2NsaWVudChzYWlfY2xpZW50LCBzeW5jaSk7
DQo+Pj4gICAgICAgIGlmIChyZXQgPCAwKQ0KPj4+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4+PiArICAgICAgICAgICAgIGdvdG8gb3V0X3B1dF9kZXY7DQo+Pj4NCj4+PiAgICAgICAgLyog
Q29uZmlndXJlIHN5bmMgcHJvdmlkZXIgKi8NCj4+PiAtICAgICByZXR1cm4gc3RtMzJfc2FpX3N5
bmNfY29uZl9wcm92aWRlcihzYWlfcHJvdmlkZXIsIHN5bmNvKTsNCj4+PiArICAgICByZXQgPSBz
dG0zMl9zYWlfc3luY19jb25mX3Byb3ZpZGVyKHNhaV9wcm92aWRlciwgc3luY28pOw0KPj4+ICsN
Cj4+PiArb3V0X3B1dF9kZXY6DQo+Pj4gKyAgICAgcHV0X2RldmljZSgmcGRldi0+ZGV2KTsNCj4+
PiArICAgICByZXR1cm4gcmV0Ow0KPj4NCj4+IEhlcmUgSSBwcm9wb3NlOg0KPj4gZXJyb3I6DQo+
PiAgICAgICAgIG9mX25vZGVfcHV0KG5wX3Byb3ZpZGVyKTsNCj4+ICAgICAgICAgcmV0dXJuIHJl
dDsNCj4+DQo+Pj4gICAgfQ0KPj4+DQo+Pj4gICAgc3RhdGljIGludCBzdG0zMl9zYWlfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+Pg0KPiANCj4+IFRoYW5rcyBmb3IgeW91
ciBwYXRjaC4gUGxlYXNlLCBzZWUgbXkgY29tbWVudHMgYWJvdmUuDQo+IA0KPiBUaGFua3MgZm9y
IHlvdXIgY29tbWVudHMsIGluIHRoaXMgcGF0Y2ggd2Ugb25seSBmaXggdGhlIHByb2JsZW0gb2Yg
bWlzc2luZyBwdXRfZGV2aWNlKCkuDQo+IFRoZSBwcm9ibGVtIG9mIG1pc3Npbmcgb2Zfbm9kZV9w
dXQoKSBpcyBhIGJpdCBtb3JlIGNvbXBsaWNhdGVkOg0KPiBGb3IgdGhlIHZhcmlhYmxlIG5wX3By
b3ZpZGVyKG5wX3N5bmNfcHJvdmlkZXIpOg0KPiAxLCBpdCBpcyBvYnRhaW5lZCBieSBvZl9nZXRf
cGFyZW50KCksIGJ1dCBpdCBpcyBub3QgcmVsZWFzZWQ7DQo+IDIsIGVycm9yIGNvZGUgbm90IG9i
dGFpbmVkIHdoZW4gY2FsbGluZyBzYWktPnBkYXRhLT5zZXRfc3luYygpDQo+IA0KDQpJIGFncmVl
LCByZWxlYXNlIG9mIG5wX3N5bmNfcHJvdmlkZXIgbm9kZSBpcyBtaXNzaW5nLCBhcyB3ZWxsIGFz
DQpyZXR1cm5lZCBlcnJvciBvbiBzZXRfc3luYy4NClNvIHllcywgdGhpcyByZXF1aXJlcyBhIGRl
ZGljYXRlZCBwYXRjaC4NClRoYW5rcw0KDQpSZWdhcmRzDQpPbGl2aWVyDQoNCj4gV2Ugd2lsbCBz
dWJtaXQgYW5vdGhlciBwYXRjaCB0byBmaXggdGhlIGZhaWx1cmUgb2YgbnBfc3luY19wcm92aWRl
cg0KPiBUaGFuayB5b3UuDQo+ID4gUmVnYXJkcw0KPiBXZW4NCj4gDQo+IA==
