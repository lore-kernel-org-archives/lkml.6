Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9D8208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qosRfu+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9D8208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeFTI3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:29:22 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:37599
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754296AbeFTI3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iG89LbwCrg6cmzFnZ4K8pMtuPLlN+awcrnXh66yqQo=;
 b=qosRfu+Bz03m9xItUe7wy5CCkb6Y7bdIwlUEm5BIB7tSyeYAGImEdI/S9zRwa8wUrUAs4vrZUrr/rLKhePqF4zVqnQ9rdwFrl0kB4yetorHn4MHU28oCbUlK9+FjRxLGCdqSiLJv2jmK/BQ07BxPPNzmW8bLusQh3b8AHHqCBxU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1610.eurprd04.prod.outlook.com (2a01:111:e400:59a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 07:24:47 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 1/3] dt-bindings: add binding for i.MX8MQ IOMUXC
Date:   Wed, 20 Jun 2018 10:24:21 +0300
Message-Id: <1529479463-26961-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529479463-26961-1-git-send-email-abel.vesa@nxp.com>
References: <1529479463-26961-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0701CA0001.eurprd07.prod.outlook.com
 (2603:10a6:203:51::11) To HE1PR04MB1610.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cf4c933-d6f7-4c8f-06a4-08d5d67ee7af
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1610;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;3:siCub8SvjlVCYZf5a7I8bgUnn1JTpUlHO8NgxfO5FBIqDAa1fE7C6/NrNPw9sAi9s1e3k1JC0EgGRQoc5SszgS4l08nLM2bZzjdNHWKW+LRJ0FfqbQq5Pf6BSYYqRtfHcwXRW3z1WDKzwpxpeBl2XZSRZcS6u0HeuQxRJv0oVTXspb71pn2aEmjMl5NMyK3cb4tAopH7KbmzNj1NK3KNTwpvLOenYKOWhyRy7P1ydZoGaKEpypBT46GiWYP89q0M;25:qGZQCi8ceaNcPRQhk4hP/khTMbNfV81Tn5ImYHKwPWmxR6w0mk26BNfC+YzjcfVBtOpXMwXj3ndjYdtt9QSxxVdlXAtK0RPHPpWnIN2Vj9Hx/oZfB+KwT1IKuC77RqRZotFanUzeRqYxZqaKlp7Qi06XkEk76zbHYD9NBRtAT95lRdi3gWyQRUHbRKNv8iEaRidakTDMBO5SHr8+sSd8WtN8dOK9X3dTkczqYzqMB+ix19kLd5dr7hemQRcYLZ+VyFAXuZmaZtolx5HtpXq/NeB5bHEBsTQ8yNtkv088wIrTnW5rHl3wZpT1gEI7z8KM0Wz68qX5MRNkxJ7JgoK3VQ==;31:wxv2Y/2O83jvwjhYH5fCl1ZU7eAhQZF00zsD65uxxsw5zwf5ltfJ6iFNy62te1xEkja0SHQnIevjlL9B99lby/7wEnY7vxUuHH8NggdIKHOg2ohOFvpX4fAb780T/4DdU5yV/kfn/NByXH4swF+xGERlmJbTfqIDqQWhfWzCno5fbl0HEOdB2hplQxPn9p320RNoOd4xJt4GL89XILNtSXvPLt6DDUvYTXJw2A+cTQU=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1610:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;20:QS8EdT1vfDQbAvRYGW8DCnTxsKNA8yOF3EoicSt0o95rVVMwIUVeUvAJtVmUJUppO91fSQCY6J3NiI5wjtBcBwVu9TqOzqtOB/By6WUK+m97fojkuGZSaDsKigEY1wtTrxjqMkGCTAZwiVJneCk64KwHEMnG/2IiQDqYYq4umGLqRECCMcRL7LrOPPICJYz9hB5GklHm3kAhdMbcMR6+/PMSfOZ5IzbEbLYig3BpnndDrzIJ3FdFF5LTDq5Qjc1PqLZDCnVjkpgzqfozH+mPrBnKungKfRa6vu6hZrvvY9q3FvL2LHlNR3Q+CCsCN/qsfuLFoscmrurYg5iAVBBp7LLzVgLVh/3nxd1TUIk59E5IV+zr0woZ9VYCR79jTwbNNet4qtdk7/3FY2BkpMDr6sBW5cvwM+yqgT/oMOHLVzMs0gSrf3thCdhG1AF8Pemftfx1w8Cn0Snz8JmiUiW2iGElmlYLdSj+78WF/zjBZ3Xte7qF6JQgq8SVEj1dkGic;4:V3LNIQ9R8J4VcLdags/xft80rMImL+AUrz9RNw+x0xqt28OniiijU3ActzEFBblJDW0pLibWyOMXlBUmAU3lBpCFtVVFxUOsBBMi2NyMpO4lHz5fkZIoxiilU6Jycpzu5jMIYWA/0QcCms7CsDAYS+LKpXwOVnrMCgAOju4vOPfrB/wB+Dk8azXZ/+4YwxQNirglqG+mNh+AYJLxCxO13lLEHYYTJJxGFo3Z7tbEwKHinSZfInR3HUBR73mzy5DKxj3SOAXa6/dLTf12ogYJcg9BbX/Ip8KjHFa3659Zopt4LgX2lWrsffsCy9h3O2aa
X-Microsoft-Antispam-PRVS: <HE1PR04MB1610595763BDD4FC4A490FB0F6770@HE1PR04MB1610.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1610;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1610;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(39380400002)(189003)(199004)(47776003)(66066001)(54906003)(16586007)(81166006)(76176011)(3846002)(6116002)(110136005)(6486002)(8676002)(81156014)(50466002)(51416003)(48376002)(476003)(305945005)(2616005)(44832011)(446003)(11346002)(956004)(7736002)(52116002)(5660300001)(486006)(7416002)(97736004)(6512007)(6666003)(6636002)(50226002)(186003)(16526019)(316002)(8936002)(2906002)(53936002)(36756003)(478600001)(26005)(105586002)(25786009)(106356001)(86362001)(386003)(4326008)(68736007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1610;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1610;23:ow/vceKMyO/x0yjVO4RDOhhNvzIHM+DU/tGu6IozS?=
 =?us-ascii?Q?lNQgGUJUsHiT31cOsPP1na5EiS203kSOK9wGpKmbWaW+saSRu1PAVdRfrC0Q?=
 =?us-ascii?Q?SyOeE09y0LsNODInhfUllP5zRWrOTodO2nTCgTgHDHNQdJwvxJMfGgH6jeS3?=
 =?us-ascii?Q?ZGTxSX8XOph1wTd++WPvyEymuyeipSToZG7FliSRrAsW+ee0lXJgUBbmVkg4?=
 =?us-ascii?Q?wco6mQ6SnZetu6x1obx/PSC/hXkRUhN6YHovTSsVEp+IPSIvSsxOzIqkLtgr?=
 =?us-ascii?Q?pCs1ASYx/1UEOIXi6o0vLn9JoOlvWSthpcpBwaD91MKEQVPCnKS6i/NP32xC?=
 =?us-ascii?Q?e00zSN1jjK6MnBnBo1Mouul1U0t7yjir1+MXPHcTjKBtnnFu94R0j3Pl8iCp?=
 =?us-ascii?Q?EuAVLAE1STTKkRjl9QzWHS0JjTJrqEQRaCcSqYpAbQYiGZsgGa92g9NqY+es?=
 =?us-ascii?Q?Lf/fLlk/v9K1XuEzLngCcYEiMHF/KYiJVUvqxQWVHuSp6rTBP/XJj+YEg0Qn?=
 =?us-ascii?Q?J/7NdexArX/YXh175YJveOubBPMAy6iOHHr+2obchbwTcWSBD1ZVMfKPoBB5?=
 =?us-ascii?Q?TKb8ELC1BM4sSfZ3lItjPGHuB4XEkLdOfiI8NI2QXjRtHc11BY88lUORG+Fy?=
 =?us-ascii?Q?qoKEKAtMsqxNMdRz6vkbQhcecGNiB3f9XafS9Tvw+wN3/ITLHsux7+Cl/bFa?=
 =?us-ascii?Q?WxShGtfA/GNm7l3EUhW8p8xoARy2O9u0zVngCMR9Pak0mEvjCazhESWvkYE4?=
 =?us-ascii?Q?P0uMY737ACngeO6c0zwEFTjxm2UTLl08mwoTZNbcpoZO6hKfwhaurc0mRJx/?=
 =?us-ascii?Q?2lI/KDn1nq2prEeszC4GpGR9oWJ3+5mZjnTNC7pE7eE0O68LgaH4FT1hClVm?=
 =?us-ascii?Q?eKzNiIPEFseIBJTHQ3DwnHk312ZPYPZKmdaoPxNgXR2SGWmH5GRxn4D2Kq/p?=
 =?us-ascii?Q?EL+aekq4uEEX36URB/aYmfF+68qUvuJ3/y+TA3Q9ZlphdZVikzseP5llQIIn?=
 =?us-ascii?Q?cMD5eEXw/9kJxUOXn8JvHbCpyYvT7Hvd1QpNpvq58TwzAfhefS204Q/A6hrx?=
 =?us-ascii?Q?VyExvvzJI6Uzxl89lmAOE+Nmn9hwsnAV3G+oTszpSOkF4BIr2CDEUeA+cYFN?=
 =?us-ascii?Q?iRnkWP9JF7bKoYN+vvAYpyoFd2lIPzHif2EwfWGaHqxF5Inh1cOMZiANlUE0?=
 =?us-ascii?Q?OKalO7aAr2zx26wcUbXP2aLyMDLp4EYIRviytrmg1Jvm4YULDffG0VpmKmEh?=
 =?us-ascii?Q?Mjzz85KQOR55pJE0Ot8YeH/N8rEtJjMM06KThgy?=
X-Microsoft-Antispam-Message-Info: dqJyo4Hd+L65WDO2wXH3Gi6Zol0A4ss/3lbhczPAngrFUTIvpPZzXK74UpBQFE4tDGxUx46WfU/ARscHPGd9dO40jsYpEbhueCWZHn8+vmNv1qPMx7fEm0wHDXEvy1vg5zfBkvbF8Pyb6QxSeliJoHtS6OHNOVBMut9aeDdchSOxlP2Cfz0xw/4IF4f9c2sMB/N9y74rUXy9T3IwF1UgUB12DGNYOZZPMx06cxJt1KN/FJmgFNNllyTanxOVBz85UdEN13JapSXKOt5ICBCO987Dm/B60vLKNQ7JHssMi2com0ZRH/Fq+4LSjcBATpgB
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;6:fIYS9nAWnVVVFpN2icuNmPtA6YHUiQwNvBXNm+PV+9QYh4zP0S/Np5z1o6zS7cfIXWqYQtAdPL1JOgJdFP07CKCTfzCKL/WIkDsgAZWH1IvnRPkUVXfaUxajzOCKiokfrXfobeMuw6vINwccC0wcnzoDcGVgwDqUx5KjWEZJicnFO179O+kOaB/oELlAXd3VZqLSz+wZThnOYW0hsylGFFBnQlVx8ANACdhiR1VYVAAxMB/p14KUKlSdxB/LoNR3rFWBdK3V3wi77ROEbPF+P5v0e2dbft/OrN5CK7HZJxiuR8faV/Rw8u+yTZBsVEzrt4GktlDfM/YqDXKhD1/yez6/yVIhrsbWCFtydeu+Ld2uI5EXVTcC+Sm42GSCIK6T4646DRSxDhBHhGmrVB1RvkjVNXCRqVRAo+vYk1HMMt56Ptd0h0Jl+w3E0vmU5wqbti7eca61EWjUAPkn5EODCA==;5:Z5dLFS9zmSUjtggX52Rc3rBX0evVnYmLNPosiI1PkqwLn/4VdihoP5Og/DfaGYougGQ88K/jE3XAxc4BCWx1RgJSgPSvK3gO2ixurs+UxXOeqHQvP6X8BE017gLEnQ7AicZDNm9lA/NzVXc2/GdUlYF33Bpx5xNpnqTjNzL3fHc=;24:FrggNgiPRIOALogNlpES640WEo1UKQ95ysL78/xbd6NGiq+0gYdmwANbIcDL9IPnvVs2P3INBa54LkTOAdIsfPa85q/ODku3s1UNevCx4+A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;7:uxR0Z/NM0ROCg1buJeO7vclhtjHW8rc5GkFjCjXgJ/xp7Guc8bP66umHIoXblscLoO9UrdJJGxlVfaw5WAPSWoum48tn/a/qA57XjBLvnmKasgEtfV69w9tbP8olhS/9DRBG8Dc+qKa53yHhvp9jv+nzN7ywtbQoL1WhiO2LS92h+9aLUWiPhIMn00vfUX9liQXpVwR7X656iKRl4BhHq1d8rnsBKk8btAj/WUv1V9Ol2syyrHaDmZmJqtOtuDw5
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 07:24:47.3073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf4c933-d6f7-4c8f-06a4-08d5d67ee7af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the binding for the i.MX8MQ pin controller, in the same
fashion as earlier i.MX SoCs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt      | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
new file mode 100644
index 0000000..5cf7f8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
@@ -0,0 +1,13 @@
+* Freescale IMX8MQ IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+for common binding part and usage.
+
+Required properties:
+- compatible: "fsl,imx8mq-iomuxc"
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx8mq-pinfunc.h under device tree source folder.  The last integer CONFIG is
+  the pad setting value like pull-up on this pin.  Please refer to i.MX8M Quad
+  Reference Manual for detailed CONFIG settings.
-- 
2.7.4

