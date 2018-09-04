Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103A320867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kzIDArgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103A320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIDORf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:17:35 -0400
Received: from mail-bl2nam02on0068.outbound.protection.outlook.com ([104.47.38.68]:32947
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbeIDORe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWmqb0ccPxeFzWv/TKbOlNdsGwZ76a4wXw3zMy7OvRg=;
 b=kzIDArgWXojnHo/mePnfnyqso6BlEabzI+mrraawW/5dXXJwcrTMVCCEiLMkwe7B9MLbvBnnzC3874873OoXvLbyZLdXot//TBKqCxUr7lXtUBA2fnTsIGDbPbMMj9zwUPHHADmS8S1TCZDtprT9FQf+tiDZ3glu0DCiAjBxeGk=
Received: from BL0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:207:3c::45)
 by DM5PR02MB2682.namprd02.prod.outlook.com (2603:10b6:3:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Tue, 4 Sep
 2018 09:53:09 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0032.outlook.office365.com
 (2603:10b6:207:3c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.13 via Frontend
 Transport; Tue, 4 Sep 2018 09:53:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 09:53:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx81E-0000Sn-1U; Tue, 04 Sep 2018 02:53:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx818-0004wr-UC; Tue, 04 Sep 2018 02:53:02 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w849qtI9024759;
        Tue, 4 Sep 2018 02:52:56 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx811-0004tv-C4; Tue, 04 Sep 2018 02:52:55 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
Date:   Tue, 4 Sep 2018 15:22:34 +0530
Message-ID: <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(2980300002)(438002)(189003)(199004)(426003)(336012)(476003)(356003)(2201001)(2616005)(11346002)(106002)(446003)(126002)(106466001)(48376002)(486006)(186003)(9786002)(50466002)(77096007)(5660300001)(26005)(110136005)(81166006)(81156014)(217873002)(8676002)(16586007)(8936002)(305945005)(478600001)(76176011)(7696005)(51416003)(2906002)(36756003)(36386004)(63266004)(6346003)(50226002)(14444005)(47776003)(6666003)(316002)(921003)(107986001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2682;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT014;1:NWGR+/g1ZOFKvVPDRwK7GMz9IVbTPZILUo9iFQLww2jeDVpwAk8+0nEh9nHAdqY2hXCCajkJOLvf2Hl7XQnxFO2w+jaJkxUDyGwbGRx6JFpMhqancu1HBQ/k1H83b1Fk
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247ceae2-00c2-465e-2fce-08d6124c37f2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;3:coaJCCWwFNhezxbn6GGI4AB7lQaHw7DdNVwRRXToLwDjGX4fGAAZ2FJENN0kOvuUJgqRVS4bkTNCbIgI5uJ8TkV3aLYZypLZkb0ifkrQtMhYRo7pBMkcdYdtEEfxlnBytCXrCnci977/PZK329gsU937EntKMibCm5U8xIpk95x/a8lFv6WTsaQeJhdGv81UU5Qawp1H1+vXm4uCR9td99dbRgYV4uyil3q1mzLQgxq0XRdnlFIxGZyXahV4NjAJsKmA11BDx+B0u8aJwJv/nGzWw1aHNRVDpfBP/l/kakeNH1su5UerlcxBIxOPnybPUy4oDnhWMIrUwIZeNS4s6LP4N0muH/PlKZIzrW1a3NQ=;25:LOlp5rWJbIGq98geUw5fpIlWs0W3zCiIlq+DNzERHB/kAT6tSaEaH9Q45obk2tsBjBM7F2nxIdF6ElGD64mAmhUnzuQ5REXqOK7TYksMPzkf/CdTMk893ZuyLU2dVOYEqwl/w6TrIHaFqgaI51wIgxVbtljVN0J75EvPp+4yOG6ZgwHPQ5NArugawtNmMgszDR3iCpW3XQtJKskNrbap28P4+xYDJ5GNQ0/qbFTERe4cDYEblLUxdG8VClM5bL+/2pyeLxyMTvG7zZrtOxsxPmmhJbY0E8lSqzziQwzhTe3gh5/QqdQRIXVhNoWdId4iTf9wU7fjgfjZxQOAg13r/A==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;31:wz7fZ/RwuovsGL+1+SFxjcFvJXRImb9MVCbVQYG2Z8cJwe2oRfjdoqWJ8FR/rjkDF3EMPq7jOke+zWmz/wL29YmN5KxHX/JWydgifGlZ8rUzhPPYTJ7nRdUKFgRCrU+btfF1VGX4eI21BoRN27QC1YMeh/bUWzejQEMYYmPrBlgrnQWlaBoTqw+VXdfxmviSyckH/iILuJR3UA9+01qHokLb+ixRfvL0Goz2xxbPG/U=;20:ZOrDkXIgpzeoVODtympvFBbgKUxNcK3Ra9V6QzZOj80lLyWVM8HIVN7hUcPZ2WZ8wuLMmnWIlYpQ8CD61VL3moaP2baf5W2Kgr2JJ9ZkfIsbbpIxaugyJ5G8G8HLLZDvrtRtdyZ3SBXUuwF34KI6X8c444pcwpIwyhoSOHcW5aazlL8KH7Io2tKlTWcJgN/trOOu1urUpilZkhkXJnP5KEa23VMpEm/5vUEy6706nqoAr92wH9qafRy/497CdFHc1B8GuTatX3hBc5sgo01T46i//AVTqjqH0vSZBeqjn6vNuG5jkFnLw1nt/UBNU95JGLt51oH/aoFSvh9HljbYpKEPXO3PrbeJlBvssVS/8KUeh1BhHYJG9xy10tWAlYoGFuqkFsf2vl3Joh0fHft/S7EHnn9nsx6KY7RI/Nwzih7kUfCWcQeoZ9A1ulmD8PskkQnXNJBZcXJ+V0D6boYrYRCgvpaQG+iqfvjFrjNf04EDzqluUHcVtf+cycmGVVPL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB26828047B6ADC464677918A1C2030@DM5PR02MB2682.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:DM5PR02MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;4:5yHQZq7XuUnrSTW0Ee7L1gb+SfQAxQXydhRNkXOYCHtXSLIVaSzmvpMKD7sytVfdivPArjtMFt28XDuXXQEII50LM5Um1bOPD/4WhyGMOLL7T2mRFlzgTtmW7r4GYFKzzmRB7UVRZpxe7vJPt9dM8mH0Ay1Njwfsrvv0HUTBAxBbRazsbXQ3tIy6SxJ1pF4CisvEsKBiLS60b+qnvcLOKCSQDlkgUU+PGS3rd598VHPUktxgBcJvMb9KqYjkSQo1sa+plLgxJZxpXWJMOhGze1T11IJ5Kp8CcACplYcXZ60YqDOM/aKmaOVbPYz4u9+n
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2682;23:LQlWe9ZWn8mNO9Cf+6UF0NBZz0bUxNzaxNnYsmpnF?=
 =?us-ascii?Q?UwSMXu8s81pxyhSsWGsW+8NY1fwiSyrZ5TF9Og5AETfrq03rieXaYbXBWdQc?=
 =?us-ascii?Q?Mbl1Mvee7PTfIQumx3NfGjQv/TTRb9+rM+5zgx9GUTKtILxXokLbHZMEjEt3?=
 =?us-ascii?Q?mVWkSejikYbBh6pQvWuYkewZ8jD+O6zSibwmYxO04tcQixERp7slw4WxXzPl?=
 =?us-ascii?Q?wcMGSLHCue+VZe0PIFsRGu7MSeQNspfYShRvDpqCL9PFHO7cGQHu3L4LPcg0?=
 =?us-ascii?Q?Rp/2FZn4r9YMHKKZVSEvfXKL7iTTIAVgdi8Yj6YXaOM2I+JPoirxDFlDDysY?=
 =?us-ascii?Q?M2MFvn81x3xp+JTmJ6Bj+EvZBIB1Cbm1gVkgiD9/AieAo88ztTb2DG+YH1Pf?=
 =?us-ascii?Q?z0e29a9Xdq1RzprgWAazGMZU2fS3zrb0e8lOyXOlSRsWp+qRXIGR6gLS8y3R?=
 =?us-ascii?Q?7xB5lSSTijHJbTLrDA5wCGUNdIjXtZjjS8xbpjndMCAtU9zIBVM6DUB7BcvC?=
 =?us-ascii?Q?D4QvU1GBuWHsvG6E8gln2TKClxMGx/fNCZVjnhQbdIyedga8rvGjehHTq3TZ?=
 =?us-ascii?Q?q3TFPGKLDIkmlJM2DH9JSei9orOcsOllvytH9UP8uk86Syl7VwbkoOQad0FK?=
 =?us-ascii?Q?KfWOTq2wv2jBo4V06hZlvyyqhB845tANXdddTlCJreHjc8gdIWnMxQjTsqCD?=
 =?us-ascii?Q?/ojfTR1aQBDPEIs/lsmD92VVEXn+OqjEqQvyieYHQBvxEnCX+hGSVoqH1RtM?=
 =?us-ascii?Q?aPhJr4hkGUSWCn3kT6AUm1wVgr7AXup8ShFRbjf9fC2HzWmdqVgwJEmITXEH?=
 =?us-ascii?Q?UtpgOFL6FUanqrPnYJaXH3WBQlhoNnhAvF/lZG5b3nwtUd0UBmcW1jYP9igO?=
 =?us-ascii?Q?7T3k9cO35yTmt1qBZXP2jy91MWkSfj8NOrlw+VZUGrK4ZR1lWYbiB7pRcqlI?=
 =?us-ascii?Q?HcwBkyL8bYb6HbkN98d+4A+ps9Ou6tRje33oQeL9zEEiF/6S4AP0jCCPs7jL?=
 =?us-ascii?Q?c7XVbJI8o2TfoQ710+iTIygnytbElNCVJ0mKEkMfV/D56jzgZiN5P5U3LWWT?=
 =?us-ascii?Q?i7gOkA2LH9Y1Fl67N1ZzJQpjtqnIlRo5OnV4Pkxv2y0/612G8xLLoHXSp/f7?=
 =?us-ascii?Q?Rs5/VuVzpeMaeihj3XkDEx4DLI3Xm3fbUmg6SxSIDcC+pSVXt9EoalSvJ5Oe?=
 =?us-ascii?Q?rRrrqtxzmLOoj5vYitXpypLh6MzhZGQuGe7?=
X-Microsoft-Antispam-Message-Info: JNr/ynDWcX6d3sSxqpRrAs4J1ErhrhVJkmHyx4y/USFmQVdmJnXrdiGFCJb5HMsuyUBETLZ70LWsQsLP+uueMEBeDJ5kJfLOyj1xeOc4Su4F2C3z0VHnXMUXXXRS00gui07tWZ6Mco7KnV/5YnoKuhFcTVQirI2yGuEcfYBlR88Zett2KBIqZOAocuU66Ep+B7jvmG1VKMbc7tSVkwkXvGMp6HOjLC7UrtrNkoe12JIu/GX3AVU85zaJSyjKUMQcP+PY5Ngdx4eNus0FIZpMC/xcxNutiXsy/niEV9nwcBy7VsHY1og/XXQ7lfxD1/5DLfBGCM7SS+lAUvLPQkjUj/S//57+SuTfQ6nISQz9iJA=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;6:qPCqAaN4AJjA8sYvpe+Yx/+22ltycnj0LCJOppK3gldRWDuUHoP6Clw9xHQMp7FhDaZmAiH9hcgMQZI7VA43L5Do9ql3AANQbrDV7P8C2b6DCGHG4yzXzT2MHbu9VopZgJH7FtLiXooORpA9UsXUDfnv5jS1ZSQsd/fR6mn8gjz0MAonIpOQMj5q5r12GqwLjV4JNDpkTxenV3xi+a9f19u0zXDkfOlm7Gm5YusLlbYaPE5O6T+k0w2E6AyUo0dOC5g6iX3lwVOdAkWuRE8wHN483WQV3g7caf+qmRin5e+AXS5pcG1VomYI6xy90dB/dQeAsNaM/UMLgGkv89AAjPszXQ4HxQruIwCjf9qYhzPVuKwX5+tQO+wdaUJjdna8aQY+kgOyzF8ASRer5NdL3x3vCD0H8z2/TsFz0UJj3DwlZP9ClYgZgv27KlDNQ04oln5cXw7lqf1Etpd6qCxQwg==;5:a9H0AiLhOdmhlFi1Ow7DCPnsH0ZjdZdNnieia0Wncla1LP52VQSx6E/q9fZkqCSbt8wYDZui+PQJ8Ww3OfSJcZRnIqGpMKNcCRalPf599jsQ7hckP4VpVx4Cy5rOhUhkMRVJGL5ZCVwo4HYhz1IcjgYYvfp9+4bljigOHhz6biA=;7:dzEA/76Q/1laE/jlznDDGWGBM0/4PSiR2WJ6Tanv9RBTth0+fOTNUs61PBy8XNjZz8/US8aKI/Xb7mjH18ItFcYy64Pc5+GRV5tcVGS+zCejvAI53KbENbchuBRQRnB43uUTLqIyZYCh/ss39uh7m9I/oevywhjdWpz6pPBCtd0ngRSIX/tGYx1m6oXJpml8wYHDivPLZimxolA/Rw/HTsIfIKca1mvkFPgn4B77NxewzoVMPgHimiTjsIkshtQC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 09:53:08.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247ceae2-00c2-465e-2fce-08d6124c37f2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.

 drivers/nvmem/Kconfig        | 10 ++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/zynqmp_nvmem.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 54a3c29..2edb142 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -181,4 +181,14 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
+	help
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
+
+	  If sure, say yes. If unsure, say no.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 27e96a8..0b3abd7 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -39,4 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
 obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
+obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
 
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 0000000..e377900
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define SILICON_REVISION_MASK 0xF
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	int ret;
+	int idcode, version;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_chipid)
+		return -ENXIO;
+
+	ret = eemi_ops->get_chipid(&idcode, &version);
+	if (ret < 0)
+		return ret;
+
+	pr_debug("Read chipid val %x %x\n", idcode, version);
+	*(int *)val = version & SILICON_REVISION_MASK;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "zynqmp-nvmem",
+	.owner = THIS_MODULE,
+	.word_size = 1,
+	.size = 1,
+	.read_only = true,
+};
+
+static const struct of_device_id zynqmp_nvmem_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
+
+static int zynqmp_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+
+	econfig.dev = &pdev->dev;
+	econfig.reg_read = zynqmp_nvmem_read;
+
+	nvmem = nvmem_register(&econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int zynqmp_nvmem_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static struct platform_driver zynqmp_nvmem_driver = {
+	.probe = zynqmp_nvmem_probe,
+	.remove = zynqmp_nvmem_remove,
+	.driver = {
+		.name = "zynqmp-nvmem",
+		.of_match_table = zynqmp_nvmem_match,
+	},
+};
+
+module_platform_driver(zynqmp_nvmem_driver);
+
+MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("ZynqMP NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

