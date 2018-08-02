Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FB4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BE52098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XB6pAXp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BE52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeHBTRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:17:11 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:51040
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbeHBTRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0wRXvWNtrzKMw1Ns7EPEj6G7zQcznKo56WrJGc/FOU=;
 b=XB6pAXp2t1Nnb8O6rkFTVzJIZdAvD8OQ4nrSI00bauK9Z9UIsdpR60XcwHsXLyAj9ZUotlCKz7IwjCv7ElaF6ycV3KYydjJqQh6uviHyvCamWZtGfPv8/RvqY7sAs2Z7hiqT1wr+krY90NCewWaUI11N14vwpN8GrvQGrS7PH8U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DBXPR04MB350.eurprd04.prod.outlook.com (2a01:111:e400:941f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 2 Aug
 2018 17:24:56 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH] staging: fsl-dpaa2/eth: Use named arguments in function definition
Date:   Thu,  2 Aug 2018 12:24:42 -0500
Message-Id: <20180802172442.8888-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To DBXPR04MB350.eurprd04.prod.outlook.com
 (2a01:111:e400:941f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06ab2147-0b68-469c-b566-08d5f89cde80
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB350;
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB350;3:LtcIk9XVJCsDO+Af5zXFb4M8QkwYReUiH0gtLoCrR5ys6+dPgr3pLN/z8t8NsgRUyuA4lRKbToasJ5B7NAPfNDlJ6s72dlx+s7AtQgltzaoK5S4B827qQWxpwLaWazSFMby2q8ejf/hKJO5ZuY8zu/mNRw4QMfkxa4bVm/x3scZ/yaCGBetA0WQek0Zyh0kZ7mANy6aVKiO29nZ1N5UOI+6NypobSpniC8HEDILz6xylZlf/CNk4jUthIdXlMnfY;25:QcnU/BeQq2kzLEVJWoQN16krgAB7loW9SwEhfkg2VcqbYaWlHrBIUfTSKL693wxslgkQuWgTISCRbcT8tczi/5ibBqGeFR1eKs930yYX9YYoxa+3EdcYoR+BEyUs9wEJo3BiQJhCjb229OOtyvvUPmO9hFqgOfmqY3x61BpjKCAqbmt6YYQ3PlZXYiwuCxsOyWKjHhwYMKmIAIIIw2rxwhKRp6VAaXlNS62w6lz+MZ4nfUqw1q8zLtitvRaM+mdw91MVHNsERBQHfIm6feTVHpYFGRD56r1+G6pgV124RfQjgkRUZZ55rZtHjHKPMPOZ7GeInTUMIPy/fuuVF+lmxw==;31:/4GmdESQjfq7tgt9ChypktYjguyNV9nYs41nDuL7Oyv0QBfLZ+l42AEDcd4tLyAytWUFm1fDXCl1KTRpW+6KKGA6DeJNnKq9JRXPLzSRky9tK46LzJUF6L7XmAe+wzkdxjs8KqJPUZZsl7r70NeFIRBuuHB0y4SLFYhVWLSvAPWIRbN4McGliW9hM1lZqF1mIuydb5IAzBEceNTu+EcbDAOi1fVkPWhVCIscir1dD7Q=
X-MS-TrafficTypeDiagnostic: DBXPR04MB350:
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB350;20:eNrTh9fml2xqezAwZKuNHej6E7Ls8tvnrGQNiQKHRQt/QMCg0n7D0eh2piua/HoyOnoJ4MBn9DbqpE1TzoFBreS8aZVMdKgRbo+gosO3JhAZOGZk9IKIo20CeXKQEe14v0ikge4JfFZeehj5VSkvwcH70QGzE2Rm2qHpqugUHcCqn3Kt1xbYE+2/2UOKeaP4h+b+C62SCDZginQDtXqCpQj97N130OqKQipfKfrng6DWUMye9qT8GcEjJAZDJ3ELt6/jEZcW+FgxNxbCW0ndXd9l0HQBMsZmeAOxkfl4fgfbN4IP6JiRFtsazHXTfWBDPswIL4kngV8H0eHfPpky8nI0hvQ1TEss2lFL1czhGPHkczRlDMp1zyFzmtR81J0lvPcaM1kOFc+ZVVMHPLqWyV+LUJs/SZZVcK1oQ4hZzDwvnSJT9pGrVD2VGRrTRBnhMMkucCLhBZSYG1z1Z10FKWEfwDsYmd/HHs/EtIDBOkeyEnCTzBqME/Du8TbsyW75;4:ai9ME8JRSalBK09xZk0Vs2YH+N6/0ZO3q++mX4qk95Q2INYZwYyuX+KoQTDYHP4/RVJCTpeqmbX+A9nZw9P9udpvaGECUjFitC5eqQUrQlwSyPNugiWLYSV9zh0gTuQPKhTz6vssZVMdwtnSXOmQ4K3J1SzEZtZflGmNPcMRxrpOFoYbY+i6INAd3+R55SK5cxUDmc9x+xPqTSTcnU2ErT5Zn7NAdzaZ4O957IX6SMFVu1v+H+G8qKMYeHp4/CIfs6KGrHXVXRUGix+6w6BNHjs7I8EM8yYFB0DFY8lfbe4GOMIIj4ppPJNnnNhHIGpO
X-Microsoft-Antispam-PRVS: <DBXPR04MB350167301865849E402650E942C0@DBXPR04MB350.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DBXPR04MB350;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB350;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(16586007)(16526019)(486006)(36756003)(68736007)(8936002)(50226002)(8676002)(7736002)(2616005)(956004)(476003)(2361001)(386003)(81156014)(6506007)(81166006)(52116002)(316002)(305945005)(26005)(1857600001)(51416003)(1076002)(186003)(47776003)(97736004)(3846002)(6666003)(478600001)(6916009)(106356001)(6116002)(2906002)(5660300001)(25786009)(105586002)(4326008)(2351001)(48376002)(6486002)(53936002)(6512007)(66066001)(50466002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB350;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DBXPR04MB350;23:dwl+KdpiOlQeR3xuHaKF/jvcfgXKKaA1YPNIH7c89e?=
 =?us-ascii?Q?XAkIuUVAw4GcBMgHAvTXyS1vj10grg13diqxXitvbJB59GQPiasGSf1jpPpN?=
 =?us-ascii?Q?tLNTSKw75lToteYR9eKo3oXDy/leDA9iPzj/WlN2anWW8cBa3PaZTytyI851?=
 =?us-ascii?Q?63houz4wDPj8cuLSiS+AIa9d/LAiZFgGd/Rg4Ni/WRZGrZAEZLWerXbbgskQ?=
 =?us-ascii?Q?xDNRWsz83shStpN0dlhxEFhQLgsy47lnLlSsymyG7l4L28ak0gOE5r1JqNCa?=
 =?us-ascii?Q?YF/7fZFUXGtsYcfZoHRM1R7cV73QVXz5SgS+HPonH8VZET6FcfXSljBvXqKg?=
 =?us-ascii?Q?aNVQV9jD5D+Nf5KmvuMJfMD62shFcwAgUO5QrA/pLPIljleEkM1/CW5UfIfp?=
 =?us-ascii?Q?DKZwrx1Q5HB/YGcy/WvLx3c98x5hT514s0vYljdTZP0x0zx5AuOFmlegYWSP?=
 =?us-ascii?Q?y8N+RjvoVTFJ1htZ0SUwUFqsRpUtux8Npl4zNCcrfb4rmBGXgyBiNU7lSySS?=
 =?us-ascii?Q?e1WisAiOqkZNskd4g7jmR1U+knVCNodlC5gfC+zbcX7rixM6iRMHz3uoyPzq?=
 =?us-ascii?Q?jzDqkAWUPF4gOkIeXAp8xgxqgknF8CdTZGD8A88rGB6T3UISEFqkM0JiWuEO?=
 =?us-ascii?Q?mkfh7NVtZEuyZcghdlcrZHtwOVq/Ifj+TrPiyyIzCjt0r2BcjTCxunrWOe1b?=
 =?us-ascii?Q?3h60NgFor60oxaaFcM/GQjUXzFYiDxi6VS1GjLZZZWH399n0BYadiHzZA/73?=
 =?us-ascii?Q?KK1wMQVRo8w7p1f/LquHo3r+CaDCeWaZweJVo53PS2eDdsQBjaQYFFJTi0rv?=
 =?us-ascii?Q?coDUaNTGVyMDFJE09CunRfpL6Ci1qnHPYX3LTHb991FIfDwgVj1T4cq7erPf?=
 =?us-ascii?Q?96ruN3K7CjUc7whcqbRgEs7rHmjF8AoNa5hvO1+DmadU38SX2wQQLes5hF4k?=
 =?us-ascii?Q?XyMaR5iNr6EUVhvGpMkmV+RNwixSnvmGGCodx5f1c+XjFZ8KuHIzqxVowJLm?=
 =?us-ascii?Q?4uqMOI22ARHEaj+nkRAoLQmfjqA5WPkIF+AbmPwKLG0FjrIHmDgoWEAaXxHU?=
 =?us-ascii?Q?7DnZ97ZTPnE0jNJM8JnhpJv9ErRddR+jhyNziUemCmjkcVLCh7urt1GW+w6k?=
 =?us-ascii?Q?kLOVyMY09ACsou76qZtEK8GvMNxJMyaqrqFfsIcBt1o4llbQBJDqogIAoXkr?=
 =?us-ascii?Q?BAZFLhyub7Vpo=3D?=
X-Microsoft-Antispam-Message-Info: /t57xSu1goIwEL8rn51AMGKuWNB28BVIRDSYksbYm8PaWnd4oJMLTcgJHqDk+PqfQkw/8F/Ku7Lr5LBproM9hX+nkbVwzpDXEy51rw9IJWBl4Z0lc84Y2SZvbj6dNZ2j2vTrIavI3PyTkixXkiqqv/CAjkNW4rnTMwKzKitMLq8RZhGrR0ew6Pd5WjNqPeHuPxZGSiHIEMBNO9LGbgySPR4pfrVoKMGc6d83c5xPjzYHBhE6aZznTgZQORetq658Gp7MrxrR9R4Ntaj252+urhiI1QKJjPLRwuO2mDRpd3DRx7GIyyyC/CtmMBZTbPX190aS3VD3PPYrLobp9gBUTjICcSMLq5mX5lWuwPsYTSw=
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB350;6:miJ3dfiwRlFk0b967j7eZHj/317qaILSCLHXCgsTA6Yyrypd5X2m1QFathy9bXraq68bJ1jWONFrn0OByBGBxjWLA9yOMMun5OQgLJKUOBXNzai5QpbSIXPbqrFGBSemqzPZGKjnXNZ4Q387Zo9Y/XeKox69AfbNxJ6FwAen/a2yy2y94+mgjMaRKUNbJ5k2mosrtfL7JmFqCEf6t+UktioUn7VD7GI2+FkHJLnKzJI+LhCDhHZQtnkbdnqH8mlfhoGYzLO2EFKy4rN8zz6UWtK7vm/J/R7IsSaHRFfc73HuLJGuj3vdEhgmx5SPrDS79yu/BooAqzd9Zl7eNgdIbpmXQHBsEFJgdc1OJzDpVG9lJbdwGy7FIvQTwS0Qet75+8GKaHCFkyD7ti8kMU0gfSmBlDWZ0DHJpfj7MO/Nmqe6/0WZYkl1qcFdqTUzVLXKUKYNJqZKg/dmesoIj5pyqQ==;5:Y1Y0u/KC5yH4bFdh0UR92jZjLaN9o842lLIWDq+7yfQ8toDuW5hFOhnV/vYphev4Jnp2Dve1sSwJFoNblPppFbKTEgbdwfoGaKhpeuiPx3O93PbY6pNcsFC7dsaaSyfCw+KmmOufHLoNADlc9GkseBIqPgspnwAlK+w+2D6Ogu0=;7:viEP7vhmYU7DfTIW6ptqa8FcjHIgeSQiWYQqCa5m3NcZyg5Qizs0LblahhGyxMYHu1OmOF+NCSSQ+TnWcXr8henjbK0eFHP7SMLfDI5EEH3nzLJ7EENUccZY2SMV515dOrqr55DXa/f6my3GPHlt5Ilv1L9TM6pcVhq6X+wK4y8ISNcDnFSnxdObANRniXHHBra+RaEhMUZUU5wdyqG2tMaaiMSZN7/2R1RbUKIbDATbElVHjqJBsC9B8FNdXpuR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 17:24:56.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ab2147-0b68-469c-b566-08d5f89cde80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch complains about unnamed arguments in a function
prototype, so fix it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 6b70c66..5064667 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -277,10 +277,10 @@ struct dpaa2_eth_fq {
 	struct dpaa2_eth_channel *channel;
 	enum dpaa2_eth_fq_type type;
 
-	void (*consume)(struct dpaa2_eth_priv *,
-			struct dpaa2_eth_channel *,
-			const struct dpaa2_fd *,
-			struct napi_struct *,
+	void (*consume)(struct dpaa2_eth_priv *priv,
+			struct dpaa2_eth_channel *ch,
+			const struct dpaa2_fd *fd,
+			struct napi_struct *napi,
 			u16 queue_id);
 	struct dpaa2_eth_fq_stats stats;
 };
-- 
2.7.4

