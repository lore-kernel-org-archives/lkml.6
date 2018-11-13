Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5596C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7653820811
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7653820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbeKMUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:14:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56570 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732077AbeKMUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:14:47 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wADAE0jm010750;
        Tue, 13 Nov 2018 11:16:58 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nnq3j8u2x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 13 Nov 2018 11:16:58 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEBAD34;
        Tue, 13 Nov 2018 10:16:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 84C78287B;
        Tue, 13 Nov 2018 10:16:57 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 13 Nov
 2018 11:16:57 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Tue, 13 Nov 2018 11:16:57 +0100
From:   Bich HEMON <bich.hemon@st.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     Olof Johansson <olof@lixom.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH] ARM: stm32: debug: add low-level debug support
Thread-Topic: [PATCH] ARM: stm32: debug: add low-level debug support
Thread-Index: AQHTBvhu7ZuVgRQin0SIqpXfFjas8qVPSqoAgAD5r4CAAAJGgIAADqwA
Date:   Tue, 13 Nov 2018 10:16:57 +0000
Message-ID: <94666165-f206-5472-c848-499ba52cd354@st.com>
References: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
 <1501174209-27550-2-git-send-email-bich.hemon@st.com>
 <20181112182236.s7cs6dol4dmxkp7u@localhost>
 <f244c67b-de86-b0e7-7283-7b27f9591cf9@st.com>
 <20181113092422.GJ30658@n2100.armlinux.org.uk>
In-Reply-To: <20181113092422.GJ30658@n2100.armlinux.org.uk>
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
Content-ID: <78FF2043ABE26D488A8FA0D6C4317C1C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzEzLzE4IDEwOjI0IEFNLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggd3JvdGU6
DQo+IE9uIFR1ZSwgTm92IDEzLCAyMDE4IGF0IDA5OjE2OjE2QU0gKzAwMDAsIEJpY2ggSEVNT04g
d3JvdGU6DQo+Pg0KPj4gT24gMTEvMTIvMTggNzoyMiBQTSwgT2xvZiBKb2hhbnNzb24gd3JvdGU6
DQo+Pj4gT24gVGh1LCBKdWwgMjcsIDIwMTcgYXQgMDQ6NTA6MjBQTSArMDAwMCwgQmljaCBIRU1P
TiB3cm90ZToNCj4+Pj4gRnJvbTogR2VyYWxkIEJhZXphIDxnZXJhbGQuYmFlemFAc3QuY29tPg0K
Pj4+Pg0KPj4+PiBUaGlzIGFkZHMgbG93LWxldmVsIGRlYnVnIHN1cHBvcnQgb24gVVNBUlQxIGZv
ciBTVE0zMkY0DQo+Pj4+IGFuZCBTVE0zMkY3Lg0KPj4+PiBDb21waWxlZCB2aWEgJ0NPTkZJR19E
RUJVR19MTCcgYW5kICdDT05GSUdfRUFSTFlfUFJJTlRLJy4NCj4+Pj4gRW5hYmxlZCB2aWEgJ2Vh
cmx5cHJpbnRrJyBpbiBib290YXJncy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogR2VyYWxk
IEJhZXphIDxnZXJhbGQuYmFlemFAc3QuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBCaWNoIEhl
bW9uIDxiaWNoLmhlbW9uQHN0LmNvbT4NCj4+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gVGhpcyBoYWQg
ZmFsbGVuIGJldHdlZW4gdGhlIGNoYWlycyBpdCBzZWVtcy4gSSBoYXZlIGFwcGxpZWQgaXQgdG8g
YXJtLXNvYw0KPj4+IG5leHQvc29jIG5vdywgZm9yIDQuMjEgbWVyZ2Ugd2luZG93Lg0KPj4+DQo+
Pj4gSXQgZW5kZWQgdXAgYmVpbmcgcGF0Y2hlZCB1cCBtYW51YWxseSB0byBjb25zb2xpZGF0ZSB0
aGUgdmVyc2lvbiBpbg0KPj4+IFJ1c3NlbGwncyBwYXRjaCB0cmFja2VyIHdpdGggdGhpcyBwb3N0
ZWQgdmVyc2lvbiwgYW5kIEkgdHdlYWtlZCB3aGl0ZXNwYWNlDQo+Pj4gYSBiaXQuIExldCBtZSBr
bm93IGlmIEkgbWlzc2VkIHNvbWV0aGluZy4NCj4+Pg0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+DQo+
Pj4gLU9sb2YNCj4+Pg0KPj4NCj4+IEhpIE9sb2YsDQo+Pg0KPj4gUGxlYXNlIG5vdGUgdGhhdCB0
aGlzIHBhdGNoIGhhcyB0byBiZSBhYmFuZG9uZWQgYXMgTHVkb3ZpYyBCQVJSRSBwdXNoZWQNCj4+
IGEgbmV3IHZlcnNpb24gb2YgdGhpcyBjaGFuZ2U6DQo+PiBodHRwczovL3BhdGNod29yay5jb2Rl
YXVyb3JhLm9yZy9wYXRjaC80MDA1NjMvDQo+Pg0KPj4gWW91IGNhbiBmaW5kIGl0IGluIFJ1c3Nl
bGwncyB0cmFja2VyIGhlcmU6DQo+PiBodHRwOi8vd3d3LmFybS5saW51eC5vcmcudWsvZGV2ZWxv
cGVyL3BhdGNoZXMvdmlld3BhdGNoLnBocD9pZD04ODAzLzENCj4gDQo+IEFuZCBJJ20gbm90IGdv
aW5nIHRvIG1lcmdlIHRoYXQgYmVjYXVzZToNCj4gDQo+IDEpIGl0J3Mgbm90IGZvciBtZSB0byBt
ZXJnZSAtIGl0IGRvZXNuJ3QgZ28gdGhyb3VnaCBteSB0cmVlLCBidXQgdGhyb3VnaA0KPiAgICAg
YXJtLXNvYywgd2hpY2ggT2xvZiBhbmQgQXJuZCBtYW5hZ2UuDQo+IDIpIGl0J3Mgbm90IGJlZW4g
b24gdGhlIG1haWxpbmcgbGlzdCBhcyBwZXIgbm9ybWFsIHN1Ym1pc3Npb24gcHJvY2Vzcy4NCj4g
DQo+IFNvcnJ5Lg0KPiANCg0KT2ssIHRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLg0KDQpTbyBP
bG9mLCBjYW4geW91IHBsZWFzZSBpZ25vcmUgbXkgcHJldmlvdXMgZW1haWwgYW5kIG1lcmdlIG15
IHBhdGNoIGFzIA0KeW91IHByb3Bvc2VkIGl0IGZvciA0LjIxLiBMdWRvdmljJ3MgcGF0Y2ggd2ls
bCBiZSBhYmFuZG9uZWQgaW5zdGVhZC4NCg0KVGhhbmtzLA0KDQpCaWNo
