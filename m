Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57529C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F84F20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="OuHY1HYi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="PGhPzSWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfBVUMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:12:40 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58628 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbfBVUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:12:40 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MK3dgG018272;
        Fri, 22 Feb 2019 12:12:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=proofpoint;
 bh=ubLMrNAd7nvNuje5CpD6D+Pd5U3ecKAguLqX7aIbkLI=;
 b=OuHY1HYiwV4squC7uiN3roxJTW1S/JyslDvG0spuq+goak/faqzjf+R5VUCNsg/dOoem
 pFSoE0Jas9U5lUDdB1LfPSnJreupbtmgq1QKtUALCdRozuO/ZHcBOjeN40xCNeN6SV/l
 QZHlB3AowGtg3h8PdW6lMQVxgb7gUv+wQ4b9K+XrEisZfOUjWAChUHr+F34uNmibsnna
 cAU08rdG3t2cKulWAnM9ckU5GTVKRnFmaWervISHRjnLzEWyaMzwPOLfJzhLaHaG7mVo
 +jO8VBAdQMsT+LF5wNdhvuUDMNfdo20qhkbesyDhYH9EpqiZ0S2hQC7vyDxBwHiiv0m8 cg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qspmmrb3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 12:12:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubLMrNAd7nvNuje5CpD6D+Pd5U3ecKAguLqX7aIbkLI=;
 b=PGhPzSWGcq2B9RjbV4AuAAQHGaftOOadnFGZgf6XgJa7Cn6SuJ8zWyuJsFgTUz8pEnrG4pu8+ruZuDdgcftc8e28kZ6u+znx3DsF82H9Yjg7pXrRiwJj7JJPzuoOQDc3tJ6lFu4Bu231GJShW7c3HKMNc491mpAZ/4tKg8oPxVs=
