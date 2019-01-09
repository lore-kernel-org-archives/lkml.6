Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E50C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8449214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sUEdyLI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfAIJ0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:26:44 -0500
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:65088
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729148AbfAIJ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r02dMB8Ad/bUBYM6q9Iwg6faqxHE6AOFG5NC9nJSm8=;
 b=sUEdyLI/JHOrCJ42Kwmm6czhr96JVmbHpC1Zd6yidK/cxopI+4FB3pxoQ2N+RSrr8motTeCZJGjOsLUkAwLA1mzwAU9o2dv7z1OA8cv+W6EJD4xuD3/8euCRLnACfoZv8qKhwJcT16PNuepyAz//eJqqzgf1XzxSeHeje3iAx9o=
Received: from CY4PR02CA0047.namprd02.prod.outlook.com (2603:10b6:903:117::33)
 by SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:a4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Wed, 9 Jan
 2019 09:26:38 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR02CA0047.outlook.office365.com
 (2603:10b6:903:117::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Wed, 9 Jan 2019 09:26:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Wed, 9 Jan 2019 09:26:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51897 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA8B-0000Wa-7k; Wed, 09 Jan 2019 01:26:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA86-0000jl-4h; Wed, 09 Jan 2019 01:26:30 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x099QSMu028519;
        Wed, 9 Jan 2019 01:26:28 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ghA84-0000it-7b; Wed, 09 Jan 2019 01:26:28 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 5B57B800E9; Wed,  9 Jan 2019 14:56:27 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH V2 0/4] Add Xilinx's ZynqMP SHA3 driver support
