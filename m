Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B338E23DC0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tcB8fsd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B338E23DC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeFVGdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:33:09 -0400
Received: from mail-he1eur01on0088.outbound.protection.outlook.com ([104.47.0.88]:9824
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751203AbeFVGdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd+bDhn+xNUS5bqGwvLRH4FBztp7QK8Xx/8KlxZy32A=;
 b=tcB8fsd7XsmLPobcc4WEzVtjYElSP/2Ub7QzEMe2xQ1HELWnG3Oc5bLll6XkFggJgtRIaFDbT+0VbUo9z9wzjNqsu57NwKxiesIHWGDra+KsUddQM9ytufxv3BinBmK/4IIZPphhAeUqyW+LfTDdvUfC+tBYGNYQJmmgGHNoBiM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1325.eurprd04.prod.outlook.com (2a01:111:e400:5187::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Fri, 22 Jun
 2018 06:32:58 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Date:   Fri, 22 Jun 2018 14:28:52 +0800
Message-Id: <1529648932-4832-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0038.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::26) To VI1PR04MB1325.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf43e58-31af-4ceb-5029-08d5d80a0091
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1325;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;3:ZCYMe4Xys03gFLg3m/vdj9Z55Ga4Y7saOmSKzj8tC5bVSTutFuEKaJGYMVr7KuunIUeYsvCYFaBoVE8jb1BFVRYElk0OqwqvEmMXLbQcqlIIsmvgsqFReDgY574Jge+T+xsZlrXsBBA03I/9JiOp84M5ZUpdjX1rPSBtil9IL6Vc/usnER/6RUvJvpaQ1zXae6EjmD8MHGYwAgM6gaP6885R4Ehl7iU4+q16On+btAgX0RNUC8/1H9YPIHNaP3Qg;25:HBZOo5Gx4rs3rLvwGh1nhxQTtL3nWPtwqhatzSieXSgDtltzdJpkdSxlqy31Ed4J9GfWoM87p7zjy0ymsZw21/ltg05KauPH9zPnwyDzIZ7lVt1NZfbLnoYm168aFCrpW1E1T9kUzSYFKhTa5l5YLDu2ywvhzS9cquRUXdwHhqMOdTCfchltZlmttYM1WUyftWpwaN8gmphrSSAKylIzHhM16vAvpoNEbWK1raswhVWX+ih1WqHrZxCG9cPrReeuph8+1tKpJWasYNBB2k3hrYSIqG3+NWNukJZQG5adFufYf6WJC6N4ceV9Uw/nU3RX+aWB5mTaa3szi1+aROBTmw==;31:6hjAxbov/qSLfRJxtLx59kg/g3rQ1Dr1svccqS8IW8VfzS5mpsgeasX3VpjS8SNik3WQvY8/eFXeLOoSUxd3OAneQdyTwqBhV3HePXudzTJ1R7K6DOsJ/36JeE+yg5swFt3hDza6kM9Sx98rJjjfEi+25zll6fUyKU6vwS0GTy61SaYCF/KtcMx6RSqoN5cmf7nF4mfLk5pCIIQLkbtlL7/mb4LjtLcn7L1DhcEPP0Y=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1325:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;20:m4trX/+ei/8mXSpYoH8G9b6r2iCtgKAqwja5VCSDQdqV+kxyNCBHy9C1Zq3o0KmxQXH3aUJHhYsRD2cOf+PkBRSQ6U/9CmXuQlt/6q4rzTGWo1Y0H+7OTgah6+DitjMCGkwzHL7mlSSpN4BI3eLWDqUtR7xCedVlgUyPSC913WEqrGx7ps4iq9solZGWsiu1rmpDpDBWvXWN50CPG2miFYoZzKjF/9rsFpyVx+O7SwXSETFdOJ/lfsKjfm3nnLPwZZwwxQtSCHURblsOixT99YfbVqrUFtcliV9cwbaucANDo/NT+l4wqROu5L/kv1n9ls0acvA67e7ab7bOt1q2RhKgoAQGZMuUMqWAL6LglKPrkniOcKhbseyI9rPKyuIr7blkB2z5IRAorHV7PQxw+QoDIl3CER1X24yOyIJhOyDgvDUzG5m7fwJoqgg7lAr2G9H6mXyOdNZhAbd/pX3sbg50LFZj+47gdxVnAItGq099MIsmtmhamDvFFL2nHNOj;4:ezg1wl6HtuBhsmm3Xzuy3URVm41X6/eraI1w/w5bom62ZKNYWIOyWR8lRjaGM0BDILBWvB75cvZRhg6Rq1BZ6EE+71WNkI91RJhep2hEhm95gD09m0HPrEqQV3qfT97IZSL2Nru+l5dd5WWLvCx4DdvfssWb3IkBzj9Qfv67jvqhiUrB8tvaiLxtaPQY18761Lws2xsNxIQ8s8buhGX5oZ+Q6L55H2YnBejgO8LhNSZ8a+gpJdC0GrEXi3HD+CUbttGjUPDkMGUXE75idJLgdXL3JV4RHTYtQ1zh2+Xbp2nvLB/J7o5Qgua9gd9prkS9
X-Microsoft-Antispam-PRVS: <VI1PR04MB13257EC7A11664D619F6A585F5750@VI1PR04MB1325.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1325;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1325;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(8676002)(81166006)(81156014)(956004)(476003)(2616005)(486006)(6666003)(6486002)(68736007)(8936002)(7736002)(97736004)(305945005)(6116002)(3846002)(48376002)(66066001)(478600001)(47776003)(50466002)(5660300001)(105586002)(36756003)(50226002)(106356001)(51416003)(4326008)(52116002)(59450400001)(86362001)(2906002)(25786009)(6512007)(6506007)(316002)(1857600001)(386003)(53936002)(16586007)(26005)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1325;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1325;23:RJ3rWb2VAneEwzwoFIHAp3uI/jau/U47cHdRBHr0t?=
 =?us-ascii?Q?JXeeQaSorTOnFyhT124LHXT0tXtwIMlFdHTkkSoMx0k6kOa51VJCniqxAWXN?=
 =?us-ascii?Q?XPVyTTxjQJXVI34ijtsHNfWE45P8HbsATn02nM1JBiVi0SNzwfnEACgFUXwk?=
 =?us-ascii?Q?awI5dFkVRhoSZfHUg7oLGOKrNAMwhJw5De8njb9VCXn5IctMBgfrFhFnDIJE?=
 =?us-ascii?Q?r9y0ZQefVIbtI/oDdRHHYGJrxz5vCynEssjU8N9mjHikGwve08fm3dGEaxi2?=
 =?us-ascii?Q?phS+mGf9+8iT9u/J8U3zoTYvMVS6m3ViBxQHrV2k0EmXBUg+enIp6nAjsvsO?=
 =?us-ascii?Q?+biAKW6Nztv2Z/wMrY2q2eHcM4a7iAOaSUBQD3/GrtJv/jQLroFiXwCbBK8j?=
 =?us-ascii?Q?4k6zUw6g5p91eDXEe3HciYmyTYKTT69wbQ64ebY+f20j/RroKRTJGPhiMP2s?=
 =?us-ascii?Q?71iRSDxdGkB6w1LPcO2I73jvwSd3jeglX4GiESucL/PW7wo9lwh9T+YS08CA?=
 =?us-ascii?Q?kGHKsLdmIAB4w/YIq8EgIarAKnN8mTVMcQrOAMvZYv0QL1la5G/eoQPLPyaE?=
 =?us-ascii?Q?8EIi+okxRBjjOTKTgYEfAneC4v7OcdF/QZlTQqmD3+8X9M/cCk9O6bQD0/f4?=
 =?us-ascii?Q?YrVQoUFP+Zo2wiapliRt1yJwTQQway2dAjlspWw9sGFfWO7jat78QOvgxn4z?=
 =?us-ascii?Q?c6r3YmX/JOfd9FSyV3B5SQjEnK0Io+K2CT0SENlRrNNSwS7eV0oknXna0jCk?=
 =?us-ascii?Q?hizfCbUo0k+hFgODJ1VzfNaPlAU12QXYzvifeZ69Rbwqwi+ls+kCdJ349tQE?=
 =?us-ascii?Q?BTQjVddMn52fYwJOrsF82SiUbSB8i5/uv5BRcSoGn3n/ZvdOBOj9lgmHQrAh?=
 =?us-ascii?Q?RHmNHjKVZl/6DmwLek05hvgTxPlOWsE7sYVQUPQQg0bQJBVbCn7qbKs5z53z?=
 =?us-ascii?Q?Qz1mWlCaxEboMi2OXdNjs1/TcZlkbOUSnhVEU5Q8C51fcAMV1Wz7QHx2M5GJ?=
 =?us-ascii?Q?BGWLLI4mj5D8/kveuXesWSjhfXhV34IIl5SbqavP2seg/ijMMxyKQmE1zomq?=
 =?us-ascii?Q?4ve7yt94mgXb1ZLj9orOAfaTk65W4dwGIU61SdSAvVw9g8J5gO++o1ZpgutD?=
 =?us-ascii?Q?jwgIK6SUHwwUhte64YLwDbAtHh6mcLHQdPg+YWrcH3YQ5LuAuoNkIOAe6bZS?=
 =?us-ascii?Q?+bUTXckDfLM1C0=3D?=
X-Microsoft-Antispam-Message-Info: yInIT6rZrKbBsXQtgDgU6cMcoOC/9ZDqEB7kQBnAbG+kWlM1YzPa+KbmKBvzopjponA2uWRePbf8LSvGplrW4RsNu/Vo1Lx5HKgbhxgnEBO6KGQYa7QMEXn4YadlTjDiL8ijLcV+9mVubQLQ8YVD++NNT/4P8nIF2oZfpN7vV+i519cf6Gu6AiWlNf017M2QxpeSo0gpcgVA8bV3gYw5HIi7meavVowBYybThkdBX1z6qAN5E/BXrx8eFkIkMdqVt9CsfZRTr56iV5lDePl5ET2NCbnZs7EJ87cL1CHAoPgBUhG/KBYkjdrK/0/xdmJj/MtddmrhVTIfpi4Mfu5n4w==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;6:dlDUnKubxXSVj9KZlu4tcdOVdYO0WzQkk0TJ+QiTVnozBRzyd6gHf+2SXNeNZWoyBdJBNcOWqTs8tuhslUOPeSaaeGKg7LGA4AJ8brrRRlxkUSL/27w01wB4cewaS4tmqvaqRYVWdxi4ku9K74qeMnb6YyPz6caUV9Q2+thdSX+K35mb7VDfALNv3JQaRRfqgcqDicuwMIfZUmHBOxZyWh80C3xR/YYkwaMU8E1gsV5zd21BCEne88myuJXS1A4dQWsQax4Fes7+cEvu/255bb88WrmKD4sHq01pvLfxkTgElWU+dZ1FFQdZqWiIGu+dX2MrbAaiL5CAPJMDqcI0n8yfSmAeYF8wDDmJrQvv8/sGS3bMxg8V9lwE029hnIFFH4TtZTjFMNaFMXWRy3ArPECzRrlFA4sNfDUwJIwPcpTHz4tIGGX87hn/d0uIeArSwP925Jk90jDjsya5QhS3YA==;5:86ZRLVt+lDaNgmlt9VcwMXP/Hwv5GaQ9Pe7N1j4puQp3CaBAa3Kkt1FRmLVUY1j7kI/eZvYhsRn6uIVo1dLBV0I7A2Q3a62r1i3ochlgATiAH/4TKFODULab0iF+hTbF7Z3EzKSQ04YFEd62w1zwVryAW/9byxe7E3Budu2pxpk=;24:P9zukhlC3RStSMfDAz6JTHQ1Km/43UrGeUH7ylMVDHb2NWrEa70SR5BsO9UOIlu7t7wK6Gn7ocJO8iX7qc6bzik1z8RpUrE02kEwAFw88+o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;7:Yntt29uPAGYqQD6Kepmo3vAixLJfuDWAI8zEkgW4WCRgbURaGF5qg+pBom+vVE2PyjhVlUQvtWRLbLnRbD6yx4MGCTGY87Idd9WLedEWAuGccuK9Q3NsIGrtj7GvgCRXKwqm+nrQJBnBxGIrJVfIoMBkjqWgkDto6LHUV73xrlAFuijSIsvTjnOkbT6z3Ft5yjiiBJ3pI7LYYW3sebjyJDnFZqS21rAe+Sph0KXdETP+eniBtfqWGIvQO2FfkO0N
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 06:32:58.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf43e58-31af-4ceb-5029-08d5d80a0091
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, PFuze100's SW4 is supplying
LPDDR3, it needs to be always on. This patch fixes
Linux kernel boot up hang caused by SW4 being turned
off:

[    1.693613] cfg80211: failed to load regulatory.db
[    1.700063] SW4: disabling
[    1.703973] SWBST: disabling

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 4684ac4..2217c40 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -142,6 +142,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

