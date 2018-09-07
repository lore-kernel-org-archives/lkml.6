Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8939CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1149920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="z2VF0qrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1149920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeIGRzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:21 -0400
Received: from mail-eopbgr730068.outbound.protection.outlook.com ([40.107.73.68]:10891
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbeIGRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBtCD7fkGJJfNNQWAD6IhYGopGxy91bnTlFOSq32qUo=;
 b=z2VF0qrx4LTGUfLKXDoK0LlhqH+a7prbLtUb/lftXAkQYYonIdrIOisT9Vh9Q2+SfEjMVijb5TT9OjMdSMK8Loj47GFsThVE6m0qNZjJfXQfonJTVJq0ugdlLnu+VRP5191cNbdEeM+r1JRApC+g7CfppAJa1NlYrUlX5jYzU38=
Received: from BN6PR02CA0079.namprd02.prod.outlook.com (2603:10b6:405:60::20)
 by DM5PR02MB2682.namprd02.prod.outlook.com (2603:10b6:3:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Fri, 7 Sep
 2018 13:14:22 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR02CA0079.outlook.office365.com
 (2603:10b6:405:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:22 +0000
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46069 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaa-0000Wi-4W; Fri, 07 Sep 2018 06:14:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaV-0005mb-0E; Fri, 07 Sep 2018 06:14:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE7Ne019603;
        Fri, 7 Sep 2018 06:14:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaN-0005lN-KF; Fri, 07 Sep 2018 06:14:07 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 417F360493; Fri,  7 Sep 2018 18:44:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 7/8] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Fri, 7 Sep 2018 18:43:48 +0530
Message-ID: <1536326029-16327-8-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(110136005)(39060400002)(42186006)(54906003)(107886003)(6266002)(103686004)(8676002)(186003)(426003)(6666003)(486006)(305945005)(316002)(76176011)(51416003)(16586007)(47776003)(356003)(478600001)(14444005)(50226002)(4326008)(8936002)(90966002)(52956003)(63266004)(36756003)(11346002)(36386004)(126002)(106466001)(336012)(446003)(81156014)(2616005)(81166006)(26005)(6346003)(5660300001)(48376002)(2906002)(50466002)(476003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2682;H:xsj-pvapsmtpgw02;FPR:;SPF:TempError;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:VWbVB6MbUR8E71oj/kYP5bCred5ZjR/54tcMw+56Y0+eRZpQ+3XNPTc2DVC3gO+U/ED+A6TSJHL2IL+UiozVDA+eqmF84jdf04SyggzyT90OsZNSLCIoMonDsjbigCP0
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d6a228-c952-4b09-3c34-08d614c3d2d8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;3:1J24N+CZVAhvGPUM5WKZAl5xERkPFglWnplkwrkIibXaPrQkxu93V3ohYpidcK409/D+OdHyXOeGUV0MFkuUZ+PCAQZhbYz9zQZmpwDhRg2gSCKEQl8seBj8zqCf8h9IqbZSuuF2g0nRGz2r6Enb8KBZadJr9tr3s8GROaqSQzNCgOlapY4IbZV+lJPF/rCGVzh4qHI1sLpevOwWFboZVZD1r5WyAJsVyWQWVGds98HPw82YibyzghvpmXpiBblckMxWCDYG5b8PiLmNJ8qXc5qeLneRXS9nhSnFc+bSYWoD93x1xTTehq6XEkHGok9kUyLZIRzaUMK0NdBPk3Yn8pBDf41lL8Ub3e1HbSwv6OI=;25:2QYm6Nz6I9/Q1D3R95N/ePcv2UQ3jf8AcwjwfTLUXQJCyBhVG+He4nDHh78YPJdgnsZyzmFFCuRKoETfDdACwsVQn7ToxfXKXv48Aq+Q2F5Y1fnjZAIQYRudmou32r2mKDtIDBcEwqCA5TX8U4yx2vqesfTSz47uPKNICNWf1QHrdb0Xwr/rETU1naZ+lJMOluPHSVwQjoZduDzsIMdZDC0mazsNSbxC/5lSQx6satGGJSTz6fdyrNF27XKNdLQ01zYDkX7s7yNxTmyTy8yAn6qSZE+P3hmVzKlU2Ul02T7xKAoCHm5qEH7B3m9YpuamklYJayKr6W+TagKnwQlPdA==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;31:lys27gHiuPy5D4CQ0LgaueLBFhpT7w4s1pJKez+JY6SbqGck36UEIYAkL9n+Fy0qhzLf8DTs7a5e+r1zskTBlYh7ZB5WcrkmmDqyguLy9ZNcJEFQFr5/gfn66H66n1jtsRlhq2k7MI529iQZ5Klm35rx+/O3S65mrz6a5utiDTSXOQxTeuhMogBhdNYEui2lT72izLX7EJxYMYRnY70yPR2ppyCwTm+UNQED9voqgDs=;20:dYLxpdUb0pEueWyArxzlTF7fmmjfGsuEXCmT2eafDjFsrRU+En4BClqVzkctwXymAoYY4ajO4IcMOwJgOiBcjXtsIytV4ucRVzCjlfBIYZ8LuxPSFm3vJ6Jq85/t0FNIJ1qIO/CH6Gt8SGBWqAkiplvEa0BcSEpkq20T0RsmuZY3gCJiJeTtwoFfTlCmjprAX9UNUUu0hEnUaUyDXKDcpQ8y8TlgrHr9SSKMZydyO4Nsp9lGQ9Ln+y0UmDiAtEmvj7/OOlamew01xDcJTtrhplSbY/3f+HgY7ZbhY8vlY3/HcAKc2qDbzWZmcDDIcq9FLGDYYLsQ7IeHxEkqks3yZiuTnlpTNCnkth9V4WkXYBUi2gZkSICibqQBmbhuW5luttkFVmnlnUswGwdruZDFaOXO6eXBjZSa/oY0SkBzNS/hDJ7Ta21buhgNpUM1JfPfSH8inNVYvJAofwNyqjuEG+BPA84AqRMdvZRcAlDZZHbxjoC8PF+rABsvU3ZzDyMs
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB268227CEC6F09FF7D14A2EF0A7000@DM5PR02MB2682.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231344)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050);SRVR:DM5PR02MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;4:Xk+yZxWYMotQxQA/VX+m80XdU3AloW0Mmu8Dtsc8P71ZWk5daA2sLBV/PWToUHCOx0E89cTLeNEoxdmub8pyihCq67Ys4esi2HMSQCtjE3af+LDFtdB3CxwqHMhDl3Ppz6b38n0Z/j+qHTEOUc93/yAYRT1kmxCTGUC7YyhAhR1ctGK6qzoz51eBqSlN4tfT0CO7BcRD2dqwLzh92B7URNFN0Wy6TKlXEItawU2CYrnFKnfpYGOlcP+nIumJ038ccgRSvcAxQmppE1w+354VV/OIH4KfRnonXNDug0d0ERh3kzcaTzt0ytNnXfZUaBJG
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2682;23:GfOo3Dc27faj+UfsaSV9lwoZwhfhE+BOwrbAoF4lz?=
 =?us-ascii?Q?o49HY6LJK14IePUNYNFS/evhFJtxbCSWz7foLsC8O0M4jQYKFiu72mZG5ENb?=
 =?us-ascii?Q?akkON9nE2qOxoO9q+b7JuTDnvxklWfWn0kgVoGJ5TKRuUjCOJtAEmkcznJJ4?=
 =?us-ascii?Q?yKGQIlTSNZGboFq4i+3kuwc2iH6jL7Fpy9Tajh/Zb+XTsBXexZ2Q1vKxxAIN?=
 =?us-ascii?Q?fM8m6Y41yCu7Tk493+fJqwfK5h8e2NAGj7xWIkun31raiC2KlPlbIZQD6Ahy?=
 =?us-ascii?Q?INLe9+5W9CGFlUcBrg+wuOIsyn+NHslFLISRIJ+3ZKHI02oNFCek1ff+3bLU?=
 =?us-ascii?Q?8oetlr7m4viP2NVq7sV4nLf75ojkufz65/nZmF/MYsYc+uX9y/4+T4V1ioyp?=
 =?us-ascii?Q?ieQ7Ui8XLdrS/4dAUjaznw3Rj3bTnZzblliU80L22zXRMA+rzy2h22+873z0?=
 =?us-ascii?Q?RssE9JbMZaBgfFAphC9mvYdrhOz8qZGx62U2QzXuEGrN5xfQNXYbFVD8VOBj?=
 =?us-ascii?Q?YUlh8h0ct8mnlykkTto4Q07Uu2RH94RrKysVkOV9EILVock87OEPRsuUbT5w?=
 =?us-ascii?Q?SjsJqh7dqm+S21R39k5N4I5YSMYz37P3dTk0+DdyLCiyS7b+ebt26zI4sDIr?=
 =?us-ascii?Q?RozlbcRoTUdFbrcCi0chsuNCO78SvKLeJL3DBGInJ9BQn882GXjSs/D6aRf4?=
 =?us-ascii?Q?DA7f7poRav6YUCwLXKWBSYk/1/OVe8CSPtJfQGCHPP9wQpycXqcQzRhGDW2D?=
 =?us-ascii?Q?VtDKZozGyI+daqp5eR6JG9EvGom5YO26WFTZDzuVTs87/BWCFq6eUg03b4XP?=
 =?us-ascii?Q?DUR/2fNvjBDwV7MJAsZkO7s/PGNQUcFlja3UIrZob8z8uyAOu9OtgKLDWOTq?=
 =?us-ascii?Q?zhQ/6V6PNpYf9E822Uz69p0zTNb1VXO4sCPo35y2QiQCx9sf0K+PLAbCAhST?=
 =?us-ascii?Q?6lqMXZJjKxU/H8zkjbfiaQkIy9l1rV0p99rlvhGUNQREXv5y0PNMGY601oKr?=
 =?us-ascii?Q?HQ/htYz0DFjFCFdx0VFW7HgB4EFvkOlyLh2xmqfEBlB3bKYTTgTzsTAwrs7O?=
 =?us-ascii?Q?6w+Gx9RtKhIcGh1nODlGoRyDvptoyAXvqq2tuHdJbS8Cs97NM53wRpj0h7kn?=
 =?us-ascii?Q?EUewQc7DY9GBylktMMB4+OhFkk8B2H21XIJpjO41K33N+G+d03rHXJZWwzYz?=
 =?us-ascii?Q?yZoM/3KcuqXes11333P8s5FL3rwQ+4EDNmV?=
X-Microsoft-Antispam-Message-Info: 5vBQWxKeUi+slKj/Dj6iRk2bYzEroicsKKlqoOuQrDxWFGdoWjRQpU539F+8tLGy50RLgrLm9LHtRYIsHLmQZR9/Jh1U4ocmBiGzOVgwFJM3IhCDO4E87KaZfu5odQrUUM+822efBlj8wen0+o5wN5BnB+jrwAfRa2/s14p6fMCxEwz0dr4s1CeSkda4Rlb5hIhj+k01zmxFO6NE8VxAGxHr5NlLbV9Zwlncc5tNVffMYvswgaq5Sa/kvj9I6zMrk7AGXYi4wB3AIO0bRYYZpRmumTKt3TPIWv/1FZT0oyz0P7VeA3qilJ+g8qlDIkeBm2XwC5h7i7+xfA68M+9Kqo73qzsuu1n47HWkRD5bmQY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;6:NKK4FY1DnyH1CNyAdepaFfFuajLRUbu6BseiCPdcxcgJAUr1tTs0yvWrk4tH+39GRoqo5Fbyy14jEmpTUYyhbJUZoqJFBzv2/vme+r9Y81NHYgIrSooqTmeifvUl1LcHZ9B35fkk0oaX5I1KDLEamrcyAARpwcRXIsRE55C3oDOrDnProcnrZPNH23+ZOiLrXi779GELJdXe9OdAVs59eUCUL4MFyV33fz30nSBpX1PDM0CKJv40AO4AjkFooDlWb8QevE8ZXbzD0FyhUgv82fCa58hTOph94Y+v6AiLTX+aiALLNRG/ZAvfpV0D0Md60Yx82FtyPMmDaY8EZKdaHlZHs+gI92OYPWKloGtATn/IzyJQVU4LOXy6fDx+elZnqODLeSMuTdxC9a6bG0ePU6K/Q09CL/gt1XuiAkl27R3QbDzDcgsVgIs1xd2ZSaS/V3ZvYclRl26/Mb+xcJjJRw==;5:T6aCz5yyy6BL/fyO3RwBJyDUprZmbte8nplRkAVzpvcODqDmLBecU5dZrqiHxpOzjthvq8dC7esFC+Lfl98nloqMhQuRPrMldzT/5j7V0qmQN0x41C+8PQuUsby5zof8dUkXNXxW1hAXYjfPmc78bA2VdP7wWqix2xoqUjKDmpY=;7:ZeH8KCiGQP/lEwwShcZb4pUhDd9J+xQNub/RkunHupgOIOkUfd+UVsCxSsKZ0DLUK3aBSpnPFH90fFXl9H5sHAhylsIyoJImrVkZYeBMmXizifkR6O23YJXSbL1Oq8q/jiLCsUU01ks8P+G3+Nep3bKUCKMvNSdqHj6K1wfVV43T2QyfF7YKE+AyW4eMhtFQ3cT62r2QoUBNsQ5F12Qs4akD8QM8q7LlHiYtYpSy4o2q4DtbBBuWRVxQF1Voso0I
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:20.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d6a228-c952-4b09-3c34-08d614c3d2d8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2682
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
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e9901cc..e1d4b73 100644
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

