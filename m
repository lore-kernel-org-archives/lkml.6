Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEFAECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196AB2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8Bu6z2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196AB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeGNCQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 22:16:01 -0400
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:9743
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729935AbeGNCQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 22:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVsiW9hwy16y5sD88hevQP1KbiaZAEiJXSbrEt/YkZ0=;
 b=Z8Bu6z2gXadCz//Uyh7LKytbdnyKtSFHgAprgUoKBXxgrMK8wARELHO3OWOV+mcAB2H1XGGLsOxXWkQbXl+bKpxpvGL9JCshTl0uWKvwwm0W98FIEdjvv9Fk6z/lLfiOdKccHlIOjbL8gS8aZ6qYe4gs8N8adUQ/GKcYww0UdVI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1322.eurprd04.prod.outlook.com (2a01:111:e400:5889::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Sat, 14 Jul
 2018 01:58:35 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
Date:   Sat, 14 Jul 2018 09:53:58 +0800
Message-Id: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To HE1PR04MB1322.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af44d9db-59a9-4d06-787c-08d5e92d5128
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1322;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;3:BG724j3wJZhL2PQ5g+e61WVK7jH4KVqXBrSFyGYhE59Sh+Vmnb47KWgrtjlK/Si1b7UFM2Aj+6pkIIZO7B18hj4paj5KF8+nJnwRuQ72mheELeZFzba5Ec63o4GiWN9l2Z1swEi6fBmH2hD6+2FRrCvBfl2b6X7ZXQQHUP6+Un++AtgHtcNDDqfagXYrvENdqFBf/zpr4th9XFsVxEGNS9a9yvWmkcBq0kRRXObQTz+XjzkndAqFPeodEHP7FozN;25:kXiGPHFZKMlD02z1ennudM0BPiYYsHnslfmF6vMrM346yVZh2RGRHGH6q8vKHMgnsvObeJTiSIAVrs7K1K5LV++siVw/3NtdQpDII3dyml37b+V99vEdT1LS3tkDybOR2DzTo3te1j1VFpO+umeNhWelxb4fh810OL2mwAqJVkGlT8T2/FiE6FJWA/92bahahfi8LpIYLmWkf6+03cOY5jUQ1hIULRbCsTOWHrmwBCo61XOGnDf6OjjObN7T8S1KBbeFFz9QCshIESNicbvEgHdfq4/r/FPEIp8iz6rBf8e/3yR3GkpeG+RjSTwIe+3Wi1s6sL6WAV5swMu032bK2g==;31:tYVn6nxOZ7BA14s+pdA8WvmyESvdJE+6i8sp2F0TamNp3aT/VCyWxHdrkyQXbkx+PBfIFYsOF4yuMZvNdfjkMjaX6hJV9zLiYFedFwE1ht5CWOzHSxoDOK2p+u9wFyK828LT2tWOJG/ebBldo4KdU248m1cwAD0/cYKPDbpOSpe1P0g+YjYDYVrFD2iyd1O8zRSB5h0YLD+5DRk2oggRQsDfL3VnKRd2op5M/4sKzIo=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1322:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;20:q732TTlrBZkCR7zfvfctBxhJLuWsAcK/0NjH5q1P8fmcc3oMCtoQCnZH60mjVeyY3dtA/4nIKYNNBGtqKLPBiTOI1SNnBTkr/6VMV+3tprTgPKfg9qXAdV76gpUNwxfj+gKrzSDXJ2LjCy59oV3PfsHybUDlzAN/Ms6qkU4snAHUAXdn8WnPWeFs2mt3XYOJs6FtcNXR6614/6mcQZMKDpSgtNviGmn7S1fQdqaKze4B0zEYO7p3JzLpRNPw839oOiZKKWETGNPS9OGMwGGTCrD+zhYsSfM2rgkGcq2sGw+TW0ANRu98vt6YJW+lqlizCu/lW4zxWFokZQTPXFNSpxzIVycLQUFRg/tWHNyCF6OPbYb7kg1Jtqyn7CAvr9Olw6B7UrBBcaf7u8fAZQx/NC/Lyoixv4Ui3PnAeb2kwYP8PcxyBV4WuEfVZnvEntziqPliUddSHbXbf/IH4gXlD7ymV2/nV00VgkpR8XpYJ5WyUrnRslMQvpr9c3rE6QoG;4:FB9SuobzzsGfnDjsGg9eqrTmJv43f1qTbYr32aDR8gO8HkdhepnjHibeHdC08D1n02sWJFmRsHPFXp2pOvodgwCIdj830UfC69ue/Nn5qwmlb+qP21HUtvEJzO2x1Kwm3i15mbEoJN06Oy2wTWpJfbCIRatJPIbZVHM5kX2NOCZVmLqyE3GIhWcqKwPDePl7n18jNVyGuVJGLXbNOJZipQwrhTvhQrLZB6uYRVFg9u5fIJih2rjgo8Li2gx+Nub/xpt0jzQSPWt1Ut2XrkFhDBycLjSbkODhJ8fvfKl2cW0spLda4xyVp+4YPojQB7ff
X-Microsoft-Antispam-PRVS: <HE1PR04MB1322A835C23AA54DCC486924F55F0@HE1PR04MB1322.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1322;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1322;
X-Forefront-PRVS: 07334CBCCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(486006)(6486002)(8936002)(81166006)(8676002)(106356001)(26005)(186003)(16526019)(105586002)(51416003)(81156014)(305945005)(316002)(7736002)(36756003)(478600001)(52116002)(2616005)(3846002)(47776003)(50466002)(50226002)(956004)(6116002)(6666003)(25786009)(575784001)(476003)(6512007)(386003)(4326008)(6506007)(2906002)(97736004)(68736007)(66066001)(86362001)(5660300001)(16586007)(53936002)(48376002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1322;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1322;23:4fmn7cnDy5GoASIa3AYlLTedevIar6dp7hIBez8OO?=
 =?us-ascii?Q?LM0EIaUkleiN2BCb1l/PhV4AtRwzAZ0tOBn0qojSi+bZLP7+gOuQTvqrLJcn?=
 =?us-ascii?Q?Rv6w4b0aLo1oVJP+PloiHBw5gWSTe3ALph7+/4KvtvYBzMNg8mZcHtlq4xm4?=
 =?us-ascii?Q?pfsfLo66ZEm0hrafv4Zyg0eV2Q6CHt+RMlQFqVeMiJqpA5GW+TCTgrrZnThl?=
 =?us-ascii?Q?tTzQhFZbV2l5S6gIcaPcbQ4eIyn5if4Y1rgPeRNGfz8vX2OA3791MBeNcwKA?=
 =?us-ascii?Q?fuA7FEQd2nSHQk1lV9oBZiTsg+/hwt/3CqyYAPxsCDNYp2xJTrlyJfTIsDcX?=
 =?us-ascii?Q?srVu3HjGMlir+PsKoZ7qZiPGF1WDtiu8//4Q7b7O+pU8UTDg5033CMFM8qQz?=
 =?us-ascii?Q?a6Thcdxe9/TrLaaLaDewYmu+p9MqRiqifox4Jtzp9ItPEl+hPE3nsywUvkDk?=
 =?us-ascii?Q?umYo4BbAw+twUzAsSLhQ4JRn56pn1J3U5uyKI/rwRE5DHMADWqsEqFMUxLIC?=
 =?us-ascii?Q?pLnDVhvppaAMdnZBCjvjXb/UNfKdu8O6/51/toPsok+rZKmg+2hrKgkbxYQ4?=
 =?us-ascii?Q?j/C9/yTek4m6uaNKZ29caZtaf/EsJcjR1tclmoAi1I1aIoZ6S5GKxgtaIwuF?=
 =?us-ascii?Q?heuCb/bH61Qe7g1JDeTu5b0nCeAlp4S6HnSveZyXiwnk54ctXNQn4ZsIWh1/?=
 =?us-ascii?Q?IoSIfwI3YyiMwNNPgFi8yABLjulCCZ4HcmrTri7Ym8J1gZu65Nv5am3XnX1Z?=
 =?us-ascii?Q?EBGgC2GAkC/F+4RLbIflh0/KFyXc//gkVAw6lDybhwZbdAPKiyA5DEA/hol1?=
 =?us-ascii?Q?Q0ePyvUAovzAzjrYfMYDzClypFYorfuatX2YUqA/5G24B2OziiZh/48fks2i?=
 =?us-ascii?Q?rLhBCrmXhEs8LS5nyATRkYwlbUngsq+oSI3JyWmHX+UsQjvx4sT+XUDc4PDH?=
 =?us-ascii?Q?zgF1tClYKJJPyGUhZyZviVjDy8qvIlQvkT03HFclv+0VzfnL1+HrwUpznk0c?=
 =?us-ascii?Q?kwcwO+MSXc8ltrIRl2kzYEj6aDZ9trIh+n5QXrZyusHnV+LTv4q363gLyX5u?=
 =?us-ascii?Q?ls3ewnhXYEea6zIZGxboxDwks0BuVUISn3HpnDyddEOO+gSyu06aqQJ/M6Zc?=
 =?us-ascii?Q?SfApn93A5Z/AtoJEjUYXo3/SH6EnrBxkoVjVEbQZb2Hmj9aZ31rHw=3D=3D?=
X-Microsoft-Antispam-Message-Info: LpLu22/lyu0fCaTHgZwLpYfCs5/RTVCGujfnzZJ7PRAZQ1LpaY7f9K5gJSKFXbd41ix/NrFf9MWwkqzUh/yB/bx4k6ivHEgC3OVn6YhMtwXrMmxii67FILq3XIHe3QKi8CfO68izE1Ez1oKQ+O9Jhx6fhipMs43bP/aH+fURfxN+Ltp6/D6kvSv/KdLHLNWs6+LP3tH1q67QhyjhyiFXKgbm70M4QwZl/w7waX5iO+VQVn6Ncc9MMDVejWo9CYvQA0i6vULTH/R9JTiqU+LnloAAc5x0QBM2KTQ+tg3RbEDxwSxwhBza4AdsXzcTjJPtQkLipwuH46/WRa1zVXR3pfZE/dN60Yw8ErEI7LVsXbQ=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;6:PZQbotn5rOThi9Eeg9cGxFGRpG6qMq++t95FWkrwCstoiWV5uRoTkkksLPM1TcAJJA+NAkFNWKnbHf9QI5kHstMSauzSHYHfjZKrLZZXnO4dtdvnlvsQhgEvoZIkuQU+ovSKZWBUai413Samt2jeIvIB6Q4uKYzdTutgD5E7knn2VGm0j7EPGndq3N6E/C7kzgYhlK0q6s8bDbzq/lb/6yNMQ0fwgyi+DwrAPDbsqY2y3eJtPHtIq4lCIvtVrwDW3cqrscacWiYGjc8cP2blKvyhN2CUHW/JeaTy3LdejWPZoSBZ/oJ+rya/w9LqrBCOr/aqXEce6QIWlkaOAdZdrsglvYaekLsJA1bnDsJd/HEhQJMmzP0woNJ7YqxcpSGGQDuycbFyHcoyw/F0UGClnsGdrghVKjHv//5H+iGjh7hH8+fgxJXRr2Wj8mqzmstdBTy2v7hr3wuDGiz+/BcHRQ==;5:o/3nifEFWo/KySNlfCQ29OPjZkDwZ3FF5/hZ+VMBGZpds2w9luXzBEZJMZXGt9MovN8X89izc3QGCsSH8McRFACRUIAYa5QBK8NpeNmu5s7vXmvLpR3FATbqaExlQh4+MOeqIc7z/vcuoAHg/eiK4QD/RZqONPjawbwonizeFoI=;24:vWMLDB2uJzNLw9ZtsxQNlK9Bp7lBSOp3dAx/i/4px+gyJ2bYzxOOHLxXD+TqOwjtvMZoUQCaOXpGgxFr2hDA46x2VMMhQhqBLCBvIgkxpJE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;7:9jXPnXMwV0b60fVSeAaFPRgK2G9K7uHOp1pJCez5ov7ZO84iPuSGfw0t40DUt8q7K5msloe4h5hac+dV6qD+BmO+Q3Uvg3WsOyAxp+A417enxu3z+/s7C23zut740//eJ3VOiiMAtv9fJ9gtpKZdON5KB/HYxuvlnnYm/4jyYY3+g6+T9ya8GIRJO+um9xuiJAUGceMQMh0wfh+vvqFjCsCO/vpshj/Qq0O0ZspFWqq1vC+UDr0DQEV0onskqs2k
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2018 01:58:35.4961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af44d9db-59a9-4d06-787c-08d5e92d5128
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SL EVK board, the MX6SL_PAD_KEY_ROW5 pin is
used as lcd 3v3 regulator control pin, need to make
sure MX6SL_PAD_KEY_ROW5 is muxed as GPIO function
for controlling lcd 3v3 regulator.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
change since V1:
	using a separate pin group for lcd regulator instead of putting gpio pin in hog group.
 arch/arm/boot/dts/imx6sl-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 50bdc65..046cfab 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -77,6 +77,8 @@
 
 	reg_lcd_3v3: regulator-lcd-3v3 {
 		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
 		regulator-name = "lcd-3v3";
 		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
@@ -410,6 +412,12 @@
 			>;
 		};
 
+		pinctrl_reg_lcd_3v3: reglcd3v3grp {
+			fsl,pins = <
+				MX6SL_PAD_KEY_ROW5__GPIO4_IO03    0x17059
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SL_PAD_UART1_RXD__UART1_RX_DATA	0x1b0b1
-- 
2.7.4

