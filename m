Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DD5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46732086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cKwqxNOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46732086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeH2JAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:00:12 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:38631
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbeH2JAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2kbLJQojCTKvvcDDmb/nmefeJu1HW23poNKySlhEY8=;
 b=cKwqxNOl3qHGFy1HfUW1HHDsPB2+Op7FTsmozfkMhSlhzf4+W9PCQ1U8SAcUqfWPgiBBgzdpfyztBeXx79y4CNZaTkCCXv4GQxPsIrnOitUaoqxHXLhbAJxR+OMaJByXtYWXi5KE6QY26p+YlLeRH3Mcy8E/7ynG00rGfR6v6vY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 05:05:02 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: select CONFIG_ARM_CPUIDLE by default
Date:   Wed, 29 Aug 2018 13:00:47 +0800
Message-Id: <1535518847-24417-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
References: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To AM6PR0402MB3909.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156cf068-108d-4e1c-fed9-08d60d6cfc35
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:78JvZb75Lmrsl5scYMJ7I6pDkkJ92iofeCLkOUrdVxS39uOE319tu3rnFW/BA/9gBs5C/oADhb/5gdI1GrDQlxAlBkKDy6U6Pwp/7goDlCPIV282+wyJDRelMeYgJTaljII1LIQZukN+fKyV06AgkRdFc6Ipw/ZRzHGhzpBePTduUDWApKLnSCMJOSpa0CMwrNJbiN+c3E1ru2U0NZsRii3lJ8uy02aIqnBErq1jPCwxLH4b/lL9IFR8cm6Ijt+9;25:i4kXKH+3GJl7UnxOh4nDxUWrhCmLwPxCGv4sMMTxp0xDdBqJBQLDaCl2RxDaqA50WXDKclhO3vnrIXUqVcyAwpmji278gsxy0rtzJWocaHU8tKt+gLPEWwGPKwMp40n5BZim6uutL1MHNmszXWBXn/e4cNowUfabXFqFunYOlNjnh8iWs418BbkV1QOVRwTTyt3tOX8xD6uXCgBnBNk5uoJjJ1Z55GJtNXaNJJsoFX2QRIpZC9nqLnJh+GTtm58DQJ32PE44PL+SHpTAaVjhUhNet6nwyU6uEjH6cUdsK+DNFw4Mv08cqDTdLVG6HJeOmwxsHdlN6bilmAUieYqY3A==;31:L1BWM/Fvfxqo7UKstMdCn5R56M/SCnT6qWGAvuWKaTVx0UfUi6ZCAbMjJ0Zxx25ra8gfrkSPK8/9g/LLYppxaxyNIiy86PlxMkKMrUkvC0XLmh4WytzU9pzDd/XxmjmYOk4499EtdlCsVUUhNveVIv/jT0J3Mx3fCWeFzhBMxO3OGie3ZwO9absOj53BnNkPxvGD2mcbEfHQUAXjHMHIxCVMvDdXqkWsrFHxbZ0KDzc=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:+DOs/eRkvTLqWjgFe7FzZn8Id3SoH+Og94GIa9vZld60pzM/y3PheikdBBh1nVNX6iaL03B8HIubG9/cQl7qfv9AoiKYViKmhjpuOcXxaW2Wz0W2Kfk1CGVqAYFw7xNc7fIqU0TyaBZhT9T3qPyPHgAWSZde+caVfaBP9anPP+WymAmqyGxRszeaxCrv9eBbIRUknjLNgPf7Ijori2Xu8VQ2qnmXergL6/Es2oAtVC/gSD+USBPxSYEqYOvm8t997anUGB9WqbKRMIwziDp8C1Cd6RPOR5hxTxP67rGYeaAjmRJ5d0n1dhKIo0FPqBUfxw/cSWfMOTISqBAJohbvMe94Y8rYzTC6ZxoNwiG+48XEPvhY6cniZU5gRQAOv+2OlYZ9yR6VgHZfni+u8GNKRFW1LWJwJTX9dn92JDeRTyXOcm5hUVXWLLq/BKLfVzEFSJyJyuCQJnAr3TYu/w9ojc3FHrSmV5B24WU2nrP8cX4ewPnkkNW69dXx265tL+jK;4:iWF3NXkpsTWcIbzfazkXf+9HG/HLgk7jNJSpP1pnylAa6lBlicsFfm+wlI3wwGsD7rZlN52hliWkXRhGYwi7gv6Wpgvc0ZdOAzTkKpv2GerPM4pr942tXXiIRGRzkG8IhyhLtFWs5Oz1/+DVzcj8TVWQqxdLnyhpXS9ovuzPenqmC3N6YZyVYp8YQk9RRsI1gJnif3q35n2JdjLurOOS2bIaOXHlgk5/fDgiKWJ/01ZWgZ+TedwuPrdFKZQR5q2pz1GHwEsa/KmZrngkXTwFq2xqk3mZgDh8XZDrK7R0+/lT34QDCTjgGnxs2Mg4Zg2q
X-Microsoft-Antispam-PRVS: <AM6PR0402MB39093CEC022B118D710B1463F5090@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(97736004)(66066001)(50466002)(36756003)(68736007)(48376002)(86362001)(105586002)(305945005)(47776003)(6486002)(7736002)(106356001)(25786009)(446003)(11346002)(956004)(2616005)(486006)(476003)(5660300001)(50226002)(16586007)(81166006)(6666003)(8676002)(81156014)(6506007)(8936002)(53936002)(4326008)(26005)(386003)(52116002)(51416003)(186003)(6116002)(6512007)(3846002)(316002)(16526019)(2906002)(478600001)(15760500003)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3909;23:FGk8VVOY+LIJwYkfAeDOHSkp09vSXwkIkQG9AUR?=
 =?us-ascii?Q?fINOep7DQWgysxDzNJJ2xuU7Lw3BbDuE847Jz4kmi9UF3Y7wLresyBYDqSil?=
 =?us-ascii?Q?r5Y06yDUHTs2d8KEaENHb4COYWpvTch/YC2l+naCnZzUOu2NTIjLlg/8k+63?=
 =?us-ascii?Q?G7iKU1hRrkq6o1mixplzYq9fuhEv8C0rHcBV0VCbPqI6vhRVv3TYE39OJsnw?=
 =?us-ascii?Q?cul3O5t9p6OlfKuilQlr4x6khZTAcxRsdwMiHg058wi1ruSNmgjO2G57e72N?=
 =?us-ascii?Q?KTQE1hjqpPbWDMSNO+YVQ+r5LFfp1Cwq5PkZvj0DvIc2viGgTa3T+HRDFNdY?=
 =?us-ascii?Q?X5U46rsjaQaEq/TVaqHrmlRgwFQ2GLI/JD9SJMrb2T+WMkECHIP+nu1zaBKR?=
 =?us-ascii?Q?H808V8PhOw+iLkz3DYL4LMGd4qvD+PvZVCvXnLax10rS6dLix3gOUCFJsAP4?=
 =?us-ascii?Q?9hiY/WfYrQ9HkDelyNyyV0fK2NN77oOnawdV7fvApiKoN9vD+9GdS3Yr9K6C?=
 =?us-ascii?Q?toJgm/pwW0V2Jl0W/AwjPm68Go8d6z0C2hbHxJlDTmBEBuTI/OsK6Rt8zjUU?=
 =?us-ascii?Q?4jXFVhV6esfRNFm37ADk3+rdXv54sJDCZT5GBpVlyTZPccEK+1APg3p1VFuv?=
 =?us-ascii?Q?bGws2UD6nV4mAC/fV4MOi7xKUr4J2a1/Ib2S8mSTNVfAtuJN4B0K+wCMfVNO?=
 =?us-ascii?Q?Pp0+jIxDOjTsPYyipebmmnVf9K9ZfY2F6KjQF1EssteHDLlFxRoCoBhpkoQt?=
 =?us-ascii?Q?BAbMgfJJ3FOR3QHtvdIAhm+fxy9KZ3axsLgavOl6Iziir1+meapF+v3he87l?=
 =?us-ascii?Q?5/6wjta5yNJoFbg/pEyI//cuXmf+4isH5Bp5aaBWeDrk7ZJ23FdqYMwVXckE?=
 =?us-ascii?Q?gnbTCNOXC5bZcRdqbqBUZRiTvAEUghRdMdVcRmo1vQTC7t8d6Kt+izg/mLJ9?=
 =?us-ascii?Q?3wPkHccrTWsJiTYZpzx7r7BCYp26vJ8N2ODxHKQ37CXwsuJmHntc1PG9cdMP?=
 =?us-ascii?Q?w7iaq3hSZ+2bIUj4YEIi5qieEPq53+Lcuce3KlNl77uIPbnCPX37cLdNfipn?=
 =?us-ascii?Q?/xZQL37iNItaaZZdKYWWMlNZnFqVzVBVEkU/FhdTKF/fzZY6itJO0hw6olbv?=
 =?us-ascii?Q?GTN34AjrLh16Ab/uI4x9AgZDJflujUZ41/TKBlW3YVbpBQxi3ccSqsw3jpAq?=
 =?us-ascii?Q?rwa4vvBAEf88swNEtpdL62IYRmG9tgWYG18YU?=
