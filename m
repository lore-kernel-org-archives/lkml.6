Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935420AbeB1W2M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:28:12 -0500
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:36032
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935315AbeB1W2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:28:01 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 0/3] drivers: clk: Add ZynqMp clock driver support
Date: Wed, 28 Feb 2018 14:27:38 -0800
Message-ID: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(336011)(63266004)(4326008)(110136005)(106466001)(77096007)(50466002)(107886003)(26005)(48376002)(186003)(2906002)(36386004)(6666003)(2201001)(5660300001)(72206003)(966005)(9786002)(7696005)(50226002)(8936002)(81156014)(81166006)(8676002)(356003)(305945005)(36756003)(106002)(47776003)(54906003)(16586007)(316002)(478600001)(6306002)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2268;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT044;1:qy2zQ9kSF/GTdydbqOQLreanXU/90ZltqhpUo5KRjgJOAc4XHqJVEWNXwX03zkKa6nP38Zgrqc984+BAMiaKJaNOjQeRj27JIRY3C3WStS+g4VUIIDxAkjixa79tOxcg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21dd0478-2c97-4b3a-0f26-08d57efa852d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM5PR02MB2268;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;3:MaF3ypbV5dZem93/NeWiGn25yY8b6eJcdSDTtxtPohahzhvkP8b7NKB1x8DNQsVWZcVq9rqRwYqv3RCDkUBZnGcAB+nnctsCYMUlRhy8+q7fKddJVO1a9fLmoPqbeWjGJPge1H3jkhODsXIBYKbF1LRihsMIPK3R5MyROWKz2Ecgvt+G7q+DC8pxw7aEwbUY0i0rSZEoB9cyzZ8kqjPNoPU/IrDxD1gN0SwGBsW2EbNc4wsEy7fV2R9pBtOcpBtGObBGCBIaYtPI3IU6TiXjEg8qYGqVWtpnxHxrF86Yp/zq1ng8Oekx4minkrbAwAwkcb8HDLzOBf/Xix/sCdzZU0N3jExyysu2pI41PTNKycY=;25:jRaSjef4T2UqownyBnEf/Zp2litpB2PqCPH5hwSDMGaxMJtKIRRYQekFlmucCYLQA948N8gSrsWSGzp9Ohn7xOBRt88CwmEGWZSx2N9/HOuaRTGDUCnuN84nQqjLDNurxPqItmyofZSJj4iM2hQN3gX9afmgq7v1wVwrBiOuYfE8xLDtMNojmwQThdfRf9Y67qc8dPpwU+JB8eferEKVT62/rHspOGi386LDx96JdmJxbqUQh9b+GNB9hdVTyESinQny1a6qbrOzjXb7YZcxfx7tF0GOf3kM6WGQ9bxXUEolLcTvDm8bEgruRDCa7x48nLOZAuakZV0uRIRjFDvv0g==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2268:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;31:Ck59tWbu9gWFfHlq5zwOvoAIpvjdEfCk2pKcW81oyzSVh+Pfx2U7/CQuQsV62WU+pqiIV3HJl0+XG/h08mFWrZTYYT+RYalzKhR9ScFbNpzkJtKzhIzzLEom2+IcsGPkbOy5kBrxHTf0ne3oh2+tQfaQhCHcAjty3dqURh4MeqmMNX8HZ7WEqJwNlisD9hZWbMDTdpeROHgnl0DU1RbKajDX0hngpJVfNiZQd4JxkYI=;20:9yoFW5H/mF4Y7l2+eSkFZ+6zJ51T5wNgw29KXCsKP53AqbVxP+KpvwmCyYcHNQd0r1jbt70aI9fvR4e0dUJKFRM7BeNOjuMRusMDLWbAneKrylXsy0QuERIt/gPQdIQcbI0Xj1OzDaGZevaDpz3LbVvvaEosjztWH8DJWnCjziYsXyNN2h02eg5EwRapRAYs9sb10gL0r/Tp5zsh0Za4lLSRWpysAXxDMH/se4F+QJlO4+G/eBaDDErjaZGfG+xqtLddk7eDdqZY2MA+YRj2l9ttDmapru9VNjhH+ACorBtV8bic/yFJ19d6zf5TsSxqIHxf+js84bvrXrAfI1Q5ByydC5DklIqItLLkp3myk3ZmH1o4BXBjiiAzfsmI3RjkEL7hwm8UfkosB6u5llVQrrwh4Jn/JnYORqkjU3DRK6FR9eGz0dugNAoe29Fp8buS7MRWHJGqdv+d3OKt8uvLAmzOeYZplNKvGSQHgQFwema5FXVPgpFDYILKCqHmm/FZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2268EABB90A03822C6B09626B8C70@DM5PR02MB2268.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231220)(944501220)(52105095)(93006095)(93004095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR02MB2268;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2268;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;4:4Mn5qkO3ib0K1jbzj+z4WzdHHIscNpQOukSiBPdKeVDyQCRrbsDi+EjKvEz31HPHkS6SAPY4wP8G9I50Vbv5bOhRt7vVx6olZu+VLMMs571C/8XH2nxk3DidjjlY1CLERSzLidOQZ495mH38ugfauMlh7NgSoRK3t4VR1uubbkwA4J/KZkv/KpXxuOi9HmUOI6VUlZukNMiSqKS9sqzJrWdREj5RCI1HJXbC70aTAJV2+gXJFRAHepwRBW2nHo0/3duPPUpWxduQ/VetN/4hGg==
X-Forefront-PRVS: 0597911EE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2268;23:K/ZSjADCbZjBgJnud8dt3uPBFNoO+EkLTJwEMNWwP?=
 =?us-ascii?Q?rm/T2WWACD3rVsUNYxUbpJvkqC98ZM8Ntn8WMuP9p3rk3em1YE5ja2fYFd90?=
 =?us-ascii?Q?4XD29WvJNyhJAiB0CQxPRyQ1K9HxPP35SxPELHoiI8XzUQTvonnygkvPwlLz?=
 =?us-ascii?Q?IJmRw7OExIz55cmB2PMyFNp0ouQ13D343RoCEQnLKagNotQ7r/L58n/bXYYP?=
 =?us-ascii?Q?EVpefwAD7FJqzUW3oigvZHOYBAW7EyKIMSfu5AyNRCiwfQv/3kMGFnjFscX8?=
 =?us-ascii?Q?FxkZSeyIRrG5N5ukV3rnuXmzti1LthycqBLw9/UExcVPmon0QLavmURhdDJe?=
 =?us-ascii?Q?dXwscg+su6TNr1Wx5xFZLsBrhCdhrX+p5Q8mu0wd+p4UYDb28x+U4eiCx3MN?=
 =?us-ascii?Q?Vr9D2Ct5CNQauCQ0JCldpKUJTybDmDef+7SbvSLgW3Xanm8kkpu0EiLWDtXw?=
 =?us-ascii?Q?KaniMIm4uu2pU2vrIL6EzYOgk6QFLf/Smk2My9K9YripYim4voS//3hql/iW?=
 =?us-ascii?Q?mfdALuVlXZQFhTv6z5xp3j8CScnL3TSaHAmkfIRTtZ+n9ZGyqduzoFrYbej7?=
 =?us-ascii?Q?lNb8RsndtJRuiMhBhgmgT/3O4+orREZoK1p0kih9yUfqRFjCiH+1u9djjm7A?=
 =?us-ascii?Q?IkdStCftJyJoTBi5mNp+caP+rfMCrQJo60uiW+FiB5nVogg//+X+sq70ZpRf?=
 =?us-ascii?Q?m2Ka7kcIlEVF0IgP4R9t7p4V5aH1KDdjP59R5gWCt7VhaEb4SSVvRMeEnV/7?=
 =?us-ascii?Q?Sy2BqnBYeVmmyRnJjZwWR/lrrHFX7u1c1bGSFFhBr7+3kchBNYYf7Yt/gwUE?=
 =?us-ascii?Q?gZoe2i1fMnrskMhS4nrUKlRou6Decf/tNl5k84VVAPm24RDL5i1CkDz0cO59?=
 =?us-ascii?Q?39L61Sf2i/fvSJvTeKgGXiEH2GN5JvQYhB7VUuAeWtHgf4xZ2KnT8dJ1LR9O?=
 =?us-ascii?Q?MHuZXlbBsdXuTqypMoX1H+FEjSytxp1QTBZd++DILxgMJ6IuAKyiAi9mMCiA?=
 =?us-ascii?Q?/UZ5iTTjsEAOd6OtiNLVxBIHcFE3z8KLkllR2gQZQYpSoDJb7mPxY5MMOHQG?=
 =?us-ascii?Q?15Hv/I=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2268;6:biJn4Oh0pt/rFMVO2u5en75pWERSW8hYIHfMiX0+RSFYR8pTRnN17UQYaIM3HpFQKmGXyPovuqgJELhfKwLRU8uOkkTT01JoPYIfOl+Zzgp77CqfAoI/SP695I6aHBap81EAHhARXH6U529l2oJKDw+IwTYLw3ui/RXcmccX2EzyXTEvhA11hUgNvbxZ59cNAYpI/ccAcJQe20YBHgHE/8rcEQIujVhd1jteIJQC8k3pndmquW1MsNTXc+PLQNzljx3T/10glvpsn4BqX+Ta+016/vCG0TDq7RqTJgrpkVqLhTPV+BqLWXFrXQofIVnQ4wU1q5wWElHBhiuqW3j0R//MCkP+RbsZzkhdIKwr4O4=;5:+kG4lMcyClMMfcJxZlaKKke6mlZ7u0pG6Emtxkmjfvvb6AWMjWHigNbbWrlVy24x627mi/6hcywroLCSenOK+q6IXRifVQ32UBHjJhALrcYUNoTHQp7OKVUlAL5SAuGCnmynhpo92vvkc8Bd67lWgA9O24Yqp9ng7LhiFC2T5SM=;24:EgOfOD5HuA/cHELSOnesDQW43GAwBBT6mPDe790exSgHp1QfAZz8TRWaZIBdMpQdQ1wIT/0mxGO9e5LEvPxq4XqFELxEvh2i8wMOWkSz4mc=;7:J4W8YHedYL71vo1AdAmZKETVj24U4UYyeTL01rXsVOBIcJTrvbF5Q4v3GbUZfkSzkxeWfPNOPEtIU2AYklF4WzPtKVWCnOHEpfx6jmI/bnvmPX/dL9bcWa0YQ/MIWBer/unwGk5bZk4RJeBIV+G8tDNHmQ+MQ2XieCNpOb2K5oHlJwuX8BK8SM0pMjpksSjpsWMjA1lPXeqxCxyytoxQvr7l0kmTmgBNlhFFnNV9ZbAB/wSLBs4LOAHnu40Zy4Tz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 22:27:58.2320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dd0478-2c97-4b3a-0f26-08d57efa852d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2268
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock driver for ZynqMp. 
This patchset has dependency on below drivers:
Firmware Driver:     https://patchwork.kernel.org/patch/10230773/

Jolly Shah (3):
  drivers: clk: Add clk_get_children support
  dt-bindings: clock: Add bindings for ZynqMP clock driver
  drivers: clk: Add ZynqMP clock driver

 .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  | 163 +++++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk.c                                  |  28 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 156 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 189 ++++++
 drivers/clk/zynqmp/clkc.c                          | 712 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 245 +++++++
 drivers/clk/zynqmp/pll.c                           | 382 +++++++++++
 include/linux/clk-provider.h                       |   1 +
 include/linux/clk/zynqmp.h                         |  45 ++
 13 files changed, 1937 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/linux/clk/zynqmp.h

-- 
2.7.4
