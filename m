Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA797C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB4E2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fBXmkY8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB4E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIHTtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:53 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:37011
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbeIHTte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEtq3yiuelDpEsnrtGaDUFtbl/A2Uu6Tp1oAaerMSSY=;
 b=fBXmkY8nbE7ylLnk9aU1cNjwIrChEtDUdL1u8a/0LXOJXruD7C92vnGFVabEWmtlA/mBHYjE6cYWlnKc1DnHoDPXhvt4JKmaG0D9nosdOuO38bv33TdR6y6oeu52OkwR8/Jym+Dx90JTiBdF4YyedsITGDuFtMpyHO5k17nTBsU=
Received: from SN4PR0201CA0038.namprd02.prod.outlook.com
 (2603:10b6:803:2e::24) by CY4PR02MB2680.namprd02.prod.outlook.com
 (2603:10b6:903:11a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Sat, 8 Sep
 2018 15:03:21 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by SN4PR0201CA0038.outlook.office365.com
 (2603:10b6:803:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelc-0002cg-CB; Sat, 08 Sep 2018 08:03:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-6a; Sat, 08 Sep 2018 08:03:15 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F3AiX031616;
        Sat, 8 Sep 2018 08:03:10 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelR-0004oh-Qy; Sat, 08 Sep 2018 08:03:10 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 4A39360498; Sat,  8 Sep 2018 20:33:08 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 8/8] usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
Date:   Sat, 8 Sep 2018 20:33:06 +0530
Message-ID: <1536418986-16609-9-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(438002)(189003)(199004)(48376002)(106466001)(8676002)(5660300001)(90966002)(356003)(50466002)(36386004)(42186006)(8936002)(63266004)(305945005)(54906003)(110136005)(50226002)(316002)(486006)(336012)(106002)(103686004)(11346002)(217873002)(446003)(126002)(52956003)(4326008)(107886003)(478600001)(81156014)(16586007)(47776003)(39060400002)(476003)(426003)(51416003)(2616005)(81166006)(76176011)(6266002)(14444005)(36756003)(26005)(186003)(2906002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2680;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT020;1:3e6EBwYM6FhYTJ4depUDXWuxGT+XBwWpMWkcxxd8PHMqhpELTunzjDfQKD8d95/X4ciOpJ2vpTppMeOxHBydoPO0iyeyevFNmhOsOr6ueMUzdTwhz731K7i8pk5rwJog
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e4bd90-54e2-40b2-2133-08d6159c37a3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2680;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;3:wsNh7MHLqcdOSSL5kbVWLBW6/w4p6huwerPsV2bM5fZ8LBJXIHpwsLGJ+NxGYCpU9fbPidXo9kpw/QQYPxrs2FCjHK3CPvSPdydHdlL354Pmc8WP59Da1Ce9u/2RN9goZeUkAcmoznBJQBsionEDWrt/o6L/gBiUZplLlO2yICIK3+45lKWWekCNW8nz2xX9ZeDLqzU+TBSggfv7+7nMVQi+kWLePKqT3Pghf7GiImWOUoePyn+aglKJjGTj9YlVxRZXh1KCL+c30psJqxx4F7ZR+NxOmD3TK2nMfmJHNf8TWCcoMAhikSOhtuLSGRnBhNGvJRDGSdUU3OxD92PaTsqhPlU6yFBeSe6PAc4GZo8=;25:dudt5+LCd8mNNzaUawcubYyB2OS2CPnDH/HwF3kexyh/QT6R3yawU+XxahXLsyJrOtNFLmz4H8SIOLVabC7LpmmAGnJSsZzifK55P9yOVHHPz+U2QmhmyazHzETCE6ZZPwvyFyM6t/0klAlun9epaeqh3z/iIddl34O24qUWpjQVojcNK0aXoIoSpEZmRoq5NbolPr2K++/6W30vZkytTsmDpcF9PzULUpZsed/Y88i8JnGas5EQWeTm0mJY2FsCLaU5pqh13g1rXXfRKfGdZxSRzWAxevzC65HHBylBrjNn7qP+AgzlEdxoTxJiDrQZnbM8g9H2BhfQY22R7JFCRg==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2680:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;31:Eplr49cI/CoslofKU9mrlblcXUCwgJGa3cNkxBSkonlby995F6FPdfbJI6CbsWZfkTvm1bcsCQsxNkDu7op7bq1i8Aue+VYFy40R22eKURPhk6ZpluGHwpLQ7QQnnEy8wceYd7JCc7N2cj2rySURxmAjGJ7MtETjp4Fg8+RCAfJm8gLtaRgmMMaDXtNuYvvzKACx91ZSKzH7/6DvOZk5sB57+bJdU/DD72WpvfmdwQU=;20:2DnFDu+Q8JIB2b7MmIaqKJKpTHhfPjqLiIjMu6iAlXFI1lrTy1Oywou+tElzSVuvoEHUmM/F+TxGbe0jYRhEFrseTSm9SbEutUZjMptFDH7tnkWJEgpQnUtgviyMGDkPgJcQje8oDP5xAJkK3+3UEcWwFRNKL0JUN7Kxw2Ap2hMpn/AN6E/kAJzCk2Ok8Ri864M64j9VwniN5DAX1z0zDqfbjWhMa9ZojkBWdkENiDhinHQzUQNkS2D/3QPxHN0JcED70dEa96CBATvFRZCFWdRr4ZoQsusUe2COhkQTdEhde3gJunNIbcNOztVBWIapzJHrjHqSzpsoohQgmL8blf9ghhftCtq1FODcCaouKzBNbOSc0mkhLZ0p+l2t8CQAWrLOBcEd6TaIgfQ+l8ptSEguzzJvByLbjRhzR6Q5kUC8OczZZp0UuC6vryPj7Ihx1+lOhrVyKcpb17eJKcZsxurqMD29KlKvC3JJZ/vWYPuZmhDWu2Yu0sdVgYIdXjwJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB26806AF7B35012DE3D9AC4DFA7070@CY4PR02MB2680.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:CY4PR02MB2680;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2680;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;4:RrZ+KT8+3njbQUP2mmeR+fWk0j3/0OFpvo7nFIvrl6uMbM8hOIYQ3bIXN5mzKCUBr1dYe0FMquVKYFTOLhm2sMd6L2zmBZRjdLP0AMQCdDQ61BOYGeXlCo76U7VJ07titCKgizPUp9FdqA4DGilIOdA5wJsKdeNOvxUSgzsfV/euRhiOMmGbqyq+wvQ8Q+LttBmeHGziMZlhIs2d/lMJ79NhBY70dh2bsvlxHuFhtk5rhqcw+IyZGgoIzrLDH75O9Z6Pb8vSEjGpJV1SafhYL2DHjLoUFHx8pMUHds4xTCrFDj1+aPABPx3iYwomcnh6
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2680;23:k9tmzrtAtL6Lz4cRdCtRpWzRfO5kK6HjkEXlkyg/G?=
 =?us-ascii?Q?r2Q31E24pyQRd0XWODMSuzMmQV6xcoKVG3FpGNOagm5wHL2gCZkFBz5gPUxd?=
 =?us-ascii?Q?hg9VmetIEN1GoQvCP+X8Ws9tCuxez/k8it/wCf6Pc95f1uexpFYqxG7ADr3l?=
 =?us-ascii?Q?VS2wcEgknV93VqWW14folkTZir/jowxlk8seWE19tm1q1GJAwn4bVwTFujgE?=
 =?us-ascii?Q?pxWoa4rlR4xFcmQnv2pbIC53k7gnmiA1Bh2clq0LkHlcrBBB7TSNyKexN8/w?=
 =?us-ascii?Q?fN6iOb3B+muwbofrz/iNHioDaD3Gp1H+H5f3IUGWOPg28c98NtXX6KEiFzU3?=
 =?us-ascii?Q?wuyclc8vWPqKKX20Mv+zSvWnPgjS+pY0sZd4WNXB31TrFZv47y26UtYqhJoP?=
 =?us-ascii?Q?M1R5d5M2S+WYYf0QescF/y+suyokazDEfpwMnwktONaCQwlhv7MZOMgT9H8p?=
 =?us-ascii?Q?5N/AelKw5Fe+gu/JF0nfLVVH8NhDowkPDbiBFddwdGdLyaQl21GVlPxhBGIY?=
 =?us-ascii?Q?T8tR6JO6zzkQ2kXxOCnX1+1Onte3zFdEyon1MVNESY50YvKi4rNBiLV8ikWZ?=
 =?us-ascii?Q?ea0nAPkA8kZdNRdxvu8CDJL87dc3O8Pv+8VxkF2+C/mrhaRmKfMJC6H+2vsh?=
 =?us-ascii?Q?imop6sq9hEO76AZCWq7qU5pJReqfeSdUhxsYBTaksLRfNS0rQdZKcuDk0lD2?=
 =?us-ascii?Q?ZtDAQCVTj49jmErxbWplAgspoz4x8txclDpFTYP8Pu5MhAjy0yUvd+WIeqj8?=
 =?us-ascii?Q?vqoBtu5HtHtPUMHWE85Dkt+wozz/gOIw0y2xMoWw1t3vmZbsuyXp085jscR9?=
 =?us-ascii?Q?dMKg42uosltCkgF+gZ4TQGtMEJaC2CGnrMS0ToyUbgqrMyqy2JODwjzDjris?=
 =?us-ascii?Q?b44E9N+g60F4htfUFHKZj+FsA+jr4XCjpny5JrrNmBplmJwqx1Oo+UZo5F+T?=
 =?us-ascii?Q?FRACc+lcl7bAkK0IDbYJOWRv10rrJSIJV+JLjVPyci6VeRokQFNa9VMCH0W/?=
 =?us-ascii?Q?kLd57tA1LYkiKPfOSm7h+VCz/ALZGupLUMY8P4MwdWEqEUY0OhaYQC+2jZJO?=
 =?us-ascii?Q?3vnCCgmDRrI/L1wVVgiCFkflO/3DPjqpC6KhwLOchGdhcbkN6W1qTUORtC7H?=
 =?us-ascii?Q?7prNLp+RkM45gARiNV6GO8sYGD5WtAZ++9wGke9fv+ZnUEWtUEY97iqa/x2X?=
 =?us-ascii?Q?mhYJxqkT/jXXi6YnBTJO6xOudAafctk64Op?=
X-Microsoft-Antispam-Message-Info: TMY+/7Nqd6AY6nqHOq6WwKJuHJvgv7WIE96n6+pLT6YCKy3MTrhzG0stZ2J9G7juUvvwnJ8nxuA3o0eFQUo69Xg47y9wAbJMsBN36nLBKlIHHtfC1Z2MLWBEyhz7YOtFoJBbIid3QC1JnY8UA1xXn6NrrcDNt7U67hx1wtoIFHTiTbNSpM3lwAYnedkGPOYq2NDcOhJKEzh4oK57+XLUEFAB+mlTlijwrGmXAYbdA1CrPukTpuO3GCwRP3KADIHot3PBWl1EMCaeo8MHLEW+imCxLtg3E3oV7RGwp1ljzi2iYF8DE4zBjwgDtE0zp9P+itYtU38cWDl/YO6U4fU5ZYov4Ts80zm0+wMHwegxie4=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;6:F+afAH4smQvXJTUBX1B634TOatXJM401jTrHa917hu6GGaBtiQxjwtDNSQnN5DbOH4WiQd4/1UxGfAAHfCBzVfLgSc4bfewTvajFLA6RtDX8pW9OASuRTcNB/hRBiTwR8GssSLYD7sKrV7JAc3bIq1XAWJdjcw44DnonhUAPwB2xzxLtFKKhtJXpkNWA88T5eNtCPri/z289Vaz1Oytijeumc7ciMw/Mbcmm0S8Zu0gjnObz5xpxJRo6gNI7tXU2MF2+PB0m3IJvcp720RXEemzZhGTKnkdNw4JiXNRYluQKkbblyevNOKHa0bTK14HVjoNPstLG2YCO3zxUaJVUYOxNbGvbLiluul1zMs+klrhDBsWNms1RhFA7l83OCX9u9Voerx/MwL4S2WI5yI8ReYPChH2phq2Vd1yV++2vwifCKKHaWztZ3AoP030UyLEq5bp+oJMmpM0qTUd5S/o0CA==;5:7EEEAHaZeTcmdldwZX2HIeNMZfMoHFQ43VwNfEpHYdd4BKDNhyWOR7LVt8qzo3gUG6jZr6Q+vOfY03H8ZhSNwfqjS+jgY7UBdgHPNUG4R8GccUWtfoD/Lk+h5JwVUB+v8ZCNoICErVenuBol0qfAC/AonQASCtk2GznKmkplxjU=;7:nNmY5VK1p479eRCDF9tzP5T9u+EZos9rgQPKbg4vNUmZRjipRneGkwrogMFSr0bcmu0+dSOK1eUFPgS9JaHx4xxNvRjRPDqWTnN/yc0QbLGVzALqPFLOS9f+qItCeapn8QTcjSX0Ad6SwMfkPNB6xeBw+fBe/db++qfx+USbsPZhKh+snL1a1omr/lYDejIqerZz8zcc/X0Erm927BxD/1Tao4QjLWjTn4KGs96ebN5xcgnAIK7v/9B6aQVmoVdT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:20.8425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e4bd90-54e2-40b2-2133-08d6159c37a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming is enabled on BULK endpoints and LST bit is set
observed MISSED ISOC bit set in event->status for BULK ep. Since
this bit is only valid for isocronous endpoints, changed the code
to check for isocrnous endpoints when MISSED ISOC bit is set.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6b6bdd2..2c9e3ab 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2422,7 +2422,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
-	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
+	if ((event->status & DEPEVT_STATUS_MISSED_ISOC) &&
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 		status = -EXDEV;
 
 		if (list_empty(&dep->started_list))
-- 
2.1.1

