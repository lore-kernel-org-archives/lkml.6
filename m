Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC164C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717BF222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="YJ38Z0vq";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="YJ38Z0vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfBMG7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:59:05 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:27514
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729649AbfBMG7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5YnqtURXKR8+lZZif5tXXlLrVWH9pxjXBxHyN96Vx4=;
 b=YJ38Z0vqjWT8BuFK26hODAWg+qA1JLa42kqDPQO5EShe/W+1QS/njI0E4yWXbuuA+S2832S03oXiuMSlm5xaFweC310Bu8KVz6rp2Mn3ika1z7vRrHJUyNo90Jk11cvOatJL1Cn6AtNDLEyrbxCdJmeYEUqKWn2/ORby9K0t+jE=
Received: from VI1PR0401CA0020.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::30) by VI1PR04MB3245.eurprd04.prod.outlook.com
 (2603:10a6:802:6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Wed, 13 Feb
 2019 06:58:54 +0000
Received: from DB5EUR01FT004.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e02::200) by VI1PR0401CA0020.outlook.office365.com
 (2603:10a6:800:4a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 13 Feb 2019 06:58:53 +0000
Authentication-Results: spf=pass (sender IP is 52.236.92.113)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 52.236.92.113 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.236.92.113;
 helo=eu2-emailsignatures-cloud.codetwo.com;
Received: from eu2-emailsignatures-cloud.codetwo.com (52.236.92.113) by
 DB5EUR01FT004.mail.protection.outlook.com (10.152.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 13 Feb 2019 06:58:53 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.57) by eu2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 13 Feb 2019 06:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5YnqtURXKR8+lZZif5tXXlLrVWH9pxjXBxHyN96Vx4=;
 b=YJ38Z0vqjWT8BuFK26hODAWg+qA1JLa42kqDPQO5EShe/W+1QS/njI0E4yWXbuuA+S2832S03oXiuMSlm5xaFweC310Bu8KVz6rp2Mn3ika1z7vRrHJUyNo90Jk11cvOatJL1Cn6AtNDLEyrbxCdJmeYEUqKWn2/ORby9K0t+jE=
Received: from AM6PR0402MB3863.eurprd04.prod.outlook.com (52.133.29.150) by
 AM6PR0402MB3877.eurprd04.prod.outlook.com (52.133.29.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 06:58:49 +0000
Received: from AM6PR0402MB3863.eurprd04.prod.outlook.com
 ([fe80::8177:6505:b6c:e430]) by AM6PR0402MB3863.eurprd04.prod.outlook.com
 ([fe80::8177:6505:b6c:e430%5]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:58:49 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Tomasz Duszynski <tduszyns@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio/gyro/bmg160: Use millidegrees for temperature scale
Thread-Topic: [PATCH] iio/gyro/bmg160: Use millidegrees for temperature scale
Thread-Index: AQHUwt7i51C89Jh4q0yHwLXHGVFmkKXcYy8AgADqNgA=
Date:   Wed, 13 Feb 2019 06:58:49 +0000
Message-ID: <4a775677-1633-db22-af8f-24c411c56eeb@topic.nl>
References: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
 <20190212170031.GA14756@arch>
In-Reply-To: <20190212170031.GA14756@arch>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-clientproxiedby: AM6PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:209:1::24) To AM6PR0402MB3863.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.173.50.109]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3f6f95b9-3d7f-4433-4821-08d69180b733
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3877;
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3877:|VI1PR04MB3245:
X-Microsoft-Exchange-Diagnostics-untrusted: =?utf-8?B?MTtBTTZQUjA0MDJNQjM4Nzc7MjM6NHBkVzltL3JLWUp2TEZuRHo0N3NGQzJn?=
 =?utf-8?B?MHZUSkJKN1JwYXBZVkYzbXk3bUg2UUVJa3RBazB5d1FwZUYrSEIza2htcGlu?=
 =?utf-8?B?UmVFbDVxQ2RRemZ6WWhwYVZJNzI1c1pkdnd0d3J0eXlGanpwakdVVktpcXhZ?=
 =?utf-8?B?VmpPNk40YmtRK0dZcHBZRDlZZVlYcHR1Z3h0STBDdE1GU3N1cjNQZ2h4dEti?=
 =?utf-8?B?N0RiMWdWNTlGQXJQV1J3aFFSL1dHa3ladTFVVTB0TWVjb09qT1JxZWVQL2pW?=
 =?utf-8?B?c1ZRN1loRGFrUVB5NC9VQ1dpSUtqYlVZRThBNFFlaEN0VGNJaXFtODVLKzJs?=
 =?utf-8?B?VEZLeFNkOVBNeHMzQ0k1T3FHZURXdnhsenFFdHF3ODdtTDdSbGdzbTBEbUE4?=
 =?utf-8?B?QmxRajZXWTBJNWZhdHZMaDFpWDVVZnY5cE5RRmtMaERBckc2SDdKemNtMmFj?=
 =?utf-8?B?SjNtYWpHS3pHNGdJMkVvWWFpakxPODZMOWQ3S2ZvcE9HR2w1MWNoSVBreG55?=
 =?utf-8?B?RUhNTmNHazVoYUFwYXJCYWRHMi9VZ2FxVlNEYlRkQnZzM3ExaGozMU9uTWJw?=
 =?utf-8?B?RVFkNnVCOENsZG5uMktpRXFvNnp3UTVSWHhMUVQzSmh3QVpGZlZyNXJhMG1l?=
 =?utf-8?B?bm9EdEdKN1VCVlNRQUpuM21vSktUZHhxY1A4L3h5TFVoSWVHcEExWEFqaTBI?=
 =?utf-8?B?a3B5Z05RbzVYZ1hrU0poMkRTaGQrTkxxRU8rWGZmYnljOUREYnYzTjBydjBh?=
 =?utf-8?B?N0JuL1hTYVRobWtwQ0JjU1VHeG5EaXp4OXRadlh5ZUI0d09tN0RFei9TSG4y?=
 =?utf-8?B?Zkw2Rnovd0tGUlRGak0waStLVXpkSmMwUmdWRGRwWFJ1SVdPS1I1MzNGWit6?=
 =?utf-8?B?a3FpemNoRU5DTFZROGVXdGNBdmhybWRPKzQ3WjJJd3BoK29ScWl2SzBOUE1P?=
 =?utf-8?B?bnpJREQ0cHRxOU1JdUd2dGszM2JyelAvbEtxbnVGdFRVdjY2QTRScnRGSXpz?=
 =?utf-8?B?dDVNMDl4V0QwcDFPUlhNdkZ4MzhQdU5KaTNQTWpiczFpOWMyL3laZUQ1T2JJ?=
 =?utf-8?B?Unc2OE8yT05sdXdIMjA3cjQ1b01nV29QaXh6cGUrbEhUS29HODRUQ0d1Ymwy?=
 =?utf-8?B?SjVaY24remJjNE1QK1g5Sy9abi8zVjRMQlNTUGRsaTV5QUlGOFFJKzNFRjIv?=
 =?utf-8?B?bFU1ZHJrbkc0TldqSjFudHg2T0E0bFFZaHRncVErMVlIVDhMTUtDZ0ZBS05x?=
 =?utf-8?B?QmpQR21xcHpnMkhiN2VCV1JYMnowRmtFR2lCTU1BMSt4RGdWRUhmcGZla3Qr?=
 =?utf-8?B?VEtTdGJPRHF6bXhBcHBSVVlZeGgwNWVtNlNSK3hVbFNCdHBsTjVBYjdKTHV5?=
 =?utf-8?B?dFZjVkVzYzhDWEtuanJHRWRpZUJMZHRmRjRabnpLaFhvK21uNUZ2WTdIMGFt?=
 =?utf-8?B?aWpTK1ZMb0E2NERKZ1g0SlBaM3pOMlk0Ym04U1JtMjlxUTlvOUUvT0k0WG1S?=
 =?utf-8?B?b0FIV2N5Y0R3aDVXU3p1Y3ZIV2gyK3dQMVZRT1NRNmFOeUk4M0NJaWNJQ2Rk?=
 =?utf-8?B?VGpRbzREYTdZNE9mcVVkZ1NWUjMwNUI2MXNsTUJNbitiWjFhWlRPNU80SXRC?=
 =?utf-8?B?bU5pY2MzSHUzcXFkeUhMa3NGZFFCY1BqZnFtNXY3VFVIM2h5OEFZOUJhK0h0?=
 =?utf-8?B?T2dNUEt5TGQxaTBRN2Rwb1JRV1VpTnZFRFRTZU5lQXFLT3NlK3cxdGgyYnNu?=
 =?utf-8?B?Sm9jOEZXUHlVTmR3VGR5eVo3dDBJOTJLd3ZIMS9iaExBMDUwTDM1RHBBYysz?=
 =?utf-8?B?RnY3VkwwME4wN3lENWtMeGxxRGRaRHFLeXNWQlJHNWY2azNLWXlXTUdmN3g5?=
 =?utf-8?B?dnRnQS94UmhsUjE0SnpZNUQzK2dkV1NWMlVtZFdud1VRZ2FRcVNKRXFQOEY0?=
 =?utf-8?B?QWhWNlhaaWZESVE9PQ==?=
X-Microsoft-Antispam-PRVS: <VI1PR04MB3245A9A231E582BB1842CD4796660@VI1PR04MB3245.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39840400004)(199004)(189003)(305945005)(25786009)(6506007)(53546011)(102836004)(76176011)(486006)(446003)(31696002)(386003)(31686004)(26005)(508600001)(36756003)(97736004)(11346002)(316002)(53936002)(81166006)(99286004)(81156014)(186003)(8676002)(64126003)(68736007)(7736002)(476003)(2616005)(58126008)(52116002)(54906003)(4326008)(42882007)(44832011)(6246003)(8936002)(2906002)(1411001)(14454004)(229853002)(66066001)(65806001)(6436002)(6916009)(71200400001)(256004)(65826007)(71190400001)(74482002)(6512007)(6486002)(6116002)(106356001)(3846002)(105586002)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3877;H:AM6PR0402MB3863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: XpEQgYm5wBliH3xRzObRArbtM91aaoRNawXIFwiNS6ytwcexlYb/Fnl66nm4JWGuno7Cea7DJf8OHW6s76JxBMgoCbKtCiz+zq/ECXw8Kgq8RLmvJodrLEsBPmorfexaJdRc0/I3od7RvFj4fQZkaGgDxsw3yCh3QIhN5ZJSE80KM6M+VHzVERtdQF6qbf/6LrTYgrVfMv875F0kGfsLgQvJcs+TOqHtXmDplYhtRJlmaBJAUDfaQD0UbUGH3hNrqg26/KTXvPUzCytGSNMX8uO69swmOOm09s576j7//RK7q2JQFXr9oKqWskV4tmvX0aNJF7azt/afRaWI87VWnCI29qP8BBB9l5whFoPPFcCbYCwCCDg7hYBbP+FfIeZc9ENkL9ucb6KlSigPwPEZsp7/vvjQF6vWZa9Zi5GBUqU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C40348884A26648BDD7B3695630AAFB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3877
X-CodeTwo-MessageID: 20190213065850.f016d57d-f830-4d20-969c-40bcacc8f576@eu2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT004.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:52.236.92.113;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39840400004)(376002)(2980300002)(199004)(189003)(7596002)(8936002)(305945005)(356004)(229853002)(6246003)(246002)(8676002)(2906002)(7736002)(7636002)(106002)(14454004)(23676004)(2486003)(76176011)(6486002)(508600001)(6512007)(316002)(54906003)(50466002)(58126008)(53546011)(126002)(44832011)(486006)(65826007)(106466001)(186003)(476003)(1411001)(66066001)(386003)(6506007)(436003)(74482002)(31696002)(2616005)(36756003)(31686004)(102836004)(26005)(4326008)(6916009)(6116002)(99286004)(47776003)(3846002)(64126003)(25786009)(446003)(65806001)(65956001)(11346002)(42882007)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3245;H:eu2-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:eu2-emailsignatures-cloud.codetwo.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR01FT004;1:QLBic5brHF9uIwdeUa/X+M5aAuIyu49zjgTrWcy9tWxt9Hc6UMIf9XR0BDmQzEM/gvhD6npazAUYokFEo3jgeoC3Hdx6RzHqMIBd183pBXWVdsl4WW+ubWcseA3W9D9HLfDBxBvANz3gkj8qqmqXaQ6jS2E2GFBjzmG9tXUOLWg=
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7c61ef98-bd2b-4f34-8254-08d69180b46b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(710020)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3245;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3245;20:uUC7VUaPytetQ4P+SDKMb9cTzxqgNShi5JkYZdjcqo0LUkTwztD88IAOLku5MkeBTMwFhYvFUS3ziveg4IODXZK0qeoQJCS+Agfh5q2S6y9ZJhDJMLlBwiNXzurhJj5PyHRFhlHkJqVQ0Gd/+tHsfljtn7JbDrOoZNKtl0rM6hk=
X-Forefront-PRVS: 094700CA91
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIzMjQ1OzIzOlk1Y0pPd1BmLzJweXFGeGJtQmtRWVI2STZH?=
 =?utf-8?B?YXhRVUdJWWhNUFpoREZDeElTSE9lRWx3Z2lYcnZmRDZLblVmeUhlc2RPMHJI?=
 =?utf-8?B?Vk4zZFNSZ1RwaGRwMThZbXgvZzQvRW13dUQ5UTNCRXhkajQ1Wm4xYVRMUzlR?=
 =?utf-8?B?UHM3akhpY3Q4VFRUYWlaL2paQ1FNVlFJSkRCNlRiaTBKWXhTUU5HSCsydGtI?=
 =?utf-8?B?aThJb0Jzb1MxOEVQNk04OWUvQnpreEo5NmpybXFGaVBBTlA3REJvdnpST1k4?=
 =?utf-8?B?ZmxPRVN6TTFjZm1laWcxeGpITGQ1OHFrTzBKZHlNT09RZHVFQjNkcnozeFRw?=
 =?utf-8?B?YnpRRkdldlAwNVg1REtGMzgxR2hQYlpTVEQyM2NnZnQyQ3dEMHN2d3lRREhl?=
 =?utf-8?B?K3VzYUw0c21Jd3dMZDh1c0VjV0JvMEVsM3hsMEZ3VXYwa3Z5ZERDVFFIanky?=
 =?utf-8?B?dUZxUWs0T3pvM3ZhTlBnRGtlZXkvdTIxcCtlWWF1NnJpQlJaNXFzU1poMkkr?=
 =?utf-8?B?Rzc4dGZYaE1GV2hlei9vb0JOM3JCdk50MFRMNzZ6eFFTNnltQWUxOEJ0bm16?=
 =?utf-8?B?K2JJc05OR3cxZ3JudVpFdUhqdk5ETkthS0srNXR5K2FYb2RJNnlEdmFXaGFr?=
 =?utf-8?B?RnUrYjNxcCtuemdLZjVOL1NlKzlyNklVQTUzTk9QWHo1MlNBZ01LRTQyYWVs?=
 =?utf-8?B?cEd6aEF5aEtaaEVheStWd2d6djZwTFVVSmZmT0ZKa3dpRTYvencyUVUwbzlk?=
 =?utf-8?B?dDBBSGxTR0d0am8zOGRkSmJ4aU1xMlVmZE14MjRhTXBPeXJ4N29jUDBmK0Uv?=
 =?utf-8?B?SUFnT0tJb3FMMHR6Z2VWWGcyMXovMm42b2VvWE1wMmZhN1RkUzlGRXJwOXVT?=
 =?utf-8?B?bEpuMnVEN2VoQ1ZwdVl6U1lsemt2bmUzMitBakZmZzBvS2ZFN2VEUFlpSHJt?=
 =?utf-8?B?Rjk5bFlzYkd1SzgyVElQdGlzeTd3SjhreEJRbVNNYTJCVlRoV21JK1hPQVh0?=
 =?utf-8?B?dmpicHlESWJiVUtDL29ZanZDZ2N2UGExU1JsU1A2U053aFI4YURTRHdoSzFJ?=
 =?utf-8?B?eHpJakN3c3ZQdGhicCtWRThIQVpPZy9wZG9yVG41T3piU0F2anRReFdWbzZ2?=
 =?utf-8?B?a3FyYWU2bFovR2lhQitrb0p6cVNCc1ZCYnlIYnBXendZdjUwbUdhcGlRWGZZ?=
 =?utf-8?B?blhOT016N2xIZE9KUVdSWGZqMVluSUlPM3oxNGl6WlcyTTFpazdkcHM2OHdS?=
 =?utf-8?B?SFlXaXZSdDBJVXZsOFRRZEZJV2NUeno5ZDNhajlhbVJrRENXVmcyRDhSVEd5?=
 =?utf-8?B?QjZ0M1p0ZFcyS0JZaWJINmNsRUZBeFU4dG5vU3RBRnFQT2hsdC9WRDBValkr?=
 =?utf-8?B?T0N6NjdkVEFzeHI5UVU3Y3JtN2hxRzlNbVkwODdNNFdla0Y0cWhQMmFaNk0v?=
 =?utf-8?B?cHNpQ3JlMXNuUlJZY3R5WWpPZEJWb2xSVUEzVnlvM0UzdnRhYStxZ2dEaWxr?=
 =?utf-8?B?am0vYVhOcjhub0Y3TCtBSFlKb2N2MGtUMWJPZlZia0FoekFRRE5YU1JDbll6?=
 =?utf-8?B?RkpFQ2ZiOW5COHVhR2lNK0hsN3VZbE5BR05kODJ2MDJ0WnhhSm9IOTVBbi9a?=
 =?utf-8?B?Wk50ckE1NllCSzAxeWEvbzRnM0R0L0tFdzM3M2xKM1EvVDVGTmZsVTgwYyta?=
 =?utf-8?B?NEp2dFppeEdRaDRyTVc3ZXk2bThteHhFbWc5NVcxWDNIeFMzMDdLM3BwMWFI?=
 =?utf-8?B?M0hPbmUwRlE0WWxKYUpid3VtY0k0QnFGMXllRlFXbk5PWi9EeWdyVmx6VzdW?=
 =?utf-8?B?MU9ZNVU4SkxrSFlVMzlQdzV3S1FPTGRtSG5mYWZVNU9xUU55WkNoK0IzSEVR?=
 =?utf-8?Q?jjsskL/1VpazIk+AYI6RnxuBDU2LCHmn?=
