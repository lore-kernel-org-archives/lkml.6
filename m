Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeCVMz7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:55:59 -0400
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:27104
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754544AbeCVMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC: <linux-imx@nxp.com>, <anson.huang@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/4] arm: imx: Clock related updates
Date: Thu, 22 Mar 2018 11:55:25 +0200
Message-ID: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131661969441277453;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(346002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(26826003)(97736004)(59450400001)(47776003)(498600001)(54906003)(36756003)(51416003)(16586007)(26005)(110136005)(50466002)(48376002)(2906002)(336012)(2201001)(85426001)(68736007)(81156014)(81166006)(8676002)(50226002)(6666003)(8936002)(316002)(86362001)(15650500001)(53936002)(105606002)(106466001)(104016004)(956003)(305945005)(4326008)(5660300001)(450100002)(356003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3309;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC008;1:uAQQZnhjZrkq0dyTAzDsckPuWxfSd8R2fy+GYq0tbNOeFobn+4oAQjCkT+vW8wjke7xlTQeBGTQnA1d9iDrViV0tfyMSYpnJ2i2ILo0PSGcOwVXgX0A6p27RAbu3TqEt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cc84542-08a0-4480-64b1-08d58ff4396e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR03MB3309;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3309;3:XN0mx1iSJQYA6zZMKMOSU4HonuDzkDjUAT0qnPCVQA6EkzPrdiFbDYWnVhuUa8A8SIav0316pTzmY5Vl8nfVluEX0Hwgo5qgN2fCbN3oA5J6q/dah2qjKLgLpZpQTjEx/cw6Z2nmhiJ2bZ+Nv1tQWitieewY/Lq2Z6wkUi4Vm84bv9CjUNoDK0VQ4qEZiobzcQLwIUj7Er6P2B43BR9JGiiItjQhXXKDdNFfleseTX/1t2Z+4lWd4F+mqKQ+aT9e++ob9mHOP02Iyox5ZNY0Bivunz6eHHSQSVaeloC6MA08bpvJIFhUgIVEf+76/2ryaxoiFTB/noLT5bLjwjrQoe+X4wBE58o1x0mFBUSr9a8=;25:vaoUvFxhxo86mXKNXBufg6hdcPa/GVeJ0moa+qpLI+JBrvGOCpU9OHZ/eVRhhx39yRJy0Z7gCzeJgM1rWz6Vi6qcImpydHxJ2E/Dt3k9VQ0Y8d9paxwRlZTxWVKcoZtRi6xuwLKPBSO2bBTjdjK89YHvBxJmMF0C5Pbjw7X1mRoXwg5UCJ9Wx4uX6nlbSbE8j/K20cmppyTQiw0qR3NBTQJGeLJItOVwL6/0tsDL6+JXun6p8cpFuPDAy0SGXKzEjqhtLZLLvdj87hxhm4bSa4ueW7Aci+puNm2BeHK8jTqhNCGA2s2aWpueMhx8aQhflRNxk//UAkLqzaOOJ26lMQ==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3309:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3309;31:hz6joGboDg2/vpmU8WA4xYsFMmYiQoYeMI6CE3VweRwNxWZ3PldNJY4ZvLrPBkViHcV+bMfhIIJq9vrc92Z9VLI8lpijCd3XmofrMUqUAPwlzxeACy82GMkjlhuqCMriy6XL2G0/Bv01mWlNfFkFI79GBG3gyzIHvGWxtU+VI+WdgnyfxuVff//YcYa44ETb/mfdUzQyok7ufYJAUsgki0kMEG/hCdDs2Q9OejL6y7Q=;4:Z4gMNBH1j5/D9rDeMCjV54F7WqRvaQO2OgwBhcgMBzhx5prV5isIEODl5WCvfIeENE4R7zSJvr7JgNbIE80SvTKVxeGxAnYqAeN9TFQlA/svdJUCwxJLF99+y++Txjwa4Q00WuzALRqPqpvbv/UUkWWeLowDFEgYh4phuG3RO1eToLkOwuWUR1RNJElWxmbCu7DZNY6daVH3AIbWtPSb7UXiMJQPjWJdgve3N3AonahWKGvZEUv9qpZ66FC/EB0HLTjwUm9USXo9n0f2WA3uZA==
X-Microsoft-Antispam-PRVS: <MWHPR03MB3309E15F91BDB2C3F96E6634F6A90@MWHPR03MB3309.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123556025)(20161123565025)(20161123563025)(201708071742011);SRVR:MWHPR03MB3309;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR03MB3309;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3309;23:tiWKs3+dHOuuLythfvFLOS9NCsiqo2eNItkvuivVk?=
 =?us-ascii?Q?C+UcWeUtI2of0PXERlgJzC83VJY0BEe5KyVrwWM5MZQd+Mx0w6LyKlehtD7n?=
 =?us-ascii?Q?j67wperFR7de9nzukb5NVxnRB/V56WDdYdSpjjepJbpYrMWHGX1N62KLnnd0?=
 =?us-ascii?Q?TDuCiPNeGCxmNnG9FzqmNxDVE9IONbqCe0iXP9AcvpUmIXg0CA/pUEfW8sG8?=
 =?us-ascii?Q?39zuu2BFnOoRHXZjIi1NyzBMGQQCkCyRvjjojcdlAO2BN8Qbzf30p+uF3PPW?=
 =?us-ascii?Q?icRAn298rvnryt6zGQcBLIj1NVCRouAkyNyQZ5YlW0+u7f8OX8zZi9iLT62P?=
 =?us-ascii?Q?O6UENZ3+2SMjGxHvqj8MVgKMPW0iOfGKu67dS+8TRdKGA3d/rfTpZdkIUJQl?=
 =?us-ascii?Q?gTERk0rI/0lb5di0M0fpczNuo44pXvmua7vgU0KYf3SmJMfYhKPNjvccpHE/?=
 =?us-ascii?Q?bCmu/39m3zDb/7IHtM5xQeqdJS9avQTvGJtc5GMFEadcUf/o/r3U6IeA59ya?=
 =?us-ascii?Q?jNFLnz83FUXPIot1g+AseISV8HubNbK0UMlRTcDWL/EFac++VwtyTvbyXWTd?=
 =?us-ascii?Q?TeQWTz7yFZbXYkq1A/SwjNgeMrZsbHo6kfKa6xv9lfz42jS23/h7hPfn8RED?=
 =?us-ascii?Q?voIehgdAQspc/6XsAAsp2BgDuzM/Q4pk3iMfcmLrZpM9SAQNT0d/nWX+xf/w?=
 =?us-ascii?Q?O7aGwpYBZ9lZJLgJa/zreWnzoBA0zeXq0TcfHu4x74RgBeeZZhOkY1gN/pQn?=
 =?us-ascii?Q?uF3Ci+b3+E5/ntLESd3GqDUVELHS48eeEfvjnXQhsB4NeyCeRdTGQiPVDZRj?=
 =?us-ascii?Q?JcVuHY29UxlOPuB7hF3Z43RFILexsoa2MvXIxjQitia82JYqQP3ussZZtUu/?=
 =?us-ascii?Q?MoTEQFw6g5y7Yokle/ZBy5Rlm4ckb0OikON/8xk4jNJG/FDYrXSiYMDfwhdF?=
 =?us-ascii?Q?kkrQVZ2BoK6C9al3+ffAOPMjKsX+HPl3lu4dsrfzwe7zfLUE2aF0w/GP1xQS?=
 =?us-ascii?Q?pdhIaZmYUTNxt0tXGXR2mX++FKfjasiVmL9/dWzLE42x/X5mFcw6i8MMG30n?=
 =?us-ascii?Q?fAOpB1unhbxOWm8jAuUwPT0Uq6Z/myAk897Dju6raLt0ry1cUh4UTgT9OG59?=
 =?us-ascii?Q?sSSCx/p20RVKo19yz6FuSv31r2pacD9?=
X-Microsoft-Antispam-Message-Info: XBx9ddbu8Sja2BkGUQBaSVccQZmWa98agp/AnPDT0gglJcO1jJh31NCiSteE9ZTpWmmbjTII2cOQWbi3KbtxGHb1/gINAQhJyKLpyfNqATiIUWC1ZWx9mV6Dxr4x7cKUYEm61IHRzHKMSoT0qyo/XabG2iG0TzZOd4kV0dfOVVZvupJ+N1mnCjEb2OjH8dCY
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3309;6:7rlpURlzl09NuRUzV6m3bSkzC3sjbaFUU9mu2eAlFujGwNxh1NKvRu4C/XkBqcrCi4l5SU6GCbrnXC1Z16l5mTWJWeEYehiJBDumKPZrzjYu6BdIGdyjmGw/4vm+IGwNoZDzLDwRtwtF9Sym///Keg4yBcfCU9RlJa2OT2VijQx8XtnVCZO9shLdDl4I62VVT3N+eHuJZhBrNnDjFe9C4+njd3txh4FQSsClWqia18QKs6zfrf90PY+jodR9bsjuM9ZpXasa7k7+guGfuwQwIOn3kLbQU/W1t9iUFQQmXHwxbZx6SVhl300mOxvSm7M5Mefgwd2SU305NWARPb5jHza637oPM/FDegIhu7TDTxg=;5:dYv/w2LYuaqoY1frS/ukPO61dcZlSnNusWGXTsb5wLK5Le8WiWPwTTH9ThZwMkUmFgOgwMX9wdIYMJfEqbokC9RbVFzPH9drBBFNSDVSyWwcmX0uX9EqBMQkSJMmk+pj2woot+UVoYQ/LTICtlUHSLIz+lP3XhRUvoyVLQdCw5s=;24:uWUuxSZW6IXVyuGW5XIX6/etfSLMqUZiMUPhdW/pyW545elfxLr6sATSLDdmRyMEONp3njWahIfBY4Oz6fkwjNuDuRuhC6ZkjwR8G4fWFMU=;7:y4j+SP6pDhNQbGHO8Na9Iq9khzioNadjUpJxHkNcLnWm1m+EvMm/TGbE7/AMzXvSK3JtFjEEZ59u/Vmh7FsXaaYOB2zE6+DzgDvF2EIkhPvFF7hLxk6gass/nXdUcozBc/mbi4lfp/IOAiyYt4s9NQNBCBBj/pwmFgLHpjJV5JJ2FKAXE4RP9cgYwJiNxblcez+BW98GsVkLvAh+V61jqsTA9rQPJTc5ca0vDx66y8voUl6eeRh4XXT9kP3gtRbf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 12:55:43.4101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc84542-08a0-4480-64b1-08d58ff4396e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3309
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the imx upstreaming effort. All the changes are related imx
generic clk API and imx7d clk driver. The imx clk API updates will also be used
by the new imx SOCs that will follow.

Abel Vesa (1):
  arm: imx: Update clk driver API

Anson Huang (3):
  arm: imx: Correct dram pll type
  arm: imx: Correct ahb clk parent select
  arm: imx: Update clk driver for imx7d

 drivers/clk/imx/clk-imx7d.c | 127 +++++++++++++++++++++++---------------------
 drivers/clk/imx/clk.h       |  42 +++++++++++----
 2 files changed, 98 insertions(+), 71 deletions(-)

-- 
2.7.4