Received: from BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47)
 by MW2PR07MB3977.namprd07.prod.outlook.com (2603:10b6:907:5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.18; Fri, 22 Feb
 2019 20:12:29 +0000
Received: from CO1NAM05FT036.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by BYAPR07CA0070.outlook.office365.com
 (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Fri, 22 Feb 2019 20:12:29 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT036.mail.protection.outlook.com (10.152.96.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1665.5 via Frontend Transport; Fri, 22 Feb 2019 20:12:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKCQe7031191
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Feb 2019 12:12:27 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 22 Feb 2019 21:12:25 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Feb 2019 21:12:25 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKCPVk019412;
        Fri, 22 Feb 2019 20:12:25 GMT
Received: (from pthombar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1MKCPTN019400;
        Fri, 22 Feb 2019 20:12:25 GMT
Date:   Fri, 22 Feb 2019 20:12:25 +0000
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>, <linux-kernel@vger.kernel.org>,
        <rafalc@cadence.com>, <piotrs@cadence.com>, <jank@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 1/3] net: ethernet: add support for PCS and 2.5G speed
Message-ID: <20190222201225.GA15633@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(189003)(199004)(36092001)(336012)(426003)(486006)(186003)(26005)(126002)(476003)(246002)(8676002)(97756001)(86362001)(2201001)(2906002)(46406003)(23726003)(50466002)(47776003)(316002)(106466001)(105596002)(42186006)(33656002)(305945005)(7636002)(356004)(5660300002)(110136005)(16586007)(58126008)(87636003)(26826003)(478600001)(8936002)(1076003)(14444005)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3977;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afa3c3fa-bfc8-497e-0c47-08d69902124f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MW2PR07MB3977;
X-MS-TrafficTypeDiagnostic: MW2PR07MB3977:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3977;20:DoU8TmOrbmcG/c3MdyArC8G0295sftTQHu4hdBGF3pMJMA+czejzji6sioyNIQfyq52pyLX2H+NmMio9YViWdB2dkADZd65+9OPS4NNkWluLM0dxdVnpwVjIKxLwWZBdfUto8hagGNbc0T14o6wyi+3BSPLAg2HVA9zmnSDuvtaFBRoi3fMvFB3NZlqBgLm006kuW9jyNr7UHYmLaW8atgc3C8aknOt1/dXeWtdT0Zhp9feY+G1kKMEB9hXkc4lsBSoP2ZzJKZsT/OjCp2O1NSgeN9BU+6wHQU7mAZkCtcAqcYUWmhfMgqmuTQgIfSik1Gc34nDFdeCfHyVZPmcTEoyl7XMdAspoM0nFum5Bqtz6KxtJSu0Lv9AFVV9IBi7tKNdhEhyAPX3Ql74qCN9jctSecNw+X6iYZeXR0zu6ixd91TDFRlHdOEVS4FQu9/mvnV3eDbWWIbSwOD83HddLa5AHux9xKBds5mlTXiYPXvLI0TC++V+CH4QMAeC0402m
X-Microsoft-Antispam-PRVS: <MW2PR07MB39775AF3624B14C4E698AE92C17F0@MW2PR07MB3977.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09565527D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR07MB3977;23:juexpUtxnp+lZGeRgKSwQ8RjEe6rlzZ4qL/3usW/f?=
 =?us-ascii?Q?YokMpFKj0GUTXs4gmmi1GZi9iFWtv42ttA2tbPvgqKrt3d9DOu3nTteMoqBB?=
 =?us-ascii?Q?taR27OfVRH4e+In9EFvdsI9sCplwBpaJuhE9n4vL0fAwHbGhfc0gADzCR4mT?=
 =?us-ascii?Q?hRFBIPbyyVUXvhoq+Vjlfe6mAfP+wSIoPIhtjJHo1FOXz2VbAcNVnT/M6uxx?=
 =?us-ascii?Q?vMC82u+nn0Jvohx/Rno+9cEbBED584isFw4vjIJzEI+In+GcQUh83xKiJrg9?=
 =?us-ascii?Q?PqvdvPu/QbBT634PI2QsDpoT2VFezdEOFN102QgFG6Sb1YMwX9PeCAsKt1Dh?=
 =?us-ascii?Q?ePCId55FzFVCpHj1c2mJvrkPCiRo1Bbm4UN/pb5zTR1f8GbFt8izEyACB8oj?=
 =?us-ascii?Q?jnJZYLVC+Y9Ql8RF57Bc3o4mbkg9BYuYgm70DvnQU+ZEnEOQ4BeLy4qMr3jQ?=
 =?us-ascii?Q?8DfAplx7P9E//BHT64kibmVaDcLYNAV1ZwmVJSqUOd05B/MmV8xnvLat0bHX?=
 =?us-ascii?Q?NU3hKBQUcy6qaP5PFQTn+Xy0RrkmeURxShpRf7w1ULx4Yl6UKY1oJw+GUKjP?=
 =?us-ascii?Q?cW2HAUYWLYon8gwh1lUZKrhSZMxspOnUvd/ylMGD/6e6JlVuiNXECBArVzxo?=
 =?us-ascii?Q?q2EZANAaXVI/JJlSahaLrK5EuPQ35sWOw9kQ1E2aXJdOKGY6On1YQhZ6D0l3?=
 =?us-ascii?Q?SXxlwpcNfkR3pQq/sb4ZKm4XZTFd0menHOmtMo3i1avwtfBPNBkRlWKDKvYY?=
 =?us-ascii?Q?3XmIJZaR8mQyFAe3XrHlWIN9c0jiu48BfccLSS7EoxH3vitLfGKMP8/Hi+Gj?=
 =?us-ascii?Q?g1ok5qbNiV9iNkY+gTlMKBGQ+BWi+is8Bv/vIg6KWveZOycNW8e1SjP/fleJ?=
 =?us-ascii?Q?hlX9OUEPU9DE47/vI75qQEa/tvnOKyc/l2XiSO6L5c6anYZXGma2kfJr/TsH?=
 =?us-ascii?Q?fTO8xkugz+aDVajnLA2VoeaGn4jDYeJd8yGe+2+SOmeGrxKhosOZONOe3GxM?=
 =?us-ascii?Q?MkmglVWqmWtplH6R0DYK0GhUeFlhRmq8bAbmHPm1CywXZ27zWuD5RmgW6KHf?=
 =?us-ascii?Q?LjtrKQ=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0KXIUDXkRiKxWAbX2JbtYcEGkvU4U7ZKOfBMPRIWgs98sD7OT/B/suRp1Kn7q7wjuwGTVNjX8Hrw+JWoXIPM59qZPQZSNIhbzh59fYifIbzcxxzgL7CVehvZkTerIbehw40arHaxilH15OBFlyAZCT3XzkgGF5TP/M5pWmon5Um01LFyucoFnas6xvF0/Q3WN/Z4dxXhB6Lvwe9/BFW+4kE/0zN8XfNf2pByI9fxXbzXSRMj48zpDehv36v8z53IFtuHFCGh24tu1MRQvEmP0z5jS7o8/1AF1BVdM/Qm2/S/1yn5e2JuslvHIQqHnBIdtbaW9uUhGWKWyhdBgWTZQkjLutNe+X37xH2PzBZSMfLvZstBiFdRZcN8lxzFcFiqcJ4VGWGTug9TC0ojTkoAi8uCflkHdPlyvj7kM4HyQr8=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3977;20:s8vsdACoHpCT1MS5NduROFP08JTeyxjYN93o60VWrmRpDdyWIqYKvnHLw/LoZ+f6XI3QQUdwVsxFSNvqpBr3WbNVpzB1pWVYtcbUnFJFQMU4KIdHSvYkumR/G8YJPVHY62HKKXFk8NPsjH/Y0+11W5tWE1QYeUEW2eRuIyGL7h6WiAPlQU9CVPiV2+JSZosqHUixihuQ/v5hejZwaUgoAjOTH9fyKxxMLRVuRWH1cBfI4OWuCEt6rQwFxnXJ52SE
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2019 20:12:29.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa3c3fa-bfc8-497e-0c47-08d69902124f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3977
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for PCS (for SGMII interface) and 2.5Gbps MAC
in Cadence ethernet controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |   20 ++++
 drivers/net/ethernet/cadence/macb_main.c |  154 +++++++++++++++++++++++-------
 2 files changed, 140 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 9bbaad9..bed4ded 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -79,6 +79,7 @@
 #define MACB_RBQPH		0x04D4
 
 /* GEM register offsets. */
+#define GEM_NCR			0x0000 /* Network Control */
 #define GEM_NCFGR		0x0004 /* Network Config */
 #define GEM_USRIO		0x000c /* User IO */
 #define GEM_DMACFG		0x0010 /* DMA Configuration */
@@ -273,6 +274,10 @@
 #define MACB_IRXFCS_OFFSET	19
 #define MACB_IRXFCS_SIZE	1
 
+/* GEM specific NCR bitfields. */
+#define GEM_TWO_PT_FIVE_GIG_OFFSET	29
+#define GEM_TWO_PT_FIVE_GIG_SIZE	1
+
 /* GEM specific NCFGR bitfields. */
 #define GEM_GBE_OFFSET		10 /* Gigabit mode enable */
 #define GEM_GBE_SIZE		1
@@ -463,6 +468,8 @@
 #define GEM_IRQCOR_SIZE				1
 #define GEM_DBWDEF_OFFSET			25
 #define GEM_DBWDEF_SIZE				3
+#define GEM_NO_PCS_OFFSET			0
+#define GEM_NO_PCS_SIZE				1
 
 /* Bitfields in DCFG2. */
 #define GEM_RX_PKT_BUFF_OFFSET			20
@@ -648,6 +655,19 @@
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
 #define MACB_CAPS_MACB_IS_GEM			0x80000000
+#define MACB_CAPS_PCS				0x01000000
+#define MACB_CAPS_TWO_PT_FIVE_GIG_SPEED		0x02000000
+
+#define MACB_GEM7010_IDNUM			0x009
+#define MACB_GEM7014_IDNUM			0x107
+#define MACB_GEM7014A_IDNUM			0x207
+#define MACB_GEM7016_IDNUM			0x10a
+#define MACB_GEM7017_IDNUM			0x00a
+#define MACB_GEM7017A_IDNUM			0x20a
+#define MACB_GEM7020_IDNUM			0x003
+#define MACB_GEM7021_IDNUM			0x00c
+#define MACB_GEM7021A_IDNUM			0x20c
+#define MACB_GEM7022_IDNUM			0x00b
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f2915f2..4f4f8e5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -361,26 +361,50 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
  * macb_set_tx_clk() - Set a clock to a new frequency
  * @clk		Pointer to the clock to change
  * @rate	New frequency in Hz
+ * @interafce	Phy interface
  * @dev		Pointer to the struct net_device
  */
-static void macb_set_tx_clk(struct clk *clk, int speed, struct net_device *dev)
+static void macb_set_tx_clk(struct clk *clk, int speed,
+			    phy_interface_t interface, struct net_device *dev)
 {
 	long ferr, rate, rate_rounded;
 
 	if (!clk)
 		return;
 
-	switch (speed) {
-	case SPEED_10:
+	if (interface == PHY_INTERFACE_MODE_GMII ||
+	    interface == PHY_INTERFACE_MODE_MII) {
+		switch (speed) {
+		case SPEED_10:
 		rate = 2500000;
 		break;
-	case SPEED_100:
+		case SPEED_100:
 		rate = 25000000;
 		break;
-	case SPEED_1000:
+		case SPEED_1000:
 		rate = 125000000;
 		break;
-	default:
+		default:
+		return;
+		}
+	} else if (interface == PHY_INTERFACE_MODE_SGMII) {
+		switch (speed) {
+		case SPEED_10:
+		rate = 1250000;
+		break;
+		case SPEED_100:
+		rate = 12500000;
+		break;
+		case SPEED_1000:
+		rate = 125000000;
+		break;
+		case SPEED_2500:
+		rate = 312500000;
+		break;
+		default:
+		return;
+		}
+	} else {
 		return;
 	}
 
@@ -410,30 +434,49 @@ static void macb_handle_link_change(struct net_device *dev)
 
 	spin_lock_irqsave(&bp->lock, flags);
 
-	if (phydev->link) {
-		if ((bp->speed != phydev->speed) ||
-		    (bp->duplex != phydev->duplex)) {
-			u32 reg;
-
-			reg = macb_readl(bp, NCFGR);
-			reg &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
-			if (macb_is_gem(bp))
-				reg &= ~GEM_BIT(GBE);
+	if (phydev->link && (bp->speed != phydev->speed ||
+			     bp->duplex != phydev->duplex)) {
+		u32 reg;
 
-			if (phydev->duplex)
-				reg |= MACB_BIT(FD);
+		reg = macb_readl(bp, NCFGR);
+		reg &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
+		if (macb_is_gem(bp))
+			reg &= ~GEM_BIT(GBE);
+		if (phydev->duplex)
+			reg |= MACB_BIT(FD);
+		macb_or_gem_writel(bp, NCFGR, reg);
+
+		if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII &&
+		    (phydev->speed == SPEED_1000 ||
+		     phydev->speed == SPEED_2500)) {
+			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED) {
+				reg = gem_readl(bp, NCR) &
+					~GEM_BIT(TWO_PT_FIVE_GIG);
+				gem_writel(bp, NCR, reg);
+			}
+			gem_writel(bp, NCFGR, GEM_BIT(GBE) |
+					gem_readl(bp, NCFGR));
+			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED &&
+			    phydev->speed == SPEED_2500)
+				gem_writel(bp, NCR, gem_readl(bp, NCR) |
+						GEM_BIT(TWO_PT_FIVE_GIG));
+		} else if (phydev->speed == SPEED_1000) {
+			gem_writel(bp, NCFGR, GEM_BIT(GBE) |
+					gem_readl(bp, NCFGR));
+		} else {
+			if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+				reg = gem_readl(bp, NCFGR);
+				reg &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
+				gem_writel(bp, NCFGR, reg);
+			}
 			if (phydev->speed == SPEED_100)
-				reg |= MACB_BIT(SPD);
-			if (phydev->speed == SPEED_1000 &&
-			    bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)
-				reg |= GEM_BIT(GBE);
-
-			macb_or_gem_writel(bp, NCFGR, reg);
-
-			bp->speed = phydev->speed;
-			bp->duplex = phydev->duplex;
-			status_change = 1;
+				macb_writel(bp, NCFGR, MACB_BIT(SPD) |
+					macb_readl(bp, NCFGR));
 		}
+
+		bp->speed = phydev->speed;
+		bp->duplex = phydev->duplex;
+		status_change = 1;
 	}
 
 	if (phydev->link != bp->link) {
@@ -453,7 +496,8 @@ static void macb_handle_link_change(struct net_device *dev)
 			/* Update the TX clock rate if and only if the link is
 			 * up and there has been a link change.
 			 */
-			macb_set_tx_clk(bp->tx_clk, phydev->speed, dev);
+			macb_set_tx_clk(bp->tx_clk, phydev->speed,
+					bp->phy_interface, dev);
 
 			netif_carrier_on(dev);
 			netdev_info(dev, "link up (%d/%s)\n",
@@ -543,10 +587,16 @@ static int macb_mii_probe(struct net_device *dev)
 	}
 
 	/* mask with MAC supported features */
-	if (macb_is_gem(bp) && bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)
-		phy_set_max_speed(phydev, SPEED_1000);
-	else
-		phy_set_max_speed(phydev, SPEED_100);
+	if (macb_is_gem(bp)) {
+		linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
+		if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					 phydev->supported);
+	} else {
+		linkmode_copy(phydev->supported, PHY_BASIC_FEATURES);
+	}
+
+	linkmode_copy(phydev->advertising, phydev->supported);
 
 	if (bp->caps & MACB_CAPS_NO_GIGABIT_HALF)
 		phy_remove_link_mode(phydev,
@@ -2217,8 +2267,6 @@ static void macb_init_hw(struct macb *bp)
 	macb_set_hwaddr(bp);
 
 	config = macb_mdc_clk_div(bp);
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
-		config |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 	config |= MACB_BF(RBOF, NET_IP_ALIGN);	/* Make eth data aligned */
 	config |= MACB_BIT(PAE);		/* PAuse Enable */
 	config |= MACB_BIT(DRFCS);		/* Discard Rx FCS */
@@ -3255,6 +3303,23 @@ static void macb_configure_caps(struct macb *bp,
 		dcfg = gem_readl(bp, DCFG1);
 		if (GEM_BFEXT(IRQCOR, dcfg) == 0)
 			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
+		if (GEM_BFEXT(NO_PCS, dcfg) == 0)
+			bp->caps |= MACB_CAPS_PCS;
+		switch (MACB_BFEXT(IDNUM, macb_readl(bp, MID))) {
+		case MACB_GEM7016_IDNUM:
+		case MACB_GEM7017_IDNUM:
+		case MACB_GEM7017A_IDNUM:
+		case MACB_GEM7020_IDNUM:
+		case MACB_GEM7021_IDNUM:
+		case MACB_GEM7021A_IDNUM:
+		case MACB_GEM7022_IDNUM:
+		if (bp->caps & MACB_CAPS_PCS)
+			bp->caps |= MACB_CAPS_TWO_PT_FIVE_GIG_SPEED;
+		break;
+
+		default:
+		break;
+		}
 		dcfg = gem_readl(bp, DCFG2);
 		if ((dcfg & (GEM_BIT(RX_PKT_BUFF) | GEM_BIT(TX_PKT_BUFF))) == 0)
 			bp->caps |= MACB_CAPS_FIFO_MODE;
@@ -4110,7 +4175,28 @@ static int macb_probe(struct platform_device *pdev)
 		else
 			bp->phy_interface = PHY_INTERFACE_MODE_MII;
 	} else {
+		switch (err) {
+		case PHY_INTERFACE_MODE_SGMII:
+		if (bp->caps & MACB_CAPS_PCS) {
+			bp->phy_interface = PHY_INTERFACE_MODE_SGMII;
+			break;
+		}
+		/* Fallthrough */
+
+		default:
+		if (macb_is_gem(bp))
+			err = PHY_INTERFACE_MODE_GMII;
+		else
+			err = PHY_INTERFACE_MODE_MII;
+		/* Fallthrough */
+
+		case PHY_INTERFACE_MODE_GMII:
+		case PHY_INTERFACE_MODE_RGMII:
+		case PHY_INTERFACE_MODE_MII:
+		case PHY_INTERFACE_MODE_RMII:
 		bp->phy_interface = err;
+		break;
+		}
 	}
 
 	/* IP specific init */
-- 
1.7.1

