Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E072F2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1Zk3qfFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E072F2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeHCTvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:18 -0400
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:26592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbeHCTvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0IgDLNWNv5gP6EXKCmjmOTwm0Q6U6uAi73B0G9dCkE=;
 b=1Zk3qfFsCgO9YbPuv0Y7o2FnuFRcjRqSj091uZbQr++yUbCmzPLaHAbty86zC4wKMTvFzPNzcC3HE85q0dL4w+S9zkVxXYBE0DclgEr500SnHCGR6gW4JopxbDEdNzX/INXyQY0GTC31M9CNwnYbK9/Y8VB62szPYcFX04i9fa8=
Received: from MWHPR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:301:73::29) by SN6PR02MB4464.namprd02.prod.outlook.com
 (2603:10b6:805:a8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 17:53:53 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR0201CA0052.outlook.office365.com
 (2603:10b6:301:73::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004ff-2J; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGo-0007cn-VI; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-LV; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 08/11] firmware: xilinx: Add debugfs for query data API
Date:   Fri, 3 Aug 2018 10:53:25 -0700
Message-ID: <1533318808-10781-9-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(7416002)(106466001)(76176011)(63266004)(26005)(8936002)(186003)(36386004)(77096007)(356003)(44832011)(51416003)(14444005)(478600001)(7696005)(16586007)(8676002)(81166006)(81156014)(486006)(476003)(2616005)(305945005)(5660300001)(126002)(11346002)(72206003)(50226002)(39060400002)(48376002)(54906003)(107886003)(2906002)(106002)(6666003)(110136005)(9786002)(36756003)(50466002)(4326008)(2201001)(47776003)(446003)(336012)(316002)(426003)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT029;1:tlu558b3azl42+Zy2SjA5Z5SRTd2KPhEWI4kdsDAyBNVxcnxnPyBJ7aOgp7x8ZwBf9bO6jbSFGArDfnY3SRnZkcPOafmo38dlhoG8+CnhSQZY6c4lXkuv2adDiH0tvNk
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e9504cb-b74e-4886-28c0-08d5f96a13a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:BVFZRR1SnMLKxNT+SdXRZlaNK6KP+fVbNjKRIBXuWDkRtU56EVpd00nuBcZEK3poMB3Dbh2qkMtsHCidJltSDyV69yvycQ8bgX20CimC0H2HrVIMYVwEa+DX2V1l3esZQDsVdvWJIPq/Wzfh6ZU3MHc7ePoIqetIXj0W80UI/6Zx9hYbOHb0NLlvZXNlZrwx16uwfYNHVNj2BkTuoGAisSSVwdX+FoXwZHKr1iiMx+VnUyUCk/UVnGzJNPfhcABCbLS+dgfiLwYLRR6oayE9JYGpieYAR1KJQCVDChsssQeEfC9Nx73SBiO8334OBkv5nfhZbUzFq4fxmgSFUZBAjp97Wllysx8rUaEjzVdBkQo=;25:P0Y4vUXVx8XBYqewFPdmE2fGmpBW3r0rzq6MXmR/XFUc0BSaqpl6YetHEqwzjZaqOKQta5Jk+wUuqANs3RH/70ThP/UOCJAoCjUSLtvyY4F9+Kk8PFe/cPfoSv7uf8Esqcu4Jl7MqZH4jrxdNacwmFKkuL72xXm7IfNo/HEb2YIFM+sjhoHZJTaioxPF23V6hhHFIMQr8gxuuQi9boVhutaCzWhbL/ptFvCpDvPeELj+hny0SNM5q+5tN5Fz2d9mGiWyRZp6VRcDDPHtzijJjKp2QA7phLJ9kSeLr9PNpl/59D/sXS6FtZmAgkPgTHM4UZ6soDr39u5j1vbmyEaTqA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:oT00T/YmZ5EY+GRI+oHKEkzdju4DMXAZgJYQuu+6BI+YmscaVJEwOqimJAwiOnDHwrFuLqALQfsFrs2Q6Uu6XJADRYaHuVik7CMeRIz8b5dbdu00qw7PzsBZ+6JlW+hIABLnCz00Uxy1wH4FAT8SIMyVUagxsr3i29sn5l4xHBMsw5+zCXYSe3cUlsRD7IktGuPwOsan5w255pzI8dgQDb/+M6vMWBYD/ZGyuW5pBYU=;20:PRGLfqeUebhpU3eShXApfNuiBWdOqRB6/txgt9g32mr0iRP03COrXk6dAMiAB6nBgnbs2nT9kwa0WW7ofSNTMCDbyZ0picljMVwzetEMEZxsVojSbGvIGqYlgFFhkVLd7dIeloruXKX+9J+6AT+P3Ifkp6HPNT/YWBIpOq8+n/tVMyfgq1tINCOPrOC2KBu3vRQwXVe7iKMtVrO3DZJ74ZXWU8XoHUlabu20hoYT4xxgtnbl0loMMZZPbhWLVCP35kccsZgVO+MEjVNWzQVyVAHaDny+nK3/+nNQ8KrfCR+c+RHmjQ7hCIlPlD31uxKtlurE/pMPO8FjxIplw7mabHGY/XSdGFogwKJIbyFFqa5OPH0cnna9mYlgw1+nSlM0e5clG3alzoyX3zsBQbD2Xp2T22RkPcFuvUzgBpYxVASD4qrlbJ9ldCM8zEEk/PMI41nSGG7AhySBbpxygvbjnGR/0pmoUWgMiPh9WFJbRTjPvhYYPormij2mUBfRaUWv
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4464FB98D94F90D655A85AC1B8230@SN6PR02MB4464.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4464;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:Y+H7YhLr3I920ykuDHLeRh1sAoQGMP49ejmWMIGmJkMYHuGB7pFgIpnKVOZNUDN3FNaBZJEw6gnx83xbe/jLNoz63q1s8fnxrltLTAcdqL6tkVt8xcFfcr6xXWEdS/bcROPvsiS+znCrcLF7zxYpvuPmjmRZaDic0fHxtlFIY8j6Kfg9Lkh/j0ARRXtadVYl/JGQM5d0andJ0EswQbcDMsPnAMWHfOchs2l4rTyRpT4a6T+6O8VZFIYUH+uMCv+mYacjocE/TDC8drF+zipK3NoQh5LwLdN5UPGmsINrkYiI4ocAVSasxOk1G7JQJa8+
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4464;23:TEa1K9fyfzSmHdgGYe5+/dP0WaHySlm3R1xxhNBnK?=
 =?us-ascii?Q?hYmMG6sHFCwZfkYsZhXoDcXoVdjpN6ElmC66pQneuuG6gbcumL0JmwLAYtpt?=
 =?us-ascii?Q?Big1/i1o3lGvFYPn/DBqnmJRMJOKDQX5q5A7OpKYqCp7IK2YYEJdvDecMkGn?=
 =?us-ascii?Q?CDBuazdk5ok6+0fxL6ctgsnJAcQce60g0bmjW48KQ6EZCdoQyzrH19xvLk5g?=
 =?us-ascii?Q?FKP1T9COaKNzR3Xp/OjlU0+QOv6mPVQM7m1u8ROBW1MnzNOu//qlWcozrxLq?=
 =?us-ascii?Q?L6Bz99vVPnBE/Kk4FKOuIYrgY0TqvfIafVU46P33H1Xt8Pcyh2B2Xs7ugKqv?=
 =?us-ascii?Q?URnwM+Rgf0s4dhZLtMfUVNobhgjw6uJs4SsqRwPhhReu5PZe9k4nWGG0djYU?=
 =?us-ascii?Q?xaCP6XYVfwxQEW7pdbVN8RlpjdXZkQOy424R4ltRR6bJPfyjmENxrvVnxBGA?=
 =?us-ascii?Q?JIMRE6YstNN4MGLM+b+vzU2kMA/7Il0eVx8xthIEOoQ8b0EslX4YCS5Cnm1h?=
 =?us-ascii?Q?S20hYsp7HvIURuGYaKh0FttS9k6TJvOPD4O7FTieIqZ9aj60Laj1ef+DOEVw?=
 =?us-ascii?Q?/HVM2FWGu94Rv32oOrTUmg+iYAKqQAt/EdojASv1TkvHje3Jd8rKqOaothsc?=
 =?us-ascii?Q?agOULy5dMXzB3i/jFB2WqjebPLNQ+D1+8tvwFmR+YwApOT1huiY09z/V61qM?=
 =?us-ascii?Q?qDTIACDuU8+JtP8fE5IzSORfQmBV3EE6nbMBO7BFXXwUQNyXehJmF1fyZE9Z?=
 =?us-ascii?Q?1dWQT6Q3HYQpPJPiBWS1xrg7gZtlDU3nFAYhin9FpyVUSpvt4KMfX3D6I4Kc?=
 =?us-ascii?Q?oszasCYZPSF9FLkOx4us09IddvOZ891o1PKCFN7i1uIuBC7APNzVXy2qSURU?=
 =?us-ascii?Q?1iF0pXq+8sRsdpCkhzALKBjKkoPsAF5fYnJAk0T1zGpsd0GGIhu/amxIW5uO?=
 =?us-ascii?Q?c9RSu03dgTWfhVUP6xNfwvGF/7kBcSdXQQS6MtoQBhVcz1Q+3pfAZ7d5PKEg?=
 =?us-ascii?Q?10HzbvFyg25iXGiF7LSVeX6dVs6Y1XaqrQuMS7YkCzBgoTKY8eI0l3RdrQg6?=
 =?us-ascii?Q?4pwVJ6scWO0wAuvhtJoNt7V4Sq97Eyy2o6CK4yhvHNpQZJQr/YSfpyxqHaNH?=
 =?us-ascii?Q?c9LAUXsOzudSqSh+UX1HbpaRlBBRwJq5+ScJ5KT9u7ueb1DojHEuXvw2NsM7?=
 =?us-ascii?Q?cbaEqgIKB8jfaRRfi74eub2VU6wL5VAlCMjkE/P9mFYPBF+pyf+AYOq6tbUc?=
 =?us-ascii?Q?ARz4lmKyVhfPG5oVzwQOS9BVA3oX++E5JTvc3n8?=
X-Microsoft-Antispam-Message-Info: KXk/29E9sX9yxslx12jfDV6jikvemRLeu/m+hBhzD2v3WwfpJnlt3GPQNvucaMvTjmsSH92SKNZMlqIGYXdUEwX297XG6M2gj+9/g+HJ4EYOTA8yAI0fHt5DXU4FUi3LR+xoknIQQF7yGc7+AgJeL9PZD3ziaQwqdFAZEXxzJRhZewEew+t/DIottC7z2pW1iYLIT/9/SseUEbELTFiXxV1l0e+AP+KmfyagpkqRgqlbiV8Cwfi1PxPR843FAA6mKArrHY6XGyrnNYP0Mfo1u2Z7IHpKOKP1OqS+Hm0cbffAi7SPFAzenqG6pWje5ptNteJ0lp/1FuIQzQ69DPp2SNsjng9Oj99jk4FuBm1pLMg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:jr4BP39GdyR5VuTYYTnZ4ALTzKjKhmpvhkgFbMsKaQvP5KlwXCKPJFBZKJbcidPGFAP4a2jNRb8JDiO1wGfFrmcWjCvnnu4kGuWnluBi6TyXQOss2csvkRreRKv/gOMOb4Wxel6lHcjyijRBGQ/RhS/uuV1cksWBceN9ifiJQRY22/XraGMlATSm1VGHR7NOO/RZhNAZQHWlwgq+wizE60ziZZI1YuxKiKpa7qv576BTRxx+tCsMcQnn1+WxmcnYfgvTipBftReMmhAnpMHz3FaloLA3fI+o+/bgzyvW9rnSQzrCeM99cYA8GTes1HbyqnSH2bnkJSXijG6K/HP0DuQ8UzinsELqjSejOlOoD835GQRjkK1EcmQVLOujqrl0ow7KYlvWWVSQOaTitdau4Oqto3yLJ05F+g1VP8/H0Jtlx2A+jQpd5JEU2rjfKU6rvdbGvCpTRUCzSWJcueixrA==;5:KiobZSTBxMVTESutT8xKPaST7EgV2scp21bCY95nBVr83Adgzd4E7nZ3fjwJjiyosTS8upAeoJZ4CuSXQd7eFW7goqeX+KfmfseDK9+kSaSo/NL4+d8Qzk4bZQocd3AfGz3xRW3hzMiyOvqRRM9VXVN67TgbyfjjRXP6pes3bPo=;7:MWGonpeKE8otT9w5v0SNaGvFqMlnVLcOMI6LnHkKufHiGnil/iMCzipE6MQhommKvUBQXmMsTlYyytjls3wq6KR8tOKD+REfr/reITqSokG72WZKoKjDrQZe00mrCliTARkkZ4ju+VoTQOoWm0Wm3/gOJXGg1mBprjgXhA6fBhBCFNTgfuyFOo3ufOayoIctbhPRpy2wxEmFcqO67vefMbvYLW4dklrvfihwH4/40x3ll2wYwCj+dl0164xo8BRQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.5358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9504cb-b74e-4886-28c0-08d5f96a13a8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to query platform specific data from firmware
using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index fc11db9..4532bd0 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -33,6 +33,7 @@ static char debugfs_buf[PAGE_SIZE];
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
 	PM_API(PM_IOCTL),
+	PM_API(PM_QUERY_DATA),
 };
 
 /**
@@ -105,6 +106,32 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 			sprintf(debugfs_buf, "IOCTL return value: %u\n",
 				pm_api_ret[1]);
 		break;
+	case PM_QUERY_DATA:
+	{
+		struct zynqmp_pm_query_data qdata = {0};
+
+		qdata.qid = pm_api_arg[0];
+		qdata.arg1 = pm_api_arg[1];
+		qdata.arg2 = pm_api_arg[2];
+		qdata.arg3 = pm_api_arg[3];
+
+		ret = eemi_ops->query_data(qdata, pm_api_ret);
+		if (ret)
+			break;
+
+		if (qdata.qid == PM_QID_CLOCK_GET_NAME)
+			sprintf(debugfs_buf, "Clock name = %s\n",
+				(char *)pm_api_ret);
+		else if (qdata.qid == PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS)
+			sprintf(debugfs_buf, "Multiplier = %d, Divider = %d\n",
+				pm_api_ret[1], pm_api_ret[2]);
+		else
+			sprintf(debugfs_buf,
+				"data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
+				pm_api_ret[0], pm_api_ret[1],
+				pm_api_ret[2], pm_api_ret[3]);
+		break;
+	}
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4

