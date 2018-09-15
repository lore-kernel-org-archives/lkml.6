Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEEEECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5C5208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="schKRKjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5C5208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIOTwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:52:49 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:36592
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727246AbeIOTws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi5xO1F9LyxDO99qXRmHSc08cWzrHY6uMEgll07uXrg=;
 b=schKRKjlD0QRc0yUy+SJvqDiJ73wGFAUVsH6I4O/nuVMM15LnOsx12tfWzwsCFsdK5e6EYHpoMbPCxcq1qpYqBz0MBTvvwhDLIhB9GEA9gX4JNel/gkE3RAzsPANqoIeLyMQGazwFe1uC25MaWQLOJtiks4/rAkm9W4FV61Q7yE=
Received: from SN4PR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:803:2e::17) by BYAPR02MB5111.namprd02.prod.outlook.com
 (2603:10b6:a03:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Sat, 15 Sep
 2018 14:30:31 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0031.outlook.office365.com
 (2603:10b6:803:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Sat, 15 Sep 2018 14:30:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34653 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bag-0008C6-3S; Sat, 15 Sep 2018 07:30:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bab-0004qu-0T; Sat, 15 Sep 2018 07:30:25 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUMm9031549;
        Sat, 15 Sep 2018 07:30:23 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaY-0004q6-DZ; Sat, 15 Sep 2018 07:30:22 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 960E0604B6; Sat, 15 Sep 2018 20:00:21 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 4/8] usb: dwc3: implement stream transfer timeout
Date:   Sat, 15 Sep 2018 19:59:57 +0530
Message-ID: <1537021801-23896-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39850400004)(2980300002)(438002)(189003)(199004)(39060400002)(26005)(50226002)(2906002)(336012)(426003)(356003)(5660300001)(8936002)(36386004)(81156014)(90966002)(2616005)(446003)(126002)(186003)(11346002)(52956003)(486006)(476003)(478600001)(103686004)(8676002)(6266002)(106466001)(81166006)(14444005)(6666003)(107886003)(42186006)(63266004)(316002)(47776003)(50466002)(48376002)(36756003)(54906003)(51416003)(110136005)(106002)(16586007)(305945005)(76176011)(4326008)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5111;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT052;1:FbCK56Ar6I0pAlmHJK2Jctm+corsaBkgCDcvL/h7ux5t96Edx+K5NsAzg6+rDhukIXU8pio5ImAIkqrmcR43/YHR/x1bStRxQD/DrBEKlwq9vNW+DZqORnDXzMOZvQjY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789737aa-3b73-454d-f8d2-08d61b17ca21
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5111;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;3:8M+4qDKgdH0e6zqJFHRjZyXX8oJXcsK7HC5GgVHWxSAkQa7pUDjK60zbLx2GB0GlhzNh3x04L+F7p9O7M4lE9JU6vCzIyHZw45dJnN6tOPIUV2bw6Q7ZgZ76pg7L5EVKh3FADVsa+Li5QnWodvAwlWU1aiLQuol9+ns61w9YwWALFi+pDpNLezOKn4NNu44oyxKi0mJnnbwnZu5jV4xlF/rWcY8i8J4Qyb0eiHf/4HxDLqZTiJNjOoz63+xj1cwQWTsfQXwGmbMrqh1/rRR8QUg99sHGm8X11ciYwMFZwuSkrccuMGmEP7rah8ACjinj4LWu1epVgTyrWPSfT7eQZUbjz4GBejqzW6u3JPY3peU=;25:dAq3yg75qXvU2iFNfT6X3LZEAHLBTSDPL2YYCJq/8AXeDFvhyPLehE9KdhTEmWg0E0vqdMH5d21FED4Z4GLwa82OdVc/9l5Q7EJWWglDHyO3eN8Gk907ozc+bFq2aKO0lqF6V6R7lUWewRJIhYNjuVCA54h/BB4Xrb3KIXNM2FxOCYseF9ReBqUR5Of1/Ri+rgCW38ezi6Ty52dHXdnowJUPGa/+bn45Qwi7QioRhICVrw3GKxmzvNYhppByTqOrxDkEe4inXflMLyz+6AXCX/RXHEQ3nn4W3QczZisgi/wgfZHFaTqVeNTyJBxEdqNtYB/np1ZmasfJS/wTY0KfHg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5111:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;31:jXcA80JmRO0hu8iku2RKLSw5EpCJAEKarSq7CxrZRlnimUHtl1MaNDhJNQ/LTbJeq6sMqNDQgGdJL8hgbahOWL2rPrdHki7EodoO6ppTUPymtHw4JOVobMwOF6Uhqcn1CFWND9UAbVy6uWdeDjhzyakjh1EBA6AgAuKENUFyP9qR4OFp+UU1huHF7HwBE9uCEqsGE/8dmRNTMozeUGx2BJERUsLXErdy/YAH9wzoRwc=;20:q11R5GsTe09nPUKN0/s0hTJLqOEvTuwqUQ0uGJcBqgvi8fNQ0aFBuuqH+QTnG1/7QMEIf6/No4XD1IC/vHULRDz+zI4vU0HX7PEMxpsU3c9daCB+oUAZboCkqdiKXG8tWgdiY3GY4EV27NfSujPEWOVbjegP/z6wQdpeUNPcxxEcnlWr14LWW3VIxG7OYSoHI5aMXf6nuhXLboM49YDjsDTJj0oZ/JgMiTQfiALdVMVui1GBLVCtz0UdWl0IJjzqq6ioezSUOqGX5SutU/vuvKcBgidhL2FUE2LzmI+/sl6E9e2LV9uSY+7191hR6MqpHOA0KjU9/MKReQEcDuS0JGe6bGS/FUhJxm3mlkN4vswM6ZSRR7VOTgqmGLGlXo/PAiK75mILOneY1N5XxuOBEymqKOHgutry5i8KcW7GpcjKM4K2dv1LvJDwYyDSc16iUCe5VqRyYZ62Ry+6o2Ti0L9zURtDuUlNFGP/eB9d2Zhd5S7AyGKLs0FV5SgLJWLG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB51114F79A0AFBF025D9F2648A7180@BYAPR02MB5111.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:BYAPR02MB5111;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5111;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;4:yapxDGmwB8VaA+H4FAHyXHQv4GyHHYyxmGmTVKMkUYBKih04j6NtYUT+mv7DYjUxVYx1k+GQKiD5VIRCpm/81UDl/XLksycDF7zlEHWGEYQoCYJqnTH2jBujW08TfQOhJIAvejv2rZPlWBNU46/Yby4h95NQYCM9WCeqmkOLvLt5YeF8ToWeM9It2tKeb0rrF2r8Wsu2yGi6I75HZ0v5o2E+jBGW8Go/bzey1/KVjFMHUzSOoiFioWvbR2YYZByFnHnnMfEZ9nocv/1Q0O9830rqyAu7tOwDBawNFOeE3e0CdCuetX9SyVxDYSuuEUy3
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5111;23:A0XdfoGAisjJn2Zpq727IhvhNltJIdFQ12qGgHn1d?=
 =?us-ascii?Q?AB3c4BlpmoE34qbT77lhBs6cuGntWaw37/qAM1VCgJ7VUP4kh8CO/8dzMpu+?=
 =?us-ascii?Q?iGS9LEeVRsGBfjyu8n3e1no9ExA6Q6+9ElIOnEmHt058QPhPHI+mmGtsyFjx?=
 =?us-ascii?Q?y9q5Vt5QVdy3Gu3WdqIITSQk4CsvsM17WV5XKf/JWwz2U66Ip34AB3v1dxj0?=
 =?us-ascii?Q?1HG2BKvKJi/m3GECaNkAuf6SXGII8Xs3xn/bV3i2oFa7KVR25sfyk0qjgqU5?=
 =?us-ascii?Q?wrgWwFjP7/IBTiAiEmifQVaLkn6tt3/10gMcTKImXzgvqqg1J5o2vhbxqhrH?=
 =?us-ascii?Q?gBks4h5riDfl53Jkh5UTU3wgG9m9FCnL0QptRjXlxNdBEhgO0ncbssBvC8cL?=
 =?us-ascii?Q?R3lectr7JuV8Kb4cOumXXRsNA7SWcjS6S8tfhqhfEuzP5/0juivJrhild4ci?=
 =?us-ascii?Q?oj+j2ibsbEeGDE3ol8zPS10NN9zg46/t4DtU2YDiD/KXsoSGdWDH6ZfAZqKK?=
 =?us-ascii?Q?G6h0LvQWw/57zxZAwY4SF6E1Ykv8Wo8SZeZERVniSDKtAgdnbAvaOyoakN3P?=
 =?us-ascii?Q?jKwQP6VFapXn5bXUnYV/NFdJZbWtSMcX25M+Rz50xspO9PGhLSRkJUJDzrUC?=
 =?us-ascii?Q?03gLDXwLPD+iWxC+0/CzZ0xk/+mWXAgQiZX3r8iFDmtBuvVpN1ajwFYNzFel?=
 =?us-ascii?Q?oii9PWumziB3CjcEKBMs09Ijy8MMaYbx2O9WY0EtAZXcE2sAGPQgMNl5y4BF?=
 =?us-ascii?Q?3AllE1airdhA/gA7SpQBrSUp1MAtu/6BPDY3qSxJVDr69NGRtcEamv9vTzol?=
 =?us-ascii?Q?ZF5IpuSaoRJ1C05vs6zBPen3DhTrzXpqgBUVmUlZtmTlCbWm7Srp/VwElo8z?=
 =?us-ascii?Q?QYefeeTTJ7BkJvBgFNrpo+4f6u9aW0Ust7CAv9BXbKQ0UKp6TXEDR2D08lmm?=
 =?us-ascii?Q?Y8AQDszZosuc1fbkJSnWxWmKGY3bJTr+tDkx2uHM0RefZ940HeGWf5TMmX9k?=
 =?us-ascii?Q?CIZMGNmy/NSOzgnfx00g4jGp67D0aPFuVh3L058k3QS7JZCEvNbXQkbZHm8n?=
 =?us-ascii?Q?jpuZBLPoRoMCGWBIdzwk46xTSVZYMR0ITIdSgzOHD8qaHtZwhJXgA6vRTQfr?=
 =?us-ascii?Q?qnsXU4w4ZDLPA+ALwZPAhrNuSTAEU8aoR6t+VW8cO1EgqeLe//7CN2sY+nZC?=
 =?us-ascii?Q?F86x8YC8RexMIpp5j15NIxPwshayOUHFx/UKz/vFSKv40bqBx9mFdrLMQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: civYUY7v2uDKnXp50bADO/KGH2aLZ0+Gp+ANbRc0VPHbzNOCDeSpa84TnTHuXhUl8YIPbqqt1FzqwiQnAQ9V8Uhoo7jUpoeVrQSC2yRRqu846lD6M2TL7wMZTOnheUM9rERiJDP9i9x1Gw7wOezh6N0cCa/5/FH+r0awnbDqeiBiVIjOGfss9JpdsgjW7cFHk1eI9pGxzaSoG5lxoRrd/gmReiirQIJazmItmCRS/6ur69sSncn/CVSz3XwLmtkOTwOOt90SO//9r1vbCOWPvDa1C3veAkSYf7no9G881AH96xYGdxKibaZp+gCDnVg7DAYZkAvVg9T1XiWsCdKUcq/wkeetHiILgP2dqUpw4Eg=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;6:tJj4VZ2pFXNbD4JtLcfFH93nyZNWTWe+21LZfSXZw4lKrgHx6cX1RgfcrrvMC7+CsqwRiWsckS0unK3iwgoje1tSNlda36519SwrXh+rultVD7TJHC1pxehEHp2MDiDiKxFlro3qDjwuA5r0de3JaHvBvOCFdnr3jeWG+GP6+SI5Ae7TsHRqOTrxMyZNZxd4ZdlrdKqZSaXsj1yhlqeJPUff1jcVHBYPIINRUDDkRuOZHYQ62CwQTFeWce6tLoKDcre3CXi6gQNZ8DjZ3UnRBwrSxBb+dR0+pjOZeYPVPBf4hmeEbDiM8LVKnVSME36v1jKEWGgpcvMCDdfX/UNpWYiPOYj+D5OF5eORHndnZNqwREyukN1t0nhVW5i+S9V8gLdYV1nhhezTY+ajNg+li5DzyWnJlmn3/RVADAvyfZW22mDB8CNqkWfkHNKKW1tPQGxVo5h9KQL+cc9BgklDjg==;5:4qShFLEIhy9vEGd3HycQks5VtoBEF7rDjovisqaMxOznm9gzAtUSyhvmAJm42oEnGUDmF8sLAN7rRwE8wNYKGA9SSHS7D3nNf52nVoBaBHApKQuOdWoSPYG8gHaN13FgWPAkjpf+pDbJNcH5XvtehoGZtnTQ90q5NbBQsg3jrJI=;7:7cDTyONqJgQIxpK9MO0NL49MfeY1lp6XVbH26+9F6EiwmtldDSWe2w7IuLgOomhJfpFAXI6TAECHIpC5u69dldjw/nVrjkRo/s23aeit0BlYs0sjdVlRi6vhnnZNZ7VrW3y6W/nGZ4LxTyw/KlCDKtEIJixWf4C/lA/mgmiwd13i+rOk+c99FZ22dUXvM9L+hf8xSl9CKO+IP6BXw/p9Vvddj7Wp7SHwAy7vLkfAjcvrDVjTEeZxwYbPl6A0y2se
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:30.5644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789737aa-3b73-454d-f8d2-08d61b17ca21
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to dwc3 databook when streams are used, it may be possible
for the host and device become out of sync, where device may wait for
host to issue prime transcation and host may wait for device to issue
erdy. To avoid such deadlock, timeout needs to be implemented. After
timeout occurs, device will first stop transfer and restart the transfer
again. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v5:
	1. Removed dev_dbg prints as suggested by "Thinh Nguyen"

 Chnages in v4:
	1. Added description for stream timeout timer as suggested by
	   "Thinh Nguyen"

 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed STREAM_TIMEOUT to STREAM_TIMEOUT_MS as suggested by
	   "Andy Shevchenko"
