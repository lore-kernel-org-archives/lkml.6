Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838C7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281F021537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0m7mBl2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281F021537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeI0A1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:27:39 -0400
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com ([104.47.41.81]:45669
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbeI0A1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ieFMMFD5YymlsCrc55U0HWne5a5d7Qf4Mjqq96VLh8=;
 b=0m7mBl2A7+DbVe2V8b6wEwQqrIh1EcJDgEltAN7GZ4l+e+0tgBfszY0PY0tJY3eJf0rS4f7GC4sYKYY7TY8I9420T2Tu1kXg/ja2mraeCfuiygEbmqIK8pxpB1uFsx6qEB4e8kCrmTE9pYqU+teKlDQonWqiW9QNs15wcaMVRes=
Received: from DM6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:5:1c::38) by
 BN7PR02MB5107.namprd02.prod.outlook.com (2603:10b6:408:22::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 18:13:21 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM6PR02CA0025.outlook.office365.com
 (2603:10b6:5:1c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Wed, 26 Sep 2018 18:13:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 26 Sep 2018 18:13:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50519 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJM-00023L-Hp; Wed, 26 Sep 2018 11:13:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJH-0001bP-Dp; Wed, 26 Sep 2018 11:13:15 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8QIDDu9020568;
        Wed, 26 Sep 2018 11:13:13 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5EJF-0001aj-Fj; Wed, 26 Sep 2018 11:13:13 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 0/4] drivers: clk: Add ZynqMP clock driver support
Date:   Wed, 26 Sep 2018 11:12:57 -0700
Message-ID: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(8676002)(77096007)(6666003)(26005)(356003)(2906002)(63266004)(5660300001)(106466001)(106002)(186003)(72206003)(51416003)(36756003)(478600001)(336012)(107886003)(110136005)(16586007)(54906003)(36386004)(316002)(47776003)(486006)(4326008)(6306002)(50466002)(2616005)(2201001)(7696005)(305945005)(966005)(81166006)(50226002)(81156014)(8936002)(476003)(426003)(44832011)(9786002)(14444005)(48376002)(34290500001)(126002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5107;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:ivfvKu6SPus6Czwv3Ep7svwIGyb8Dy0RLnl9HJd0yyZUvlYp52fUy7qLczPYV8B1j74Fgk+i9X95rdss3T80LE81jXTitczwNQ7pef3fvDa+/bBg9D6k+P211LVaBCYC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a931dc3c-3a4d-4fb2-03d4-08d623dbbe11
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;3:N7l7j+7EGx2fiNALIEWFGSu0XALG3HUgqyxgVEVuYM0SqMhB28teQuag7mfjfnSC1nAgA/jvtmg+o8KuZEnBBFK3wx9qfAOtKiLO+28i8aHQnFpGjRNd0LGgri/dv5+Am5DW2vMCK4vx2qcTKpEKQmOgtc/6GobwD3eRIYrI71of5p4xGQZ7CgnDnfogDufG9m3ULKFqg18zYBwqEXRwKzvVt5i+pYU2XuPNPa5yedxxPJYromQ/jeM/eCbQIiPxG6k96U4AHTWJSXrPEm56POfsPRD4IQ6zLf2PrR56egceipI6Y8jjWW6BFq30kZFSaLU9n07dIe8D4Vb/E0Sjs0YMAEZp8T79dtGhOV/hGUE=;25:FDKuhsf0v4LlmVgJz9zCUqgWinJkuEGytBG5xkL1prhtFNg3twPL6rG077L5pyTzYmjaD6rnP6TobaXUdvqiVVR5FdGIvVod8sXOyJh2QCGkTobUS0PZUCm4Loi7umhU4qmNF8rEwrZQCLsIcDOFd2QKwhNWIptvlJQr4f5ri1XdgEBDwZ3ifTgdRNsWz0kODFJkixGOLA06P09+9iVIIVoLKph142tfFUwzLicKtn3ls5nOZN28D2/NatdI9oVg7FNyas1AucXp2WaAEPweygXNDq7+Hh3EMa4zEGyeFBeEO5cGDbKhSym58qpQq9yJ0lfwbKJn9gY90/G2Xh7X4Q==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5107:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;31:2oxcRyblRIfIr3A1uUJlt/mEVwrQfcaP/Gcztlup2PtpKPj2uE8KJu99FMxcEYnNiQi0dfWjk5NVC9MNBK6qkSx2GsYKqPPN9wD6z3e3r/RRIXkdHHGyvRzUKvDmWxfRIx3SQ3sbJv/CQljZdXlCuVdCYAdSaA9nJlyOTPK0TiZqj27h7r3jgaELoZBFLgrQSjndWMN7CMe7JfKtn2/3hLb361QOx59emZeCp/px/tU=;20:85VfjeP2V5TFgZfbDOkG/eGrHqhpWAzAT5NvjKruMPyQt3kX+xCN8nvtfnxH503f0IeoZSbyNk44RuS74GytoHVmEnrgmTa2DrHqwWmV3+C1zzTCOrywbdHIufdVLMpbL5GBfywa+RJY1iGkdhEg7FrPQxyV9an80290kE/WrvZvNIQHkhO4UO+Sxw6F/+a4hXgfD2BChnGOddpw5k7dXixK1R22FCr827Or7Og9OZl5iVH2+sieJhWcYpA0mFr1GhmJmumFRuNxSajzfcrGOkA72wiZreQNQH812T+yUb+gkl1yEq0hOqMtmOS2J/ver4gO2U127aJtQJ7mSYRCJG5vypRMfKlTiL+89P+pcg/USXza6Z9VOEMy74RT7T0ZYwwoe2+ULV7ukEuMHpyngeCQ9moSP/MCsdS+hgYyjSnGcqUgrlIkmXB+CPGE2a6uIfp04h1T9oIuhaQjUIlNcdlmOpSuEUQBj6zTvozIatuosty162F4GZ2ZWrb5mAT8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5107AF26A44E00F2CC938879B8150@BN7PR02MB5107.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BN7PR02MB5107;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;4:eh9FfeWpC+vga7V7kYkX4j7ToCWXVv3W5oAIdy4a1X94OMt5obo21ZSgNOvdjFzN1Tl22frZpqTo6aisDb8fhueZD4VhLSDjHUKatx+uDCX0Zz85sPlg/IiQrALFzuZsRkzsrSTjXi+ESoT9cR13yZ+DKA6dNJn3RxaEJwTmX72K45ao8GoaYok+/bf4kplLTFGDW8izhgeSm39Nvdo4/exuNRXsiI6rYEWRHsuGu9wzu89mfUQ7GmiLOBBuDrXHj/+2Kg2Kdm9VqKqKiRrvx9y8Ma7B19d1rOZHAlEQ3BZS4EeCJqfj5863bpPVmpBB
X-Forefront-PRVS: 08076ABC99
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5107;23:0FFDZAdxn8w6LhvSymMLyk46M0+DvO2GB2TRq1RIG?=
 =?us-ascii?Q?8BHhqqKYbGoOLQxF75nMsb5qWtHS5/IJoTHcPB30EZfyNC0Fvg6u4nSnyXfc?=
 =?us-ascii?Q?7qkusRjTRwL2hIlya8xKsCyHpSmYEryyYVBgT966a5ssbznNQ3FSyEKkQ/jq?=
 =?us-ascii?Q?Tex/0ywA/JUswNOX2m0GsUb86jvHC6qEeNTdhPqaiRSCytrjliXAPNY1knGv?=
 =?us-ascii?Q?tIq/TSfQkAvoa1MqXvq5LF3c+pRVhisunPFPEzXDHT4CpQkMKRqkNuGlsbzD?=
 =?us-ascii?Q?2ipL2LJKNYNCa77UqKX4DT8EoRsBQHgw7KbfijWdWJEKK/CBvPwLSkuje6G/?=
 =?us-ascii?Q?+Amfu7wl8iPmzbW9Z+TMX+ZzpK+biKfqhZ9FtZh0U059Tc8Zwe6qJijpVHyv?=
 =?us-ascii?Q?7b5cKQSRuP2a4SssR9qlJBshpzqa7cGcl3qLtdzEdgR5doLh9YR3w0j0qvhD?=
 =?us-ascii?Q?mrgRsvNWDkcK3sZ+C0Nm3RIEJ0lOu3BBFr+E5GkqODEpC4v2+oUqW6PN6v8f?=
 =?us-ascii?Q?C9Y9hA5C8C8NP6n1Caruau7Noc2F30a9pa4RQKsErTDwSBR8XyW1x7aruQOF?=
 =?us-ascii?Q?Knaf1APbgydNUpm7IwOJKLIKWZRXwToONdojsAXQl+QYNYq8CgFPnTArc8ag?=
 =?us-ascii?Q?h/8c3VMbIDVoBiYRnYVh7trZ/OtNFSbcs1+pov36ZdUP2amtnxwzbTR0h5FL?=
 =?us-ascii?Q?r1HEMs3xvIeQNm+M8BjA15rveAvsVTXXavAXl1SJ1FufMeyRL0h1tvKViE9y?=
 =?us-ascii?Q?cZP9iP8o8lBsrd/KTOStnopt7vhCl70HUG65Hb4DVqQY3RSB9BOHE0tZcfYx?=
 =?us-ascii?Q?jpqKQ8Vf0UxDbMrhtekF/En6SBNlNwUOZks2ZrpUQZ3W5dAirrXKJgh8qjMZ?=
 =?us-ascii?Q?mQqJCH50vxDq91ti0pwCT7wpNfbRrtu+ABs8LJmHAIaLnMxJCM5O1xnmWBF4?=
 =?us-ascii?Q?XP3vBWjaiNzV7XJAa0Kh+iFgPciGl5Mtux5xaUH8ECl9w55MhL9UGCwY1g0M?=
 =?us-ascii?Q?hpiCJUOvifKjXR3epBthbC7J6taGEiSSVqTrnZ/CtKXIE+v9bkm+89zOYXPe?=
 =?us-ascii?Q?CRMYP5RBE9DT9YHnEF4IGi7WeTYsv+DsYxuXLAKr5bRAttzjv2h8tRO1xJpw?=
 =?us-ascii?Q?V+L6J57CoKtuqW7EvmLMToaAPmM/4nEcHJLJ/3h35y2mOhhRgxsWk8Q1UJIB?=
 =?us-ascii?Q?Eu2rT0EulDytxcdiCMd17LqCeHH/0Ptyur9hbXqXzSGSJzfepBNAeP2Gw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: pvSQrmWFhovM3Md/XeJnnthmu/jGmcKKw5doDKU+HO5e62kiLIVwj7WSUraf75pbH6Xg2xhjnWVfi3j0bWI5LAZDh81NXCUWxH+kNhx/oaTcWfNH2pENmUwjtfHBKsPGY88WxLE8OZ4BuVOMNXX1213KbDm1+oTwYulyQvqUu+GMiZtsC/VOcSN5oKbvsBXCmjhSjOXybiOBcVNexXlcL0OHzt63LJffwo8cHIG4r0AxhgxRS7CU8J0eqSIXCEKEslbJNWQTUkhUK4V1Gx4CyIS6d4u0PImGTyVvdRFXb2fHViD71InJW/p4ZaGRs+oiT2iaFlCEa0uNmmgUz0on2mPhFxbZ2eYOaSNlyI59QWw=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;6:DX9VU3UkUtY+b7mnvxDUtvqQXRuhlAekjoPuBBieqVH09G8Luny7h7N6TrIUFaUf/kWP8NDBMbxaAuERtkVo09suV2vsmzTCNzar5tlSsQwARY1Ix3f6tDc5iyEp8gRpTrxSMfSZB7KT92w3fJZ/zIfJycTeLQC+JWBlKcd+eLrNeKq2amfbqzQzoDSh8gRAtt4/GImpZwyWmFpaIkN6AQ0r+LhpvKrM5+1fOj4UZJ3HQ2fezDOHr2O6di2MTh7rwr2SqzJm4fdC4z84RIDxCBXPYNcMX4/FcEcORnIbQbIQbmaPIyrOxD18UwpTAbm9alEDTC7ltu9xQqTFqbNQ7xdKH8/itQWm0JFv8g8BM9AbDIU4KcapoKjJgeG3VT4gHVwwTwEWN9lDnCh0iwUx+GrDklVsDEkSKtRcBE36D9UHG+r1sW0d4QbAuFtrBQFLZjlgedU3Aqx4gLkMlh/rTw==;5:U8KllGJ1rfnhNASJfaPoYLUrqK9XmFQBeul1sQql7dxCt6Rga5nBkwzwO5BrcmTMipuN8N4gB9Z9SOZdixPA8niaqHrVPGu6drzSeKxH2sZy9TObW76CukPL+Vs4VIv0VeHe0pLWlCwQepAMyYbnJ/2EuPbADX0+77TZ4LmX7dw=;7:gwLj8QP9rS8OFnYSUdGaHIVK1l+fkSKophNlNrUHzFUhjczOHExZ/qnJ4qOlMJnNgJ/TVnj7Pla4TpjKtIRylpzGn97BzGq3i7lFSZ69FL8Ue14ZQYRPkvgdVLoIYJRXLUEw2Jn1AwPhNPpJQVNgE66/ezfDcZI+pJ4gXdQpETTTAeeKyYkBJOZ70ZDwXKQXKSU2ij7igR3kpX42hGwr/kTkPBhSFyl9bYNp3AlCc1s0wloHQR1SPmZ9CCoNGrWm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 18:13:21.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a931dc3c-3a4d-4fb2-03d4-08d623dbbe11
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries 
supported clock information from firmware and regiters pll and output clocks with CCF.

This patch series is earlier reveiwed as part of FW patchset (https://patchwork.kernel.org/cover/10555405/). 
FW driver from that patchset is merged. This patchset contains only clock driver and is based on top of 
xilinx firmware patch set available in below tree:
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=next/drivers

v3:
 - Added check to pass only valid ioctls for ioctl eemi api
 - Added eemi documentation including ioctl details

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (3):
  Documentation: xilinx: Add documentation for eemi APIs
  firmware: xilinx: Add zynqmp IOCTL API for device control
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++
 Documentation/xilinx/eemi.txt                      |  67 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  43 ++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               |   5 +-
 15 files changed, 1920 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/xilinx/eemi.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

-- 
2.7.4

