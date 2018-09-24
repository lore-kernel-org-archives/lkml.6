Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1DBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C8820666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xK29Kj0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C8820666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbeIXSQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:16:22 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:33328
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731008AbeIXSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfK2n7Ae+5RlBZd+X6EbwHtQP9Su7vGFVutmyvIpMjY=;
 b=xK29Kj0wlU6hJZTyHhGstRHjG4Ji3rtHZKqKPrjWaFHc1MxdpAn+DzdGIgXrhZOhGLeNfZu+trEYtq6yAoMZHLTOdAEQ1Bn4Gw4IBnboD2iVK3fZCk8+imEGIq7FT/uBMPzdrwaQRxMkBen3lJUGBGLHwrZBLzhBkC97Rrq2jIE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (2603:10a6:803:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:14:22 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v3 3/6] drivers: clk-qoriq: increase array size of cmux_to_group
Date:   Mon, 24 Sep 2018 05:38:58 +0530
Message-Id: <1537747741-6245-4-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To VI1PR04MB4798.eurprd04.prod.outlook.com
 (2603:10a6:803:53::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43627705-934d-4f57-77b7-08d6221745d7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;3:JlN1KdAo3O+/7vyqDyOezRzv2EuvtUW5cRmsTKvxXn2RoYw+vlKd/kTvWy4expk61au1Y1Y63aGjKgWcrY5xczct6AD/64tk1Dsrag2LgGcCtDj1nCkk3mbqwWiDDa5o2OLQ6MLpAx7LeAt/xHdpJTrO1vg1y0q1rXynCfrzCL82KMg1MiTt+0oQpE5eIaIfDwrW+USwTcVpzJVORlaunPxxxU7RW0n7+FCh3/rrdHucbfFG0Q1eIiPhQm2MXKRh;25:fENfHiC1gM1XDZYHFf+TeYUaSkq+DBo3QeBhWBj4ZHSIynUVKhoaGiet8PcFLCj+URGvyn/XLmuXPsIH4hGJIiWJQ/9xN/7WFiK/FwUnecOH4hWeD1884/T2yu2fE2EhgYDzsp/Zl9NMgdmPmI5Ig+YvcPzpHeW1usmmZFKvfqXZXdspMAd+rEpW2/0eN0ezShPey/0p0I7gxbEthabcLe6wzZdDjDW2js/Ee+TPqHNSz5NxFWNqBuqp9/rOk52eqyXx/qoh5PcNuVS+TWVpZxIlY2UGx/oL09f0rCA8oWsVHeurUbj2sNmR6JxDjR6cL33v3dYHg5Asu8s+l+S04A==;31:xVbdzCxZVlEX3Je3aSd6SIgUEFObvsVDGMlKlK3GDsfRtbwsg+NtSxB52sm+BuH5tIyWO4tkO3UvxxDOJEfJI34L9QdPa7bu77A0LgOK/dUaADGaGIQrF9KYLYRyRtVQuGu66NbFYLgM6kcwj5kwKD+OkmuITDMH55M3PHJCiSC7q4p+ralLMZs8WN5KxKjVspjSyQeWMk7Dm1xZtV8LRCOvz6e5Pr1+wwaRBhiHI2E=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4798:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;20:ENd9cMXatJikzBhgdUUa8vV53M5wVnykYkKD5M97FiXTCOmn1huS0XfJnHQJRae4Ah6lmkFOI0S4Fp4NQ+ck5ZpSfoVFaNH00ePRzBxTKXOM042bYMsFdS6W5sGCO+CrwkcZgs2y7PTApRr6t8flDlc9+6Cowth/k1m+QU1ePq2DdO1oTujUdZtKcdk4B6qtNB/eK3aojeSuJlW8u3KRNf7t14mItwFBCZ8P3L7ujSM8uPGvO/xrnQHKn64SW+7+2UGLKAggiJeF8RHV+ftEnkCnqDw1nidJ6GTA+Y6CPXrkrtsnTnvCpZDXIKnrNeRz9AZDvnht6IW7aEmJPS6FXA2ffcQgiB1++oFzLEWK7LNRnah1t+eV/eHO3tCCMnNwNLlZt/VjngKbeFmwmNHWqdjAOJQwgKpiAkiSIGZXJktydk2IoEXJhP6WPkSTzo2M8hZqc5avy1wnaNrrAtrxGJtFFBLVUk7oqR41i8J+o45kjCqfkQ9xosfogz6iDkpS;4:vbTbD5cvcNZUGSFpGHrZk+7hI5uaxYPfp6QSwU7jJI6xw2lwEZWpuHfhSwL+7at6evksLg+6dFUqJkpxPWbyMzIN2iye+LfdQJzfnlngEO+8S7SteT+ubP7FBqt7H+DpIojuiuv0xJXOGNs3R3Cs9qlnoomuhbw4tfgbkGdNw5LXO1H9a+QUwTS+k6Zx7bYaLSlUoiG1gX6ARP+84zXy1kX8Tyus1DHYcEDZ2YYwJGmODuBMKrNcMIWhoFtrjvj8pInePC82MYycSOY7te2BRogTKNS0CTDiw2lllSUEGxlyOYM+axwLuhSNAqXLJ/nX
X-Microsoft-Antispam-PRVS: <VI1PR04MB479899B8BADACB2BEC41FFB3F3170@VI1PR04MB4798.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(97736004)(5660300001)(6512007)(14444005)(48376002)(6506007)(86362001)(47776003)(53936002)(386003)(6666003)(25786009)(52116002)(76176011)(51416003)(956004)(50466002)(186003)(7736002)(54906003)(81166006)(16586007)(7416002)(486006)(36756003)(50226002)(6116002)(44832011)(68736007)(5009440100003)(26005)(446003)(305945005)(11346002)(16526019)(2906002)(66066001)(478600001)(106356001)(81156014)(105586002)(8936002)(2616005)(316002)(3846002)(476003)(8676002)(6486002)(110426005)(21314002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4798;23:ng092lTqmKenLCHW8ieOrw9JHcLwo6+6DhCUeuFpW?=
 =?us-ascii?Q?KZI2BYfLejm6w41HsSUVGBCd67vvMtsUT3/3LjPOT2azAutXqQlLBwySsu13?=
 =?us-ascii?Q?P6375dXa4GJ53abM2/OLdUkZQjyWXpk9EZrCPORgt5hV4ojWk586PkCzFF+R?=
 =?us-ascii?Q?RRJXyEI5H8cXFbZQ4P56DEOfa6JMvZObt5nbvA5bDI/pjzposgwGI48Ozx00?=
 =?us-ascii?Q?rS8tFKCHF/o0+A+wyZxIo7tj0yMQCfrtw4bkoWN8WUwKIRfaSQa9H0uW79fH?=
 =?us-ascii?Q?ojTxYa6wbgAjgCEkovIyDjiUVguu6UXuUfuQdem/6PZBxGH/ySES9HCAw6s8?=
 =?us-ascii?Q?buBbPoS5tPtabzHEo8VUecDdL1nJ5YC39rLabICl+X79uk/QJQqeIZ0s5Qz7?=
 =?us-ascii?Q?sJupyzIO1XGnzEZQqGbdGJwqC2G1aN2vORQayaP1urtUe3f22QEOLpWEHth6?=
 =?us-ascii?Q?w+BujChnRBEGeXgDQyDlWyNw2livT7/IAB/sPxkUFUn8bp/H/RK5E46dlNGQ?=
 =?us-ascii?Q?+jH8Npp5O1nUHBnc6MQtpFhnx8VupFjzkMYGI/Ut56urTkJnU+zmHdajg1of?=
 =?us-ascii?Q?8/zHdVc6LCBP1QhIaex8x4WlT7Zx72K80ssubd2qWqx1S55XA9zxrQp8MUuM?=
 =?us-ascii?Q?0UH8C5+JFOI/8wYY5aGGPQ20rAPASV+/lPyLQi5SUPgZ4AaOTmiGdltx07LC?=
 =?us-ascii?Q?+uftazY+8CY+DR/VrG1PvqCNcI/n0VA4irXJ95vnCUnQpesSSIIeho42Ea5u?=
 =?us-ascii?Q?TMqtXHwCOH4KrRpu0J9cxHxjKyxwKBooTmtw4JBL3/t9nbW8d0rVFuW9OCjl?=
 =?us-ascii?Q?JowpZjOZt6+2dVgAEIuV24wfGTBjfR1Wn0H8+wiQ90/pAZwMQ9TqGG66Dkj3?=
 =?us-ascii?Q?Ko/Z8p2Td1ULRGR68ZyFm1WQQ7SC569Xs6phDwzQsrQlV2BLzLzRVnQzrp6O?=
 =?us-ascii?Q?RjXix0ruzOxWzFog+eOX4DNIXb5YBf4QHQkh8MJFrSg40U3M2Z5jma0lKhdl?=
 =?us-ascii?Q?KL3NFoTUmm+K5jlCr/NVFyhNkK8q5Gcjiv21F0iuaj2QrqwsJGXbpkV0fw1n?=
 =?us-ascii?Q?NClSh6F/7f5b/mGlk3scSJQhvUjcFbZrvmwUmjr5h/2kr8FjwfD+I45ss2jS?=
 =?us-ascii?Q?ireGeY+Wca/E5zxgJZs+/zgdq38Slvc6DGslZwxBYp2oey4HAuBKzfXyaDpu?=
 =?us-ascii?Q?u8QObL3g111xYESrltS9KIOmwO083sR51OZ2h7MSAncZ4yOoV4HOXQvt2xoz?=
 =?us-ascii?Q?SqNXnNW4fmc4ktIDET3H3MS78TfquUYPFgy4m1bCfcPW+POvSfZ28b1rfRim?=
 =?us-ascii?Q?YS8PlvxXBXLVrIC5au107tG8xNrGDwE7pD9UzCxCdyQ?=
X-Microsoft-Antispam-Message-Info: OXeM181u0SKMOmqg2H8lHIJIZ0OKyZW9l/HEsVL9L6z4AwwY64YyTOnfimjVzF/or9f7x4LxHDi/yr8TypBks58LCaIMhnFDJJ5EiMs5Gic/S3uMPCvaiIMtxfeOwL5c5JbATkGWjgp/Lv1DhhrSAp+/toMVQyenVArbWMoCrZ5GneUVGsk6KnElrLwkNlHsQoFsEDJpI/LGfn4bhP8N6lNlq/NhB5CdasBUoB2ii5rX5BgKiCZcXtJ0Oyb/gFikTBFBiR/t0TPDfBziKRLQqGbGCWo+2yxB3Xu3A6jjbr93S03Sg99S/4hA6THGBBX5JA3EePaHpgEh/om8Ir6sChfbLlpinDjJfxJ8hlIdibM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;6:CG0KfBkhvv0NXO03hIoEpTad8bJzDhClP1PZFuITMQjbI4pcPa94/Bv+bihOmQdeK9ViR1QKbLX3Nw+/z3qMQkSMAZ942iatCq+BVE9pUpT3A2CDwzlKm6ONdXTtyAGVhogqzO1iFhAzHxUUAhfDKHKgcXTmdl6+4FtbhUYWqXjFDTnVkrziO35GL/BhJjVn/30PZYNBA0y5P5JAbQQwMhczLtyYzaIb7TzDcmsJ+qrDM7PXhMKGQHQf08OIfvWnLfuOuv0vAEnIUiINLnWhMcNANonIqy6weRnw7YbI+L3va8pSSjtSPK6kiu0vMIanL7Pcq8A+OzZjHsJ9QnL73O6h0mpXPdGlNdu52IK7IwcT+zrL6bBRpwrY9kCbmHiZPho07Qyp1ljbHQl1J6RTpyGBBiaXR+GwX8xBGJ+hy9G9iDHfBOTMMAfke2b1XNIqICVpalJodOYNuNUkWW+/qw==;5:qi5Y+us64c5VTFjFCw0WqFfCdjCOCXj2F9Js6ZKeShfym04YRj+qEJvkq8MixK5EPcwwynvr72xxQJ96WfNB1z+vgTs7up3gFvl/TxrQoaaygdPIk9vvdg8gml2PnyZ0ELlFmnlDi0ILw5cilwwqMSizy8mOurgjlWDGFI6rqwY=;7:4k5t/cvCt9PX0FNvX0AS0pbxH9gMdZyjDN5812yYT5RBULsDUZvvU4blcrMjJmw99fDmBucTu1qoAe0T+dPIB0sL6sU34tlZCaB4u8MVDVltk+EKjekPIui2f8gHyI6HLyseZDZrGUFHMyBHdb00rj9M3zitTvJS5s0w0hNjzo9gR34+rm89GQkDPrVSJvR7UrhliewrK9qG8ds77C3y91Devw7kMhGyPzJyhsivOrmOpz8T20y5heLcS2FTpdxQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:14:22.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43627705-934d-4f57-77b7-08d6221745d7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Increase size of cmux_to_group array, to accomdate entry of
-1 termination.

Added -1, terminated, entry for 4080_cmux_grpX.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..e152bfb 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -79,7 +79,7 @@ struct clockgen_chipinfo {
 	const struct clockgen_muxinfo *cmux_groups[2];
 	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
 	void (*init_periph)(struct clockgen *cg);
-	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_CMUX */
+	int cmux_to_group[NUM_CMUX+1]; /* array should be -1 terminated */
 	u32 pll_mask;	/* 1 << n bit set if PLL n is valid */
 	u32 flags;	/* CG_xxx */
 };
@@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
 			&p4080_cmux_grp1, &p4080_cmux_grp2
 		},
 		.cmux_to_group = {
-			0, 0, 0, 0, 1, 1, 1, 1
+			0, 0, 0, 0, 1, 1, 1, 1, -1
 		},
 		.pll_mask = 0x1f,
 	},
-- 
2.7.4

