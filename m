Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06AB2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bMLcUeQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06AB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeG0Pfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:35:30 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:1281
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730714AbeG0Pf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o1i4wMVnApKq/gMgTYWcyYSUdD3ytXDaYXqbu0oRbE=;
 b=bMLcUeQcNdEJ9gD2SvU5rlCJs0BTHKn/OnccUX3JyckuDczwG30YFLlxFSRlvR5mO0Oy9ZLejY6kX2eThg8CUgWjmR0PIILykxkrCpbZGJtD9R00l+K11QUsqOcjIOTnlDj35ShTMRqYZJ/2tRGk9MpxDD0QajnMAmYlOGI2aBk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DB4PR04MB348.eurprd04.prod.outlook.com (2a01:111:e400:9831::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.22; Fri, 27 Jul
 2018 14:13:14 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 2/2] staging: fsl-dpaa2/eth: Remove unused driver version
Date:   Fri, 27 Jul 2018 09:13:00 -0500
Message-Id: <20180727141300.17511-2-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180727141300.17511-1-ruxandra.radulescu@nxp.com>
References: <20180727141300.17511-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:805:8e::23) To DB4PR04MB348.eurprd04.prod.outlook.com
 (2a01:111:e400:9831::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2980405-97bb-485c-bcd6-08d5f3cb1840
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB4PR04MB348;
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB348;3:dtowq1hlfVYdFGYSqumGYHI1NHEkc7lO1W8IW1trHFcBOAln0bZXqrb4WZnf77iVKPad3qZpq+1Z8aT6ZqzHe2J5tfJoeWWlnS1/F1Mu3gKgGUwSIWGI5+0OygdGIAOayVjE7a1S9l1OR0Q6tqwQIbTPezIrflbwh+SGSAV+OGK4IK0W4eZ/ParHH7Sdu9/1cGY3lFD68reD9nIRS63vNcDuagDoJJazylsGQVlcEapLG1mYTNhcCZqBD7VJQzcy;25:iBRJj5DLSXZw0p88yKuqpvB/EXCoaPuHGEmqg83e5l7V+AAgjflc/KGJCR/8DUppCkeK8xQYib0mZ/Ucyghn+gIAKnV8e3qGR5ruAMCtvmQCDKI1vuEyXThsz0V1uUD4NzZPERAnOvzdN+k6U23x8npW+ECWlipIJmBFZDAw6sFW15+mk+3UGo60V8egJrKXtB/pmRGmHatRvaqMkr/lBbbfy8wsA54PF25do1NFSFNpfhP0oJ/MQF6JXKM8MVj0VJZt+NzPKiQIDW+4eldGc/Z5JLkO+areE0ZCqpUZk4nrG6IWtjNlAcQZJzkAgc+YB6PDq48/fU2BgQ8K4XueVg==;31:bFjD0D3v1UvISXA4S5/OT7fYImd3MhIaAdq/16P+ZPr6RtSuzP6ZoRNr04L63JywIc6x1hqoduNPbOeBLOuNaqzlXbxyeP7qSr7Ro1yH5hX1AES5CAoAhhF3i9XB3vnWb7Xi8ocRu2LjEjQ2bno6O1NpihAEIzKB/24hdLrxOP6K0P0s53xem3BjfHVNJzJJAau7Ap8XW9uOYIfLNR2Pvd+wLIhMVwEOP4zfX9hqQlY=
X-MS-TrafficTypeDiagnostic: DB4PR04MB348:
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB348;20:hvi+rR10X4U9r7EO2R33nUITlmA2uopkntNfgavJ2Vr+HdVM25sCJa5967mf55idJ7z+0Bg703TLXAWezsghV4z4JpPQQFsboZwUS94RC8XSulj//iEdYAGQOrAM0f+0oJZF1j09DQ9rYrYMmG4ZUynRhhTNYxKLAEbvBv2GJM9idq/JvVhjf/52SkdzyOnab+JaJfKoPhgYoQabhyvQTHfi9hgLrLx60o3wVNLGaNk5xqEWCik7VCjW8kmTzfYGFXYmfBvJqA4maV07cjk+BJA935Kull+5Fv1OgCx2jyauucwHcMq3lqu14UsgSRsrlYYNRfwUPam56OVwjUGgGXDMfphuAYKfvjeT8yqFYjRQGPOSiebqupWbEW6h9gwcEgRi3CUKTvJcrR77EaGnOmkCcfaz2VBMjLr4iRtMILSzY2kE+OQk4FyGX1toTCh1BA2djIeRkxEZCrqEgEbGIDNzHgwD78NCC9kSFuysU3wxlRTpT/aQzhH3NLMyCgs/;4:DxYB/oARKbeGaPWVY34H5je44wqrO2UBOcU1kV/KW89kR1nkrgR6BzPmiUFs4NsMuai/h0W8yH0LWLBKW6AVsJKcziqjN9612FmC/1dEMmHFLTHCUPbGdGV/LehqsDnbC8lxc4cJsIWj7qcOpbGzlVcYn8mgyYaqlHuU1hzNcLOGsXqh6sth3ad9OjdLr6/7HwQGdY4/r8/sb53ypWN7iKveq8BvAKEN9fJ1Y4uBBD4uJMt19BTZitz9OWCWjt4X1c+tZVrKQ4lI15semDMERFxuESCPMtmiyCLFaeVD9+Lgg2Z8V9jWHZePl+xscTwQ
X-Microsoft-Antispam-PRVS: <DB4PR04MB3488CD178DB6FC67ACC72FA942A0@DB4PR04MB348.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB4PR04MB348;BCL:0;PCL:0;RULEID:;SRVR:DB4PR04MB348;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(50226002)(6512007)(316002)(6916009)(16586007)(486006)(8676002)(8936002)(47776003)(476003)(81166006)(6486002)(81156014)(66066001)(52116002)(7736002)(51416003)(2361001)(956004)(25786009)(305945005)(6666003)(478600001)(76176011)(97736004)(2616005)(68736007)(36756003)(1076002)(2351001)(3846002)(53936002)(6116002)(86362001)(4326008)(446003)(2906002)(48376002)(386003)(16526019)(186003)(5660300001)(6506007)(50466002)(106356001)(11346002)(105586002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR04MB348;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB4PR04MB348;23:oQ+rXYXi5sFmjvNQy28vussTwv9s4S32o44yF5S58I?=
 =?us-ascii?Q?S0tuPprjAyVuaSe/cOgWRVACNfiLd0mqG5nWzfP71mg03Eioti3Ql/ntApv5?=
 =?us-ascii?Q?lzC4RpCuACPnebHPVkv7bocATIS53HkeWBmgE0Rzu1xwWqPMTD5/ASH97y1Z?=
 =?us-ascii?Q?N3O7mZpY8kJUkBoszTbhV/ZM6x+nXS1ro77qwM9UVB/IJc3IvK8fIS9BuEiy?=
 =?us-ascii?Q?cXGn5sHIcYvjCIXvMxFmNDoXPdWqY8aaAaP9gR7/pCm8kpjpLOxwTn/g9v3r?=
 =?us-ascii?Q?djrVUeZvlF/2zYCHU37NtQaH91MMvBtH53P7sTyKFgfFwBTSZgvJgnOqDRJL?=
 =?us-ascii?Q?rq1w117/7PM2zi+sVabfyFu6SCgYW1ZYh8Jp1PTyVHxJYfTkiOChO2V9tk7t?=
 =?us-ascii?Q?qfDM2r8h29F70DJgVp47MUrm1fPiI6LilLxVP+Z6PKNrAsubtGEG7HMb35B8?=
 =?us-ascii?Q?3UJve1ElURyrybVMQ9dYvUqcWnVVBRGzJkqiGERpyT/sqyuUhc81S5Fpzcw/?=
 =?us-ascii?Q?+b2MR4SqILBrvdXNn6iOil/d0sM/kG734cSWdLGQj7ME+4OGSOe743AiJ8aE?=
 =?us-ascii?Q?6TjW/vtrRmGhJHXUBlgTG7BJQozeZfFG2clK9wRGbp/hAWvVDzjLIYQ2NJGK?=
 =?us-ascii?Q?HRo+XMbDC/TBoj/Oce4gTnWC4ypGQGGNnBCRl9B2JR57u+YC84FJrS+ueWQN?=
 =?us-ascii?Q?YV32CyOygkzg2h8TnJD8fw0HrKObWMi3lAGTPlk3jkT0YQ7O/cCS4b5Rby5t?=
 =?us-ascii?Q?8jlUp223U2DYFDG69BLhxgdXaj5nr9pUCeSkG361TeTVXapyz9t+e6WZWGN7?=
 =?us-ascii?Q?na0ljRGtWUrYA+6V82AeX9RjdNhXxH6KRhFZRdXO2yj+9zvT1JMhxPqSeX0Z?=
 =?us-ascii?Q?5gmQLhT7RJhWll0KF3E1qK+KbJGcvNnWl742znzkOLYFyimp8RG21MOOFIBq?=
 =?us-ascii?Q?n/hSi75qoPToqA8qjrSZz/l4og1f9ElHDYZfVD0r4rTd/6yBWBB5sDSVyXAG?=
 =?us-ascii?Q?sqFpJQ1pfobHg0dtPidWqPfEi0oJ5UF8ed/QZpl87tpuclw6sIVrdHIcDXbV?=
 =?us-ascii?Q?q85P2/C7/RH8YVKVqsdkFPfqol3qKvIEaUGIVWvq4MUry/XLNUtVdCzid5yW?=
 =?us-ascii?Q?RWfkV3KQKxr8pf815F9eGKRh9AoCk0wB0rLKCGmlJ29r/zTJcHnWRZ1vSOs6?=
 =?us-ascii?Q?9IKC5ZrfHWoF+IiaGPP+x2dVO2c0nXQ2SvGqlfniEGhgpNZMcaIcseBw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: syqH4Vz/XWKDmVpMuwk9+lIQqpGSKgRRf3ouzL64icu7PrwQi2a46kiLnnJSLtv1eMppdTfZTIgT1BX3sFzQjoHgD/zZGuQhjgcYGTbAW78oKA+WRz0VMNso6iH5gtvGNr+xyWjbUlCe/FtFO4QqxsZJ0sixqcMWb0DAkGNE0b/NFBYPlRtUq9ftZuqayd/iRW5uAKypXWrF+uRgJATFFHDkgqHbFG199RuC+ty48tyo/lBWEMoJaBFHTUBgZfs8gT2RdHUnL9yohPDp34XJiaA5u7VDmIlNRcBeykD/j1rQaGTPdLXf7YNMZWBfBy1QMKdT39l84nVb7Horky+ImyjUbFLBwIiVkZ5PSGn+3to=
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB348;6:7/i1owI4k7Jg1eXCKaCnfjaTNytT1g5cBg6lHEO5TgyGCc8vndHXOWAOj+0Up8NDjSvTqFNBMwmYS5lOT7QCd7YO1/dxPnZ6u1acNLH689F9G8M0EqemAwgnLkFDqfQHHlw2AU01xAOOVYOKrhecVh3TecNPky8/RA0ExjgrgLXR3QPwF8LYwHbCNIUpwY4qPpTbNu5FkxKcmnS070+XBppGlkmilVz4QW6foJRos26YPDpbJvOrHg3epX4FjJ30pAANAEbXzITJY0GTULiML1l54s7wXwPT873MUyrAQqU0AAGpmgqwGtaIfudgWSFPmGeKYUcmvGQoRnGd1lhp0k+vZsM4WuiU3kJWq8Sezrkl3TU1k9WAHTVjz02r0GCsEdSSjsL4uTHxs24i3G/5kN6gvWPKSVdHWL/Ye7N1HS1Isbb6KNAMHwslY4+U/Q4aEwskK6F7RGiNmYpetSWX1Q==;5:+VCTUiUizSjD0v8EQCeb+51LrIQ7RqwjL/pGze4LLBElk6ClZ0SHWPBAH/NnHAN/yHgfzx4aOg9z73pHp8902AjeFtM6cn6helnH3y+4IkActyLu7H5xSMfCDwwPxBZXz+f9zej3xrv2p2E3O3cntbfH6TQJT3vBTfez9L9d7FQ=;7:M6Pq8T26ytcTLh1tWZh4EAcxO8SFtVSudTYKDaX7oBZAQ89biHx0ZOaKtzroYOIwPPGm1E1bDoKrRw9J2WHC3BLXb8Gke1tebCog0w3ZXusIhreUTAXzDztnTW5FZVvf1DpyC3bVuQgoxw1OUqGnh7T5dDnSKAHSkbCdp5O7rtKOML3iqHonpQbabtnLSr+X6GZ72AMuQNrrUErnthSuGV0eNfpsqedpmzxRZPoIgUP81NWbkBZoK3Tl8QsQUQ+T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 14:13:14.3130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2980405-97bb-485c-bcd6-08d5f3cb1840
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never really used the driver version, so no point
in keeping it around.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 2 --
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 2 --
 3 files changed, 5 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 5dd73b1..41dd6d88 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -55,8 +55,6 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Freescale Semiconductor, Inc");
 MODULE_DESCRIPTION("Freescale DPAA2 Ethernet Driver");
 
-const char dpaa2_eth_drv_version[] = "0.1";
-
 static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
 				dma_addr_t iova_addr)
 {
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 5589738..6cf8a4b 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -392,7 +392,6 @@ struct dpaa2_eth_priv {
 #define DPAA2_CLASSIFIER_DMA_SIZE 256
 
 extern const struct ethtool_ops dpaa2_ethtool_ops;
-extern const char dpaa2_eth_drv_version[];
 extern int dpaa2_phc_index;
 
 static inline int dpaa2_eth_cmp_dpni_ver(struct dpaa2_eth_priv *priv,
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index 1ae779a..8a3c3da 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -82,8 +82,6 @@ static void dpaa2_eth_get_drvinfo(struct net_device *net_dev,
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 
 	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
-	strlcpy(drvinfo->version, dpaa2_eth_drv_version,
-		sizeof(drvinfo->version));
 
 	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 		 "%u.%u", priv->dpni_ver_major, priv->dpni_ver_minor);
-- 
2.7.4

