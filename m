Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148A52077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iMmYSEHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148A52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeGKMRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:17:25 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:14816
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeGKMRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg+amnUYHgAUXpiLMBGrS/SKmj++xDtB8CGzrWvApno=;
 b=iMmYSEHyNdQlKuNR4jC8FtldNQZfUNXMmM8jVKhmkstAEcAa2NqkTa1y5rBD7H7A09jvZ30xFr3AEqAWBhApJZSV6+Ka6+9D5MDkE2lENH0PvhymSb3g9mC5rojc6eb4Yc5JXX+ouhLN46u5YkD/veXMem5NMePkK5769tRwHjY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 12:13:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH v3 1/2] soc: imx: gpc: Disable 6sl display power gating for ERR006287
Date:   Wed, 11 Jul 2018 15:11:16 +0300
Message-Id: <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1531310547.git.leonard.crestez@nxp.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM4PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:200:89::27) To AM6PR04MB4295.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a069a53-0bbd-42d2-1dda-08d5e727ae48
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4295;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;3:/OkFIGe6IJ9R8/JkZRoMKj90iw/+DTgQr/7P47N3RgoQX8jyJ5FQeHQSB5q00vqkyZR3Q9sLLrwMZoPW5BUMqtyXrDCoVP9PFnRDvIkSQ2Ar0CduXfrar9t/t+bt8zTP8jhAgQ+vnJ0YSWFnaCLjMWJ4vfhp4JCEvQzitIpQzDUUq+1ej5v8pdFoQZFlQHL5SaTJx8u+PwOnd1sW5UhabIJWeT7g3+HBAMnVRNoESTZdqD6O1EYRRRFP2sDVrlW9;25:aWiq+3cQ7Xvm7hbPWzxDOPyup8pZOF3zJm15M3lANnZTlI+exolaJ/GocwmdFqa1LPV1V39sJXBd71pr32J8URw+Ilnen3ZdzpEnklR2lOLHv1b1eFFdsnQg4drJpNT+TeNvWA4ZZrp4fIoXEg67GB/U2lwYYg06GJvAmQW+Xgsh8nsRrJvMDYb+8xwg3eWHSlnoihol/if0rU6uTRYusvFDSYnNBOfW3wHIsF+FsSYfoAzDFOp/3+kCY40xdod+2CjoP8R4TytD8/IMSRot1wjJq2vLbUG3vHYkjyujbQm5Hexi1O4CC2IJN6fodE3o2kAIN6oSfg8XnxLEaPrknw==;31:7lMSpIbJv/B/wKbzueWHoCp2SwWCPuEm68yCToiQMxtupSgGgihlMs60WwHt0YmGr+PxtnGCmW3JLrZLoBdZc+1uUOuKXUwU7auzCG+8HM6NYx76HMH9QklZ3SCH7ddgpNd3ViDzfdZOkmE6gWP4KbV22SBYHoQm7TJQUku423tZSVJNjvrTpDu+RrqbEbmkwwTGyOzETanE0V81hZzDn1xbjMTml8y45W682duyyis=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;20:ssMYCZUmI+cBWh2exuIDrD3pxtt4qy3Tt8rfxpOewK/yMr+3NZg7fTlpJpCA76Rdvdilfxj3yYXJmateELeEBKKZhFQL9ZNAdIPa/aOKwZmDvvfqbAu3NPSFmGzMS1+LUQ14w0tqiMTi64ZVyczr/Q9qcW8eFM/8eQoZ7TMzbwvheeYOk0GOVSvK9zjT8cp9FDuzSIQZLP5LuOJatBlgT3RQIQXkSHOh9ZJDqxXzIoLHxDARcHl8cTCaRJRiZ1feBUHgouU33NasiAVN1Th0ydmOaOEf34QOMt7wnHdN9DzEhm11LxdgtKEJw5hTCc45jvExdMlDsOMktqvHumgD962NGQKVyVeAtA25RL/QzwTBZs0f1qwQ7jgo/5El6VAvBJNL+QnJTZA6bSiHh2O5t0o6Y3DPGy2nEh/pMw0e0G/OyMSdgcyJY6DwKIDT4Wj2ZLguJNBRYNh+ZaFwEFMeG92j41Gu/MWTe+tztLROgv3Qim4J+C+XSXqxS2UN2mxR;4:90FBoB5VSM6yOWDNeuWFWAKsLdaVQSB0GpneQuTuhTufXc9ykZlGSODV5RxQzxfb9adFi6S56Jq/q2fcHSilKSfqTnTzBNhbNT9IUFQkTQi364jX5IGXAAp1E4JQkEzvXpNO59n5FFPKumFI5sA9Df+GemtvA2o4riynmzZyQFHSeCmLfnTKSBevIKZ6TyUiUa+PZQJYM1OkugFAW8UpoYJg8NjrIVb2OaSIMO2LswHgAtnFK0VH6y+2m2RFQzdckJasuH08hfqECLCYtciSo3X4tbKsKwWtG7n6M1sZJ0a4tCdrctqOVDmFgN+9aU1yhVaASigXi89QgKRLB1vmEvUvtnUjn0370gMukOPRRqA=
X-Microsoft-Antispam-PRVS: <AM6PR04MB4295F3FC1A25ADDB08937067EE5A0@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(264314650089876);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4295;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4295;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(316002)(186003)(50466002)(16526019)(26005)(105586002)(53936002)(86362001)(4326008)(25786009)(110136005)(51416003)(6506007)(76176011)(16586007)(386003)(6116002)(52116002)(97736004)(3846002)(48376002)(7736002)(47776003)(44832011)(2906002)(11346002)(956004)(2616005)(36756003)(118296001)(6306002)(6512007)(486006)(476003)(446003)(966005)(6486002)(478600001)(68736007)(8936002)(305945005)(106356001)(5660300001)(50226002)(8676002)(66066001)(81156014)(81166006)(523214003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4295;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4295;23:wax3y0lO/anxlDBgkO00rW+ty3LZrrsA1YWTtlRoM?=
 =?us-ascii?Q?vL/q27LZ5Ecv2VbxxtYVa30Dq+7BdyejX+OHbc41JhNiub7r4CGl3U379k9M?=
 =?us-ascii?Q?AxOFnvQZGXewVeTjNZJzUCXcELOZxxcHya/ilFbrrshruEH3bLCAEVVyS3hq?=
 =?us-ascii?Q?XYIfiklKUuEMNs+cGYzzlC18W3dwq0C5OZBwvxKF1hkjKyMzaFOwBbtp+6dI?=
 =?us-ascii?Q?TR69z8yYsexxz0DEDh/lHp+oyUeki9C9EPQiE2/b6TKq/9VCM1nIt8ikkbm0?=
 =?us-ascii?Q?WXH1JRIJcrY1EM42QgtVrYI6WIDGHJpkIHR7GW+/3Untd2OSBpjIbBUNq8dY?=
 =?us-ascii?Q?h6oARWaNKmgtXG5ZshAHz4G/T/9GWT63IWEmM6swpzvQuqSfZrwy2tawVtaj?=
 =?us-ascii?Q?fOaoP8U8ERDv+/YKsbzaGlDqJbcCMwCIhgoYUYKJUG9Ec2K0KxEVML8IEqzA?=
 =?us-ascii?Q?gqsFLV6FwyNPNtkzKFpAf2cIK39FqSqyTWzqECy14uByXuAlYbTa0zl4iWz0?=
 =?us-ascii?Q?EInhFejt0nwaRLwK5cZxu6aCQcE37O+5OZ/qhy1hC0CeBkTPWmMZarp5SL9T?=
 =?us-ascii?Q?4KuDBQDn8L8BI9izxnUbCMSVgw32BaJkXnQ6luFK50QaXZFOtn4aJftjHagY?=
 =?us-ascii?Q?rEla4pbtmT+2MXFaMApVL9I1Ph5T8JXOyENM4eWA2pjrYiXTsCw4FII//RW7?=
 =?us-ascii?Q?0UXKiydis35f/SE4gz1Mheysm+HjxhE32gG81YuAJpFQ+Km3gthYf/a0XVOD?=
 =?us-ascii?Q?X1I7rpK1STOg+DCam2wvynJKNxwp4wa0zfDikEw1K7iWU8jDD1/+qENoEI3i?=
 =?us-ascii?Q?JThA6RpKYEvj9JHzcbXYpENo3cwFvtMY4mzBhLm4UeDGr9ektAXN0BFQ0A86?=
 =?us-ascii?Q?9AQAW2Xw1JbnAX0meNuCclE15791eSL64li0BJDykwQiXo83xcRdP/dGFEl+?=
 =?us-ascii?Q?5gCevB/31vDEHpt7mgOTLfnpzM8OUbrAZc7HWG/p+cEOtQgxQDCfZOb6Jf7v?=
 =?us-ascii?Q?Mdo2r1ZQJhCXrYF+t5RpQd8TUqqfHd5Z1K7dMQo9RFK6urZnn5x6fkkqtJQT?=
 =?us-ascii?Q?G59RNIFv++0femD6ZfYZmYnPjcYMjSpitiMipKJ+Vtaj6XoA3sHCBPe8bKS9?=
 =?us-ascii?Q?vrUhtqsbr8IAQKOsiNuaoAPzGsQVjoQGiys8dvbGlB9ezEpOr+UDuqUesI9P?=
 =?us-ascii?Q?4eJZZ2F9osWwZ+aUt35gPusIl+xuavz8dnbrleB3T5+rfNRa5bTBzpj9lyE2?=
 =?us-ascii?Q?7B9yLQHm9pABlAYSlS66nrI4AMX6Vt4/2nbxLHz?=
X-Microsoft-Antispam-Message-Info: nOOExeUtnvR17QiWqWN2UNUxWnhXp6u/52v7DlQHjBCOCBv37Gq8njzdrX/PZow6WjizKvoYdMB+senrW1bY/uKgRKFDqPl3y5Ko3fedYptIhHq/RzwC9fNjXkURKj/xFOOG8biYyA6oOK/xRbBQXYien3Jryo+v8sVUJ0NzjxavmwYRj13GjIcGO8of1IGAiCXvWuTyuhSRLNZzguzQoof9qVl+iVbY7yuJEK5UfKCOAMnekSGZ2/fO4dYyz2rAQf3Fi1Zf4/EC/+sqvjxWBDHv5DmdBwKMhPXxi2zTUazYPSrXXr1pBO0LYcNgZ1Te6HnxcSAZWp3zbirAoDBKa9mtHYOmBu4ms78oV0uRgh0=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;6:DrpMkaI5UNDE5z2nl4u9KKik6tgWL7qOdn8DBZ02TJ/Rk70ZoM6pwv2rEa1ObmMOurj++sWHqweGP1zhRXwF8K8AC0zqESmf4c0Q+r43A7tX7HLwD3EL8wdg0jseCNO8Y2juk5z53HFGoa1dWA1x5JzLii3IXVB1xBvGOpfChjE2UIP5tC7Z7B36SdHhZXh9ldW5/oJ7AmGAYaIlb5KQVMdTpbRZVR9ilLZyyKDE1y9/L8BIGUr4NUuUy6BhL7btYG9nMsL5OBUTSoATT/FXsMfM+Whdk/Zd9uJL3HCdmCj26P2ant4FwFJPIXuGZQKN44eCjfTIal6gNA4xzAtob8oPeLYBthErrrYjyrbvLmQpx5xPaK7xTmhFJBPfUj8H6+WaN5ICc9ROMPVFGbL3VWdtgP7AFTeMMx45xREqSY78HyoKokuNmLRI4WF7Uiqj0zqeN9Rd12rW4AEhvu0weg==;5:PBG7+SiKAEHHElKcrT7SDVOBdWrWDHq3sfhWBpxAWWeejj5b96zkRueap+FUb2rPW86qwZxJ5TEXvEBrrxTcRWOOkqZj5KDcY32017IliloTunZYagYYeYs+9FaaDjro8cps1t7+EXAUaQj96mA9k1DzRu87GeAYc7n+bYlC3Hw=;24:5tFaMgbYfEMwXl+VvoFwuFB1taarfU6B0IGWHSwonnO7nl7sxEyymCFRf2ctrGG5HbbT8HUUjAAiurB+njgYU85IslfnceH13wp15Ule8K8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;7:FUobFPTOsueBoGEeWuFScy2M/ItDyUjnT84d4KccXleqVsOXY/E8ekg0zPhFxGyeaQdHOv8NfV5pMt1oH4pjVya3OvrEmv2Db9SMbXnPVlpSd4dpFHwC7HxyMNbu/oDfM5WwDyNduVfHaN5bR4GG2T94TjG/NdPdRJhacPwoQ2JkUnvkpYWhX0TiCrQSOfQ2hcAdMFp02Sap4NEsN5VgEgvsRdyiZ5TjUduRH0N6q3bA1PgXWJf/MDfAoYwIMsI2
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 12:13:15.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a069a53-0bbd-42d2-1dda-08d5e727ae48
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6sl chip errata document describes ERR006287 like this:

> Upon resuming from power gating, the modules in the display power domain
(eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
correctly.

> When the modules listed above are used, do not use power gating on the
display power domain.

Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62

Handle this in the safest possible way by keeping the DISP domain
always-on.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 526f2d02dc78..f7960f773019 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -339,30 +339,35 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 };
 
 struct imx_gpc_dt_data {
 	int num_domains;
 	bool err009619_present;
+	bool err006287_present;
 };
 
 static const struct imx_gpc_dt_data imx6q_dt_data = {
 	.num_domains = 2,
 	.err009619_present = false,
+	.err006287_present = false,
 };
 
 static const struct imx_gpc_dt_data imx6qp_dt_data = {
 	.num_domains = 2,
 	.err009619_present = true,
+	.err006287_present = false,
 };
 
 static const struct imx_gpc_dt_data imx6sl_dt_data = {
 	.num_domains = 3,
 	.err009619_present = false,
+	.err006287_present = true,
 };
 
 static const struct imx_gpc_dt_data imx6sx_dt_data = {
 	.num_domains = 4,
 	.err009619_present = false,
+	.err006287_present = false,
 };
 
 static const struct of_device_id imx_gpc_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
 	{ .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
@@ -467,10 +472,15 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	/* Disable PU power down in normal operation if ERR009619 is present */
 	if (of_id_data->err009619_present)
 		imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
 				PGC_DOMAIN_FLAG_NO_PD;
 
+	/* Keep DISP always on if ERR006287 is present */
+	if (of_id_data->err006287_present)
+		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
+				GENPD_FLAG_ALWAYS_ON;
+
 	if (!pgc_node) {
 		ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
 					  of_id_data->num_domains);
 		if (ret)
 			return ret;
-- 
2.17.1

