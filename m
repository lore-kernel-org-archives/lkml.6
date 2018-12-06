Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC7FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C7820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C7820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbeLFJNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:13:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56049 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727575AbeLFJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:13:33 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB69BVNx009594;
        Thu, 6 Dec 2018 10:13:06 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p53mbaa7n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Dec 2018 10:13:06 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7EF4E123;
        Thu,  6 Dec 2018 09:12:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 425292479;
        Thu,  6 Dec 2018 09:12:57 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 10:12:56 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 10:12:56 +0100
From:   David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] thermal: stm32: read factory settings properly
Thread-Topic: [PATCH] thermal: stm32: read factory settings properly
Thread-Index: AQHUjUPg9X1K8GffyUyGZZ5N7LVjEQ==
Date:   Thu, 6 Dec 2018 09:12:56 +0000
Message-ID: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CBBC0193CA97B4DAA00046551B7631A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2FsbCBzdG1fdGhlcm1hbF9yZWFkX2ZhY3Rvcnlfc2V0dGluZ3Mgb25jZQ0KaW50ZXJuYWwgcGVy
aXBoZXJhbCBpcyBwcm9wZXJseSBjbG9ja2VkLg0KDQpUbyBhdm9pZCB3cm9uZyBpbml0aWFsaXph
dGlvbiBvZiBmbXQwDQooc3RtX3RoZXJtYWxfc2Vuc29yIHN0cnVjdCkgbWVtYmVyIGFkZA0KYnJh
Y2tldHMgcHJvcGVybHkuDQoNCkNoYW5nZS1JZDogSTE1MGQwMGZkNTBlMzgyZGYwNGJmYWQxMmYw
NjUzYjFlZDZhMWRiMWINClNpZ25lZC1vZmYtYnk6IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6IDxk
YXZpZC5oZXJuYW5kZXpzYW5jaGV6QHN0LmNvbT4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhl
cm1hbC9zdC9zdG1fdGhlcm1hbC5jIGIvZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMN
CmluZGV4IDQ3NjIzZGEuLmJiZDczYzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3RoZXJtYWwvc3Qv
c3RtX3RoZXJtYWwuYw0KKysrIGIvZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMNCkBA
IC0yNDEsOCArMjQxLDggQEAgc3RhdGljIGludCBzdG1fdGhlcm1hbF9yZWFkX2ZhY3Rvcnlfc2V0
dGluZ3Moc3RydWN0IHN0bV90aGVybWFsX3NlbnNvciAqc2Vuc29yKQ0KIAkJc2Vuc29yLT50MCA9
IFRTMV9UMF9WQUwxOw0KIA0KIAkvKiBSZXRyaWV2ZSBmbXQwIGFuZCBwdXQgaXQgb24gSHogKi8N
Ci0Jc2Vuc29yLT5mbXQwID0gQURKVVNUICogcmVhZGxfcmVsYXhlZChzZW5zb3ItPmJhc2UgKyBE
VFNfVDBWQUxSMV9PRkZTRVQpDQotCQkJCQkgICAgICAmIFRTMV9GTVQwX01BU0s7DQorCXNlbnNv
ci0+Zm10MCA9IEFESlVTVCAqIChyZWFkbF9yZWxheGVkKHNlbnNvci0+YmFzZSArDQorCQkJCSBE
VFNfVDBWQUxSMV9PRkZTRVQpICYgVFMxX0ZNVDBfTUFTSyk7DQogDQogCS8qIFJldHJpZXZlIHJh
bXAgY29lZmZpY2llbnQgKi8NCiAJc2Vuc29yLT5yYW1wX2NvZWZmID0gcmVhZGxfcmVsYXhlZChz
ZW5zb3ItPmJhc2UgKyBEVFNfUkFNUFZBTFJfT0ZGU0VUKSAmDQpAQCAtNTMyLDYgKzUzMiwxMCBA
QCBzdGF0aWMgaW50IHN0bV90aGVybWFsX3ByZXBhcmUoc3RydWN0IHN0bV90aGVybWFsX3NlbnNv
ciAqc2Vuc29yKQ0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCiANCisJcmV0ID0gc3RtX3Ro
ZXJtYWxfcmVhZF9mYWN0b3J5X3NldHRpbmdzKHNlbnNvcik7DQorCWlmIChyZXQpDQorCQlnb3Rv
IHRoZXJtYWxfdW5wcmVwYXJlOw0KKw0KIAlyZXQgPSBzdG1fdGhlcm1hbF9jYWxpYnJhdGlvbihz
ZW5zb3IpOw0KIAlpZiAocmV0KQ0KIAkJZ290byB0aGVybWFsX3VucHJlcGFyZTsNCkBAIC02MzYs
MTAgKzY0MCw2IEBAIHN0YXRpYyBpbnQgc3RtX3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCiAJLyogUG9wdWxhdGUgc2Vuc29yICovDQogCXNlbnNvci0+YmFzZSA9
IGJhc2U7DQogDQotCXJldCA9IHN0bV90aGVybWFsX3JlYWRfZmFjdG9yeV9zZXR0aW5ncyhzZW5z
b3IpOw0KLQlpZiAocmV0KQ0KLQkJcmV0dXJuIHJldDsNCi0NCiAJc2Vuc29yLT5jbGsgPSBkZXZt
X2Nsa19nZXQoJnBkZXYtPmRldiwgInBjbGsiKTsNCiAJaWYgKElTX0VSUihzZW5zb3ItPmNsaykp
IHsNCiAJCWRldl9lcnIoJnBkZXYtPmRldiwgIiVzOiBmYWlsZWQgdG8gZmV0Y2ggUENMSyBjbG9j
a1xuIiwNCi0tIA0KMi43LjQNCg==