X-Microsoft-Antispam-Message-Info: fMSRBfk6dw908E8IUQPoRPmSfPRCW82O06DexmoUdC8UNu7PL95DjjXqLrnnkx93Iu59u3kaLmwJbRxi5Wtt1F0S44GLmUAtn7mM1oEYRHsCu3sgUXykv0J2ve6Q9Ko9OJfsf5ja/mhpgCh9LsYE+ftLsGwjqrRRr1FJKE8twf1xp/Rj4mFU/o8iKN2mT8wKRGIBYWw/kv33rNRb8Zn+h8SAD9o3sS/Me8rhBTf4nZ6tyOoonCtbDX1rSHHkHkBT+ZF4YJqKmxZkN2yIzoGVUucvZyhp+3KVCGFKpYtuFJzmjksij0UBT4KRnIQHcWicHJGFVTZXj6UeHkTX/sJV8/bmnP2BAohffpXjyJwxgdiifJ0Ap6HpwEbPPejEYGRun37e0nh/XvuHtcdPgTP9eKp3sQ2ajQnbtz/BmwuXZd0=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2019 06:58:53.4676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6f95b9-3d7f-4433-4821-08d69180b733
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[52.236.92.113];Helo=[eu2-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTItMDItMTkgMTg6MDAsIFRvbWFzeiBEdXN6eW5za2kgd3JvdGU6DQo+IE9uIFR1ZSwgRmVi
IDEyLCAyMDE5IGF0IDAzOjI1OjQ5UE0gKzAxMDAsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPj4g
U3RhbmRhcmQgdW5pdCBmb3IgdGVtcGVyYXR1cmUgaXMgbWlsbGlkZWdyZWVzIENlbGNpdXMsIHdo
ZXJlYXMgdGhpcyBkcml2ZXINCj4+IHdhcyByZXBvcnRpbmcgaW4gZGVncmVlcy4gRml4IHRoZSBz
Y2FsZSBmYWN0b3IgaW4gdGhlIGRyaXZlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNaWtlIExv
b2lqbWFucyA8bWlrZS5sb29pam1hbnNAdG9waWMubmw+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9p
aW8vZ3lyby9ibWcxNjBfY29yZS5jIHwgNSArKystLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9neXJvL2JtZzE2MF9jb3JlLmMgYi9kcml2ZXJzL2lpby9neXJvL2JtZzE2MF9jb3JlLmMN
Cj4+IGluZGV4IDYzY2EzMTYuLmFkN2Y4Y2IgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9n
eXJvL2JtZzE2MF9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvaWlvL2d5cm8vYm1nMTYwX2NvcmUu
Yw0KPj4gQEAgLTU4NSw4ICs1ODUsOSBAQCBzdGF0aWMgaW50IGJtZzE2MF9yZWFkX3JhdyhzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4gICAJCSp2YWwgPSAwOw0KPj4gICAJCXN3aXRjaCAo
Y2hhbi0+dHlwZSkgew0KPj4gICAJCWNhc2UgSUlPX1RFTVA6DQo+PiAtCQkJKnZhbDIgPSA1MDAw
MDA7DQo+PiAtCQkJcmV0dXJuIElJT19WQUxfSU5UX1BMVVNfTUlDUk87DQo+PiArCQkJKnZhbCA9
IDUwMDsNCj4+ICsJCQkqdmFsMiA9IDA7DQo+PiArCQkJcmV0dXJuIElJT19WQUxfSU5UOw0KPiAN
Cj4gWW91IGFyZSByZXR1cm5pbmcgaW50ZWdlciB0eXBlIHRvIGlpbyBzbyB0aGVyZSdzIG5vIHBv
aW50IGluIHRvdWNoaW5nDQo+IHZhbDIuIGlpbyB3aWxsIGlnbm9yZSBpdCBhbnl3YXkuDQoNCklu
ZGVlZCwgSSdsbCBwb3N0IGEgdjIgZm9yIHRoYXQuDQoNCj4gDQo+PiAgIAkJY2FzZSBJSU9fQU5H
TF9WRUw6DQo+PiAgIAkJew0KPj4gICAJCQlpbnQgaTsNCj4+IC0tDQo+PiAxLjkuMQ0KPj4NCg0K
