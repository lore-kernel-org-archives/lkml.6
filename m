Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F0E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F0E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeGCLCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:02:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52675 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752387AbeGCLCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:02:14 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w63B1wMM008848;
        Tue, 3 Jul 2018 13:02:05 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jyws0tkvc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 03 Jul 2018 13:02:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8870343;
        Tue,  3 Jul 2018 11:01:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D69D24D9;
        Tue,  3 Jul 2018 11:01:58 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Jul
 2018 13:01:57 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 3 Jul 2018 13:01:57 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: filter mode pixel clock vs pad constraint
Thread-Topic: [PATCH] drm/stm: ltdc: filter mode pixel clock vs pad constraint
Thread-Index: AQHUD5t2SiSk0f8/7E+xMnCpRIlOt6R9OcUA
Date:   Tue, 3 Jul 2018 11:01:57 +0000
Message-ID: <e1c4deef-ba3a-6454-a0cf-b05c144c58b5@st.com>
References: <1530271342-5532-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1530271342-5532-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <229892A2CFFB3A40AD6290449B07F914@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWWFubmljaywNCg0KT24gMDYvMjkvMjAxOCAwMToyMiBQTSwgWWFubmljayBGZXJ0cmUgd3Jv
dGU6DQo+IEZpbHRlciB0aGUgcmVxdWVzdGVkIG1vZGUgcGl4ZWwgY2xvY2sgZnJlcXVlbmN5IGFj
Y29yZGluZw0KPiB0byB0aGUgcGFkIG1heGltdW0gc3VwcG9ydGVkIGZyZXF1ZW5jeS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFlhbm5pY2sgRmVydHJlIDx5YW5uaWNrLmZlcnRyZUBzdC5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIHwgMTYgKysrKysrKysrKysrLS0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5oIHwgIDEgKw0KPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5j
DQo+IGluZGV4IDAwZTMyNjIuLjk2ZDIwYzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9zdG0vbHRkYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+IEBAIC00
OTEsNiArNDkxLDE0IEBAIHN0YXRpYyB2b2lkIGx0ZGNfY3J0Y19hdG9taWNfZGlzYWJsZShzdHJ1
Y3QgZHJtX2NydGMgKmNydGMsDQo+ICAgCWludCB0YXJnZXRfbWF4ID0gdGFyZ2V0ICsgQ0xLX1RP
TEVSQU5DRV9IWjsNCj4gICAJaW50IHJlc3VsdDsNCj4gICANCj4gKwlyZXN1bHQgPSBjbGtfcm91
bmRfcmF0ZShsZGV2LT5waXhlbF9jbGssIHRhcmdldCk7DQo+ICsNCj4gKwlEUk1fREVCVUdfRFJJ
VkVSKCJjbGsgcmF0ZSB0YXJnZXQgJWQsIGF2YWlsYWJsZSAlZFxuIiwgdGFyZ2V0LCByZXN1bHQp
Ow0KPiArDQo+ICsJLyogRmlsdGVyIG1vZGVzIGFjY29yZGluZyB0byB0aGUgbWF4IGZyZXF1ZW5j
eSBzdXBwb3J0ZWQgYnkgdGhlIHBhZHMgKi8NCj4gKwlpZiAocmVzdWx0ID4gbGRldi0+Y2Fwcy5w
YWRfbWF4X2ZyZXFfaHopDQo+ICsJCXJldHVybiBNT0RFX0NMT0NLX0hJR0g7DQo+ICsNCj4gICAJ
LyoNCj4gICAJICogQWNjZXB0IGFsbCAicHJlZmVycmVkIiBtb2RlczoNCj4gICAJICogLSB0aGlz
IGlzIGltcG9ydGFudCBmb3IgcGFuZWxzIGJlY2F1c2UgcGFuZWwgY2xvY2sgdG9sZXJhbmNlcyBh
cmUNCj4gQEAgLTUwMiwxMCArNTEwLDYgQEAgc3RhdGljIHZvaWQgbHRkY19jcnRjX2F0b21pY19k
aXNhYmxlKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCj4gICAJaWYgKG1vZGUtPnR5cGUgJiBEUk1f
TU9ERV9UWVBFX1BSRUZFUlJFRCkNCj4gICAJCXJldHVybiBNT0RFX09LOw0KPiAgIA0KPiAtCXJl
c3VsdCA9IGNsa19yb3VuZF9yYXRlKGxkZXYtPnBpeGVsX2NsaywgdGFyZ2V0KTsNCj4gLQ0KPiAt
CURSTV9ERUJVR19EUklWRVIoImNsayByYXRlIHRhcmdldCAlZCwgYXZhaWxhYmxlICVkXG4iLCB0
YXJnZXQsIHJlc3VsdCk7DQo+IC0NCj4gICAJLyoNCj4gICAJICogRmlsdGVyIG1vZGVzIGFjY29y
ZGluZyB0byB0aGUgY2xvY2sgdmFsdWUsIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yDQo+ICAgCSAq
IGhkbWkgbW9kZXMgdGhhdCByZXF1aXJlIHByZWNpc2UgcGl4ZWwgY2xvY2tzLg0KPiBAQCAtMTAz
OSwxMSArMTA0MywxNSBAQCBzdGF0aWMgaW50IGx0ZGNfZ2V0X2NhcHMoc3RydWN0IGRybV9kZXZp
Y2UgKmRkZXYpDQo+ICAgCQkgKiBkb2VzIG5vdCB3b3JrIG9uIDJuZCBsYXllci4NCj4gICAJCSAq
Lw0KPiAgIAkJbGRldi0+Y2Fwcy5ub25fYWxwaGFfb25seV9sMSA9IHRydWU7DQo+ICsJCWxkZXYt
PmNhcHMucGFkX21heF9mcmVxX2h6ID0gOTAwMDAwMDA7DQo+ICsJCWlmIChsZGV2LT5jYXBzLmh3
X3ZlcnNpb24gPT0gSFdWRVJfMTAyMDApDQo+ICsJCQlsZGV2LT5jYXBzLnBhZF9tYXhfZnJlcV9o
eiA9IDY1MDAwMDAwOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWNhc2UgSFdWRVJfMjAxMDE6DQo+ICAg
CQlsZGV2LT5jYXBzLnJlZ19vZnMgPSBSRUdfT0ZTXzQ7DQo+ICAgCQlsZGV2LT5jYXBzLnBpeF9m
bXRfaHcgPSBsdGRjX3BpeF9mbXRfYTE7DQo+ICAgCQlsZGV2LT5jYXBzLm5vbl9hbHBoYV9vbmx5
X2wxID0gZmFsc2U7DQo+ICsJCWxkZXYtPmNhcHMucGFkX21heF9mcmVxX2h6ID0gMTUwMDAwMDAw
Ow0KPiAgIAkJYnJlYWs7DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXR1cm4gLUVOT0RFVjsNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5oIGIvZHJpdmVycy9ncHUvZHJt
L3N0bS9sdGRjLmgNCj4gaW5kZXggYzE0ZTRkYi4uMDI5NGQzOCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3N0bS9sdGRjLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRj
LmgNCj4gQEAgLTIwLDYgKzIwLDcgQEAgc3RydWN0IGx0ZGNfY2FwcyB7DQo+ICAgCXUzMiBidXNf
d2lkdGg7CQkvKiBidXMgd2lkdGggKDMyIG9yIDY0IGJpdHMpICovDQo+ICAgCWNvbnN0IHUzMiAq
cGl4X2ZtdF9odzsJLyogc3VwcG9ydGVkIHBpeGVsIGZvcm1hdHMgKi8NCj4gICAJYm9vbCBub25f
YWxwaGFfb25seV9sMTsgLyogbm9uLW5hdGl2ZSBuby1hbHBoYSBmb3JtYXRzIG9uIGxheWVyIDEg
Ki8NCj4gKwlpbnQgcGFkX21heF9mcmVxX2h6OwkvKiBtYXggZnJlcXVlbmN5IHN1cHBvcnRlZCBi
eSBwYWQgKi8NCg0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLA0KDQpSZXZpZXdlZC1ieTogUGhp
bGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NClRlc3RlZC1ieTogUGhpbGlwcGUg
Q29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0pDQoNCj4gICB9Ow0K
PiAgIA0KPiAgICNkZWZpbmUgTFREQ19NQVhfTEFZRVIJNA0KPiA=
