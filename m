Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D2DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648AF2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cn/h1biM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648AF2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeHaOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:39:34 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:45696
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbeHaOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2W4VVB0B+4waA1W1wQAUGAO85Yiopo+YyUr/fo4768=;
 b=cn/h1biMrz/AKSojQeWMrMYk8BnHQYtGRTFcyARpAVasVCwrcdOon23cvJNJ3voDTNV68p3/rz//+LDzuiRfVcdCao3wz3gVVoDlnWl8LdAvtUabjhadPMYXtZQtkFVhsUUoXkvRGi3D2rdcQbCxz6GVU2IJ08zC9wN/1IDEOjg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 10:32:21 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 6/7] arm64: defconfig: enable NXP FlexSPI driver
Date:   Fri, 31 Aug 2018 16:00:03 +0530
Message-Id: <1535711404-29528-7-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::26) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b701a8-e549-4c11-522e-08d60f2d0b96
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:40iYj0gJRjS6MFvDDls6Z6Jfk0L6++csjJHuxJU57V2DQNNxrTP/MvzK5vorqMZqpQENlozasmCIN9U598KB5ijYbxEKKxK1MKGa3zQAPouwIIRg9435nhkSK1i7chDocQn9CLxkffcOgrnXmQQ5FDhjpLbmyA1PtYe/EADcA/MjcZZ6Se3BD8SOrn6+afF0aPMb9CV+j97TM5z2yvCpua1bevUw0m6V6MTdGMqQhQZXI/MRvblFVsjuup4b9lvJ;25:ga4jEMHmych/qSp4PIMBtDjlaY+L6o2dqKGupX+g5hl6EctEoT1r9BmkcaHGAV61e9f2636bJbj48oAGAiufHDhSS7dNChRo1vM9XT9ttpXWeYSK45ESf9egeP8I8h0oREx8CvAxf37X7L9kHp78YYcx7uibwOjX4RnCAzMeydQwPmlWiyaHilOWInTK8vYtXUtPTWzeF55G0JDNFhIfXpR5tNjwWbdwzlFDT/PHI05jd3k/BWw30nZt4RlWsK2SsfEDC94S93uUhQd7CI6I+V0izJ+vuuOIS5KA3qHlGDq6dGV59euimeNRq7GC4NTVB4j4lPngrL2GFCsEMiI4EJZx1u84Xu+fJHDgKGLBVsk=;31:LAaVU7k+PyEzFxenN1+EtohBq02DvzjKJ462opfVnhzleRfyedeFwIRJqOg8BqRSyJXgeEmawu7gsQMrACvHNyP74ni9+1UVV67I5nePPTEocJShhpqkjqWNfN0VpSBGv8V1m0/eS1fJPOGNgzW0z8JpbiyAKKAysmC+YoBYEkTDuj8Y2RQmiyG0nZoQFsqeextXN+XbddDa3O2iuVWaJFo13Kaxg7kUpt21M6aKVUs=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:abxR7GyV1d2lCgEzBonnK9TJFFRDNbggSQF+3rApSLbVvuKkkvyt+qpLzJY6xfLO7L5fx424QtnQpp6/bt+MaYTTrkFiXX3ePiwWqaEJyo4euSb+OwNQY91QV1dJ4SPtpc1fPsjVfwavCvp7DhTR1A0KN6LyycFSU4NzIWY/BljwV+djTQuxTqS63p/AmywJfqLNnmGnR3mjaMzzsVBayJhB32itNKn2QEbSOGp3AOxmeNAgcIaX70AcD86vK8xvNxMGSB0+qz5bWQlNH6TsuRUUjWFATtU2KeffcYSMTZZZKHcmW/Osu1VA8oxqrFiZnMdQ16b99EVy5F3h8dUYPt96xuZNOeCFLgamIhTFq6jDjvhsludVP+ey7V4anr9cXezZ1Cah/+5th93eG1NY6ILfqhpe9bRS2EvHkMjev4EYOPdTDP1q1mETL584NwzJ3jUm90MSebugxSEpM7vEsxXU2Px3qQLu90ZDYGUwics0ax72mv9AbiGKV5PUyr3w;4:Id/zv/Q04kdqcLTAv/YHHqNxHnSMTImOj4LFZb/DsGIE6Z9O1Iu+9UOeg77SPLODxY5r+e8kPgrbfLkdKYRSDAL7UNneZItFrtcGz1m3M21owUBIepkzKohX20iRjOsF7B7gbKD7+gPfDrhtL8cPm4BXjFRxSiTdTzVI7rT8y39E0BgSFt5zfK8Cv/sWDMJZHaMWqKgvJ4lYptPbHuzzNbOVWvKi1EheoH2WhpybOBCf82IZeYm6VDC5lz4FT5ooUWSUoTZTvWbdooTjca4zHRWwbcoAjHx+J8PnD6PT9MxFZzqyQaG02Kle1nqfcNUY
X-Microsoft-Antispam-PRVS: <HE1PR04MB10346F2B9CD8EC44AB2E2E25990F0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(48376002)(7736002)(7416002)(8936002)(105586002)(5009440100003)(52116002)(106356001)(51416003)(55236004)(386003)(6506007)(81156014)(81166006)(76176011)(2906002)(86362001)(3846002)(186003)(50466002)(16526019)(6116002)(305945005)(26005)(6486002)(66066001)(47776003)(25786009)(36756003)(5660300001)(97736004)(8676002)(53936002)(6512007)(50226002)(316002)(6666003)(39060400002)(68736007)(486006)(4326008)(16586007)(11346002)(478600001)(446003)(2616005)(476003)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:5hvhiwn9DdvaBNY0TrR7diEaTWFBRRGeGYGM7kG5/?=
 =?us-ascii?Q?vRCRMHtSrMfjuSnbjXivf7rThiUllIm4/Vrz30ayvlce38X5yzj3nQQnAa7Y?=
 =?us-ascii?Q?hu/8fVejwLerq7eoyn9oFTei5oHRpfLuM9TbsmhCrS4CoOQOOmzqHZJ7a4cG?=
 =?us-ascii?Q?U7pbuY+7qrYp3ldn3JfcW0Zc1F3NbDy+Qh3QFtYMC9O+gQVX3FOwwmSX1QGC?=
 =?us-ascii?Q?wlvOhDtRopGcJcA1jAJQKaWL/+AC31egdYkk2fP00w1rpB1U7vG4k8Zs6kqF?=
 =?us-ascii?Q?zkc7MPLfXqBc478RmohkA3x1pD7ZWzZBPKhvLQcyXWD7RAJX53jIro4rQGQU?=
 =?us-ascii?Q?xprxWVDbLYg5mWhH3niXDY5skN3he7u1w+LudjLfhM76sAtic8zm9ohmTJmW?=
 =?us-ascii?Q?B6U7R6l0wcw97uJ36yzdu+sZXyveMzW8doJ8Q58EacncHW3YJle+icLybjIL?=
 =?us-ascii?Q?LlVez7d2WgWe0SnvxYNi8ygZP8E1XzGRiWfAS2b66BL6eVSrGCNNuYaMrnFg?=
 =?us-ascii?Q?3fronyJYel3+YdcXRDV4C4zO7O96IFfFx2y8/rhVaIllYgKIbUY1NiAHOMv4?=
 =?us-ascii?Q?n+tU/aVlQnBnUpA5VNQ0gX/926LC6ukp/MyPLwK54Ruuj313ZP+VPkAntSdq?=
 =?us-ascii?Q?p0uH6CRP9SJPxW9vjKyKBaYbiVXS48w1KLWdS0I4srGqNjmAnQDpKrX3F2xC?=
 =?us-ascii?Q?h3PFBX0qkdBC/8tXVNG4RgGyd/h0EORQ+nPF6uaz1t8N6hfzbW0QedYe12JA?=
 =?us-ascii?Q?KYPgx7RJWCVWP/5yeHBLg+duuIIWq0Blea/AzVAHPnzEAwTcMb6VgmObnnIv?=
 =?us-ascii?Q?AUfgo5NUI3xcAoUn8KkHAuQ6JGxNYjd5nQFwBLwg3qv7rlB9rqwWF8cwnoFS?=
 =?us-ascii?Q?3T2CkUrxmvT/jk6aL/5rX29zDTgBfMLLm1u4Ap/lk9bFJGw32hFjdkFnrdbo?=
 =?us-ascii?Q?2J4tzaqetaC4xN+5DA1UQT+tsZMZofJIpH1itHhDNdARb2IUm89BObCT8I6L?=
 =?us-ascii?Q?QwUsF3nxndh5NY24ABIvZX1Pm3xDHSfaPV+Bkv/8HT4fw/QterW4YkSwA/W8?=
 =?us-ascii?Q?92520zPBjxviGVppbbWlIIf8aUgqGogq+LTUdWe8tH6JoRtvy5m/oom3MBd/?=
 =?us-ascii?Q?Kh9Q0XqbhBxSyhGt7o4fsDZr9ybW7nuCTOHBAVaFpVmX1E4KXRjYQ7/UNZIi?=
 =?us-ascii?Q?/Tz0DzxhtZQtcw3DR7oGB8uHbaq/NXoMXcWxU57mSjIdZlR1X8FudUxvTMlr?=
 =?us-ascii?Q?1T/RULawG7xOL5p5KII3niGgr5FOX32BiS2uZVa?=
