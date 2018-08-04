Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E66C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B604D217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="K5jfyYNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B604D217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeHDL0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:26:36 -0400
Received: from mail-eopbgr730040.outbound.protection.outlook.com ([40.107.73.40]:53280
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbeHDL0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9qoUpOg9ZO9st+BmqgvKZw1O9Rbwkwlel6/FXDGjqE=;
 b=K5jfyYNTLBtRl3VlyP05vREu2F4nmGer8dgfzOvQX4XmFT+uByNTlJHucXR93dTQkS1WBAug6k7Kv9FRYJMAQTZUImUXQzHGep+r198ByMklNSbKmXVH6Pd/Vbu6BhQttnG6Bf5f80OfEZ+Tr/mm4f/+S22r5hE/sNTU/ZuBl2Q=
Received: from BN6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:405:60::17)
 by SN6PR02MB4335.namprd02.prod.outlook.com (2603:10b6:805:a4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 09:26:15 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN6PR02CA0076.outlook.office365.com
 (2603:10b6:405:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Sat, 4 Aug 2018 09:26:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Sat, 4 Aug 2018 09:26:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46158 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flspC-0000SY-BM; Sat, 04 Aug 2018 02:26:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flsp7-0002RS-A3; Sat, 04 Aug 2018 02:26:09 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w749Q5gV014114;
        Sat, 4 Aug 2018 02:26:05 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flsp2-0002OT-A5; Sat, 04 Aug 2018 02:26:04 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 91B0112167D; Sat,  4 Aug 2018 14:56:03 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 4/4] arm64: zynqmp: Add DDRC node
Date:   Sat, 4 Aug 2018 14:55:35 +0530
Message-ID: <1533374735-16662-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(90966002)(107886003)(6666003)(36756003)(36386004)(14444005)(8936002)(126002)(476003)(2616005)(486006)(186003)(5660300001)(51416003)(81156014)(478600001)(11346002)(52956003)(81166006)(6266002)(4326008)(76176011)(7416002)(2201001)(26005)(6346003)(103686004)(575784001)(8676002)(110136005)(63266004)(54906003)(356003)(305945005)(48376002)(50466002)(2906002)(47776003)(50226002)(72206003)(106002)(426003)(44832011)(446003)(316002)(42186006)(336012)(106466001)(16586007)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4335;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT008;1:FYES33487xEe2urdei+WnTiPqqG0ZxA1Dm6TBzUwxob/tVXH2SRMRWsq6sMaoN6SMGKUV+1IMzBLuKdRAeYrREaXEwArldclJD/KEInwVEVBO5DBbaOY1JAG2nuy+duL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 542193e8-b4f3-4228-bb14-08d5f9ec5383
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;3:SB3GqXprsRtPsYph9l1P7ibPLcyAvEt6gugQdm7KtXU+Ypbu/dS44O1oV12XOvNlYHSFFwUb92wmsNZVh2+XDgGHWx5qv2L+TXXdEeo/6Plq8UWLz5HifHhDabJy+Bi/ZXbL7y20ahcBfUpfLByau5rcS2aPl2gexXrBebJsfg1+/jaWPo4ml4XmO67f0UZOKlmgULrHM65eID9M1a8k2LRT4mTbCPYpj/oTkeVTauJti4ShRKBwXTh7vMRdhWHRAWtj6DSMN1xKp9wTFJ2ix+s6h7mDGexWiEFNBAjuJZPSEgNvqDZFXFrd535qvlrTPvCL6mDV6choO0zo8V473MOCI2U2pZJRuX2/7ao/RNU=;25:Od6oMNZ07uDM3xlW8wcX6KUdi40HPKYMmbwY8HgGwRg4zZczGaufCU0Ca7VWzqzGZxXDiTRQicQRwL/2Kf87Kb8baMUdC6PtT3cKPHG9ICQOzGj2vmXVoFQZwx7mGKC850R3vGnvXwY/u453NeEQajnJj2fOEwxw8HVwRE5SnoQzQE4Hbow8KPksik06MIQSyZs9JEzLHBlCLUaXAEYssC/KyRDRLSrVGK+uoxbjZzl2bi/VKR7FDImHTppZYk1wZbrqtzysx14AbocJqrmFSNN4OIVmRL+/ptAFS6AXpvk4YyNwPbIaPEzcSZ+lmroujmG8LsLDYBNvXTbApuekHg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4335:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;31:u8stEPGeDEYBEh68dC5cXFIlErv/n4WE5TeEVirFgN1mDqx0UzAefky/xp9wgaTNqzC7H3ws045tf4As/PnQo9UUyL86eFc6kgbq6QeZPIkYQdkqsprpS8jc5ru7p+u7hg9iMIADu3rnaFXefwNmQZiBqT+vUqogsy2GRkhoAh/oErVLJ1tb7/Z5zkMNFhgCkgVeJguTLvSOe3MBgRoCbC6YjZYnvf63BEfmV8SV57Y=;20:9MaYB0LbdHbf5/kjT5ivnmwj+zOmqmDS8qP+aJD/CkG3n5R/BnUL7tWQ8rVy8tvRCaITwAj+oHrKv5tT125VRQdjaexSOu8ub1JCp496q/FAP1xTlFzM5vpxbm6cKDd1EaqWoJrz9ndC6AD74JcBIGG5e6mcN1PAmXmeLBmiwhoF9RX8vKV5CMNVFR/2w8vioE3ZqDWEskmcA5v11in7gCfamJQ3jxHy4ImVKD7+5lTLU6PuLxlptRvClcUiWVvs728cPaEgjIn2FZRYl0pQGOzBbQw5FYKMCqe5IOkd1StoWMeY5H79EviueKYJsLZocxI36AAzzybhM5RvVj1K9CQZfsqtN21GNDk0VIA8O9fowvmw+OxGuxHvVjWSNVJAsJC9H16UnpQYnahmkOBFRt/7xN3nU746QluxRkcuqgjZwozYhqfgrp7LbWksFc2XyYXWPvFXwBF8HUIywTOpWdjmTTWrsCz7DoyhWpgReuw1hPyrNAeDY35nLK+quQbH
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4335FB91BB40431A02E450B0C1220@SN6PR02MB4335.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4335;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;4:kPntK41f3i+tt+fNPNBS0h4yJYQoFZAG7GYKH5dyGhi0vg1H71kCC6NIYOjWOsoU4uey0D33b9LEI5SJfbZWv3nJaOltOrhhD/QFx0gbpKhM+9SGgpkO5HpIlvHar48czH9DAQGPez2I9IT2c8lP+K4bsx0rUU3D7aVD2aIbUDVeXDf6yu9YjwnEK5VmFbDLUpZTnm/eQphIYDxUWNWtXM6YzHeA0LJKVFXcD9llDFsNNH+BQpr/GcdPqOF60/GTpGlZd1A8mlfQv7CcmeXyM+JRAab90cpE3MRhNIKig23soc9w5I2eYlYxS2T4qY9x
X-Forefront-PRVS: 0754F7E325
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4335;23:EuMTCTNmPVaKObn028MTU+Psl1//9tWsCcUYwTvmj?=
 =?us-ascii?Q?zS/wI/iQ8fcwd83Bio6Tn9iXghx5Yd+xpvpAtgiKzQCH8W4qJ0WjPAPfFMfV?=
 =?us-ascii?Q?UZb731TR4GfyvrFEGdcyBZdfarmrAVMsJucDYkKiGNUBbZUHTx8oAFXDQ9Dh?=
 =?us-ascii?Q?EwP3EYTxPq78E/pb+SaJLfrZe2nPu4T3+rRrr2kkwCiJFbRv3yrV9d1p8V6B?=
 =?us-ascii?Q?4VAU6yJ+0Tw/S2xhHO/X+5XbMDaNdIz/xfsVw/mQYLDABjhMTK8SCVuoV80v?=
 =?us-ascii?Q?B840ighBRsuNHEYp9NtKmRdG5fma9UXKgMnu1f60wJO4qyOU47tOa//CwN0H?=
 =?us-ascii?Q?UILMwx8DDGRXTgOKlmgC0//sAj2SFEGZQ4u/HnXq6T6sSQubr7zwfsiNhRWt?=
 =?us-ascii?Q?TBrLS9KJMB8ORk7VJNnhDOSnLnD12LCbihU9dvRVIpNbULcOxH1xs7VIPTSg?=
 =?us-ascii?Q?vVm8+DqHPWxxV2Ppz/1CUUWGkTTtRbAhZdsX6seOgzQWBsMt+DJG3LsJbmX8?=
 =?us-ascii?Q?aMINyilAs/ae/WM0TSiJbg+y2114tm/nYI/khcsAtddMUFtxeXnXdpqikHCM?=
 =?us-ascii?Q?V47gKMyQRf29dWYmAL7yl3zGWqTXoEXksIK2ivL99ohPIXSvgB04I9MpzcRk?=
 =?us-ascii?Q?AFU+ZtKzLUQZBT6rTYlKvt+JkbQgFPn++/+8ezVQj5WTW12/A1VaVAhx95V5?=
 =?us-ascii?Q?7NEZRuvJGCeyCxA1dGJ17bQAtb+ZZsftQfxC9UZzPg4h3udk8fPp3/kYT2qW?=
 =?us-ascii?Q?iw5vFmJHIstY4cHo/fPOfr+YwFIpxhuT86fAT30YfBeLtzXOYrq+zvry11/V?=
 =?us-ascii?Q?Ko52zjMHYQQrJKhQWVUlO6VbUcrT8MyCHmHGzdt88BuMb1msdFGeYPRsRz4A?=
 =?us-ascii?Q?IrqNwAir80HoeiViraINuwCLaUvkQznWy8Gn8wt3Y56F/RyRR0om4zUkXn5A?=
 =?us-ascii?Q?9TIkwbvKfRQSU0dY1UEufnx6YaIM2+U2x1PYl1Oiu1XwXRBD7ajDs6iJolqx?=
 =?us-ascii?Q?UfXN3rQDzOmpc8CmJ3JS0bLnI9Cy//5+jTTBKanLPuD3ys6JtJeuxF87Yhon?=
 =?us-ascii?Q?wzJhelShVEVdAzh+qnk/YIlcN3u7QEz5KhvAexKO8V/NXXI8YHLxSt+m6GQL?=
 =?us-ascii?Q?u2GmZzMl9RtnPyo61u9ILuOoSkUdjoxl/z18wXnne3QGReQrVgkZpJ8Ezgp+?=
 =?us-ascii?Q?39zoz9VI07U+Ipp1Egdtbm/m0KPymtDuwu68VBNr7QTlgzb0tSGB+xjXnN41?=
 =?us-ascii?Q?kQP9WN4kurgu+NHBseNjMmK1PuJypv1AZreWdFGdjBNWtxdPLbQKB7h7H1aP?=
 =?us-ascii?Q?haGaDL2bHSLozDINI5IyZIYQXWCOW0Vjke/7jCZzEG/kwNXeXCXEIVQWLfX/?=
 =?us-ascii?Q?GazRw=3D=3D?=
X-Microsoft-Antispam-Message-Info: x+7bQlEy43RVyMpx+4pKiNxoMW/eJUnSsjsxQP4IRKQCf91XW2x2WWXpSA/W7UP+k+F+6li+zQa5bI4dz3sKXxLCruiOajnUCSZTYbM9CNhzk/yicUYD3dpHkrpwiz1NercsFB0lkJyFzHzoXWmxDGCWggXPNxu7mJG+dH0CVNPMCsEFSUEJucNbh+bhJd11LLlt21OIG0/mx+FaaiBejdgyPV6z2Y+z+ofYmUiTePZ4+2B/y6MlU1dsHRcklOpiPS45o9UbCfpZi5rhJAFytYaII06MfRFvwodbabblhAgPSNAjAegdk0p8qp6UOWcMbhiDMXDfUQocnu25DR/8D+3Ce23f7KDWOm8qEsAT0Ok=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;6:tsXLQGqFafk+1qUKevPcftzQqi/fNL/ybrXa1jeNe/tAl9SM/2zkEBPNfzsBTVQmSstiysM9aT0XULPeAH34jAyvEqfc76yz6iSNF1+c59aBBtlcKBxWB/OtviSSeXcWAKZnaur4ksI1kj4XNyFLB+SfyDhPXHRJOy2CMD8vvsh8kCu/XF1GSYcuUJiougPyFhKpCZgOYpQCeoZU+INAwLoAIDyPEmqrngLDVLck1y3xQsBgQqza5LRrxLb3TduEEIOEwUiJFFe9SFDfbuRz7FS1yBierd7XoZGd/cAM/jHXRSitfBWfwrm7X3z4andXsHmhkbodYd0utGFOllfufmpbKjeM92I4onxFt3nCe/MDHBZcRf2vuEo5nurKRA39ZJ+YKoJzfykcfP/6294ie/m9nC059thN2CJywvhhHhK3mpsUqDYzO+f+g423w1RbFLenUEkqNsapCm9YlVUOmg==;5:M5zEed30g9vE8A3QITrGM8qmPg6Pt5oftvnansHhx61l5TjL1rFfdJ3OiTZxFZIeVAipaYNE66FXA1N8bQ+pSgq+vNMVfRI4u7LqyUFZrc+BOuxZZ6/a5R8u5C0VxaOgHeg/+SFZUNxlKJI/zYpClIXiI+aiMxELO5wLp9vHOPA=;7:3IDXVmCnxB/HGqF/HZ9ToorTnCxvRITOVEQP/T+yjt+VWKFPPDdKzYTcK35PE/aVN/sffLzL+rjAcHNglFWVEzr2XteY9Pbi1SiLrjbVHvJjfzS024cBkj7FoScRfDUsM4+1LKigqD/vMtHXA/4NOmvzl6sdOl9NZKK7MOPaJHMCkJwMaFbzQZAARIc/FN724pflK3gCiGqeDiDd958guQezWqS6O33tqGPfg3CcS/6HZXzHATiY7RXEQV7VN0OC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 09:26:14.9658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 542193e8-b4f3-4228-bb14-08d5f9ec5383
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ddrc memory controller node in dts. The size mentioned
in dts is 0x30000, because we need to access DDR_QOS INTR registers
located at fd090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a091e6f..7d6a3cf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1

