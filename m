Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D3EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BF820855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sDcZtl70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BF820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeIJSpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:45:11 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:34336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbeIJSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSF6WsMiQFz9osmzQtZq5/GO4k6ZQuqdRQNL+BJQVlw=;
 b=sDcZtl70nflqmyFNRD2DJyT8HWxXTz+Vnm/tFBb2iNNAjvujMueoqCXD+L5ephwvi/0DPGnz2ERhyIw3qPZF6TU4wOOtefxRdDLNPaG074dJqQ+tx9gLiDX8vM5zUy2OKi5VtcYtjGaZ4i6Y2w5ncY1cC5/aff8LGBtF3JSDW5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4476.eurprd04.prod.outlook.com (2603:10a6:5:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 13:50:39 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc:     m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 7/7 v7] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
Date:   Mon, 10 Sep 2018 19:19:21 +0530
Message-Id: <1536587361-11047-8-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::11) To DB7PR04MB4476.eurprd04.prod.outlook.com
 (2603:10a6:5:35::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0114417e-8365-41e2-d5c1-08d61724676e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;3:pH9A2RWzRGbRyjU3ErcRKKcgjHfoZBn5qVnCN9bFtd0eSNN5qcqF5GOpfp1UnR6RPMMNf9fXFuH5lSYj2eMqZD63uGDEXXgWyPFA/yv0X4cdMTqXMquRgELhqlpZ3Qpt1Eg6+SK/cv+IzfP+Ok0G6bnVSwvYRazrpexb4VDyA7mZxgkiwODqu+6/XauVvc4jBsQHE+jy4AmYmZLhNcQ/B1oE/9NzXP/cjz6Kgf3Al2itWjncAG0ZlHHrN0CPnldR;25:hArr+09ayBXV2JVxbRkZlos2IqN7+E+il26NbwJBuemPecGDAFM/WpnM5gdYg6GF1bvhJpvQ4LFC+VrL12ehAWDl2FE8QAgHhIttY9eadhdA75sc4pywWu4PmJi1vARXbJdaag8jD0oK8HWIEr66cXXu65qSu1kkY/Gpy5O4/kaJDrQ0tnIsqeLEW/85anCELsIGmgNGV38/RY66V5UM0SKfTUYv2pGQw7Q5HWusgtbfMTSzaLr2U1oZZGQn3t8NgHWvhj8PDWHk1VwIGhp8U0IBHRT3rzJihs9qECQkMLG5czyoYADfb4bADXFLb+RLPfMhVEZ00wRShV8H/EDiJA==;31:gUhg/qY+E+ElQDSoN9wLTIFQG2rxn95kwZ5cE2VX2JFZdBEB04oJ1J5HBjrIqCYIlM/ub8SljGAPxBPANGg6OKuI3e9NDkbp8GerJ4dkqXajrWgHyrp4ZlH2dFNUSh15Asaa6QPThDMdlpaDr+IaUgeWUK9IciMDdCiI1WzFYYFfI5B7pmNsSWJvgsQ5OocZqT3o2v74PHGYxQAJMdJFtV5YXgVjqWSTP0UBNJ8YzdM=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;20:HEn6M2CdE4ehcIu5LLHF4OIjouINxqBcwh5CLv9ppY1KSbQWxbrEipeJXwDUeMYFTfZr9yGZ6qbObrCMcPtXNekJhd46oohIVSQJlEIgVh5a1yHV+Yj2xAGHfb2WNUAzm9+tj6+bK45JwuXONQNdbl2In0MFFLshZF/6uVes2WSH9s70znWgrn+/9bng31QiiD8wEwXL0uglIRS74tI+S65RaCW6M04VuFBpg5a/+0B3Ww7qflfn+QSZ0/jaVP7BLCvZ/8F1cd5jZmwsJV2PClGshyn+IT3ZK9FF5/8OPXpaIa7CU0Y+2g/nKL7qb5bu0XJH6OTNM0clfZftgX2hEdwNq7w96vw51LRqQtwMVmXKQxY1a5wuV27OrrSvGlkY+4JksIUk/Zm60k1lifuG25iz7emXceXjPmnDyuE9tHACU6jTE5mDHHCXAIYMvhSvH2RPMlOqPlNctliqzgwu0Cuqqngx54eFqUSYoYysQydgKnzghzAwyXSItlFyf1Qy;4:NFqu7EJaEdPTKPbLbCAHNIrj94HgEbyGPgX7E7l8x1yt2IrnxEVPzzxg0T4QD0NjmjXzFY1OKoUuhcXWjH09MwB9o7fWiwSPPmAhao1nrVRsAAwWwulUIlUqsP3QG9srnNUnH9sLldsJXOfG/d3lPmTwJq2m8d2ZrP6nBxuLNLNy7vhbKUGj/G8dkFRWbR94mkuXwTnJcbZdERMo5+49fasA++UIhzngUCnkK0YhbDODZ573JaCriyZi5LYHWYB1YBNy2EkGT60R/WOYpzO4cCXjbUbZBPIo+nsm6fTNQGsLxk4cOojJtnCmgaWRX7OOR/LGsG/y7Kg6Exkpg3IV3WA+AoxW8/WCH+xN5FEkK5k=
X-Microsoft-Antispam-PRVS: <DB7PR04MB44763A18B2A1BFD381AEE246E6050@DB7PR04MB4476.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB4476;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4476;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(14444005)(48376002)(81166006)(8936002)(81156014)(105586002)(106356001)(44832011)(53936002)(47776003)(50466002)(7416002)(316002)(956004)(16586007)(6512007)(2616005)(575784001)(476003)(26005)(186003)(66066001)(486006)(11346002)(25786009)(6506007)(386003)(50226002)(446003)(2906002)(16526019)(86362001)(55236004)(6116002)(3846002)(97736004)(4326008)(68736007)(7736002)(5009440100003)(305945005)(6486002)(8676002)(478600001)(52116002)(51416003)(5660300001)(76176011)(39060400002)(6666003)(36756003)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4476;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4476;23:l2bQ7CJzjIVHYL69EaTULXNajGnpMSmhHSA7mRemC?=
 =?us-ascii?Q?BVxs7Hg6/cAaa3ajlazUowcVJi6qmnQDdoLb0in9fjHXQsYiUO3MzK4itKZ2?=
 =?us-ascii?Q?OUBfnKOwx0T2F8VsZiWqaEJx+mS63Mi2Omqh4B846QPlyHJKOV4N1haDGpiD?=
 =?us-ascii?Q?nyIUNrcbQz0f4rGiKdfT8y9ucbGysisvrazhFLvaAcQYjSarEpWk7I5S4Lqe?=
 =?us-ascii?Q?B7j+5sInvDbcwxWdvxj3Q4aDZiUTJNdKp18kN/hR3MPxb3phT3pNXL9SKOrO?=
 =?us-ascii?Q?kkz1woyHfYGKwRdILgtWBkvy0Hi9CVTpGmO8vyLB921vrAjjxH97F/A5NnzM?=
 =?us-ascii?Q?TKHCVo81ylwvlIOqj8n7gbpnj4RM7UFExnuOgF7Ctiv2mSgDwNQR4SRVA95p?=
 =?us-ascii?Q?eCYBu0pzznnbY+eiIOixWXidaB4ZzRf8Ehk5zGqNahYO00ZcTQ48gpr2T+4J?=
 =?us-ascii?Q?AK8RuhfnkZfmPl1Bvevhfn40Gww1A2TOZ3oGSprEFaFZ3+rgzJv6AqJmFihT?=
 =?us-ascii?Q?U9ufZ2k2E0dJuaHN+9vapwTtjtGcbss6onzMo/4cOSsoMD8tn/bkFkByM3x5?=
 =?us-ascii?Q?+ywDz+9dqNoSDI/2f3t07DgfDUU0HMhheUZrirKzNzKmbrj6ieOnG1epeATU?=
 =?us-ascii?Q?colazjsrpCnnL9TVRoGAizOA/9z7dC5XR7ZZZZh4DDEi/lz4qwZTvRM/RqWi?=
 =?us-ascii?Q?VAC8mPRm3jqw7uhGhtvVnPVOzQIvTMG7zJNA1j0tyAHy6b4e3APV8JxkSHjI?=
 =?us-ascii?Q?KVN22oc+bzhmBwllebW6/2PHvtrS1/9A4GvaNeGzTKcOCkPC0eWiaRVhmU/p?=
 =?us-ascii?Q?CVYu7FlqLfiagu20mNxBJPnKgXuYirCn3bTmRKyITg4lpKcH4NF3KCpDyvP2?=
 =?us-ascii?Q?fboRtw8IWLBpULQ387XqKAJ/ztunQ0bVpeQTTtdLVrqG5es9HQToUMw7bf8W?=
 =?us-ascii?Q?JUU3zGQlC1hQjhyN6AMBEnjBIsNCrljzTj1Zp4+wxZNnZG8gCoRzlU1fpMGr?=
 =?us-ascii?Q?vAzXANitzdYjLr2bMHDZ8Jo6G+B+nyr7CqATzYPtevvyvS+63n95++eEfsWk?=
 =?us-ascii?Q?58cvUpMdz/2Kq/RnZ8+l1SGzLeHbVCbTDPicima3hpqrcv+0uWUpW9eScpGr?=
 =?us-ascii?Q?95sLnoKoM/Y18o8K2qYUaq1UFampoS/DMepYDXCu2GsGZA2GFObGgcHDZRN8?=
 =?us-ascii?Q?ouoGGuHgfTjqsFwP4uyNpcbOyJweURlHsCwZRfHR+EYLuDkQ2WLDnydvv3Ww?=
 =?us-ascii?Q?pYE92p7ANBV5whdIVM8erElIqGrLA/NdDtgm7w5Dag/kgHXUwqRDRI7zinup?=
 =?us-ascii?Q?l8RMdQkNGtaFVolZqUnxyuG7auC0mA9dlNX6I7Pc2+sxutucc3Y/C1q1MNE8?=
 =?us-ascii?Q?URPKzWqjWRHqLva7gLPokaN7jQ=3D?=
X-Microsoft-Antispam-Message-Info: pj6vywbTQqCiWuWwAgRM0HlWpygT6wSWpMyCpLb+hq8ABxLeT4xJXCDHnuSCTF4QPKOlZHmzvaftQZN/zKzWI1h5G7LRkEydndXVUubM8kIYuPN0yTgeEDl8PkaQzjfK76Dzi4ibc+j+qdjgcq6Z1kia7E86V4cojTyuOHhtca+pGSCkO71orrZxU35UpqhUdVOmDsxLhiTKM0fRf+1rvt6tjNh6lwzd1sGKqM+iK7KNjtIyjqJgoa+2C5TKem2lR0SzG3eRua8QXLPTGyh7p+nkq0ajMqBN+w7PtCFQXl6MzXw13rGimthYXgbXLAql/eejUDJVwmYYd3EGQcE5MJ3EvaZD3XiRZKdX+yLujLU=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;6:K2NqBG/6qTs4kaWGx0Z9yG91lwRqyqEmP2uXljxWAOEVKN3bPKdbmoKw5Hw+Eqqp2hkLDY3nRVXO5/I9Uz1nL1VI5q/ephGWmN6REOeoJLYvZm8fNuhFssiGWfkUCadR6rCWQWKNhx5Z+CauctSEFHuVfufGaT1UYSyjI60WwCsjZdjK7oBSaeOw4pJuES7qx/pTleBM8QgiKssik+YwxTWQsN8cG4+uBzgQmAjrCKB42r44guw8Ig2V9KczAPZ/OLDwTAnvu9pc5HtJ2SMjbbYXhzRRQVUpedL1uvEp3kCofYwVs2tExqAqXl14K9WiwDXRHGuyZQz7H9Qsit8usbQrCbly8hEAdssOTwgP0OH0fXLfx+eW2iBuOTQ1cOtPeKrdkxqX0OVMU4La38bBf3dhrNcgasvCgsIHcSEsxpC6EIid+k25KwegDYPsK7a2SvLoxE4c9eqMD+mahrTETA==;5:xfFd2vR+prpdbAUbUXSEb+qLKr9xxAUTaRWloeORr+Q542Y5IdeR8PByIxc1+5NoEJ7SNff2Y8Q5rliX6I55xTbZUB0Oj2e8wORu9sui4KGSicHYdKng0RDH2HOuJ405p47aDlFDxApQkO9vat+XF0c+1X+1IaXXU1LFeze0lGI=;7:fV6piyY5wIk5Ewp00jruef/DHBrNxjO4F3/RlFmn7Z/LDoE56gh3InHZAFNYp2y4fYMLfZANBSCJYTO/6B9p6vZlBocvtoT8nJVhvy22wIr6MG7mpPlbYK9UyT9G0nnwLRLOBB18BKnBvsQmbNTmahyn6D3+EEGr6T/bCLRWLajrHsV2XKBkW6MUULMYxirnQmi+V0OhE3C1NWWn3zM0p+15xSYzYhHQPK443XOT+/5I5HbmnX/5UO9PWXobeAjv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:50:39.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0114417e-8365-41e2-d5c1-08d61724676e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl-mc bus support the new iommu-map property. Comply to this binding
for fsl_mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 137ef4d..3d5e049 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -184,6 +184,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
 
 		clockgen: clocking@1300000 {
 			compatible = "fsl,ls2080a-clockgen";
@@ -357,6 +358,8 @@
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
 
@@ -460,6 +463,9 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
 			#global-interrupts = <12>;
+			#iommu-cells = <1>;
+			stream-match-mask = <0x7C00>;
+			dma-coherent;
 			interrupts = <0 13 4>, /* global secure fault */
 				     <0 14 4>, /* combined secure interrupt */
 				     <0 15 4>, /* global non-secure fault */
@@ -502,7 +508,6 @@
 				     <0 204 4>, <0 205 4>,
 				     <0 206 4>, <0 207 4>,
 				     <0 208 4>, <0 209 4>;
-			mmu-masters = <&fsl_mc 0x300 0>;
 		};
 
 		dspi: dspi@2100000 {
-- 
1.9.1

