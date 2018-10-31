Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A61C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A6E20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="t6rO8s21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A6E20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeJaMhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:37:03 -0400
Received: from mail-eopbgr740080.outbound.protection.outlook.com ([40.107.74.80]:10240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728578AbeJaMhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdLXCEjS7jpC8ibU0COcAsOU2lfTyy+gpIkqR1Q9UOc=;
 b=t6rO8s21UwmqQgzi7WLk887UDY9J3V9DAW8x0zzl2w8vLBQfBmnXd42L7DY3VXSERwR7x15iqqHRHjBdGwbzhs0uk+XSLNDm0fMiAQqMGhGTHGHUUc2tF90TNc7R9aRgEugVOpuFMiaBrBEqjhENPsjY6RiV+ZRoKxp1amviZTU=
Received: from MWHPR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:301:74::29) by BYAPR02MB4327.namprd02.prod.outlook.com
 (2603:10b6:a03:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21; Wed, 31 Oct
 2018 03:40:46 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0016.outlook.office365.com
 (2603:10b6:301:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.21 via Frontend
 Transport; Wed, 31 Oct 2018 03:40:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 31 Oct 2018 03:40:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51571 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN7-0003D0-6d; Tue, 30 Oct 2018 20:40:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN2-00039p-2y; Tue, 30 Oct 2018 20:40:40 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9V3eVIv010776;
        Tue, 30 Oct 2018 20:40:31 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhMt-00036w-73; Tue, 30 Oct 2018 20:40:31 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH 0/4] Macb power management support for ZynqMP
Date:   Wed, 31 Oct 2018 09:10:19 +0530
Message-ID: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(186003)(50466002)(77096007)(14444005)(26005)(6346003)(16586007)(316002)(48376002)(305945005)(39060400002)(5660300001)(2201001)(4326008)(54906003)(106466001)(9786002)(63266004)(7696005)(51416003)(2906002)(8676002)(81156014)(36386004)(107886003)(106002)(336012)(44832011)(6666004)(356004)(36756003)(476003)(2616005)(8936002)(47776003)(126002)(81166006)(486006)(478600001)(426003)(50226002)(110136005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4327;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:AJ1pafHcJreYKHma7o7HOj4goyAlXX1ftQLF3Z0Lu5DS8zt48tjroMDA5ulj8WmwCUWzAL8ymF281NoGuac1vUmJbtOAE5PgzPeOosFF6+AV5Ep9cuTO5rXg4gCnozcA
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e6a6cb-56c9-49dd-33ec-08d63ee2a459
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4327;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;3:/4jrBlZe67y+VnpRLhobIXnIe26LsL/wxM+Tu5i8Li9LkeK2F5fh6PSHszbAvga3vMZnFPbkT9wgN5U6f5COHDLZvmALdCut4ANwQV7PDpe5u0CpDN2WsfVNJMuM2KPC11RNtN5HW5kgDjovaTQZ/t/oSo/DTKt2D5JEt9bleYxVzfAvN5HfVVvkGK0Q0ytgGWrvdhYvAE62y58qkQcnTF+bRcRbTUxC7l0dk4NlovAzLxH3hDpxROdpPdJrX0Jh6TpVGpEsQEuVs48eF5ciXsryuWxJus7UN1oHI0GFUY6jJTH0ZY0nxlF5eRxiAR12JEvjKZUJwvrl/gMUTe2U0z7ybNW6sBLJGht/IxyFiNU=;25:a4YV7KP0yN3ZvlgbI2X63LVrypkWPCyFj4Gc1v28NfLl+B3Pe5x9ULChU9yi6RycxJnCRLZb4NflQZiiZ85k3yWwbIa19YHH2OfTlcD7+GEwyddSibIHx/1Y1Zqjj9jsN4YhNylAcgSSnqSCxMSF9yJ3LxyWbGf8jH4j5bsz8MEClcJBXRw2K5cpnb7lTWtYiWQ46iu+DUf5SvT+zP6yHatZP0Aan7udgOtnn6tRP3fDlkvsvvoRfbumzOdPGAIy9IILzPSTferIl4ycqJjAZ12M0klbCpooGhNMr6ulM+8wb3U3kgVsfKuOLSnkVscxqNDfgOEDtVqb7BklYAn/UQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4327:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;31:VjfjSpQ0mJu8QsESKo6ZIz9X1sreJm/96ESf+ZJVq8CnSToZh5ybKlgOlo9iA5LLaVLJwr51KQLjwJZJewQlBh60JpFeqKrUsw0HDwBmrtAQLuXk6KvdZlBIC8IPefOnv7vEiln/P93lmiaCPdlcIBamugM7k0fmdYO+3b5p8zvHEJe4IYeegsneHEjN1VzhEw0TtxQKHaKBH27U050eLKkyXIuOALQbAg9G03e3Lt0=;20:iC/XWu7pgEjoZtgsrwf/kFt0KNZL6AwGgpG0PhQnbbVJFIyu5JwOzBT12AQTBtR9HwIaZCr14JcgKW9GhJjbFW+Jg/Aqbfz4bmWHbzh6MLpVv/XlBipMJD6DGiI8HZi+kCmB8596gctBibDvZQfMbXc4AXXGeg/ulgmYVexSUoAyaXcOesXjx4KuqcdaCd3D55yXEA1iulygMIhy7pyYYjcSbHv7YnTdAZPWuLIQbDWHO+NSxLQweU89mH6glFtoUkg1uWn5xuqk/17yiI5MI/Qkh33EUXf+J1sHEpsUM1+dSo2OalhcA9jCMV2nypXZD5Uh1+f+sYN7ORdW6IC8z4qbaCXlRM+tAnxEJjlzUYuVMonNtmLMzQn+KPpKczJtbVP1Jzb6M2SA2XRJWEXgMjeZT9XvNQjrHqqsAoNZZ/xTxU4vAF70cIFdTxSabNGQ+yM3bokyc+Do0yHjkjIoms4OGWnjao0YDg+n3RmF1RBAIO0lMtlvj/SiDmxuKnzQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4327C2B6BA112020ED4A78E4C9CD0@BYAPR02MB4327.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4327;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4327;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;4:MWGf8Ey5s+LSQIXcHqoWYWAh9cps9SVhB6Oc5RmTgiyZrd/elHWTy49OAoNtCleYQNoXeMQudewONEdNl4bF/+pd8wHb6UePkvvLmInSpig3ym+jVaj/1kQN936Ls5BADbhvhKMmshlr45zuU+TRcmad+OaPymWQbzEIyvUGgep2ieoihRg2MZLDRiHi6d5i+tWJddjSIt0if1VNEjDe5LhqOVjjZXPixfEV7pdjFf70awSos8tREIhkSam1dHRVDASWswLtVv0mvUyrdVBm7Q==
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4327;23:GzM7e4B3ueUpBosA3RntCfddoSu2avg0DAX4p6HY0?=
 =?us-ascii?Q?UPJnJczJu/hLV2zZv5YlIqDjYQdB0lFYYbnIJMYsbaUxSoONPVvfzAFMjG7n?=
 =?us-ascii?Q?Yto6JMqZPX2vZlSyYctJBh47fma+uGXN81jJqAn4V7ugcwMIB8VEhrn1x/WE?=
 =?us-ascii?Q?KUOzpvU2tHqQthZrq+hUvl+5p7KX5qBCIoGuTjK4Wrkua68gbXjoZwhfDlrz?=
 =?us-ascii?Q?YUgjF/DSglf5fiQa0Bqb4ytmz54TxGfOq+VrGdoSxZRpYbXnUx2Fe/gQcBlc?=
 =?us-ascii?Q?eVKYLemdJ10rr0oq3TFWHWMsdpGeKqcF8I9rQgU2ITIKUEgzmFUvKvVQ8592?=
 =?us-ascii?Q?4rwD7e6SD9VEyVwTNlJjkUx/dMOBEWHrIIzPP8WOVWpt5/2mUdIPWbSJKSDe?=
 =?us-ascii?Q?2742NfGyPxEFveAUFwFYwsj2lTKNG+PZj4l/BTcYblpk4Qk+5ViR6dB/RkjW?=
 =?us-ascii?Q?EBrvpB1Iv9/OpDTgNkDtyrI2aC20WZjLLK8HLsL2yebEhdBZCPec8YGQATP5?=
 =?us-ascii?Q?8oUasvCfYCI/8lt+8hC6MXwAQzCQJYqVglCKEnFfZX23idE/99LgOiyRq5M3?=
 =?us-ascii?Q?fMgULrR5t/XTIKgUVUFYEHDmubNify52hh2qS4sx0xhXZ8PK/uyJkbzjYbTt?=
 =?us-ascii?Q?1FH/sNlWOWqABY9fGR6s2aBKmfct42Nx+g8zX+RE8VE2vX7ZgRqTUjRQN4Fw?=
 =?us-ascii?Q?4hcB8hQM8jOX+u6gODHYQkaKsDV52yb2mkLOzBBr8EFe5KnsYKaTNXMiqTxV?=
 =?us-ascii?Q?oI6EaxkgTLfZ2g5lBO4RRQ9fIY88Wnq3qEVp0UqiLZyse+uuFuW70QWx/Kwv?=
 =?us-ascii?Q?k0LAh83jB0yfBm6iF8dzxHhs5sqhm31lLkblwidCo3atxOq1ZjaxV+np3MsS?=
 =?us-ascii?Q?Rlpe62HdSwZgDgaiHS1CqR6OtGqAby5+wpy5fCSbBZRs2PvnHAoLXfUcPFMt?=
 =?us-ascii?Q?ab8FNk/R7Ytg2uy2WzmJvXWzH+t0hQRxqPVyzON+0yt4ihLQdTLURtAQusHW?=
 =?us-ascii?Q?W1RxyuNueyvMbt2tA7KbN3LdoYj1XcTGCGqB0w5/ytnTYVPBgzk0tCxLD2P1?=
 =?us-ascii?Q?W4ROufn+KujYWYL3JUE5TutZpaHC0rvI0p/Z3gYL3UtBmaIgsRdCRUBkt/Dt?=
 =?us-ascii?Q?X/IxPDkiCVymQPbSPdNPil7P2WzmTMJsG5sDdzIGjh/1S8x58ZTqlaQ0Q5K7?=
 =?us-ascii?Q?AsSaWaieO199xE=3D?=
X-Microsoft-Antispam-Message-Info: MxL8vxuVfTYJ8WjpyU//38skkVQvPB2iNnT+qlvyqTn47/A5ZjXVZ37FG5IMAYyQIVLN0y+us2xr8ZMfCQSYxzwCVkWtB/geQLqNDdyRjSieZcRwWPnLwdHD31K60GMpSa02RHRd6lh1p1ZPgxz1d7BOHr9rJ/uzx4v3vQ56zHu8QwDO7G+l0iU3JEFI46GnC1EN8ROnxMGrqP7ESPORzX4qfIRs9nY/V3ydWM2LK3NwsnqouCwWH96MdcNWf2JS1fprrE4E0+cwNiemH5J/nlCrlffDWA45KT7lsNpQFFzEJ/riEUu4f6tYRiwanTpkAZIJQ2yPMZKgQbyg5vpSyOLCXb7D0wg7PZy5Je3OQCI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4327;6:/TM2CaahV0asg69Fs0BMwAK77SbzpHKWy9RmaygK89oxtEfIdgXr4dB3fxBFxh3e+fAAhfkTAgKCq5f1Kur+uPxwnXln0FvKAw5+8Zt4oDPkom6PByYWqAxMneFykYQwhDi9GiuHIMWyp8Gq3eyHIWlbiJJXYMpWaNyjNSuxxS4LqSKHEZNP+bZJoocxzcOW69mggMNRDUbdp7cwsMzwAn6WLq54QgAg6qQFSgZ9gf3sfpw5wQr+hYxUQ7JgLi44r+GcXfto0S5e1XXyF3ukiqSsGla4grBBF6NNwRItOQJmzN1HzL5QHjECzQFM0hhRYSpAodgCGNwiNWxvZF5Inq4tJfBJ9mHYXNimhenCO6N8bhLF9znRNjOFHi1GyY4YAcqnZDQ8SYc3YineP8vvFC4FITLkBEqzyvMHGzK7RO21jwtIWrU1CtwdP03VzJVMEBPbIwSvQXLECN3FSBGdDQ==;5:0VbukrYh/rBqk9zU+A/FTnI5O+MkD5HmElD/BGIg6hnpJ/PGWtqM0Bb/15XCRjQMz3QPqeKznZt86TKwO29jPtYjpmNlJXr4HGaIKI5zlXscX5jRWsI/HN8Dn39n3dSb/sQXcao1jIV3PbwY4EKPsvkuVQuOtrMJc8VVTMyJamw=;7:qPlhu0+yqJu1ok19N8UOawx45osu6RbdVDI//ge3qhMUDPtpKNQj7Uiw67sSqRRCe8BjCp7xtj+l5uKz5jnQCPF+o1c0+KW0IgsNLPknQAil4KU7frkawAp6fAvVPeZGoZyBYU8XKHao4i6TUnALDw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 03:40:45.5969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e6a6cb-56c9-49dd-33ec-08d63ee2a459
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for macb suspend/resume with system power down
and wake on LAN with ARP packets.
In relation to the above, this series also updates mdio_read/write
function for PM and adds tsu clock management.

Harini Katakam (4):
  net: macb: Check MDIO state before read/write and use timeouts
  net: macb: Support clock management for tsu_clk
  net: macb: Add pm runtime support
  net: macb: Add support for suspend/resume with full power down

 drivers/net/ethernet/cadence/macb.h      |   3 +-
 drivers/net/ethernet/cadence/macb_main.c | 207 +++++++++++++++++++++++++++----
 2 files changed, 182 insertions(+), 28 deletions(-)

-- 
2.7.4

