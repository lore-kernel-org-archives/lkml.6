Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61737C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C45214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C45214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeIZWOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41319 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728181AbeIZWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:47 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8QFOI7D017966;
        Wed, 26 Sep 2018 18:01:01 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mqq3n759p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 18:01:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C771331;
        Wed, 26 Sep 2018 16:01:00 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8BC2C509E;
        Wed, 26 Sep 2018 16:01:00 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 26 Sep
 2018 18:01:00 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Wed, 26 Sep 2018 18:01:00 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Anup Patel <anup@brainfault.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH v4 00/17] remoteproc: add fixed memory region support
Thread-Topic: [PATCH v4 00/17] remoteproc: add fixed memory region support
Thread-Index: AQHUJavafIDwx5YKDkaOdbwMbJ6kvaT6dRyAgAihvbA=
Date:   Wed, 26 Sep 2018 16:00:59 +0000
Message-ID: <99dd0f89ce60402fa606245b2e8dde0c@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <CAAhSdy1SKaX+sZHGzExZVKFP9fOsYec+iiEMbxjSf_iSauasQQ@mail.gmail.com>
In-Reply-To: <CAAhSdy1SKaX+sZHGzExZVKFP9fOsYec+iiEMbxjSf_iSauasQQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW51cCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnVwIFBh
dGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyMSwg
MjAxOCA4OjA1IEFNDQo+IFRvOiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT4N
Cj4gQ2M6IEJqb3JuIEFuZGVyc3NvbiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+OyBPaGFk
IEJlbi1Db2hlbg0KPiA8b2hhZEB3aXplcnkuY29tPjsgbGludXgtcmVtb3RlcHJvY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnIExpc3QgPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBBcm5hdWQNCj4gUE9VTElRVUVOIDxhcm5hdWQucG91bGlx
dWVuQHN0LmNvbT47IEJlbmphbWluIEdhaWduYXJkDQo+IDxiZW5qYW1pbi5nYWlnbmFyZEBsaW5h
cm8ub3JnPjsgcy1hbm5hQHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAwLzE3XSBy
ZW1vdGVwcm9jOiBhZGQgZml4ZWQgbWVtb3J5IHJlZ2lvbiBzdXBwb3J0DQo+IA0KPiBIaSBMb2lj
L0Jqb3JuLA0KPiANCj4gQ2FuIHdlIGNvbnNpZGVyIHRoaXMgc2VyaWVzIGZvciB2NC4yMD8NCg0K
SSBkaXNjdXNzZWQgd2l0aCBCam9ybiBsYXN0IHdlZWsgYXQgTGluYXJvIGNvbm5lY3QuDQpIZSBz
aG91bGQgcmV2aWV3IHRoZSBzZXJpZXMgaG9wZWZ1bGx5IHNvb24uDQo+IA0KPiBJIGFtIGludGVy
ZXN0ZWQgaW4gZm9yIHBhdGNoICJycG1zZzogdmlydGlvOiBhbGxvY2F0ZSBidWZmZXINCj4gZnJv
bSBwYXJlbnQiLiBUaGlzIHBhdGNoIGFsbG93cyBtZSB0byB1c2VkIFZpcnRJTw0KPiBSUE1TRyBk
cml2ZXIgaW5zaWRlIEd1ZXN0L1ZNLg0KUGxlYXNlIHNlbmQgeW91ciBhY2tlZC1ieSBvciByZXZp
ZXdlZC1ieSBvciB0ZXN0ZWQtYnkgDQpJdCB3aWxsIGhlbHAgQmpvcm4gdG8gc2VlIGludGVyZXN0
IGZvciB0aGlzIHNlcmllcw0KDQpSZWdhcmRzLA0KTG9pYw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBB
bnVwDQo=
