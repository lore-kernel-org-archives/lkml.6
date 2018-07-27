Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C50C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7AA20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gIFH1i/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7AA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeG0HnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:43:19 -0400
Received: from mail-eopbgr710082.outbound.protection.outlook.com ([40.107.71.82]:30016
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeG0HnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llcmDc2MqL5DA83zLNBIUX28KI471+0Zp1kzKraTY8A=;
 b=gIFH1i/lrctajXKZ0gyZUWWDKr7ibd0ZJX2IGcu+dXHJPEAOL2UEKul9C3MY0dyiBqdhwTjLdiCTy4E7YTsXHIIKCeWa/llLx/d45RNJ+yQw2a00881AsSJE0buXMSdiUKRI1U7Q9nACSCn/7nRJcjRqKCmw6xYuIAijv06e0pE=
Received: from SN6PR02CA0011.namprd02.prod.outlook.com (2603:10b6:805:a2::24)
 by SN6PR02MB4464.namprd02.prod.outlook.com (2603:10b6:805:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 06:22:58 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN6PR02CA0011.outlook.office365.com
 (2603:10b6:805:a2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Fri, 27 Jul 2018 06:22:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Fri, 27 Jul 2018 06:22:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fiw9O-0006cY-2t; Thu, 26 Jul 2018 23:22:54 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fiw9I-0003h2-Uo; Thu, 26 Jul 2018 23:22:48 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6R6MdvQ030108;
        Thu, 26 Jul 2018 23:22:40 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1fiw99-0003fZ-Ar; Thu, 26 Jul 2018 23:22:39 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <michal.simek@xilinx.com>,
        <kedare06@gmail.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <navam@xilinx.com>,
        <apandey@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v4 2/2] fpga: zynq-fpga: Add support for readback of FPGA configuration data and registers
Date:   Fri, 27 Jul 2018 11:52:31 +0530
Message-ID: <1532672551-22146-2-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(478600001)(50226002)(4326008)(63266004)(336012)(54906003)(14444005)(77096007)(316002)(110136005)(81156014)(8676002)(486006)(81166006)(2616005)(476003)(26005)(126002)(186003)(6666003)(8936002)(9786002)(36756003)(106002)(305945005)(356003)(2906002)(426003)(446003)(36386004)(39060400002)(5660300001)(76176011)(7696005)(51416003)(47776003)(48376002)(50466002)(11346002)(16586007)(106466001)(2201001)(107886003)(107986001)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT044;1:tJ2vK2nluwHov3hYxkyGhEtB8V+G6/mWoir3FhFz2vc0DX8QrnDYLm10gSRhsxAtea4TJpskRK/pcKzuNJnVfDEf6lX+fY8PJAqDxBu0PLu6wr3qEp9yg4ly3bSlcpRt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cf98bc4-8d62-4fc3-f294-08d5f3896516
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:eIpkil7GkSDcMtn1kWWRRKbvarE+bzfWExQGnZOM7xp8e/Z0SyijbT1qEcvATbvOCEycZIZCT5meVosMnr2NMn5LkP8yF+mrQlCQvR59t26NkLEQl0EtXetua1WaEfeAV8dhkd+587l7NSd1355/oOc42Y8g73JeDkRTbhbMXHlekqMyVkj8tO8yBT/xhOVTGAqMlepiY9+FaWUqwj2UUDXTzTlTKM4R1JR1p5u5UfEeqhNh8YMOhwRBuZbphXgelPJyKpds4LWAT1Q1GtSJnYQLR2eNd8HhZxMtDxzZzMD9ABfTXsIhIbm3l8H6s++mckZZL8KVgDDl3rgwK8rzBw6m8uYp4ePR8AmYjAquwCs=;25:jBdgSFXGsUx93Q9TTIwo0g2LvhfOYxrv/MH1dGHsLt4MpcN/qtlMlAy/BFO5Q0tQ3jJABWw0141MffDEMcRuO3IhbXLQvEeC0rtRW6drL2fUcIuEfhmTZyh70h7i6dBbvtN6h4yfcwECgdshh8mFoOTdTbwWG00PaMhGLrvuIWh69fcBeqlkC3kS+CIOJJy4NQM+X3KdPPt85DRwWvm/NILgnnVSyMtq6kh1oMejBJN/EHWalOTnyztioYb0WSpnKttVuDuYFBtosMbliTSeic2g5dATEyJXYs/wfASwxCLjvsoqHGP1XbZOV0FEk1oLJlqXjYkRAMDwSeG3HuZRug==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:WO+89ZZ/oJI6CvVfU6GypHAMyLxLYkDQ+TznzNugDoPyxBVFsr6n0cPDSGG6Ci16iLWeIs1BdoJcFIh1UBH2C/yDh0x+nIE9LF/hVZHlEe5+fCU38eqcfuh3iXlU3iKyWMHTQbTgj3/02ocQlGCkFKV67qBVwInz9utoy2875kqlGceZlXkzoHFafMYMdghuxaaTSZIjsV8RxLO9XpBQrxjYcJ5oToDwMraJtYK/9DU=;20:zXbhTaqPy9ylscghj+WJLenEb9aYqrGXvlm8Yxsj+dBfls8UEdB5Wht485wP4xChfK4q+UyN4RtASIu+yiUlzyu9YNdLGFjtHLhOJj3W74PP65AYZaxiQXpB5MlkHnkDglWQskTrmGS/ovBqR7hpj4JdqTLg6/gkmJKTIONLtcu/VZyNUo1U5rla3QK2NKo6rDawhlTpmHOnNC03S1FQ9JCmwRwH+9E9/nlvLodn41IJ3PK+IsWRX7ytyvh6j2qRZXKcf1rXrMEeN/nGyMUa0jNLCn8MIf11xUx+WsEW0+k/n8O2Dgph42bXluZI4+hZRkzS87nSpreVpRnNDgjQIW6i37ts8yjkTlY09Qg+EwBsCj+vKPczQazALA6nJybt0DtkH5Nh8HtvZyLLKjbeoj6oMP3l4RcnZrWRgbmYVEkjPo3ZLZPixFOwPLq4ISU2p2RS8q+H+YqrleQOkeXAUnaqW03eJY6Cm3vL3pMOWEz1fZ7VHD4rTnkNuykiJaxW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4464DE4217BE36D505D3B969DC2A0@SN6PR02MB4464.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4464;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:UeWRRDLskP5Prh5pB/FjWnaupCV+M00gQ3rQQasgrzawuPpUmaVs6vSKgQHko3tUNuDhAR1U+iLxJ89s3Q/lLOkvLGdi+7gei9/EHB+3oQIc9tYHU7zQ/IlD0bLmh+554xRo7BUw9vk7hI9tCkEZ01pRLWdnVOPZxKymRf10C31TxVNhlvVqEJShDHRyJLt3Mk98b9u1SmX1K14uIwJqKF70WooBaM8mdUhEIgPBXUaWgpiqdqOhjxTEOqXMlAWcpMf5tjVq5dpWOKnFewCca/BxTcJGoF86I8P7isvBsrwwfmyrDmjMDfJ8qRr0zhrJ
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4464;23:40FP4Cf4RJHdpFwOFdtQ+eQRA9Jgl6hYCPtlqwWEB?=
 =?us-ascii?Q?wYWMkXU5pKgx3I3qJWN1FIzWJE8myD5bPi3SY56LmwPzkr/vl56C3gh4XQu/?=
 =?us-ascii?Q?aLk58+UxdX56/uE8P9V6Vf138vBPaXPZQUH+Sj0udjyCzrF4GgJDXX2EbEoM?=
 =?us-ascii?Q?FinPlN3tVkRh9hqSvFvRE4mFe6marWzW3WjI9RisaQiPxIlx/K//sNsXA4oK?=
 =?us-ascii?Q?iC4GhoM9uek0DZLD9h7QZ4k3r7AtLoJ/FMcsWrpAcDIG1vm74O5DhHPg5htZ?=
 =?us-ascii?Q?llSeyxGWCypsuV/LQDZC8TinmFQeYLCUxp80CGZ40L/pz3u7ddlW/6KiODFz?=
 =?us-ascii?Q?hUC3kcNEkXfXEvDyGFAUDFhA6EwCHHlWU55nlFrskzwQTGR0VCSQCEAXh/ZN?=
 =?us-ascii?Q?tYhOCqgf0VULWXkjhUgWqf3cOh6PRnVH8mdZ5qtdZfIjsITvHL9Y7x1OMAIn?=
 =?us-ascii?Q?U+nu+Zpv++PUAgcpB09GOsLzOlSCEmQHO6LoTMNnzS3ZVok1hHv9HPP8pUHe?=
 =?us-ascii?Q?wA92gUQsNyzgLzUiXwR6ORdD3TreQjuVu4EEsl+EpJToqwPdfzVOmGRzvFva?=
 =?us-ascii?Q?cc5v41Bdlx7z30VBx/RQUnRioJq3g9DjS1sxo3EofGko/2hjDKbvr9HLmS3q?=
 =?us-ascii?Q?P+xk9Jh2e2AV0aZma1BBklx+KoivGFNUQtaoLEkalxeZT4r6Pvz4wOJLptC8?=
 =?us-ascii?Q?aHHATFNpOn/wB4+5PAkPSxuEmRhjsetEEvEuqUgXHvmb4/sy1cYaFzb9bNci?=
 =?us-ascii?Q?tU6tHM2Y4kn2r2PqRGIQp6i+o6vTAmO/nntAcb3ZJUvQY1tqwi398oug1Egj?=
 =?us-ascii?Q?7mf4ieYSpvgCCv4IjajXfBDrxlfK6Bhp2J6ag9+hGm7lF5DQfUHFqzhSW2TH?=
 =?us-ascii?Q?6OHp5kpPIl/096IsfwZP0YQbsHk5GefWvDoSIYBaq+bcPlq7wObmHhsCmQXH?=
 =?us-ascii?Q?mOUxC0uJ+5zLYtMuxGt3gpxB675a8IBy1PxSjds36FxkOAaxG1AMXrOh4j/7?=
 =?us-ascii?Q?aktNWy/EJFcN72dPsWLl/6+b39vEZOeAZZMAW1HTOM1n5qLtoxDMruvDucJs?=
 =?us-ascii?Q?rLkZ+fbMtQ9q+8F+k7WTNliMGkd8aSJYzBu1V9yUryRYkmcaFdlgbqbkoc/l?=
 =?us-ascii?Q?O2/XWSqat2GF6/LNljEorW9Q2Ot82GFhWy7ocdUeZI7Wgh7t4iS4s/a9ghZw?=
 =?us-ascii?Q?BNMPUzio4ug4R6zS2e3N6Fqd0j2VHKr9hE3uT3Q4LVBvvW3YdmFYJaV1vgux?=
 =?us-ascii?Q?ayREIOU7wN0Rje5hfI3mn0DBhLlrlgzU85TDOA+RVM1enCSYwuEozFmduDzP?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: j3diQBMtHRBjN4GNS0SVn1RkOqgBVGjZhX/ippl7i8nA+7evXcxdrUS7cPnddfdhu4arLeHHbjUu/zMVZbI+rK4VqvGoB1qcNju+slf9aOazlFXT1RJXjzMBOcoR3Fz9FQ9yzd+DIJwBs+KlpZrxKr4UVYCPlpabML9TIx3yQuFf/Fgh/nUc6XS0CekxIAG+I5KSDzwCjF8R3UDzIZBraemsqwEkOyBFtWn5XuSKmK514hc+7k+lXsoWkYAPo/gYFZ1O2E/uAK2kPIgxcdqesXC7nsb0oXoutmp/rcwH/aodcF9kUo8kE/xPAeQN3nc4EWHSlGZj8JpKg/8mV/ysxtFm56+VEzIpbFawS23yPdA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:dZzb131rmvc7IVVWhsHFRAfil4gGu5AwGAlqgGCL9DRvwkouHbap0M5S2/M/my1t4aEvT+Y6UEu+339PYOtkWbgTSyK8KqGleX2XQfWl9i5cYGUEAMCcNRcpDiv6Hy0Go/OiDiWyW8Dz2KXD+DXZmiw8d8C/ETl0x0a/fCBtHeRHcFTALWlbbY3epTzF+7M9mthMtPohgtcoR5DEemj16uxS9scuFsDrszW1VH9XiNfbacYIEe1XM9zuj/O4AgJ3dB5UorHECeKfyQPdmcety8X2W8RhA4yUUxbWmbzaQa7G9aF6pVg9LFClcAhnlLTaK1D2BCsAi8AWJ4gfiWTwMsXa6QsR8PNlDKHYUJpQ4zQjJx3krDfS6zgPWZcoINyhQm/frA1jUL/AMiW6d0BVtmS+LDNXDwo1xDskgxqLStFoaKTGDHmcXAh6SHx1iEaYj1sQmxtLvL15Gu04OqCtUw==;5:s3Ud3y2k4QT9grubSqeN3H/4JGZBHRLFRqh87wiBORbrea/ZnBIxG6WtoSea+RNXwQEa5xCT+A1V5aqCQW8bG7nu19j1uXqEr1xrsx+SHjYmQ9PzN73URL8EuuPYT2P+qqB65jDJvsbIt8Z1RO7/lGK9eNkxZ70ulT9w59Ud09I=;7:X7/+ODJCKWzNbrHVWPLX5ZOGklQgMBwe1ywR7IS1ezDfcIgB0OkSVuIQo6JqFdcZaEPABP8Vn1meXdbvc9Ow3nu89bn5PJfVjE6JuqA1EG/a2oYYNTNcAmhRQ4KxBCY+tNdCl3pVFrYC/TIX839yKOU4j4+qe0yh+F09ke2VhRvcRXbZ+7htLMaQiH1UhBuCArM1FXz1+Pjo13fDCY5m4JhhEyk7c/pjAiKO4yS0/Xrr5dIwEgv4eAjjEyxqrnyz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 06:22:55.0020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf98bc4-8d62-4fc3-f294-08d5f3896516
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for readback of FPGA configuration data and registers.

Usage:
Readback of PL configuration data
        cat /sys/kernel/debug/fpga/fpga0/image
Readback of PL configuration registers
        cat /sys/kernel/debug/fpga/f8007000.devcfg/cfg_reg

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v4:
--> Improved commit message description as suggested by Moritz.
--> Used GENMASK and BIT() Macros wherever applicable as suggested by Moritz.
--> Fixed commenting sytle issues as suggested by Moritz and Alan.
--> Get rid of the readback_type module param as suggested by Alan and Moritz.
Changes for v3:
--> Added support for pl configuration data readback
--> Improved the pl configuration register readback logic.
Changes for v2:
--> Removed locks from the read_ops as lock handling is done in the framework.

 drivers/fpga/zynq-fpga.c | 430 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 430 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 70b15b3..1746d18 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -31,6 +31,7 @@
 #include <linux/regmap.h>
 #include <linux/string.h>
 #include <linux/scatterlist.h>
+#include <linux/seq_file.h>
 
 /* Offsets into SLCR regmap */
 
@@ -127,6 +128,69 @@
 /* Disable global resets */
 #define FPGA_RST_NONE_MASK		0x0
 
+/**
+ * struct zynq_configreg - Configuration register offsets
+ * @reg:	Name of the configuration register.
+ * @offset:	Register offset.
+ */
+struct zynq_configreg {
+	char *reg;
+	u32 offset;
+};
+
+static struct zynq_configreg cfgreg[] = {
+	{.reg = "CRC",		.offset = 0},
+	{.reg = "FAR",		.offset = 1},
+	{.reg = "FDRI",		.offset = 2},
+	{.reg = "FDRO",		.offset = 3},
+	{.reg = "CMD",		.offset = 4},
+	{.reg = "CTRL0",	.offset = 5},
+	{.reg = "MASK",		.offset = 6},
+	{.reg = "STAT",		.offset = 7},
+	{.reg = "LOUT",		.offset = 8},
+	{.reg = "COR0",		.offset = 9},
+	{.reg = "MFWR",		.offset = 10},
+	{.reg = "CBC",		.offset = 11},
+	{.reg = "IDCODE",	.offset = 12},
+	{.reg = "AXSS",		.offset = 13},
+	{.reg = "COR1",		.offset = 14},
+	{.reg = "WBSTR",	.offset = 16},
+	{.reg = "TIMER",	.offset = 17},
+	{.reg = "BOOTSTS",	.offset = 22},
+	{.reg = "CTRL1",	.offset = 24},
+	{}
+};
+
+/* Masks for Configuration registers */
+#define FAR_ADDR_MASK		0x00000000
+#define RCFG_CMD_MASK		BIT(2)
+#define START_CMD_MASK		BIT(2) + BIT(0)
+#define RCRC_CMD_MASK		GENMASK(2, 0)
+#define SHUTDOWN_CMD_MASK	GENMASK(1, 0) + BIT(3)
+#define DESYNC_WORD_MASK	GENMASK(2, 3) + BIT(0)
+#define BUSWIDTH_SYNCWORD_MASK	0x000000BB
+#define NOOP_WORD_MASK		BIT(29)
+#define BUSWIDTH_DETECT_MASK	0x11220044
+#define SYNC_WORD_MASK		0xAA995566
+#define DUMMY_WORD_MASK		GENMASK(31, 0)
+
+#define TYPE_HDR_SHIFT		29
+#define TYPE_REG_SHIFT		13
+#define TYPE_OP_SHIFT		27
+#define TYPE_OPCODE_NOOP	0
+#define TYPE_OPCODE_READ	1
+#define TYPE_OPCODE_WRITE	2
+#define TYPE_FAR_OFFSET		1
+#define TYPE_FDRO_OFFSET	3
+#define TYPE_CMD_OFFSET		4
+
+#define READ_STEP5_NOOPS	6
+#define READ_STEP9_NOOPS	32
+
+#define READ_DMA_SIZE		0x200
+#define DUMMY_FRAMES_SIZE	0x28
+#define SLCR_PCAP_FREQ		10000000
+
 struct zynq_fpga_priv {
 	int irq;
 	struct clk *clk;
@@ -140,6 +204,11 @@ struct zynq_fpga_priv {
 	struct scatterlist *cur_sg;
 
 	struct completion dma_done;
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct mutex ref_mutex;
+	struct dentry *dir;
+#endif
+	u32 size;
 };
 
 static inline void zynq_fpga_write(struct zynq_fpga_priv *priv, u32 offset,
@@ -164,6 +233,27 @@ static inline void zynq_fpga_set_irq(struct zynq_fpga_priv *priv, u32 enable)
 	zynq_fpga_write(priv, INT_MASK_OFFSET, ~enable);
 }
 
+static void zynq_fpga_dma_xfer(struct zynq_fpga_priv *priv, u32 srcaddr,
+			       u32 srclen, u32 dstaddr, u32 dstlen)
+{
+	zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, srcaddr);
+	zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, dstaddr);
+	zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, srclen);
+	zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, dstlen);
+}
+
+static int zynq_fpga_wait_fordone(struct zynq_fpga_priv *priv)
+{
+	u32 status;
+	int ret;
+
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	return ret;
+}
+
 /* Must be called with dma_lock held */
 static void zynq_step_dma(struct zynq_fpga_priv *priv)
 {
@@ -192,6 +282,7 @@ static void zynq_step_dma(struct zynq_fpga_priv *priv)
 			priv->dma_elm++;
 		}
 
