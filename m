Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CF2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6JEEe74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3CF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeICGIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:08:07 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:58080
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeICGIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5n/1Q5wkLVBg0ujwTddrxSAzInjuWvcEF7hs3Dpi8k=;
 b=a6JEEe74LLiSbDUGpncHGeI44u4/N4o9LDKekm2plWU57ZUYPQLqiTtWqhC5jmtE+WO+y0W8+5xfnXWIVvdzgjsa9R/bW3pIzNQrsDBuvrL1liLE11yjfCQhF10d3TkgxwKMr1oszW+CYuhWhqGyIGBOB9mv1CubWUaL1DfaKHU=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3917.eurprd04.prod.outlook.com (2603:10a6:803:22::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Mon, 3 Sep
 2018 01:50:05 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] ARM: dts: imx7s: enable cpuidle driver
Date:   Mon,  3 Sep 2018 09:45:41 +0800
Message-Id: <1535939141-14338-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:203:2f::29) To VI1PR0402MB3917.eurprd04.prod.outlook.com
 (2603:10a6:803:22::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e12c75e-44d2-47a6-f2c2-08d6113f9488
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3917;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3917;3:Rz8e5ONOMceWgBvmBb4qe9G3dPeEcFr/dh4lToY/dGjpgcqKN2GLzRY8dntgFT6xkU/TIrv1aU3mhUWCD+870zto0LB1RqgTdoaulLHYpz+NDMvIhvI19c1zwVArq7MH/rf32Ny7tcQU67Vdc7cykefLZzQx1iunEfVJfP/GdQW24dsPY6Hdb2ZMKUOLr75JicyuzvgXZF366dfSAsVeV4r+xOvsJ02FD7R0BwHk2XlajumY1t5sssjTAfLSmM/f;25:E3DOcxdLdbnWzTKD+uvENlb10GVrwj9wJyddHv7a36afLyOuzfETBTHSE1zbRLPaUtB3KnKd7rqO2b/9Gjw0Ak89Aebbl0BOMOmTKdWv6ZZHERWWnXm7c4q0rLZaDaxrkEzbaKmuPwmFwJAcOqw0imdlc7PIGJW2fsN1TpmI8JHSx9gEN0tVyOiGLymwYoAHz+OCpgM4x6ZultGQXU2gtYkVTCTBNz3dDp97/36/Tm3p/2gDJXTgfEIata/Rl8C+puLoa1GWLxiLTcJdmM0cJHHFxiimk5gM7XPKB109Lnz+b3ZD0L/RY5OUWhZl2CD70y6ijbzAIqJYaUu7mVMzEg==;31:2RDESJ4xoLGLfW3ZuXzAr0ig4GsVeCrjtv421eWRuk55iaid02sEX7paigDHLKph6Bt1nEzpYCfNl1CgxvPHiEJcvlPjwf4MY09jfPzxLZwpQIYpUEGLkdJru0LbLiRTq2A6MRiWki5/sBqvhoIjM2odo69GuN07BpqUZkFeSdxmsozDxVxsvWH4HfzBAYGZdJ2+G+q4kIjJFQzpY7WelfQZXslxPVjP2y6oTpCHHW0=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3917:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3917;20:i1jfqWFxsFBLIdph9MAtD1/I3bmB0pZkPv2Uoy5cAg2vfC5F/m7kRSoFIRBbvgsk4SqsSl0EQxctRuCxuHAKQX44vXE6XThhqx70hQ8CE/+IY5EGCN4mGWhrLfisNMXdqwPsXu0kM3bgxwuO/T9rvRw7kRTENnlWoysNU+lXespOxOz+eRZgwQckaI8qEPX95HheEpB9tM/QIXypWJM9/407ZuiMsi9+UoWDslX7gmVcjmhq1cvTRCU0RSGv3AW3ThexLAWsfDG0JF5J5Bj0YIJ3gPxdYJ31+gB2Udj8Rjwvy/z7dyjGZ2VZ45vuxdgdxRysDhBnZLkdlDDjN6Y1zEc/9XEtBSAS6ZxqUUgM8JIwovTQ/CbQPjevxlJfhomtFlXXXXG8E3sQgkPzqfjKt24ythypqINpoSD/M4CvGhEylphtD7BtnQxIHYydKWnXkHdW56eFMw2ACyV57f+QcrmZvApMwUr85pWbKMgCzj5ez/5zPfEeAmqUJ8vfVVDw;4:/rxv2+Lt5AI18tQau70k6uzYYLlUNiTyA8OUeyUgnny9yhAESagd6AqXOcr69y1P+Na+DsDMlHyFB47MyuP7Q7uc4V6LPH+2Iv1kfw7vcSS0Fj+YZebhuNcLtEY3jXCFEfHGzbAH79IsmKulQd1kb0ALAWGwZTsoh0oJ0RxFpnkuid3VIpk4OiDZkOl4TDfO3hercsa833OeuF30p8+PBmhROVJWmHU9ZZI3jjK2jlsFQtal6KG+pcW3MOpTTMPYyngfbiwAF26G41uFtS/Ar2FDLuARDIM/QgWyhaaGK1+XbxxnvOnE1tnvV4UblfoiFW2mJX+1LYHo71zBKMhpTw==
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3917254E7BE722A51C5037E8F50C0@VI1PR0402MB3917.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:VI1PR0402MB3917;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3917;
X-Forefront-PRVS: 0784C803FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(16586007)(53936002)(8676002)(6486002)(36756003)(68736007)(7736002)(50226002)(6512007)(8936002)(14444005)(6666003)(316002)(4326008)(5660300001)(305945005)(50466002)(48376002)(81166006)(51416003)(52116002)(25786009)(3846002)(478600001)(97736004)(6116002)(81156014)(386003)(66066001)(106356001)(16526019)(476003)(2616005)(486006)(86362001)(47776003)(2906002)(186003)(6506007)(26005)(105586002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3917;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3917;23:8lvTjcDVPlSoSXPepCOrf+rFCkJ8JbGkEHThxA1?=
 =?us-ascii?Q?D25uC85GMuvjdgbygEAC0YLzOA4md9vPBh5p/wLSVRDEssNy5Hk+UU2z16Vk?=
 =?us-ascii?Q?bDmi9m3ZwnFgkWSRZkhrSdJfaB7oxLaLyiRQgsEsS9fexJNIrTxmAW7Ht48C?=
 =?us-ascii?Q?Xu4RQUNF4qfIJzzO/DjHkMeOX5WYGyHvGBY9bVdX1HzlZqNEJtn8VQPRRfnL?=
 =?us-ascii?Q?F6w4gixuYXX4zy+uFjCmvfUSW3E5sMx0Gwi/6gs27cF5GHCYYkvsHnu9evPl?=
 =?us-ascii?Q?bOhhhGtV5Yz3TBsIZwgEOGs20J7QL8WIQhm0lBvEWbkA9epiXbS+2kqGOapS?=
 =?us-ascii?Q?ExLquzMvmQ2Ai+Xa1F9n6RRmKPYXNNX/NXApJupLVAXv1wyyj/DFo+RC+Fds?=
 =?us-ascii?Q?/pQGDBlaLZRfrPaLX9dwhQHwy8SUbYmN6jxdfulZvddkWrIVJyMylLvKsFf7?=
 =?us-ascii?Q?+WjQnU5DFfAEi7frrUAwxZ9/dz/cFaJAV9/y7YnYbe/gBazZvdxhk8upiePH?=
 =?us-ascii?Q?Y8XRyUwuRrJPU7ooCr+IMzS7VGdDe6CqhK9q3Zi+QVH0e6rZMuopz65Crl8a?=
 =?us-ascii?Q?te+CLzVGLDc/Dpzhk9IrJak2W9HB2enZc+qrNRAKUZ6N2Kzqhof4JAlVyXU+?=
 =?us-ascii?Q?Vr5dlQEp13tKNQYSk6BZcC21ZzCDhp+bMtqkHGo9iPZfVD0OZlAoO9GvDUF0?=
 =?us-ascii?Q?3w/k4w+Cwwgoimy3rpc84aCMH71S8I511Agfe69FoHRYZhUPnFkXIfTcH7NX?=
 =?us-ascii?Q?Yh1wzQ3clfFdXr8SwXBcu7WxguqOiM9M6mFLPXe9UefzyQHb+U9eq1mZBqp+?=
 =?us-ascii?Q?N0A38KKV60vkumokptOxwbnUdSIhAKXwPdbs5yYBK3nNH0SwDAfpx9Cy4QCD?=
 =?us-ascii?Q?CA/tHxk7tIXSbz6rybf/TGQ2NkBr5STENpnh/jdpN99PbspvyFzAappGfl4X?=
 =?us-ascii?Q?zn0HewuXGyo4HuadNS06zhoDeE/QlSHgcWizGKXBZqnY4GJPqEDGaHkvGt/z?=
 =?us-ascii?Q?nh/gvOHqTkyzTLpExBp/jXYY/CLzzM+VgPMWTLR51VN0LHzvpkQDw3BoTGAv?=
 =?us-ascii?Q?4+e+hlOz+muZkF4i3PdM5t8Rk1EIptPK+Cg6+12su+C6Ey0AxfvQ+nBysgM2?=
 =?us-ascii?Q?tHjtm7d3RBYU=3D?=
X-Microsoft-Antispam-Message-Info: y/aLPwJpUrgoybFxmBgvjS02vZQG2WgVGPWQh1/Sc03C94AbdSrLKNjkkUvm7xjvtprc8flx02hErKPJTaLZXKv64Wj9jTIs403hwV57KWucpRhjOdQa8OVYPutYCXQmnvK1TfFWPjI/31Xv6wsiUl+uYIKREMQvjBvHdI+Cn4aQIVjq6jhakjYk12+yBaleW5vwEFg2unxIevhL0Dgp11wGNaM7IXtm74hi6f4xWKvq3sjQu0YpRc6sH4l4PAzksEkjvGtV+y97hIq8RwrAz8qVL0uMq0aWPHZxuvothsLYAb2ihH44sSW7kfg4pf8jnoGCxrC1g7HKwHqTBdK7wl2vZdTtwb99YAkWUi9Vt8o=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3917;6:Qc/BumxO8wH8oyLeDnMopyvr5ohIPGcNqOvzJWCQSiO6l6yxBaqWZSaRiiot4EFW+3XFxXBusoTMjakHtDJrHlWpaf6VX7WpEmpcu/8Dg7mZSp5NKpsv2lt2bxig8arRKmW8lxrfVfY1FYnNFBt0bJmmL+RUVMrcqh75/N7R+eAX0vmfUQs1WjxpREJEqaNeSxeageUBZuw4EvS1rY1zX/S895X2meDSYY+alnmMG+h9T5r0zvmfNoAvMWhtqkQ7udcR0WF7rkUCcdxN8V2icg5JIAYi0tEXhncPKTxKVzDYzd+yKTMsKGOsUlwpZ5YSSVK0nJ6I1fN1sFIDouIk9wvGtQNtU6gjOTIoZZ6ihx4k8qWec/7JuaC/TYgJ3c83dwGcl0rwsN9bUz3SaAtWWOWJYTagvXQVfanDipZjn3Zn6V/0Mdi94NGgrUPig7D5CBiP9hJj6bztUS/WvHcJyA==;5:KI1Df0unBx1oYlFf9fOAibhebi95rUGFx/pYsESIRvrTsCHCbIiOGVKJG0nqa9peDskzBoMnrNfkM18o8xKix7i5enic8Oz2JuqM5eT1yPDR+Zdd3DP5XdXd4WOGmtDzCMLjGmxGvn7MtsO9ecVQXavr9XPbj2K7e0TJIJdqggs=;7:8fB9OCnJua4lV/RXb3vvWfCGXTNEPr1dC4QGlBu37dRSwE1c/6SGlrWilMxu88NRrwwKtANXnrbnHImvDet2BCTh0HMsD8AQFcZtjak4Psk8keS0VRVEzJas7n2Rk4lYSYZ+sV8LL5yVctffvOwXLmjOE+tRLgeCr6EIbf1qhKY9r2xfYxScoAdDKu368r2cssbC16p5Qau52UiJCNwqdrmr6v/+RLk1LhkN1L6x7F0oNDKhj9V14eTlf/KB1HiJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 01:50:05.9617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e12c75e-44d2-47a6-f2c2-08d6113f9488
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable cpuidle for i.MX7S/D using generic ARM cpuidle
driver, below 2 idle states enabled:

1. ARM WFI;
2. SoC WAIT mode.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	replace uppercase with lowercase.
 arch/arm/boot/dts/imx7d.dtsi |  1 +
 arch/arm/boot/dts/imx7s.dtsi | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7cbc2ff..53eb371 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -20,6 +20,7 @@
 			reg = <1>;
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			cpu-idle-states = <&cpu_sleep_wait>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 93884ce..d3f6488 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -54,6 +54,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep_wait: cpu-sleep-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <100>;
+				exit-latency-us = <50>;
+				min-residency-us = <1000>;
+			};
+		};
+
 		cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
@@ -61,6 +74,7 @@
 			clock-frequency = <792000000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX7D_CLK_ARM>;
+			cpu-idle-states = <&cpu_sleep_wait>;
 		};
 	};
 
-- 
2.7.4

