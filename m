Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0BC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C64E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eZZS9Ykb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C64E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeINN4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:56:33 -0400
Received: from mail-db5eur01on0073.outbound.protection.outlook.com ([104.47.2.73]:12192
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbeINN4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA1X3+VxDYs7Py/R/JQOfzEny03QgPe8W9xX/Tm8XH4=;
 b=eZZS9YkbEWgPUJewaONwZ6/iJha4S08ZxRrcjAXwMz/woSHfVm17ByjfB0m670otxh50301f35mUUDovLAZ4iG8LQpvah+VUmxdvTOI4X8SYGbqpl8ybqzGwcquAdiIKT1uMSt1sDyEugBKjFm9xKcZnFTGKsVHXHbjTOEWERNU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:53::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.19; Fri, 14 Sep 2018 08:42:54 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2 0/5] arm64: dts: NXP: add basic dts file for LX2160A SoC
Date:   Fri, 14 Sep 2018 02:07:50 +0530
Message-Id: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::23) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4484d0c0-e6db-4454-0472-08d61a1e131b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4800;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;3:fgQN8MIT+JkzVzjDF7bNN8lRQwNlTikxdg6qtlgk/1Bp4MBQ/ZVZ8qVp3MELaePe2mnh+l1nIqOZo4gTWBWhXKa3XusogFjnxwS4s5MlVi0FcWrJgiilkgS2ccVFw/A0tp3R069gKAKNL8THlk1TCdCT+wqsiVfIhXsLRz0dJGl9IdoGnesFniyDaXWYhIDm7sGDYmTrTQCLPBNyyMdzM9TC8532HkHZKEaKxeQa50+lj0hQsaUHch1pBx4cJ84K;25:pzLmy1zjso/HZmH7Bohry9Ka0MI22410yMZeJAoxnFszBYuBtzz1PeeHcWPRZTM66wgy08IeKmx8N8bm/xmWD5+CZAi9SqGHYo5NPl2beFd+3dw7ERaeI9TV+t25w0OQ1sDCPnDzRsut5v52+woIRY1ugaD3F6iYquY4PuhkQGMDdXzIx2qx99tz9H8oiRzfLJeouyOAOfNzFdTw/Pl9fl/hvTPFIimNlAYEEdmQbMVe5ZdkO+zcZnolFX6YdR8Abky934pT7kl9LVPEFo2AtwW4M01l1TcZjARfcTr60tK9sxmfQfFQ54FVvM0bHuNZcMmAyoxhORpcVLnnJc6rFQ==;31:U89XNtBj3Y3Eu6e+W1F/4UiOeYfQxAswEZCyBS0aDQ4FOFqVAnVsg0rg1qLbMSLy5uKHxsVnDD1cu8Q5NNHs3LX1fptxB612KUoj3Q+XNDaenxgV/nErPjH/V9UAtt0FYklDvyT9vm5LqqH4OrPc2GUFYYRXjPkbXoA7sAXxn3c/uuveyKbMQ0fpK/prNUF4N943K9cuT8ZOO7oP1lioP3/WcZZlAvQIhy3plmWBlNg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4800:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;20:1wKDICuBEBMOXXFrZmOhHH0bHTpbWLGR1y6dnbPbBAXMGA1UgQutHdQHR2NiiYmoPHUpOz7LK2eRq7btsp6ki+vbxbVrbTSH8jc9CoPHtj+KX6ElR3lvo4B/WQWBJ8PH/dPRWGiOtOVrtXyyJuvtjXVmABJS52nfSn0ERbTE7zX+/7FodzIsfBf7C+N7QAJ9Zmj7lHlcpTyyV9DeBsBTB9dFCln/L5NL/Qn7iYCBBbtv2dap6WxDMnKanwt/c+3H7G9n/COdzGXpZ6g8LwbB6ZTdVRCm5KwhJspUayJ0bz7xP9//k2aWEnWaCNH5p9iLZ0ecJXLrK0fdR8ZR6dMdbl/f9u9Zfmmh2fIkl/BL//NjLDWy+lJFDCjVb4MLtf86cnNlM4DPOzQbA2wSSWHtiH3V59ExVF91Kmwy5y6vE8EPTB7LanIegc75UeL99JySBhn57OS6O6dmypXWlRqRTsOtCfM0aKx4qex/AgfkFv1MoiTTsOyKXLk+Jh4HSsdo;4:KzeUBozaR/IbM9uQy5LbNHr1DS42Fd/z15VxNNDg/rCJ4y0OwpxWuiF2CgKWZXx6M0n+po6HRPRTw8jW9Zqa4pm550kV4oTWAzwc0ftY21iIKExklNqY/RcrezkRJZtRv1DeyZ4JDgyHa4WavGPbkoTM4F6+c21LzW72iiYvQtmDltlQh3Alf3CGH/q19Lp3xxQ+PoUJdlkZA++NXwaN2aoo5k7QboiFudKAXYLTSICxmQzIhz1066OPwFEcVfAl1lWV8Brpz9YEz7ZG36HTUw==
X-Microsoft-Antispam-PRVS: <VI1PR04MB4800FF8479A38E59C6B701EBF3190@VI1PR04MB4800.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR04MB4800;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4800;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(2870700001)(7416002)(305945005)(7736002)(2906002)(4326008)(25786009)(36756003)(14444005)(68736007)(52116002)(23676004)(478600001)(47776003)(81156014)(81166006)(8936002)(6506007)(386003)(55236004)(6486002)(50226002)(5009440100003)(86362001)(66066001)(6512007)(16526019)(105586002)(2616005)(956004)(186003)(486006)(476003)(6666003)(44832011)(8676002)(316002)(6116002)(3846002)(53936002)(106356001)(26005)(50466002)(97736004)(5660300001)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4800;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0ODAwOzIzOlNhR2gxN3g2dDRYMU5Kb1V0VEpoNUQxNUJH?=
 =?utf-8?B?SjRFejBXVTJNS0paT25rdGx5cjgxYVBHT25ZVUdBSXlCL1JDVkF6UllyZWtI?=
 =?utf-8?B?ZG9NQ2JyRTUza3VYUlpYNU5KSUhIS0dnQjUxdjQvZ2VYeWUxelZNclpDVHFt?=
 =?utf-8?B?aWx3djMxc281N0MwS3dIQWNPdmEwMGwzWUd4RzdRSGR1eVN5cXZxLzFiVGx3?=
 =?utf-8?B?c2IzaGF0TzlIbXdIYkxxbVBCQnFDTnlScDFyMU9XYUc4QWk1VlJVUVE1WDQ0?=
 =?utf-8?B?ZlhjeEV2eW5tc0RlQ1V5UnBJdmdnUjRzb3czUlVoMEw1Q3dpQU9CKzBPa2VH?=
 =?utf-8?B?NHBuQUZzbytCeW1VdHJTYXFvWlRNbzBiS1NDU1VWY285Y1FJOTBFSEdtd3Ny?=
 =?utf-8?B?NXdNdnhkUlVQR0F6YnR0VmV6RUFhanNLYzJydkUreUxJbzljclkvakI1QTdH?=
 =?utf-8?B?SXpXMVk3RjJGMEpBQUNraEVPaEVmT3locmo1ZFltcXFUODFWM3MvdTdEcVll?=
 =?utf-8?B?R2Z5RVpWOUdQUDNpN1ZmQ3lNY1d2dnJpNUtnQlJoUTdwME1UbVJJNzZhdFk3?=
 =?utf-8?B?aDNUdFd2eGxlMVZ4RkxrVWg0TGIwelZKUG1aS1cvRlNFWVpRKzBQWGVnRFpQ?=
 =?utf-8?B?WTc4bzFJVlVJVXV5b3VpRFZIZ2RHQkRMK2tQYWJyM3JrdTNmRkozQXcwT04x?=
 =?utf-8?B?YU5xTEFwSVhrYVdkTFYrRlZDbm9UUmcvb1U0Mmh0ZUlNRldCTkttTWorNFZJ?=
 =?utf-8?B?VVorcFpzbEJINFVGc05FQ2Z4ZHNBTkJmYWJzK1dVbWZJOHlNQmYrdmtJeUUr?=
 =?utf-8?B?emZ6TENiZnZHdHoxQnlXQVQrM3B2TEZrbjBHVnoxbVlzOFlabTF6WXIyUCsz?=
 =?utf-8?B?OERNa1RXOENadmRNeXVvSUUySURDTVVmREd3STMvZ3lCbS8vTjhKUmdLQlZQ?=
 =?utf-8?B?QkZOaHRvWHQva2p3NytwaDNqYlBsYnBWSXNLYkl4YmVYbndxM3B5K2ZZemoz?=
 =?utf-8?B?M0UwVDI2Q1FDQURibjJtdS83SFpJeE8wOEI5cUdFUHl5R3ZNbS9iYVUvU0tn?=
 =?utf-8?B?eU0rNUFQdHQ0cHhEcDFrbjl1M29CQ2gySSsyR0ZvbDltbThkSG9YUEVvSXVV?=
 =?utf-8?B?VmlsYzZKMHFWSGt6Nk13OG5vUFZ3cDZxa1NNWVRDMzhBandOOEFYbDV0MzF4?=
 =?utf-8?B?TnlpNHNueVBaMnJrNzk3eUZvRER5b3FjUUg0L1hqODNRSzQxSENLbnN6WDAr?=
 =?utf-8?B?OTJCTlVpTlAyVXAxZmY3TzVmSFFQYXY4Y1BMcktwSk1VQ2RrRmxJRG0zN3Vl?=
 =?utf-8?B?T0R3bElTeXVFVk5hUnBPRzVqTkNxSkZpOUhZUWpRWEhsU0Q4RVJoeUVncG9E?=
 =?utf-8?B?Vlg4Mjd3U2VMOUhJS1NIZVNySHpldi9BUWM3NERNeG5pdjY4cHBmdkxjTlN2?=
 =?utf-8?B?YWZRaDR2R3NsdVF3V0w1MDc4djI5dklCdzdMZDlFMUJWemEwYlF1c2Q1MzdK?=
 =?utf-8?B?dkZ2R0xuTFV2aGtrUm9DSVNnZFZnU3ptSmZUNU1QOWZNRFArdEtsUjIwTzJo?=
 =?utf-8?B?aFNhdnp6RDZqdW1yczZSbm1oSVRPWE1DSDZ5NFNKU1lVbWpvYmtMNXFmbVN6?=
 =?utf-8?B?eGdOK0NSV2h5bEJoMWRvNVJqY1Fuc2lrT1VUK1dMNVlubzRQYlNsc3NXNjVD?=
 =?utf-8?Q?SR2OC01vdLGM42Y+uI=3D?=