+		priv->size += len;
 		zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, addr);
 		zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, DMA_INVALID_ADDRESS);
 		zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, len / 4);
@@ -401,6 +492,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	int i;
 
 	priv = mgr->priv;
+	priv->size = 0;
 
 	/* The hardware can only DMA multiples of 4 bytes, and it requires the
 	 * starting addresses to be aligned to 64 bits (UG585 pg 212).
@@ -546,12 +638,327 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static int zynq_type1_pkt(u8 reg, u8 opcode, u16 size)
+{
+	/*
+	 * Type 1 Packet Header Format
+	 * The header section is always a 32-bit word.
+	 *
+	 * HeaderType | Opcode | Register Address | Reserved | Word Count
+	 * [31:29]      [28:27]         [26:13]      [12:11]     [10:0]
+	 * --------------------------------------------------------------
+	 *   001          xx      RRRRRRRRRxxxxx        RR      xxxxxxxxxxx
+	 *
+	 * @R: means the bit is not used and reserved for future use.
+	 * The reserved bits should be written as 0s.
+	 *
+	 * Generating the Type 1 packet header which involves shifting of Type1
+	 * Header Mask, Register value and the OpCode which is 01 in this case
+	 * as only read operation is to be carried out and then performing OR
+	 * operation with the Word Length.
+	 * For more details refer ug470 Packet Types section Table 5-20.
+	 */
+	return (((1 << TYPE_HDR_SHIFT) |
+		(reg << TYPE_REG_SHIFT) |
+		(opcode << TYPE_OP_SHIFT)) | size);
+
+}
+
+static int zynq_type2_pkt(u8 opcode, u32 size)
+{
+	/*
+	 * Type 2 Packet Header Format
+	 * The header section is always a 32-bit word.
+	 *
+	 * HeaderType | Opcode |  Word Count
+	 * [31:29]      [28:27]         [26:0]
+	 * --------------------------------------------------------------
+	 *   010          xx      xxxxxxxxxxxxx
+	 *
+	 * @R: means the bit is not used and reserved for future use.
+	 * The reserved bits should be written as 0s.
+	 *
+	 * Generating the Type 2 packet header which involves shifting of Type 2
+	 * Header Mask, OpCode and then performing OR operation with the Word
+	 * Length. For more details refer ug470 Packet Types section
+	 * Table 5-22.
+	 */
+	return (((2 << TYPE_HDR_SHIFT) |
+		(opcode << TYPE_OP_SHIFT)) | size);
+}
+
+static int zynq_fpga_ops_read_image(struct fpga_manager *mgr,
+				    struct seq_file *s)
+{
+	struct zynq_fpga_priv *priv = mgr->priv;
+	int ret = 0, cmdindex, clk_rate;
+	u32 intr_status, status, i;
+	dma_addr_t dma_addr;
+	unsigned int *buf;
+	size_t size;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	size = priv->size + READ_DMA_SIZE + DUMMY_FRAMES_SIZE;
+	buf = dma_zalloc_coherent(mgr->dev.parent, size,
+				 &dma_addr, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+
+	seq_puts(s, "Zynq FPGA Configuration data contents are\n");
+
+	/*
+	 * There is no h/w flow control for pcap read
+	 * to prevent the FIFO from over flowing, reduce
+	 * the PCAP operating frequency.
+	 */
+	clk_rate = clk_get_rate(priv->clk);
+	ret = clk_set_rate(priv->clk, SLCR_PCAP_FREQ);
+	if (ret) {
+		dev_err(&mgr->dev, "Unable to reduce the PCAP freq\n");
+		goto free_dmabuf;
+	}
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto restore_pcap_clk;
+	}
+
+	cmdindex = 0;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = SYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = SHUTDOWN_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = RCRC_CMD_MASK;
+	for (i = 0; i < READ_STEP5_NOOPS; i++)
+		buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = RCFG_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_FAR_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = FAR_ADDR_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_FDRO_OFFSET, TYPE_OPCODE_READ,
+					 0);
+	buf[cmdindex++] = zynq_type2_pkt(TYPE_OPCODE_READ, priv->size/4);
+	for (i = 0; i < READ_STEP9_NOOPS; i++)
+		buf[cmdindex++] = NOOP_WORD_MASK;
+
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Write to PCAP */
+	zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Read From PACP */
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0,
+			   dma_addr + READ_DMA_SIZE, priv->size/4);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "DSTDMA: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Write to PCAP */
+	cmdindex = 0;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = START_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = RCRC_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = DESYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+
+	seq_write(s, &buf[READ_DMA_SIZE/4], priv->size);
+
+restore_pcap_clk:
+	clk_set_rate(priv->clk, clk_rate);
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, size, buf,
+			  dma_addr);
+disable_clk:
+	clk_disable(priv->clk);
+	return ret;
+}
+
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int zynq_fpga_getconfigreg(struct fpga_manager *mgr, u8 reg,
+				  dma_addr_t dma_addr, int *buf)
+{
+	struct zynq_fpga_priv *priv = mgr->priv;
+	int ret = 0, cmdindex, src_dmaoffset;
+	u32 intr_status, status;
+
+	src_dmaoffset = 0x8;
+	cmdindex = 2;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = SYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(reg, TYPE_OPCODE_READ, 1);
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto out;
+	}
+
+	/* Write to PCAP */
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+
+	zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA: Timeout waiting for D_P_DONE\n");
+		goto out;
+	}
+	zynq_fpga_set_irq(priv, intr_status);
+
+	/* Read from PACP */
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0, dma_addr, 1);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "DSTDMA: Timeout waiting for D_P_DONE\n");
+		goto out;
+	}
+
+	/* Write to PCAP */
+	cmdindex = 2;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = DESYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret)
+		dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for D_P_DONE\n");
+out:
+	return ret;
+}
+
+static int zynq_fpga_read_cfg_reg(struct seq_file *s, void *data)
+{
+	struct fpga_manager *mgr = (struct fpga_manager *)s->private;
+	struct zynq_fpga_priv *priv = mgr->priv;
+	struct zynq_configreg *p = cfgreg;
+	dma_addr_t dma_addr;
+	unsigned int *buf;
+	int ret = 0;
+
+	if (!mutex_trylock(&priv->ref_mutex))
+		return -EBUSY;
+
+	if (mgr->state != FPGA_MGR_STATE_OPERATING) {
+		ret = -EPERM;
+		goto err_unlock;
+	}
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		goto err_unlock;
+
+	buf = dma_zalloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
+				 &dma_addr, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+
+	seq_puts(s, "Zynq FPGA Configuration register contents are\n");
+
+	while (p->reg) {
+		ret = zynq_fpga_getconfigreg(mgr, p->offset, dma_addr, buf);
+		if (ret)
+			goto free_dmabuf;
+		seq_printf(s, "%s --> \t %x \t\r\n", p->reg, buf[0]);
+		p++;
+	}
+
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf,
+			  dma_addr);
+disable_clk:
+	clk_disable(priv->clk);
+err_unlock:
+	mutex_unlock(&priv->ref_mutex);
+	return ret;
+}
+
+static int zynq_fpga_read_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, zynq_fpga_read_cfg_reg, inode->i_private);
+}
+
+static const struct file_operations zynq_fpga_ops_cfg_reg = {
+	.owner = THIS_MODULE,
+	.open = zynq_fpga_read_open,
+	.read = seq_read,
+};
+#endif
+
 static const struct fpga_manager_ops zynq_fpga_ops = {
 	.initial_header_size = 128,
 	.state = zynq_fpga_ops_state,
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
+	.read = zynq_fpga_ops_read_image,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
@@ -621,6 +1028,26 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 		return err;
 	}
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *d;
+	struct fpga_manager *mgr;
+
+	mgr = platform_get_drvdata(pdev);
+	mutex_init(&priv->ref_mutex);
+
+	d = debugfs_create_dir(pdev->dev.kobj.name, mgr->dir);
+	if (!d)
+		return err;
+
+	priv->dir = d;
+	d = debugfs_create_file("cfg_reg", 0644, priv->dir, mgr,
+				&zynq_fpga_ops_cfg_reg);
+	if (!d) {
+		debugfs_remove_recursive(mgr->dir);
+		return err;
+	}
+#endif
+
 	return 0;
 }
 
@@ -632,6 +1059,9 @@ static int zynq_fpga_remove(struct platform_device *pdev)
 	mgr = platform_get_drvdata(pdev);
 	priv = mgr->priv;
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	debugfs_remove_recursive(priv->dir);
+#endif
 	fpga_mgr_unregister(&pdev->dev);
 
 	clk_unprepare(priv->clk);
-- 
2.7.4

