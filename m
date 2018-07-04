Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC5BC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31724575
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WBALs4bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D31724575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeGDGAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:00:36 -0400
Received: from mail-bn3nam01on0046.outbound.protection.outlook.com ([104.47.33.46]:46544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932204AbeGDGAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofR/nmb+3VUF78J+qXuEfRa+ds/M3RKDJcM0BlOFYnU=;
 b=WBALs4bYezNz8xtXavEgLL/t0A+2iJZ7367cCrq8tn3TibHtDl3RvxodUJejuo/AMgb0iIY+qSM9+gbNPhMZLv3dmL0MitoZHqYSqKVk9fOZa0FYTTPsNnjnJgDSOnBE6zceq0m647nACCgCeAJaFggLyXwI3RS1vyeBZ3vulfE=
Received: from BYAPR02CA0067.namprd02.prod.outlook.com (2603:10b6:a03:54::44)
 by BYAPR02MB4327.namprd02.prod.outlook.com (2603:10b6:a03:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Wed, 4 Jul
 2018 06:00:29 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BYAPR02CA0067.outlook.office365.com
 (2603:10b6:a03:54::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.26 via Frontend
 Transport; Wed, 4 Jul 2018 06:00:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Wed, 4 Jul 2018 06:00:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faaq4-0004Oy-LU; Tue, 03 Jul 2018 23:00:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faapz-0002RK-I8; Tue, 03 Jul 2018 23:00:23 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6460AdA019020;
        Tue, 3 Jul 2018 23:00:10 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faapl-000217-Ov; Tue, 03 Jul 2018 23:00:10 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <michal.simek@xilinx.com>,
        <navam@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kedare06@gmail.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [RFC PATCH v2 2/2] fpga: zynq-fpga: Add support for readback of configuration registers
Date:   Wed, 4 Jul 2018 11:30:05 +0530
Message-ID: <1530684005-27343-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(50466002)(51416003)(9786002)(186003)(50226002)(39060400002)(7696005)(6346003)(356003)(305945005)(36756003)(77096007)(26005)(106466001)(14444005)(36386004)(8936002)(316002)(8676002)(2906002)(126002)(2616005)(476003)(486006)(107886003)(47776003)(5660300001)(63266004)(6666003)(426003)(478600001)(336012)(6636002)(48376002)(81166006)(106002)(16586007)(81156014)(4326008)(110136005)(54906003)(2201001)(107986001)(2101003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4327;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT022;1:h9Er1N+5re9uf9xUSIdXBXqn2oXwRM7XjtjOmp1EYJRNLfhwljnSgZnH5XiH6wiOSs9/3cw0M34xTf0kF5yfhypHc/Yr0WGvyjyqT/MVDX0Guc/e9OEx13lbs4Ky2Ye6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e7e5c75-53f4-4f46-710c-08d5e173722b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4327;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;3:XidRHQNMlp3xCxeNzQUc/t5DfB42mqfJAYF2KMx+D13OR+3OdsHUXFvW/16zvb4HUuTXCW0FZsXQ+ES+sSPvRO9WRQgOk2x6eeH6/GlSUWcaqahFJZaqJxWwhHL640BpfLvxplFXnMIwy4OAh2D6l6mX9Px/bUrr0qWluEhetvLmYyT6ucGDkr94uGKgdgAQZcQ5kSg3ony8c8MzwINXRsBo+RBniNOAc62iSwS2KKEBXU0Gp8yz+cI7wcBa6aYl+ZmdN/0v8MYLiOmQTW3QIUYwagzimgkB6LzkE5qI7vmfswecFF8fSF+whJzSynDnpbiEHNnGu5tZNuYLvA0TVdHV18wJcSNeJbF47FjOOmw=;25:+TUNNWo78WFW13RXMui/W6U6Zjzc32jvnjwe0aeGTj4eLxv7dU9atPihyKliR7Jn1Ox3cuP0PHae3/Tv+llsvcZQiZKoJ1piRwkl26GL3c3HieQShPr+yH4UqP713ipzfIZpPP4Ux8gxuBh3hYqzfmo+KBO43KmQZs61pmWl5RFcvznpq/gatb/f81A7obTCuv7wm7AzsvykI9dwzg/hVOfQqL1rj2VvIDp3qjvJ8XLd2k1osWWRmlPc4/DJBa1kiKKJF4pILQHeJnd3m0YCwOV1A8Z/vADiz0hnnn7Mg1YwI0UbgMPLHgF9L94rARTNCvJUVsAfW3cxJS4E1Si4Yw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4327:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;31:UWPMsK0cE/6ukLaE6olCJUOS5f2oOIZP7hUhfOGYuOZRQzVSbuAT2DjExR6iDQDDySo6y4PHtS3FGv/wLBnOGdkHUP7U7U6x8L53eyxph2pUbQWpM7XdhtF7ZcRnVhHz34Ykou4Tar2GrCUwzTncL/9+ubeSLoFY3557sJhBapbGK7XyZShB0osHb9mveLXWaySjGz25sBc4bb0aeZB42JZS9CeghatSMN2oZEy0szU=;20:8LCjtfIZXF3jkokU0dmYeYFCNAnQRKK3OL4xDZEwuam9b2U/25sHZNqWhBFKXDohAnXKsL8AVoHOIKJzwRMlRsgfU9ho/PBIkci1fx+U0cMjFg9K+U7Hh8S89LK9hVSZCEVqts3g+w1PmXrPvuoO172vmahD9fxGp8Tm0ff31WKIKv06hGEmCbAurvcqv070Uh+p2wrSHctSfsfWfKdStHb+lrpdEoufY1lV9Wkv+wjj9tFebKnG6+noyW51l4kjmc9HrrupJQHTVan5Da3Xva/PKgJXhyPqrcNoQ/6sI8jcdJ8+XkqC76rqFzROayQf9sacMCR1aADMrmHiCNPEL0jdLsWmZ3KkN+o4eb92cvg1vm30mq+OTQDn2LVUPs9QW0QX4EqrAmTUr9JzfT6WwWgjUY0CcvBoYA4bCCg8g8F11gpbwexCoowP3IwwQvNaTiiZs0TLZ4tmBm0KoSkjNVgxeVBXEJ6Co3ndiUKBEwyK+ycRfUDwU8eWP9w6QR17
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB432736D11A6F2AB442C1A7E2DC410@BYAPR02MB4327.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231280)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4327;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4327;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;4:u39nJa6If3kHb9xT3gyJFy6RiopxRvfnGc8YQIkWRVmzfGP4gi2zS7SYzXoiTmJ7h4xp6HVBFTZYMnaKwIYyqCtVAQ1YrlNwyx1vbVDX1a8FDc2Iz1jmBhWc9DSv2mYvGHyAQzP7hO7q6iFDBWsz50MudBoNF6nXj3K0fJ71W6ji2DfAN7QVlj3qYoM4bUV6tLc9Og1RlUBROKilDaQjtknZ9tQT0NTvDy+dW0GaKifippOAASSha1ZhrB8oELo3hHtC82h/sk67Ucufxl8n/AxgK03F55RvJY7Geme9EBAzokQDa6xU7qP0xCVWMgLC
X-Forefront-PRVS: 0723A02764
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4327;23:+nKLJ053FLEb9oRs1br5mCwg0ijj85suzX+Cy+JZF?=
 =?us-ascii?Q?Sjw2MS+4MrmZJw42dAxtEpKS7xi1EGQekNKggFbCaodL954v8xyxPz+vyjIm?=
 =?us-ascii?Q?AaJIFb1nsS0p02zWh7mq5QFFN9D0s39+VYOdoIm3GkDaJrFxZSfsH3rSa2jQ?=
 =?us-ascii?Q?lHoC9njY2M2OaajA4Ojd8HpGKBf6GtLSOakO0ftgpeKWTtiOhEhryKDrlNqE?=
 =?us-ascii?Q?IbaDtT5hsGFwbpE6a/wnWQ1CZdtLMkDLovlKvaBTRgiyEKRX+uDYE1gi6uNs?=
 =?us-ascii?Q?rup6WIMwv14VXeS0z0buEelC4JKK4NvXfjUbxoSXMus6tduPxSz/XImVuEph?=
 =?us-ascii?Q?EtV/qZrZmupptTn+gdHctVT2dvVobQlKGmi05QmKUL6ZKkf1ShnqIfHHSn+b?=
 =?us-ascii?Q?iPveNKOR7awNbHcrHJjlHlb8OV091xybYm2DdTlXid5aZLdKpHmj1RQr13sr?=
 =?us-ascii?Q?GNvOXhWRE+V66oC+bNE2y1w+X31wWWXpuwKVrUfFwW7o1Qu4SbjMA9bXOmz0?=
 =?us-ascii?Q?rfg9amv5D8fCXOYB93DLaXY3dUJU8u33JD3n4x1PRu5h/hXfUdYg8spZ+wHA?=
 =?us-ascii?Q?pXcVtJ03YfuLrBqVRnMaRYv8lvGr7vPhrdDdIAe1+OnZ/pfFGAjVrUa6YQVm?=
 =?us-ascii?Q?AmkYaWPMwiWdmbsPtxLX6/vcxp5886taG3L6PyVQFamNGq4KwiaHbYVMqucG?=
 =?us-ascii?Q?p0yIfqU9H33JVxpxAX0ObSdFcP9+kngiwEL7pJnFvolSK++dAU5fLNXUC+6H?=
 =?us-ascii?Q?Yn8iYwE1DQW5/GeatRPUKa6czgoBzuBKEQEPQJL73udGuGTeKmqxUVLfD9Vj?=
 =?us-ascii?Q?E6j9vYP0iIUaH5JbOBEXj8ixBV4+Vc22APxjxJspX4ufJ3O0rfkOVxfnyDeb?=
 =?us-ascii?Q?mosO23qL53Sso9rkpveyzTKhJnHFtFmC5T6e5HIdjW6crCwITRk2B7ADEXuH?=
 =?us-ascii?Q?sYUp8I2xac8GuHbZbPKN79z4M7IBgUBAcSYIc6odEJ2aZu8LE9Yl2CO6D405?=
 =?us-ascii?Q?S0zAo3d+9HC2+j/IRuoFDMMKnvydDXGq8I2A/rirOMlXcP90UKrxcizooQNU?=
 =?us-ascii?Q?uIpb4aYNKmxsLkBisIl2v0TDEC1Ssx0E/IKCKk7/Md5eDxpyo77pE/H+ZY5h?=
 =?us-ascii?Q?mPpEJx2bBxfuHw6UIhy4zdeCBlRonkrM2fo0ztuY1vt3StMZcB9YVy7/W60x?=
 =?us-ascii?Q?0Aqlg1cIgsqXzU=3D?=
X-Microsoft-Antispam-Message-Info: 0ta4WFsi4rM0L2otwz6xB8k6jQAbpcUi0M80Xfsfm0TjJz1KZUzl0vs2fMvFYAfmJbOv59dbQddVp+Y8o2Gmlctn1GcGKCA7hJsgv6XB7QNUpPBErJlo8WtBXmvzpNUjromlPmlqIA/eTx5m4cmQ2gcT6gbNbmqd/4R1T45G/oLzlGiwDokCaH0P2Ps7q4N6Hav40r3p+4ZTsJ0i3UCHgUNkNM74HgYxM3RH4TiELSkVlwrIKCK3MmnT764qMh93cJkSKoInwVmoFbV9DA9DVi2UsAAt5NuCvK8QIFvWQigr4/379PUuvA8KSb5ZFBAYJN2YidbU/w4auPkcNuUQJ76ornrQ0PJ8WLljzuMHDpU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;6:7xDGj94eTn8NRsjhLC7oap1fbLqOHzYSjtuwRTtQ/2YNjXhG2wH8Lyxp7Zl/wmCnh2szPpkbtZTw6uIYfneDZfr+BO6vwInkfMfQ/bHApTMgnw23Hbb2aXH73DnqUUVSbAnx7hgsa/VraPLyCmQhoiuvLgF/U0xFkbKnQCZ8I6AJ3ZQCWT+tF8a5QpM8qdQnPpK0OjfTrwk6hjGQO1JFwutANQEy7TcdKGc5Esn7TUZsCafaYCchigFsH9mXu5glPYMPY1mDcXLI2ShkynHFGIxETxas252ppxwwiB6IqYOZXUJVSilYXmXfCwORndUnZa+s0c82GLv210Evo38GA0lSgwAu7eK3kIU+FQxGCpHVMwen1LDuNMyZP2dNhGAym28m+60GkbTB5OLROFAwYX8D6aRzkJKDjVZ6CdV0WhcAO2/4fvqKfPnvy+SPLr5VOlntGiVP24TdLiIYriab/g==;5:d6jYaHRTDIeVQmhf2W8b6k6cFdcVglse/ea0ov8kjWUfNqLH92w+jBPvb0Uj2pa7aM+QHf8DXfythoQ/nz4VbmYF3S8lf2ET0+PHlZg+iRdEec1Qw+v3tMN2ZbnhwZDU3H1gheoJKmNphvvICcPF94zt9En3diDW82kCbCwjamc=;24:w4wycXEEbeALLXitFUbBEA+JO33iVdmXKMWtchIP2sfVEc+ewktmk1khaa9YHdDk+evTmfBGLRtUepv+vRWcUXiWqoArHEv7UjtJz1xI9aY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;7:+t9grylMm96jrcTr5OIYCefZQsJFwQRk0oZEdEPwit16qoVdzt3U+mgiWsL073dWZUJtP1d3T2nkxeHFP8sUCh/JmbaXHYjDBo/gI3QkVMKG6SuwOlpa3zkhfhsIjtviSVOY2WIB3BoxllJrSM7wHsmv7MXoMchG51puiNyuwmbHnDHhuhMt+RlloTc9+foOv53Cmn/psw2SrZihibDpnOFV5DNDIxEZvOMdKVtvhwAVsdX+C1flXhatgzQHCKqi
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 06:00:29.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7e5c75-53f4-4f46-710c-08d5e173722b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Read-back of
configuration registers in zynq.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
--> Removed locks from the read ops as
lock handling is done in the framework.

 drivers/fpga/zynq-fpga.c | 245 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 70b15b3..b56a6c6 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -127,6 +127,49 @@
 /* Disable global resets */
 #define FPGA_RST_NONE_MASK		0x0
 
+/* Configuration Registers */
+#define TYPE1_CRC_OFFSET	0x0
+#define TYPE1_FAR_OFFSET	0x1
+#define TYPE1_FDRI_OFFSET	0x2
+#define TYPE1_FDRO_OFFSET	0x3
+#define TYPE1_CMD_OFFSET	0x4
+#define TYPE1_CTRL0_OFFSET	0x5
+#define TYPE1_MASK_OFFSET	0x6
+#define TYPE1_STAT_OFFSET	0x7
+#define TYPE1_LOUT_OFFSET	0x8
+#define TYPE1_COR0_OFFSET	0x9
+#define TYPE1_MFWR_OFFSET	0xa
+#define TYPE1_CBC_OFFSET	0xb
+#define TYPE1_IDCODE_OFFSET	0xc
+#define TYPE1_AXSS_OFFSET	0xd
+#define TYPE1_COR1_OFFSET	0xe
+#define TYPE1_WBSTR_OFFSET	0x10
+#define TYPE1_TIMER_OFFSET	0x11
+#define TYPE1_BOOTSTS_OFFSET	0x16
+#define TYPE1_CTRL1_OFFSET	0x18
+#define TYPE1_BSPI_OFFSET	0x1f
+
+/* Masks for Configuration registers */
+#define RCFG_CMD_MASK		0x00000004
+#define START_CMD_MASK		0x00000005
+#define RCRC_CMD_MASK		0x00000007
+#define SHUTDOWN_CMD_MASK	0x0000000B
+#define DESYNC_WORD_MASK	0x0000000D
+#define BUSWIDTH_SYNCWORD_MASK	0x000000BB
+#define NOOP_WORD_MASK		0x20000000
+#define BUSWIDTH_DETECT_MASK	0x11220044
+#define SYNC_WORD_MASK		0xAA995566
+#define DUMMY_WORD_MASK		0xFFFFFFFF
+
+#define TYPE1_HDR_SHIFT		29
+#define TYPE1_REG_SHIFT		13
+#define TYPE1_OP_SHIFT		27
+#define TYPE1_OPCODE_NOOP	0
+#define TYPE1_OPCODE_READ	1
+#define TYPE1_OPCODE_WRITE	2
+
+#define CFGREG_SRCDMA_SIZE	0x40
+
 struct zynq_fpga_priv {
 	int irq;
 	struct clk *clk;
@@ -164,6 +207,15 @@ static inline void zynq_fpga_set_irq(struct zynq_fpga_priv *priv, u32 enable)
 	zynq_fpga_write(priv, INT_MASK_OFFSET, ~enable);
 }
 
+static void zynq_fpga_dma_xfer(struct zynq_fpga_priv *priv, u32 srcaddr,
+			       u32 srclen, u32 dstaddr, u32 dstlen)
+{
+	zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, srcaddr);
+	zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, dstaddr);
+	zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, srclen);
+	zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, dstlen);
+}
+
 /* Must be called with dma_lock held */
 static void zynq_step_dma(struct zynq_fpga_priv *priv)
 {
@@ -546,12 +598,205 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static int zynq_type1_pkt(u8 reg, u8 opcode, u16 size)
+{
+	/*
+	 * Type 1 Packet Header Format
+	 * The header section is always a 32-bit word.
+	 *
+	 * HeaderType | Opcode | Register Address | Reserved | Word Count
+	 * [31:29]      [28:27]         [26:13]      [12:11]     [10:0]
+	 * --------------------------------------------------------------
+	 *   001          xx      RRRRRRRRRxxxxx        RR      xxxxxxxxxxx
+	 *
+	 * @R: means the bit is not used and reserved for future use.
+	 * The reserved bits should be written as 0s.
+	 *
+	 * Generating the Type 1 packet header which involves sifting of Type1
+	 * Header Mask, Register value and the OpCode which is 01 in this case
+	 * as only read operation is to be carried out and then performing OR
+	 * operation with the Word Length.
+	 */
+	return (((1 << TYPE1_HDR_SHIFT) |
+		(reg << TYPE1_REG_SHIFT) |
+		(opcode << TYPE1_OP_SHIFT)) | size);
+
+}
+
+static int zynq_fpga_getconfigreg(struct fpga_manager *mgr, u8 reg)
+{
+	struct zynq_fpga_priv *priv;
+	int ret = 0, cmdindex, src_offset;
+	int *srcbuf, *dstbuf;
+	dma_addr_t src_dma_addr, dst_dma_addr;
+	u32 status, intr_status;
+
+	priv = mgr->priv;
+
+	srcbuf = dma_alloc_coherent(mgr->dev.parent, CFGREG_SRCDMA_SIZE,
+				    &src_dma_addr, GFP_KERNEL);
+	if (!srcbuf)
+		return -ENOMEM;
+
+	dstbuf = dma_alloc_coherent(mgr->dev.parent, sizeof(dstbuf),
+				    &dst_dma_addr, GFP_KERNEL);
+	if (!dstbuf)
+		goto free_srcbuf;
+
+	cmdindex = 0;
+	srcbuf[cmdindex++] = DUMMY_WORD_MASK;
+	srcbuf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	srcbuf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	srcbuf[cmdindex++] = DUMMY_WORD_MASK;
+	srcbuf[cmdindex++] = SYNC_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = zynq_type1_pkt(reg, TYPE1_OPCODE_READ, 1);
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto free_dstbuf;
+	}
+
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+
+	zynq_fpga_dma_xfer(priv, src_dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+	zynq_fpga_set_irq(priv, intr_status);
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0, dst_dma_addr, 1);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_DMA_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for DMA DONE\n");
+		goto free_dstbuf;
+	}
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+	src_offset = cmdindex * 4;
+	cmdindex = 0;
+	srcbuf[cmdindex++] = zynq_type1_pkt(TYPE1_CMD_OFFSET,
+					    TYPE1_OPCODE_WRITE, 1);
+	srcbuf[cmdindex++] = DESYNC_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	zynq_fpga_dma_xfer(priv, src_dma_addr + src_offset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_DMA_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for DMA DONE\n");
+		goto free_dstbuf;
+	}
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+
+	ret = *dstbuf;
+
+free_dstbuf:
+	dma_free_coherent(mgr->dev.parent, sizeof(dstbuf), dstbuf,
+			  dst_dma_addr);
+free_srcbuf:
+	dma_free_coherent(mgr->dev.parent, CFGREG_SRCDMA_SIZE, srcbuf,
+			  src_dma_addr);
+
+	return ret;
+}
+
+static int zynq_fpga_ops_read(struct fpga_manager *mgr, struct seq_file *s)
+{
+	struct zynq_fpga_priv *priv;
+	int err;
+
+	priv = mgr->priv;
+
+	err = clk_enable(priv->clk);
+	if (err)
+		return err;
+
+	seq_puts(s, "zynq FPGA Configuration register contents are\n");
+	seq_printf(s, "CRC --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CRC_OFFSET)));
+	seq_printf(s, "FAR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FAR_OFFSET)));
+	seq_printf(s, "FDRI --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FDRI_OFFSET)));
+	seq_printf(s, "FDRO --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FDRO_OFFSET)));
+	seq_printf(s, "CMD --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CMD_OFFSET)));
+	seq_printf(s, "CTRL0 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CTRL0_OFFSET)));
+	seq_printf(s, "MASK --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_MASK_OFFSET)));
+	seq_printf(s, "STAT --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_STAT_OFFSET)));
+	seq_printf(s, "LOUT --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_LOUT_OFFSET)));
+	seq_printf(s, "COR0 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_COR0_OFFSET)));
+	seq_printf(s, "MFWR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_MFWR_OFFSET)));
+	seq_printf(s, "CBC --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CBC_OFFSET)));
+	seq_printf(s, "IDCODE --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_IDCODE_OFFSET)));
+	seq_printf(s, "AXSS --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_AXSS_OFFSET)));
+	seq_printf(s, "COR1 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_COR1_OFFSET)));
+	seq_printf(s, "WBSTR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_WBSTR_OFFSET)));
+	seq_printf(s, "TIMER --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_TIMER_OFFSET)));
+	seq_printf(s, "BOOTSTS --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_BOOTSTS_OFFSET)));
+	seq_printf(s, "CTRL1 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CTRL1_OFFSET)));
+	seq_printf(s, "BSPI --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_BSPI_OFFSET)));
+
+	clk_disable(priv->clk);
+
+	return 0;
+}
+
 static const struct fpga_manager_ops zynq_fpga_ops = {
 	.initial_header_size = 128,
 	.state = zynq_fpga_ops_state,
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
+	.read = zynq_fpga_ops_read,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
-- 
2.7.4

