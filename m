Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11851C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF0420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeLJMi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:38:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25619 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726292AbeLJMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:38:26 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBACaWuk010223;
        Mon, 10 Dec 2018 13:37:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p83yd2qpn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 10 Dec 2018 13:37:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BD2D31;
        Mon, 10 Dec 2018 12:37:57 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag3node6.st.com [10.75.127.73])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12C762B9A;
        Mon, 10 Dec 2018 12:37:57 +0000 (GMT)
Received: from GPXDAG3NODE5.st.com (10.75.127.72) by GPXDAG3NODE6.st.com
 (10.75.127.73) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Dec
 2018 13:37:56 +0100
Received: from GPXDAG3NODE5.st.com ([fe80::d995:abbc:5285:10c]) by
 GPXDAG3NODE5.st.com ([fe80::d995:abbc:5285:10c%19]) with mapi id
 15.00.1347.000; Mon, 10 Dec 2018 13:37:56 +0100
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     "cezary.gapinski@gmail.com" <cezary.gapinski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/5] Add support for STM32F4 SPI
Thread-Topic: [PATCH 0/5] Add support for STM32F4 SPI
Thread-Index: AQHUj8azLFItfSiuXEO2Jd1SqFlrjaV32geA
Date:   Mon, 10 Dec 2018 12:37:56 +0000
Message-ID: <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC5027D79CC5B45A933F00D59740D08@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2V6YXJ5LA0KDQpPbiAxMi85LzE4IDI6NTMgUE0sIGNlemFyeS5nYXBpbnNraUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IENlemFyeSBHYXBpbnNraSA8Y2V6YXJ5LmdhcGluc2tpQGdtYWls
LmNvbT4NCj4gDQo+IFRoaXMgc2VyaWVzIG9mIHBhdGNoZXMgYWRkcyBzdXBwb3J0IGZvciBmaXJz
dCBnZW5lcmF0aW9uIG9mIFNQSSBpbnRlcmZhY2UNCj4gZm9yIFNUTTMyRjQgZmFtaWx5Lg0KPiAN
Cg0KRmlyc3Qgb2YgYWxsLCB0aGFua3MgZm9yIGFkZGluZyBTVE0zMkY0IFNQSSBzdXBwb3J0Lg0K
DQo+IFRoaXMgdmVyc2lvbiBvZiBkcml2ZXIgaXMgbW9zdGx5IGRpZmZlcmVudCB0byBTVE0zMkg3
IG9uZS4gQmFzZWQgb24gbGludXgNCj4ga2VybmVsIEkyQyBkcml2ZXJzIGZvciBTVE0zMiB3aGVy
ZSBkcml2ZXJzIHdlcmUgc3BsaXRlZCBpbnRvIFNUTTMyRjQgYW5kDQo+IFNUTTMyRjcgZmFtaWx5
IHRoZSBzYW1lIGFwcHJvYWNoIHNlZW1zIHRvIGJlIHN1ZmZpY2llbnQgZm9yIFNQSSBTVE0zMg0K
PiBkcml2ZXJzLiBUaGVyZWZvcmUgU1RNMzJINyBkcml2ZXIgd2FzIG1vdmVkIHRvIHNwaS1zdG0z
Mmg3LmMgZmlsZSBhbmQNCj4gcmVnaXN0ZXIgYW5kIGZ1bmN0aW9ucyB3ZXJlIHJlbmFtZWQgdG8g
YmUgbW9yZSBzcGVjaWZpYyB0byBTVE0zMkg3Lg0KPiANCg0KWW91J3JlIHJpZ2h0LCBTVE0zMkY0
IFNQSSBpcyBzbGlnaHRseSBkaWZmZXJlbnQgZnJvbSBTVE0zMkg3IG9uZTogDQpyZWdpc3RlciBt
YXAvYml0cyBvZmZzZXRzIGFyZSBkaWZmZXJlbnQgYW5kIFNUTTMySDcgaGFzIGFuIFJYIGFuZCBU
WCBGSUZPLg0KQnV0IGlmIHlvdSBoYXZlIGEgbG9vayBvbiBTVE0zMkY3IFNQSSBbMV0sIHlvdSds
bCBzZWUgdGhhdCBTVE0zMkY3IFNQSSANCmlzIGJhc2VkIG9uIFNUTTMyRjQgU1BJIHdpdGggbmV3
IGZlYXR1cmVzIChkYXRhIGZyYW1lcyAmIEZJRk9zKSBhbHNvIA0KYXZhaWxhYmxlIG9uIFNUTTMy
SDcgU1BJLg0KDQpUaGF0J3Mgd2h5IFNUTTMySDcgU1BJIGRyaXZlciB3YXMgY2FsbGVkIHNwaS1z
dG0zMi4gVGhlIGdvYWwgd2FzIHRvIHVzZSANCmNvbXBhdGlibGUgJiBtYXRjaCBkYXRhIHRvIGRp
ZmZlcmVudGlhdGUgZWFjaCBTVE0zMkZ4IHNwZWNpZmljaXRpZXMuDQoNCllvdSBjYW4gaGF2ZSBh
IGxvb2sgb24gaG93IGl0IGlzIG1hbmFnZWQgaW4gZHJpdmVycy9ydGMvcnRjLXN0bTMyLmMgKHRo
ZSANCnNhbWUgZHJpdmVyIGNvdmVycyAyIEhXIHZlcnNpb24gb2YgU1RNMzIgUlRDKSwgb3IgaW4g
DQpkcml2ZXJzL2lpby9kYWMvc3RtMzItZGFjLWNvcmUuYyBhbmQgc3RtMzItZGFjLmMgKHRoZSBz
YW1lIGRyaXZlciBhbHNvIA0KY292ZXJzIDIgSFcgdmVyc2lvbiBvZiBTVE0zMiBEQUMpLg0KDQpB
cyB5b3VyIHNwaS1zdG0zMmY0LmMgZmlsZSBpcyBoaWdobHkgYmFzZWQgb24gdGhlIGV4aXN0aW5n
IHNwaS1zdG0zMi5jIA0KZmlsZSwgSSB0aGluayB0aGF0IGNvbW1vbiBjb2RlIGNvdWxkIGJlIGZh
Y3RvcmVkIGFuZCBzcGVjaWZpY2l0aWVzIGNvdWxkIA0KYmUgaGFuZGxlZCB3aXRoIGNvbXBhdGli
bGUgYW5kIG1hdGNoIGRhdGEuDQoNClJlZ2FyZHMsDQpBbWVsaWUNCg0KDQpbMV0gDQpodHRwczov
L3d3dy5zdC5jb20vY29udGVudC9jY2MvcmVzb3VyY2UvdGVjaG5pY2FsL2RvY3VtZW50L3JlZmVy
ZW5jZV9tYW51YWwvYzUvY2YvZWYvNTIvYzAvZjEvNGIvZmEvRE0wMDEyNDg2NS5wZGYvZmlsZXMv
RE0wMDEyNDg2NS5wZGYvamNyOmNvbnRlbnQvdHJhbnNsYXRpb25zL2VuLkRNMDAxMjQ4NjUucGRm
DQoNCj4gRm9yIGN1cnJlbnQgdmVyc2lvbiBtYXN0ZXIgbW9kZSB3aXRoIGZ1bGwtZHVwbGV4IGFu
ZCA4LzE2IGJpdCBkYXRhIGZyYW1lDQo+IGZvcm1hdCBhcmUgc3VwcG9ydGVkLiBUaGVyZSBpcyBu
byBUWCBhbmQgUlggRklGT3MgbGlrZSBpbiBTVE0zMkg3Lg0KPiBETUEgY2FwYWJpbGlsaXR5IGlz
IHN1cHBvcnRlZCBmb3IgbWVzc2FnZXMgbG9uZ2VyIHRoYW4gYXJiaXRyYXJ5IG51bWJlcg0KPiBv
ZiBieXRlcyAodGhhdCBpcyBzZXQgYWxyZWFkeSB0byAxNiBieXRlcykgd2hlbiBUWCBhbmQgUlgg
Y2hhbm5lbHMgYXJlDQo+IHNldCBhdCB0aGUgc2FtZSB0aW1lLg0KPiANCj4gQ2V6YXJ5IEdhcGlu
c2tpICg1KToNCj4gICAgc3BpOiBzdG0zMjogcmVuYW1lIFNUTTMyIFNQSSByZWdpc3RlcnMgYW5k
IGZ1bmN0aW9ucyB0byBTVE0zMkg3DQo+ICAgIHNwaTogc3RtMzI6IHJlbmFtZSBzcGktc3RtMzIg
dG8gc3BpLXN0bTMyaDcNCj4gICAgc3BpOiBzdG0zMjogYWRkIGRyaXZlciBmb3IgU1RNMzJGNCBj
b250cm9sbGVyDQo+ICAgIEFSTTogZHRzOiBzdG0zMjogYWRkIFNQSSBzdXBwb3J0IG9uIFNUTTMy
RjQyOSBTb0MNCj4gICAgc3BpOiBzdG0zMjogYWRkIGRlc2NyaXB0aW9uIGFib3V0IFNUTTMyRjQg
YmluZGluZ3MNCj4gDQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1zdG0zMi50
eHQgICAgICAgICAgfCAgICA5ICstDQo+ICAgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJmNDI5LmR0
c2kgICAgICAgICAgICAgICAgICAgfCAgIDYwICsNCj4gICBkcml2ZXJzL3NwaS9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTggKy0NCj4gICBkcml2ZXJzL3NwaS9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDMgKy0NCj4gICBkcml2
ZXJzL3NwaS9zcGktc3RtMzIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEzMjIgLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvc3BpL3NwaS1zdG0zMmY0LmMgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTAwMiArKysrKysrKysrKysrKysNCj4gICBkcml2ZXJzL3NwaS9z
cGktc3RtMzJoNy5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEzNDAgKysrKysrKysrKysr
KysrKysrKysNCj4gICA3IGZpbGVzIGNoYW5nZWQsIDI0MjQgaW5zZXJ0aW9ucygrKSwgMTMzMCBk
ZWxldGlvbnMoLSkNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zcGkvc3BpLXN0bTMy
LmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zcGkvc3BpLXN0bTMyZjQuYw0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NwaS9zcGktc3RtMzJoNy5jDQo+
