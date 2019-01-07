Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497C6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240E52087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfAGIuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:50:44 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14982 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbfAGIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:50:43 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x078fexa030486;
        Mon, 7 Jan 2019 09:50:18 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptybmp9pv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 07 Jan 2019 09:50:18 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63D743D;
        Mon,  7 Jan 2019 08:50:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C6AB2713;
        Mon,  7 Jan 2019 08:50:17 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 7 Jan
 2019 09:50:16 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 7 Jan 2019 09:50:16 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: st_fdma: use struct_size() in kzalloc()
Thread-Topic: [PATCH] dmaengine: st_fdma: use struct_size() in kzalloc()
Thread-Index: AQHUpF1ix7uI5wB8fU21b6FQMnj6mKWjcoWA
Date:   Mon, 7 Jan 2019 08:50:16 +0000
Message-ID: <d5817730-980d-0295-d4fb-43bd34b89e7e@st.com>
References: <20190104184322.GA9615@embeddedor>
In-Reply-To: <20190104184322.GA9615@embeddedor>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6E5608DF6E9D4EA4E25F48D85F6408@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VzdGF2bw0KDQpPbiAxLzQvMTkgNzo0MyBQTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90
ZToNCj4gT25lIG9mIHRoZSBtb3JlIGNvbW1vbiBjYXNlcyBvZiBhbGxvY2F0aW9uIHNpemUgY2Fs
Y3VsYXRpb25zIGlzIGZpbmRpbmcgdGhlDQo+IHNpemUgb2YgYSBzdHJ1Y3R1cmUgdGhhdCBoYXMg
YSB6ZXJvLXNpemVkIGFycmF5IGF0IHRoZSBlbmQsIGFsb25nIHdpdGggbWVtb3J5DQo+IGZvciBz
b21lIG51bWJlciBvZiBlbGVtZW50cyBmb3IgdGhhdCBhcnJheS4gRm9yIGV4YW1wbGU6DQo+IA0K
PiBzdHJ1Y3QgZm9vIHsNCj4gICAgIGludCBzdHVmZjsNCj4gICAgIHZvaWQgKmVudHJ5W107DQo+
IH07DQo+IA0KPiBpbnN0YW5jZSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBmb28pICsgc2l6ZW9m
KHZvaWQgKikgKiBjb3VudCwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBJbnN0ZWFkIG9mIGxlYXZpbmcg
dGhlc2Ugb3Blbi1jb2RlZCBhbmQgcHJvbmUgdG8gdHlwZSBtaXN0YWtlcywgd2UgY2FuIG5vdw0K
PiB1c2UgdGhlIG5ldyBzdHJ1Y3Rfc2l6ZSgpIGhlbHBlcjoNCj4gDQo+IGluc3RhbmNlID0ga3ph
bGxvYyhzdHJ1Y3Rfc2l6ZShpbnN0YW5jZSwgZW50cnksIGNvdW50KSwgR0ZQX0tFUk5FTCk7DQo+
IA0KPiBUaGlzIGNvZGUgd2FzIGRldGVjdGVkIHdpdGggdGhlIGhlbHAgb2YgQ29jY2luZWxsZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRk
ZWRvci5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9kbWEvc3RfZmRtYS5jIHwgMyArLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2RtYS9zdF9mZG1hLmMgYi9kcml2ZXJzL2RtYS9zdF9mZG1hLmMNCj4g
aW5kZXggMDdjMjBhYTJlOTU1Li5kZjZiNzMwMjhlY2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
ZG1hL3N0X2ZkbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9zdF9mZG1hLmMNCj4gQEAgLTI0Myw4
ICsyNDMsNyBAQCBzdGF0aWMgc3RydWN0IHN0X2ZkbWFfZGVzYyAqc3RfZmRtYV9hbGxvY19kZXNj
KHN0cnVjdCBzdF9mZG1hX2NoYW4gKmZjaGFuLA0KPiAgCXN0cnVjdCBzdF9mZG1hX2Rlc2MgKmZk
ZXNjOw0KPiAgCWludCBpOw0KPiAgDQo+IC0JZmRlc2MgPSBremFsbG9jKHNpemVvZigqZmRlc2Mp
ICsNCj4gLQkJCXNpemVvZihzdHJ1Y3Qgc3RfZmRtYV9zd19ub2RlKSAqIHNnX2xlbiwgR0ZQX05P
V0FJVCk7DQo+ICsJZmRlc2MgPSBremFsbG9jKHN0cnVjdF9zaXplKGZkZXNjLCBub2RlLCBzZ19s
ZW4pLCBHRlBfTk9XQUlUKTsNCj4gIAlpZiAoIWZkZXNjKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4g
IA0KPiANCg0KDQpBY2tlZC1ieTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3Qu
Y29tPg0KDQpUaGFua3M=
