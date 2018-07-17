Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8491BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33275208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p8kDW5F7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33275208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeGQFrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:47:46 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:17547
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbeGQFrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7tgxPeYn1RczK3TsUv/1AI0RcLDa7pvGXo+/mO1320=;
 b=p8kDW5F7D/pSweOZX0daE0tEgfc+4jUA10g8vjn2+aCbC1ieSHo2YN66zy6HAFyjg2fcAG6hwL2zcMSia+PsHds8HkDl1T1f4Bff9zvu8RVp5JCMkSK72Q/HI6W0GdtreYSBvqgANCK8/seEN+6N+OaUv8sONZxSjBgYt82Ezy0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 05:16:53 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yibin.gong@nxp.com
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/4] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Date:   Tue, 17 Jul 2018 13:12:04 +0800
Message-Id: <1531804325-3476-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
References: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd2551a-95d9-40cc-30a9-08d5eba4846f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:Tq63z16hlEgGMDP4ZmStf8CORXXqbc81b487qdgJIo31IeJnMQ80bRQcR1OG6A75N+Q+Y31ekNJhaV6GwyTL5hOIczLJmRuzXgqWmIvyGvAffiJPH14WWHacUrHv6OxOHP/NpjcAkOeWmZ3FPKLJtDkafQvfEO6G3A/i0kdsI2e34ogMiMTOFakESaZsGKcA/0nfyyr60Wr/7D7e/6noYlBmJ7VEeaXvcWaLBtLAYTSIIAvuFgJwMUK+DwnGhbkZ;25:70jLSpIRxtYCddAALvHkU4Nr98AwDUa1lAWAFvZv9vLjlq8L6avimW60+7SjnG3Cdc5nMVEIa4VKfqXx3wukwqQ+ZKwtfLXl3GfVMiPHzLb2n3Clj9yXpZ4duC6RScrV5G/AnkJr+sLllekJrkJ4crlV38pOuMz23EfJFi+UnuX0e/7492/mRmFGmuYqKmSUkmQHJyb2xWhOHmj0li/QxLSTP6a/BUR5P1b5pIBWyu91G+6zq/FJfXMcalRG8Jl3EQ5RdAB5KAoHCQ71dVMw8YRs6HwxEbHp1Ufl43bfLtGudUUYBtGwsCXls19L0WTnfl6OGrQJ93zIL9Zr0RwwaA==;31:qIZqM8REF6pvEmS+DuSmPkiMfyYImaoAWwE25fbq+kSjacK0LsfFpH/+jluWLTYtqOPnmPp8+bric+oVQq8V2sUoUkTkB7X9KijRwMb7s8m845m0W+CFQhPRYewDJ4xmlGL1JTTZK5xzp9ahc8Uz2nM+25nHu5ZUomAqyFmgjxGvqFywP3WY/50CYQxxLX/zTi7Chme2yzMPGRqFpqxDQLUto+43aP9OFNdsG3O15HI=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:BCg3G6sLHFy8sWLOYOyd0Ijlgh+D8lJgHJVJdJ3Oie0ygXM7eJDvtokATuUzh5pbzVZATMJYfM+4QkqE1iQdEw9/3j8Aud075LFCKyBVSdTjwO77lvy/v7GQjDmLHIVGdENtIGfpllFtUxaBKSnqtm5WGWsEpTfnDLrP+YpJZWnQZktMl9Ob6I1/cmCWF7+t+ERtYbR03tYCSD+ep+g/W5pIwl2D/4lJ1vPWWmvYqwJ7tr4IAWCoO1HN9GHmHEUDfVUouIZUChIn8PNartHPSXH/b6tsM5KAoJZ3P5x4Vbh0/mqa/sXoY6//oUPO3SlSzZ1dD2QGKwatRUxx7AQJjY2vedUBty7AQZPjqCHSlH21RfKqRcD8J/k3loQMQfBDFQLoDuZ/TMCKdBEpX14C22rDmUgtbilv36rMVUcwwvBkdJSNpBJ1v8bPA00caY6HcJ1XQKgPD5kqv9SbAAipii89bXJNVWlPvyGVSZ/6Z3fs80bHnc9t3mB8V7ACxt4J;4:1Qmvkv542C/CI0EdwhWipeToXykdW7Hr2Ys6r2oyg4H+A/Rr1TCWrp+PcM+gnoHAMGPLUQch8jyvlDqf4ESW6jZQVv0n0suvf1zdvmjkYNTNagkADDsMrVjRkn0anJFKeITHysR+yZDobehxzXW5Y0KTUC3/+cBjZAolJk2akrOhnx553sz3yJ7wNX3Uo3ir58Z7dk8cO9YyVLnSVsdSxSlxEAT9Cb/vHbBa3Cf9/9FPLa+N2CINCPcbvdXmq0H1fJ9eBAvPhA6vsu93ol85Gfyuolc4eNyBSsxTwiD5w5QsFLA3BjiyA8tVmidMgEq7
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315BC006DA8BFA2DF10A331F55C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(50226002)(66066001)(486006)(6506007)(25786009)(2906002)(47776003)(16586007)(68736007)(478600001)(6636002)(86362001)(316002)(6666003)(36756003)(50466002)(386003)(26005)(5660300001)(48376002)(106356001)(956004)(2616005)(11346002)(3846002)(476003)(81166006)(81156014)(446003)(105586002)(53936002)(8676002)(8936002)(6486002)(6116002)(16526019)(4326008)(51416003)(7736002)(186003)(97736004)(305945005)(52116002)(76176011)(6512007)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:WgdL5EZwocZpgdMX8L0brpbUGSGylrGxM27Gg9i0d?=
 =?us-ascii?Q?lef1buQS+1We3bjLN0eLBRxNc0lGFtgAbtaT/7Y8YSmFPBxsEUsGw/BcsGzZ?=
 =?us-ascii?Q?jUFARLADFjC3AEkkyMuYThRvIPg/nchTd9kwyXnFjpxkpZsUWVcT617zCRTb?=
 =?us-ascii?Q?Qc+PCfepzexGAUb2pvnEyYeRkD4ecdSl05fEUl20Ht944oKjN6x56QIv369L?=
 =?us-ascii?Q?guV1bUODFMUbiB+M8r9uiFqucBrWbXMLVzOMIWFU6SLYH9eo0lhr07/TZ2Ue?=
 =?us-ascii?Q?TOnaUgQan7fTbG1PSd2kkKDP2I/sHW90Mez8ByYjwd5uD722fi+TsX5LP22n?=
 =?us-ascii?Q?pfn0oarSa7UzXxwo+47itQAjnr7ZDCEJ7sT7/nV4yjzoiXd2cHPogAhdSAfl?=
 =?us-ascii?Q?w++wClaQyQHpyLpzeACwxXxw5pJx4ZLQ9DwznJftDsyH4sp0o+sPVzCXLE5R?=
 =?us-ascii?Q?dGSXj2jTL8a8wUFS7iXt/boK8Jqge6T1s7G+DkfdgpRDbz47A5x+loCU4pkQ?=
 =?us-ascii?Q?qFAXbv1fcEccoHxW9pVRWVCRxlfuJazx5dUTpJVJ9QMB4OUl8RdHjE7YlmGD?=
 =?us-ascii?Q?HEm7mzPKgV1g6IW6ralgtg1KWpSTQ9zRXfzOWl0a4EUdgMku0fBC1sPgzue5?=
 =?us-ascii?Q?WEUYeYCIGw0Sq/5Ez3rAXOmig0YvXYVI5z7+qNT69zkBlcRR6gvXxk8+UK/U?=
 =?us-ascii?Q?G37JRdhDGgCEjHLTRWtJyG7MfrhcXEcDjQ7axXalbCncKv+g/m/InIZ/5V0P?=
 =?us-ascii?Q?Yj01GYalY0JYC+RF+YWayF32cSfEu3v4rAeEeWw5cuQr2KfVhoeeI6gX8Y75?=
 =?us-ascii?Q?qfVlbe6oLzjJBdGYlhcSdq47HizJdgnx2C7cJa0lQ9qLYVvT/zdQiPmW7mmI?=
 =?us-ascii?Q?E6rageHowqG997gIa4qIcEjIXCLAAeR2Nc2oA0s8a5i8MZOm+FxTebQZjfiC?=
 =?us-ascii?Q?mKTHtvnj8CXWQMR+RFA4kEYQttuqrly/nF01e+A5s3nlJopb6yhwAIXG3FPL?=
 =?us-ascii?Q?tf3hojkEdlb2KO6oYKOHXNkiYyjJPv9TUgr7aN2ZlOwxD4HnxRfQyzfTkrGK?=
 =?us-ascii?Q?pnfuUxS1KGBUsjw21DP2lctS2FzHAG5LCHo3RA9BmG9xlAyZTd8wuntiINZC?=
 =?us-ascii?Q?DL2qElN0gg1d91osibsK7LIzqVXBG1aZs6o+I4klwUJg42cYCpnxJu8R7CmY?=
 =?us-ascii?Q?t7LAYDG4UfKxnF+xGk296vJ4bJzPdI+NsbxABZvk3HemGm8hZ4kist9NQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ugUX1kXOIWp4wPYt3noKFLNjXM3BB2PqSDpsaEmZ+bYh/AUJxeTLoHhF+UpYs9XOiY1fWu7GXNAWitPKG8igmobjHXX2ipLlQyfIMErPrvfg06/CFgEWe1tBTPKf3LGLxYbvEewEKCh72bWjFGZqL3qpZfG84tu/1BIicjYkDJ3Pt8V6qd+ScHUz2V32EzcFzvsqA89+BAQOqmr8+IZSzqDosFJqCDdIdg3tUeZJMYVNf0pACAN5G4GPQeasEydvDUMTHI4nisPNetaynWe3xxv81Sv6THReIBJCas4o1s87oJuPH1QkofXHbyqf/nZf5lJmyUQAkfYEritJpgUrb581RRzJrB39V7246eh08B8=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:U9ZVYd+hRQ3itZHNT1XoPbvx7wafM9o2DNwqgX9RQ4EzOik32FZLJuJ45KXgOMqQp9ZMM9pf2WJ/18cKS0ZFPRDKvKXmWnt/kaaQiswORb6Y+PXIP0HOiI6IVCo0yNAQ3ROqzCnZiZnH1AYFM55LSdFnakSKHgfSMFsMup2gVMKrph3l5Cx/OxersZfUFwMpomSLXrNsQ170IqVYlG0Bm+fwRob8BiAPAqt/YboHwzKguIQTxpkNJRZTgP+dI/aFaG3+YMBVYWb+2cN6i0FlsCOhLgp3Y57a14i+pw3EJDtihgTaY1sMqg6kzJV5G1jjArmxivPW7X5iQVLaD0tB/Kq++1wIELTP3Vcj9Ff05TcKAFFsfwW6TKnhBI/PBzAjMgNSWZ5/p3jDrBdHVnOzC5h41jECBNP9y+4kauv8kNigkFR3Ud+9FiknOhizLAXPQ0jfbgNTXBwIKpxQTLItVw==;5:g2k3yO8ymSldRUf6Lt3AyweuKojeSMuD+RfU/VuPJymlxVZEOvl8ldBx0xdv6aBgAEkdIWAdy/vmrFmCvBmatBM9PPxj3QtjpoUtGJuAULeDO/qknXjSVWv9xw86+ZxuQadDbltHHfUBZr2ER7P7iGshM5Dd4Jig47PT5itW4NE=;24:Z+vuSFW4mRGIYRPvsGubns+ioIpF9iJpTT1I1gOGY/br6ZehndFEjl59iYVs5T1SpfcpXVSmRvdg+4tZEZfeaA2UnweIYj9mg4bDn2ghPXc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:HE5Ap+w4c9IWfsGE4m8rgu/q1gekqq4LTjwMgDuycEEs2cmwtwR+WDQc9YVgaZysFMb7NuxEIc8VokFTimBB1O2woT6bg6Ij3ZjgAIhJB3JmB6SbCYcZCrGaNtcfy7ufs4IqYf6mXGSx+ncnxo3Sf3S6cXMejHoMd5Hwn1BCFDZ48zBSFI6ResWdnYbRvpAQm+uVvq3NWh3DqtT+K7TpQ47cIr9JskL0s+k8WsPFFUUdw0zRZRpgDT8F3fsjlSji
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 05:16:53.8058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd2551a-95d9-40cc-30a9-08d5eba4846f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, pfuze100 sw4 supplies
LPDDR3 which is critical for system, must be
always on.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index dc34da5..c8e1155 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -177,6 +177,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

