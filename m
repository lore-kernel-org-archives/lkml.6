Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRrKtas0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0138A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeGYPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:42:03 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:3904
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728051AbeGYPmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zMRvimjyNYZS3osR3lBc+34G3Yz90ZKclapGDhD7/o=;
 b=HRrKtas0BUjP6s4qnP0HHbfJ2SqMwpoQczvF3j1TCIFg2C3a5RcheVUFBv5nmaYF72Hj0WQCTlwzY6ffz6X3YJSdv5Axj+Oa1Hr5HwcQiz4svPA1rYqO8BvjrM+GCVWMGqeRiTkzq9doZjqT9uCvEUfa8OpLpS3d63zgNGHoQBs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB339.eurprd04.prod.outlook.com (2a01:111:e400:881e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Wed, 25 Jul
 2018 14:30:02 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ioana.ciornei@nxp.com
Subject: [PATCH] staging: fsl-dpaa2/ethsw: Fix error message
Date:   Wed, 25 Jul 2018 09:29:47 -0500
Message-Id: <20180725142947.3850-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) To AM3PR04MB339.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c9e3df-716c-4ba9-bbff-08d5f23b1c3a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB339;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;3:jv4KRR7kNZB1nnsZPSRhBj0ZckKL77MQYgkRyt/OlUfnhFnZVmt7hb8EbqLDd0Q3dGdS5HwyHf22hbMO6Tq0M7dzCvNsZLtKKQVIY7NcsOPB5rMngmnn+KwWpzdtUBnrZFT9rLLC6cMVz0u02uSAsIGXZD0gmwRoqai23eYhyIDFhfzNQ/ec11KVVwdbkg9/dZKZvzkscqXtC5eNr55Vfqigsqm/nGF3cyc6EA0UdT5s2WjxNxUxlx0hDhtEhxQN;25:qjd5sdvvqiTaDyHjbS5raF9jXgIoOGSL4hJs53YIMupa/zFkkiNer1qQh8QIf9MVxnP7s6+oylHkXWTt+glORskBZt0ziGmZ6utzRn818y04iURCzDjBuRGGf8fKvqsppojGFGcYYlQN3Ho87+7C5y+axYPBhMcnZ0N8pmSqgTOF9GB4KdrttSMa3CYB4o8xBhTRLeb/hmqAFkPMQpIyxVMpPxxbfy5icmWaJjuNUTudWToiANkVDH6ZCF0M29tehlS5fu+js8xR+qinxykC21WG/0yNupwXZwx+o914Cd3ULymC0BAt3cnLgiVGTMQWq/IpCGV42NOA96anS7GYpQ==;31:oJ2P50Pyjj+V9KpFrwnlEZkToeWBCvisULnErpM6suq2cnQ+4NYr1ZUPhqmui0I2mVriiOQCcRTukouiE44N/WXLjeBze3SZkgBikSc6jnggL6unHIC+y20DBx/Hth/R9NRbOtjFk0435NlfprH29KikvNV8JgyGfIm6js0wCE7bPXvJH6q7Clr+3mbFdhC8kTk1G1scRDhmF0Zk2VLS/meFl6/5skuoYlQ+hw78Z1I=
X-MS-TrafficTypeDiagnostic: AM3PR04MB339:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;20:spYrUMcZJ4Pi1N2qZRsAxzO8pD3tPSTGluy2GjwmPlDQj0MWPnG694sfNZskmnM4vSCP2wl4RLBTG2Hbxhh4ot5lt/y0D2T9DomteTSOuRNQg3HBoNQV6+KgO4uoB8owhIOAHsVzpkFO+f2c0hZNN4MlagShYsZpaWVUGPiGSM7kJxPrZWclVcUZiXy8Km1BLc/D5b5DzPGRXYaEngEYkdITKsnZ7hhGfyO8sklWIJNdpZ5XMrfwMz/bxLMSQlgDfj6d6KY8mOy05t+bUffOwMoyM9/i9WCbdeFFz3wD8mYFxpVbEdR2b1QktsbhVtxNvyWUudF9GIkPYR8thPBwu8ucfB1pREyMkl7qQpYDBhGaBuKCfNOWi2C2aX8r+r+NGDxi7Y7IB66XBjByXMxIugJ5PA8H9gnqY6zp9FMEAMN6OUIo6mhXpHkNx74bmT3FlTBUUwbtCO3WNjNbIrYNY4fTC3fpOAS2jfJhQURZEDJo6xoluJ5Qm78V9lr5U0A2;4:1c8WsvsfuGIFBly6ksXCh1J4YGxECr3zHxMxBNA7G5jFYZXAETc235cDWjKhpzF3qyqyRJ5MnaJ1r7W0bN6ZkaA8o3p4h9Ptfz9cCI2iG2Z506xaHv6fCRv6FAbxwSQMJiiIGXkc02Ifkq5kZtw+mR/4cIZIWTVHcdr17FV1yMgsB0ayH8r40PFADXsX9lqUYPuKiuSoQHRMyCE54Qapic5T80+gi9kalgFTBJUaKcjwBwXPCHAczQ5Ni73wFhiuBakJnsux79ySFYRpB1nqRIAXM2x50+aJFwRDzGwcDeYaLUyZYZ6xXtxhKYcdDy9d
X-Microsoft-Antispam-PRVS: <AM3PR04MB3396E80C5A76EC0773FEE7094540@AM3PR04MB339.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB339;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB339;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(68736007)(5660300001)(7736002)(476003)(25786009)(106356001)(51416003)(2906002)(15650500001)(4326008)(305945005)(81166006)(97736004)(478600001)(50226002)(1857600001)(316002)(53936002)(81156014)(8936002)(186003)(16586007)(105586002)(1076002)(36756003)(3846002)(16526019)(48376002)(86362001)(50466002)(8676002)(6512007)(486006)(26005)(2361001)(6916009)(6666003)(66066001)(2351001)(47776003)(6116002)(52116002)(6506007)(386003)(14444005)(2616005)(956004)(6486002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB339;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB339;23:gOF8kpTjAGl5fTij6enWJ+MK6LjR9KMbECFEeimm1Y?=
 =?us-ascii?Q?RZUdBs9wyPsInfro9msxm/f4w2522FkilsGw5jTXK3OteHqpnqhTyCIA1Ue8?=
 =?us-ascii?Q?Hkq0tYC4H5OmkSkhD2csbkly6rNtIKCMXoFnlIz4d2X+6EAp7JejkFSLaEXG?=
 =?us-ascii?Q?1+d5V+Blc/qsePKgOx65JGOj1XZklqH8PqFS5ju48TVYO5cv5imh12ItQSd5?=
 =?us-ascii?Q?s91gtR3ijPQoJEE5/EYzhq7fhwtYkHkQT/W7AYNtOfXSKOxcDaKYuTvbpeGX?=
 =?us-ascii?Q?lS1dtdj8jcU88w+jFaa+CAPpR//Gwsv0pO9pnsjcQmq4D661yzwbJLrwzHVR?=
 =?us-ascii?Q?YJ1pEI0UTMXziKVYiLwA0n0BSwZml61+Dhw9oIpB1QJnHpLMtatHqVKfvNZ8?=
 =?us-ascii?Q?pOYTJV1hU/hpOKthr7sSvF/3fpsaCWMOFgnqeUdJroK0JkRsLbKtSsnH8uF3?=
 =?us-ascii?Q?S7CX9ujcZmztO3ubRaTQSbe0u3xSgUeneoMm8yiXCL0bznGKTBBr5p8YOCOo?=
 =?us-ascii?Q?YhyLOhilsM6sMT06tSFhYzfVwLlehVumhm45tpTm97YNTq4NPU8IDqixyDni?=
 =?us-ascii?Q?ppkx3QggTGKs9Mcw04/hH4GV39Tcoattkt5lkS0lSiaAPzTvT9Y1IjWkGZFw?=
 =?us-ascii?Q?Lr23gccYbBkFeexejCDx0Tl8llFXEluYXnmgzYoPPvD0IexDg9ymFTzqKiX7?=
 =?us-ascii?Q?s4cJVcOzgqsmhG+6/eYW1fq9PDeYnQvjgu2ya2SlHu/mozxQFXnZh4mQ0mNG?=
 =?us-ascii?Q?pgqtIAZpjUQM8LASrHeu2k4zwwSH3MRofPRvrKn6hGpB6DLcWwb88RSg0fw6?=
 =?us-ascii?Q?EAgBno6XryIhgOWMpvBR0RqScUDB87e7Ds1YN3Ehh5ZGCziDXVBeCyWc7ffv?=
 =?us-ascii?Q?loe1OUwPBkW9xrVrEboMYEKNeruJw69xqN3ZvNO4v0ZPCB0QXcoLCjm/RPMX?=
 =?us-ascii?Q?C8FFsS6559grQL2CYs/2j8TRoWzlgnHeJMHbWK1pScUh1bGJ5/QB98M2Dohr?=
 =?us-ascii?Q?Uo9yxF61xNrYXE5+0OJiP7IIUHHXRig/QI0E022taio7YC0qMM0T9zZev6n7?=
 =?us-ascii?Q?Uq3SRmAilEgo+SbMZYA/RW2Oxus4kaXDaEHeLZ9ULO/uE+vcirZkKj/x1y8p?=
 =?us-ascii?Q?jcFjEOXxBl1PMayAO2W13S9Fa3AZfywJSxb4vLOg4Y90QTEGvt46XDlO7b4T?=
 =?us-ascii?Q?jYtsmkGVg6ybHae1FLxgIlFNR7f8TGQ4Vuo5I0DBc+lWcxmH7eZOJVB2aEsr?=
 =?us-ascii?Q?fOX/KO0H9snrcsg+BmBZdWWxSrCwfKz7/siz51?=
X-Microsoft-Antispam-Message-Info: M5TwtJIngtPm/2wF7c4Ge0mFfCoQ25/4yY4eElyfvgevQd071/K0RX4limxwWrLwLsl0EU3BVCsmsj+vNp/KKeAfRIdBVopsa+0bChHwnOcF8rcyWkNcJUkJJV5Q82c8mtuW3rh/R8J+KiKXl1UDknCCbze5yvZ0+jPOzVHvwmVSUNDRAS1tp3dNT9FxhFmczVz3cbiN7vJdKNy7+yz5RTHBtk+eoCukruvd5rF1FXSSQUHxRrA2mI2EoBBTO/iTRLEM4vp9bDTr4BJH5zt/svPlLyJmMi7IdMKtl4bISS7vWX3jg0s2ggbvf/DfJwYW1ygpuvMb+WtKOtMvVGl0RY5HN+NSUV9/zBgyRdmt5Xc=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;6:7p9jD2PflG984YILW4tH4FBSTp5xKfO9kuYjHEF6vbABK8De6SVxtGQrUmgvcDXppSipbTvQ3t3JO4F244Jb31KX83R9iHsCGj7zeBi0OyuTWCjT++EcaHbEfifbl8nsEUUcB7hcpRNdVEIVCKAr415APgEVvjrKn8i4orzG3wVE9mFYmFjtvcgJKd0u6Y0tx+a4S7sMqVdh0p2Czc7DQ1lrIx7dkvjonWVOP7Sle2pz0+4nxTtAjcbDF8ZyCX9vmj+uzdsbGgtRgny4k4LqzT5G0nWA1oVclBjRBql9C5neRCMqdQqHyb5s0yk+YMHQpDINQDQysGLH+1GOxUCalnmNc8jI+7gRW877tKrQvV9rUoerGu44FzIzqrLm3ukAfBXLECQNLwJRVBNKxb4sQsrz5CMmGqU7M9X7L198y0O/a+diuht2IHWWkfp+k67rGTGBMt1MqATfLFkXYyYd3Q==;5:KrTnKVhtue8bRw5wgLZNrash7sVaKAt+SKMNR3iWdKprPzq4NZPa2hkLFisQ9Br5gRlVvVOvhZrr8tbuqzdwBExtztPSpkH7PchwyLRGn2hVeFhbJzfrsLic/n1ExrIZ7HI73g+dHBZXsgGYwTf8nZOty3UW7FOBGt92xDcLoG0=;7:NwBS9LLJCX9zb7wrA71ARYbRvMPzhBsh4GX2j74XEGyD/d2YR4qVgfa7p4H5mJMGa0zADc2rTH1rQD6hW3gQ9swsbfVoyg+iFbJ3c4xaocYnRfAtop+xhW4lgXPFiYK07R/lJKuLVJW9BFXwzNDo0w5m9tYm2Tr3Rls5sJEmE6bVW+iUWo15fiuVwNOx+6hsIy7CUDbtU3Daam02ePV9uXlyYeoIez1iM0a9NtWg/zFKRpQ0tG1xDnOoQ+/PQEix
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 14:30:02.0877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c9e3df-716c-4ba9-bbff-08d5f23b1c3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error message was referencing wrong function, fix it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 0d54564e..ecdd3d8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -179,7 +179,7 @@ static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, u8 flag)
 				   port_priv->idx, flag);
 	if (err) {
 		netdev_err(port_priv->netdev,
-			   "dpsw_fdb_set_learning_mode err %d\n", err);
+			   "dpsw_if_set_flooding err %d\n", err);
 		return err;
 	}
 	port_priv->flood = !!flag;
-- 
2.7.4

