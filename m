Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E17BC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BB520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c2UiU+/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BB520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeFTRml (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:42:41 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:35235
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754412AbeFTRlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaAHKfwXtZnFlQtbsK6IoVKFXMniTR+0V+qp6W0Ql+M=;
 b=c2UiU+/ZJ6tKytqcKuM5bGs6Hlq2k3YYovQI4k94tj/3kZ5x+Idin54nj5Klx5UAYlaSF/s0KZo+1sdltN+udvWAmZO3kS9IHNsZxe016RGZvRUfXeHXCbUmyW2BBEypbN1Fpv2xNduDHI+EkPGNGSb9Sw3eiRavxGYSnKHofqI=
Received: from MWHPR02CA0008.namprd02.prod.outlook.com (2603:10b6:300:4b::18)
 by MWHPR02MB2655.namprd02.prod.outlook.com (2603:10b6:300:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 17:40:57 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR02CA0008.outlook.office365.com
 (2603:10b6:300:4b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52933 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6F-0006oe-RF; Wed, 20 Jun 2018 10:40:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6A-0004lu-O2; Wed, 20 Jun 2018 10:40:50 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHefev027133;
        Wed, 20 Jun 2018 10:40:41 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh61-0004hY-Kk; Wed, 20 Jun 2018 10:40:41 -0700
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
Subject: [PATCH v9 00/10] drivers: Introduce firmware dnd clock river for ZynqMP core
Date:   Wed, 20 Jun 2018 10:40:25 -0700
Message-ID: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(396003)(2980300002)(438002)(199004)(189003)(81156014)(81166006)(50226002)(47776003)(63266004)(36386004)(48376002)(50466002)(486006)(426003)(8936002)(126002)(476003)(2616005)(39060400002)(44832011)(36756003)(9786002)(8676002)(107886003)(6306002)(106466001)(4326008)(26005)(51416003)(966005)(72206003)(77096007)(7696005)(110136005)(2906002)(106002)(6666003)(336012)(7416002)(54906003)(2201001)(478600001)(316002)(186003)(5660300001)(16586007)(305945005)(356003)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2655;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT057;1:J2XhShXepJrMgOuG3hQAKCKm3kcMZBX34iHRZGfNv/l4wqDBsue7faNdWkfKunuDCG2as7N1eMmOLOBJx27XAKY7yrHqm6Lum0mKftd5nDnb2oNsgeLDePqVdDnvU0ud
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e14a727-4f70-43fe-e347-08d5d6d4fad3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2655;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;3:rcnTSu+yKl3AtuNEhzeIO1GZo3ONX0s978RwL/rSEeoFt1O3Xhon4bCztvgo6l39FezXQkDq/tO5A96GhJg/ePdLv0gInXs0ilNY28ha8EOHbym1/zpbZ4JZSlZS52bfVU64lIZEMAU/5B8VPzA/MFItveYYQoX6rPEd9/Xhp/jvAlx1E1CygwP4DMZLITmCNXx9xOwUkI0cAFOYkVlOXwFMj+cobxbp2poDyJVRSvjlFS1RPbE4YJa5rwL2e7/3MJNXqzjggHqwVrnL/A1UHiXyxYKhdGesi+nWRw11ITQilp0LRF4ZRCksyQqbYkYRydgU/33Sn9S95YQVRBWYak4NtJZTN8c9rlh4QcoA5wQ=;25:S5lWqyjPZv8gndTO8Fl21HyFtC1ZDXQsd7d49Ijy4Kk0Q1Hc/USZ94o6R442MLsb1yVuW/Wspc4g8esihTU6HttxSQ1nGdEso7tqv+Ix4Cy/A7VfFiQ7C/PmbGkGNcv/BLzOidL2yzYPQ7JF3W2vUSQ4DZwSSy3w566bR7+Yr5TCFu4eGsO1kBdFOjiLbz9LYwgmaa5tyF97Ugnjb0myoBFeVAnTbtDJK6L1VsvGHMg93EKq88B063zi+6ltN734wsMj/C+VrEoIFAkfEnSCfBbj2VVM541cRxjvOX0x02S7TxDAuCAQlybQLsuJS1NZNy5xeeacf5IrTvnSE6m13g==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2655:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;31:MQTufNRPhFBDJr1fopiUlDAl0i9T0A3RRcfqkNrOmbqwpbaiNP4cGdYLCar4aE5Y49s6tlolDX+78/kCKTQL+Dtc25LIRgxJdl35NRUmL5vvdc+5elDJNwLuj0BvIObdDLGJ+djsCHGA5NJibwg/rqCHqBVUcJCG9yaSeK6P7C+v5si+g2BrsLkgIP/zEYegU/XidiCudyJ36pIcxv7Lu0/khPjYD3jeNF8AT54NN5E=;20:2Ajn89P6Wm7/GWgw9MohDGk0oz2zD9qgqmr/1sd1aB8ut2j410dQNDDaLZ40Hc9cP5SNJIo0WsCkir5QRgPP5hjlqz0YJ1BV9R0tfL816HPIkojgb6OrruDnpQIORT7pUGG34cEhOJxFCmxI58q65MQuU2MHoyVbQW8m6c8sHlRcmxpMOTuWl1G9DhjndaDg8yHA3emQhwprKFVabJZuKT9TRkPmNGUaSLT8okL1nDC1nLsD8hKn3stiMmYkpPb6V61t+xCnqFa6ljTF2iXoHFoKchQD44LFGJAxlx02NeYZ63SXl7/CNqWNI7KfJK5OmsSfgf4bFPgBuIBTekPz1+22T0s0gD2HgvXtrAMp+NZu6HCbj7N4G8G423kBaUwWMRmKmxMBgsYR058vqYCoFDHjvVC/NEW3bccHA1Pgy3rkFLIUDTlBVltIRqr3YHukHAauqq+cfkHuSPaKo9VSzqP4iCL+PsKsADY57gymDKaYzbTR1ivCmbX8zWV9Qn24
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2655DC9D2F1F860129AFE20AB8770@MWHPR02MB2655.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2655;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2655;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;4:bgT3WY4U0inj9Y0CghUDPglHDxmsGMqEXsJXWXQpfeJDGjdWBCK84bt3ZNqLSvkP/2OHd1fAxW/kwZnl5Nw3MFcIK/3DFZo8xFEClvbW29oGHkqRG3n38VDpIZIdziKTCWqZoWclK5TveVp/IEX1z3a7ZTdhDvkjNjjSTfIGy2H/2cpqYJc0Lryl05ujgQJ+p7ZLWPjK9NAroOc4GC2xL6NxfNOBpb81syKJ7lEV2E4FGpJp2rBdir5kJSmA2+2kmXfj8s+ojFNSU14h9iiVjA==
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2655;23:A17B0RBJBUZdHszCi84bYiQD2lnSAddqG2OqQpuCA?=
 =?us-ascii?Q?IaFntvTXXReyFevY6NvS+69frMcnoWNYF1Fxk0qhdgiG2FRtg2y9D2Ee1R1V?=
 =?us-ascii?Q?E/dpO+4SnmTmf20o46VDlQCmvReRdMnG3Cp2emvOcp9O3SmPywv1a4lUbS5r?=
 =?us-ascii?Q?SwISsZbXACYm0iTgQZ9/V80WLhFgHyJz0zS0H6wCwYXl1q6o7u+pZIoBySRr?=
 =?us-ascii?Q?6C5Si6hXjp1fQFjFitzdbtIFvFq2N0GdvxZJg62pB1LH/i5LtmLPTvCgCrZC?=
 =?us-ascii?Q?AplT+1mCSt5a9aTxNek5PoGJmUXWSsUqb5/2wJlFR69DKdSDvwlDlI6aCvTW?=
 =?us-ascii?Q?tMp/alnL0VQu+DCaV0pCQN1MKikocDVZMfdfzj2MePKNiNMg09sVjo+SzveG?=
 =?us-ascii?Q?4GmaQ888jTr2kk7S5yOEMD0JcEtmOJ3mGzxotkNDNOPyjstfHYxTxXIyHvVK?=
 =?us-ascii?Q?ZedIkyBMdrmcxCFnD7JtxCaNj8l0uDMcFjW6U+FlHJqrGsVkxahboKXneIRo?=
 =?us-ascii?Q?47k1sgf9k/rF7H6KtIoq8zlXqHC+blxHmlKZMl9QL7zNhwNTav+6p8hS5Fjm?=
 =?us-ascii?Q?F5QMA5pdZ88C9rdK8AfRC1+ta0LaD1+349YLVR1Nxeoj+HivUTu55EvZETHa?=
 =?us-ascii?Q?9WNXkT2JJfgHCz4Ckjt6RGQck6OC8yYLeDXrHLZt3MmgAOjMPci6cil+oUS2?=
 =?us-ascii?Q?mHroB7H5kYEpo6pNT/D+BggCrGRnMyGgbD6Ta7Dm2FQi8pkRQ3O6nD8IU5R6?=
 =?us-ascii?Q?sxpq6TwPILkUtYS81L5HH6oj4ft5xareRQXsNmmCGI2XA/AZTNm8MBTmksOy?=
 =?us-ascii?Q?lDEqNO1I7998YAtiK2TSLMFoIhSe+So7gQ+jWmpMPDaU+Tyzj1/40jBFkbzL?=
 =?us-ascii?Q?e/E6jJigvHum9CebvSqhqMuwkfFybY7zFLbOhuR0TtTS8UXfidgRSQgFc2Dz?=
 =?us-ascii?Q?EOCyo1UyTJgsz/+PxOewCMzghPsCAwdMHYdltDxYic5yu7uRY6qhtjtZZ1UX?=
 =?us-ascii?Q?in58mY4Yc5YgLnlg+1wh5S+y8K1NNSCGWJdgxDmqlxutn4xWWBjnjLx8uaUz?=
 =?us-ascii?Q?KadUqmmOEqcYo1NPDZqncPN33ovSXWCpqBJI8n+D9SIkIQnhTdCV2CPxltik?=
 =?us-ascii?Q?6WftccR2E/tNHesqhRReR2sN64B2YJDOAxz/47ekJ/IR3KZlz26kD63WGkCy?=
 =?us-ascii?Q?FBjkkocbLhVR7EgBf7gkY7b4ZCluQLCiBy7cZNBHxJBwbG06pVBt3wkwptjK?=
 =?us-ascii?Q?m1ohlPjLPqbNnR4WkhmFEh8Nqleb/7ufQnGU4xE?=
X-Microsoft-Antispam-Message-Info: Hvd5xOpts/23A/b/AzU9zfBGz9S8buU6Zs/w0IaZqd/D10Z3kd/bTtmfqjPktJnuS8oH6ek/RcIlMyo9wDyOMJYCb6bK+vCwbZmArjGs9uwdUFHy7t10PtnwWr8CgEKUBEk4XC8VnIvo87AR15lcWdDB/Txqjb6LMMbd8uKt+7IMXP8/vS9RBPuFFM81IMAnNCXCd8vTU9IMWZ1Zc8fyJCl5weuvoqyuXSbyWnxiNzTARr/TehOk/HJlGZJ4slv90uIpAubkBNMkuti5bmEb2Z1gHtYdm3gVMIL/JIv+3sWfpAclbcDhBXoUdzQzUE15pgXYa1gVd0EyzqIMfqYW6Q==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;6:9Glpk6GuvFoK1s6yUGaiBl93eBKLHcHHGiju8w2aki2LkzZSvtzyqi8DeAVq3h3hXoNoODvq++f2IqEv3rlolo8lG/lAphCBtlDE8osj1m+/+cGHNvuzRPD0Dqk+YSH2TWrcuGJj5MksXXlXA1PGrMvpue3kSzURt1x+NeSFi87IwfJmPK6DoDMeRdkEWnokilvW18pNspQAF5cCt5LDDtP04OqPurN9dqAhwmKAsetru6Cmq8wdLprsXFD3fmCtSpW0c/3Xj9UuOvyi+GQYjqJjpU/Uzl5+woRWq3NDyd/j7TVDXPVfzB5lTw+dI48T7VGeSjSuZmaeNdkI/o9rsi6cT/J8Bl/WAdOJOzGfXZbGc0ebNB1bi3utqrzPXJmaQOLd7sHZlaLgi74ndDsZQYzuBJmdWydbH6l5VBaQJjOSdpkN26P4xryOtvtzpD572vP4yveHJGZyyTboViwbeg==;5:3ya4Ltf/zX6pVJRYlk87eu0M1zxDoBgiiBSg0yK2o8pbHybAayEO298ceUoHym+snhESZ6K66evkWUgVX3BYMILh94O96UkzSYZAZjSsjDI7HtnGms2tJiCwvWHWnRzV4BxfObPl1RBtzbv9OgaNSgJ+HBsInmpD+sSBoR0Sktw=;24:6OwNfljjMfaUkC/+bQMGPWx6NuoX9+jZE/AIOoHOzxtHwhYxUAwLnBmQV9jkD6lXr7znmHfvTNQlzD+iQXvdVYPQs9gOrjSbIzkoKf3fJaM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;7:YEVLDf6wZ5r/QAZ89aUqZA/G3lHcfDjrUc60tvMa36+0O6psN8uwIF6v77/XBA0UpgX34XtDY5/qzZivNrfLvw6F+9jQP6mLhfrdgD7tuTqhMhBzUzAZQWCfVHVGlO26WTMfGISdyTZynb3ulrYSyBPH/lW1Bt+k7Uz20kPzDQbug6WkWcHV+Ps++dciujLq73SCZZCdSvIAosTuqPZLjMLt0nB1bkoOnj92R9c71U0pMIs6CQyB8tkGkZOtDD0P
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:56.2862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e14a727-4f70-43fe-e347-08d5d6d4fad3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9:
 - Fixed minor typo comments

v8:
 - Corrected typo in clk Kconfig
 
v7:
 - Removed xilinx specific clock debugfs API support
 - Added reviewed-by tags for FW and clock bindings
 - Updated clock node name to clock-controller

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (9):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add zynqmp IOCTL API for device control
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for IOCTL API
  firmware: xilinx: Add debugfs for query data API
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  11 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 146 ++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 150 +++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  53 ++
 drivers/clk/zynqmp/clkc.c                          | 737 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 219 ++++++
 drivers/clk/zynqmp/pll.c                           | 345 ++++++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
 drivers/firmware/xilinx/zynqmp.c                   | 562 ++++++++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               | 115 ++++
 21 files changed, 2844 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4

