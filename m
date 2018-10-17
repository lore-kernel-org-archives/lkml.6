Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E25ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07020214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="HobBiqJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07020214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeJRBqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:46:20 -0400
Received: from mail-eopbgr780103.outbound.protection.outlook.com ([40.107.78.103]:53492
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbeJRBqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R9xCB/bhpFcMVMXBSW63u7ZFU5js09DouHe+bFo0ec=;
 b=HobBiqJGuMlUbFjNNUo0Y67/OAaCZDdpMeDX4clf3EDkKf1mzUNy4vlLbtdP1K15zmFX06sMrx+9QreQIoV1MXZ+XNPaJ0x2FL44CoNFcvl7infWqbpqzlTV6YlsS3pw6QgmcF7+nDewvaGyZZuyszZdZjQCz2iXIo40dCwnH5A=
Received: from MWHPR13CA0031.namprd13.prod.outlook.com (2603:10b6:300:95::17)
 by MWHPR13MB1422.namprd13.prod.outlook.com (2603:10b6:300:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.14; Wed, 17 Oct
 2018 17:49:27 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR13CA0031.outlook.office365.com
 (2603:10b6:300:95::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.12 via Frontend
 Transport; Wed, 17 Oct 2018 17:49:27 +0000
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1250.11 via Frontend Transport; Wed, 17 Oct 2018 17:49:27 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9HHnPeB006379;
        Wed, 17 Oct 2018 17:49:26 GMT
Received: from USCULXHUB02V.am.sony.com (hub.cul.am.sony.com [146.215.231.16])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9HHnO7p029807;
        Wed, 17 Oct 2018 17:49:25 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB02V.am.sony.com ([146.215.231.16]) with mapi id 14.03.0408.000; Wed,
 17 Oct 2018 13:49:23 -0400
From:   <Tim.Bird@sony.com>
To:     <brendanhiggins@google.com>, <gregkh@linuxfoundation.org>,
        <keescook@google.com>, <mcgrof@kernel.org>, <shuah@kernel.org>
CC:     <joel@jms.id.au>, <mpe@ellerman.id.au>, <joe@perches.com>,
        <brakmo@fb.com>, <rostedt@goodmis.org>, <khilman@baylibre.com>,
        <julia.lawall@lip6.fr>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <jdike@addtoit.com>, <richard@nod.at>,
        <linux-um@lists.infradead.org>
Subject: RE: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
Thread-Topic: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
Thread-Index: AQHUZat3o2tuxUXYQEuBjX1lNU2hjKUjtXGg
Date:   Wed, 17 Oct 2018 17:49:24 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF805242EE@USCULXMSG01.am.sony.com>
References: <20181016235120.138227-1-brendanhiggins@google.com>
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(448002)(13464003)(199004)(189003)(2920100001)(102836004)(5660300001)(85326001)(6116002)(14444005)(4326008)(229853002)(8936002)(478600001)(72206003)(2876002)(2906002)(356004)(47776003)(110136005)(2900100001)(66066001)(7416002)(316002)(54906003)(55846006)(106466001)(246002)(2486003)(336012)(76176011)(26005)(186003)(86362001)(23676004)(3846002)(2201001)(126002)(11346002)(33656002)(446003)(50466002)(7736002)(8676002)(7696005)(55016002)(6346003)(426003)(305945005)(486006)(6246003)(436003)(476003)(86152003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1422;H:usculsndmail03v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail03.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT051;1:e5wP0WzmMggDJvEgxFfWYlxXQvwe0OnCFsQc3HdBrw+RrU0eW9uzvG9HoZB8mhpffaUx/GWZfpMWjF5qp8e6EkXiM3XacmrIieFoQm6uBlmqwdPc4su9Wf+hdsX/U30y
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601ea913-ce54-4aa4-7c49-08d63458e1fc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:MWHPR13MB1422;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1422;3:ZqGpejSg4RhqwhnYOqu2K5RYXhrJt9U3pkGCpooaz1EBWIUZHw+IvP/PjV4NsiQQDSamzlRY0NBrESKL7H317zsZVIYbtw5d9ePl/p8ErvIcR1kMy59uNDij4fqAsnzqD3jM+pqFm94tpnnv8HXoaNRCSo7P0p3vWJKGGkgWMk06TCGvl3nn3jsk4h2QTYa2JdWMB8U5GdX3pIoBTEEIT8o7XJOWTsNNLluWeObpjOB2g5VL4uduLmGsavmNfIfJT+lfER7PCAAF50AtC/KFksmatu9CFIAf30XgMdJT9Y7fGwGu+MyizlaigEnLPVokc3cmNGK3cRPLDOm/uvnKKsnOKXww5IbBD22t/3iaiEI=;25:lj2wupSFix8oPpI1s6/BYAqgLTqo9UK8ZhxDyNaHlSHOiiA1UvZsMRQCNzjZ+WBBzyNinyXHV/bFwuuc66FDydR03Owc7uYOw7kTcsmuYP3whDZgIph7u3xW/DKKaBLSnIbxKa3lnwCflxsfS7rEkucNBWXIvFb1CxUmniUIdvoZaiS9ehfonWVNbZwotfQMlyIJtGeqd4Bz5A7wxORB00SWEptjiiIT23Jr9HHtC5dpe6MtMtoDz6X3CzEoww8LUa70ho7Xn5Mb5E2jMoDkPEgZoaZJ0+RgUIqQ+OiT9E6+V02zug4Pla/J631ejmUOHEfwcqL10pA0tAUK5RFDTQ==
X-MS-TrafficTypeDiagnostic: MWHPR13MB1422:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1422;31:PMzYRaPabyyF+wmJcAxw+Q+ROgdd7IqeFJDzWveD1F2VDZYIW2sjs0SZtQ4AkRfRRUJ+/OXOb7xlxhf5XRSkMnFk+rUgqErrmrkHowvz7skJ47+E/WgvCQGu02L3+6WuV1cDyN2ukMhsCrrKvvDZoWlkI5/poFrL1+UVjjfr5vM+bIyYWIgPHKzjRsXH3Fof5IZ4cffajbV4CMCv0QqPJcQalfTjXnp7MR8W9ycl4CU=;20:O63yFBaZzcegjbyP/kY49Rrs2/tCuFoizE9Ul7VOkxG70Ras3IC384jtG/4OZF148ysHfGSVMUB61Z3un1B8AONM9r394sMJxV8vyVukiDnHXoubl9YEmYNGvIMH3UqYXjXhbwYazccqTaOGWx1RmW2/7OxoqjJusR6A+v1eEjLjqxXf+fQaYcGDSw45khhwY3MayRc+vaxKDSA+rqEk3ZRtNZAua3CDk0I3scjAtudyi7iObho6bfdv92hT36Jw30aDnnXlWth+Liu7jJdRnDWx6NlrlkPbmo9TqPhWPeHqmrLlp1c2/6UArbkRalYZa4q0LKg76Yctkl3ZAAHZAofz1JuYfSsVsRi3EfJJKQDP5ZopyhlHF9HZ9F5/snSRzffhHaq9WbTVeCNgBqZaXYl32Cr7hVW0rZc3GyvoffmT+/wfNdMmZZNhNeJUHJaVuvE0SVl7yoUuupxaQjxdPiSjF3awupDvpt0Q0UgKgUYVA3xSgyZGNaq2w699lCQG
X-Microsoft-Antispam-PRVS: <MWHPR13MB142270F9C04EF9A455887C00FDFF0@MWHPR13MB1422.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR13MB1422;BCL:0;PCL:0;RULEID:;SRVR:MWHPR13MB1422;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1422;4:0FSIWyd4GfbZYWWILpweJF1gV9lfQ/kzrqfZMiJLKEZLO66CK7Csrkuw85rDBJpYre1KpbXc+79o28y8xzwWZ9q9BUGSJbdpgjHxKig3AdkgUyeKBA1OaLxfvXdJ53y1n/n1p8gb8hl8KpP8hu4y9qQce6vEnU4lvmIXoioWW+Qg04Oh6UNILmHxPQGzGVYOA59dwK9n1voIw+Kp6as85xlVX/q+vRGJt20eImyR9XJ3Bmags7HpLUzOJUkvKwSb9KRRmGMNGWb/KqFJ/4ULFQ==
X-Forefront-PRVS: 08286A0BE2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEzTUIxNDIyOzIzOkViOVJFamRRRVB1VW1BZU1ITG9ndmJXczVh?=
 =?utf-8?B?aXdDaUFrS0pkcjczSmNkME9jSzUydm8ybk4vVmVOZXFnWjdKR1I5WTVKVEtT?=
 =?utf-8?B?K1pnQ0RhR1ROY3NiajcrM2JDS29xUVFxY2hzcWhUak1PTGFFLzE0elBuWE5P?=
 =?utf-8?B?SmVoMTJFMGwrMmlzVHo1YUJYTlU1MTE5ZFRQM3pLWS83dGEyUk5DRlBpSUw4?=
 =?utf-8?B?VTRDV3FmRjNoQ2RZOUYvSnVaNEsrTkpOWG9mNXRSV3lMSU1ZTDNnbU1RRHFP?=
 =?utf-8?B?OHhFczFJR1RJR3FDUXVqdDNXUzcrMnNndW5GdXFnOEFoMkh2aE9RUHZhZWg1?=
 =?utf-8?B?Q2s0VE1adldwdCtEUWpEVVFwVjVtc1U5UzcramllcXAzaW1iWnFwci9Sc0E2?=
 =?utf-8?B?WUg3WVB4ajR3V3lXYXZ2V2t4dS9GTGRDcEo1YTlFZW9SZGxXMTcrdjZpRTB5?=
 =?utf-8?B?TVIvdi9TMmFHdU90Q0VMNXBZTGppbzVCdzUwRmd4WmlidFVFQldYVXFUaUEw?=
 =?utf-8?B?Y0pBaUhJTE5Mb1hZWVR4M3FVM1NRbEhMVGVmdWEyOEZEalNMMTNxUEdpclF5?=
 =?utf-8?B?bVBxRkhNZ0paQ0hGdENKUUhZM0E4c3lmNlRWQ1NEc1BxSlVwZ0VqZi84c01i?=
 =?utf-8?B?MVB4aFlIck9rMTR5ZTFnOXRvMHI3QW9FRXArKytTbTJtY2J5Q05RdUpGK2JS?=
 =?utf-8?B?YmNoUklXNmtxRWd1UnJlL1haWDdybUh2RGx4eFFLM0dlaFhyUGdqS3Q4Sllk?=
 =?utf-8?B?N2RJMGZhWUlZaUtuMExsTFhMNDVnU0VCRDE5eXZJa2JHSTlkL0R2SUdGMGJV?=
 =?utf-8?B?WmdtL2xyeUZDamdEUVZwSUdUSXBMbjR1bnBSa2lQNjZvdG9iRFIvd3crQ1Jy?=
 =?utf-8?B?b21wMEFLNHM5TDFIMGNacjh2NUhqOWl1c1JMQTc5Z0ZMdmZ1bkdVbzByMEEy?=
 =?utf-8?B?dGQwRE9FQ2xhWDdRelRvRGcvMUppaSszbUxJTW13YXR3WGZFdE1oSlo2MVo3?=
 =?utf-8?B?alN3bFU0T3QzVkNhTUQxT0lqUFNsanFMY3ZLODN0MUdGUUpUeTZ1ZDlqMHFl?=
 =?utf-8?B?NGxhTVR2UzZhbnU3K3Ezb1paZ2c1bmNYT29yc0RBN0NNTmVmSkxBaWFvdTZ5?=
 =?utf-8?B?L1NYTHZPMTBadk8zNWZ4eTZaQ24rZWFPL0hnVG9CL3Z5YVo0OFZkZ25TcEdD?=
 =?utf-8?B?YSsvaHNXYVB3LzVPSHYza3BnMFQvaEdqQnM3aFNKdldSd1IzcW1uVTlXWjBU?=
 =?utf-8?B?M2cwZlVkZmdHNEJMdWkwK3BJOWNVaUxuYnkrRmdZeWpGR2RjTi9pQ0xPUDFn?=
 =?utf-8?B?cWFKdDREcGNJbm92UkJwdVRBRnoxOXYxQVdUTG9uYkl4M1o4eEpJQlgzdERn?=
 =?utf-8?B?VEFOYzVaOGRNZU9JUktvVEdrQkxMUkNaU0kzc3BaVnNacDhteVFqUmcrOG12?=
 =?utf-8?B?cWJyNGY1SVhjbDZKYTVMZVh0WTh4ZjlydjY2SXpGeUxESW1WWjRyUEc2K3Vz?=
 =?utf-8?B?dzducm5Sa3lsTXlRajlhK0ZxVnpYV3VCaWEyMUNqZ2NUVGFKeFlVdnM2Tyti?=
 =?utf-8?B?bEZoQVY4Vm9GU3ZmQ0JKOFhqSmYrdWVBeWp4UVM3aXlaL2pQeXFXQ2p1T3Z3?=
 =?utf-8?B?MFFLWDloMHV0UnllQWttUjFhM1ZVM1J3SlEybDZSS3VhQ1J2T3R6ZXlGcGV2?=
 =?utf-8?B?bmNCb1JRTUlqY0F4NVFGVGNJY0gwdkFVWFN2ZDZRc0w1SWpVcnZhYkUraDMw?=
 =?utf-8?B?dXFkdEc2T1M1aHY1akhNM1RRUG10VXV1NlV3M0NNdUQycTEyVE84ZWttVTZW?=
 =?utf-8?Q?wUeGTpvwc34h0?=
X-Microsoft-Antispam-Message-Info: vUaR38bc8Iv+MKPh5o/PLjkkkz4WeNWT1twMHUR1BjDQHkJhICUkc0ulWOGEwdLgxbV5GcbNCgpuDNlLrHmvxUwUCZRLO4AYKRT+bCjijh0q0+oc7MJadHanXrzAJIxDXBON2UgrZJtuwaPEPaggQy+DsLcvi8u2ice4oC1oMhRu5ZoH73ty9iWdg5rBUumts8P0UzIL4Vla/iNmLsJT4qd4Kk37JKn0lzYLDntOoSW5o9ZEskfiaz/A5R/Y2CSno2cStgRELhtfrV8hxPnRze+YWEakkY41I6HZVr1OrctEyAcp9L3cv2/UGnO3vkjZaFYlmljmREHFIDUrr+yAehS6JFabpYaP76LWtj/16eI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1422;6:ZXOsO9eab7hdcrjoO+ITWdBUvkIXOCHgfrG0Z3JNmVy8Z+4yc7kdFabuN25Aicorp7SgLtpZ7IP0u7lGnOW5a4IYf3NmZAgHsP+m57U4B3ikLYFAXMgIiR0UeqLrdPBB5Sn+4HaOaaR9NGaAtXfu9wHo5Ae0oNyxSCOIsJ/bwhcq1yBV8w9vJBGeGqVDGV7OIxM/q+pam7oNXnAPWKSjAfaJZifto+t4duPmezTMbSvEimv8Ojijy4lz/Isar5pzBMs/OLPBeJh/TvIk1bdWKrxa8wDjRVTo9gB2lb5giNJSAb9m57GVDBk/n/zZngx/sfv0VpA41MqUypYsiSuec7EBH/jbgFLJ7SH0q5q6+Zud0Xwph6PzB35lGRIX6eUgTjMNuy8kLkSikDmnNcIBCwijSxFLASQ9UGGSXnZ8k5Alia4RqO7iu/KGNZrInWyQHW+DHXyaOJNLs47Vwz3h/Q==;5:VhaMc/iwOTXIvo0kzmqTsPyk6GSUSKPw77E+NhaR6vVaUF3x4wi8r/+z8dL3njyDQiYu+V9gOdeK4PoMtyxA8icTJzJTLmx9FejAVmkhA81uOqfPu9wVeljP6iIlMWdHwqwJoPBDKuVSmZ5RRahE0M9G95MeYAqnm6QDmc88Je4=;7:QOroTmowfJhaRWgt5aH1zmCM5WzL/uNI6+/o4i6GeOJHMDqvhjS+B+C675B1twa7wZgeMkMsQWIDXSXBIRMpBaDETVBBk4XkKbEX0QNXx2EI6WqSgI5BJaN+S7gNKwo0esKPK7VZy8jkEzNaTrTphA3h8af6hHwiFQOXS9f+VaVbWHMOa4Ha7sL2ytLT/iYJY2akT/rYbnW8eFaIsTJPgy9Vyf6I3W4D8gkHrI3sXL0OkZdGpSRWIQqbHdkf11DS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2018 17:49:27.2065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601ea913-ce54-4aa4-7c49-08d63458e1fc
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEhpZ2dpbnMNCj4g
DQo+IFRoaXMgcGF0Y2ggc2V0IHByb3Bvc2VzIEtVbml0LCBhIGxpZ2h0d2VpZ2h0IHVuaXQgdGVz
dGluZyBhbmQgbW9ja2luZw0KPiBmcmFtZXdvcmsgZm9yIHRoZSBMaW51eCBrZXJuZWwuDQoNCkkn
bSBpbnRlcmVzdGVkIGluIHRoaXMsIGFuZCB0aGluayB0aGUga2VybmVsIG1pZ2h0IGJlbmVmaXQg
ZnJvbSB0aGlzLA0KYnV0IEkgaGF2ZSBsb3RzIG9mIHF1ZXN0aW9ucy4NCg0KPiBVbmxpa2UgQXV0
b3Rlc3QgYW5kIGtzZWxmdGVzdCwgS1VuaXQgaXMgYSB0cnVlIHVuaXQgdGVzdGluZyBmcmFtZXdv
cms7DQo+IGl0IGRvZXMgbm90IHJlcXVpcmUgaW5zdGFsbGluZyB0aGUga2VybmVsIG9uIGEgdGVz
dCBtYWNoaW5lIG9yIGluIGEgVk0NCj4gYW5kIGRvZXMgbm90IHJlcXVpcmUgdGVzdHMgdG8gYmUg
d3JpdHRlbiBpbiB1c2Vyc3BhY2UgcnVubmluZyBvbiBhIGhvc3QNCj4ga2VybmVsLg0KDQoNClRo
aXMgaXMgc3RhdGVkIGhlcmUgYW5kIGEgZmV3IHBsYWNlcyBpbiB0aGUgZG9jdW1lbnRhdGlvbi4g
IEp1c3QgdG8gY2xhcmlmeSwNCktVbml0IHdvcmtzIGJ5IGNvbXBpbGluZyB0aGUgdW5pdCB1bmRl
ciB0ZXN0LCBhbG9uZyB3aXRoIHRoZSB0ZXN0IGNvZGUNCml0c2VsZiwgYW5kIHRoZW4gcnVucyBp
dCBvbiB0aGUgbWFjaGluZSB3aGVyZSB0aGUgY29tcGlsYXRpb24gdG9vaw0KcGxhY2U/ICBJcyB0
aGlzIHJpZ2h0PyAgSG93IGRvZXMgY3Jvc3MtY29tcGlsaW5nIGVudGVyIGludG8gdGhlIGVxdWF0
aW9uPw0KSWYgbm90IHdoYXQgSSBkZXNjcmliZWQsIHRoZW4gd2hhdCBleGFjdGx5IGlzIGhhcHBl
bmluZz8NCg0KU29ycnkgLSBJIGhhdmVuJ3QgaGFkIHRpbWUgdG8gbG9vayB0aHJvdWdoIHRoZSBw
YXRjaGVzIGluIGRldGFpbC4NCg0KQW5vdGhlciBpc3N1ZSBpcywgd2hhdCByZXF1aXJlbWVudHMg
ZG9lcyB0aGlzIHBsYWNlIG9uIHRoZSB0ZXN0ZWQNCmNvZGU/ICBJcyBleHRyYSBpbnN0cnVtZW50
YXRpb24gcmVxdWlyZWQ/ICBJIGRpZG4ndCBzZWUgYW55LCBidXQgSQ0KZGlkbid0IGxvb2sgZXho
YXVzdGl2ZWx5IGF0IHRoZSBjb2RlLg0KDQpBcmUgYWxsIHVuaXQgdGVzdHMgc3RvcmVkIHNlcGFy
YXRlbHkgZnJvbSB0aGUgdW5pdC11bmRlci10ZXN0LCBvciBhcmUNCnRoZXkgZXhwZWN0ZWQgdG8g
YmUgaW4gdGhlIHNhbWUgZGlyZWN0b3J5PyAgV2hvIGlzIGV4cGVjdGVkIHRvDQptYWludGFpbiB0
aGUgdW5pdCB0ZXN0cz8gIEhvdyBvZnRlbiBhcmUgdGhleSBleHBlY3RlZCB0byBjaGFuZ2U/DQoo
V291bGQgaXQgYmUgZXZlcnkgdGltZSB0aGUgdW5pdC11bmRlci10ZXN0IGNoYW5nZWQ/KQ0KDQpE
b2VzIHRoZSB0ZXN0IGNvZGUgcmVxdWlyZSB0aGUgc2FtZSBsZXZlbCBvZiBleHBlcnRpc2UgdG8g
d3JpdGUNCmFuZCBtYWludGFpbiBhcyB0aGUgdW5pdC11bmRlci10ZXN0IGNvZGU/ICBUaGF0IGlz
LCBjb3VsZCB0aGlzIGJlDQphIG5ldyBvcHBvcnR1bml0eSBmb3IgYWRkaXRpb25hbCBkZXZlbG9w
ZXJzIChlc3BlY2lhbGx5IHJlbGF0aXZlDQpuZXdjb21lcnMpIHRvIGFkZCB2YWx1ZSB0byB0aGUg
a2VybmVsIGJ5IHdyaXRpbmcgYW5kIG1haW50YWluaW5nDQp0ZXN0IGNvZGUsIG9yIGRvZXMgdGhp
cyBhZGQgdG8gdGhlIGFscmVhZHkgbGFyZ2UgYnVyZGVuIG9mIGNvZGUNCm1haW50ZW5hbmNlIGZv
ciBvdXIgZXhpc3RpbmcgbWFpbnRhaW5lcnMuDQoNClRoYW5rcywNCiAtLSBUaW0NCg0KLi4uDQoN
Cg==
