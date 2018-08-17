Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193AB208D4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="H7+9GKSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193AB208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHQQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:23:14 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:10688
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbeHQQXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi5dVgd64qoOD8S7HdL5cmmqvjBlF/9Qq+sa//jtpDY=;
 b=H7+9GKSXM7K+iIVb9r5iP4Oyb3MxzFHVTN2pvM7hPYBOp0jS7uLVOrHa+YzTOD0iqJbDDYOvGUhNrd61t2vVZ51pFQ9J5BqCzpq3Jjvlgk76OZ6ZY/m25saluaOgTbJkEgZhzwRXF5RSSe7PbJaKouluXR3wFPMEdW1Ld6XOJiY=
Received: from BN6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:404:5f::23)
 by BYAPR02MB4455.namprd02.prod.outlook.com (2603:10b6:a03:57::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 13:19:46 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR02CA0037.outlook.office365.com
 (2603:10b6:404:5f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 13:19:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 13:19:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53541 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqefI-0001ir-UU; Fri, 17 Aug 2018 06:19:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqefD-00062K-S6; Fri, 17 Aug 2018 06:19:39 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HDJaYf005724;
        Fri, 17 Aug 2018 06:19:36 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqef9-00060p-Sp; Fri, 17 Aug 2018 06:19:36 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <kyungmin.park@samsung.com>, <absahu@codeaurora.org>,
        <peterpandong@micron.com>, <frieder.schrempf@exceet.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree binding documentation
Date:   Fri, 17 Aug 2018 18:49:23 +0530
Message-ID: <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(5660300001)(486006)(476003)(446003)(50466002)(48376002)(126002)(336012)(110136005)(54906003)(14444005)(16586007)(51416003)(217873002)(7696005)(76176011)(316002)(2616005)(426003)(7416002)(6666003)(11346002)(47776003)(478600001)(106002)(2201001)(50226002)(8936002)(4326008)(77096007)(63266004)(107886003)(26005)(39060400002)(106466001)(186003)(36386004)(81166006)(36756003)(9786002)(356003)(305945005)(8676002)(2906002)(81156014)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT010;1:lc7F/kloV4PA91OsfqX2xgfxklOQR1jQ57/SwM5XERG4ZH9+7XKsjEGJlLpWuvq+IsHdPDz0pEST0PQs0b0qTtp05S+YzWMOfAFETE7YkS1yfM9JhWl8RqIiw8ihyX8R
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e85e0c90-4993-4c68-1f03-08d604441a15
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:eS6DWxTnOiMcTDdjESzY2KkiS0cd3JrzG/A5MpYvXbETZh0we3xgYtNa7G7e/N+RnoUwrQLDFzBeNDqn1wNzIMU2K6YYgO4M67IoONXey5Zbv5qc3ydd1+IP04UzNbN0lDQK9VAgUkdS2xCNTVmS2V4eZUgVi1ioA1B6PuGE1rfk+4IrJv0oJRdS6XFGDJNa/T8XRZOw0u3fZnmYfuyiSK9WvFEFjfpwoA2KDlw4yH4cI3cjMf+YxChlXrrtTV54GdQExgX2e6u/X0Mwp+pVS7G/G2EK2/zLSRr78A66QN1ML/6gBlTr0vMbAGnIaKdgfBRT1d3FBTF8yThhnYDkTwVq6fKJpaYArbPBKeswfQE=;25:pe5EksHqDYq0VIcG/y5+1x/WbaJ+8Tk9K83WiaMYde0nURj+qEH7lUatJCAwn+Xt0Hg0NPNyZcACHTWK/h8ctdCMm+H0qMirA1R9BNxqcy8/pJoJq1PJmysNqDF4YCCQP+AQd6lJNXSg4TtCFLR8gHd268mTKu6hEzaJUTkpnfWWczl4a9TTrD7b/RzkarFF9qLJCvoqA2/KFeE0BXaGUegyiTgSafEb7xpPhXgkpI969DN/L/ky1r0YVDJ7eSscLbrl4HjmChQtWiP3Kvs+L2W0NNTg1HEZwwK1+SlPQGJILlZNc/9SuynQhTHRy3jk/xz2KJQNkVQyef1COHmubA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:rSc4vFXnZFhut+vnB8VDajjBqawxg2xG/BZNyNmhlQ1Wr4lw9xFTr5QhhL3PsZevn6cZGNpSHsmA9W+/Y9LbEhtfZnnM4RyBoxF3B5ThvULCPtVHJWaBAnP0k00u8hRnN4rjyigyms0xBk0ISn5mbZ5GZ/DZpGbP09/ZG8lhTEh7GEJrmCiOqqQi+npqFiOcTS23A49YSlQpEQdqDlbPMSZgt6T3eZBAnCONeU5h8O0=;20:t/jAdpOqS2LBt8TjJD2nJeqAFGvZp3MtilXEWvR9GNGL4GdcSMFf4usUX/sIr2L/qn4nNk9VgXBLVJzCAUNAE4vBoIlyE7TMAJSFlRunleHSFbB7ocpVVwA5c1Z89a0lFjN/kTWUhSHiIIyBigzyOnYadF9GGGraOCiyBuBEgqHJlEFr6+uzdvOQM3D6IhteCcHMJ3/a5eAtNkT49agfR5PEfpu9h/loeNVkoSqbe5GXDu9ywQAt5bj/A1Yq4XeZRUPf4Yn0RcHdVruCYeVTu6eP8r7Le9WuId+ZbgH82PoTFs44VRVBmAtUitzG7x2AS0zcmRbwOXu1dxHGFiiHCb/kpp2xc95O772EWL2/zkzjwskTd7FJ6+HdmIXH/ASCUlRcxzsjNCfs+aCXf9hfJnNSR41OcPZedCDrNk7DRG7UhnBbTsyL/xXwUTqqVW5bwitXZTGtCkNdDkfy4uV4g5BkTb32fl64nqGIWuTdBX74hGfQ07VcdQK9Cr15Fj2g
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44552A3FEC251A6A5F0AFDD4AF3D0@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:PF6wKaw0xwO4BbTF90kvT31M8zt5Quccn9G28YuwCUiTNxRRqyKyZXAZlKTPdKIQUFfd2llzjWcm578DKK6sA4TgCzQTLIZzAyF6yPX6ezTAVObvDX44fEH1HpQVUU5dSwckc2oQA3uvvWx/XJVpTKZKwxZrMgwVJGm2FaBKLhMYqu8NHv2Ky+0ghEApMNhanQLMOzLy1vC2y3zFZV0/8QbhmOP8PCIt167rgVS8exm2eBzh71xz88R4PnkbxuqhudfKYnc+BZJXRoAm8uuvkIVC/YyoUPNu8AoSpuMzv5X+YkCkU4WuQttZ9j5rZU7b
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4455;23:0aq6RMknjiepZ86hCDqSVGWsauT37QYCf8Cm/H6W1?=
 =?us-ascii?Q?YpbtPyHHBPWXBmXNCdyOiTJ7Y3nyEGPljo6nQuAcjXRM5ddR2mefez6qQVhP?=
 =?us-ascii?Q?ISo1fXXM7idu9Z2s5tZSz4MuOifjlinDJk+5x4QHVWC6J30B9oBBBILjP4h8?=
 =?us-ascii?Q?LKr+UXV25NQwo0bHMQikOKhQxgwrTgUEkTXy6P3LOtNIozheI0TpQYO8IY7w?=
 =?us-ascii?Q?c+qbl1yALRWmW03EsC4gkAmLFT+4hSNm/2WPUFphcghOyAyfZc7HtoW6yd+g?=
 =?us-ascii?Q?H2wcsMWgI51zO2ZeA4Rd2m95yXcqd3bXsVhRMtkDVhu8Z0yV6yDKoPjBy9ez?=
 =?us-ascii?Q?XgLtzNDEYAO9FAbaGd1fD129rtHudu1tZMhePgC6lvk++m25+OnqgNQMtu02?=
 =?us-ascii?Q?Ao1JapyxJNCtXItU31wVjBGZFOgwQd0ISECgo+blPpOULevhUQGkpoRSzIyM?=
 =?us-ascii?Q?q9UFEdBfgnnPmn/KjXnSX4RPjQIqHz6kU+b7H4EpdeBf+232C8N5UF+ZVrL6?=
 =?us-ascii?Q?nidID2m8dBpvKT7DNvei/ptkFZgK4n4q5S2ARmU02v4LeeR/vMsJTg4OxBKw?=
 =?us-ascii?Q?d2JUrFH3/fAMJaNCDsmxISAMJfSnEXJgkf2rpmQDmDoUAZ8hSN5NBDxgtKxo?=
 =?us-ascii?Q?Y8wQJmTnWdjyXcPpMtBxPpZMDbx8I331APGh/Wk0JGxEjNLQzfzBSUucYEh2?=
 =?us-ascii?Q?kCZlKfDe+2o4MVYG2qA7MctAYT3zf9FpfmijmB6ZRJjn4M0E6I9UdwyEGs4g?=
 =?us-ascii?Q?nm9QONZDYw0isGdMDTdb/3RNnayJMQbO5uJViW/b9An+Nspdb0hF/fmdfgS0?=
 =?us-ascii?Q?w6Z9eMtDv217hjuQM57zNzDPevDVMXATl+EBGdMxvL2y0XH/gRQCl2p8q4Za?=
 =?us-ascii?Q?4zdYw/Zhhhj3PW9a0ZxE8ug9jS9oK3Nj5p+81q0Kx/U2B0pXrAyvzIq2niYK?=
 =?us-ascii?Q?IDwtBKOnfPJciMm40/lJKoO9HxIPR2G/WR3lf5ZOqP/3oHU6PLkYIbV92FgZ?=
 =?us-ascii?Q?grv9Uw8lWBWv0cnbb5jm6DjLBGINmtowaZdCL1Cm/oNlG0s/gKC8AuAoA0Ec?=
 =?us-ascii?Q?T2UjUAJ/+0bSbZQ7w6SYwoRJ4c8UU8nO6QW3Y/FUmiB7IDuod+V5JrDMAZJj?=
 =?us-ascii?Q?3hh593LBlYwZklMMIV+r5m0uTRc4wImY1Z0BSFk+pStldz9Ziepy4YiFhgvQ?=
 =?us-ascii?Q?JQglXGW/dL/MGE+LykznbnbEMTSvB7GUzt649ed2lr5MZTkmWY5ygWaS5y0Y?=
 =?us-ascii?Q?hsj+Y3/YKKdydNjF4ZKEBWq2NCrkwYj10Tj1iBX?=
X-Microsoft-Antispam-Message-Info: sLw/y+zizX7z/KI2yTxWkvccG17S+yrkzndWHEexU5e0JuB7lBQ1b3X+bcdQhPhlHb2ecCZxEaT9MwdoWYThg0yy37BOXoLHukZ69wwvVyHpjyLub/L9+TSFmYsjKEL6KSN/Cgx8JgsKcy73fFBBe7wHbC+Z9HkXb3iZpGHE/DTpkwoLxFDn5ZOY0bJ4p4H3dWnkFwUnnWudUw0G6xFSyDdJ5HnnI6uVB/S4agjNb2Bzh2iK519vDdopow2FAAWMgO4Q52vWvpo9kgiHQ0A9rip7h90+IPNobRVz+erlC2qrlxxckqBe0/Oo5G0657jNje4Qz+JmTPORBeKsh4AOXRPrzudwt/U94l3qvg+sVU0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:3hv9sORAT2TBwjv0sM/GE47BdNGESXzFK/20p/5s9oSkIdvpC/E1rbfv3oZlh3L4vmMK4aaXAhgD73ig4LPczakGnz04zpIbj2hpDoYzjxm1UoKeLNL71G3Ww/+8pAzEu0ZDr47JZgg+SIbLMzeFfXZGIxCBrQdiY+7qavFLPFNSnYjfR7Rsf4Ue2S31NGa4E5VrM6EeCOSg4Ok7oNowSFqqkiEpITYF9iiLGOTlcMDMSEYsuApA5G80/1zFRY36Ns46JcUPv7hlzbVj4MEeL/HoTeoHmzji3PYgSx6KBANyxo0Yr4PGeQBm7in71lfNfu//2+4+/hrw7BCRF6Y6Bv9h88LF6QoDh2jbzHUxKo30N8wTU1dFOaepOqaTTUSC93iWBGFxNejDgowweJzIa09dVWM3PQpfCe36BgNHM3NcjP8acrkcS4JChGpw1zU8P2oYBizE6hIbiJxwdWbooA==;5:1cV7qsqUskvUBgq8+A8LgtrYn/2o8Ou0kTMsndxFgx5TmUbWOdpk/+NcgT42pUD5++2YgdfXuTMrNI4igOh9OPZ6TdqAj7KLwuXYVYxSTtZUqRSJWbIi8kQK/gKce9kSkeSaSBo8O+ZESwuIXDL+9Zl3Q4dPhCpPA9yf0VbQ2Go=;7:8YImgwYKtP9PiUFfG9BYdsIyQaWI8ZTws2vk4gUbe2pSFIrg1Bt/h3I77YXyOriyXVi5c2MxOxceIW+noE1HzXMCQc5AWr5jRzteuzgCJAWKpHdyQTjExOk23wffW8g9t0X5AvlGHbpvZE5/Ngfsv5GyKMJUdacpUwQmF7NBHmTFmcF8rXIAk+/pzd3AvP2e71TzQYcfPReUxEFyIuaV2VMjm2xlyKmR3c+Pgkrhx9JJUPVLaZVwpPXuJ/4MACn0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 13:19:45.4351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85e0c90-4993-4c68-1f03-08d604441a15
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the dts binding document for arasan nand flash
controller.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v10:
- None
Changes in v9:
- None
Changes in v8:
- Updated compatible and clock-names as per Boris comments
Changes in v7:
- Corrected the acronyms those should be in caps 
changes in v6:
- Removed num-cs property
- Separated nandchip from nand controller
changes in v5:
- None
Changes in v4:
- Added num-cs property
- Added clock support
Changes in v3:
- None
Changes in v2:
- None
---
 .../devicetree/bindings/mtd/arasan_nand.txt        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
new file mode 100644
index 0000000..234d7ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
@@ -0,0 +1,38 @@
+Arasan NAND Flash Controller with ONFI 3.1 support
+
+Required properties:
+- compatible:		Should be "xlnx,zynqmp-nand" or "arasan,nfc-v3p10"
+- reg:			Memory map for module access
+- interrupt-parent:	Interrupt controller the interrupt is routed through
+- interrupts:		Should contain the interrupt for the device
+- clock-name:		List of input clocks - "sys", "flash"
+			(See clock bindings for details)
+- clocks:		Clock phandles (see clock bindings for details)
+
+Optional properties:
+- arasan,has-mdma: Enables DMA support
+
+For NAND partition information please refer the below file
+Documentation/devicetree/bindings/mtd/partition.txt
+
+Example:
+	nand0: nand@ff100000 {
+		compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
+		reg = <0x0 0xff100000 0x1000>;
+		clock-name = "sys", "flash"
+		clocks = <&misc_clk &misc_clk>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 14 4>;
+		arasan,has-mdma;
+		#address-cells = <1>;
+		#size-cells = <0>
+
+		nand@0 {
+			reg = <0>
+			partition@0 {
+				label = "filesystem";
+				reg = <0x0 0x0 0x1000000>;
+			};
+			(...)
+		};
+	};
-- 
2.7.4

