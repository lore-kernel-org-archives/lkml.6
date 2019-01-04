Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C05C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD0D218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1NmzvslO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfADV4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:56:54 -0500
Received: from mail-eopbgr730085.outbound.protection.outlook.com ([40.107.73.85]:49248
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbfADV4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu9jKEjQMvfpglDe1otU3GliSLYmUZ2vgVVdA8SiBFA=;
 b=1NmzvslO1Nv/Wo4LHumJZRCGu7/c9bh9Raqe1wEpiK34P0PtSNj0yFqH9Nnl+UG+4TF9nMvAXnEAkUQ7XuUAAGTnzrEX5X91AV3z7ECwfqpskTAT/WSTpZb+Un3GoLVCkb4ZoWfNSiFBo++UjQvRSPa2i5BgXigi4voEE7oWPlE=
Received: from BN7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:20::20)
 by CY1PR0201MB1899.namprd02.prod.outlook.com (2a01:111:e400:527e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Fri, 4 Jan
 2019 21:56:49 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN7PR02CA0007.outlook.office365.com
 (2603:10b6:408:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Fri, 4 Jan 2019 21:56:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Fri, 4 Jan 2019 21:56:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSS-0005Y2-D0; Fri, 04 Jan 2019 13:56:48 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSN-0005nC-90; Fri, 04 Jan 2019 13:56:43 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x04LuWmv021616;
        Fri, 4 Jan 2019 13:56:32 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gfXSC-0005iq-28; Fri, 04 Jan 2019 13:56:32 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 1/4] dt-bindings: power: Add ZynqMP power domain bindings
Date:   Fri, 4 Jan 2019 13:56:19 -0800
Message-ID: <1546638982-12954-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(189003)(199004)(107886003)(63266004)(106466001)(9786002)(48376002)(44832011)(72206003)(106002)(2906002)(336012)(36756003)(478600001)(486006)(110136005)(54906003)(16586007)(5660300001)(50466002)(4326008)(81166006)(356004)(11346002)(81156014)(77096007)(8676002)(6666004)(8936002)(26005)(446003)(2616005)(51416003)(76176011)(7696005)(6346003)(126002)(476003)(50226002)(47776003)(186003)(305945005)(316002)(426003)(36386004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1899;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT004;1:QByzLeL3PUaCs5AXu09vzAneBBeslEW2ip0ZQVsgFQUkZ9q+wYw43cvXJgOeixUblES1470SCGLmQliisE0TFJZfBRfWSdI8ZIjs2vTfqp6AN16xXsjGhE/C9n24CSi4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75eecb22-9b61-4ea9-f0ee-08d6728f8702
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY1PR0201MB1899;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1899;3:WtD5Z7yUDWatQ+ydYLuFTDh8kixxfA3DAE67XvGKdKdb99UjXE0E7g90Q+jjO1aoShiSJIpvzxSl41hKeNb2fJxu4+lsn7bxj7UwtCUsfKE/C2iYsThjRi6jc6GQyLQ3Qp4JFlyu7vYs7GVjqjDs5EG+J+dplautRUq0EqY0kTfh3XkV2mdAUCgCScmtaCK9USobL/ejKJ2RWnOLQIazbrt4yd/qrTMDDcj2wzSk4glLkaKnnkHK+AeLlrvXnu5X1IQWuiNY7gzX4pi3ORMZCZcC8dKaaBQ21svGm2sicv8bvbomeAwYgJ8KYmE3tCNEnVgwU4tvygzMQwH+tk/KXUKAa1QRXHpLjxIfXbGK4vM8PL9aSK9pyXUPt/XGeZ2y;25:AaaUIFzeItgoKNdvUt1O4ITVwxREseVxcDTPCxgtIAneSNWnNHvXPponHWiXkhpq6fjul2pX5Sg0ypbHFIOIFcHuLhUnk7/81H4pCZO1NsFGIBRgWYfemVmH3OkrnnWdFRcSIVuc9WJTP50xq0TKERpPSAxiEGh3SwwOKHJOpx+Q9oDCWfHlzz2vrUfB0/LnxS5C8nnGkI3TMEMdmGIz9CTnvO4cpdIFvMMDS8MauSQ+cpmWnbql7KuGhdZATISIA81OVvLVANSoYzgXz01EByvkDnRHV4N+kCotduSvAbOlgvAKWKYqj7XH17xLp8WSd+CEX9DXaKbP/RC6Kqfpwg==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1899:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1899;31:/yo54YrAGZds1HccwsMEJWGxHqmLMCQcH4gd90aIW7jSvdx1+iWkOL0+Bi7bnjLLZvnloiR0IeMkC3ZJhSoaB7/cJkS2x1c+tsLr3xUWO5vI95SCAmmTrAM9uQQ58mPO8WX0N9jl/kwKsdhqIyrV5Um1f/Rem2oBft8wRG+YOOy3mgqyqWOfc/oKWv3fNkqWtJXcbaIsE7tFB1aN6LiOOZXATe8c1QYj9u4mSOJc16U=;20:JDF8FVe3n8VejGdgscAyYOyp4VWyXxQvXKxX52bKutBZDzE/MSAN/fG3p9Mm2m+fCuUgAKdh3b5TtIdtsYUV392M570GKD+LbKvT3DUrnl8WTYXfvFlREleQWeMktRZIc/Ao7vXMN4NKpIFPd20JIfv0zTK3dD1g/kdVrVb0m3zNE/fQB375g2pBMrwcHO5gREcGNstT6u3pfsgllYRVc9Uk0WPFk35qgEBGUffPyjnJpJGnnbWXP+2KEQLkVEsZWexECO0hVFmiaHjQsnK9/ddSm6cU4J71jbY0pi/6akJ/ZjNdB776PAMeUEnyszJbLHgChu9ebCwpBL0W/irmLZIW5xNjgaoOUzQ1sGHo1we5L2xAKK++7PoKisjNXp0+twrZglGLa3oJEEUCGFv+26cqehFATtQqXkiSPSmVFDvJ/uvywnRL2WrSrZhjQ6+2kYXUS9gKa585FXUS3pSRt1a8eZMKI6mKgBp7pCsCBvIgb7olpXO3c+N0bqxOcl7K
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB18991D4CA5F3D5A824BFB3B0B88E0@CY1PR0201MB1899.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY1PR0201MB1899;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1899;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1899;4:xpSQ1z1TNHj6SzB3RiiEG8840f1lUng3LNL4PwsusW/2/nC9CdIYBCmbBqr0FCPxWEyEhFo9dMLPwopFcTvjC9OQQPW7/7e2/DLiM8oyDB1Ap7RJ2BqSdUXRG4fXAH7VfEbU4FF3f7DHf08DwXwE2y35hh3JAqQHFX2O2axO38ga9PhseZQ4SCgg8oxRhdMTcZPkGh8hdjEyZLbNsQ5gl9KX1urTV0kMYxuGVX6P9U7f+qHd/OgwCyvWXJSWZTnlSMzbtu/eQoD4FqWs1bqSVqlo8z0EpvXZBwbwIXkbpes=
X-Forefront-PRVS: 0907F58A24
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB1899;23:CK3yr+AdcNWjSzP5znoF1Bx9t+0mMOY74K+uo5v?=
 =?us-ascii?Q?3NtXRv4oc+2PMDfhNLo/IG4Gw8rPaJleajqJEe8K1K174i+BqNh4bugS+QuT?=
 =?us-ascii?Q?zd8jv0pI/ESQFdvr3esTGY5x9q0kgWv8DdcA4s5ScsEQPBmS+C8XAGS79nd7?=
 =?us-ascii?Q?7EdEsf/568UpDpq9yYi7PuQToPzSDHcEhKA7yotNC/4WX0gmJb6YDjCEYvbL?=
 =?us-ascii?Q?bHkKgQMaWsUQw4UF9Jtxy/o7uQeZy9k+NQElPwvT8woq/7eDrPoZt5QPdCPS?=
 =?us-ascii?Q?kOMr4i2/2+L1R1GllsaXCEFg/hyirheUak6k5K321v+s4YbYApBI+F+BjMjl?=
 =?us-ascii?Q?WQJW2BxitZzGSX/IJ6QOGp8jwqwNEq2bmF6awnJTqkwRkxcXoTYaQDzFfESH?=
 =?us-ascii?Q?ejqhexLBWwgjeggySTQOTvZwx9646PwUdqAo/Cw8tXHTcL4gV00O/woR3u4z?=
 =?us-ascii?Q?VGz4UR0l7moYE26CzbLPIO1h8v7YSn2mv66Jseg5uU9FYvKQXLwwkbEOjAqo?=
 =?us-ascii?Q?bnoN+nVMfG2iatiP1z41DTEKaL+vw4UEzfr097ZDB4RIzlP9THXwCKnjALd4?=
 =?us-ascii?Q?gQLxioxlrhAPT0gIc+AIbSCJC9HgMk3kkBjPKljuNbms1fjT7yt4hlnkdM5b?=
 =?us-ascii?Q?/RtamQEKNCLRBC2QJ4G9x9/OqHKs28/gwineqSNDWvjDqgEDtq9sShu7f/JS?=
 =?us-ascii?Q?B9OyEt6VC9HoxbeJOnCX5VRAsO8A9lKNdeB0Ref9DG5rwFtZuYCByk4+BHna?=
 =?us-ascii?Q?48XuRQS4POf0PrpACb2VEu3zR9ot85X1L8zzLX55tRSwR+g0dk9O6LHurL4A?=
 =?us-ascii?Q?vhZDEsZC0FKSSzEMqrRlwktDM4zc4qbuNwr7T5iKfIXCgp07hmGdntyWWU5P?=
 =?us-ascii?Q?QktF2FqP8AMGZuKEAxrtHhX2IxCw5mOxGXJfAZY5rn7k7+Lsg6sxY5YlDBQp?=
 =?us-ascii?Q?kbjAl3vu+jrQoeohg1blL1OcNhoFYA0JEkHXEpWJpciwhXnnFh1Hh3BlYGGE?=
 =?us-ascii?Q?YieaKbmvBy2hzaeFSRl1H6j5cjrxPggM1yJONoaANNawjhyBXI5mqDwidk1E?=
 =?us-ascii?Q?ehiF+kEdxepc7iZU7rwwD23PyFDU81YBSEdAHKst2MmRLV8j+JWhhdLNO0J1?=
 =?us-ascii?Q?cqIMUs7VQsxEfFrIIYveSb0TtZSyqjuIU?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tSmXj+R5PoPS1EFxATko/yBCR/oW9UDOd7kW4WKJCLM9H2sOKfXM+MpR9Bu9BxPQB9EpUocm6m8yssrUtly8p8u1xFvhCZ9ALd9DV6xn5l8DANwoPqkUO+zXBYKDvE//mAA2jMErdFdJ5iZ0Pcz7ji4nAvi4kKejtvH3F5ObAPcvtIAbdqSde7xQSL8AxdS0+PZVKFaFYsY30TqC3kBcLkbZDD9q17pHF9aY59LhR8IpgDK/bk27ZRMazc5CDdsJuzfLRJNjBTCbQxUhAp10Hs7Ln1K5dBEr47p6GPlQxPaCncrlM9JG43xEBwGM2rWc
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1899;6:ermOoz4yv7BlqxQ8BBzTtueCcYFzwxaQ8WPPzS7SgWMk6H2MnLognuJMsPJNUlTOIaQcope6OPF97P58QvDxcVYFTUdt9EF6zbW+y+JqOXzkk4RnUVsH7ElBOzID/1t6nXuHR3RRtaSfifCAeWsLgp3NHNPf/n5bvu0XqrVOZ9b22RgJFcgj49Fkvfk9B/yW8zxSaEcm4f8vmVoGM3bN8ow34OM1EGpnzI/P1QgAnK0wfNkOrxG5aKr2cheYj5q16qm1EF8UXFeLUrbA2+zrIbvs0XuscdPetuxYVZppnVSdB6ODQUL8btwueqH5vMkk1wqURGfIJPkvRZxQzi7x5gbO6zT0dndrt8LFQO3OAmWFdOwVv6Y3uI4kkjccJ+7JYYZ/yv42QONcQUZ8FjMrhg/kRjIzrCo1ayfgUWwALlQ7I0OSXndVAHNe8E9S/8dUaf6KVKKCojIeTd+UJjdZVg==;5:ddws1+9TiHDL9NArzoGFLG2Szy2qTlh6w4X2/iajD65GlPysWg8FJgxPPyNWLMOOF7tRBzToomopYCrCJCWgPC+uqOoTT/kwx2d1tcwsbAysobMUbgTIuhliCAsNrQg6QcT7eIbwIFhBjOVWVHMynRGC4u2wEiInEnpvwG8UKuCVB/aCg6EnHJaY/SWkBWKLsVsPw9KNeyXsO10pWfFj0A==;7:ddsIxGYmK8ho+F9v41gxVHfqv1FUWxjynItESBELVdzA9wHKC24xC6SBYJaGTgo4iUFNpKbAwQ0HrFdBoPSXx44todXtMaOjws9L1KfypVYGEl+UOWJs762rf3IcinKRmMCMncqs3VNVNbe6yLvvXw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2019 21:56:48.8010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75eecb22-9b61-4ea9-f0ee-08d6728f8702
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/power/xlnx,zynqmp-genpd.txt           | 34 +++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      | 39 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
new file mode 100644
index 0000000..3c7f237
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
@@ -0,0 +1,34 @@
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required property:
+ - Below property should be in zynqmp-firmware node.
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 1.
+
+Power domain ID indexes are mentioned in
+include/dt-bindings/power/xlnx-zynqmp-power.h.
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		...
+		#power-domain-cells = <1>;
+		...
+	};
+};
+
+sata {
+	...
+	power-domains = <&zynqmp_firmware 2>;
+	...
+};
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
new file mode 100644
index 0000000..1bc9636
--- /dev/null
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_POWER_H
+#define _DT_BINDINGS_ZYNQMP_POWER_H
+
+#define		PD_USB_0	0
+#define		PD_USB_1	1
+#define		PD_SATA		2
+#define		PD_SPI_0	3
+#define		PD_SPI_1	4
+#define		PD_UART_0	5
+#define		PD_UART_1	6
+#define		PD_ETH_0	7
+#define		PD_ETH_1	8
+#define		PD_ETH_2	9
+#define		PD_ETH_3	10
+#define		PD_I2C_0	11
+#define		PD_I2C_1	12
+#define		PD_DP		13
+#define		PD_GDMA		14
+#define		PD_ADMA		15
+#define		PD_TTC_0	16
+#define		PD_TTC_1	17
+#define		PD_TTC_2	18
+#define		PD_TTC_3	19
+#define		PD_SD_0		20
+#define		PD_SD_1		21
+#define		PD_NAND		22
+#define		PD_QSPI		23
+#define		PD_GPIO		24
+#define		PD_CAN_0	25
+#define		PD_CAN_1	26
+#define		PD_PCIE		27
+#define		PD_GPU		28
+
+#endif
-- 
2.7.4

