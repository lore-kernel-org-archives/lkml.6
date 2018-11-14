Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B187C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC36F22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5rQeX2pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC36F22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbeKOA74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:59:56 -0500
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:62112
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeKOA74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hp9ko05j7PdVKZRm0LeBJLYlPm4fc7RxLpNasZZBqs=;
 b=5rQeX2pfxnbrFoLF/QrmsgLysmjCwCQGfkD63xq1+O68XkK5pYI4eMk6GM81qn2affBtcB9TKHFDA86UhFvqvKeM5S/3J/bRnVGpaMwK79n9bkNuawIxMzIh0mDRZL26BeMUEOxhk4Z9LHLMxzUTXj+V2uZHG/Ux4lNyrWnP3Gw=
Received: from BN7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:20::19)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.20; Wed, 14 Nov
 2018 14:55:40 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN7PR02CA0006.outlook.office365.com
 (2603:10b6:408:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.37 via Frontend
 Transport; Wed, 14 Nov 2018 14:55:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Wed, 14 Nov 2018 14:55:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45016 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwZv-0001hF-N2; Wed, 14 Nov 2018 06:55:39 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwZq-0007of-Jh; Wed, 14 Nov 2018 06:55:34 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAEEtOO2014470;
        Wed, 14 Nov 2018 06:55:25 -0800
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwZg-0007nP-Dn; Wed, 14 Nov 2018 06:55:24 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 0/4] Add support to register platform service IRQ
Date:   Wed, 14 Nov 2018 20:17:54 +0530
Message-ID: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(106466001)(9786002)(5660300001)(63266004)(478600001)(50226002)(16586007)(426003)(7696005)(81166006)(51416003)(336012)(81156014)(2351001)(36756003)(8676002)(8936002)(4326008)(316002)(6916009)(107886003)(106002)(47776003)(54906003)(48376002)(2616005)(186003)(486006)(50466002)(2906002)(476003)(305945005)(126002)(36386004)(6666004)(26005)(77096007)(356004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT006;1:XWPRKToeL6JLBSXJwjRWHwjKEhqWQy2XzAKR1jDbweH4iV9Y2LANDRWVGKn0MZKGOpIILfc6sVN0t7yxJ/YEgC5c4M6u9SE3ZPefPSMed87nGMd/nTkTynhEtLiH85iY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc24ae29-6938-45ab-17aa-08d64a413e92
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:p0BJ0MSzWhEfnmN2BiXk+7vR6Eazca8zNFPiwYRld3spUZTp5i+vX64HbYkAdFdV1TrzhYokVzB+DPgcWaBDTbw9QyfJeU5ytS7DT/cXt+9ixO5NtEL5t4Pko2mCPeCIWw/dYeXlyhN4COBnh4TRbLWGoq1V76VW+8AxKqWVVsPRMN0kSD8GCougWnN+JohjPgZXep1qr5tBtR2PZXrurSR84g4eelEwaJKX805EhhQD2mD12QiqXeX5Ivj2DKc0+MCLhWhk4BDRJBqkf/5iJ4Yy8xynmgB7kj2x9nc4PMjf5uHpNpycLviXlMuWVyVWZhlLe5uFMUl8No8XxZb1L+uNYY7NZMKD5X31L16a+Yk=;25:WzfwQMrIByaiaSgEc/GANSb0mVLhrMWF2UM7Y+aPJg5l9CTStAoDHv6InUgBjzdaPp9JL/nF9cqzVd14Urm3jKKAlWgID3ifMinoLNb1q+BX2JdFAA5HoCkN6jWlaHwegQqbWQcNG9LcoaMukRmdRxTs1q7Rkl6DSFvWjiEx1mOb9dyUUeQVxqk9tBtv80R38lHD+7SSWqNxYdqZz7uZQ9CzFXziWtap4Ush8W5hU4wYYJXBpUISPZyGlEdMf+a2C5RqnNGO8j2qZJBZ5dQQYl6BlaYNJhWdmlOiePIpXywiIugW3lZItgUn8p4Y7TR0wd/YM/RETRBWT/UanOQduA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:WYaRyfQow0tZtTOONSUyz+iwcqZX3An9eSnaylnZmX2ayKY8uWNHPOY08VhnvgppNh4RTJTXWDCgOdDlvg4bUcEh1JUGCZrVpMDMf+Zi+sRiM3eKWjwlZ2E/aS3qCFApAdxbAj/2I+2cNSABnWa5C5pLBa8sgKLjhhjhfm8zNLQ54Xp5E+X9VEqXOTc/L5wd57v6xxPGhvr+zcRa0kl/8aJOUq+gmRBvWH/l3uji/1s=;20:hcD4KENppmi3zRBqLzuwu53kuZ4gQddPqcdr9FlbP7iCJpTwluDbdutf6x1iML989xLVEfskBJ9lXN86nv4D/3/DtZqEI8gBV8NVUCay24Ze1SQHhuTe4LpKS/2ZPQk5NpeD2EoAcfkNh7rfv2/sTggpFCrc0KUwgIyc95N+RVoUvwU9e4GN/bdoIsqxhKFKLo4SVPf+pNZYVjEOXRamH0SHwOQqZHiKtK3v4FSpsAQMbr6rXaTqPOnr7iYLDQEwls2PHhkzXTPPAYq9NIwB9p1QnKxHeIMRaSI1jnQQ7KymJOEcaB3HD3gZoYnxdsU3WVT+QWx0mNX8GJAtT0/bbjckccANtNqq18NINxnAFwtVQT7vrdpFIyW0+Yx2zDTAwjb8GYVWG3GL8rz5PHKeckhetMZoURvKLBMWbE9+igymkKOkrVN0KZuoGemIasOox6nRCiH4BEZkSv93aIFYw05gsIZrYGbJ+WC+v0hcf0kXgs1vu+B2XelGAV3BOE7t
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4449A7CBB690B529210D38E2A5C30@BL0PR02MB4449.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231410)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:6bcunTHZoLuOvMi7I60/sYG8/GivQTUoWxjRkVvSAVTOJo7kenCbnxL4gOsEZd3wT/88gkOn51Yq9LK24HkGBIqcpArBVGm9GJEM19lxZ4Cvl6+iDlV3lag7vTNQXiiWSwj6uUtlv3SiAVesZ64xbbxkX8xI3LkoXPLRodYOiyy8aQeUciThsuTtTE5COWHp6a2DJYACgpgYI33RYyts9kIY8OGb2TYvA4mGrtNyz4EiwRy3miZ02QYYnoixuSzXusPExhChPIedeHLQ6k4CJA==
X-Forefront-PRVS: 085634EFF4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:o3otJldbYf5q/FAo1sqwTIWOteNdoVfTT18JbShua?=
 =?us-ascii?Q?+zRNw/jSKLwGdgyxMU/2To779XFy8mSSxTkqvrMkog+B2sIctr0ywVbZQdkz?=
 =?us-ascii?Q?mv4PoN55hNXpRJ4Y7hfMOZe66lBF5jkLiHW7iN7ZPSPwhtPKgiC0/Pukr+m7?=
 =?us-ascii?Q?ZQKyW300ujS63KiAG5N3ClpaArrDy6CxjFX0xTt8iCyWu6uhPs9QK1NSCJFn?=
 =?us-ascii?Q?QdvDyiqEATcOwyT0N6lN4k2IgE58lHadYP+fNv3OJnSWX1cRWbvO/+GSFJ5A?=
 =?us-ascii?Q?zwI5YyJ7VRLPcYunjDSJLud4HLpNZRbV+Ip815HKBcR3SVpDlj446CYl9t8f?=
 =?us-ascii?Q?nQ9XAUdO7CDiSNzidZCec8tMxLsQ+vNhvtQa2akfPikFOmyGHIjmz5P5NDBE?=
 =?us-ascii?Q?AAeCowW7T5fGghC0tohDO0+9GyjN5M+OPTlc18R+acIc7GUSSndS45/mhCfP?=
 =?us-ascii?Q?ef2pmKfuVJ2F2KXWRs9NxTpkQZ1JUurUeOgMsd+rgKvtq+8A/9ra9Yiv5EuL?=
 =?us-ascii?Q?pVA4sFZYGy6OIk0WtsXY+/sPAcU6/fm9Hwtlt+OiMJW1W+fTiI/nae8DcZ1j?=
 =?us-ascii?Q?N/giwGvfOgTQLw5t0DYPee7ooUxcKdcrToVCmg22Vwe9JSTS+GYjhXc2HrV8?=
 =?us-ascii?Q?MDwEY7NiTbX2yvCC4/6Br+BLN5Nd63qdVd8Sl7a3TwCazMhZC5j1cc3koZ02?=
 =?us-ascii?Q?1Q9g6DwH9jvBzTvca3Sca0tjUU8T+PK71uyxeuNtrV4YlLSosMze82H5fOwX?=
 =?us-ascii?Q?cNyOk0aaPC/0DmMJmlyoaV8WklahECRfoKtJ+wt9m0r9Vjq4D7r+HGmXNVCj?=
 =?us-ascii?Q?A6s8uJ1DCzS4+/rdEL8youExaWYnnF0Z2zpKibEyTgxt8A2b8EK9ax4ZtvQZ?=
 =?us-ascii?Q?Dd/fiGdoVTm1vhrGUKWsME6F6/p8HHmRsez7QJzlZ6kfySGuyja+AmXaQop2?=
 =?us-ascii?Q?dTkDY/9lWdhacpr1w83kuX2rZ9zm0/xxznQKmEX4l25QrGrZVnwRpRt5NWK6?=
 =?us-ascii?Q?LJ+me9T13bcm09YurIltp8I1mx++F5rupfL0e/f1wb/0Wr8Rmzb3tVbCep7I?=
 =?us-ascii?Q?55zL2efCqGj56Nj5v/x50OEh0CZS14/N+RnwUrtdg7+LYsvTw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3wXlSoTbVYIK+IlWI6vuylK+tDDVHWfKR4nsLMX1vTAhgLP/T5hmcmau0oGkItYHVxzZ7DvREPP6NQ0mN0Z+08uyrp36csoXTgXynZSP3ClHgZnFu0FsxUSEK4PpT3T0dXmJ40GC4Did3y9RHf7nOwKRZqYaCdv5HikMLHw/l2s/xDEOCfNHbzQ0UNSW1TesKUdRLuoPOZh5EXhNuz030F58rFBwMPdQmZqV6ZLZ2PpVzoxns9IzQMWtQhOuyy3iTI7gnFO+8wyW81uVjxQw0Qe5AUmxjCs+E398N2U+Kz8AnDfc8hcjGhZJZyNXzSAREV4AWVn1DH0a9HwtnjhzyxBzPbZR7QIjJqoIExj7wDQ=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:0yD/F9bGltPYA3KXcdZ73Uk1tPzlnUcBo5mRkHe0wgJhZ7PsjN6w00pp97phRXsARNV1UJoxIL0H/XIAXiAJMZCPoM5U54amZioIEiT6MzA5UAl3Am8KenLdj35UDoL2yT9woNxVAVWSPnxL0fMf37cOD/vHthuRSr9hjQFpFgvsa5om1jWqATnahxcUyoMPNRCmv+OT6DagJIkD6Px9e1Rn60Oj9lY5fE6Tnp5OPS359+wAAlwckQ5iIzlsg3ZncuKtwDUqIjZVIGtZCuYgHlpSMVpXY6Uz6tHD4n3oR6kdLfVGU2snr2NoY5QyN8d9mAZ5Nv+ujhg9ZHL/vgDqyZRyi0yHVWY+2SCYkze7OPzxf4Dh6ddRHGUGnGOokqh4/x+B6tsZaOpPxrU+Izu0BQwqCkdNcZjcz2veEslCeYtGZbuTPScsEqW3KBRYI7lkI7oeqj/KyFsggU9qDMNbHA==;5:nacORNvxCn7iBcO/zKNDieKExGxLAWmE/dbWEg6/Yb/6kqtTn3RcYX3M1JG1mZXYbx86iHwN15vIPGbScCM96gZg29eSi9peakF73tyGPy1SbXwHQ832XQ8st2zXUtAMhfeYZFwOTJhDW+T6Gveb8D78/9QQzGhkqeTgzrDZg/0=;7:lCt/W1UDDTL/Q/cNuLjx1e/f9xSGL+P8nL426H+HpZn1lnbpwyxH3OMOa/VBg8MObV2bjcxL1EsEZIUjQSXo7a7v6Jv5YzRoYygdLYjCPkCvxlehocqTSkfgZUuShwO8pbFT+FknLDY91P0wrZsDcQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2018 14:55:40.0876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc24ae29-6938-45ab-17aa-08d64a413e92
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms have dedicated IRQ lines for PCIe services like AER/PME etc.
The root complex on these platform will use these seperate IRQ lines to
report AER/PME etc., interrupts and will not generate MSI/MSI-X/INTx interrupts
for these services.
These patches will add new method for these kind of platforms to register the
platform IRQ number with respective PCIe services.

Bharat Kumar Gogada (4):
  PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
  PCI: Add pci_check_platform_service_irqs
  PCI/portdrv: Check platform supported service IRQ's
  PCI: xilinx-nwl: Add method to setup_platform_service_irq hook

 drivers/pci/controller/pcie-xilinx-nwl.c | 12 ++++++++++++
 drivers/pci/pcie/portdrv_core.c          |  8 ++++++++
 include/linux/pci.h                      | 20 ++++++++++++++++++++
 3 files changed, 40 insertions(+)

-- 
2.7.4

