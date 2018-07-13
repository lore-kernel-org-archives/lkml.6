Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3977ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7652147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ShUx5m0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7652147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeGMFXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:23:18 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:3363
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbeGMFXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSTeoEqLmiFHCPbOUba/6H4mU4Ojk8nGHxU+kbKd8pg=;
 b=ShUx5m0Kiy6j8T/Ez0r9S+1apzWAx9OPtZnRdvQuwhSKe6KAxtp/o71oNdFW21PhToJJMsNC9WeAN+q71hs5+LhDYUrgx5m6eHqSP8ViH3cURDn28SRWNWO/9wvRStsOjacNiCtzNe8+P5Eahl6oarFIjVZTCLys3YHbyyA1xxk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3230.eurprd04.prod.outlook.com (2603:10a6:802:6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 05:10:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2 3/3] ARM: configs: imx_v6_v7_defconfig: add DMATEST support
Date:   Fri, 13 Jul 2018 21:08:47 +0800
Message-Id: <1531487327-21879-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To VI1PR04MB3230.eurprd04.prod.outlook.com
 (2603:10a6:802:6::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1c246d6-6e73-4876-2490-08d5e87eede9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3230;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;3:8mIC2HXHldNQM+WamWeDmyaGdVkVymsEglxO+lugcEFJjypZvwj0HI+HmLM9d7QvgJ+3ydF1Hk6V46Hspgon03JeltakcN//8A2/NcR1W1zXC0xmmGeSBmPZIu+0A8W9JtK03J7BHra8PVTOMt+MvAdU+RThPBLWEgL/X/A44+LCYs2qSoDGvl6ZV271yevVB5iNOqg9kc4wkPI7bsW/Twm4GCLLPW6RbfSqK+ZQ4aCfq0prZHPs/gN+Q9iAT5+f;25:2iE3/2runxeTbfyhj7ainbQPfX5OZyXU84wlIdc5dY25HDAuA+HF7dALiaVNXuZGWe3eyUndfx8uffs+ypj+/tdGcQh3l2Mfvl2YWBFJ57w9krFEwmrEw+NAF79+X084DVe6bJcMdOOvPS7K55Ep9Um5Q0s5CCirld0y3cHmV1U3yPbubuQl1z77IzNDniCKWWIlKjxsdiaPgEmgvHV8aAgC7d3V149pSIA6oPZHg01NMQ2fKrHazpgXbgdenLjD8MZOa4nCczhcL7OwEeOL+zEmjYVIajqSTJZ9j2IRWtOyCHL9NDUV5TCz925oAgKqa82Y3ZB9SCHE0CSyFAYcPg==;31:erMDqC/pcQ0uyZ76E5PpRkNqGTzVDVn0AJcfk8ksMPgG5/h0Q139GxFg0xECJyP2Y7ndti4RDipUwbmcYjoraZzAuEGpmLiAfrQ1gbRd5xFnTP9A5JTpfKt03stLXp5ZGL5GNzNqG5YBCfm8JZ8B7uFgMihuepXKOL0gY8ebmOnUiY5KG3isOLppnwO7JBDvkATxvmzAe6bcK8wOL+ZkRgTldskhH+nkOCSC/ri0YOk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3230:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;20:KeetMhKWeJimbXV0e33LKYIHkLSGqL9NcL/VZdv77B/lvlwyj88PRfHnNCQaAE7pwk+lKvgr5LWQUFMAXJXl3/uYW+6OYifgyKT3gPPqjf2AzMA/qRXSg//mGlRhYAWCaw3Trwr0tHnAPkg2Mi3S/zrDToqcq1LOwWjECTYOa6MX/u5dsWqjerPb4ETN5k0EgIm2oz0hViNiIDvqwY0nmevsRQaYygJB4WC0V7h4d7xsgxwwnMYAkw9aSCaS9Vy6QnrIJqGqLQO5RuJBfBDNGSMl0DXUqf4pYyMuJLISn0SyFfqgpPBir2xw181RK60aaocZuqU69KkyxucYR2lxnlKGZAZYfOLdAIKkq9gBBDg0uI6UV0vIlCHR+03rCMZ6BnsVOUsZ5acJ1eEBvd74+xe4yi9BdmXqGH23VqbNQ+fqrKm0J972tWbwJcDWTP4JieQjv+G8Yj6+gktxnD+XoGqMYFKyfcQzFqp9m50aLopj4OEWE9cfAwJq1rNeI1Ri;4:YxuNrgPQKTRxi0L/Q8LgyKz0InOpiZs7RRAW2itzGEMq8WnmLVA6Is2962qFMTML4na//cGRMdcPjxW5AUkZ/hZ0L9HufY+ZHEwxYF+UvPR9uPw9xg4dIsx/ce5/9naUojLPGBhuXgS9lMU4M2fUrSnqz4iiTsRnxY4B8jAPTmve4Cu5eHixuPe9TBx1RW/eakjOuqHJxeMqcwVVPSF4/Q4JVtoHnnkB7MiwvJ6a6DnpaDQADW2kJsDBI1nrAthD2PSQqEkudZOXCKCy5hbIodjtonRJepe2tnApixuCclrpWr9Cr09qsdyT9KMNVYye
X-Microsoft-Antispam-PRVS: <VI1PR04MB32309CD68292809FB4F2DD7089580@VI1PR04MB3230.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3230;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3230;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(6506007)(47776003)(6486002)(4326008)(51416003)(386003)(66066001)(8676002)(76176011)(11346002)(446003)(52116002)(478600001)(48376002)(68736007)(36756003)(106356001)(6666003)(6512007)(2906002)(16526019)(105586002)(186003)(26005)(25786009)(3846002)(2616005)(476003)(305945005)(7736002)(81156014)(86362001)(956004)(53936002)(81166006)(50466002)(8936002)(486006)(16586007)(50226002)(97736004)(5660300001)(6116002)(15760500003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3230;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3230;23:RXpvhL9Io/tU3XCwrE+kGg6bjW56ypv0rgxG12TGX?=
 =?us-ascii?Q?msdLCXj7SxnNpqQArw885PhU48oTikrLNAaqkLCU2fBGj8KcTceCyn402+3C?=
 =?us-ascii?Q?eFjfoi9oQX6O7bb43TCMO7Ibe/ekL0u/Njf9EuXXLJybUJVn1sWume+K6OxW?=
 =?us-ascii?Q?pDSslY4XcyMQN8eQeDdmOpEt9PuHxkJu7f6rtJQdCZy+S3RNL9NVGmWyP6Qj?=
 =?us-ascii?Q?cIcYE1Iytzf0TJAZwt+WMG3X7kY/w82r5P9jdHnjj2Df094EO2hYjL6W/1xp?=
 =?us-ascii?Q?3/4c/lSi5g4V4etgJ5IJ27jPcHDBrn+hpAEGDXGaYs55LuwPhPiz3O6zxx8N?=
 =?us-ascii?Q?brQ/wo2Y+Ik7euEzA0kpXF1CIh3GbXbwnd9A65ssMxD3bUDpDTXyfdo6Qx2a?=
 =?us-ascii?Q?xPiFY2dBH9R7F1+GwjeCzMq0noqCXl4j2756X7Udx5a16/Ca5OqSL9Bpxl7D?=
 =?us-ascii?Q?o8jcC/X/aLsL7elkgfOqvX70N/pt0x7xDudu61rvp1a47Om2q55dx+gWjvkb?=
 =?us-ascii?Q?qMv+e9hjiys7og8EK7AYXwWajmfiNTRNUBn3KMypkDxHU2txIoVaIAbP9Tu4?=
 =?us-ascii?Q?5DRsMqv/ljnHU2fje5sHfDAZ3Ly/gnvcBHmhz+YuegM3ttIh4P1WvHmAXMbY?=
 =?us-ascii?Q?iQWDedgTUJGoChMhoOQiOX3QKJ9mNpCJyOqrSt2cT6n/idGsc9SVDbAC5AO1?=
 =?us-ascii?Q?IRQYwY3eIyr23GHfjJ/CrsxgveonY8Jq3AOrfiMavX7c8XprgjbadwhJy3kE?=
 =?us-ascii?Q?GvD/oo5LyN4ubNfQArV0KdHfNVv/Z7ygaM+Ts5qqGmJX3zKGeILQfANVy2cA?=
 =?us-ascii?Q?n4sFIwXedut7ieJt6/qJci6ytvVrVAzbFQg5CcBbEX2i5gKHHgdWh9L3+Rtl?=
 =?us-ascii?Q?dbv99A3i8GBW9CJL7ceYplQdn3cgGNgMV/PBWFWXfjJz9CeU9pJeySqB1HSQ?=
 =?us-ascii?Q?jDk0lOfaT3kTWewoSAQu/AXP9sozDmh7FMbO3+sd9McuiD6WuPhRIqIluERh?=
 =?us-ascii?Q?B2gt81TzEdiYLf2BJ5wgOG5gLwZRLwHA91A++6xW0ypkAFgFHppNSNZcYTyL?=
 =?us-ascii?Q?//b+VrshjhwsqXQEDlb74g4LFtXmEPdYYZctUdaxsq1dhbkAlG9YhG9hyrro?=
 =?us-ascii?Q?lS9FEkv8C7pRambsN77TdsIsrAXTuFMnUl2dt3EYzOMDHuVec8hd566BHWWX?=
 =?us-ascii?Q?yo5LWgg5IoqmZU=3D?=
X-Microsoft-Antispam-Message-Info: HTFnoWl6X5uUpudxzcSfz9MNe36r8AMud5M+6Nl9Ckfx2HHHVb+dY4UfBFJaP5m2PvzMvcHxYQZ2ql8CbLNG1djRQYiJ/qOlgG8Ta9xiQYRksg+Bf7kSJVhxcC0uCoifUDirDMfJX1l1crelDjkk+bMU2FxKZPwrjwCVDODYvGNZtmwNpp/O2+4NoEKt9S1gNEdMQ1MyZ95Q5ju1HDFasrPfw4y1D2n5J0xgrQ5Go64JM3wdMUYgAsu7H24fntTXirpwEGPyvtw6xyduTJh/vbwZ6ekNoAbOFOID1tzfmkm5MTBTpaCs2bI4V2DSPwT838UIEIe8OKnoCHXFTnbrp9mFPQNLZoQzQS1y0GqMa1w=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;6:nYIuFkWwMB+FYUhZFuMuGDDbS7nNS+kiesn00bju4Q3tBZ5zEuxDla/rS0X6csyjNo/Q9b8SQTAp6DDsxD+5gepm8+ZNXwC0i0hsjC3Q9atwoPSXUvznwgwpYV2pZyO/Y/ATfJ+ml8XPvRsTpXkvbqmbRrAfQf9XrbsLvQS7fc4vNX6EcnJKyy/S3pnH2W1H/6nV6jKnUuFRvTjyBBrhiq5zZO5holBZHxb4jS9ijUe3IouZM+83AAg7s6Clu41AmUYV0CRXBmUF/+dLDsbVto1zJC/fPxraXSnFhRfSuDV63cc5zLDQWdTcmNoqj2jObGvdymcVG/nRkG4sYSwAaruGqJiRVsjrxl9kBevKYvFw8BxWsGQ55s8XF9uO3/GnT5ksLa5MfUPFaGS/5IVNTop8pWwVTeKnqVtxr4jApwkVjCBxb9OKxJjFfE+9skX6K70LzJO413davSih4ZPV6Q==;5:rWP5GjqlEtS9YRjDgUeWVsG1U0otEQny97DLoNsR3QYrm4JsYelhp1mbrrEa5UwsvAUHWx5tX47tbJjaYCiqLMz03M0HtvcRS2ciXRQ/IxDoswd6RLoF61Mpvjm1mil0EFGRqh8dLVxHc6KxKl+/WbtSWo8RUB2P42cNJ6kZgro=;24:MQgh8JfHmOd81PfZfHruGiyGzk7/zsA2pRlkca9RUhk/KNB5kDMIq05xP4+0hw3QVqdL9EVGT+w+BU9W5unOgQS/VnD5jc0wElubRrCdNqA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;7:SJTkZ8mVxa7HcPcQhKmDSoUBZddEfOzpWT7bPhX28EcMxrbbN+JMrbIlPZc3zqlykw7qx0kgg8zLmdipAJ2xhaejERBOlEHBAGE0nevx3TLd7/9yNdVqLuRr7mfJa2uZVAB0dWpeBygDAYF0GN+T890IFBpN7koTv5F1uzClTppTe35zRILGyGjXyV6rkXmTOo37fOORXJRMLON88np9pY2986A63koKXnmmgg9cT5g/2T3uYWZs8D3FsVBdgmB6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 05:10:16.5213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c246d6-6e73-4876-2490-08d5e87eede9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMATEST support and remove invalid options, such as
CONFIG_BT_HCIUART_H4 is default enabled and CONFIG_SND_SOC_IMX_WM8962
is out of date and not appear in any config file. Please refer to
Documentation/driver-api/dmaengine/dmatest.rst to test MEMCPY feature
of imx-sdma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e381d05..f28d4d9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -81,7 +81,6 @@ CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
-CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
 CONFIG_CFG80211_WEXT=y
@@ -282,7 +281,6 @@ CONFIG_SND_SOC_FSL_ASRC=y
 CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
-CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_ES8328=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
@@ -371,6 +369,7 @@ CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
+CONFIG_DMATEST=m
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
-- 
2.7.4

