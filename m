Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B27C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B4E20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ly6lA1rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B4E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeGYNDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:24 -0400
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:38112
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728905AbeGYNDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nHdIms80+LkB8kmVniMIrM8KRP2VTQ6zAmQwYn4wY4=;
 b=ly6lA1rsT8MHMEm3qERYLAzJfdVdP72mCDodUjC3mdB7iOct3BzhhZ0YMnan5xoPlnHVEqEpKoi/NTn/5AHfVp/dUFL5Y4XdCwB2EcHWGMeNMblNufrPyiJQJ3NpaGTi/A9nXXaKi3C8GVygnpkM86DShMc8KomU6aohZcmS50M=
Received: from CY4PR02CA0031.namprd02.prod.outlook.com (2603:10b6:903:117::17)
 by BY2PR02MB092.namprd02.prod.outlook.com (2a01:111:e400:2c1c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.22; Wed, 25
 Jul 2018 11:51:59 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by CY4PR02CA0031.outlook.office365.com
 (2603:10b6:903:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43924 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKh-0004QO-9B; Wed, 25 Jul 2018 04:51:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKc-0006dG-6K; Wed, 25 Jul 2018 04:51:50 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpg7m027064;
        Wed, 25 Jul 2018 04:51:42 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKT-0006a2-Nx; Wed, 25 Jul 2018 04:51:41 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 5743B60504; Wed, 25 Jul 2018 17:21:41 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 7/8] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Wed, 25 Jul 2018 17:21:30 +0530
Message-ID: <1532519491-19502-8-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(51416003)(476003)(90966002)(14444005)(107886003)(478600001)(6266002)(8676002)(39060400002)(103686004)(26005)(186003)(4326008)(2616005)(486006)(126002)(106466001)(47776003)(81156014)(305945005)(446003)(81166006)(50466002)(54906003)(16586007)(52956003)(42186006)(48376002)(426003)(316002)(8936002)(110136005)(36386004)(106002)(36756003)(11346002)(356003)(336012)(50226002)(5660300001)(76176011)(63266004)(6666003)(2906002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB092;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT020;1:ITm7HDYeRJhBbqiVTb4AuvqlMnsUjviS5e8coj5gzX8chiqm/onLxeunsbD0tLnYkuOwxWhNWhBcpjQBHtOF4MI01gM1/l++f/G79kngQaEHdLd/Tr1u7S8FadA6BqdR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79db40ca-dd6c-4f7b-9e08-08d5f2250699
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB092;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;3:TZFUVf5/oM+yz7OAJL+J/D4OFavaXsGopMbz2ntDo18jfiKMn5DMoRiNS4yfPA55qRAhD9+pwaISTvwcNmxdm3qcH4oUw/CDyOfX2r6jOAYOnOPl67+ADMk54P54iyiBghEAqRX/z4c+z+mlWPQi3vE27XG+zb5925YY02erMpxsrn5VicLjESRIv7WOfOI/GR8+rL6nublp9env+1geN3UquonNp1gWogEtLd7xJCaixPO2DLXhS3n2lmDFRWWPfGtWjPU+1+5l+18MT43Mo4NkEBihZ7G59GKo+0veTA184J9ji8EhjnqAFobv5PLMSaYyR5z7powyJywM/Ja+P5zQUIrEl5/r9kKYNPSrR0o=;25:hasGpcucbtafUaxkc6MAHifWBlUhevgaUqIjfaIdaK9hiR2hVdvUK2Ptu6sfiJJQWPfU+D2Z+KVjDVfP8wNpSIsbD1JhlTt8BmQ71+DSTGrI+idv5vzQ+vA7p3/eK2IsJcHVnUT8379HR45crkih9JC2AvrebRMwX/TT4X/TKj5sltxJdb8kQLlWejhz8RvR/eB196JBbzkQdKFEk2/3dnHN0DlxnGKAcI525bykyzGYcqFGzzSZO21TkI4t5tl/X+Ej/rNN2eaaWc9EiNoEb4B6L9WPsp8bs4VcK7v7i3J/89jWWoYKbnqbS0vSOKbPdSAxlZ2BqdPIl9fg5XbJQA==
X-MS-TrafficTypeDiagnostic: BY2PR02MB092:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;31:NwXAQ/EPV/wGIJBPxCM7ucu2vu+VphF+9HdK75+hbpfWaZayBNUM4LMHcIL8ep30hLu7j+om+DKf1O2aKfCEvF3S6OgoH3EbX7PHRttVTNE1lRX7RHyfbMzIVZ8hNhGG3DAeuHFpFlKXAB3nvIhsCSz6gYgKzC7W809FbhKoo5Birt7U2zCfvAZP5vRXJdAhroHQQfDSERrGcfh6sTMXzQ7IqolLDaQ27A/G/tLL+ns=;20:s3eRpnSrteo+3f84GVF+PMgl7BCFMwMWZVmyAFJHzxH/sMf6MqG4qz/70U3jc4CxWqAWmvx2Vb1tCw1xvYLFse7ji3GIx7DlTk+VDlpqUeUNBRbVIoZAarx+wh/qmo4SUJJFdiWLmyjb+OkuQuQ+dGpzrE/o7yFffQXNRMyIev74TOfHEI4Vy92HPhfqfR9bpsGm7YpLizF56lNomrXMT2KDt7kkIw8M3dP+O499P8pGEK+C9P0Dtrr/81a+jiDojmWKq7+zsGekRrSfYDVHhS9fQSSUvXA1NnotwR+T/JCPzSRQqbj7lg7e9F/N6pZWB7PZ/GWc6a5TydOo24mrKZvwClzUS/h2K1/F+uGkGEmvE4CV+iUonFIJYFvZEU6eubfVvoEWjyaHg1/foL7buehMr2eRwJZyHDbO1bdhDJTaZ1iio7iwBP8UPa04BGVwV0XH9E37Cau3neEI1NVdFf/f/xT4OS5egFG3ttTVYlbCMHdJBawQso4JGvnMu7zl
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB092AD62855D1C5E8A1968BFA7540@BY2PR02MB092.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB092;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB092;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;4:l9sSZW2nwPtOAC/xloAmCGaM9+mFvGPFbg040359LzBPpUYrY6qx41jliRoUqmIyRaPSJqJyYMmVEsfY7wm9JX7pvBo4QJBPlqD2cOPyDeECBLMzKrDzpPGgDue4pU1bKYL1nPXmUlSiK5BouVOmTtBRDFsuv0SDtDLrNSMN/5WNoo0Dc4WF977nG9HfpMITjtdswb14HUzk4pozmWYkCx8tSQN6qj75VsBrvlYIeBpwS6ShtVWz9NBWkqWMRomTWt7qKbBlJR8lFupF8yO0HfQml5woXbAwoU1Wxfcy7U4VMZXQsqVkOpWU1FPuOpMG
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB092;23:ZbxNrGBO6SWAyISALNpklFlYrIvJbfbi3L6Nm4QkTw?=
 =?us-ascii?Q?ze/2iiCPL2FFgOUjAAvHvScVhRCimx+sJ0KngBxdD7KOctgkByzV3T/vIhWx?=
 =?us-ascii?Q?7J+SUv6mZlSp8K5pBAXTqtpqRaQEf0tccihMCHgvDcL3ZPo/3u/9OT11bboi?=
 =?us-ascii?Q?Lvzu1EJIXPVPhgcmVPk4Y8jBpmxSMysurMrCU49j1W04/4uphpGKRfBdRpVp?=
 =?us-ascii?Q?O7l5L+HrNW+/S1AHeqxDB0pHM5S+JBQy6MrEJ4rkbiEs2clrZu8VuBrH4Rto?=
 =?us-ascii?Q?/gazNfmdex/eVLtubkTBFNe068jTMtGHpBPKYj8PaxKShALIBh4hI3SHo/PQ?=
 =?us-ascii?Q?dqPdk8QY4IvKhZPkWS8kfHVebGHiG9YmSrb4qa8glV5/DL5KLL7IlaivgG2Z?=
 =?us-ascii?Q?tRA2YX5AaxL7W3qITzeZ5ZGJF1Y2dNJexnAmRQ5MpaQxvBCAzkCff2iPhk9W?=
 =?us-ascii?Q?09oKJiRYXx7EbBUywwuxdZiyee+VqKcIl4n8dfhTgw3O5Wma1RKIB8U5S8LF?=
 =?us-ascii?Q?l0C4JWFdAqDxcJzG2LcRQhwrNfiPIyuem/P86OQdWckATpyj6Qs8SrEJj7ha?=
 =?us-ascii?Q?MixAt2YL18Eo9X2cxppXOTmEQNX+kqoPWPFbAvz2ybxnYUmV5aaocaPiLOUP?=
 =?us-ascii?Q?PXKfskOo7poODAGcyhsSqq73TDXPIJv2SvXhqE97YSiWbmqo0VzrWKxdk0mZ?=
 =?us-ascii?Q?MP0TCRVj7gyK3wqihUN6YHug/b9PsyRSM59OJrXqQ4XcnDQFs9lmLqq+Vk4f?=
 =?us-ascii?Q?CJXBGT4RQtHgCuinCfUDuPGg7XMuYG1EZdfEOb658tjIySKfhhL4twC9NyWA?=
 =?us-ascii?Q?5RVmy8w8nYYle5uEyJHtsiSiaxjZ2UGAlGKgy38SLkw1qWYuU2YeD0cx/1n0?=
 =?us-ascii?Q?UNeBj9oXJno7V/TXMC5WL28RHfoTdwtUZvuFCpRCtnvF0lOCbrnfP11HmWR+?=
 =?us-ascii?Q?ANOZ+B1hE6RND3y2sD/E+/ruA7N1J0vMyS/QDB5wyw7XGpqBIV3wdrBBOSG7?=
 =?us-ascii?Q?hwb1mY63JO3jBIYqJnuhA2IIUbsljmNFPYFfYgUHg6l2/vijcAZkTmi04Ya0?=
 =?us-ascii?Q?TIM80yFQGPVffTbFNvIv9CERZ+mN5rnsZBQJN3EaCqso++HsfILcyKo7tYHS?=
 =?us-ascii?Q?UJlPSlljikayJ8vhcWcyBi5v1BJxVBMmaj6Yny3i6nn6r8rrpHBdanh1WFBy?=
 =?us-ascii?Q?EJJaxa2GtqdOT8Xteil8LFCJSZHyZlS3tE1YwgKHHHhl+sKcy7hOGiWg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ad+wZSIVTQGAd+V+4Imrb96NQAocbm1qSBq/LIJtxi+hLI8fUGXPm5Y7MGlA4MKiKGwjqdMLDWMSumal4O6ArIOcAMdOZPGFHaKwRL9N6EISKj0dOhpg/YkJXQob25b7jJ/MggT4LKquOUFA3KN5IEFLd8zBFRrSVh9IuRuKqXkYHN5+gBvDG6boV4/vgUBVY569G7ANvHrl4k+U+FQ063GbdvOWu1+Fyis5VEGXKUiI+XYD/UzKtCU5rAqTz/deYInKVx3aIumxc77BhUVSG9y/2uUbrFMNrJ6H/Bc4nRgtllRrS6j4vE3WAIiAOe9uoPAsuXr/q6wmpnu5P1ggZdoxB37Srlt1bMVo4Vl8OP0=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;6:Y63rX/8zVZjsURR8lTSBQwKu+aHnyk3eGYRZFB5UWwS0eJmKxt3/zhYz55D1CBILYSjy0FFit5EyEusrdl2wuqbuiBuQ6AxR03otImx4he94d+sQk2whcoQTFr3yp/0RehhjDQ5BQMAZE5r8uHZx0NXrhux6uWUhKsT4vt2DbiYa5kAHt3eDgYZBve5ZX3zGkizpt2nFxaC4ErwCKekPHPHfvgu+2KLdxhTQ8UsLRmd1sjoG56+ALGShGGV6Ls9MJz+DMAoYzm1gPBJcXy4rovWiA/duzD+NXppRvERRpXwOHhDQLOPRyTkR3CQeURMQX76dX0FwHTLLw2P/X2ejnu/kmy7Zt0gxRHzJ0b5MULFKBqwYKY9xWRo+cmzFV+u098o+uarC7TnW3LK7HlbGq9BmequZZpwaaJIlNsA9KLu/Xn33VjGG4SIpPDyaLPCNrY6RkOVpgqFDw/Dz9is6AQ==;5:0QJXwh9R/ZOUwKlofe8ssJP7s1YoBCnNONBHrz7vIiDYaUkfCUbI3rqM+93qSnpW908NDHeyKrpJjok7gehRDI5GV9kcQNtTXmts2wSPCLS5j8uvU+o45EUcc/aC4fnqiyeE+xZZR/woU9OBLfZQhjVQvCp3g/KbQP3bYt6nkaU=;7:Zhe1lDcI4IhyUnXlGgHz0ialBVAjWWCCAh4gE+W2J8Wx5KId+vSGJf9rEjXN5nK11MWY7gL7wJj4OyYzefXRyhgmH78ndCmxvahU6xtg0Z9N8ou9rTIgaQjqZK1U84UJsyeTD66tZ4o5wHIHJgQF44fs8JRVy9yIZI4e3i0uIDWEI0l4seyZiS/wD1OOX05v9a1TWEbRsjhmb018e/6Nj3vnuG70emMF8KamEX/PiXruQht4tv5XyHjQdp2gqg0Y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:56.1860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79db40ca-dd6c-4f7b-9e08-08d5f2250699
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fe1ea245..1e5cd4b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2290,7 +2290,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.1.1

