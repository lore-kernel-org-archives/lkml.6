Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82883C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4687D20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4687D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965981AbeFRJhX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:37:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965060AbeFRJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:37:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5I9XYWX029204;
        Mon, 18 Jun 2018 11:36:37 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jn1pgsd3k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 11:36:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89CB33A;
        Mon, 18 Jun 2018 09:36:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5801659E3;
        Mon, 18 Jun 2018 09:36:29 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 11:36:28 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 18 Jun 2018 11:36:29 +0200
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
Subject: Re: [PATCH] media: stm32-dcmi: simplify of_node_put usage
Thread-Topic: [PATCH] media: stm32-dcmi: simplify of_node_put usage
Thread-Index: AQHUAnJCosrPhFSe1UmPkANMLwEVU6RlqT4A
Date:   Mon, 18 Jun 2018 09:36:28 +0000
Message-ID: <1b951a4b-4583-5cc2-c54a-4de1196e1653@st.com>
References: <1528824196-19149-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1528824196-19149-1-git-send-email-hofrat@osadl.org>
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
Content-ID: <A66A17569BFC51408F223D8818E234CC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljaG9sYXMsDQpUaGFua3MgZm9yIHBhdGNoLA0KDQpPbiAwNi8xMi8yMDE4IDA3OjIzIFBN
LCBOaWNob2xhcyBNYyBHdWlyZSB3cm90ZToNCj4gVGhpcyBkb2VzIG5vdCBmaXggYW55IGJ1ZyAt
IHRoaXMgaXMganVzdCBhIGNvZGUgc2ltcGxpZmljYXRpb24uIEFzDQo+IG5wIGlzIG5vdCB1c2Vk
IGFmdGVyIHBhc3NpbmcgaXQgdG8gdjRsMl9md25vZGVfZW5kcG9pbnRfcGFyc2UoKSBpdHMNCj4g
cmVmY291bnQgY2FuIGJlIGRlY3JlbWVudGVkIGltbWVkaWF0ZWx5IGFuZCBhdCBvbmUgbG9jYXRp
b24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBNYyBHdWlyZSA8aG9mcmF0QG9zYWRs
Lm9yZz4NCkFja2VkLWJ5OiBIdWd1ZXMgRnJ1Y2hldCA8aHVndWVzLmZydWNoZXRAc3QuY29tPg0K
DQo+IC0tLQ0KPiANCj4gSXNzdWUgZm91bmQgZHVyaW5nIGNvZGUgcmVhZGluZy4NCj4gDQo+IFBh
dGNoIHdhcyBjb21waWxlIHRlc3RlZCB3aXRoOiB4ODZfNjRfZGVmY29uZmlnLCBNRURJQV9TVVBQ
T1JUPXkNCj4gTUVESUFfQ0FNRVJBX1NVUFBPUlQ9eSwgVjRMX1BMQVRGT1JNX0RSSVZFUlM9eSwg
T0Y9eSwgQ09NUElMRV9URVNUPXkNCj4gQ09ORklHX1ZJREVPX1NUTTMyX0RDTUk9eQ0KPiAoVGhl
cmUgYXJlIGEgZmV3IHNwYXJzZSB3YXJuaW5ncyAtIGJ1dCB1bnJlbGF0ZWQgdG8gdGhlIGxpbmVz
IGNoYW5nZWQpDQo+IA0KPiBQYXRjaCBpcyBhZ2FpbnN0IDQuMTcuMCAobG9jYWx2ZXJzaW9uLW5l
eHQgaXMgbmV4dC0yMDE4MDYwOCkNCj4gDQo+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdG0z
Mi9zdG0zMi1kY21pLmMgfCA1ICstLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vc3RtMzIvc3RtMzItZGNtaS5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdG0zMi9z
dG0zMi1kY21pLmMNCj4gaW5kZXggMmUxOTMzZC4uMGI2MTA0MiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9zdG0zMi9zdG0zMi1kY21pLmMNCj4gKysrIGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9zdG0zMi9zdG0zMi1kY21pLmMNCj4gQEAgLTE2OTYsMjMgKzE2OTYsMjAg
QEAgc3RhdGljIGludCBkY21pX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAgCX0NCj4gICANCj4gICAJcmV0ID0gdjRsMl9md25vZGVfZW5kcG9pbnRfcGFyc2Uob2ZfZndu
b2RlX2hhbmRsZShucCksICZlcCk7DQo+ICsJb2Zfbm9kZV9wdXQobnApOw0KPiAgIAlpZiAocmV0
KSB7DQo+ICAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb3VsZCBub3QgcGFyc2UgdGhlIGVuZHBv
aW50XG4iKTsNCj4gLQkJb2Zfbm9kZV9wdXQobnApOw0KPiAgIAkJcmV0dXJuIC1FTk9ERVY7DQo+
ICAgCX0NCj4gICANCj4gICAJaWYgKGVwLmJ1c190eXBlID09IFY0TDJfTUJVU19DU0kyKSB7DQo+
ICAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDU0kgYnVzIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiAt
CQlvZl9ub2RlX3B1dChucCk7DQo+ICAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gICAJfQ0KPiAgIAlk
Y21pLT5idXMuZmxhZ3MgPSBlcC5idXMucGFyYWxsZWwuZmxhZ3M7DQo+ICAgCWRjbWktPmJ1cy5i
dXNfd2lkdGggPSBlcC5idXMucGFyYWxsZWwuYnVzX3dpZHRoOw0KPiAgIAlkY21pLT5idXMuZGF0
YV9zaGlmdCA9IGVwLmJ1cy5wYXJhbGxlbC5kYXRhX3NoaWZ0Ow0KPiAgIA0KPiAtCW9mX25vZGVf
cHV0KG5wKTsNCj4gLQ0KPiAgIAlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiAg
IAlpZiAoaXJxIDw9IDApIHsNCj4gICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCBn
ZXQgaXJxXG4iKTsNCj4g
