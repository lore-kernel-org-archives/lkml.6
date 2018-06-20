Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56486C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B5E20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LWSNIEAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B5E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbeFTRlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:41:25 -0400
Received: from mail-dm3nam03on0043.outbound.protection.outlook.com ([104.47.41.43]:17024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754504AbeFTRlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnUuKT3KOVxk9qJDl1SweGkZ/cx6bMHa0cexhaMd9sI=;
 b=LWSNIEAZyt0YwFrzX9mn7QN/UULN6xGB/sCkXSZASLBmV5HH2fI35GoQCwbU8Vz58PFvQKkWKgugZydSkIGuHwkrPXWsQv3PrtYmHGU3NTkB+OgnSAxWukLo/z5xec8CFjV7dD8CDK3xZXkw7q3Tm3KGFqcUUjNuprEUgtpUBc4=
Received: from SN4PR0201CA0029.namprd02.prod.outlook.com
 (2603:10b6:803:2e::15) by BY2PR02MB2149.namprd02.prod.outlook.com
 (2a01:111:e400:c506::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 20 Jun
 2018 17:40:57 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN4PR0201CA0029.outlook.office365.com
 (2603:10b6:803:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52999 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0006of-Lo; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-ID; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHegta027147;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh62-0004hY-4o; Wed, 20 Jun 2018 10:40:42 -0700
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
Subject: [PATCH v9 08/10] firmware: xilinx: Add debugfs for query data API
Date:   Wed, 20 Jun 2018 10:40:33 -0700
Message-ID: <1529516435-7315-9-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(396003)(39380400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(63266004)(2906002)(11346002)(446003)(44832011)(336012)(426003)(8936002)(476003)(2616005)(126002)(486006)(106466001)(305945005)(478600001)(72206003)(36756003)(50466002)(48376002)(26005)(8676002)(77096007)(6666003)(6346003)(47776003)(186003)(81166006)(36386004)(81156014)(5660300001)(107886003)(59450400001)(356003)(9786002)(7696005)(51416003)(76176011)(39060400002)(7416002)(106002)(16586007)(50226002)(110136005)(2201001)(316002)(54906003)(4326008)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2149;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT017;1:FIHHU3ZIlZXsE3SnDdqbo9YlnklTad2gJl9ik8tLJ5S//QuP7d/AfJGXdNW/9/71MrklyFk6u6aFxospzt3idOorrffejBde6nGMfdt5R/z/LUORTi9PX4HVgBx8qI+N
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aeaf153-8a20-4fbd-8ef0-08d5d6d4fb13
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB2149;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;3:x0DhkLeWyU6Z5bbPVIWAqfIsBZdndwQngCqZ2W+a+mURZo0YhYgna/df5kpwzhMkoG2SIbLVx5GWRismrCvRhKb01N8xK2sAUp8eXKYAcVFj0+sroTkSHi0rtFmoRnXKl6+pOFEnKubcsI8ZfWCfIZCkH/pUpbZO5TXXHiQxp42OrnB5x85HxzN5fBubksygiFDaJjpYngTLd0IBdO910gMGHZgngNAKb1XUa9U+u0b5zgACnjdqyWo5fSDZa7EFHa/ruZV9oF1oHSGP3HI3Ku+1PF+x9+7T/CwEfd4fyZNSd8Drh4KEDeY5IHILTdRvezKL/kemmdLiy0KkWZVwsIddi2ZbhnsN2uhJGjf0Ugw=;25:pe6Wcb1RX7MAD6sgudk9qbt3TrQ98faeAloOe0rSRLm9wm+Ost4cbFanspncSVdLwrNM0aVLf2mOVJvuHQzuRQ0PBgAzxBWi3RksAYb8CJnZP9BvCRVuP7ZqSoo5QtLQ+u5QgXW26vqIVk5EI+Pz92BJpQu19XcQzEGR3Gu3x4k5+JO3rRoWALm413xdqqjpl1wkS/udzk6sdqnKfGSnT8827OwohN7TObv7mZIZRiy/wHbACZtM+0c4AE02t11/tGh9kKYQ93g5e4rmjGbgus7WT5hhBRMR6hU8cveRlBKwZnuD1SAujszOQ32O+zvNZCLgKA2YZyoeHZJnmeI/Og==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2149:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;31:WkGPLtBHtsry349wIMPj/0CpoTReCUXtOzE2sqSf0VGtL1Ulx9emvHabfw4KnLfYIEdd7f6ulcB9ZjmtLZdibCecvIxwlKYlFeU1wuc6sECX5gHV6o/iLvgPwQTqxWd97ewvelYJ7hijDyrSY5oobZ1jAFMUNeQzAk7blm45einU7//ueYijgi9D1PizOPUEPhc6+U5mSE7Ce7uybLbmXqJ9ri8iNDAOCN/7VyRfe7k=;20:UqJLjmuvqPfq2mex8bVXUG424TT2BkCGBwa5N0zW+A1s1yIxNov7nDTFHUQlcYUDNZEPzkTd+/tFZ31gJ/ANPet92TovA2YmS+5yu5SC07rbUNtWBQ/uNQcS90mCRchVOfoDIf9F/zYXic/YIUuuSb/rcd+qxhEcnjfjUgELzbfpPzX50FYKeCp+mdEaQr8btiZs6jIMmBfwaA0j7MAD6ke6XGPibjEy64GFPp1Z2cjUhnRsxofj+j3uBSh8RBIGwnr/zw6bFSEEqxqLQTJmJfAodDVDbFrwB+24+P+bxOfvf1fEKYyZAQVXSS/32GKuNPzS+dsyMcdp4D4A3WTWCm8TnEsdnRyETyUQCvm3PJFHZ0/8aUqond8XZOLs3g+PZ3+c9fXb7mqa/PZF/VaRbt/HgAYa8vsj1zUnJ+5P/8lhvwuDEph5269bqNKWBAw/96JU0pwUd8rBaTnOM4CLcCel0jef5AVPNlrSIGafV5hn9fYwLGP49CiOgGb6fZ43
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB21492AD273790D3801A09B7CB8770@BY2PR02MB2149.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB2149;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2149;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;4:bZamNiGlwToYpopNS9Gc/8dXSlZ4O3cki9uZrtKA4ujDswLE7IsbKjpDL8GvuEqNdJvukF8/CE+VPoy54kGZ2vPsYFy77A27ZxtflEKO8eJhNV5r7zFCP8Um/m31kOOnCZWcoGk8r/9OgNBGYUzx2ziWHbKC/3HNXU94WVs1lpqD6WRkxPxRKMXPTDhtMThY0LRfjwxtiPm0v/TXReNmWKpPYlamKR0Qz8jq2kOJAxmPRrBkr65pGxIaU3BPhW4p1h9oMk/XIZJoTi5xnyJe4rFB7ZqnFpxsJVjj/0O3lmAOBKdIbxrucGTBLs1IXjwD
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2149;23:LGIKBwwrKNH/HayPnDu1ZqxS0kCrWGKLAWxUE3+CB?=
 =?us-ascii?Q?cn+TLilixmtQlGdeHji6wFCEW/CFTygduTd0Gri8A5ViHuke8GXxXuEiNwtI?=
 =?us-ascii?Q?gagHUvjCp7e3UgJGQHSt4i2D50I+fGjh9PVUFdaaL0VefVcn15eNyAqfp9RI?=
 =?us-ascii?Q?Gx3MZn8yyXcOk5iADdLTQFUw4r+3RipQEOIBvlW7SYy3nIE1RR9W/2HbFVvW?=
 =?us-ascii?Q?dPcmYH4fq3Dv2AZYRFaiW3xj6Lt1HrAWyAWBXqNJEpY4jWNiMUh9alKgYoGD?=
 =?us-ascii?Q?LrDBal+wzMgZyZrWdu/bn47SFzHbQXEZFTP1O2o8+YAygOWvXUKbgMpEx/HX?=
 =?us-ascii?Q?krRRe3H6jx5m2GSlmr6zooIDJ3CXW9pHUbkX7I/EMbsQwzrAEsy4K/qA39Xd?=
 =?us-ascii?Q?IC/MWrZSh+jCJ0gsoVhYmPOqzX3a/rtzgocw3Pbd2ioxo+dwqFp6tVVu0Wio?=
 =?us-ascii?Q?VX4X+tzgh3FHLzn65YcXBAmJWrC5p4wJ6XDuERT8SULygjFNyvnFN+xcU/C9?=
 =?us-ascii?Q?x+mQu8qihPCnQ0xGmmTipB2SwgSO9EThR+VgFnVSjjKK/ca0dRRjEQ6DAgnH?=
 =?us-ascii?Q?AjrVQLAyyJns5YPoBzUcC7lfchErzenPm5Fyh0zQpKC8rtjRvjLMRBrKhoIV?=
 =?us-ascii?Q?GA5moJgSqybGlyHBkVkKX2uxfrQzU+3t+KRhvFo29SzDeG49UBJg3KV3h2Ky?=
 =?us-ascii?Q?6Ey1godKQytZtlcg6WpN0exWGo1L2EoScIlK4YThhX0kNC8EfwZfqJE/HgE1?=
 =?us-ascii?Q?rD+CPkJYskC2SrJr56qzFJIIhxST88mE4hrg5ivWNLW74jB/zgDhsdoJDIai?=
 =?us-ascii?Q?mKs8SZgULUnjjnJNi/4wi9XLOFwnChu4aJ9d2BYaPF5Ryo9Za8JHM5ZN3nwX?=
 =?us-ascii?Q?6yYK8povSnBUmtKhxTcsFvraQBoN6NGesVWVPWkUzNZdk1pI6rudawXRkTku?=
 =?us-ascii?Q?wuCtqSwIGy8csGUbBmtU/CEz29stZvoveleCOIGaESMnbel7K4cry9Jb9ZGv?=
 =?us-ascii?Q?Jde37UNj0u+XmaGEsoIyPdX0eIg94S0dwvJvcbeD69M70BVEFNvCueF0GZxW?=
 =?us-ascii?Q?CvZjfrbfzrSKbLqRzxrSrgaKDwUaumXNkBj+1DlPRAzPc6LUL+vVFxMQUPSz?=
 =?us-ascii?Q?SB/C1rOKJkNeuwaaoHhQzhuaH9ZHeInAt4U6ZJLaBCYMOn1NjThPBIjBV+wz?=
 =?us-ascii?Q?6XSPQbZJ7mxAyWN6hXi4Dx/IKcYETUP72igjqCW69Ig56A199jHrP+zwBC/+?=
 =?us-ascii?Q?MWZESwytT2Hr3j9Ya/7TekoFGQZ1v70hM/0+j1yTOh0bxaXwaNjSSRZeGL6k?=
 =?us-ascii?Q?q6TdFVVySdGATMJYGgFjvkRhwXuZYQxrMZeLNFf0M4LOQxS39Ia/lwMY3SHo?=
 =?us-ascii?Q?7bVYw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9F+uRAZI6jwXtcUSHZgx09gpOo4BkLFkcCoRdBTZhPoW8ect7rNZCp+6BOrSjNXBC9uNriROrbJVVnHImVl9qWYaJiRz3JOfz8kg+rYaHrX+qiNZ1T4HbnN3JQEsnnzs4RiLtBA6tpvg4vt5ESAWmfeGrFBKb/cGVtqJiTHQs+DYxjjzEd7yA9OdTtsjlX3H+OfsgjtfYdnvNZkKAvc9s/CCe3/UC77dzaLE0CHlqqHWn0GB+3W0NgG1cG7/JIgxvKJvLuNIZdIu2qTaMC47dDRl3L0hMJHoL65i9Hd18XUGv3bJYU9pK3FT9WiaUk8z3+onvPk8kKE7qdBU3ppRMA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;6:6QsIuLFZogN7pga42JcKlUpXIBAKReLxo9mecbqzt2Kxg/eEAvXJxlm6FOGr/U6NWJ38ruCpro/bwdxUxEmY2nFsFiIoXKPftTdmAj6YY9N23AjZAhrTF6RD8V6biODDtiH454/FHAuMTOzWHSsuZ73bp0nPFuiGWmoeSIWS9Mbgl04HNFUybIoCvna+dROBjFeIxcy6tQH0bSR3JTRKxR4buWUSQQ073XrXljXYlw8SLn0KciaY7Snw3hz0es3Q6047KOfL6wkXwVxW4P4I4QgqvIviduTOJ2kLFr5dk/WPdNoX+ba41c1OAUgjUzBvHh1fMxspS3XmOjKbruSlSeFlouqwQYWrYRyzWtOT4l4oOyaeM1sSGESXwvbZC4TlIuX4ekIntM9v6jTOrl7fPRJFaSpY8F4iSaky1NjxH2yinZQVi2MlNn8AdcSt2X1GeAwYk1yAJ2EYlixYdak0rQ==;5:WucbKbDbcA/Zpcid+xMRIC+gHW910u/417MSqpmSW09Y+rIa5LsP04h30x+WdbLiatXxFXmh7YXGQeAUmuf0LCO36H30YFiBb/tkE3I5cCgUKuelL3TMPPtvBo9fQ74l+Wl7Gn0TzzUnoMw4HyhWwe0S3+c/OjDsrMP4zrP1YMY=;24:YklfXEVU2mbDbzwrFe2gUaaULuQH56wWGT4VxFUOeMeLBa/Cp4210plV7n4NckXNFB7CrcAHgbnlgMjlY/sRfHfekmrHkM7EgQVnRue2tgM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;7:/irJCXUZ1RvQ/Vi/2XTRuUIfBhBeNuqUKRa8tN05rFA6yzpf36uc/fI+jDkAv0q9uc53OqeKkitGPjB8VDV65ZasBAoktQVh73WS8/AJFhQ7Dl74eCadkq1tW3dlmTTMaLgC96h6FyMgilzVV9Iyg7JXTgTWmNiWgFYE+V0PXhsyubb8r+7og4nqApTaocL1B42h9dzjztuGNpYCoODltkv22TD+4+AxXve8eY/fLJny4AQZb1OEswqDFn5rLoz2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:57.0941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeaf153-8a20-4fbd-8ef0-08d5d6d4fb13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2149
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
index 148dbff..1cb69f7 100644
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

