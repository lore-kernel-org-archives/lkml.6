Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0742ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DE62075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e4q/05Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DE62075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGRLyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:54:08 -0400
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:11350
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbeGRLyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L11PJ/uPzvQ89vo5uTBV8QVI+ciCk/h9Nu/87b2wee8=;
 b=e4q/05Vez5IsuLjhpRZqgeCDsxNcxLVLoitl7t1sS61gOWB0TPDVNci9Hq5A8wHMXTM4w8Bn/cT9kiXqDyKH4nXRpwrClI7OUsZl7JkyVJC4P4FMG/JdssTqVcRAhhHklFre7rLkQUn63Tm9ear5TtL+4Mjrw0Zl+h9EiCYKqAI=
Received: from CY4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:903:18::15)
 by BLUPR02MB1619.namprd02.prod.outlook.com (2a01:111:e400:525e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Wed, 18 Jul
 2018 11:12:47 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by CY4PR02CA0005.outlook.office365.com
 (2603:10b6:903:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 11:12:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Wed, 18 Jul 2018 11:12:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNy-0007ol-B6; Wed, 18 Jul 2018 04:12:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNs-000325-Ol; Wed, 18 Jul 2018 04:12:40 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6IBCUde000897;
        Wed, 18 Jul 2018 04:12:30 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1ffkNh-000315-UL; Wed, 18 Jul 2018 04:12:30 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1E9011213D6; Wed, 18 Jul 2018 16:42:29 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 0/4] iio: adc: xilinx: XADC driver enhancements and bug fixes
Date:   Wed, 18 Jul 2018 16:42:07 +0530
Message-ID: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(438002)(199004)(189003)(47776003)(4326008)(63266004)(106002)(126002)(2616005)(107886003)(44832011)(486006)(50466002)(72206003)(478600001)(90966002)(6266002)(48376002)(476003)(52956003)(6666003)(2201001)(103686004)(5660300001)(50226002)(16586007)(54906003)(81156014)(81166006)(110136005)(8676002)(2906002)(336012)(42186006)(36386004)(356003)(8936002)(316002)(36756003)(426003)(305945005)(51416003)(106466001)(26005)(186003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1619;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:RA/+W5I0nnWI7NJ3Yrnb6Ddxez63EYK/3JasdRaftET8CJQa7zAh4Hj2ii9XyS1g69WQe56E41PoRJWD+bSwsmr6iavIFq3kkBbp2iAqnQMFGeBxA1cGgR9Y+Njo+n2x
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 050d27c2-aa37-43c0-162f-08d5ec9f6478
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR02MB1619;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;3:2Vqv9HIXZaoK9OqwULDHMIbWL8o1z4EsH8f1C2+1hyUMx6iLSumOXG1vvi7pKw3FnDSqORRzfK7hvc9btVPYq4fKiXbWIziJCE5zz2ekpygtY5LwIqRUnTjp3+6+kT4nT13ZqDtmLEN+EzLW8QoM78SA5llAriGppJSmGYCfzm0LErxIivDTNqn1amU8Q5wUq30RkvXGqjGUEnRYLbEaTX5EOcM3I4NjnwjOlKnOBD5FU9s4kjoTmGayjjoCjpgpjKR3nfa5Jpn0a4m0p/AMtzA+xiUmYikCg5M9UD+ZbNVE3zyXjr7wcQ8eT+h1rHkQ1CEIjVkQITNN7AxqKoJWeo00dm7HHuzpVmuc2Zea01w=;25:IweFJBQi5Yem0Y5V5+InT+/HIYO0DtwhfFPk/BSzsgRsb7hLPG4umHiDIqgBmbD5iuMx59qP7Xze3pr+cmNTXwBbBXrJF+O2d3ecC3qKoZRDSG4eJn0D2qtKLgwjARG0oh0sAmTxZNgGaVMjcGOJT9/3gonPsxVKp/9nKhWLoC/eemaKxIWvHpk9RVZtB3hH5YEMsRdBhx8LPXrKVXBITQ/K8kdyzPsKEKV4iNyDjeNP/HJa+agGw25pmC1T3+8guNW4pQ94xep8SYTtDQaGt2tp4f1zjoeaSAUZfAs351+M1AfFbEUdh+xVNbnYpdu+cI4OKPV8+WpRsgZnmbsLnA==
X-MS-TrafficTypeDiagnostic: BLUPR02MB1619:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;31:RVyQ1UMvSFK6hg7gzFfDD4DvDFAl8tTpE2jUTtVRXCPEITzeAG4nzPAXr63YQbacgjMe2zHDG5Nm2/kZB/6ecvghTmPOgyQGnAkgYFvMVqCDfv5o9EawJbWQJ0Bev23vdwP4MeogW74bab4huPP/x2WI6xT5q2VgbW648uqMkbMOvSkyE8SZknzpzk18aMwCHZ6m+m5L5219yURplNvyL4oT2zfrkpQjnczHEuzD6Ro=;20:UTVIvA2BI+xKLvZH9YPZVmf/mEjS5HvHUgQy9L71H/ITwVgItSfOfS82oGUYH6vz37nD0CHz58g5HFUaw9rx1vNiE0cW3WqukvKFUXmZGHd/ZiIrNKWIjAfIrRF2/9jF6RxL3Fy1bNXbDuBs4eE8RAbDPPZVKf7DBGdTI65gnKCqHNVDyqalzi4J7Es5dpKrPVFzQLV2yJ6vPFOYUGx/rXOJ5DXZDVc98KJtwKe3jQLQRNqQfM0woGhX/mhl1YBg9osBXQ+ybsP2oyPFTqrgOc5884O9StpeuoDPKW1wHsORPCAtPsckvQdRS9XsYaOfqXFFIVk+E4yGyrgFW8glnCRTl+XfNB1RNYL8d/qtMenDekK1sd8xr1E22OyPdzUbcEDNa18oVFhTWRKGLOZ2G5CGad3WDcatxm6WfBqb9dZd49im3uHaZIvkg4bchWUkXxPME3zPvtwkW0ZJoK/fN3wn3sWujbPOkU8OFYhyBPtRP0ZswEiczJuteCn6gcUd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB16195A7603ED9EE260021137C1530@BLUPR02MB1619.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB1619;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB1619;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;4:lyryREfyngS1QjxoFHZNZZrZWzTT6RIi2zsJvvKJIeA4ZOtvtVZBKbQkC4vvS1+Gm+FuEexwIvhvwaW8MCzXi7sH5aLxRhISOYz5EJlNL7U/Xsy7J4NeXL9VZvXl2h3PhXLwA8PVgP1ka4ey3bEpp8rO+2HvvKoAYfiNlubGolsM2/KOUGz8dyNT6Fj3dtMrrpLFMN9Qdk9+cqUv9DjgoWtZr9Vh30ddv12Mj11NdCrRBc1/BbjLWsQ5Xqf87BZJORdxVnuJnxisUwfn1eLWTQ==
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB1619;23:4VYkncvA3EYd+VveIerSZSYnPXWRFKx9D6jehcCWj?=
 =?us-ascii?Q?5y1y1JuFYarHg7gJkQDwSD98T78TiyqAmUB5nkfH7ER4OH2htygEzXlSwGEU?=
 =?us-ascii?Q?VGtZWFWgICdabK/6kQn2Pw5RDfgl6fsZL55ckWKEvVzoK5l5t35LLpB0zD/E?=
 =?us-ascii?Q?T9HaTOrn0m2XgI2u0I/n9JX8ITo9MxuHiLZ4Ghlqwbr/1R8fRt3mokCf0EAA?=
 =?us-ascii?Q?dGiI5eMMJ/byDBM0mD5PS9+8iu/BZTFFReIM4rLgd5PFZS6XqC+vsjP2IZUG?=
 =?us-ascii?Q?ABvzyRKNlMApGxvAzLHoSPL9tFX04QXPVYMk9/VzxXasrMaDyAQpIRhp8dSV?=
 =?us-ascii?Q?H4Z3xo5IbSjlLsPMpiq54502Tea1LQJqWE+15Bq7MCTsLVPvEEfF6SvTg+te?=
 =?us-ascii?Q?6G0E+j8KuU3BAtCVDEFWGhmeG94AulVqse1PNdmP1jbz3JHAZ1QQjtzqJsxQ?=
 =?us-ascii?Q?605/k8iwnHJSy1skpJoN8eAYei8VLCv7+jTwwdgfbzsyMJ4QxHpun1yXtQrw?=
 =?us-ascii?Q?eqpe7mdtLpIzqCFk1RuzW3FjTgs5VjSXih5Xbk7vTEKAskOFZqMZca0irzM1?=
 =?us-ascii?Q?4rUNqedwzYasIEAqMUNSpVt3JCFS06STXBqo6hI39gn7H2ddwAIDuAiU1emp?=
 =?us-ascii?Q?j14BlqlHjB+Ck4z8vXJOIRG+YE66XcDopXNqbq7aOLXS42EWP8P6MBHCofES?=
 =?us-ascii?Q?pSBLM6sg9UArKiJ3e6E3YJ+aWvA8vFsTRjk/r3hhnZbDk8J4Z8dhYD5zSG3K?=
 =?us-ascii?Q?c12EPMD1x7B0VRKuA5sejftZyVmQykY04S7OkMvuRbrvU8oZ72GpvjJDKR1J?=
 =?us-ascii?Q?RwngXxQAMCMgM3Yd8s/PSD7TzOyOZv3vTE7s64tnD8TIUP5juYw7RM21TR6/?=
 =?us-ascii?Q?+abDufnxXFN/tZHcdSaGvFezr0r25OfkG5aXRQ+A3VFgkUrhIYqcKqBMsZAx?=
 =?us-ascii?Q?x7i0mrRQDmcXQ9bryjHDMGM0PipYvmH8AQJHr8bL1MG85rVvoxF/oIK0rCR6?=
 =?us-ascii?Q?zBeCJZrvBJkYY3CzdljBVsmzg6dFdxI79PFWw0lUKxCVW0RFaLM2eclx0ydm?=
 =?us-ascii?Q?S/D419Rx33QZh2zPZdXCP62Lg4o6i23TSDySf0hi4cz2ChOa8y7o78nyjsw4?=
 =?us-ascii?Q?/PGoiVlG4uKxT8ivkEU4g+c0l0T5G3vMrj98Jn2VRkWpQ7Yc2cxN6OXLFbcO?=
 =?us-ascii?Q?pOTWecQ9SulP/c=3D?=
X-Microsoft-Antispam-Message-Info: ylcj0huEbaGSBGPhjmwwHHsJVKi3ljTOaoXCgxfiet+c3+oYDv6oKwmug7J7sev7CCq71Es0JKFC/KlL8wuW5X1aYxZihh4kbvrH1vpKJEA/wGe4sSjMuluk3wP+r/8NDXawdphL+KOPVDLA/TrSQnOtVmM5SKbwNf4FOYm3l7Plv2D5EwbX/ALGaeGDyfxp/1t9lQ0PkkCFiyOTLIdz5s37V4v8RHE3ncfJRyVE9R5FUe2+sCsPTPGa73XGwMXVarHK0NAEHJhDXjVGGNSCvCrj4QAnyOH8SRiZy9+Xrwi1S6OfhO2Qwho0VT/921GdhwgPwgxK+s/fweLaaErJZGfthPOdakMGbQuCUDeEwMo=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;6:PAPWSQzrPbeoxet4S0UFqkowsaqhdaNMnkxzEPBnOFlULEgtk90a90f+4pERMTeMZcBq9ooLEvO+iERgv1OnK9JFNMTl0lbxvquE7TMvbX5X1Qb8Ha3/20BrV7wQvEhvS9nP2cXbVbaZScU4r7O6kjnILCj1tDWXDyjyy66XNBzYQ8WgxICOOFyyoFlrY1TdlqtQEhjmsQV0hGGVedgKWvQJFvDvfPL3PhWPaF0aBPHQliKAr59p7QDvICC/BiYASWtmoLneneBHFE0PKJPvt24sWeawEnQAQdja7t+FcMJkU0G6ZwTMdERLuRJ+JGbXystHb3eJUDFOOuIZlyrFfct7djL0+pptMor+IVbP+ZzP22xM6QFWahzlflWzBJgBWUYUkoBvXNK+MtWng4VMDEpXYGkZDkVLA9iwiMWJEblDSxiXY6rVjuJwzZqz2/VJTJpeMAfy/90mvuoPVcB2wg==;5:PLoR7O3dOGBU7ztuWMoCnINpVady+AXbDIudbUdTABAxh++Pp+zVnoGXfTZ1Ft4BiknYRlwRDHNV1e1Hrqq4AM/yRcLxYZvWXXVKxAMPQaBQnfs9W4xU4Kb5NuLVD2nT1FjWCkkSRngC0K5+5LQbz1q5gnRM1xIVRiMpegrQNgI=;7:qtWrvPngqM95JQOigsdT2ppHnDPvUmo6uhn9qcWaQN9yl4z8p8vIvjABoSkpFP9xVDVqQisC29OTW9mCbdtydnEQZIFyLaiCzFz5cvVEXXvHL3FkPT1LGWmfazNXEpJekOzAy2Q4eps7E59UZrjzt4NUkcoPWM54C5ZiElNgUADJc6BPGrhGrt8cBPGUGbzA/m0QpZZk1lxGtUTI03dhZ3aigbiYFNHElIs4hiU8L+X8wJZXP58JeROazISVzUSO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 11:12:46.8121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050d27c2-aa37-43c0-162f-08d5ec9f6478
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series resolves code style problems as reported by code analysis
tools.

Manish Narani (4):
  iio: adc: xilinx: Rename 'channels' variable name to
    'iio_xadc_channels'
  iio: adc: xilinx: Remove dead code from xadc_zynq_setup
  iio: adc: xilinx: Check for return values in clk related functions
  iio: adc: xilinx: Use devm_ functions while requesting irq

 drivers/iio/adc/xilinx-xadc-core.c | 60 ++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.1.1

