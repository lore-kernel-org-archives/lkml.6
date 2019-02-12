Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24616C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BEA217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfBLP2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:28:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47492 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727248AbfBLP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:28:36 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CFGUqq031812;
        Tue, 12 Feb 2019 16:28:25 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qjfy65khf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Feb 2019 16:28:25 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6C0F38;
        Tue, 12 Feb 2019 15:28:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DF4A5470;
        Tue, 12 Feb 2019 15:28:23 +0000 (GMT)
Received: from SFHDAG4NODE2.st.com (10.75.127.11) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 Feb
 2019 16:28:22 +0100
Received: from SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f]) by
 SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f%20]) with mapi id
 15.00.1347.000; Tue, 12 Feb 2019 16:28:22 +0100
From:   Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: st-keyscan - fix potential zalloc NULL dereference
Thread-Topic: [PATCH] Input: st-keyscan - fix potential zalloc NULL
 dereference
Thread-Index: AQHUwucSbnUyh3E18kKgOKwxl5Aux6XcOJsA
Date:   Tue, 12 Feb 2019 15:28:22 +0000
Message-ID: <e0967983-cab2-3c18-6c8a-a0333dc087ff@st.com>
References: <20190212152429.1936-1-gabriel.fernandez@st.com>
In-Reply-To: <20190212152429.1936-1-gabriel.fernandez@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <07234B400B9A124689DEB41218527AA9@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgaWdub3JlIHRoaXMgcGF0Y2ggKGJhZCBtYWlsaW5nIGxpc3QpDQoNCkJlc3QgUmVnYXJk
DQoNCkdhYnJpZWwNCg0KT24gMi8xMi8xOSA0OjI0IFBNLCBnYWJyaWVsLmZlcm5hbmRlekBzdC5j
b20gd3JvdGU6DQo+IEZyb206IEdhYnJpZWwgRmVybmFuZGV6IDxnYWJyaWVsLmZlcm5hbmRlekBz
dC5jb20+DQo+DQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZvbGxvd2luZyBzdGF0aWMgY2hlY2tl
ciB3YXJuaW5nOg0KPg0KPiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL3N0LWtleXNjYW4uYzoxNTYg
a2V5c2Nhbl9wcm9iZSgpDQo+IGVycm9yOiBwb3RlbnRpYWwgemFsbG9jIE5VTEwgZGVyZWZlcmVu
Y2U6ICdrZXlwYWRfZGF0YS0+aW5wdXRfZGV2Jw0KPg0KPiBSZXBvcnRlZC1ieTogRGFuIENhcnBl
bnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHYWJyaWVs
IEZlcm5hbmRleiA8Z2FicmllbC5mZXJuYW5kZXpAc3QuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJz
L2lucHV0L2tleWJvYXJkL3N0LWtleXNjYW4uYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lucHV0L2tleWJvYXJkL3N0LWtleXNjYW4uYyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
c3Qta2V5c2Nhbi5jDQo+IGluZGV4IGJhYmNmYjE2NWU0Zi4uM2I4NTYzMWZkZTkxIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL3N0LWtleXNjYW4uYw0KPiArKysgYi9kcml2
ZXJzL2lucHV0L2tleWJvYXJkL3N0LWtleXNjYW4uYw0KPiBAQCAtMTUzLDYgKzE1Myw4IEBAIHN0
YXRpYyBpbnQga2V5c2Nhbl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
IA0KPiAgIAlpbnB1dF9kZXYtPmlkLmJ1c3R5cGUgPSBCVVNfSE9TVDsNCj4gICANCj4gKwlrZXlw
YWRfZGF0YS0+aW5wdXRfZGV2ID0gaW5wdXRfZGV2Ow0KPiArDQo+ICAgCWVycm9yID0ga2V5cGFk
X21hdHJpeF9rZXlfcGFyc2VfZHQoa2V5cGFkX2RhdGEpOw0KPiAgIAlpZiAoZXJyb3IpDQo+ICAg
CQlyZXR1cm4gZXJyb3I7DQo+IEBAIC0xNjgsOCArMTcwLDYgQEAgc3RhdGljIGludCBrZXlzY2Fu
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgDQo+ICAgCWlucHV0X3Nl
dF9kcnZkYXRhKGlucHV0X2Rldiwga2V5cGFkX2RhdGEpOw0KPiAgIA0KPiAtCWtleXBhZF9kYXRh
LT5pbnB1dF9kZXYgPSBpbnB1dF9kZXY7DQo+IC0NCj4gICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gICAJa2V5cGFkX2RhdGEtPmJhc2Ug
PSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCj4gICAJaWYgKElTX0VS
UihrZXlwYWRfZGF0YS0+YmFzZSkp