---
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb625..f62e8c4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -633,6 +633,11 @@ struct dwc3_event_buffer {
 
 #define DWC3_TRB_NUM		256
 
+/*
+ * Timeout value in msecs used by stream_timeout_timer when streams are enabled
+ */
+#define STREAM_TIMEOUT_MS	50
+
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
@@ -656,6 +661,7 @@ struct dwc3_event_buffer {
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
+ * @stream_timeout_timer: timeout timer used by bulk streams
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
@@ -705,6 +711,7 @@ struct dwc3_ep {
 
 	unsigned		direction:1;
 	unsigned		stream_capable:1;
+	struct timer_list	stream_timeout_timer;
 };
 
 enum dwc3_phy {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 13ea282..e18f9b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -254,6 +254,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 }
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+static void stream_timeout_function(struct timer_list *arg);
 
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
@@ -574,6 +575,17 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 			| DWC3_DEPCFG_STREAM_EVENT_EN
 			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
+
+		/*
+		 * When BULK streams are enabled it may be possible for the host
+		 * and device become out of sync, where device may wait for host
+		 * to issue prime transcation and host may wait for device to
+		 * issue ERDY. To avoid such deadlock, timeout needs to be
+		 * implemented. After timeout occurs, device will first stop
+		 * transfer and restart the transfer again.
+		 */
+		timer_setup(&dep->stream_timeout_timer,
+			    stream_timeout_function, 0);
 	}
 
 	if (!usb_endpoint_xfer_control(desc))
@@ -730,6 +742,9 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	trace_dwc3_gadget_ep_disable(dep);
 
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -1257,6 +1272,12 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		return ret;
 	}
 
+	if (starting && dep->stream_capable) {
+		dep->stream_timeout_timer.expires = jiffies +
+					msecs_to_jiffies(STREAM_TIMEOUT_MS);
+		add_timer(&dep->stream_timeout_timer);
+	}
+
 	return 0;
 }
 
@@ -2403,6 +2424,13 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 			stop = true;
 	}
 
+	/*
+	 * Delete the timer that was started in __dwc3_gadget_kick_transfer()
+	 * for stream capable endpoints.
+	 */
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (stop) {
@@ -2487,6 +2515,9 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
+		if (event->status == DEPEVT_STREAMEVT_FOUND)
+			del_timer(&dep->stream_timeout_timer);
+		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
@@ -2588,6 +2619,18 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
 	}
 }
 
+static void stream_timeout_function(struct timer_list *arg)
+{
+	struct dwc3_ep *dep = from_timer(dep, arg, stream_timeout_timer);
+	struct dwc3		*dwc = dep->dwc;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_stop_active_transfer(dep, true);
+	__dwc3_gadget_kick_transfer(dep);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 {
 	u32 epnum;
-- 
2.1.1

