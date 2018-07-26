Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776ACC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0421020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0KCz3EbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0421020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbeGZNyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:54:43 -0400
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:18496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730496AbeGZNyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbJEBK9DLV/e3kz8RGVimefFT4Ltyg2i8EbPX/5X2uU=;
 b=0KCz3EbE+/QUVM8cTaO6oOBE2d+64bH//a6ST/zYhw+Mp1YEUB/a2aVC8eqFdM77f6sr9aktxuemujJrA9rUy4lhZVVdt5pTxD4glKj+05kA2tEI6gLgMQ1yVaFnUbRYmAoLxy7Wy/6Qb8XFZUyhjoCE5PTL73IxrR/Radrjjus=
Received: from SN4PR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:803:2e::12) by SN6PR02MB4335.namprd02.prod.outlook.com
 (2603:10b6:805:a4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Thu, 26 Jul
 2018 12:38:00 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0026.outlook.office365.com
 (2603:10b6:803:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Thu, 26 Jul 2018 12:37:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Thu, 26 Jul 2018 12:37:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43212 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fifWm-0007zX-Rz; Thu, 26 Jul 2018 05:37:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fifWh-0004KQ-Oj; Thu, 26 Jul 2018 05:37:51 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6QCbkDE020173;
        Thu, 26 Jul 2018 05:37:46 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fifWb-0004K0-Sf; Thu, 26 Jul 2018 05:37:46 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id D7DC4604BF; Thu, 26 Jul 2018 18:07:44 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2] usb: dwc3: core: Add quirk for enabling AutoRetry feature in the controller
Date:   Thu, 26 Jul 2018 18:07:43 +0530
Message-ID: <1532608663-4091-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(438002)(189003)(199004)(26005)(52956003)(6346003)(90966002)(186003)(336012)(36386004)(476003)(2616005)(486006)(426003)(126002)(63266004)(8936002)(51416003)(81166006)(81156014)(575784001)(8676002)(5660300001)(36756003)(16586007)(106002)(47776003)(54906003)(4326008)(42186006)(110136005)(305945005)(106466001)(6266002)(107886003)(39060400002)(103686004)(316002)(50226002)(48376002)(50466002)(551934003)(356003)(478600001)(2906002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4335;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT060;1:nNCPPr1ZHOxTogqWlr8ZBGPoDu8rSZ4f4/Dawp2/1hr4vBmk/Mj6Cbk+RFmzi4YslNncqO4P11Yt5x9yad4+Zc92kKmYTrfYXGCeRHqT4fdNffA5GWCO5kEuT4waE43w
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c489d775-ebfa-47ee-b276-08d5f2f49ee6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;3:KdCCbQZCndeJo3+/VuJpWR+sJjj/mFKwwR/WT1t3hdp/ccT8jewBgD2oVUJ5ObzK+H4dwMQ+MPvdVElfaUK001ngDKj+mNHvJQpFpHRdh9v0/Eu0yUSo+IKTZ3O130uItmc9XF6ZEhIBZRq6QHWqMAhya25qLv7swLYhU9SfM9nE4dV5727XeP4rKko2zx3iYIthwf0lEbES1/D+XHoy/Bu8Z0HvA2tB/0axFQzvSwIVBkGWfg1GMmChRNgu9LDsPhl2cmSpz5/Jx28GwKLhaLgXfqN+mkOPem3O03npWIIK3HZsFJL7Y0iz98JKY6uMDGAKaeFDORSQtItK35cvvR7o7AhSV7wozQERynEImQE=;25:ahe2KkoB9VKPdm1LZbrDLMcImQWos2hODjPCwN/5Jqwl7Nb6OKn2fI7Tcbk7bdx3ym+UMUiJ/y9M9x+HmTQq84r2J19dJtC+W8xoaVceVpwDvicAYVZjLiRJfsW9lcmR2PxapDY94DiUFihSryHDGr6gDn8g0bdpK2OOwcMnVkmJRpcCN2qed+gghgArk5br1qXOheLJqBoIwD9HtoeyRVC7rzHY9uv3+C2Q61dfK2jQ7TIjcKKCl61depyp/egj4arvqtdNphArJBTNwhR2je+wD1LKQVkbIWb2OYZi/494unpcAtJD25wQh4nTHQJLqpKdm9I/kE9kf7LKsUJ3SQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4335:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;31:oO0iEzoaDN6zSeLv4PJFFaC1Fquc6qLdAdQubRXcz3jwQSZ1faxUNuPcSEvMdDqsDLrCO4NY+OJ0M/HEAHiYgcArlU73xRGLvtRqlzz2NIDYowyPKYFub0Ffk/x7q43DxaeaXVkmALmfs1O/ytG0d8VMXPfDQM+ql2seAFjEDAB8L7nAIDO8GH766GfksxhdNkHpdTLsrVbKoh1jTlN4jteWhSWwGsPeKIiFkOtgYj0=;20:QFtdBT8bJdTfqDqmUZN5OgxLS1EtFFNest0iEOOQ+MhCa79oHQEVsRSYG54368lM0X0pW8VOWIoeamxy/UOYHaihEyWc+RF8gPoKU6RrEK8nXcscbtz8Ij45mIMwadIpai6OyhpyHJS+4cw4ZwIVV2fIq8oIe0n3dqnJNiXgsOGetJNyCXbOlliIW8l71pf0jFcbad8erSo6FWuvEjicx3nCg/gaHNjLCS2e3/srOcZpVJKP2+YbJ47IDHIGh/vJpYXJslOVnFisCz7PJC2pUlCo/upVw8/rc+7xOkApuhJF2NzePuxu9MiUAI5bsTrgTtEWCP6gGf8e4hZHXFp1v89/j3AXQfLFQnmNNsgw7k2y/wALTkJ9TpuKZRz7/ZLlqzInRhGr2l4m6kAUeXQ9UeKvr1mJ8JROd28rXWfarcU1f+W9MUQTD00gRmReawa6aSlB5uQA14aDl3tzsB0p+X7/bP8vPr2cYnCTmYWUY7NopXC813fXW73UGXjdtKUB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB43359B5BBF59EF5A953A1E5FA72B0@SN6PR02MB4335.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4335;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;4:B3ZXUawxmff/Kz8DZ+BGB46QUrPIATTShv8C60lCd5YFEQmpggPUe7jO8f92WjWZpa3/7qK+KQQZ4yEX2np+CLvMYyul6CmqEQja1iQ4vYL6jCKQzb1a9JFuYRC3gl8xmeDmdC8lS0e7Dv7gj1zF5YONxr8hXHbs0g2mLeBafsfdrzknIXcpMNw/7FrshxlJgLcd8SlRdRZLOZUrb9WO05P1cAhT7EqtBiekkfdNkEgL7LsfYqEGkWRNzaw/KtvV6A7TLrVlqp0y1BjoeMTh7kBbjmEe0Jynnd4tsNglnPK2LO40bcbzkmzmtlRev/KE
X-Forefront-PRVS: 07459438AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4335;23:ceZC/Xs2yvZQOnH64u0B9SwzSu8VcgnZDCtvs7Bza?=
 =?us-ascii?Q?+09DepBAhavmcsbgH+Xwj0c6r88nnb5U2e1Ql5qDnq4k+QwIBtXRoeXPKPni?=
 =?us-ascii?Q?Mfa8fMulj3FtKdLwUnGNtUeFdOh+HmmkqJtXAhdE4Rj4DKZ2bzJtgmbenhaP?=
 =?us-ascii?Q?3Ywm7hnMtXPCHkvdGMBrgW4+X1sMFl99xcGFzEkkMpf7/vtMuLEaeoFAGpnk?=
 =?us-ascii?Q?4sgnEvHqM5/u7EEMIIP3EH24f3PJb6RVyyIHFFa5EYSTnU2pcNj41zifMeJq?=
 =?us-ascii?Q?tTIHzMeGXsHnUswOGvFMWaa5+I33N5mKa/f4rNZLuhYu1bxt/1J0Uh76OZ4V?=
 =?us-ascii?Q?4x3q05CNLjf0lCJIrCaDIbEJYoALKLWJRCwqU3MvpbDAFsn7X5SQlVupsMK8?=
 =?us-ascii?Q?wqJtdl55uYE+RO7SE4orCjEwxj3yZ3LKuPrK4uFwZbmF2gT0K6YyyBmr38HZ?=
 =?us-ascii?Q?bt4Fp1qwHjtCl1oSOl3GRr9j5dm4bkIKpGQntgIWsP+F7qp3HI1jckAA4PJd?=
 =?us-ascii?Q?OU4xUoJIb3sQtSCw5QRifwCO2xA30jpBVutu1aH0QbPmcRMdZmPWo1IC1AUM?=
 =?us-ascii?Q?+xFbNylJxOvyomQm1XeqvyH0Xk9YLx9Hw7sV8sxlnIJ9wJ1RvWdn1N3uUnXj?=
 =?us-ascii?Q?VpstH2Fby1Zq3D786m5ENOOHSG57AaD8PVsiDmPubL9BLB2EAjIDQAtwg3qP?=
 =?us-ascii?Q?I5EcpgMXfeCOk4TeAX/prpkBxBPVHCJRTXI0sg5W1sXZ9T03iCjL9JUNBtNk?=
 =?us-ascii?Q?aViA9n25AYPLLMwTALML1stoLX48USYxeZ+hspv4bvskKP8dQjZmtCB3cRIn?=
 =?us-ascii?Q?DzbCqYN6UxJWwflLDo2RET/hLJsxsUqos086kP1OwlvZ8q2cj2P9E3Z+FqyL?=
 =?us-ascii?Q?vUeuwVf5krr72ZUAZIYIvgoqDWLjwoJLg1gv9fuccyLuNi/jvoKbMMaVwgSd?=
 =?us-ascii?Q?kxvrkwb2oV5fYQTkAJ8HzXIyM+1A+EyrhT1lX/U8SXN4f/E+CovTiStKtV6A?=
 =?us-ascii?Q?RHJGnrQ7NMz4+UJDYXpbu1bJPti+4QInrCAlOqPP8RJ1okKBsL2OLB7eibc9?=
 =?us-ascii?Q?OE8rrgFwkZ0FS80fy+sHIoCcIYQZptgje9hCnm/cjOkB3WrHktXMBfXsY5rw?=
 =?us-ascii?Q?4S7Ehdkdm/g17epCyYPCfsZFGPZZhHcRBQfbBJ/F1m1+DueKW95p+dnW3XDB?=
 =?us-ascii?Q?2PUlUHsO4ChXVWLYTH6VRrLMqp6qb6LrVPQ?=
X-Microsoft-Antispam-Message-Info: WE/xlzS0ZVmiwTP0OqaCqmZmP7orrCp//kDvMkKi+wNbw6OYMB2VuPYtEO1+BDQ3bmgDx4pUjsK/fQzFhz6Vf90vFjok3g6dHWxHCkEsnRAfGLC3tTH/Vy9g5e2BKwKsGRXSlge7N5UI2vMDCcHqsd5m/JpNoLDSxvHuelCCFqf1g5m9YBd2CyjydluapN+hV8fDKahX+fIy8GEnEFtus0pRuYeUOzrUxOt81A3uQNZWECyN30VwgP6UIK92/PWNC8pUFVnfl/CfEqI+YfK4Xr5fMDDo7zfr0wPk/e0g526rxzeeWT+XkJN5Ca0ST/mtpcOdiOS0wYDyRGiDNhCOeBV9KyjHheaEYkiojc+iNx0=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;6:0kQdbv40WNf9QvZlG8i5Qau7uAtVXAPF0BtXxUo2ngwtgVC5zMjQGymM4VUe2Mp3dv+tAH3PufMX4xk6f6vjmIeo8a5yWX/17xAe1uml0uX+8DVRAM+mTa8sUUChD3VefkB8X2bWbqep76jTRPnL3Y3e0ev0IBrp/moih1sDxbiaBmlLcDOw1oHEVVrVdn9X8dY6G00gOX6WmLUhtX8in14ODY/XWLwFTEDpNxyMHBNxpR1MFYsraRxTdUC3eU0HkzNgKshPIWqtevSIe+i799bFU07CuhKWEaLUDqEi5N3yt/dPSPAZ+cBzIIgNNGPZL+nzaxiC0zKCJxNTlSYoPd3kegNC0P5OQElM8QpFaneLs1dvvhKLYx7TidNlDWDBjIdfbLDxWvL22pWmOlQQhDpNzPWRmmHWkf1zkpHZBh2FRDIP1jZzmZtrvgpozvGPlDFOjXS2pG7XNPoRXeTjDg==;5:Jd60btwtGUm/r1oknXOI1GGwNQ+RNtTE/WHFO10AgfenJDNtUbOrejVv9KdEwEQ2ulMX+kRtFTPdpUMPTlrnrvEcR87oJof65JgYHg4t354OVzJRz1zcNszGhk2eNkvviI49Ux6/UyO2H06cpbaZ31bLo+hpowgVtWIuG6x7kaM=;7:Ukw3A8o4/PQ++4f7xrGVX99krAMSframYm+32yyl1LBptiCLK52F/iRtt7ZvA05uYmTnLIN2+xdtSnSjhNiBq/ixrO1Aqx9eXqNENXucFzqAqwlFdCZyWmfUO4nNCLhc8icQ/gaIhk+sDNQi2K41qI0vKMiXHcSFE3XucoOnqfpYIrQbkYjoYFY5DuM9RkKiR2U+/stQFCsZxdxhEi9slqlFeOiogC4hvb0mq3VL57V6rmPptHEGvkkidiF8tSc7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 12:37:57.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c489d775-ebfa-47ee-b276-08d5f2f49ee6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4335
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
 Changes in v2:
	1. As suggested by Rob Herring & Felipe Balbi removed the
	   quirk logic and setting the AutoRetry bits unconditionally
	   for hostmode
---
 drivers/usb/dwc3/core.c | 14 ++++++++++++++
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1038075..478c8a6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -883,6 +883,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
+	if (dwc->dr_mode == USB_DR_MODE_HOST) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		/* Enable Auto retry Feature to make the controller operating in
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

