Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5922320652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5922320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935948AbeFRJul (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:50:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39307 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934168AbeFRJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:50:28 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5I9muKD006881;
        Mon, 18 Jun 2018 11:49:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jpabag29v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 11:49:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2886048;
        Mon, 18 Jun 2018 09:49:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B75EA5A56;
        Mon, 18 Jun 2018 09:49:44 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 11:49:44 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 18 Jun 2018 11:49:44 +0200
From:   Hugues FRUCHET <hugues.fruchet@st.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] media: stm32-dcmi: add mandatory of_node_put() in
 success path
Thread-Topic: [PATCH 2/2] media: stm32-dcmi: add mandatory of_node_put() in
 success path
Thread-Index: AQHUAnIXQgFv13jwGk6FR46PvILaiKRlrPKA
Date:   Mon, 18 Jun 2018 09:49:44 +0000
Message-ID: <7f3ca88b-e1b0-ea2c-da02-63da5cdc9e09@st.com>
References: <1528824138-19089-1-git-send-email-hofrat@osadl.org>
 <1528824138-19089-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1528824138-19089-2-git-send-email-hofrat@osadl.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED13F2B41F034A4AA7F6E8862EA2BF13@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljaG9sYXMsDQpUaGFua3MgZm9yIHBhdGNoLg0KQlIsDQpIdWd1ZXMuDQoNCk9uIDA2LzEy
LzIwMTggMDc6MjIgUE0sIE5pY2hvbGFzIE1jIEd1aXJlIHdyb3RlOg0KPiBUaGUgZW5kcG9pbnQg
YWxsb2NhdGVkIGJ5IG9mX2dyYXBoX2dldF9uZXh0X2VuZHBvaW50KCkgbmVlZHMgYW4gb2Zfbm9k
ZV9wdXQoKQ0KPiBpbiBib3RoIGVycm9yIGFuZCBzdWNjZXNzIHBhdGguIEFzICBlcCAgaXMgbm90
IHVzZWQgdGhlIHJlZmNvdW50IGRlY3JlbWVudA0KPiBjYW4gYmUgcmlnaHQgYWZ0ZXIgdGhlIGxh
c3QgdXNlIG9mICBlcC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIE1jIEd1aXJlIDxo
b2ZyYXRAb3NhZGwub3JnPg0KQWNrZWQtYnk6IEh1Z3VlcyBGcnVjaGV0IDxodWd1ZXMuZnJ1Y2hl
dEBzdC5jb20+DQoNCj4gRml4ZXM6IGNvbW1pdCAzNzQwNGY5MWVmOGIgKCJbbWVkaWFdIHN0bTMy
LWRjbWk6IFNUTTMyIERDTUkgY2FtZXJhIGludGVyZmFjZSBkcml2ZXIiKQ0KPiAtLS0NCj4gDQo+
IFByb2JsZW0gbG9jYXRlZCB3aXRoIGFuIGV4cGVyaW1lbnRhbCBjb2NjaW5lbGxlIHNjcmlwdA0K
PiANCj4gUGF0Y2ggd2FzIGNvbXBpbGUgdGVzdGVkIHdpdGg6IHg4Nl82NF9kZWZjb25maWcsIE1F
RElBX1NVUFBPUlQ9eQ0KPiBNRURJQV9DQU1FUkFfU1VQUE9SVD15LCBWNExfUExBVEZPUk1fRFJJ
VkVSUz15LCBPRj15LCBDT01QSUxFX1RFU1Q9eQ0KPiBDT05GSUdfVklERU9fU1RNMzJfRENNST15
DQo+IChUaGVyZSBhcmUgYSBudW1iZXIgb2Ygc3BhcnNlIHdhcm5pbmdzIC0gbm90IHJlbGF0ZWQg
dG8gdGhlIGNoYW5nZXMgdGhvdWdoKQ0KPiANCj4gUGF0Y2ggaXMgb24gdG9wIG9mICJbUEFUQ0gg
MS8yXSBtZWRpYTogc3RtMzItZGNtaTogZHJvcCB1bm5lY2VlYXJ5IHdoaWxlKDEpDQo+IGxvb3Ai
IGFnYWluc3QgNC4xNy4wIChsb2NhbHZlcnNpb24tbmV4dCBpcyBuZXh0LTIwMTgwNjA4KQ0KPiAN
Cj4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3N0bTMyL3N0bTMyLWRjbWkuYyB8IDUgKystLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RtMzIvc3RtMzItZGNtaS5j
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdG0zMi9zdG0zMi1kY21pLmMNCj4gaW5kZXggNzBi
ODFkMi4uNTQyZDE0OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdG0z
Mi9zdG0zMi1kY21pLmMNCj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdG0zMi9zdG0z
Mi1kY21pLmMNCj4gQEAgLTE2MTAsMTAgKzE2MTAsOSBAQCBzdGF0aWMgaW50IGRjbWlfZ3JhcGhf
cGFyc2Uoc3RydWN0IHN0bTMyX2RjbWkgKmRjbWksIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSkN
Cj4gICAJCXJldHVybiAtRUlOVkFMOw0KPiAgIA0KPiAgIAlyZW1vdGUgPSBvZl9ncmFwaF9nZXRf
cmVtb3RlX3BvcnRfcGFyZW50KGVwKTsNCj4gLQlpZiAoIXJlbW90ZSkgew0KPiAtCQlvZl9ub2Rl
X3B1dChlcCk7DQo+ICsJb2Zfbm9kZV9wdXQoZXApOw0KPiArCWlmICghcmVtb3RlKQ0KPiAgIAkJ
cmV0dXJuIC1FSU5WQUw7DQo+IC0JfQ0KPiAgIA0KPiAgIAkvKiBSZW1vdGUgbm9kZSB0byBjb25u
ZWN0ICovDQo+ICAgCWRjbWktPmVudGl0eS5ub2RlID0gcmVtb3RlOw0KPiA=
