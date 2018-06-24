Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14292C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7226524F50
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JtYFVW5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7226524F50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeFXOrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 10:47:32 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:47200
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751961AbeFXOr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 10:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWQkBl4w8nPMaHuUDs/EskDyfpZ2PcNl/tgJtwo6ifc=;
 b=JtYFVW5P/Oa5vIgllqsNirKFL+XKzyfk9WuJK3oy4fMN3eCJ2vmRG+Cz1RA7j8gLU7iITPxvdxoD5ETWndk4+20t34Z36mxHssmAUwhXc1EIQdBbMY/HSawiXcGKrp/McDsCxP3FvYRfGT8oMIBErlgSpjRn21cGt4LsxHkzOSk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.142.187.166) by
 DB7PR04MB4251.eurprd04.prod.outlook.com (2603:10a6:5:27::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Sun, 24 Jun 2018 14:47:25 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        borisp@mellanox.com, aviadye@mellanox.com, davejwatson@fb.com,
        Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH net-next] tls: Removed unused variable
Date:   Mon, 25 Jun 2018 01:37:50 +0530
Message-Id: <20180624200750.26192-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR01CA0110.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::26)
 To DB7PR04MB4251.eurprd04.prod.outlook.com (2603:10a6:5:27::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3a3ddb8-a294-468e-54e6-08d5d9e1674e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4251;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4251;3:HPuEWHFPTSZEbc908bfBunaeBEqvN7+5kS54iIwE65c0B09wrKguCVVM7BKbUg7HYXJY6PCJt3yAkub8TJeVm7hYCANBNqfGbsnIBznp6iU4JCrbdErKoi/TDdbdqBJOuXHwJgt+2PSpvSAy5eMLG1w8DynPk5EgLTmMeDSl1sJDBcY4LmH9io1TAWBKI49gdJO+mxr7hW8uH3UiYHOz6Uske4UxDXqKzrvR+9fCwFyRb45dsD1+1SJyZ/Vq75oa;25:eWRyzXmrRwdoqcqJx5ox0G6/2qrrvGk5g0mtstKcoH9SxlrmZzZdIaQfm549PXYC5wvuBZn0EPXfc10AvAPjnxFRXo3WSpfQ4V7iNWZ1x/hwRGg7pOrxe+61k9mrVEf5bWeM/GGtri0DnGU9BDRnVHstMCESirTBnj6lVTqPvX1OIc66o/zcxwp0szBRw9IPOTleUqyR2WlOamm8ihZtArDVaYv/b/qTr0c1ieKKGSI6Cl1UEPY6Qg9sO2NEiFCh5MGKGH76jw2fE46rh5vld3x2YGwvDozcVOSmyH5fa7+LDYh6cVR2iE9iQ4XG5C2x+eJSQrDZuE18aJ4DNmUCWw==;31:TAa7IsUoHIwcMigh8XDELSBeqC5SHzGOyggMqAfFKjQVzn18lted2dqq1djGikItE0Vt43tS/dhBgtf6nPpG6LWqz7Vr+Uk1sSSNd/s9iQlep0VLHBsKE/I758+HApiIlcAKS4MYG6RWFtqVsM1xVyHkgzFk3ibuzstzhs9wg2R7IiAfLUP9xD8QT/UN4ZxMnfdxuui3MIksDIh0gkSnitI0jDXTs9UBBuDYYdulU8Y=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4251:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4251;20:EAyCT2yVBwr1d6NbVwS8GCcEB0rYbeQcnijh39tEr+JPZWL9VjYOBIQ7ObsqGjtBw2wDUzsglVzx6MgJMQBb5w3hTGhOoAphZz56RCxbElk/TYjuj30/49B1K0U6XRUSxHKG8RcwbLTpwP34VnaIm5pL/VVmQd2qLrRyyCiRuXWiGV5/bLqoJNjhvSwj8fyei5C+uU7Jvqb/DvoAeG0tSLpgoP3VkS2WoJ3XPJCtF8yKn3J9k5GudHQVGX4YdVQSCU1HXMX4q9xUOJtb0JnCzmmU9gpH0qtIqPUa/ayYnQDXVmGqjz2BvzNR/WtYj3wQRfyl2P3bRCXfwlzt+5iZZ9jD+9T0pqxWzRDsv5q0w3DNh15yky7n0/BrX1CP8k2zMPD2d0OvIJufXzKdcbSs3S/NAnrQS7kOue7h6K5ctv8btXy0hBfkrcMAwfhtpj8vTkRsDVQHv3wXiIn7SmH1T1KX5gusAC1bju9axJ4/fv5p6xXQqsGxj8/WXF4nOtTe;4:7207WJ1lx2G8TANIMh9/EBEHuFKTp2J0MOOKQtZrqGgA6qb18Tdxwsy7EBrr8jFvfQjkJGwI8/OzqvNeTW6UKyjWWJuHfhOnO5bZCEvD4YBwxRj5/5oq0fyl5/RyczIoSsW1FnDpzF2vRXahgcazikiL/15Rvuxu25QDNeS3DDzaXLxiQpaOgj8diWOthRjBEsO01m1Ti5t1qY8YDHYlNY4X9zldFc75Js6lkqXdiN9Y2GMZVtcgE+B2V6QLriDs3Bqb274wYyPbRXlz502RUz4g+LXleHIi0sRAv4rtGOScdsqnviEkYoRqDNA7V4D2
X-Microsoft-Antispam-PRVS: <DB7PR04MB4251A5140C8080EA3D7427838B4B0@DB7PR04MB4251.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4251;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4251;
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(50226002)(476003)(47776003)(8676002)(2616005)(5660300001)(81156014)(81166006)(1076002)(51416003)(316002)(52116002)(6512007)(2361001)(86362001)(956004)(53936002)(66066001)(386003)(6506007)(6116002)(16586007)(25786009)(4326008)(486006)(55236004)(36756003)(6486002)(3846002)(48376002)(106356001)(5009440100003)(6666003)(44832011)(26005)(478600001)(8936002)(105586002)(68736007)(50466002)(16526019)(2906002)(186003)(7736002)(6916009)(2351001)(305945005)(97736004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4251;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4251;23:pq7afncJ1jsIR6k6M1WZmeRIQjGS/qMjyTu0TdW+H?=
 =?us-ascii?Q?LjfL51LZPEEGAZ4qQwa9UmRkDdeGjB8ZtN0s+GttfMeMxG8dT73jZ9azKlVG?=
 =?us-ascii?Q?OVzUtKgHInurhjhlnWvyESuhuodcIsP0suUslo++08daIjhXxF0TLWHkTB9+?=
 =?us-ascii?Q?1ElyFl6nJ3Ac5goaEIJmiWxQttajclXw0XDFCfdLMoxbi603IoLQRASOnThr?=
 =?us-ascii?Q?k7Fw2AVnus4nueLECuxNicgRtJ98oylpGwnsDwLno0Wb5+yk0e0Jud5PJP0q?=
 =?us-ascii?Q?iOPyE+osgEMoVScDBHhFsAZ2BZ7Vjd4NSnZmf7nD+hXzedLNxZuaWXsdfPH/?=
 =?us-ascii?Q?MspiDgtF4RQO9EuEBPHHtxf91UXAnA+s89Q3F+XvVpj+KXw9GdTYw4fcmu6G?=
 =?us-ascii?Q?CsSTrDBwrp75rQMgfuB4YE0y89rm1hEbuoVmPgEcbmPmaNYirMKgE42Nv4DN?=
 =?us-ascii?Q?Er8Jyfc7FiHDMTjlUuhCkw0ABrkn53bvy7v8l+omgbVWvfIdNUPAvdETGeIE?=
 =?us-ascii?Q?Z7rjxsnYAWdrtrwDEzTvLO5vUdNEYySK319sfjA1KyheiOm5h7ZNRGFp1fdM?=
 =?us-ascii?Q?jlJizUAnASUGADpGeL5Zi5/ZZ4TJM7fFGPlZ091pgOzQR15931VekJ1Le7qA?=
 =?us-ascii?Q?7T1xvMUrAtEGlbNYqwb40ShEhisMNSjQXLWn/OOhlwVtp3KGpcMPW9XunyMN?=
 =?us-ascii?Q?01lpji5+hKgT8m0PO5gZFUVfjDC+xhyDeHHGNJE2bAnAXBbyqKxXcjR9IXkg?=
 =?us-ascii?Q?M2W710hnywKS9kJpcEeqK/+fMj96qSIspXsy63Uh6fhGVAjKBn4F9w+GaLzO?=
 =?us-ascii?Q?fp17fAKfOh2RPKnMl9ghoVfrvM99eYEDwRj80dasbFwwbTB790KsF8fnzF9m?=
 =?us-ascii?Q?jW9obx+WwyZWMbq+sdCrcvNWKmsa1lhTO8qf/dsCzodh+VX9tLiaXfrjuVlc?=
 =?us-ascii?Q?4ysKtMHu+3s8A6VdqAX09YjaEXF37kN1mLQOmG/UvXEtYLyK4P02ZQX902a0?=
 =?us-ascii?Q?VrqOEItu7P/UF+nsWeL8TGW0Ga4OUh5syFzjVsDjhdLR5EIjSsTHA014C8Hn?=
 =?us-ascii?Q?8lPDGM9F7an7yR79i30AGHTH4v8R6Tz4z4H2z3YV6lzr+ev2V+/zq0b+pbzC?=
 =?us-ascii?Q?e3FDIsFTGUTnRSipKlJ/pqHfIHcwSxPwF2KZEhPula8skinuVzcsdi+VFtRA?=
 =?us-ascii?Q?wZI4VGchlBRW4jqbyBg5vp8PyUURKD0mk9uk0nudC+3BrEMPb9Bnm51cXVAM?=
 =?us-ascii?Q?J6GkcAi/lfYFnITlWnRuaXs7ndWz0oC0L8RvW3H?=
X-Microsoft-Antispam-Message-Info: mo4/YqPmsyPGqmrblqHxXbm5sGgc8lTHtBR2On1ytmMZ5YEwO1FkvbNh6q2o7ogcSRz0ue47UDQb4Q5seERwSHMxtYY/ZsflI0jDwQ3xsCTlvInuxlo1AirvFeo0sDHK+HNNjXQp1j1iZjDo45mP08rizZRHj6HKbLD4aak6DN7cMAfokVhee8nEeSXMbnhRBpi39TMEbU/juk9kOnJQ4MbvuSMa4VDHVJ0eS4YkL8UyvB2bBLa9tHIRgdLl0Eve4+fJzessW6VxS+hJybBM5rQDfxmZne3TW824omCNnMXPQ/SIRTAD8WVKwffgY8Ks+OX56ntsD4vOU0bsukJFHnORBY9zoxm5kPDbH0VXAS0=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4251;6:vRcScrkFLk+tVeb3LoHu5qPeLXgymzyvOor6U3fuT1XWtwLtWRWE9K4nzSdsk6F+zlbU7gQqW6RUSuH1cpLPy1AK+CSgXWryQ8KKbVWd1iRlQdES4bVBwBY4jD35YLpxP9vnWjckwiwx8BXyyxSwBX5dXs6JD7QDDc/B8SYZpl3LK4Ibx4l5BPcZbk5Yma9YDhERqX25jywDGBCGH5ftHuMnAPY0iDu3+aXM0fnQmaIH+jXuRqKg5+fCgB3smTh5k1VUMXuMaoP2878YBI0OHpa4yJChfh7GMmdX18SFCtODLuxi6zG74p6xLYDNdEcAXo5sW2k0jJxnl7e1xfbYatFciitZOMnr3COMbSaBDqgQjJ+aUvubypDMDbvR3cpwG1PQsq2bYv5spGe3SVkxiwqzNSVh7zzhAMXRHNMhz8Kip7vXW0a1Tov+H8CfXfJdlsh43BlBIRa00gdr4AwxLg==;5:kcicleFlx8jlQb1nZSqNRGGMcGstqzuaIqemlFNQGtpvergYAdQkcZHaHPZciecyk37WIrxjkCadqwjmSPsp9TxroAxsEU11xAJbZFi0BoOtFfO2rHsseZvQuPkPU6IP77C7TcGDJVjsrMfNhxnUNYb0mG3Fm3dkX/VSsrzGgEM=;24:pL5KBliM1nhXMje9O6Kzkzu03LH/pzukDR7e3J71eYpuBYu+XVdNOcbLuDARGgWc+cVZUbTS2bOj3DwUjacrZ4IDZaXXatEiyCU13PFIcmc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4251;7:PzK3nPBocf6ReOzH/dO0HzRiH1c5DzcdpLSIEnghKZH99WPGcrbBO3anSxKU4hk78PcC9pkSnrR/QAVNTc9dMdzIo3xy5YBHT5YdoBcRKS5xjmHVNKJbmm6K8NFpJ0Qhx2s4Q0WB+C/0CkpQD48AdRXw1niwI4erxbs7vd62jG9BWl3tIOUp4CA5UqVzIDM01piqrcBS69/JBlOeVvLG9qZaT1C+ZOwrs4PrGdOatgmjXu/WOws63vAZlbfjNfOj
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 14:47:25.3099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a3ddb8-a294-468e-54e6-08d5d9e1674e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused variable 'rxm' from tls_queue().

Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
---
 net/tls/tls_sw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f127fac88acf..727433b37bb5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -990,9 +990,6 @@ static void tls_queue(struct strparser *strp, struct sk_buff *skb)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
-	struct strp_msg *rxm;
-
-	rxm = strp_msg(skb);
 
 	ctx->decrypted = false;
 
-- 
2.13.6

