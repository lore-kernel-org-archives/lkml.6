Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OYCkN4TXGltoSgAAmS7hNA
	; Fri, 08 Jun 2018 19:23:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3EB05608B8; Fri,  8 Jun 2018 19:23:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdWfZK6w"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9E2D96074D;
	Fri,  8 Jun 2018 19:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E2D96074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeFHTXo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:23:44 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:1584
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752845AbeFHTXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI/TmjGirxNTs324Wy4XtqH215eSKgCKdEgLQFUXSRY=;
 b=XdWfZK6w/FZGJAOusozV30lq5Q+UO4+ZJld+GU5tya0L4guGb39EpBla2xdl7ePR6pKKFxd5HnQLtt0wWOsgrFNS2D4RqggaFpzdk0TNPZ6NFv0+CuSv7J+b6Js8HPGW2Zmv8c0xt/EdWeKhEkPb3lT2TMgYx8/aOhEnzU75Y6o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
Received: from Ubuntu14.localdomain (64.157.242.222) by
 HE1PR04MB3291.eurprd04.prod.outlook.com (2603:10a6:7:1f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Fri, 8 Jun 2018 19:23:13 +0000
Received: by Ubuntu14.localdomain (Postfix, from userid 1000)
        id 663DC10A55E9; Fri,  8 Jun 2018 14:23:01 -0500 (CDT)
From: shenwei.wang@nxp.com
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 4/4] dt-bindings: pwm: fsl-ftm: Add compatible string for i.MX8QM
Date: Fri,  8 Jun 2018 14:22:37 -0500
Message-Id: <20180608192237.11063-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:805:2a::35) To HE1PR04MB3291.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3291;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3291;3:D41ajJ2lPMT7Abo1sgBUdch+5VISgiJPgQYy+Gwoq1FH3WCX4r6eHEgONLpG5VCdfhE0HNdNnL2PDdN/2ZVgnlIt8fH4WGhVwIqlmhyFrHYDOoGnt0KZhDegb3syRiQa4qxPvY3X104GNSsuCQ65V26HVUPeoyz61FriuI2XI+pQkDPdZNZazY+Wr9/3tNN3wlZIjmimS94gNG3AzxeDas2XqBs25ZvoLfaINI4q2VLm0gdkkqMgU9xxP8wpxb2b;25:rs0+XcKy6n+Rg7g9a+KddqruhOedQNg1i2UOyR/LEHokdruELlRFb+rRvvA070xK9+cy1bnopq1B374E75sdZFzz40dWqDMQSy+IN2qaRzX9sXbWduua7hrFuHXaLxN/PCiDERs99McQAW67SCr/+XA4EHNT4KjwVOvk4NHK9IK+z8IMaFSS3sUh5mrkj0ekxPWFwrf/6RYyl1bCLFzkeob9oFurtIWMUAk5PB9UptMrzKs5d/Co/fwMyTIGYR2lDDVPCWUD8LsLojypHPA93q9aJenImgh/ugRMVQlbihCbCH7h5wKEXx2cpUXD+XzXPQhCre41kQEn7/xIr4puLQ==;31:oCu2OjiwdbUGJYFChuhfz5b6q0wpU8NOqoy/Z6fvrtOHDgtznPW1b9ZR15mPevP+SMvzOeM0bUccsfco+BgTBlEWcO9AcV5T3COItfjHSQigFbJN5WAJZtn8nzCPQTrbDcBM7trzENazlBUZJ8e/31pILxCi8Bka4GBvAM6eJrCaE0ivl88O3356irYVySFa8CFJWJQ06j+p4wOPj4iwt4kPFtAhi8681/kGh8NDJu8=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3291:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3291;20:FmskApkd7ByiNKtU6yjvrXlW5+A7hIhfqCmKcMs/DImzQBA+Yh05MbzywYDzBbkZvQ/L2CF8rxjZUvD8gFmKrlK/Hhm60BBJuVl5La7GbKnaBI61UP+a7CLdVsvEBHGAOmQYPZh5/rCw0SgTSs+IKHjJApTR+1vg5g/HaCIjkg2DrdKK4a8a7OzVLOyCYyHvef2YIsGvLmlqQHo3NXj6kScGvNq+eWypLnta9Qi3n7kz9tI0zNdRkFjiw2lOQVSY8H+3oBCMn3YW45H6XNpfnxunUA1EdADHkAXsjME8yqxMZUye3DZ3PmfvYHBXFWm07eDEfHSWZTCnH70jz8BkEKs+XQlcK03KHH7c/45KqfZwQgTRq8z5YIQ4SH477CAH+MtCm7SY3tY7t47Lr/JpvDu++sVwd2s82vlBXl97Ww/eojlg9CRoGliWhPhn5k8Cy4Kg47YjyeglAN3OBRiG5BtHSxOm8vSCA0tLGSxUVkip8u6I/14IHGnldwcePYoE;4:qSkvIotM752TBZ+8Uv1PNczeGfD6BOib+wDIOTYfutGCz+ydy1stkLxCkHJAyDnm61OZWONWwMJdylNVOdpdShh1bsELBferLERHxTB5bT7vpnZf67tPdGGLl9mlcKSHec49A1/t+ff8cCXf7u00EDej+rFyo0d/LqmxUek5ajYypU4ApPoLAZsA2nwCZ7uLUJ8jI92BM/g5Bce9W0LqINuPJ5fEBP/hjoZvrva2nXyZS8EZAVJQ/dlKMoEpykR+5XBuuI9o4jvz1+jRpPbsXfBptpVOkNtH82H+YdlcaO+HWcfF8P6B7bU0WxIdvL6m
X-Microsoft-Antispam-PRVS: <HE1PR04MB32910BE01B9FF791565CCD8A897B0@HE1PR04MB3291.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3291;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3291;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(346002)(366004)(199004)(189003)(39060400002)(52956003)(105586002)(106356001)(122856001)(101396001)(2351001)(2361001)(50466002)(48376002)(86362001)(66066001)(6916009)(6666003)(8936002)(81156014)(47776003)(50226002)(305945005)(7736002)(316002)(8676002)(85782001)(81166006)(1076002)(68736007)(5660300001)(186003)(42186006)(26005)(76176011)(11346002)(446003)(2616005)(6116002)(386003)(486006)(59450400001)(33896004)(52116002)(476003)(51416003)(478600001)(36756003)(97736004)(6266002)(4326008)(90966002)(9686003)(16586007)(3846002)(53936002)(2906002)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3291;H:Ubuntu14.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3291;23:QhuMKAAESiRIp6M7ZSj4r42PCG/vIIaM0FQcRVysN?=
 =?us-ascii?Q?+ZkCjUa3zzMZ71eYAfXZnrjY+ln+UUrOarjar03pb1Kz0cq6lU3OhqA/Slct?=
 =?us-ascii?Q?EIkPQmk+FDIl1K0D0ejef7wIYXXSzqfOKOxcLp/DujakYfBLRRxfFMeAzcNY?=
 =?us-ascii?Q?QRyzdZr4ZNSOuy0Nxv+WqqYLmj1Wf9TX285XhhfARsKv3V3c7fF9sp1WAjRY?=
 =?us-ascii?Q?L7SlfV29dPJbeoB1Uy1HYGO25FfhM74JBSofr5Evmw6dbpB39q7SASSjMEr+?=
 =?us-ascii?Q?mjU77h5dTjDa9kJtX1KqPENhhL8BaPLPCmm6PM/3V7/e4mt5u5gaP9vG2pBJ?=
 =?us-ascii?Q?pJB/SEZGszfr9WMObC6czKBkUSAVW1MdSUA0fZQrZxB0jqXQNwX33WpPAbjm?=
 =?us-ascii?Q?jiQ0HNYRigWyPrwGZuXkGY6uAO2+KGMaD+4FpKb1EI4qlkzVROiQRRMGp0Xh?=
 =?us-ascii?Q?YhnqNUhFSmd9X1isEcExEEiWYhUBH6RFvR1EoBraFi8uyfOCYaTgDdSDxkBT?=
 =?us-ascii?Q?6Wb/HcbyoZ7qmIBihL1NFv22x8nMky5BDfGg4t4VQUW57UFFLv4TGj3x2FHg?=
 =?us-ascii?Q?Zf4Lsb4jCpgae27bx40Hnkn3untzd8VE1yi+opFf6clRHaFnMh41MhP/GRS/?=
 =?us-ascii?Q?ux+MWaUf9s5fIW3fj+iym0uRW5loOUnOZSF5zcJzoYMQJCsD1lkoaRq/GMon?=
 =?us-ascii?Q?0TplUAH/nWFMQ6cqDbO8upHCAM4v+d9gCrDk/EmaPzmw1+tM5zCLA1T5AvCM?=
 =?us-ascii?Q?T6w6pbSTDCPcSup9DSK1Pq1pB34zU72jjkmbIDVqtL5EhI8CP3jjdFLnd/Fz?=
 =?us-ascii?Q?fZYulNM9MBTYFDoARmIwgWNV3EGD81Wmtw28RrR/TlUkZiiTqsZMbJeu88+k?=
 =?us-ascii?Q?2hv6ECYryJRhU92N/z9yLJ8M/k+pOHnq8jeP1sULzrdKpS9vIDiMaFTPkN4c?=
 =?us-ascii?Q?X4serN0AM7smiCc0BPej4wmL6JRKfWbeDX0DBEjgC2s4kdzNcEYa7QriHPpy?=
 =?us-ascii?Q?zirgn6PHruwZXKJHb2bO7XvLIhcGocTdhYtI4SKR+AOhjPGgk35dcJ+uTjHJ?=
 =?us-ascii?Q?qLGPRJMCGI8biKDD7QKz4a5vJrPXZHvPlUJ/6RWZNDofw6R+34qeAWNqLSTR?=
 =?us-ascii?Q?pTi+xX4PpQ5c5cyxnt0lQcjowq4Eh1ynWX/y2nPZwfsGePK7Bt1sLz63xRNQ?=
 =?us-ascii?Q?u6VJo32TGRgXlOwK/pIVs17AH4LE46le/duJNSISanWwhX8B75M0++2pZxVb?=
 =?us-ascii?Q?a/filwWvuHqdtDirJjPd1JPaMPIYBUWB2AhUQWcMeWkLNyD9bR2TtI1ygzhi?=
 =?us-ascii?Q?R45VraNgkSZh+ML+bXYK+6sv1n8iNfOfiEUhJv0fEcEjMnmabwi+LjLupgVN?=
 =?us-ascii?Q?fr1/JOJi7zFHJG4ywgBwJL5DC0=3D?=