X-Microsoft-Antispam-Message-Info: C4bck2fn78iGkssY1e9hi1N7hEJBzLCzmHarniJfpu1O7WsKHVe87f5IL1n18uydTZTu2/fQ0eAIjEeDzS/kD+7rnDaDOX0PNTuTXsvHNutWKmmCNidck58ap5ll8V9YvnzlPXrrwDNMD/aamOU30tVe+NEw4Xcs/ORremkmSesj2XIQtfu8whWaqHWM7E8Ct8rN0EX3rSGx3MhI6l0Es8xlk/xEGnE9aFIiBE/NcWEjeKnKXVGiR6k9mGk8ZYhQ07V8GKo3v8Xst1sOJNODfdU/W+NC4oPh1K5O1ZS7SqxwQ6Rr2oMHFNbZGB4T1cueDGdsOfcja0agjJ1SCwWrn8muiJ7HWosqpCJhAMSuBFo=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:OAmSJlKdoTQTbGqBX367+HZ3Tp163dMgucEuUOGNvphYC+8o1f5EhQQJgp29WfLBAnnJSVgc+LfsOfbdKLYqtuuFY07IY+/xxFfwngcIFUyBYshetS98qOc7vlPOZTGRfH1OZRuuC6RRHa/nYTZe1adjMNrUCgCf6sZU76LPRxMPP39yOwAdHUUnVoE1HpOYrZja37Hd/bt1yzrELQh2GI7hosORC3xF9/X9/nS+eriOe3Z8jmUrUnX4kPNcnt7p9h0J/G2aI9OSXu4nyiczhTLbaTokqhGdWyQFTTmltHwcc6SeF2DqH54Y+aIWJwuHPYFCTOx860+DbszEJnnXGcSIf2tncxbp3kZo+SFCbHMQvq+p7KhiuXXPWFmXbtSbErHuaWlqraywNR8gCRpDw6xIyN5Pi26y9+onNBanm1ATPIuCZFoM2XQG+IHqZuB9RC0SFJ3o5j9ipQpqOhT73A==;5:S8cDEjD8Qgp1ErdGukybqCbkx4NsETe9tIyAee4Cl7VLMgh1Oov9iaiG1k9QhJD7Xru4zZsbu0J0b0KG5MZt9N0egarP01h3XZt+Oy69ErNq9euxPIiCYL5xtsPdNvmmR5Waqc1n1bf/bq0vnDHokn3lsPIVjWFBgiQgYp0Ozrw=;7:5O6jnvhBgskMAEMDbwJ4hLAnQ2e7zH4zhNhQDN3eKK7ePpA6euzko4u7BDZo3mzSHEOqYZYI8y7H7b8KcBbHgZDSvcovBnFU8bfx9W7HJ5I6NsZQjuaHwWA8/N1s27IKa5MSNffxIyR1dCpivgdBbvspZa6TBr7sc27JjyNPSAxYMab2gOITZTzVE143sLWU9FjEQ3Hjgs6om2OfV+zCDh3SRo2eL/aV9ecp7S0DzhfSSgVI6MMTU9AySNiC+lbq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 05:05:02.5606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156cf068-108d-4e1c-fed9-08d60d6cfc35
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some i.MX platforms like i.MX7S/D uses generic ARM cpuidle
driver and psci method to support cpuidle feature, select
CONFIG_ARM_CPUIDLE by default for such platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c1276..65df4b2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -62,6 +62,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m
-- 
2.7.4

