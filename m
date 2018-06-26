Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77AE26695
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77AE26695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeFZIRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:17:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43347 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752189AbeFZIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:17:33 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5Q8EV6N014804;
        Tue, 26 Jun 2018 10:17:27 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2juhf48455-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 10:17:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86BE059;
        Tue, 26 Jun 2018 08:17:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB90715A4;
        Tue, 26 Jun 2018 08:17:23 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 10:17:23 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Tue, 26 Jun 2018 10:17:23 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Anup Patel <anup@brainfault.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v3 00/13] remoteproc: add fixed memory region support
Thread-Topic: [PATCH v3 00/13] remoteproc: add fixed memory region support
Thread-Index: AQHTsXm52AmRE8n/bkGgITRbf19uP6Rw4ymAgAIF2bA=
Date:   Tue, 26 Jun 2018 08:17:23 +0000
Message-ID: <ac8b7abca08548149e67540cc2187542@SFHDAG7NODE2.st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <CAAhSdy2vVyp_LtyiX0CQ0N=1KzgNPk4BtwOScndYEVoFSq8msw@mail.gmail.com>
In-Reply-To: <CAAhSdy2vVyp_LtyiX0CQ0N=1KzgNPk4BtwOScndYEVoFSq8msw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW51cCwNCg0KU29ycnkgYnVzeSBvbiBTVCBpbnRlcm5hbCBzdHVmZi4gSSdsbCBzZW5kIFY0
IGludGVncmF0aW5nIEJqb3JuJ3MgY29tbWVudHMgaW4gdGhlIGNvbWluZyBkYXlzLg0KDQpSZWdh
cmRzLA0KTG9pYw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFudXAg
UGF0ZWwgW21haWx0bzphbnVwQGJyYWluZmF1bHQub3JnXQ0KPiBTZW50OiBNb25kYXksIEp1bmUg
MjUsIDIwMTggNToyMyBBTQ0KPiBUbzogTG9pYyBQQUxMQVJEWSA8bG9pYy5wYWxsYXJkeUBzdC5j
b20+OyBCam9ybiBBbmRlcnNzb24NCj4gPGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnPg0KPiBD
YzogT2hhZCBCZW4tQ29oZW4gPG9oYWRAd2l6ZXJ5LmNvbT47IGxpbnV4LQ0KPiByZW1vdGVwcm9j
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyBMaXN0IDxsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IEFybmF1ZCBQT1VMSVFVRU4gPGFybmF1ZC5w
b3VsaXF1ZW5Ac3QuY29tPjsNCj4gYmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDAwLzEzXSByZW1vdGVwcm9jOiBhZGQgZml4ZWQgbWVtb3J5IHJl
Z2lvbiBzdXBwb3J0DQo+IA0KPiBIaSBMb2ljIFBhbGxhcmR5LCBCam9ybiBBbmRlcnNzb24sDQo+
IA0KPiBUaGlzIHBhdGNoc2V0IGFsc28gaGVscHMgaW4gZ2V0dGluZyBWaXJ0SU8gUlBNU0cgZHJp
dmVyIHdvcmtpbmcNCj4gd2l0aCBWaXJ0SU8gTU1JTyB0cmFuc3BvcnQuDQo+IA0KPiBJcyBpdCBw
b3NzaWJsZSB0byBoYXZlIHRoaXMgcGF0Y2hzZXQgcGFydCBvZiBMaW51eC00LjE5IG9yIExpbnV4
LTQuMjA/DQo+IA0KPiBSZWdhcmRzLA0KPiBBbnVwDQo=