Date:   Wed, 9 Jan 2019 14:56:21 +0530
Message-ID: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(199004)(189003)(217873002)(5660300001)(106466001)(966005)(81166006)(63266004)(36386004)(4326008)(486006)(106002)(47776003)(6306002)(305945005)(476003)(2616005)(2201001)(52956003)(126002)(44832011)(26005)(110136005)(8676002)(16586007)(81156014)(478600001)(8936002)(426003)(54906003)(356004)(48376002)(6666004)(103686004)(90966002)(107886003)(50226002)(2906002)(42186006)(316002)(336012)(6266002)(51416003)(36756003)(186003)(50466002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4334;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT003;1:QweDIi8VK+/DOpTF0lKq+DxvIsEfl+Aabvmix2X7tIw4AdIQXBgs+EUXcodoVimIbIP6hoiPVz8CHzIHmwBByN2fPKgwsl3OCdMV0I93spd0lqcL3eur3yaOEwx1vEii
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04e88838-d022-4dba-86fc-08d676148e19
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4334;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;3:lZeaVzA1iCbTFVxhhyWHDWruc0nWnC9ed9Xq1mfmDZJf4sWWzAJhN8MzJHL7wtpW0Bu3xrt3GQF7ZvX3lAHHOm0SVrm7Ig7wSsUMLfyBVZ5c+8gAkYqrn1xS3qj2ed/tv/F4XnbP6CduHrIWDhwxr25TjWVNuNVEfUzzggzdwARfu/4A0jkNBJZSnAn+mv7qhG5JQf/m5TRuqySssiFemOD7zBV42FVd3O7eItX/gA4LVdlaum3Yno1wc3WeWlskIkdHJA/oMwteDZq4MnCE4dZAokR3txY6ApzLE5RgobZ1Z1JabjGjWUzQwqXCxFNykjwSFn16BUBZ239JBiLAmdsasofPNM4HGcac8dJjdFg350hrA/NHCTJOHsHsdAPV;25:9kvr/Cwp5TJIvgWhR9QaJHd0/EMKwWApbOBmQJdDwT4tsBE5cw7FYiX4Oi7RwsXPI6mMR9cDkyU2Ch05wnBPQxBbkP3/p6wEe4PW/S+XSNJ9tlbp/93/50JqWh3bjyd3qQYXOYtWle+SmbGj4uOKoDffenr3swA+Emc9Blac+jq62TloT4jXgUG7jZjC5tVrDLtYRreE+tAGR5S03SQvFmL7lss5oQJXWgyO98/dLSEJpLDKLQ5dYYQDVCte5dY32losW9u+r1l9eIi2T9AhSauLfNfovBskYIoxc69c/6uNicjmf1HYYQtDy2gJte+wD08hs9Oa7D0AkW3sk9e1UA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4334:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;31:hK2cmaDStI8c+NNOohVgZEbODFxjwFnoz19R3vUok0MwneZyd7P3dQgVPQIhfbxxr3fJH78g7p9lPatwp0s5WBtnZd8zbIBNByJnpYWWSFLNG7/GPCf/NFBNdU5kKhbdmuws5DkSxCyqyUw9Ygj4uGYv824CYdMxjo2TsblS5/BzNyOQ2D+ZKZMVj2K2FC3X0O5Wu2f1bnCdA1tRl/uHGc6aDn/w8rQjagHQLOVdmNE=;20:Y0LvW7q0zxCoIpCQrezk3T2M1rMbef9XtNQHjoAR4el4rcUNPdRMpAh61so7uHOuH/JiWxQjcqr0kAKNML19lnl1EQZGCYOV1qq6BkpoPOy+4h85cjkXllD2O1RbqPZ0pECWIqZOAyncifhbO2a8Dmb4sM+iYvQNkpeHrJnSZl3Y8GiqXSuRRJq0H9a6nBx0CAyDb+oyxH6yE0ez3gL3t0HqvMvzlw4sxq/mQ7CGGgr6iRv5HE2XYIonuVtEc6VfH+CxCuNXF7B+mare2Q+3QBR6GgC18zl0iX3gxkhLLoHNixMcmP/HOWnkrlhnFWasRUvAepPqGUIT/xcgahbBQBZn1DdEmqiL0iv9h4+5FrOPpMd2k3+OJNESFSYlA/RElKZOfFsxdJ6uKHm39cDLplgUluCsgSvg1akJlDSOO33mMy9JUY663S9cGr9ZpyPuXEyAfeQyH62c6yEHjtz6qNUxfO+LJ/mTOJZO9YYJkb+ThsXTdCxSA9Jyh2DhdbU8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4334C506DDDBF7766AEA630CAF8B0@SN6PR02MB4334.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;4:/My/U7L6CMmAR0zvdv7wev7pZ7Uwspfwm4fi1O+6yZ1LEoP0tIfwcdCldaaVZgbX3xNFxsuiqBWdyksP/8wpmtV4zg+nbB1zKMh+ZAbSaZqUG4r/PmkD0/UfBKjyfyk9skybw+JaiIBwXh6IWo7Ly2LIRhn2pYLEcyZXlRKaqeVclHMZPNEPuJ1twgAGTBRwpvwDhvnJAjI54KP6YmFrulg0GOG5nzUhnlZGNCKobJwZy9tzca8Gu3NMxnHaJCjQ+Zt7c0HIHMmammSfhNg/iXG+s5MBhgmszGB1bPdyRXcL/dHA9QO/lKbKsj5iiX8i
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4334;23:k0ZcobpO3I0o1L06MVOqFFCFcpilGfnqfFcvaq6G0?=
 =?us-ascii?Q?oWpWJF2Xl+fPq0O/foUjtaMzInko2OmYgc6QQ1l9wfazoTtZ83NtMOnefjQD?=
 =?us-ascii?Q?sK5SJJPyxWHWA8fzk8ynYmnm/ELQkU2bbS/XAdCljRF8qz06zrUR5kSx062O?=
 =?us-ascii?Q?ac/juPeaoudmpR7yMdf/V45K2aXe5ijxbgGbHEQLnyVUkHZGaf0IN5Tu8XvT?=
 =?us-ascii?Q?YkajBURim1d9I/nbtzkH0Li5cYmb3Jd26z1ymVem43Dt3q5RT2QuacwSBA6E?=
 =?us-ascii?Q?kOTOliG63ExFneZlnnBnmEkCmEAALTWlRyiFk0Soe7NUXv9Oviq/G4Glb9yY?=
 =?us-ascii?Q?JazRHo2YbcbJsDNUb+wnuBAEqvomr5weUMiw+yqQJ6OPsBY5hjIvddl9mWH9?=
 =?us-ascii?Q?+GH53ghqqG8Jm/TGp6TCjIKlBCQoNQXljPVRNuye/FEeK6IddnBYk8zW6f/e?=
 =?us-ascii?Q?MQC6Ie/6VOoqZ/ORK2/VtVeQw8pMf6sop3FaCoj70raUjlO3esqoaI5wKiyA?=
 =?us-ascii?Q?6hyyUG5uqOSy7aIKqqlmLrrvt0U11ULnmNlgtjr/CPw41F+NltJTxyfK5WsQ?=
 =?us-ascii?Q?QC1tqNc75o4pRP4PbhoR77YudOvKVsJz7M3+gs79l50X/sKnXauqmi8sVBX2?=
 =?us-ascii?Q?NjS5lvRBsmo+slaqUAL0R/aJ8/k/YsU4R0yqHvPDoy9UMcvEBCPgp6+/s0Sx?=
 =?us-ascii?Q?T90Z+9Tt7ZTlEc9u3jvMh2GgX0abIBF+axEm9UzyhVu3KfcEUOlf5p/Hiw79?=
 =?us-ascii?Q?8zuhCYqHw2xFRAAzgypjhh8N6hM8soKl+yj6zUAx8kKZ4YL8kfvZ5Shz8eeF?=
 =?us-ascii?Q?nWMFUo4Y2m2Nwt6vawwuC1Z/EQ8++prAOBX7SRQZy1aK/+3Z6Ji+hiKK+U70?=
 =?us-ascii?Q?iNJdDPUWdidnk0pxB0H3sKa58r/wD/eMVRr28Qi9l42tvcF2H5ZUfgIT6BHY?=
 =?us-ascii?Q?qhXnQYry6WrhGpG4fb8VgWy3f8XsOuOs0ASWoU5BRM8vR4vtTn6zXBjAuBpX?=
 =?us-ascii?Q?ByCHWq3bcXzFB/zalue0Lz9mPe6CuwlY7nmW9i/T7n9LdSkGBZE01MVuVxr5?=
 =?us-ascii?Q?mAWaYeVL3CUV1yyajjoJQq9s4MhQUNp5bbDx+tPGRXb90ftMR1iyIONYOzDm?=
 =?us-ascii?Q?1k4B3dmQwy7FeVAte4Ll3udAiVZW45wPV/cz9JrKjQAKWhHV2XvqH0qD4Wvo?=
 =?us-ascii?Q?KRRNAF4JUgC2Gpirbnx+nxQ/moGmtL/2tfv?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: j2wSW6kiiO4kv3sc/MeHtpf+L01s2+nbTycQ1i/02ZN4M85PJLo7oN/bd+Zn+J7kQzj4zVm8Gt/kA4lIwEm05egE9FZoGUfGt7Pm2O/7WYOJ2DInxSATfFSeKXMKfJuddwolk5lvnARnm8EqES32K7o3oaDJ6Q/mwG+SQ8BD4Ai6mHkG7YDB1KErgYiLA3Ugm0csKje0DOKRhKogUXfYyo67O57rw8sCL5vtE+op5iUeEyGVM5PZGSkXZN9Y2fRM3qb50l/7eRp1VIpwdgmSwwlUKsxnpCyeey0m5PfRgWKIXJSM1UpPiHSH7iDzVwXq
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;6:Md5jwi71b3po7yJGzcDG+wmr81DVeJ4QbuJPS0ftBirpg0X4CNN60cj2TLYFvjvuSi08mtU+aTcKDQuTqEptTg0vYQ8Lw1QvIepcmSOjzzI8/ESPlUkjWG3/r74dfmXdAm4DDXAZGdfuZJNlHXq85OsWaKwMzTGyAVJSs1gD5LA9SU0SqjyuLdkwDihYZidQnzlbVoDa6TWsQMowjMzSp1HtvZsKN2fn6Qxhul0/kSXlDQ8LDalOyrr4YNyN9LJ46VqOdxXXINTDR2fGQI0Tp4djocDse6cS8RNSCVon1OZOlHHCJ/6wg0K4kBr8vDHPc4wBw457I5QqrktvjUNuORNjneqO/1n6VTMkQfCKd2D7GQNA6yLw9EbFTZ5Ecx9yJjoj6OMprkzk26T6RYIBXWgyfEy6UkWWav/LTbwWjN0fhrPq3YlcVNpQ6Ird8nPyK/Ycvu6Gyh2vzKVPwcJcfw==;5:9T5FqWNONpDpHdU1zr+xei938l7e9QIMutMIKSsAZ/JIsjqhaK5bQO5LhdsGHVpqxPQ06SWXPDmMb95JmyCQMqgZqsZFEgCGeEWo26Tk8TYWmJIs/kp3/CBuWAQ7kUmHo9v+gf9LUZllOGaD19TuisMMNjJM8e5BNilcqfzE7+HlsaeamExc45VhLE9W+JrXDSQuN9VSlMvuWOWbCUSRfg==;7:pjkidzZmBD960w75OVyn+xGSC03Lyn9IfGybGhT0MsE355pP7v1BWqzCH6VbYttUKdsu+ugniw3SsR0xz3FaYAHI7BjV6nL/RI1nc9ulCW5e+FaBt5cSvUTU2HvdcNT3VoJdC6t1W4D3yD0hZGSTPw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 09:26:35.9808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e88838-d022-4dba-86fc-08d676148e19
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for
- dt-binding docs for Xilinx ZynqMP SHA3 driver
- Adds communication layer support for sha_hash in zynqmp.c
- Adds Xilinx ZynqMP driver for SHA3 Algorithm
- Adds device tree node for ZynqMP SHA3 driver

V2 Changes :
- Added new patch (2/4) for sha_hash zynqmp API support
- Incorporated code review comments from v1 patch series. Discussed below:
        https://lore.kernel.org/patchwork/patch/1029433/

Kalyani Akula (4):
  dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
  firmware: xilinx: Add ZynqMP sha_hash API for SHA3 functionality
  crypto: Add Xilinx SHA3 driver
  ARM64: zynqmp: Add Xilinix SHA-384 node.

 .../devicetree/bindings/crypto/zynqmp-sha.txt      |   12 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |    4 +
 drivers/crypto/Kconfig                             |   10 +
 drivers/crypto/Makefile                            |    1 +
 drivers/crypto/zynqmp-sha.c                        |  305 ++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |   27 ++
 include/linux/firmware/xlnx-zynqmp.h               |    2 +
 7 files changed, 361 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/zynqmp-sha.txt
 create mode 100644 drivers/crypto/zynqmp-sha.c

