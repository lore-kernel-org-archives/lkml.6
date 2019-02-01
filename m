Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5C2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="y4y5Zheb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfBAWJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:09:29 -0500
Received: from mail-eopbgr790052.outbound.protection.outlook.com ([40.107.79.52]:54240
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbfBAWJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rv08A0eLwyaLrv3WAXSTZ9hcVX+PCe9xJNqFuJaFzk=;
 b=y4y5Zheb9lvTRXujjEnAWxDmN9yOG04Tal+7UAsW/g9WGhwSzD41oP9QgL3uiEFsAXp24TiyFR2XnixAkfMF0qa/XUkrRZjblp9VBmiKSun7tFyUqm6zG/Msw6+yOXetSsjJjTwlCHiD3rxcX1Q1CUeaPh0U2u1T4TvNUXzOvaY=
Received: from DM6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:5:1c::23) by
 BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:71::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Fri, 1 Feb 2019 22:09:15 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM6PR02CA0010.outlook.office365.com
 (2603:10b6:5:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Fri, 1 Feb 2019 22:09:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 22:09:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzq-0007Tt-Bv; Fri, 01 Feb 2019 14:09:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzl-0000P8-8b; Fri, 01 Feb 2019 14:09:09 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x11M8w7Q027117;
        Fri, 1 Feb 2019 14:08:58 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gpgza-0000LK-Ht; Fri, 01 Feb 2019 14:08:58 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP power domain driver
Date:   Fri, 1 Feb 2019 14:08:47 -0800
Message-ID: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(189003)(199004)(72206003)(8936002)(39060400002)(478600001)(305945005)(16586007)(110136005)(4326008)(316002)(7696005)(7416002)(106002)(51416003)(107886003)(48376002)(14444005)(81156014)(36386004)(50226002)(77096007)(8676002)(81166006)(186003)(26005)(50466002)(2201001)(426003)(126002)(6666004)(2906002)(356004)(486006)(44832011)(9786002)(336012)(47776003)(54906003)(63266004)(106466001)(2616005)(476003)(36756003)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5016;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:Hxp28AZYhmsRyXppU9HaFPhpt1AL+TGAP+0DXKeQWBQBohN5OpTa9O6VHDQOz8IvyuqTyZn5Fx6NTpZmq2isiRLdWWh7coV1zifEqYC979GBI640MJKJe8aZK89O3eRgifn6JQFl+sZ/OKXCX9xj6lOhFtrTnwDXs9snKzO3WDM=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eae3b530-d734-4808-8bdb-08d68891e744
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR02MB5016;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5016;3:QZTSWWqXVT2vTTWTRSZVmxXBpg+3wujce9cpV9ri1FlRgIKru1gItvL8ZHFcgIh5XPX5ULKd+prM83rB5YtAT1nx7VusBRTIhRnSOtN9gk7L3rJI/7n1XCAuNAiglrXHYzi6TCwB4V0epSFEFA6xJzhWG8IgrRPs+ZZfnFUlhZjWgH57zwJi2Y7UYv8J7aRD/YA0T7qJ5cYiwtD68d3UrEvoPil2pTuuHg+1LfWFJsqAy3E85iwf3Vb81Sz7aBJFHUfLa+5DpUIQ3dEV20Meq9q+/4N6faC2oSn2cYQCDj0FFR0/lslqgIgWvOiLq4r5ub4zyUtChyY7VlA+oQjBS86BrKIWj5UBl5jF1Le2mlTnppgnRqOvLINimC8980s2;25:wR+Fhg2zZKanauYyq/41BZ9M3oFhy12TvTfIJ2Fbi4l0PRF92VuzVEGxrrb73UPeQfC4bq6CZcJMrqpidJYWw/A9DRnpLf/RavdTztfyr8CJAAR1r4DE8ASJJnk+hX0kFOTewouumaXpQg19DqbYjTcC042jWJlzD5q1EVpjl7dl31/kW+0JN7ryloz3fyNmJFdRyKbWWKiMR+iCkJIateAnZcxS578KZDoC4J+KFzV92QZpMS/Cazbf9q879fCEDNRVPlajSZ1+3WL/3konrrWTzkWUoJLZP88Jri0pm2eW/XiJhM33dB10k7soHmNVldKtl3kHDCts2yPH2djrVQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5016:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5016;31:tOwynl7X7FAqoyTHUdvwZRNNRML1AOla7nAfB9ehy2QQ3mHAUotUZxxWZ7YH+S+Y/g8bWDsC5d8eOsnbRKgriNt5vk8D0hxzGCv2l/jh68iLqYqHwAJNBU/6kKxn1ngyOyqueaDLNNtWiPuJD4KV2EDE70fpeOPS8mL6lQAYs2s5gifsm4G030+durqWSJLDJx6P7TT4noAuvwlFW8DCEthsF+N6dWH/i3ZLpJNT3SA=;20:KwsVz3HPei6B0wfTKJ5nRsBnUvtmYAKCxzVMoR6XRJnxhmAFE8JiwP2PGRAbGVCIQrXB8Vz8rz7J3OCGVUZYA2VmmlziL7WWFt5pLQtDoG5X+jqMaJACVKJ4fGZmpEiFvQ1kTZYDzRdXgVfgUmcaUZGzSvBfOCA5G9dCWIJBzaVjXvDXF2gsZFKwOpsbbVvWk2bjVTeo8HhjT/2UNWfxbzXlnnxcE/VqTXNG+LYbD6js12OJijn35RwxQi+tNLmDainIwaBIqA/CB/4kvEVN/v0gBGviNGwQkb2NwCf8ICck1hMfztrjR9eaJ1mJf+ve3lt98SvES3QTGSXN2LPGra6Yk0r1TY2LK3btttq/HzUPT/58tb1E04RfDXsfjsS9OpcqgY5F2SdqQ1c3+tu9cKJitgsctqTb1MTHsq/UAikNAe4nOyUAJqwuxVIyenqSjxeKNRElFJY433xe40xiw11Cu54zMg6XWJYDVR09vlLutxqzgdTxTNkiR22s3i3l
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5016BF7C9CB9D82BEF777DBAB8920@BYAPR02MB5016.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5016;4:k3Hb0DwnqYHwSyVlyEPZJrZ8F3nx6NwoUdd7eb9z6tT6E/4OKEuHHKszvU2v8peZXWsNi0ud3yFEAgClPAQYWGQSfyQxOtspzo9G7rIesFIc27tzHhUNIPF0w1JuXtSov9rt3gvrpUmeg+4sEflYEcG/9lY5vqvNUw5ehuwhApDGxeMyFrlkosSZNHbbS6kRve3GMPyflMMMsln2+i43zgLfTYlA/guKSUytTOi0B3IcmyDbiXemK9bikW+QYznpCe43ROm4zTnXIv8+kJH5RM0w4zxnorLvhJS7v/TkARE0CHDBOnbc8/y3//eHLpIg
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5016;23:3OP2eBJPfmyA6+RRyeTl5QrFmp32a6ublYUaDsoq3?=
 =?us-ascii?Q?mIL3nbOXFeSsFq5yTOGJxHxRGbFWaluZjBRpMXVLtuWufI3NU+WQlrStml/V?=
 =?us-ascii?Q?0VRJimpTa6LyyZ4X9K/j9gWwCmrC1qIOcao8+eTAqcuhIxvKhTiLVTmWzbw2?=
 =?us-ascii?Q?Wa2DgWEZAB/Uw0unywp3sWxDUVTMM4dBWRP1QKOgWorG90mn+TEZRinmoTEJ?=
 =?us-ascii?Q?jUad+nCSSRg2UEOD0v96qO9hBAYJBVFtAR8sKDalCgGXiNCjxcKUTPn/VsrE?=
 =?us-ascii?Q?rMtEjXfg6KDmKthLarbIzIkH5uP18xZbw7XZ0N8IRBuOj6lile9L3p94VETv?=
 =?us-ascii?Q?LApTdvrLGwTW5pbmHQaS03UUkYrfC796XUWf9C3Xe0FrcaWoqSSk17D9zDMf?=
 =?us-ascii?Q?tYH/bysiFmDexX5Rq5VAOVc7qE86bJYzpCXCn3xfzW+whVMd5SfUlWT02XDw?=
 =?us-ascii?Q?tk7IyjvLaKiadmvL0aifr3nqA2ZyjXRRKwoB9i66JIE/gMEC3lX9hM2z8ubC?=
 =?us-ascii?Q?bSWqtZaPYHwdSCHh6/DppQyJ0cIM/c7cHI72MhhN1Q/r8fKsPlpsw3M4318C?=
 =?us-ascii?Q?PL13RiaU65VmVDU2kGjERx1vkA9n0LPwUpo+UClYRoXEPXT4oi/dQ1DA1ppq?=
 =?us-ascii?Q?QT6EZXHftqRpdfetLLBvgQtNUPQvYYa2YxSkDdphEqsYJJVgj4rdoecYhmbq?=
 =?us-ascii?Q?5WVy9q6kPQo4ADEOrylP7L7pEcMfNqmMprZIOTnstw7B7qUOKiqBZGmRJtyq?=
 =?us-ascii?Q?ZpQEOB7XlBL55KjlzY7AwUEKvxJSu/iKkuH6udpm3wGPi3r0iCiAKlSZ5OTX?=
 =?us-ascii?Q?AAzDhMfaHjHZo/5ey+w01XT3aVQbEEXQEFcf0z7i2vgDLkhfZt5YpT7j+PH6?=
 =?us-ascii?Q?mb3z4vSvJ6+PLRhLisXInSET96KVVQEJ1gGOKJF6CXeZ/UucAXNOR2/FpPoa?=
 =?us-ascii?Q?YvFLC1va8f25+aez7bkS213gu9fPwXWX6prOnHkWi/a0hTg46KRTK4Ep0n+G?=
 =?us-ascii?Q?Jqi99PyajRq8q4RKjzph8Aaw6nMQxqFHAPrFVjnb8KD5X90Vb3stXifRI6qP?=
 =?us-ascii?Q?+kxaDSyCDPlRCtQu5tP3UOBRnR31ZcSp4Et5UjTc11OtYcL8eZJO6EwgGVHA?=
 =?us-ascii?Q?D3nXO29zKfw2EjcTyQJQnhNpN709uay/9Ss2nFgt3W3JfGtg6dbbLnpLd+jN?=
 =?us-ascii?Q?SuKRTw1MKMrO869g/X7Y4/X0I99i4YJv7wm?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: L62bjvg2i6O6+DIjuaxT+NCMWkmcH4Bx2SCNVThJQSHrNq7FSNkAvne7ip1gfiKsfn806tnZdhYTZFe0oIbmGC2MpIIsHDL1WvZDCw4JNaWVNG2Frd1KjfGZxG7PNKb5qXUnsuqsN2/I2dYir5DVNcHQGceSKHeKxqfcCxmC3goplSsOD4bhf8STtc7w5bfmLVXdWyxlJv3NLsEz3HhPFYbFIcxhtJNN6hSWrLlYGvV2G2QPGRn3lcmFA+yJsZPrKfn81pfAXaZjhHVR6zo8gwrlhVXCMoZRULy4RZ94BvCKMK6Pua0sWydtmTRTeStFAfeNrltzBWQsNIdYyY2WLyIxV8JCF6X7+3eN5hIMvnicP60jEsN5YEoOsV09R8glGshXvXYRKqzoG7qojKFW7Ez0wQfPX/WITSKBHDc8nF0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5016;6:w5bfCoYk0zXpr5DMEF8JNEW3QStiuGKP0IS+ML4hpKo+D5T0NtRHhyhp4F6XXm45t5xWfyf1GuMZZAbC54XlAMtW6XG41H5xmpsDOp2fI++ozWmtaN0LoPEhj19sC5ZZ4W/jicyV4ss05Yg2GcA6geIRAGH/ut1Q5yL2ZABfYY87ieSAJnyA/KTMYf4TUG9GtWT4SNVzgDRqowGAW0G4+SF+kDGbU89xDyQQ2rvUDzaB+YVrtWc+k0pnHwiTGZkoiLklkkbZ5t7qqA9M3eEbL4CNggK8WjrEouz0rzU1W8AUWASYyLmOXABll2wW+YGDw+0dVwCiM9xjHuMp3lHbsTdwHEjAr9LSpxizg2LjE3xU8J5fJgyQMMcdm/uH5OJKkswxCUraDYMg4Cg53P3d04pLvlkRtkmREYC2A/lU/n8jFbfJO3R8yhDsCZHPRIZx5JcqlGk4UxK3e36DQ2tKUg==;5:Unz0rKKU9VyeaLIHTu0tTDLXSPUxJ+nCfKKcW0Mcj4tiTix0/jxCHAgRzzOOcr2enz5uNVLu6fhHwvClVhbWF7895y+hh65YZ7sd4GEoylBbOwsLjAoQnoa8tzGi6N4v9lGHD0okaqeUWalvX0w3ljGhbEypFXTSL9DA06+ixHegKWB+dPhdhH5WCxV/MHrue/JKpZfbRFS9yUWaffLNmQ==;7:AKu8KhHtGn+RMZswQIHBag1fRkpNnmm2XifGisUBxVA6w8kU+4vAqZtsm1b/Z71bwaZc4iVP4GbA0MgCSoYFvAPiY/+F5Ju+D9crRRb8/EkC+6gB+/9YHPGZAgFwLGnMeJEDoNbJabjWQA517bUjvg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 22:09:14.9416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae3b530-d734-4808-8bdb-08d68891e744
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zynqmp power domain driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

v4:
 - Added reviewed tag for dt bindings
 - Remove local device list for each domain and use list maintained in core genpd structure
 - Remove hardcoded pd-id to node ID mapping. Instead use argument passed in peripheral node as node ID. 
   Firmware would validate node ID when APIs requested from genpd ops.

v3:
 - Changed binding to have FW node as a power controller as suggested by Rob
 - Updated FW driver to register it as mfd child devices from firmware probe
 - Move bindings location as suggested

v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver name from zynqmp-genpd to zynqmp-power-controller
 - Updated device tree bindings to move power controller node under firmware node

Jolly Shah (1):
  drivers: soc: xilinx: Add ZynqMP power domain driver

Rajan Vaja (2):
  dt-bindings: power: Add ZynqMP power domain bindings
  firmware: xilinx: Add APIs to control node status/power

 .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 +++
 drivers/firmware/xilinx/Kconfig                    |   1 +
 drivers/firmware/xilinx/zynqmp.c                   |  73 +++++
 drivers/soc/xilinx/Kconfig                         |   9 +
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/zynqmp_pm_domains.c             | 321 +++++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 +++
 include/linux/firmware/xlnx-zynqmp.h               |  26 ++
 8 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

-- 
2.7.4

