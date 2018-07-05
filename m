Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9F9C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39D324048
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mscc365.onmicrosoft.com header.i=@mscc365.onmicrosoft.com header.b="l1C44XTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39D324048
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microsemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753735AbeGERmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:42:10 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:1584
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753346AbeGERmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mscc365.onmicrosoft.com; s=selector1-microsemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1d8A32of5HLKd4vs2tKWUI7j5LYsZ7iaceSfR1w4S8=;
 b=l1C44XTuV0etA1hZxMO6AGtEXGtTpiGbn3Mu8d8kx4Z8QJ8W4pRto15aAw1HPrslxEsM5e0U+yCz5b6+2dAgC7tkldOBrMQb3S0fMMp3/AkdeNnvthTunZRficQw7ivAvAUtqQiNBNUi84sydMJ+fkR1OIxtGkdgMZskRlFU2yI=
Received: from BL0PR02CA0090.namprd02.prod.outlook.com (2603:10b6:208:51::31)
 by BN6PR02MB2498.namprd02.prod.outlook.com (2603:10b6:404:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 17:42:05 +0000
Received: from BN1AFFO11FD011.protection.gbl (2a01:111:f400:7c10::107) by
 BL0PR02CA0090.outlook.office365.com (2603:10b6:208:51::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.884.23 via Frontend Transport; Thu, 5 Jul 2018 17:42:05 +0000
Authentication-Results: spf=pass (sender IP is 208.19.100.23)
 smtp.mailfrom=microsemi.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=microsemi.com;
Received-SPF: Pass (protection.outlook.com: domain of microsemi.com designates
 208.19.100.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=208.19.100.23; helo=AVMBX3.microsemi.net;
Received: from AVMBX3.microsemi.net (208.19.100.23) by
 BN1AFFO11FD011.mail.protection.outlook.com (10.58.52.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.906.21 via Frontend Transport; Thu, 5 Jul 2018 17:42:04 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Thu, 5 Jul 2018
 10:42:02 -0700
Received: from AVMBX3.microsemi.net ([10.100.253.33]) by AVMBX3.microsemi.net
 ([10.100.253.33]) with mapi id 15.01.1415.004; Thu, 5 Jul 2018 10:42:02 -0700
From:   Dave Carroll <david.carroll@microsemi.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        "Linux SCSI Mailinglist" <linux-scsi@vger.kernel.org>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>
Subject: RE: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Topic: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Index: AQHUFE+SkQv4rrPc10uDGWlD5Wf3BKSA5dDw
Date:   Thu, 5 Jul 2018 17:42:02 +0000
Message-ID: <4cd9a8cb64dc4d8aa1e10c3b008c3ba0@microsemi.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
 <20180705110140.19545-2-jthumshirn@suse.de>
In-Reply-To: <20180705110140.19545-2-jthumshirn@suse.de>
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
X-Forefront-Antispam-Report: CIP:208.19.100.23;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(336012)(476003)(486006)(126002)(2616005)(11346002)(6116002)(23726003)(446003)(3846002)(8936002)(106466001)(81166006)(81156014)(8676002)(53416004)(305945005)(47776003)(8746002)(7736002)(69596002)(356003)(26005)(102836004)(186003)(110136005)(54906003)(77096007)(316002)(50466002)(106002)(36756003)(97756001)(86362001)(46406003)(108616005)(24736004)(76176011)(229853002)(2900100001)(478600001)(5660300001)(4326008)(97736004)(68736007)(53936002)(107886003)(6246003)(558084003)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2498;H:AVMBX3.microsemi.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD011;1:HFqxB/xFf2gtE2GtjBvEkYnk+eYLGgqRmaQDVlDETMkUc6q14IQyxMsjizp+dO+gWe97EMgM+PjbzF9Q5XBlpvXKpJownGz82bRk4gyP6Z3SIA2KiFheOMcfv0IQYmoZ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 226af142-ac3e-49c9-9392-08d5e29e9f77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2498;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2498;3:/ln8ctLC2lZ6ubb2UUs8ywBbSYHeWt27RyceY4m+PcHPQU1gxcbUKr0V/hwDFibSbbnH2GAZQy4AP8XqzMNMCSydPQGhXC6lyohGhVe9v6AXOTuqz0LrYbXETSl6odSEsnvtPcKexzt9MfzM5b2VHPFg6nrol37rbRR7nHs/UECqVrEs/OyDJicttABZ0WkvPFb5DObE1pMulrdKLQsCh+oGOsr1311oIgJvb9trh993qCOMaRzh+FV311e9+h2psCgti+TaEADR7Ad0Rik9EPkDFf846sxogSkrO2Irq0AGydsAGy6pNtPsX3WZXq5g+V3hlrgzDGfYlcnNSiNtfoIiyVqVIHczmKp2uavDXK0=;25:E3AM0qVjccz0AtnifvViIReHhH2gbLNPE61TVlmkUtsd2RdG7WeIksRlhD3h8daQHOsN+1+rFRKQA7IW90a3wcCzAtJ41SIZhSO5JyCIDWj0z99z9bkKF3FAfDuYcDKOSmVpRq+9f9PW1mTzY12SqId0fR9GYhs7vjTo3u4HizkF9GZ+sw4G61YFCIPL38SC+ZqJKf48n3DfgjDG0uT/gwohY1v9SnKyXEGxQzB9sWqmLe7BHO75qFiX1OMWEJqQuK54KHlJ07OPVwoYD8QQ0w6pHJ1bYJZONzgnoee98PyI7DkgBMqScOpkry63jmUMy+SjuqIaRGQTr7z0QbKuzQ==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2498:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2498;31:yRJmPo+GWhwimWGBsoO6+l5ggbFh7Figl0YRHnEJXRissKwWXoB5gQyHlt8V1aSRd0bSV6HfrP23FsQXWj07jvyoBlkwKr5PVwotaxNp3yxY7soy6AaHCfIqR95+lDpqPEjMUE3Re7b+XEPC1fmAC80UOqMnTyOdVVg4/0dPk8WXM56RZ1s+47VG5DK0CLaypAuHz7VOlfDDv8ER+ERfiHyHvmYOHjSSv2RG7z/JXV4=;20:WYFbI8x2pGZGhP9cWCSVqZHhYPUhGdyubP2MwqU1lgUB5ZlJYUNCzL2QyKQEsk7JIiUGLdOXQ4Sm9EXvOGYO3abzDAFd1vBX3UvPHgQdpZ1/2WqI4EpPFdE5pDnoAgJd8wmi5md5xsW0zJQ56qY8jmqZL6slwH0ujebkfLNncws6OJehjFuNaOP8wk2kYHt5mmhQvcFPOgVkBYzrxV3puqmm9EROnkot35dTJ+aiL1blQBAfJGmwWveW2M7Dl98ChkXwCazxK0wHP7bOqNIFXxzFB7oYjllOJDSAT2PEs3av4NTip1monwr4N97bq/kkz3XC5FcTaMtTbilrS1TaAKyjpDjWFCCf/miAum/9fwnyOcH7EqIxk9u3JEEUbspVoJ8jatQO934CQlUwfid2UJ4KjRoEfjzTB+lmt3a4ka8K/5qHi0AeVBYG5tnTzwF3DHbG5FG8bcmBBU2AuE4jSDa5eHqBgeFDvpXbMzrDP/Q8XAQvhX8Ma5kL/62WlNWzKV6l2KhTN/8VpOIsqfqyWYxEJRK+Hrzac/FRTOXMBHpsgXe8QsAvXyUKh9WGYea4kQLuhm2ePo8vZfYRH0dCJSY5HUs9V5cOqUnPRSvxaco=
X-Microsoft-Antispam-PRVS: <BN6PR02MB2498CD978613F3034E7E3948E0400@BN6PR02MB2498.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR02MB2498;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2498;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2498;4:x3buJkej3xQfQ65n2TOq7w4Rn0w9hbtS01+QE3fsDeLR0j2Kjud7r5IcrhiQ+AeBbRpKVnB7rI1eu1QbKyPWPa+BhF4KoaO0WTu/Mb+fEe5hRMG/GBOQdXcexLRN1l8BbPH2chlpVFaxejewGT3A5jR/aLovHOSFbY6HNr89KmDA0LXNZwm9zqKhLNMZWy1lD79DfDYMfhuC/pAzq/LQ2hRMnOC8jS33shlX9jhH9EMsJMooOXPN/YSRSdPbkk+/eOl74QVf5RrdlAR1hcwNqg==
X-Forefront-PRVS: 0724FCD4CD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2498;23:7exmqWRfGPUogEvZxYm8TxyW0yE1puj+Ii3WYHBzB?=
 =?us-ascii?Q?8mLGbzXIxtEeoEY2akQ41Y4nQJB9l/3HlwmG9O2/ls00kmrKmPCNliX2QygC?=
 =?us-ascii?Q?Q71ufkvbnUjxYtCM4XP16xtTjKJzFVHFYy7nvBy6v53U1kTufwBQxgXCi+R9?=
 =?us-ascii?Q?iIbdSPL8t3z104nKiK2XewNvt57TpIySHDtf9Dd+1LV69y+XyVejFrEY2JwP?=
 =?us-ascii?Q?j/nk7XUK64a2+b/4Bzzr7oihAnC+OaD+I0LOz69eVc7ASpzqXbQSaM/hE7io?=
 =?us-ascii?Q?gN2I4kfmcZWw55LzXO37VpJnj93vWX1HDaikDfmzl54f58U7pfxp7ieQNM7Q?=
 =?us-ascii?Q?zYpajsx+xPXH85QX+ZUDnuW9b3lVASQkhXfNBAuOx9WyjRsk5oXS8WCTG63j?=
 =?us-ascii?Q?RmWap0VPQCfRgFmabGCPadZmhA0SVrTRggLtRZ9mh2KBOjRtktb4Sn7X3q7D?=
 =?us-ascii?Q?Tjv0GxNcBm5+XiojsyApqad8AwgsitZPo1f33cWglzeEZ20VNHk9sgicYJy1?=
 =?us-ascii?Q?K6ZW0n6gxdgYBQqq7ajsMDPrvY3WmnNXHe31dT6UAk7QlTcvG2z16B0pUQbk?=
 =?us-ascii?Q?lMEjxRHGJPH3W50ORDia/nHhvv5Kki3FJVWMvmN9joUhIFeC8531LmNM6FGa?=
 =?us-ascii?Q?ZZAqdc+nW/Tg4aGP8hwa7lQBkjfEy/IqC5aNk62jjk+pp46+iLwkPI7grt/v?=
 =?us-ascii?Q?U5BdykVzKLWO+mt4X0h2+Q8s8j5pqBXQ09+csmNuIKxn4hfU15Mb6CQoeVpJ?=
 =?us-ascii?Q?/0cak3/7f8cY6hQeGhB9SY7SNgAHP42dNmN0+NKTU2lBoqhsSWJzHnRvohHG?=
 =?us-ascii?Q?V5llXjsD4vwkohpjMSY3wVCZV+SIMFzIwih4V4KshqWRpYm4g4TaNNv4FAZv?=
 =?us-ascii?Q?2Fk5p57jWoA5BSYM9/wnCDWrDGNQiEoCTKX0sB18sWHDvPKaLRzej6EmdT6r?=
 =?us-ascii?Q?CPjJA+Yj26Jb5zSQ9dse58E1nbD7zYrV9BdaPr0NDzFxEBUMHPzCh0opzls9?=
 =?us-ascii?Q?2V6zD6cI0s/RaJrom33qIKiMuDLwGQ6AfC562GbQZ7xWKq/nwnuyIpktboE8?=
 =?us-ascii?Q?Hb/jicuGl0uOqduuab8GHe/3dHjQiOyHMF/bK3mb0ZFNPIB1c1L/AlsJZrnU?=
 =?us-ascii?Q?cppNcIBmWgi28/HCAB2d4KFOLN33fBdOdVx6kBdOwKSESym6XPzkM21jfuGT?=
 =?us-ascii?Q?ZLUFJm+zHygC4+doXywPdglnZBip+CeQNfim3LCAO/RQ0PuZXmMrAL7VvveZ?=
 =?us-ascii?Q?DMT/T4uEEwIPKxUQsuD6//sy/yE2+ufR3LbbCAl3oecsFgqJXp6cL0oNP2EA?=
 =?us-ascii?Q?mvGQ8qdWE2AxsukwLQLhKA9e8SbkMm82f91ATKVRU0n?=
X-Microsoft-Antispam-Message-Info: c2MQNsFJZxbWM8feMMoIXdeIrLSBRxHMmJSpIiPset0DUEzPBhSDjwRU7IYXD/qX4PzCvEJfDZ6GU9eawKgn8in3cyA2IHCNg+fUfHef9tg5w2NP5WHe5629PT/V/jffkP2+Ywb5E+5G8golRUrqvKESJK+EmgC2i962ZjWlzXaBsSM3eWGcvUaVLZIRgyNMsky98BqkAkBUOycxtgaX01eQdsbcQQi+HqkWBs5Jf01yIRi2sDbnMSULaFFwOFWx0FyvAg7elc+M+glFl1eCZarhmvAE8UbZsbmhfQx9tp3nuZ2JDNTGBa3+a70/0PmSpscXOr1+QIIo6rbYlnZdNCMTT0vtmXwqverbqmdZXLY=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2498;6:FIOEi/dAhXFt+Z0q0vHyxjtUGWJybEFjn5/VmtvMUnPOpbvzSkXBQADHIk2217Nn381gybNA7/OaQEF54e/xjvdwCQye28GNSo+iEL1Llfv/n9sUSBHeqGcYdBGt1mxTqoRutvwalCaX4tCIIUbUZW+OpkSZnmUtwDxkBdajHIRAOv93Eu1ZkBnPhc/fQ1dY2zCcGU5X/ro+eL0r554qAAR7B1Gj50KvEZkEM0+5R2QJ9oSzhEMiwQ+0fKBKWdpEVsPycDeOEj5pKoZIjp5MwDOJ5vu71gJG54QGwOAYLIMVfWh/fE9+tW6A4lj00mh/j+Hct1Y048uhUn6tORjw3B4fXmVfhKondI/y1qZD8r4sOQuqGJbmTVeixsOkp1bEQsrc766oPUdBV5HfdEqAZM8Q7xGbdV/YlFo7p+mjMrqtBgxjevO9CDVzV274/DztVDSeHTeHQhkXJoipsGAHIw==;5:QI+Z/b+EhDPSaK7B9ZKLlQSOCX8Nc57HlN4b4p7YP+kuGa7y5CiW3PvArXFBjbvo3RFWN/I5s+RR0PoEIwoIjogXqNQ6dJY+3cHEtj63FFi6l1nd/Z1BjkD6jEBbubAm5HKihNQgX+7HkZTlFPloHJFRNOmulbXCMgEiKBqe5AY=;24:X6pYQdlH5rpUgvFo4rwUq+W6i4bQaArLn1S3iuAclaPP32KoZCBC3qite76xZVFUgAH3cDuTCH5o1PKW7eYdBUJCqp1tu54sDGRkS0FqjKQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2498;7:K59ZojeVuR7w11w19b1+TL5BB2yqhBD2toI0MqDJ9ms+pYPgKu89KNspjA1htdLYarnle7aPdQZ5VqBOtDDkPTdnSY4mYfD3bgDQw8HGOEWC3yRYLu7nLOxzT+puR+OJGTvKXX1iFbcn0mgT2lQigFdt1x23ZcY5krHE+YbStSi2cdsXclb6fbsY4+qymPRzb5h+QU34ZDzP3r3ApCZIppB527WkwdUJ2N01H8d4Oc6zbwyME8EIdnA7VqgFpxZw
X-OriginatorOrg: microsemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 17:42:04.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226af142-ac3e-49c9-9392-08d5e29e9f77
X-MS-Exchange-CrossTenant-Id: f267a5c8-86d8-4cc9-af71-1fd2c67c8fad
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f267a5c8-86d8-4cc9-af71-1fd2c67c8fad;Ip=[208.19.100.23];Helo=[AVMBX3.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
>=20
> Remove the AAC_STAT_GOOD definition and open code it in the places it was
> used.
>=20
> This will make subsequent refactoring in this area easier.
>=20
Please don't ... the definition itself was added to make refactoring easier=
.

-Dave
