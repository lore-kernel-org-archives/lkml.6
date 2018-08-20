Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03C7C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7579D20896
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e++zdjOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7579D20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeHTWI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:08:59 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:11916
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbeHTWI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6WVxVoObikgPBErnEfip6fb486AZvQIMhpMrmwjOyY=;
 b=e++zdjOM8zQOo+sAl1XDtDJ98lIbJfPfbfHz83KxpIgmgPsibkFq8CUXJeLfLDyCForu2X9P162MSPKGek288nwcVFzNzjjNJ5imtyvzZYker2wd4kvFekCIm4aAcVh4AURBkLNdWnJ+TrPpKcytMDZQ5u0Q8NMlvqNVq7nN9Gs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 18:52:01 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 2/5] soc/fsl/guts: Add compatible string for LX2160A
Date:   Mon, 20 Aug 2018 12:17:13 +0530
Message-Id: <1534747636-20064-3-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::30)
 To VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c415743-4366-460a-e98f-08d606ce0619
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4799;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;3:noNGiXj1NZOHKMKybf/O7ILdwfxdKE4qiZSItsRHMYr37Gxvy6M2vkNHgz9z4mns2sa0rfN9Xq6B4sDJKIjfPCbsBPkiNnVlj9NvudlPcudzu/QH3ru2KRY7QDfWwPT75Uo59jeTHVJqvnHirkytYK1+SyVCI2/uIjffy0U6JGxtdw7Fu2ifQBZNRqyBhU7EC12Gf/4lp2TO0RFPJZAvW67zLyUK7nNUcTLLH8o1v4br8RLJIzKyhQImjBpxm5fb;25:crC42N7mYcRnrLdoyXKQ0sSxm+TtaK/A7VzQASX051+owgB3ohSlKFVDAekPChylGc3h2HDeSHdDLo6/Xn5f2TbnPyRqFIw7hMtZQZjGoR0dEeQSr3zOcpr/fjQHjXbRWf2OAxB1WIKC6xct21cygBvi+noMYp9N09bAN6tdBMkcDARMUaYHKV88SLbXqdosy2W+DBdeYuQvBnlWU3FtSJMkJfYAEIqASErc9ULioSfY4QMwr9hQpCc75S/ch1PqAWXnrOlMDrCWqfDXOmIXvoC68wN24jQXJRmDAzRYs40u4rk+fTphNuaNyTD0vlQCBkvr2UkdclGw09zwrAiynQ==;31:4y4vpdoxt0WbZqy61YaB1hVVDKDxEe5Zt0Sb7b1pW3oLqHBHwyyHLgdmKsVNzkVB3z8HCKXUNIwVA99KBG6vIU4NI1PVptD6Zp+sfoEFGKXMQlg0N1jePKOjggw415nu54nMY7n+EgXqr/CxNc9lTuKn7RrnW9isFhEMbGdRJHN11+TsbcCpsg854HYLEzJExgYqWU+WhREgIegLddja8DseJngNrN2IdWvEDa0nQ8Y=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4799:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;20:aSMKa8OPpzGjppD/ShK+B3rmQisddqLr3NPShS0Ah2vu/zXtWgeDzGFJbE1WB7vR6X7lK79eL9ikvM5hAXN6ylMKXEVAUvQxa5JOpi+Dg9O8jGF2SJr0cxNa4hCRUihjkSLSuaOtcZW1nwsLWuQqwB9xtLNu6YfRwQrGzDlYaXpuiqcmUrvBtVq1WD/x0yV2uwlIf2Q6ncvaVrOZ5Vduca8ERMZpQELLRFawJG2zgRYi41fpnQ6L+pj4I6koGE/BEs7kiXgTsZAIa5dBx4JtO4/klH8HCYVxxa/4AfclYeXH/1lQS5zvMphC1psmMsS8Xmjp1kTHleZGeN0zhJ0xlv+G9EfrpG0iK9P/KED8NZC9IwVoZud0g1p0mBoXeacehGOxzKarKB4QddMc8BVinYJbHn/DvR1B9NnpZ3hh+XKtZwDO3xgytqL+RyjW1qucdZR1x1G+kXrW6oGhGFoutbB0PPAvdmHmPiY1C7VuPuZo+AnoCWdrAaBQ+57mtPPE;4:keGaefU0lre0wmHp1BSuagsv7spBQlee+m+GVsxiT7SM7pZCnc8dJvkE8ubedH5NoEk5gayOc+RyfygmMLQJe3UPejC3QlihnQPZgzw59m/Nme9fKcLSe7HGHtzRJJrVwI3g/1sTal2N4GHjP1jUgIdKnw+pemF8Z4/o/4XfL3ywhk87fhwuyNeID6tbjQ936L4EN5aF5EinbiDpHXJfF1nfPZsY9VZIOA2K/C3l96PM/QOmuUIOwL9Fq46uE2zJlUhLd8vVpJ/TWV45ZNFTpL3b1p0+t4Vpk+PUvn2/BmF1GCmuhfwKLl8vZqxvYGMt
X-Microsoft-Antispam-PRVS: <VI1PR04MB479971DDF9CE3A42E34FD885F3320@VI1PR04MB4799.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR04MB4799;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4799;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(6666003)(8676002)(36756003)(7736002)(81156014)(81166006)(305945005)(16526019)(186003)(26005)(478600001)(25786009)(4326008)(386003)(6506007)(48376002)(55236004)(50466002)(106356001)(5009440100003)(3846002)(105586002)(5660300001)(44832011)(7416002)(6116002)(51416003)(52116002)(76176011)(2906002)(316002)(16586007)(8936002)(476003)(6486002)(486006)(66066001)(47776003)(6512007)(86362001)(446003)(11346002)(575784001)(68736007)(97736004)(53936002)(956004)(2616005)(50226002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4799;23:M8JPZ7OEc6eF8dzRpHZxlmHIMQQ7OrX0VmuvoS3sy?=
 =?us-ascii?Q?F50I4gT5IscBTj8yZ+nRil1S8r7qzoYxspT4FF6V7bdHNiGvHaf5/+BTjOta?=
 =?us-ascii?Q?ARllrOp1IPvAmmav8HqjAzBodTkI+mq3hp3wjgkI1nmx1o48qTl+goyFR7ZK?=
 =?us-ascii?Q?dqMw5t9GaxQK8YeiRoo/M4ax2g6pFyiZOCt0sfPgljNkMNO6iHW22ho8rxqS?=
 =?us-ascii?Q?SL+hEkWElSHU5/7Q0G64xbk0L0yetZYvbyRkfAnnK16MdtrBKZSkN95sVrxg?=
 =?us-ascii?Q?+25JWFMnlCokjE3zFFaIKze5n1gFqxMfzIde0xSF+oLFt0YnbXvYg4NHEg1m?=
 =?us-ascii?Q?mos9Ol6rRKRY7oC3YNFwtYHB1CSONphC7iNxiRqNTi7jSk6B1AITJOCcDkrW?=
 =?us-ascii?Q?Wtc7j66sYXFCV3rUgGMYazs0GrWpatMiwqQK94UyOh+Z1dI9e0yv4gAUcJE7?=
 =?us-ascii?Q?8vztkTSh3MBhPi+hv9o38kLBPn7Gof50B/e7V1eOsErE6SwvbNDwcektVyAY?=
 =?us-ascii?Q?eAAmnZabuF0xm2ayjTf0ttzwvfOW5xBTDhWQzLIvfODJgNouAkWrSCqqXNo6?=
 =?us-ascii?Q?4pPXEygZX45Sr1Kuu7EAZLTCWTqfGgOGyRmNZGKdQXvYnlBzLTu8+BN6+M/x?=
 =?us-ascii?Q?+cAScYUgly4baH0/gNvRUm4dokVY+vC5dJ5Wx6LcBdxNl3uGKPCQDDlJ8ydW?=
 =?us-ascii?Q?1qPBmTHqcCI72Iot5INp6l5LnIDSOk/CqibgLAAZFEz+ejws55pjKNFj65SA?=
 =?us-ascii?Q?RL+Dzu0ouIDt6oV6Ui5w4EAFahX28Jfuw8xQKUyuL1fnR3FH+Ty09D2uywx6?=
 =?us-ascii?Q?235X++0cvT9My+DamLZzFVZSj8EuIF4VN/S1kLqt0DYjVdFMUhIjy0634CO0?=
 =?us-ascii?Q?61AFqhWvOXMY/TuQQ7fxWHTlX9/PPJ/ubb4udi6+J4t9RGsWgvhTKBXn15Iv?=
 =?us-ascii?Q?MLZXTfjBrKJcapczqTWdugx5NQDioJSj/EhUoJUQAK3jrxdXcR6NtLLz2IcE?=
 =?us-ascii?Q?ZsyGQ8ORHCQy5pD+XDQVI/+QkQKE5qLevlY9OqnZXEzGFK6VfGQev6yFiL5D?=
 =?us-ascii?Q?ItGfcZv5pPZeHN5Ynu2jfVGPXSvPVVmGd6kehL9NSqd0syTIwa6Qf+ffyKH3?=
 =?us-ascii?Q?nGi+4/q5Lsihoq4DebL2nmqErlD0uGbDDnLWGwrr5/nup/n0dCviIXgpsNXD?=
 =?us-ascii?Q?0az6bU/J8FyaleCYWx1QQ+bWPkUJga8AfR6VbXkW4hJPi2e9mHWaijLPtfmS?=
 =?us-ascii?Q?8feM46lJAxhl28Xvi6kdBWYTPld4vW8w7YcmnQPa8JauIopJHVhUpmChOjzv?=
 =?us-ascii?Q?odtk4dN/L3e0U9I01Z4UCm82TbO1duLjGX4A3Ameskn?=
X-Microsoft-Antispam-Message-Info: AptzlMKGUwh3idw2MSfMtNwdUMjLByoupgS7oZI71xty1s1AkngRmLnZ4B3MIpIfu9GATIFyJ1Dqp2GdCQD4r6Uqzd7H9mDHslHmrK7MQMVS7kdKdSdp7/++zcjRUQvI1KpTW7Gbxt0O9BrqkOGPlUWwuZKA3/5cXTW/hw5rUy/waDBJu+FwsqE26VCZIq25Z7BxVzuuc7qToE7nruWquXypZfOvLG3DYLzTAi8b8ejUKd4kRqAknhFooTxR33Ak7BtbCYVjBp+ocK0fEj65oxfB1TeiWDr2UY60iDTRJXtvHWs4ap0oLHjdZOEYj1VqoXnUkJ9tzsEi4XvAVDAoH05bPrsUFS6e35xuNI7buhM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;6:n92p8JzNKP0wikqyGVB7yYH5/bbowGO/Dcg7qZOtR8AXlFSiIduXxw+YdClu3YfUwADYatz5061bV3yUctAfc0IchQhq4nJpvNEEpBjC01PZVCl66B0yQlbkKeAHUCLUCdo3fbJYpgbZSBRTCZfhuMrshzqAIK5f4hDcBzxNidWwuqAKHQjfKlY7ms6MYeV7imGV0KVVsv7nb5uROUg2vfedtVbPsNitvpf/gBNnGhdiujllb/dgBbIkzO1bT6cyBc8sm7mXinh9tJsOwpwwFd4n3AefRbi7UI1DbyNR7VmKY3WhC0lZ2mDA4Jo74yp9pw22LchUv8ldAGCOxDDxuDf8jm3WhofB3mjyi49KmBkBIM5E4l3Z3wmNpEOUoaaUJaFEhUZ++P/E/xErYeyF+6abBGVlTKhqCp7KKSlqhonenc9XCzObWy2kmzNi+dbNPgY5seUhL31ifWHhboJeFw==;5:U3MdAtsKvBTz3/2sEso5aSV5fVO1LSmyU8+NJUXmWoOXwqcVZTKj0JqYmjjhBS11IvIQlsBwrIKfyx9hWJP6diaplazJJ2X465MLU3nJhd1iYBdXAT1YOyurf+oDkYZuJXTKxeDMQYcr81TM3aorPUMpG/EkON/5nM1B7xXDuL8=;7:g3HdrIfgat6/DpuBYL1Zo3+OPxZvnBy+PNAtfqQ4apP4aP4Gg/NProojWFvzEOJrwuBtZTtuVwbWN5UiY4qbitFPllINUPHzFt1zu93uYWsVYADkZF4dahHDRvfOv3zLENiOPQqfy0aIV9Nf1aI4Kh2aHzWHFunUiM7iw/MljC9Sgvyc56jYibopbh9I6FX9lYki+i7ES0CQJL4J7MHZsCxpw1lMguEAWjJrKuiMnXPdeiaX0888eXT+NoCs/tOP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 18:52:01.7598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c415743-4366-460a-e98f-08d606ce0619
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/soc/fsl/guts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..5e1e633 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -222,6 +222,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1088a-dcfg", },
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.7.4

