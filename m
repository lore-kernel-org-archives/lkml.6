Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E5A20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Owo2iYoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E5A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeGYNDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:24 -0400
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:3979
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728897AbeGYNDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Um6Y8Vjbo+W/DI2SZhnG2tvpx2LF4Gjc3WhPVys2E=;
 b=Owo2iYoJZA8Ar/p5QP+fMNRm0ytvYbgfbEndDArPVlhOkLjAaD6LT5L3F+MZJ8TjPSbO75ngXag1p02UyzzByTDvOGPRJP7qkHIhUrhXFfpEj8HSjK4SkTpbY2xuAb5QHpK3bEEd9L3Y8goDXhvUUjeszCcIeTdCwkZIH9gVEik=
Received: from CY4PR02CA0031.namprd02.prod.outlook.com (2603:10b6:903:117::17)
 by BLUPR02MB084.namprd02.prod.outlook.com (2a01:111:e400:811::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.22; Wed, 25
 Jul 2018 11:51:56 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0031.outlook.office365.com
 (2603:10b6:903:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43931 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKh-0004QQ-CL; Wed, 25 Jul 2018 04:51:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKc-0006dG-9L; Wed, 25 Jul 2018 04:51:50 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpfRY027062;
        Wed, 25 Jul 2018 04:51:42 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKT-0006a5-IY; Wed, 25 Jul 2018 04:51:41 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id AFBFC60505; Wed, 25 Jul 2018 17:21:40 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 6/8] usb: dwc3: check for requests in started list for stream capable endpoints
Date:   Wed, 25 Jul 2018 17:21:29 +0530
Message-ID: <1532519491-19502-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(6666003)(16586007)(106002)(446003)(51416003)(126002)(11346002)(54906003)(476003)(2616005)(426003)(305945005)(5660300001)(110136005)(486006)(186003)(90966002)(26005)(478600001)(63266004)(76176011)(36756003)(52956003)(336012)(106466001)(42186006)(316002)(4326008)(356003)(14444005)(47776003)(39060400002)(8936002)(81166006)(48376002)(2906002)(107886003)(50466002)(81156014)(8676002)(50226002)(36386004)(6266002)(103686004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB084;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT008;1:THBxRVziudxi1ygra7wWcg7I7sG1tsnTjrHo9FLdgbsuoEmKA92wCK2E1knuTQkGCX2uI73cZMcKLdRXU5eoBO/YWHtzV6EGYyt4YG+dctXSd7HN4yj5Ou2XZoK2efmY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f6a0586-ec67-46b1-bd38-08d5f2250572
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB084;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB084;3:fKZF9tcuCAcApH+tK9F8brzntBrbz3xmOXjJZemvSAMEWFMbssHI5+YxBdlOLmiYbSBe2nTXe4JE9/SUf6d0bsgbEvb4qN4uPJpkL45YUYTqMxE9Hx2YeNA+bJ8+iyEkKf+yDcdSxWFuqQD0yA7vrfewfZvbelwyg94uoQ70bIPyRIbrRsVceKIaqHPIcvyhG9Ry85cTm24PWoMxZf+l3wPw9yIIdeekeEF/EIhePmDu/QmFUjirXX2001RBOtkCl0UuOEQ81cB9hBky6R4sNg8qKaSd53v08ZUS/nx9zvcs170JQkiH/tA2A9y+0AoF0KwhDo4w3G6wdgiVVA8PCNHlJqJaQ1rLbdt7p6ZY+kw=;25:nEx/YHxB0cxZidCEHJBEPiJigJUdLWyNTn5tiLV/ypzOQW7Nngb5RtMWqD9FJ7TX7iKI5OdK7JRs2tYIW++4J+pwOQQzyLNuvahj0qSXSFOCsyFHjtGdYx475O9BWaBWfNPFSwNhtO9BleV/LSe0KpQExIlpelOPwPPv0NUPB6jKwNAuMqe7aegd9dG7ysxEKqlZvnYe1r70m3wSiRpakR6McINNx3O51r37BfpL3QuFSQRBBWGKXcihT6zxvfJMYf1cMWN0ykj0CgTSBP267FV/Xy6hpRvTJsZQxz4w/Q6IolYKfCNZJkUsOEgaoofpQ72DV2u4+kwHLjlXPWJ8N447qm6Sk7HYVtzu0E1/yOg=
X-MS-TrafficTypeDiagnostic: BLUPR02MB084:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB084;31:ecQgrwQADJrETHe82a8a9ACjo6AY0gD417nqEtczDqyz25RwiifIAehPybS0gBtWrHiOhTUGqAcwWGUtiwHockL/WYL0whrtHFi1mbMF/lB0ym/KujR07AHzHFVvNWcPrTDbJfgQIkpD0t7Kv99ErQLcRNnBG39qPgIUMfIShnpIgdWPwDl3tew6X6Ag1VK27X/j/qjGrworoue3IdYAU/RUV9xGeFk65lEJ1/JQ5sE=;20:9lBqH05igEjdOdKFlDaISWhWfJXhVFTEWeCC+4iGcWcrKLnZx13tOakUpZCx/i0Icfi8vHXMwo7qf9dc3tEpUsnMIfNGW06zDdnoDTByBVihUMtWBDeIGEnaB6TwLQxqcfJ/KV7OA6wzA+qGmwPhj1OtMIetYGuTUJx2wf+gx+/jITTqui1xg3Pq04Rw27Tr/zzwcpQKv0nabwgCFvwiH8rtkavYO1L8qjjvEEQbHJDZIWNM0r5KY1Cj90yeRkrwKzmznQGSmh9k+YFGsjgj3ykGU8Z2Eup26Tr8Aje13/4qhicjvfCn6p7Z0bkA3RvPsJV8hRpoSPKHzfY2K5GjN7ntqNLbLqpGvSa1a4ovUaE6Yzg0ue2/OpEMhdv9dWJLyCzDnYEhpjRb9TKnI+CUxuJ8J4QVa/UdwiLA4NlER5Cko+RL6qyd3pJpClmhcSueKWKvRx42evqNFckd4tfZ21ZKiZ3ddio/E8C2osb1jku2d2npB54sXhwe/UJBljAb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB084A1F9DFB165BC143FBBB3A7540@BLUPR02MB084.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB084;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB084;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB084;4:rkCb5wB9TIKKT/ZKCYzFa5jNMly02y38356MzFyLMmepP70H4HbRjnumRWFVLzyrm1ayu3fnLCo9siK8ajXM0U3wKq5nqeOqaN9rHnaz4Q3bfARAD/kfaBC1Od/XXTH/VZzrGixolGOZleRa2pLn+B/Vvw1+B1+lRrbPMEJQJQty6EMaeTDyfHc5I5LE+cBEd10WBKZJQsIYpQhhqt3MVyToU9lT1WnReEqNnjj+wV0E+bbO9Ybuhe3HrrOTJaz/Kq0ImEHJ6LMDGNfL+4WXr0o+6I/GgzC84M0uz9o7Z0lJpg7cWSuhTPlyVeRxosMA
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB084;23:zdbVxYOlz1iPrapmJxuTLdXXr4V7FQQm6TtDnll/h5?=
 =?us-ascii?Q?QrNUJXfZEmEf1dx9shRNUnU69SndNX0gn0/lso12S+BL0fO239FvGQYf4MKf?=
 =?us-ascii?Q?Wxz2jNjidzneQqmEhpkFSWrQ9fwSttzXh7CrFjdxqAgka2tm2zm3gXvyDRit?=
 =?us-ascii?Q?Cr2ByRy5lBpPeTw0e7LTexLhEHXSsqIdBu6mttmaQryB8n2Ybyt9pS1u+Qpj?=
 =?us-ascii?Q?2ExRLFiVWO/hANi7wAeC9xvVcu/DLtSRK2SVsBA2HIvg0P7LvrmWqU2kMAN8?=
 =?us-ascii?Q?Q3lEqKblF3n/UeduwEz48ins54CD9BMIBHnyyduqWjtRvPFzQ4Y9ZUUCNVkf?=
 =?us-ascii?Q?qPGe81t0TRpjWvRUnbFwPD+4W3fhI5FK7dQcinotXabFBZPgCLil4khnpiDZ?=
 =?us-ascii?Q?LHhNqgZdSaYrcKD2U9oBhIIESQjtp6HdUM09/WJYq5PkbVrApgDbQ+EQTca/?=
 =?us-ascii?Q?mNva3SXIz79M2MRWkB6Hvn5FdMWMjY6yh2n/iCIX/jm2xvnlnf66lzJjIiAi?=
 =?us-ascii?Q?fPb7HYEiYA6GOlinIULp0ilosk3Z44fhjBPv4G+JlZcEa2OMd7x/NND0Gz++?=
 =?us-ascii?Q?lHHfoWDNaJu94Xy//RgTTucQ9YVsbJvnGZumaZfW3aWOd8cVT/qNqg3XCBvJ?=
 =?us-ascii?Q?OAqyoGsb9tQr4QmTEWkFdnOsAO7b3dy6EBTphJuB7hQyH6uauJwiE8u7eSbG?=
 =?us-ascii?Q?hHFv/gKWFJoat8/90R5yUkTbGLkJK6iG3x1i9kzyTb/sey8yH2U94VmfZgDn?=
 =?us-ascii?Q?NLMr6B8a0g1Y4kwcbtRn5C+XQOgsPL8/vI+5mjQnCLuM8g3vNrZGn02Rkxgt?=
 =?us-ascii?Q?6EhpJOiLDYKVzzY7v/z1q4IA/ImPW0rlqjIJJDjkP8KT+a8EP9mY54Q0mYi4?=
 =?us-ascii?Q?iO759Cn0V27n2qzPwT29PCU0EwF3wAhvrvMrZEOfr7BgJi6ADu9FMxmeIEu0?=
 =?us-ascii?Q?OgRxk4KjsyQ7G6GsxzUWgP+u0rGZgJtxl3/2F5eTP068u6K4DwT6Aky8lzKJ?=
 =?us-ascii?Q?HS0RKiJxoqP/I+6xxtx6vt4vaFgAR+XaXtNrNwKNaZW0OHcYoMxL5ZMoLnAO?=
 =?us-ascii?Q?qTJR6uUstksrEufKc+06HM3lw7iw456dnhAdqzs3/ea5SFKssuRL44ROBSP7?=
 =?us-ascii?Q?V83D6O6cNz8l1moS37FT5VYGu05+F+feqRNmkyOy6ucSsX+9PPbOhdK/CCPM?=
 =?us-ascii?Q?2jLUHof7N1YGql38uCyCMLdI9ONb+jPn9wrmPKYRmgQ1L2dSXfKehAbQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: PK3W81tpMYgvDapJVnSW+8qMcPa1YMzdJ+/di4g6W33EH1GKiR53ikB4VhqOhkoHM/K9QAZXM1yGNVjnHjiX0LDwaoRngnedBvnxE5GkYB/xImN3wP6LFFjlu0QegchtOv6OsGVxlpLsN/mQHpaA8ifxzKdnrnF16kL0nu2HLQH4lijBgDiz4MhQude8Tb7ok3S+b8iu6RVb5R2OA2H+wA4WgxRj3r7kldxpgZYSQ1YNiLm0EBPYQqxkuvSOAndxX4B66hHASQ8+nXiefw1ZgCdlYyRS5LzW5XS0s9h18FyIhXC0vtMi/NuXb2hTqGV5K1ISnC2IEREmTH3CagHsD9t/vKKrkVnRi4kxNaAUmZM=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB084;6:PZVpB2fVcP4eXaoO8/WKEwsXW9nFhgF0LBGX1TnsiTOmWpqvnshI4HhaG61c8dM7I4h2Y3G5KY1lEV+S6WR0JMLZTa7YRa9dR+HDRVQ4tMSEisxZx4YFqmCa1ZZinlNzuC8CVoU+x5FJqSM7kZZF8RiaNM2vL+LfiUlpVebgBo3TA922OZwzKvMBmj6Z7ml25kjAsDii3VCg7OvpjZ63U7zfIt/jgwbhfSXWenQkxZn3DnVeGSTVomsKz7Z2NR42PyHW/Xwon/Auk26RyizL0Os8RVGNow0S9KAxtZJWexac1ybOwsHeJDciUfsz2ShBYji6RkKMThGGag47r0A7r6RhT80CLlqsBEp1MxLjHhl1fnKNOifebswa6Bf8Ou0x9XTW1tn4uNGiz4jipUukim4OwlFRdrQVcT6HOX5KxsfMyyEl3j5fs/jlBjzUjNgQ5GgJQ5TLsWQUzBITQJgogA==;5:0whPQpkVpzTIsEr+NwM7b0W70IkgDqfJlctlZIgZTyia+gpBDUkSEFrV/QljDTUFkW5jYgHn7DH5WJAlIyjOoQy6s2KMKSYN4fAna/xFvwxBsUQKDttLwjwnwlrV9/sQ5JDKTwCw/XTkTg4AKlLks0gh4gHCHuoQg9emxYUsAIg=;7:EgshtwdYwc15AgogncWxjOZ9ROiTdFQuVG+JhYZqUE4mSu8MPx8yhdUTTRnJXYlkiWU62J8ixeu+NUuT9VeJUZblnH7fZC8DCOMUfSbbQ8uuixbqUAxMT/2G5fKKHkAQgBwF9Jh/DaHiIwObuD2oNcm1bWHGmtM1C8UOmejtZPXEFi37pJ5Iz3mTOecsp45bskRpbFlsJaVoPwsz0Kgvh4dKJc1UC1GGjwEzYn5sen4Wzahjc7U+un2hbwm4rZ/N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:55.8629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6a0586-ec67-46b1-bd38-08d5f2250572
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, uas layer can queue mulpile requests on
single ep with different stream ids. So, there can be multiple pending
requests waiting to be transferred. This patch changes the code to check
for any pending requests waiting to be transferred on ep started_list and
calls __dwc3_gadget_kick_transfer() if any.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index af8d470..fe1ea245 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2424,6 +2424,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
+	if (dep->stream_capable && !list_empty(&dep->started_list))
+		__dwc3_gadget_kick_transfer(dep);
+
 	if (stop) {
 		dwc3_stop_active_transfer(dep, true);
 		dep->flags = DWC3_EP_ENABLED;
-- 
2.1.1