X-Microsoft-Antispam-Message-Info: l6a68q1Va661PNn4zbTXcIp6aH69AchF5OPGmEpclJMJ4dq3d5wqo3dOcM1xNmSsgrX5YWr2xme1fPDC4ZzTs36a7PAee4XBla/PSCJZn6i+++Q/qtW5NZ7aLyfZTRTf0WQXEfl2GV4K0jnBvEypG/a7gFsItlDSofWLR2eHWtayqzhQDjt+OuhU8KTiBFLOOWyLWhPttRAtvyC9r4fm7pUOt5ia7Q/jr6GnRN3jlepoMnvdVpQdbVOr481Mwa9caSe6zhR8/hgsEZFoxaJlFeUqVnM/zqYyp7Lv61HosJgKildkGtHkAO5zfp3vuqeJA2AzG+F1Qhce6e22XMcGj7O9HxHUTFXvc6OHXk/mdKE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;6:WjAg8tZ7DbPpi4l2cr2CQs+vhKl0NZC2VD/TWaTp8ZKodvqri60mE7cJO+Bu+BbegB8PndjRQhSAxOkVn3cdXCjMG9Z+b7moTbje2QPed+FmwuIt8vCpFacaGWGLgeOrRwyMYid0S6JXw1T02173jf4e1/czVCJ0yDOp0ua09Du5xtEiugd1UFx0m+IKTEV2IJOfDapYas8CNIPsODN+jjWvU6b4f7LVwy9jxuwWqrORjejKkudi9AkV5w9xI38uHnfNHKHBmmsVV7Nopfqy5LVbFbrIUuhdGcd/WXKZmvi6mZACS0DndfhK483EgeJEqa21vbid9aJhRGO624xMkANeVi3MmJySirlscytELwout98DnkJN016gDNSp8SKWnhG3kQ2qnw7wfCR+iV9++0I/f3mrwXOk4Mq1RTHcxICc4FJ2uhlL0GvH2+V/o3aUpdKbL/rsv1S7tAX3lC+7qw==;5:bjYw8iwW6qfLXYch2rkdWVEQ/ZRP3Qbm7AYmLWb+6QrEyHzu2bbCYaqvO0c4bBRVfYmPoUio94PI7KiPNx/2jSBuHGYabsg49hJNzLiy09+EXq/zvz8xeAtgm2oGF7GEVhYe2HGZ++Qi2bF8g8KGxcdH957/Kyx6f5vNYAh6x+k=;7:X2YdkO/QDUoHKHzUIOe3CLdjye9tJ3SjWUG5kJG6Xj7mzQTHs+RzyxMx7HLrDpQ6kKK+uvTFyba8ciP2bMh66B1ROhpuYfAh5oV3rQj9Xc5b8jrTwfuiRmZ8YcT6aaueEI8/HaR80uAl+WamtFn3QFkblDRSeApGkLRXrSFi1Z1eAyyRWhwTTzZdVtallKfUAr2f3phqwo/tVMhg5sRP6xcGv/v7pt4+0ijAB2oyO4KI6jlMjnGcllZnfhuZIx8n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 08:42:54.6710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4484d0c0-e6db-4454-0472-08d61a1e131b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes for v2:
- Modified cmux_to_group array to include -1 terminator
- Revert NUM_CMUX to original value 8 from 16
- Remove “As LX2160A is 16 core, so modified value for NUM_CMUX”
  in patch "[PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
  lx2160a" description
