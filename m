Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3157C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF04222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="xfqpZjE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391084AbfBMJAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:00:32 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:31721 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391024AbfBMJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:00:09 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="26473945"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 02:00:08 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 02:00:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nczkVjZQpLKzBXuSAswPvKJaT3FdRaOMyekFqsZSjaA=;
 b=xfqpZjE5cZxabaZtbN0DJGRKl7cv0hGh54HCLD8Zuq8rz89lJmu7GaZFLlS0AWE8JJ7gZllzZAnz4VwUw0C/3Po/X9aL13+V2eXeFTR1k3NPpFDZQ6IQ42Ujgud21CpkPl0MuRoFWwVHZPHG7RCxaL2uQwI9cqMi5OHoImmBrMQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 09:00:05 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:00:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 07/11] mtd: rawnand: atmel: add sam9x60 nand controller
 support
Thread-Topic: [PATCH 07/11] mtd: rawnand: atmel: add sam9x60 nand controller
 support
Thread-Index: AQHUw3qCWFNDodb6ZkCALjA5DxGPkQ==
Date:   Wed, 13 Feb 2019 09:00:05 +0000
Message-ID: <20190213085930.31578-8-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2de62273-21b2-4a3f-6652-08d69191a534
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIwMDE5OzIzOjV5QWc1RFV0SWZWbEdwWDFvZ0tiTmZqNXV6?=
 =?utf-8?B?MFZQVjJnSmpkOWc2cVNaRmZUekFRUXp4RWR5aVdYRG52Q0ZSR1ZhV1lxdHFj?=
 =?utf-8?B?QUdPS2RjVFVYdlRxaDVYSWV0anBDLzZsbTY4eWw5ZWN1SlFyNjV4RHI0SSsv?=
 =?utf-8?B?ajIycEdMM0R3dUx2alErWWZWVUhLL0oybEJTZzhUSTQ3VlRLeHkySjQxWlRW?=
 =?utf-8?B?cUVxcFhwMjNkdFpqaFBjakJiV3NVbkhvTUE1YUFOVzRvUk1wMm9PTXM2MkhE?=
 =?utf-8?B?SFl3Q0l2RS8rekExdmNPZzNDU09vWmlOZHhTWnhySmlURWxSMzZLOGNzcTRH?=
 =?utf-8?B?OXI3azRONGF6bVRISzFPU01ZNHVBeEEweDUvN0lreWdzZlRGNndCcEgzVDBP?=
 =?utf-8?B?MUZkUmtzUmlRMHhlUGZRd1JTMmxjOEZXUnNhQlRTUWhVeWhITTBCcGlqcldW?=
 =?utf-8?B?V2lrMjNzNlRCUEZZU3h6QVE1VjJlN0NYZTVuZW9udG5acjR2MGhPTVMwMFZo?=
 =?utf-8?B?N1FhUUNHS2dTS01VcWc1bkF5S1VsamZqVWYxU1d4VXExVmFRVk5tVjhOWXZT?=
 =?utf-8?B?ajBwNTI0czdrYUdmVytaYnExN1lUYTNSSkVQOWpjQkNOVEk1dlkrb0dTSW9K?=
 =?utf-8?B?c3Y4WWJpQU5VSnhjOTFOT21RMEFYVElGU0dNUEJWSGRJVkdFdXVCQWRYVHRk?=
 =?utf-8?B?d3lQS3c0TTZjVVV2QzZHT0dHaHhiakJZK3V4cHBmNnhkOUhVVTFsSWdlekNH?=
 =?utf-8?B?Q2lzSXV6MW9uYVJhdXo4ZlBUbXVuQm5tdmtiVWRTOC9yTHlCc2M5d0NLb0py?=
 =?utf-8?B?Y1JGa2dFVGxPclIwYXBEaXJCcklHdEhrQ3RFcUoybG8xL2ozWEN6MFJvQmxV?=
 =?utf-8?B?UDlEQktuTEt5QjlVMEk0WTZWTTBIUEttdEJYWHBTb2pBN3dMdkZFRXNPOVR5?=
 =?utf-8?B?ZHdtUGVTc2FLTm9jZmc4L1IyVGFsT0Q1TGxQUEJGREFMaktLU2N6M2NPVndP?=
 =?utf-8?B?RFNJV2RYKzlydzEzS2dHUFJHTmJ5WUNyTUtWbC9KeUZCN3VZaHJQZEZoSXYr?=
 =?utf-8?B?TzdzbWpPR3k3UXpqUk1UdlZtZVNsNlFUKy83REZ2ZHI0bVdPRi8vR1hHVkVz?=
 =?utf-8?B?YlVFK1VVVmZJcTJVNm5VbUZiUXorRWRsempMeGs3dFRqalhORkRkWURBcW9m?=
 =?utf-8?B?d0ZZOGFWS1dOaUhLMUUyM0MwOU5FTTdDaWQrTWZsRndqWVJVcXUxVWZqSzNu?=
 =?utf-8?B?Y2xtd0pxcldiZlFFdXk2bXJ0UktjQ0xGVzFhQWtjWGtIZ3RoanRaWk5pZzZ0?=
 =?utf-8?B?Mm1xdmI0TENQVHVJYVJjRW9XaW9TZmNaSUNGNWM1eGxXMWJ2enR6UGNzeUw0?=
 =?utf-8?B?WnEzZkJuZXcrbUVScEN6bDRROWI0SUNoMXpMbFUyQ3hQYm9TRE9MVjdoMnMz?=
 =?utf-8?B?ZC9POU0xd0lvcmIrSXl3bE9HbkthN1ljZS9rTzY1OFR4cUMzOVhHbWYzU3VI?=
 =?utf-8?B?RDBKdE9VNGpHdVJxUS9wQXRhRkN5VXpDZGI1aFBoT3Brb3JYc24yTkVMM0tz?=
 =?utf-8?B?bG5Sb3B5amtLN0RWSGdVQXp3cDYwTFNsOWY3MkJsajZPOVBIcDNtZDNRb3Rr?=
 =?utf-8?B?UUcrdmZBUjVRM3VHZXg1aGFqTk50cVMvNUdoNjNZRGRQY1grWVpzOExlcldY?=
 =?utf-8?B?NmY3TXlIL2wvOUwwWmkyNFd4V25GWG1jSGkyZGVOTzh5azRPZDNKdVVNdExv?=
 =?utf-8?B?bjBNMmszTGZ2ZG9PZ3NTYWxTckRWUkRTKzh2N0ZxOThnUXN1dDN4dlI3MGp1?=
 =?utf-8?B?a2FvL2c2Qm5XRWdLQlNZa3B3UjQ2VEJjMWZmL1NzQmZBYnc9PQ==?=
