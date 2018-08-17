Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CF2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3BD2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CGXtPGwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3BD2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHQP2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:28:24 -0400
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:40480
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbeHQP2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At+WIRAdFd5BdQ9QOsJTqlBefuOKmCOtiVL0faHCGmg=;
 b=CGXtPGwFWL2xQCipB/Alj8SsmhfW1pMCxLcK9rdqGAY/dVWrkRTeUK+Y6DiuedFGfylQSR9L2k0M27TsdfnqhlUZCUGOnElp7+oX2D9XcYbyUrHzSUmkVd2m6vBkMrCkYZOS7S4PMh+vtEmvued5S9JG1LBWU9YQLn3ibzrappU=
Received: from BN7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:20::35)
 by DM6PR02MB4459.namprd02.prod.outlook.com (2603:10b6:5:29::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Fri, 17 Aug
 2018 12:25:06 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN7PR02CA0022.outlook.office365.com
 (2603:10b6:408:20::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-00030v-AF; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-8s; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOw2v019099;
        Fri, 17 Aug 2018 05:24:58 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoI-0000Tb-7J; Fri, 17 Aug 2018 05:24:58 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 4B2A06050D; Fri, 17 Aug 2018 17:54:57 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 6/8] usb: dwc3: check for requests in started list for stream capable endpoints
Date:   Fri, 17 Aug 2018 17:54:53 +0530
Message-ID: <1534508695-12642-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(2980300002)(438002)(189003)(199004)(14444005)(356003)(8676002)(51416003)(305945005)(76176011)(81166006)(42186006)(47776003)(36386004)(36756003)(446003)(16586007)(106002)(110136005)(52956003)(426003)(81156014)(54906003)(316002)(107886003)(126002)(50226002)(8936002)(90966002)(103686004)(6266002)(11346002)(336012)(2616005)(486006)(476003)(4326008)(39060400002)(5660300001)(478600001)(6666003)(26005)(186003)(106466001)(63266004)(48376002)(50466002)(2906002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4459;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT017;1:4ke7zDdFWiybjRbcfjvZDSCDZgzM68+3v0RomgERACrVkH8r156LZKblTEYSoZcUpNVKYTZd6hTLsr5zSdnHs96iY283xRucMookMqdKry9CJNgIGmbpeevpEbjWHO3j
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cf6636a-b0cc-40a2-1d11-08d6043c7705
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;3:2GUrBKfKO5mB3HRCXt5r80UVEDjXjWb0XxEM3KVCkcVs588FkRuxO2YRyDmCHjVq5a3LrDBEkBdbDd9x1CREN+T5r9QIQNmJNHbGwMRgsLcislBr/7K1ik61/D5vWcNIgyQqVkHXGxktg4PldZ45uUTBgW3Bfl4o7OF+wlUHcnIpFaXiIca6zAOdXhNzjnlszxlJLaCzps39Pl//5aDzowfc33kgUcuMaLiZCXydf6KvxvTpcWDMYl8sU0MPoc86n9SssFBOD89RujETMJS4ycp3mSDcwVpMqgewcpiNNK4wR/DI8kFjxKtAFSypLgM3jcFmfE5h7mO9zjuqwrNVqeYbCVirAPLaS99Bm5FGJBE=;25:QrUIQN7mpmVA9ioBz31daFzodQ1L6epnoUzsbp/D4Payv7CYG1NfTAvoCagwBCOWkXCAOq6FhaybTJKvPzMf3vUpnAisir7mbsCXecWvLGiBkkVttW1ThsfMkchvJp5MBf2bwcoTNL4LO+wPKpKOnhag1d5vacikVKZY1uSH0d+xbjemaJyCiF0WeUIdp2zcrvgqwZE8EQFhFTdrVbxwQ/hvsA2e1Tvb2otZCoBq/j09j3jRl6q6PTvyY1l2uaJLSLlsImhhpcRo+QBp6XBTZ/9G31FcJvYm9TSJHnJ8qwSRk2SFkhcUgGHHkkozUWi/ocphRhHmdYTaUQyR3fJpnw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;31:UD/3y1lzMnrSditvmaum+FhhmES2WJ6TT8zhWS3ULN6EXKQwjPTrGYVb57OL8jT6kECnSRi1TuRdYlfOxfv7DOAhrL344xdnxJ2KcxiaIWLBVN2f1YAiGFsqVrd+wOPjLaR04i49WpApYyY+Cu9+4g6CBWxlY7Hn3QsLwzsCrfzpPWW/qTHVLFNVmT2rIq79uAwJUft5gGRqX4Sxc/V/fIqMcBVynD8ORjYGUB2qeOA=;20:uSYY6wCgGs3Ozr55EdCV7C94nxG4iGTuO83nJ8NotuEwc9CxHGb0Ogvzr5We9Q5LUca4ZbtI26ym/9Rs0AkJ43dCl4iuJAkdo1ZR6bIk67kTm8hX56rradBd+yikB7jWxeNttYmx5xahUij2bVJM3P9fJ3394sZ9MLAn6Ej6HLq5iEwbotsMYfK8GmQClLHilJ8ACMX5ak5l5JgMRkhd3OWpzsOlIkfVKwrmHU6EESAC6DLpINSGHbtMboZ8KmOCTK2+4n2jdUeM1DDYxUjFuH/nFcoJPNmuD0pKdF8PHlXq7FSuUGwwkD/0M7JJRbPWqURsiyUIHuD+qJrFHNiuDyHsViyIK2se+tYU8tgVErGN7ZIKaus04PKWB2fm2og3UaGAqqHcngvUVfv2MtBeVtLB61rwvO0raKscwykT3YpsQSaIorxMtLjoe2U3cJ/W+MqjTXxgwcyeXeqw8zEpRLrYRwcN7sfO6CzQGZ3jsADHMlXgO6rF/peA+EEzKg7W
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4459B5DD9AA9714644401199A73D0@DM6PR02MB4459.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:DM6PR02MB4459;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;4:Fpf7kbVF0CKluAd59iHFGRkfch3fsoXbmlPK1eYfnibI324zVcGFVZ2W9cS/wda5WfKytk/lHM8c61UewSkH/wMxzPw+7/7EfkuWfB6NwTjSBROjaXx5NG/X4+pWwD5tAlUz/QwNCnCsHxyqg83o4C3fAQHHQgatlEujaUQD3T2mhjhI/Bkj5jFsXhpXTIsZ+Q+NnB+pdxACfcXSC4mBqCMhkTMXVT/5WIKYGq1Vi3nJyxATGPf4bQWJA1FcXdX9/CK0rVxWcabrvEN9kHnwJgUh3RG2YPeHjSjh68P2bhKjI1IJQ2XB4zd9u8jigb+K
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4459;23:y5eVCEaViYI/P4gPAN+u8Bo53BNloFCMKHJXqzfCO?=
 =?us-ascii?Q?vcRuE+71VR3TU0LpSm5++j1ytAsZ+AUBAmHP92wKOPFlvnxrAqzTh3lsfFrI?=
 =?us-ascii?Q?96b0Qoy9r8pAz9Ovl+aE7UAvpI1ETR5fPARsWnk1eJHmJdQjHuPWmibMbLPL?=
 =?us-ascii?Q?nyc0bg9/zBZ/ABcnM4XBTogfWl1mNYrizEzNxpHvZXt9AAcjBSij0XSdYrdw?=
 =?us-ascii?Q?6slh9DQwus8rgVUz7riPiyJHF8wZU8Jjy8VqvYkkfcnxYmWnkBy1pqKN4M1V?=
 =?us-ascii?Q?B4cUKv3aggehjck9fFxaUEmgLbFraeYMhstps+tbi6zHuusvkr62R0JfaNMB?=
 =?us-ascii?Q?f0e2XpK+dSp2bwfih4wCrV+cPP8G6yVidJKhVY2PtLf83F25FIo42K+MTPjm?=
 =?us-ascii?Q?GQ8xrHUBXVTGtIOKx0VeLa1NWZyaC7500vb2xZWVocrkszanSK/wqFaGdWuf?=
 =?us-ascii?Q?nDJfu2/26GOHfcNY9doXdUiR/0cAqCb4Jd2k8ekf2KIDeEfIoyWdvzsd+6jP?=
 =?us-ascii?Q?iPmDvi1Z8lqlroQg43Cf1HcGxZA1KZ8LtAD4A+kK2XygcgAbJAnkZgeD16J1?=
 =?us-ascii?Q?bxYS07RuWCzSx3TDNxrvLH24dpbHXTpJybNbnp/yCvrQ+rnv6gMKUrIBuTGv?=
 =?us-ascii?Q?OUE9Jiw2zSykMdGomxsDfRwpQU4ybY48IoHJns1dVaY5FPM1R4BzZ+3elKzq?=
 =?us-ascii?Q?RMRUNUgyiUUUirCoeMuSd2RUlQBMs5WxcOJyU5z4fjC5MO0fHxc03y6VoEv7?=
 =?us-ascii?Q?gijF6YDzh6xLtzRlCZxrYTIEVMah3yftssD0kaTHt2kEpJmzRliBbYOtPyyr?=
 =?us-ascii?Q?zYANJeekpDahgicE+ymjqmg+dZ29VYLAzCwivpVekcSblmXbNgYu9FD6cdDk?=
 =?us-ascii?Q?/lB8V/EexFqrRyZ8krX8r7aIXPOWw+FOYs9e//Pesa5vx0E6QF3GK2DmRQsC?=
 =?us-ascii?Q?cx1RZmtjkU/csdgxaewhE27E2paLHo1ySDShIf8n7g+PpwB5mHjQ67YCvt4t?=
 =?us-ascii?Q?kYgmWp01YQB+G2TdaJImwuZ9NGNYJwRRn8SKlMtCaf/4D2hCXuWvWj0dDOqz?=
 =?us-ascii?Q?2W8jSOyp1aCplNJSP5/zsk7etm5Vp/UYl41+YJl7oACXVmyUgahwf8IKyPAW?=
 =?us-ascii?Q?jzBGPFbNlHOirOwGTN08Od6kyfSCVMDPyHsP+Pr1qUc/Tjau9VgSHNIJddVI?=
 =?us-ascii?Q?B74gfLNeTBy51NQfPbEsfx8M4yk4OYRwRl6?=
X-Microsoft-Antispam-Message-Info: ZhSoQtk+jtetzjdT9901eBX33+4jsIpAEhJ7kQdLjpJNnQRt7RSlAKWCS8ti7OwpzLA/X2AavRnKEMTxSjIHikxdK4axx4DFH9qolT/lg00bKyVSPJ89DczXEDuF8noxbPeXr32b9eZ+jF6aNswwQWIJzwUMHx7VY87dGj2k8LNSO47KpQTSzrCPtFIO6FzJCNdwMlCikxLZxPj4/qwDerGHYv+B7m98+/q9gmIX4rBF+pJUEB1iZWGxehdWsD0Q0nO6Wb1+MkuuWuBsWycoYtS+q20w8X6Mu7jRANtnMirJHJ/YJYfdJxLRCD+wQijA39X9BsfxyNstkj10YyqOySr5lP0HoCl+inbXJwUbuQ0=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;6:ytDhIOtOo3Id8XjjfQ58+ynx6RRMShp/cKNkREGfgqy380cN/rD16pcdz6IO3SPD3RsjIbrL3KEb+kjxl7gdIL6kyxgyM417cUs4hs/OF8gceUEQou2N/VpmlAMDaG4nww+Ajaj6IScvzTYxQWxT1EH1+d/Ihr9evx9tmGzodcNXDVHNTCrHrhtdtYQ5uRqwyZmt3nE1IoHL651Rlu4njtayWsDoLz2ha6Y26T3zxKb2ZmLIjzaiOa7uadUt1wb8l+veCYHkmOZJHBucgnR2Qh/xoks5kcr1Jrtiedf04aBu4Zr2BbzsqSGkXfOBrWf47rVV7J/eKr2hsxow+atR6zb67SWotCEPCkX7ULP/15V5jbbFr2aG+Kr8I0zPMr0XeZ0GZI29bYpNlEm+x+jIdg30oR6NtOAbZGsxEwiK+8qbiH6Gq96f7XIjNNLE2ivCfaXxfGznpe+8/3vyDFwNvw==;5:a7T6GnPHDPjNgC0OR2lo42YE8gnsmv2gKcOkFv6Vtj4LUoHPbI0ifyldyQMXFCnSwrnVWhe4Rsw1alGyDEp+UWDtP+N8FgbopU77pW2CUrbIQZvyy1m14Vvooy1hH4oKqRaLQ8dJosGsqgoHpSV9Wkgo68FZtXT/p8wYbMzevVI=;7:YJbXG1gMVLZWRsJID0qReLOC7dELuV0Q+1M+3ILXW3o2kRyJZQ6v8bYM+JTeJqqp+ou3KbIMgZRUTNhTc88iWfSEE5m6Qe1fxGX+o/Y4Fc67sgthNCkaNDDG0ksoD5MiLkS1x3vQN8grrUwWKsSD6garJnvrH4jxvuHXQ3/B6oy+4if0rbiia7OTu9K8DMGvkErizMiZ073fPSNIGFvS/tXJxR6EOwWI5HAe3ociRprf9e0iAYmW5BkfXpxnpPII
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:05.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf6636a-b0cc-40a2-1d11-08d6043c7705
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, uas layer can queue mulpile requests on
single ep with different stream ids. So, there can be multiple pending
requests waiting to be transferred. This patch changes the code to check
for any pending requests waiting to be transferred on ep started_list and
calls __dwc3_gadget_kick_transfer() if any.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 260f10f..3af55f8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2424,6 +2424,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
+	if (dep->stream_capable && !list_empty(&dep->started_list))
+		__dwc3_gadget_kick_transfer(dep);
+
 	if (stop) {
 		dwc3_stop_active_transfer(dep, true);
 		dep->flags = DWC3_EP_ENABLED;
-- 
2.1.1

