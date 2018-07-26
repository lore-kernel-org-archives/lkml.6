Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43ACC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vfcffyIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3809E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbeGZOZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:25:59 -0400
Received: from mail-eopbgr720087.outbound.protection.outlook.com ([40.107.72.87]:34777
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbeGZOZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYNp2fPaXMhl4EzTIBRAkw75uN6SPlzrIk5ALQch+9o=;
 b=vfcffyIpEl+FwLiQRZcZ3H7AsnVfFMwkyV8ebVIIgwc8EBYbkwNv0hxkwcpvjVQpUNOjbax1XKXf+Zco6AYT5QuDHTPcehbk4O5+6oS55RTtJPW3Cxxp7/v1tGpORQ7eBc+ra/7ekBRcvI2lWwrHXdPtHpYrJ5kjUhUh+oaZ0Zk=
Received: from MWHPR02CA0040.namprd02.prod.outlook.com (2603:10b6:301:60::29)
 by BL0PR02MB4452.namprd02.prod.outlook.com (2603:10b6:208:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Thu, 26 Jul
 2018 13:09:06 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR02CA0040.outlook.office365.com
 (2603:10b6:301:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Thu, 26 Jul 2018 13:09:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Thu, 26 Jul 2018 13:09:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45150 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fig0r-0008IR-UO; Thu, 26 Jul 2018 06:09:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fig0m-0002AF-Pf; Thu, 26 Jul 2018 06:08:56 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6QD8oOO028514;
        Thu, 26 Jul 2018 06:08:50 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fig0f-00029b-O0; Thu, 26 Jul 2018 06:08:49 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id DFC9A604BF; Thu, 26 Jul 2018 18:38:48 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3] usb: dwc3: core: Add quirk for enabling AutoRetry feature in the controller
Date:   Thu, 26 Jul 2018 18:38:48 +0530
Message-ID: <1532610528-7290-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(2980300002)(438002)(189003)(199004)(426003)(90966002)(63266004)(478600001)(50226002)(8936002)(336012)(551934003)(36386004)(50466002)(48376002)(36756003)(4326008)(39060400002)(110136005)(2906002)(476003)(486006)(6266002)(54906003)(126002)(16586007)(42186006)(103686004)(47776003)(2616005)(107886003)(356003)(316002)(5660300001)(575784001)(106002)(51416003)(8676002)(81166006)(106466001)(186003)(26005)(81156014)(305945005)(52956003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4452;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT063;1:XTLd72V80EQlgf8Hz1M0w6ol5m9w8CrVlRYx/4kx08ll26rSCiv2er983X86q2IzlHQgSnZ56UQIpu67vPZaG7foXPxatNVhw6bhyPgRjwyxdygdp+AuRtBZW0GN3jav
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01149833-b3ff-4ff8-937c-08d5f2f8f6e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;3:Bg1JrR9oedlQyiMlnSaag/yuvsKZmrweXTaWy034BiO+mEK4cnZmYC9kNYRAExzQg6uPujiQlq6R2L65fHDTTaDPlJGU7IqSY9lNvHwzjSN+IiScixfSXSq5uaHRs6Fb3Am3fHkoOYrLjx4hgnNrDWdyQourhdIHDNTMY9mW/HoKbf7e1+VweYOG+iOrKqEYKVVZiY5GZEtdQNK1UPMyJT65kwEYN0OsUF8DRPYAghFNQ6RGAujZW1lN3hGYx5SNnRonuA7CmO3Dx76fZ4yrRwTIc91ylsVkuM+KocNY+0b6jdos70F2dQyUdJwGFg2baqdPsYqyz7T3de5Zojk9UBo8TSrjURX6URZ+1NlBpDo=;25:1ISKXkgY27wnRHaQscrH9DVmPILEXlvtZ0lnFV0tua6Uc3/U6N0YFiBRzYFxIx+WRhO1BBQ49G3FW3XOO74grWKofdmyD3Fyeqes4uhvas7lfYeGyI1d6Mmsiq1NAFeeQQMOEz7IBF1q77h2ti48QTAt9UxssMkiMnc+BDvZJoZm4ig++aPNgRQosPCYSu7TyUlBNoBgKdJ3qFV1wlgCTLq8dlYfzaJhvg9HgJag2JF5rdrxRXpeLT52SxexM+7sMRz/3AfZCe4pLzYwUI5B2b+Rg7Xc2oMRpouvTT5maawoXbSDwR/dCCVXaA6nRbKG4X/6sYsRfBG5hODjS2KLCw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4452:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;31:ZNaa0Kk6DB2tERbkEl9D+PA78DK6OYdPHlXzYylZARTbtSYIP19rYinEOOQughHR7AkOxnigRyqOBg3/+KGeZEue95pByaD2T1X1G4BuiJ0sN6Df8n0mJeUcWfvWnEOSikomxKhWzuXSVhTGf5+JKT/xLDrdhxzkO8V2OCXPd0lk5bmyqMwTDsMVfqzobRS5npRT/wq25nwfWCSDTw3svYEpU2tza0w14vQiCbncSwU=;20:98OtZBUay2ZimfpunPgAqU3iIn+pF9IzMC5gJxpe8HUGIs7lnBJQ7BZrvxyN1dJVfsTvAgL1ZYFdi/iHMd2tSxeB+Acc+L02Blxny/WrHIGtjiTf8fPF5b6zNS8cM/TQq5sgGEkf7+SjuQIOch3NV0P6mFEtCWZUTpwAJW5J3Sz5eb+HkAAGMgezJ2JIOQBU7OMseu1R92tI04aZ9YTBKGg44TL983v4Lp3jCevOljWdlhxquqH/2DC25Cir8oYdfhHkpZZOhBZpatJT33HbutUFLcFj0uiHSg8EhoBUBf55ZGv9m361pHwU95Hs30iwchdIu/Rg+hLBD99rjtXPZ2jV304kvC4lRXdQMntx1t7JDgDNeV8p4iJSWbJiqV0KeiHLN2cSJm0MKggVJvDmXz7R2T5MpvGU9/9fK/vacK3czg27/LGGHpVmXafeIyS7Z4E0fxDZz14R/Ofm1YIJdTM1+JuvcezxSzeyeUObp1ITiKWywRbcu1TPdSWqOjmG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44524D0A469EFEB10CB4BABCA72B0@BL0PR02MB4452.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4452;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;4:+LSkGMwQtXldgNZxNIXB9zEp7vG5kGeTCPHoEB3sh6KVCNU2vUSiTHXTNKNjDchcA3cyofWEO7JyDjhGTE3+hrC0BH1G5+sF8EQUfYZtUfxAqCBayFPDg27dRX7PBN7qLpTsY4w0dZ6ELdEBd4dv9PGsMDCt23zvDqUNTKLN/5HWsJNr3RfOxMuz6sqy/Wrd3pzsiZA4WMm6mxqb03VCO3XiWaIHMBvl5o6HKgNCZq5fa3tbxEK48gghIvvzyZJytfZNBDNzNGiWvgNngaTVhIVWBoVvqkq6h0KrFh1a20zj4yZBssYUoXYRXReexXaf
X-Forefront-PRVS: 07459438AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4452;23:8OH0GnFTRl/XJhxOu2ZowiyaurocAlHA9jLVtyqkL?=
 =?us-ascii?Q?WovyHFKj3bV+2kkjNXtxXFjl4aQNmKzFplIB4QKIV8WnLazGObbd0/Trovx6?=
 =?us-ascii?Q?yKkwFYDWI5TMfDji9xNKY2xwMPJRMXiP8rAdOLMMPE1/986dkQPgMiD06F0L?=
 =?us-ascii?Q?gx0IrgJoPaIKiJAPAb0iAsPh5bPA+2N/59bxnbJHFpbbei8WOA5EP7mZnyyT?=
 =?us-ascii?Q?0fKTX+RBFJo8OF+wWDiIaKz7E2ebEh1mGPuaO9kBUOUjiPIpTmsG9CfYFk1k?=
 =?us-ascii?Q?wSkWuR2ALQWOO9n9H6uricJju0VFOPBwG6m8+1wYDFxg9XffXXyP13o7sdOj?=
 =?us-ascii?Q?ZMf52oqrNCsz4ZaGwqFaJtUcO9wQHfTshHip8JzGF7FW8103fIYOFoM7uYDY?=
 =?us-ascii?Q?bqUjoZ7KRJBqT6Pl5qWCsYlTRzWPbGRBrdmwlcX2TwzaPattD/U1X/AMOzT2?=
 =?us-ascii?Q?w1axE54RfmePhpFInOgUFQYYwOt/0nTIh7dsFcGwb48KsEMI8gp/i1DeCGQ0?=
 =?us-ascii?Q?6rHE6o4kJuiobbaokSrVOnSM4oHRoOpm6bDFES4As0TqFN3iH8KYgNCkuytC?=
 =?us-ascii?Q?ZNK0aU1w2eaT2uaIHzoWnP/PxzDFKTRLeqXLSJL9N4xtAbxCw8T2Ev/C1g+V?=
 =?us-ascii?Q?9rOKvbLS3+4l7jcP9/buf12jTxr2OB8XEJxa4ntGYecQtl0yNGgkGLu3DSkH?=
 =?us-ascii?Q?Yt58EcWmxIdCopB6ITCJjTIVBPKZPsH8si3u7usZNqMyGBBMol1I2SiAX4AR?=
 =?us-ascii?Q?BimrmalAvXtnOPCSmbLIiUHcrbQixHfHY//4TQ46EKs9/fx0go6kZ46uz8Dq?=
 =?us-ascii?Q?6TrdWrVhrk2jEuwpDGgJVr9p/GcWtNpsC1eI57DEbDmX3yn81DLDENkq3xzK?=
 =?us-ascii?Q?yxJdtk7KDXEmdELm+CRX35yj+7GeToIup1x6oyOT/z13ctPmO7koh3eoCP61?=
 =?us-ascii?Q?mW48Ad9GZbZVG192aU18OCKZ4Fea95Fg4BmBc+t1UzKwyZrnpCYsB52J/Z2W?=
 =?us-ascii?Q?hObV2wSx8ge4RCNUmJY17NOFLWwoBUt4j+3xJ4+h7eQJFsoxdRuOfPXs+j/j?=
 =?us-ascii?Q?o9YBAFzc1e+OKrTzubhUKeAC7iSiKlyyHgEFYvGMrD//Rq97j/r6c1furwCV?=
 =?us-ascii?Q?aGy0pW86WlsDbWrxLYD0ZhOGsOInIF+13Kn3tTRIOPL/J4j6h6XfA0in50q+?=
 =?us-ascii?Q?EV6Ne0p8MxBi9s=3D?=
X-Microsoft-Antispam-Message-Info: twf6kc+/ozUFHvCYKLAWrjT/+TKxjiJ0hJTvsok3ZXLDx7XKoJ4AD9+QyMUISF5Oi44SSyQ5vcT8FrKY5MwcGB00fBcLbcJH1CaPaR4Wr95U77gGWVmmAV9pUI8ZbOHEWCg3N/oEko6+dbt6/mO60QBFtfHC2ip4vFoZYkNoiS/A+b+trd1vcwnsxe33OJ85Z3RwcgYqegk6zm9+CxZh0ZDI1Gm/bMnqh7KxFZb53D9zVFXdLSD3OGqssNKEdIGSuze2ORsub6j03WytVnp6irvvl9cF0ZMbVUsn419n5sR6HJjCm8dpLUyHjfiPcWV+ltMQccRr6RpbJMMuNmjIt+IOriv86W5bygsqUxvSzKA=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;6:/NPw02ahdw/VvG8CBx6TH3i/h0XRNfAN0IbS56If1jiNM6Ma5xs9c/Fws2f8TVYrOOF6VNcl+SxJymoObpSLWUvfX5/i3RmGAa+LXLwvLTIlUBr9y4Pif6I2bxJPXQUhO0R078y8ODJpLYor2mAtPAPFZ3KiahBbUFj8ci5rBCACDR+fQoyAomTp9shouF48zzG65lAwz/7OYtHx2ruUMQ6qptUIUkhJSM+2Ljlq2/R/6VUZ8a39apOmaM5ZkhpOowE5JVWnutbfMHcowgHw/rQ3QZ766Pf48j24s8dfbQxg0zZH8B8CYCZctCcRgUKA5U05kK9T4SvzIzVq9w0TFGRN/Kt2JMy9VKIhB9hLr6eJdukg4q9+rB/ul3nZrJbbojlTaAmMDuN6rdV/+TXt9apPXjrg8GUHNaFmT0vAjN/9lkuNRwKZGbWv0ZmXZCPwdWMzONb7QFTL1xhLXjZb4w==;5:W2jnkKUuUlNxelkBW9dzhOVsGb7QfJuwrp0sPQSrJYwIbM7XrGFY+LBbwS37roeN8h1j4hdvg5sCSo1SUhu52TkNKqhqVXKCIohlqzBOrghmRwTc+5sWWzc+reA0c8P7oQSTUBABM7UdjCkv42JxMdV3w7YNFqSXq8l7iKUo3iQ=;7:9LzRm0CJdr6mJZb1ohy1irmPvefuvOyKL/1SGbSjrzPvU4dN3OKCEaCnRXT10qesreow03m1XKZfWRuttgkY6AzOWucKoXgUmgZDqHOThreeuiYsOF/Eb8ik8jtUn4k+CmOO9eJHkJtnHszUXw5lKQYG1lr+Ir/vEjutkrocB1pGcZANvoQQo4zpk6DHd6MnFxzb/ZUZdizXOCV7o9hc0S7Sk+2YN1V7HLsRist7kvLQUb6SMrRXD546Abs/Zr6v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 13:09:02.7069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01149833-b3ff-4ff8-937c-08d5f2f8f6e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default when core sees any transaction error(CRC or overflow)
it replies with terminating retry ACK (Retry=1 and Nump == 0).
Enabling this Auto Retry feature in controller, on seeing any
transaction errors makes the core to send a non-terminating ACK
transaction packet (that is, ACK TP with Retry=1 and Nump != 0).
Doing so will give controller a chance to recover from the error
condition.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v3:
	1. As suggested by Felipe, added OTG related check
	2. Corrected the multi-line commenting format

 Changes in v2:
	1. As suggested by Rob Herring & Felipe Balbi removed the
	   quirk logic and setting the AutoRetry bits unconditionally
	   for hostmode
---
 drivers/usb/dwc3/core.c | 16 ++++++++++++++++
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1038075..bc9e33c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -883,6 +883,22 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		/*
+		 * Enable Auto retry Feature to make the controller operating in
+		 * Host mode on seeing transaction errors(CRC errors or internal
+		 * overrun scenerios) on IN transfers to reply to the device
+		 * with a non-terminating retry ACK (i.e, an ACK transcation
+		 * packet with Retry=1 & Nump != 0)
+		 */
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
+
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0e..92a1077 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -227,6 +227,9 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
+/* Global User Control Register */
+#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
+
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
-- 
2.1.1

