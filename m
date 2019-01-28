Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE4BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC88520844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="mOW8gZLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbfA1Q5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:57:13 -0500
Received: from mail-eopbgr130117.outbound.protection.outlook.com ([40.107.13.117]:15812
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388199AbfA1Q5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTOvXw5p9cFbNNiJc8i7tDnMarpa4KoAj9oTGhSzBcA=;
 b=mOW8gZLM3ZpP4PK9TDpl5v51ecexrhBHbh5WwD6oJObh0iV8Hc9YrY6KU7X7f+DEy2KEw+Quc1NNraqPlu14VJbmuTwolpryxBNdvRhpA/uAvrI4DuNWiW2Wrs5PsOImuzMrS5y43jfj/JZSkpPCxANNi6CpF1rNCEVdPHMt0LA=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3563.eurprd07.prod.outlook.com (52.133.6.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10; Mon, 28 Jan 2019 16:57:05 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::a8ac:38d7:8a41:438]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::a8ac:38d7:8a41:438%4]) with mapi id 15.20.1580.014; Mon, 28 Jan 2019
 16:57:04 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "milian.wolff@kdab.com" <milian.wolff@kdab.com>,
        "jpmv27@aim.com" <jpmv27@aim.com>
Subject: 4.14 perf unwind fixes
Thread-Topic: 4.14 perf unwind fixes
Thread-Index: AQHUtyp+vo0Rdrbyc0arcV+47XxbTw==
Date:   Mon, 28 Jan 2019 16:57:04 +0000
Message-ID: <e975fbaa1bf8449038e422d7380abc4de4a36a8d.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0702MB3563;6:rtfHdlNonDbdzBIutbOfoBifMgqv5qzarSK7X++SukbDht6VKpEA4/iuuyfYt9bfmY3Pl1gDERzYQcEh/jEN+15gwT2NL5C/akQNkLMQ3SpZeUDzT36kNDdWX30zBC7JYXqQuS6I4WGesAvoC70fkqqM1JVTnJLjsnyG82qan96f0cZdRZ/BziNyeMhM9Sz1QEjfVPN/XbddULdYhkPvUaesuVGVUyi6WEA93Sj4N/fdcFtZ9SOx4jO2CAlOFXJckDWCi8XDQEcV4+OTkve5dg2MoyOJEf7mlr9qY3v1TWuNxGLTEbUYCsKoQQ1KUJyKIHWkI2/9jI/F66n5nY9PqIH3JSh0jlf9To2K03XVNlDGEtDCbmhUnvauPxa9ci72WkUl/i6puD8rp/SeqH6tgUZf423S7pD9o8nN32tvs7Fg0NEiE7n4VFwvDY/QLQM1bcKjKRcYF5G0JzeigjBy3Q==;5:RcNfMoYtVMcEWX7VzW2RGem3H1b/MD5kCkYH9cWcj9DOSxGyoXQCYxOaIkJDTIxdS/g0xITntrOIpU8c+lcepOpq1EsJfzuUNfTZM821d5m6e4axrI2Sk15+maAUWF91xZ7TslECMHbN2Cp95M2VmATKvtDWSi4jJcqJuOpQ1TjUZrTVFyr+kaqo3Mx9HdcxXnUkRLXcnapI5nd7uolqWw==;7:Q/GzTvSvWtOM5v54OR4WpYBlud95PiX8oNlaBK5zNm8FpP6gT5Xw7n4Lyi3I8K31t0+shcKOkEjAGA1Vme2AmY6a2ecaKT95nEuhTVfmb4eS3QsYV/ScsAhSBrTw9SlPeYMFqpF3dODqwyvXFpqDzA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 07db3d9b-df81-4b4c-a55f-08d68541a195
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3563;
x-ms-traffictypediagnostic: HE1PR0702MB3563:
x-microsoft-antispam-prvs: <HE1PR0702MB35635F0D13A75C8BCAF380B4B4960@HE1PR0702MB3563.eurprd07.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(39860400002)(366004)(346002)(199004)(189003)(68736007)(316002)(118296001)(2501003)(99286004)(486006)(14444005)(97736004)(476003)(2616005)(71200400001)(102836004)(305945005)(5640700003)(7116003)(6436002)(7736002)(4326008)(53936002)(256004)(6506007)(54906003)(26005)(6512007)(25786009)(186003)(86362001)(71190400001)(36756003)(6916009)(6486002)(4744005)(66066001)(8936002)(8676002)(81166006)(81156014)(14454004)(1730700003)(106356001)(2351001)(478600001)(105586002)(3846002)(6116002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3563;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XBGaCaXiYA0nbdcAyplTP8C1d1uHWuYv9vOInjWuJKLkzWBgTUvbMUMaj+N9lu9u8dXGOUX/dKuk9ZUltOUGbheK6/ZYqJ3L4Hs89PNpOaX4LzwZBLFPsAGyBLGgcAOGfQW+nK14jACsPjH4N4VyDxP0ZL7XSGGQzarPOPYLONp3ucu1wUEvvJXtlo8BZOK/EBcwNKynfPzi88bveR3cd89ABU7RCjFFnwRzV6n7znw0wOthbf0AbDbaCfrhb4KXPKve7x1BWa5BhMIZVyZ5agRSbzf6Y9MB9gbsI51vKg69HivrtBRz1LDH176wuuRy2q310IURh7sinoltit2YLyAtP9NZwieVu//akaDT5yrDxnJXYk9FVEQQAasNSP8/40+cRV/2kXha/bm2880B9HAmzz74X+zLLdm83TjJW9w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC5CE0FC6D971941AC79B996DF135605@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07db3d9b-df81-4b4c-a55f-08d68541a195
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 16:57:04.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KQ2FuIHlvdSBwbGVhc2UgcGljayB0aGVzZSB0d28gdXBzdHJlYW0gcGF0Y2hl
cyB0byA0LjE0Pw0KVGhleSBmaXggYnJva2VuIHBlcmYgdW53aW5kaW5nIGZvciBtZS4NCg0KDQpj
b21taXQgM2QyMGM2MjQ2NjkwMjE5ODgxNzg2ZGUxMGQyZGRhOTNmNjE2ZDBhYw0KQXV0aG9yOiBN
YXJ0aW4gVnVpbGxlIDwNCmpwbXYyN0BhaW0uY29tPg0KRGF0ZTogICBTdW4gRmViIDExIDE2OjI0
OjIwIDIwMTggLTA1MDANCg0KICAgIHBlcmYgdW53aW5kOiBVbndpbmQgd2l0aCBsaWJkdyBkb2Vz
bid0IHRha2Ugc3ltZnMgaW50byBhY2NvdW50DQoNCg0KY29tbWl0IDFmZTYyN2RhMzAzMzEwMjRm
NDUzZmFlZjA0ZDUwMDA3OWI5MDExMDcNCkF1dGhvcjogTWlsaWFuIFdvbGZmIDwNCm1pbGlhbi53
b2xmZkBrZGFiLmNvbT4NCkRhdGU6ICAgTW9uIE9jdCAyOSAxNToxNjo0NCAyMDE4ICswMTAwDQoN
CiAgICBwZXJmIHVud2luZDogVGFrZSBwZ29mZiBpbnRvIGFjY291bnQgd2hlbiByZXBvcnRpbmcg
ZWxmIHRvIGxpYmR3ZmwNCg0KDQotVG9tbWkNCg0K
