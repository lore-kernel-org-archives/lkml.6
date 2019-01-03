Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D10CC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3DB217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tvidy4Av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfACSKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:10:03 -0500
Received: from mail-eopbgr800081.outbound.protection.outlook.com ([40.107.80.81]:9440
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfACSKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7SvDH7Oq7LyF3jGwCydJ2gTIjPfmRHMVPFCLDoDwo8=;
 b=tvidy4AvhA/YslmKviRvFxObFjj3i14fnv7vKyGWsjRIyw7U/7xHS0xv2VP3JfKdvfk0IN3dWNmMAhC5PBGI1u1j9J49eaFum5A1rr0HnbQ6YsyuUQa8Y4OaJ9/7HzVnVKTNoKZyph6NKIYssTrf/AXsbj8kAQhQXwk6l0YyPuc=
Received: from SN6PR02CA0012.namprd02.prod.outlook.com (2603:10b6:805:a2::25)
 by SN1PR0201MB1903.namprd02.prod.outlook.com (2a01:111:e400:5223::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Thu, 3 Jan
 2019 18:09:58 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN6PR02CA0012.outlook.office365.com
 (2603:10b6:805:a2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Thu, 3 Jan 2019 18:09:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 3 Jan 2019 18:09:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RI-0001eG-1C; Thu, 03 Jan 2019 10:09:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RC-0007gG-UU; Thu, 03 Jan 2019 10:09:46 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x03I9dOK025358;
        Thu, 3 Jan 2019 10:09:39 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7R5-0007fE-1u; Thu, 03 Jan 2019 10:09:39 -0800
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
Subject: [PATCH 0/3] add Xilinx SPDIF audio driver
Date:   Thu, 3 Jan 2019 23:39:50 +0530
Message-ID: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39850400004)(136003)(2970300002)(189003)(199004)(8676002)(2906002)(8936002)(50466002)(36386004)(50226002)(2201001)(305945005)(81156014)(81166006)(9786002)(356004)(6666004)(63266004)(106466001)(7416002)(48376002)(47776003)(5660300001)(7696005)(486006)(478600001)(39060400002)(36756003)(51416003)(16586007)(110136005)(106002)(316002)(186003)(26005)(77096007)(336012)(2616005)(426003)(476003)(126002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1903;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT038;1:Mogtfo4UcgMR8c218bgv8t6Hxy7tssyTNd7Vo0KVdHKnYy1eNFQHq3ujOGWErSsNv3VISTlWoahOAPFiLwzTMhWJ1C9AK5A+W6SuIe0nwCiQsxu+6TlfKSRw2uzl0e4D
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6a3330f-8f6f-4e12-6642-08d671a6aafc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN1PR0201MB1903;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;3:YvV6nykv9I9c/Hcyiju9ue/gXxBNHJVgdXVhmjn4+n0aHeL2GJPJnGOJNXfH0lbGrW+qT38JNyi9PmLl5Hwpwp350TB+7JKNUkWeie2mqq4aVhGcC+KnidVe1zRqXO6H4cH0z43+tIc/p71Le01b9UL/VtChRJTwqVqviIH8nRWHKBkQ41U8WjoEaZOJumfROr/GKDfCjRv4qcfVTNGxU2ld42R6H6ES4UQwMpwsBdclgl2uGO66eB8erdNRqbGEZPSS7pl4vnWp0TAoY+zE/Ez/54kj4+8CfHRuoGT9MoDBdkhJ86KTfmBqPRVgJ0OTa59vyGgVitE9QR0YAaqy1kuGM/LN3RsMokTASwxATsa/GWIW+t6C+BjBh8PocPtX;25:bKMgm5y+uTvXqzlR3JzX3jH7aH91v5wVj+gwy95cGFS4n/DThuQIywzZDpu/88v51Z8leg6Iw6ltm7iaz2/xr4zp4KaIp5anwN6GskNo6hqC/I4Rhs6ZcSvhKYyJQV6I/9W3VbUg54RJbyE0If1zrKYIAAaGuRfzDyBZLksm3VPt/QvhBDMSJozDyjEd5NJ8d+r2po8Ed1Cm3ba/WGWdBDkS2UbHyXbrGcYrFMjS1Jo0tcgue0H5F1g/i2CmIdr6osJq4bESPDj/6UKqfZiFACEKepmiJDPFtDCS+TX0gGFdR95P4NIbcUmQUzvVtRqwRGGD94VAAj1qOeTHGq4eqw==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1903:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;31:gCxsiMxmjEEXML0QPyp7W0RNlgJtv+O1nU29bINwN62EQF84wiS3jsU9bZtUPCvZZRx1NT4XxOFx0pGxEcEQ46ktHFoixqIoZz3JkqcEMQ9O1xLUjJyxmSyU0/CntxvpyD9QOjmWkVU7m7jGzzYOcvpBQI0n22XB4UCkXYpU8B4gJ3fjIHGVWkFdEz+7I6goxbw16VfR5kDlc6AaCMtWk6DPTAwAaXHTpTv0mDLM+bc=;20:XbuJHGnyxdhEXnuEQVAW2VrfQK8Oj1PqxLt5+WDG53TWujVH2T+zE6AbQOR+t3sKqvIEXCbzg4sEeL0Iz7BV+5BbOItskS0NvkqWOgP2pxBZQcbUswaYA292hh0pMTwx6NWwGAJMDVlOCB1sr82M6mQH7/nXbgRrIczeAkjgeS3sPpHTnvEBkjX3SwenMzIpMlFnqxk3Ml8ynggaEHVsa+J9kN35W6+NBr1WnIjRO6rJs/SQ+OqkKKzJYQbXMgONHV0MFrH/wdIa2rYw8zRKgdTMWFWQgic/6uSWlvkkWI3vBPLqzgpLFDClksqYtGu5QKF1hZl7Us5xrLAoYMFqXNiNO4ToZBhbdTW0Qh/nwxxsTL8DZv6qcF7h746S8Y36LQKUNdovvQUoeEP9adjEhDIgRu8r3BCMBOdHqmlrb2k8y9uWiXPj5fRE4TGR+thxkXTYNoHMLS/ELpxGo8EmI4qoeGxAnceAi55cZoD9exQjb3p2m7SkLDWJyeODuXUd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB19031EA908DF4C385D902439BA8D0@SN1PR0201MB1903.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN1PR0201MB1903;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1903;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;4:5bmkLAS5poaYvJfBtGyY0nTjnZk9PKeOhYEBgDCEMLoIRLps1BUpK16y0nCoguZjQT5N698JoY97sah5KEVWtHU0R4QW0C4msjqW1evQH2zigSvQUDZYGEwx7rWwrEEvUnSMmuAOxF/lnnHM22O4PEX9xl0Ga2JGuIraZnbndMDR39wRu+VdAFXIvHFDmOZuLGGKricf7oOBMtulInDisk2JABqJOsFs4R5E2RtqiMUOF3PToZMaeg5/5S6v30RaymwS4wzvear3HvNsmR6hakk+pbS9rM6BMnmJCPXaZB4ey7AzJvJVfeTEkiYxyWla
X-Forefront-PRVS: 0906E83A25
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1903;23:ovBmgPgMplWXQyMeAc3kGBjhgFpVbdMeDTQCZU6?=
 =?us-ascii?Q?ibFaslPEcwYBdLXBR9NE7kFWMEzmQPrQMGpP/szPErqPPJsxAFGaWn5iAcQG?=
 =?us-ascii?Q?TpItQDSguCvE4tdHncOBGqeYrTz527gZxtSv13LfPSAWpjio84pWrrPHFPaX?=
 =?us-ascii?Q?C9IY8GyNwv9VLgC8v6BcInCnCrbkWZRsHt5rvrVuUT1ek4VHl0mmYoQGoW0z?=
 =?us-ascii?Q?pgyQTQXGhUSYGbpl3yzlCLE2PdJLgh9OC8GO0Nv0axkDMA5c6UAJE/VO74zF?=
 =?us-ascii?Q?RTKwv8tnDTuEJQtcGgVRJ4fqJ83fKavFHxmyH8KQtZZ34UHsvh4HWeta63i8?=
 =?us-ascii?Q?bJgFi66fV0CeSd8wiSnjkrfX6ch2/Ey7fiXDPx3cM8H6aK9Pm3dM4ZaDvn+I?=
 =?us-ascii?Q?l1GeEHkQtg4egp9alwFgKL50gwGYW8I/VsYE0QzKmGC50ob46Zz7XiXs28W3?=
 =?us-ascii?Q?Kx/1BYcXB2dGITe7cp0Q4NeVAEBY293BmlgisXNc3OSDVfof8g0a+y4/IpSg?=
 =?us-ascii?Q?J5Qpf5bVC7Ga10Mrtd3aABQBoJlGp40TLMcSGWWRfLcrpJXXl6RWH5NX3y1X?=
 =?us-ascii?Q?mlzo4mjC9YxRk3ymYm6qG9sxseytk4Dnp+zi04tlsnO5P1EbpI6M+97qzjsN?=
 =?us-ascii?Q?EI3zzGxbaAw3wjjYf4HIPZw27sasgZVLgnqGj9vX6GTEkds2FVTCIOeNjkC9?=
 =?us-ascii?Q?1aPZ4wJ+GJgblS5qpVwHmcvm6HX1ZKbzmydRGmHZ8Hq9wlfJpF5o93USf5Cb?=
 =?us-ascii?Q?oN3G1b3won9G+Ym7kL5vMgWut2jY66odftRVWtMrzpAC4lADmvy4MUcHRE8g?=
 =?us-ascii?Q?+93qBF5CG0B1rqpEAaSgoi6V0/NWKC4S6cmRTUqqTEiNyegbzNseN5YKy3VA?=
 =?us-ascii?Q?yh6bfPyOZPTxG/U/Kr85rbxwIXRGq2eMfT8Jrfmv+QkrTvhHS4B4SH+jvFik?=
 =?us-ascii?Q?uB9jqzl7w9IscA3LF3qzXHgpyeF4R0QF954rOI/GPPH4LkW9FWKsmZdkUmU1?=
 =?us-ascii?Q?T8yFgQUQtS+Mb+8TYFfxWymglCKrjov2GXOCrSpMJcwCYG/MGugw6xSaFotB?=
 =?us-ascii?Q?+ocOdb5TNv4tv1uM0aDj0BE/n7o1Z?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tWESEy9Ec2Utio3VLtphXqCEMx5g6s7uTdt/DUe4EelapxQKltLVSRDCSG6y+HjPx9Oyb6Yq5/I7VcP3pPZA0ETOFqBvCPvJz3fJaHfg4eaogPe23n73OIoeUwtDGAGz2IamQouvHSJvsxSZfKUdFKSs3evAdSPaKDhTfRph+y0Ax6epbK+IS2h+PoxFazyJdsP8sDJN2VcD0jVfVlmcaCDsHR+Us12oy99icLPo4mmytvPVaNzYzfT3fwy2mkMkWs+Tb+iIt9+kUjLiqp9OGCogSbnD2egIc9Rul/XO/IS3GoNQ815/MH/Lxjyi6B/i
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;6:B5dVq9imy3fhLbzqzW+6+PgjVT8H8dSMZv5fiM9R8zIGu4+TBf3fFa8scKLx4Smp+Id2IkjrA7PQ5RdXdjB4rdjuKKMDT0quydevKk+BnAgspJkb2QhVAvfSoqVtY7+S4OdqufM1kRsNMmsLCmqOqUiveONo+mQetk+T7JcUq8GI43oKRLXA1Hw7Hcmop43ikJ8jS49eW8G1LUmLNcocEZlsoUh2xg+gUiOJUO+FyZe/CUW69AqWZRg2egf8UdRDBKfWcOPt3isMYJd02X6U8K7EsWfG19YkVP2YBxVtukB1zpEZQA4bo2I2r9VcD9OE3mwgO7ez7cLOU65wwmA47SRSp2ZKli7qU30fye/P3LCjB4wmCeKu0mj0MkKZvm/WlM+Ioze+6LcgyvzQV5EG9BgqZMkhCAAtf9PCGtny6FuAISRYtyGbkUEywDSgWC14CqOS6RjdHvSN80jV8JUrTw==;5:Kqd2X9vzIUdDIdoXz0c8SPBDRz5Mbe2XnbYCnzFvBc0GBFBS86KcNpH7QL9TuxQ7fbiUinQrZeniPYK+g3v2il3xjPqj/M0YK4uV3CLDHbQ5eenOq81PnmjAL5fMxXE5eiblpN8HucAS+f2F3Pp/sp2ze8MC2XnYl/nxd4hT5vWoAkuvB1vwufZ9LnOg/p5kDUNHk6ayyaILtirlKT6vjQ==;7:AuE+eIOKJJ0GuGZ5c/NRZEzZzVGUHVx2jylRLh2SU+ei/L+3gfkQK+PmqD/xkP9FKltWhTWYIRvnHNlVCBPHQHgHY6umZ8ih3w+7gFXLP0zZ7M7t0BIyMkUJj+qZ3GW9phcW/98hFUyoBPUiKGAn7Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2019 18:09:52.9493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a3330f-8f6f-4e12-6642-08d671a6aafc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDIF IP supports playback and capture of audio in AES format. Each IP
instance can only work in either transmit or receive mode exclusively.
The patchset adds support for playback and capture functionality.

Maruthi Srinivas Bayyavarapu (3):
  dt-bindings: ASoC: xlnx,spdif: Document spdif bindings
  ASoC: xlnx: add SPDIF audio driver
  ASoC: xlnx: enable SPDIF driver build

 .../devicetree/bindings/sound/xlnx,spdif.txt       |  28 ++
 sound/soc/xilinx/Kconfig                           |   7 +
 sound/soc/xilinx/Makefile                          |   2 +
 sound/soc/xilinx/xlnx_spdif.c                      | 339 +++++++++++++++++++++
 4 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 sound/soc/xilinx/xlnx_spdif.c

-- 
2.7.4

