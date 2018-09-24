Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A848208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PgYMt0+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A848208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeIXSQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:16:08 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:6240
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729178AbeIXSQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCzl5fvjjOIEa2HAC9qENPocEt+jy5YPOXjyVGaaQdw=;
 b=PgYMt0+W3CK9bQpzeHjFPtCJQZFaRm4uC7Z1/riz+zrWvGWoHeQfOUScC/tR8Q2sz1LvrvGSs4v1llSN713n7C0JuIv0P27tgmFFjm7iFw1WMl6O3bYSmwcJanoNGZSX59rJUw3ZpONx24LjTPTcenrNoy2HxuxAb2gipm75GkE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (2603:10a6:803:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:14:08 +0000
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
Subject: [PATCH v3 0/6]  arm64: dts: NXP: add basic dts file for LX2160A SoC
Date:   Mon, 24 Sep 2018 05:38:55 +0530
Message-Id: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To VI1PR04MB4798.eurprd04.prod.outlook.com
 (2603:10a6:803:53::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e12778c-e0e9-4ad2-aadd-08d622173d37
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;3:ZMGB9q44YtzSLTKH4sIBIYC3jwC9ntk0UBl3jT4r5u2avzFnKzvrdqSNV+EqMRs7K9fQXrkEqPmAKOgiVYQp3Ttynb505ztJMMtnGSIQGxYjiGnluR6x+hzV0dx22LbU05nKvlAw7oQ+MMhGjEXKO2q7qFGKY+RIAtp30iWlHKd15yYlBAl/QLmOxeicowajDxjBrSEjlTyn3HusSBjKAg2v5cHwZTeWuspq1F2qwkXVEcKaKpFFFjBGpWJZ6DFf;25:iPFt6U7M50J1lFoUkKhNRd0QI8Y54kSS6U/DdzhcPHRPRqTJ3E567kvCZYUWIvv9o4yuz9PBlSbhQSh2PpHhWUr/8ju+QnZt9WqMQzNprMQrUtS+XQ5yzyi1Ur9hJybBPo3Y2RGmT30gTCeQBQIqS44fYU4pYRxWHhcihd/Xzh08wlv8FXJFBYonJw2o1d1TFhP7FdtBdimyZzuYCT4wdARaORWKwcveAKKI0Cru/g0knshKmdU7pD/otHwOYNplSND7Eh86SslK9wL0ZVAoN4BymJ933itlxG2JrWb7tg15XKloAqjuMcQSM+b9hmsrWw8uT2wCx97ppIwBW5nasQ==;31:CzDxtT6rGv7qNiQbDlzYm1cvKxeHgstae/q/Dhaa+vobjXbeoNTCC/qSW50zFrpO7pIUBa4Y4fjCUq7sFfqtzhjJgf59/157x/oSBfl2rP/dGVj+U2gH+08FedmkL74XDj+PxBz1esp0KJ6pvMvDrQPbNXMw5JLZGYvXQtishe9776YckH2mxnVESE8XxWjRxq1lffHWpTlXkX9WqI2ZUGb0XAhMR46w2yIWRKfiPrI=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4798:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;20:MtAAIdf4/f5VeZ8Q6U7XxpOq+No7Vb7Y69yqY2slfnK0hM7HUEpE/dsEvs85rt5fbFLVK6Qn/lNVvja41jd8ax2qrGpTWg+7hkzhMKbrnQOW8iMCeNmrHfj8pSgClbKfTxJ1T0lWf1cBgMM3TZUqUT+hxfg17x7blUh5mQyugTBHPjt2smWxol12G9sBCZN7cJPYNoFVqyj+Gv5fVX64+3z+koUJXhrOwzptEvUW0v1LrQuA7enn6wWYOWlco3pR7jdLYMip6st36dMjfwcIzmZQCyY7GUjTFk41PdDjh4VHD+mNsCsm9t6UIhrpostQxVCd38itDKFZuf0hFt8ttOgKMJZxeFWTGVq1aQ3w7niOIT8v7dba5GS4+QbXZWgw34CIPfjT2FzEOhd3mgan+HFktVDYhDHlzbPH6oRPYtZlDMYJGbypIa5XDlfg5p+3Nz2vPjtaiC24L5tcgz/Yqhlt8xOoHw7AUWHcJwiatcCfAQ08gfSHVEjSONIC3u56;4:azPSfx1WqubUMBDOrvKr9NYEvRe2ZNrIkoCdUo9c9V0Ga9tdcYB9B1LCTVM7QH7sFfq1bGDBNU2WG4hMijlRMTuRwO/S+5b3MBMEm32Zvi/V+8fLi/VqHG7HWa3d0+3NC4rgU6tKV+RnlTMzde5XAQ55q//PEy0J/bcq45Q/1MN8wb/Az3V9xVLFZ2c04XM5miQdVUW4Bm0L4xFcqvyl6EuWeKkfTkA89RqiJtUdKT11GhrTGUs82iwk4mZOg916D3YistA2saZw5h10PYqDFQ==
X-Microsoft-Antispam-PRVS: <VI1PR04MB47986BF3CA9A9F3688698DC9F3170@VI1PR04MB4798.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(97736004)(5660300001)(6512007)(23676004)(6506007)(86362001)(47776003)(53936002)(386003)(2870700001)(6666003)(25786009)(52116002)(956004)(50466002)(186003)(7736002)(81166006)(7416002)(486006)(36756003)(50226002)(6116002)(44832011)(68736007)(5009440100003)(26005)(305945005)(16526019)(2906002)(66066001)(478600001)(106356001)(81156014)(105586002)(8936002)(2616005)(316002)(3846002)(476003)(8676002)(6486002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0Nzk4OzIzOktmMUJHUENiS1cyeWNkMDlSNHVjc2hIREhK?=
 =?utf-8?B?M3Y1OUxOam9EVlpLcW56bnpxa01NWUZpZFFHckh3blJhMTRpRkYwclExNnJq?=
 =?utf-8?B?RDBHdnI1REpoTy9peWwybjBWQTZSaW9mTlZ4dlhxdEVaWXB1VEpHY1pVa1pY?=
 =?utf-8?B?Z3JqUnZCOFBaQit5Wkp2VHFrV2QyeTR0ZTA1T2IyNStIaHBXK3R1aDlFVGNQ?=
 =?utf-8?B?cUVyMUtKQTZralVvMTBtb1NSOHhwd2hCbllrQXhOVEtLWGdNeWM0WmsrcVhi?=
 =?utf-8?B?NUZLV3ZNUS9RWHB5UXg5a0F3a3ErMFYwVUxTbUxCcmJzdWhjRk5qVEJMcXZQ?=
 =?utf-8?B?WU02YXlReExZMUVDQ0UyaDVneTlZcmxyYlQxYkpoVHY0dEJZdEJaeno4a2lk?=
 =?utf-8?B?bnZPbXV2c2ZsZ2xrWVZMSVRQOEREd0F2RzlKbG1ZN0w3UE5EemxuNS92TG9Y?=
 =?utf-8?B?MER0aHJ0R2JidXY5YStZbzFXa0hvU1NzdWlWdGJRWEs2cWFCSU81d0Q2cjEz?=
 =?utf-8?B?MGJlaUtpWEsydXZNWDhFYVl6R0pVMXRMVUZ1S0NxMkVtM1k4Nll3QnNSNXhF?=
 =?utf-8?B?UkpLZzJncTZUNnMwRGYwQkJqSEJvYnlNaURqSGNUTkdxTzdkVWpLbXpFdDFJ?=
 =?utf-8?B?d3J4eG8xTjZheC9RdU5xVlpaNEdaSUlNb0ZGYjJTWmNjcnRaa1VURVk3RWNY?=
 =?utf-8?B?TDRVY3g5Z2pVM2FhMWczc2JwWnBsVHFmd1BuU0pEWDBxWEJvKy9HeVgyOWRy?=
 =?utf-8?B?RVR2ZTRodThpajF6UE9EQ3VKaHNRWldacFV3SHU4RjA5MXhmTitlODhDbncv?=
 =?utf-8?B?MWZ5ZkQyY1lvWVphZWNjQ3JwSktFMFduM3llZS9rYVRBeFc2cDNpdDNMdlIr?=
 =?utf-8?B?c3NXSEs1QVRhVkFWcy9QWUU4NnI1Qnhkc29qdG5vbTVTMS9FU1hXVDdBaElC?=
 =?utf-8?B?NHhjU2drUEV2ZzRUMjV4Sjc5TU9taEZNSDZhSDNqaURNcVNuakl0WG1NV3cw?=
 =?utf-8?B?RXpNQndnaFd1NDJJSjFvZ2dMUW9UN25KaC9qcU4xR0lzaVgxNW5CZ2JSV2tj?=
 =?utf-8?B?SW05TENvbnllNXJIWU1rVGNERTlhYmJWcmNjbElUb1l6R1p0SmQzdVdHbDJ2?=
 =?utf-8?B?UndEWmJiOGUycXZ3clpXZk9ibmZwbXBMR2NrT2JSd3o3eEpiWnFrRFM1NUhi?=
 =?utf-8?B?dEdMbFk0TUxzTytLdWQrQ2JsK2RmSEV0Vk1HZ1NxN0lpeWxwZklNVmRzVDhF?=
 =?utf-8?B?RDBleUh6SzVBOWRNdXgzd3EwMDZFZytDS0h4K0N5Z1VVWGU2dGtnV1pCMDln?=
 =?utf-8?B?bXVjbXIwQi90a1VQREg3UElqakZ4WVlDdUJhR210bS84VkI3OFRYMHgwMGNS?=
 =?utf-8?B?VDA4Y1JBMlNKbTdhRzFidEJIWnNnUFpCV0dvcE9iYTJKbEc4L0crU3Fjbzdt?=
 =?utf-8?B?YXQ4MmdiWmpMUTIwbC94d0dxY1RDVUxzYWdubzEydkpyN1ZtK1pPZlRvM3dY?=
 =?utf-8?B?T21QclRadFBTeUZDUDlsWGlhclMwZVYzNzVxOGplQUFOTkljZ3llODNHK2Y2?=
 =?utf-8?B?cFpUK0lZY2FnQUh3Q01Qc1FDZUpjWkd2aEY2MkdpMytyekphMnNCVHVoWjFv?=
 =?utf-8?Q?S+keEjbGZjZhyj+yKB9e?=
X-Microsoft-Antispam-Message-Info: b1OfoE+vv8rG/XCdF0joq7rvK4AQfs0zs2iZdFO9H1oBItMTSwpW1M+IZlMA89q4k1jUkeMy/ozBlmK/nvwrx32lY+l3qK6L2eu0D6+D4qVv6hkny6WwQWLw5D/hQLAEDQjB4lBuCOQOpf0toV6idaQWpdtzH3UNs+Pj+duRmjVeVxgR61ziKj7mQSuXIfycZG6LEvPXt3vsFrahkwG5O72beM9z9gJ9eO2397H8pcXYDhOqCnFxAcr9NBRm5XNyBq+uvWIsHEwY0L0iTqFgz/Bx6ePgn0X86JEB26p6Iu2sQ/fx0oAzibsZsHOMqq1sVnqem/Pn0F1pTym7HVQ74XeR2I39Zt+2Fj2XD6go5tk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;6:+vWt6Be0bAQq5NDUOYdyT1x3w9LbPWW+/KfibpAHS4jYYVumbNYJrvtZIKRdex0V8ohlhDSRIWWlI/sOyNGVcfWWJ5C/kJ0vOP746WovQgUQxCSuPTI0YQ/4T8fQ1GUEIkOn4GR0OTJKOoEHtgz3pn7+lSfEKVHLE5bY+I9DH2k6s2zm7oOivCe7Y3TirqVVF5CmyVEwpPi1DG6QYVEPITncufRmQ5u4Wvs68jat7FM/U+4+ydE3oOh6cbLWXIY3ci8d96bu8/D/RY3BtT+rbcGDkUy3uuGkJfXS8AJl6K3eUC6fd5T4EFSY808SCujwIJgT21qPL3OB/kx9lLbWO1rwVE/wVOBo94YTV8dfV9gYMh2ymq0wXrgvxb0oxHAB8d2DhvE+ENWZVzZYKMWbfMhXhx5o61kwQZxPlNPXs4XlF1VLuyf03iyCooBxmcLsYjliaNvB/cQLuyNdPcsBAw==;5:E4wOilh3B+vuP8sr+1HffgzYgLlb6ZjnYx0WHuspp/aojSJo0B7soRk82LYBHNf40Y84/7s1zD4ZBuQ+4eCmmscKiNUnO50GLDtDLEYig4SXaBXlCZkPCvYZfS2MAFcjuoRw8S4Wa3MUTIkLc4svD4Xo2ezZ8gVf5tHhdZnk/PA=;7:3iHYSUbXT9Y8ruAwLsk8Q11pb/sl1gLXLRYaKFsTCvXT4nyPM91mSAo/AS/Yj5OvUW9V4/ciOjPV2G8AaSjlrYc1213Kag93ORXMMNX3e2shjOPW7iRV5YU4yFTbd+S8X6dpB56QMu6PFl7/OipYnsXAb8fLTtLtRMJVduQN3EK/BXr5Qu7GPF2apvWZE0NHOMfV8q8wyAmo3RJ/QTkx3Ow/m3wUqOzKhJghVJ0hyYg86WtTqLaPXDvFF6h1r55g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:14:08.4122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e12778c-e0e9-4ad2-aadd-08d622173d37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes for v3:
-Split clockgen support patch into below two patches:
- a)Updated array size of cmux_to_group[] with NUM_CMUX+1 to include -1
 terminator and p4080 cmux_to_group[] array with -1 terminator
- b)Add clockgen support for lx2160a

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

Yogesh Gaur (2):
  drivers: clk-qoriq: increase array size of cmux_to_group
  drivers: clk-qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt     |  12 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  88 +++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 693 ++++++++++++++++++++++
 drivers/clk/clk-qoriq.c                           |  16 +-
 drivers/cpufreq/qoriq-cpufreq.c                   |   1 +
 drivers/soc/fsl/guts.c                            |   1 +
 7 files changed, 810 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4

