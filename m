Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B620875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bX9WfwVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3B620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeGIPC2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:02:28 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:9760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932949AbeGIPBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIlvywWXdqt9dM1hlpW4HLUfN8pTSW+LQjVBUNYXBpY=;
 b=bX9WfwVIQBB1pZE+FKOmOd7nqpWNFgBWDNX8JJYO4aj4oNLZ9jpwPu6wMjdvDMOb4cViPQrIchVwiMJbdA6Q6kZ7i1b69j13KU6lqKeMlKllbGk4x9tOW/lN2bqS4WZ5HieWh0P+OK5MuRajgGHmwOLcsTIAr5i6CgsMdAWbmSU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB339.eurprd04.prod.outlook.com (2a01:111:e400:881e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 15:01:31 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 3/5] staging: fsl-dpaa2/eth: Remove pointless instruction
Date:   Mon,  9 Jul 2018 10:01:09 -0500
Message-Id: <20180709150111.8875-4-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
References: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0085.namprd05.prod.outlook.com
 (2603:10b6:803:22::23) To AM3PR04MB339.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0bdf05f-cd24-48cc-a3f9-08d5e5acdb99
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB339;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;3:hiloZ2QkP5PxctBK2ePxsXWYmQARfqdv7y73XB8NjGt/HZ1aCJ3pYOZTnhU0cf5VytiFf6fyAvLHM3KIfmqrzTFngMXaiLCUjqsCqMgTCveaoCoHhZhw3Q4LtJWeI5iWV6yXBlpUIpPmrQ7n1PxWSOIbruVy0/VUoWybUvxomPKaCpaksAwSOJhfuyHKskAHHLdYrleBkeqSp/+ALFYP4QPfiRy5tLnlgsGIf4qpqoGmFaLJnxNd5QV1Ng8Eran/;25:/91dO6KS46LSU/4pryhb3mztX0sPUuIT1JokXv8XErfLPN8541ee+nj6HQEzx6DNHULDCad0P/rTT4nHh4wlfgxHsQ4opI4Dhw8qWcY3Aj6FseP3MuPUxyp2aRLWQdyZDYWTbOt7O2o+pPrBumKWH9tiyzdi63McXN33Z1ppwAMZjEVeORDtwPjj4jl1xiYZ+xRDeQfOL/c1PqDdPIJndv+3K0HepcJFDOlztBnPTMEmt0zl82Y6gMb3D3lbTK1IKOWuvkwve16GK2DUdZx5SW7FcM3pR97qfWHgGUhy2is30mX/fOV1EROvf5NiWb4l472PXsU261K8duvb6UNyvQ==;31:B/PYjSiLHocFr052ufEI+S8Sg669vtZnqGtl0LXqeWT74/9inHUPt4DYXy6RSwBA8wdIqOjkx+AYERs2h9GBe7XgCS2c9k7nfKp2pEQs47JPX6vRGd1qFgRMSNS7rsFdfvxaEiRylMk/hwY9wqX0PY/f9icsPZQvI3Lbg6bkB6e5dXUzvaPjiTuu9u9jxrxyNupJpMTtIUNOzRyFQCwao489s3AZV2A/KZslxDuwh3o=
X-MS-TrafficTypeDiagnostic: AM3PR04MB339:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;20:EuFNO+Dl5tlSp85jv997vV/bXKeY7tkJjrMUJcDJG9RHS3igcL6Vrs3Fo/sILKPjR56pDizFql8fUPuaelDP5W0HdDrC3t0/IUthPNKL0C4NwAHbTP2SQCi2ELeYpt+4Dda4y+SA7pzDHiZBLoANUclptGY1ItjgvJVWylSJAL9p5zLfOwkE4LmFB1PldcT3cw0xu3+RWWIQndAvB0ugWl1k7vf3hQEbtq+xRM1I0Kj7UChpPj2VM+JpYnOnGKeGSvVug9s4qaUkSnCUwdvRRFsslHJB4Ij93iJ3Jx/UNVMc2zMKYoMwZf2v9nDEHz6Gvry7zO1wyw82X+B6iFICx5Z0G6ojNVRwZ/yZqb6+F8kjWOocTYI1uI8pO31qCvQklWCA6TtVW3XbALzW4cE15/49xEfab3t+DIEzNJrYzQl7U/hYiylG61K6AZtxJz1BtkLK7BwB0+OY9ADH22TbMZ+3IPvwN26BeYL9ql0UxDfUkKgAbsnXePxpEydP4DtQ;4:hQ2SaPrBOFGAqJran5XZYb4PQYfa4ikH617BT7CLRG+xRT+qOZDc7MGJlYioCVvLSoZlfyDjHOepV/NQD2M7hUZ9SXza3A/BYkSS/DfX4VuGk/97OPGL+H8MTkSdXktdPIj3n4lzMBwKiTWqMc6lpiktavaeQFW3JJqP+kPbdAdrabQ1CaDW7As2mNAFPbgDEXHk+HiZMmocQULhwvOqAYX3l4pxx73/vegJ98Yo/wbMul47jU7HoILAp3o45+KssbiwFGwk6xhoUG6bxrWCLRG1IJGRW51b9CyiJfnpIxiBeKattJDO+6SH6k7dQfxB
X-Microsoft-Antispam-PRVS: <AM3PR04MB3394C2D06CE22B92AA9B4F094440@AM3PR04MB339.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB339;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB339;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(68736007)(4326008)(25786009)(53936002)(446003)(6916009)(6666003)(1076002)(5660300001)(486006)(956004)(2616005)(8676002)(81166006)(81156014)(8936002)(305945005)(14444005)(3846002)(7736002)(11346002)(6116002)(97736004)(478600001)(2351001)(86362001)(6506007)(186003)(316002)(16586007)(76176011)(16526019)(106356001)(50466002)(51416003)(50226002)(52116002)(48376002)(26005)(105586002)(2906002)(476003)(47776003)(66066001)(2361001)(386003)(6486002)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB339;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB339;23:hUKZJoOMQWgRl0ZOF99dC65ksqTgyEy4r3FnRhXcay?=
 =?us-ascii?Q?wWL1LWtkvNfim5niuRTChH/AExpkDa3fgAFc5yei9RmXroNuIXOOGTDgx0D9?=
 =?us-ascii?Q?rZN753PkajYl4/eufxOAoUsbrLil0Rbe+ClzUPQDYPWl7ZhOHMckplhmL5xy?=
 =?us-ascii?Q?2ctx+8QFhhFyE2/I6GDLaJoNYlDMJK8W2Zse2w5+DJTRJFNkVCfRXxVyC2Rr?=
 =?us-ascii?Q?CfSqp6kHOMZjCAE248+ObM2sMgro7yI8Gja149OOyXV4i6PNTNMd+YHuv8S0?=
 =?us-ascii?Q?pnd9jcGPF1hOUx4Hl43alVtP2iojKlE2UOdwNhtcSCps2WiB9xLaGdObNMKq?=
 =?us-ascii?Q?h7ta/BJQTmjcUAg7LA2+6m3BrAgN2QsjAcCZjpLwo/1G7twLSahXC0U+iPM1?=
 =?us-ascii?Q?TVMFHsxYWplQbUYbV88YWyYThvkf/PCbdZmNrGSIJ+YF5l1tcKUal40EUOLQ?=
 =?us-ascii?Q?467IypXrfrs8pinYvCcsFnNCo+Inw7upYyJ0FGivjmGQ1FTiinf6pCh3Lv47?=
 =?us-ascii?Q?EXEUBarKulgiG3pqT/+zaANwDqZKZEK/2NcKe/rv0fDHQMK5MdvpoDCi7Mkq?=
 =?us-ascii?Q?dBSbny/p5zlZ0cfYuXQ6prdBvfhaP8nptFqa3yMYJi7q46FXnewsUxY0yCjp?=
 =?us-ascii?Q?xxrpuiA4YG9d1L2SA9LSx8hKEi7RV/ejkkmW6K7OASZErKCpTcbf34yw0I2U?=
 =?us-ascii?Q?gxQFRP3I4U6OLMjHvzCkLMyLY86WqHnafv0uGaUIeeEBiUtUfEnwPtObXWdJ?=
 =?us-ascii?Q?fNUnA80E+rzfj5RG2Fh6yk9+7a2dqnnp7JI0lKfD84FAt77+oWBEY8GYGWq9?=
 =?us-ascii?Q?Z96XFjVkywhuS4r+8QmpHdpHI7HFThYwtukRMp17o7ZD4gCjTcZ7pl7mYozl?=
 =?us-ascii?Q?ZaHIKZz8ulSOlpc5woE1phxfFa4zwZ8gyobxnhNcOvg9ZB3FPNxru0WWcVfn?=
 =?us-ascii?Q?/3A8WkZOqcTOaqN2tBv6wRCc5BBv7oFsR1r6QC7+aRJWnOTzqE2FBOz4eHP9?=
 =?us-ascii?Q?1Dsaa4uXeJa2mwHRDEOgWdRir6SGioFDS6k2e3nm0vAj7D6S+i5hesXwtXk8?=
 =?us-ascii?Q?3UqnvO2ovAXrxIiriZZigNMwziTjUvhh5sRuZT8EBICZ+jCSQfULjF7xh62+?=
 =?us-ascii?Q?EGMCdNTk7CB4JE3sSGd5Aprz0rvf5FGaKlumFkOpPJ+qwEV3bU/nidwQkBT/?=
 =?us-ascii?Q?bVQwtQQMy/aasnXWK2IQmelbte6s7k3VGcwwvngudnARSuLlSm6tfWiOluGP?=
 =?us-ascii?Q?5irfZDdPYJmiCAfb8=3D?=
