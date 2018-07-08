Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65662C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9AF208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aWkCBuJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9AF208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeGHO7y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:59:54 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:8057
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754198AbeGHO7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tOUeCa2XweKDn/mR90RpEIH1t3pGNkqBz0mMfvFUAg=;
 b=aWkCBuJkJZK44idISMfhuxxp17NJv3mkJc/lJbM1ZImfmQSRnsIfGDFwCTLJwQraFqz86JgIP7iJpi4Qy16C9+H9Sn+O87kR4l70ENmg0+35u3DEGQFwpL9ZIcXhbITNZWTMX5EQ5GUR3ukmTYTK8Rj8av8j7vdTZsQnStB2anE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Sun, 8 Jul 2018 14:59:44 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/5] dt-bindings: mailbox: allow mbox-cells to be equal to 0
Date:   Sun,  8 Jul 2018 22:56:53 +0800
Message-Id: <1531061817-1980-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:203:72::36) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a11cb840-2b97-4693-8da9-08d5e4e37314
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:m3jV7pwMI3LhFxRk8XjvHpmx+445gTn+eV0yuHaILzWhfCutLgZXgDTqDEYmJUyV9HE7wDaUjnmORgbcfI9t+TyjqrpoBnTVmXm03KGAGVU28f2XJwe/FT4tb7zeBUOq1OnVs2p06+rho5C+Cad0GRQIdGakdCzTk9F+V/gAlWo2Ws/wqTYWKe+9PoqKDVTm9GKlyf6k8IZZqR3HujnUGFzNmMhqrL/Q840dZPPJdfdHkgdNzwd5+KKL7/jYx30S;25:EhxoZ0Mstu1ZR4oJC/ngDG+rMXJMHMwHS+4Yc1DMoeOIISf3koFcTLoGGFAs/ht7a/5BMbSy2LBJnVH+vVeijZ4rUrnkPtXO1hMf3lQX/u6iQZ0f+Ff25eDFG6xeqP0TYLyuStD+OK276Ep6l0RLdQ0Sq+bKVWZmySw7IKdqneOmQJFxyXcdDbqqqDZVjbrIv+TNETbH6ro4/PHiAtCfQG1/e3h0R/Re+8zqzZ8iOrMFWgq939As7dh+e7tmjlx3urP43eY4HewnNui3UvHGKy9pSu8OvW5obWu3SVo0O0L918L/irYpj6QUQ7kavjHpD+sAlnGSVWvdhIahehrMVA==;31:5AODzdtQcvRwJfHQuehKNCuIxphieUwl8eW145pgVK67/LFgJoyg2lMJvP4Oxv/uhGvsaDZntxLUa0j5/785Dif5+hi/eUbAxsSrXipsDajJ3pwCe9f/B9kyPJgRRmdifobe2tAM5tMSFN/yQPs8QTzuTv+9YAZr0VdEKHQLzN+8E8moX63z7cXtShOfN24ZydFX2WXI33Dq3d9Lv6oAXRbJD1A9Lr02dS9YUniqEkk=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:yR/HG4g6EYuC6fJJXJ94GJdjSED6KmT3jyUHvGjIwfox3LVXZaEPmHVX1mggxyUZerthNXCgLjnF4E8KU8ZltZi9Ouyr6qUDEAFkgljvI8HQDi1KMwhfdvipLRwVmikLI4G+Rib5TCZ/7McmBt0kUPjfqn8TUFPG4nVj62fe8SYn5MEPjcHyCe/m0F/NN73kFAW5r7NH+Xjs7V5RwRm4b9r5DBi3SQTc0l8O1/9czFDDF/+o70fftSr2iGTbj5iIexvL6YCp7bQy+6JPBuddBCvM+0YPCKInD4jvaH9yEuwVSqurKkEj7rxeOOhuWfoi1YlZvQmUyG8Gc4XT/23HcAUvsex9TabhSI5fvp+rtuKn3+++1n1mwoUrhjmOIXllByF+L73WjtzY8hF8JaTiU8sjDYvL22+qYR7Gi7/lzkHSJR/hb08tE4enkcSpOT56MtP8g4pyo7ubRxulGvksQSnOSLL6m79q26JTAiXth+GVt+sIOjgBEx5zHWdVceh+;4:qQav6pcOvTQENJxCjqDOvVwNe/4uHHbrW8XctgOkLN1IcWp5qdzbcv6X2OxP2Q7EDO44TbsTsz5bP5RKvgb844eR9WXCx+DwLCeCcfp4JVs5QorbDG0b3GaIxBnIQJ2ckLPLYzZgEsTkYJs2UJiwzs7Yxo4hlizjY+Wm5ihZ4lZlyoGJk3rwq64EgUcsYp1Ur5O0hBf81XPBB32TJmWVOCKDpIBag9RacGWhhAY+WB/hINGGe/hVFDrV26/vrt7slZUd/VO1DQti/j/z8Rg2zGOxdRjiYTHTffcZNfJ8zi/YujALkhzp2BFr8Q6lzfXCOeiTqwhHz4Ag4mRojOkZwObx/FCfI84HJM7EgZG+HFd6iA6fiReLHmqQejmlKXbn
X-Microsoft-Antispam-PRVS: <AM0PR04MB4211E600D9EE496872BCC75480450@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(9452136761055)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 0727122FC6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(54534003)(52116002)(386003)(6512007)(6486002)(7736002)(51416003)(106356001)(305945005)(105586002)(6666003)(6916009)(5660300001)(2361001)(2351001)(186003)(16526019)(76176011)(86362001)(39060400002)(26005)(4326008)(3846002)(81166006)(25786009)(6116002)(486006)(2906002)(66066001)(97736004)(53936002)(36756003)(6506007)(478600001)(8936002)(47776003)(8676002)(316002)(54906003)(956004)(15650500001)(11346002)(16586007)(2616005)(68736007)(81156014)(446003)(48376002)(50466002)(476003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:Yw06DqccwdeCarR/O5mKNHGWHUQkK/nt9b61v6Q06?=
 =?us-ascii?Q?0POVlYZ/jlNdjvC/qzFidDfHrzIhhsh3oUkvsI9SqFM/xEtssMnlmjRWTZ7r?=
 =?us-ascii?Q?oLfldXEH8jNgnIwdPfS7wXs6kLlPgC37MoyUlDL+D5sLE+htABQ5UTHW6vjf?=
 =?us-ascii?Q?VLrJaliU/0KWElrnk4jW0xvHvdrTWSIulyfcCZq7Yc+pGDMGi8FKHvqVwHYM?=
 =?us-ascii?Q?6vkbs3LZIehLmGOkdF5mpHy3QuqhOs3TpQS3AZnagPsmobXBK4rXBuR/rrhj?=
 =?us-ascii?Q?zicEZYK2KnhrlV81of246hb24kPsXHxoPgh2YyX825viD93DtuzHGmdVeDN1?=
 =?us-ascii?Q?jjTLTAOrUlnGkQRlKz5a1KZs3KGEMiBl1Q9pB9Iqs7BbP8oGOz31h/xq/bIp?=
 =?us-ascii?Q?rep16Ol2jhjBEoRh6sq6Y9mHAnXrc/tCz2cgS+gkps7enNRq0LaTWMg+oq4b?=
 =?us-ascii?Q?locsV6HbPUfeYmLuRUMonf0W1xlC4xFqcreDg9v4u4KmAMoApHvaMg36x19S?=
 =?us-ascii?Q?FcaG1r9ShWXG/Flz6Ghcle59t54tiE9zEn4xfC83zxMpIntVvvrxsAPl3016?=
 =?us-ascii?Q?Vhsq1g7nP38K5V8/bhBhQWqyXyneRvAqUG+SJm8qk7q+2dhBiMUf4JFq2z+Y?=
 =?us-ascii?Q?XO0RM90DAT9ZtvQHUVzudFvWFDR0PTT2sNNI+Z+qrrQwLhl3XXaCKUGAfB0Z?=
 =?us-ascii?Q?AotUlxl/M5EDdww2FvBVmJtRCnF2MSv7aWmjuX1snzh3dC5ow4T4zVMFiKNm?=
 =?us-ascii?Q?7AV+pN8BP4CEDTJ2LJP6vACmKOBMwWndOIZIdU2ynuf9PCPFpB7p5sEiQrYJ?=
 =?us-ascii?Q?kLkC6Nfmag5M04sPaH5/W4tJnJwh5ebPbEUbIk97PWaP4A28JjIRpLJHVnag?=
 =?us-ascii?Q?7mS3wGz3H4v6OIf2Cd1oVA8sq40bOhjDX+ha8UQaYik5IOub6WTTZWhvYW79?=
 =?us-ascii?Q?db4IRwskTtBEyHcB7PWFUqVsG+R6FL0nLSaA09TpW7CAbIBsqhzsnlmoAHnQ?=
 =?us-ascii?Q?Iibw/2NpyX6W2/N0h+enG0tQk33t+ze8R4MvuSjfh2wOkfSpp/UNGcvxKno5?=
 =?us-ascii?Q?GHi7PwNvdhEiQzdnEVRR8G+wY4pdG+vMtoPr5iP00CX+VQOO+K8VSFV82Pyg?=
 =?us-ascii?Q?1tldzXPhrRxUramb+HqYqocEKeKDubFNl0z1Tx7nE9PNuWhhNsEaQlGuFK8Z?=
 =?us-ascii?Q?Eo1hsXrxrlKSjIr/ML/9mVdvwUrSloxqB823oaLXERUKPg5unB+hZAr2U8//?=
 =?us-ascii?Q?utGimSYamQDRxwJRT0pBIUbp07HQ5prdyOd0Kgsm4cNfSP+cVfqt9sAr59cC?=
 =?us-ascii?Q?HkDRzPs+PCwvqVxYG1Az/w=3D?=
X-Microsoft-Antispam-Message-Info: OCtSjR4+26sCRuylRG0FSDA38PyozxN3Hm/j93dO4wxTtNEZk/+xc7S0j7hrUVBNmviQa2RwgQfumdEL0RYGt47Nq3fmimuXJJARBYI48PXBF0FIqiZZFu86w5ND77fLUUn3j9JGDmrdF71XcuHw5RDX1I79U2+RV6BZLDTcsJ000EH8SINaZ+KqeodD+QDzSGwQtQjG1KLLZDhc7qxpO/dq64wULOA6LbEvYFoe8UPdRKVUBmICDr4jZswtiaj7NAzKStT0aA/YwyMx4gawKrLNVyYMGZx0551aRJulG3CiiZWw3ZaaIJK3vl65GQi1x2phWZmn5jNdhUdIorfI5BWov+fUyYfeZTXyHFn62pU=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:Aoyb7KQikV9AfAF/Ga8raf12Wr5aozb1bH621xCL0+8QA8LswHGGd1F9as423rLxwwLdZTyDmnQtTZA1EQrqKBIa1IFV8AudwjYKErMVlDznjUHR+VGwFEIg73DOpuGGYncKhd0KmhmhYjfqicsSg49uoixx1Qjzd+dAg+dxoKG7VSA3AnyW4c5FDOhtIYw2akXncVr8cKiPH5Pfg+S4hn4aHkJZkFKplCzwW3mj0iYNqYODUzxCbecra09W0+TauoIrEhtG2o00H7plzYM0N1QoMHHmN1TcZGDhHjz4TyigzZYGfhLZLzVkXfM4vjAb97ZQjI6AiavfIjy8s6HD518xIh8eSgeDba9xAQKTsIhMVfdmlg6FqfQjDlS0F8UDE6A3SQtz5rkddmHYX3bYF3hAPcLuBJnS+XOrIAwMZaxHrlqIDHO8Pxd6PhB6UwJH/KOaAAWhrEh7F3zSZwVhSw==;5:Tng9IoF58jleYaehwRiLaeR+9xR78HYXcIpRcO1DurMTpNKi8QQLiXvurB+u1wKZPc9jBqD2Cq0f+o1DO6W2fZFkjooGVZ88jTtMePgEkqf4cNcxqq9FH+Ovn+82XC7ymab7p4Lopm9Rz0klrYorAM1orHDUbqqfG17cXexfIJM=;24:0OR9l51nHzScTRNSNC3BNryyz2/W5tlWyBD6Flu5rzgbxfYjY02Aq8LtTD4VoGw3vq3wBV8ykUGROJ7xsn2KQgXc+QXuxr+1Agg80VyAi1o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;7:OvGmD8qtJppNj2gJ8zvjiFKs2lPPOfat5pHLV815MB5/6YkkbnoswSwFIeRqNyyJEeU1P1iBIIoycIiUJebqrwzvqUFvCI84WQHbC0gaV0L9PJA4eeS7FNphrsoJAZrdogcQNd76zJ0O4HtKYcx9MYE5ZwSrpETZX4HyEoq1sMPPakWuziv3iapqINo2t3/4PW384OKwELgnCZryG/ILj7aMIY+UiVxuIFxI61IQ1ThwJ6Jpv+8V+eOpqf26bNET
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2018 14:59:44.9436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11cb840-2b97-4693-8da9-08d5e4e37314
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mailbox devices may have only one channel which means the mbox-cells
at least 1 does not make sense for this type devices. Let's remove
that limitation to allow the mbox-cells to be equal to 0.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 * New patch introduced in v3 series
 * Actually there're already users in kernel with mbox-cells set to 0.
   See:
   arch/arm/boot/dts/bcm283x.dtsi:145: #mbox-cells = <0>;
---
 Documentation/devicetree/bindings/mailbox/mailbox.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
index af8ecee..c2fcd05 100644
--- a/Documentation/devicetree/bindings/mailbox/mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/mailbox.txt
@@ -6,8 +6,7 @@ assign appropriate mailbox channel to client drivers.
 * Mailbox Controller
 
 Required property:
-- #mbox-cells: Must be at least 1. Number of cells in a mailbox
-		specifier.
+- #mbox-cells: Number of cells in a mailbox specifier.
 
 Example:
 	mailbox: mailbox {
-- 
2.7.4