X-Microsoft-Antispam-Message-Info: KZlrny3jdnYbdfmTi1JLIEdblIQQLYcYGgA2fF5IUD5WRo6nU+jqZnfWEmIKLAjJZW7bAWzeBQeBPT6MqQAoP5xy9jhbmFz2i6yg+QvleQ6soeqUfexJKo6brWXDunqIILwGyExguviwJwFJn+2hbxEVu3sEfr71j8z58bAo6HEjJepe7pKjoiSHsN3PV1de
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3291;6:E3pSrJ7/maRg1Edcvfckaa3u+qfadJgy9gP/Iyvz4Kz+hJOZQqp1ugm1stfltbG5+Q3zI+BcymLtB0yZVitBf6ovLgKisTKzOFSTfEg0eTs6Pahw+/8yBjrp34fB33O4qNK3wCRvSO70zEiHxSyY9WS8m3UGsoH7mo+aIzjgFU5tU8zlUYZK45rie/Jar/V4gKoI0RL9BYxelVrrmjorheYEBRsv3AkDCfpd+ecz3chrIINyEHCXN2TcajKyo8qwLS8bC85lHuJ6LKT+kjpslzCkHAIbdl8FFwpwmLP1CY0HgZY8qzubv9Ib4UkmaOC8E/RBpikTlea7u8QhWzNkUxCKY0Qe/MTnAvFa4eu1UEqci28kaYg7We44K5CyOleVJEWZD6OKdP70MNnGld6LSsWlKgX+Es8BxNvzk6Bi/qvih2HMmerDNiKZwKejeUecsER1pcSZEKISBZFd+KEmdw==;5:ydnb+WsLrVKSHVLAeCY9zWC2iJsqC8nGx3GynQnCUJ0+SJy5lvJdMhKBUZt4oCE4EQYQlzfE7FkZcDJ3DELUGcBFwNZaA4u8oPUdyOw2YK2TC9PN3hM+ke7W/lw2xMHNGeJuXy2hZlLD3XICy6rT6PAJkYGev5yxgRaEOkmUbaM=;24:KOF30ahQK0/M0DxBEYupqHKUzzVqG9Nl88v+cZTY1RuL5vcjWW+NWTEsgTl8oAssts5I85VZpN/z6rGRG8xC/KSALeKzj3Qw9khtATvdn/I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3291;7:VHYkCq2CuZzhFdD4QWOXsSpVCwGdkCgkH53r6gAqaLZbrdPhz1naF92HmV87+vVCJrCt2IehbJq+gCcBODJBnLsEniZDykyGWfTT9VN3mXQORpI5Y+e4V9w0ueElxB1/9yKNodW8EZnqgSfBA+rdgmhfcAS0BcsYemxkDc6PsEE4kO6g0byqPkhv1etTv+aCrEdvURT0F/W4AKl3GKG0q9qjv80sKgQ1+cZnp0mxDAOMHd/Tek1ST3J9aFeq82kT
X-MS-Office365-Filtering-Correlation-Id: 3fc989cc-12c2-421a-aefc-08d5cd754773
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 19:23:13.3924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc989cc-12c2-421a-aefc-08d5cd754773
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QM integrates a new version of FTM IP block. It adds eight
PWM enable bits in FTM_SC register.
Add a new compatible string of "fsl,imx8qm-ftm-pwm" for i.MX8QM
to differentiate it from the previous SoCs.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
index 3899d6a..576ad00 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -16,7 +16,10 @@ modes in device tree.
 
 
 Required properties:
-- compatible: Should be "fsl,vf610-ftm-pwm".
+- compatible : should be "fsl,<soc>-ftm-pwm" and one of the following
+   compatible strings:
+  - "fsl,vf610-ftm-pwm" for PWM compatible with the one integrated on VF610
+  - "fsl,imx8qm-ftm-pwm" for PWM compatible with the one integrated on i.MX8QM
 - reg: Physical base address and length of the controller's registers
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
-- 
2.9.2
