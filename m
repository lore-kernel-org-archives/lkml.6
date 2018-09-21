Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19677C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF776214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="oE2gqaDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF776214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbeIURn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:43:58 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:38762 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389914AbeIURn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:57 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:22 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 920E67318E;
        Fri, 21 Sep 2018 20:55:22 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="291574205"
Received: from mail-ty1jpn01lp0182.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.182])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:22 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5nO3RxfLKtmucLdrZPX8kuokwzGPizW3J8pUBgJ2qQ=;
 b=oE2gqaDhUvYwI6yhVf4/RZgudG3zbW0OC4St3coRt0F7iQBeWOLm9erV9u4UvSYTSGMPB1ypfWAQjD4dqtdxAqTEVB9xG/n9vdM9B5sGcHCvAxAfvaVNW5w7m9CBeUbpO8PIbBzW4qgZmMC+cfD7g5Jeigy8UHWIjyI48RsEXmI=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:21 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 4/8] phy: renesas: rcar-gen3-usb2: Check a property to use otg pins
Date:   Fri, 21 Sep 2018 20:53:20 +0900
Message-Id: <1537530804-19399-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.144]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To OSBPR01MB2296.jpnprd01.prod.outlook.com
 (2603:1096:603:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcae63b5-26c6-4c84-8e35-08d61fb91b97
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:SX0Ih9u8hDgFzXy/Kp5xSIiAqf4EtoWjqwylKQAhdmOMZ0TF6riUz1JWn8aGFxjDuiGzgbC1A+DUzSe2dlKGJzPd54ac8pnqLsr0rbSWVau47C/0DFVvywI1aBQpav+z62ckotAHrGYE67mYucATf2USxDL/cFuwHHTVIJD5TrOg/OdmVy0YiabBWsDLek7U8BeMM30zyZXXfaB7WdF4DIgcf3e4HkojrodAYf/8YWhOWMOsv3rgKfwb4mtBNqaS;25:YN8liK7ehKXp6qdXBHdNAy2tGkM/wdFaxmYIbnHsm9FSfPBmWhYn4SyQWYftMROgrno6rNip4jFmE3D5L38zU3/zbrrlm2HxslFyVUH4PS3lwFJotAx0eCLejAbzwwgMjldHUCvNk79XTPycKFyKRlYCanB6aUZe+mB8JI+94BFBTHIKVUzp0IojCAuYo7t1HaOe2rMVogHgpFS5AVRSPXKXshd6xvdFI4Aibw9MFYrzvvwP1cuCGdVFTa3RQN0wXaQ9Tz4SmlzsBWk9fYXT3iOGZv8bKtmnGybOCsNoIw0GXJNpIszC7n1Y139BTxiuVr4zN0mDeS4sSUO9U2l2mA==;31:98r4rqRgQ5AFcv99JvoItWzDs45pSwVL+Hw0n/s8H/c0bB3ILjpH1AbvI4GjcRm00um1FPqjX4vtiHpDfX6COtr/izgwUEEaDDr5mqrCH8e4xOtU5ZGpv4xNst6jD2tnoYK7CigxamMGRX9ZJTeyBAiAhTYwG2LDPx90W/fRwI6wv+xZYdFD042tG4OnfBk6VdOD4j5ZEMDk7Vw1+lw+TGiaRP537josBDN0rdUxBps=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:9Yt45Qm812viIJ9JPYDftqPSzMeNPsMubFXsoDrVDlFjQwQp2vC2im6h9qHq50AKpbmtZ7HoOD4UJdZXyvlM7fjWYPocGVRUWPDOuV27V6QIHvjMDD8jp5qIbk6urQfS2h8ZXNw8Mtyr9hOdCcDsqW6DoNHbGy+3YVSAm7Dg5KQSJRXcI6LCi1lOck8YlZ/jqgORsRqPp+KPqfuFFhaoalipVNlYQz0dWbd/4mkQvjo8p+UeQ09wETMvJXF/dWl/vk8mSOGJp3km+HduZepHEUEJLS4a0kWlYDIUaLMiMEcJyKYieeqhiu6BNHBPKBCSuiZRKxIJJ3ENnF1PRSCM562p4oXMXfk//KGU26rolebR1xGy34/tlb7/IOKdvvoUZoQAXXjOzs2G3OmqYlP6DF2Bdg3GYcoHlwourIYhIcu8wleIsa7kEfKQvQwySSNJzgaN8ik3CTAjzfjwnqtO4OGs/hKmTTBDaw5ivyg2qRQXk3Fhcc8qgYPh5yrxMSAz;4:LUcbJ0ijR2D5xCH1LS2UgfCljaHKeBhsodaCu1A2399ap3P/mgj3y57XUHnfgJQwXPA7yZpqbm1Rvftwe/nNVV4dMjNtYzV4Tx6bPC5cBzUJ2gHr3YcggXQwpkITTUahzH6L7nyKJ89bQxVBJEu5zo1jKbrWE6GsV4a1yOlq6acqPtKaN0qVthPUT+6FPuFcpacKrMBVui7B6ArsY/i6fpf74V8Jdv+EpK41RD38UeHaWnQ9h1LubNsLnRlB8rh5FK+SWqqGThzqEMGWztbsHg==
X-Microsoft-Antispam-PRVS: <OSBPR01MB2296E0F40D4839D3AEBDF178B8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:+uZAJ/rnDKrdKW43YOJVyB63LLTXStlXg6AGvzZtx?=
 =?us-ascii?Q?GPfXpTB/3fscu+/Ckim2qN1tkuBpu4vLyyhdO+7V4L+zW5nbREIjOa/DGfh7?=
 =?us-ascii?Q?5sMBjpKhKDHFgVuvgUnzBDyc9J7sYSlQeVasvflrWZSUE/2dao97OcmYpMB7?=
 =?us-ascii?Q?bhPaIC3e3YAzG/6ISQcFC7t4AD4Niw8cZVSNIIj4AZ5bMxpwY3ZZWA+jpfPB?=
 =?us-ascii?Q?GdfSHSnTBZr0e10G0yz40sNB9eNJ8nd2LVHeQ5E/lCenqMHaOohmMvABiLIE?=
 =?us-ascii?Q?NTU964sLFCqxkHxt3RR1UjoRPZcekkZrrcEJkGLoyk807csJpRJX/jv8yFcE?=
 =?us-ascii?Q?sr0jpk7rwzZh5kwxw4vi0dafBW9wfaoLG9NUAKLbwfrZIuZCCHm4+d+KToZr?=
 =?us-ascii?Q?DApp+2T28zu1Ma+dTc5GXXOF50oeuFYvLNyqvnukcEye8FGy4WJCzZZdK6pA?=
 =?us-ascii?Q?9uWNtwrZpna3cSf9tOKkrC7RITipWhGh4Aq1blUFbinIHx0tz+1R6LSit/OX?=
 =?us-ascii?Q?v5NKlANl5/N5wxErVyVl/F9P0dxltWLY833VBe4dDHSZiz57FcHvgOoWLtxU?=
 =?us-ascii?Q?oeUIztUEZC2V1bCC0ooFaQTVCH3QSCRgUi36P37iTHSGCQlf5M1NSPU94C/e?=
 =?us-ascii?Q?9nftk2vNkmVlL/SdVarPaOLdqvuf5zY/HHhhA00lUdeRj18agFJP2hB9dWLp?=
 =?us-ascii?Q?9roKtlKx108wVYMV+X+YszBIQuqDK0fqMZei3SIpjWMRJSfSydDiuLswEiI6?=
 =?us-ascii?Q?ydYI99NuwDjlo8IcyVkQeqoqcKgbtzzMdJKmTIScmzD6m3oaW3RpncfFRKMU?=
 =?us-ascii?Q?q3AAQd18/+rlyZN29KNvCeHyAsvjsG3qLEjcKNLbzck8i0EqTqPyTyt1Uk9F?=
 =?us-ascii?Q?PyIjMo3mbilQBO0dmCt9LvdbXJDlHxRKd1wJ5ysbqL5l+5TVP1pCAvM/isRV?=
 =?us-ascii?Q?3DdMn8d3wIjgbg1cufGv3484gDNRLHvhky5BtTA0sdLiDy/m6Ko+2yl2qShu?=
 =?us-ascii?Q?RUSAM81BjXFuYGDxy+VG+LKoQ1zDWPceqpdAMXGl0lzf1BtZKIIm+TxiCBgI?=
 =?us-ascii?Q?lqHfMMlxj0PAcVwQBFGsvu/EpbKkHrSqVMqpV8QD7M+45V8Y/Ie3Hlh+PIcL?=
 =?us-ascii?Q?I9Kyk9rc0ZQ7wfe/mmw5Kvf4oej27GXFdSDBcaq1kR5xCXYa8DcefFFHWU13?=
 =?us-ascii?Q?yHvb0CJGQ4Gx32xsJh9NTvBL0YcNIpTJeeGWEYmHY4ryURh/5jjNdQeEg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: n2o9K4I+Jv28U5gMzxtlz+twMz/Tt/hVa4QTeuZ9TJ8iDwgGwV3MrhS7xzaSeCOyutj/V2FnZfYC4s+n37af0ipPVbDcdKM2yN+UqtP1y7mIBya2Tsbh0COyOLKtmsUJVewuuvT9Pn17+tvT5cX1R8JWbwVMyAHkGtg79trSKq9NSe8f84S/+KOJ3UmBRJPGl2qFz6KOdm4+lgLfy1sdAtr105W+PkSlwZaJf/F3rtrofwjDFd+ZwbiY/O8ppRXacjMSqIX5/N/Q62ZjxS2iWHKHEauaAD5xXLJKppjMrskAQcDhfqD2HDGjpWuLqVnHRE0coNk8wbSxTtmX1uhpkpigaLZ9tBJa0A+tmtoSRSE=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:Oj0cCT/d7qUqGFcJR4PODgXh3bYxvmGCwK3Z8eTveojSlhdMOdfKyuuzdeWpxx05Ogt/CrYxmOjIexchhBzwWqUpKFoRvlVjoMk0FN2FSypXZNQjDzWQ5v4M08zhlns1wrhrIVwYAB23qNhrgDZ1YHyXgeaS6e1O/LC4PGXVEidDHNf1NHKYRg94GnDVVMdTVyILusYrFgjSbeVdak7G8UAwxK5reSIXu6N+fkgk+Ai65pgADnPATC94Pp5Sa5jVhM0PSCEL/I4ApWJ5CqClega0JFEabrAq8HNrmJWSPOjvUSEhrSHjCgTaWQ+cTL/+4YjCPzgrIdoJ2fipxvWM+EgXEQbW6LbImwt2fh/WIDJDIUE38RtFYzjvuUFDdXAst0LbveSjYbkaRzqzJijFcbHM/1lIF4TUs7QXbFOQV4c/QH65XIp3wa4iZHScFzuYE8F7khcLADFmz6mS/cCZ5g==;5:bNW0nZKytutc1kMcRogi0/6athGppsxEKxEtCdxGZRC1qSIZBnEX2u7TDaw1WcUkgU0GxlxsJv1hQ9ofs5KNwvCs1AmvnDUqYjYwwGPjJIIwotbSCEa1GXN9gwwg2AglwcbzEnpCYBK2hkmCb+OyXBDTKOSigpPeL5Dzw1TWrm0=;7:GvimLyGH50RZ2dL2D3b2/wagrT8nO6LletmvNXgpwG4QPjQTVUcNGJ0YlqM9bPY+mgkbU/HBmD+fp/OqBQycK3oWTZeoRR4TAq7/ehtQzn14J/GEkKU8ziAef7dyVn6hncCGumxXJDMzMpQ+5vLznKHW5CyedjNGCohAgr1YtK6yEJqzx4M36JqG2T5Ex1Z0pLsMNaJzKBDB181NfXIHoDdRLmbeD5qK/ZArJy4jRCW5qWBGrU6lyfXEBKhaSN1Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:dxcSCH0SWjeQAOt2J6ZJisymyYO9ITF9JF/HS0RhLYH5YpCGqh5wCcZ1l4LRJDAioS/+Okg0kTXZAWvEk5/vcJylWB1ipzQrGQvP/awI1Gz592o8OEy2e2wPa83spgYGSUzePA9LtIw/g5eE6YSK6U3F8q4RyJ6vZj9YQlHuYTg=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:21.0460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcae63b5-26c6-4c84-8e35-08d61fb91b97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since All R-Car Gen3 SoCs have dedicated otg pins actually but
some boards don't use the otg pins (e.g. R-Car D3 Draak and R-Car E3
Ebisu), the driver should not choose SoC model base by using
rcar_gen3_phy_usb2_match_table's data. So, this patch checks a
"renesas,no-otg-pins" property to set the "uses_otg_pins".

