Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB0AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1471B2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vbR3yPug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1471B2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeHaNEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:04:37 -0400
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:12752
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727207AbeHaNEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn9q/nFhBobgbe0QBdNlauvTWWK1unTUFaHZyi/W+kk=;
 b=vbR3yPugiXBXmxwfnMKJ6dX/yKkhldYFYoz23/IQAsrv6b3RDuA/3CEpZfLrwKEq2MgocD/ZzOFLeZ2cVcm4ouPlo9caVxlLNlw91Ljqr4ChRL9KxvQjf6UKDVNJV4AplEgkJ4fmr7gtdRqSBA0McmsWlSuGUz70b3pE/Mzs5oQ=
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1035.eurprd04.prod.outlook.com (2a01:111:e400:581a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 08:58:00 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com
Cc:     computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org, david.wolfe@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date:   Fri, 31 Aug 2018 14:26:01 +0530
Message-Id: <1535705763-26369-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:3:2::28) To HE1PR04MB1035.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22c3ce51-af62-4a7a-d3b7-08d60f1fdc8c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1035;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;3:bV17ibsZkPcnR8AQYveuehB9Ifs1QyoBK68aqRhDVoCND31ptmzscsAJrpaC9Uj3kxHAuOmshMynAUyaZUCf9yv2G3zHWduwIZ2/uue/HtWRbfA3Uoozh0LJy/IBf2E7Bx5wQuqWE6LkQwETLjnYObN1K2Dk/Z5ZdIO32ZReA8Nf/VKFf5P2aOQot8EWSgf2XQZ18hnCqp0+8pwalWREll9KuXKmrUf454Gapf26FTbfREh0cVyj+dSubj9k+aQR;25:2ZIiNeOlXTKTD4vOL4CgaNrxrPA2shqOl8U/CvyZYW+rC3mbersDvXLZ0qF5glwF8Ffyihy4E25n5p/pDwBqttBkx/ue9z2+ivGSR3vm2qKecc2Bz301vSoI0x+5JzRcU2NTtkMjIoHUdjwO5i5Lzp9jdTRxenOlrEccYD+1U0CmBdEEO1gIWgpEUZBHU1qu3LacTHbJoQwJpDBjKRPgmt+y0L9mtI0KO0ADHpha5MHPO7hrxeXD3E4Fw/iYLabuJCaBYF098isVg6mWX9jcViHFDkOeYnSXsotO3oR7ae1hlqfZEW7H8eAwUPb+4LXxXkjjzQSeJEdiboS7qPB/jg==;31:fV4EHhWzYdBLVuyqoOREItHV29/ZmYPCwAC/ILxqGD4HvrsJOQD0ommHucASE+NnmjyHmh4cUc6qYe9XLVpdPyVvhRSe8orpQalig/PylJ5RUYy2lYHACasSUnJDIr01Ikkcl+sNRbea9bPTB12xDn7RvTVv+d42Qt+qzB26eBynTA0FSQ3D/7Spl/36hyX4tT7yBt8f6fpZi6clYtTGDLbbFCsPr0sk3ZHtxJh/vNA=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1035:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;20:rq5D2ti81saIpcNw3zrQj6RebBfeB5J0y7Yw24Xy5R0yfjt+AB+B+wqE/SVZ72vkBRJsJrTVvhQZtdfSxiLpY38HjMVTQG/oy5/2qh94Ul2LvREaoGrSR8qm4YlCCat7rQ2AKpTfxDH7t+/jd9LIqFL6UKwx+V83xLq+reXS99Qs2AhevXWw3vI/PGOEK52s9HljnGNFrffE6wzx+y4OJnAg5UuQHgDpwxI82i7KzG8a5Rx3DAmaCKBiN6oD0u5PplwV3HsHPIRMV5vPyD2YBwwifwz9/wEbqpig+d32BE/5eq7aI5TS5HK9tr7oZtEFDHM07DRE/y/ktiL1ftWYEpdoMcKPK1LrS0+6LvIFHALMFY/Lm6rxAjwvJhV9j2pnbj+Q69CBWRLtE9aOptPj1gsp23lGmBZEmRPK2wvYd50gQOXP1HBEO6E4QUJ+Q74AzCXyz7b6K/mDhzwNZ9Bx7MMqiuv7dYtdlhgEs7naYMNg1Lu0BZWx6osqmQIpM64c;4:0hV3wAHF5RG+JwHyY3NK0BDoVzVOVdDk/Z8aUqGKkSgrugo/SkqabafzRlZjPlKqs6Yc4ibuTwAyzd800vrXrZl4Rezqv9C3wruzRiWWV5NKbg5dVoIk6CT2unOfAx+ThjyAegrZY4j6YMcutNTsHIcDdN+T0ZWalzibSBi5XeAM+no0KWG96lVFAOLjbLCJlY+xdHPiNXn8Yp3Aiwe2jltuV5NpukVx6hvg28kDrB69TgcezID8TsCIbq2P47F3f26juCC+zbcBUJDWgUfSPg==
X-Microsoft-Antispam-PRVS: <HE1PR04MB1035FCC93FD6C6588EC918AB990F0@HE1PR04MB1035.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:HE1PR04MB1035;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1035;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(486006)(66066001)(47776003)(16586007)(316002)(476003)(2616005)(956004)(478600001)(68736007)(2906002)(3846002)(50466002)(6116002)(106356001)(105586002)(36756003)(81156014)(25786009)(53936002)(6486002)(81166006)(4326008)(6512007)(5660300001)(39060400002)(26005)(55236004)(8936002)(16526019)(186003)(8676002)(97736004)(305945005)(5009440100003)(386003)(6506007)(7736002)(50226002)(86362001)(48376002)(51416003)(52116002)(110426005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1035;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1035;23:eTC/3WwOoPz2ml6ej9OZ5TUyX8NIg2Gd6Vl6gS6jv?=
 =?us-ascii?Q?IHEHyaF+Lbtkd0YYL0RBh3gMvl1C3OgRMN/OAaGsgv7ZptwW3qdNSe0LoM5Y?=
 =?us-ascii?Q?KDmPMp3zsv0/z2/iB0Y7D5WKVLt6YccQfvkJ4ttAjszTc5wZrtE7FsZ7VuZY?=
 =?us-ascii?Q?Q+dqWdtu7ioeotfFmvXMQXo5b5oZpp9Pvajq15suj1Z+B9cUwEm7KEcwF+h2?=
 =?us-ascii?Q?2UEkwAjrW6g7vtlYz/+hYGqX5o67H4Ohm26pt3ECMRss4B99O6TkBM0hLlie?=
 =?us-ascii?Q?Nw0mMYWvQSc49gyAmOwbDpWUNJtTKY0mq4o3R5wuthNM1Pd+CArqtLMR6U6x?=
 =?us-ascii?Q?MLHYSUMiZSkGq+zoveSD8FCHGb7TueM//4pPZDBL0rH9Gt+GxLGrX1WnfJYV?=
 =?us-ascii?Q?ZB4cjimxol0C7D08vn8gNOvuayZImXCf1mIyTrtA0apVl7JGco5l0wKxVPBK?=
 =?us-ascii?Q?i2NSWJRq8z3WFcL4PKwTwdeUR0siTLSUYIBh2tmrtumCapoJU81df80ZyZ95?=
 =?us-ascii?Q?sfPm7T25XZUruOxwioWDJI/YVJPZ0PbWDQhB2olB5s3XdMdFlkZynKgvW4IG?=
 =?us-ascii?Q?aIPX/iz6eoXn5m/w0mBkoqLIyiUa7dNTYVFdbs4OAOD3KxFQHXu6QiOtu974?=
 =?us-ascii?Q?UYs0S15vxboT04WNoAySDUxBr5mUfwURJzdF9cRbfdRi5aB+mP2/w377KaL2?=
 =?us-ascii?Q?poGB9S4tLhsM66tAPR7az16Ya5qdwFeNPLtNS+hqWBMBzV2tS6gKt/4LfiPO?=
 =?us-ascii?Q?zAWvkcn1f5GSwj/9eXk604DuQsVmih6Gfh5QSxusBfZXYkl73NNmBA8OSRso?=
 =?us-ascii?Q?2kVAuHUUEKjCZrAr8h8rC6gSHIiR6ESaioT52yntovkiOVSnOSce5Uvz7eEc?=
 =?us-ascii?Q?l887kqB+RhxzWyq873Vo/sNlOIYQwMUYGCzx0PaDJ1kXD3lzWgMnM98njiGb?=
 =?us-ascii?Q?r7e7tLUT3g1QgM1SVeNAiEFCTnype3ZzKFmiUIwWz3LcyQ8na26WkANdqTGR?=
 =?us-ascii?Q?k4W8ql9N4oTUkxWkav1Rp8RnTDnGVclyXSNixEE5q7K5Rj4/dLOMcInsF0iz?=
 =?us-ascii?Q?76FuqBceLJbRpbrm6WZ/gnpY9Bze2GdymwT5jseq4vVUbuUjPgsmVTMCwgFo?=
 =?us-ascii?Q?6MB2zJbCUXzDh8vMMhcd6F6BJQAGxS3neUXS4+47vEUYl+6ju+7VGnQAYchx?=
 =?us-ascii?Q?CSBaTA/yG6lWXOK9LzWuxVRG2Y8A6JHHAzcySjlIJyOaFZ3skj6Kn54v0huV?=
 =?us-ascii?Q?jIt9ABbJbjOHI9/2tZBNGZOCl2cL1J937lx4pHG?=
X-Microsoft-Antispam-Message-Info: nmxgU3jdCjpz8EbZ8bbWcJwJVrhdGJ7IGDEq4XXzA+r19lNpCypBHgxJANzn/lw+kVBPisWxhhldWx/BHSWGN1U+zto44G2iinDmtvoszROtyjrUS8YBpvdeNPTedNhiczqZYVUwl2rueMY1wLHH5UZgodefqVxsIgNXs+SVbQKemvMawSLu7ATj7rEFoT+JIc+4fiScmA2RjrHhat5ut6TDMq0+QZr8V98qkmMiRUpJT8yBX07tXV4BkIlWvQmeYuuNnxS/2OOJrkTCyFmE2iaq+NuS8SiiqgWefvOVrsIowiNavwN7oNqQjDaWHfHvHxjZ666TsshVN4Xmq5uXM5XS9SqLoM6Lo9IQcvEYCV0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;6:7tCpzTZtkTK41vTd5+6INdMn6pnfuIebzh41xOQGMjmw/uA1asNRdxT0NJIpJuRm2qc3Pj04gbwdq7qd4t6rO1vb2sXB/CHoOpWrsDsUQARd49YhCLrKXImcmt/+5syXkfbyyjuoF5YPIqpGVOL0nIBSmoehxSfXusMnZIehFWWaUnX6OVNVR8nTUIUZJ1itHoLduaFvjNRFgr+4SMNXewIeFlIinmySdoYg79eThN0afgssSCSF8Ax2JuMbqAFya2SaXMJfxF7z2fZLBU2ez9VvEFLIRArrRjZOTyGnoS4pQp5EGantfoVRYt8oT7BK0unOi3LJa2bJXGWfMTREogNR2hIRxnHYMUbPBrWlnQpwGe4meENC3JOEdj2YB3G63vCuSXR+Z2gDb+W6jUTGPQn1GZwlwLmLeIQdgkmFmD+qvrS7LUVlS86frVZ6fKDD6YhpDRQ1D73qWL01Dv+lGg==;5:VaFDJJz9TjMDhLyqbUckW3pFHCNT72AHzW20MHUhcVPHbRBOwKpJo3m8a45Q5cpbljbv/118GUDqQYuHVIvmUr/6Kvf2logNORIIL8OCd2PFcqfuS6X6A7j49W7zcSU/cn8rbBWP4gedOFH0jIMtG3CoIw1VSSHubJLtANJ6WBs=;7:A5zVgIfzokLg4ron6d0/FmVGusmkUKvB34x0ho1VXiILxEje9iDg8LHmi3UN2+C1S7Bf3jFKBt9ZeoSjaavmHzhs69rOelXSGXppSN5YIDV4ExznMK9k6Bp4MiE6Xf+7Pl7kHtu7eJsgopWkcPb8sqHGaWS452ZRbK0MihIFepkW7CgZ9QLqIzfhC4CoFYkzYxHg8208Sj1UkGjTCz0yZhbzPw/KuhZh/icJb9yZfSTIHHVmFxiDO8w+yObRH3xH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:58:00.4685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c3ce51-af62-4a7a-d3b7-08d60f1fdc8c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFR_ID information, 0x002C, related to the Micron flash.
Currently, MFR_ID 0x0020 is being specified as Micron flash ID but
these are actually CFI ID of STMicro flashes.

Rename SNOR_MFR_MICRON to SNOR_MFR_ST and add entry for
SNOR_MFR_MICRON having CFI ID value of Micron flash.
Add entry of mt35xu512aba flash in spi_nor_ids table.

Yogesh Gaur (2):
  mtd: spi-nor: add macros related to MICRON flash
  mtd: spi-nor: add entry for mt35xu512aba flash

 drivers/mtd/spi-nor/spi-nor.c | 12 +++++++++---
 include/linux/mtd/cfi.h       |  1 +
 include/linux/mtd/spi-nor.h   |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.9.1

