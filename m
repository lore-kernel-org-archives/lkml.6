Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F59ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57702064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Gk8JZzpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57702064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeGQUd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:57 -0400
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:22800
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729802AbeGQUdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0IgDLNWNv5gP6EXKCmjmOTwm0Q6U6uAi73B0G9dCkE=;
 b=Gk8JZzpPofmR7qqtwzEgO03lRdDEv4sbffwAdKeurJu8bPafbJm3Wu5mZ/Vw6OVAr4xQprSKG679gfMD+XwhfvZA2c8XQSoEOaZ3UjrZ5mTMcsRVPwVXTy2Cqs5t0A6I8qfAF7oHL5uuz5aPt99UnSpgofzaerthhEyHMq+QVlI=
Received: from MWHPR02CA0040.namprd02.prod.outlook.com (2603:10b6:301:60::29)
 by BLUPR0201MB1905.namprd02.prod.outlook.com (2a01:111:e400:58af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Tue, 17 Jul
 2018 19:59:35 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR02CA0040.outlook.office365.com
 (2603:10b6:301:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59443 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0003Uu-Tn; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-Mk; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-LO; Tue, 17 Jul 2018 12:59:25 -0700
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
Subject: [PATCH v10 08/10] firmware: xilinx: Add debugfs for query data API
Date:   Tue, 17 Jul 2018 12:59:05 -0700
Message-ID: <1531857547-16652-9-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(50466002)(5660300001)(305945005)(7416002)(36386004)(51416003)(36756003)(426003)(81156014)(81166006)(39060400002)(6666003)(2201001)(356003)(47776003)(48376002)(72206003)(8676002)(63266004)(4326008)(478600001)(7696005)(9786002)(336012)(16586007)(107886003)(316002)(2906002)(76176011)(14444005)(44832011)(126002)(11346002)(476003)(446003)(486006)(2616005)(106002)(50226002)(110136005)(186003)(26005)(8936002)(106466001)(54906003)(77096007)(921003)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1905;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT017;1:jkz24JmVnXw8fsiFDiGMGlHbl7n+3iC/LxWEG3QALH27Z1U9fuPyP7BQuvvo9eKWCFAAAH0axiJFgkI3tEtDqY38+BnVTENGf4I5wzYotsUtkpyWtfWLDQ6z2aHFjcaD
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c65d116a-7724-47f0-e883-08d5ec1fd132
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR0201MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1905;3:Zm8GG/rn48udlEnwaKsrBweJ9VZZjVrLLRoETR0CrKQraudQo+Tb1kj0aw8ddvmhmmSxLlvMWIAXa+NjSWHrLS3Kr0cioWHyc2ijJv9kOqnp2BH031gFLpJKALhRY5rRGOdOqKYxpedfxNtxwPp0pu4qXMaKupTVpwZlpPswwsW2zDbIOF3NtKsdLLRd9Hy3/GoB7BNUUx6Gp0JfkPcmJkAyUjG1p92KJNnhFIvU7Es+xBN1ARJPnddf+nfAsoW/9Ifimlog2qrK/jxRTgkInaPJWHgk1WVfc3UWeurtbhkep2nA7zTktFo0xPSrr9yDszKfFePjh4tYmwgefVOGv0gfBWBEBDwDg1rj0gSXnjU=;25:RaPdqpxu9NlY/CTXrRzUUzXXxs3MEzqEe1nKp9AUYOUbNKI7YRUkkYcgBCvRgoWkMlZ3rN2MF9NyYKSy8YK3S4xt9aWtv/WlDQ1OaxTVKjRSWGGc6cwfKqLthIVtTxmHDeR96mVwTy8iqXKt3PlUFVNOWs200liaSBLET9o4bNYO3ZcBJeelaEwJ5WYXPorFRrxe9/llDFd4cZfE8n7SxRKpWwFzMB0qLS70ctxeanIV5z1YZWfKpqnFf69qoBGzXCsFDe5jwIloweHPHbQD9shIVppcUZTiiMgCaaDPCyEv9tupP95zvjl1dAZX0sKdpTU2iLmW7ejL0o4o9wfCsQ==
X-MS-TrafficTypeDiagnostic: BLUPR0201MB1905:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1905;31:YmGwVoigRpSrz5nX1L3HFZpxxBD06kBzTFi6TzG9DjpqJ8cua6ZFlcuzXpEhBzJ2Xyiiyc9+2loL67iz8AwE1prfeA6lcNPdEBkHyoOOipcA0Zz0qTdP5HgIGcUgbeUGfkyXKQbYSTMY+asvoeE0nz7jErbQmHY65cKthhC6Bv2RCTqRMHodfZO8De07yrWW118UOmN7mZ4asHvrqgRxPxkFluF609ON00ifRXG8z8Q=;20:MsNt2easGG7J4xBkkE9Le9Wb4cEIVFMWNYp2DW9ssve4LoRyvBcfkwWS/EoePg6GgZN08ZJSHCewY7VVdP+/y2c8dVYVIvjtcYxMhgVFzw9BvYnSXjV6ZstGUtaru+OPZ5bNs5qiDH4xKv5KO1UQZXjCfsyNdwRFhM2yI7XsIqX+P4GaXkfrfvKG8/ZgfnQOK4nYMCZy1DXB/3gk4tlh+tu/hl5vTjUkE0nynMPtNEToe/Q4IZQA+ASyUgr8bexsqFKp/tVvaItA6+NqplTQKDTxDQA48a+KrnsdPdNmKUv/NKdawfXUxAY9LxZri1EOISwth1hxSAF0S2XGcUX9d83mtDspwhnH6Jp/sBQa2jyfI77u6uBZziyWq3/k6njpwvfixVwesQRIiN71pXtUjvoDuPRnjdivYKgZvSQgLQ+hSPJCgdPY/xyAMFgwW3lOm7aeBPmhdN3cQRRX73KvsggyXKqYCdDxlu0Hpsn/Jd2t1xfHL4QiY0RRY2JCJq3g
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR0201MB19058EA96C91D15D8DDF5E12B85C0@BLUPR0201MB1905.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR0201MB1905;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1905;4:bkAzEEmNzBKOlvt1fgUJwxDfdR8jxcmouPv5XPDG1dDawdH4WKqPWrvLOXiM/MDkrb/lzFJZVDRSX1Ez7oRzTxRmTUP5+//Jyk04tVw47Uye/6dBT0Fpk1IYsSs7HElbsG/wrJu5VTyWP3YQLlt4/rq3A8Bk/kBfz+jzYEilaDu34++OGkC3wla7UDJEnji7K1AlJFX7PWWsNvolBFaN8XbCc5N+i86MmN9bxInAZXt2B4e4euOcPEb78tgVnCNNBdEnuL8W/HoEzUQOuI4zgsbPwFriRarkpvgTWySeu9y8jHiR7Rw2uihYR/XGPemM
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0201MB1905;23:qbozkxb1S5NVlo0V3/3qXNSyRre536qDACGrG8+?=
 =?us-ascii?Q?JnnRqil82/Yz6pQ0i5OxyGpc6pV4r2ZpooNNwFKhvgDfOS7W2H61uiwaPuFF?=
 =?us-ascii?Q?rwLFoKegibpMmUeWs5DmWDQJztPtUdPpbvJ9yDCwtbTSsO5EXPlPCCeAeP0k?=
 =?us-ascii?Q?nwyAN4cBoC2exFV4bLpN/joVWjir/bjWm5CcSKr/G9VgM/hsF52YG3brCeg4?=
 =?us-ascii?Q?boxVS0hBAt1lsAVIcm/MxBvZvWEVtnS4tgtU5+Lytgfq5jH2nZeEeZeJrY/x?=
 =?us-ascii?Q?HtLf0z1y1zSpEAr0KDvVk4iDhxBtJJp7L1RibO5jRhbV8d9+3fr8Q8s5uNpq?=
 =?us-ascii?Q?WhL86/iSQMhOrkb04BQonQlv6U1gY8wwExtOS8w3sfqGQ4VuOJvStHCXmJAt?=
 =?us-ascii?Q?GepsVexFkpHAqeHo2urMOfvSmyWfpTottUtzb7caJzn/3KXmZcWh6ueuBIZ5?=
 =?us-ascii?Q?3WF71y1+3YGpa5dRF6+LrZvJNaZOrEMRYKRnpQ6v/I9+wtaE6EgSqjYciEXX?=
 =?us-ascii?Q?UwfBCKBveDz7tVzpOCulCFoO3FG/MwZ6YqcLFm8nj40Ou6IUd6/c6W7jWLTn?=
 =?us-ascii?Q?7jgJGeSJ6pWxCw8fTu2a5t8uXoFp3DppoY/5bpP6P1DK4JKG3pFoMjq/4/ir?=
 =?us-ascii?Q?ORS9pv96oQKfOLZkoNEA+I47lfJpQTR3TI8nEGqVpQtdTOotGNMVWK0/+C4d?=
 =?us-ascii?Q?4XXCB3HXxzhnY1na2NUKJzvLizpM2sVeMa84Ouf8SOezQHjXTrQ+OF6RdXsj?=
 =?us-ascii?Q?u6dCrhXbLyDNDfr48B4CJZWfb5M3zQaUZCA/7zIX/NgpRyVUm1aukXsZWuEl?=
 =?us-ascii?Q?LnPEI05xco8aUbIfImKph6WavlpvQQKJjHI3KJLTcJ8ifYtgb/kAh9yMat+f?=
 =?us-ascii?Q?KjmcEncyixIm2C3zSA4vseXp1aJuqZ1w13Ze05bXQSY1wN62NDu1zc4prYWn?=
 =?us-ascii?Q?Df/Kua2dHNWtfj9KGQ38ZWvDxUaFT/1F/VpwDICU8PD7Z8khr3yJVJHfBSbc?=
 =?us-ascii?Q?esN56yAD6NXyWXfbRbGlH673j17lUFl3sQgf5W/uFAcW5fIEaRWJTXH/Gd0Y?=
 =?us-ascii?Q?D83K6zE8CvCb63f42krYwoJrJj5Ox/0RanN++HDNGfAQ+qxwjXyE1tIXl6f+?=
 =?us-ascii?Q?NynNjXEn7jJamhIOWHCDu889UrIgvzITY+HbNmyS/sp0jB/WeO9JEFFGdABm?=
 =?us-ascii?Q?ob5Nz9nSMDyr2To57atErRaAfW8l16xnKUiXc0YWfrqOIiVy+fsHuJDOtpXZ?=
 =?us-ascii?Q?2e9FyXftPQt0V6pefZcAdaaPaE4lP4THVf+X6WI4kSa9sXMssTOKnkdamzve?=
 =?us-ascii?Q?rrg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8Qe6T9DlSqxGBkIOb8xtFB27ctqGIx5A1KdwJ/p79YWZZjvcT+FUrXE/Z55WtyOXKX1Qgf8R2CDq795XaOm9YHg7i/2t+FIpte5GoZLxeSihg+wh5wn9tdjvsnUMQFr8NWa3b0rgMaWnrE9VR3ld1L6YVJYfuQ82WlGDlXcHaOwwFytkhK+0Zxam5OCtAuU8MDb7iTbIxdl6UwPG+B+xfA8nanSX3884WbZ89Amf7ssYTKibo5VCrBjZEAMcudtdT/wV4nk0/HjtSTZ5szMoJNgjuBuwWE0TbG5fzZA3Am660lEt2SsNpW1cU0q/hmo7EsXAQRntKoMS3zUcwrL4e97VPfAAn9MPaq/NS/WlenM=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1905;6:OwbmYuxK8Nfd9sHYKa8YhUEsmD41/T28cqWRBGlg3IjtquEyzr6yreeHz3IWU/z07hpYBCZCZ+EUzThVtyRhmH6Xf4q8aRzJnCsLTYGAV/LDU0Of0RyxVCJwXdkg+5rrkszgaLOIAscv5VxGXRmKNikNugLl8JjpPOKwfUBz9PFB3zYzx+JcmNzbpeHI9Z0XB3rwWHAzr5UOjCK/jlRIQlIESjg0fo5zNJWYsNnVpsYNYpXZJJcx4q7rWQrorm1gBgGV3RCKLZbNMg62FmPYlup2KjkJgoOsl3OSQfsgNSLnXFPKg9I4RKbLsf8zbeLcc6a/4jHxxdu/eSe1BM/MPoJsdXecex7Lia3njNLUYI8FHTnGVqZxXKRunyg7xJIZYol9tZ+ozxwYr+rWOYT+9FSHR360asij6+rrscwQmACae8srZFiDd/P5kgz7HuBIhd0AMC/2e8cKPpwfHdj8Mg==;5:FGAMhas19ndQA7vVaP+UUAU9CRL8YuV2UsiQ+zC11v6aElHaUUdvJovkeITBBacmKI3IbavbWni9ekJv9YgXXRSiJkenH2jfa3clv7LKtx9lU2tiSHzJ/IzwzGO8aXvHC7DNtHniOymAwVC5oeEpgVuwp1QnGq6ZCTAA8kUHCoY=;24:otpSAKIhn7GpFpj1I6/IGEjlJGKo+xTPDBqPH3rqGmgZ2WsXjU9ygoA/fvLL6tRK44GowExtvcriKxuSUv9+7e2ndsESHJlLqhHtjJyjMvo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1905;7:8KlNG9FROwrPr4QpKN2R6DBR/wCrvDFA55JkCuJehpka2Sd6DdWVd1YVKtUIT4rcpiEZ4bn8nNTjN7lg7wHKQ0IpsNTprt7e8LQrgxBI/8pgabfe8pqsMCCCstWnMVB9sHoa3mDfbAYva5jh38bKTwPfpvdn9UGpfjb1RcQkKnuXO/17oD5bgTEZz4VpCRtl2OjNpYbJ+2OPaHOU8t4+c865MnsJ9AXH9K8AecxLwoI3XcWy35+HOfxvJbm8ND4R
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:33.5083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65d116a-7724-47f0-e883-08d5ec1fd132
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1905
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

