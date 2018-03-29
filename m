Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC2D4h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 23:56:37 -0400
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:61192
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbeC2Dzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 23:55:47 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 1/5] powerpc/pm: Fix suspend=n in menuconfig for e500mc platforms.
Date: Thu, 29 Mar 2018 09:31:39 +0800
Message-ID: <20180329013143.22527-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131667693447604640;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(346002)(39860400002)(396003)(376002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(2906002)(15650500001)(5660300001)(47776003)(106466001)(8936002)(6636002)(6666003)(105606002)(508600001)(50226002)(336012)(26005)(36756003)(50466002)(81166006)(77096007)(81156014)(305945005)(68736007)(51416003)(48376002)(16586007)(316002)(126002)(356003)(8676002)(2616005)(59450400001)(486005)(486005)(85426001)(476003)(450100002)(1076002)(54906003)(26826003)(110136005)(53936002)(97736004)(86362001)(104016004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB391;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD018;1:BehqQlhk2qVH30Hd4KlSXhAVB28/+guxKxg2knVW7ADg8yR5liRs31anEUMPFAMeS7sTgMUj2BRLM/0L3DOQ1XyNVTnsprxfpXJlHOIcGIvDpb1tltC1OU7gPK2EzlIX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd1d5f4-0be3-4ce3-e9a0-08d59528f2cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BLUPR03MB391;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB391;3:qBBxenEUL9f2S2u91G3uKUSuE/rRiwHVn56iLc0rUhWz4Yph2avivDSInNbT/+V4QRH/cobGxchSSQOQXjC4Eb+MLGebK1AKbZ+YrMfIm5J98E+m5oMDNy+8CvNu+knPEAZVfE+VMB6Lt8HGy+sUUyZRpIl32+cobuX8HIuigcZ6p67WJAYtQwvvA9SXrJO269/Zv+m6d1CWDy4xuqx7bQTHAS7Xo56cqAV3ezN9mhbG5huw5sRu4OSn1QgCK78JXLjPxYauxnyax3Ucj4RCxgQ6K2tazvQBMxJ455osXgVS/IaZ5RDWP87lptFYsbiNtw97Go1T2dFtHdTbW7XAmXs8EkHLXlEuqDhkq9sPywM=;25:TP8l3YntIukQTIs4FYD9G2JsLD1JLJogr9rAlvnFAq9Ej7QnqfBTGqkSB0RcmOBrIHtHXkHuqxX+kW6ZrxVEwpDxS+6qe7xAs9F4fj4+JJ83kBeGLIK+J1Jlor3FfRRqjYShWyx0ku0zWP7jVIBQkj5lDmkLTgtcgqYMSkI+4POO7QhtL6QpjuCw/bkERNjfzIyYDbTIWZPUiJHghuHS3lXiM4bSE9LYvxzFOmAaiVFcTBn76YO8o5Qq+DB/UGTT7B8PW6y3EoH4yNbWi8B016duC3OsPuuFWIoCMrriXb9LpgnCqgDzYeDlv0tlBDNquovP2u6m2Fk8jbidKxKVqQ==
X-MS-TrafficTypeDiagnostic: BLUPR03MB391:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB391;31:i8L+JiB/igWvgmQbUMUCZAC8DaT+FtVUfFCWDp4D9zf+IHINukxsfzgZ7HL2bNRpz7tIFStOmMtm9IlWSBH9hSwGy5MlaftuCN2JhSNvULAXitb3pzrTWh93tKM+YPztaJF4F9LhfFl9Dw5bcSf6SOF+bzdgTOmFGDiPlBOw51Fn4HdyDboGma/pwYnmowBZnEygMk2bVr6Dq2h85ghYNwfia+soMQ7NqUdnubKL8wk=;4:9ALQrzs5bmXQom4U7SeAJVQyN2pdvvMZ63xMi1LdZZkH+vAMCuNX5Ie72kbJUv73ELV2jhPO62/PVxb2REsfSht21zJ9aud5kJEwUZXgH3qRTRd/N8LdHNDUyiCpQFXv0JwbWH/6QnM3Vo84rJ3QeQw4BPY1jkmtTFpiBrlrtmp75r4KoBZXddGdrg8K2VC9oSPes0LRzPbiT7khn7bTtHT6ivDQi1yI3V1MmUnWoM3tlHQNn0jP/EKS6yBib6uPzFNxFJSlGo7kO+6Xdk5YmA1CGRRFPUSTLYYt6ha9w+HzEeWiD+e/OTmiVObf6TJ4
X-Microsoft-Antispam-PRVS: <BLUPR03MB391BB4E5BF0D3FC9DC75B26F1A20@BLUPR03MB391.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123556025)(20161123561025)(20161123559100)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123565025)(20161123563025)(201708071742011);SRVR:BLUPR03MB391;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB391;
X-Forefront-PRVS: 0626C21B10
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB391;23:6cL1hy753x6P1McUDGCn0USRUSPnOGpONT6xKKDC2s?=
 =?us-ascii?Q?L8HPXwupIRTi/0fX9jZyRZXzf/ENvV4RB5uQ8s+QqrY+Y4xK/NzLtn3SXeZm?=
 =?us-ascii?Q?DpSdaS1w4jNen6eOMt1rSC2vtRhDbI9n8jLgQWVhdg1Ltzkea/A6kQnnL0Tf?=
 =?us-ascii?Q?juxgaC+kppMecB6J+Z8NHkQIqimyLPWAXpAYJtmiZJnAAIhF8c7vbSzNTN1v?=
 =?us-ascii?Q?yY24ETZDFuomBXior9ovwBrtAhldt2LK4KxEFNyFWTKKZMZmj8iPG2x0BTgq?=
 =?us-ascii?Q?CoEDd/4eVVb8LjU54JShhsZlB66bvv55/PlhPw7cNwu523ZcLu9EOYXNdl43?=
 =?us-ascii?Q?RDc6wJqh/jFFgCaxFcO70adVteF9Sc7cptjZwIUAgw17CKcMcK6L91IIoonm?=
 =?us-ascii?Q?PeFcGBhtiygyxjKVGyGkUeznFOi1qBuAZhy1Vhiprn+HAPX1RUZqM2+GZY03?=
 =?us-ascii?Q?RMB9A9AfL1y7AEGhwYvkC0VNz3Rfj+fm3XxTpa7Jd7kWDIqW+kusomMRJlwX?=
 =?us-ascii?Q?d663LAM3hUy6/AIMtbVMKxD58vLG4oJIOHrRmy/6NJdrzMyt5JMpSMo53Lww?=
 =?us-ascii?Q?bSgtTPTzeWkP89oLpJ4PAhxnr4qdi+fIgvzmr7CN/x/8QiAPVf7CL705bps1?=
 =?us-ascii?Q?WIgS5N6tA1grq1wtcAvSdpx7Bwjp2J1Hgk70h7x200pb0C3xjWaKpPQ7709L?=
 =?us-ascii?Q?kEAywbUNReaV8uCJuckiK97/ZgvRl/29Horc0QqU0tmH/A+PcQwyZbRj/I7M?=
 =?us-ascii?Q?Jk4PsezT979x6+Lj6sMsQdX/0eQFQk4+1yChKj1B36XwwlyPP+W00SiriSgY?=
 =?us-ascii?Q?Q8WmiDOsub0gHicfalOr2OnYbNC7JWKJ7ONr1qYPsDseM3Vqq6xsbfiR8H5v?=
 =?us-ascii?Q?w/5pv8PSqck/FRozGHbHxjCn6zv2VlaTIrTGdygSibWzgohg5/34Lqgo9tA7?=
 =?us-ascii?Q?btyEf3mFpkBKFrMkIMjDvhj+QUB7+YdgTKMQ6KNI45Z+UdZUXaOS1Mufa6sr?=
 =?us-ascii?Q?i1JCL6E4657atmkBTKZzAgWKFDX1lNDEV61beaSHuGCSUhtQ97C4AysOq2f6?=
 =?us-ascii?Q?QJBzb7rIdweNazMpcypYkQ135qnV7lPQMwBwGMJcpbPhyKxIrl1SP0xKdpFY?=
 =?us-ascii?Q?IiqWiNfhgY2NDeK70i6LXcTN6VZ2xGJIK5UdV+QAD0PUpp8wGvMQi5TP40s8?=
 =?us-ascii?Q?WtaZ1/GIb3qfYJkItcwtxhm/DEUcKdePdS61mGjauMC3oJ0LWqZlTXFegY/Y?=
 =?us-ascii?Q?RBG7haMBQn5RCmKjc=3D?=
