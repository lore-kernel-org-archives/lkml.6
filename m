Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A72A2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pIkbxfdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A72A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeIELiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:38:07 -0400
Received: from mail-cys01nam02on0084.outbound.protection.outlook.com ([104.47.37.84]:28997
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbeIELiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqT/IxzpTrWR0ieXYACCPeG7ann+N+vKXcGmYs0Ao/M=;
 b=pIkbxfdbxUCyrlQgjjRT30q2mAUjoxdB/OJ/e3GKcP6Mu6HMd4WYB1dTHdGamKvbzrVDE1yr8h/nraExW4KriMwgzygOV0qNDg5vPsPmhCkiRLko2DixO3looCJx1q5slvuxFWLV71yglJ4/62YD1+E5s+0GqYmb1SWCUoqcOT0=
Received: from CY4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:903:117::16)
 by BLUPR02MB503.namprd02.prod.outlook.com (2a01:111:e400:88c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Wed, 5 Sep
 2018 07:09:16 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0030.outlook.office365.com
 (2603:10b6:903:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Wed, 5 Sep 2018 07:09:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 07:09:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwB-0000AX-3V; Wed, 05 Sep 2018 00:09:15 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRw6-0000al-08; Wed, 05 Sep 2018 00:09:10 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w85797EM024257;
        Wed, 5 Sep 2018 00:09:08 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRw3-0000Zf-D7; Wed, 05 Sep 2018 00:09:07 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 0/3] Add reset driver support for ZynqMP
Date:   Wed, 5 Sep 2018 12:38:59 +0530
Message-ID: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(36756003)(48376002)(356003)(50466002)(50226002)(81166006)(110136005)(9786002)(47776003)(8936002)(2906002)(51416003)(7696005)(316002)(81156014)(16586007)(478600001)(305945005)(966005)(8676002)(5660300001)(6666003)(36386004)(217873002)(106466001)(426003)(6306002)(486006)(476003)(126002)(2201001)(2616005)(106002)(6346003)(63266004)(26005)(77096007)(336012)(186003)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB503;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:F1kY3i1BAkqTexZzavNoW78ywpqZHn4eSJZ0sgSUYpERsq78KfGyCk7SBR0ALSNqEafHLZfSSThyELwmDongVpt6Eej3qlBfb/nX7oePnx9/8KAlQ1kXuHn0jWr/HFoc
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00b0b7f1-f648-442b-8fed-08d612fe7db0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB503;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;3:qCuGmV0LaoviJBBykrPch2Le13/fHo1AQLpzFgstXQaiDcZyK5pUUDThamh/s/a3ub35c6gizeYf4gkYMA0cnjLn/kJPzcw0Qv/+XE8NYie3Vtd4eEAF9XNC1/WakMu8UoCAy63ODecr0xmQYzh7Fp8UniLMBcR0QdbUhv3yiK2zTWsJ6tzPCCEMAIqJVBVLzFaZvHmm2bjcZ5dO32Yzxye80w8+D4XTQumIEpPo+C7v42/BqgW04+Z7hvDm9hhDPJ9ZgU/EziCg+u2C0bg31lJotuKQbG1mMOQWCnFOC9cDrSdmVw31ClWvuxfqN1xdo3lCYlzHt6BfAlKtU+4YnJC1IM0Ams80NFRHC3gCFkk=;25:c9tzDhJP/wIWPoF+bfn/3fN1fPVQzvtNKhzJ8qmfRW2nmN0Fa3KgRvaGhSJptaykCVeBWlzCge3VoZv8c+TU+btDTJdWOyMuyo1eZjwHZmFxBoCz4tnSMFwjAqdbguW9UA4SrEZWQ3pqEgTYtJ+UqG/PHYcYm9Bnoy3DEqNja7MQjsRFmZI0hwD/mGrLwODqcD6PW9V7q/OxgaDBnJX4ZM05M+bpo+CgSt3rMaGgZB56PEVSu4rBuca1yllpQVbi0wPF633DXJNjGwBU9IarZrXOzTnmGPmV/vKzfe4UD0OrI1jWiKrxED1UrnhajwGSRCBZc5ZW8IWpsQZCK1uTvA==
X-MS-TrafficTypeDiagnostic: BLUPR02MB503:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;31:gkzH8NsW22JIBveir/RRAyQpC5f+3NUUgqO0tfnTcYSyi+XD/KLo0RgOKLwYyj7pLLdamA8hr5YTxOUfuCBMLi0L9+D0msnUQID81AODZ7Y1OUizK17w8QrPnRMViIbSZAi6H8HV/FMtVxxA5LYQYR7dNWzBKg7iQ932vJs2ZJBnlfM97/FUsSnymYfZhxpzIDJ9tfmfSweHjLnE0plIMeZ1YXVoefwCR0JJoA5PLog=;20:MA3CUBNtjzS7751ANejn0kUIf27igaQS2N4A6WPRssHI1w46cOlljSOVanpSRZ4IiPMKkv5Gd5qvVFm3Sf0IFYEcNpBZc4lJrQmUevKLO9/86m/J8Orc8XR8o1xPpqCFQC6YZKqU+x8vb/iIRn+mmYOAJ/Yby2mdbWDsj5rCt52g7wH0KYZit68mvV4Sc8no8lTzPmyrz6IaBRb3hpY/PdqaXIL/pSTE9FBOjsvrc0J2LT326dm81T7Y044x5KQp0ij+mS3B4DAZc3SagV4Qcm5ZAw/T4LrREYj8w0g3yHXlcZhqvT2fDf8IctkD4BROaa0ES0tvBBlkEUfvKTutBg5Dr0eXkbpBt7zg1500cmYnF2cfRGQ2FW1NRybIHx5i+pwJ9hBWL2wBD5jZXf02XRZimNIPs4Okge/WwjkUKl8WVr6b8UytN1+56WVaKjgLLAVQ9sUCiUWoH4Yh6qygZR0i4r9xfYFjxN3T/McOVyADZyHj8E++EI5lCj+VtOUG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB50357C7524FBCA1F117E728C2020@BLUPR02MB503.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BLUPR02MB503;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB503;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;4:236Ma5jfbL9aOGzIn+9gDfNfP7na2wzDs0uKnss08ngpfffNPqEZtzhCuOmBZ3KntNPbjP+uX0Jgi9J2pK+jOQyRN4jLu/yxFRFlWDTXU3incW5Vhn50k0V79hCjZzbb3t22qXpymslv2hNkY99EGCTJTxC07xPLZmI8JBGF6epHSDUgTPaUSwfd8UU3m8Zt12h9+Kb+dA2AuB/Els6EMgr7PSjw32i+kMhCSUbtWZ6x9T5IWplChjV9HJjrl9B9T6309WSn6iHx9Wiwdbomaw==
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB503;23:xTOGzhRQYbyJhvUXyjNHDxx9QBEUz4lv+0gSjxXP83?=
 =?us-ascii?Q?kBZ3mShNvr5B6BazrNyEbWQEoxE3NC2wDhPYxVNiVeNhxB5WJ97V0Me8vx+8?=
 =?us-ascii?Q?jxEw22HX3JXu7ek74X9hGFSOyPRuJIu5MiYPZbze7iTqCJF2tsehwkKK/aFQ?=
 =?us-ascii?Q?l2VjVSn7o2rsV+QD2IOX8p7/mnFdzEmtoOEqRmoGabBC3ocJz9rWqUOYQ84m?=
 =?us-ascii?Q?9MPHISOohP52uUZaibj1p9sgr2csSeBRQS1fv//Ny8Atx4mv7Y8sdWgNj5hC?=
 =?us-ascii?Q?/jfrIB3uIWt+Ub2mBua4TsuVNpcWahPJsVdNbmDyNYsY3WIEF4Eok9Ubmy26?=
 =?us-ascii?Q?VjX4VmPmdI1dwoT80K7hWgfKYDwW6skMm+rLIQ5zpP5JNKolmHotUk8aLUse?=
 =?us-ascii?Q?FT7P0ZSXfCf2Zq8qZl77RGss85Znh+lYhLMTA/jsb4Y6s5lNAnyuBhkVSp1A?=
 =?us-ascii?Q?1KuhVDNAqk9WlfDp2tTzYZoYQVDrOiKnsd7h6UUZYnaVBLFPjZZssyTiowod?=
 =?us-ascii?Q?EhhSycQ14UJi5sqB/1TPGinnoaH37sGQOFi2GJ01UrcpnLa1Ni/NlRogOt3p?=
 =?us-ascii?Q?PHDSLrbGQABAHMu9w0zjhMia32+ldgbr5rqrMYzhfm/wh+Jlx7LBmlKvG/ve?=
 =?us-ascii?Q?HE7YcyLszV+wQS9lD8DLVXSw5TDRicnBO+h7kiVdFAkKI+bG20mugzhoy63X?=
 =?us-ascii?Q?HGci+gGBn4J7TCAXjnA9r8+nV1OubHBqQnyceuglDkqkagMD1sHT+K+x54hM?=
 =?us-ascii?Q?YMUjgQgf9XF0hq7IIYjWZzIgy5zuTxVLXGbqvzB5FFNdQTepnoYDO3clllji?=
 =?us-ascii?Q?0kVLLh08RgEjZlwgv/Yx/83gLhFL9cCZwLqdQf6GKjy2I8l3aRhg5m7GaYjN?=
 =?us-ascii?Q?fofZRZs/EiQgDr/zx8JOxFPLUktVAl7pGT4uobxgJ3mi74pvBMJL1cmRX+mC?=
 =?us-ascii?Q?BClWo8yjQILcjS/yHNX15HLQ+8bkZQLmd0ndRBNPURhZhMb1H22ZACJQi+JF?=
 =?us-ascii?Q?nfWyjRSewhbIYRJVhUm1ZSaHr+0T1cpArjqsQPaU8xbD5xtp9ru5b17H6YaC?=
 =?us-ascii?Q?YDrkbmB3mQnow/56ul3J3rLR45dzT/2efOFcqWI1anpYAiE/nDG6P+xDvq3H?=
 =?us-ascii?Q?4HiGMGYErq4KBDy2PON1OhxfwVe7SqKLGA5LiQpZwNZQmYb6usmg=3D=3D?=
X-Microsoft-Antispam-Message-Info: jWeKKI1HWiIPPfnzgiZRLv7uT0ihs06pO0lv556OhqgDIlzswiF+pEESAaFKFhQ9123YgIzYwIR9Qb36krLmQ0g8ECsmdOiO6bM/hltn/alPUmx5U2/jJIxuAmVgns3hoH5CAdM00pgPc1XeSG3ymeSaHmDseo6coveb9kEEc23SRW3MKRtu9axflpglZNa41mBTgWstXkJqqBKoTo8EI8XkHN6KaZj2aMbxwRKWDSXSHuxFEoX4P0VkYko09w1WDSRRZupwWSKbkH3sWjX5I/v5AwaCMR38aWzihHo3s6WBN9GODGMS6IU+ONjRum/jDwkdclZq1XIah9jt7GTU1J3nV/b94LdYsbox+SYPMcs=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;6:yItgtbJT19fzE6EiuWN/L6NdkkcvrJFpkWA0+mPmZFtuFwwCU4GFHQenr3FYQpiAYW1R4xMQ+7W/4FtzCS0UYNozsiYbNfpt2Jj3vp7pwI8up21QM5PopSgJowXnb5i4gQsZnXqxJQ4vR3ywyWkCoRO40LFnnXl82GyT25lpKKWw5PHSPkfFqtCy3hFPiS6mSivIHwfPCIQTeTrB4Wu9TLAjCIyotSkeRolGknVnc0LiVPHGebfwBH8c/J121/ydRB72p32EB5xODpXEgfcRAqfjvX+ix5EhOFaXy0gLhPr+nQGamlWboTjRPZR3NGHrVGWjH0njDJLTKYsMeYLIbTMV9iIgde8piAHFySM/3QY8IGxwXG75zF5icFrpcd8zDOTyFuFTI4t0f3aMUZRh62okqVfLqzoTQztkP6WxMUX6HjhR6prKknioAsC8TBGWfF2Xp2ApHLkt8j6RnRKNIw==;5:NWv9tXnNyO4Pa8+wM1dvr7eVFU88CHGcEdIGJe/kvXzr0IpQCe06fzqxHRNuEBn3rctxk540uQFgjWJ7w2M2sffGn39I0kmaVPnjPMjLAXLIVczt2tkKm6n17ln2VvmcBCsIm07cgKGEpiEgZRPShppzutb1vk0dgqoVAe3nrno=;7:5p9XQR5Dobtoeq44ULVngCUSyoV/VpElvTMkS32P4NHIGmNzCZVRARo5R3Oc2n+4QB37PGR7x4j+P6YtJhn8XxAhozbSlx0nfy5Go2iJ72+QFdQ07ZhwlQ1wyoD/acTBSCH6Av0pMBrAr+MZ+OD7zNP3IHXA1/ye0wPBnoEsRprSKW5eY21bEuBzzPiknkduSCkkwliN+xpg2K0MJpzJZnegmaVvf75PBGvJrdBu5X/MDfjtvpe96PDSS+KhWwGe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 07:09:15.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b0b7f1-f648-442b-8fed-08d612fe7db0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Nava kishore Manne (3):
  firmware: xilinx: Add reset API's
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
    controller.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 142 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  40 ++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynqmp.c                       | 115 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 136 ++++++++++++++++++++
 5 files changed, 434 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

-- 
2.7.4

