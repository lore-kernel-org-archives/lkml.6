Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD7E23D29
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mscc365.onmicrosoft.com header.i=@mscc365.onmicrosoft.com header.b="H9AKDYW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD7E23D29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microsemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeGFQzz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:55:55 -0400
Received: from mail-dm3nam03on0084.outbound.protection.outlook.com ([104.47.41.84]:35184
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933196AbeGFQzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mscc365.onmicrosoft.com; s=selector1-microsemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAb3iSl6AAqyvuBEEAtv5NEssWiPhKIPvRtuNu8lqB4=;
 b=H9AKDYW6zVCvc2G71aTYNel6+d5H2paWUmDG1HO6IJK63GxEdwYlxHDqkSXTXApWCI5zk6GTwXWCsUTw1Zv7krCZNoYKKcNZlX8ZBJ+1do5Lpfh5yLhANzXa2O1aQHjkcA22RSfC92naI28ZywRtN603+oeM9CiOw9rYoEjUhQc=
Received: from MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) by BN6PR02MB3348.namprd02.prod.outlook.com
 (2603:10b6:405:63::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Fri, 6 Jul
 2018 16:55:49 +0000
Received: from BY2FFO11FD007.protection.gbl (2a01:111:f400:7c0c::171) by
 MWHPR0201CA0048.outlook.office365.com (2603:10b6:301:73::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.930.21 via Frontend Transport; Fri, 6 Jul 2018 16:55:48 +0000
Authentication-Results: spf=pass (sender IP is 208.19.100.21)
 smtp.mailfrom=microsemi.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=microsemi.com;
Received-SPF: Pass (protection.outlook.com: domain of microsemi.com designates
 208.19.100.21 as permitted sender) receiver=protection.outlook.com;
 client-ip=208.19.100.21; helo=AVMBX1.microsemi.net;
Received: from AVMBX1.microsemi.net (208.19.100.21) by
 BY2FFO11FD007.mail.protection.outlook.com (10.1.14.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.906.21 via Frontend Transport; Fri, 6 Jul 2018 16:55:48 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX1.microsemi.net
 (10.100.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Fri, 6 Jul 2018
 09:55:26 -0700
Received: from AVMBX3.microsemi.net ([10.100.253.33]) by AVMBX3.microsemi.net
 ([10.100.253.33]) with mapi id 15.01.1415.004; Fri, 6 Jul 2018 09:55:26 -0700
From:   Dave Carroll <david.carroll@microsemi.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>
Subject: RE: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Topic: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Index: AQHUFE+SkQv4rrPc10uDGWlD5Wf3BKSA5dDwgAFmboCAAB3lgA==
Date:   Fri, 6 Jul 2018 16:55:26 +0000
Message-ID: <a5821f3718a44782a41779fea7e0f6ed@microsemi.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
 <20180705110140.19545-2-jthumshirn@suse.de>
 <4cd9a8cb64dc4d8aa1e10c3b008c3ba0@microsemi.com>
 <20180706080301.gvjxdd4w5eun2x2h@linux-x5ow.site>
In-Reply-To: <20180706080301.gvjxdd4w5eun2x2h@linux-x5ow.site>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.34.7]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:208.19.100.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(51914003)(106002)(8936002)(316002)(68736007)(5660300001)(8746002)(53416004)(93886005)(229853002)(53936002)(106466001)(2900100001)(107886003)(6246003)(4326008)(54906003)(50466002)(69596002)(97736004)(478600001)(14454004)(47776003)(126002)(46406003)(77096007)(11346002)(486006)(81166006)(24736004)(476003)(186003)(81156014)(108616005)(86362001)(26005)(2616005)(23726003)(3846002)(6116002)(2906002)(6916009)(102836004)(76176011)(305945005)(36756003)(8676002)(97756001)(7736002)(336012)(446003)(356003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3348;H:AVMBX1.microsemi.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD007;1:+d58Qq3pZ4H/YaaNqQ4bDUx0CQhzzXPUP0W5CyBiYXo5meXQAg/83If6IpaA5qIrF8GiIqOTfzpKB0Mwh4QV2k5E3fG86RhaovjhMiZaZgZLlz6Hz0cMvBpmoV3ZCAFW
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae0b4511-5aae-4513-e07d-08d5e36152d3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB3348;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3348;3:EB94X72atI0DB/hd52AOBhNohrnAaMgsjILycKbq2ECRn7Wc82ApMA12ZTfJSFtOKTKdYSdEQFV2I57cAiG9p6HqUuMJQSk3PjUzBcHslFx8Rw4Jjqn12jXvIwE+M0/2YtNYRgafvC47oRHGhq94mnXGQJ22gfQN2d+Swaa4F9IR1DhR+4/S7HWI1K5NqS7oUX6J/QVEGjSPBoU5c+DyAT/DkwJszKI9m7Qa6VsuO39LDL0mb5sSHtbao+H2WfviucjZ7Qygx8Tg+ewTIV5Jh14NRNOKcyAloHMmHGLyyOdFK/GVDAwFLq+ustOiT2XIREvEFp0j+QXgHEE1AQQvUl8Bvg1YLMj50csG2eqyqHM=;25:dGZthrO2AlwfK6lIL9PetA4ojMzd1NooF9nmMCe+D7eIMU7NYvWituzmzQ/pX5/K4lWOwOdTVN2FAt9lXCEhC+i6ZWrWTpwue2s8Gg5rOzFb4XQMexQFkEvGP4YrYYs26wFO2J1zr64RYu6rWffwmM2u0RbkRWLebCcJn1iMo0QPQOZl4PHNci4bFiYfLQCyXb4deNkbZs1ZhgbZc1rEd279bykgM+h/k7lghgbNg1kk9CDJk+K4NpbCkHlBjcCrQBfD9v9mOniG0QNl831Qrlkm5mxDEEhOmcwqpsAuBZItuTfgSiFhIS+JMXpXqLgKbw26/FszSaX7ziXM7xojiQ==
X-MS-TrafficTypeDiagnostic: BN6PR02MB3348:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3348;31:4MRmogXHTUG5+9+Zhyvym4kx/wHLiSmTOzTg2UuqgEc0LekblPcKDYN/poVTwiAqN5ScLej0pUygxkA4TGceogshI58RUUrCPnnscGCYNVxLIJWTeQ7dQpE1stJV+sxLV4jatSlKo0elb1lL6SjKgcoeyTtsqLRdsDCGzRqmxGddWlxtBoQQPoEhOcH3rAb92HLE9q3pWIMvkGxRirQt1rgNyNWPRrd2pxQ5Bc5ryDQ=;20:2xNG7enTaJBJfDBpJcRIjjKLNg2GbJruS4zGmuepe1xcrnG0eSBo4IOES2yLjXZaJJMWjN9CZSztv785krSgSPkVENqWd6yrV4YSxHTVp/6LNZmvD1SpaI21HaOURC1jUV/6rlr6h6WL88qSdthm9HR3NxjAbl8YdL4UgL/Y4BBlBrhAZ2KOGrdwuND/UHTZLDFGmDCO47kpvxlJhl4CObNpWbp704IT9XHIFhfHs2KHS+njisEcjLMgAQQFvEzQwXDRR+jCfT/STMQwwjXBuMtJo9Kil18ZsavX/s2Jneacqu/83OKqKhXs9J06lI10j8Y5v8KekpdvTWE7mcx+rysjbB3/YP+oSrCvYQcEmIZ3ohNP9hCvAfmzfrVHM/Oy+POsnqGNmOwrCsa0DcSu+AY4qOF7jifRHPOmPniFRIi8JOU3vjpOnr+c/BduexXSJOzk+2jcll0CtXzx3UryVPuxIjKp6FtnlSfCQAdRe30DFEB20vzlyJH2i7l+BaSR4zn00lGmEb/NNbZ96d2ukjTfNZLf5nDAajg3R/kwuEyy0uhS7gU12j9OHyAZZxDjlC2iw0RoGNtBpvh/C60eYm4xQU4w7LwGVtsYuTZmui0=
X-Microsoft-Antispam-PRVS: <BN6PR02MB3348F1179BC65A8319EB2212E0470@BN6PR02MB3348.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170198267865);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR02MB3348;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB3348;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3348;4:rkCgk/xgDfEIbHcDUGacY6yQ0jFgbj9/1PoHr+rROYR+Bz1GMgqDbgOvvgA4o8kzp4vdr0ghBVuxIjM++mcf3LwjUVvyPO9mwDf9t0rQR14uOBLfxGPCiPDgn7vSlWMXrqIyQTpDQUtegoecQ73SFOqFTR8HvFUtSYO4qpKuDKq3knJj5X5cQ2V6wFCklmVFlieACD7C5kBcx79ViIum8un4Xz6wQ50PyP1+uVZVR8fG90nuzcpxXSama/j5PTY7leSRv+ldr9QyYOVTQ4rdTFIZr4WCBcqNmcCgT4h8/wuId9/VKmEFcQO/6lHbsVM4
X-Forefront-PRVS: 0725D9E8D0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB3348;23:URv6OQAv9fpT8pihi7Fz6gkhXu1Im7tmeUTvksmAc?=
 =?us-ascii?Q?wtoDmdvhMBqJqy+FkmLVON1rnK+163KFjw7oBZSv+6V1mxdF3VPI5uokOTu3?=
 =?us-ascii?Q?jBRt9rGWyussgcGMaiOBmkOU2kp+fZym3tSf7FTDWu7Fu6uUHNSz8ss9WDnT?=
 =?us-ascii?Q?J6ZUv0rpU6rFcdfvfH26+FmjmEkvQBFlkN0gizb59UDdMcJmKfOtH3d09NsS?=
 =?us-ascii?Q?55M6HYHbqqaiqNX4MqQbN3M6j7v/k+16vCG9V2rQcR0EUlNUlqi99EEMB2M5?=
 =?us-ascii?Q?SvKIl/su2gRFe17hb8uqeymmxGWHyxwzKYr/NieL1cKRpZKuo/usRRIJvSFC?=
 =?us-ascii?Q?nUn6unB8DWginLLUDWF2h1y+CU0yNLzgFKOB5nJyJHdxhMPD7u47OkL1yX1o?=
 =?us-ascii?Q?skf3GXxHPB5Me4LhDS6JU3eS7duDKPPnyGrj8Zvi99znTqZakBewzoHFfLxc?=
 =?us-ascii?Q?BWl0h1oSfiHxfYGOH6kfcydGqYT4jAShOykxMVFDGGylXxY4/5Ptfb5l1pjh?=
 =?us-ascii?Q?mARQi4N7RwUL+NpMEVLb+QmC9iuTaO84G1lGs5UaM/sJBuMVBWnevkUetlRp?=
 =?us-ascii?Q?hImaFNVqm3Ew/umpQgeGvM7z8d6NsNkzBehAgrtcHbf0zC0SYELthk1vRk+c?=
 =?us-ascii?Q?y0XozRSRPIbWtQGBq3dUK+l9mxkHniu5O/XrCguiFjP+VkJDtln8gkz00uBi?=
 =?us-ascii?Q?kcv4KWZBiBoXM/S9t+IqDgSMsohS3/YYwUwR04/4pq9FpHns4hWcQMV0/Cxn?=
 =?us-ascii?Q?KJPentOFbbU6w9Cji/oMJFPRKEulyF0r3XjJurllRc0rND9SSypBVxfDwsl6?=
 =?us-ascii?Q?/3h1hJARm0c8JTk3dV21S7qz1+ivrcP+S40szLF1Flr7BEabaL0Jz8vKYChx?=
 =?us-ascii?Q?TTHljGeDh4N4Bn9iIt3OA8CPVx4gO2vv6LUNz5sy4e4ctw/6TUQPIRWyMGSz?=
 =?us-ascii?Q?vmGW8i8u6DCf9qmgu/BmAH/HudWW4vIk8p/c92oVsyNXjxj12+0LUMc8k5qy?=
 =?us-ascii?Q?yG4Pq6s62JI8PzpLNhzCLIYg77lN0W8PBNh+2eKqSmgeYVfxhKwDfPv2f87t?=
 =?us-ascii?Q?v5GJDcYlDyuHBXVuUgeRJg5fUATWJ+n8QfdXOB7zFVrvd6+W5JHTydgQrqqp?=
 =?us-ascii?Q?TdCLH9lgv9syY79jkN4A6QbshHpJgLDkvmHe4LlAkNWV0norKDROBT859QZk?=
 =?us-ascii?Q?bNLyiYT3PGiNmXCIbeizWtCyyfY07yWssR2ohVcK6d/wuM+jn51h2/5h9UsG?=
 =?us-ascii?Q?8wnbVtFlCwWIk1By8ltB0PSDHNBDTq/V9WKYXRNDiwHybGjOQxUFTOkV6BMa?=
 =?us-ascii?Q?Yp9NUe9/M0JiPY9Z+l8y/EtDea9jUR5XizsGco/XgFO?=
X-Microsoft-Antispam-Message-Info: Hfo/SzFz/vPRxq9ayIq/aWEDtE6KecGI2rlNlJ8bz7IuP42TERJT0xfeatTB9koq58FUrmdVTZatzLjhQS373zbgnYvh/NNow0F7fJWaIFUokdmdKeJv8n1TeLC3a1ii+K3O7uAwCz+lvwzQGLSpjwur9jHhxWGJbR/RD2doqUggBWKU9aLrO2q2KAkhCgrvEue7HtS7/+0ZK8cTkYKhPK+J6MTzE5AtkuTq6SEPeAkp+7/SBy89CfrhOtlrl/6WHyPYMC1rYoufU7ivP6yE5ztWlHcdIg02tX/9VBqo1AqY5xzLegy3CiMVGOo+iUx+09fOCPL13Ow1onXvJilRz7SKge88tLwhlNNeQ29XpM0=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3348;6:XpKtRq3d2FwGX4XiureFbGtbexHcXIh0Yjb3cHPLA6YqkegXm0PXFqQcyTqIhJhqvkbkHKYcWosjm+Yw4s60smGs6HVXz4xX98OH5I6N9NuZqhW5+y0Hbjmo+WS9XSAfatCgCs1YdZav0msfwgR2FVD3gcV1gg7ycFhPlgDk3UBULJPE56XxwgupjJWoZe7Fis4tz9+JD6t6BEQ6V2DhC9SN85BIl03t3X75RDuqHwTTuQs6hGJiYBd1l09zBcd+yScikJTjWkO+Z66Tn6SEUERxU1m2GToKWAI4Nx4ArauxfcJI1uOUnpXoCk8AAde9vcdHobrI/MM/+rH8IJENEncqwjRbDrg1NbaADnok5vTvKz8y1l2Z/yZ8W36+LiYnazqqH2QsCKlY69vf7FcoTJSK/Z+Nd4hltyYip61lfjDotCO2XSvvMsmDMkvntnJPiA8ALnPhOSuOFD2pLVY4ZQ==;5:FQ3d5TKyz1Ab8vw3F+YfC7HehgmojZBlLbe7iZh5KDSv2gi+K28LqUrBgWuke7vSThKPzKJiFovQP9miVpk2nFnEuWJIb0Is44mA4oPNQ5hAUmtgfw3ioyt/kY3OGqPcPClj33mPQH/hRYvpAwptK9JZBbLJa7SBV+6yThqZl7M=;24:x1C9ycxwIJKGisvs4KPCtZm+0rlnoqCckhDvMWTKv6Cv2zFwlaPEDCcxw3zJ6IWkmeSgdbYWPexDQtziveRuIc0zsYyGDU48pvS9ysZ5yXw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3348;7:7+cih3XMRNgC3kimqBS+gIJ6/l2CBSnfjbk2JMtg/ty531JYNkMB9jZuZHjx/7KEXNz8OVrTw6z56GLjx6o5a0HU2EWKjyOsRiyvS9mWVyM/Cl3DEtfB1nHFKxZaRRESK2OGa5ZypATTtnxlr4JrXwnlm9+VVa38EbJ40f1zZBaNxWBeeLnuCZfabavKtjwvP6uyYtNO/rZCZ4Fc4AC9Vv5akXlCke7y7XKpQ0sEMGy7XxgEnpdtCBpyvaL9Qto+
X-OriginatorOrg: microsemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 16:55:48.3273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0b4511-5aae-4513-e07d-08d5e36152d3
X-MS-Exchange-CrossTenant-Id: f267a5c8-86d8-4cc9-af71-1fd2c67c8fad
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f267a5c8-86d8-4cc9-af71-1fd2c67c8fad;Ip=[208.19.100.21];Helo=[AVMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Thu, Jul 05, 2018 at 05:42:02PM +0000, Dave Carroll wrote:
> > > Remove the AAC_STAT_GOOD definition and open code it in the places
> > > it was used.
> > >
> > > This will make subsequent refactoring in this area easier.
> > >
> > Please don't ... the definition itself was added to make refactoring ea=
sier.
>=20
> Well in the end scsi_cmnd::result as we know it currently will go away, s=
o
> splitting up the define is rather crucial for this. I could do it when ch=
anging the -
> >result from one integer into 4 u8s but doing it in a separate preparatio=
n step
> would be preferable to me and it doesn't hurt accraid at all.
>=20

Thanks for the explanation Johannes, the routine is unwieldy already, and i=
t just=20
didn't feel right adding back all those lines ... Looking forward to the ne=
xt step ...

Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
