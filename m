Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF31DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6533120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Xch0YCdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6533120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbeGXPYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:24:47 -0400
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:43856
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388430AbeGXPYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87XOzAnQQ35a0u3igUcrN7WUGDyliaz6GnBVqOhBesQ=;
 b=Xch0YCdEjYywBz2LLw7+Ai/krlk93896mGVHYb7r3LvuUvmWTvEgPDFkB6zQA40+KxZaqC0ip6fR9aYBNIYgaVlvdY1Yf3IeA4ZOdOOOwtxMy1lJU4/F75VO0vLXIm2E5AWgffz9P3MC6qBWvpD8smISY6ITFwEHAKVbdo7EYRw=
Received: from BLUPR0201CA0023.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::33) by CY1PR02MB1625.namprd02.prod.outlook.com
 (2a01:111:e400:5299::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Tue, 24 Jul
 2018 14:17:59 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BLUPR0201CA0023.outlook.office365.com
 (2a01:111:e400:52e7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 14:17:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Tue, 24 Jul 2018 14:17:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fhy8U-00022i-0Q; Tue, 24 Jul 2018 07:17:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fhy8O-0004O5-Vu; Tue, 24 Jul 2018 07:17:53 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6OEHldc004205;
        Tue, 24 Jul 2018 07:17:47 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fhy8I-0004NT-QQ; Tue, 24 Jul 2018 07:17:47 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <navam@xilinx.com>,
        <michals@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Date:   Tue, 24 Jul 2018 19:47:38 +0530
Message-ID: <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(438002)(199004)(189003)(186003)(356003)(446003)(11346002)(6346003)(7696005)(106002)(8676002)(26005)(336012)(6666003)(51416003)(478600001)(81166006)(81156014)(47776003)(2906002)(8936002)(76176011)(54906003)(36386004)(77096007)(110136005)(316002)(486006)(476003)(2616005)(16586007)(6636002)(2201001)(426003)(126002)(14444005)(305945005)(63266004)(50226002)(48376002)(106466001)(5660300001)(36756003)(50466002)(9786002)(4326008)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1625;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT033;1:EuRl/WZg7PqOj3NbfOIg8qgFbwOHJlshTU8XDkp70ET5W0i4bWMtFKMiGJG99nrmx8781nzeSOc5843Avn3lcd7z0R01mbr0WTUSxLZeoTgKMY6dxAQ6Qz5iaDTMYi2G
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696e7795-9e2e-49eb-a05e-08d5f17041fb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;3:Fp3R8mVv5aH3xaXdn3FzhlRjo51oYHtEwqT6IIQ1tsy2nVoAyZkcmPBBVY2vAGP2Aqk2/ynRibC1PQRzNdsbdx7Yw8KRWSK81YEn7m39dJnXlIswq9UZ4i2DIKN0pvz6CoM1tDVKQghAuUvMh2nWCkI/RmkUeD8T4yTj4mreoH63nPdrRN1PdF23vNKq3K2NZcGCdYgBxaFBoqmKomuW8BBvqaRM4TOdQ39Suf6udrKrPblF62DIq3ZAWp1LCyJuFxlHnGnisn8q1W87+UGRWTgLTlt73bu13AesBhWJ1OJM2/zRwELLmIYMGbUUk/t/ia9Y9Z1h4eu9NMmySW8ObcBgECEkBLDu1GC25mXfWYA=;25:PNtR1nsvgj9dXHdWBp1Pvo/erK7Kpdk474ejdB08TOLIyU5DQu2WLC0rycgkLBc/5kmb0sohlYTVKkUj02kVJz3JL07PYc76AQbJ6PRnxG0S8A2gEs7JlUUEd5xqk9iPUryb+eyvVxr2uxe8Onb7PcTjhszWXsfVFFbdi88Gw6138bISv1XFvI1VhH8Ml9/t6YzPSfMY/K2rp/RXAcfIxu/WXBaN33dhyy1E/v2toFL2u0fpGgsbwBvkRnFWp+GldkgHAtK7zyRkk1EJkZGBEYbIHQQDdgjhk2dnU3WHdJZteyPIfLQ/STI/ysEqUe1Oi9ofmOx8lcv/QJETNmq6FA==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1625:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;31:L1RKEWuJM3xvPCWh6+ac+uj09RqzzXABv6gUtYE76FWQu8kZI7XCjdAFSC0CBroQ0BdTROAv24xnMRlkVtYG7P9eqLXR+mvuQiYdjReUD40/vlXxAP5sz2PJyXjBFaNEgu4NJqk+KC0Z5JvO5Zuc61h1IhssPnyhEqQVlS2oRzhBn6Xx3yyr9gBKQfq3v+B+9jF0FPjy8MF19Fg0Ns6H4X1FTBU6fKClYUK/hHMnCYc=;20:xBAlotMhbJSkOFNra0gWWrBTVNz16+jzx27ZmbediLEhKy60yswQ7a60o7jfjv02eBE7QKbERm4/Uv6eckb7HC2rsFtrKl4OWh8VIbUD9b7/yNiDK7mVufzyzYFxUfPCrxekDRNESjH6ymEtcLpvzWfsxuTCK6un4CAqyHMtRXy/vslTf09neO+mrl0pfIY/12Hq5ltfsy3Y2g0epzf4ZAIWoFQr18D6jjIeW85XvMw0o/FmTH2aUQovL0TwOVwo41N/tbqK48wH11wtzbkyNy3wciGRdyyEZIG3hgJFJ/kuK8XmJq/cUd9vyGMKkJi+8LnrS2A+p9mYS6VyIaWt3a6maZYjXvLTa2g6822+L0jjQ+if1QfCxcWS33qy1v6VG3iyNUqmjDbbZ/sBsT2O7D5hcMISTGcay9GRh9LDsCD0aMOMQynVdHaB3tRNZz4SczrgnZqMmZ98zVmPafK1gwIUBrP959AQ6qxbvyXwzszOnZeJOQgU413uTWYqXwvJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB1625A5A7132C52C26E5D84ABDC550@CY1PR02MB1625.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1625;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;4:Ga/jd1T/iZCkOyBEbkwFubuZHwrysG7B6FvS8uOTlytCNOmazksznFpr+ko+W8Veam9qpl+ABd0YZNLSDKrZItO7JH5d2HVZvSef+F9knEjXbu14kXxSNiE5f6MZru+9xmhFBp+T3ls5/Szqw5vLKYwD3G5f4qjdfENURMqzZcd/5IhpODD93DYr3sFmjodxt2QBux7xoLTRTJ8WfLzB/0U2c+AEhSV172/Bv/9CJ4hReyyfBMx13dcbTi7Rm8WPY1VRoDUjzHdRcFJzuH9fdAhc37PQptJ2JvUeZWGFMvWbnsgLpIw3cnfQjr4EoVfB
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1625;23:2TyM82PZWDt4asx9RFFKqEIQC7F6otCaCB+cgSX8R?=
 =?us-ascii?Q?IRVly4ePrs38ws1cVVmkNfu0AjZhPlbPhySyLapKpN4RGergiZXsczUUpTxi?=
 =?us-ascii?Q?7mnMtMiPefTNwAUEC6dWfZy3FkUbyS0WsKmvTZmCtaPWkUFewN/QMzV3/N4H?=
 =?us-ascii?Q?XW52Z5bdbgDkLlzPxhBs+N+0onnlQdIr9SGhLD46KQ4Vg9iaPCnSrRTmy1X4?=
 =?us-ascii?Q?5OP75YTajKC37Ttt0Za5Wr1/KqpbB2qDKja4YkRUbxhbKLu2rIOMr9HgAEtm?=
 =?us-ascii?Q?hlLUXi5pgKRq93xGuODWZUhso7ot1Z69sn6vPot25wOY0724JF5QoOYqwsCS?=
 =?us-ascii?Q?hs4HGuCp67Yj33KiVsX7mq7uWPQDfmRvP+T1b8r/5xE9FJYGsHo03EhmsBqt?=
 =?us-ascii?Q?9STqvowHETYQKTrvruEQeZcB7029oaC7uPYfrszLsLzQQvTuSgXhvB99PKfm?=
 =?us-ascii?Q?7FmVjshDfwsYZ6xB86NbPFSDDupqRnpoBW+6Qj/3kZGMd1jbP9hmrVcZ5d28?=
 =?us-ascii?Q?gW+IKOhOkAb01WJZNFoSlu0hyKL/f7123tYlitCRPKF/4wbJAA93UJBzYjjG?=
 =?us-ascii?Q?SX+wAcKAbXLMPLZ5Y5XDnaqX8W+6B2POoVvrWQuC0Ff1DZkY3bWYtNbonzsa?=
 =?us-ascii?Q?TBnHxjGn7E7qdiBy+RPVkD6sfLC3Vf4WlqfvMSi2GtEaC298pqQ7L/fAaga/?=
 =?us-ascii?Q?asvXaQ6RQZJnG9tgpVmmgIUA1rUv6/02UfW2kR0U6y0lQ+1dUfHCIrYsRsAL?=
 =?us-ascii?Q?G1G4szLOT1Qozctnmif4REWDohIgd0b68uaMB52aZ056yORMuudLQ+2PSczZ?=
 =?us-ascii?Q?8EgRzWzxVNX+bye+XEbJ/0Q1MD87o3E4A7DVfmnJEvcPn8HyTvUdN/pqVHxP?=
 =?us-ascii?Q?3Lh6QqURGHvaE3TjtrBFmSJ3tWllBXe949nR82n5KChXEOHyYBTd3XwUlq02?=
 =?us-ascii?Q?h/KU5ULVpUxQ7QOC+uHh8uVI1ZrUddtao25AQr/Fb2vUxj8/WmczAsDWxpVQ?=
 =?us-ascii?Q?dX0vazEOlDeKrvqIv0zzxFRHC0QMC3hA5EfvHd1ik/LgoWqg4SZKPF+qdQJa?=
 =?us-ascii?Q?axonaw1kpHDli5UCIGts+5hv2EcVkN0L00a/l87H/rNIGGj9Oo/XgwJaqW81?=
 =?us-ascii?Q?c+kalgRsLMKq+/3ZfmBkGxJnfpaHDkb2FW3PWjw+d7y2fBa9aq07jdTohNd1?=
 =?us-ascii?Q?wv/z6QeCECdnxE=3D?=
X-Microsoft-Antispam-Message-Info: V4A5WnAfgqmCUCwZqHWD7g4xNoJPq2iH2/XeJXL8dkchHkpxvSZS0xWWDXkDzgfGgw38Xq5pB56ugkpEksm0dks8Mkzj/FC8cM1z6TMC8SVS6+L9NdwPEI1NzHSUT8QG/jF8YupiNi0Xv8p37kw3dOU/aLkguNlp+OQFYmTtSHt3vqXoEi9mtRZt+ItMeNLGYRR8QmaKt3fGxjXYykctYKn+qwuM4YPKKo9ulqwg3Nl9wOYpEO7MJcTqpcb3ptqYWMnSa8mftoJibvZgeFhMZ/Ja3rGerD8vs9wzd8ugCVUJOHGVmEOvqVJL+ocuqPTWwORCQD3M/GLdvxBe/WA+Pxcg8T68qOLJQpsQF9y+AAU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;6:ESJzKnXseV/7H5td6Q1NGoTt2cOVM9scl7mxm6BUsM1LWHJR49dcgn39sBtKv9XesCc+x2PC812ObryczXwZ5id3Z82C8urGu5kIkY67DPkYDPB5xWrGgVnL/Po+MfwanEyElFZPtwCqSmfM4qTZ4SapwHxCFLS1SjCV3grCXSscHzACB2sueSzhCHIZkvVknafTD+8DDpG7jW7IK8YnqkrK/+8wHQFpDQ1JA9qcfiSC31hsG3XMU4Fno7Vbex7GrsBpyPu+gEw68Bp1WGTGqr35suD5jOBPgwFPnBn/zMmc/sr4jtH35fQmJNmLprpCz6+4+ZC+L24+vqmnuCnwpEfFGxV0Wlfkx1P//UVNkPnguerZ/8vuJ10Cm1VGUz3Udm+Xm5DPjhCXztT6Fh08aB3Zg6QTBGzseVSFqLnJzg7+w2GMgeP54xm4awWMmyvDwz0WwTrUZY/j2aAol0+vIg==;5:jB+Jp2G++MtV9qieJsvcYRyzV5OswDIO1WQDHxxFnyn+YIoEwHj3q3foC/6bjwK9qZlfPsqK8SsBmdzXQ2Ycn6g/cPjeRH1VYpAG7XS19gW72ebqs1T2aPxpzbB5LXGD+MKz43sPWMlNfrZNX8Jix5YeokRAdLcIEx1xhgscFmU=;7:XodnHNAXPsBvSbvIviwIgXLqlyvjYHXOaABfG2EHvA6Fto5IkSeMfiKS45DjBW95IU6o0A271ZgBRSf2iuKOWWCNoKCYXsEojWJED5NFs6EqeeIp1+sW8oz94Zbd9SJI+tSVaVqaYbxrqNzQy5MUOCECubz31Vs9w/c/ulurP4knYXgbVrreyzui+OFm+E5i9I2157pLf1cqVjFQaC1NDCML+RYlK6X/fDs0yJd+BV3ChWqW5T0BnngNzmVKFMqH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 14:17:58.5621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696e7795-9e2e-49eb-a05e-08d5f17041fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does the below
--> Adds support for readback of pl configuration data
--> Adds support for readback of pl configuration registers

Usage:
Readback of PL configuration registers
        cat /sys/kernel/debug/fpga/fpga0/image
Readback of PL configuration data
        echo 1 > /sys/module/zynqmp_fpga/parameters/readback_type
        cat /sys/kernel/debug/fpga/fpga0/image

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v3:
--> Added support for pl configuration data readback
--> Improved the pl configuration register readback logic.
Changes for v2:
--> Removed locks from the read_ops as lock handling is done in the framework.

 drivers/fpga/zynq-fpga.c | 400 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 400 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 70b15b3..5f1a1aa 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -31,6 +31,7 @@
 #include <linux/regmap.h>
 #include <linux/string.h>
 #include <linux/scatterlist.h>
+#include <linux/seq_file.h>
 
 /* Offsets into SLCR regmap */
 
@@ -127,6 +128,72 @@
 /* Disable global resets */
 #define FPGA_RST_NONE_MASK		0x0
 
+static bool readback_type;
+module_param(readback_type, bool, 0644);
+MODULE_PARM_DESC(readback_type,
+		"readback_type 0-configuration register read "
+		"1- configuration data read (default: 0)");
+
+/**
+ * struct zynq_configreg - Configuration register offsets
+ * @reg:	Name of the configuration register.
+ * @offset:	Register offset.
+ */
+struct zynq_configreg {
+	char *reg;
+	u32 offset;
+};
+
+static struct zynq_configreg cfgreg[] = {
+	{.reg = "CRC",		.offset = 0},
+	{.reg = "FAR",		.offset = 1},
+	{.reg = "FDRI",		.offset = 2},
+	{.reg = "FDRO",		.offset = 3},
+	{.reg = "CMD",		.offset = 4},
+	{.reg = "CTRL0",	.offset = 5},
+	{.reg = "MASK",		.offset = 6},
+	{.reg = "STAT",		.offset = 7},
+	{.reg = "LOUT",		.offset = 8},
+	{.reg = "COR0",		.offset = 9},
+	{.reg = "MFWR",		.offset = 10},
+	{.reg = "CBC",		.offset = 11},
+	{.reg = "IDCODE",	.offset = 12},
+	{.reg = "AXSS",		.offset = 13},
+	{.reg = "COR1",		.offset = 14},
+	{.reg = "WBSTR",	.offset = 16},
+	{.reg = "TIMER",	.offset = 17},
+	{.reg = "BOOTSTS",	.offset = 22},
+	{.reg = "CTRL1",	.offset = 24},
+	{}
+};
+
+/* Masks for Configuration registers */
+#define FAR_ADDR_MASK		0x00000000
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
+#define TYPE_HDR_SHIFT		29
+#define TYPE_REG_SHIFT		13
+#define TYPE_OP_SHIFT		27
+#define TYPE_OPCODE_NOOP	0
+#define TYPE_OPCODE_READ	1
+#define TYPE_OPCODE_WRITE	2
+#define TYPE_FAR_OFFSET		1
+#define TYPE_FDRO_OFFSET	3
+#define TYPE_CMD_OFFSET		4
+
+#define READ_DMA_SIZE		0x200
+#define DUMMY_FRAMES_SIZE	0x28
+#define SLCR_PCAP_FREQ		10000000
+
 struct zynq_fpga_priv {
 	int irq;
 	struct clk *clk;
@@ -140,6 +207,7 @@ struct zynq_fpga_priv {
 	struct scatterlist *cur_sg;
 
 	struct completion dma_done;
+	u32 size;
 };
 
 static inline void zynq_fpga_write(struct zynq_fpga_priv *priv, u32 offset,
@@ -164,6 +232,27 @@ static inline void zynq_fpga_set_irq(struct zynq_fpga_priv *priv, u32 enable)
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
+static int zynq_fpga_wait_fordone(struct zynq_fpga_priv *priv)
+{
+	u32 status;
+	int ret;
+
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	return ret;
+}
+
 /* Must be called with dma_lock held */
 static void zynq_step_dma(struct zynq_fpga_priv *priv)
 {
@@ -192,6 +281,7 @@ static void zynq_step_dma(struct zynq_fpga_priv *priv)
 			priv->dma_elm++;
 		}
 
+		priv->size += len;
 		zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, addr);
 		zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, DMA_INVALID_ADDRESS);
 		zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, len / 4);
@@ -401,6 +491,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	int i;
 
 	priv = mgr->priv;
+	priv->size = 0;
 
 	/* The hardware can only DMA multiples of 4 bytes, and it requires the
 	 * starting addresses to be aligned to 64 bits (UG585 pg 212).
@@ -546,12 +637,321 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
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
+	return (((1 << TYPE_HDR_SHIFT) |
+		(reg << TYPE_REG_SHIFT) |
+		(opcode << TYPE_OP_SHIFT)) | size);
+
+}
+
+/****************************************************************************/
+/**
+ *
+ * Generates a Type 2 packet header that reads back the requested Configuration
+ * register.
+ *
+ * @param        OpCode is the read/write operation code.
+ * @param        Size is the size of the word to be read.
+ *
+ * @return       Type 2 packet header to read the specified register
+ *
+ * @note         None.
+ *
+ *****************************************************************************/
+static int zynq_type2_pkt(u8 OpCode, u32 Size)
+{
+	/*
+	 * Type 2 Packet Header Format
+	 * The header section is always a 32-bit word.
+	 *
+	 * HeaderType | Opcode |  Word Count
+	 * [31:29]      [28:27]         [26:0]
+	 * --------------------------------------------------------------
+	 *   010          xx      xxxxxxxxxxxxx
+	 *
+	 * @R: means the bit is not used and reserved for future use.
+	 * The reserved bits should be written as 0s.
+	 *
+	 * Generating the Type 2 packet header which involves sifting of Type 2
+	 * Header Mask, OpCode and then performing OR
+	 * operation with the Word Length.
+	 */
+	return (((2 << TYPE_HDR_SHIFT) |
+		(OpCode << TYPE_OP_SHIFT)) | Size);
+}
+
+static int zynq_fpga_read_cfgdata(struct fpga_manager *mgr,
+				  struct seq_file *s)
+{
+	struct zynq_fpga_priv *priv;
+	int ret = 0, i, cmdindex, clk_rate;
+	unsigned int *buf;
+	dma_addr_t dma_addr;
+	u32 intr_status, status;
+	size_t size;
+
+	priv = mgr->priv;
+	size = priv->size + READ_DMA_SIZE + DUMMY_FRAMES_SIZE;
+	buf = dma_zalloc_coherent(mgr->dev.parent, size,
+				 &dma_addr, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	seq_puts(s, "zynq FPGA Configuration data contents are\n");
+
+	/*
+	 * There is no h/w flow control for pcap read
+	 * to prevent the FIFO from over flowing, reduce
+	 * the PCAP operating frequency.
+	 */
+	clk_rate = clk_get_rate(priv->clk);
+	ret = clk_set_rate(priv->clk, SLCR_PCAP_FREQ);
+	if (ret) {
+		dev_err(&mgr->dev, "Unable to reduce the PCAP freq\n");
+		goto free_dmabuf;
+	}
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto restore_pcap_clk;
+	}
+
+	cmdindex = 0;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = SYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = SHUTDOWN_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = RCRC_CMD_MASK;
+	for (i = 0; i < 6; i++)
+		buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = RCFG_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_FAR_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = FAR_ADDR_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_FDRO_OFFSET, TYPE_OPCODE_READ,
+					 0);
+	buf[cmdindex++] = zynq_type2_pkt(TYPE_OPCODE_READ, priv->size/4);
+	for (i = 0; i < 32; i++)
+		buf[cmdindex++] = NOOP_WORD_MASK;
+
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Write to PCAP */
+	zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* READ From PACP */
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0,
+			   dma_addr + READ_DMA_SIZE, priv->size/4);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "DSTDMA: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Write to PCAP */
+	cmdindex = 0;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = START_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = RCRC_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = DESYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+
+	seq_write(s, &buf[READ_DMA_SIZE/4], priv->size);
+
+restore_pcap_clk:
+	clk_set_rate(priv->clk, clk_rate);
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, size, buf,
+			  dma_addr);
+	return ret;
+}
+
+static int zynq_fpga_getconfigreg(struct fpga_manager *mgr, u8 reg,
+				  dma_addr_t dma_addr, int *buf)
+{
+	struct zynq_fpga_priv *priv;
+	int ret = 0, cmdindex, src_dmaoffset;
+	u32 intr_status, status;
+
+	priv = mgr->priv;
+
+	src_dmaoffset = 0x8;
+	cmdindex = 2;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = SYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(reg, TYPE_OPCODE_READ, 1);
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto out;
+	}
+
+	/* Write to PCAP */
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+
+	zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA: Timeout waiting for D_P_DONE\n");
+		goto out;
+	}
+	zynq_fpga_set_irq(priv, intr_status);
+
+	/* READ From PACP */
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0, dma_addr, 1);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "DSTDMA: Timeout waiting for D_P_DONE\n");
+		goto out;
+	}
+
+	/* Write to PCAP */
+	cmdindex = 2;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = DESYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret)
+		dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for D_P_DONE\n");
+out:
+	return ret;
+}
+
+static int zynq_fpga_read_cfgreg(struct fpga_manager *mgr,
+				 struct seq_file *s)
+{
+	int ret = 0;
+	unsigned int *buf;
+	dma_addr_t dma_addr;
+	struct zynq_configreg *p = cfgreg;
+
+	buf = dma_zalloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
+				 &dma_addr, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	seq_puts(s, "zynq FPGA Configuration register contents are\n");
+
+	while (p->reg) {
+		ret = zynq_fpga_getconfigreg(mgr, p->offset, dma_addr, buf);
+		if (ret)
+			goto free_dmabuf;
+		seq_printf(s, "%s --> \t %x \t\r\n", p->reg, buf[0]);
+		p++;
+	}
+
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf,
+			  dma_addr);
+	return ret;
+}
+
+static int zynq_fpga_ops_read(struct fpga_manager *mgr, struct seq_file *s)
+{
+	struct zynq_fpga_priv *priv;
+	int ret;
+
+	priv = mgr->priv;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	if (readback_type)
+		ret = zynq_fpga_read_cfgdata(mgr, s);
+	else
+		ret = zynq_fpga_read_cfgreg(mgr, s);
+
+	clk_disable(priv->clk);
+
+	return ret;
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

