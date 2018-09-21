Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA9ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCF12154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SON+3H1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCF12154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbeIUQM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:27 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:31280
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389815AbeIUQM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fdnsGsYUcfMaQRa8kx5PkOdxTFkQVvAZ2XwI//jgvU=;
 b=SON+3H1TOzy15tE1/cDaGZCHN182sl7yv+Uy29HUOdKKHkRDUgKdvcsjx1QKIGAsGSH8iq56reBakvSTd5nb0TITtZfjUd7loq4cqrixu7+Vc90z+CAJy6kd3DdtaK9XfaQM97ie4CrBBERLStKUn1+M3pUvf6tmI+BgsKvJgos=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1028.eurprd04.prod.outlook.com (2a01:111:e400:8443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Fri, 21 Sep
 2018 10:24:05 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 4/5] arm64: defconfig: enable NXP FlexSPI driver
Date:   Fri, 21 Sep 2018 15:52:02 +0530
Message-Id: <1537525323-20730-5-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To AM2PR04MB1028.eurprd04.prod.outlook.com
 (2a01:111:e400:8443::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81796c74-02f7-4239-5e26-08d61fac5e92
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1028;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;3:w6fAzixq0RPT2/bxFv+USX0MW2s8hu8l2cJDJlV80Bi45EOdodLVpZ3w+9fs96T9RB71MvqnA+2gQXjnk7aEcckz+t5qbOVXiPMbWZZ8d6gacD+MxdYoIqAS3+A30aB9vsyuElBj3t9rXp69jtjlJ/yleyGqOPFFCK4AgUgdbIE0gsS/NTnaf63xMvI7mBm8sY3wKQyYkSD7kU58FLiiVXTiBEujhXFj2oM8X9PBsJsqEdgzYJ8H1GW3rclsKOdt;25:xDWeQygjW6r0ckbuaqdvZqJU07i1rY6ChieqHpb8q2/Jawwy0jVF+VXghPk/+JZomafHNgS55rwQ0445hlwjM8buCY41DrRuK/feFmT+zv23zZN695yX2TSmabH8CuEO1LN8swnRCQ5ft5AcdFF53Z4z/lhhBanvpF9fV8E4+jUT3sYKnA6pSgq23deYYfTBm40aFlJoAY28I3HlWPm5ZIvFB3Q7JKTNIsaFWZVrUJFIGHSZV+6caC5LemcG3+sYIay+vK7PXZAmEueKuJGVujcQiIf1F7NPtN1sQhgHoMLn8MmhsmhD6bclDSZYsLIY1AJODyZyXS7YUWwfNR4JWg==;31:AWgANcUhu61hPG3JjQJURVN9CReXGvod0hH9DQcnLuSQpk7wTqL8/KTEAocoNpvTP+fH6yxaoXtMy2wvA9VMBZAU+bEBkZUtvJzJ/iGJZHMLjQiRu0f4xaQuuiEI//bjJAv9rq11dRXTR9Fmwrx9H+anJVVO7jR8d4yFnVZLz+FUhUQSUXWKlp9YMaLKe7JCcZHdTmojU5MirTJJ1WksOaoa3xSDN5jXsnXQHmGjpq8=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1028:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;20:flbj5pMBOFbGBLjAX7VlqwpdF9Bth3TBrvCG3YKnJQzNmeFUtK84LJwe3AhaLdoLCP3vnTsNXbrH2Xkva5t9qKlDWP2ajXHfD40iVeXGdxzCSIeDELLOqelQ/dhPjRfpcm5NQvn93XAqeFjuVEGFay1yHnRbw2T9a3FLCIVGERJcu1X0E0xZ7NmInaIVAwYlJmn9k5So0LSVSVBWGA56xe1G27DLk94AGTDB+EsVjrZ9kTMepkd+dd7GhcXjzE3848gAMzv6ewiiSeonx5hLRDjoyJaNIWe+4LFe3lPlJ8UMY2NEEzo3q3UWBdtY41zTBO0M8s0yKpdm5rtErXyJE5T9AkznCNlsHqOVwOoQvhqIc+B1xvbN0uzx0VJq8ZgsLs9QfH89uQnn9M4X32tQ/bKoNTNwlYGWJcus9mWYPTa9A3fR8I32dA9SsUZ5K4Hic6ez20QkokWWwcx1fU6nE7sEkNZSaQ3NsgC2BongYywHlu6UdygLydpRKA/SnT/E;4:6Hvv6KC3dqJ/NxfgckPoGjfU4fgqkScVCrZ5tbwHfVLiRU8fgg+uD8BK3HK/q/KyzEGfzeCar0KsgatMykmgyOFTQIF3Wc9zUnwSzwjk10NVzHGGjuZmKWNC1x+iiXGmno9sd0OD3p8FbW2NnjbfdrLyDUuiDROXTF3ek/4epuqYMKuNuXxnJ2a1/xLILV/EgGrAoKpAmV658GydPWSbozJujK8ZGRh9IjeTGTvQGrTvT2jzeXH/GFBO2PTKT5o0jo1vkFmpw//3iFy7OxFP6RLOJrGItuZDSVzjItUtf2ntCW+YFRy4glxwr8bgG9ih
X-Microsoft-Antispam-PRVS: <AM2PR04MB10283F87E93B2F81EBCD488099120@AM2PR04MB1028.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1028;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1028;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(48376002)(105586002)(305945005)(2906002)(6506007)(25786009)(16526019)(186003)(81166006)(66066001)(81156014)(8676002)(316002)(2616005)(39060400002)(956004)(86362001)(476003)(50226002)(26005)(16586007)(11346002)(486006)(6486002)(386003)(5660300001)(6666003)(52116002)(5009440100003)(47776003)(51416003)(4326008)(76176011)(68736007)(97736004)(478600001)(6512007)(50466002)(7736002)(8936002)(36756003)(446003)(53936002)(106356001)(6116002)(3846002)(7416002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1028;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1028;23:M/Ubcu2yqgLj/NqDuaB8C6QStd7mNv0XR9B6QeWlK?=
 =?us-ascii?Q?M+aS2FKTwY52rknJjw77N7gJ51WxSB+E7IlO657axZkBSOsWIAvz/zoV+wBh?=
 =?us-ascii?Q?VzCT/dDVRIiYfWbHmdL2Ek5uG1ysHwc/i/xoRbRVqCZ6W9MsyqjsPlMMD5Lj?=
 =?us-ascii?Q?7ZHNkdRdNeHsyeh8aMyZ2zQZDsyawc8Y4mVnSsun93lX1Sxp/TWCVFVyGbs1?=
 =?us-ascii?Q?DbiHWIrKgIpTfn81LUN+q5H9D3QGm2Hz0nWBVg3UbFT3uJiUPmXATKoubRpA?=
 =?us-ascii?Q?Wdlb+PC0zRVCUV5+qJurBqpyrJwq86bLcyA80VN8oiGNI7SzyQrajZFNf+xX?=
 =?us-ascii?Q?fxuAMIH9o30P1DiTMGSK0EhYp32K5w16wj2zkj+f3CaSXe4Kwf1ARA2748nR?=
 =?us-ascii?Q?vl9seNYLavfjCv1KdwUZweYrpekjCH26bFwq1hjnR5R1fTeh6X2aDn99pbzI?=
 =?us-ascii?Q?y3/wlODJd0nqUiUhr3TDUWLfIJTxa7xMoj5Mr1mdgQ2+NqnqArEOiEc6NcyM?=
 =?us-ascii?Q?XMr88pq3Dbdb3eN2zM5pWEEr4L4NVBW/C7tJedVWjnHcyUbWCYeHfr2pYbwR?=
 =?us-ascii?Q?zvC7Hm42QIMUhwREOQroDRC+eyK2BYnjzaCwYm45YPdNzGwaCcExz6JNZSch?=
 =?us-ascii?Q?+8HEVTIq20DKynxJvBkkKzt7w9OpJe3S1aTw7kWpQtBcbLlG+g+jTgOtLBUx?=
 =?us-ascii?Q?RUJHDk2j5qLkbKyFk5ShCtaUrxYziLtdkbdBrK6cIvQrBbwidEcP3fylfT9v?=
 =?us-ascii?Q?HC/H/hQPPf92SybJhsko1Rw938b+1SWGUDRO1o3wpdHYmIna5HGwEenKcu37?=
 =?us-ascii?Q?9PsyWAFFuv/XVHH1ZXAVa84uqn8NLkvcCKV3iaJ+pTk6DzR5s1xcs5I3McLD?=
 =?us-ascii?Q?uuldBhC2kySxdAFi1scWjVpqpG+3SQu+PefsoxdiI8ugnq5D7qssbSnJLtaz?=
 =?us-ascii?Q?enT1RMfM4rJNb6NsUazObBxdRGDwPkK0UDDIcM3v3BkX9ZJT6A+al9fIZ+1c?=
 =?us-ascii?Q?11PViQz39I/3mGFuDa7kxR45dREhSWKmr0qyyT8bkf32bSH2t6BgBwlX/4Y7?=
 =?us-ascii?Q?TvijBLbUvJJk5o1z4l6FF9IyhKSdTG8TOMOmVpaoMPbm/lgcpzH7Ct15IZ5L?=
 =?us-ascii?Q?VnIhnYoEF443PEk7ufM8Fo/x/MajG5IaG6qwQi4k9spGqiQexw2DNLO9NXjI?=
 =?us-ascii?Q?PmLVsl/TdBztp6zJQZHccikKDOOpqCMe9XhnH+4DLA3GHQ+DseGNXxf2kDy8?=
 =?us-ascii?Q?Woq5Xo/EkdMGBR4TGg=3D?=
X-Microsoft-Antispam-Message-Info: enoraqmAvR61bQQ6EIN93gGxEP/wJcE60jx+AfMVLWp+IJ70EHBx7l6sjqp3mhYRp7dTLVZSiIZYiUmLW85/c1PL25FnQBHwSaI8dBOn1eKq+z4oYAQVJ5ruZCZYvFFq+0f3EJi9+GLPGO4tSzUIQScVgd7Zvz6+SHreK9mYgAdXNC5TJs2/Ex+xqGn4zgL2Xq8kfUIGeTjLYK32U28i5wOTXBAKY7gGUDjO/LRstIu/R/EtHAF9GIztaYvk3Gifp2yx/obtaT+0+owhe0vZ4yH/Fa2JqaPO6BytM66JaEga5lQBG8xHsE2jinhYb6z59qz+u44Mxq8PAA09IE8bW3tFkSmQUnk3Lps8PvCt0dc=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;6:yXXyBCJFzshxdQUwosiz2U8k3siN8uBupfnZWi1pWY/S1H5x0EXUoSncncnu53wvfEADVxPIYQ1vZivUtaEiEiTo936MTYeD3zX/TGVE5zY/uRGQr1+r+AZ2+WYKUy3MzbfqQiS5nwCw02mhk+/CaxyXPD305GsZBFTFk3u0f7EF0VSLcL9MDVJa/aGBJDuuOVsB+eYiswlizFcZAcsBsUzhn8w1SmC1SRS/lz4DOa9IH8K3QxMgAhnyAnbC3JibVNfnp5o3J2f0vyFmRMSdQ5hY7me7KkNcatmGi0kGIIEpvsrbYtkp1nTcMpZGl5ieELCLtJW4PiYInsMkILLXZdbJ5sPhlnZ5qmeINZnvUPq3wWw9m+IeQiEd0v4Os3UHH76mRdTy4SLoOz/eAjXmrhBq4sj5vl2MgM/Asbp9C74Ovg588V68u2rls71UbWKs+kbiWeiR+untd5fZ0tSsPQ==;5:zsocDqwpi+fLsGRdcMVuIgpeUAW7sT3/2RJeBg98bGNqMumsbygc+4sbIiZRYoPvvhHSX0GPoUedWENCjvB2ySjERxhLSqIYbBmw5hoXU8p1srYwgF+kbm3X+Iyoi/9TXEf2SRl8P2YPYGLO128JDX/zA+bGlZTVPURjU+hTEvA=;7:Km9Nme4doWBpJp/+9jpl48mf76Y/ZZIiSA2PCXHqIKn9UGNe05vh7rIyjsyOWNZ8WSJpjErunljTKyqhv2g5jOqIffhSilUhJExkMdZ6hoovNEHlglf8cBt3tXJrozZdE6TKcfddVCQk5fTSWxSYe/DFub6MaWuTtXpZrkBO4ZhNYYhr0dRJwXx9DA4Xc+atU4dANH5tKHPENPg1jGDuBgYaRux7TBe5HYOJG5JguEz1FkdEYfZ6CNXNsgcLyM9o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 10:24:05.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81796c74-02f7-4239-5e26-08d61fac5e92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3cfa8ca..75ceddf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -335,6 +335,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
+CONFIG_SPI_NXP_FLEXSPI=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.7.4