- Populated cache properties for L1 and L2 cache in lx2160a device-tree.
- Removed reboot node from lx2160a device-tree as PSCI is implemented.
- Removed incorrect comment for timer node interrupt property in
  lx2160a device-tree.
- Modified pmu node compatible property from "arm,armv8-pmuv3" to
  "arm,cortex-a72-pmu" in lx2160a device-tree
- Non-standard aliases removed in lx2160a rdb board device-tree
- Updated i2c child nodes to generic name in lx2160a rdb device-tree.

Changes for v1:
- Add compatible string for LX2160A clockgen support
- Add compatible string to initialize LX2160A guts driver
- Add compatible string for LX2160A support in dt-bindings
- Add dts file to enable support for LX2160A SoC and LX2160A RDB
  (Reference design board)

Vabhav Sharma (4):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add compatible string for LX2160A
  arm64: dts: add QorIQ LX2160A SoC support
  arm64: dts: add LX2160ARDB board support

Yogesh Gaur (1):
  drivers: clk-qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt     |  12 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  88 +++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 693 ++++++++++++++++++++++
 drivers/clk/clk-qoriq.c                           |  14 +-
 drivers/cpufreq/qoriq-cpufreq.c                   |   1 +
 drivers/soc/fsl/guts.c                            |   1 +
 7 files changed, 809 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4

