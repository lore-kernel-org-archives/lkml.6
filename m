Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE423ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF0E2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bav6YBCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF0E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeISLqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:46:25 -0400
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:18432
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730984AbeISLqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KzZb6S2yciXf3W0EO6IdVNP5Zz8IzXObnLQF4G2G8Q=;
 b=Bav6YBCofvMuYPkEiZC1KUb6rabRj4RYCcaCf+ewl+VIFI9rhetlwjrpJPwIBx+K9seh+lsGYwtYwEQSFMfpYHNozJyA5H7bStJUK+VxoV7zgvQe97fYgN3Yl6xHp0czEGkhSr+KQ8exVzynyqIoVzSj24ijPfpx44tzpInG0LI=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3919.eurprd04.prod.outlook.com (2603:10a6:803:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Wed, 19 Sep
 2018 06:09:52 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/4] clk: imx6ul: add i.mx6ulz support
Date:   Wed, 19 Sep 2018 14:04:46 +0800
Message-Id: <1537337088-28819-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:2f::14) To VI1PR0402MB3919.eurprd04.prod.outlook.com
 (2603:10a6:803:22::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ad0c0fe-1725-4c4a-e544-08d61df6870d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3919;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;3:WA+G+eB7Vv0Knp5214/cqBXl0w6ujoK5aSygRFvezE4SoKi/woelZlInZHlklfeke2yjYSkHMS+UI0e1NthEPqeD4CM+hkTCdh9ffO6osH0vEGBGjQbZTXVKF8xwz7V5RfvsotZJ/QJlCC9vhDyYezFtvkDx5oZDA3AWiSjtW1MWqSdXlSxuLjt4psm5DHgOfQsGk1/tG4VWo8brtH2vixJB+lo7bhd8eNPBqzlx86hac9mlLhscnu8MxnKRLjbR;25:C3vP6RmJ+rW6kgUil+KglLPoRJhQYCYlqtu1u/GdDDCXxkljCqA9WBYtW3x1/SUHbffbZRA9JJf7Yko3CkeJlc3AVOKZbru94ywBf1SuFzR8dHJURjg5l24jM3YTJpmpN0Lanu6nUF/azIlhtal0tpuN4J1CJaApTkC9PjUpTfq1eEJavYoAjHomYKrbfjX9vrGVyxvDZ2h4ccxX6SEK6t7a5HpND14p9LZLwRiSqaIYmlEK/GIBgBVyeSyrs8Q0YPyxZyS+xGHJdXTqphQNV136MwPc2w6NuFISfsHg9SWHLQB30XfVEJG6CCzeQufvRqeEDCIwM7KkzDJOkiaPNQ==;31:Mj4MH0PJiexSVrXYqRDjPEMj5o7qT3U+CjOjGFaB+/8zfvIBqwE6Hbx5STQ85yOc7bCnw9YGp1811KUHCRbryPtztPmlnjPE/NE4cB1aEsVXQdPzyVtWxwybFbPyw+UEJkyMrdkBpxvcPuBkL3zyxak3AcZdMsxyrnpVWWbF3fbKa3jTFyhWRJk3fZiVHiVaPpbbFpgKFExy8Kr7x0VQjoWzWSx7VrGHK6eCwvAz0b0=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3919:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;20:kvkZ9Rcwxah25yYAk/bjG961i82a5s4+r6TpRACHyWjqV25cVzRMuMHFr8rZiD7QM8bxv8Ck8G1b7fSLohLWgh3PaQAfxoyu7LtCH0q564Aijfvi+K8YPG+ERhNKP+zVCf8LGIlzQDikkEwJ99obajf4FZgffO5nZKj98yrbrkkQ/bFaY5Jjklwp+dHXuL3ZsLvhpw/826ulSPgZiBUMQz8qookimHGEbHYGYtGnApX1yp9xEQGpuyfTBC0G/Z8OFZo8RnYAROOHazW5EGM1nbbDm1MnF4B5TfkbC2bwdXnqrgjW+23x0fCPmR1EhloEOj3t8cqoNSPCfPNIzRTt/VTDkoJmvRllLn0ESY9ijUvBl142eugviIJ+ZA1lLb2GKegA+yMS+p1XwAO2S1bwiOmNIMl9KVUkrDaGMZnFcDGA8VKFYdSr3ihpvXe2sdCmD12fSDa5lI1dCBkLugAavorlKcCJIZ34V2NHd7Sj+BbyDOsqB8PzWftMbLdHm87F;4:SxpGKpztd/1ZqnsYQwxaPSkuRfQfdq24Qr7W+Jj9msr276PqFlGFe7RyZjUDJeGndbRn3i2M3jJy5HgdLPpMmHQsRsyHeSa5FvrhwhqR0xNEIsbdhNcAr6Me2ts8gKY88/8bFZWDIQs8o3x4X0OtwbMLZBW7XhBejtGsEuMUFI+p/Ijcea7GbiHoBikH2Oq2lg7bI0wyt5l5tpwOPSQLH8+mUO+lsyYEicdmdoW2yIAX1O9P+fq89T9L/+wni0ucxZLD8TiAwZ1FkWc/kJVcqSM/HIBdXZBHorgl25c16ONNK2SlBRZjqFX/sh1D0gbW
X-Microsoft-Antispam-PRVS: <VI1PR0402MB391904F391EA00E86BFBD6D1F51C0@VI1PR0402MB3919.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:VI1PR0402MB3919;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3919;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(6506007)(51416003)(26005)(486006)(4326008)(16526019)(36756003)(52116002)(476003)(956004)(11346002)(105586002)(25786009)(6512007)(386003)(53936002)(2616005)(47776003)(6346003)(186003)(68736007)(81166006)(81156014)(446003)(8936002)(76176011)(50226002)(66066001)(106356001)(6486002)(5660300001)(6666003)(86362001)(305945005)(7416002)(7736002)(478600001)(2906002)(16586007)(6116002)(3846002)(316002)(48376002)(50466002)(97736004)(14444005)(8676002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3919;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3919;23:vR1OavGN1OeiBmO4Z/MbqqcpTeEq86to+EI6vnr?=
 =?us-ascii?Q?k12X6laOBAuoDteGu9ZIb4K/ja4jJ2RYFwKDVXHvtpMCJr05IkWl4EDJ6hAz?=
 =?us-ascii?Q?Ge3Z2oWucEbLoq698PmHIWqI+HFuRLtUgHfYwBV4GXrl98ZPoEcOptLjTS7Y?=
 =?us-ascii?Q?/Mm64eWIagk7sFxEGyfkSw2jsQIKEghN6fdSoEgIUc41K8L3ApJFGO7AtQsL?=
 =?us-ascii?Q?akmaJbEcVvelBTEoeyfI2LXbt9nsnzcxcggxxjhEvq5H5fOVvBNuMIqz9ZNw?=
 =?us-ascii?Q?0Y5sggCUCwH+qzwHoefmQ+43W47xDcQ3LqNzy+IcQB5eLT82lp0NXyuVlmQy?=
 =?us-ascii?Q?+JBcOX0EANn6/N5RysSLk/nvb4hV7i1GOiNEQTAUPgUkivxSc5mmU41QuUzF?=
 =?us-ascii?Q?EoZVjb6EwmKZ/gj6xfYDcqnzyZGgYBY7b5rklZ0lRZcbX22fWOefw++pu734?=
 =?us-ascii?Q?qhuow+0+TJY/ogW1jfbLE4HyVruxnl+oc/PEte4zRynYTJcHorNVqeWSPItI?=
 =?us-ascii?Q?DTW3Sy4JIMB7h1Z1q/g4pptLAbog8J6F726xphmeNMy7X8couygs0YYwGuJ/?=
 =?us-ascii?Q?PjdYv3CE9SW312sIrNsiN4px/FeF4w2vY8a2/q2iomhvUte9hN1Kv7/XT6dl?=
 =?us-ascii?Q?hC5x7I8BINNpq9KAgkcl+2294YrywpBOe7KQo4Ucy0dK7fKTRrQNIXKwYnKW?=
 =?us-ascii?Q?CLg/coUNvtSTF3LWXIyilDrayf1iEIcBVUIgAyCLjLsP2qj29w131qVNUODm?=
 =?us-ascii?Q?b0CIJxqwIIBrdtTn7Kkj+fvzl2JmXxQU+mNTh+FDqoCa4iXzEzhk/1LDCrfM?=
 =?us-ascii?Q?WwumKeJvRn8tK2eEykisKSHCLL8khvP97qSuNfwVScCv92VuTAGBg+DT43r8?=
 =?us-ascii?Q?qUtzCofaQ32Dwc13eaGxGbmsqTKmWyyGQxoAlGsOEXnJlVczgTFB4fhYDo4x?=
 =?us-ascii?Q?E3K20cYCA9UA/M+9SKir6XRoiRkKxNv0+GheKzVy7YzQHdp+2zeKrNwCbu8/?=
 =?us-ascii?Q?N1npW+TeROSeI5yp0cSQlHmc+7lYNlH/FY3AVrmy7bPC/Hel1KZ3UVTNnuLG?=
 =?us-ascii?Q?9iHXJoptMsohlnedFv3V61wp6pL0SsDyUqHVdOzSchsTXL8KqysOIK6NUFOv?=
 =?us-ascii?Q?zWzQ408l/lcRaygJzzG0A/iAazJ3+lsMI+AFnkJZKI6EERmYLL1JsMhKhA7u?=
 =?us-ascii?Q?jEbPXgASz6S4KJlLJy5T3D2P+L/lT4lY8bNkDAnQdw+ZjG3nw4Z8dH04Gsln?=
 =?us-ascii?Q?TddRDr8fhtjgwo0cFaefTnMZhr3HSzwXheyrPrA37?=
X-Microsoft-Antispam-Message-Info: rqaXywG2NEC73sEijqfnCcxKY3y/abyToZndhW2rslCeSHqWooA284LwRy+94AmTliIEWM/lpNv6VJGwrWTseNoCxJQT/GjxVQFuEvhQTKTFpbRaAuygTjwtftEE1a2+gCBM9I3LrXT/Gyo8OXbDCwb8ELL8OkCZKzfeOD3FvOJHlTOBA5buBUw9JBG0IiCY0CBgprRzD/5QrpWN7jrRtj/UjGCjrX9WUtdLZtqOY81Jr/Peth3tlusqg6WTvxDwFQELenwSXaXT+/pWedxa/B0Sx2Cv/1u7C2ZQkxgQ/GMz9TeigrL80oqIJLiFs9Ank5dcDp0f/FCf31HzuuAx/ZD3eSm7MKwbKmrRt6eBdJQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;6:LQPt/qjYWMaFGk48Fw04+fszlB0PG0IXrUK/Ncbd8fbb4ztkYR3WtOiGoS5heSa3PSLGUQILOx52oNzUQTg6hKRSLZgIrkXcHm7GnpXw824Snwm73FncQR3gCO0SmKIHkwQ7s5UywdJn4GJAp0UG7Hl4uLhFWcHSw6P11Ie4etNnzFkKniCXWGSQTjYqI/KidfrMCSWEoIpLNsB+/06+S+m3++rZvtT8qCTiYGRrTPSIq7/OyvpCRMxfWwvOZ9qLIz2/MHaJJzQXtpuya/mb1uBSsnN5PkwCC8fj5WSOq+vocRDuF9OkJvN1gUweOZP7LJ4VSXYHhcUvbSV+9raJbXz7D7US41uQdmjnv1Ck38Kj6IGaUqJYC3xgx1qrPeEvRhvuPjFGdcw22VtAAeMykH9S4Wt5XVuZcvowOoXlfljz2+m96B+aSRw1nY9LtrU0/278Tt1HhG2LhlQTs3oY1A==;5:M5HF1lRmOTyvKJSVxpEKVIpVqy9/wqa4fMFhp4uavdi7aUkOPscVLnJC5E7T0NZ0ryfYYbKacACAeWzLqpL+lz0wWMtGbbadbROVVEH1seFUy20NmmkDdUIIGX1rf10e/tOiG4Qrqh5GbqaVQIMSmGS9nunL8Qo8Z88xUryVkIc=;7:WHESvO4lwPX48ZTGQye31nnftMzrAowNWmWn/YrON5MIXw77VM0VU6mqq3Tle+f4CpwrP344zcyd2EsvfOnPGmsiXcHe2/Xaxk0KiszAt1dDraoYytfcy3cpLVDwAbEzQJc3XKM1E1LkO0xFhlU5YsNZFba3al/55OZ74xayBnr5u6ZiNuVDUbygOo2kphcVbpuaXiT+YRPuzQxteooqkFpBt4qic3mox8vHIjjKZ4SptkfdpRKa98g/mEBNQTDu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 06:09:52.1774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad0c0fe-1725-4c4a-e544-08d61df6870d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULZ has same CCM IP as i.MX6ULL, and it reuses
i.MX6UL clock driver, this patch adds support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 361b43f..42b857e 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -116,7 +116,8 @@ static inline int clk_on_imx6ul(void)
 
 static inline int clk_on_imx6ull(void)
 {
-	return of_machine_is_compatible("fsl,imx6ull");
+	return of_machine_is_compatible("fsl,imx6ull") ||
+		of_machine_is_compatible("fsl,imx6ulz");
 }
 
 static void __init imx6ul_clocks_init(struct device_node *ccm_node)
-- 
2.7.4

