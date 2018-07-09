Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B63C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4102087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uGB7LeaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4102087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933040AbeGIMYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:24:05 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:62272
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932571AbeGIMXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPdKiSufcFdD0rzhyOV/i9hvKehkHprWxl7CM90J+0c=;
 b=uGB7LeaQTLHmWdU7h4RamuWLtwNX+VsjtCBjNqO0JRX1fYT4KCvqmOWlCKjBJKK9ZeWTFA+tRdYuMmxpmI+arKUPFvWl8jzbI6wxXfFpuo+UhQ4tb01ie19v+KL/yXg/zev+Sq9bc4ONqH++rMOJKgMMQH9LnOUUQygJjx+GyDs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (2603:10a6:208:67::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 12:23:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH v2 1/2] soc: imx: gpc: Disable 6sl display power gating for ERR006287
Date:   Mon,  9 Jul 2018 15:23:01 +0300
Message-Id: <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1531138446.git.leonard.crestez@nxp.com>
References: <cover.1531138446.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To AM0PR04MB4291.eurprd04.prod.outlook.com
 (2603:10a6:208:67::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0c3ba85-3af4-45ea-ba25-08d5e596c9a5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4291;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;3:k7lprsa+j7MQkhkVvNmHfTKKhDumX1SFqqdW4AFXuamhe1II68qQ2ur55lyeVWTo8fL1nDhbJjC27XzGCmd43NmES1nGDqaPLArUwtQee7JUtixQKT1761QVJfFDuM9mfKFvtOeTlmFXyG6n4tWO286qcCV4Q8l4frzBFrSNOiJx/VO4zJFWthiwW94LdMwl19rLoqhXfoFafduk0VnkbCaTe8GQHpmZ6/3zsNYkF4lui94vi2B0dMF/IlVVh/HI;25:jk0HI/jcYIo+UI1+I+NHZwf/iCV/sgEa02MpgQMFZlT3EU8fT7by6ebROnXrYPXGGBL31sjTd6GxPMuImMdWngXJnWMrRbb+H7CuNFstVbKApFexx2ngL2H7szNBCTUVX06lDu+iJJJLDhsazuOF5ESd/EKYw9BPbmfzIdodkemBcq+6YNIY1ImTBneE8Av+CBjvVeIA16AH++dEzUVUGfPpKkOzgP5EBv6dZ/aeZlcBTOwd90fNC81mmJK7jzRtuuUtoupcgnuCG9IcYBAyICaxDpH5V9qiIs40s5wj4r94D5ZXmg+vc/qYQigtSbGbbs+KJg1AeXo+BW8huVeIiw==;31:FWpXFJUNyueofHhjk1X/XeDp/AZgCzezsQKmJQwh+Y1JF3uXslfPJbyAJNmsmnVCsmkU8qOwZ8UbhNgaoUZ/Ei7MimtawEgZlKkeJajltJi234lA5KurNl7huIwT083p+t7Jk0HYzTwPDdxX5h8JtXCKaX8e8Wm4Og3GFwYwk5efl9IIrOTULpSBFcEIJr2Wy20Pzfpw+BNcoGaFezQqKxaIQbKE43heH95v1dOXHEo=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4291:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;20:O56OE7BepacN5qlgXesX1X9XPkLVVFPk0Tn6XsmQDjpeOjbnD13+llS6Adjrv1Fy5KZDHL3iwPMzf3EWI9XJ5fsZ853lSTunhWlP3WnPjSpx7IQ3/8ofE7yXo05Ev+H/Rfzy0zvc07po7+3tq1GBC7un28Iq8Qs6e7d4uGfNzrqPp3mDZPDdXP1MO41QCT7iZ3n3FOC+oqSzahW71HeLhi+IN8uz6n8cRkntIEg7uYNXFAXSy4r9J+lGba73grGJ4aME7xoRwUnzgGRnoTonwEXJQhDnpBNZn95JXmzbVgrtSG7zNPysecnAMAKnUEwkTcwO96atlnuuciMHufMTz6oqk/ntNYbURo0N0meU2KQPNUd90HRIFvSxAASzXEJJfhSZH47S8nSO4sCfWhpCYMo+jpgouI6MKv/AJRsCX+TGIM92SnpF59BEQpjmjlayw4wTHPSLovYCf9fNYZZwiAoLpmtnCo1FA7EdcxnVR0Ovjn3ORrWF0uaSqC4qGpsw;4:Uu2cT01aNIKwlyKGhThiGQ0x8MDLwisc+YGlYlml4sOVMbPMy8WId2pb1Q1ctWEpg2V5ZVj3TIlmaV44H9cpiAdQ1O53XNA5ZEcLSTfqP25WGSDYsXsVVOGHcJa3lppX+o4oykNamtck2SaBf2MpntBJ33aw7bNyiamlgxYNIMHjoOsFtczjZnzxHfyTIQL7hlMGU76jPElxtL1dFWE3Lq5SdhBA8siuX2ZY/ZHfjOHq6fx1+Ogt48AvP5SbY7CX02k+gWlc5SPo4jLx8VVaXo9wqpRuVcgn9YwxGYny6aGPRN9U5trGz279mZGmoRhY1dTTqqCXjpvgiztVWaNSUJnc3SHT9QBybvFRRc2oqJs=
X-Microsoft-Antispam-PRVS: <AM0PR04MB4291D50376C33063D7A92F7CEE440@AM0PR04MB4291.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(264314650089876);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4291;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4291;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(47776003)(110136005)(97736004)(6636002)(316002)(106356001)(86362001)(36756003)(105586002)(44832011)(16526019)(118296001)(3846002)(25786009)(54906003)(186003)(8676002)(6116002)(956004)(51416003)(26005)(52116002)(66066001)(486006)(2616005)(305945005)(476003)(81166006)(81156014)(446003)(11346002)(6666003)(50466002)(16586007)(76176011)(2906002)(48376002)(8936002)(53936002)(6306002)(6486002)(50226002)(68736007)(7736002)(5660300001)(478600001)(4326008)(6512007)(966005)(386003)(6506007)(523214003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4291;23:UYbhIMfeZirlRz0y5AAH/5pg9XaTPNTlNiR9+D+9q?=
 =?us-ascii?Q?z7kvuwnDHR4QD6VTH7vE4oDCymUFzbclMnytxb9MC/AApcW8anf1Pt+hEHyy?=
 =?us-ascii?Q?tKuLiKSfWwYMzdvMaItvNyL75lXJ4qv7NQ5D3gOCfjv5NmOX4EO02TNJzQEp?=
 =?us-ascii?Q?bxbpo2xUbvrXp77887XXNIDWtjdUyoLUMuF1cG3g/5lTDlrb+PjzUOsNt2tv?=
 =?us-ascii?Q?yYejYDzg5Om/Cd2Za37ESP7u52z4sEeSP/tfQqeyxcd2alIRLK3fK0UZBEgb?=
 =?us-ascii?Q?Cw89UfwSkSO2MdmkmXU+ojRd11WoI/UhExEreAARGuSf1gv2LAVVD/0/+PyK?=
 =?us-ascii?Q?yS6nEcKpms60nVxs7njab7JNG1LIu1YVFoIA+dmJT/DtJCyUaAFzo/rb/xJY?=
 =?us-ascii?Q?nNoM7oJiAQ96rPCKe5kLQRcqtdzsf5/G2jt4GmjHXrk245B+x+DrOvLB4ecN?=
 =?us-ascii?Q?XKKjImfWZF26KpLFK0WA3J2BeHKXFX+EcaVPzTVxK2JRLQ5ZRWKz1tUQd+8A?=
 =?us-ascii?Q?VPNEJZJ72FIeqeJ7PF3nc5oTu7rL8nKNkzHAHgeDNUnY3fTLzGR73kbdF/74?=
 =?us-ascii?Q?rumEsRJLRp2w31YxhTUfAkHnwudKeW8sCxGfzWGee++Mpk8JOQA9kupDCYIm?=
 =?us-ascii?Q?pzIqdSA5z010QSAYcMRgDv6qlzr/CeJf5fQq/9b0pjlqKVY/M2W7oEHqp0gM?=
 =?us-ascii?Q?/TFg9LG9NcVNTr5dcW+09iSX97MP3qKjows2ObyY4GPqMEesbQp+dg0nbShR?=
 =?us-ascii?Q?cd7DBnz5uyoM1NndW2Ez5ZB3f8vYf5i8uYaYbgS0VseMnpqtuG5I662sjjiV?=
 =?us-ascii?Q?DHdmGOG/FHsv32XOKj30EqD00c+0zYQfEensO1tYcKefYc3nqL7BxqQweLkZ?=
 =?us-ascii?Q?HDIUcC1/SwWYX2tCG8R05Sn8tt+tSD407gJ3lAORfc20CgVw8uXFX1fCUVss?=
 =?us-ascii?Q?sSmMVO1Z2wP730p0ZHwnIzURNZGvxpIEtaMo5kmmcW12BNB1Yd7nzCjxtG1I?=
 =?us-ascii?Q?4ICW2LT1dtSBPwBzbTqKCFsbSs8cwTJpb+yrzQ+SL1JUosQ5QQhGzCj3uLGF?=
 =?us-ascii?Q?49HiLW3OuK4miwjqSv6Il98TE5NGmQCxMIfPFV9dN/TMiSTv6LjvqznO5zzt?=
 =?us-ascii?Q?WVgeyxx/4OfRubC0XQqcv/Z6ch+RO4F6dpephX2Lvzio5ZLvkhAWGygiPiql?=
 =?us-ascii?Q?3iWJfqEhQHpOst6NvZzSEf4wQCJr0+9+e2ntcsIISiwjgKaXp8RDwe45DCH7?=
 =?us-ascii?Q?uoZZA2GA6KQtrSIo0+OiCOyZUyqXSbPWf4v+/PiBTOJ4mBds9hT/0vG1LndN?=
 =?us-ascii?Q?2em6a/kVtKeX0nYDTwd+tJc+xgQ1b881wZ5qo6YgqsWH9gj4La7cgjO6+U36?=
 =?us-ascii?Q?tOaxD0Vlgii4sPKWh10q5Z+AKg2VpHoCUCbZDGMQjfTZkTi+lQt+iWnPsrgC?=
 =?us-ascii?Q?ajho4aivQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: tuzz5S2CUBjBMKBFU7AEYLAGJAPCXs4MBgpiYUTweIfiyDoSLVfq3ty0zohyymjDo81FTSkVOgEDfY0hpnl6AMwDxljyHMAfCvddjqpqWtDMBQFuWKEo76ebn9DB9BbhcYA49wb7GcTCyIrxxzMKv2V78Bg+/qcY6BW6/Zdi8sxKhzdTpu13kys1GnZGK17tq/cyb1f6Fe8TEpSIb6t4GTLd7hhJZt8jpkKmx8jCtoO3KVaVTD7tCoor4ND2GcYMjbdpopp67759Bm3KWPFTt4omnC6VnmqLaBe5M4LQCsY08RNmXpNytZE1KwEVocDlsXbVyGtI+Tq0Ly/fHYw9cvy6V15kZAv68mB1Zz/NWb0=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;6:iiBYa08TP8et2mfticyXdmuCwpslWJxZSeCSKAGV9A49A+JzZ6CBR6heDz5t/YrOs6MbfQf484Wk4FNOfSuai0FPvZ8c9QOpoCiWqvUJJ3bUAdw+G1Rjl4ouCqUU8SnsO8zIzU+YbYA22DQhZgSHLej+Jc879hHr1qZzuVsLH0lf9If3pcyjLP9d45TE1/nq1pyzFANMQBtGxFb4l65jGfWkYw2leZQEM/MCE5oW0GDDozrEoCM/uZTol8WfxvUth6zchkYEJjKiK3Uk8WVG16Z4J28/5RUHrLiXgYFxLI5xHo8Q6LoUXuCm4AbGNNTU5OSFfHzTtCwTefDmwTESzGO+3LbMGZWmnb9bztXIq5VYg0+8EsLKJRsxHs/xV7eQC0J+z6giUT1GEC7L4OnoASMnS+M2GwiMuueOPm5Zq+GXpaOypQ1RJJ6OximVOwcicIiOc5XnMoh1Y1xeF8DXqQ==;5:sHHLtLV/RMyI/ps6J05vfKy2rUI9ykrWNmepOAVCwSM460u/UMu1YmLo4rx+P6MVEQK1Z+w6jaX5ZBHCLvZfYIUyPOKq9jEwdOTv6qR8K+mg/kZczUDh4c8WtXZ90V/ZVnTSy9jR5Zglc8dwuLBPe4YY3Eol559fKwOUd8uukrQ=;24:L9crLJ5cDTc3hAoct4YQsXwwzqnR/u9H7aHzaltpeJMjNRAqmpVp1XxOZpaVOf9Kjd8Kw+gpjwml9Gx1wiINkGqH35eVhGYXX7eIrtrflO4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;7:zhly/ORt/+pReqld2xvxjXpbfEw+5wVIMcwDTSTGDBSIV32b4CJNDE59J05OiBU/x0ukMC7JjD7UtdHAavWW9FFSkZoB9Z6/t6E1AiJSmgDj5FhuSPjn2wnTkm/ezSAQ4SG1MSCcMwigkAlx2878Lh8bQ10b2PtYhGokmpXhpNlv9b4tjXKhWfZM0dso1JqJehIsDu2cg98Rl27G/F97ZC8LZvirIH+UxPQqfYROgJ6+/kGLZnlK8IHOqovjncbg
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 12:23:32.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c3ba85-3af4-45ea-ba25-08d5e596c9a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6sl chip errata document describes ERR006287 like this:

"""
Upon resuming from power gating, the modules in the display power domain
(eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
correctly.

When the modules listed above are used, do not use power gating on the
display power domain.
"""

Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62

Handle this in linux in the same way as imx6qp ERR009619: make the DISP
domain return -EBUSY on power_off.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 526f2d02dc78..6b726dada560 100644
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
 
+	/* Disable DISP power down in normal operation if ERR006287 is present */
+	if (of_id_data->err006287_present)
+		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].flags |=
+				PGC_DOMAIN_FLAG_NO_PD;
+
 	if (!pgc_node) {
 		ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
 					  of_id_data->num_domains);
 		if (ret)
 			return ret;
-- 
2.17.1

