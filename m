Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CA0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D56821476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BE/ZIpS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D56821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbeGLF4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:08 -0400
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:56218
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeGLF4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sQktYLVQc8ZPv+3DQw6VqRujFcGYr5oeHkZyc6WIpY=;
 b=BE/ZIpS9ZclY+Ba0C3V4CQRJUTJUlD7hDYBEtONdV1L2Chg+wgUyhC/GNtMpUnIuflwMkZtWxFZb6SmSwEwdexJHjXQ9IOm7DpNJaE5CnGO8UJ0roHXY6hJpx7LdlCWUFemNxJoXQ+0eCaYuV+xL+OKtWPcbJYnX45mY0At6ez8=
Received: from DM5PR07CA0036.namprd07.prod.outlook.com (2603:10b6:3:16::22) by
 DM2PR0701MB1341.namprd07.prod.outlook.com (2a01:111:e400:5119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 05:48:01 +0000
Received: from CO1NAM05FT056.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::202) by DM5PR07CA0036.outlook.office365.com
 (2603:10b6:3:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:01 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT056.mail.protection.outlook.com (10.152.96.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUS017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:07 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:06 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5loL8029780;
        Thu, 12 Jul 2018 06:47:50 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5loc9029779;
        Thu, 12 Jul 2018 06:47:50 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 19/31] usb: usbssp: added support for USB enumeration process.
Date:   Thu, 12 Jul 2018 06:47:16 +0100
Message-ID: <1531374448-26532-20-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(36092001)(189003)(199004)(42186006)(316002)(336012)(1671002)(16586007)(107886003)(6666003)(47776003)(109986005)(54906003)(26005)(186003)(87636003)(50466002)(36756003)(26826003)(478600001)(2906002)(48376002)(246002)(76176011)(51416003)(11346002)(486006)(2616005)(86362001)(426003)(126002)(8936002)(446003)(551934003)(5660300001)(476003)(105596002)(4720700003)(8676002)(4326008)(356003)(305945005)(14444005)(7636002)(575784001)(50226002)(106466001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1341;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT056;1:L07qWK9GCKzLJzJ7y0hfi+0r8c2hQnJo02Qb+nw8ruoN2pEHrNWvqLiKdv62KvkldDoJ5ZVwtVrFE3e1w6si450m34Rj+fBC3ooEwtzqLtH4TsU+HsbguD8+s3ucO54+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a3c0952-b79a-4b5e-3439-08d5e7bb071e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR0701MB1341;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1341;3:F2g+84M4h5TbKY7TZmvWSeugeQeKVwfU4cUPkYIePkNLcPa72KSXiLzmD2bD9UiAHHFpKRKGBYWoGaXaSjpyav3623ogdU8gdWmVxjS5hthL+M6+78/fadTB1cJC3MAgN5wXYo4CA9Mbp5J8uV96fm1nPFMionCKo7mNezgWO0504bYQ4ZIhvsgGaurkq5L5e3HFVAGvjFTv3emTAcSdc0vCkXtOWg7tyycEpAlydPZFwLdLCSOdxRJQsAT3R/L880bL0XH5Vr8bbv88w1UxQK5PAR5Izv/OfNuzC1TVcv8QOQSPQN0GXboWMPSnl+g1k0NyQ40GZlFrDRA4ncbeoUUBfoJgjXHr1FQCJVtQyo8=;25:4r15uWfmP2HpeCU33+s7w1Mr+2wBTbNZL+axAjlbGVTyjeYSWJXX0epqxnEWYvsyiM5GHgFxG+YUoWB3ZHU09IRG8qf136pml0SrzhpPQzw3Sol2gRo3VXzCuW1NbmVFEX1PbUu0jXiT02M3rrg5+SimKq7ffBEhVxQXMF+SUvN51lqC2bkyYo4BxemmVIaQWCmceYqLFp5BUycGACTfPxrnaY95BDmwsGixa04bJxlQcgON3Il3K5IAYsKVICckGw2EcLjC7bI7JyjWfDXbEjOm3wNAVOzgLwcLng2DW+8womF2O74hiGDg9b2GLYIRF/j0KtHpgT9Ghc7Yy0N3Yw==
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1341:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1341;31:3d0UAEH5qtZp9KaOMKtbM6BlYzDR31J5px8fdoWbcfJMrzYKZ9V/bPAp25ehTK4MBRWVj8KacZeD7oBnjCQSUa3OySJLFpK9nd1bKKksNPuIBw2lxay5kVbV9eYyjxdD3qpmMhFT+7q1lLCDIAGHGP3tcOHzV+Mpum2rrontHWLzBCC55X/7maWMYQQoyTEjLxkbwyvArfMxbh7lK09PDVdQVqV2HSwPvizCR9qaKyc=;20:Z3mhVhK8yQ+IpH9ajC/On1ivd0rvz66TwPX9RSX/CmRwZdlPvPf4YYT5/pYVNN6cx2zouttvFAMP+1MNmGEUD4Xf7AcwrwS536pq38HkfG8+FyNwqjWhqjy4pLZJbyHo3CWINkpC8va8G0EsW5QtJQ+pyZ5r7PkoijoL5x8Y3bZNULSMoJa+cBsYWPE/RHjPs8IiM7NzK1w5NmATBMVCZ5yYfTwRIpPw8mOexymXph7wTqdQQMDSITgC994x+od6ElwuhyypSv/IZPQ5XIAx6KxyC3TSqL231fUJpqUKp04cG3KogA8nab96d1Eb1NMqfk/c954TD63zy46sVB9zqAQ8B4QCdWdoOdCmxRl0YSW3pR6/J3VLFTJyuyrSPx7nV/AZTJpfQZ0t0f0XlNGe78xYFUAXyOOMLwwS0dTQhtpJ9FOxtREaMzv7ZY3NVEPm+W9p0EGuyXOz06QMNelPxGFU+4RnRO8JG/qBlwZwpEp6y5WS58ltJqF+kAfMhRQQ
X-Microsoft-Antispam-PRVS: <DM2PR0701MB13419AB0F1273020BEC31B2FDD590@DM2PR0701MB1341.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM2PR0701MB1341;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1341;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1341;4:BAnn33Qs+E1QOmNdAEECs8OPTFiy9ZTtlNZGUe9ZEU9/fRV3lsVVDtfSma3V766C1yMckWRsbmEQZT30ab6vsjglRVkMX0/Ta5qmCQiPg4cWQH66FlZt11w1bkxm9lGHnhTu3NQuadcgVyw5sd/DYp1OJNj5sL6ni5TVEvXDkKeVa25Z0qk3I6sQ9Fvx3hvaZ68T2Jn4X38JdXTJDTyHAwO5WQAk3Xad7R6ithtpMy2cOxnz4jDiYV/KSWb527ILw1lZR4G3YAzFr1eys+XPzDdRwjpqxIY5oGhgmeE5wz+u9PpXgEm0SXCGKcBX2WMu
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1341;23:Hx7ZRyYxnqNenJ1SdOGGXBqmM9mUvKpTHX8TOyq?=
 =?us-ascii?Q?JvrLYvYB86oPm/H+tBtgLoIYq/zLeQOVbllyMY5FvRN2hWNisddm9pkf1CiS?=
 =?us-ascii?Q?yo1LiBem70tR1UJV9BtMQtBowzNf/UIuwCTtfzgXusyVTnj7OF8kDhIOTZCu?=
 =?us-ascii?Q?kvtY+4UGMXkjupmoooqLBjAokhEkCwJmsLSoOaiW3g1F/5UZJYDosS5cgDIc?=
 =?us-ascii?Q?p/U6h92RJpCgVQ4CFMkdKMtJXfaM/0SwcMVkVeuym+Yfjv08gLf2k/lWf76K?=
 =?us-ascii?Q?rUWEkj170eKuFP27paQUhTtB4Qsx+kYgJypVCaetdfCY2Skk3QSfQt4VZraA?=
 =?us-ascii?Q?u5yhGsdCy+Lf+1UukIhVZg5yIOyhdN0vNDzufg2MXwQhH7YTyWWqnJF/wLKp?=
 =?us-ascii?Q?pHWF+3b6lGX/hDqp2kDP+qmY0gr+xutyheHlV9upUuU2Mvn0LgX+Fk4NDQV9?=
 =?us-ascii?Q?yMBJ+tTc3I6RRJ2niEAZdJOVh9+2bJeYE1eqz7Vo0rSCLMeFoYpmONbTCHco?=
 =?us-ascii?Q?QzEMNgI8jsdp3DU/6FMqXhTNUGXFJiACAykJsHXPQvBv4XTGdbX+FRJbCC/8?=
 =?us-ascii?Q?U3OxeUaAaLbvdaqgdUJifSdLmAlWAqomwysTWlv2YpecSL2poCA1jCU69lnK?=
 =?us-ascii?Q?/jWMbCEe+f7xEgi+140iDhrboYQtSEADlfaqLnFf2XnBxm0RfzYGMzJFynp/?=
 =?us-ascii?Q?037H8Y23i3g2ihA5+Ryk6ID2Oj7er77lpQp5yeIfiAQWqMo1LM8HoY91+Mur?=
 =?us-ascii?Q?2ouqVYqqJBVzwzq1CXKbfzv2bLkZGAasxCO9heKinyd4iiyA1mRmC6Z4dMub?=
 =?us-ascii?Q?h4c7IoaIqsSyVKfWTXmL/QMX9QvintR4AMl3PRJSxMeccS9f/oOq1e1RpdJa?=
 =?us-ascii?Q?ewL037XsJZfP3FyCMSKlaJEODNnO9RRMYG5qr+vuC/cp78mfbFUgVot+bE5C?=
 =?us-ascii?Q?DPFiipCSlCYbfV6MIFWlfZNciaFr6ejqqDwQI6CdGdDTR04oCC/u9b+GZnX+?=
 =?us-ascii?Q?DkY9NqnbHxjlz0y0i3WD/3JXNQw47viHuclXEmR32KjQ79dpLhkXxbMOPgJ5?=
 =?us-ascii?Q?zmKJ2zH5/8TMnwE1IiyxkkAVproIf1Ukf6OE3/sJFlda64m79hH2FN/biWxl?=
 =?us-ascii?Q?CDzqcMuj3QJ+KIl/AcMLMxIb4eDRWmq5g8Itvf9WI8Y2KhANL0z5lTziH9A5?=
 =?us-ascii?Q?Dsc8InopPQi2TeeUudnDo3FCnWqyz8o2KCooo?=
X-Microsoft-Antispam-Message-Info: qfKA3vuNRrTK90QrUdjAHwFJ5NVoPlyXhk8XaHfQt45eh67eWy0VI+V92s/xAIX+DyeTeFCm7o91lZND7j6+fu7nzDMrqiNmn2kdbWQKgVwvx7516GdyhBvx+VkeKZ4WSI+Z9qGt2W3Q+7XY19eyE/2FmQJ6/ZenAg94veRRwxGg9l4KNDd0liCMPwGuNrCQGHht2CkFQXgtbFaaA+Vsfh4p2H9wdPN3FgRiuDkb+aiuDCMG3Y87SNF6xbrgciH3mk26Dwzp8qVZL88acI08A+iwIchOag1FpgdMJxmNPrTmQBk97rJuPs3PhQxeLNZSvlv5jeQAKiIzlFNQNGSQ8FO6WWzrE0QnyAIbxuJA/ddpop8ipan0ukb2C5BO6qmEoDpJEfDb8tGnVO3S7K9ZHw==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1341;6:TzlI3gwDd3YiuQ8yfxmFwebJJIFaVp/ONP1Ol1mVjDTox8Xka/bDLwvMJN6tWTH09Z0IAEZmOWnupLAU1V5K1g/2Gjxdb77AAFyUkVmOyg30yDFYyfc3Qim+XmB5HHJibAJsNhLUONUexpceXkKa2GZ3t3sGV7aT20I2epciSrUjvjVYaHbA9IyUyLMcw+yYIv/LdOSy6EtLyR7HcHEz64pqr6GeeRdxzUEaQ9jSAHZfY5qeKYpnoH/HZgURMf+ejAi2LlOFP0BqD972Rb2e3jh1gc9g9zptD/4QjiVTejSQdMJuejj1bkwPJfRn5nt03TtuC33UPeS2MO+RgV//eAm8fP8gpz52eBH1IE9a0cHyBvqs7/ZoHGp2dg4SjoQ63Od8DwVKWujvZ4Wt4K56ax4w07rPMCvv7LielKZ0zBh+sSAFL3fSzcOuMCm8Os4NHH6Ev5JyrEb7EUvCIGo37Q==;5:O9jQYolCUpl0Fc923xPg0Il8VdoQmt9UlOmsq2IUn7s6Ak+UqNWkQEjc+B4Cq2gd2TJnZqVUT3NptRoGssY4DX9VmMCpO+nnK8EZEf9u4uomaOepgK6u6iaMdt8yNV3vri4bKCbsFm/V7DuwIH9EDJYHS/N29T7mD0Pwj0B/dv4=;24:9mYU+ibiBt2IPbmPh2zmPhfPJDiDByP/EBF1mn2MQuwQdFXnCzaZR3D+p3acYRuQ0UgqrLpw/LQrEwaH+Ps1wDIPpnfHm01z8pY+r75G3xw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1341;7:KzTfPbX7o0norqy4LtM8plIL+SjBeoZ5K12Mp/TChuBVtlpZxnHf/wRXLk7ujOJx/tgbLmp+LZEkAhbfEZtJ7A+AIWqrtHLbPJQuT7K2xU5lXSBXAJQZLMscF+1aKrubNAZyqiMfk/biK2eHECJl+doH7yaNjBRS9Iw2piuW3OYfo7JkC1EiZqKzB0fiXrTTLA2nW0cPUuSEK1+9/FArruvKR5590A/26sUQGoihSuaBVLJWggXPiQU2AHjvl8Yh;20:wAhoLKe4+blx5UNmymonwRAmeDbF8lhG0KtahfDFiqok6SSBPoU0f/MpR47Vqq/7b036zcGCYFPmj9eZtz/yxdJSqhu8EfJxLxLLaswD4QILyfzZ1REpUv+/TZKsjFcDs1AlKmrHq0v0I8xdu2JEjA/Xc5WeqAoj/mUHOdlYM+jSyrjsC122bOk7l/Gn+KyYGeycukW9/dX7w2cd6Khtz/HLYvrULdwmPyJyqhi2VL+Gxa+PZt1fveQmjGcu8Xlb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:00.5238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3c0952-b79a-4b5e-3439-08d5e7bb071e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1341
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements a set of functions used during
USB device enumeration process. Added code analyzes
received SETUP packet and decides whether packet should
be handled by usbssp driver or should be delegated
to gadget core driver.

This patch also introduces usbssp_ep0_stall function that
sends STALL to host when received SETUP packet can't be
handled.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ep0.c  | 507 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget-if.c   |  32 ++
 drivers/usb/usbssp/gadget-ring.c |  18 ++
 drivers/usb/usbssp/gadget.c      |  43 ++-
 drivers/usb/usbssp/gadget.h      |   9 +
 5 files changed, 607 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ep0.c b/drivers/usb/usbssp/gadget-ep0.c
index c889a3102740..6ded0c1b0e70 100644
--- a/drivers/usb/usbssp/gadget-ep0.c
+++ b/drivers/usb/usbssp/gadget-ep0.c
@@ -15,9 +15,514 @@
 #include <linux/usb/composite.h>
 #include "gadget-trace.h"
 
+static void usbssp_ep0_stall(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_ep *dep;
+	int ret = 0;
+
+	dep = &usbssp_data->devs.eps[0];
+	if (usbssp_data->three_stage_setup) {
+		usbssp_dbg(usbssp_data, "Send STALL on Data Stage\n");
+		ret =  usbssp_halt_endpoint(usbssp_data, dep, true);
+
+		/*
+		 * Finishing SETUP transfer by removing request
+		 * from pending list
+		 */
+		if (!list_empty(&dep->pending_list)) {
+			struct usbssp_request	*req;
+
+			req = next_request(&dep->pending_list);
+			usbssp_giveback_request_in_irq(usbssp_data,
+					req->td, -ECONNRESET);
+			dep->ep_state = USBSSP_EP_ENABLED;
+		}
+	} else {
+		usbssp_dbg(usbssp_data, "Send STALL on Status Stage\n");
+		dep->ep_state |= EP0_HALTED_STATUS;
+		usbssp_status_stage(usbssp_data);
+	}
+	usbssp_data->delayed_status = false;
+}
+
+static int usbssp_ep0_delegate_req(struct usbssp_udc *usbssp_data,
+				   struct usb_ctrlrequest *ctrl)
+{
+	int ret;
+
+	usbssp_dbg(usbssp_data, "Delagate request to gadget driver\n");
+	spin_unlock(&usbssp_data->irq_thread_lock);
+
+	ret = usbssp_data->gadget_driver->setup(&usbssp_data->gadget, ctrl);
+	spin_lock(&usbssp_data->irq_thread_lock);
+
+	return ret;
+}
+
+static int usbssp_ep0_set_config(struct usbssp_udc *usbssp_data,
+				 struct usb_ctrlrequest *ctrl)
+{
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u32 cfg;
+	int ret;
+
+	cfg = le16_to_cpu(ctrl->wValue);
+	switch (state) {
+	case USB_STATE_DEFAULT:
+		usbssp_err(usbssp_data,
+			"Error: Set Config request from Default state\n");
+		return -EINVAL;
+	case USB_STATE_ADDRESS:
+		usbssp_dbg(usbssp_data,
+			"Set Configuration from addressed state\n");
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		/* if the cfg matches and the cfg is non zero */
+		if (cfg && (!ret || (ret == USB_GADGET_DELAYED_STATUS))) {
+			/*
+			 * only change state if set_config has already
+			 * been processed. If gadget driver returns
+			 * USB_GADGET_DELAYED_STATUS, we will wait
+			 * to change the state on the next usbssp_enqueue()
+			 */
+			if (ret == 0) {
+				usbssp_info(usbssp_data,
+					"Device has been configured\n");
+				usb_gadget_set_state(&usbssp_data->gadget,
+					USB_STATE_CONFIGURED);
+			}
+		}
+		break;
+	case USB_STATE_CONFIGURED:
+		usbssp_dbg(usbssp_data,
+			"Set Configuration from Configured state\n");
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		if (!cfg && !ret) {
+			usbssp_info(usbssp_data, "reconfigured device\n");
+			usb_gadget_set_state(&usbssp_data->gadget,
+					USB_STATE_ADDRESS);
+		}
+		break;
+	default:
+		usbssp_err(usbssp_data,
+			   "Set Configuration - incorrect device state\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int usbssp_ep0_set_address(struct usbssp_udc *usbssp_data,
+				  struct usb_ctrlrequest *ctrl)
+{
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u32 addr;
+	unsigned int slot_state;
+	struct usbssp_slot_ctx *slot_ctx;
+	int dev_state = 0;
+
+	addr = le16_to_cpu(ctrl->wValue);
+	if (addr > 127) {
+		usbssp_err(usbssp_data, "invalid device address %d\n", addr);
+		return -EINVAL;
+	}
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (state == USB_STATE_CONFIGURED) {
+		usbssp_err(usbssp_data,
+				"can't SetAddress() from Configured State\n");
+		return -EINVAL;
+	}
+
+	usbssp_data->device_address = le16_to_cpu(ctrl->wValue);
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (slot_state == SLOT_STATE_ADDRESSED) {
+		/*Reset Device Command*/
+		usbssp_data->defered_event &= ~EVENT_USB_RESET;
+		queue_work(usbssp_data->bottom_irq_wq,
+			&usbssp_data->bottom_irq);
+		usbssp_reset_device(usbssp_data);
+	}
+	/*set device address*/
+	usbssp_address_device(usbssp_data);
+
+	if (addr)
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_ADDRESS);
+	else
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_DEFAULT);
+	return 0;
+}
+
 int usbssp_status_stage(struct usbssp_udc *usbssp_data)
 {
-	/*TODO; function must to be implemented*/
+	struct usbssp_ring *ep_ring;
+	int ret;
+	struct usbssp_ep *dep;
+
+	dep = &usbssp_data->devs.eps[0];
+	ep_ring = usbssp_data->devs.eps[0].ring;
+
+	usbssp_dbg(usbssp_data, "Enqueue Status Stage\n");
+	usbssp_data->ep0state = USBSSP_EP0_STATUS_PHASE;
+	usbssp_data->usb_req_ep0_in.request.length = 0;
+	ret = usbssp_enqueue(usbssp_data->usb_req_ep0_in.dep,
+			&usbssp_data->usb_req_ep0_in);
+	return ret;
+}
+
+
+static int usbssp_ep0_handle_feature_u1(struct usbssp_udc *usbssp_data,
+					enum usb_device_state state, int set)
+{
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (state != USB_STATE_CONFIGURED)
+		usbssp_err(usbssp_data,
+			"Error: can't change U1 - incorrect device state\n");
+		return -EINVAL;
+
+	if ((usbssp_data->gadget.speed  != USB_SPEED_SUPER) &&
+	    (usbssp_data->gadget.speed  != USB_SPEED_SUPER_PLUS))
+		usbssp_err(usbssp_data,
+			"Error: U1 is supported only for SS and SSP\n");
+		return -EINVAL;
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+	temp = readl(port_regs+PORTPMSC);
+	temp &= ~PORT_U1_TIMEOUT_MASK;
+
+	if (set)
+		temp |= PORT_U1_TIMEOUT(1);
+	else
+		temp |= PORT_U1_TIMEOUT(0);
+
+	usbssp_info(usbssp_data, "U1 %s\n", set ? "enabled" : "disabled");
+	writel(temp, port_regs+PORTPMSC);
+
+	usbssp_status_stage(usbssp_data);
 	return 0;
 }
 
+static int usbssp_ep0_handle_feature_u2(struct usbssp_udc *usbssp_data,
+					enum usb_device_state state, int set)
+{
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (state != USB_STATE_CONFIGURED) {
+		usbssp_err(usbssp_data,
+			   "Error: can't change U2 - incorrect device state\n");
+		return -EINVAL;
+	}
+	if ((usbssp_data->gadget.speed  != USB_SPEED_SUPER) &&
+	    (usbssp_data->gadget.speed  != USB_SPEED_SUPER_PLUS)) {
+		usbssp_err(usbssp_data,
+			   "Error: U2 is supported only for SS and SSP\n");
+		return -EINVAL;
+	}
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(port_regs+PORTPMSC);
+	temp &= ~PORT_U1_TIMEOUT_MASK;
+
+	if (set)
+		temp |= PORT_U2_TIMEOUT(1);
+	else
+		temp |= PORT_U2_TIMEOUT(0);
+
+	writel(temp, port_regs+PORTPMSC);
+	usbssp_info(usbssp_data, "U2 %s\n", set ? "enabled" : "disabled");
+
+	usbssp_status_stage(usbssp_data);
+	return 0;
+}
+
+static int usbssp_ep0_handle_feature_device(struct usbssp_udc *usbssp_data,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	enum usb_device_state state;
+	u32 wValue;
+	u32 wIndex;
+	int ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	state = usbssp_data->gadget.state;
+
+	switch (wValue) {
+	case USB_DEVICE_REMOTE_WAKEUP:
+		usbssp_data->remote_wakeup_allowed = (set) ? 1 : 0;
+		break;
+	/*
+	 * 9.4.1 says only only for SS, in AddressState only for
+	 * default control pipe
+	 */
+	case USB_DEVICE_U1_ENABLE:
+		ret = usbssp_ep0_handle_feature_u1(usbssp_data, state, set);
+		break;
+	case USB_DEVICE_U2_ENABLE:
+		ret = usbssp_ep0_handle_feature_u2(usbssp_data, state, set);
+		break;
+	case USB_DEVICE_LTM_ENABLE:
+		ret = -EINVAL;
+		break;
+	default:
+		usbssp_err(usbssp_data, "%s Feature Request not supported\n",
+				(set) ? "Set" : "Clear");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_handle_feature_intf(struct usbssp_udc *usbssp_data,
+					  struct usb_ctrlrequest *ctrl,
+					  int set)
+{
+	u32 wValue;
+	int ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+
+	switch (wValue) {
+	case USB_INTRF_FUNC_SUSPEND:
+		/*TODO: suspend device */
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_handle_feature_endpoint(struct usbssp_udc *usbssp_data,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	struct usbssp_ep *dep;
+	u32 wValue, wIndex;
+	unsigned int ep_index = 0;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_td *td;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	ep_index = ((wIndex & USB_ENDPOINT_NUMBER_MASK) << 1);
+
+	if ((wIndex & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT)
+		ep_index -= 1;
+
+	dep =  &usbssp_data->devs.eps[ep_index];
+	ep_ring = dep->ring;
+
+	switch (wValue) {
+	case USB_ENDPOINT_HALT:
+		if (set == 0 && (dep->ep_state & USBSSP_EP_WEDGE))
+			break;
+
+		usbssp_halt_endpoint(usbssp_data, dep,  set);
+
+		td = list_first_entry(&ep_ring->td_list, struct usbssp_td,
+				td_list);
+
+		usbssp_cleanup_halted_endpoint(usbssp_data, ep_index,
+				ep_ring->stream_id, td,
+				EP_HARD_RESET);
+		break;
+	default:
+		usbssp_warn(usbssp_data, "WARN Incorrect wValue %04x\n",
+				wValue);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int usbssp_ep0_handle_feature(struct usbssp_udc *usbssp_data,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	u32 recip;
+	int ret;
+
+	recip = ctrl->bRequestType & USB_RECIP_MASK;
+
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		ret = usbssp_ep0_handle_feature_device(usbssp_data, ctrl, set);
+		break;
+	case USB_RECIP_INTERFACE:
+		ret = usbssp_ep0_handle_feature_intf(usbssp_data, ctrl, set);
+		break;
+	case USB_RECIP_ENDPOINT:
+		ret = usbssp_ep0_handle_feature_endpoint(usbssp_data,
+				ctrl, set);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_set_sel(struct usbssp_udc *usbssp_data,
+			      struct usb_ctrlrequest *ctrl)
+{
+	struct usbssp_ep *dep;
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u16 wLength;
+	int ret = 0;
+
+	if (state == USB_STATE_DEFAULT)
+		return -EINVAL;
+
+	wLength = le16_to_cpu(ctrl->wLength);
+
+	if (wLength != 6) {
+		usbssp_err(usbssp_data, "Set SEL should be 6 bytes, got %d\n",
+				wLength);
+		return -EINVAL;
+	}
+
+	/*
+	 * To handle Set SEL we need to receive 6 bytes from Host. So let's
+	 * queue a usb_request for 6 bytes.
+	 */
+	dep = &usbssp_data->devs.eps[0];
+
+	usbssp_data->usb_req_ep0_in.request.length = 0x6;
+	usbssp_data->usb_req_ep0_in.request.buf = usbssp_data->setup_buf;
+
+	ret = usbssp_enqueue(usbssp_data->usb_req_ep0_in.dep,
+			&usbssp_data->usb_req_ep0_in);
+	if (ret) {
+		usbssp_err(usbssp_data, "Error in  Set Sel\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int usbssp_ep0_std_request(struct usbssp_udc *usbssp_data,
+				  struct usb_ctrlrequest *ctrl)
+{
+	int ret = 0;
+
+	usbssp_data->bos_event_detected = 0;
+
+	switch (ctrl->bRequest) {
+	case USB_REQ_GET_STATUS:
+		usbssp_info(usbssp_data, "Request GET_STATUS\n");
+		/*TODO:*/
+		//ret = usbssp_ep0_handle_status(usbssp_data, ctrl);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+		usbssp_info(usbssp_data, "Request CLEAR_FEATURE\n");
+		ret = usbssp_ep0_handle_feature(usbssp_data, ctrl, 0);
+		break;
+	case USB_REQ_SET_FEATURE:
+		usbssp_info(usbssp_data, "Request SET_FEATURE\n");
+		ret = usbssp_ep0_handle_feature(usbssp_data, ctrl, 1);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		usbssp_info(usbssp_data, "Request SET_ADDRESS\n");
+		ret = usbssp_ep0_set_address(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		usbssp_info(usbssp_data, "Request SET_CONFIGURATION\n");
+		ret = usbssp_ep0_set_config(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_SEL:
+		usbssp_info(usbssp_data, "Request SET_SEL\n");
+		ret = usbssp_ep0_set_sel(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		usbssp_info(usbssp_data, "Request SET_ISOCH_DELAY\n");
+		/*TODO:*/
+		//ret = usbssp_ep0_set_isoch_delay(usbssp_data, ctrl);
+		break;
+	default:
+		if ((le16_to_cpu(ctrl->wValue) >> 8) == USB_DT_BOS &&
+		    ctrl->bRequest == USB_REQ_GET_DESCRIPTOR) {
+			/*
+			 * It will be handled after Status Stage phase
+			 * in usbssp_gadget_giveback
+			 */
+			usbssp_data->bos_event_detected = true;
+		}
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		break;
+	}
+	return ret;
+}
+
+int usbssp_setup_analyze(struct usbssp_udc *usbssp_data)
+{
+	int ret = -EINVAL;
+	struct usb_ctrlrequest *ctrl = &usbssp_data->setup;
+	u32 len = 0;
+	struct usbssp_device *priv_dev;
+
+	ctrl = &usbssp_data->setup;
+
+	usbssp_info(usbssp_data,
+			"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
+			ctrl->bRequestType, ctrl->bRequest,
+			le16_to_cpu(ctrl->wValue), le16_to_cpu(ctrl->wIndex),
+			le16_to_cpu(ctrl->wLength));
+
+	if (!usbssp_data->gadget_driver)
+		goto out;
+
+	priv_dev = &usbssp_data->devs;
+
+	/*
+	 * First of all, if endpoint 0 was halted driver has to
+	 * recovery it.
+	 */
+	if (priv_dev->eps[0].ep_state & EP_HALTED) {
+		usbssp_dbg(usbssp_data,
+			"Ep0 Halted - restoring to nomral state\n");
+		usbssp_halt_endpoint(usbssp_data, &priv_dev->eps[0], 0);
+	}
+
+	/*
+	 * Finishing previous SETUP transfer by removing request from
+	 * list and informing upper layer
+	 */
+	if (!list_empty(&priv_dev->eps[0].pending_list)) {
+		struct usbssp_request	*req;
+
+		usbssp_dbg(usbssp_data,
+				"Deleting previous Setup transaction\n");
+		req = next_request(&priv_dev->eps[0].pending_list);
+		usbssp_dequeue(&priv_dev->eps[0], req);
+	}
+
+	len = le16_to_cpu(ctrl->wLength);
+	if (!len) {
+		usbssp_data->three_stage_setup = false;
+		usbssp_data->ep0_expect_in = false;
+	} else {
+		usbssp_data->three_stage_setup = true;
+		usbssp_data->ep0_expect_in =
+				!!(ctrl->bRequestType & USB_DIR_IN);
+	}
+
+	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
+		ret = usbssp_ep0_std_request(usbssp_data, ctrl);
+	else
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+
+	if (ret == USB_GADGET_DELAYED_STATUS) {
+		usbssp_dbg(usbssp_data, "Status Stage delayed\n");
+		usbssp_data->delayed_status = true;
+	}
+
+out:
+	if (ret < 0)
+		usbssp_ep0_stall(usbssp_data);
+
+	return ret;
+}
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 9c236fc1149f..411c3971082f 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -133,6 +133,38 @@ static const struct usb_ep_ops usbssp_gadget_ep_ops = {
 	.set_wedge	= usbssp_gadget_ep_set_wedge,
 };
 
+void usbssp_gadget_giveback(struct usbssp_ep *ep_priv,
+			    struct usbssp_request *req_priv, int status)
+{
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+
+	list_del(&req_priv->list);
+
+	if (req_priv->request.status == -EINPROGRESS)
+		req_priv->request.status = status;
+
+	usb_gadget_unmap_request_by_dev(usbssp_data->dev,
+			&req_priv->request, req_priv->direction);
+
+	trace_usbssp_request_giveback(&req_priv->request);
+
+	if (in_interrupt())
+		spin_unlock(&usbssp_data->lock);
+	else
+		spin_unlock(&usbssp_data->irq_thread_lock);
+
+	if (req_priv != &usbssp_data->usb_req_ep0_in) {
+		usb_gadget_giveback_request(&ep_priv->endpoint,
+				&req_priv->request);
+	}
+
+	if (in_interrupt())
+		spin_lock(&usbssp_data->lock);
+	else
+		spin_lock(&usbssp_data->irq_thread_lock);
+
+}
+
 static struct usb_endpoint_descriptor usbssp_gadget_ep0_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 983705f6cda9..84bd462a1f23 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -306,6 +306,24 @@ static void ring_doorbell_for_active_rings(struct usbssp_udc *usbssp_data,
 	}
 }
 
+/* Must be called with usbssp_data->lock held in interrupt context
+ * or usbssp_data->irq_thread_lock from thread conext (defered interrupt)
+ */
+void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
+				    struct usbssp_td *cur_td,
+				    int status)
+{
+	struct usb_request	*req;
+	struct usbssp_request	*req_priv;
+
+	req_priv = cur_td->priv_request;
+	req = &req_priv->request;
+
+	usbssp_request_free_priv(req_priv);
+
+	usbssp_gadget_giveback(req_priv->dep, req_priv, status);
+}
+
 /*
  * When we get a command completion for a Stop Endpoint Command, we need to
  * stop timer and clear EP_STOP_CMD_PENDING flag.
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index f198d7e308c6..f14b357a1094 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -97,7 +97,9 @@ void usbssp_bottom_irq(struct work_struct *work)
 
 	/*handle setup packet*/
 	if (usbssp_data->defered_event & EVENT_SETUP_PACKET) {
-		/*TODO: implement handling of SETUP packet*/
+		usbssp_dbg(usbssp_data, "Beginning handling SETUP packet\n");
+		usbssp_data->defered_event &= ~EVENT_SETUP_PACKET;
+		usbssp_setup_analyze(usbssp_data);
 	}
 
 	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
@@ -405,6 +407,45 @@ static int usbssp_check_args(struct usbssp_udc *usbssp_data,
 	return 1;
 }
 
+int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
+/*
+ * Remove the request's TD from the endpoint ring. This may cause the DC to stop
+ * USB transfers, potentially stopping in the middle of a TRB buffer. The DC
+ * should pick up where it left off in the TD, unless a Set Transfer Ring
+ * Dequeue Pointer is issued.
+ *
+ * The TRBs that make up the buffers for the canceled request will be "removed"
+ * from the ring. Since the ring is a contiguous structure, they can't be
+ * physically removed. Instead, there are two options:
+ *
+ *  1) If the DC is in the middle of processing the request to be canceled, we
+ *     simply move the ring's dequeue pointer past those TRBs using the Set
+ *    Transfer Ring Dequeue Pointer command. This will be the common case,
+ *     when drivers timeout on the last submitted request and attempt to cancel.
+ *
+ *  2) If the DC is in the middle of a different TD, we turn the TRBs into a
+ *     series of 1-TRB transfer no-op TDs. (No-ops shouldn't be chained.) The
+ *     DC will need to invalidate the any TRBs it has cached after the stop
+ *     endpoint command.
+ *
+ *  3) The TD may have completed by the time the Stop Endpoint Command
+ *     completes, so software needs to handle that case too.
+ *
+ * This function should protect against the TD enqueueing code ringing the
+ * doorbell while this code is waiting for a Stop Endpoint command to complete.
+ *
+ */
+int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 			 int value)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 5f653f3caabd..1f0d1af33dfa 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1696,6 +1696,7 @@ struct usbssp_ring *usbssp_stream_id_to_ring(
 
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 		bool allocate_completion, gfp_t mem_flags);
+void usbssp_request_free_priv(struct usbssp_request *req_priv);
 void usbssp_free_command(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *command);
 
@@ -1779,6 +1780,10 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int  usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
 void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
+void usbssp_gadget_giveback(struct usbssp_ep *ep_priv,
+		struct usbssp_request *req_priv, int status);
+int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv);
+int usbssp_dequeue(struct usbssp_ep *dep, struct usbssp_request *req_priv);
 unsigned int usbssp_port_speed(unsigned int port_status);
 void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data);
 void usbssp_gadget_disconnect_interrupt(struct usbssp_udc *usbssp_data);
@@ -1787,6 +1792,7 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
 		struct usbssp_ep *dep, int value);
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
+int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 int usbssp_reset_device(struct usbssp_udc *usbssp_data);
@@ -2257,4 +2263,7 @@ struct usbssp_udc;
 
 __le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data);
 
+void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
+		struct usbssp_td *cur_td, int status);
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

