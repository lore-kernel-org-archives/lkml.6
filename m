Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04954C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27220838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lgAVLL3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeJaMhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:37:15 -0400
Received: from mail-eopbgr820071.outbound.protection.outlook.com ([40.107.82.71]:21856
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729218AbeJaMhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lm2ACSv9DkWWCCpI8FXPi50htKXOwwti889tAr7S9Y=;
 b=lgAVLL3opzcB+55J+oVgnJsxx4I7jxl4xAiJX5p7agSR3tVHBc1pTNFFackwEoQhwUpqn3PPADv3Zdg2+jafMFtgxcCJVw7jjHP09zzl1q5utiUSnaJnKhXhy8twq7dztWvtsZjQizJgwIvc5jsmRpGAkGh0Jv2tA3vNLHoapd4=
Received: from BL0PR02CA0090.namprd02.prod.outlook.com (2603:10b6:208:51::31)
 by MWHPR0201MB3513.namprd02.prod.outlook.com (2603:10b6:301:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Wed, 31 Oct
 2018 03:40:58 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (207.46.163.48) by BL0PR02CA0090.outlook.office365.com (10.167.182.95) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21 via Frontend
 Transport; Wed, 31 Oct 2018 03:40:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 31 Oct 2018 03:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhNH-00012N-UP; Tue, 30 Oct 2018 20:40:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhNC-0003BS-R6; Tue, 30 Oct 2018 20:40:50 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9V3ej68010811;
        Tue, 30 Oct 2018 20:40:45 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN6-00036w-Kq; Tue, 30 Oct 2018 20:40:45 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>
Subject: [PATCH 4/4] net: macb: Add support for suspend/resume with full power down
Date:   Wed, 31 Oct 2018 09:10:23 +0530
Message-ID: <1540957223-30984-5-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(5024004)(47776003)(356004)(14444005)(106002)(77096007)(9786002)(36386004)(76176011)(478600001)(106466001)(5660300001)(2201001)(6666004)(36756003)(305945005)(44832011)(54906003)(2616005)(8676002)(446003)(50466002)(110136005)(11346002)(81156014)(81166006)(50226002)(51416003)(426003)(186003)(476003)(48376002)(336012)(7696005)(486006)(15650500001)(63266004)(16586007)(2906002)(26005)(4326008)(8936002)(39060400002)(316002)(126002)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3513;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT003;1:sym9oOuBYU7ajn3/fxV6cQ/UW7DdEcRwyz3IRBTvbNRWN6k0FNqGdRv6ESp1IMgAinztZVG0UsxnST1v643n+LJLtQh3O8gMQ8PcElOUL7YZEuWi+wcFc3GU1TiKHeN+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30dce376-9760-46a0-f9e5-08d63ee2aabd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;3:ILSRWfc+O9MrI9YDrtaUM8VhVqWURRB/mkQXDmLYcWdOFdyp0OiT6jbbYFDo3hZ8BolAOZehDpzm05WkW1mT7qb5UUQXMDQacGV6QQsit+Z5g2uR4H7ftMfzoGmLKR0Fcopm1a0DYoQfWb/lJlkYrs/15SeR1DdZX9HMrOTN19qVJBmt9WseeeqEOptBeMQQ7BSGbPhvX7aRAFULs68V9jdY6XfNH/jiiq+nomrAy0NzIGFrNFyWz8I17cwz//qCgyHlJV+pdoV8DBrCCtXwDoWah2L6Fujk0LtbTdJLA7HAFxecsdaVfr1uxtVBZfQsPDCfeR965k64reVN7arD7DN8QMfjBRvZeqrA/gKzy2k=;25:JzEsnGg9Ro1wUbyNdB6FM1R8B2BauCH1zJGNE2XJIjdmF28fges6XXauZa2sNT/QFyK7upqriQtV/YVbNTWQN6MDVkhWiBkNOTD6L3O6+i8exafMzl6mm78PnbQVwLVCoU5qA23i9Lu4Zbc3wECs/7lj73AnGOFR9ji2GAZ5Ul9GEYDBtzDYvttgqL5IQnzlzBW6s1svCtnYOre9ireAYQr4bLRULXg61PO3F0PQrPQAo7eu39jjUHbVMum55nsGVeXDrl9A/o4z3+JBaxzTMMv7TnUNYNpUU80Sbqmr9GHrlDVu0G3H6HHV2RxpB9ZA6ZEgDSVMTH/rc8vxq1IIdA==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3513:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;31:vTglp/nwOGudEM7P4fl5qSbI/3BbmolP4Apay1ucj/QkU53qgxq4hoIGB98mMYGbGIpyDeiUTKy2XvDVvxuAB/BCJjl4/ko4SONZo3Ca3nZWVPbcQQWl5G72xkm9TnjR0VIktdql/QYCd8vNh2BS7nYFX5yHS2cjL9BPxI8zB9j2SdWfcbj4fjpWIWvbXP74auHjQg+Achpo1XvouAstUNOP4GV0Bip8XilZaESvflE=;20:yzQRyum3d3PoJdDremY8aiqlomDjwoXq554UXRBI4FDxClyH50vXEbDkxbhcoUpdgtWvRsMnOuPpSEyL0V2MBTNwJk1T1cileTJgiWzQU/lCSRrD2WlXqIsuW816LRxTFv0gudxawS7ZXdpcV19oq10fMAnvDm0hdSYcAdKwQjIcoKpNSSEeM8l74JLalGjq66eFuQZUJdwow6uFp5l0rTXCx+p12mT9lfJUdQkFnuCUND86gnIU3nHI83xV9vua9F7EcWYdAIfkb/E1cbX62FR3Lk8E8f2VSHImfJuC7miMSB//I+3I7xjQqD5W5AGfw8dugQrmxWJ9MM7nSWLO82qlrkMhynARLCBMpPrpmeolVwb4brkq+NEEk6BygLar8CsnO652ZTjy6+qYly3OG9gUmgXGrsDwBZPPn7D9tPoU4cuZN0CLR6MqcFBVm6TzpxNNd9W7IaMrM9RlJAC35BuowSzQ/2kEIqRp3GtSqwX5qrPSC9C5/KnyrT7IRUn5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35136F6BAB0A9176B886C1B5C9CD0@MWHPR0201MB3513.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3513;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;4:v5uKHq1UANDMdio1zwuA9ICeCBjCEyqpRREkTnQ1nvWvwmEsp9SbyJN6A9EbTcSDcAAtP9Gdkf0kGV0EtKX/0RjYHTC6Xl8ZJJtvB8ZC/QKASQKyXTvLVBmcD5pr74SyHdF7qsAsnBgTa3H4urERmAYV3AChidNIXJ1op0Vc29V4OqRQF0lCootewU1ufmmsskp37JY8G68avP7YWj7l/VbH+z6Z6gFlhq3Y0cC1XaaSV449Wl87v5rbAtsp68Tu7ov5dASH1gJdf7p8woUFg6gvHNMLnMKnnW8Tn3vKxU5hjWBe3lgbyJ7dziSyBeOr
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3513;23:6/FuID2e3X+gXQMe4kvcdi4pjnL2TFZ/galpuIJ?=
 =?us-ascii?Q?n3jRWciGxkVAI9nUZ5H47pyKrdWQVtD4mR6Tlt6NICttpFubllTexaTAmFoP?=
 =?us-ascii?Q?UWR9DP6GiXlcDzx8kgGu5lEyjhCBo7dSe+IhJsF88DwCdXmzzn9ljmCyqsmS?=
 =?us-ascii?Q?Lldbj5gsNMPLi5QZRGWqVznNd/U2akLTc/kjgrBX+I09hxTjyTBBGejfQQHM?=
 =?us-ascii?Q?bZAmu/znlQuibbCgRj60be5P1i3Pm5kvzk/DTGZYLinrWx16L/FuE/BYbvUO?=
 =?us-ascii?Q?ZXAbCFv2+hScGS/oJ6z0eUFTV0NvzMdoE+7Pr7dQuOO38kEPEpEU9SbBgfMW?=
 =?us-ascii?Q?aAfEEa5CelG3zoekGaXJMb3NuDz/Je961o53dQEb+XO7zDMpybhE9VoaDKeS?=
 =?us-ascii?Q?FQHtk9wPKyqNUrO7e4MLpJ6VbB2twT7wvSoARMwi/zJlTNmYLVBwFqdyXtIr?=
 =?us-ascii?Q?604GkOy+ewSj7Olj8tCK9LA0xCDCxtk+M685/dNEwlRdq+Q6OZWV7LUVi0im?=
 =?us-ascii?Q?h4wZcA5793bTc/FgqZLEhJv6F8Lm375N8EUzyhp1Waf9T/k29WDAEprcFzZI?=
 =?us-ascii?Q?8kW/PWcLtD5LPKPyoR0fR4L8SuWPvQE77/TMvo+ErIsSzrSHRtc0PIE6AjMN?=
 =?us-ascii?Q?TMcO6sJG6oI99G3Zn8K3611L7sGldffMndp+8tvyEe3rXrDETibpOmoQ5NyO?=
 =?us-ascii?Q?A+She3YXKlSj6eY64Lo+Gqe8G9EECjiK3aUi/nvoJkSILE1XH8TMzc/AOg6o?=
 =?us-ascii?Q?5Sw9c4r/+ovcmu7cpwfIYie3MI+7Bo9d7Q2ZXZGzeqc8ToLBMBguJQPg9N58?=
 =?us-ascii?Q?x/MWEagFxNxbQbKgVwC6RLy5kwSM99DagdRdX0rW9bP8ngTMmGhzUyuZ7jdD?=
 =?us-ascii?Q?5yc2a9wsX3U+enZsr51QrYJeZRPO+5O1lkhGZEUoMCwGKJY856Fmxw+paJJs?=
 =?us-ascii?Q?wT9gWGPa5QOGb40eBHt5958ds7DZt20nYwyB/fL/UBpcq4Is08PBcDhLX4MX?=
 =?us-ascii?Q?4ctOlpeevhfsxenJP2ecwv/U1rPTQ8ouMZhS1u5eXJEJdR7hvH2IjDJA+ckg?=
 =?us-ascii?Q?qMx3kqEmtCM2n64X2UHeqF9N4BzhqW0Leqws01coToyeDii/LRBHGM3CW5tZ?=
 =?us-ascii?Q?6fyrxn5Sw9g9L/Zcoayr8SEcSVaqOpCFxKhLCyVmDtOyoU3ZGhxUb8YhyDIS?=
 =?us-ascii?Q?oikCvMSsTyW1Qovo9iCckyCRDysoJ7ZAsFvzagRL9j1s4Qu6ts47m+5Vekw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: kskDh5ztvKY212nGyGCYZyXxEbR9wJEY4iH8dnDH1rpGXoDHq/bKSE9laoDxhgZq8hegYxf4PLYeVFdaVeQ7ToN7Nqx6PaWilaKXmr/8RudLJR1fFxHGDd6Pp0YbatjEJd70DCEZisZF1JGmQ//u1JTYr3Nj/wyYZiuYQIhv7jIat+HpJANvX2FrxRtmVh+IGNL11Rx4HhVHklz2g2Wcy1Q0ebeo9O1IbWCh1XAuOAbzkB5fxGtraPyTF48RrUAQof5hGeuM9uGnD3fVe5OAv5ufX3AY7790GlAE/geaa3nek1w9RzLSoCwEb+JxhNy/ujcuvRwcHTMFHPI9pyj9X7vvpbELiAoFBAVaYQYU9ho=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;6:CdLEbLle6a6B4HTD9JewTYXrcXg9knCiHpfbSS0n4C0nEjuP9IMsZfG31w6Cu6znZdNR8QtFUOqdK5WKJmCC8gVbt5vME1Sqr0T8tHRyY1z/zemwAfs0/IsaOx7lw8NUqCpgpW3nERwsOWDnRTpAcJ2HAcjUR1xoT7OuzyVbOk+f1n5gZ/0d8lzLTepX8ZWasVchmMCqPVVKqyfEtEos2s9+qEHrSakVmwcPf59noOwK7XY8HKAmCGk/6fdf6YpVIZF6oipWgflZ2UeVG2/iieTgVC2ghM9paVnbylha8gMFXv9gHHaqxhlylSZZvRYDuXPxjwbwzRspCRa7b+pW6rwyio/XtfPRU09uyKMpFJlAZ+J/qlvujj12QDCRO1Es0gK3FQk5GnkoZDQMrgEVWoZIb2sNSMSg0SbfBl8v16tZMOokWQJAjXehkjxDrD5QzNtyfcgJ2QQqNodikhZa9A==;5:jswBoYfB+jLBjAdnb/Zdnn7SyXabcnLsfu1e9+sHLjr6xfVR2kxeQ3I8Ke4ugR3EeWqiC78AJzlOC+kcrrMtF2wQF4n3HRTsnEjEKvZ5fsPQp9gdSCxtlXsotglMegB4NV5W41TFMq891Eari3R+aRysKwht7IIPR/aq7+TAStg=;7:C7FkjqRsx5NXvGF96FMAqXUCLMZb7o9jnywERIfMV6spUKRuUOWuxU8aPe1IvyKw1nwm7jVDQiFVd7aT4Yg5HJK8zDIW0r+XuiBFk1nCwDIkbVXBNo5nD/B1l2buITwnVJbdGoYzrtTB/Zrzf88zdA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 03:40:56.3236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dce376-9760-46a0-f9e5-08d63ee2aabd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When macb device is suspended and system is powered down, the clocks
are removed and hence macb should be closed gracefully and restored
upon resume. This patch does the same by switching off the net device,
suspending phy and performing necessary cleanup of interrupts and BDs.
Upon resume, all these are reinitialized again.

Reset of macb device is done only when GEM is not a wake device.
Even when gem is a wake device, tx queues can be stopped and ptp device
can be closed (tsu clock will be disabled in pm_runtime_suspend) as
wake event detection has no dependency on this.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
Notes:
I was unable to do a full macb_close/open in this patch as suggested
because it was freeing and allocating the full RX/TX buffers and
this time consuming, also leading to a crash when done continuously
in stress tests. 

 drivers/net/ethernet/cadence/macb_main.c | 38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 09cb4bb..0d1acb4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4247,16 +4247,33 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned long flags;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
-	netif_carrier_off(netdev);
-	netif_device_detach(netdev);
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
+		netif_device_detach(netdev);
+	} else {
+		netif_device_detach(netdev);
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_disable(&queue->napi);
+		phy_stop(bp->phy_dev);
+		phy_suspend(bp->phy_dev);
+		spin_lock_irqsave(&bp->lock, flags);
+		macb_reset_hw(bp);
+		spin_unlock_irqrestore(&bp->lock, flags);
 	}
 
+	netif_carrier_off(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_remove(netdev);
 	pm_runtime_force_suspend(dev);
 
 	return 0;
@@ -4267,6 +4284,11 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
 	pm_runtime_force_resume(dev);
 
@@ -4274,9 +4296,21 @@ static int __maybe_unused macb_resume(struct device *dev)
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
+	} else {
+		macb_writel(bp, NCR, MACB_BIT(MPE));
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_enable(&queue->napi);
+		phy_resume(bp->phy_dev);
+		phy_init_hw(bp->phy_dev);
+		phy_start(bp->phy_dev);
 	}
 
+	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_hw(bp);
+	macb_set_rx_mode(netdev);
 	netif_device_attach(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_init(netdev);
 
 	return 0;
 }
-- 
2.7.4

