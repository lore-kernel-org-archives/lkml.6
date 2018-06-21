Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933FAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6D220883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HyAIXohl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6D220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeFUGmx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:42:53 -0400
Received: from mail-co1nam03on0085.outbound.protection.outlook.com ([104.47.40.85]:62528
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932564AbeFUGmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of2HvzOUCf694FH47fYLjYVJIvv2ClAwoYRr/uPs3yk=;
 b=HyAIXohl/iAJJqu31SNBsQIQK5bHiw3pXPCkVckQYA98Vin8bIeKM3PtPI5zDFnQf2c5kUyGGqSIRrrGxkaAhLwfKN7L7q04nrHaQz7Yfixbsil2cfYN7YNKyDtQx2NjatkDf+6xNDTLnKnPD+Khz89vY8T1ilCyrQ2QDkF8Hw4=
Received: from BN7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:408:20::22)
 by BLUPR02MB163.namprd02.prod.outlook.com (2a01:111:e400:849::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.863.17; Thu, 21
 Jun 2018 06:42:46 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN7PR02CA0009.outlook.office365.com
 (2603:10b6:408:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.19 via Frontend
 Transport; Thu, 21 Jun 2018 06:42:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Thu, 21 Jun 2018 06:42:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52985 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIr-0002SV-Ej; Wed, 20 Jun 2018 23:42:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIm-0005pH-BX; Wed, 20 Jun 2018 23:42:40 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIk-0005oY-Bs; Wed, 20 Jun 2018 23:42:38 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [[LINUX PATCH v10] 0/4] Add arm pl353 smc memory and nand driver for xilinx zynq soc
Date:   Thu, 21 Jun 2018 12:12:27 +0530
Message-ID: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(396003)(2980300002)(438002)(189003)(199004)(50466002)(2616005)(26005)(426003)(126002)(51416003)(7696005)(476003)(107886003)(106466001)(77096007)(486006)(186003)(48376002)(966005)(305945005)(2906002)(36386004)(63266004)(36756003)(478600001)(8936002)(6306002)(356003)(81166006)(81156014)(47776003)(8676002)(50226002)(316002)(336012)(16586007)(39060400002)(106002)(110136005)(4326008)(9786002)(54906003)(6666003)(7416002)(2201001)(5660300001)(921003)(107986001)(1121003)(217873001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB163;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT030;1:tZubLgI5rxoUUWm5CAkrgm6DUnqQYOfE7QYEE4lhdvCdpbFnospOsQJ3d0jBzGYuuNxK3HLOtH18o2LczXzBS4hXpSQZCdmjePFSBCsXkmfZYPixV2fQJaVn8WOlCxYQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6163009-b3a7-49fb-5192-08d5d74232c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;3:gR/PSBEXe0JODja46+zLBJ47CXJh6KVll62NCaGLCo+rXEOh3hofAYI2+7H/xJ1eShXXIVJnBY9FvuhvfREYnwjGFS+5flnOd8m8z6ZGqCdIK8sjMjtVezfr/H8+wsqRKrZ3X2/UOQcfwqxcxmWyIameFErIh7asY5IaavEr6NXHwSHzNUpz7+mHTpCSHjJjapRCQ6Aw8yNuq8if3RI2ZwLxkkkr9Kn6HEY2wfi3TSP+ItVoKWvcncg//dQsuvXNi6onNaEY3H7fixwvNk0acKio8PrgNLnvncAW0H0t/XQESVfahhqxhUs3WD3/BUCaFEtLnShwUecD8vjpd85z30lzeE+U0LhdKZIAnlAYQvY=;25:544TzrPkbg7JTZrkmPFkxHDlGESrKxR4b9zK8XAxrb3+sph7kT5ddEDNv5dDNJ2vbULcbY2rOeYM13XMnzXiCEUtsl4UzTNmFPiThdPa9tG9Kmf3k0cZ8Vzwgwtwy5qpVik2A+eydGx6nWkOMHlCgIgIU2Ew5BWZstlwet1xuZk59sMZjTBe+dKqjOZWF674ToEKyJiURKDpz/37NhpnRD5f4zM2GU4ZLMr9gITnPTm7Hu9tQNtatTVKoO8kobmByJAI5I8To47KgVxo962B1rD0HtvErMEWCLQe5HcOaXU9eY6gqvi//gVWTqL2rAoSONw3kTIDy+iwy8/iqlyKpg==
X-MS-TrafficTypeDiagnostic: BLUPR02MB163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;31:I8kSitio+q1Tto8dZ5YMKmrWi1nCv2keRZ0Jun4Zpkq9Ok9RmU4NQsPYAL/O+3/Gig5+7EUlWbUDiJY5KweAnK/lQg1lZTPx/2xNvwoTxnobsOBn3QZuxs5xr150RFy+jtGK93TSZy0xWlljlmbwi1U6JbO1Pi/FvKy8PcI4UfNX1rccumHIuOKdfG+osy33aiXZHLaw+q0HGQpPykzSTDSI82z/g4GKbhXhCZTzgm0=;20:B0qJGygYyGn3Kriwo12pN16xtlDm2A9aXStL5YsIb+5wP7A3YOukaXiLgB2b7i5ro4/UyoSN3t5WBrGg0qjeOknq4rCGnIyYRzmvlOTmn+yqKcb6s64bLhwLfaaKo1d/WHY+CeTxegKCuKN7xMt9eMeeWbt3vc4tr/wnQ2xJV9U5B9ycLVlPdzoVO+xfCxOXl0w/c+xncYlUkWOJ1fEMIIx5FSpEfpOnDUqNq8jcUxBwgTDJjL/n56MAV4GJZKX9djMnzhNEiGePYAMf+N7pxkLpJO5pOieVKKuzFwP5ITMLtq7uXCyvWElhqIvRdaA5JEBNkr4KytNjFFr/bhVzYyd2spvlPFZjHbttkD04qAOSNcABG10k/s5BbpJfkHawlt3mHACQWGRu3+IyoSAiXTN6xDjWGUwYaRKfBXlkC6Lczkzst60A00N2cCRNZLGQgJqkfX+H//F12s7ojzwJv58P7pNIE7wnkPRzmI4/IIfcGdpBzg/jjVwG97sKxkDk
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB16309809182EDA75D4A1866AF760@BLUPR02MB163.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;4:9qq4AFUW8DZwV4G9zai/BGu35RQdxveB0b8JxROIfPcZ58w8QYsZmTgiNciOm7ADuEd1WFeB8LQeAvI9qGMfb3LWrBouEfuu3qHRol8/S1IxCKlbWoI88FCvrGbcoNqJ6NmsKTr/xFsethdqIYTvzXJZ3XZa9eLUKeYMHFgu7eOZ1f1tykPTKc3uwBsHMfjoC1rBD/P809hIbQ8WuH59U39OU+UGJbBWJ015wVSxNcVLmSygsh+oJlVMbSGo9FxiVHReQHydZF0MyBKiUS6y+7/69PF5zMbK7IGDKgy+ThtKQWk5Ci3jdP0LeoKhBUVjYE0niSSKnXOhy8ekIkpf/piUc5moGQo90BGFivsH98e1gm9H/rUYODc3MIyom6Qs
X-Forefront-PRVS: 07106EF9B9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB163;23:mm0A+YHXEnKrFqX1uSxXT5NmVyAsQXBbbQhmiEUJyU?=
 =?us-ascii?Q?bGZmjZSrLrj7swhqmK/qP09hV4ZF2X0Brlr/TRMgbsqDtgExQTBqGfk/U2Hz?=
 =?us-ascii?Q?03IgKBa582uare+MDGwNGrB3vm3txCBrdfT1uN4jNW4e8p0SCgLzXx3fN/w7?=
 =?us-ascii?Q?T5+/rYGGhLa1qHkRAhw2nEOlwhfjjppZ+eJyf7E8aggUq63r2Dfd1AZKvgzZ?=
 =?us-ascii?Q?hR36VnBjrtWN8fAnzZUePik+P23j+zj14ZWcaDiHQGA5DUEWTtSVBJxV+/w5?=
 =?us-ascii?Q?1H+d6LxO2WhG45Xhzzx0cZvL4W9P7baI46VNK0douQHMBIiQRKlVPOoMwwHt?=
 =?us-ascii?Q?ipSNRN0885yHI8UZ9Tv54Mm66jZYG+I6/QmAWcIn1ZqI8ZglAtUax/MGnWuR?=
 =?us-ascii?Q?Wf11ouH5Z1sy+o2PVXvNxo1Yik3+dDuR8DIR2m7z7h0JZDTsMvtYQv/bHr7v?=
 =?us-ascii?Q?uk0ItuSrWazUuWcUQdVBFB5FEWIy1XpJFtCbkdZYOEQqAmv8mK5e/eLpQ4CZ?=
 =?us-ascii?Q?m1MNLGyJf27jBgmB615dlaBIGeBsaQOOFf4BlHlTMh30TRRNahFRv3qZXNYm?=
 =?us-ascii?Q?QbqPZBMQNhX3yTqTuPwMZagVxf8Fhr5e7sfUx1PhqhIWWcTV2MYgdKhLkw5u?=
 =?us-ascii?Q?dYYi9kNH6aQrIXNsw1Wk6ZzEnYI4TN1h+33OUTaTojeUr9toEADlRzxNwiij?=
 =?us-ascii?Q?XzAcaPsEGp7vaJIwMZhmjLSK1g4ei1ntpfWWyl3QT+fQm/YJnAu5Q0kZheeQ?=
 =?us-ascii?Q?XYoZEk3VsfuXVZZzq1QJI3rWQI7b/M9iHsXk76C48LS3graTTuYObhDkiyeQ?=
 =?us-ascii?Q?Ax4NvHF6NhgEv80gs3afVaBUBW8EGtpi5iaP0ZBMEE3VaCIadLJkFxVmdFVc?=
 =?us-ascii?Q?kcjEG/L1bYjdKel4osNy9GVUmBjTisEV04jRdekk6A5hSBOw2S6IN3HqNpn+?=
 =?us-ascii?Q?OG4zcL/Enc55oJ4/M9nZ4W4npOtC0BKBJM0sVvbDDVfqkLLAK0JR2Shv3JsW?=
 =?us-ascii?Q?33UB5FVa6COrxDmblW7ECzAh5p7g2rGy92cD5kUYjPTnaYZbwXELAPGcxe6T?=
 =?us-ascii?Q?ibUfwZzMlriyia3q8DR/4f8181CCk97B5H/KEr1aHmQ5zB8DZykYTTq8sB0h?=
 =?us-ascii?Q?68akPMlW3pSXKIvgLTBl1I+G7cZ6QnURPq9JtEnXfNlXggSxpK86QimGUJx8?=
 =?us-ascii?Q?RseGSOay182vFp4JtA5Zw8ElB8GyeGmGFVJkRX83XpiA/ftnojhwVGEVFizl?=
 =?us-ascii?Q?iF5bRA0/KkTWExf4o=3D?=
X-Microsoft-Antispam-Message-Info: Dy01U3jMhKaYCviEtbaY2BmILC9xlq8JWowWbZOYRWhOU3dMUQnUpZUBhIAsA5SDiaxiDKhWqhlizOgV2r9Vqm6WMIUBT2IQEqjEs6YslcT6fzpMpydKn23ZkPV/ynAMFDR7ngAWI6xLz8hyURnKILjWZPk/z/0FApob1fKh3vh0KyN2l5a2DtkjKwvVTVGV9ofhIG7XWBTc1FV+iqrn6BSp0b3+q4A6qjxdRzLzO9hnZ8B5LcKeQArSxGpBsuJtVRnaixQSTrD7tdBKAfIygyKJA0j6r7GCNl8GBiESqgEjp+3eteF2Xm6vOWzL0qtJ
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;6:O1nlt6f9E1c1HzPcneB0RFYWQVOGUGFZky3ieC55fGTaSydKsuZc9lRJg0LkplxW6NBJ99d92AB8xDL9znyYRRyigyUqCIWWBl4VgOiAqBoVPLkLw9PaEW9ohuZb7b7t+eJ0b9JewovvfPVGUHorsuyujfUCfOOMgxar8eHcAlPyZgncGf8fu0VTht9NvbnzV8NdKX+5hiTf+u4ztxvJx+brH/blhuI7WHpWSP2UEwSj5hppopZ124Rp2PdABJdCZ1GEi4jiyQA5lQ5LFlrrWOmsquTpU7Ft+b/6mh8AINhWCXThzDmKOL4QKLOU6y4kxKItP0OnqN99+hvUu/t38/E/Dmtp4X2+ADisut8t57FxlgmYiuEPU0Qglz1a6F71mdQNU1lMMcqLbLGDxm+kOYX+Gs/M19cJUWko76A/qJb8ExDR5dXwvlZbpR4A6P1nO62eQRT5BbD/gLE8ixGOJg==;5:qpzfFzdyjOe8WmlYSI1EKI7PaUNokC6BoFt7GJAXk58KdfZHi9ZSv5NiL7l9gW5OhByhFe/MMHvr/UiXGdsWPGQoDlgl/aVPE9vfGqc5T8Q/eRVL0KNPGKghvfaRgu3fX8IXVgbfDZtXEAraoWJg0+YfKPsi8TjUNlexVcjFqHs=;24:zjC36c7xHm4nSTLwCKEoH0nG/BxQ+Qu9NsHm3wjAPSbeiRm1iMFN7dXd+uNRAgF5PtkHHyNBuzSKftytFInksEofWNLCP1mi+tD8QWakJb8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;7:3fb2SQxKzOuFBpOzoFK1MUuDjMj29jCwZbx2Z3v7Rj2B9Zh51qbhrM2fa6Hby0WOCX84er4+eK/8OQz2z8z5lsZP59CAK8+pfaQeMTtaY1I8RAsJ3I0EZammLh7xHkXoBpcrwh5geZAdkxo/xkAJAGOnJimAaLzf7RGCHPSnHEDFmMlm3/inD5zyRw0a+3dgXG8N3FWufDXbAEzE8BWvuRJb2LQg7cVSwMWgObzulQOnLuCX/CBmQbx/+L6XUgBr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:42:46.0720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6163009-b3a7-49fb-5192-08d5d74232c8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add arm pl353 static memory controller driver and NAND
driver for Xilinx Zynq SoC. The arm pl353 smc supports two interfaces
i.e nand and NOR/SRAM memory interfaces. The current implementation supports
only a single SMC instance and nand specific configuration.

Xilinx Zynq TRM link:
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

ARM pl353 smc TRM link:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf

Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.
This latest series make use of ->exec_op().
Referenced the marvel driver as pointed by Miquel.

Naga Sureshkumar Relli (4):
  Devicetree: Add pl353 smc controller devicetree binding information
  memory: pl353: Add driver for arm pl353 static memory controller
  Documentation: nand: pl353: Add documentation for controller and
    driver
  mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface

 .../bindings/memory-controllers/pl353-smc.txt      |   41 +
 Documentation/mtd/nand/pl353-nand.txt              |   99 ++
 drivers/memory/Kconfig                             |    9 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/pl353-smc.c                         |  466 +++++++
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/pl353_nand.c                  | 1309 ++++++++++++++++++++
 include/linux/pl353-smc.h                          |   31 +
 9 files changed, 1964 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 Documentation/mtd/nand/pl353-nand.txt
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c
 create mode 100644 include/linux/pl353-smc.h

-- 
2.7.4