X-Microsoft-Antispam-Message-Info: wP7LXPofrqEHpbRe3syga41TWmdMdtc85RavoRQR5B+RmiaxMxOxF4jZM6AGC9WmjWsaA2VCtj6jOjylsbcXFHRGMBZh0XVESCtf4hWaRslWdTN+V2wbggXK1GMZXfiBRLrdvCrD1R1laT+MjQnmnPUc70/gcZYjcfgUpflr450yVLdpdqKmYOFScrT9YJDsMEOxs/EpDaLpefvl8XCUoPvphl6ts77SwE18B+5aJXPfUC502HpkRS71KIi3Mh4nJYZGTW8z2SgSWL6dPMqjiNbw39XZ6+9nFosGmtTRFuphZdoFgYIqVasQQzd6909YglcpHPxhlPkJ3lUVSKBwJty3RhpsBz9lh/ievZgkSUo=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:aOu3hkFm9gEYOJXpp6s8hcmVonl7+QiUkXDgUjLGYe9F4JwAabU27wtoC+/1aVSc4uBZcBT3sdh+8En3uDyb9tBuw2aVZJeTcNRJMkDJI+yKR4stUllPKOJxtrlKgJBDqi8GCyQBpTZh07nS55A64XGGlK+Ip7p/hIk2N9hep/gJ3oiOya8iBGPooQSMBnfpDm+okxsYPydpCpRqSmq3MD3iOA9EfadVKmYhk0OChmP+gdpTrpLnks6QF4XwkxhTqmIeJKsi8JKlbx8Kidf4XoCRlFy8Kz+w8Xm8CFgMp85CHSYBIXVVxbbAOfnR51H9NueWY6NoJdWy5DD9fMVVq6hVkvdk0RGNDbcxiZO4Jli+pGaHNtLPYCG+SxU3ZrHt3d984EJStqs4fM7h0PeHvD3zIn6WyT28GH48F4WmD/zoLcXhS3T0A+ZxyiKIyPMFPtxQscXEj05xbI8jUUkRlw==;5:UPM9hCrRwp1MM/oyYtotd8Cvy5V+JdDFkdP8sTqaR3Db5njBtrLxAlXCtAYphJFkKXl7vFb4Btq+7K22+mqEyv8bT9LS/gQNKeSTYCJ9bWC3Pi7O3iW2+uY9jqdJUGq5oaO1PC1Er5QI3CyzMeiVU1LSfh7QLTN6+xkkjiRCxZo=;7:Rm8jj68EiVNzi2YPopBRCBbq+kGLwGYThCWNroNax0z/DUA2RIsbDIRWZZxrDrJDEcbz+OlYMCPR1DyQcAARU5GdPkSiUHiDPW11fx4CbgAOE67OO31eDzqqU4NCkkYjAgSjPSx/oL3xQ7zcwMXNhUFr0j4z8U5Q28730D0Flhsotg0skJgOQkrsQKg2TMrCgHr34oSrhuWIoRy3uHPcSzMIF1XLwLhWHg6VkfzjnvXEvB8bsmBqn1yZdq9a/3sA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 10:32:21.6381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b701a8-e549-4c11-522e-08d60f2d0b96
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

