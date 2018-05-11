Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeEKDhV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:37:21 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:58784
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbeEKDhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:37:16 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>,
        Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        Meng Yi <meng.yi@nxp.com>, Wang Dongsheng <dongsheng.wang@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 5/9] drivers: firmware: psci: use psci v0.2 to implement sleep
Date: Fri, 11 May 2018 11:35:26 +0800
Message-ID: <20180511033530.7931-5-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(39380400002)(396003)(376002)(346002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(50466002)(316002)(26005)(7406005)(7416002)(106466001)(16586007)(2906002)(4326008)(81156014)(498600001)(5660300001)(8676002)(8656006)(50226002)(48376002)(81166006)(77096007)(105606002)(1076002)(97736004)(86362001)(356003)(8936002)(36756003)(51416003)(476003)(2616005)(446003)(110136005)(126002)(336012)(76176011)(54906003)(486006)(47776003)(11346002)(6666003)(6636002)(53936002)(44832011)(305945005)(59450400001)(85426001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2189;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD025;1:dJ0W2YSSexHVe55OWniMIkncX/cnBEqHGhEiJux60nV91K8j//64PQYJ3mBcTmlSbxc0zjH6IKnUG7de2zeUMUSO9QsAAX2xhuW6EbZEQ4vHKVAwCW2mq3l+K0n/OcXU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(5600026)(2017052603328);SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;3:9zICG90Yy251lb2yLUm6iXOQDXWAPY3NnUfsuymdDTsZvp/5vN+L5AVOHH4xQGGWWSlHXJxcRF75oe7lLO/6VOqHez8Q87ndE6ldheNwFc7VT5r1S1yQVqX2otyjzOVMfp77h/zoG3OZ0PSJdelaBV1VDVmUAFBHG6LGG65QvKC32+9wVfCNlVoZUWRbG5s4M/WhLfcLQKbPVdennppjyOHDj/wGCgiiHe4dBTuZfplorwpGZgy+9vHcmrHl3e3y3wP+fA5Gntu0P9svDrA9eW8oJd3eLi+6WHMAkK2GDu+t/Rkm3cuhsz0s4uVndpJJLzgacjQ0PpOn1UmBwWdXyRbiQsLejt+ZxNqngRFRS74=;25:md3esU82diB0TCh2dwZx8Xb5an75/4PcsoBStJycTEpvWdbTGn750n/57Qk0ay7AeHv2tVPBT1TlKPlgSQr5dWzM9cxTJhjILnhRGgx705LiO4V2VxKbfihevBknBYZ9N+H08+/EjUlQYuu3+mlhumKSaEhgBnG6cXQ7+wpNjR22cxW4FANI2WzvHFgHtXyC10n2L/ZFym8thI9Y4dj+3I3XlIYzQbJSVRbSPbJpEq/3oSXdM0yYL1sy6RoF7365+UvGG6W1YphH2177fB3tFRw0sATUbh1/ntYxrXw1TUDyvzkuo3rlAOclDDg7g8DQDbqTHbfiPMxntnKK82JTCQ==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2189:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;31:YfC24O4TivbRZzqs3O+C9Yb+QlNDp6YQi7O20fPy4ID7d4b2oeFudsr+zvtPgUST4CckZjiiIt1X+siAZuMHl77vlJMDZsrcgEqlUlLvYZTJ1cvgW+lTjZ48bLj+1Beh5aEkhrnSQtDFBFUEfW+/hUKhemwouyyGQuSaUnjqIU/pzRMP0jepzqS1JnDmmJuG7H2UtFeQXnUQ7zFlaAkqoPJ88N7j92D5MgxNtR+iaKs=;20:e9Gh5KSUhDReZDPPDVy8l+WsT9CgEqIOMpTwgPnQCSyy5xL3h/tfs+V6u8VdNPPoutuM/2bYH/L4DkDi3pdCsuhNWHaEOBxQr49Z4ac3ATRz0djW8qtmAtt9e3CFxj6BtUrk4bUM5OAkF8Vcm7bWj4sg1Hp7icSLgP7mwHw0drTMlIX9PLgXtotuIE98cmWSfIpyJf9N2Ek33955gwuc1WzK0OnoZeIoFOeRBCkM6fbnp5LB8v69M9MVM1jkm9e6Kin5rIgVvkyON69xSuZOIu7d1NymbnJpj84iJOrsuWeZvBZnnsXNvEa7wfxaidl5gH/862iL/uj1eVRYCiC6JJxjDhB0ohRWcymtk2eg9CNTLcY/OdEUMuO7B1BZZh2RkQXw8Fh+LFAeDK1UbdMyz9+P+na1H2XBeA0mBM1zZxDxtU5jCod/ucYhMTctBNivi36Hlue+/yDaHS4LGvn9nTqXDlybfD2wDMcATdz3i4p+7n0y3cGvXV1pNTz54BO314tBm6E0Fp9nuvxcajwBmjgqejx4ou190YWaJabkhlRUbmVezjsz9wmRUxtCzEzMHXGWc3ZCjfKWGgUN8I+/x4ekVlLuLREH3Xuh1tJqyLk=
X-Microsoft-Antispam-PRVS: <SN2PR03MB218942B6B3DFD3C8A2BBD188E99F0@SN2PR03MB2189.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR03MB2189;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;4:SY2r+fCAsRbuDQ6tDK24/0RqpI20jEiHLGGdrt/1w1zcDP1MhXyoPOnMtYETcd/ueDoiH8OIh1qyw6MgLjk1BQE1JtFP2g6GymJxkkdEuzRFydunILgxGKzrIs6K8a9M4e0BHMM9PegYnhELLGHUVVa5yCNVpUxl6Q6wYKR2AUtZ6viZWNtWNf/vDFMnq8fIWHDGsIfLkbTZQAu+qDZE28/LhJ8JMhYVOIlj2HSx5u8VNP95mjoZL7pSwGSxHXv33dbxAxu1OyPrjYxWyKbyGazwWQLI1DUNn+Pe207T+yo9EcRlYHRPg3VwP86K8+um
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2189;23:hiudYMEVLDzKKIfj0m+KyOtOBl7zk24l1NtJwqmwW?=
 =?us-ascii?Q?Fs7jtneVN8QucydP1ducjeM/m43hPZOTs2Rshwhl+l9fFf9hMf5K46tkWMrU?=
 =?us-ascii?Q?0J0AXO83C8hFiCqYZeXZNIz2wGci8C14BoGh/wZkf+1E4JGgJqtgHAnYlBmV?=
 =?us-ascii?Q?h+ATDsLHdSZ4Rg0YvS1u2KuoyK2VSU83SUCuwAbxXB3LpLPyjfUIMznSc+ux?=
 =?us-ascii?Q?9CxffaY1NGGWlJoPSrAOSkIh98p5hs1ixQbMQYRIFzD1UKeud9rgQZi93RoV?=
 =?us-ascii?Q?GfcwhbQl8XzxyzZ2hcHPYk2uxYxSI9Ss0oqOiRKxnRqQwQobVAl3eaILV0Jz?=
 =?us-ascii?Q?3yrsZ7+bmOeYeRP4Kiqh6jjbsqpZ921bd6egoMxRrl90PrGofqvO2cucTcD5?=
 =?us-ascii?Q?L8SVFxtQnxakGFhoV3N7XSdeXUoGxCYVJiq+ZFI+YRMDo9RpWlZxC/UUjmKJ?=
 =?us-ascii?Q?VIN3GzF7gwJFv4w0jgcPou1cTjjyCfVApeUa9kvh5Ip0EMXzUmWqZ0KVZyCj?=
 =?us-ascii?Q?fbIsLH2yPFZHBbidUznO/T5S9+BLIY55z4Bpx2yL1SqEmQuWACiPgFNlVFOG?=
 =?us-ascii?Q?/yb1YHj7/yPOxtK9bmpscV2rxGI2GdNBBngvkSOZF2YFtjOvxJ3o4tPdzWOw?=
 =?us-ascii?Q?zLd4kn6hjxZPRyH4Hg62m3E2FVSQBwRSxbgqyVWTPCC81qoQqrkEGgbqw0uj?=
 =?us-ascii?Q?/hOPzvRdOBqgCtrCyUHKa23FWUAcuG8tyHev/c+1PDegto6yMq1stlcwh+Xf?=
 =?us-ascii?Q?7IIsNoPQz9suQsnNa3JCCe/EyrYA/RMmvD3XLEc1CjjhUkdYayT8UtHEA8ev?=
 =?us-ascii?Q?seE0h8jv39gYJylzjTKZriROuOalfikFyReYW197gRh+uoQgs9QisIG2jrs6?=
 =?us-ascii?Q?hGrBQ/aIbLvoNqyaf2Z9VsoTLxp/Xipj0iOOy93QVtJ52KUlTdNew3VgpByb?=
 =?us-ascii?Q?Uatr9kD5i+HfjdLOqNAmGESPH5M1F5gQgM5Evcy/qC3F/8AkbRCljda172ox?=
 =?us-ascii?Q?lkBVo9scX7bZoYDEenNbfRTx31/0kpo+LiwgmGvGzjRl/AfSQDm/FOaIYOEd?=
 =?us-ascii?Q?X89LmzjQ+kNBZxPKOzkV1mqSX4ww+w5Gab3eh5V2zkXDpU6S3I3UK7qmBdpu?=
 =?us-ascii?Q?wLiBJ9n66a0sY8o1yV8HzpnnO9pl10ahekiIK6YBgIi9BqiMOhQ+xu+96H/2?=
 =?us-ascii?Q?9esy1Q4bmKTumZc276I1T2fO9f8h/roepHfpyqA9EKoe8+hfJ6m4yXzHOZiG?=
 =?us-ascii?Q?HnYAyVW0r4SOizDC6E=3D?=
X-Microsoft-Antispam-Message-Info: ftIWnXruMTQZp0cJftYhlpDOX2XpmMd0BXdlzFTSNjS4qura0vQl7UqaQv0RX/W/CYYwjHs+686J1qc2X7qa3cDwSDaxw4fjpFVZoHp6aULjGM3DVlEEf7RdfE0t+cgvLiTA9qA+vDSZ95/XBt2B4DwK1238AgNSNdQiPVFR5yQ80ehfS16eU3GFuHiE6iO4
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;6:7bcLUf5q2hWj6EHAV07O8HmIt/h21IDs4tXDdlGxl5GzNoyF1KumRw4lAK6qPGv3qh9a0PP9s6Do0JSBj4zhjaL4os2KTN0mLF9eEZI0d88w/G1icL1FtMdf54F5sruvbSkj6srCYSv/ZFgDPx0m1qzrMKem58ZU4Ik3f6GHEXGkLgft30f9bo0LT8ZkJiZZ9xBhd3M5s9Entvl3xgO5x0nZ9xyVGgYYKuVIhCaM+4SajwiyFUxlirCNuUPbYslg+2nMqere95UI6goEVfXnawDfA54RpFnr+nzWppbllqdLBqc33SQNs85t0WdAVsdgB6KeDK4Eycs3XBi5HaZlGxuQnOq85Z+hGbGqyfuZM+K242IYX45LqOIbaFlUuZiX44CofyKHxnbkeDVS0DSxST+laAo+jCa0k6y59PWSanCJ8NZU7HPcBXt/QoXHE0ydnZkIl7b1pXtpysiaNs7oZw==;5:vHlX7SxKRCI9yQei+Z5K0UfMVnbcty5829bk3cWaxR0ITeC/nm0zNc4fUiqXnZ/mOAQitvWDHjXT85fV/TL+6d4lAOMYAWaomWcbri+QqpbpVb7dT/qC3+wwVh9+ZQ1KaPaTRoMUYg2JuWFcm13QCBwbU6pqGlsnF1zPXj/8sc4=;24:Mc8cb0qbCL1u9A/ED3vRJk/Ci4i+XPdr0MSbrAho/2EwpPRVp1NhCYSWeUWvfrSEG+FcJpj4mYlum0BOEfpSNHI4lg4ov4YcG6wNVaBe7Bc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;7:f3WobbwqBIJlu+2hjib5tuYlGt2gibVlbkqqdfl+YwRRFNdvFmBsvK8QWz7KzMBZhNUCUIwvQC3wRlipG5FtDG8tqaubIeOlqIZXgA7LbZiCXI/yymCAV1MtpwWSBISjCAOM14S9UiEz1feFMd+OGqmLIq6yn1HHPGPGSa2EQy7WDbYwervMda6Bekf8SVH7PQOjIGTSoKdBbiNZA4Xk6T20gmiVbtn22EOJPxnTK11XFJhRyQWURGJGdYZ0A0hw
X-MS-Office365-Filtering-Correlation-Id: 412c5e39-aee1-438e-8682-08d5b6f07990
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:37:08.7126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412c5e39-aee1-438e-8682-08d5b6f07990
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Technically psci v0.2 can not support system sleep. Unfortunately
our PPA only supports psci v0.2. So workaround this by changing
psci v1.0 to v0.2 call to implement system sleep.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/firmware/psci.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d..0bd795f 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -437,8 +437,18 @@ int psci_cpu_suspend_enter(unsigned long index)
 
 static int psci_system_suspend(unsigned long unused)
 {
-	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+	u32 state;
+	u32 ver = psci_get_version();
+
+	if (PSCI_VERSION_MAJOR(ver) >= 1) {
+		return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
+				virt_to_phys(cpu_resume), 0, 0);
+	} else {
+		state = (2 << PSCI_0_2_POWER_STATE_AFFL_SHIFT) |
+			(1 << PSCI_0_2_POWER_STATE_TYPE_SHIFT);
+
+		return psci_cpu_suspend(state, virt_to_phys(cpu_resume));
+	}
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
@@ -562,6 +572,8 @@ static void __init psci_0_2_set_functions(void)
 	arm_pm_restart = psci_sys_reset;
 
 	pm_power_off = psci_sys_poweroff;
+
+	suspend_set_ops(&psci_suspend_ops);
 }
 
 /*
-- 
1.7.1
