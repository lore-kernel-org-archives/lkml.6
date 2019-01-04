Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBEDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE44218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="k3iAaP+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfADV5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:57:00 -0500
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:12512
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfADV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iX2rqR+JVMF8vB2Qx4K1nq4Ic3tGhdZSScmO4zzsQQ=;
 b=k3iAaP+YPCq4jwrHamJS9BSp0ULzC7E0sMDWp7NZFoFlFJuCVWH6chfbtCLzGAvwgEEje/5d1/ZpUeRwzGMIHXTObdGDsXCmbznbaYQu8UjcZmFHyWkQ41CC7KmPkIq6AMVF3vmcjHmRh4jsA3Dx8eTjg4vSL7Hm6iIor72JKjs=
Received: from BYAPR02CA0048.namprd02.prod.outlook.com (52.135.236.153) by
 BN1PR0201MB0724.namprd02.prod.outlook.com (10.160.169.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Fri, 4 Jan 2019 21:56:52 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BYAPR02CA0048.outlook.office365.com
 (2603:10b6:a03:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Fri, 4 Jan 2019 21:56:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Fri, 4 Jan 2019 21:56:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43788 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSS-0005R8-9c; Fri, 04 Jan 2019 13:56:48 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSN-0005nC-5v; Fri, 04 Jan 2019 13:56:43 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x04LuWi1021618;
        Fri, 4 Jan 2019 13:56:32 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gfXSC-0005iq-4u; Fri, 04 Jan 2019 13:56:32 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 3/4] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Fri, 4 Jan 2019 13:56:21 -0800
Message-ID: <1546638982-12954-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(189003)(199004)(77096007)(110136005)(81166006)(36756003)(2616005)(316002)(476003)(2906002)(81156014)(8676002)(63266004)(5660300001)(6666004)(106002)(54906003)(305945005)(356004)(16586007)(106466001)(486006)(26005)(51416003)(7696005)(107886003)(47776003)(50226002)(186003)(446003)(72206003)(478600001)(11346002)(76176011)(36386004)(44832011)(126002)(48376002)(4326008)(50466002)(336012)(8936002)(426003)(9786002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0201MB0724;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT026;1:gn/FZd8ae51vuweT8Hn2BdYh3uhiYYpI37PnB4CHzteps00ka29u2YViHPSoBANo4Y4ZKhK4GlnhcSMUXlo+zw0t4ucNJF3nEGI3tfj+QtTRMoDoFUkD9lWZ4m9EpoFY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e428261-fa76-462b-6ccc-08d6728f8846
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN1PR0201MB0724;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0724;3:oVZQlIK6sDoltK4agw2nmtNrp17QtyapTFbvx8yPFKt2ckz2ZoO296wOJgUifdAu56tKprmLrqtO6a1RIgxyjHJTcbvsWV3tavbAMZsxjC16g1v9dHkcrGlP+tNyPjZvDBeRQ6sFNrOtapsx8jrPKwURFm+fK/blhhYDVb48eDtU1NFE7FWxVX/ilpNfXJwXupZU3fZDvWxF+sJNIlUXW6xQDW+dYSaSdBwsmcoxIJuHbTl6cfSzUc+D9AIsrIJJ2ZfsLLdeSkg+6Mmwe0o9POhQF0jbC/SvMwdlioHIcOONG1whLsL0MenM7iEK5fB9409mN847RwjeFBN36HwCqSEAaji+sSFobNPilq5MUCfPBl21hh/UGOknjO7X1taR;25:lHlA2xXruUpCMAWqdFbCsle50MaExpvKXI90caV1suosEkW91B0diFGm27ybbjgnhAnr0dEO80qnHAWkIQ859Njnw1byalfvcARTFjd0IrNsci2YpD/hToZ1MxZuaMxuVABOW1nWE/0nD6IsehEipZkJVCow8VXp/1dx0SGf16NLf3SY7xl1CyG0D5PFqQufIdnKE5Y9GpVMA3Qglor6gqmmoJsy5vRIuHZBLfFISTxDQNOdJRvTl7BIwXBd2brtMbXRBNf7aG9b62wCX3N/Axs1jv3tSZ3ns/8+uuL6NadDIbQz9589a4uSv69bbPn70uKVFYb8hI0gEjwuHyTIAA==
X-MS-TrafficTypeDiagnostic: BN1PR0201MB0724:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0724;31:NPChn8sTHL74TMJze9pIT48bhPhV0lUwJ/Y5X6dJYJKSulY5xfuEHjybfIwWYc3MhJF8a/CuXXBeZeHa6VYNE7ebR/lclCq9QtOro9isdJf4PtaGzr5LuLD6yBfOW+6AqGRBehcRxUMRo3u9CD0ln8gxuX6+Q2/25ENsDtUYWCJSPypkaOu/NdcSlbozybLvI9HOGqp2RfHwC3TSCZ9Z2TOW7OFLsz1+FFZwfa7Hhdw=;20:WpNY8vr5WkfhmDgGy9UisJ02y6xm+ttLLzOVraAoqic45Np/ywUD2FUBPoGKMqXp1JFlBBQi/I4tY9TBuAQwgHylXvFH8oGvqHCSPIIS9oJq20s20X+1xlku2UhDLpOKtfQpjiGzMa65slBeYVzPEWXwvK0sjAJTaMAu7qXpUL1X2qbDBC/zvEl1WVHITIn7dzTpmRiaORkGQFcapEX7gksrjO44YlSAjoiygAOMWvvWEaiArUNh4iKBDUZkdjYb6o/oRGWLDL1L80JIp4MbY1DyaVTgU93VcpGJxTsu5nOwKZsX/UhVeHDBmf8Vlr+YIluFczyQFHghwYeK6GYIbKcFqICUp9H/6PQPyzorMS9tgJsMnyC0ox5XZurngYq9/KZQiNz3edPHxxO58d7aD7tLgUJFmXgmCxY19ADHR0nBEJMj12/Y3lKIs+XAV2HDhOC5uRBpqITKrv4S5DfSKiBxlB5IjNEElgo4LXBNv2c3sl6a8JloaNhQQ3r8SXBt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR0201MB0724828F1EACE900E300537FB88E0@BN1PR0201MB0724.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN1PR0201MB0724;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0201MB0724;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0724;4:H6oObyQ4Crul4PVG4pgdBCUbNNph9S2J+Q8+7zHP6duRCGHKnYdGSd+OJJG02e2YukN/vFCfgFKgUcqBGt/TsWPkNelkUL3hFCauyIH/W5Gba/HSYfQrF82+b5w4YIq6c/6nn2jLY0jNBb5qiSjHMh4M4vJFfeYqZa03whVTYO4A65KJ4nZ7svEbxGC22eJvuRuZOa05XCcND3xbF3ZKL1Eo9rndL2b7ahpbmCXpY7G7Z0thEwjYgZoKsyGqcLjHi2SKiuF3pddAYKCI2f4HZRCDN406odcCGYHr9kWUqgEmACtlwwN3LqJJ8+3G8qZa
X-Forefront-PRVS: 0907F58A24
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR0201MB0724;23:Q396Pp/ck96MUQu8BmzPcX7xi45mEuc2qVaUXxq?=
 =?us-ascii?Q?zNHZh1lvsoeRBMEG/nCc6d7yBudi8UbSOUZsBrijY6oPC40rY/IahEGRS/6P?=
 =?us-ascii?Q?4OBAIpX8/nAfyfuvv8o4CWsIwGwstCd0Klv14mPb1eWmjsGqfvFMG+aYXkjX?=
 =?us-ascii?Q?j3a3Qphm2FCLPTUPCbtthEMeH8c1sg7F91nUK6aecaRD7NFvrRmb8XWil0LX?=
 =?us-ascii?Q?fiEmcngOh0SNbytvjDFeFVmHpz+OUxEjVPxMOqKVUi3KqPSUIzqAztHCfiPP?=
 =?us-ascii?Q?GsezgmbC0K7LbR3U20xRZU85G0lSbR9X49J74RNiWWPsZQQOiPULk+Y0YY3W?=
 =?us-ascii?Q?fCIovcUSryPWVlAO9hwI9t+e0zN7YQn0O3iC9GOBs1DmdviT6o5tsepBJveS?=
 =?us-ascii?Q?khOlzhp34f9OCYcpoPxNB1RvH/xz1vyzf/0JkCFYaOUOKcUHvVnOfNtyk6aD?=
 =?us-ascii?Q?z0z4kQpGkEgY4f881QKAwrRyEIrkskqB3e0AjNn+WLqEEdRqGdU0FI2tFRGT?=
 =?us-ascii?Q?+vr9q00EyWegUtjh/+DvJwjjk+HlTgyLViIUQRVdL2SXj6B/qJwA0XT7QFnC?=
 =?us-ascii?Q?PWlPspOuit4Qs7q6gYSQWqy3vLpmafSLOAr+7gLZf0AIFgWSKIxAWayhus6D?=
 =?us-ascii?Q?4i3ljVM/wgGlCW4r22vDCZBjWsjKIPAVPIE62JDU2Qpvv1mfykmzwaqb3mWL?=
 =?us-ascii?Q?bMfCebL1p7ZRDqhNJtdxdjIlVBZ8FvCJm9FEk/IpKz+eQY0zdB2qyLb/LUiv?=
 =?us-ascii?Q?DCqgWGmaKQOaAmCBy5ddKLyRt8/VPak/hMaz8eUBctMAJg4tyFj5VFYF1H0/?=
 =?us-ascii?Q?TJO+Vn1VJpdWbJR7ii0Q9yAAdbh8hzZXpRZ+Bfno+2Hn0hCKvj5+zqI/m8jh?=
 =?us-ascii?Q?KVNFm9Q3qtEF2fZ8sHGX81Cipb79I9SLpQ+X6VpzRfUFCC7oxWZfnBEL9PKg?=
 =?us-ascii?Q?dPTevBC58GaxDUakJtYJgcCoL6FnU0zQvvSJ5aDYW7HLgwNY6p9Bfr7aR6t0?=
 =?us-ascii?Q?6feUiAhxojxd3mt+ZT01O40zBD+vwRbRxUfAA8ByTcBZ0HK6SJs07RydXn5X?=
 =?us-ascii?Q?VA5WAVl8wrfizwAyLzXRrFBD7bDrvRNb272dfcE+KMvfyw2GnMh8lhkCY6/R?=
 =?us-ascii?Q?XTqs6tIcaNjy3o6EkT6u3RwQaU4WRE55KopRvsWyu584bWhs5UXrlUQ=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZzVGIS/+PxMQYMT8kwGAv3XjiwJcj5RPWsZNAZpc9hkUTOwxnxPPWKe34MhpBo8i1UyXqJiFNnKPd4k8HWzsPybf+TS6d7ABavZspaupyBSl+Du3ISouGxATjcirWyCsnEWdQjhRY2uwQr3ROkaMLvAGvTHczUAflKwcSgcfd+bowBwFjJ277/i0uM1beVXP/n/HggO9z5DiVZXUQxPW0JzO0wu/gDaVsF1MAsKPfswdInvjUwDKWsOAx6sfxicNr/OSKkuC5MX5Hox7h0Dj8BzMYD4g54AzMqjdvi1ZM+dReCbiazI16jvdNaQmXbV8
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0724;6:vdHKltS6zkr6sgAFDl0LxUmP5bQCVJKDYvpEbuiG0nMtcODE6ugEWTOzglqFyIAB5IhiAl7QFAscxjCWmfabLyJScmIeuR61codf3LPvlLP0oXlVDpPY61J4p4/S1V6JeUmScqO4GWz7zF+iXmJ563MM5Xkl/1qpcPGIi/tWEfH5CwMeNpze6D2aqzvywHrfjBN2GnQLHegj2wXLNXt9FlzdiwRXjzMjeY6hWfnRcQWO3A3+tZ2yhWY2x04AaqgYDEEs9foqWVLfalm93C2dilnhqCdPMooTwZph2p144AF9oRapjJ2KhEKOvLfH8NsZ+GTfqn2DO4ppTkXsgGcytcfebcw13EArFuZXOjSTeWF00Rfya9u7p5YAoRrsGRKGCq4EggtcMJ7YynX0a0SRia3Fx4GwDaSdN+MlWor5nzA+qGdmEkNCj6ktQ197WuO4czn17wKzJsvhwLkhuL9+YQ==;5:UN8ehm6Rpf+3aurseKAWPA5DR/odhsSKhrGI4IdDjtfmLuFIZr6r3NcnDtESSpgOFj0UNr9cjklKrXpXDUBrDVkebXNDEXUGVgf41OfoK2FsCQsLHjeA04OHufIZ/CH88C78+keDuVzUlruaBiBORE2A6ixHm496qCxJue08VvLaYoC9IJ0W8crWy2avGVK1y5WZY7OmHA9+nJ4oOfMqDg==;7:x0JvyNGOJCoDlGzkh0FEsC4RqUAoacIRYoqZM/s7eNi1eB4MTLCcqK9qRf0MI60KbwnoGDvAqozUaOSxo+qn9p9lmFLoLfMr7CbEuE8cF7Zfv6OfGkIqlccO+efKGYgkpxg1pLLKqOC5vdJwB9slFw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2019 21:56:49.1709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e428261-fa76-462b-6ccc-08d6728f8846
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0201MB0724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/reset/xlnx,zynqmp-reset.txt           | 148 +++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
new file mode 100644
index 0000000..e9c1af8
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
@@ -0,0 +1,148 @@
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+Reset outputs:
+	0   :PCIE config reset.
+	1   :PCIE bridge block level reset (AXI interface).
+	2   :PCIE control block level,reset.
+	3   :Display Port block level reset (includes DPDMA).
+	4   :FPD WDT reset.
+	5   :AF_FM5 block level reset.
+	6   :AF_FM4 block level reset.
+	7   :AF_FM3 block level reset.
+	8   :AF_FM2 block level reset.
+	9   :AF_FM1 block level reset.
+	10  :AF_FM0 block level reset.
+	11  :GDMA block level reset.
+	12  :Pixel Processor (GPU_PP1) block level reset.
+	13  :Pixel Processor (GPU_PP0) block level reset.
+	14  :GPU block level reset.
+	15  :GT block level reset.
+	16  :Sata block level reset.
+	17  :ACPU3 power on reset.
+	18  :ACPU2 power on reset.
+	19  :ACPU1 power on reset.
+	20  :ACPU0 power on reset.
+	21  :APU L2 reset.
+	22  :ACPU3 reset.
+	23  :ACPU2 reset.
+	24  :ACPU1 reset.
+	25  :ACPU0 reset.
+	26  :DDR block level reset inside of the DDR Sub System.
+	27  :APM block level reset inside of the DDR Sub System.
+	28  :soft reset.
+	29  :GEM 0 reset.
+	30  :GEM 1 reset.
+	31  :GEM 2 reset.
+	32  :GEM 3 reset.
+	33  :qspi reset.
+	34  :uart0 reset.
+	35  :uart1 reset.
+	36  :spi0 reset.
+	37  :spi1 reset.
+	38  :sdio0 reset.
+	39  :sdio1 reset.
+	40  :can0 reset.
+	41  :can1 reset.
+	42  :i2c0 reset.
+	43  :i2c1 reset.
+	44  :ttc0 reset.
+	45  :ttc1 reset.
+	46  :ttc2 reset.
+	47  :ttc3 reset.
+	48  :swdt reset.
+	49  :nand reset.
+	50  :adma reset.
+	51  :gpio reset.
+	52  :iou_cc reset.
+	53  :timestamp reset.
+	54  :rpu_r50 reset.
+	55  :rpu r51 reset.
+	56  :rpu_amba reset.
+	57  :ocm reset.
+	58  :rpu_pge reset.
+	59  :usb0_core reset.
+	60  :usb1_core reset.
+	61  :usb0_hiber reset.
+	62  :usb1_hiber reset.
+	63  :usb0_apb reset.
+	64  :usb1_apb reset.
+	65  :ipi reset.
+	66  :apm reset.
+	67  :rtc reset.
+	68  :sysmon reset.
+	69  :afi_fm6 reset.
+	70  :lpd_swdt reset.
+	71  :fpd_reset.
+	72  :rpu_dbg1 reset.
+	73  :rpu_dbg0 reset.
+	74  :dbg_lpd reset.
+	75  :dbg_fpd reset.
+	76  :apll reset.
+	77  :dpll reset.
+	78  :vpll reset.
+	79  :iopll reset.
+	80  :rpll reset.
+	81  :gpio_pl_0 reset.
+	82  :gpio_pl_1 reset.
+	83  :gpio_pl_2 reset.
+	84  :gpio_pl_3 reset.
+	85  :gpio_pl_4 reset.
+	86  :gpio_pl_5 reset.
+	87  :gpio_pl_6 reset.
+	88  :gpio_pl_7 reset.
+	89  :gpio_pl_8 reset.
+	90  :gpio_pl_9 reset.
+	91  :gpio_pl_10 reset.
+	92  :gpio_pl_11 reset.
+	93  :gpio_pl_12 reset.
+	94  :gpio_pl_13 reset.
+	95  :gpio_pl_14 reset.
+	96  :gpio_pl_15 reset.
+	97  :gpio_pl_16 reset.
+	98  :gpio_pl_17 reset.
+	99  :gpio_pl_18 reset.
+	100 :gpio_pl_19 reset.
+	101 :gpio_pl_20 reset.
+	102 :gpio_pl_21 reset.
+	103 :gpio_pl_22 reset.
+	104 :gpio_pl_23 reset.
+	105 :gpio_pl_24 reset.
+	106 :gpio_pl_25 reset.
+	107 :gpio_pl_26 reset.
+	108 :gpio_pl_27 reset.
+	109 :gpio_pl_28 reset.
+	110 :gpio_pl_29 reset.
+	111 :gpio_pl_30 reset.
+	112 :gpio_pl_31 reset.
+	113 :rpu_ls reset.
+	114 :ps_only reset.
+	115 :pl reset.
+	116 :ps_pl0 reset
+	117 :ps_pl1 reset
+	118 :ps_pl2 reset
+	119 :ps_pl3 reset
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		...
+		#reset-cells = <1>;
+		...
+	};
+};
-- 
2.7.4

