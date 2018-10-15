Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31C1C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718952087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nQ9Hmxxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718952087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJONOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:14:23 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:15971
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeJONOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrydX7w/R43HiIp1197Q+8fFrak3sf53/5bz4CiF1oI=;
 b=nQ9HmxxtCkPad3eycFPWwrqLmDNGqFw4JzwQfrS/55nmgVpuEi9jjD4CB7AZ7hzsySWfQPBV+N0pXRnG+l/S0Qr8930IrGqi/5a9KMnVqNTLh+WSG57qU7Svor0A/PtohKbf9lORiBf4h1SrnADuh2dIm3zsTAdb4BqSWKFok9E=
Received: from MWHPR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:301:73::29) by SN4PR0201MB3520.namprd02.prod.outlook.com
 (2603:10b6:803:44::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Mon, 15 Oct
 2018 05:30:33 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR0201CA0052.outlook.office365.com
 (2603:10b6:301:73::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.22 via Frontend
 Transport; Mon, 15 Oct 2018 05:30:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 05:30:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60011 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSV-0006bR-Ft; Sun, 14 Oct 2018 22:30:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSQ-0002eW-9A; Sun, 14 Oct 2018 22:30:22 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gBvS6-0001hY-6B; Sun, 14 Oct 2018 22:30:02 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 927F4121624; Mon, 15 Oct 2018 11:00:00 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <olof@lixom.net>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v9 3/6] edac: synopsys: Add macro defines for ZynqMP DDRC
Date:   Mon, 15 Oct 2018 10:59:45 +0530
Message-ID: <1539581388-23963-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(356004)(106466001)(47776003)(52956003)(90966002)(6266002)(486006)(126002)(110136005)(54906003)(186003)(26005)(476003)(2201001)(2616005)(6666004)(51416003)(11346002)(446003)(76176011)(103686004)(44832011)(81156014)(81166006)(2906002)(8676002)(478600001)(336012)(36386004)(72206003)(36756003)(106002)(305945005)(4326008)(7416002)(16586007)(316002)(63266004)(426003)(42186006)(50226002)(5660300001)(48376002)(8936002)(50466002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3520;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT055;1:Q6e0ICXsPXcTwQ6aaOm2CgHe/IpDGG0UOCOG4QX0FSmvIyZ2BrjRURe5zEENU98qNh7zILSjKyxZNo0jT3oGCFl6QsxlGQHdbE6Tr/P6g1hPKXdSF+bjP7w2rBKBj0ns
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f083031d-f547-4322-7e5a-08d6325f538c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;3:aDqNDZaS3Zfn+i2ysaLaLHIqRUoqMc3nNTivW6mIuggvBEn2f5UgpS9q3e6KZZXY6UAUNiADloRltpIBUjfqYwfbNafIpPdtSlGni2LGRCN0AcY5cpfWSYC9EF+cZNpPixP2XNgw6fB81tLsq1/GeK4zMGUQT2Cjcb85JqYAZxDOPYElDTMPq1+/bYI8ZOEyY4VpmPtLO3JGG7hbXxrEdgyTqdUIh6nptXe7/m07dvuYYR4UAavb89XXlmKQDpBpEAImJzjnoVMYyeVaunwXThzpJrhAcyXcZIYxiN/XTYynf0RH5HTqpx0mOYLlpnXikOZAPZAClge64zEu6xtyMJaWyNGXCT4pOKsQrhPyjdw=;25:4L7OpQAgu1AgcJGcER9WwTLmbesbLWSgs1YOEc7dujef7NDvrmrEHGBK7zwpsZXNf3lB44Tm6TEOTF71D1ZFmp3c2TLH+I1U6Heur9vCMYDyXXGMY2+BxH1aY/P/PpWrwp15d9f68eFMw3myUrw7CGvd/LrXuFFdz6OTrN7EbTbgL5Sam6acghR86J6jhYLxa4q6iTWe3Fhv/dTYBndLs1vZqrlhlaFGjNDeHA4zuDpR1Vwc4qRNMui0s9eeDsQOaKgqUm6tdOovD92s+umE7Eqx24PO7JgBzIuW8HZWO2HGn7SEpKz2iqUi8XGP53dMWHKpJkobameno0Ylzjl8Jg==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3520:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;31:q97+GLZWq5rRA/IWG1FxwNlPrePPq8he5a4xE1+ZD8nrqoE3ERK7ZKGxvfLLx+kUiagOZNbuhmBKMYEJibAEnqoJiXcGeGVDPUNXF5Rx9lZSqG8tCgwPckQlwqAKqRs0AwUN6kBmc1Ti6oLDnc/5JgkjJUaxuwFuBKJvNztXhmztdIm+2rStZjAuk6SujM0v5RD7Uf3gYwroFGFPzGJmPt5yx2455QzuiYAaGhKkkQk=;20:y+c3B4kX2r9dpgtSysqrN+0ga+jfpGe0mwiL0yGHMCK3yg+A1BIA35Zpulutyc4FXNx5iHzZIwcF9Yvk4S7PdAakx1Pg4w7dsNS8ElQj2l0B/BqNQcIFturd/EQR/SvhENp8RopF3WYrpbXecQ5d+qH1GBZPv/02k4ndYtvUexOIT40lw9DHEfitTbGuyHcbckgEQ4k1vAWrzV9D0pVpZR7z3Dl/N5U38+DITRp987tVGZE9rGg1VbVm6xmDmyGClGpryLe9jDDeU56Kj5NJT96gYah0r8CYOOHngHUOvIzOah0wu5qMO7dxwkallY58r1D0oy44H07Fd1gpxd7Qe3fK1x96PMEXSKCIjbGFkEzDFKip+pK4PY8e7GV+dVdhGeAChZaxv7DepDP8DN6KpxkXkgNGuvBYscz81wpVl9A9lapuefTqAoWnPGpyx/7lqHhGGPA4I3qWLrz6qJVWsB1ATH1JL9e43yF14cBVUSQj8juzfh7sBvGNSyjd81YC
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35205BDF9838F4EEC29BF495C1FD0@SN4PR0201MB3520.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:SN4PR0201MB3520;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;4:7ULhy1RAMEWMsd4blqyC7tVs8fNCg0SBbP5xDzpGVu7hWXPRTKt5wifW9++1iy9X2tjDXUtqwE8pdDpGp8ixW0fOyPGnHrGNMPqP+q9ZSNjjH7ytK0vBQfsgcGF/pR9V8hkVydYDqkl8Mb7ZN2B9BqVvnqXKPr8MfxZQr3QZE5KtG5HSXdO7oC2h6MbbamCedyhq+tjhjP7Ibok4TXiyuuswua1Kr+xuukQLJRmpqnkI4OluOTWZn+p/Edf5P5dIP3jk/GMEtspzQl6osrfYNZ9hgqlnORdroIOugf6PX+wxhZ8CrFlAinQAgyJvsGJBYMsxA2LIXTqqaSpc4COJjPaX3c9QWgPT6QRwq0nvrUs=
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3520;23:63j+cpguHmeeFLhp8HcBvh/YLCnWsA+KHbwRSbf?=
 =?us-ascii?Q?ebvANGSTXlDxHhqeBzzplywaYpribxYuMkeddIUzz3rNpZHMOOkOEpPpg50h?=
 =?us-ascii?Q?kkjLwggJG6UoxNgJUKk9CCWi7aosImDl5ydCMQkF1STYVAYBTIIsEWLOG/WQ?=
 =?us-ascii?Q?Zlqbhr6cbMwIACjY/tlX9Mii3oFyKNKZn0GzuwRcaEpk+L3hHn1kbnFnmOV6?=
 =?us-ascii?Q?4R2S/tXMDPt0TwGGHO0h/qeplIquxpR1HaPD+4sVFwAtF9fto0XBEvLUfjzG?=
 =?us-ascii?Q?IE80s73DgGPu+d4++ePgudPAsJTg8gYM5Yk2YKwqPaOo1vjGL41MZD7Qkcc3?=
 =?us-ascii?Q?hN+ff6nHRsEBaR77FMv99WCcKQFjrtbnqiBdvDgAT3ggX6f6LKipAoCb0ZSQ?=
 =?us-ascii?Q?jxzShtKB0JY8BKansWWfubEjp9OEd54ZEYX5MFAFwbGdhLr8v4sLENzr1HaS?=
 =?us-ascii?Q?UwHcQDZ1DojX0cwR7rNqi0PVWCtYjaEPUU/Wjk8LF7itF66JPrBPqolZrpV3?=
 =?us-ascii?Q?TsfD5CtBBwiehQLu/A/kLwWEJ1lN+oI7HA4Io9/ljh/Pj2t28fi8oxcsVEaF?=
 =?us-ascii?Q?SzMokEZnFzdTqMjjwSVmDYrWVWGcSGv8nSrmjVg3LTFZ50tcyTmMMMB0SGfY?=
 =?us-ascii?Q?6y+9kTcjsGWCXdtiPlDXu7nAJXUHLWfO/F6MEJPFwOKgf/+A1AIQ+pfcl23F?=
 =?us-ascii?Q?WLPSIYf5Y7VYrTJOHeXxFNOlYSZEP+dj2jUJTECS9muoR74ZYRUC/xyN3jYk?=
 =?us-ascii?Q?0YS/vOJ94yd2/iRIB2e0fEac5qnvK4dwf6n1yYUG/FhaxKaRGbYf+XokVfsy?=
 =?us-ascii?Q?N9dZdP4SIcmezH59OKUF1gOVLvAI/KESC7yDiGvL5nfedIH6i1Pi8quyQ43m?=
 =?us-ascii?Q?v1siad1KNADlS2Kjx3ZK1G1C0ySG2TUpfgdcOCwEJFtWSHfH2LXnPTVVJhE4?=
 =?us-ascii?Q?LW2NvPezgq1edRG/jDyl2nw3vqZpvKXqbGdpl50CMYWawnVzv8zGCRk31yrj?=
 =?us-ascii?Q?bd2VuqNfyVxgfVmL6FPtCs6CSjS1P9pFXjucg9+nNW0HCW5OcrTRU+PUydgV?=
 =?us-ascii?Q?NaG6c3JLHai+TKeOb3FxqAAuBi/Y1fbwHEHML4X5NFcEqzC5zyHEFVeVsJfP?=
 =?us-ascii?Q?B6FTSUpomVaAmnkk9HPzA7Nz2ipDFhZUB4koW0AVniB9Ji1j4r7qCH2mxheg?=
 =?us-ascii?Q?eFXK4a1FIIHTGCNAM3GhS7f5lM30IcTsoBYGlHo1FfMtpiYAT+wpE8oKxh0R?=
 =?us-ascii?Q?dt8PwYNDQocYJLjyjEFQn5ExSJL9JXou5dO79luRe?=
X-Microsoft-Antispam-Message-Info: LqnDdI2AxKhBlDG4H061IMgBU1s4I4q8x+6NZ2VJ+76+VF0uz53wRv1BbWQqGzRZOaCoIu6PmFui7tma3xiUMGB1VX7hS42MFtWK1xUiqz3ZIXrqAqmN2QV38OHTdBGU9zL2xOi219eRQNKAKD+pjWr5lOGRJ1cFhQ1GSFfiyaR9PsnLrMwmctVlivG4ZS2gTA9VFRX19GDYxrF4XMIFLISeoq1gG2OJsj1MOfYGVRSHAf7r9peb7LToSkXViAoQ42QEIx6I82U9B8Vy8IZTgd7A04WIdzuAhZDUBlOJ/K+j22lreDNBY4RpLYN5O9/gM2kS87YoT4dmqSoKu5fIHB2X9NPViMf0aKGDwx+WPEs=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;6:ErrO3qbUaiopTmxllWwyGJSo1OyWiEMlDaZqkJfqgYG7bQo8jVT1hiMw8xqcowO1jQpXo7SSD3KlDITgmZXIXQFmbOXc+wVQaIa/Hwh0B4jxxk84qVfXaLwF0ux6Rxw4rwqcUrcFmaF1C5oH5MkPYrxpMUWCmy5BFht8iPPy6tHGTzwpPr1aaUozmqtyNwCGLaoTB8L9aRqGroOyuXxfmT9FwoFUQ31lcipYhd7qNUjOwUHPeYCaFtNIiHGyGIUnWgEiZcxCMfp/+RWdjPKnTqQAs/W2uwVfqu5I8ZMAVP+D+cMRy5ph70UvF8nZylF3D6PcQd/7R7kZOHCHisHL0Iht2ywzts/rqB+fPeE0J+Lw2RBelFM17HyNioGQY+3Rm36fiDJopDgg5aUKqJASDakCiMbDu7L4KiY4kDOIlyFieVp4ArBVjDvNFAvuO51RGzLk/vRsWwYswEvdgpf/0A==;5:UtLirauVIf0TFvzUOW5igdfXGHl1D+szZvGAWXlOmfSYavqS/pSQ7SwJ+0dSMH/89U0qeVUX3Wbsa9ZAbTqNrwwKBtUGPmVRd7Yn0exAmr1g8zDBT47pYUhUQllsbp87d9icaNaAnRvt7cluP5mFPL1hi3HPumLdlI1wdQ4MtDI=;7:jZjzd+g72M4wWuoo844rQrEFY9yqeChBqfw1jglmIZ3MFicKq5FCB1PFx+Q305IroxgkcEei2Y+qkQAQLuxu0YSOTk+idkLk7qgcaka23azphbhrlZyy4lAKisGstumLJ0nO5hJzAgA9Rx/Zx2WnJLz8QM7bQVMNDrxueYglVOV2L24rRm8QQbovFeNbm+5uy8FXxBmypEzxPkuGFlyzN2wZVYw8mkcI3fg60a/qfcgen1TmyKsVsaMB/U32nKjr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:30:28.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f083031d-f547-4322-7e5a-08d6325f538c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro defines for ZynqMP DDR controller. These macros will be used
for ZynqMP ECC operations.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0005ef3..d1999e0 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -97,6 +97,174 @@
 #define SCRUB_MODE_MASK			0x7
 #define SCRUB_MODE_SECDED		0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT		BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST			0x70
+#define ECC_CFG1_OFST			0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST			0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST			0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST			0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST		0x84
+#define ECC_CEADDR1_OFST		0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST			0x8C
+#define ECC_CSYND1_OFST			0x90
+#define ECC_CSYND2_OFST			0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST		0x98
+#define ECC_BITMASK1_OFST		0x9C
+#define ECC_BITMASK2_OFST		0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST		0xA4
+#define ECC_UEADDR1_OFST		0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST		0xAC
+#define ECC_UESYND1_OFST		0xB0
+#define ECC_UESYND2_OFST		0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST		0xB8
+#define ECC_POISON1_OFST		0xBC
+
+#define ECC_ADDRMAP0_OFFSET		0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK		0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT		12
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16			2
+#define DDRCTL_EWDTH_32			1
+#define DDRCTL_EWDTH_64			0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK		0xF0000
+#define ECC_STAT_UECNT_SHIFT		16
+#define ECC_STAT_CECNT_MASK		0xF00
+#define ECC_STAT_CECNT_SHIFT		8
+#define ECC_STAT_BITNUM_MASK		0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST		0x20200
+#define DDR_QOSUE_MASK			0x4
+#define	DDR_QOSCE_MASK			0x2
+#define	ECC_CE_UE_INTR_MASK		0x6
+#define DDR_QOS_IRQ_EN_OFST		0x20208
+#define DDR_QOS_IRQ_DB_OFST		0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK		0x3FFFF
+#define ECC_CEADDR0_RNK_MASK		BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
+#define ECC_CEADDR1_BNKNR_MASK		0x70000
+#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT		16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT		24
+#define ECC_POISON0_RANK_MASK		BIT(24)
+#define ECC_POISON0_COLUMN_SHIFT	0
+#define ECC_POISON0_COLUMN_MASK		0xFFF
+#define ECC_POISON1_BG_SHIFT		28
+#define ECC_POISON1_BG_MASK		0x30000000
+#define ECC_POISON1_BANKNR_SHIFT	24
+#define ECC_POISON1_BANKNR_MASK		0x7000000
+#define ECC_POISON1_ROW_SHIFT		0
+#define ECC_POISON1_ROW_MASK		0x3FFFF
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3			0x1
+#define MEM_TYPE_LPDDR3			0x8
+#define MEM_TYPE_DDR2			0x4
+#define MEM_TYPE_DDR4			0x10
+#define MEM_TYPE_LPDDR4			0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL			0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK		0x3
+#define ECC_UEPOISON_MASK		0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_CFG_MASK		0xC0000000
+#define DDRC_MSTR_CFG_SHIFT		30
+#define DDRC_MSTR_CFG_X4_MASK		0x0
+#define DDRC_MSTR_CFG_X8_MASK		0x1
+#define DDRC_MSTR_CFG_X16_MASK		0x2
+#define DDRC_MSTR_CFG_X32_MASK		0x3
+
+#define DDR_MAX_ROW_SHIFT		18
+#define DDR_MAX_COL_SHIFT		14
+#define DDR_MAX_BANK_SHIFT		3
+#define DDR_MAX_BANKGRP_SHIFT		2
+
+#define ROW_MAX_VAL_MASK		0xF
+#define COL_MAX_VAL_MASK		0xF
+#define BANK_MAX_VAL_MASK		0x1F
+#define BANKGRP_MAX_VAL_MASK		0x1F
+#define RANK_MAX_VAL_MASK		0x1F
+
+#define ROW_B0_BASE			6
+#define ROW_B1_BASE			7
+#define ROW_B2_BASE			8
+#define ROW_B3_BASE			9
+#define ROW_B4_BASE			10
+#define ROW_B5_BASE			11
+#define ROW_B6_BASE			12
+#define ROW_B7_BASE			13
+#define ROW_B8_BASE			14
+#define ROW_B9_BASE			15
+#define ROW_B10_BASE			16
+#define ROW_B11_BASE			17
+#define ROW_B12_BASE			18
+#define ROW_B13_BASE			19
+#define ROW_B14_BASE			20
+#define ROW_B15_BASE			21
+#define ROW_B16_BASE			22
+#define ROW_B17_BASE			23
+
+#define COL_B2_BASE			2
+#define COL_B3_BASE			3
+#define COL_B4_BASE			4
+#define COL_B5_BASE			5
+#define COL_B6_BASE			6
+#define COL_B7_BASE			7
+#define COL_B8_BASE			8
+#define COL_B9_BASE			9
+#define COL_B10_BASE			10
+#define COL_B11_BASE			11
+#define COL_B12_BASE			12
+#define COL_B13_BASE			13
+
+#define BANK_B0_BASE			2
+#define BANK_B1_BASE			3
+#define BANK_B2_BASE			4
+
+#define BANKGRP_B0_BASE			2
+#define BANKGRP_B1_BASE			3
+
+#define RANK_B0_BASE			6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
-- 
2.1.1

