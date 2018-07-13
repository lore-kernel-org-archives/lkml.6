Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9094ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF62124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FoIB2sda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EF62124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbeGMINp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:13:45 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:51044
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731564AbeGMINo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHQJAPdOnQH5Pz7CsZCnMrLpfNKQL+VoGJoSGJmecfQ=;
 b=FoIB2sdaz3PY/u2fcZtxjvPVVTi+e78JHv4bxyBEwadIXU9U+QEYkvfXI75yBJCYJ7MGrFvgpzJ65y7NGQTe6xcVCM6QqoFhUN6BHhkeNAoTxn0QnPDQsVhcaYh0g3NeFpOviSPPCfLrJoYp7nS5nFFdWUyVQ+Zqq2ewHHwIdVw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1318.eurprd04.prod.outlook.com (2a01:111:e400:51cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Fri, 13 Jul
 2018 08:00:07 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
Date:   Fri, 13 Jul 2018 15:55:30 +0800
Message-Id: <1531468530-25667-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0043.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::31) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddeee443-7417-450d-0381-08d5e896a838
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:Cc6/z7I9BW8tWe5jKQ0f22t9pFXyb8r5qHG6lIZKuasXaUP8MxegFYC1QtiYyuvqziEm5e/yA3HHPkyWahkoaEy6rnFiSbu47acUetpRHbHnkJcAGky5MAz+3VD1clK2Try1RpQHiGc5D80DuUfM4Q+MNcQajWX9mj76jXj5KzAoCyvdN65RtFfQ7h7436qmx8hhrAV6G6RcrdWdI1BQd+C+JEd8hDtw/AUxDq3K/ga8t4enc8qeyPa9mxc/eUru;25:K5WvYVuhMnmHwxhcGBQrvRsLnu384jbtf2lEwJZkwQUVOcrxUjSHgm/lqrZi7jJwbItU5XXSP6n+saig8zMMS17DFEvoGiK05dTzpLghKv2pcWOXbO82CDej3WI7afRFsnOBYhkYlaLjbvEt/cECuGHNGsXb2VpmNzFYNgIgg1BBs5qmyzVcMF4eec+qEB6v/+Yg53sFbvvhF0ndpZXESybDsBbLTkYbp/6w05a0mE05/bXImFStNw/VTYwu/CnszE4+H4jyxR0GqYQnQxho18+gRpyaDGUqN71DR5Mr6LhjfAzMYLG/bphvVHs3nrT4EbIZMweODFfYy9xOV1r2vQ==;31:9LSbRl7M1y9HN1DnpqXO0w9uOYyoLg35gssQBzHvcwdFjxZp7lrWerrys6QMJi/udeQvPtPWGp1nY7UvdeBeKq22L56jdfrJCw0J1ICaDZvldWQymdkTMl9p+TVYzlveV/tEw3DIpLgi94LGdo4u5arqAgNO8naeg0WAqWqgPIeFvQneEA149rt0nSaFI0JU7I0yJ6G1JW1AQyP3OtF98GbMmyTVI6rZvSsF6y3MSRU=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:fzqol+9YH30peHO7fXYOvP6DsaXU8NHHkdJhDRJmPlL5+GqDQ0zpzTVqyR3kybGuxVQs4RYydtVydlryVadbYaSF4B84a78DTljR1SLrHlO4NfzTYuPAsY2Se6bBy3fr3OLxNzkmqnsORFIkCrMnRQPuAStC3kDV5pZFGoHd0xQVUcgk7gKtUp2cI3Wg6g6uNXetKfvNYKtqncsAPBN2fBZrbQLIJfDAzUZgH/SulsgN9yEK9TtLEm+lGHZ7KkuR+pVZUFaCv970Socb4sfGEsANpOc9SJEl8B4VgXaWxBusg8MSHtIB6zCkVxJJICBdJMV5ds2n2WVExVdabTaxpl8mcrNOOiqPPqQz0UpquJeSn+8XiCtEA0llN4+xRVChBv5t5SY5BBurRnSaKwPhSDjqbYeuhVN5OovOVIhPDUepRSK0kPkixZv3fGMgVdxvvx0NzZ1Ju1uRjKE4wm6P+F/QgG4hrGmwEhgvJdmyykBfSRl2J2OaHu1Qy5aQ6F0W;4:9YuhLm7PDjjS4cvijd3678L3MWQ4ZxITqNxpbDyDUUimPj/rVPyN2paB/2sPlssEBkDWmFjLjKJjsHmwD+HqcTG1A0Q0dAlfVwlKCzbChpwrgc5oV+Jx66JvzbQvOassNGbVduuJ2OEiQ/YsBoIicK2xzO3ghnN2/N0KCKFUMBBHeUc8vIxXpL2MbgEcQiW09jBuirAgslR+USxhR0zrHcy3X1Og0a7WhGuVGCZ3V8W4RPGtBpBfRHQ3G8AlN5FnBU5QbylECMYwRqSbFlCj/xKQxgSykIa1nh5sZBF0gsM+7Z6SxQuM1DL4yPDCuN2z
X-Microsoft-Antispam-PRVS: <DB5PR04MB13186C933E2CA075DA484A47F5580@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(68736007)(81156014)(81166006)(8936002)(50466002)(6666003)(8676002)(7736002)(5660300001)(53936002)(6512007)(3846002)(4326008)(6486002)(305945005)(47776003)(6116002)(2906002)(48376002)(50226002)(66066001)(25786009)(52116002)(956004)(2616005)(316002)(51416003)(486006)(476003)(1857600001)(16586007)(86362001)(97736004)(26005)(36756003)(6506007)(386003)(105586002)(16526019)(186003)(478600001)(106356001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:oK7g6u2D2Sy1zTmjUtA5bo2h9gaL8dcWOb1fW3Mp4?=
 =?us-ascii?Q?XUqLOS8Fei553Yk0Y7wJuXQqAhO74Mtp6N5odv18XwSRdC8oltxdYTB96bGA?=
 =?us-ascii?Q?cRP+Ah+4KbWCc9SWrZ7ZJg5nfIw1QN8H8Ld9MD1Dwb3DDDpL7vuxVVhD9n31?=
 =?us-ascii?Q?dGz/QwXhRh9larylfijI1cegT/vFDeM2iwHAs7wVsE/+bCkDchpd2dzIIDji?=
 =?us-ascii?Q?XkGnkisi+LCFBAT1pGmhJnHo4o+U3aytzJeXR1lBxnmCsLqtONkqyOOcCNNj?=
 =?us-ascii?Q?1jk3tKDqwYxXISSe1t/Dv3QSso3r7NVP+3Qv3Aaa2N3wu1741UipJQ4zFet9?=
 =?us-ascii?Q?6FBi0GJWOfWuPGIHs+nvvyd3F1NrmbJbqPjSDqEwP2oQBt96Mn+lCSI5YYu1?=
 =?us-ascii?Q?+h7dmQQdXlBLYWPLU4r0++QkfJDybfrUPfLq9lrpEqhhjZR2R77RBM4uNEEd?=
 =?us-ascii?Q?bMenteTrs6NqBGwnctsTuCjUj17yFV+fJ7uf4QDYsCLJQ91R0IcJu3IR4Gwj?=
 =?us-ascii?Q?kGV8UNWnDoqgcQQhgfapDxGlPBIDYfjdIPpRhZu62INna6+1ZUgSs8XvCukm?=
 =?us-ascii?Q?oFkBIAUA8uGgdf+QEFGPN0hrM5+ctFNx9RwGRDXTVIrisTRiOlLyU+AloMj0?=
 =?us-ascii?Q?yxz5YjpP59jNZXuxXkxPi4ZUp2V9V8JEePIJN7PQCaEI/oCsJtr81dl/lq1z?=
 =?us-ascii?Q?ItkfaV0Ev8bFznfdYAC/csIEub/4u0ZgwR98G+h6hAupOF5ROyStMdefK/lS?=
 =?us-ascii?Q?UHuE19xkVzBxK/rVvdp6jk6CayI+51yBQrKydbz+SCDe/uDMh4jqfG+wyXjT?=
 =?us-ascii?Q?Gu6E+rL5dF80X+kHRbqmsauddKkstdUJmdkDIPHAjSy6BcEesm9FWLmjYQiv?=
 =?us-ascii?Q?16eEefjfKHfGOSSy8NvOoPkU8QFBCBZnt8pC3wv9jOHaOtOI2UoeVc9M/Auj?=
 =?us-ascii?Q?x7+uPxEaig4Ikg6ay6PoAS+E/jnOwF5SbhD0h5pZKgxTUFLCEHNmpCr0yZfy?=
 =?us-ascii?Q?vXprHIU5r7fll3Xl6j8g1J9tl/+kiy4oGHcxL5Sv2lDwVhY3RDNa2pJEyekf?=
 =?us-ascii?Q?6Z0ZNiCnqUa7RC8uccPxUiRwltombPG2wf63mt5T9SI7/lVfuHKCqhLeiQ1B?=
 =?us-ascii?Q?NtZHKS+NJXbHuESAyAGta3+3nhW+S2A?=
X-Microsoft-Antispam-Message-Info: 1reIDsD988cPdDdJd9O/LFrVhKxH4qMt0JpL/J3V9Lq2pbLKjHBzW+8g3/pK5BJJmuhz7dAiS+gAlo1ZF9q6p3g0sV+cH0mTzAh4y08kXAVIdt6JtgYWzzXS0dhT+0YvqOPH0kKdBy0zaY/AkuoLWHcO0PrxEONYXuK0fOSRsdHISuT1rU6cDz7K1YIV4qHeqc8r7zJuYGoL0KJdwrLrtjEtq6xthUm3lunoEtq4Uua/hx1dIuM5ceBKj7jEC5b1zPrRTx1BOd4CJSYT4NicYw2flPQ6O0oovU8+iAHsS/YkKdZUVaQen0OhWnUkcttrMr3wclTb5BFK/dTE12Q3chT2Sk8reHN14KEB418cM04=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:ezhdFXJQa7nYSkeC6AlP1xORI23ZBdqt4OTML4cdutDgecDK9MS759RlrDpaSlRl6HTrtDAeosPEgiixPKiIKwtBnFP+WSekJRAo0NfCAVM+TaalA9ETM39miUyRK/Z3WhdPaWSnw9K6lVP4rdNurerY0uCbY62kN5m0aS56dzUI2JwRnsKsvxHMkIjQyzhWhrR3b4czEzhpH7zGOwbPUD8Xvpir0ppBYHJVDzg380HB7zLIDHKnzb8iPKFtWGqjilUMjXFC2lW6Mt/zg0qLYuALlubCE9xAzCH8p/Jmi0Lp4zNiJD/y6it8QDQQcOHtFgFFlJqGckffoCUkYTG6PLbh9G2ODH+gRbAvm1vyTrAUR5ESvL7NqpncQc/yKMl9vn/2tRH+uQc/4hkb4nd977Bej8vKRVbXGYNS/kgt5exsk7/ZPmKxmaqOUuIWGkqnEywOB4THI/HK3EEsKFZWXA==;5:jTMaUiroj3sP3IFfPJ6WU+7j3dlpv4SCMOTeTm7NEUPZ3LuSu+UnVZxo7GwND0klPhceVv/xsO6STEsJ8vBAG/3W5DanmgS3a9P77faGi27am/BWJ5Oc0qhmPES1LTf0DNRpptDL8g56DQfn+k8jo3OR/uQXMe6gHgazItIpe74=;24:eDbFPBt5zpb8gqs6e+q23z3HOlmtFSNfKL5J2bSerR5ggMbkYETGAjHl/X0Gi4AlXo8BCDvVBgQu8zE4IM37F5YuKhEu9qy/rylvuxCMShI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:NL/5WTMSLOMHphHsh1JNjdAkRTaNFjOzXlb22nuW7TKv+7SQYDBHHZiaDpIbdZUtNM75B5+lyiMYqmq1xIUdf4RcehqC5oiYHEtbDGK57hsGL09AHOE0bkLU3EEe6peoWA1nMHa85QfyJytju/Wl4iYdODW82jiexRkr5VL8byH23evIUT6XM+RaczlyGZyz62t8r6ga5XTz/jV2UWDfIBPlzN9y4TrkwmZd3ADOQvAC44q0mSICSC5+8uw6g54Q
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 08:00:07.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeee443-7417-450d-0381-08d5e896a838
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
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
 arch/arm/boot/dts/imx6sl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 50bdc65..1294fba 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -283,6 +283,7 @@
 	imx6sl-evk {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
+				MX6SL_PAD_KEY_ROW5__GPIO4_IO03    0x17059
 				MX6SL_PAD_KEY_ROW7__GPIO4_IO07    0x17059
 				MX6SL_PAD_KEY_COL7__GPIO4_IO06    0x17059
 				MX6SL_PAD_SD2_DAT7__GPIO5_IO00    0x17059
-- 
2.7.4

