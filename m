Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B1CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205812077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MLjm0jUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205812077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeIDORO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:17:14 -0400
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com ([104.47.33.75]:27194
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbeIDORO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVK+mrLzmMFYfMMJCbBvPUeafP9hWSEzS6iWlQt7PmA=;
 b=MLjm0jUmfprXWOukJbbI3u2QH9w2VmkNugryV+rwtll/OGLgXmb550ArGfkHpXhJfaMtxyzVc9EkhYW2axHcs+kFkpfzlA2anxSToudr2paICyImzUcwi2LsPaE6ozG1xW25m3wxBaJgvQzQ+4kTvvKknrRTa13B3/s3cuBhIR0=
Received: from MWHPR0201CA0003.namprd02.prod.outlook.com
 (2603:10b6:301:74::16) by BY2PR02MB505.namprd02.prod.outlook.com
 (2a01:111:e400:2c39::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Tue, 4 Sep
 2018 09:52:48 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR0201CA0003.outlook.office365.com
 (2603:10b6:301:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.13 via Frontend
 Transport; Tue, 4 Sep 2018 09:52:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 09:52:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx80t-0000SV-98; Tue, 04 Sep 2018 02:52:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx80o-0004un-58; Tue, 04 Sep 2018 02:52:42 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w849qe59018776;
        Tue, 4 Sep 2018 02:52:40 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx80m-0004tv-10; Tue, 04 Sep 2018 02:52:40 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/3] Add nvmem driver support for ZynqMP
Date:   Tue, 4 Sep 2018 15:22:31 +0530
Message-ID: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(16586007)(63266004)(106002)(356003)(50466002)(316002)(6306002)(2906002)(51416003)(305945005)(36756003)(7696005)(110136005)(106466001)(48376002)(81156014)(966005)(47776003)(486006)(478600001)(2201001)(81166006)(336012)(186003)(476003)(126002)(9786002)(36386004)(50226002)(8676002)(2616005)(6666003)(426003)(26005)(8936002)(77096007)(5660300001)(217873002)(921003)(107986001)(83996005)(2101003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB505;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:vgNkwalz8x3bpXPzHx31Y22aYdSu0r2/oXJkSwCNuaKlVvVi/TM2H8WZ1PL4dGSuzxOHu9/jRDEVXvduKO6h3OSC8zwq4sg6M0yzCgGJBeLatXIiT4gmxr4JkNVifguK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f6cdd58-6d12-4564-caaa-08d6124c2bb0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB505;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;3:izhTuckGAsorv8Ik2OHRMB8K7HNZlbZHb4jrFZP2EPqdrrJyM9xdsQmkFngULd8qjsvAg1sTDP2k7L0PAhhJ253JRtXU4fJSSUpj7W6XFRVaFuSJSMA4BNoyGk7QKd1NDgymh26bhcb5Q+0vrmb2hHdZGU1pXSYqZ3AfKVYex85/SLklHPZIDboUWtJbb0/v9n4wMYTnL3cpuF+mVae2Wj2g2vWxr6BuWWSOO4yXk3Ijj8JqWmGGvmD1dPU6MAi8vQ0B81OSNYPKdIULEnz/uaPEn4gzCR5ZAemMZai3z3eGJEsHAK1FCDAeDne3qIATa+E7dlD6x6WsWqObCjaN5ftQznCXxlrWTXa92k2y++w=;25:JLOwRgyxxyAZ7yNSvslqUhc3cAnRaesTyQ1bOkiIRvoxIgFJ7y1L9wO9zuQzdhnEMjHTEjGUEeX3CQiNXG1je3jc7YIzbdZrTkbfQOmd5kobZGDvdXbjN6rQ22J/fqu385ZZtoSDr/JpQOXzRBFcVX/mYY9BVKt7eyryjpKhUprNdY1XlNc+qCYL2oGpj8bORqCA/2DqNaQBQSv55IRVwXQeCjbxl3SRdvbTks4/Lk3xZ2HPQLDSuL+4y7DygaxKgi8hQmDGIv10OK43xZ3fbvec99gpSGh6Cm0bITBaJ9b1JFM8MdCrI4frY2AKYxc6plAi2kj+djqcmZGIu89n1g==
X-MS-TrafficTypeDiagnostic: BY2PR02MB505:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;31:XCYPlUj/81nCjHToXXrzZHTGZv6G+A3kHWxOluOSB1U31Zvh+ScN1YKkWMrEsj69KyJWVmCsgfu2Cp89cVqo53wg/+rc6aS0K9ygXHvQu0Wj7ewM/WyuqpgpJXSzbRJujImXioTw0t0DilsVj8bZgExlcwTEIfmB0PSXj/0YH23tn8nNXRuDVbUX87OVlE4b7pNaASGsbfSNQ7jOwjN+8Nvwj7N2Zw5A9YdoC+LvjTQ=;20:8UoO47pzQa7B9myOZvC5zsyzwy9H28jlbnVHlmSDx4tRHLCtPdWvW5R7Zda4Oeb/uiJdQUNTugnwRn4RZoSxjb92lLHeUZxvxZGxoqBFquT33MRNdDWfEwtrMotQ2QM928TxEv3KxxPm8Pu+nzrPPHaQ6WGpSziNGyMA81TXy6j2pUZHc9ilHiwu8XL8WlTnc/X4u+JEWDWVvciz35ePgiXVWRPLgAvs+oPkPijSjITWzoip/v7Z+9Rx9aKTQKpbmjP0TfSS2n+ExNewbomzB4BI9xmBYKhlny7xVnkbGsRfP4u0JmZ9m0rAnn+ub7DOjpM6iJyxXcMMTWvWVBJ7Z94fYz+uD48iroEohwyQXX/CYIGfw+acwT/AyyzAQpBP5onf09Uf6JEadkWz20sDyBe2VAilIg1xYol8XdoBjSehl+h8Rv+SIklUsyEqLBB3l31GRpg2a0YVQW0cOVKlFifh6ZXiAmGngDiM01Ko+cy6TtD3lfoA6hvtCF3AA1Kp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB505EBA713D380D94C6CA1A7C2030@BY2PR02MB505.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BY2PR02MB505;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB505;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;4:A3v98JarBGtyt8xsW8X+jvqSimxj/lgbVSDSmBdaEmlPUHZ80to2Y60+MOYc9Pc3TcfAuw8GdqZLlP/sE8aUhQ82XjzEB2DbKG/R48NXQ0qImbqyzlaxtX1J9kNUaCCKvrfWb/JmphsqbHWC17aq4UBuvWg1szv7rLoiRR/Wcq0/kU6nqWLwsXsnGPp1s54L6BAcpc+Nazv1MY2NwRYh+4czSyXBcJqEHUR97CJqAH1FvjJq4XCM8NFEHciHorDa7hyZTODdnYZWokebQ8A/Ew==
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB505;23:pPuzBcFcuFiHjot82UFYGfJawCwIW3R/fuTP66S7UJ?=
 =?us-ascii?Q?r7brF5U8kQaUV6zUJgFnW/6nDxFX0B4j8wb4DlemPlQMDcWY0waAt7ZcWNv2?=
 =?us-ascii?Q?xWjYqLIVuRVVKVpJU0nfrDfyP/B8XkyhuRGvQqPDMHrKWKt/z+ETYGEU0eAR?=
 =?us-ascii?Q?58fyORbUWEMVu5d1NmSBFIzx+83R6v8aT9F31hsDmmxtzqtC1Atw0/fFvbwo?=
 =?us-ascii?Q?Tl0jgAx84Cl72H5dZNyQJDV/fqBI5tzPBvgLWsZb8y/e79nNuxqzKrWh2yFv?=
 =?us-ascii?Q?MjSymYOX2ztucP9ko4YivdPVQ19m+fAxD2RwTIg/93bHTl5Nvf4+YHKGJoqV?=
 =?us-ascii?Q?P5/J/SgtoXdF2V3edoGi4JpeMgV38jYsGaJR/T9cnBBpaPARwmw58P/bIwkM?=
 =?us-ascii?Q?T5Va0mc7qjWmO6mXaK6AIR2AFB96XtPM1elPaaWPpTgCDHigSu/p3km1cQmk?=
 =?us-ascii?Q?GD8Io8JELSTIhr9PW3SJu8kBWmxt8c2rtVw3vX8/viPwdMBvMUEEfY7Ju6NU?=
 =?us-ascii?Q?pqhKMcX6crnT1xc1SkTcrx8mVrYk3wtzv+7idGUTYv7FyTjbFPNyuquCH0RC?=
 =?us-ascii?Q?qcW0hPDOQi0T1cAuwdfaksOPc4I2PJ8Oegx0rxnaIuxKfQzdgfUqSsASEmYg?=
 =?us-ascii?Q?BYi7FpjhOVMk8LmY/OxcdeAS6gY7db/15EF8m4ri9la8I1gxFFAVYC/M48Ja?=
 =?us-ascii?Q?6cG5cTgLZmt3MiZN9M5w2wBdFgZI6OjvUVlsjoQfGMLwU0W3q9yhrnloNcVe?=
 =?us-ascii?Q?5a+dM3Co0MWvuvKusng/SqbSN1cYbSBJtsGXSyZF2VdH3CX+TlpvqRD7gybe?=
 =?us-ascii?Q?zJcfYIgBwfoFg3JIENdcdz0ifGWUWDZz4WT9024i1hd68v26EmwlE4tFwl69?=
 =?us-ascii?Q?NfYa0CpDKRDKBuvNZ1DDEfl5IhsB6kZDFCxwrX+wfujioEdWwjO7raRAF+xn?=
 =?us-ascii?Q?9c2Ool0dm8HCWXnEA0vB+F7l3xiHFD6HNv1W2RFI8F5xw7mR8ZkqIvbuKbYZ?=
 =?us-ascii?Q?R3JfUddW8QCig9empCz9XMYhgldCpU5bTLlWdfz2nnLbutBVt2IrfJ5Yg3qH?=
 =?us-ascii?Q?a90GYtFFM3wT49NVt1nwMA744RnFrwlOWZnd4iZJZMz5I+nstJacQaVJ8nU1?=
 =?us-ascii?Q?Ijn36II/FiKbLDM5NgwBHo6KXJGX1oQ4kGZd0fZ7b7cgNYS++ZGLRj7EVWJC?=
 =?us-ascii?Q?dkZz11ngvla+PHUCuJ5tkhXfsqleZoNplORieVPPjX8VooA3E0GnRH6w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: xdBbz2NAbowVyZE0SS+h7gQhdPxnQM2ayh6wYgkfKYm5CXA9iSMbiJgkHu2FFaXRbfqmDoilmeEjTF6wm5hK92kyxk8PqMmg5+qK10B4Ve/MaxNzwx2sq7Qf2hDslnFz0SqJFWvdmY2zuyHGP79EoSoAFusX7q4eDHray70asE3bFUmqboUlM+4gLTT48QUVi9rxwN8Tsjv0P0b/+bunAc1NBeDjs+CTE+Hu16a8TfQWs6py8yyMU5kVaadgc5f3QhtkNMYCt1v2mj5yL90Ov/PduteOVIyA+HP0OWep4PqX1TIMlmzbzdcP5F1duM/L8QI/safCwd7rKKBgbQnmjFCOTZIJssH1kUOY1S0nT4A=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB505;6:FfFFjieKmCMpdW59ub+II/p3Tsc16Bo7AC2Znr7ab5wwee1MH2R4bESwD6QO4vHKYS/YdBxvDVcpXabbXK7LDCV//RXWIMQME6X9Sdv7tl0yqEsvSD9sKleB4fFI9SDS+yzlYkon0+oy6ngmEc/MkksljYNd0MAAZI//cKiDJd3ISpMGZGa2LawUVJsY/qjijrENzGFTIlBwfgFSgfW+auLc/95kLAfkFhm2KhzAsSlpu9YATJhyXsfgpTHoLHXbUuXkBzF3pWqnZuMlHJTAuMOfwx1E0okubQ0XM3g25eJxrFpZ7ydB5/JU3bJFAWxhb1jEaZcZi0PTYP51hSX1/LX+xQ+GXPu887rGX0FudO8iKrFTiIbJMYrFEBVppdwvJUcc7xnQpFgEhYHnwmvfFpHGYQAwDP4iUXcvH+xr7r4F8B4tPe5WIDWdwMWryd8mUtxtW7kh9lpbi8xetXdAHQ==;5:H8jciPKvudT1bGScUW3M2fUEpPIB6d8ACvlXIs/WFCQLdGbzoIDUZvHrx7VEoPnjpGg33XW+LKWQsVM0xHg7auJ500NHcPKa1wc9GUg9WJlzHUYuvDYG/01Rd+pZJeqQFyKpwLoEYYtGjdKVlukZDjDLYXryGL4bpnYPIBl5Vpk=;7:99gtFgXfZ45xJGjEhAe1XuMZTMqNxzMP1GRabxWAWw3f5UGL7jbKdcptcbGoPu0u4tGR0jQy6BTdWvm2Sv6Aj38kRDEF7UIJfYKySkSqnq2Si6EQ2l1ob+TekoWRrgxRr6OZccPPe3EXeLgHqfGvSzsctPxq0xWpCVdFXnIBgcJQxuSxeNuOpXBSE+v3m8RGwmZChn3hNiyrazg/+0w53uM1Wk7ZbBks9cMQmMBzz7gRv3XlNPxW8SRtCBt17VLm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 09:52:47.6824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6cdd58-6d12-4564-caaa-08d6124c2bb0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687

Nava kishore Manne (3):
  fairmware: xilinx: Add  zynqmp_pm_get_chipid() API
  dt-bindings: fpga: Add bindings for ZynqMP nvmem driver
  nvmem: zynqmp: Added zynqmp nvmem firmware driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 35 +++++++++
 drivers/firmware/xilinx/zynqmp.c                   | 24 +++++++
 drivers/nvmem/Kconfig                              | 10 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/zynqmp_nvmem.c                       | 84 ++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  2 +
 6 files changed, 157 insertions(+)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

-- 
2.7.4

