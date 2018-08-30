Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76174C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C002082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GRyxwvpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C002082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeH3Ojf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:39:35 -0400
Received: from mail-eopbgr730048.outbound.protection.outlook.com ([40.107.73.48]:62112
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728327AbeH3Ojf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtLQJvuVUOF4EuoKnkIjNFgfh4078Er3vWaFPq9o7vU=;
 b=GRyxwvplvmI/h8As5a40IKNvlNyvLvz75MwDl3q9/n41p2+Qa5I3SXe5qDxu87A4SRN31hLpU3VEKz9VRzt3+VMUc1nxNuq6QU3ja3q+BzS+BoC3MHvbyP75GnvoSmurVFTIUtxm4J3BX8xQHKDIz3tN8AH13SrNIChoHZu7988=
Received: from BL0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:207:3d::20)
 by BL0PR02MB4930.namprd02.prod.outlook.com (2603:10b6:208:53::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Thu, 30 Aug
 2018 10:22:57 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BL0PR02CA0043.outlook.office365.com
 (2603:10b6:207:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Thu, 30 Aug 2018 10:22:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Thu, 30 Aug 2018 10:22:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57360 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvK6A-0000WH-IS; Thu, 30 Aug 2018 03:22:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvK65-0002P7-Eh; Thu, 30 Aug 2018 03:22:41 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7UAMakj003987;
        Thu, 30 Aug 2018 03:22:36 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvK5z-0002Nf-Lk; Thu, 30 Aug 2018 03:22:36 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 04AA3121447; Thu, 30 Aug 2018 15:52:34 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <broonie@kernel.org>,
        <arnaud.pouliquen@st.com>, <geert@linux-m68k.org>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <lukas@wunner.de>, <freeman.liu@spreadtrum.com>,
        <vilhelm.gray@gmail.com>, <tglx@linutronix.de>,
        <baolin.wang@linaro.org>, <gregkh@linuxfoundation.org>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Thu, 30 Aug 2018 15:52:17 +0530
Message-ID: <1535624539-7839-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(438002)(189003)(199004)(106466001)(478600001)(336012)(8936002)(6266002)(72206003)(39060400002)(305945005)(2906002)(5660300001)(81166006)(81156014)(36386004)(36756003)(90966002)(63266004)(8676002)(50226002)(356003)(47776003)(6666003)(26005)(76176011)(52956003)(11346002)(42186006)(2616005)(103686004)(44832011)(16586007)(476003)(48376002)(4326008)(7416002)(51416003)(50466002)(486006)(126002)(186003)(316002)(106002)(446003)(2201001)(426003)(54906003)(110136005)(921003)(107986001)(2101003)(83996005)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4930;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT036;1:ZUhvwhdQ7OM2ld/VOMsybAR3H8F+E6ndsJaJxsZ9ysWWyh0O3+fNin27Dlk2h1SIFWdrxyEFq5SsEefOf0Cc4ApZjIRBGkhE21Cg18KoR4d+KMtkms1FVw3SpOueXoo7
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa9fb170-6be0-4cd0-9364-08d60e628d93
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4930;3:EQR4qigKO8bTs/1GuK/2z3oC5wxMBPgJGLItbRhzugjofEMce3rdtpXpUItb/cIzAzzufmK0ptWLk3zN8MaZ8NETTPCd4VlysvV6o0vIpVaNJf8n40gpItmDNCUAz26FeDyxOo8nngCN6VjJHKkU4TZOU/AJ6JYINt7+erJmesFCM3Rm8sRm35360UiC+0Ty3Os2KqgXrymRbAn5Uklfd5S9LJ6UUqgy32KJN1ljQ6+/NZ9tdfcxbOBK6IdWbq5vafcphXBQxOcAKhYI+wulIfEbNEbpg52loorfNNjsyEvhwj7dvrs3e3cTEUs42Wc++Cu2fKybmB/p3EW/T7slc/iCA87WxRsc/dhIsUAgOH8=;25:zuKWNOvT8wSMjj7w2Qeg8fYy8ZPoJLI3xKUuqaE9XP821GjD+Ok+77lLAVcsRMYMOsgLF4EMP7Nv1KEUNWqpjuNXHOfnNfThrcYPQL/fyeR4HvHDpnRJVginLiScnZuMZYAbuyE3hJ0E4SBFr5g74J3twr6Bot4cCR1haWibYR044TzFKlFqYUHYrHCHxWU1v45y9JhMyi26z2cVOR56BRq4QX81U+0Qxj3MdqBEdH1k91AGlWJp4SGxVb0FZB8AoXhBM85ZLaropTbMhMW1rfScPf6AO306NxuDYclS40NhHv9tslLl2LzHdeV86DLoF99k8QJvrzgaC8LzVA+DVw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4930;31:cjFxS1ap4tA1tSIOloyZyZ6GhIRdJzSas48AWT+ru0FU8vIu7el+QYu7UTBzplw2XzFY+XP666eERNWwpN3e/iV1ge2Vn6NVqoLHbcXaWwfBO5rhQo8Zrg9+6+hhJPl5zz5NIFJ+TNTgkQR+vb2MlU58xcGdy62Rni5YT0d2Sf3GM9HQA1+8q8RsZIeFIwXVlSfO3Uf0R7NGUcQz7VOfC9kgV7VIHku8qn2izC5d2ws=;20:KQfffNYkX4YDQno96gHHHYXxyYKACYfraR2nrYy/TKrLjvbOjnQdHqMD8EDwzFoaR82Mg5meREQGeqTyBJBI+QC003hWZhCphD9Gk41NA9SKIGZMBuhu+OtAJBUGLnbaeIka4q3T57Ymk3lecP7K7gG22UmlJPXnuhMmXdyqjjAar3vPNrX4EADFFCRQYrFkYdVJ4FCCwIvm9+uN2cSvKeU8prTlKQAUB2TOO7AqptLqYjgCjvJYWPNGxI2qy0MYzOOgKCBhUHqGPVAuRowimgKPISAD3K7CUJyIUgirkK1WcaU7AHgiZSNrN3snsotyt45dhHGltdCCKD+SOlsVea00UxD6Ba1ODSDrvn9qzrY817N2ixlQe94nk1CAVtgFPA3c+ChmvC05E6Q1mDNdfmq3iVgV0r/S2xm68RgIHwIKqUsFvXmE17QiVlTtLgmv5xXHRmzMJyrnf1lH2aSllddjWj+DtSiKu1xR1kjHG/kH7gKiadjENkCPP2/kF27r
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB493040D09507CA3B20958AC6C1080@BL0PR02MB4930.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BL0PR02MB4930;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4930;4:QsUIi868dVUhFLCwtM/mp5IfN1mSpRf6NKKwDnI9etXqMFWxS0GDiz1Bgs+cjfNJ98hrmaYliiksM3xaMFpmEHTIQTNhrXVqEN44JqXrqtf/PFWhyeOzZoWx/j+WuxBcohhQd97+196WJ8B3nbKHto/PHwLIbTek1VkPCvuTqsC63Pxtv1PfI/lp3dvQ6b4+RFqCdyox/gOOIVRNwRNqBs3hw39GPiPcDQ/c++iuqzh6RquH2i7GIO9B+Ol7lNp5VA41n4oeTkHxDqUSp+831TSSyKkTnyRhOLli5tWskElo018bViH43C8ouOwh+ZacK3YP0D8QFJnyieugnXfZKN5q5o/7IsswcidW7BvlIEo6/SeFBhWbzKi9GE9I7H3T
X-Forefront-PRVS: 07807C55DC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4930;23:14c9x08kGEc6hbL+MGyNRUDT3JzEzHy5Pq+7OyyK5?=
 =?us-ascii?Q?CEM+dx0Ytefjmd+nSAj5m4hOLIqnK8xpNrNkhWQS9TFSSkzStvNFBGA7J7Ij?=
 =?us-ascii?Q?Z+qLazYVWFsauMAH46STpNyiPyzCqRccyAl19IgbnLx/0LU+4b9CmQVgiAPM?=
 =?us-ascii?Q?TOP1ezUs6racHx+X3cHOlg4r/JRF98qPRYv6UyBQD8KdXHxvIO8QSPXIfU9v?=
 =?us-ascii?Q?FKxShEwIL3hStQdwNHEH1YxJxGSS+cZ0GqA9o4IAnVtk3AJXl1njkTr1pWmX?=
 =?us-ascii?Q?ynpKb9g5SiCHY1JFPC0n8QoN1NAsNf43DoIT6aLEONcibVmEEExoqWFgLv9y?=
 =?us-ascii?Q?WMC0OpviF30OsOQlUtxIB6hD7PSjuNr718SAJsQ7xdmfnRNTOkEweplBF5xI?=
 =?us-ascii?Q?LKaE85h6Nu8fW3uOHEnpQ7u0AIXhtG/WoRX2Wha87BTl3n7qm6LIPe+mQ6hM?=
 =?us-ascii?Q?Hm9Nip0wBuhphDDSXsuCyWvntgVF1rRl9/p4euwH5e+vj+B6hwC0B91rAj2f?=
 =?us-ascii?Q?kMlAqe9yKfHw4pshK183/2CQYYVGKZn+6FwzIfPJFCyVzTsD1x9fQ6uM/vXO?=
 =?us-ascii?Q?KAQ9aAN8wrwImQfadpwOXW29BeufxcczdwLLH3bfwSGKFIK5KwMX7/gx9A0n?=
 =?us-ascii?Q?tnuYrDqy6wLgQcRQKBiv8Q/RznAke0zhBbuVEHtAyp4ZRCS6K5Az8ivwSLD1?=
 =?us-ascii?Q?aorDTtKXhMJSD8ynzotYxmLQxNJreOU5GbgGlJMWobG1fIlIbWeJu/aHvD/D?=
 =?us-ascii?Q?H7Xlc+tGN4wdEWPfopdPfPhjGZ5YtpYAMaA++gzKkDcf42OtPCRiMCTolCOU?=
 =?us-ascii?Q?GGfNcvOEkqwchgcnkS7ulD5UqFH51ehImN6gYM7OhvR808p7zDOS3n4etHvi?=
 =?us-ascii?Q?Gjcp41nHAO1bQwUVHMcHn8yxDDkKdb2BznMFhBZ75y7bWKq2uj0gDSo0HyXC?=
 =?us-ascii?Q?FhXVQ4twSgBKJAPfV8BAyxF2xHSHUImwAd6Zgk+QrzWL17I6HAYOG/YFivrS?=
 =?us-ascii?Q?DkJSot/qV3NZnNYKJKcjc/U4Q//7gNNLnu23GIVrMLY3OnUWcxw/xNz6+jwd?=
 =?us-ascii?Q?xstuZt/lcUyyPtcHDT7YFbtGKo/A8q9Wqx7hdrZAOpeheh32tDDI7O9VSMLk?=
 =?us-ascii?Q?FJpEmsMaBPhXF7GxSpgI6fWxCeUIoyCJTkoRG91w2sK9KG9AMlh+N5OrIC8H?=
 =?us-ascii?Q?+01dnrOARki9RC06badO1nmB7uDRYGI9FI4R8Q0k7f6Qu1t2ogC1+bi49uI9?=
 =?us-ascii?Q?2a4c4noSi3fbslTubF0GAR5Hu9jUZcZH+V2/7cSdtoIoENVumllur7Elh/kg?=
 =?us-ascii?Q?mj+9mfbTE/5WTssMHxWq0lGKWIHnDZrBzqTrcipU2y/WK24Rs2CsAsfOURl9?=
 =?us-ascii?Q?zSRUA=3D=3D?=
X-Microsoft-Antispam-Message-Info: MSJNNnUVAftfuPnEDO88N2j/dDU8JDQvQ7INmNWXAPXXjPAy6HdgJf5T/5Q4IlMrA3423y89I5pgqj3td18WrdV/rzlMILnlIxPKpuUkKNcTcXo7VenpTpFADbT9VBCZ6DJ6EhlvX7HsurhuEeaAfzaPzUREfmro22fdsNI/fvNAlhLSHVdBtO6TaQDpAfRblNFjXeXZrPdqWEyHDhwB7rdrqdhVUhim7IRkVd7RvlW642CUVNWdiePEuaQofE1Kje31bJ6VTCIByFLGFJeSUSs7qnZKf2NrmzYeLuVGL78M6APPZh8xqDr/lNiL+KV0dyvZDRY7dbjw/4m9XSRBxDPClH7s+FlMFFCMigy4EX8=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4930;6:cxpWxGn7HXCEWVmIoaOlvlKFbC4OMuensM4aVMWZvkbLFCrFfFb7EzwseGROgMWIhsvDAFBTqt+DQ+1N9VcwvjGLaH1ucRQ36ZSEq+3s6twVqBMxk1C9yNGNh93YBCjX2txgGhuCvBPZEEE78+r9pQ6k4F37JRu+uTI99AaKCr+lJXicOF/Pdm525IfP9rJ4ppKKe0P1Gjv2FAn8QQOQJoo5Nuf7Ss3OlvINP02kuUYY+0D/Jyd7kCjBAcZdlGCZPG+FAjJh1OAQqalKodtAdrH5TqtEVGdpmnxVQlcnJdJCi11MN920QuTDY8pwZWdtc7Us+DwXFPEfGFMb9mBRcWaYGOUH//werSU9Tqts/g2jIzBOhiLfxB2o1t3dEq5znuR13RDpMOBQ32ZleJgrdnXP32X76Cwg9JWJsHXSQWOl6v+h2bowoyU/MQ+zLnn6oCP4F5DD8rJjHpidInxGgw==;5:ev18ehPlr+DwUCXG4zNQB+5ayPp30504f+zrNQ5Gj0k79H3E9gV4E4jnZq98b0hZsld1B1OfJJG099KwR194B1iHEVjc6kBg+v0n/bSpf7ObtXexwimQvEaS92bfmUij9ysgJVP5mT1Rp2KjayIkPx2DaUnCSD/P/4d8fqBNTFI=;7:pBC8WOgA9i1L8PJ+ldeYZsV0wLI8tY5k6CtXVOGX+Hg0qA/SG/XWeRo5PbftA83ksMLt0zVeVTZEPOCkKkl0AAh42dzZyuRkD8Wzj0AyuycjkV1j9JFMZ7bK1zlipIjQjxMx30SJ0L5OdribFdbxktzUVT0Vd3a97RPSsB4McyvTRv5GgT7F4iqW4r6JBL5Q7fcemevfNJZe9kIY1csLBAFVS9LTeULGG45svbQHOEDh/RXcsj7+Ckj7U5KWPrQt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 10:22:47.5590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9fb170-6be0-4cd0-9364-08d60e628d93
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 159 +++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
new file mode 100644
index 0000000..8cc96f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
@@ -0,0 +1,159 @@
+Xilinx AMS controller
+
+The AMS includes an ADC as well as on-chip sensors that can be used to
+sample external voltages and monitor on-die operating conditions, such as
+temperature and supply voltage levels. The AMS has two SYSMON blocks.
+PL-SYSMON block is capable of monitoring off chip voltage and temperature.
+PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring from
+external master. Out of this interface currently only DRP is supported.
+Other block PS-SYSMON is memory mapped to PS. Both of block has built-in
+alarm generation logic that is used to interrupt the processor based on
+condition set.
+
+All designs should have AMS registers, but PS and PL are optional. The
+AMS controller can work with only PS, only PL and both PS and PL
+configurations. Please specify registers according to your design. Devicetree
+should always have AMS module property. Providing PS & PL module is optional.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams"
+	- reg:  Should specify AMS register space
+	- interrupts: Interrupt number for the AMS control interface
+	- interrupt-names: Interrupt name, must be "ams-irq"
+	- clocks: Should contain a clock specifier for the device
+	- ranges: keep the property empty to map child address space
+	          (for PS and/or PL) nodes 1:1 onto the parent address
+	          space
+
+AMS device tree subnode:
+	- compatible: Should be "xlnx,zynqmp-ams-ps" or "xlnx,zynqmp-ams-pl"
+	- reg:  Register space for PS or PL
+
+Optional properties:
+
+Following optional property only valid for PL.
+	- xlnx,ext-channels: List of external channels that are connected to the
+	                     AMS PL module.
+
+	  The child nodes of this node represent the external channels which are
+	  connected to the AMS Module. If the property is not present
+	  no external channels will be assumed to be connected.
+
+	  Each child node represents one channel and has the following
+	  properties:
+		Required properties:
+			* reg: Pair of pins the channel is connected to.
+				0: VP/VN
+				1: VUSER0
+				2: VUSER1
+				3: VUSER3
+				4: VUSER4
+				5: VAUXP[0]/VAUXN[0]
+				6: VAUXP[1]/VAUXN[1]
+				...
+				20: VAUXP[15]/VAUXN[15]
+			  Note each channel number should only be used at most
+			  once.
+		Optional properties:
+			* xlnx,bipolar: If set the channel is used in bipolar
+			  mode.
+
+
+Example:
+	xilinx_ams: ams@ffa50000 {
+		compatible = "xlnx,zynqmp-ams";
+		interrupt-parent = <&gic>;
+		interrupts = <0 56 4>;
+		interrupt-names = "ams-irq";
+		clocks = <&clkc 70>;
+		reg = <0x0 0xffa50000 0x0 0x800>;
+		reg-names = "ams-base";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ams_ps: ams_ps@ffa50800 {
+			compatible = "xlnx,zynqmp-ams-ps";
+			reg = <0x0 0xffa50800 0x0 0x400>;
+		};
+
+		ams_pl: ams_pl@ffa50c00 {
+			compatible = "xlnx,zynqmp-ams-pl";
+			reg = <0x0 0xffa50c00 0x0 0x400>;
+			xlnx,ext-channels {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				channel@0 {
+					reg = <0>;
+					xlnx,bipolar;
+				};
+				channel@1 {
+					reg = <1>;
+				};
+				channel@8 {
+					reg = <8>;
+					xlnx,bipolar;
+				};
+			};
+		};
+	};
+
+AMS Channels Details:
+
+Sysmon Block	|Channel|			Details					|Measurement
+		 Number									 Type
+---------------------------------------------------------------------------------------------------------
+AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.			|Voltage
+		|1	|Battery voltage measurement, VCC_PSBATT.			|Voltage
+		|2	|PL Internal voltage measurement, VCCINT.			|Voltage
+		|3	|Block RAM voltage measurement, VCCBRAM.			|Voltage
+		|4	|PL Aux voltage measurement, VCCAUX.				|Voltage
+		|5	|Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.	|Voltage
+		|6	|VCC_PSINTFP_DDR voltage measurement.				|Voltage
+---------------------------------------------------------------------------------------------------------
+PS Sysmon	|7	|LPD temperature measurement.					|Temperature
+		|8	|FPD Temperature Measurment (REMOTE).				|Temperature
+		|9	|VCC PS LPD voltage measurement (supply1).			|Voltage
+		|10	|VCC PS FPD voltage measurement (supply2).			|Voltage
+		|11	|PS Aux voltage reference (supply3).				|Voltage
+		|12	|DDR I/O VCC voltage measurement.				|Voltage
+		|13	|PS IO Bank 503 voltage measurement (supply5).			|Voltage
+		|14	|PS IO Bank 500 voltage measurement (supply6).			|Voltage
+		|15	|VCCO_PSIO1 voltage measurement.				|Voltage
+		|16	|VCCO_PSIO2 voltage measurement.				|Voltage
+		|17	|VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).			|Voltage
+		|18	|VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).			|Voltage
+		|19	|VCC_PSADC voltage measurement.					|Voltage
+---------------------------------------------------------------------------------------------------------
+PL Sysmon	|20	|PL Temperature measurement.					|Temperature
+		|21	|PL Internal Voltage Voltage measurement, VCCINT.		|Voltage
+		|22	|PL Auxiliary Voltage measurement, VCCAUX.			|Voltage
+		|23	|ADC Reference P+ Voltage measurement.				|Voltage
+		|24	|ADC Reference N- Voltage measurement.				|Voltage
+		|25	|PL Block RAM Voltage measurement, VCCBRAM.			|Voltage
+		|26	|LPD Internal Voltage measurement, VCC_PSINTLP (supply4).	|Voltage
+		|27	|FPD Internal Voltage measurement, VCC_PSINTFP (supply5).	|Voltage
+		|28	|PS Auxiliary Voltage measurement (supply6).			|Voltage
+		|29	|PL VCCADC Voltage measurement (vccams).			|Voltage
+		|30	|Differencial analog input signal Voltage measurment.		|Voltage
+		|31	|VUser0 Voltage measurement (supply7).				|Voltage
+		|32	|VUser1 Voltage measurement (supply8).				|Voltage
+		|33	|VUser2 Voltage measurement (supply9).				|Voltage
+		|34	|VUser3 Voltage measurement (supply10).				|Voltage
+		|35	|Auxiliary ch 0 Voltage measurement (VAux0).			|Voltage
+		|36	|Auxiliary ch 1 Voltage measurement (VAux1).			|Voltage
+		|37	|Auxiliary ch 2 Voltage measurement (VAux2).			|Voltage
+		|38	|Auxiliary ch 3 Voltage measurement (VAux3).			|Voltage
+		|39	|Auxiliary ch 4 Voltage measurement (VAux4).			|Voltage
+		|40	|Auxiliary ch 5 Voltage measurement (VAux5).			|Voltage
+		|41	|Auxiliary ch 6 Voltage measurement (VAux6).			|Voltage
+		|42	|Auxiliary ch 7 Voltage measurement (VAux7).			|Voltage
+		|43	|Auxiliary ch 8 Voltage measurement (VAux8).			|Voltage
+		|44	|Auxiliary ch 9 Voltage measurement (VAux9).			|Voltage
+		|45	|Auxiliary ch 10 Voltage measurement (VAux10).			|Voltage
+		|46	|Auxiliary ch 11 Voltage measurement (VAux11).			|Voltage
+		|47	|Auxiliary ch 12 Voltage measurement (VAux12).			|Voltage
+		|48	|Auxiliary ch 13 Voltage measurement (VAux13).			|Voltage
+		|49	|Auxiliary ch 14 Voltage measurement (VAux14).			|Voltage
+		|50	|Auxiliary ch 15 Voltage measurement (VAux15).			|Voltage
+---------------------------------------------------------------------------------------------------------
-- 
2.1.1

