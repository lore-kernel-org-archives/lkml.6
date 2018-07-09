Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C10DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F015620875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C/HJ0GD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F015620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeGIPBh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:01:37 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:9760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932879AbeGIPBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4J9mgWK77soOdrqmPsREt8PK0yJftKZAJhdwh3Ihc0=;
 b=C/HJ0GD5nknEpx3WVqVyhPZ72JvxN+pw6BCGEe4LIpZYYbf79O5hDttnB1ediwaGC9shccfgS5UTgIBKSX3QGScXBgmQy1+UEnxDgzo/M5Q1DqvMLzC+mrBq8bvDwKNWGLMcW9ULWO7T7k1cyu25Rb77y+4S9B2+Y23uNWQpqRg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB339.eurprd04.prod.outlook.com (2a01:111:e400:881e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 15:01:29 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 2/5] staging: fsl-dpaa2/eth: Remove obsolete reference
Date:   Mon,  9 Jul 2018 10:01:08 -0500
Message-Id: <20180709150111.8875-3-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90015f01-1423-4d8c-87e8-08d5e5acdab9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB339;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;3:MrIr+mxuEijs1i8uFXmGaIDreqRKNfRkE/7MCbgfB7OOZHTe0pndBiC4E4LMCGqLxrYe3TWCt1TwG5Pbt9El6oD98c7UBKtiNZkBlrO/BRjtIMyflomLaVhqI4Z9gNtDUYuHH6PaZkRkq/TDroSzLWQSxOXIZwPDkP7OGWj6eywyg+4uifXf8MgL7NUGDG2nGAnEvh+muApiZuPp69W38zkS4NWghtGYwGSi1bHp2eH60pyyrZVAzKJoeLL+V1ZV;25:+mSv89UXzneFr5OBti0QN2PUs8b0MuMxAN586078FZL/IXXf7gbxddlyiKFpKgT5Goj+FQxhxSBI7jtaVo681LNCzVDQyDNG14CfniXxDf12ZZ79UPtSB10M64tBbq3ZYhoUSl8kr/UCLasCc10wUFzJtffG0um5LtY0uUJVxmB9pgLdytTkOQrcEXzG77fcZvG3cJjNhwg1ddM/huyeILQU05m+A7Z1NzFyn2y/uaVtX0HX0TcMy0P+PWRsv0tRd8WK4V96GIjwaLX4AzfnUQIswM9cgTYtjS2QawffBbV2vlMpy6Y/WjeBhNyC255YVZ5U9mxHy3AMCbNUxXL2wg==;31:i6r6JSvGir71ru8Tt245ZnUYCuEDYLLMN3sFsCudYr6wI9InOSKyTHS5JUm0h8PAk8qb4seOih72p7XDJ5Ln+iondKWxv9g8rKvOcQpuQqIe4YP9OiGyCQggitWpHxLMKyLkcMfRaYRTsXi2BxMaiN+/QHkkJ7E+xmN8YRR55JJGFmvX2HX/y6lqRl6JxAJL+6lp2iTqen1At3TFp40JNzS18t7CJAdpKTG+Uf1nc4k=
X-MS-TrafficTypeDiagnostic: AM3PR04MB339:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;20:d5Lj3y6xoJxzNEZfDzn9D4Yv4bCSgOOvFasgX+5HvFNoR9/9IVX8vJSSu111SAjsKxmOZhmeZCtBbC64aoxTLlXMbsbPc8iP/e/3LW417SQ0wK6NquomZ/xRU9kfXiUSOu7ygc3GCevJHrbQ1nYlDkLo+ECR1LLUjgICTETFMC0fr6c1U0iEOUzfntVj8LkdBhyuxHj0VLnRqNJ5yqrL0uMjY9T00aRQf2599oQJiiv0XQKoNJkTS5IkeU4kW6R9WuAaaXcj6+LnI4xIKWIda4J0b8W/bNTX2hY0QIUHZNsafmhE4YMwWawVlvXD05XWPq2I0y1b0pk9E/vcNnDa6+VjBI4VR7h0++saGio1w0aWSh7s1631G+awS3T/07udhY//M6IUlkVRc9NZxhC/7AazrI7PliJjhEU5e3Gu4uirvcd/p04OQB0y2PQzRdugU9JUp1tPJLuUB1xaMlONckfLSLvHKFO+eIN1NqwX+p1jMBJec4HwFwHsXSKBr8H+;4:UubTXblc24zN8KjMLhYttk7HjSQBHNju/2pAkyXS+FsAxqSPTkt/rf56PvcZ6yLM/PBi2jltw3JzXi2B0u6JMaKqvXyTf5yhjQBS7w5MqEh7IgNmbXfVvRwG5Bs3sUfxVaw8UTbl1p+t92yRGZYV2m+cuwrmgtDOqdLYSQ8Nj5bCakS7x2dEUtwEX7hFhqz85dD3SCHgGwptKygkjKYWPPBZKDfH8wIC+VK1xbQwOMd9NtjRWe9ZlxUDJfDaD6gAAEonqCVIl8togjrvcTvItZdDdk3wFWV2IGt+mgjfcXWHClECiwRgBbT+mfSixP4g
X-Microsoft-Antispam-PRVS: <AM3PR04MB339F3C8892E8F20478E68C894440@AM3PR04MB339.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB339;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB339;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(68736007)(4326008)(25786009)(53936002)(446003)(6916009)(6666003)(1076002)(5660300001)(486006)(956004)(2616005)(8676002)(81166006)(81156014)(8936002)(305945005)(14444005)(3846002)(7736002)(11346002)(6116002)(97736004)(478600001)(2351001)(86362001)(6506007)(186003)(316002)(16586007)(76176011)(16526019)(106356001)(50466002)(51416003)(50226002)(52116002)(48376002)(26005)(105586002)(2906002)(476003)(47776003)(66066001)(2361001)(386003)(6486002)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB339;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB339;23:cLN2Yj30IrhefhZ8RbiD50S3wKdnWCzMyjS/zSV24z?=
 =?us-ascii?Q?lFONrDAmMPAv7eLg8GtwOHzk4TGovKMcQX03SDAEUngvflOST4B/5I1XoRYG?=
 =?us-ascii?Q?1yBEcdi4oJUOSg5bNZk+MlnkRdSQUjlU2diVN5A30re4mS7gfYUUZe7ltQbj?=
 =?us-ascii?Q?juxtzUlyOPYSxz+QbnB29NmQhhmqSKM8yUtULVJ+c1/yjN1D4bSrAGNQ+Ige?=
 =?us-ascii?Q?PPvId1ebABsQ9Q9a8PurrNSaK1EuyYUs5ncn+79nJ8U2NtuVfcW9WEQGjOZU?=
 =?us-ascii?Q?9GOc1QeFNOA8Cv6AYi9T3ffa6ZFdx7sBP1jGQCMAcWhPfnJHnUqHYmT7u3GZ?=
 =?us-ascii?Q?iuCafA02PzUD8PNwujKred2H5XZZTX2+0mHyIbm+JrEfqEnwyLwBaVhpq8nd?=
 =?us-ascii?Q?f9DwImtFgH0T2LC1IMnBRFKrkgWMDOjtDbGg6S3TkzxdvN7HnQCtsw9BS0jF?=
 =?us-ascii?Q?RizYiD4xpjYn8Uy3b7iRf7lhH/nDgfmG/aiN1U7EkSAwFpQq5UZyuOzqlVT8?=
 =?us-ascii?Q?HHM+7rTSc96mbwzZjGBZB+dUNwwaxtHgpNc9k1iFoIa2w6BCzgmxEJL9zbVZ?=
 =?us-ascii?Q?I3L8/sgYFl6gaWoQ9YBdygMWj2hwwxn0VHvJGh7A2EVvwIN8NjSHwmPyEQfj?=
 =?us-ascii?Q?tpNF+xObdGPpOTWUicTNCpvRDVLOvZjlOOiKekFcMSWGxLKrqF3taiJlD4Vx?=
 =?us-ascii?Q?aK3YyDeVCN2uYsfF/G0cfPPV+m6fIhv7vMGzkiUV50ISuUGb8Io0mboaEi8r?=
 =?us-ascii?Q?7eb3tggLP2Z35+KF9pfk4KT5zdeNxDImAJ4azFkxkvyp6Wj3xzOnOHpAhwWQ?=
 =?us-ascii?Q?wdThPmWmwmmEAGOnYIye+HmzEUtQ3QGZ7aDXPjiN9sDw8D5qryTwDRvqXfvx?=
 =?us-ascii?Q?3tlkC5puNHYi1dBosR3Q3EDe6YZY8NmUEURHTVIXNixIyNhIFkf1oivZ59co?=
 =?us-ascii?Q?eaypFu8lf7px46EcJVB5EN4wTWjiAZXYI//kaJQGSpMSF/6ihX/rCT+6hccR?=
 =?us-ascii?Q?ZD6K0EpRMEdfvEj3ykBeGSAPX51TdtV7GhNDzpNOp/eHF3vtd9u7nJxGmZDf?=
 =?us-ascii?Q?3zzCWvr2T0AdJF3yWPClGc3xoHV9S2NvpNcvjXqFrpK1NQ44HHROOlbqe9W2?=
 =?us-ascii?Q?Az+FmQhU6PRTpN9euLisoLv1Aqs4tnkx3mp0E8UxJzLLTSfkxrWLGsUvZnEe?=
 =?us-ascii?Q?BcS0AUEUxcL+MBuqqyJp9HIyaSNVplr1C3teKc0fq6ONjUZW4vVnJaeNexbH?=
 =?us-ascii?Q?qzjsDEIDi7qxboRv4=3D?=
