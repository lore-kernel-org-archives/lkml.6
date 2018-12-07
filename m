Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F79C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9249220989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yTKNqYCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9249220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeLGSfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:35:45 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:36350
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbeLGSfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edeJYWzxeYMqAt1Wxl/JHvle/9OY8EuMFIYq38j0bp8=;
 b=yTKNqYCUasBjHU0in+d/y9jXc9AUpzVAhTrwETbIcFV11ZPMmW1uPvuUaRNMv4eHTCRHSywJaoucVd5G7ULJUStvJoaSEvT/nuaroZWn3qKUPCuZ2/v83CNuxFRYXm41M2XkxwVF0CIWAjgVLPgH0UvT3RsP1Hc0cvifbJr6wWk=
Received: from BYAPR02CA0013.namprd02.prod.outlook.com (2603:10b6:a02:ee::26)
 by BL0PR02MB4450.namprd02.prod.outlook.com (2603:10b6:208:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.22; Fri, 7 Dec
 2018 18:33:47 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR02CA0013.outlook.office365.com
 (2603:10b6:a02:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.18 via Frontend
 Transport; Fri, 7 Dec 2018 18:33:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Fri, 7 Dec 2018 18:33:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwY-0005by-0R; Fri, 07 Dec 2018 10:33:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwS-0001uC-TJ; Fri, 07 Dec 2018 10:33:36 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwI-0001ry-GM; Fri, 07 Dec 2018 10:33:26 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: ASoC: xlnx,i2s: Document i2s bindings
Date:   Sat, 8 Dec 2018 00:02:36 +0530
Message-ID: <1544207558-72508-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(486006)(106466001)(50226002)(6666004)(356004)(305945005)(478600001)(7416002)(63266004)(48376002)(36756003)(50466002)(51416003)(5660300001)(76176011)(2201001)(7696005)(39060400002)(186003)(36386004)(81166006)(81156014)(476003)(8936002)(316002)(8676002)(9786002)(2906002)(16586007)(336012)(47776003)(11346002)(106002)(126002)(446003)(2616005)(426003)(77096007)(110136005)(26005)(142933001)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4450;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT015;1:BE2NF1LyQrTdwu0E58+1l0n+lIUQbaAhhZy3Fe4NMtldUtPby+nS/SqzHbWhn01F5mauPX1RxsoIaf2/Gtw60338lOzm+fARWAqnZxcNPX5yK0GmtGlNhpbNs+fg2ABs
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 562a4390-e00d-4eff-2605-08d65c728607
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4450;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;3:vnDY/3etIUzT9q0ZXXAY8ggn6LwuLXWFvMo2KzU2XxWx1nqPUO3ugKKtfvZHJ4lc7Ufyx9LG3OnFGW2DQ85tX2VfyqVPgu9LaBbc/376dX1yW9XWyJhmD0GDiZLt9CNVzbccw/oUNKxno3/PcPJnYZLn+O9Zkl0AEJimq3yv7Z1WJBKZ9XYkos1RXF1tUL6+g9xpUEBYilIyA/inT3N07Iv3u0RXVKmxM/w3XgpeX3Un5zqcaUERsaAqlmMV8/8rYNNxwtx6U/MwEPw589UOGtIIvtsBqtYA+6/1pZfQUyHMGWsqg5vujhwM9ldSvtbu8PRnACUjKVO3IQqAgJCmj2QwOWIVxI40vOZoRYCPUTU=;25:UOcpCHVfa7PYZS13+AyMtyTa/EhmnWN08BOv6H9b3iJRvoG8u2lvGnZS094bfsy+flsZCUUAldR8Fq29gyatZHjzVgHX3Kj2BFMzNc6tBpbW7WKhiPKcG6YUMrnIKq7zP6ndZgFOyEFci/HLgDrkmbSoaD4xE38TJnGs6u77mwyDp3Jy1893mIite9untvK3F3HscZA6UiKS5jrOziWbRhEVT49d6CR1e6t0/necXdR60EP+duJfcBSX5KS1zh+NZ4TvRY5CM1uhJNuGQaYbVQFDxsaWnBHvoVCvWr674xv9KaYl3R79oPn0p+LP2jK3YII/KSEa5uV4XDugVHlPsw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4450:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;31:gIC82X34CbdMeV8XMe/tz0TGgTyY0Be245P9yX/mo6H5DcQviUilDZX9OuHjVRmr8UhEd9CCa8P27KKIUW7kTVPA/iHANvP7i4r+sgz0SSrY7latCnKvY2/1CWoBac1VV98aptWJYZXrxNhQ8vBsLbU41equIHL51hjpmO5LDj7mgzVzLdMwi2ITgx+WD5sQ4O64Iuzc98iI2Mwmosgi3EYtFGKHApegaAteP5quTkI=;20:bxdPuESmDqEkFNgUwhNXnn9SEYGRDEmDwyhAmKGIBoI5iDIh6xeONDoIJRZBwJohUE7PsEXeMV9Jw4nljZd8KmeyMFXmKdG3xsIr1BVbVnSEmm2L65szYMS7dtv6zN1GGqEgDUzCc+WUQ92/vZ5LXxHl2vEXROHcV9nTMRBWeDtc9/TXp5076+pEj3kLC5bhtuMAA7fkM5VgZ23cQR8F8HiWaAVPc9abUOb5bMCpYN3TtbHHYmKRvgwL28+3resgpzJcojegNe3WsmCCG/nVGyuWWxj2UFgJXIztzEQOAumACUZp74ix3jlitk9efgol4j5oQMJtwM/fELzUrvrDNOTw8xJ6YrRmZFL68FGpUSAGQric0ROta9W1Q0plFKE7sMKb4pZHYPsTQhd1BNpV7jilGEhXimVQ7t5S3fjp8tggwuMIdxUX2eTRFeiMGHWriqnFc8cXJ2sqNTiLiGqRdLxLUH9/6PzCa+iBOZdhZW4lleNQSZul4F0TuizCVzO7
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44506B7635E6516C4881A9B1BAAA0@BL0PR02MB4450.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4450;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4450;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;4:xPlxf25UjzMhZUiOUSreI5KM0jofdH+3jozs0e0rPc7NCeAntlbxnwRqEJNswMlyv7kKnPfYs0e3B//5WC2CmyBO0r9wF8EeLUzmSLGF/rUnI1p7hPB5qWpFXGiDO21d2TQzD1YYtiLyIXw+phXOIVqg+sPaUa2mIj2cDQKFKDS7/J5hogVJYifH0tHpmcevCpsxJ73R4BYzo/iAMXmBSdr9btrtsYfNDrDGqCzivZrtypZAYsSvnFryR5LOORBVZHkbBlZj7K7YuHiBC3pmJQ==
X-Forefront-PRVS: 0879599414
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4450;23:cTigwXjYf0mfnYoJebKTvXGoLVb0X8Me3lMibMtl+?=
 =?us-ascii?Q?PVPocFZct9BIL3SMFPfiYPME19WkI97U7jE4+mh5LtwjK/M8ykMLLcDHeQpb?=
 =?us-ascii?Q?nlA9B9PjOS8MPdKKjeO7AmSfIneXG2Pk2Q4Gh3pOy/FJAxD6Pxi0QcxcnHdL?=
 =?us-ascii?Q?4j6ezNAr2XsvPuY2D/kmNZJSUS6RXCXbhKt9HGUo1tqqdJ2fI1r/WiVk8Rx7?=
 =?us-ascii?Q?t77pPwVOP3kew9B0ZXBHzlyaCrFVuZSpzNoP+Y72vQWaS9aCGPh4kWU2H1KC?=
 =?us-ascii?Q?dDyTI3TuIkit1nGe0D2q9E9njlk31NO4248qoKmg6LBtknoN3+JK3p15Mduq?=
 =?us-ascii?Q?gSiUukEtIoLAIkff69ybuUW/YEOkQYM2/zrXHCtEN3Pf7iSs7RnPYXGUgQxR?=
 =?us-ascii?Q?L2pLUZbaCS8RQCmIq/BKgqgLxtw+QT4sfogaecXqGbtWU4eStiNGw/LBGDwX?=
 =?us-ascii?Q?GF6RuKxAPhvyY9aGANAsKVmNrd1Aur9AhEPqnX9cv4Di8TsiuLhLbkpn4y9O?=
 =?us-ascii?Q?FMO0SPmHqH3J8bo5ZGcEM2+L5SPw9hy5RUZFasJmprE4zZAW2noa3jXw23Yd?=
 =?us-ascii?Q?/I+Z3MhJ5U794As7gjr29A1iyoak6x+iESEOKd5H04OLNLdgufbZEP/I045g?=
 =?us-ascii?Q?RAP/+Evv7P5Ge83jzCXVcHB2tv6BKOgfq5L38RuljdPY0CNN2T9WSMPAK8zS?=
 =?us-ascii?Q?kMyc1o4BVqflZIeANAjTnnB8it1t3DA8vwlFWFWoR5sP7vXcDzURdBmEkseZ?=
 =?us-ascii?Q?y9c6ZZjpeUrKkTLjJe8CX0Gd6drSdkG6W5RySNm/Fs15qrogorWmjz5aIvRG?=
 =?us-ascii?Q?QjK3CZdYylVJqnOFxmDKn0EaAOUArKezwhGdUH+Kh5VrMnn0PuOYk2yyP8cp?=
 =?us-ascii?Q?R1N5rmqCs7xIOWFQoUdpNnzTnEK/cKkzG6aCFKn3kDAwW0ynRTYiVOaNZxEh?=
 =?us-ascii?Q?zXgXNVlMSXgSsIakbiCX9XxJaR78Rd3qi52wkcvdt4SipS5WQTcfe6go/KpE?=
 =?us-ascii?Q?eEjoMDNoF8fKEiXKKvH/XrocKqF+k5HudcPr0HjE+QWMggRcrMrrt9te+LTY?=
 =?us-ascii?Q?Wk/Zqn3Ub6knJoD1ZfQsOc3ah7J83gyUYo68LiFy5nf0rlxDgubWct/q6bGC?=
 =?us-ascii?Q?h1ME8zcTVNo9YJnhbU0+D5DRNmwQr7J?=
X-Microsoft-Antispam-Message-Info: 4VW4ntrdqMU1gS3doDpfYO8kAgne7Ruyrp7VqQOujjRbdF0zMrUPKXVTbBGQzTZAX3As67PmRxj6ajR4LD9MG8dPJ1QuQGHXviv/scAtAjUew8cOKGwY+xYMePJzJWWncvjKxuVbKwDMDkr9zfDkuQ3nSGNsUgZrDXZ0RBrmapYTeAarUsNRmIJdMHSeWKAmmdMahwhJPaUjFXPoCIttzlMovFGyiRdxS8BWCiaG2aEsw3KAxuZCLxgzJGvWDvtJKxhvBGRzS6AVXRJkdixUxVw4MKhxQ/6ScGqj0Nioe1Iv4Uag5GqpjSc/ZnKpdGvuASznTUHCAJg9q23bKoaCTF+2/Zx2HYMOXkZ5n5EFLPQ=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4450;6:aXHSrxGCja0j0mjSL6d8OGXqrmpq1QObdXY0CV97eFJxE+Lf6z3tWNDqc9aDSJ7tpf8GTY3P3QPrysmwcAtUAGF4SRoyAwHgM371Ial/080c6aNcJYof0/x0bsOOHpb7mGUYHM2uRU5A4twHjbr55M2fRsiX3l0LAYQpBIwFEqqla7MS5JeL7urTvJ39woLK889Gv2jcgqBPq/iliT6LUuoLLsXTFhr0rjIFcW6kDa9IU3qV5pgm8/B21+CeM2N81FNG32FJskIPTIuB7TWMV9rogKkqCtUxQKp5LngpLqNn4Dgxal5U1ZY6GteL1NPcy1S0kVB7KxMlaIePKr697hEIH358wJ7x+l4AMpi4Fd8Kmo8baPvxqJopgxzO8x4DkoN2MOHOtR3hl/NACJBVpcJIVHKtVs++VmXvTFwXu7fu4qMjPpt2gdEqtbgDvfrc+Stb95SeVFX0BvVn5ZV4gg==;5:+PmYZLsjknIyXoHpH1dYzIB5HK5gIa+ro02jf+kD2nOMFRYgwWei12J1ZcA6e4ugzHNRC/yGZqr0kfs/ZT6y2qu71QyaCTrz2sQvbTMGsA+KIcnseKXi/E9LVv4UYc+UOOH7FyvCGqxKMYi7Dptosea3gHkTM04rja2xoA2Vt/Y=;7:l1/z2YU/ohREqWe2nTdiGFV5E8RNXlVoiVVRSI4J4G9k5RxNEQ1c2KWdC6sznTZirsb9EQC3IU/I/ByLagkVzukkj4zlkLR6vg9E5cPogqrU3LylYNnEfKtmjpelPHvZJaWnNtWD/g/ls0bj+w3nPg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2018 18:33:42.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a4390-e00d-4eff-2605-08d65c728607
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation for I2S IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 .../devicetree/bindings/sound/xlnx,i2s.txt         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
new file mode 100644
index 0000000..5e7c7d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx I2S PL block
+
+The IP supports I2S based playback/capture audio
+
+Required property:
+ - compatible: "xlnx,i2s-transmitter-1.0" for playback and
+	       "xlnx,i2s-receiver-1.0" for capture
+
+Required property common to both I2S playback and capture:
+ - reg: Base address and size of the IP core instance.
+ - xlnx,dwidth: sample data width. Can be any of 16, 24.
+ - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
+		      supported channels = 2 * xlnx,num-channels
+
+Example:
+
+	i2s_receiver@a0080000 {
+		compatible = "xlnx,i2s-receiver-1.0";
+		reg = <0x0 0xa0080000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
+	i2s_transmitter@a0090000 {
+		compatible = "xlnx,i2s-transmitter-1.0";
+		reg = <0x0 0xa0090000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
-- 
2.7.4

