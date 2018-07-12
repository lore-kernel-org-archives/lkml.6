Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED67C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9222820C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SN3/1HP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9222820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeGLIzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:55:14 -0400
Received: from mail-eopbgr60124.outbound.protection.outlook.com ([40.107.6.124]:11076
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeGLIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me2YHz1AVg6KQalV9x7FAhfe6aFTfXHKYzZEn8dlu5g=;
 b=SN3/1HP+XQadQSP9m7TJbsHjg2sGHmDZMl5xhSG67bguLmYen0saVXhm98JcouAGQhj2ul+6NsfWzfztEKr2y18zgZ1/Eg2zLKOfJT4ECrh03O/5Ct5GFqD4553IFo9Y/EZc5oXbEWjMt2CsSBscvQjrX6kNvWYp4l/i5XDnphs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB2017.eurprd08.prod.outlook.com (2603:10a6:203:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 12 Jul
 2018 08:46:31 +0000
Subject: [PATCH] bug-hunting.rst: Clarify bytes sequence format when making
 "Code:" human-readable
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     corbet@lwn.net, christophe.jaillet@wanadoo.fr,
        ktkhai@virtuozzo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Jul 2018 11:46:25 +0300
Message-ID: <153138515186.6379.2711739561825941424.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:7:29::38) To AM5PR0801MB2017.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a3c5d69-ad32-4813-97dc-08d5e7d3f76a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2017;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;3:zrAFyTdmOf+uDPBWCKdHHZmMPAphyRGim7BmDziBAgHhfhGiTpwDn0L592HIU8QgZNYaOOpSNtEWndMucCzjgUeXGB1JjprrOAj0+mr8vKAnMeMWnEMBLbPNkW5DGp5QX37gTT92TgT0WtiPqFNBN22fyU/b1tvYjrDd0MBo99dl40kerbR5NYmRsEY/btIEJJwxVjhzikH8P3bBr+a4d4Ny/EO/vyf14AM7JEcwIXjFowMFaTVVHEMSLIGFlv9M;25:AOILjdttCvJODUh7mJaT8RLybRyd1PuZFy5ZxVC1RHdDxiMBQZ7QSOHuW0hUa/ptcwh1FjsJ6aL0Y2082mYInR2tGT/wj7k3WHImq7siZtRqbzj/Ne55vttAp/VAUQuiZ5hNCUEkM+Qceo++JAO9XNN+jeoUjaXTRjdAnCZeioI7vn0AmCkp6uQvwB0nj8kXSP42NQGfSJcYdWFGmqA7Vi9WSXeXS1iEvnpbZzCq5GCYRJ7a30qr20u+l7EVc8WELMjzcra/K/rOxYXbwPSSZgixVhrVos1R3qFqKvf4Uda4168rmBEbfXdgsK3+6zXPu1pNly58mxYE0YdE7+xVBw==;31:K5XgCjwYh4v1tG6F1xwq7DA8pkZ4TTFf79yLPAp/Dl9+b1ktPSP449deERxC/HUmv+dJt9yLqo/CaUg33P90sHghjwRXwF3tSDIMii9+ungwnbHIM5knbwTddH3Hml7U+rneAemR3PhjUhSAzWNOV80yUimNfKdO4njcCV5bT775smKhZ7I2hdD3xcuyDkRjwjxFrwr3AKyRb9AbiWwGvUqC9mVbc8s3B1itWbZFJy8=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2017:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:QRp5OWka8wK8rkdl5lUHwJ2ShEMCQ/pszg+yjUxvl/n4aCT830LGkyMdozGU5NRchquw+bwjqdQI6iJOk3J3qgDmhCd+bvxpDMHLkvDs5ElheqBtjEFpNQT3nCRvwS8XQvcn7YEBPH1hYyB0gGz30UuvICHP6tUZhBZsgHFeXQ48vXNRurXeBwl3Vnf6loDszP5ZCWJ2dSUE/TKNtl69USZo7kUjzi5KCqdbsrUtV3/5BI0gURKGZIOIBkmrRozPo7u9sFlOaXquegumbz+JFjD3B2bYjJAGjMLrGxVTF3VezBWy3fu/BNSD6XM0OyAftHKT0ErYlo5wI2t/JKWqI/jI3tle6Xkqv32igXSn4cCXJ1fDlIzV0WuFE1dNOrKhMUFPq3O0Yk4gDSrmLmhbfo7yuNoM+N9TxkbEklWXWzrjAEZVMu/4RZ2AeHUzyc9FLSy/ths/c2wsEXsGcaPBcyMiMyewqs8KNaUywebmrkkdAZheKX1FhgjJFie8oVoi;4:eMM/6Zjxnr2dnXyPBQTsifkSgYZksCBtCvk0NBtoHt2fEo7q66dMb2mzoJYaxar66mZCZGSg8qbCntZgCyTNAtzF4sIbz1Tduxr3SGqf+xkoV6ngpIQO4Bbd8iCYw11adaw6ei5ZPf0UqTs0wpZ2hM4qOwBB4/xW5YlGb0q4pg4OTTECXKtMMl6/lctKL3vVqpdfjrPASBfRqPr63FUyL4eaAuXqiFrbZjVnBWhM7aw23V24CexPPyPjgKiEcNdupkVkTc6QStPCrY2ZhJzQFA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2017AE2B3196616C1C64E6CFCD590@AM5PR0801MB2017.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2017;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2017;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(346002)(366004)(396003)(376002)(39850400004)(189003)(199004)(6666003)(5660300001)(86362001)(50466002)(316002)(68736007)(230700001)(14444005)(58126008)(8936002)(105586002)(486006)(956004)(106356001)(103116003)(53936002)(97736004)(476003)(6506007)(478600001)(9686003)(81166006)(61506002)(52116002)(305945005)(7736002)(2906002)(1857600001)(81156014)(186003)(16526019)(6116002)(33896004)(8676002)(23676004)(55016002)(386003)(47776003)(66066001)(7696005)(26005)(3846002)(2486003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2017;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTc7MjM6ZHIxS2VxWXlTWkFHMzh1MVBGQkVmUnQ3?=
 =?utf-8?B?NHpPaUx1MDZmRUFkdUdGRGhENEJVME44T3pMUGR3TDdVY3lGOFZuYWNxVE5T?=
 =?utf-8?B?TFROaWM4QUQ1NDZ6VlZhdnhhUjJWQ0pxVHF1Q1hEaytIL0hOVXd3MmdqYnJO?=
 =?utf-8?B?cFZFS0VGbktkWXNhcFM1VnB6bDFHeVFtMXhHSFB0Y1QrczRhMVJxaTFWZGJl?=
 =?utf-8?B?ekVHaUdhaTg5V05DWHpUL0FQUDFkKy9MTHVvSEpVOEd2bm5JZ1ZYMTQrYUFI?=
 =?utf-8?B?K1BLNmZMODdsUTdhZm42L0NyOFM2SFAxQkV2TnZwRFQrWXc4VytDMnhsZjVw?=
 =?utf-8?B?aFdLZFcvTU45K2tFYlRIdVljTzFib09DNkV0bXJpM3c0aWxDelYyN1pXbnZB?=
 =?utf-8?B?VTk5aE5PWE1zay83UFRKTXhOYWF0aFIvL2owcVZIWnpDL3NER3BqRUVUamZj?=
 =?utf-8?B?cWc0ZmhLOVFxbjBDVDQxRTZva2pmMzRDN2hjYW1BRG5UR3pkVlhjV21KVHlH?=
 =?utf-8?B?aUVDbEdZS2RmQ0htcitIOWVsVUM2aXJ2M2tWdGh0c040RnZpKzdnemNRdHZO?=
 =?utf-8?B?eGhtNVdkWkxHOWxpR1NXdWpTMWczdG1ZRmpTcGxtYjJpcU53aURlSFkzYlkr?=
 =?utf-8?B?cGJmYXl5bDlJelphOE9DTlVPUzZUeTdieXlqZDNVYlIrOXRBRTFnczRkY3dk?=
 =?utf-8?B?U2pNeW54Y1lWaDlWb3lSaThxSkhLanpRQ0ZQMS9yR0tzZmJiei9BZDk3ZkY5?=
 =?utf-8?B?Mkc3TDUxUzArU2hiMFh1SUVtQVg4K1JmcUx3OG9ZUlllOGVhZjkyRVJ1Wktx?=
 =?utf-8?B?UHVEVTYxRnZvK0xqdjNZTExxcHJtZ3p0ZDZ0bVU5S3BQK2dzb1oxd0JhVjZD?=
 =?utf-8?B?a04rQTlHK2trSWRWT2JQTGd4R01oZlFxOS9lditqdG4wVENCRXQwaUNhSkFy?=
 =?utf-8?B?NUsvWnJvU1BDUzcxa1hzbnJ1Y1hDYVFHSlNFa2VXY0FyeCtPK21QY2VLcnlK?=
 =?utf-8?B?RDhNWUowMFduVkRVVFUzbEJPUzlTSllUdklkQ2dEL001QjhLTFI5UzhnTjlJ?=
 =?utf-8?B?dGg4dSsyakt2WWtwaG93bitma2VTQjVWUXVoSkhlc0svZlRjbVIvc2xVaTNT?=
 =?utf-8?B?aWQ4bzhwa1E1bWJKWi8vcmk5cHFTRXA1UWRtTW5VNEpwNzc1dU9mT3d5R0E2?=
 =?utf-8?B?ckQ1YmZuV0IzZndUbFF0VEJXZ0VqSVRoUHFLVFZqbFc2NG9XNlRnd1MyU3c5?=
 =?utf-8?B?MURIcVcxK2JaRFZ5V3RYSW9XOUExRDFCaEEwUlFSc0Q0RUt1SEVrUmlTWGdi?=
 =?utf-8?B?eTNTOC9VeXdkQWkvelBGQU0vdzJyUmRTUVNiTTgvamo5a0k1ZUNFYmkrMi9o?=
 =?utf-8?B?RWc5Vis5YW1tZ0dTWllCM1l2aEt4R3lhRzlWV1dSbHVNTFhWb0xrbFlHZksw?=
 =?utf-8?B?WWRjcU82QUwraGFJb0dUVEJQWUZ2VU11MFJLSXp6T3FHWTJVYnV2NHkwbTFW?=
 =?utf-8?B?bmJKVW5ZOGk2ai8wdXQyaDBCcFNtd1JRdkkreGhEUmoxK1BlNWVlNDdyT1JG?=
 =?utf-8?B?WkRFa3FVTzVvVWZmOEVRZlZXYUN4andkMjBBa3FNbHEySWlkdUE3RjVockpV?=
 =?utf-8?Q?A=3D?=
X-Microsoft-Antispam-Message-Info: DicwQ9H+n3CzRCwVK6ZVjq17YSRHErNWVvnI7IL3wTQjENQkOU6PorugZhq0gdpYoO8mn6nezxWbaegm9SjYLPne6k4C3/sHTiGTO/YZDBRBdsNpslMmrkxVXjgsAibEkgdsSA/dQwZ059fM/2/TyCT5y0t8+UaDX6anaKQQ9hHOuNyKjWfMnD2n89Z3ub02OsbTP4I3sGxLGpxwL23epK2pL9B+l7b0Oz+Wi7D2/iit5SkAoSlHYSKZg93UcP7U+miHrB+DadeKbyUl2kSMwls7HYdcVJIwoUdH5yCAWGVd1dh0UGkSo2B4rg/VjqXaNrhVcMHvVAcTxERiAjYpcP0oOhWyNJXnee43TWP5iPk=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;6:z8tJ5y49weVZtQDEBjXXtyDbLWvNSlOpk+qYoRk51QFnnOmhkUlCU1o1y0i6G7riZxFQZiv5Bkl+VW5xkQ0LPcPUlF6yGhiZwKUQ3nRvHRwq2DEezvwv7pCz8booeGQJ9E+M0UnWnbwMy6QRWzsHUVbJ/ovmZ7X/tXITurH7Qu25vX6Y5kufyntgPCSQj2arohPppA2kffvIcjj/PcT/XWzV8dYI+ZBXu7vcQXXKkGaX8cLhf8WdoDsLF3Q6v8H+EKeh/mD+XoqusIAFQvz1EjWO/gA2GEnd5OaKrqM+M0iUAbD6Vz7p6YAwIIg7F4V9uAR+wYPOSS6+JKKFOuOp9gMC6Hz0Wc2isd0sEJJz0T9VsNM343i5MFDS6FWdGAaFSgW3MsJhhJOt9RbKAbRpRvxkXWbM1WwpiD7HwXewLI4UsMkhnO8sBNayr5xj5F7TE1as7Dt00dIcdhyHWxFTwg==;5:L3uqaZ+jHxY3Nf09y7WwMC2whQ/KaGTM0E/pk3/pIJKXmi24EedeEFoZEkJOO6pjLysSiVFMTsRlhToSNGkarH97PMYMk+QCEkzwwJ11XR5GXRnoTPcVYCYGtG3Deh15Cs1dpMMFJGzUNQZ0T2a+JJDzCbZOC96qyrBVEPkP8OM=;24:VMpuDB0jJ9Uh38DjjBk3UurNIZ+eBH3AbRk7BDzNjINGKQzJRp0ewPGOk6eY+KeTZRTyTS3SVbxXPwi/NX2qi0vC7GfSUg3t/U+EG8xBdd0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;7:ePpCKYm0BVL45ZQKhobmC9962zZ9NvUwLrrdDAMcM2zpQ6wYAcAQw3nZswm2JKc+p4olPfAxbnp7IvT8lXG56bEf1nHhCYQq66pv4OgneeQQPhS+UJ9b40EALUs3NM60ycQkcDnrEFAbB4Y0Vz5DPsHtAfX1DmexFJy4ydLgNB+CVvaPlPRI1mCqcy3BLeMYFGbdu6q8mlyazS5Bgwc0v7T4UTJWdk0AxT7a+UT0PS57wY5t+vUoCXzINnGXlQuP;20:VlAZjlxyNNvdH8Nyc7ib+/IZrGHen7QkOhuEhvpdOxPBMZ1o/lc65m0kStR+pkqRwGBpfJQTqaX44LaTEX9gVOAFJtwR7U/Zv+m4MmWTDxMkZuoxdF9CaoVrutXldWVm15PkLae2RvnppOr1fZTkPGveMsNb9BaP5rZj9RI6aCE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 08:46:31.2241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3c5d69-ad32-4813-97dc-08d5e7d3f76a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bytes have to be separated commas, and this is not obvious
for a person, who does not write in pure ".byte" assembler.
Let's clarify this and make visible for people.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 Documentation/admin-guide/bug-hunting.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bug-hunting.rst b/Documentation/admin-guide/bug-hunting.rst
index f278b289e260..861ee752eae9 100644
--- a/Documentation/admin-guide/bug-hunting.rst
+++ b/Documentation/admin-guide/bug-hunting.rst
@@ -213,7 +213,7 @@ If you don't have access to the code you can also debug on some crash dumps
             .text
             .globl foo
      foo:
-            .byte  .... /* bytes from Code: part of OOPS dump */
+            .byte  0x44,0x24,0x04,... /* bytes from Code: part of OOPS dump */
 
      Compile it with "gcc -c -o foo.o foo.s" then look at the output of
      "objdump --disassemble foo.o".

