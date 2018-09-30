Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A545C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8938F206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EouXbwzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8938F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeI3KIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 06:08:25 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:3808
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbeI3KIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 06:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW38gl6mJLi8Qc5oRJ0lNrFwjOMISxcCU5bGhcDzgQM=;
 b=EouXbwznuqd55KgEDwjQTzkUigoXMs1oVbYQYfCm6OP9YlRnwV3Vx8VbCkq8hYQo4/zSU6bx+hKNkaYA0mq5UPuiGlh3SiZlyxPS1MmeDNaCQTnQuOl744awslXld/bk32GPp1U9fNgYVnaonwvHtGwAIfUfJ0zng1CtpAG4J7k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Sun, 30 Sep
 2018 03:37:03 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 0/3] Add i.MX6ULZ SoC support
Date:   Sun, 30 Sep 2018 11:32:25 +0800
Message-Id: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:203:36::35) To AM6PR0402MB3909.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1008e788-de3e-4713-6691-08d62685ff06
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:Mk0ogrB1k16ZnJCbIcMhIRZDL16M1gPYMx6GF36NzM1kP3tFfzo8Tpy8SUpnK2eFZOzDQMmtuYmuG3exC9wEmqsK2Y2NenWQf5f3AvpIZt+HCvmBCDyEpilog8q92XtcInO1GBIWQm8FINAeBcBwFCKQFaIghEvBgy4WdnlLp2yU8xSAo2waw4wOj9qdZVaxtSvVbAnEpV3gleRawvqYc2PwFKVeFS1xke+e/vuJxcvZYlw9ms8qBhBr2WNtH/cP;25:NAA2LdkDdTB6DQfRb/OSGBHqOKl5akhngUQzK02oO26P7txk8F0CxixhOaJ2+ZiiPW0ec+yOkGRtPpov3x2ZrOETSA9Q2McNBWGIiSk4LkUwX4Y65yssv8ra6dmeTD1ZPi562FkhGUwM6RowKzAJMjB0sdje34nzryiBGTxsr2xmsO2MNZp4uT7LSjUHXV7+JNsYQedtE+zsB/sKHsjM0lfWK4j0zbEophVw9tNhRRiJK/v+6FsPMrtMpC4+jvR5qwQrBJfaUQl6eKisronrLIjBm/HNMizdHQTA4lVpsRGNTQj3OJiWz6o9JzLQLm5bB3TIkv3KJvTFM376l1GJuw==;31:fOSG2TX0ZCv+OKt7ChnJw5TB7BZ5znkBqqD9aTDxkAky3I4INjUCssmxxr2r+wJJ2cejRuUW2EtjZzWYtcvkXuqGAEqNhtwBZCyLt4JJx3YLF3y/U1OFDLG2Z168QasXeeQyt//X/FAYOxgp7253nMdHNyCBPiop+fV+RuFUJQWaKb4D/VKGG/8q9mVYXHOsMDTq8JvfXC+doRj36aiJ+whxwvkahDpwyLXanuv18gU=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:yxbULYtNArar0c0GuyC1J08TB5lLriS7yWKVHexjTQa83O+b0faXkeSFCK4ghcWPgD4oZU6CO/5BybF2AZslRNHBYMVdbSJ+DGbmjGVk6YUGL27wtP24UQG9gWN+u6KNM3J2OIXL7+rowwGdi/JdRmpBQ37KAhZF20HhPQQVghA//tdYLAv1DTyKwvkyoF8Rf1LJC9j8UqhTD8v8F03mUPQAO75d5TToS4o6fwM7BGA2c2fIK+RBwkcmcVlgyBiTm934LDPddG2K8efWrwJAcYB1AwYAwiqP81BbQS6esVRaCyGuYbn/F/EdlTX/i9ThzIK5wwV3oaC0fDNFY077cwHzNcsTaV5sNIFJlGij7SyJ30o8VnHjyU5s5MBnhR8n1mZZqnwU5dKrl7hN9+eCYoaCqN0dvJKKmW9jPdfFnAwbCdKENpj3hb8D2Ovv6ohRjxVuMSJsHN+Gb3TpirOAFHdUOCvOn2DcoP3NSxWtZErK8P8g+yl1uPDnzMuKULVn;4:h0eXHQrYjltogUmWv35gsI5Tz//LFlfYzb0jf4LDmO2O3tVyzMUJYDWtWXsa3ZDaBJwxpaK8Lx00fmTWENyl8AeZpNLwwImU7PSJmDK5t5LiZXviL3gdaEID3PaaKnUWRoaSeXTXXKQx1BCv11XIIbWzHxckYnagXCoq1RjHzZL4TrcafRhGMxao2s02BqHd1iTJGW2wOWcCH8AER1xdOOGY+R5U10CslSt785iPGaSsl950f4oiULPQyJMmUYkRD1SeXIP5D3Iime+hEMCREw==
X-Microsoft-Antispam-PRVS: <AM6PR0402MB39097887C9037FB378A03D7DF5EE0@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 08118EFC2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(86362001)(476003)(186003)(26005)(2616005)(956004)(16526019)(81156014)(81166006)(105586002)(486006)(106356001)(50226002)(34290500001)(23676004)(52116002)(25786009)(4326008)(8936002)(478600001)(2906002)(66066001)(8676002)(305945005)(6486002)(47776003)(97736004)(53936002)(2870700001)(68736007)(6116002)(3846002)(6666003)(6506007)(386003)(5660300001)(6512007)(7736002)(316002)(36756003)(50466002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0MDJNQjM5MDk7MjM6MFNwd3dvem1aWnF6bXZvU1psbXJKb1hT?=
 =?utf-8?B?MlpBd2paRDZIOEhEUGp5Tnpsd3Y5T1hESVFIczNtTEtRUGxWUWhkR1ZBL1RJ?=
 =?utf-8?B?Z2Y3QkdCNXIwUnZWQ1p6cit3cUNxcVhUMkh4UFV2WSt6VkRrRUZUUkhYVkZ5?=
 =?utf-8?B?L0p5ZlR4dmF1dFE1RW5XRkxKUHV2THFJUmxnM1dxSFVEWW9qeXdldnhmRWNC?=
 =?utf-8?B?emIrdHdtL29INmlWSTJ0eENtMko0eFh4N2ovNFBxTGdBdlZzNDBvMklPMWF1?=
 =?utf-8?B?Qjdjc3p6UVVhaHZyT3dQNXRiTnozajFScUw2NVhXOFJ3K3NLK3NCR2MxVkVm?=
 =?utf-8?B?dk1rRVh6OXNYSkVCeHczR3J2dEhnZjRnamZ5MUNUcURaMTdVc09LZ2FmeE9G?=
 =?utf-8?B?S042WnBWaGcyclZHSkJXM1ZzeDVyU0R4VHVoNThMdXJ0UjJFdHFET0lCNXhJ?=
 =?utf-8?B?OC94L3lpTEJ6MXNYUW9BenZwa2tmRHozQS9qc2lJRHdoMEY5R0k0TVVWUS83?=
 =?utf-8?B?K2R5VUF1ajVLZkJOU2hiTnJZa29QK2MxaEZ3cHdLV1doaWp4QmlkK2NjUWE5?=
 =?utf-8?B?a0J3d2lFZlFWcDVPUGVUd3F0QWEwNzZ5dE9BbytMVldEN1o0ZEs3Z0F0L1Jx?=
 =?utf-8?B?QU9rNEo2b1lvS2lSbmFUcFJoSDhVc2VGWlhTeXFteU03QSsrNnYzS1RHKzVQ?=
 =?utf-8?B?cmRxWTBYQUcyM1ZTblNoMllWY2NiRVNwYzVGZjZwWDN1eElrM2NKVy9sU3VJ?=
 =?utf-8?B?V1lBNzhVcElPSXBqeVM2Q1VSaGYwRDNSVWl1UUdEWkxZdGN1VVZhT1F3bFZo?=
 =?utf-8?B?c0RKMGJPeXVOMzdvOTlrR0lCTkJsSVozdVExa2RhY0wvb1V1RGptck5PZnBF?=
 =?utf-8?B?eWZCcDdIdmlYVDY5NXNuZHo4MnpqU3V5LzJLK1ZINFdxUGM2MUFSS1dReFJJ?=
 =?utf-8?B?MHpWWk50bENiWDRRNUtQWFRybUhQODFQMzFmYy9jWUVYS3JlOFJabXNIWGdK?=
 =?utf-8?B?SXZsNGFYaXNkTkNHUXR5Nzd0Q2hhSlgraXRxWWtZYnFPczAycXJ6RkZ3cmRY?=
 =?utf-8?B?cFExb3hBY1JEd0RDOGZLMkZ1Y2lyR29aMXE1NjRmSWRuVzViNllJVm5YL3Jy?=
 =?utf-8?B?Zm1BNCsyRWc5eHJtckt0cU5aQ2xibGxnd29rQUh1Vmk3ZURDK2FBSHY5Yity?=
 =?utf-8?B?Z01SR2RmRVNXeFBhV1l5dHZhY0x5dmQ1VWx0R2w1YTE5MitKYWF4b1dGb05z?=
 =?utf-8?B?Uk02ZVQ1dDdUUFZhem9Obng3bk1FSEE5YmNObFRMeHExamM0VVBvZ2ZJVzhD?=
 =?utf-8?B?Ti9WNFljcm1KekVLenM3MDMzWlBmdXdFWmRmcXJyTzNFY2xQOGFTb2FuL2dF?=
 =?utf-8?B?TnJKNHdteTZOVlpPT1lqandzN1kyc1MvZWtXQmU2RnVrNit5Qmtudm1JOUZa?=
 =?utf-8?B?RUplR2VFMCtmZ2Z5b0hLcTlmMUNtYlNOT09jRCs5Nkc1RkFZUkRQK3lvT0Z4?=
 =?utf-8?B?U29mdkR0T1lUQzRkYUdzNnNrcVNVM0hRVms1eU9kanZSSmlwNFJvYlpYeHFO?=
 =?utf-8?Q?AHY?=
X-Microsoft-Antispam-Message-Info: ElT2DwkRFxLOukb+7tCWJFGjyWQb911k/qAoVtIjYptz1GyeheZeloffIteJQj3o6DKL6FocirX/J0BxgBWA4Oel7CjwM8MopaEV4rhwpskKb2a5laqEc307TnK3czT8S57bxNh+FWq+VGHYsW/bDaMNxLFIuAy1dAVrHOmDTAVn2xHVr4h2xc90Zig/ThjRiY2SF0h2lJsWh43usO3cw/AHcJIIRiJYVmT/8WSQpVj2vcXLtUSA9zFvfV1I2mHbwqsOSMm1/XpMIHw/gJdh4fm2MKoxMismcXXszXY6owoX2uldIdy7qjo+SXaOqcIbrb1BcWHCzbhUKpY4S/97N/E8eKBBW81PZs9WfrTmafI=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:V4QbLeabl+n6oAvBXp0/Ve6dwlvVYaG3yFBJjwGbsgjnAHhqsDAE9Xw06jJpcyEOHkfKCUsZBxoPaRph/UthfXtaCoV4nUx5+zIOOuY2hpnzm2kG1NB6o05Wkp0d5ICuaDyJPNjVAme/GGvKle2kwoJLlLK64esk23sJq6Jo6Tm4k+XZypXQQkloCM5ViPd/jyilWcxHL3lyfOBZ7lygaUFPxqlxxjgEkgUupT9osr73bE2gyLawK+zRI6i8IoU1ErtdOjj+yM5+QWLcfUNgdKn6llCEEcDua4T5WKt0NCAaMkKxg/J7Uim0dt20L63VZIpbcYYe48L+MfEsT7WCygurqOWszcyC7lGlTIHCrGyndJkVr7k2RvjxxklfKBzoZ06IJ969mY+dIahojtbdI78wf0OpR61p6yx5jrCOP8lIVCKdg3J+9QI0/b1KYKQJUhDj2AV1XN4trTekbvOmfA==;5:s3/NVAskkCABFbhVMzTXBUlDA4TB2Xd0heRn3ySkM5PAD67MMRjkUu7PzXoM8xkd0bKCs6KahscPZyzNfztSST/EE18b/m6EwSvSlEq4ZhllD/NximY4/qdSfLd3SBisvgIb/pMtY1J63VkoeiChb00TkA4HANUyiO+PWcQIRVw=;7:Fm9ihBeazeouyX/vSsT2d74wQAETiirDyZAMDTPErtMagRdoNCasIEERwVpBzq5o5D35y5frGkIvcbs3FoFg3jjSwmizaSApY3jEkNHhpTvOFgyUYK5fPczZonElzM2zBzHJkxsSALmpBYN0l1AY1CrYEoTbt8UKrt6gFfE5uRokJEFMtyfyvH3knx1dTqdh9ybtWNUBp9VZ36t80cdjZfGmKdTYEvr8313e8NLPMdTWNj/uLwK57jAQ5ZWTDmKf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2018 03:37:03.2532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1008e788-de3e-4713-6691-08d62685ff06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
i.MX6 family, compared to i.MX6ULL, it removes below modules:

    - UART5/UART6/UART7/UART8;
    - PWM5/PWM6/PWM7/PWM8;
    - eCSPI3/eCSPI4;
    - CAN1/CAN2;
    - FEC1/FEC2;
    - I2C3/I2C4;
    - EPIT2;
    - LCDIF;
    - GPT2;
    - TSC;

And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
just add the new CPU type and remove those non-exist modules from dtb.

Anson Huang (3):
  ARM: imx: add i.mx6ulz msl support
  dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
  ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

 Documentation/devicetree/bindings/arm/fsl.txt |  4 +++
 arch/arm/boot/dts/Makefile                    |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts       | 20 ++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi                | 38 +++++++++++++++++++++++++++
 arch/arm/mach-imx/anatop.c                    | 20 ++++++++++++++
 arch/arm/mach-imx/cpu.c                       |  3 +++
 arch/arm/mach-imx/mxc.h                       |  7 +++++
 arch/arm/mach-imx/pm-imx6.c                   |  4 +--
 8 files changed, 96 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

-- 
2.7.4