x-microsoft-antispam-prvs: <BN6PR11MB0019816180EEF9900E0D66A6F0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(14444005)(5024004)(7736002)(305945005)(256004)(25786009)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OMmkuYu9THGvM2YyN/hHyTfUXWxbyHxWR1icl2unKg8c2TUqJMbB/YJ/vFKly0lyJg/FcFSAOYiNRc+UtjSY+xf613wAZnomI4NFpCBGHxSKEqM8wm+vfrhTBRzJlMtaDE/m17ad1Jd4caXdBEONQjcHVHoHTd9M8Whc7wiX9ewW8z07npPpJ3MJdw/v5V7kIYldq8N+BznwtX0zabsCL802eoiVWlN+0KncO54EVuDKoFeMDRxaIwsfB3U6+Rbqp4DONUuonslBSTP1VdLX6ejG+52dvyQ22O6gEzblTZ218NJwVm8kwo2tQ0lSQfZQTGpH+2Z4Q7EiHWBF6piHatO2onQSegpLYcrSL0ROlu0UuTv9ELmZzoqXGskuunCmjNSI+4gw7q+M+2o6KufHFEtzKe9Wu8/StX84MTC5lpg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2279D3538051D24EA42976561F3BD224@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de62273-21b2-4a3f-6652-08d69191a534
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:00:02.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpUaGUg
c2FtOXg2MCBib2FyZCBkZWZpbmVzIHRoZSBDQ0ZHX0VCSUNTQSByZWdpc3RlciB1bmRlciBTRlIs
DQphbmQgbm90IGFzIGEgTUFUUklYIHJlZ2lzdGVyLCBhcyBwcmV2aW91cyBib2FyZHMgZG8uDQoN
Ck5BTkQgRmxhc2ggSS9PcyBhcmUgY29ubmVjdGVkIHRvIEQxNuKAk0QyMywgdGh1cw0KU0ZSX0ND
RkdfRUJJQ1NBLk5GRDBfT05fRDE2IGlzIHNldCB0byAxLg0KDQpTaWduZWQtb2ZmLWJ5OiBUdWRv
ciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL210
ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYyB8IDg2ICsrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNv
bnRyb2xsZXIuYyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29udHJvbGxlci5j
DQppbmRleCA2YWVmOThiNzMzOGEuLmZmODViZTBlMmRlMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29udHJvbGxlci5jDQorKysgYi9kcml2ZXJzL210ZC9u
YW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0KQEAgLTY1LDYgKzY1LDcgQEANCiAjaW5j
bHVkZSA8bGludXgvaW9wb2xsLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
Pg0KICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCisjaW5jbHVkZSA8c29jL2F0OTEvYXRtZWwt
c2ZyLmg+DQogDQogI2luY2x1ZGUgInBtZWNjLmgiDQogDQpAQCAtMjMyLDEwICsyMzMsMTUgQEAg
dG9fbmFuZF9jb250cm9sbGVyKHN0cnVjdCBuYW5kX2NvbnRyb2xsZXIgKmN0bCkNCiAJcmV0dXJu
IGNvbnRhaW5lcl9vZihjdGwsIHN0cnVjdCBhdG1lbF9uYW5kX2NvbnRyb2xsZXIsIGJhc2UpOw0K
IH0NCiANCitzdHJ1Y3QgYXRtZWxfc21jX25hbmRfZWJpX2NzYV9jZmcgew0KKwl1MzIgb2ZmczsN
CisJdTMyIG5mZDBfb25fZDE2Ow0KK307DQorDQogc3RydWN0IGF0bWVsX3NtY19uYW5kX2NvbnRy
b2xsZXIgew0KIAlzdHJ1Y3QgYXRtZWxfbmFuZF9jb250cm9sbGVyIGJhc2U7DQogCXN0cnVjdCBy
ZWdtYXAgKmViaV9jc2FfcmVnbWFwOw0KLQl1bnNpZ25lZCBpbnQgZWJpX2NzYV9vZmZzOw0KKwlz
dHJ1Y3QgYXRtZWxfc21jX25hbmRfZWJpX2NzYV9jZmcgKmViaV9jc2E7DQogfTsNCiANCiBzdGF0
aWMgaW5saW5lIHN0cnVjdCBhdG1lbF9zbWNfbmFuZF9jb250cm9sbGVyICoNCkBAIC0xNTEzLDgg
KzE1MTksMTUgQEAgc3RhdGljIHZvaWQgYXRtZWxfc21jX25hbmRfaW5pdChzdHJ1Y3QgYXRtZWxf
bmFuZF9jb250cm9sbGVyICpuYywNCiANCiAJLyogQXR0YWNoIHRoZSBDUyB0byB0aGUgTkFORCBG
bGFzaCBsb2dpYy4gKi8NCiAJZm9yIChpID0gMDsgaSA8IG5hbmQtPm51bWNzOyBpKyspDQotCQly
ZWdtYXBfdXBkYXRlX2JpdHMoc21jX25jLT5lYmlfY3NhX3JlZ21hcCwgc21jX25jLT5lYmlfY3Nh
X29mZnMsDQorCQlyZWdtYXBfdXBkYXRlX2JpdHMoc21jX25jLT5lYmlfY3NhX3JlZ21hcCwNCisJ
CQkJICAgc21jX25jLT5lYmlfY3NhLT5vZmZzLA0KIAkJCQkgICBCSVQobmFuZC0+Y3NbaV0uaWQp
LCBCSVQobmFuZC0+Y3NbaV0uaWQpKTsNCisNCisJaWYgKHNtY19uYy0+ZWJpX2NzYS0+bmZkMF9v
bl9kMTYpDQorCQlyZWdtYXBfdXBkYXRlX2JpdHMoc21jX25jLT5lYmlfY3NhX3JlZ21hcCwNCisJ
CQkJICAgc21jX25jLT5lYmlfY3NhLT5vZmZzLA0KKwkJCQkgICBzbWNfbmMtPmViaV9jc2EtPm5m
ZDBfb25fZDE2LA0KKwkJCQkgICBzbWNfbmMtPmViaV9jc2EtPm5mZDBfb25fZDE2KTsNCiB9DQog
DQogc3RhdGljIHZvaWQgYXRtZWxfaHNtY19uYW5kX2luaXQoc3RydWN0IGF0bWVsX25hbmRfY29u
dHJvbGxlciAqbmMsDQpAQCAtMTgzNCwzNCArMTg0Nyw3MSBAQCBzdGF0aWMgdm9pZCBhdG1lbF9u
YW5kX2NvbnRyb2xsZXJfY2xlYW51cChzdHJ1Y3QgYXRtZWxfbmFuZF9jb250cm9sbGVyICpuYykN
CiAJY2xrX3B1dChuYy0+bWNrKTsNCiB9DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBhdG1lbF9z
bWNfbmFuZF9lYmlfY3NhX2NmZyBhdDkxc2FtOTI2MF9lYmlfY3NhID0gew0KKwkub2ZmcyA9IEFU
OTFTQU05MjYwX01BVFJJWF9FQklDU0EsDQorfTsNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IGF0
bWVsX3NtY19uYW5kX2ViaV9jc2FfY2ZnIGF0OTFzYW05MjYxX2ViaV9jc2EgPSB7DQorCS5vZmZz
ID0gQVQ5MVNBTTkyNjFfTUFUUklYX0VCSUNTQSwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgYXRtZWxfc21jX25hbmRfZWJpX2NzYV9jZmcgYXQ5MXNhbTkyNjNfZWJpX2NzYSA9IHsNCisJ
Lm9mZnMgPSBBVDkxU0FNOTI2M19NQVRSSVhfRUJJMENTQSwNCit9Ow0KKw0KK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgYXRtZWxfc21jX25hbmRfZWJpX2NzYV9jZmcgYXQ5MXNhbTlybF9lYmlfY3NhID0g
ew0KKwkub2ZmcyA9IEFUOTFTQU05UkxfTUFUUklYX0VCSUNTQSwNCit9Ow0KKw0KK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgYXRtZWxfc21jX25hbmRfZWJpX2NzYV9jZmcgYXQ5MXNhbTlnNDVfZWJpX2Nz
YSA9IHsNCisJLm9mZnMgPSBBVDkxU0FNOUc0NV9NQVRSSVhfRUJJQ1NBLA0KK307DQorDQorc3Rh
dGljIGNvbnN0IHN0cnVjdCBhdG1lbF9zbWNfbmFuZF9lYmlfY3NhX2NmZyBhdDkxc2FtOW4xMl9l
YmlfY3NhID0gew0KKwkub2ZmcyA9IEFUOTFTQU05TjEyX01BVFJJWF9FQklDU0EsDQorfTsNCisN
CitzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX3NtY19uYW5kX2ViaV9jc2FfY2ZnIGF0OTFzYW05
eDVfZWJpX2NzYSA9IHsNCisJLm9mZnMgPSBBVDkxU0FNOVg1X01BVFJJWF9FQklDU0EsDQorfTsN
CisNCitzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX3NtY19uYW5kX2ViaV9jc2FfY2ZnIHNhbTl4
NjBfZWJpX2NzYSA9IHsNCisJLm9mZnMgPSBBVDkxX1NGUl9DQ0ZHX0VCSUNTQSwNCisJLm5mZDBf
b25fZDE2ID0gQVQ5MV9TRlJfQ0NGR19ORkQwX09OX0QxNiwNCit9Ow0KKw0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0bWVsX2ViaV9jc2FfcmVnbWFwX29mX2lkc1tdID0gew0K
IAl7DQogCQkuY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC1tYXRyaXgiLA0KLQkJLmRh
dGEgPSAodm9pZCAqKUFUOTFTQU05MjYwX01BVFJJWF9FQklDU0EsDQorCQkuZGF0YSA9ICZhdDkx
c2FtOTI2MF9lYmlfY3NhLA0KIAl9LA0KIAl7DQogCQkuY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkx
c2FtOTI2MS1tYXRyaXgiLA0KLQkJLmRhdGEgPSAodm9pZCAqKUFUOTFTQU05MjYxX01BVFJJWF9F
QklDU0EsDQorCQkuZGF0YSA9ICZhdDkxc2FtOTI2MV9lYmlfY3NhLA0KIAl9LA0KIAl7DQogCQku
Y29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2My1tYXRyaXgiLA0KLQkJLmRhdGEgPSAodm9p
ZCAqKUFUOTFTQU05MjYzX01BVFJJWF9FQkkwQ1NBLA0KKwkJLmRhdGEgPSAmYXQ5MXNhbTkyNjNf
ZWJpX2NzYSwNCiAJfSwNCiAJew0KIAkJLmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTlybC1t
YXRyaXgiLA0KLQkJLmRhdGEgPSAodm9pZCAqKUFUOTFTQU05UkxfTUFUUklYX0VCSUNTQSwNCisJ
CS5kYXRhID0gJmF0OTFzYW05cmxfZWJpX2NzYSwNCiAJfSwNCiAJew0KIAkJLmNvbXBhdGlibGUg
PSAiYXRtZWwsYXQ5MXNhbTlnNDUtbWF0cml4IiwNCi0JCS5kYXRhID0gKHZvaWQgKilBVDkxU0FN
OUc0NV9NQVRSSVhfRUJJQ1NBLA0KKwkJLmRhdGEgPSAmYXQ5MXNhbTlnNDVfZWJpX2NzYSwNCiAJ
fSwNCiAJew0KIAkJLmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTluMTItbWF0cml4IiwNCi0J
CS5kYXRhID0gKHZvaWQgKilBVDkxU0FNOU4xMl9NQVRSSVhfRUJJQ1NBLA0KKwkJLmRhdGEgPSAm
YXQ5MXNhbTluMTJfZWJpX2NzYSwNCiAJfSwNCiAJew0KIAkJLmNvbXBhdGlibGUgPSAiYXRtZWws
YXQ5MXNhbTl4NS1tYXRyaXgiLA0KLQkJLmRhdGEgPSAodm9pZCAqKUFUOTFTQU05WDVfTUFUUklY
X0VCSUNTQSwNCisJCS5kYXRhID0gJmF0OTFzYW05eDVfZWJpX2NzYSwNCisJfSwNCisJew0KKwkJ
LmNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtc2ZyIiwNCisJCS5kYXRhID0gJnNhbTl4
NjBfZWJpX2NzYSwNCiAJfSwNCiAJeyAvKiBzZW50aW5lbCAqLyB9LA0KIH07DQpAQCAtMjAwNiwx
NSArMjA1NiwxNSBAQCBhdG1lbF9zbWNfbmFuZF9jb250cm9sbGVyX2luaXQoc3RydWN0IGF0bWVs
X3NtY19uYW5kX2NvbnRyb2xsZXIgKm5jKQ0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KLQluYy0+
ZWJpX2NzYV9vZmZzID0gKHVpbnRwdHJfdCltYXRjaC0+ZGF0YTsNCisJbmMtPmViaV9jc2EgPSAo
c3RydWN0IGF0bWVsX3NtY19uYW5kX2ViaV9jc2FfY2ZnICopbWF0Y2gtPmRhdGE7DQogDQogCS8q
DQogCSAqIFRoZSBhdDkxc2FtOTI2MyBoYXMgMiBFQklzLCBpZiB0aGUgTkFORCBjb250cm9sbGVy
IGlzIHVuZGVyIEVCSTENCi0JICogYWRkIDQgdG8gLT5lYmlfY3NhX29mZnMuDQorCSAqIGFkZCA0
IHRvIC0+ZWJpX2NzYS0+b2Zmcy4NCiAJICovDQogCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJs
ZShkZXYtPnBhcmVudC0+b2Zfbm9kZSwNCiAJCQkJICAgICJhdG1lbCxhdDkxc2FtOTI2My1lYmkx
IikpDQotCQluYy0+ZWJpX2NzYV9vZmZzICs9IDQ7DQorCQluYy0+ZWJpX2NzYS0+b2ZmcyArPSA0
Ow0KIA0KIAlyZXR1cm4gMDsNCiB9DQpAQCAtMjM3Nyw2ICsyNDI3LDE0IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgYXRtZWxfbmFuZF9jb250cm9sbGVyX2NhcHMgYXRtZWxfc2FtOWc0NV9uY19jYXBz
ID0gew0KIAkub3BzID0gJmF0bWVsX3NtY19uY19vcHMsDQogfTsNCiANCitzdGF0aWMgY29uc3Qg
c3RydWN0IGF0bWVsX25hbmRfY29udHJvbGxlcl9jYXBzIG1pY3JvY2hpcF9zYW05eDYwX25jX2Nh
cHMgPSB7DQorCS5oYXNfZG1hID0gdHJ1ZSwNCisJLmFsZV9vZmZzID0gQklUKDIxKSwNCisJLmNs
ZV9vZmZzID0gQklUKDIyKSwNCisJLmViaV9jc2FfcmVnbWFwX25hbWUgPSAibWljcm9jaGlwLHNm
ciIsDQorCS5vcHMgPSAmYXRtZWxfc21jX25jX29wcywNCit9Ow0KKw0KIC8qIE9ubHkgdXNlZCB0
byBwYXJzZSBvbGQgYmluZGluZ3MuICovDQogc3RhdGljIGNvbnN0IHN0cnVjdCBhdG1lbF9uYW5k
X2NvbnRyb2xsZXJfY2FwcyBhdG1lbF9ybTkyMDBfbmFuZF9jYXBzID0gew0KIAkuYWxlX29mZnMg
PSBCSVQoMjEpLA0KQEAgLTI0MjEsNiArMjQ3OSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBhdG1lbF9uYW5kX2NvbnRyb2xsZXJfb2ZfaWRzW10gPSB7DQogCQkuY29tcGF0
aWJsZSA9ICJhdG1lbCxzYW1hNWQzLW5hbmQtY29udHJvbGxlciIsDQogCQkuZGF0YSA9ICZhdG1l
bF9zYW1hNV9uY19jYXBzLA0KIAl9LA0KKwl7DQorCQkuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAs
c2FtOXg2MC1uYW5kLWNvbnRyb2xsZXIiLA0KKwkJLmRhdGEgPSAmbWljcm9jaGlwX3NhbTl4NjBf
bmNfY2FwcywNCisJfSwNCiAJLyogU3VwcG9ydCBmb3Igb2xkL2RlcHJlY2F0ZWQgYmluZGluZ3M6
ICovDQogCXsNCiAJCS5jb21wYXRpYmxlID0gImF0bWVsLGF0OTFybTkyMDAtbmFuZCIsDQotLSAN
CjIuOS41DQoNCg==
