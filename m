Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F6ECE564
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B54206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XHtyRswE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B54206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIOTtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:49:49 -0400
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:65446
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbeIOTts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irb9Ec6IxmxfN6v33xS/0769B4QncTxsdO6kgoqpTMQ=;
 b=XHtyRswEyQVtzEDnxmhhlrkpPCzBkT16TrAGOMnzSsHH1+LYhW8KWsB9Znp3fIEtae6XysKbVvJyeQnxM9sGkBlKNo9Qlvc9+lBKCqsEATBVkE019kQhC4hOjJ/4yzCHd/7UI+elWjvx1k6weaN9iwJ8g7or5I+Yj4/0cOELs8M=
Received: from BN6PR02CA0046.namprd02.prod.outlook.com (2603:10b6:404:5f::32)
 by BYAPR02MB4470.namprd02.prod.outlook.com (2603:10b6:a03:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Sat, 15 Sep
 2018 14:30:32 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR02CA0046.outlook.office365.com
 (2603:10b6:404:5f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Sat, 15 Sep 2018 14:30:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34685 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bag-0008C7-IF; Sat, 15 Sep 2018 07:30:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bab-0004qu-E1; Sat, 15 Sep 2018 07:30:25 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEULdQ031541;
        Sat, 15 Sep 2018 07:30:22 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaX-0004po-It; Sat, 15 Sep 2018 07:30:21 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id C3523604AD; Sat, 15 Sep 2018 20:00:20 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 3/8] usb: dwc3: make controller clear transfer resources after complete
Date:   Sat, 15 Sep 2018 19:59:56 +0530
Message-ID: <1537021801-23896-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(438002)(189003)(199004)(48376002)(186003)(107886003)(47776003)(54906003)(50466002)(26005)(2906002)(6266002)(51416003)(336012)(110136005)(42186006)(16586007)(486006)(446003)(126002)(2616005)(11346002)(476003)(426003)(36756003)(76176011)(36386004)(52956003)(39060400002)(4326008)(478600001)(103686004)(90966002)(316002)(106466001)(63266004)(305945005)(356003)(8676002)(5660300001)(8936002)(6666003)(81156014)(81166006)(106002)(50226002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4470;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:0bCySa+mHRKB8gtY3j8UIhGAP46G0RZ2RHKAX/Q+Tsnzy6MhjGT2NFi3UFy81O3CwPr8m/T1l1sJSKhQa8ILaQGNO+OynHcovA3UfoO2NbV7y5AGeeK3LdJRTP45IDK/
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52a18c32-7869-4d78-829e-08d61b17ca74
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;3:71qowaLxt5c6Ymnl4QLXtXbm0lw9q9C7vNRDMT8Gidw96on2xjREyin7pPsnk5TDmctGPSGnlwYsVWixd4QzdEIJ8NzwvxOrKGXm2GuU0Ev8qs4IY46inwHCVrEje4kV/YYneNcjx1tNJi+sApyfAHuiv1Z/vOy+OMxKa7cH828/sOpFO+sTowvxgF9uBuJTw3QcDZIZLs+/nrN7wD3hg18jpJbvoNeCSKuOwxZZHIVKVg3Nc2Sl/ZsEFHFRVrb/KIvCUCunLg5wgi7dMNmwLOX1YP215Q0/os72j0wDGavNZbMxPSBObJzTfO+SzTsx2Wi3yfh7DcBk+XNI3aufA0ex/zthxlh/ncgyzh/fdpM=;25:32z8BTXjjx0/zpk8iIX8iyQShZ4dKLhNBp/Hz7GFokpCOUtUvhyHhvLnoggpJ0OvZfrK3S3FQRqsMSTpiH68YKjV37SGKu5OYe4GXrWkyucCyyLjEHdLfireDqwPiN6ejmwNJZEamNE7tw4rJ9zN1Ny8TyA6HlwtZpf0acECeqNJH9F18t/e2DRy9hA22Ej1FunC5JtAeMZ+T+Wb1vVJzQoC2Y/zQn4yRApscJlmXipcB29hkdD7FQN50cD0wQuMi57OMgluydHcI1W0Ystpy7tis/qgLFIoR2TK5S1T0SjZtrbwSHV4afyZM9gxsoCfLDznUSD8GpXC2ZCdPUxt2w==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4470:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;31:bGXhQFICH6Sa6p7yZfBYk9K3U+P0jbHm0lPiQCQKOInNK34ChsPJmjuOOvBM3k7sX/Or8VoCZN4Gqfrmi5QrjrAjW6k5jvwxpXLzCqBAqYcTJMdK+xuGe5MDhTgP0bWpVHti+ahhqNnC43x/dFymn9HAWx0DhfBeWGDidIFAjgl8JBbjsUN8rORj12mugR3q3M/+Kn0Ap/WJPRi8CuhBsGrgBfTzzmqS0mz22jdugYI=;20:Lj1ZJElSQwVa1pZs+hKj8bVF7BIzwjBcxyQb3wzOI5rusy1b2/zCmorzF0r3FrSQz/lkwyThrSFMhicav283n9BngbnuQx3bTKiEAO/jWNV12+DGAHr9Xm0HPhOP9Irz8PglHVKCrZPi8Lb+lbo+vXPskKy34JE1ovFvf+x1QD0HsHvsGBIzHrTdQahxMKYxcqgq8rI0hOj2+HQbU5dwI4BQ177/GKYDoJ4d4LFrIICkt7+wMmzIDxg7RloPI0tEtE2PhfR6d07TSf875ggdzPDOBKiwEZJwSGkaxn1W17VK9boi2RwjVWWyWb8lIb3YjA/Mcdx3JTN9DzOGrIr1JbhGTBDRAJPnYukOqzr98yx/pKiCJZtnPedDTTzB/VvdFV5ZrXuRxCWjW6TRuWtrQ2QQ9jkcp+wunzcqGxoPeBy6MXv7Q88d2aqFtYYxQWpiOD3EJVwc5zMqLZebPZzXdvkA4aSKt/qEbuYse1VBmaOqSaPUjcpJ1yDUHlwqT3PI
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44702DA81813520F4CA70AADA7180@BYAPR02MB4470.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB4470;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;4:Tcmhb3ldQ8UkLxXV/OOI2i7JWySrbE2zir4rb4ReQgNNqsmdzijx9VwPN0Hr3wjBgfZ33I1kXwat6B7G62he4U13CT4FJKoson5/it4M8nuNkrOcxSfhImZB7jnhb2msDVFmJf0cYGgYB6oVer0Sl5gBqQOcVGPH7mGZO0I1ZcUPaQV+i3sho7J4GRaLzvnhKTF5vgFPnLgjWvj8GW5+KytK0DStCAh7NfqOxV0RZhWTwq6NP5x3hZuy8302g+KIjkkWIKQcvkktndLJ2JEO+wEU/pSSoIeRURben3SaAt7D+1RDqsBLhBgrk2EUexnD
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4470;23:yw+3XAYxnUzvMx23x+sJF+R5uA6+8rYZ9qx1hq2Xx?=
 =?us-ascii?Q?qSO2mhR4Kg2x6G6HQk3+0UtfTrg7B8fH1ENkpD6F0FyuQ7iUXkOZNiiXZAjv?=
 =?us-ascii?Q?FKy18yKf+ClcueRGazJXMy6kUB3P39SmfUsdKlhRYRh29EVOqidh6I2jxTZ6?=
 =?us-ascii?Q?Yj0HbOhEzoOlM67W8qHj7VMb3DoFaLAm2HUcvb9QzpfFIz3tO/8hngNvwqHL?=
 =?us-ascii?Q?qfsFHcOujt9ILGpe9PL1ckWxTgS/mA7ic3ZpgbZkSH8xujsr9cSmr9KStoQA?=
 =?us-ascii?Q?nqNQy2cf+0SzagdCX+WFu47Fy/utEKP5/+/SpEHdXzYywc4ErqnCTnXDdbLz?=
 =?us-ascii?Q?GFCUDLvjsPHFkfpXlyotUNeYOdONeKLzDra1/uNsUbqVoN6UFiAPaKcanuuM?=
 =?us-ascii?Q?+2lVlaMrG++DHtYKzEY6Pm+1u8IVMcpfySqIiL3XCGnmn75B9LSVwLssHdVq?=
 =?us-ascii?Q?9AVPY8XLknZb0ecLHiA353W6uR2ZBmk1LuYx9wfwk1Si7hy6/oUFYf0vexUJ?=
 =?us-ascii?Q?Ao0qh3gPkmpZ8hPxEvEGF1kbIcCHqSzDk4PK3jbNOd9J+c6sG9/McL17ig63?=
 =?us-ascii?Q?hFkiQdgzncGXtVh7sCqKMZ943vcLVMvTCOI+I4PIosD8rgY1KWaro6PRl25F?=
 =?us-ascii?Q?eIh5kHS9eUBbTIRxpQwUzb0+CEdyLxzsHjh13u5cD0YW8aUBELrN2RHaV2n9?=
 =?us-ascii?Q?uGh4crHAGznJjD7qJCfxF+uoTHrnfFXVHT3AxVFJJx01hWGMrwK75lmnFzj0?=
 =?us-ascii?Q?j76e0d1e5rhBD/aOlxIo7rkZbXje8D7Tap8pR7RK+eg/8DMVk4FSh/vqP04V?=
 =?us-ascii?Q?r2d01i+9tURx6TsRTwZnSEEhl8fmbPbdLRlDBAnZ8pyXVOjgmh4B9nFTJIoP?=
 =?us-ascii?Q?JvAXrUDQUqTBdHpSPoIFQhOqFhpWsfC7ervQ7X/pm6xLPKKfjqYbjEpN80vm?=
 =?us-ascii?Q?92TppFjj5SQxuVgkU5WgQtMilSFtqa5gmcpc1ZgmU8EBu8lG+Gh7YLUzQTvo?=
 =?us-ascii?Q?aafN7XsE+KXKT8W6IzG3UAj/JtVymt9EYgbcjXUY51jyJMKzZpXfpv8Nw7L8?=
 =?us-ascii?Q?yo1YmZiGBsUR8l0Bk9xRL6ZKFOFkzjUAIjFQLu4wOb9o1okcjMul7k8pK7XB?=
 =?us-ascii?Q?WzG0QKEHnm7nBO3lpzfGx8e+qfJmVB0CHjPhC5jodd8YUmN39lh0kE/0mC6O?=
 =?us-ascii?Q?vaKcRFC/6oS63g5JmfTuld8EuwIJ3w+Dczp?=
X-Microsoft-Antispam-Message-Info: ptSk6ngr+2npic9Vp0AuAVEWGZALHuiM0lrYgPCjtMq7ui9NBGGYwfRwxLnpcDw6t3ESsf3UUtCwlxRdVcmk8DqhIBm7xJ2Z4WNjJfJx5rMSWL4g2QU0oFl9qlipa+9sSlj+QwSGql9MaaNKl0CvDanIiUKfHp7KpBWRksHXrffk6d/DFD/kY9uFtAFXMaGMSjoslU6NZXzQgnV+GYQ5yEZP7wkmlVGtCdWjVhMR624JD9YvjwiC+WRjHtDyYyF3BAbc/Tdpv0hADSCm4Jofz9uYKHbzOvbCQQ7rN7GfZtBHEC+7w8snJyih9yShJOMcj2+JYrpxknvs/PdShxajajL8QDaQ57turFmID5JIcgc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;6:TDAoNynkoRo/gflW8suGp0zcj8APLbcu2ENK6cZjuXYT9Oql3F2VeF+iyGCC393bAeW3KogYpXZ1/GKusv2VRsLe468u5oGxAU33f7QMWQwwABsbOiB9UscPjUFolGaRGGDI2dwORcJgIiA0gcJv1l+xbK/IWtYzONL7V6GNl1hTjK2zQExNntH1tfTfpzyomTOJ2q23HDmPquB/AfISo15XFeJxrJfDuBLIOONAwtka7IO0WB5NYlb+iKP0PTf3silJRg/n3qGJN5kigHIMlmgva1fkfo4ANScZxEzrJd8xx2/CABXrCTXOf71ko7otIxxS7TJMmXvKnk+yhuiQzHs59vzrIWTzArYD0vdwmidCx/R4ZekaqQPK9xhEw8KJvIXKoUe3vyZb8/kX5/JDndjA14/F4DIYgK+8b5wgmYEmOVaSzdFGHXN9wzXUNTpW+5rd6JZnmGPsQptLh8Uhqw==;5:2lVTzs5XSY/URFvPLQ9pOXxJpE0IpkWZVJ82DEzrMrv8s8E7MPCocS703jw+5Xbyy7UfqRc6Im4y4YXdDe0djRgIhyq2opyguUsenmOhUjky5ehbP6f8y+oR4Md9dzAzeaEeCyCAA6fPIXPzW9VZOHA/KDEC02CsuJI3xb2zx30=;7:a6JqiB3sMcOKvn7c8/OJjgG+Rz9NeBitS/X0tfCvQXabQB1bWjGC6Gm0q5OXIov0X/R88l4CZBWgTW0pibL4sjeOhOQd5o2BIMzhC3RCDN7cmsBFXeOLb9MRLGGG2OaifVBpzl0oI5Zi1lUbLI1PQT6cXHu7k8oiV1MHnda2kX04hl7vBAkLLUjO7/GyzakLLhXkgXBwdODEyYA2TqZ4OQE7afEaa2x9dIUh/rW/wW0i8e8CzszonMwkm5O6iHy4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:31.1834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a18c32-7869-4d78-829e-08d61b17ca74
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start transfer with another stream id, controller needs to free
previously allocated transfer resource. This will be automatically
done by the controller at the time of XferComplete Event. This
patch updates the code to issue XferComplete event once all transfers
are done by setting LST bit in the ctrl field of the last TRB.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 43d63a8..13ea282 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -571,7 +571,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
-			| DWC3_DEPCFG_STREAM_EVENT_EN;
+			| DWC3_DEPCFG_STREAM_EVENT_EN
+			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
 	}
 
@@ -995,6 +996,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
+	/*
+	 * To issue start transfer on another stream, controller need to free
+	 * previously acquired transfer resource. Setting the LST bit in
+	 * last TRB makes the controller clear transfer resource for that
+	 * endpoint, allowing to start another stream on that endpoint.
+	 */
+	else if (dep->stream_capable)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
+
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
@@ -2268,7 +2278,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
 		return 1;
 
 	return 0;
@@ -2457,6 +2467,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (!dep->stream_capable)
+			break;
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		/* Fall Through */
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
@@ -2472,7 +2487,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
-	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
-- 
2.1.1

