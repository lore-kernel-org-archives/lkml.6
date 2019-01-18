Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E73C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953652086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfARJ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:56:54 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38763 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfARJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:56:54 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0I9pXwP007406;
        Fri, 18 Jan 2019 10:56:48 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pybywxsvy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 18 Jan 2019 10:56:48 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B868434;
        Fri, 18 Jan 2019 09:56:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 97FA42641;
        Fri, 18 Jan 2019 09:56:47 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 18 Jan
 2019 10:56:46 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 18 Jan 2019 10:56:47 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [RFC 0/7] Introduce bus domains controller framework
Thread-Topic: [RFC 0/7] Introduce bus domains controller framework
Thread-Index: AQHUrBdlFvta6/yGrkGsEdo72v7OKKWzsz2AgAEMDwA=
Date:   Fri, 18 Jan 2019 09:56:47 +0000
Message-ID: <d62c54db-7699-69fa-5928-1c55313da1f0@st.com>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
 <CAL_JsqKwj46CSB8vRbYyU6kRMTXqa2Q6O=vQkJwTwC_gHjOf-g@mail.gmail.com>
In-Reply-To: <CAL_JsqKwj46CSB8vRbYyU6kRMTXqa2Q6O=vQkJwTwC_gHjOf-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFBC8C56BB83B14D9B31238CF1783297@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzE3LzE5IDY6NTcgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBNb24sIEphbiAx
NCwgMjAxOSBhdCA4OjQyIEFNIEJlbmphbWluIEdhaWduYXJkDQo+IDxiZW5qYW1pbi5nYWlnbmFy
ZEBzdC5jb20+IHdyb3RlOg0KPj4gVGhlIGdvYWwgb2YgdGhpcyBmcmFtZXdvcmsgaXMgdG8gb2Zm
ZXIgYW4gaW50ZXJmYWNlIGZvciB0aGUNCj4+IGhhcmR3YXJlIGJsb2NrcyBjb250cm9sbGluZyBi
dXMgYWNjZXNzZXMgcmlnaHRzLg0KPj4NCj4+IEJ1cyBkb21haW5zIGNvbnRyb2xsZXJzIGFyZSB0
eXBpY2FsbHkgdXNlZCB0byBjb250cm9sIGlmIGENCj4+IGhhcmR3YXJlIGJsb2NrIGNhbiBwZXJm
b3JtIHJlYWQgb3Igd3JpdGUgb3BlcmF0aW9ucyBvbiBidXMuDQo+IExvdHMgb2YgdGhpbmdzIGFy
ZSBkb21haW5zLiBQb3dlciBkb21haW5zLCBjbG9jayBkb21haW5zLCBldGMuIEJ1dA0KPiBuYW1p
bmcgaXMgaGFyZC4NCg0KSSB1c2UgJ2RvbWFpbnMnIGJlY2F1c2UgaXQgcmVncm91cCBoYXJkd2Fy
ZSBzaGFyaW5nIHRoZSBzYW1lIGFjY2VzcyByaWdodHMuDQpJdCBpcyBtYXliZSBub3QgdGhlIGJl
c3Qgd29yZC4NCg0KPg0KPiBXZSBub3cgaGF2ZSB0aGUgaW50ZXItY29ubmVjdCBiaW5kaW5nIHdo
aWNoIEFUTSBvbmx5IGRlYWxzIHdpdGgNCj4gYmFuZHdpZHRoLiBBbnkgcmVhc29uIHdlIGNhbid0
IGFkZCBhY2Nlc3MgY29udHJvbHMgdG8gdGhhdD8NCg0KQmVjYXVzZSB0aGUgdGFyZ2V0ZWQgaGFy
ZHdhcmUgYmxvY2sgaXNuJ3QgdGhlIGludGVyLWNvbm5lY3QgYnV0IHNvbWV0aGluZw0KdGhhdCBp
cyBhY3RpbmcgYXMgYSBmaXJld2FsbCBvbiB0aGUgYnVzIHRvIGNvbnRyb2wgdGhlIGFjY2Vzc2Vz
IHJpZ2h0cyBvbg0KaGFyZHdhcmUgYmxvY2tzLg0KJ2J1cyBmaXJld2FsbCcgY291bGQgaGF2ZSBi
ZWVuIGEgbmFtZSBmb3IgdGhpcyBmcmFtZXdvcmsgYnV0LCBmb3IgbWUsIGl0DQpzb3VuZCBsaWtl
IHNvbWV0aGluZyByZWxhdGVkIHRvIG5ldHdvcmtpbmcgYW5kIHRoYXQgaXMgbm90IHRoZSBjYXNl
Li4uDQpJIGNvdWxkIGdvIGluICdmaXJld2FsbCcgZGlyZWN0aW9uOiBkcml2ZXIgd2lsbCBiZWNv
bWUgJ2J1cyBmaXJld2FsbCBjb250cm9sbGVyJw0KYW5kIGFwcGx5ICdmaXJld2FsbCBjb25maWd1
cmF0aW9ucycgdG8gZ3JhbnQvcmV2b2tlIGFjY2Vzc2VzIHJpZ2h0cy4NCkRvZXMgdGhhdCBzb3Vu
ZCBiZXR0ZXIgZm9yIHlvdSA/DQoNCj4NCj4+IFNtYXJ0ZXIgZG9tYWlucyBjb250cm9sbGVycyBj
b3VsZCBiZSBhYmxlIHRvIGRlZmluZSBhY2Nlc3Nlcw0KPj4gcmlnaHRzIHBlciBoYXJkd2FyZSBi
bG9ja3MgdG8gY29udHJvbCB3aGVyZSB0aGV5IGNhbiByZWFkDQo+PiBvciB3cml0ZS4NCj4+DQo+
PiBEb21haW5zIGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbnMgYXJlIHByb3ZpZGVkIGluIGRldmlj
ZSBub2RlLA0KPj4gcGFyc2VkIGJ5IHRoZSBmcmFtZXdvcmsgYW5kIHNlbmQgdG8gdGhlIGRyaXZl
ciB0byBhcHBseSB0aGVtLg0KPj4gRWFjaCBjb250cm9sbGVyIG1heSBuZWVkIGRpZmZlcmVudCBu
dW1iZXIgYW5kIHR5cGUgb2YgaW5wdXRzDQo+PiB0byBjb25maWd1cmUgYSBkb21haW4gc28gZGV2
aWNlLXRyZWUgcHJvcGVydGllcyBzaXplIGhhdmUgdG8NCj4+IGJlIGRlZmluZSBieSB1c2luZyAi
I2RvbWFpbmN0cmwtY2VsbHMiLg0KPj4gRG9tYWlucyBjb25maWd1cmF0aW9ucyBwcm9wZXJ0aWVz
IGhhdmUgdG8gYmUgbmFtZWQgImRvbWFpbnNjdHJsLVgiDQo+PiBvbiBkZXZpY2Ugbm9kZS4NCj4+
ICJkb21haW5zY3RybC1uYW1lcyIga2V5d29yZCBjYW4gYWxzbyBiZSB1c2VkIHRvIGdpdmUgYSBu
YW1lIHRvDQo+PiBhIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24uDQo+Pg0KPj4gQW4gZXhhbXBsZSBv
ZiBidXMgZG9tYWlucyBjb250cm9sbGVyIGlzIFNUTTMyIEVUWlBDIGhhcmR3YXJlIGJsb2NrDQo+
PiB3aGljaCBnb3QgMyBkb21haW5zOg0KPj4gLSBzZWN1cmU6IGhhcmR3YXJlIGJsb2NrcyBhcmUg
b25seSBhY2Nlc3NpYmxlIGJ5IHNvZnR3YXJlIHJ1bm5pbmcgb24gdHJ1c3QNCj4+ICAgIHpvbmUu
DQo+PiAtIG5vbi1zZWN1cmU6IGhhcmR3YXJlIGJsb2NrcyBhcmUgYWNjZXNzaWJsZSBieSBub24t
c2VjdXJlIHNvZnR3YXJlIChpLmUuDQo+PiAgICBsaW51eCBrZXJuZWwpLg0KPj4gLSBjb3Byb2Nl
c3NvcjogaGFyZHdhcmUgYmxvY2tzIGFyZSBvbmx5IGFjY2Vzc2libGUgYnkgdGhlIGNvcnBvY2Vz
c29yLg0KPiBXZSBhbHJlYWR5IGhhdmUgYSB3YXkgdG8gYXNzaWduIHNlY3VyZSB2cy4gbm9uLXNl
Y3VyZSB3aXRoICdzdGF0dXMnLg0KPiBJZ25vcmluZyBjby1wcm9jZXNzb3JzIGZvciBhIG1pbnV0
ZSwgd2h5IGRvZXMgdGhhdCBub3Qgd29yayBmb3IgeW91Pw0KDQpJIGFpbSB0byBiZSBhYmxlIHRv
IGR5bmFtaWNhbGx5IGNoYW5nZSB0aGUgY29uZmlndXJhdGlvbiAobGlrZSBmb3IgcGluY3RybCkN
CnNvIHN0YXR1cyBpcyBub3QgZW5vdWdoLiBJdCBpcyB0cnVlIHRoYXQgc3RtMzIgZXR6cGMgaXMg
bGltaXRlZCB0byBjb250cm9sDQp0aGUgc3BsaXQgYmV0d2VlbiBtYWluIGFuZCByZW1vdGUgcHJv
Y2Vzc29ycyBidXQgb3RoZXIgY29udHJvbGxlcnMgY291bGQgaGF2ZQ0KYW5vdGhlciBncmFudWxh
cml0eS4NCg0KPg0KPiBDby1wcm9jZXNzb3JzIGFyZSBzbyB2YXJpZWQgaW4gdGVybXMgb2YgY2Fw
YWJpbGl0aWVzIGFuZCB2aWV3IG9mIHRoZQ0KPiBzeXN0ZW0sIEknbSBub3Qgc3VyZSB3ZSBjYW4g
ZGVmaW5lIHNvbWV0aGluZyBnZW5lcmljLg0KDQpJdCBpc24ndCBub3QgYWJvdXQgZGVmaW5lIGNv
LXByZWNlc3NvcnMgY2FwYWJpbGl0aWVzIGJ1dCBhYm91dCBkZWZpbmUNCmEgbmV3IEFQSSBmb3Ig
aGFyZHdhcmUgYmxvY2tzIGNvbnRyb2xsaW5nIGFjY2Vzc2VzIG9uIHRoZSBidXMuDQoNCj4NCj4+
IFVwIHRvIDk0IGhhcmR3YXJlIGJsb2NrcyBvZiB0aGUgc29jIGNvdWxkIGJlIG1hbmFnZWQgYnkg
RVRaUEMgYW5kDQo+PiBhc3NpZ25lZCB0byBvbmUgb2YgdGhlIHRocmVlIGRvbWFpbnMuDQo+Pg0K
Pj4gSXQgaXMgYW4gUkZDLCBjb21tZW50cyBhcmUgd2VsY29tZSB0byBoZWxwIHRvIGNyZWF0ZSB0
aGlzIGZyYW1ld29yaywgdGhhbmtzLg0KPiBGaW5hbGx5LCBmb3IgYSBuZXcsIGNvbW1vbiBiaW5k
aW5nLCBJJ2QgbGlrZSB0byBzZWUgbW9yZSB0aGFuIG9uZQ0KPiBwbGF0Zm9ybSB1c2luZyBpdCAo
b3IgYXQgbGVhc3QgYW4gaW50ZW50IHRvIHVzZSBpdCkuDQoNCkkga3dvbiBhdCBsZWFzdCB0d28g
b3RoZXIgaGFyZHdhcmUgYmxvY2sgd2hvIGNhbiB0YWtlIGJlbmVmaXRzIG9mIHRoaXM6DQotIEFS
TSBUQ1ogNDAwOiBodHRwOi8vaW5mb2NlbnRlci5hcm0uY29tL2hlbHAvaW5kZXguanNwP3RvcGlj
PS9jb20uYXJtLmRvYy5kZGkwNTA0Yy9pbmRleC5odG1sDQogICB3aGljaCBpcyBhYmxlIHRvIG1h
bmFnZSB1cCB0byA4IHJlZ29pbnMgaW4gYWRkcmVzcyBzcGFjZS4NCi0gSU1YIFJlc3NvdXJjZSBE
b21haW4gQ29udHJvbGxlciAoUkRDKTogc3VwcG9ydHMgZm91ciBkb21haW5zIGFuZCB1cCB0byBl
aWdodCByZWdpb25zDQoNCkkgaG9wZSB0aGF0IG90aGVycyB3aWxsIHNob3cgdXAgd2hlbiByZWFk
aW5nIHRoaXMgdGhyZWFkLg0KDQpCZW5qYW1pbg0KDQoNCj4NCj4gUm9i