X-Microsoft-Antispam-Message-Info: DodU6DH04atNF+eg084ropV3Qc9dcZt92tkymBRIAgd16KN6p5qLTy1bXzXBSUjqwoeRv11cXl6ESfxi/TQUvP2klZJ7Jc9ZNVYkgNNIOqnCE7+DNmJRlex9o1uSV1nuBSuNgzHvR0WJTI6orphMDMT8Yo3HNZLBrBBPaHMlXPRdP3eYT+Fyu8AEHy1YcrJ/
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB391;6:xzJkSyP43+kj3rroI+43tqda82m3+xgitcNop1s+FUCb4exrz5GNyVi2EXAxpeZA+x7yLFlaROVtRJ5niDV1Xfj91dIhTBTx3xt/7KUg/lNdx9dDAXBpaPjs5X/Lzhfg09B5jThmKgXThsUvE63lb8ZfuiJCDWWR4/hAxepXNmFLU000dwrGGYYDX7J3btzfObASVxvYJKcbt7iBbPr5P1wQTbcIq40nEsKeOY49qcpv5lNWBGKOfgUek2eIAJI8zyHZFfH75izQUAVIcWlJQFiV8swD4vr9OOUcL0xLySx6152ZuXfYVTeVAPZMbD1gnQx6LwM3iwVL/l3ex7HO/F/uCaniVP2HBHOnBY89hjeA4hghBeVjpIwAQfVBA+tcNfxJ9UgkjhAPv7BNP1pUhJfyTGVMGgJ9y62J7e4ZM9OsMHSQy6FO9WNvrOYDCX3zyn7ETk+zdZ5+vYsMWQbnTQ==;5:iG7E4PwYBFFnzz66ocN73yxI0eg9yZNhtWiV1A4Z+eAOJarWF83/VT6h/jEzA3V56aPy1f5POKo2uKK4PeZ51x9pUWX8TUo9xPZmlVCuAUM09LEXI8+aw6dFgPZiWWYrtG+zVQnj4p/zujoyK+pP+nutn7CTyWPYq7h7NMEZidw=;24:aG/Jwh8n7uKEbScAD9sJcofzb1XEBsB5+4l5zcczqH5/0Phs6o+6dUyTfa/3wsj04BPoh9lsBFbQzuEk/fnEx+yDPH+1r0ZuS7jD8Kzx6RI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB391;7:a1qgJ3OFaki+4da46/Uyn/GSnV5IB5A092v/RfCtndnQ937ZZO6v+BvF4q2XzD1JIA4XMAGHsb87viTSKiWTsfQtEYkI/Fm0Rg6DSxkLuA17ovEqwO0fe4S/dSxL92XMLVQlPgHS5rLEWn0K0kGg0T8FSTsVXVZSRqioHmFf50goaXMDYsVWUNm5xFBmKB3v8ilVjZfcCUpqLDPPq4gCcYgwS2bWMbnGDrBoMAK3LEPyXToIOctCzifWdI9ZNpiM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 03:55:43.6060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd1d5f4-0be3-4ce3-e9a0-08d59528f2cd
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB391
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, unselect FSL_PMC which is for older platfroms instead.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/powerpc/Kconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd..ed60c83 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -316,7 +316,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
+		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
 config PPC_DCR_NATIVE
@@ -940,8 +940,6 @@ config FSL_PCI
 
 config FSL_PMC
 	bool
-	default y
-	depends on SUSPEND && (PPC_85xx || PPC_86xx)
 	help
 	  Freescale MPC85xx/MPC86xx power management controller support
 	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
-- 
1.7.1