Note that since r8a77995-draak.dts and r8a77990-ebisu.dts don't have
'dr_mode = "otg";' for now, if we apply this patch, no behavior
changes (the value of "uses_otg_pins" is false).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index d69317e..856056e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -78,8 +78,6 @@
 #define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
 #define USB2_ADPCTRL_DRVVBUS		BIT(4)
 
-#define RCAR_GEN3_PHY_HAS_DEDICATED_PINS	1
-
 struct rcar_gen3_chan {
 	void __iomem *base;
 	struct extcon_dev *extcon;
@@ -385,21 +383,10 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 }
 
 static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
-	{
-		.compatible = "renesas,usb2-phy-r8a7795",
-		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
-	},
-	{
-		.compatible = "renesas,usb2-phy-r8a7796",
-		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
-	},
-	{
-		.compatible = "renesas,usb2-phy-r8a77965",
-		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
-	},
-	{
-		.compatible = "renesas,rcar-gen3-usb2-phy",
-	},
+	{ .compatible = "renesas,usb2-phy-r8a7795" },
+	{ .compatible = "renesas,usb2-phy-r8a7796" },
+	{ .compatible = "renesas,usb2-phy-r8a77965" },
+	{ .compatible = "renesas,rcar-gen3-usb2-phy" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_phy_usb2_match_table);
@@ -445,7 +432,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (of_usb_get_dr_mode_by_phy(dev->of_node, 0) == USB_DR_MODE_OTG) {
 		int ret;
 
-		channel->uses_otg_pins = (uintptr_t)of_device_get_match_data(dev);
+		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
+							"renesas,no-otg-pins");
 		channel->extcon = devm_extcon_dev_allocate(dev,
 							rcar_gen3_phy_cable);
 		if (IS_ERR(channel->extcon))
-- 
1.9.1

