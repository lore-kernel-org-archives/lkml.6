Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DATE_IN_FUTURE_24_48,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FFEC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDA021773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ru48E2/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfBCHJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:09:33 -0500
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:56576
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfBCHJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjNG9zTOhYwF+USYWsutbTQET/27oZW1mKN46DUawf8=;
 b=ru48E2/wiMXxJr050jWHuiQ1XcaHCuqkdN+k4whpDVdCW3UsFAtr7lpZkDOjX8BfoFHQvSobd18Z9I/KFQ9nZ3FaXnmFFHa/KjFHKtR9xwdjbcO80YaE0l5i11mVAa8ws4mNq/TQQYeGDDxHcqSWygNgBAoxgoquiRJRog1bNHA=
Received: from DM6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:5:1c::38) by
 BYAPR02MB5015.namprd02.prod.outlook.com (2603:10b6:a03:71::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Sun, 3 Feb 2019 07:09:27 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0025.outlook.office365.com
 (2603:10b6:5:1c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.22 via Frontend
 Transport; Sun, 3 Feb 2019 07:09:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 3 Feb 2019 07:09:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49879 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuA-0008Je-HI; Sat, 02 Feb 2019 23:09:26 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBu5-0002Pe-Cw; Sat, 02 Feb 2019 23:09:21 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1379HwB026900;
        Sat, 2 Feb 2019 23:09:18 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBu1-0002P8-7t; Sat, 02 Feb 2019 23:09:17 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Add nvmem driver support for ZynqMP 
Date:   Mon, 4 Feb 2019 12:39:48 +0530
Message-ID: <20190204070951.6933-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39850400004)(2980300002)(189003)(199004)(47776003)(110136005)(305945005)(2906002)(4743002)(8936002)(36386004)(8676002)(316002)(50226002)(81166006)(81156014)(50466002)(336012)(426003)(9786002)(48376002)(126002)(2616005)(476003)(486006)(106466001)(77096007)(186003)(63266004)(356004)(6666004)(4744005)(478600001)(1076003)(26005)(36756003)(16586007)(2201001)(106002)(7696005)(51416003)(107986001)(921003)(1121003)(2101003)(5001870100001)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5015;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT015;1:CJr9ka3SpBVwYNzhxnWOmOj89zQCOsSJhcaRs2VJPZcd3m3LpD2N8Rl147w6kowlDjzVDiFsRql6wHp/l4Ho+EH1pnE/riCT9VB0J2sW84/+VN3h1FSAS81NESaPxVyPKYqhANyO/lGLeg+M+YNBWA==
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79aa4aa-27be-4e7e-26da-08d689a688d4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR02MB5015;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;3:Upt2NZtdZyk9IAT6Gg/xnGoK/cCVqOBtp2D03c3D6JDPXeFYR8EilAAsi+6F038ME0Vd1FLcmB/5n1dpzpKXJjifQuw4a3Gh/VbJTYkHY07REIKO9lc6DCuczaFehSXarGLtZDdP2ajgVdclxLZEU8q/IVsni9fMVGOgGQ+fQ8YC7B61JAUT2miL5Yq/svqo7jxf+pbdCBP+eiWPxtJm0jo8ILpt2s6CW7wFAyYwg+t2etCAhTwEDuJPVmSHZFDrK0SYYQA1we2sBMyLMlGbkVymQ93Eiccigxazoe72XtM3Vu3lAb6wN0pgLwkTrgcAHuW66ecFLNLSMC1GqJFwgGc2tjidQ9BXpkPXYlpbPH46C09Vi5E3rHPw/ek76N+b;25:RTDUpRsYNwqam8oWvL5u2900MW2x7K832AKAabt4Mdb2RKMQEO24mIbD0ybMbbuQsUf9BjmYtLJWsdA4hRIoVJxQx3ajf812aWvqESCJg47qjukMT6DIZoclzLqLXSC+ZaT31TX4nvKTCWNgHODuhEzVbMYcgCpiLRnvL3GDUGV0ENTs9Tq5WWMMdeyxm6VCsmJGqlv+Onpl9GT0t3Kg06d0G9IA9nz5nZ+Qz/V2szYDBwRloSnFwaBCa+DVSeQQkuXUrKJZIcDnI5a8YUaJfs4gj+87sDaX5/sy3pmhqZSBSivTtJnwEYyWDX06AB69wOxfR7ZevDBNnIW3q8zRnw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5015:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;31:LBrTZvSbN9rrhEkY7NYZA84O2FYNqt4ctSmIPYgUCweQVgO+9FOMqDBrodOPCUyM8m5hUB6zFZkZc+YfrRxpfsfCZ1blKCMgS5Ti/HeUH36/+JGLjBmOF6zIlw7zXNl0plVApWYlXbtXt5fwPVCKjWG+YKYt0wTXRsZMQvBrOHvT/jmRdpAmshDyNgCrP+phCpDXrd7hx54LpgbmgRPYPcO70HvKZuHIYSTP70V2xrk=;20:uwP26qxxo4C0ox6UNqPDCkFpn2AhxxNyF2KeiCs9flPoBi9QFeSazWlzmDIPwf8++axOGij/NaBF+sBS/lKYEWql51nBxKsKZT6XU2XDlsgnA2KtfuFgCTrTIKtSJnPbOUJ3aOFG8wSVuY1+lXRFtyL3YHvYvx5NWvrVSXd8zpfP31s47mcfK+PeIAFfEsm4qg22F7+fbNGVAAUK/Ie1YigBEkp9FJH39uYHl1M0aOWsEG95nwUOGcGfRyFg29cBIsee2p5V3wouN9VwcjIM7kRqNkrY07Vp56x+t2dns2L652Ac3HqsulEiTn5vjbVwwIP4VP7k3W3BOOkZPsVWNYwRKcXnaKGIFF8BP9gs4Mm72P8ZDbUZFx1T9Y9q2XRuo7XYMyj5czFYsB457+CJKcEvfyi/zWeq6aZrbTpFMrsJAUPm2i2Sd2rP3l2zjaIWieOnvyWd0QjWeIjy06vjSJ01g+1k2Ept4a1A1LOS7dAvI9dpAJ6Gl4neuztCe5i1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5015C8505F72A7ED9B5AA451C26C0@BYAPR02MB5015.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;4:/JEUDVPowpGa6jmNQ2h3M5+xM5Nv5PnmcqGKuQ1r68srPfMzpupF1K4HCheTc+5X3NBQVDZV6THl0/ZDYhGPuS4IXFtbXK3lxa5+7avW2Nv7F0ll9ytue1p1e7ls6OeFb7m+Fg36tH8frd1zT9mtzEjNJtMfbbCGPQYgyX3WNX0mPt4EiLjgEgSJqSr9qsIUsnzTwa05j0cPVlpEgUfISSNRoxjRfT00HugA/zGp0ydhO14To6QrwcgPKl1L+FtpcYWLRJHFhnIIygZoUHfBDh4/sFNaV7IerIMeTpiM/sdNV4Y52rJ6ZeaLdrm1p+wN
X-Forefront-PRVS: 0937FB07C5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5015;23:dLzbMrK+ojbHTB4SPUm7200WoQYQW9uXwA/PBQqMG?=
 =?us-ascii?Q?muiIzt/1smqhQyppigplfoyJ1dFZ2ql7XqevBSXN0pg7Qi+eUT1U/Fe4Mgvk?=
 =?us-ascii?Q?G/1xFWyGd+nFUk8wFdJ0FVNb4erEIsMQrtC3F+gBYEouxRrCG7GaG7NBtYEg?=
 =?us-ascii?Q?04qLNSMpLgtS2m37ZFOe19bydIDOPggdj1BiYuNOqzZL/yUhvb5tKf/h0nmF?=
 =?us-ascii?Q?TqDBK4KJFf/rWm3SiJ1yeg0N0zkh4qlmzqt4uKiiIE3z9VUhP9vCc096vOXs?=
 =?us-ascii?Q?EW77HSwKjv3Utry+pmnS07NSPuwXJg8wjYABSFLUTUoQOJZaSh0vZkLrI2z3?=
 =?us-ascii?Q?eLSg90M5Rwec3Ix+PC1kmVJKRcA8O5bDllCA9I30JXiVCzVfGGj+lwy7KH/H?=
 =?us-ascii?Q?yiDZBoOhRksYYlaAKyomL4RKcGYZUHtzXCoYmZOK7fsfAwfCFfxF6i0Q1oix?=
 =?us-ascii?Q?dS4+bDmHeyw0hCXopB9r4UF7IyATzFdjp1ZSJ3/n+vpBXxHEtABgsI1IbMFp?=
 =?us-ascii?Q?wEHeQNoqn8GI1hnCvMkHa7t1ZjSHe9lOn4i2bn2URzwRaftck3vrInnaCxlu?=
 =?us-ascii?Q?g0KWGJKt1xH8GH8XCu69RQTcHnWv8m4P4qL92QWqPlGESllyaY4pb1Hn1XPT?=
 =?us-ascii?Q?gkfBPqaiFvWqLdsAPadJUzQAXeDPHkA/nJ3cwmf4cPpSbGKAW1jq7OZizW1G?=
 =?us-ascii?Q?PfWzXPyzy0snKaSsOo0ro+AZqAcLGfsKsZ4pxb1gx4S8emgCl01Y+IdwTkig?=
 =?us-ascii?Q?Qsu135YF8J47G9GfJhc7BJDMAdNXnqxAYwvaO0JzFbAy59N3BCjvQ+1r+ei+?=
 =?us-ascii?Q?nqrDtuHrDFsVf6b+L1jLv66i3njoLSNammb5QVZx3TRTQeSqFmIYfbI41gIx?=
 =?us-ascii?Q?GS9NI32w9Jvv0oF7z/QGMoFjtRKq65lz9LbuPHG0Awvb2ALFqwW6dIcdHfu1?=
 =?us-ascii?Q?N5Sp+xzLMrnrahJuDH68iRrLD7c3oWgTm7VYrMtoBhiEb5kdg+l6Pvje+1kU?=
 =?us-ascii?Q?92uGCWsZdz9Zx8NHBXiJh1IJUotk0PcCYRYqWKFFbsy4Ymm7UcByYBqdddMn?=
 =?us-ascii?Q?M64dvQK5IYa/i1jyDRyVxGLe4Ba2Sw6EUnunopsR/JjKVG0DOac2Hw3w9Bht?=
 =?us-ascii?Q?d3kt837A04=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4JtExJzsinVpQ14eYf5y4IGaC8taZu2KTJ6Kg2+KUSGkb6rkUlxSPz1dfmkGQGxhDzNAFlCyAKRxIJQQuX1iS9UI+rlYVc+uiOXaHb2CL4kDFNGvHqFWPLinOHWIVYIhi9mrWGnA++J5hETpdVeJ7qoba1GHQtLM/s+3YxaNsr2L4bwQG7hnJUBMVeb34hm9F1enenKun7JyGmbAKMSlxiwFJBIDdTAyUn7EIZ/jgWa6QnFFspc26Ax/NITL1yVaNCBBLlpckrkz2SoodCu+12RUBb0kWGujgxYCb3c/3sEFdRzqkNs4XGCqXVifBmT92rPWyGwyhSg9Lop+R4bPIYkl9uP0pTnWqk8mxDMw4DB3r6SOo3ZkhbCRkP4Vihaugm4NIqMAH7xjjXklgU4hw/7h8eKgGHL0yNIzuYbWifI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;6:guy0u742O8Oh/j3aXcDgjvMMJGymYw6DBhhqSvo0OlEXJCSJDc9PhZh1xMkcE+28RUJUYwPRwNWWbZWuVonOuWXjj9JxviN7B5AQzJl4JyJV28d4DBhohJwYhBlUybAg8Qn8+l7tBHYEvrtp3b1J+0t5j+OoBKVw+qxPynvO6Tm6Pbc9mQZaA9th+6SaGzRFnvymUi56jeiZB9j8EIgfBwv5+6/rsBsNmfi/gidAwkVN3+QQw9lGauY1Hon2pVHI/4ozuP8WdeqVlgDC+aHmok1zEZoAlh+v2v5EeUapKrIumWbclCUpO6J8+5ApR1mLlzKIJn/cRh+wSezTz/PBOhEG7Wc3RCFR2TjjRG1qllqSef80H3hCkfsofY2krAjtHA7IkvXy4DP3O4JEVi71Sswmf1cM8mh2oJz35aOvPqe9jAsnPbQiW+TtvxK0qXG0IXE1fgtgEiccj6vRwq067w==;5:9WJxcA+s6iUUgrGtiTzEnThfPsFskHSdulzrqtb1DTv6yEFTILNo9Xsm9SN8fx/mNzNThnL+f+2+VUgOaZIX/PWqIh6oKtVQUJf2gAhkpE1bBTtMYD10f0rSyl+rnmBB9I9CsOXMDnlC8AsThUx24n1oH0TuO3mr8N+R+tVXlEXFo6Y4o8YPGUNz/nHcwXhCqiPoWHzWQOi/azOFduGCCg==;7:NwZ88Yi4Rm0/A31g7xjX/InVUA8+mAy9lO4uzVxfEBNdbAfqlR2sQqwoUbC83bX+uSvliQ/Y7B1D/SMv6YploVzyC/wZGl8rt7hCsD9TDrZc1qVCCS5sFGT/iw9hCKpqaxvRaS3OlvhVUwjgp2DDFg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2019 07:09:27.0943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79aa4aa-27be-4e7e-26da-08d689a688d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nava kishore Manne (3):
  firmware: xilinx: Add zynqmp_pm_get_chipid() API
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  nvmem: zynqmp: Added zynqmp nvmem firmware driver

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 ++++++++++
 drivers/firmware/xilinx/zynqmp.c              | 24 ++++++
 drivers/nvmem/Kconfig                         | 15 ++--
 drivers/nvmem/Makefile                        |  5 +-
 drivers/nvmem/zynqmp_nvmem.c                  | 86 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  2 +
 6 files changed, 169 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

-- 
2.18.0

