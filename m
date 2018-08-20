Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA91EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7279020896
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xCKVsW/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7279020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHTWIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:08:51 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:11916
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbeHTWIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQUgP8dTYkQSji7Kkx2BcFCRp1MwkYu/gjobdKMcMl8=;
 b=xCKVsW/+/wmTAHoQleftXMjQ0mM7UnlNSizovTa7TSwEB83kiNoAqdk00X2FJeGKAK+k8KeHSBFrLP6pf8XnSn/YMciNsPBKnPDgSkpYDXCFlMzXplDd9t7+7bAo/GPURkrHnjf/wMRX9KYfwPSkY2YUAvpWOHOlwaplZoeywyc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 18:51:53 +0000
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
Subject: [PATCH 0/5] arm64: dts: NXP: add basic dts file for LX2160A SoC
Date:   Mon, 20 Aug 2018 12:17:11 +0530
Message-Id: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::30)
 To VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3e88316-5531-4ddb-9ac4-08d606ce0111
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4799;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;3:0xK/5o09TCEylwKg5POrxSts+v5a/85ghFceqdvs3t2PwC4po1FN0JFGwWD/VPrkGWtCm6bj2nYJysLxGQ3DInIcZLeVV5JMqznpCoczAC93NMt5Np+OD8Hy/OJOsTOrRIhlo5q/1qGDu1E4x+lI5R3I95o/PMoNxVuZNmgUo+hauHPR1U0zjW0GxO2yAxpL2rrbon7bXz853+5QWo3VIi98O7OiWOWYEqRCUQSZBhE6Jb6evh6BFIFq/7BF+avR;25:oyw+ABuDddYXRL6pqjUd0iVOxlweyaWQp+Fypcu4RA3YUhX4cuH2T4r7uGOM13GL+T11fXrjqJxPPcbvEcrNUiNnFg6u2qqlwkRxWFlkqczeWeDM6dffsnv/q6Rlngmr0huPeL+JK8SfM3PfcZhrBJPLpti4bmhOw5xRjIB3vrPr6E/u/ybx9p8vPiTi6VD04KzJxoSdLFGP0thz/MT+LhEwiY02XjOvT2+LTChEaIIyMAU5qnIMNPcnAMFzKpNHoaG1Fx2ny32ZivHFBIDhJSajI3HXWzTxAemI4ra1iJjItBJuvpY1hv+ggMK/LyN3Fzh0HRzwFbMPevPQ17oyyA==;31:7VzcZy1uXuUHYomRpKKSiuPEbI2MRjebpk0O7JjkNXd+k1gYVRN/M702ioxMcJRxbGPJNAGkxuzzdhwUkPtm2xn4du5TSppT5v/mfOMbq/MDLUOLVal+PpOrVRfGOa60mIQ1sGcL58QnzCl7osN0G/jDuWKQpCAfCV2ZoydNYCvLiaInzAvYozmsHzvCxrj6YebsCncWTZ0VdzaFgUYeGSVIPIfL/dPgUQKivHsLWeE=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4799:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;20:9ZNVxby4T/gQnLpjxwNByWwix3Tjg+k72/7ahMpzdRbo3obgsDxYTmpCTjKUliBRgTJdcjY3u1xG0p54xzN7GwlzH1RGUS4+N3tGlLLtw3xDPiKHDBr0fcNQ1AfYeYq0iFbFl7cAbRnlfQE5jhkMwYZ5KNLUTPOXEGYqex0+vOfqmBf8ZDnQis+uDvZuTfl/sPUc3S21ZbPdcKBAyYS3+LsKHPrt5TTzLYcwNdwEyHLXe4iBViJhSaDVXlSJb/OMhWW5/BJIB63u8e3OuS+ulVDEp81QsaMon2d5l6WQLhOmZ+h37sMEAFdQuwp9kK1vrU47uVJ+g+8QAAZUi7BSI0r3dli/P6ywEJ1BsHPHvhOckUewgnhIoEhe5OvHtGon54kszkAV9VfH57expjmnoY173yjDEL8B2Ahi1aLjPBXvL4Dvq8bUbla3IHxri2/vRCqTrVKxtL119GQha2gNZ9C99wDDOwPOGBchwYiiEeUf3cMle94Pu98RQZH+4Jzg;4:d6BTSXjaO8tny8lkSP+enZ2F4jTrChCO7qbZhexHEXjLeVB+METYr7/N12yfBXf+UscyyA8/KroTj/Ee4jG5s6A5LV4DQ3vOL1qYkdD3F6q74kanivhgb9tPwH3tpFCXVfPUvOxx+UP39cBUIIVj2Q8hru+YSl/fJ11gpJJXVQSo5sPv9eCiyfsr1pm+B5s/iZdTx4gU7C+kIwPvYefhwFn2ZGtbIEObYSl63MrRgIfOsA9V0eKT8H3FILPniyNYYxH1HtZIw0THqIuDsE16LQ==
X-Microsoft-Antispam-PRVS: <VI1PR04MB4799F74DDCC044C6496FCE3BF3320@VI1PR04MB4799.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR04MB4799;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4799;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(6666003)(8676002)(36756003)(7736002)(81156014)(81166006)(305945005)(16526019)(186003)(26005)(478600001)(25786009)(4326008)(386003)(6506007)(48376002)(55236004)(50466002)(106356001)(5009440100003)(3846002)(105586002)(5660300001)(44832011)(7416002)(14444005)(6116002)(51416003)(52116002)(2906002)(316002)(16586007)(8936002)(476003)(6486002)(486006)(66066001)(47776003)(6512007)(86362001)(68736007)(97736004)(53936002)(956004)(2616005)(50226002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4799;23:HLGqPkm9gucwNxdTvyU+zD9tsL7QGL8GbCBgTH8Kb?=
 =?us-ascii?Q?jooXF0tjigxpbnSsNEU5w3w8sjr0e1d7dJS5foD6VsJclg7S2s/Fy1WD1s0l?=
 =?us-ascii?Q?eTDya2so9lKIlnwS6LZTBrPOSkYm4FPrhfFimbDl2e2/+A0mgH1Xkc5IQSD4?=
 =?us-ascii?Q?B7aBuHw596e4IW6xZxmwzc3XIRFFe1Sz9xT5jwv9yRb/7liKPPyuDeoYu7P6?=
 =?us-ascii?Q?oDBw6JQk/oFa/zXcbhzKpBQ79LXlTdZqdvSVvzBrxZmrV20UXSp9BVORv2gI?=
 =?us-ascii?Q?wAPHN+Wzb69npqWZi9aJ3GvI50v7hTdw7hLZXRMNhYc6nsJxCOp940qN1XCh?=
 =?us-ascii?Q?DDFvGtFwo1FwIQTIsoWKfqQ2F8OOHJjtqAqMHv9SIRiU++eFQnbQ3xzEdgd/?=
 =?us-ascii?Q?KaNq2IT38DVT/lOfwLdVJ0f8uYmf534Vgk3vqIictB5Efki0761nr345CGTs?=
 =?us-ascii?Q?4ghdDpnoElCHLtPsvEpwQcmJ4B30m99xD8ve+O2kXUzFLKMa6z9ikNHNOpMa?=
 =?us-ascii?Q?O1l+fL9mYBf5fUs4Qi9xt22Tvv2p6lIQxNP7zGf1tS4y0Ej+J+OBvUk5HH9S?=
 =?us-ascii?Q?GID3ZKWZx/lIOEc/UIlWQW+9L8o7HX3lKSzh5BStXcl5t/T6nj0f4hVJ+oGK?=
 =?us-ascii?Q?6fSw9II2jGv+3GGIQem6vUMeH92jGO9wodFxEwlRkQh7/mjwvxsMouKpdPF2?=
 =?us-ascii?Q?oc3oCT+iOuDEUvrYE68xINWIBWIBvxf6CyjVLT0ffpItBbaDtLPXwykqWZS7?=
 =?us-ascii?Q?Cp9nYR6I0js+kVzc/I5VWVlWWW1L03BXX+W/TmXrqWuTSAowqPS/EsSGjA64?=
 =?us-ascii?Q?E4ycvNl430KpRDaqeol8DzT7xIqgtNDkQv0+XyBjKRT7Lr9IiTjVD0iRpdpP?=
 =?us-ascii?Q?81ssKg8mmCL7TcLpg9dsednO2micsA5OqEpliYifi6fuxu12muSgBn5tnDD9?=
 =?us-ascii?Q?mQVo4taHh+h6T6K4INbDE+26/r6nM1QVNR0vIQ38gi6H82WddunlD2i4eCTK?=
 =?us-ascii?Q?md6kV5VZXqfD6GIJF1rgAiDMHGJhYtMl+bKs+60TMgrfEEpMK/s4+FCSiDQS?=
 =?us-ascii?Q?mGxPA5AXnP1eug2mzAzf3Ced9YxuBI7zzNYqp+xdhr79BqDbwwnrSoOq5sCL?=
 =?us-ascii?Q?uTGROhMg0Tivodv/tKjnw5x6BYzkdHdd200C9xLaBYSlzS1FlPFtE6Fuk0gO?=
 =?us-ascii?Q?NQOqqpvtEd70U54gek1Ech6EYxwecZ3bMgUHJPMcZPQYOgvm8KPlUa+6qkph?=
 =?us-ascii?Q?kzUwAkQPTmcCxUkOoFKFs9iJ1Bi+LjSJXu4GyK5?=
X-Microsoft-Antispam-Message-Info: H32y6zZQkS+nb1pe/tD2tVfjcaCsQh7fWTqnWLSAz8OG/uK95D+VyRVpZ6x8IqFOeH7XVeGsuMA521s8WSXuxgC1Yx7X6kbrfgXhvBPXyYMwfr2tQupQ4M19xMEZIIgVuM+0mdKC3PYKh5aL69rob+ivhHuL2P3K1Hk8gIguQU+VlO/UFRENN1AytFatjGn3UWnSdz4SgUEOSxB3RSQX2DBwynb7qW+Kvgi+oBrAazNgwIvm02SbhZJfEoALDxE9dl0fZNcMEFZzPZPhzA7XP7YQfGabXDpAwzoo4IavGrwEHZpqNJgeiAQz4QEgORcmNcMVKP6mfbzuN+pyLtelGEnwG0sve9gT94chNbVhMjE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;6:ORQ+G2eafrDMp/iobU+fpj79QdksRzUFpSkv7CF36Vk2pQYd3YnWEP2XyFiUHyk5L/mDQT3FrdT6XJ4Q5O+mVv3NkxweBXaeOQOmUR6rreR9m3vW6xZ2BIqWKZnM2tDz6BzFu8Pj9dp9CfIFM4SFLnZEylvbJFOsFBw2MzS4sUYzz1hJYBXpYLYkCFADfBYZM4CSlRwaon3z94s7l0B8s8BpUK0fbTJlrH10HGQHaVYXRe2EOZzu4Vla2Q0FAFc1Z4Z+jWHdTSfgh2dqFH5jbzrcYSVh6xEHCuMMZP+gO2D7MWirC5505ZlPr7DffUQteqZMF6Vrjg2EvZV0W33rsVneAK/yMcsgBWqkPGprXPIOsa3H385FK8ufOwbCbaEDjKU98fRjyGjLOxsKvgYP7OizU4Auu+k05kpGueoTLWX1356v/Q3o4j2/JmDUEPgYu3aEoCKQtcW73PnY7N5QEw==;5:8hCqPhWhWdPNU0/HICWT+Rs5ALXEs4dH5H5vrjUS6EU8SibGJwKLG3gyl3P2tZtfPWfNTVJ7YCfPi4pU5dF4acc8Bj6/4MBajo6apXaOoQ7umkkwTbB8reXVWxPDTbsVvCZBQCcW+vSsn+0L/k5aGh3TZZRxkcR0wCo1OiIx0gs=;7:tfefEasWNNfSdtbRFVVgWFyCk0J+877qo/X0meQUs3U99qFQ5Ps4fuVsXnVz8dc/iFLIssgl1thScvQJw2F2VUF5zgVlOHyT1QdNxuF2BUHvim/Bffc3F17HzWKiSBKTfmII2867mQg/iJ6kpqb7qZoNC+f3KE1vmmNHVEvHeQfBgKUxdve8sbDr0YE61W9sqLWRQaOl5Njd5WUJ6OcyjWmISuCbauuF+7DVBSBfo34m+QwBX0rNvylHZ7LcF7M6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 18:51:53.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e88316-5531-4ddb-9ac4-08d606ce0111
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add compatible string for LX2160A clockgen support
- Add compatible string to initialize LX2160A guts driver
- Add compatible string for LX2160A support in dt-bindings
- Add dts file to enable support for LX2160A SoC and LX2160A RDB
  (Reference design board)

Vabhav Sharma (4):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add compatible string for LX2160A
  arm64: dts: add QorIQ LX2160A SoC support
  arm64: dts: add LX2160ARDB board support

Yogesh Gaur (1):
  drivers: clk-qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt     |  12 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  95 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 572 ++++++++++++++++++++++
 drivers/clk/clk-qoriq.c                           |  14 +-
 drivers/cpufreq/qoriq-cpufreq.c                   |   1 +
 drivers/soc/fsl/guts.c                            |   1 +
 7 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4

