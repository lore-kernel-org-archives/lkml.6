Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF35ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB720652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wfX0M1Bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCB720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeIRL4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:56:12 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:3250
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbeIRL4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KzZb6S2yciXf3W0EO6IdVNP5Zz8IzXObnLQF4G2G8Q=;
 b=wfX0M1BiOItBdLOhzkeTVeIdokSYOC5L9kpg5JLxMoDQzasKnZxnqxa6MBwSMpRITvUG90YKkPIQGxY/R0T35Y0Rz7mUf30bAElHvtHuUU0HtifVvGjc7k0tky9uUXQ4PFUpYm2SOtwsgFL/Ph48D526cVT+RZuGizYNvwPl6rY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 06:24:16 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/4] clk: imx6ul: add i.mx6ulz support
Date:   Tue, 18 Sep 2018 14:19:07 +0800
Message-Id: <1537251548-27845-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To DB3PR0402MB3915.eurprd04.prod.outlook.com
 (2603:10a6:8:f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a252b704-1f54-4db8-aaee-08d61d2f5f83
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;3:ZT/KuyB1KCwN9FA1uKdy4ZspxJD5WSEw3BcskSG0LpWvAe0hSY5EwersW+Vn539qmsUlLqDeRxjefVbpkunfsq8b4NTi/WJKxGQohoapsaPBSesk0zYaf+omxH+pBJvNfGqmlFbk9OKcG+yvdjudrBQJW/6xZTRNxRxueK1PLfKDS9FnXkGwLaHC+Kp2ZwZsXj+58yFDNLiETb993HHYbyVdtL5n4YDczTdw5F25cqAmuPxf/Kj2T18Us+bfluBS;25:/ehxHcTs/DRq39ZXSY8X14gFZ1nXr/NyRuWjDcFJpuefBeFIX5CFYD9P+cwWnBQ8jIkUqy/9u8Vtt5KObikIvIlMiaZEfSFoHOro4pMjpIBx4Rx42ikDHZk3AFurBYawsSuQCcSE0qBEtlNmpDGz87Q29pcEYcfUu2R1lSOpmQksAmAS2eivJGy898c09aKCbMfL2F8f0b6ekLiOQLB0ZarEDyJLgL1xhNkVO01XJ9iWLf6HruclcF0/T6yGUaXnrgHodm9zHI8CG/vmPRR4TWfv+G2Fc69a+cXSX0TPofDTk2uJcUORU1HRYuhbZBVuc9MH0F+xCYk4ciiQ170TCQ==;31:aKChBiU8o95TNwMGkuWauTx44w/LuWO+F8B+072RWDEr4VOdRTNZN/RfCcpXC2tMqzuxGhEN3brJ8gIcNp6zw3sifPkipHzvQLZPXfuXldWKzUeH8kJi1D14vDbC4OuMWN8xeI6k2O6qkkJ6A5tJrooD3JXn06iAJjJuqHw+2nWX9J3g/b83jLv/nrq4pYVauVWNVNVRAFQGtrsBU/QIRgVhWE9bBFoWQpbDUsiB6QQ=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3915:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;20:JX3abhnHgNi7GW8HgvEfx3+VkmE3vgup2qXAVSOBnECGgI0jp1Q7KLh25FcxOA7EwT9xRtxPK10H3gEhdAvomxk074jSB9k5h/lPfPyIYgZMIsnqt6PZ0H7TDpVA6RKjOEDN3yBQjwzJ4r8gzNXiaDrZ5DtV/L05kBxPMDZ8aK42+/udB6CyxbBKLszjNlk1RqQzwjUqOQD4eM4/FKODitGaG0k59weM7b6GtUjc8KMVkGe+MAAzCaxsOVftZmJ/BxZ4tWlhVAs41hoUWy1gK4Af7Zd5sDbjm8J0wSuCh8LJQE+hpbgVeducOpdWVxcCu8UYxSXPa2DdjB6IV/UJyRd9aokE5UjkJJ9HBR3mjMK2xyF9s8DozOi2kUeSV8h9ms5qbdctPqUHv7RP1nJdNu265x4XhVQj/9Kd1Q5v2Gc55tc0uaMCMJ8w6xlP6L4NMRz88FUy3WlMImgQhpbiihpkL6wWOIpihorWfFMqYZjBTUGklBhFxVqyD+0CLwoW;4:rRIIosTwBcy0ST96ODXNPyeIZ5Vu3TyMbqtrsc2/D8Qt7Vh6uQ8FOI4xdiNuoSezsdxv0+L9+S5OV9FiyMODVIZKT8Gc4NYdjm1Vx1EORc34VlKh/DFlnA/YgGkhxvZfBskzP587u08iVD96VCGKi/aWAeHX0sSkbjTlF76xjyBvD7HGz94NNv0mFPmMbvRYR22ZiRKAEbUA+APo/R8GzxJcekC+qrCRpkCTaQOsyc5xOWcwJgCcYc/8VOTbgICS3//X/J2JJh3M6c16b82sN48wlY/xbT8cEw/DqAUBFysWyyLTtNx4c20I7APfW5bN
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39157AC421B69481032B3EE9F51D0@DB3PR0402MB3915.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DB3PR0402MB3915;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3915;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(186003)(50466002)(50226002)(8936002)(47776003)(105586002)(106356001)(478600001)(68736007)(52116002)(2906002)(76176011)(66066001)(5660300001)(97736004)(6666003)(25786009)(305945005)(4326008)(7736002)(51416003)(26005)(316002)(16526019)(14444005)(6486002)(3846002)(6116002)(476003)(2616005)(956004)(8676002)(7416002)(6512007)(53936002)(6506007)(386003)(486006)(86362001)(48376002)(16586007)(36756003)(81156014)(11346002)(81166006)(446003)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3915;23:Vyi+SUpgJdjRqx+9u7rK7D7Ti+5zqVcz+l67RgL?=
 =?us-ascii?Q?m+SH1vBOh6hjRfYIcHy++Izftns+aFrcPqMG3oLsdT7kW+YYzfvke0OAmMUR?=
 =?us-ascii?Q?AgERpTps5iQ91sJYXYGWamF3o1zxcHuKjnJtGyEqQA4yqep8geu0D4i7lB+e?=
 =?us-ascii?Q?FB9OTzHUEUCMU0vX5jhT7ixT/dDzw5lkjouOlBMpNHUAmrCJFvxxjNYHHsXC?=
 =?us-ascii?Q?8ARGUy6BuffjfAhQgv5Dsx+cLmOj86FHDkG6sqS2HbM/UH8o0DR9cAdofIdE?=
 =?us-ascii?Q?7i+qDzVsck259OIFEQ8QXB0jb50qUZY2cNodTOImnGN+XMHARur8LGDgRCto?=
 =?us-ascii?Q?Wmk/J2p0yN+cuLbiju2vViW6mhfHHTCaDquBd4jCnRgnahvfmWUMivTpjSTN?=
 =?us-ascii?Q?BbI47WEwpcP21zJUCKB04lgxCbuYMPY84ZPzHGCHMjYZhgoCBBypcwHMAXbA?=
 =?us-ascii?Q?RHM0b2uaIdo9IxqCnheEWXelDG+tBqxRcKiCUlBA5H3TfpQa9TOmuFpTslJt?=
 =?us-ascii?Q?sKIwtYc5o8Tnd3WjOj3073yiFn49jiFfiU14PHTtntBKZ4nbmC8bjRmZ2fxR?=
 =?us-ascii?Q?ZfsdKQvLD1EByGrhhA/Ngibve1+PhFfg5A63N8cincW7cTF04vnBdeiLjUyP?=
 =?us-ascii?Q?P3CB5fIBtpZEjEeZ1fUrCzfC48ElTtasZzOg/aKFZxRcJ+kZDxG3XVFNScvl?=
 =?us-ascii?Q?A2aZ2Ed7Sm4K3hGu/QYa5pHuF0yDxLGIey3Qr7YOzQBl80sa9FgBisprSPmH?=
 =?us-ascii?Q?Zv9woHdEGhPlW5tAmTB+p3BRe8e8vFrgGhDzS4HS0dTuzQRQg00hZkOoz0RB?=
 =?us-ascii?Q?L/0CJs+pvYAm7e94/pPHczVSopda3nBPz9hkiTqMR0V1yrYGuy4fqFKbkOii?=
 =?us-ascii?Q?NbUN1599dBQx3X3zNkV3Lx5LZf27PUThIuI8qIiZSzxysZHFSC3kXvzZBl4c?=
 =?us-ascii?Q?+QKMsX53kNPVPZm6prZX6getc0VULhwrqWZX9kOa5O6P7DtGfyTVSTs+V1rg?=
 =?us-ascii?Q?lbnYakB0iuj8FiRos61arAnTE70F74YKDeWt7RBR1ZL84CK3T/XZWqh00/Kp?=
 =?us-ascii?Q?EUINyK7IFvbOvSv/7PurDMbTJ5WoL9pQIOOLgPN45kXAvsjUNWL29RUdDENV?=
 =?us-ascii?Q?RNActGTDBZPoRhsmJhzd2kGwOWoh6be9i0i3bxTNEYKzTXmO5gSapoGpH1Go?=
 =?us-ascii?Q?IwUYmyjNt7DvL7P/jppAq38aFl8IJhmn+Q45TGWCFNpOAP87MXT7/8YuQyVn?=
 =?us-ascii?Q?GbJtJv5hLlLeP88HER/M=3D?=
X-Microsoft-Antispam-Message-Info: zuUzRaf7nu7CbHQ3mZtvcDEZUZv+j7jnRz5pePvmo9xqIw+zUcuDcZ+3f7lgjjcsHSDSgIpwYo2RZzW4luUgYizvht0efW71ovzQyPNoIgZClO17pB1qydZBR40BirF9NwPTwSMU9HfQJTpjZyrJh9y+FAoHvKInQaeH1sVZyVKJNXhUOY1GFfHDqInh2s38NtnSS5ZXmo/HGJjhjwcFVTXuAwkUtyJzq15I7pfMYb2znxg6Iei5d48czNe8Wodq/ZtC1cyRQBYOFyMWOgCsu8gSWZKwSsaYsVGPG+A2bPVPyLxVc1+YKmpMW2XwlgVKLdo6LbpULkKdqFTBXaKc/t07czPzDKvz7HXd9qr2xxw=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;6:xm9xq3Sl3pB1xeC9cgBeZf8YO1fyzft4+IBrfdjy5o4Dasb1s2hWKwmwaW1EzoVU6Db0wPjBrppsrHAZ+6OOJLerHUFnbtUWqPZwBwoFZQ/xq6HiWFThnm/Gkm0c4njIBPh1JpXaObVNGQaumlBv/tTY0no0+4/OFKT9VYYA6st8gmc+wPzRRQv+yWHL30bmjVye+1VXqg1bjXctpBf/4MeYgxuVK0VqV7FJqlqxcc3NSmtfe+R3Nx1RepzkS7JKAbqZmiENlpn8AlYsoI8wqFvTXK5HEcrzxofqCO1nqlni+UG7AAHIa6ua5mYZebBSIWyTN+vVlO8hjxsTLIvKtwJmnX/uh1JQNHALRGlNGzVRP11m7sS3VD+ZzWqksuhuHrY3XRnqtpybehzlKJXtNe5+35JJo0r0wYyl/qYnLSi5ApInbxjl/kVnpSpoB2s0aqtDGQoTYan0865QvimD/w==;5:sc9TO/xBzK7rq69UeAl9uGROMQm+DX3jf5rOle6tJ095ByxS9KZBN3RTjHKiHQBwvKhSpRfPOmWLJJZxEKX9CgrJf14B4Y01B2teCJsjVlsgRza0ilf/zWr28dEH7FK7fN/OO7MLWdGPwn4McVIGWx+f20m2cDZ8TkHKj51dUJI=;7:Zske+av+nDEQqkigDf4Cj0bbfSYgy+r/twWf2WubgQxfGXTEU5B2Rhr3R4yDRONERkG1PTZk1GRJ9oiyEfu383oxOuVg+HjgvzGVZrf88k4YR2ZMFQR1Wj3sYdGLDL1y61jZWPSILiMh7CXeNPLCB4VXoh5dKI/M/L66AKdRhKvpW4Zjgl7XMapVtA5aayAeg+sWeQ3A3EOMmOajgXzUXol2kh1ZhwNoI8ZslfKcNzYoZwSZZut8sYdyGuJJqR46
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 06:24:16.6206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a252b704-1f54-4db8-aaee-08d61d2f5f83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULZ has same CCM IP as i.MX6ULL, and it reuses
i.MX6UL clock driver, this patch adds support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 361b43f..42b857e 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -116,7 +116,8 @@ static inline int clk_on_imx6ul(void)
 
 static inline int clk_on_imx6ull(void)
 {
-	return of_machine_is_compatible("fsl,imx6ull");
+	return of_machine_is_compatible("fsl,imx6ull") ||
+		of_machine_is_compatible("fsl,imx6ulz");
 }
 
 static void __init imx6ul_clocks_init(struct device_node *ccm_node)
-- 
2.7.4

