Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF512C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A312082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yY1M4Pr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A312082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLAW0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:07 -0500
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:22888
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbeLAW0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibZ3ce3mIxteL+0e/bpAIX4Gwfd/RYi3ylv6pYFjtgs=;
 b=yY1M4Pr9W0islWCMHPhAv4WJMY01zhWV0LpX74K2bYv5SyNmDldmi3G42rM15yy/k/9j3uer4VMxMQ4oTe6JpB1Dw+1kioaUHEcxVGqiXaBgr+O2qfCyhONykrmLeZm+UzEpJNVMS799TPJVlbpsW4CgMWCwLoCZAf3sRg1DQRE=
Received: from BN7PR02CA0030.namprd02.prod.outlook.com (2603:10b6:408:20::43)
 by DM6PR02MB4460.namprd02.prod.outlook.com (2603:10b6:5:29::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Sat, 1 Dec
 2018 11:13:46 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN7PR02CA0030.outlook.office365.com
 (2603:10b6:408:20::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.21 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0002W3-4M; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DP-0001kp-0u; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDZZH015271;
        Sat, 1 Dec 2018 03:13:35 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DK-0001k2-UK; Sat, 01 Dec 2018 03:13:35 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 25B1B604E9; Sat,  1 Dec 2018 16:43:34 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 08/10] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Sat, 1 Dec 2018 16:43:29 +0530
Message-ID: <1543662811-5194-9-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(189003)(199004)(186003)(16586007)(39060400002)(48376002)(6266002)(2171002)(50466002)(36386004)(36756003)(107886003)(575784001)(52956003)(47776003)(2906002)(63266004)(478600001)(106466001)(103686004)(426003)(446003)(476003)(90966002)(106002)(110136005)(486006)(2616005)(126002)(51416003)(305945005)(11346002)(54906003)(336012)(4326008)(8936002)(81156014)(26005)(81166006)(5660300001)(6666004)(76176011)(356004)(8676002)(7416002)(316002)(50226002)(42186006)(921003)(107986001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4460;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT028;1:HuGqZvMyNqmzOjNeE+0ElgDIfs6aMS5EmRWWeLDGLZrLbI68oAD77aSVSdRMesg3uc2vLm50+nO0mBkNziWvAVWny0BvAcHyz3TmHjvEBURRVFgl8UCqOW4cOdTeytjD
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e84573f-a05c-448a-3d20-08d6577e0f7f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;3:llEF+tpe5tyjphXSeAczjxYlgqs20AV3Al6+ONox/Fv5VlkL1n8ew7z6lWOTHESxsyTyg29xzNSExFYP/qaIys6USC5u1+vcs8Ey7pg3Twk3iKapfWBj9NJMXuW/1EKyI6+hYGASr9BGNSTah0NP6xqp5aJWJW0Ex8mo1t/TvIPk449r+FwaYYAfkKfHRQvso8pA8plLgcvftJx9urywrxAzpSb8zVmnWx42zD6Ez2KD5Tg5ybCXKTBNvjJ1J5QjG5edL8/1IZYUSKIQaYeHFpECPW0y+ztYwaP5j8VrzB+GI3Dq2TxmoKs6gJH0bxlDfQWuAPKazlenidzVhux7iVFytsrTxTB3IGz29FGUrK4=;25:sEqZJQcabZQmg/Sd/pormwPx+1JX3Ll+Io9vy4tXMGaasXMpkPlJoK+FwekZ7ZFtEay8WnuLIJJ7Y/2Xcj/XVGUA47EL2S7VAMLsOAZ6AUw9SNeDFtiSQq0F+UXeI02HtjoOrfPwb6gm4sQavrdfQU1LABLjL+5fBM7kfzXGhrTSdjJ2W7AaQwKnKLXys02l01gxwuH4bEzMdTWYRD5J54FRbmqjkWoCWVKtXWpTltQ+7y1QRxBf2yVL29R6tMgcO9A4Krb4OmW4o2kw1BQYhWeqMu68QqH3plEBipBPxljDZW+7OZbDxHy0hWw9XNIuy7wI0QAO5u1yktcCFwPyYg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4460:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;31:uKcLiyrSfXRu9P8jhFUnoNDjgcjnh3utdV/uFWSpcPlKH5mxrgqeFKeiDsqPDcJPOQdP+mB++cct7NI0TLtGVN47XEHiXK2rLjKXNiVz1469Q7Ftnt+A7wg446QC/Mv4/b/g80/mj24CsFnmJOF5ImCwth9E6cpbBJm6NrtxM1g4ySOMBOeRNqYpSgTznZQX00Lgm/eG0bnYsVQ8c/3yqY51c3PiFborUv5ZIA9oVkc=;20:sgaa9uGZNf6Tye6z83G796L+kundH3Aw9h+6uoNxWQJZdIajdzoRbCECHLhI8RZpW1/e0c5ias3SmVXdQY8znLtZWmhckVkSK7B8CSR/+ptIvIC10eZoPo0SxcN8574Xiol134M/tb+dGgzn/9Yvkt2nQ8f5v/qmhkpGfW8feerqnP00XJvO0BA2J+KdyWZJlaUCTH26SaZpUPszFasl7gL/hbtQGaFwl1EVFbRiT17iZIbu4RjisiZlC8Xyj/+Gx9R03cmBE+jEs+vZFuhtwA/ABTM0Zsv/8oJIdwY4jh0n9FkSSViGdWaN2HFRl0afOOz46HQk95klhDkSdV6QXPzfMn75gHPqB57DNvhPJCuji/tqNvAKYjvyTdA5FWV0GcPJZ7VClFPmOAj61TA13eiRbDaB8ozJ/h/EYkZwF/qcHp4LbPwFekbUWDy7oqcD0pXObHQ7uzosV8UfTSak67oQBa9nyfr/EzAq80TWNcybyLruwA2I7GNQkGdC2S4H
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44603FF0D7E5DD3FBDEDF9E9A7AC0@DM6PR02MB4460.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231454)(999002)(944501475)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4460;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;4:trlnWTsmME6aHrATreUWI88KnHVB25BmgpMZxhW1V4BD/PWXwNOHMssUS3k9sI+LKN6EILcVNYTKKotQkL616dBBn/sn9CNtH87cUNRDxQ7veONXzg/50Kaw4R1WUkqcVfHqw0U9pAVgbBA8jD5j2uwIuPw2dG64C/irOcdchfmKlGk8t3F5nWBmya9LO9ch4/YJyKCJQNB7sWgr+jKHFWmgY+CjxjCoLgWNKGKMbTPYhTNy66OuoGpd0szrDkEmYQsVrQmQvD9ORzXiPtg+DA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4460;23:DxKoE48MRJRo1YDGdFKz9Uamupcp7tesZyjSPSzjX?=
 =?us-ascii?Q?DeMvFOajlenRJ4E2Prp5P0LNut+EsqqCo3F4Zla5SAaoLgbn+U1Y22LjRAL2?=
 =?us-ascii?Q?yAaLnlcqjIIAq7Q298VTl76g1qORZ1h/WqcCXsybCFixeP4dJWwRj/993vPw?=
 =?us-ascii?Q?DrZbVH2ZN4y+MVkHV3IczolvF5j3lVZrsNsoBYUbOKZSXqNQLzOBS5X2iaw+?=
 =?us-ascii?Q?bw7hTZnVl9L4N8ar8twNFhFP4wIKkqZV5lfBZfcDmjIoqdUC0y2OyqMIolWL?=
 =?us-ascii?Q?6V8xEaZITlpsyUAsVxTMC9DCXfw0Fz2Dz7VcwyxcNaRzxi1zAbyjiA7uQdCa?=
 =?us-ascii?Q?dPyUr2S4ZIbIs7B7qBOizBsTHZTOZbF+f5HCkaJ46LP/6tXtLcbqLiGzZH3c?=
 =?us-ascii?Q?WNuMsrVDoY6iHvSj4XntiPxr4q1OhIUdlwt4Ln6smre9AMEM1aIJHp5Y5lL2?=
 =?us-ascii?Q?HweN2HONvn66mpbkHQF3zGoZkx7KTCrppHXquoB045N2cLuO+m4uokfVTRZF?=
 =?us-ascii?Q?/CAHKU5h9bQbJa+gXDwxdpnvZSTueKm5bSel1Bch0gxDeQe/GJ+SWHb1E6sV?=
 =?us-ascii?Q?sjkIqNjEiXWCO4Xo5EfLjX8MBApRalqTtmZGeIUevfbuUyEMBSKmZW1HO8fM?=
 =?us-ascii?Q?k2XxHYj+RHW0TtWFXEVQ4pTTKHMXSGfZS8RAFlBe2UOnNRmGdJi5HJChtLsY?=
 =?us-ascii?Q?OrgAMAmMIjJdPEsbSDi4heezAlh94fqP5E5d41966GQLwzjhfz5t1r/MgdHI?=
 =?us-ascii?Q?k9p8ZbIt6MndFUgD0GxfHDtFIcq1f1Fx/HlZFOKt3iR9iJ/LRs4S5rAL4ikH?=
 =?us-ascii?Q?UYxQnWmFyhGQCak0RJSctJfrBjt8zhVBmNSS5sN4873l/MCVmSIWwc6LLFjQ?=
 =?us-ascii?Q?1VEGviJX80ZYWv827X2+YxSHY740G0AHL00nLgWysdi0Rkx5KtDzeqQ9s6yZ?=
 =?us-ascii?Q?iRXzlonW1iSKFYoaTUmR2UOVmyJJ4LIteCPbtu0N2ksjfavAzBrirwXxvwt6?=
 =?us-ascii?Q?YeQ0f2/kyaz/dPdS4CmnvMqVkZEAC8N/MggxqpTJSxkrpEWrZHyMs8wmPD7J?=
 =?us-ascii?Q?X5l6Xk7RXhiLWdJbkys7BeuXysniGa73Q1KhnDviZjqbXQ99tEsuoGUVEMai?=
 =?us-ascii?Q?Plr9acGY/seu0fJlTVMmGLBkO4/su4q12LdwcF4qYLHn5K8sWfgVZqsutazH?=
 =?us-ascii?Q?SzIcIpFsn6lzmjckowuJHonbg26akgVM1ljwlw59FS5+61Ujvf5NSnnaVTiF?=
 =?us-ascii?Q?jpWA7T+YjRNPZtFOxfAJNFA9TdUeiArEIXEAiqHxzhkSrQsxb4C7sFzlTQ8L?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: AxEkPVUCX35s5lfSoOeMCAwlBsoPmWBu3mEIcLj+Q7+Im7YuYRet5YW1gX+x7xzwUaN5K1rjrtI2744d1Y9aigofs2mYVZJZIDbDzdqbTfX0z3Rb9mi9gTSkltCNVWJZxS4hIVRZPanW4VGWhopWxs5pDeeykm5PjYrPiMPmtyWw5wQV8zxGYMKiIv+RCWFTrcZMDNdDQPgfKmI8fI3SuUSg6kOjlEOm8/gIK8gYfAp7u9/fWWu9eFFwx6LhMX9aTNN0DagsKpnWl1DeAYk4Ji1UU/svv7XK43c57ISejVTjfQq7QHZJ730ve4lnLDLkQvhBYLrkkMXxT61nE1KR3K2OjHMtW8W5K8XiZ5G+CfY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;6:nkYXDQyvr+s9m/2USH8QZOPyeWkAxh9B0JGN1gip/HRbFg7ICfsqG6nnEaPJpjoZnAYtj57xAiWyz7vUYQ7KoNH7PV192WLLttnpOpmng+PNPn96pA3M4YLURs6nGxAVMiV+GvDZhRwVkn7hyhle5P+bwozYNCEirUZQzWL4eVcD7SWAPgp6v5rT9AFkztNZmTN/Jk5BBOJmHyThFeF+WM2ZoXbgLgNRxqOjeDgT4HozkImfB0M5ZCQg5eyPikPNTuijAghjOqbWaBmGJSLE+CWx4V3n9ZVgV80n/DPvcPFJTNtJ4LP/B0gKpVT6li8hYMKhPS7d3pL9phZupvPv3MQg1yxrCQbS4nF8mip5Ys/PHVZFNmSCVWEdV8dKmifdXoiGKgjwW8ZQjplVPixt07RAlYU/WQHzJElB300ybQmK92DAHOU6UbaEl0NP9qxqu8zQo/zwJ7hZpgbA7/YCYQ==;5:v5sFN2GsNWx14u4EA3fK5NsU0j36D86OlVK27R/jJAeKWvTVoKhCpUId1FeOXMTdx5iM8zNht/xmU7x4N+Rd5Z73IkZLqVckIi3SShpdk++dG2MV9jnzTdOVtbS+j/exgHJhePE03M53v9Gi+f+8jFQampVKZMP4J22akoBTExI=;7:T02ohJzhscejZNN95iGQ6g0rRLw8RTLGAUWfVUJ6+8zdbypeXj1cVYDyRa2xPa1JQQcBtSaxE2Swrutm/+nC3fPEH9fQ5lVRjvaFD3hmmWNmootS9rboKU7pzmQMPBZmHlbi66klJKGd5MOfB14vdA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:44.6371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e84573f-a05c-448a-3d20-08d6577e0f7f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Availability of TRB's is calculated using dwc3_calc_trbs_left(), which
determines total available TRB's based on the HWO bit set in a TRB.

In the present code, __dwc3_prepare_one_trb() is called with a TRB which
needs to be prepared for transfer. This __dwc3_prepare_one_trb() calls
dwc3_calc_trbs_left() to determine total available TRBs and set IOC bit
if the total available TRBs are zero. Since the present working TRB (which
is passed as an argument to __dwc3_prepare_one_trb() )  doesn't yet have
the HWO bit set before calling dwc3_calc_trbs_left(), there are chances
that dwc3_calc_trbs_left() wrongly calculates this present working TRB
as free(since the HWO bit is not yet set) and returns the total available
TRBs as greater than zero (including the present working TRB). This could
be a problem.

This patch corrects the above mentioned problem in __dwc3_prepare_one_trb()
by increementing the dep->trb_enqueue at the last (after preparing the TRB)
instead of increementing at the start and setting the IOC bit only if the
total available TRBs returned by dwc3_calc_trbs_left() is 1 . Since we are
increementing the dep->trb_enqueue at the last, the present working TRB is
also considered as available by dwc3_calc_trbs_left() and non zero value is
returned . So, according to the modified logic, when the total available
TRBs is equal to 1 that means the total available TRBs in the pool are 0.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
---
 Changes in v7:
	1. None

 Changes in v6:
	1. None

 Changes in v5:
	1. None

 Changes in v4:
	1. Corrected the commit message as suggested by "Thinh Nguyen"

 Changes in v3:
	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed the commit message
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d0de7dc..9ddc9fd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -920,8 +920,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -1000,7 +998,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1020,6 +1018,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1

