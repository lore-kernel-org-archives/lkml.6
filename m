Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6659C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E49B2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="i+Jhysnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E49B2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJCTVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:21:38 -0400
Received: from mail-dm3nam03on0050.outbound.protection.outlook.com ([104.47.41.50]:42336
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726547AbeJCTVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WgVl+t8eN1xiAb0gLH+OGEtZLMKREUhKbrLNAnZbTg=;
 b=i+JhysnmPLz0l1E18xYNXxaCAIZgRMFlc5kBpCa2Y7/lYcxF2y/bbYNmN64BdoNFAJEMCooWtM2mUyHuyCFJO3PUHshTgiQfeqZetJPtN3S+4MtiSkjXiWLGkZG/xSSe5j+yV1b9fMmXaafOXgvNuGEAD3EZD4DDYj/z9v5EQUM=
Received: from BYAPR02CA0028.namprd02.prod.outlook.com (2603:10b6:a02:ee::41)
 by SN6PR02MB4477.namprd02.prod.outlook.com (2603:10b6:805:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Wed, 3 Oct
 2018 12:33:22 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BYAPR02CA0028.outlook.office365.com
 (2603:10b6:a02:ee::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.25 via Frontend
 Transport; Wed, 3 Oct 2018 12:33:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 3 Oct 2018 12:33:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47033 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g7gLB-0000wv-9f; Wed, 03 Oct 2018 05:33:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g7gL6-0003aD-48; Wed, 03 Oct 2018 05:33:16 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g7gL3-0003Wt-7k; Wed, 03 Oct 2018 05:33:13 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 4F250604CC; Wed,  3 Oct 2018 18:03:12 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH] usb: host: xhci: Find usb-phy by phandle if of_node not supported
Date:   Wed, 3 Oct 2018 18:03:11 +0530
Message-ID: <1538569991-17959-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(438002)(199004)(189003)(5660300001)(90966002)(316002)(42186006)(106466001)(103686004)(478600001)(2906002)(36386004)(356003)(110136005)(305945005)(51416003)(52956003)(63266004)(8676002)(50226002)(81166006)(36756003)(81156014)(106002)(8936002)(54906003)(126002)(476003)(486006)(426003)(26005)(186003)(107886003)(16586007)(1857600001)(6266002)(50466002)(48376002)(2616005)(4326008)(336012)(47776003)(39060400002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4477;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT049;1:ex4trjUpvBduebjPIpqs0+E6aVTCnTy1NLPTl0T2dYCJv3vsdqGny1sttZsszPqJEbdCSaAbwU6Vn47+v3U5wY2RcCeaao5iIIWTrfB9MvHmGFm7wuKumbW/AWLpDHP6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a231f656-6585-4553-9f30-08d6292c680b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4477;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;3:INbQqnbhkoVxPOjecXTLm4EocwL3p9x/79GAWojKXJrCauJN9HC1YI6xuuDUbv/2Ds2cvll/HNjn9VcYJcgqb66pjGWGlnxnY0NhxlIlDWtJiLGejMqQQOGfYoJxHJEyC1cSE02rtv3X8yi5P6Dw3aXjp1ITyX/DtI3N4Th9YBWsbPd8D+waYoiK17doGCYNobg7QnC3wmNuQplazmlzQ/CmF0BgLzF0+kpgFgF13BOyqnxEz9d5WhwOvruscX2bKvl8TixERw06WEc4QJHv73Y0F3iKVN94eMeeiBPETVRlh/yt85evydfSR3uwHNYOpSVDUxOfDffLmednMNC39Ysha3LoO2UuhTQ8g6lDpxI=;25:Wlbe2fvmsms2GWd1rNZXOYlWCiDQBb9IMRu2KC0sYFI31W0jQthSqR3UFacol0DnZtHM1kX4C2WNFDmhcItX8wZhcQuac5krJaJrC2r4DPvUkO06Hud0GFaqmbzr/SHiqHZbmQonAiid8uw6xjGRD4ANlsShkoDCSKSKcnblNmVjIcOBviF+kyCcnxANkJCtieaUemFhPVefK98hNKP90nMw1/OxAd0z/zv31NK8M2cxWsf5yIMx4p6m7bsgqNX8JT1rb0rfF3JX23VxvS5XatFb/RqvkC8gB2lLbv8jyp6VEWZH61SxlM/cx20zfzEjy0hXlI3RemmUcXBNEOoSJQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4477:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;31:o/M9fUd9vEJ2OtwnIXmIxnCsb210dgI5V+S5VTKSYZDAZWp72IAsEQdlNxMS8COaCR2evjiObkpvOl0Waa1denL8fDP9ozDMKFo92BNUGLG1NtZ9D8UBJqAq10wwrbp03LYs9T+VA0BhlEPCyI1rBKS9o+kufLI9z50Y+4LKfH22FLCVtWXvm02O7Niz4SKxAIiZsgXPHpn2NwyICBhQD83tDRoITx3A+woVVE+SXz4=;20:FZdA88n3kexKHBB+prhUz7P3FmV5gR5szX6OfH2oi7fRSLa/z/FjM0aGG+TlboOMCdIrWwUP1YiEQ/8WLv2FY4RI7+fjMETyb+9nQMD5TR0grkAiTXQmbK6cb1hddeCtzNK41qlb73Aee2oO6tfhfQGQ1NA3jkWLL14tLUrVnm6fsQ8o9UK3+2UGiPtM/vd2mSh95qI/I2B9oGuZEJz8YrBiMOUHrTQWChknFkQnnh6TP37M8xp5Yu5wLbzhE0IqoJSvi5ysGRL93Ale0GxhUVMHd2ltFGCKSvjZUHkVSlvlKI3pqTbwnAcrGRgs1sLJxZOj4YuD3/MA6prLZuvyNeAp/g8g+QcLuEHUM3x6SSI7VaZKvfeUf1m+8/qOQ8sOJyuxugEEHe0eioKyPSyyCRu7q9/BuuTPPucnfFOBIbdnW4jGEaGaRuQO7kJIhnHLwcvDJSpSkvemellMdLh+cLPU2e4LepEAxHPqX/sLaLbaOOm3bS8mMlFUB9iPEwVH
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB44774DFA4FBAE4AB769B5652A7E90@SN6PR02MB4477.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:SN6PR02MB4477;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4477;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;4:ZwYdaNR4p+zYeb4AwD7CcZt4hHlzhyzXOo1ayS9H6RTmfSrCWUZY6WKjsUns4Nb1e1xojFE1WopEiiq+jlv9tDH9ZVO9VxJYjLIVLk97/3oOIBAYElHl4aNN5W+E4F/YADK8ScHhQkeGNYJrC0RLR+yZ9b7rH/FcGFwopR8ZsdCOMXg+CsLWwaJDraD4qMWTIFx0X0MhLM7vXy58kUBxvwWpgt0Yfd8KDUFUdWln/Mkq7tqiwqMA2BhJr1xHbwLqVYbrLvctL7EnYRAm/zamAv16ZwjFOKHt/5jIaU4R0R4tBZWwDJaTPt7QbxOOROlW
X-Forefront-PRVS: 0814A2C7A3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4477;23:uyPESgeik5fnw3LrvmJSjvbSPZkuex3BSy+1eXBkK?=
 =?us-ascii?Q?tC5F6X1p3KnxABUBuJYuD6alvDx9AX7F94RdGDaC7AFm7Wqf7xwLF09ztap2?=
 =?us-ascii?Q?B1kUxhe6mqCJSx1H0gl9pHv5sDFvZPBEGjvGdWpxQAsFd77/Wvja1T7dFN6O?=
 =?us-ascii?Q?KUdGegF3EqcPH2ln8Qpt/gPfQ8HwzJTXKelFr+NHB3wngWvtpRxF/l6fkqlq?=
 =?us-ascii?Q?J831oeu0eV7M9i5mtGiV+7ndG5fWxAhtsRLUxXaIq3n5EQE2KTiGD8119dPg?=
 =?us-ascii?Q?kcQ6rcQssucld6aardP3mQNfIMIAn3JR4ANjsBYHlwhMNslr8e3NBtd2MDkn?=
 =?us-ascii?Q?X4Vz4IuiStAv2H5NjigzJCnesRBWQFBbhZDgBZ4OLpWRb9Si2uu9n7X4lo9y?=
 =?us-ascii?Q?Z/m4tXz9XwdBj/cNPCVjxVE7dRxyslgkgwPya77OgWFpu0oWv8lUdu8iVI+/?=
 =?us-ascii?Q?MMtA8CdYLY7Ki74wax4qbmoigp9sJiV5ZsKkzY/bV0YwfkKVMe9C0y4k6Eqf?=
 =?us-ascii?Q?sEHZUkuAUZU4KF/bIWIxv9BSXY9yo9sNX4g7mY0ReYepzo+8N599RzRwdO3T?=
 =?us-ascii?Q?rcCRgFNPUEF8VyJZFd8Yno68g4cjByTzaEWyauSw2xIHFRTAHxjHmMs0ja0P?=
 =?us-ascii?Q?Wz2mcR40b6L8m1lYl1X7/s5etJ2l+5oZ0LsacYh+hXqdR+C1aXtgejqbYh/u?=
 =?us-ascii?Q?TBZ8i/LCxDfxT7+av7xWDGIkjMlgTKloJK6W1HiF+KXk94gtE4TTISHNOtXe?=
 =?us-ascii?Q?KZZVUloMtG8xsEngjmUhjxFiy8mN+z7tA2h8YVH0T7wgW9IhOi974zA04LO6?=
 =?us-ascii?Q?99Rr0XRxO24jhL/nXDENiGlZzdN0o5xPlApHXsUK5Q4mP9VNw9o8wNh9/o6n?=
 =?us-ascii?Q?/5pX9r2aRT5xgpmMeP81/NCp1QjH+GA/MK3tn4WNY1nsIh2mKCrT8mZ/tZQ/?=
 =?us-ascii?Q?hthFIRZDmsd50HZs9auxTP0wlLKx4K8LeAxu2GvC52MwaPeCi4kTGxF5UKMO?=
 =?us-ascii?Q?9ezcP0dFNvLPH6a6jjHmWMcYzL4EDQYdxdcynYFUnIsvTdmEI42W97olFIGl?=
 =?us-ascii?Q?yvPQ+fkZ7kW0T3+hEJZFVodyMmUFYX4mYYsmnJVErDOhM7+iZ2z8vwRKFiON?=
 =?us-ascii?Q?ifx1/cP+u5x2mpTFWuWaHt5hA4MNksexxJAaEjGZ6ZY7tOsiA0Jyw=3D=3D?=
X-Microsoft-Antispam-Message-Info: LnvJaLwmrsRs5GAXuQSE0a+Ob03+EKuwjTUXZqimGvGvhDyqGaNz+4xW4FjIOrwdyl3jDSmQsZwM1SXPggv8NApHgXje5b/Rh33tSGSXqBZuilUJuhZ8RaVXR6LKn4eaSNK3IYyappHddNBeaqYz10CxwjR44/YS4YtXgzVGssgiXsGX6XfXXCLbASeS/BKV9/L45ZxfDxXwE6toKkiipfX3aerDIuX/d2+j08sFMMEq9KY4wuf5e2r1HMyB6Fj9NzfcmLlZhixu5MrXoEeJCyAtIsvxUdndm5NMXYHLDQm08PREacs7dKajn3txwFjX7272SETjbPt7Jjm6EJ42Zcv+8psLvfrRce8HQ2JyIUY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;6:MN+zf8tXXmb2gQJf7Ymcf23FC0yNv0niBOkdiSw4X/MQXthzVePb5L7ZR+E2g+ynxZkF5qHYN03QtxW2j/fzJfFvHxuzkf4PfG1lBVkWAGtcGExbswQvbzOyIsPumsAJ3oxDXucOREscx04kAWNlrV9SwC/C7dnbINHZYOVro6f9ArX36B9O9Jm1ZknJy1OgKAFlGdeXXoTIXQL+KNngKS4JL4FQtHy9yVMsWDruqsUC873+Bw9iNMkj9jwokXD1hYgszH6RmVNEr47SqvJvffxsQQluDfXQ0d2TExRs5QVr98G5PhkavwEwPlstEU/IOY8jbklwlVp7PidMsYXIQzOBLupF41TIkqrkVrxXXqyMPZbyG9fBj0p5+6iH9dmsiRa4jh7pSsiDnoVatlmnHEw4ed09AMWyG3QPUweguTuD95RkOCyAVoCpEfNoGBSHXDSFK0x7M0jJm5yBC9vNYA==;5:aSCB3B7zdF9e8Zqk+HqT1xLe3DYd/YSWAjf3DUzR3To2zBtOShB4L69kScLMkY5wp7sD051jwGLuL0SxTurPWhX1plOwQBxO+NVij14aUVqAAjOrT5j4VeNFaMNt0Zn7A5Dn0IhWi026XI8RcoUrZ2CIgW3YBxNUncQcGRUB27Y=;7:q3/8of5XXvLcyTkvdXaJnWNFRwjfWrkzr+hTkMA/7CiQYjVBjgnLGQIvMBwBRwsRA8PifCp8m2R0w1nvsMMTSArML3bmti5cPnPihpi8dsVWKLHSkWxS2OtnBMnY5SYbNUg5L1VCXODHblE+94MwxduQDH9y5P9uMNAxHiinhZyp5VuLHviRVHtzukeGWHRHXVtPcx3re5A3zsBt6PF+SEq4wSwn/VhOGFjjGisnt6vyXOvQjM05FmBFAUrLqAa6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2018 12:33:21.6958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a231f656-6585-4553-9f30-08d6292c680b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use cases where the usb phy is created at runtime and
added into sysdev (for example phy-generic.c creates the usb phy
during probe and adds the phy to phy list using usb_add_phy_dev).
In this case, the sysdev may not have the "usb-phy" phandle added.
So, the existing devm_usb_get_phy_by_phandle() doesn't find the
"usb-phy" and returns -ENODEV. This patch modifies the code to search
for usb phy in of_node if "usb-phy" phandle is not found in sysdev.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/host/xhci-plat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 94e9392..997836f 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -293,6 +293,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	}
 
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
+	if (PTR_ERR(hcd->usb_phy) == -ENODEV)
+		hcd->usb_phy =
+			devm_usb_get_phy_by_node(sysdev, sysdev->of_node, 0);
+
 	if (IS_ERR(hcd->usb_phy)) {
 		ret = PTR_ERR(hcd->usb_phy);
 		if (ret == -EPROBE_DEFER)
-- 
2.1.1

