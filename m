Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017DC2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NfsSKUfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017DC2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeISK2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:28:18 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:5947
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbeISK2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn9q/nFhBobgbe0QBdNlauvTWWK1unTUFaHZyi/W+kk=;
 b=NfsSKUfTWKHDosSldc76FSpCXLFNDwLy4uB2L2NydrldF1r91QMSQUOEjOVVZ3Tn49v/zsuxl6Arvk7hi1w5kEvii0B+dVu0w7IVk/InAgb5ODbsGmQVwLZaTA68vv0Wv37y6jPYzc63WAEwgF57qvSzzzhH6ZPvkEa+5vFZdYs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Wed, 19 Sep
 2018 04:52:03 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        boris.brezillon@bootlin.com, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [RESEND PATCH 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date:   Wed, 19 Sep 2018 10:20:06 +0530
Message-Id: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1920ef-3719-4f47-c4d0-08d61deba669
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:ps5oECqviilMKTuJty3PTzbjALFqbjfspum/fTM9VPU/RJOpYN5keaX2gOoXungmXVXrZ9wzZqKjRO86vg5LWZwt7JM7se1ax/TY/cY4JxSNxdVaJvpTf9fSNJgUnH4Na/PGIhyjHwLRa3StZbUL8gW09QL1usDxg4A85XarBuplPqDzG0cuq6Ot6cIElU/Afpr/IFLhQWpLGf9LkFUUQrXw8ijJKu2NE+ztxocFNhargDsWbZHU3vE10LMf3vCT;25:cok2o+EWN27wgKs/wZt6rPPewljL99RYXVyfPOcdBe/heSW2eV5DMXkPlVDnI6RAev6IWJLfYnjFCZq5CVoUm11qoP20MDES+BQJdFAKVBDayIPJiIznLoHWiJojkdOaYhkgwjj/jCBz2ufUavaAfys5yvLJ5s369WLh+I3S3zcNQisIlJ/gk6OqUmuotKz1t3Zxycuz84Xi8Dn8M/BTXb50G2QdKe8frHN+5aHsvo5QQtsABPhSZbbJxFp2Ta9ElheiPb4R6/70zw/XX2L/aMCo+a2EQQAjWtwJw5JQhDc9pZgoZpa5Ygf/FTyL3xG7wYQin+7TWAfeMSQQ0k5Xvg==;31:DTs01MZ1rBVu4F/gQVORswmm7qNpxkauxJzZG3ByMcaJtGXAGFHqZiC0lVtMMg7Q0MrC6X5AMObE8rU7Ziur8cLOVJrcQvlcdOD5YlAEpmlNwEDN/E/IyFQmDb6Mlo7RBYklfZYkDwvcIQWn0ClLYsew5ysMQWszzVxokVTA+KG4zb/dPs69xB7Cqi+mHfxlisvGn8yr5sZzliLfazTkyTpdb2OuaHAQOxOWLZlHAaI=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:3/LjrxchwYJnEzoxsUITTJJPBDvoXdDOb0HwEuth+uuqmJKJTP0dQlSLfssL/ZpjRaPR0PMgP0qPaNTOeLyZKDJfFA5b+88rUORbs9bxS2Qtwrkp50d/cJDlRlaSZFvG3hQc1Z/SgLvhbMnk6LNqtBylKH+DxyyiOjh4WpnlrM2TrbOsZjVMLmhifD39N3RvL+XQ5YRBO4N1vBmqxZCp81Tdb5yQIqfjVj0LO9yAsWGNAP/NsfbwFMKIr9n03Xj/WWGU5algPHNVibLM2nuDEfkOp1l2toI23+Ztyt81Xr4a+V5+XcOLmFEU6oo3WUzBhZxYQEVv+zmyAg73lhpyhNkvtyRSrSQaLZrVnloZF93TxNT8U0oqg0gxQq/G6zgLimnzuw4hKuQLwRmL0/FZ/xK6c7RR91GhpT9GoShL37JwPo4mZ1HGKq2hQH6NdYVmbQ6Pvsrhwl3hQn4CWyyNkSik718mW7+Jm/6XiahlWTdtq5qA1ifiAxfCHU+YWaaM;4:CsNCZ/75+daMiGHwRg9wK3eVPMxW4XUHFPkwkNRhDs5gOkMMe64tpPY6FIs0GRrVoX0ussv97ZkM+ZdujaVx+MUAHYVhrEgVf59e9O9U6ptuw+qR7OhHZuZWajYcBJw320F78O4atQg9ZEUka+YzdvE3R+J/A723cfaR/+Ie+3m0Kov4a648tqjJ0YAV3o8Q7jTmhw9dShMs+64/DSlEWcwrmzqC2A32SdgJHzDQf8E948V61UBS6f5Ze7e42woVhOEAyV+FjU67a1P5tS1o+A==
X-Microsoft-Antispam-PRVS: <HE1PR04MB1034C1B1AE583A6A3D0C27E9991C0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(105586002)(4326008)(52116002)(5660300001)(316002)(106356001)(39060400002)(25786009)(6486002)(51416003)(86362001)(47776003)(6116002)(3846002)(53936002)(6512007)(16586007)(5009440100003)(217873002)(81156014)(81166006)(8676002)(36756003)(476003)(2616005)(486006)(956004)(26005)(478600001)(8936002)(50226002)(6506007)(386003)(16526019)(55236004)(7736002)(186003)(48376002)(2906002)(66066001)(305945005)(97736004)(50466002)(68736007)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:pQ0FK6+zonRskPa9XSvcG2tRkGmO68Rjo0f7/0Q3N?=
 =?us-ascii?Q?VcDFBPuY6BS47Jp4G1hzXyVa2pjMrsJ1e7IfnSNqnIVHeVQtMpzxhSRppAVe?=
 =?us-ascii?Q?S5zim8A7HU0a7j75yM2AK44kaBy4EF9pdTXUPOpQhmpOG1mbb7chaAG6B8jt?=
 =?us-ascii?Q?wXIVZYF8OewgASXbRquL22J2/1yElTr4B7xBR3UkolHwijwG9/VprIHbEgaX?=
 =?us-ascii?Q?jKYSAMLbE78xWyPqmhOY4cJ9LKKmcz9DJcEzhED+rwjqI942OdEYEB0bk3ka?=
 =?us-ascii?Q?gbmXH2has7qIK2v412ME+JnKF0UWEB3y/GK1ymsA+qq2WAoO7ghqxhFT360O?=
 =?us-ascii?Q?mEx3BdjZzoAho1yYcT597OFC0UTo0M92a+XGZNF7XWOMLjBTwXqX7ICgbdyK?=
 =?us-ascii?Q?K6CWzR9DUuq2+8vKqDY7gQKouhipCWXdiFV2YBZu/KTdnDq461mwZpCxE3ty?=
 =?us-ascii?Q?ct4oUCtc7/ULDXfzQS/dnUX1rRS0PxEX/7KN61uzLaBqnsPL8i/64XEa+crs?=
 =?us-ascii?Q?gcpd36IyTDxsnLEtGNim5ccvKMgkAK5lTRemvdrEoMMUjVIbroQk2sn+Gn8h?=
 =?us-ascii?Q?DGaDwTqFY6ltqGo7F+HlYss/AzexJh8YPkWVi5rEeAGjBehAapCLy9TUTSUi?=
 =?us-ascii?Q?ZuUK/rexQDYNv43sKu+GKiV2gWVi3UA/7w3rSqrsMpUa7clS+8UFbyC6Y2fv?=
 =?us-ascii?Q?FJIi8PFZacsftXmFCpgZGhvFYAD34NjwQqJ5uq/0prLF5wDXQDPNpf32Fb2J?=
 =?us-ascii?Q?JDrLjRT4zVWW3QkqoRLm0AwtgzZJxfED2AfrY1yVtRPbp3VWo0B9isBppY7X?=
 =?us-ascii?Q?HFaVPAGLdEzR4HhO1sFWWTSV5NubILne0QbS/+t9hxatqq8wBbaRtaHyvHUy?=
 =?us-ascii?Q?0mdbjoJrThbG7hA417j/Eony2GxFhkqiPheiYECeXl+ZgdKHp2f6oN6QCbzm?=
 =?us-ascii?Q?EfD5atP4eAZI89rGXapHEl2CWZXfsmH47ukDA4TSfr8MpffptKrzgj0ElgP/?=
 =?us-ascii?Q?pOZcl8aqQRVEv9St/NIItyxzlgzWlekGjIsCsmaoEy30phiI8grMQWtoVrEK?=
 =?us-ascii?Q?6pmDExa7uJUcJTZSB16yNhpdwAsxK2T0mqRczjSWtR8u5L0Qg6qMjN0l3oML?=
 =?us-ascii?Q?ERzbp6b2WehCg0x5Ij1YObllAGEoAKoEy9HtMKk+2Y5/nTzgxJ8pOSAUdfku?=
 =?us-ascii?Q?cyQd5sBqG7fKUjNzlzVtG2jNLlsVEyDdVgL?=
X-Microsoft-Antispam-Message-Info: JQXbdrL4SU6qXAV75i+Yu2ZX2DvxSDNTpDhhxVgy7KNjNpC/BHXNtyNg+DlO5nJnZo621YENPcAoJ+M0jy+8XLC88yqYqEm2W3JRRPWueP0+rGLXLOnaUOYVnpoFljYVa3cJByR/miRC3QB3tYLNVZ6LBuddM4RZUAA4JLWjcBNBF6DdtC1ze16eLOAtOrqQjlJT2UA8aV7ZCoseHVwsCKudVeeKPGSS/Ev7LsQ0dFaZTFqTFewxkb18v6U7eSvtrluV7TFhGEtZfXCeWbnCjLyoamSp01k9A4jMLjWafQnRiE/fqeZG9G0t9R5Cvj9NJ4axyoS/wB8TnK/f9VHbsSkGJ7Rid4bYzEcnpys0NmA=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:nvZ44jJWPCeRCOZky60E2rone8x9qrGNp7EHp5BuKvNJhtpqg6TWkY4mdWaoM9uL8f9vONTlxmwEqFbl2HBJbu51W3qX9/+6Dc2tEp/spc5/Noso+9OvK4jeSJ3KFrSVKa120Uj6f/zrAxupk0iy6AZ9a5ejDXdTFMHl3G0npfneexlFaNVF15JdjFwUhbDWhJLBcQBk1hn/FesCHg0VZkPieb/RkNlioGeUpGTabwDW6iE/Qk7S6epGNFEsZcRaFwJi++LGUFNK1MdjLkebavRcbPjKbP4p+98Mt+sF9PmNs533w4quqR05jG1zqfxzcQVToqHU0Z9nBNLYJLlZYsqhxZ0ls9SudKjm51go4sY7WjWNCsgbhKq5xedBechdqqUdXGuAi1Ib4bNQoVwehjNRCZpazh6ns7hadiTnb96PJoVHkezctL+oa9CSL6/lAPQ6FwmkGYMMWJfCRIM8Bw==;5:w+D+1uwvMgopRHTblORO8jiLdtlX1RzO8DtUjvl+cbBmJDT/Sy8NZx7JUnU+bEM96jqNZer5OT5UJ6J2GzGMUVwYFWabdXp2JQCtmYRqUAjozc91CrV7ADUWp7QZOHRZKAFA8GK5tYzYff0HJFCZ/UK+6ZLecmA9Frj7rJRt5NY=;7:D6o+dV9ttOkw+EUn0XZzSz3+tg61AtxFIgIG5E1OHIMbH+7BNglDziYXbJnPUsGEfj8kdFhsMrUYxfNRfvkrTer9Vu28QCdK6hVxp1G1SXALAYA7ib4rbxE/Yvm4cPauRC/5ceWakRtDxeceFk4F1GKG361+s8ZQtJoLiDR8Rti4DStX635FGdDlCFIfG5O/8tde7yPKaNNxoGTme5sGrTFHpAx8pSd0kRVZhvkokE8hVwASq0WThBSK+TrpDTuf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 04:52:03.1886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1920ef-3719-4f47-c4d0-08d61deba669
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
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

