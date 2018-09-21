Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A87ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F98621531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JnBxFWMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F98621531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbeIURo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:44:28 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:20694 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389935AbeIURn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:57 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:24 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id EB8BC7412F;
        Fri, 21 Sep 2018 20:55:23 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="293141293"
Received: from mail-ty1jpn01lp0184.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.184])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:23 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdukJd4V361FIUqxH4WVJQEkgQaJL12EJaMI4E4dxfw=;
 b=JnBxFWMjB8JoVFhAAOasEqMkONcdyybUE9iC7OnTuUGM50m2HLFmljzNCrKtU+WJ2ndTDZ5Cj8jZxItN/HSWTaYgrVOTC7eWA+0/8AD6oj5mPTb4UeN7urvCgnNtHW5KBgCcLQWjXgze0yajsrI/mv9ZDEdVrtvcFvV4e8DvuR4=
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
Subject: [PATCH 6/8] phy: renesas: rcar-gen3-usb2: change a condition "dr_mode"
Date:   Fri, 21 Sep 2018 20:53:22 +0900
Message-Id: <1537530804-19399-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2a074194-3c0c-4a1d-9309-08d61fb91c0f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:j/4+9PLscpt4lGqMbMHJBanOajxDXq657N+9VDObzvC1TR2htRzT8UTBrmuUYpNqzniepWHtXVFcTGvyIyMSwuJiUjFzvGpy+lYyHrRvxvXfJcR8hZA72htl1nsgfR2T2/v+GgyHBDV+/6YWsD7x4gXudUVSbkmhxndnEZ48J2ZVaiXkZvHhwWisL0TE4jLByOr2hgwzOHfSx9D/E6q6AYsjlzkgTnaBqo3j272TU9LvPdpP45kCDYsa5ipt6LUu;25:G7s5h/+Z8f39JX7VERBwWPAkQ97WGGQKxapPe5ODCcpf0sQPCGPIr4OKg8Gon2KyUE8xj/yufWbnA10m2adpV+Ic1brRsBE+p67N/k67spcZ6nMnETCZpQkxy2lvghACD6wMSLXiTM+IBVYVQBLtP9eSNHZzea3zwEEK+4B/AENZpR9ic1GrGEUQxqUbg1Z1pXRanGxbx7mgViuHwbfvUfapSIa7hSC8ab8EqCvXHBufm/FmaI8ZUg1v2wxZW70Etkwb8rs/HP2mJyHeZmaJbgLiSoks2NUwOAqWbUMI2Pzzj2NpJSdwiG0koIaCCOw09+JywgKrxB2oFkHjpnkNtw==;31:/Hg6wqhOljqHvT/KuklzSEDUN90OVu2NBL2F1kcMXMP8k5g11a7ZvKaEHLbFuTyF5M3TpG5g1N3Xob+F56z7nkhcb1zWwq4LP0dzIWDP3CP42Dbwu7JHuoSK4p6J1rJ+cD+GHG+WW8oNS/d6N1JGP1uaZ5jqOWnzIPcJ1tmLecXl0pvQiMaf8VsM4GweX7SWEkJrvpJy66LqBCpMXznUglxODl31hhab4+SKtjEjJkk=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:8xWRo0gLOP7XKx1HJvrTEKDjVjikMWACpi6zs5STI2Jm3ANGokXucR2a27UsuEAUyRUeFG/vNkk34F7u+a2UjoOK+GXASvhSUieLBvqFGDlhGDKoQUxRY7PXOQx9PBXK99KcjZxR3Bx5T8oX8/3eavvENK+QZTjvxAaFg1ZyDsrFCdeQPPAyOyYyKiJZS73dlNKpq5YwCcXG/HqmQxtKbl+dYYF5+HarFAn4NZhcVHydEzxF+jBF8m25EI1XlYUFE9/24oECWaXM/UFx9R/b15YDGL5qcvDsrX1Fx5d+lGQYnWDnLUPMobXRcDE8/Gd5Zxdl7Um86vtZRyZVTnfl8NoDjZ5/96AJFeJqJTz4Mb1mjHY6mmy3iy8U1iau/vvqqwtEPadqXLb649QcLVSAxblLzgxqVNsIWIoNRRf7uu7pehJUBHatbihJ/H4om9g9SLjAUC+xTBudNt5xgP1y91NjjX1OOhfY3NAL6VnV8lWUW6DKlS0TS2PfjULV62/q;4:BhGsn/BMQwbkkpVRXg7cNGvVCEQGgGqYquNKYkaflfHJ/vEVq8f/KvAVDa/jOZjQ7cSyowuJ7W+pNpWGw+A3kViVNFMYp1EFO1ePqEnpwvawgM/HLbrMwdrFz8wcElVX3aniz2Fpb4mztQElTnIAOxwLOZ9TUl2jjuar6c1Ib0qzuJ00VVFOEcwJ6rL89eUY1ZpO5UueNLgd8rRPKZgsn1ZAVa7v8We0AIkBfTeZFz5Kg5lvlTr/e/Gg1GXqAXJ/nzWtMzJRJ9bTMmW1jzCXuA==
X-Microsoft-Antispam-PRVS: <OSBPR01MB22966C4E8FB2BEA077511B24B8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(14444005)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:bWfgLKQ3PpYaIM3/rqmKIo4dj//efVmqNe4GD/jeg?=
 =?us-ascii?Q?PSG9Ftn1E8zC5jsxrQnsZyI7wP+7InrpoTDAKmGfRGQZV8pTxLFPGG6h0eMt?=
 =?us-ascii?Q?6uJRwY3Z/6EuZ1jtbDNH5Nbf5tqYMftIQVtMX0Ig84E6QiTEpDbXWikVbvCt?=
 =?us-ascii?Q?3cBf24LHaKSmYT/OoBX2eBESSiNyvspt8m7RD67fAMGonz5GyArfGyV7IjvP?=
 =?us-ascii?Q?CBvTZZUHI0HBlFgCNWn5hryySuEGyxML4M/wg18D8Gu9vnLVcw3NUcqQTMDD?=
 =?us-ascii?Q?rLlGfHIiZi/fzPK02mrnGDrK7Hf5PgfLr0xhJK46HmcWBJXmolTdPTCheGpJ?=
 =?us-ascii?Q?4nOxFQ6F9KiG/KDDH3v8YYkBMLf5J+tPxQBy3UPY1PRYRsmIUZFAp6jN8iMY?=
 =?us-ascii?Q?Rzepo0J+HVtG0PWD8Arn1Wi+PQhqETbyLtLxX5vCgNPe1ZFP/iBE0FehWjKk?=
 =?us-ascii?Q?5yhP6WiMSKriIKVbyKL6JaDCSRE9C1BY3f15TqOqr+tIUWzEhR4kpXlbk2Ub?=
 =?us-ascii?Q?JLvH97X9ROFxl+C381bfl1MIJpnSUtmShYUHoJKthVcf9ZsKFaiRpjGBe2XZ?=
 =?us-ascii?Q?Ymx1qwx3JKyGn4HN6bXAXWyTR2eQIWf2O/VTEOytb2jtJOKWZjiFRKZt0L5C?=
 =?us-ascii?Q?DrHFhgYzTypV17PwsR95kCAVBGeBnRtRrUJbG/pzrR4vUcPvQnDGAWUrAHC8?=
 =?us-ascii?Q?f+KVAbfPvUKmVmeC4sZfzPXENj4JwhLC1sA6B6GNLD0x+GaGjOeZjqgokZ+V?=
 =?us-ascii?Q?EyJPvIShqomtkeAL42EglFg2+ElCePik8WwV3XbOeGgIX5HR6mmsj1IxHwym?=
 =?us-ascii?Q?QUhp3YbhvfbvRqBQQRaL1YzcVzMp2ddzhUnjVq/eT7Zj6rWB4gQ8iC3sfBLe?=
 =?us-ascii?Q?c3RAfK3YYtlIfLqA5tzgJW6Qt5YAK9Ae01ho0DuFBp22yiQxg6ouUEM+BI1C?=
 =?us-ascii?Q?Ucaf1cBiNdPCnqAgAQ8sEiE3iFHt6QLkoSf4S5F59uqpaONN0mkx1Om4vjF6?=
 =?us-ascii?Q?tEGdKwEe04FqJxbVl/LGaBGb9z4F9fPr+UZt0XeGNGqOTBTOlnTBXFAlIFDn?=
 =?us-ascii?Q?+cvInpaSo7bF1GtGpDShj15Wfp+bD2LmGd27Q7w0N6AM4iQh+UDTCZsoi351?=
 =?us-ascii?Q?lfmDiu5YS3qBc+39OFawNlEKo+p6HPTKKoAmydENxD+CA+sJG0xVGFXPusXd?=
 =?us-ascii?Q?o3dZEnsw5ZdDasJMSl6rYOaqg0QqwTlt1f9D14mBSRSwkD/jFleEhbVWB++y?=
 =?us-ascii?Q?XygOR6ZpEJqCQbQvT4=3D?=
