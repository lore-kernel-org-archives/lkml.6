Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F95C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2832175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="L1V9YCed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfA1RNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:13:17 -0500
Received: from mail-eopbgr20118.outbound.protection.outlook.com ([40.107.2.118]:4613
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732663AbfA1RNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nR1vSAtGuaE7dhyoouoSQey1vrSoEeyY45fc06RF0Q=;
 b=L1V9YCedadCeWXjMDYvzkq25vXLAc4n3wCy1aZ0lpyu1hk67uA350cw7X72MG2v28kFBNIQ4y88VvJ7L6z+q0rrRqKcX7M0le9rjWRlssnNXiHv3w06qEdRAj0a623oDXj7qfgC5JDQBO2svKUnaIbMgnF2o1wJhHlSriGhPN/4=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3609.eurprd07.prod.outlook.com (10.167.126.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10; Mon, 28 Jan 2019 17:13:11 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::a8ac:38d7:8a41:438]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::a8ac:38d7:8a41:438%4]) with mapi id 15.20.1580.014; Mon, 28 Jan 2019
 17:13:11 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 4.14 revert "seccomp: add a selftest for get_metadata"
Thread-Topic: 4.14 revert "seccomp: add a selftest for get_metadata"
Thread-Index: AQHUtyy/cSe05BWfZ0ywaC9Q4cmtOg==
Date:   Mon, 28 Jan 2019 17:13:11 +0000
Message-ID: <8d246df3cdf19608cb6a043bf1dabe8f0adcae6d.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0702MB3609;6:mEoUdvM3uFtPoZdI4xx4LhbG0xVG+AxHPONiJmIXW3PASVo5smY6IFKxapLqlLtMvFWEKNRKMfdhHurI15CZT6AdrN+fA4qiVNcLMGtTMKS37mbT8Fmd4lUKidL0ulhf3fW42dq4yrsGSa7l1lVGT5y2oJu8VOm8PU2YmDCtllh/ORhqAm4hrlHqcetAXW6Bxw2DnHJfEwyG2fnCA7+4Qff7pYffmrZY13yB1P76JiDjOjQ2pnI6iD6m5EX31WaAKYCD7slMvpHLjB5cKaQBxlgt03GVsTexvgsq3OWCknHvutAe5JVUdIKQ9C11K3VZI0jo4jFJLlLuB+GvmNU7HPXNEW44J0v8qlMHV5GeBPzKoj6BGt+TdYKW0XthqXUSj78O4/EbAxb51b3GrBMJayKw+Yp4e5oEz0tTmIfVnoXlDIk4TlqcfQZTj1nvkSFxIkN8LbE6iq7mK2vgqo1E5Q==;5:YGF3k4+DNOysk9sZROvA0aaXveKiqhu1qenYOtNGDn7Xq0LZeigxxlFBlI0uBkYy14hqdHAheyXXQdHP0IGcFjVEMNooQa4l/nn7nvIRH1t9Wh0aOjmVwXfgT11TfTIQI+ITKnHUe7aVN2M7S3fbmw4qASA8LJ/cL9n2DBfqYBrco38tZgfBQf/FHfmFYdT/FzllsxV9/8RlokiGgido7g==;7:np2D+fMjlztkKChQgLn8AH0WMQlPAJ3WmoYDNdV3JEWPnuKHGEA6Q1Xym3LjfnkD/wlg40iAl/wHZCkTQMBu486C67azPJ0LvRSm3OfCINcxuYeNgXhPu/+t3g14Fo9WnUbSnMpLZRIx8te+0HbEYg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0165b1e1-dbd6-4007-40e6-08d68543e19f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3609;
x-ms-traffictypediagnostic: HE1PR0702MB3609:
x-microsoft-antispam-prvs: <HE1PR0702MB3609B41A0A0CAE89D7EF3209B4960@HE1PR0702MB3609.eurprd07.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(136003)(366004)(396003)(199004)(189003)(7736002)(6916009)(305945005)(66066001)(3846002)(2616005)(476003)(6486002)(8676002)(68736007)(8936002)(256004)(6116002)(14444005)(99286004)(81156014)(4744005)(81166006)(1730700003)(486006)(478600001)(316002)(118296001)(186003)(26005)(106356001)(36756003)(97736004)(6436002)(25786009)(2906002)(5640700003)(71190400001)(71200400001)(4326008)(2501003)(102836004)(6512007)(53936002)(6506007)(2351001)(14454004)(450100002)(105586002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3609;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 17hMwZqE6i24k/QoCWEfx6OGJICbeafRs2BfHsRNCtZXyaZUnh4fi4tWOyjEK7E6L/wYj+ucZr91eNc2/bXYAYfxYRCnvoNabMSPXBjWNWqS1zMRto1I8RTfI3TyBPqLeUczPwS4fXvOqsKYsjs2m4Gq9KD+0nO1oI8VKdJelKgvjoEL4krvV96pH4npPNHK04b67VTcQYvKpCB9P2rFvEkKDII5bHLA3amMK98YXI/TstT2K9vX9LbVPqpd5Xt1zIYMw6caLVsPrvtLZIMO4fZRHhGOtQxe3bFqEsrAMFDFCArdIJGWnHxoJhp7OR+NMmxXUAs9p5iXqYkz+ncu2nNll3DebPXSyfpHrP3BQDafX9tjUrEVy1dEJAGEBqUGfIG/vmi3f5XNb4zKbCgAEhJfJBxEBQfyZvNnr3oytHI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5C6378125401C4EA4200A5FE7040611@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0165b1e1-dbd6-4007-40e6-08d68543e19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 17:13:11.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KQ2FuIHlvdSBwbGVhc2UgcmV2ZXJ0IHRoaXMgY29tbWl0IGluIDQuMTQ/DQoN
CmNvbW1pdCBlNjVjZDlhMjAzNDNlYTkwZjU3NmMyNGMzOGVlODVhYjZlN2Q1ZmVjDQpBdXRob3I6
IFR5Y2hvIEFuZGVyc2VuIDx0eWNob0B0eWNoby53cz4NCkRhdGU6ICAgVHVlIEZlYiAyMCAxOTo0
Nzo0NyAyMDE4IC0wNzAwDQoNCiAgICBzZWNjb21wOiBhZGQgYSBzZWxmdGVzdCBmb3IgZ2V0X21l
dGFkYXRhDQogICAgDQogICAgWyBVcHN0cmVhbSBjb21taXQgZDA1N2RjNGUzNWUxNjA1MGJlZmEz
ZGRhOTQzODc2ZGFiMzljYmY4MCBdDQogICAgDQogICAgTGV0J3MgdGVzdCB0aGF0IHdlIGdldCB0
aGUgZmxhZ3MgY29ycmVjdGx5LCBhbmQgdGhhdCB3ZSBwcmVzZXJ2ZQ0KdGhlIGZpbHRlcg0KICAg
IGluZGV4IGFjcm9zcyB0aGUgcHRyYWNlKFBUUkFDRV9TRUNDT01QX0dFVF9NRVRBREFUQSkgY29y
cmVjdGx5Lg0KDQoNCg0KUFRSQUNFX1NFQ0NPTVBfR0VUX01FVEFEQVRBIHdhcyBvbmx5IGFkZGVk
IGluIDQuMTYNCigyNjUwMDQ3NWFjMWI0OTlkODYzNmZmMjgxMzExZDYzMzkwOWY1ZDIwKQ0KDQoN
CkFuZCBpdCdzIGFsc28gYnJlYWtpbmcgc2VjY29tcF9icGYuYyBjb21waWxhdGlvbiBmb3IgbWU6
DQoNCnNlY2NvbXBfYnBmLmM6IEluIGZ1bmN0aW9uIOKAmGdldF9tZXRhZGF0YeKAmToNCnNlY2Nv
bXBfYnBmLmM6Mjg3ODoyNjogZXJyb3I6IHN0b3JhZ2Ugc2l6ZSBvZiDigJhtZOKAmSBpc27igJl0
IGtub3duDQogIHN0cnVjdCBzZWNjb21wX21ldGFkYXRhIG1kOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgICBefg0KDQotVG9tbWkNCg0K
