Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54099C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F32204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="d2PeQX9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F32204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeKBVPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:15:06 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:54883
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeKBVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIN1TC0COD4yHGP2vSd1F8mB6588nCvyRwErHiW8IdY=;
 b=d2PeQX9bPbVO1t6rN/uqsFYQRCe7qE+iafPyqd9BWN2KkYPR7RiQIwKwuqbgksnhyGC8RNOZWXpCpy1U0wQCvrqp/vn0YF95EOqaYwI9lph2eb5IJKp4RbPLRIIrPAkR9floBYOosR0eTlheI46AMDHoslHCGbcf9vos6JUCSdA=
Received: from AM6PR08MB3686.eurprd08.prod.outlook.com (20.177.199.159) by
 AM6PR08MB3895.eurprd08.prod.outlook.com (20.178.91.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 2 Nov 2018 12:08:04 +0000
Received: from AM6PR08MB3686.eurprd08.prod.outlook.com
 ([fe80::2cbd:c62d:7b33:6d84]) by AM6PR08MB3686.eurprd08.prod.outlook.com
 ([fe80::2cbd:c62d:7b33:6d84%6]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 12:08:04 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "acme@redhat.com" <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Coresight ML <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Question: perf dso support for /proc/kallsyms
Thread-Topic: Question: perf dso support for /proc/kallsyms
Thread-Index: AQHUcleHgK1sdrL48kCD7i8o9dowk6U8YImA
Date:   Fri, 2 Nov 2018 12:08:04 +0000
Message-ID: <AM6PR08MB3686A4DD9B75B551885C790386CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
In-Reply-To: <20181102025516.GA25374@leoy-ThinkPad-X240s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Al.Grant@arm.com; 
x-originating-ip: [217.140.106.49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3895;6:p/J9zS2fmTlDeMxBV0jH0JdMTt0trFdWaA6pYe2Ag/i6k9tM1rZCsiyj3+gLGmybPuaGaqxjguhy3OnoQUgQag3n3wvEFcMYtXMfWqxMJzzpJ9HNkPrB87Z9OenuC8aJ8JmtE/5YuWj73Onn+waUBYRqxT2Rlc1lAes5ckbyKQllc2YAbwE2uHCEeNgGp084NtQ+ND1TRb0Nvcc+fmQK5JGikhw3OIgGHWftzzrvVmn6AaNGxCWTbT+gkkBbRRGm1aihW2YSMKwDxmZ6IkkYUpltBIwLF0tTy6GBHJGB+HIjw6av9IEHdCgEigAdrUQCCn4ftvbCw4GE/DcjJh5m/gHEOweVQ834C2x/AF0m/n4xxWqsgnX41QgaiWMYukE2RvGUfYIWbk366MufiFWTgkExEc2XWpwmNqvYMJQHa5m2/7NiHnih6iEM99npAHc6JyZbGKbRda9DBc+MJVmybw==;5:TbCEwHsd5XhlcIV2/PoC8M/MkCiRGXt5f/SfMj6ZSYFY4uyqMiztGGFBMiuI8v/oibRxLfqsp/Xfm7Coys49aS+/z6MyupS+eWblswq74KubOL9B9UoUd769SkK1dKA/XegAwDlbSp+0AU989BLr3kRX19cGx4EBZHm48zSLoT4=;7:m2qK7nJrJv4DgX7blzvQgoOVxctswP2zMEJC8/JcMjZF4mUN+s9CE9Tf5rbpgxNxanQOv3n7RXmqOtIWFXy/pxxUF6o44bVC2GZE4cs0Dj5ix1RoERFioPfnIyt9y6gp6YmIi38vC40PEJTLo+LRqw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c62c8ca3-e58b-4237-85e9-08d640bbd7e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3895;
x-ms-traffictypediagnostic: AM6PR08MB3895:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-microsoft-antispam-prvs: <AM6PR08MB3895312343845C4F542DA15886CF0@AM6PR08MB3895.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3895;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3895;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(40434004)(3846002)(5024004)(54906003)(6116002)(256004)(2501003)(110136005)(86362001)(14444005)(106356001)(8676002)(81166006)(5660300001)(81156014)(74316002)(33656002)(316002)(486006)(476003)(446003)(11346002)(186003)(2900100001)(2906002)(102836004)(478600001)(9686003)(6246003)(97736004)(26005)(55016002)(6436002)(76176011)(68736007)(105586002)(229853002)(7696005)(25786009)(8936002)(14454004)(4326008)(66066001)(71200400001)(71190400001)(6506007)(53936002)(72206003)(7736002)(305945005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3895;H:AM6PR08MB3686.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nkkpjzLwrOmzxOmd7nph9SPIWkGLmLAIah0mQtr8cygNM9SEmdgTHZ2OZhD0LLnfiae3oErQnCBomeFiyaJJbuN2iPOob64twJpG208vqpaDoQbIxc2aVzi/fkUYQY/vJcROsWOKDSnMNjZWmRHlNQcO+p7d0AaMPdqcM2na+R8bhAaPo6MiAjMiasRPcADJbwhsnUoMVbpqAy6RCLjkLdJFYWGQKy4jTKkqq7gmeYsFDA0DFcG7qWHEYLPdv13NgmZpRIq0h3yTz30yvXMAD3AhQIcfFTTZrw3PXgyqc7cUWlAe+OvRVacZBMu6gd1MwoNkv7Vd6yu+M6jfgk0P/z8g957mNZzP5VomBKowSq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62c8ca3-e58b-4237-85e9-08d640bbd7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 12:08:04.4510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBOb3cgSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIGhvdyB0aGUgZHNvL21hcCBzdXBwb3J0ICIv
cHJvYy9rYWxsc3ltcyIgYW5kDQo+IGhhdmUgbm8gaWRlYSB0byBmaXggdGhpcyBpc3N1ZSwgdGhv
dWdoIEkgc3BlbnQgc29tZSB0aW1lIHRvIGxvb2sgaW50byBpdC4NCg0KVGhlIHdheSB0aGlzIGlz
IHN1cHBvcnRlZCBpcyB0aGF0IGF0IHJlY29yZCB0aW1lLCBwc2V1ZG8gbW1hcCByZWNvcmRzDQph
cmUgY3JlYXRlZCBmb3IgdGhlIGtlcm5lbC4gQnV0IGRlcGVuZGluZyBvbiBwZXJtaXNzaW9ucyB0
aGVzZSBtaWdodA0Kbm90IGdldCBjcmVhdGVkLiBUaGlzIGlzbid0IGp1c3QgYW4gRVRNIGlzc3Vl
LCBpdCBjYW4gaGFwcGVuIG9uIEludGVsIHRvby4NCg0KV2hhdCBkbyB5b3Ugc2VlIGluICJwZXJm
IHJlcG9ydCAtRCIsIGRvIHlvdSBzZWUgYSBQRVJGX1JFQ09SRF9NTUFQDQpyZWNvcmQgZm9yICJb
a2VybmVsLmthbGxzeW1zXV90ZXh0IiBhbmQgcG9zc2libHkgc29tZSBvdGhlcnMgZm9yIGxvYWRh
YmxlDQprZXJuZWwgbW9kdWxlcyBpbiAvbGliL21vZHVsZXM/DQoNCkRvZXMgaXQgYWxsIHdvcmsg
aWYgeW91IHJ1biBwZXJmIHJlY29yZCBhcyBzdWRvPyBPciBpZiB5b3UgZG8NCg0KICAgc3VkbyBz
eXNjdGwga2VybmVsLmtwdHJfcmVzdHJpY3Q9MA0KDQpiZWZvcmUgeW91IHJ1biBwZXJmIHJlY29y
ZD8NCg0KQWwNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFu
ZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmls
ZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRz
IHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9y
IGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
