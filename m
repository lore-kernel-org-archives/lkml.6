Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE306C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1603208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1603208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965961AbeFRJe6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:34:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965840AbeFRJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:34:54 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5I9Xadk029207;
        Mon, 18 Jun 2018 11:34:08 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jn1pgscg5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 11:34:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 495593F;
        Mon, 18 Jun 2018 09:34:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C25C59D4;
        Mon, 18 Jun 2018 09:34:04 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 11:34:04 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 18 Jun 2018 11:34:04 +0200
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
Subject: Re: [PATCH 1/2] media: stm32-dcmi: drop unnecessary while(1) loop
Thread-Topic: [PATCH 1/2] media: stm32-dcmi: drop unnecessary while(1) loop
Thread-Index: AQHUAnIXDdKrcWrbfU6vYUIO2PoOYaRlqJGA
Date:   Mon, 18 Jun 2018 09:34:04 +0000
Message-ID: <a67e4d0c-8434-5669-329f-66a45b7be343@st.com>
References: <1528824138-19089-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1528824138-19089-1-git-send-email-hofrat@osadl.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F7FF8B9CF6BBE4C9B3F701360F3C82A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljaG9sYXMsDQp0aGFua3MgZm9yIHBhdGNoICENCg0KT24gMDYvMTIvMjAxOCAwNzoyMiBQ
TSwgTmljaG9sYXMgTWMgR3VpcmUgd3JvdGU6DQo+IFRoZSB3aGlsZSgxKSBpcyBlZmZlY3RpdmVs
eSB1c2VsZXNzIGFzIGFsbCBwb3NzaWJsZSBwYXRocyB3aXRoaW4gaXQNCj4gcmV0dXJuIHRodXMg
dGhlcmUgaXMgbm8gd2F5IHRvIGxvb3AuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBN
YyBHdWlyZSA8aG9mcmF0QG9zYWRsLm9yZz4NCkFja2VkLWJ5OiBIdWd1ZXMgRnJ1Y2hldCA8aHVn
dWVzLmZydWNoZXRAc3QuY29tPg0KDQo+IC0tLQ0KPiANCj4gVGhpcyBpcyBub3QgYWN0dWFsbHkg
Zml4aW5nIGFueSBidWcgLSB0aGUgd2hpbGUoMSl7IH0gd2lsbCBub3QgaHVydCBoZXJlDQo+IGl0
IGlzIHRob3VnaCBzaW1wbHkgdW5uZWNlc3NhcnkuIEZvdW5kIGR1cmluZyBjb2RlIHJldmlldy4N
Cj4gDQo+IFRoZSBkaWZmIG91dHB1dCBpcyBub3QgdmVyeSByZWFkYWJsZSAtIGVzc2VudGlhbGx5
IG9ubHkgdGhlIG91dGVyDQo+IHdoaWxlKDEpeyB9IHdhcyByZW1vdmVkLg0KPiANCj4gUGF0Y2gg
d2FzIGNvbXBpbGUgdGVzdGVkIHdpdGg6IHg4Nl82NF9kZWZjb25maWcsIE1FRElBX1NVUFBPUlQ9
eQ0KPiBNRURJQV9DQU1FUkFfU1VQUE9SVD15LCBWNExfUExBVEZPUk1fRFJJVkVSUz15LCBPRj15
LCBDT01QSUxFX1RFU1Q9eQ0KPiBDT05GSUdfVklERU9fU1RNMzJfRENNST15DQo+IChUaGVyZSBh
cmUgYSBudW1iZXIgb2Ygc3BhcnNlIHdhcm5pbmdzIC0gbm90IHJlbGF0ZWQgdG8gdGhlIGNoYW5n
ZXMgdGhvdWdoKQ0KPiANCj4gUGF0Y2ggaXMgYWdhaW5zdCA0LjE3LjAgKGxvY2FsdmVyc2lvbi1u
ZXh0IGlzIG5leHQtMjAxODA2MDgpDQo+IA0KPiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3Rt
MzIvc3RtMzItZGNtaS5jIHwgMjggKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3N0bTMyL3N0bTMyLWRjbWkuYyBiL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RtMzIvc3RtMzItZGNtaS5jDQo+IGluZGV4IDJlMTkzM2Qu
LjcwYjgxZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RtMzIvc3Rt
MzItZGNtaS5jDQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RtMzIvc3RtMzItZGNt
aS5jDQo+IEBAIC0xNjA1LDIzICsxNjA1LDIxIEBAIHN0YXRpYyBpbnQgZGNtaV9ncmFwaF9wYXJz
ZShzdHJ1Y3Qgc3RtMzJfZGNtaSAqZGNtaSwgc3RydWN0IGRldmljZV9ub2RlICpub2RlKQ0KPiAg
IAlzdHJ1Y3QgZGV2aWNlX25vZGUgKmVwID0gTlVMTDsNCj4gICAJc3RydWN0IGRldmljZV9ub2Rl
ICpyZW1vdGU7DQo+ICAgDQo+IC0Jd2hpbGUgKDEpIHsNCj4gLQkJZXAgPSBvZl9ncmFwaF9nZXRf
bmV4dF9lbmRwb2ludChub2RlLCBlcCk7DQo+IC0JCWlmICghZXApDQo+IC0JCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gLQ0KPiAtCQlyZW1vdGUgPSBvZl9ncmFwaF9nZXRfcmVtb3RlX3BvcnRfcGFyZW50
KGVwKTsNCj4gLQkJaWYgKCFyZW1vdGUpIHsNCj4gLQkJCW9mX25vZGVfcHV0KGVwKTsNCj4gLQkJ
CXJldHVybiAtRUlOVkFMOw0KPiAtCQl9DQo+ICsJZXAgPSBvZl9ncmFwaF9nZXRfbmV4dF9lbmRw
b2ludChub2RlLCBlcCk7DQo+ICsJaWYgKCFlcCkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICAg
DQo+IC0JCS8qIFJlbW90ZSBub2RlIHRvIGNvbm5lY3QgKi8NCj4gLQkJZGNtaS0+ZW50aXR5Lm5v
ZGUgPSByZW1vdGU7DQo+IC0JCWRjbWktPmVudGl0eS5hc2QubWF0Y2hfdHlwZSA9IFY0TDJfQVNZ
TkNfTUFUQ0hfRldOT0RFOw0KPiAtCQlkY21pLT5lbnRpdHkuYXNkLm1hdGNoLmZ3bm9kZSA9IG9m
X2Z3bm9kZV9oYW5kbGUocmVtb3RlKTsNCj4gLQkJcmV0dXJuIDA7DQo+ICsJcmVtb3RlID0gb2Zf
Z3JhcGhfZ2V0X3JlbW90ZV9wb3J0X3BhcmVudChlcCk7DQo+ICsJaWYgKCFyZW1vdGUpIHsNCj4g
KwkJb2Zfbm9kZV9wdXQoZXApOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gICAJfQ0KPiArDQo+
ICsJLyogUmVtb3RlIG5vZGUgdG8gY29ubmVjdCAqLw0KPiArCWRjbWktPmVudGl0eS5ub2RlID0g
cmVtb3RlOw0KPiArCWRjbWktPmVudGl0eS5hc2QubWF0Y2hfdHlwZSA9IFY0TDJfQVNZTkNfTUFU
Q0hfRldOT0RFOw0KPiArCWRjbWktPmVudGl0eS5hc2QubWF0Y2guZndub2RlID0gb2ZfZndub2Rl
X2hhbmRsZShyZW1vdGUpOw0KPiArCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMg
aW50IGRjbWlfZ3JhcGhfaW5pdChzdHJ1Y3Qgc3RtMzJfZGNtaSAqZGNtaSkNCj4gDQoNCkJSLA0K
SHVndWVzLg==
