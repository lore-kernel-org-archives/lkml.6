Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C1BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B4F208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ct/q46gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B4F208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbeGJIob (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:44:31 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:9536
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751328AbeGJIo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVAkTVuIrMmsIUWxDgnnWzLEjUSKr45HQdwdPCaIpeY=;
 b=Ct/q46gdW9mH1p6gYlBN9jsL1bEg2M0vk7mri9hzfqBXvw78i/262c5UdyPSEEYRgZ5PjMcPWBTkqo7tByhsAFIcrzxhU5JowA3Mf1qezD/Om1JEgtFCZyd3d8Kxt54JYG8MJixHKEZjrTOirvH709QoVNCuxnxQlHMhAFnKx58=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1327.eurprd04.prod.outlook.com (2a01:111:e400:5187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Tue, 10 Jul
 2018 08:44:17 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: dts: imx6sx: add ocram_s support
Date:   Tue, 10 Jul 2018 16:39:39 +0800
Message-Id: <1531211979-2179-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
References: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::13) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4c96a9e-9bbb-4ba2-b126-08d5e641550b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:0vSaRmTdjhm8zDC6fGBFT6HQfOEpQAZ34Mn2G51nRn8J2cqua/dhVeJ+zFe6Ey3GCkErX7izyIupkjvVpLJmielJUZbidk/oCVS28YKqbE6l6/tqM45789RPQRaXX697aOSlWYlg5YswVdyDqFRIlyY1BIBJf56uqYioJnVvAwCjWZHv29Jw5s33bTjY7T3KWOsjIt7JE0cOdydIRypNIBpubARZNgtYG6T97vIYeeth6/PxBlnxj68gr/5SFz/d;25:VHDpr9WWAqF9YUYTYqRxQwom5jHgMFeO17yfPYZerD2N7lH+yAW9xyeNeaR7/J1aiK2SjnNs4aUoNtfq0IRttmkrNQbQOsdSil6pSuHIzKhKi+K6LPdinzMb2TbtopBnPDiL5oDfALCnz9Jzed7RguQbnx6ox1bqRc1YzMukIDCzC5lCeluxu4pQ1t4I4s7y8qILVcky45TTc/WYNEXhVlt+Ki7XXYbSr0BQO8IdACagRiGWn0dWywlX7LBmz4bCXSTCQECpCklttU2EXEkhVGrgqiHFjn95HNALxg3L3/XnPTgsUCtD/oxWY9j3Z2Uyq4eEjFWU6l09Tv+aJTJUVw==;31:MiMf7uRSgHt8q4wAL/h46UgvGtmko4cX8LdX7kYzxtlOB1f50jIr8LLra9AnH8wHkfYrFFE+YbELqN78tGpa7DEL/r8jqs0kWr1bJCyMoKNCbBOTTEdIAcKdvMmX8PvXAjEcRS6cE3++q1POXmCuWxaTslxW4FVfzeYTmuUK5O2NzRsBLsS6BBG+YcFjYvDWsovMGO+QTLO2JxPP+C7xn75ftK4ce9LPVG+H7/WvfEo=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:lJR0ihqGl66utkGsUtDGswd2tsL8/iNZP90tQBNQUwb+MrdEkie945x0Rkgt/CoMzKy9YBa4lonwrtCBQ1yRU660NggdPs9J3mEq9vY7opMaIr6txWLJjN08W34ks43pbE7gnr7w3xBGpL38Fwfequ8686iO3+3QmWnz3rfudDgN85hDudsgpotrMTv6WY6u1bq68+u0tjdqb9bc2fePZwKF7vlI43PAMB1jig8UDvynL5tPlt20GtzoeAcXlhvDsbGjIAJsOMkvYLgkNBJT0KXmkWspV4rRL9HEFoMCwb2UT7nNflBjgqcOUseJxHG0d1mosLtJF4JDO2tVxsp4/UfadkC5WAwyBCtWnmOGRYQrKMvPmiJR6BZ0yk4RM6q5cOPg9lUu0HZUtk+TGtRiBW0O/alEE8el1HJnGz2Kgvi3FpYV/D6lzfouhlBn9MlpOeKa+smiJd1ayEKa7IC6Vt/ZX+MF3YEeK0EIj2C6TkX8vPtu63my5VzqQAV6vrgk;4:rTAJ+66x8B2pns/6xHCTENBXYsSo9jEF7aEu6QifSYP8q6d1UF3nWRDFf//RbVpEB/bL9S7Rjls/PykIMwLljCiyt4NoKEuAxRxY0UekwRdb9zIPtSxYI7gGa+EhmOgcTV/qUYrgPlEbkR8rUHhxhEf7RJCGdAl4eVKs9jdzPhUtc0yf2iYgB5MXPg++zIUodkNzO9zp/La7I8c74blesCBQF8THz997ZRxQQ3MREWd7dUt1+b+myeAUCVricavBkHoiZgw9Apq9pWQY3DQyXCebeH0K4iSE2+EQzrqWKsPsFzofnsVWU21n1LcnzKl4
X-Microsoft-Antispam-PRVS: <VI1PR04MB1327FD1FEE8D4B073A2DD59AF55B0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(25786009)(8676002)(478600001)(16526019)(47776003)(53936002)(106356001)(81156014)(2906002)(66066001)(186003)(6116002)(3846002)(386003)(6506007)(81166006)(105586002)(4326008)(8936002)(26005)(6512007)(316002)(7416002)(36756003)(86362001)(68736007)(97736004)(5660300001)(6666003)(2616005)(446003)(50466002)(7736002)(305945005)(50226002)(11346002)(51416003)(6486002)(16586007)(476003)(48376002)(486006)(956004)(76176011)(52116002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:A1B2x0PFhE77PyCLwHcrThOhyV2BsTE5QYWScBDzV?=
 =?us-ascii?Q?/w2QGi/1i6OqTC6SkEzKNJNTZCD2mK6BTOZPR+jwe8PislGLoiBUm5NMA8Il?=
 =?us-ascii?Q?SjlpCXehcRi5zjNzX3YS3EAX+FMOa8PoaNQCD1iups4Fl7PlkRCw3WII3KmT?=
 =?us-ascii?Q?qWzmnQxx4tb2aHJB2mRFpH9ls/RVic76Wq5ewuu7RmgPhX87EuHaLVzfAa6D?=
 =?us-ascii?Q?6XdydpGPXUsYLGOntN1smUbHUOZM59NMxIi03pSY9qUU5wHRbU3aGGUcJixO?=
 =?us-ascii?Q?3IFkomDNkhbDDSy5/82OkV8fwiAuAZbolaSM2EGrlZ/qiD9TEDLS4e09pqf6?=
 =?us-ascii?Q?q3YhIF6D3b1HLZPkjBomMEdro2F32mczfvJj0qaX5HYn0UJOhBVAIR5sl6Te?=
 =?us-ascii?Q?OiFo3Q3aoijWbul8B0C2UZXeurfKIV/NbDGh2I/5i0PPAnle2s/qgxpOoL31?=
 =?us-ascii?Q?PmREnoLHj3AzLIMcnULiosfqrGqV/M/MSjfMQeTJo6GYXOzweofCSXRI1LyX?=
 =?us-ascii?Q?YULloQaAfLazvOzOLfb310OLK3qKo873TJyqvoq7pgwWW+P2/8hJca08ck6+?=
 =?us-ascii?Q?0mS3hWvQDlHvWXSVWX2LQ9chHaEVFZDlSGjTZmKku/6ezud0jX2cQ/O3ouim?=
 =?us-ascii?Q?2iEzmea3s9G1Z60iflkjIqIRPMCEMC/9vOpkt9BeOfk60FQVcWywqH0bDtZp?=
 =?us-ascii?Q?WeJQQ4o4hvwb1LAP42xTc0GdQ0v3dndyQ/Iezfg3TaU9iiNmfG35jmkq59kj?=
 =?us-ascii?Q?7W/wTnWiY8yLZIHS9Pj0aoXXqJUg5tnQCn/1wv/0kqSjDtnvgULM6WpcxrKp?=
 =?us-ascii?Q?JMDFqtCYqm/UmTl8ucWVK7Y4niiJjNQq9wUax9t0RcdHimLKrhCb/O0wJuLE?=
 =?us-ascii?Q?v+ouq2oridECuLBK0uoCFgQztuRmAvtOIEsLWWnvCWpXOx0aT2ehyseI19pf?=
 =?us-ascii?Q?2RdLLKN4Po2BbXpO6OqmPxBUFIwBL1UGN3yEV3enUeKpoC0ZpUPIbHKIV0as?=
 =?us-ascii?Q?+/CnUh7QcmDlGOlkWH9+rkCjp3X0MMHhLsh8CL6q95hoCLCYMASJ4QNf7LfE?=
 =?us-ascii?Q?MJNAzYanK2BGxGz8oiOP5Wy5orY2V4vlky8Nq0MxPM1RxuXp9ep0jy+5rFut?=
 =?us-ascii?Q?vcS3+BHfuyaqCkl7QGyl18zPQQoMqq3e6CdxhSBj+w0wuX1SGzQvOWecZ5yw?=
 =?us-ascii?Q?SQCnCwh1S3z9t/lDCgOkNTMETDX6GHFm2s2PBpp1iyahviHqPL/ymi24A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 4c+1ExbyFfLSPH5KwXpW2neKnG+eOCzsD/W1FUbCVacEL6iO/Q+5Z0kGgcwyO7jjDMeTp77nKRzO6oP7KfUdHarz7ECHK7qBwiBqaKSE2vN1030AunQJa5X6DSD8TqVWlYRI3l0Y/gBVeeXFkvFhzRjqK2XCTpKxvQoVMr15LOBESwqGY+8NYpovPaR1iuvLHGt6sHdkEnm4qPSdtX+zwsWxz9Z4ILyPaw5qCkVfGlH47fQMaYXGZ0UZqfRo7WTAN1HFdu69IWlm3rqY57AAsuTt01Fj9uniXUbmzQGpTGCiXxynx/o9rt7AEGdYLcxfHZKb4ckyfuwlJvFxL0ks7oOqbXfEZhaYsEIITDZGhJw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:5H0qSfV0LNWMcrkJdc03DMarrYUpxFxveMjOkr1h6KlhL+U8FMj15d1vCprv35vI1bfyeJ9JtnpCTjSASi+UoCM6XIbk3dlwuvw/LIN5sS7PuvuAcdn0hKtWr0Ezf7BefbwmS2IJL+HxRbOqncgcWM43KTyaUV19KYM9mhdfVSgHiMsqDRfWJcyh1mjE5+OCq9X7TBqtA9JZ5Dkge6lB6WqUUQGziS/AyStuYheRYFTE3NTJkIsMFsOGYpnphVA+20yQdsA4DfkIZeKaUgK/TI2C4M37aLWf4jTCBbpWpsybb+tmxfetKVrj54+7cr/wz34lsoiAeRuq+VyrytVqSbDqxmgeqGwLOFKsoF08iI484ZEs8T7cGjXF46rnhv4iU3FOKJiJhq6jAZ71EKBPCAuYR1BHGGkTe4no4Ev0lLk1lHSdz8+AN/dZ8VOv0pqPIuQlv/4y9d7GbleUNuR4Lw==;5:hIf9s1MPLp5MkAtfxWT0JWY9lWZbjnA2qRsZ7VvZMfrnYtdPDAYWRAQYozZWPfm8j9TZdwZ9EWggpd+kgYXKZqM9jRRrxh+R2W2Oc5h/gLb/2FLBJo29iUrNz8n2xeKax/4w3ITDOVW1MICNQJbDfDkt3Wlp9P7sR1UoNUnW1iA=;24:A+qJnYD69aPyBZ0CyRR7qm5ir7fMCmlairWGYRvyd3jPi2ACj/PE/2wZBSd2ESSBtnKyvdCYJo4I8Vl6fIL+kVaG6bww5fYnR8mDWywY7IM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:1PCDQVn/Ag9VR2O0ftkaOGcSCwnGmhIMreYJfmRwVFLkPgu91v1nWZxcU+tQgKZWpShdW5ZQajZz3QW2FFTrjG/sRe43YMBTAp4ks4/d5PBJwjWz1zNuo3S7lYaEHVEZrJ5iLF7GvHM9OXB6V/gEO0GvolSCb3iTcCtFOEFiH4hVaet1NAQP2fiRZUOb6cdwFUBFd69q2gLY1V/iufUPzOrcmCvij5nntL1erG49sJjYOvYyDibueZxXyAgkRJeS
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:44:17.5625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c96a9e-9bbb-4ba2-b126-08d5e641550b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX has a 16KB always-on ocram bank called
ocram_s, enable it as another mmio sram.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 596763c..9923739 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -172,6 +172,12 @@
 			clocks = <&clks IMX6SX_CLK_OCRAM>;
 		};
 
+		ocram_s: sram@8f8000 {
+			compatible = "mmio-sram";
+			reg = <0x008f8000 0x4000>;
+			clocks = <&clks IMX6SX_CLK_OCRAM_S>;
+		};
+
 		L2: l2-cache@a02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a02000 0x1000>;
-- 
2.7.4