X-Microsoft-Antispam-Message-Info: qSl4f4ZTApq78yUg2Haxv+l1sbsEk1Lb6z0d29grWz/xgxqNYe26hi20PJKWrVzFwiYzvOdML0XtfQKeG5QNUgBiaTQBudFp58mAz/+a+G/IXKCjxr/J+5B2Eg5VtKA/pCfxHJzN7ZqHFc+3srLzXTqIwX4mu1FaZKhBWSfiLQvFfslEhriRqoOCa4UnoWPneIL0uc86Qo/P+iruIQzpBJADk4CodsXWsA18MVEeJM3e4jZfreBndVw8Y/YFICWdZe5ojSC1Iym9iALcfSa4go+oLAu+K7o03z5NLOfSeLj+XDmZt9iWt/qDaIaVlNcWC9MNt9ZGLzDr17A6LpY0t76ZJRP6eIUmGLASIITNwro=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;6:mi9WtqO3cqn+KDigZIX3bvueTyMGi6D0B0Z7KmS2l27f2EbVM3tx5OKF59otyI7z21ExnEvmpEeOrFuo0tffyWPwTJ7m1uAyGCeHI2jKxpsZNj6j/xT7Wx38EuumRomaqH7cHWxDLyMivNeS9kyxuuRaQvJFB142phZs9DdhdC54wiGMrVFEwvcrYA7VC96nu4qXlnoCII70p+1eijckFtO/K9A30QxzJC1g4HiGKxAf0UNypTt1mWs09c4/zbj5w5jeDOY34Fb2ZlroGzgXR9y5P8F7GwoTYPxCLdb0ryl5Dw+MSiLgMDzi8AK2J2pkWZaonBHqH6Q5tMHnhqsu3tSEPewLjDaReeD4tk+/ic16EDq3tqylbM41pfQBe0dff29juK0yxWQgnjRFoD6WqFkV6df5P8HpGD7x67OkcGfSyKn1+NEB1EwHSqOw6dwCMz0PLybeKjcmMtky8Xn/OA==;5:iv7/55ZnHkfIhrvkEiHCmV3sxBLDf7MHQRVar1+PSkja2UF+Bvs4oep4CLvYMhiMlUTcdkxmwIzV11TRty0m2D4WnnO/H87eASZuCyYvCJaEGuZa9bBdfEQgN17bWfS1rjVd0EHqX0ZM9OJI1+mWQuIoRJ40Iucac/+NqEQ2jPc=;24:x0rSwEPgnoOL+Umrkdcbbd4RwSjXhvE0MYJI4QgKbmVAQZ10qNw/AC9UhdN6B36izVMcABtkfFdiOUtQSaHo1RZuN5raZCdVixmtthmkH0g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;7:lcOzTRdXuWYmbZJ9jJaOS+t5V/6IDK3hHLzh2BccGS79PKu97ERx6cWXLMnVY2Ca3xid2W3zNSZIwhKsnrybBuivVIwuzmC8R7dhaoUx2nxuOezWjM1+w2fUanUcV7ep3bo7hrZrTGXR5MNQKX2Hcb2UrLzibWPQQPRvBu4t+8qr6d26KRBvwPBMCAhgPQu48SbqLN5aI+bNlGyXjteFxuN1tWjYy+l2mCAWSCBThmNSXodRtOgzkKnOtG2D8h7Y
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 15:01:31.3739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bdf05f-cd24-48cc-a3f9-08d5e5acdb99
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to call dev_set_drvdata(dev, NULL) on driver
remove since core kernel code also performs this step.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 6331e8d..439b260 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2676,7 +2676,6 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 
 	fsl_mc_portal_free(priv->mc_io);
 
-	dev_set_drvdata(dev, NULL);
 	free_netdev(net_dev);
 
 	dev_dbg(net_dev->dev.parent, "Removed interface %s\n", net_dev->name);
-- 
2.7.4

