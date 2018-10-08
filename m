Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E393C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86CE20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oPvEfuw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86CE20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJHSZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:25:40 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:16928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbeJHSZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U04JwYR6aYACOHPep/OGrbGHP0TULl1yz6qT6UB0m5Y=;
 b=oPvEfuw9tYEcCGabelaJRIAMUb9fax88wF8aFKDZLptIuKS1+OOhkuz4Jy5WooDMm3NR5E0ZNunZoXMfMs+Pi82ABYkZyy8pzkRzepwCw5wmxL2OPufkS830KCvF1TwMzFYJC6FbdSGnSpcboYvqbWDT0Bngiv+6OKhf910Elqg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 11:13:59 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 4/5] arm64: defconfig: enable NXP FlexSPI driver
Date:   Mon,  8 Oct 2018 16:41:42 +0530
Message-Id: <1538997103-11152-5-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac8c1c6-ee32-4930-a8d8-08d62d0f284d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:a48kMMV6TIhjsClh2FmvEfbSHvPf7j/IY9JlYb+pKcHzuMO9Zh5XxdHrf8UKcGVNKzmobz0pDLK3VLyPjq3OvpHcKXV+9PqKhPyaJhf5Ej+ba8mcU1xIzskPjakpGxcpnhjUR81xNsQUnFQXeAjjSOxYeqd8umZvJ+boErRkUM6GM4UVFiekpE+YTAeDGWKf+5GNHf64oTMkv1laLRFUD6BQ4aKihodJrtu+tkyGMDpVH0117+BZNnzVna6gr9pB;25:zYUpP8QV7HG/gXMeOdr5bfimkNhTuGZQGEnunaPtM1toIccGxhlFeJaB9CZ9FOreoW3kcfWyvYtHT61kfPosuuVOcy1Y4Ex9PYGI5uoxvX9JVt+3/T5EwpqQ6CKTZQGeTuH1lVRhLYdEKVw0EricEndEUmtj9T3Jg7B9pSEu4P4HFnT/0S9tuuiAnr00HdqbyU5h+ZRQq8difPo1nElKLDxSKdcJxfQNmvB9B6ACTiOyqM614ZhyiYOUx94wfUemOYVO0pgjGDZvrw3a+Di4GXC04+h141cQ/FIrApdPCBQHneEYMUzXTBvjJxlVRU7ZFZms3D2ypjXEtKZyZ+AbuDpcj75d5tZhqvV/qPzB23U=;31:pMU6tYQ5oNSerMS2KoZnfEd4Kdn2BQ+hCB4Nwrb26LbQGLC7br8L0hmZ8zdQRiwOm+nXlrs/qyD75qnASImJpl4sxHQryThha7zY4HoPbszu2S/elfovXKFF5Xsu++MdzOTfKYhrYvHoHbhqRAvBf+pOx799zSGjA7FpmZJ6exUuzmyF0KfIh2YEmxT7Sumr83sDuWFW8U1qDh/rJyv3TMi/lHnH2jVl2uiIONepqFM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:5Uz7tfpSxBl7tJT/ySSiMFWxOwVtFxJUFjy9n8Q9pXow3Y5Te/MP8Dr/JHbXjHFqNHkl6GxudAkMboB8R8doHniVMG1TnKc/+4H0EnPhmfHFEKJF7hkBq7putD2Gmq51oOC+6KGUSbGMANzbBQ/yy0AigOOs/aPvu7+UYrd8WmD/AFbZ2TXonWR6uJMTK7zlfezIvoJucGhW0MZT2F3CSmMAeVdY9nKTwtC+sW6hVrRcbqEld7gqGVnKUN2nXuvc9imfrruYPRm+L3lZuED/p3T9LR93X7hbBF6xZ2eAF0n6t1xo2TYTzGV+oG+ia7ijMYpT/CaTYzZfa01CI5kV3ZXdjPbHRl1PcikDrN3MICBIBaYFmwkg3pncgcpcCDfVH0m4MMtdO7zXtop5NHo0e+GagEAJd6vaQi8save1ZZ6pz/oCuBo4ww08V7AD30SbCX+8YK4aknmO/IO2JwKEeU+MN+z6Wdc46sPGqTTdXJvF1PZy4ZnInqNCLyEVMfob;4:8QK0Chhr8ILya+u0+MDm0TBWhhEHErppuvcpBfoV4GWbnuYM2IWo0V+L6165F20czRNwTFxT0TFiDFmoa1IXI+G24HiOhByfoG6tRWrb6fknwu5qxdc8kQocnYMphZ4pFSmZEk9ypC3X8gSc/1vgHi6YhSSdyXNihPwSimteIK8wJmLQwEXV6vjElR+9pLubrZsAy29zzBPXiQiwLPVz78/WccHifxYzvac15YPEb+igG+Ua8R9lM3D8/nW0tIiOp8KsEXXkloHt1fcX/71I28vLEYtjCowkCmYFVUviRp/Ae+DsA+AHzIj8t7VQ5+L+
X-Microsoft-Antispam-PRVS: <HE1PR04MB103463E23F2532A05012003099E60@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(2906002)(16586007)(105586002)(6506007)(55236004)(48376002)(316002)(50466002)(16526019)(6486002)(186003)(53936002)(6512007)(68736007)(26005)(106356001)(4326008)(52116002)(5660300001)(39060400002)(386003)(5009440100003)(51416003)(76176011)(97736004)(47776003)(7416002)(478600001)(2616005)(956004)(66066001)(25786009)(6666003)(6116002)(36756003)(476003)(486006)(86362001)(8676002)(305945005)(81156014)(81166006)(11346002)(446003)(3846002)(8936002)(50226002)(7736002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:Oy7uev4FCUL4I8u0xsk+aJIjzgWLgDu4T8ZgKxw7Y?=
 =?us-ascii?Q?NDG8RIzcCl38oqBLiRAyx3CyRKGQ0POpMBDtfaWs7ESjVoIxi6yqPwHe64mX?=
 =?us-ascii?Q?eoelofwBv6IoWF/bX5PtnCioKgSE/70oWnZ6EoNVo6Wwlf9Jfaw6N7GkFxmy?=
 =?us-ascii?Q?ckd1sK1FHqWrkv0jdgs4NGru/wbRO+aRQrWSzBn6XBGppfiE2bgNpvd4s10k?=
 =?us-ascii?Q?NdSYZKeauxK3S/xEC+oNiXdpL0jKN3Asu4t9zqwXYEZxFm2gh5Ur9Sts0OPv?=
 =?us-ascii?Q?fwqqBCEIb2WbNI1x8uzVW4cPnZituYgKCihsezceYtEKJ1jxd8SLMsvUnM3R?=
 =?us-ascii?Q?e6X8XTv2e/4SYB5c+N++md0rSNaLyBdW+QvO2dbqKuzkDulHyqUrAJRCikQk?=
 =?us-ascii?Q?NCBpKWSlNgfrW6lcqwuKAYCXQnjFIkFkgItZOdOHKPCPzg7xuj4lYH09GnuJ?=
 =?us-ascii?Q?cTxHzILTrq5UvHg0/oNNzUxVYEU2BKyjHXGVsxJiRTIHmNcOJ8ewaFGFkgwC?=
 =?us-ascii?Q?KdGA3d2tJXZit1fDm/ZasqWVdop0dAU5NYn7591IbXCxeW59Db7W2De/rBz0?=
 =?us-ascii?Q?5SYA9vag99EpAYYma3MNo7/uhUz8WctaRRTngeYBhNUqyDepoiYMA3e36tWl?=
 =?us-ascii?Q?haMMLBKsQ1lH7SwGE2QO6lUEn/2QHYNIbEuQqMJs1VUYrZj2/6t3p864TdjA?=
 =?us-ascii?Q?d+0maD7Q7aoi9OMztN4aZPJNC7E9ED54/sShBSrpPIx4Sh4Y554f4T6o86Nf?=
 =?us-ascii?Q?EXHc/8n+R0KTeigYi3jCgMwv3xrd/Ms0hp8OMQ+a/MHgTjCxcYLVHSsigsO8?=
 =?us-ascii?Q?O2wFRfZkauyj97GnMX6IMfn9n6SyTTZdjOa/OFDd1Wr7jgNv1m/tS3V7D/FA?=
 =?us-ascii?Q?2h6syhwUEw9ZqhJT6f4pXXYD3wnQ2iYP4kvBuqzyUoa8w2sXu6Cw/VIwBOFg?=
 =?us-ascii?Q?OcFOKO42ygmKur2A4cnnK2G7FFV+MRD85PmrN11A61cC/4CpDEmf5KtBjhFv?=
 =?us-ascii?Q?yWGH79DPeYGVtOx5TITxqPVFafYc4OeNSzRx2N8+GYgoUkkXvPV9Uy9VAagL?=
 =?us-ascii?Q?2yK93a+V5Dd/F/ycVE2Ga3YIzaCOSM/bCO77aLrUK73VRLM0IR2hJyBnEX72?=
 =?us-ascii?Q?/vroX1EEEWbj3ZjEgDF1ZlxDt5dhB3X/ynZDy1Bcp+1spQiFZVJAQgFmFRqt?=
 =?us-ascii?Q?06z20pUpTPH667CYIJVHHsakcNGuVfaFioF3QaAkojvin/W1REtMXAhqO2tW?=
 =?us-ascii?Q?2YD+KBeQwC9d5HegQZtoVCGt9GCu1ixsY5eXiDY?=
X-Microsoft-Antispam-Message-Info: IlLhLJO+0Yt3n5IKucG6g+bQL+AOSAqvjTJnzvrtTSUIdIZ/+Q0lSc7g4Gxp9IT+tPYLixaambVQG0jdUArrA/oJMGPDmb1L+n30h7xpsU0l73glMdcIbDRLHNeVpaii+KcHLWNDZGlKGj8Pk8SVd6jOtss1ugyAS1JG05JCClhtd9ke/+9pdhXi1M0JfS7d1heoFXLg0nnBBPw2XSxUvuwNzOidbFGxxHTs1SbvQiLnvVTP6dVdH/YsBYL6N+XNvPIEabBHfH5ApX9740bvJHxjdXYeIMATzgXgRIvgc9hfTJMMGfzqkGenzxY2bmdQqdVQyam71DprYbyvQypXUdsmL/N+TGenuwGM/Y1CraE=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:7iBFvx82fiMQLeCEaM7f6l4sJibuxFzKBCYzTpLFGdDjI4PCVRwTQGrrWmHpXRrRp6I4gr5LvxWHY8Ia0H24uoxLMyOvvrd5cb0q57P6RFs4h4+BmpvZDwHuCl3RtfISwvV59JKtLsKeYuP6YiHbX1TbmPyz/GGaUt7pM673zuN9BxWzozfvDFRdUtPTyyxPR/XB2eNiu/jmiKrsd7dOHUeI5faTw9nXUC9jCo58e83eYk/xUwWANNY4DBDQAX26L8OMpIPiPo68YuFbTW15ymMo6IezILjVnvMZcZpdk/5siakdCbhE9Qd3h3eYkEbFD8JMAhlQJRyhaboLc/g8UUfyze9oCbXabfgas9ejl5I0UdvXwCb2LpsuCmUivFwQliX4sZU1dbVNQFbtI0PNbixkVwsjB5Zh7ytPdcRJuSb6d6TWhZp1JQrF4wpdDibyhR/BwleRENXYoZng5RQ/Yg==;5:YxnXP5y8HSkOqAyXXah/7/EMFgKX/whMkrOz3mLaV1en1gTgWDZ2qzIuLUqF8huPosWVpKACKL2T84l2R+NTL/VIr67xsxHbDNfMM/WmP/33NZpwDAaWfgTe57othJuUH9p4CJPTG3qm2Tz3i/LhQyadE4dfHU/GTreKZMy3GJA=;7:7ZDoOGUAUXCLGt7blHw5pi2RupWW0dy9SDlIx0Ua5vVVSPwz02G6QsPCSuG5fATloT8rTAu793ByPfxVcb5n/Ss3stk2itgZVt/uWrcMWmwGJj0ig2rxqHYKsnW3flWKc4KHxS4XWF5lBYSaTqlNvT/+O/B1OZcQRg3eJf9OPLiiK5nf0cnNUShKtchKYbf7CM5aTuk2P3FkUhkuXp1BCy+sb4UxrfIFrOpIz1BA1YzCNtObPKMPRlYhGlfb/oVW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 11:13:59.7035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac8c1c6-ee32-4930-a8d8-08d62d0f284d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
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