X-Microsoft-Antispam-Message-Info: csBU3ZTm0K1UDB499HpqAUyFFuRm6I59NPy9+rhbvIWs1J5LO2BDp+hGRuEGjpKOjohUuzskn9hXPBGjRyr+DFtmUanFw0ARHLL6+kKxs2U3mmjZL97gf/4JYk8qt0tGg/JvvF9YRHj31ElQYZnMMB2q8un5bYlH7MqzJXJuhIlFs5VPaxQNJA9GylRkcZ83aWu5ydMOZYNFsSLPRxsu03EbAmw2WQ95fXAfKtw7Q5sOAram2kjWu+U6cEW9xXcfDoKA7E95Hbgho3+hu4bAR2AinR1uziT5ioFvJYr7/ThrvzO3chCnts4lwl2JWrLIJ5RxJtOFh2hgSu+BVowiP/sGB929yY8bkKxoykIcUAI=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;6:Nbim5yqx7qpy+MaolBAT6AJkr8efXBul1MHY73RvlWZoE7zUo1Ol+M4JEILFBogdm7KZnWsMUwusH5t2QYZwmGmKSIlbX2TWAN72WmAWlnpJ4J63kHOzWk4ou+zLyTSv926v8beV5h4Ev1pZmc4wLArdQkSknCaxDByVPtO9W3pbTKE9lZka3FcFfRm3KIB6Fdhs10u6e5WnB6jPZw6Iv9uo2s8ip/0grw/JUsOB7mcSA4hRzZs03Bv7ghxHzfu7lErBG51LqI8tn9SW+cWA3p9ml+7orbDfxVemOljvw2QKkybEi84QnXz+jksFa4TBs1lXJppzWQ3jc0hGy5rdlnWyO5+vU0PVrMY8Ymni6GQANH3hk4xU1eXlKY4fxZbaL63RV/Mxa/fvr3O9SzTgQ2r1yIIimr/dE5EgqQlOHKQcjyAsoyVBx4rpZI3igh2HiopPCZegFhEndQKXQpRl+w==;5:2po/ibi88eF5fg1R299hq4sKzthBv1MAJO1+I7HwjArD/+guzDSsh5HaaEfTJZD1468V0vQjPJebTAoS9g2Cx2kNreuw1r4md+BpoIH0PWh930iO09Eq2/6OYGk/VQ5hH7nvTrjpEab4dKd1gHsVdIwhKZtKBMN9iWm1r8k65J0=;24:f3B4y8VJieA6DioOE6aBpFPL3e2TJfnaZdfB1KuzFzriq9nH6d/6s/z6wLcFSpzLZBfancvK2tEHkUPGZZGigAbCMpojD8NhZmxig8Q1w4E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;7:4caCbBbOWNuvK9ZaYv4LbS99bPMoSf1BcJeufhJsss5UI5f8xgQLC4pt876ehMYHWRvWYoF6F21VLM6yH5TXaP88/sjXSsWOJRW/fu94hV039t0FqQrVTV9buO1pVQEJbpqJaOS65y7SIvwZRwKjXjjTR70j6XZXtNMIxJdN+P1wEfjxuio1rH9N3VaRc8xPaxGKoi6Cj88Qlo9jFiYwzJCp2O7dQRPBztRBHgMqnHOvy0rRloTnFwJmb6hq8EUr
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 15:01:29.8896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90015f01-1423-4d8c-87e8-08d5e5acdab9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2b7c86eb7bf3 ("staging: fsl-dpaa2/eth: Don't enable FAS on Tx")
removed the status field from the TX confirm frame annotation,
but a reference to it remained in the description of free_tx_fd().
Remove it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 537d5bb..6331e8d 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -522,8 +522,6 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
  * back-pointed to is also freed.
  * This can be called either from dpaa2_eth_tx_conf() or on the error path of
  * dpaa2_eth_tx().
- * Optionally, return the frame annotation status word (FAS), which needs
- * to be checked if we're on the confirmation path.
  */
 static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 		       const struct dpaa2_fd *fd)
-- 
2.7.4

