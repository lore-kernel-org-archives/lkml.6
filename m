Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeEKDhb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:37:31 -0400
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:16298
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbeEKDhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:37:24 -0400
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
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>
Subject: [PATCH 6/9] soc: fsl: fix the compilation issue
Date: Fri, 11 May 2018 11:35:27 +0800
Message-ID: <20180511033530.7931-6-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(346002)(39860400002)(39380400002)(376002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(53936002)(486006)(7406005)(7416002)(76176011)(305945005)(8656006)(51416003)(47776003)(446003)(44832011)(356003)(11346002)(2616005)(8676002)(126002)(4326008)(336012)(81166006)(85426001)(1076002)(81156014)(86362001)(77096007)(498600001)(316002)(6666003)(110136005)(54906003)(26005)(6636002)(50226002)(5660300001)(2906002)(8936002)(16586007)(36756003)(476003)(106466001)(50466002)(97736004)(48376002)(105606002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR03MB2185;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC010;1:q1nQg/p6w9nrWDMAKIYNoQkJq2Cfzfh3QATuQ/0GCRVIdU2x8jVSqls4H+6qRbn/rnXrG5rgKIToGJWxk+Lt0k/eOYzHBGxGOTFKuIBW8oHBFEYSh4K3FumeOKzFCPq1
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:CY1PR03MB2185;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2185;3:CPGi7S+9q8NSgzq1jTOglyEe2Am6CW4+sXoZU5eGXv/TkCWuvwxFvOSOKCw9UuWycqfyVhiKubrrJ5SjG0R4u2opS/M86vb4OZbEe2SvrznCaRvCxetHnysqdSjxfmQWL7ZF0YQotruJvJl5CYvtaVKLoYw4gJRNQaTkwPq069sgQCEzhzr0h9j/lyu2jOdpGN+RHtN+NUktRynkF0IKDK8Fb3LsKTJmCgWGUjSqk+YpteoXEiiVTAesJC61AjbLFYmNl23ZDem5gWEOrr8fW8EYnUvQZN2kKItWC2eN71ZJeY1HiqkuqE5EwCSV1AEiOT5RA/Zke5DhzAzZlX8mG6Xwqfqy+vYr0BVsFDJAgeY=;25:eztblCe44SdmqtLleiH2KMpPEajcLXGo+UPIS6TsWJPOL3aPcidu5I/aLmvI9mWdeVI9mrPSBwx6hE6JioFFGDZGqwIF8nKyHjgbZZsPZKmN3EjN00cAk3h/O+Z6IO4Fe+dsTxFtdcDGf25zs1UkvwESoz8ru4HFnes7e4AcoJx69kTt+MX2vZxoAR/TG9mE1QEki79VYY/IfXvecYToN8K1YHRT+6YsuaPFD96leyVkJP5AefUPePQiwm30nda+Px4xQLP508Zt3YKUa/Yf2i8rdD9uMJZ/pf3wxGeDWLQTfXA/+I656U69Hu5DaBKJc1LVFYCr7cxdAGSLstRhoA==
X-MS-TrafficTypeDiagnostic: CY1PR03MB2185:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2185;31:/odh1367bf01hDr9UOQOLQ9VqptRaCEP6ulo7cJfTH/BXGhRgwVKZVhwGxmIJ3vQ2LO9JFjW3qbMnCM7sp4kUW0HpXvjTk66mvYoeNY8zDpJgv+oPNL89ZDp0Ocy79QtSuhRXeXX9A4aRbiidibJKWuPzD5BLqjuo49/3E/aFyJKKL6m4FXzhG4GZ63ce80br8ImyAn5bZENrhGO11hSiLHPk8p7PIa748bGKhjKpo8=;20:2teAowzpI5LpNSIyE0Xo0ADeoZlnO8y6k5+/q+7oH38UtAcOfHrUsu9bE70aZAkkTsE9cDiohR5mxa8mZbIZ5RfBPdfbHT1ykIiX4qORv4GudQLF+uGxJois+yTaWfOEiz7q8JFjonjL6IRWCgh9xevcbDc5jpFmP3xAUTgfbxichmwAnZy+y1FbWcFHqpsuLswQhwILqE6geOyve1uKSwlYzaIMKabUDvx3h3q/yGLEaSZ1Z8toCfBrVOJOu+giiaLUapjOBih/8cyMacLXwrTsLCF4FPexx3N9WpVzSyK01iLvCcdD0vxVyw0qq/8pTeXC5Bjm27tMidDPPtrlYO3/UIjz2JhDFtIxFgGJbM1FsnQGbXzGhyzlbiA1iczYFiFEtKWLQvEzxLNYZNgRWKWLsp8JFapDmp8mJYpGoI6pea0iqy87bsWH+/utaq9FPw0eCXG+LBwy3IGUC/GV+Cdw/cGYQwxAONG3rar95Eb1KwFHz8pzrlXxLJs4xSZRg1/6HOFxx9XUaSrKIKzz/gSbAzRopI3IKPhgtfTpKgHcaxZmLwYdW/54eKbErescOe418gtb3yvwj9rGZEZI9CJOBjl9XdWkw3sgIheOdk4=
X-Microsoft-Antispam-PRVS: <CY1PR03MB21858DBCDAF2D268FEDBB94BE99F0@CY1PR03MB2185.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(20161123222025)(3002001)(93006095)(93003095)(10201501046)(6055026)(149027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:CY1PR03MB2185;BCL:0;PCL:0;RULEID:;SRVR:CY1PR03MB2185;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2185;4:o31/F0VwTKg4VK//s8ThOhFoAOqMqaLPppfpu0D9SZ6dKEDBjByjz8sj8guUfX0ACl+z/OFRB1M5D0yoFRGdIFNxVAonB0+UBjnZdlGSh84AcwrYfpRheNoQePVwscOita5MPB0Rg1qvR+JycHrj9vrflrEBpcDj5znyKf+j/6l60Cq0SI7Im/BGycSt60bfX0hfria63NPK5EOx+00Vg8ZacUn1WfDl8QgR8mLiLUV8hcZVFRq51m2FsyEr0D8yZN/ClUhFSw4Ic7YM73mObjzwhmDhFLrWWlDwEM19D9R8/Ne/Dr9PtJnWBonwyr4F
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB2185;23:EhxNuYCFHSXyhP4D3bcM0bmHoYjGj8oPqpFVQLNCQ?=
 =?us-ascii?Q?iTCmhyxH11oeG3w+QNn79K+Zd44JlQhe+weolTSBBHxCdPyy+VYqhMXyJswZ?=
 =?us-ascii?Q?Ev6412ZV6q55jJAdxT5SnGVH3fWhX9JSN8KP0H6yqXkbb6muqBugPHu3aoT7?=
 =?us-ascii?Q?J7iZQNxM347IGPjzv6CanLkmj423J7UZzjcNqPa0uxDPn+rne/ZVDciwwP1a?=
 =?us-ascii?Q?Xq3mwEt4pTjR8Bfwf9/gORQF6M1rfMeyAAbCfqaLnyH8BgDe6/wNUMPwP0TS?=
 =?us-ascii?Q?lER+P+aMeAGLrBQVx2Q8A0R1VA6ISkPMfLHXmDNAS65z6K8GUGQct4ejztRD?=
 =?us-ascii?Q?jbK7H5N3KSYFu0BIDtamAFzGhlyDPwWBcFnMBXbTugbIxUwkJERv0N80lBDp?=
 =?us-ascii?Q?e+yz1CFoUafy5EsPrdE7fpJ8o5k8mufeUC7f6Tb5VzZ/uwty8IYt3pj6xBAN?=
 =?us-ascii?Q?2JdKz5q5mmxEJ1k0RVMDpsvUOlxSG+udhTEzTsHknF8n4WkaBoiIS16mSTEN?=
 =?us-ascii?Q?thOKT1PT9onulTZPZX0HJZ9iyD3hoYbJ8yruQv8kwTeB7mdRmGmvnKAXeC0m?=
 =?us-ascii?Q?JlOxy0n/IrNfCiEOl/yA4rVt8gFv52gJO7K9aHUvAtUCntLi3pCHyVHd3Z1F?=
 =?us-ascii?Q?ggqJoGFURKrsmaD2R75PBY9F2m3x+DoZof8H1z4MNlirhr33MliPCEBGDM93?=
 =?us-ascii?Q?udpDRkQ6Ov1drGdQxc5Ouf1YV1yvb6jLLs5JE0hPoSAhVekNY6kS80WDbLjx?=
 =?us-ascii?Q?epFCKz9RNCoaXNUm7cSmagy2UZJmTpR+y0h2N7kvtWiwDsDVZOQ4uWajIq7Q?=
 =?us-ascii?Q?I4M503LL1kFjxdBcec3/ytG/KWaGiCx2JVnQkrcY8+04ttTP2tWdN1zbpVKp?=
 =?us-ascii?Q?jLufOyZzEKZbIe8ufgKy/BUSl2x6u9nw637INNsZ5jIOg28koofFttZEgklT?=
 =?us-ascii?Q?NX0pfIDgXJUwYlxvdupajIWzRCV2wxJo7w3Ofmrr1kfCGsAzF3VPFywNA8es?=
 =?us-ascii?Q?9DQlfWnrTNJFk+9MIcgvJvG9fkTOi9Bx2Yh291bAZ34UqNpyNaLmFWQQM64S?=
 =?us-ascii?Q?7fJLbXeJSed5e/wqd8wecR2ppdL5R0YJw4/sX5D0IZwRqK692+QoseAebJDN?=
 =?us-ascii?Q?Mwc+IhiZv7L/KDvdaqG7donNNstBYIHf7aEYO2pKXs6yKWdXMmhYb4B90Can?=
 =?us-ascii?Q?lM5dUd4fXO3PS2jJgcxg3oiDxG9L1W8MAm/MSzsvUZiRSswzukHKzYM7A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: TLk1m6WiVBJcWzeiJYF+B/jKvuIgHljC0HsCj8qq2yO32CB3BTvrdaoKmb1tZFcw6/H481dCj+Aje+Ork/M+m4A7OHpJSCg+BZhR0CoD4pgE6BZ08S5/ryODLmXTCnfh06ISayRX4auFG/EQtWc5TQEd6m2mcQ6XU7K0Snur9n3i7yy5S0wF2swQ1ik3TS6b
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2185;6:2MnLZrEpu+g263sH/gKqVGAIl7V8gKMuE/FT3oXabQWoVEP6YnVMhuWRGvl+j7dirUhOF27NWJvNg3bSrc3rDDNFEWi3e8NpauwRWZ6pylk1egvkPjCcf6n16KdDpzCKxh7mp5mEEIR/UhiHCcNCAIcv/4x8LydgLEdHWAQl/WDtHIOXMbcfmU7M3Gr6LzCFdOyXfpdMRnaefmXFQZZ9yza7+GKlyLQGGZ42Bxkx32Ok/ACdHWA6d+CpbacV35qLor55vGiHq85pATM110MqjgBGk+J5yNav4ZNs/1AZScN1UA5GBFkmAfysAxoX6VOEwfZ4vtYZ8N8MOwp0JYBO8DfruanOzZ92AEmBT7CBgpv9f6N8lTQqxVKsgFaHM7UdvSzCJfOdiD5F6ofmPayzkmEHpEvzi7NDtSUILu8IVfjisUHDJQaB6B2pcyxBhryaZ3ZIFEgCpMLwBrTtxiMzSw==;5:13GhuvR9xCr+D5TuVqQPsoZGa927O0k6m4UDFcHsvSiKDgBf77skLPPZ2p0kD5siFlWqdbTwP26g/ddWehzO/FZvQTZVmolUAD+cHtH3Ai1K8PVyppdh3yBbDurjobJ+5uPUP/TYZ1TMyNFvTmcprGxnC6NjeY0K8sA5CpIGSgE=;24:k+VwacXWiKVyoLAYs2y+6Jx9QEdp9bhBill+RSlUHyRyejoM6UduteBbgiFWugxJw9/e8ulzCztVHShTEsVp/M6noDku/piJFZhZnvRhHTw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2185;7:0La8NTKbd5HNeyr3XMLD0VGTmXQVX1ZNXdWhYHiBvZAqLfa6MfM+SRfPlgV0lnZNJPbW75TCiYWHsWPc98H2OBcpXGazGky8Gntr+FqOoU48xkKnEsK0zjgo85f8LZXFNP7jT6ZnU5E6+zRfUPAbQ+W20w823iNZ4Ef0jXpkYNDMrjLxKOF+v19GZ+o69pVR6tI32K0e0WyPtJkeUVgwO8jA2rCPLqKjYk2OHzDrQkKvyiOtDl5ezzQSpWJoiwAQ
X-MS-Office365-Filtering-Correlation-Id: 2d763126-cfaa-4801-fc3b-08d5b6f07e24
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:37:16.4276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d763126-cfaa-4801-fc3b-08d5b6f07e24
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2185
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 drivers/soc/fsl/layerscape/ftm_alarm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c b/drivers/soc/fsl/layerscape/ftm_alarm.c
index 811dcfa..c22ef49 100644
--- a/drivers/soc/fsl/layerscape/ftm_alarm.c
+++ b/drivers/soc/fsl/layerscape/ftm_alarm.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/libata.h>
+#include <linux/module.h>
 
 #define FTM_SC			0x00
 #define FTM_SC_CLK_SHIFT	3
-- 
1.7.1
