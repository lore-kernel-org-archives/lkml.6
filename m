Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2867FC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C120522408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dZSImeMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C120522408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeHJSPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:15:45 -0400
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:59524
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbeHJSPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTWN8O1xjIHsZtDgTKpfk9Fw/JRSsjKb7bVvz4rTgcw=;
 b=dZSImeMHaerBACCq3rLjLui369Lq53iTmg0ejMt4hxRGoQYJuktiLAfmw5Z243B+eqAvqNWVrw4AwVxYIyoGyTG4vdNuqcpYIwMt+KIssU6b8mivbr+1u9WM5d6wJD1LiOV+HdRpVpRmV61BqOgrs1WstUZ6xKg2FfQR4C2twSI=
Received: from BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43)
 by BYAPR02MB4453.namprd02.prod.outlook.com (2603:10b6:a03:57::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 10 Aug
 2018 15:45:19 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BL0PR02CA0102.outlook.office365.com
 (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.20 via Frontend
 Transport; Fri, 10 Aug 2018 15:45:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 10 Aug 2018 15:45:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9bI-0004wJ-BK; Fri, 10 Aug 2018 08:45:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9bD-0006uk-82; Fri, 10 Aug 2018 08:45:11 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7AFj0Jc007803;
        Fri, 10 Aug 2018 08:45:01 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9b2-0006kA-Fb; Fri, 10 Aug 2018 08:45:00 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/4] PCI: Add pci_check_platform_service_irqs
Date:   Fri, 10 Aug 2018 21:09:38 +0530
Message-ID: <1533915580-31805-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(5660300001)(16586007)(110136005)(9786002)(478600001)(316002)(63266004)(54906003)(5024004)(126002)(476003)(106002)(486006)(106466001)(6666003)(2616005)(48376002)(336012)(50466002)(36386004)(446003)(11346002)(47776003)(426003)(107886003)(4326008)(2906002)(7696005)(51416003)(356003)(76176011)(8936002)(50226002)(36756003)(81156014)(81166006)(8676002)(186003)(26005)(77096007)(305945005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4453;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT056;1:TsbpoHC7TtELHSbLbgqHKuSIAuJN8383YqRM2z7KgmgXA8M3VovkgrNnKIBo6LSf/vRIs8Bl9rd/FPCPhVUmGZl6AXGzfwF6yyodogRtf6W590jUPXkUMIUXahnbjSti
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c307116c-a314-4a5e-8d1f-08d5fed845f4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;3:nVr0AW3T2qqUKKmj54XWc1sHz+2BmFieVIMSb1b4aAdnYZKYih+z+vVnRxQ7Hy2+BdM3OMucvG0zVjAlcmPD/88xkAXaZt1tHrp/U0/D7bM2t9s4UGpGr0x12NvckVEussiyjesYhDDadETnRYIvE2SzaU6t64hhe3I+0XeRfrVSnBFfRQK+8+SnhV0lvgag9JfT6PyiojelJA7PI/ohYoKQGc6ucJN+S7uXdyZJNf2OOjL1pSPQulJMJUSTQhhE8fRDybzELzIaL1BWQfmjufYukk2be5NCOQb9eAhtbQzDn7et1pddSg8Z+FXioxUpyEwl+UmfQpH2uW73g2xG0Wkb+NfF9qCFGOJ1zvJ9hv4=;25:y7pWrvKQaduJB+aHspLXNuJz3ZChosgE7HUt8VoSYOZ7m6q17i2nwgIJes5DZwQ/EnRVgf4jT3DxwxbNQlqEi2Gmc27RYkjR3XHuR6XmXaC2rZN53cHcwP+dHJ2gPk+YqFalhD5mAnCcQPYqS1ARDz+0NHYC38qY3Vn8E//8UAawtnrLgw56sP5lGZzlIzaS2/p85fHaqdGVJVksONCCnLxr5Og+rgxagjI+n8PbotLg5ZqYOd1USBxuJ4KDROdjnzOjJxix6wOaltDtSPplBLglhYjKqaZAkajFeCMkagr9TMplzbwAHXMFbKJSpxC1oL/dSo02ohYpFy3V0LpNGg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4453:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;31:+MkcwrYcpokHDnWb761MNugCWXEBt/SKhFwlqMOqkDJXO5A6cw9cKifEPMYydiUKc1UY2dMlL2aXRCN8NyyO+R9SE6y3jNPnH4k3kXbZB3v9p9qutgKGslSwRi6grNG+Zb/gxPonLEYKzRAjoDNLTP3fOM4ma60DhSavw6DWf+ru3zPIUCBCCMfsqwYa8pjj7dg8NW5Kk+NIIFWCbVff9gxQG9XDIrg6ScnuP/R68+c=;20:DXUoZQGJZdCV26Y6NY1TCpdaxs6B2no2e59i4iGS9nYwlKoe87xlEXGmOe+0j7SnKvCpf8VK2osXM29RUM9j3DDx2oJFCpUf/aUOVv/rbGh2rHuYCcaI6BpLQZO84DmxN27Smt9RTSAH366i6JZLtRvHVenjvPdT+h+/4jrP7szdDzID9vBP00p9nN0lHJuSU4dpwY0auYfNk34X9ch+XY3JSumRlp+sdDu/TpZads9tzo1LJ/Omexv27qweXXLHXiTQSkTzhykOjh4KKLyjWqliwqY0OhXRiMNcis+LDutA+chVZxx7AXeNROxQHMKeURVgkEJ6ZJJB6ZNPNdrN82D27JIQRw+l7djbWafOCIl6HXM6Z+SOxbLXIcD2weZ3NVoJMOi3xtfIVbFXnwi7rmG68EplpR7D91Sd8Hwf9mLR+XMfjguRQeKElXXyBq1jt5iaYOSxhlYHAv2HPIZ9ti8ZLgsUnBJN2DQdlJMYoZzK5FLexOFZpWOIZmWvhm+L
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4453CB063DF605BFEEB41215A5240@BYAPR02MB4453.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4453;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;4:EFL9U3i6WnPssre1iNpu3tS8NMfdQfULyafhTUF3NlIFqDW3tYkK8EC/OzYKzjo1UG6IA8Q9QBWJUiVzlPb3rnzKhjcbrcLOf9SfskBYJB/ZPVk2RuMW/pUgiSIyGU0RwJXWRZzN82v1arZEalrSZIqx/p3Huz3yaWw/DBGBAcKCzV5wa00dOABso/OdsVhdwopVFyqE23GUxiEP1ZeiV8YwnT5IYFbDYwP/9xpiEev3p+F6A6yISkETIS/zBUacX3KcR5KdWg29GWybl9shhpvLkPwFjXLNt3jjv0EwdNa/U4C2NHC1RlWREkLWGjcj
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4453;23:R0QhJqg50AP+pxU/62k2sxsyEGO1pX8wQxTKCvunV?=
 =?us-ascii?Q?4ZxfnYoplES58dYVFGH9M33NoOEw2sLCamH2zfq5wvVUV1tMHPULvbZ+bAKO?=
 =?us-ascii?Q?HfqiVgFDT7C4b6eFmi/DrD+lw6od0ZbG1XWXF8x4AneAsrQ+aPekuR8Jm3HK?=
 =?us-ascii?Q?piZaxkVyhvP5KsXKHNt2ySZac1u5dX3fplPVOfVlRiDAoGlmnpO34DMq6did?=
 =?us-ascii?Q?yHjTjEM0XjZsqcjtJeZxLDry51A2aU8X3K9fYvroaESE1m3K470wnfaBdhbX?=
 =?us-ascii?Q?cwhb7IUMyjV4V5MagK3oY1yMhYDK6sPzL6bZ0eT5D/2IsVwBwlM8VIpjGYEX?=
 =?us-ascii?Q?W7Ygnfy/rw9RWgmjBlgVDJJ8zA+DnH82V86X5+ni+OruODap+coE1Sm9Jmid?=
 =?us-ascii?Q?IlPHSF+ixZaYPnqI/W77iOZEViO3s4P/HwEqU+hz07jtsc+uu9PKNUelm3uU?=
 =?us-ascii?Q?md5IV86dafRRloFSo2rgFsUPcxRfec0aBo9ffnkMSwT0c8M6r8N7can6j1tT?=
 =?us-ascii?Q?DfEl/xWD2i/Gx9JQJbkZH0MsNqMYELQHS0mDDJRW7K1rdPdJt2vTesDEFd0p?=
 =?us-ascii?Q?uwTYUcT8HMkdMc5MZIVeDT0C5RLXrEEB8yIMskMO1jja8Fne6tMmj0O6micg?=
 =?us-ascii?Q?Vw4o/oGiJTwNqttei1NyizwlUVPF9bqZraaPya5cdDObURYJyS06iEK5kYfQ?=
 =?us-ascii?Q?YJPfCKX1OhqfEJOi9xZvPv6pGIFJiSUozIsslmB0Dk9duCauldw/M4+4XJNB?=
 =?us-ascii?Q?R1qC3gERl1Jl+AFVbawu2rG6fmDDhBwEQR2s4YKj+CKlj+L6gb5mMaLdk1b7?=
 =?us-ascii?Q?/W10RenYcxPKSILLOxM4eXGpyp0TWpVyyZX4CgsS/oNOq2VKxDW/ctMt1lKd?=
 =?us-ascii?Q?ZKIJ5gPF7keWVlOXssWX81pOuxL5D29w3sHx6tWut6M/wRAPsfE/ofhMvcDo?=
 =?us-ascii?Q?k8h488ppUZzeJ1slNrrWe6dgdzemZZcGpmDRnG4fHzrC/ldQir05vdg3Q5AC?=
 =?us-ascii?Q?Evf+vdEqfB2IXyPzDQOFKVYq96xnvA/0drQDo1xDYIcH/TzaaUolTb3zlzhp?=
 =?us-ascii?Q?LdRq58dbVfKdmIsJenbeFf34ffyQXQtWVAwI21g4HeLr83hg6pULsut5urZt?=
 =?us-ascii?Q?S0Q/+NKxDY=3D?=
X-Microsoft-Antispam-Message-Info: 1gBoKsUQqhXa5iwAdNL0iJbDS4Yb5LzaoANeyZIaZAWS05h2Y6RtXFcz7sHMho+uGH3oWi8CTVE3j6ffvHVBCop19XzDAopHXukl0uaaSLZH7N9Dm75KDqiUCQjhribGTBElPy6f5jj/mGP1UZlSBc+LzHRY99gLFFSaejN4J0Dlj7P8XdIloMq5gs4wTgjG4VIevVZQWnvHrMayEojZLwTIpQhGMnJEzJvDwZAAgfQ4d0VhzlROBBm8X2THqlLrZjAeE7majF+lRytvZWXrU1gp/S23eddTusp/5nFgoPDZWNT5zZRzvAOYUMVWFhCAFs39dkk7et9m+nCuyKd9lgOH4nVyGQLc15ppXvVBGWk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;6:mLEFKo6cNInuOkj870XDXh00+/2M7nSsxIDeUA8w1k/Pz6R6LGaEqT6heIElKgs8EtPPJvraQoTsm7yCW0B83CNp1hC3GunTHBEKVo2pwf9nv7j2sheEl6eJ5Gk1MAln8oGjClz5wao+MXflLJ5bnGJVIGi89fPbdgRtgT20nPf1mecZ4BIih+vkc8hKalr8K+6uAXaEc4e0WDkR9TaR99uZDloXyXKPy5wThcdxdDz+z4cZ5sH/s/5j06cC/szvuW1zdDy61vBabcKAw4rYWWGHnsMnok00AtjUIne2mcOvT6+orN+Kdwhlqp4zZ0gj6/wE+gZwGFeTuUFYADXFt7Ubsl6uWV1WPYoUezagYtJ4n9bU8g6DqIhW5UYE7ZFtJZWsiNOgXzdIc6feXbunDadD3KupOiloLkHf/TAydWJIMLANm+oSzwRj/bWoHMgViR9MnjZaBBP3yV4aL2mF8w==;5:lA0C48/67PWxyx3+5H0hyOtLde2VSYjgSdmnmmpQDP81dt2d2RNkQta2eXG+XQeeyFJ9h+GPS7K31u+ZFekb4ChbmZJzeu1wRNlYRIbg0xPZ0FuYJTrokOpwekMW9GlaD/xOBfCKlyRoCWDL6grTq3+xmJhpC876xEvxbGJzVks=;7:H15THKgzcu33nBA5zdJnvWzXnJj98F+9YajvZFJw3SdTwYnkRYn3YBcfjXi0KQi5NxHlIqQMR0lo8O84aACtn4gsZr37LzlI2EknuPrbOLGg44t/BvoSw6XHut0qJlPP01JrvcPDaurVzG0WFayK8JoGBxbnz3MP1kzWmi6F2zFHRWP3FtZ58OZduBFwQqrHwecUbs072W/anJghcWS7B3xA4D9y5LTkY//YPy21WgvYJ1o6eshNLqinMrCYVqEO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 15:45:17.1119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c307116c-a314-4a5e-8d1f-08d5fed845f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding method pci_check_platform_service_irqs to check if platform
has registered method to proivde dedicated IRQ lines for PCIe services
like AER/PME etc.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 include/linux/pci.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c28f575..8eb6470 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2271,6 +2271,30 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 }
 
 /**
+ * pci_check_platform_service_irqs - check platform service irq's
+ * @pdev: PCI Express device to check
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of capabilities
+ *
+ * Return value: Bitmask after clearing platform supported service
+ * bits
+ */
+static inline int pci_check_platform_service_irqs(struct pci_dev *dev,
+						  int *irqs, int mask)
+{
+	struct pci_host_bridge *bridge;
+
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return -EINVAL;
+
+	bridge = pci_find_host_bridge(dev->bus);
+	if (bridge && bridge->setup_platform_service_irq)
+		return bridge->setup_platform_service_irq(bridge, irqs, mask);
+	else
+		return -EINVAL;
+}
+
+/**
  * pci_is_thunderbolt_attached - whether device is on a Thunderbolt daisy chain
  * @pdev: PCI device to check
  *
-- 
1.7.1

