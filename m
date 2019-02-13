Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89695222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Fw0s9xD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392669AbfBMQiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:38:19 -0500
Received: from mail-eopbgr30135.outbound.protection.outlook.com ([40.107.3.135]:63712
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391852AbfBMQiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9z27y2TL7+zjEL+TKbTizhWCZ+Ku4I9ElPCpId1Qao=;
 b=Fw0s9xD8cnYMi7h330zIQoyGbsFZkH5ScHXW+ti6q8pv1HT8cE05Hpxg97cjlVFNoZW6OmIDeP3t6fymM+LShtqGY4fLTlkMhHlqLqiPAn8coa9cA+nDa10aoMbpAVNkXK3AuB4it7uFc/TrMsK3udwde8p3Nvae5U5X9JZgc9w=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3579.eurprd07.prod.outlook.com (52.133.6.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.12; Wed, 13 Feb 2019 16:38:15 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:38:15 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 4.14 perf test patches
Thread-Topic: 4.14 perf test patches
Thread-Index: AQHUw7qEBsG2pGYAi0y7FSIZB3p6Qg==
Date:   Wed, 13 Feb 2019 16:38:14 +0000
Message-ID: <68c69f70bc7b524731c70f1f4fde40c5b16688ef.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e38f9e2d-16e0-4346-0f86-08d691d1a6ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3579;
x-ms-traffictypediagnostic: HE1PR0702MB3579:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA3MDJNQjM1Nzk7MjM6TXVGbEpUMXorRncwNDN1b2dCTXdleXlt?=
 =?utf-8?B?RXpRS0NQSHh3WEJGak5Sd3ZBdHYwKzYzQjd6cFRZdXgrelVsMkdQTUlUUFdt?=
 =?utf-8?B?ZExIL29OUjlnd0xiakR0N1lHZ2tRV3d4K09jeENadWl2d1hVaktBcko3UWp4?=
 =?utf-8?B?TDdWSmZkWGVzQjNQNGp3Vlk3cURmNkJqQWxNcXlYSTg5U2lvZWorMElSWmlN?=
 =?utf-8?B?akthSm96b2U5b0dpenlDcjBJd3pZSzZMMU1rdVU2djRKUloyamFJS09TQUZF?=
 =?utf-8?B?WXJxbTdaVHVPVEdrOElYMzhnUmYwQm1EQnN0VEFsRWtnTGNQWkdxaUl3OUQ2?=
 =?utf-8?B?eVNNWmNFMVUyN3NnRU1IN2NrK0Vad3M1TlVobGxzbjNlZi9YQ3RXUEYrMUs5?=
 =?utf-8?B?OExvbU91Tm5lNStSRk9HdE5VTzcxNjJDTzRueGtvUG1OSVZ3YTJNY2RYSU1F?=
 =?utf-8?B?eG85MnFXT1h4TjBJcllNbGNZVHYwVzNKQzR6SkkxNjFvbXhTTkRjRjhjUmZX?=
 =?utf-8?B?Rzd3VUVNdGUxNjJLVEdheTBtZGJBUDRSdHpFNUpWdEF0aStFVTZnS3ZVYmhY?=
 =?utf-8?B?cnRXQTU5YnBBbExzY0N4T21odHV6R3M2ckJzRnplejdvVGVhTTdXOURsc0Vu?=
 =?utf-8?B?UWkzNzA2c0pEUkxMQlo2cXdRQUUwNm9NWnZJWi8vR3dwQlhFbGtKVHJtVlhG?=
 =?utf-8?B?QmRIUVJCZVhHZm01cno3aXlWWTIxNU9XL3lUcDZINHBQR2g3Yk1aZ2k2Sk1T?=
 =?utf-8?B?UmdMWHdNSkJmMmUwVnBtQ3M0SnN6dGd3aGR5TnJqVzFZWlAvc0drVzlSZnF3?=
 =?utf-8?B?cUNwOHd0bGQ3SEFaUXRvY2YvaEJvdVN2emp3YTQ4Y0FPR0wyR0tRdVFsb3hJ?=
 =?utf-8?B?RnlQS3JiUHFjbjFId09XbCsxR0J4VmlVZnJOU2N1SmJTdmtxaGpaVjZ4V1c1?=
 =?utf-8?B?Umovb3lzcThmb3M1TndvUHNDK1R6REg0L3hwSDZOd2M5b2o3d3BhQnVPOVMy?=
 =?utf-8?B?VVgzTHBMWnpNOE56TjhVQkk0UlJCa3lvVG5nNVlPM050ZTBNVk1zZkVIa0dz?=
 =?utf-8?B?d2k3OWVpYjRqcDVMWmxkbnVLUTlZenZBbTEzaUJ4YXZ2NlhIQXhlNFdnSVlI?=
 =?utf-8?B?S3pQL0NRNkhrbkJubXlSb2hialprR21oR2txbG4rWG5GUmxVMHBXMWlncXdL?=
 =?utf-8?B?c25xNzU3VjJhd3lhd216QWY0TXl1L0VOVmtQUHlKaTRlY3RrZmk1RmtwRXVT?=
 =?utf-8?B?c2JuanNvcTVGV1JCWnh3SUN0b29oVjFkV1VvUk1ZVFlwcFZYMWhJZEVPRnpQ?=
 =?utf-8?B?TmROcHh6Y2s3MGpaRForOVlhTG1qZWlEa3FrWUFWK3A3RzNsa3lLQURUa3Rk?=
 =?utf-8?B?cHRjeDVuRHF6Z09TZCtneTNreURDOHVWdkZtTi9uMjlDV3pMZ3FkdGRXemg0?=
 =?utf-8?B?Q0tSbDhCNGk0ZHNXSEpMWUlWOUgxaWlKbDRhYkRyS1BzMDBDa21MajZTeVNL?=
 =?utf-8?B?emdmV1l0Rk5GM1F4QThwWTRUZkIyMmNVSW8rREs1OU9LL0phSE9kbmZCWFhF?=
 =?utf-8?B?NVJMQ3FUeUhtbzROa25FYmZzUHdjWmNRakhaSWE1UnNweEdSZit5VnhxSldX?=
 =?utf-8?Q?c=3D?=
x-microsoft-antispam-prvs: <HE1PR0702MB35799D1A65FF21F31FD610FEB4660@HE1PR0702MB3579.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(97736004)(478600001)(3846002)(118296001)(256004)(25786009)(6506007)(14454004)(6916009)(2616005)(6116002)(186003)(105586002)(2501003)(106356001)(2351001)(316002)(7116003)(26005)(2906002)(486006)(81166006)(450100002)(305945005)(66066001)(4326008)(81156014)(36756003)(68736007)(8936002)(102836004)(6436002)(1730700003)(6512007)(8676002)(7736002)(53936002)(6486002)(4744005)(5640700003)(99286004)(86362001)(71190400001)(71200400001)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3579;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: leI1B8FbrtU3IdYC+wpJ1duqVDFUkgdRjADe04Jh6knRPMuQ44V6wvc7UpMApnJ0Kl4JxKq90JKoPSie9U+Vio1vTYjFR6wwwCMSeo9URvoHiFwJfwWy7Bh8qqrAHJ7X4aQfwNPq6zYWs4BNjZRDrlKS7MBGJjTpn9Q90YnC3gZnjd3bB2nDm4r+ju0lujYx/oUjFxD/jog0BrYxtlTHYgxpxLLtRVRebi8K+zCs8cS8lKcb9pI+kjY1tgZUpQCPEico5Q7kpOn1bQS2/eJKKVBgArROsbzM4JNdvq469O/Vp7a7B5xEFjrwUgmXauJVGLg0/l20wuugWNY/zeR3fWcs181nWRtvBIs7md4j37OmmXIk1TJ+h7K3RGOvXIWBT8tGZzZIGpIpHAsiGVAXIqVw91cOvKEUM1h85lSAZbA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61E11CAECF7ACF4E8CBC899A174A5940@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38f9e2d-16e0-4346-0f86-08d691d1a6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:38:14.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkNhbiB5b3UgcGljayB0aGVzZSBwYXRjaGVzIHRvIDQuMTQueT8NClRoZXNlIGZpeCBz
b21lICJwZXJmIHRlc3QiIGVycm9ycyBzZWVuIHdoZW4gcnVubmluZyBpbiBWTS4NCg0KY29tbWl0
IDEwODM2ZDlmOWFjNjNkNDBjY2ZhNzU2Zjg3MWNlNGVkNTFhZTNiNTINCkF1dGhvcjogSmlyaSBP
bHNhIDxqb2xzYUBrZXJuZWwub3JnPg0KRGF0ZTogICBNb24gSnVsIDMgMTY6NTA6MzAgMjAxNyAr
MDIwMA0KDQogICAgcGVyZiB0ZXN0cyBhdHRyOiBGaXggdGFzayB0ZXJtIHZhbHVlcw0KDQpjb21t
aXQgZjZhOTgyMGQ1NzJiZDgzODRkOTgyMzU3Y2JhZDIxNGIzYTZjMDRiYg0KQXV0aG9yOiBKaXJp
IE9sc2EgPGpvbHNhQHJlZGhhdC5jb20+DQpEYXRlOiAgIFRodSBTZXAgMjggMTg6MDY6MzMgMjAx
NyArMDIwMA0KDQogICAgcGVyZiB0ZXN0cyBhdHRyOiBGaXggZ3JvdXAgc3RhdCB0ZXN0cw0KDQpj
b21taXQgNjkyZjVhMjJjZDI4NGJiODIzM2EzOGUzZWQ4Njg4MWQyZDljODlkNA0KQXV0aG9yOiBK
aXJpIE9sc2EgPGpvbHNhQGtlcm5lbC5vcmc+DQpEYXRlOiAgIE1vbiBPY3QgOSAxNTowNzoxMiAy
MDE3ICswMjAwDQoNCiAgICBwZXJmIHRlc3RzIGF0dHI6IE1ha2UgaHcgZXZlbnRzIG9wdGlvbmFs
DQoNCg0KLVRvbW1pDQoNCg==