X-Microsoft-Antispam-Message-Info: qVILX1pbolDPsdcRZTzX3H3lK9gxLAFH9mvxfXSSxLb4JCRoBAUHH17J/wcJC+LPf9+S1CDmWuhNAvRNXPuzUUZouLXU6apdtii+A3tqyULfA4zSM7sRFdbC9te//nkEMA7ZJWZcQGGw572Fd38qH+/zbLN85W7mtsMhbWuYWXgVmQdrwQWp1CPswZ28d/z3xNki0QciaAN6zGS5jyYsKkzG6VXlNvV8agukmuP1U4Ig8VgeedzTOvnIprIgv+WPdffwuOujl7MST1uYB3Brezx1T1Mm91hY100CZxROzC/6w93srxbGrdjZfBakNJe/OesbwdANLL1R7maefNd/vgzFtdOU5VKv4R+3QulGVbM=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:kdsx/HeW6IJtsxl9Mnp3RkxSk7Rvzqa6WJc+mlTNTRcM7hbyiyHogmcLfa1WIEew8Z2g1cpqipNX2Tt43pp5WZDcnX5at/xMwkdXyyyUFun94q0lIjIUsNLPrN398nQoLM7jz2xT+SO2YNuwtUecJtfN4i0rr4v7GFFhFxb+WWl8k0L/2k4786ey4Ql5FRH92JMc8ElzL09k2dgiwogwgvfIHY8h5ngtsNLEkGIHesELOstnwsiYdk4bkpYvjVKs0AwbW+V/MQPBmrqUXMd0ie7XFVN1u1bUg7Uukur2165u3K2ekyLovcCjgpbI+HA2eNgkqx2LxRIzhDg+CmBxspauD98skuIFIlY34fb9ABoujZQ2aVG7G7v5KVU43lNLx9xazIsqvw77bONKfnpX7fwkUPUGcflL0KyTDTxEn57LnmM/rJ++w+MLtaVc7dHtrLxb2ZGb9VnrblCiiRBFWw==;5:ejiE3LUy6sa16Ubdy+T0jmLVic36VtDZucdCWhJM5XEpBqrpr5YeZ54dTnfiPXHtFSXkVBYM1paEiKeeJrBLF7w2FvIBVV5X+zj1tXKlppeNr5ERsFavOftgZRm8L2xysWi42utF++C6kui3yvVgYbNNWxFpNoC2ZaMdN083vbU=;7:ha/T24e9CmFk3CDXmAuDwnqcfDiEwsPVn5L1D0G2TSW7nj5N2vVHZIriGu8m5kb7I+xZrTLhBOor4Um4+OMWh9FQkjvBW70RAjXMJfOEIegPfooSWH+SbDD7okBo/r0a6/xTZIj0qAcVUT2GCTHisQBelc8i9YCkhgOqbsCAP5N0sWho8XwWTvcLCy0IPmTuwU3pUaL8cp7jYonopBjrndwndCO7JoRprrwX363NoyiA2spDhcmAMjvu1TAkURoU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:1DZhdLoj4y+VmzeFWA1YlkxHQvgueoSBzja4RS696SGyJAB19lZ9iLMZk5GicKlNv0XBgEpyiF5buCTZilCaLyt+KYzDEKDYsyHrbzKa6JUYV76gTMw2g6Oqh0fmVQzvijvF2uImB+Mghk2rYM7TbRhuat1jghdcpZp1oh95yCQ=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:21.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a074194-3c0c-4a1d-9309-08d61fb91c0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes a condition about dr_mode. If a device node has
any dr_mode ("host", "peripheral" or "otg"), this driver allows to
set "is_otg_channel" to true. Also, this patch keeps the dr_mode
value for future use.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index e7eaed9..93ab860 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -84,6 +84,7 @@ struct rcar_gen3_chan {
 	struct phy *phy;
 	struct regulator *vbus;
 	struct work_struct work;
+	enum usb_dr_mode dr_mode;
 	bool extcon_host;
 	bool uses_otg_pins;
 };
@@ -436,7 +437,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 			dev_err(dev, "No irq handler (%d)\n", irq);
 	}
 
-	if (of_usb_get_dr_mode_by_phy(dev->of_node, 0) == USB_DR_MODE_OTG) {
+	channel->dr_mode = of_usb_get_dr_mode_by_phy(dev->of_node, 0);
+	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		int ret;
 
 		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
-- 
1.9.1

