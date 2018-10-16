Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4FC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD682089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD682089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJPSKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:39 -0400
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:5587
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbeJPSKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:38 -0400
Received: from MWHPR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:301:74::24) by SN6PR02MB4687.namprd02.prod.outlook.com
 (2603:10b6:805:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.20; Tue, 16 Oct
 2018 10:20:51 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR0201CA0011.outlook.office365.com
 (2603:10b6:301:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:51 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:50 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMR1-0007L9-Jg; Tue, 16 Oct 2018 03:18:43 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQw-0002EI-9H; Tue, 16 Oct 2018 03:18:38 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAIbD1005798;
        Tue, 16 Oct 2018 03:18:37 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQu-00028h-WB; Tue, 16 Oct 2018 03:18:37 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 9/9] serial-uartlite: Remove SERIAL_UARTLITE_NR_UARTS
Date:   Tue, 16 Oct 2018 15:48:08 +0530
Message-ID: <1539685088-13465-10-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.681-7.0-31-1
X-imss-scan-details: No--5.681-7.0-31-1;No--5.681-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588508686782;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(2906002)(9786002)(11346002)(446003)(55446002)(426003)(36756003)(336012)(5660300001)(26005)(16586007)(2876002)(105596002)(77096007)(126002)(8936002)(73972006)(86152003)(50226002)(63266004)(486006)(106466001)(476003)(47776003)(2616005)(81166006)(81156014)(61266001)(48376002)(110136005)(54906003)(50466002)(87572001)(8676002)(6666004)(356004)(86362001)(83322999)(316002)(76482006)(51416003)(76176011)(82202002)(498600001)(450100002)(305945005)(73392003)(107886003)(4326008)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4687;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT013;1:3tCNp1VfmvqDFdtkmj/OlTrugf0Aw65ovMLEkSiM1JRWmFRJBwE/BAff0buUBgeQ+4djtah/uxiBG/SD1YSEddjW1DLZC0gZq8LFJFdZaU6huQEAd7AqGyqmfqlpHxJm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce9f31fd-9b52-4e6f-f9be-08d633510c25
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:SN6PR02MB4687;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4687;3:JjYg9mQPn/On1EPaaQrX189RjYukhJ5AdCTlxrHAjgXa+MYhDaZik4SZWXzU83ujE4XdDoBzws5j9+owzmOubmul6DWi0qOsF7M3CMqziq/YknhKYXeEnQMly02oRVosvPzpX0arix0QkDS4TsAKYq7H685xWed+MHtgU8hC8X1KObFQCD1JRHpj6X6ERv8gq4oDIQZtqZeel1hxPHY8PfsbBp47+6S+ipyrEs9hX8dhsScd9V/bTuwufxOv6k/9RN0Dd9AVGWfp5kJuYublwGQ0fliDXucGXrvvqNtST1jcF37hOr9z7vBm2BCSCMInZ58L05WqKTUNQuOpHYK4nivWgppMn1WmvWdOYRb+bB0=;25:nin8fkXK5Ydx5AlDZNr7SClFwSjV2HPZftn9AGWOP1wGaSze2ZMx7z28n82M4IcoT8uWSkRojgHNSC+1xIe0StzWa4bdjRIL35eQrU5SyAbduu1aiR6GSs61cKkTxDqIyw3AXsiuadyw10LoXqAyADuxFfbaPS4lcRaHkzL4qS6QWE5XLOsA5/kDTdytmDvild9QVssEX9+p4bhO46WryQIAaDNzwvS2m0rYcmcYU4A2cLftwpfgHupmkmO0WvYrfb4HJhJoT9rL1p6R0esGI5vt7YBTt1g1/WIT/EiGtcUwaGT+XWX/wdOAcuzdx8ywaXXqz5gZU5SSKH5CKnyyKQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4687:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4687;31:LILKfXYzMHD8l0bqOtG+aFbDFhjr1/lPCoo8jTNLDJLjy5a2dnfIHNKZ+OxAAXjS8ClRUPG8lzJuqbtPh69KUXCsD23ImcqMGKGz1waUpvwiwwl7gL6oSL/nBacWFpeGDO5SEoNVBabX9bm2V9yKoO78fmCt5vKQ73eO4az/XKOiQdghvbW20o8ItD6+tbRy3dCcPZvgtbqpwAsqk9f17m82cr1X5s4e2yt2su+M+Xg=;4:VdrNdDzsuEV3rGAtXNlWJ8TApI/j7EsKXSPoo+wIFoFOZlVqt4QzBiBhss6JLnADe7iVnqyWHXRKmo6ZSmEQX4qbCJsu0sv4mZSxLdrtOl8oXrzVBOUFZcdmTOdHbHGJPdaLEfn7Ot1ul+3IMAV7jsGLzpyFFQhin6JD2DWAz4Y3JT0RZxEipPBhISozwmlFbtMnGKLaBeHsumZ9dadwjLCGywyQ7R+Y4OuqhQ9DPmdZ47o5dsG/Apb5YgEfv+/+e7K4RxBPno9U84M2xTHlO/EOYYfnpKQ/eZt1rV68CPYjQo9/sWG2gxvSGWEOgsxX
X-Microsoft-Antispam-PRVS: <SN6PR02MB4687F351A00108453EAE3ADB87FE0@SN6PR02MB4687.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(20161123556025)(20161123561025)(201708071742011)(7699051)(76991067);SRVR:SN6PR02MB4687;BCL:0;PCL:0;RULEID:(400006);SRVR:SN6PR02MB4687;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4687;23:mX7ZqXFbORn0HeQ5pE3e1oEBP2b4LlV9KFcrzlZnC?=
 =?us-ascii?Q?QDZ0YD6JrlGnZ6TMBnYrjmJkVCBJ9N01NDWX+5xbqxOs2ZhKeCbKIl6iBVP1?=
 =?us-ascii?Q?POrmeF0wzmgsaPGhD/gzz+M1CmS6hE/WddZINFJV8+MF9OmB0PlvFPuEZT2k?=
 =?us-ascii?Q?NHUYDDP18CgpUsHrPkjWNRACdyncoaM2gkJZE+EzoQYSSIkbOpPEiOaTrT7W?=
 =?us-ascii?Q?y1/K7ydjv8tOMlGRZ/0S74U2drMl4f9bmOGzKvo/DGL+dnI5+CJkZBw4FHEz?=
 =?us-ascii?Q?ynJkJhadI1mqR9gihsbAmKCcnPfrWltc+oZNVAHfc3Gn+aSUJEjo1/zbRmKy?=
 =?us-ascii?Q?S2XgFlkwdJitQN/dZta36Pj2yylcTnfOhdSU0H7MpgRxELDsQUiFbLL15GMk?=
 =?us-ascii?Q?3Ys1HmdlHXzufknXDnZyo62F5vfYp+qasME8o6/890Y6D9qe2t/+qMSxlUMl?=
 =?us-ascii?Q?908XaS5LjdJYz2tiXu+UMCW91wUqh+FZ9hOOp7xIkj1zpK4FW2X5j8zswvpT?=
 =?us-ascii?Q?eSdFDvQ27M8Wso4H71xhIFSOZFpM13/L0hlP/85N4y+NvwIY/Krkfi1flT4F?=
 =?us-ascii?Q?3jIZK5Gu4AxcMa8xr+DzX5U1xA8tIt/dXcLObbKoznd58QuThQYQbbytfj0k?=
 =?us-ascii?Q?1TKvCeeXxPGQpqxOVYzx+EBe/+GQdOz3OPrfYfVS4YK94eEXT6sThpHIvaHg?=
 =?us-ascii?Q?irRWZITu4u6tsbBv/k7QLPKF+JCzHugGlKzSQog8xN37kdsyrd/GYNBynJql?=
 =?us-ascii?Q?QmbqszVhO4Qgk+pxTqxpx9OoyzTv4w9YrkptLKV83mrSPATfNYlFbQ6x0gui?=
 =?us-ascii?Q?Eoiqq+RaQnvy1W3vVGjmrjLIvdVe32bHFtDXRwsBZHdyaYOLuf1qHaCzFYHg?=
 =?us-ascii?Q?AcZ9K8opcEs+0ChElxtROd9oZYjud+RW6xA2PEJ6+XdZFeny6QXy7Zr6VR8z?=
 =?us-ascii?Q?d/Zj3BjJgE1jK9CmnvlNWhFnGe7EpFkEEDuwQoIZyr0FRnr4qGsW1jigE5Kg?=
 =?us-ascii?Q?3Hs/Lg1qgKLExGGj9je/0YLkhRKFE2hoW1RGs1V5Ir8XihV+LAvA5nYxZ4zt?=
 =?us-ascii?Q?fIahZOKt1m3xvQUlvkbb490c5AhHwW9erTcQ/HsogUIa1Lyn0GVSsdj7GwiX?=
 =?us-ascii?Q?55nUaTMy/QJrxRi6I4f+anuHUKRDjhOuNzgRBp8hjWLnjQ4KKT/pqgn/xI2k?=
 =?us-ascii?Q?d0wnR6oZHc/JiaBAWiNDsGkqwv1a1GWGCkORTpxA4c6vU9s5XsPbfTA5crAv?=
 =?us-ascii?Q?0t9w34I5i2+bJ+3wHs6BGQNajs2WfMA9hZqsfi8iYUqDbIuiAXZxCH92uQAW?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 17gFyCbEH+QcN3cTBYnLI4Eo3IZsbvCj76RLRZIKlWQxQjRG/SH5UrG3VQyclZNXMRkl5knzktgtgTgof+qN3KOkJSNcDhlSpRLh+0VXU4OghVKb3ywNz1yuIJnjXCbN37Immta1scY2pANy/Kv6WVck5Ew/wILK9Z/j6VP8mIroqk2IB5+rLuosYXqG96R5SbNIqk0Hwv2JF/3UBrASReE7WA13m8guELCBv/1TXcBB3m7mmGgS8EqMykW7BlmmCC/e73eFggLOCc4W8JrGDcWFNPY4n/MZjUTdEVD7s2PpqDuUongJvQyt/iR7t7wd80RFZVmpiSbW5/iWuoyc6zGDKeodD3Nb0g3TacZj9hI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4687;6:s3UfReG2HzDJlfIEhdCG0Vyv1BuC9lVgTg8jgSndVyHUfgR3r2O2qQx9iZpOCjqPqAmluQSzpCpxOUQNmP2vaDgJFzXeLCZt0BQcH3VvWUPrrzll6h/GSVSH5KNYU3jnVDrQ3NuZ4frZ3HP6JiP6FrDpPTsot9d7MhgVf+Dw1aIZJvGxaTkLIA83BSDxTo6qnLbHiYHQGMer12/85Ze3RCyQOJio+aRrqcV9ZMahycLAf2QKG3A2cqjhAudFkJGJqFBfOgQQ+N5t+Nfz7o3VF7nnNRKmWHaa+UiIMuxEZCTZn5akKYpShMSgZEgDv3PWtzL/q1pWGXNSuZeWWyNF4T0zMkQ3hGtDp3KRHTY4ucJd5IrwNTdTQgbi7BvtWUDZ3Nr92VEZcWGUgaCk+HjzWZrkn8YNw7lbcI8uuX3eELnA8BJR2L8YletAsx0i3iGqNO1WxVM2BEARHVtmJInxXg==;5:ptthasgsFb5UtpQyV4wj4q45zXNi6/T+DlbgBXATKB7s7PxG7Dqcimxhu8CfWAt0mkMdgPzFaoy88CyzUqK6sqyNujU5lwc+oug+VBv+oq9UoTE2MgTU+j1oxjqPWdalPuMOW9hsG4zaKHzaVBHlfFTI1ZhJJ/AdKihLk7TU92U=;7:rDYW+EvxaT3XjJVb92Qell+rsdkhhkTCEYdu+4gu7muqC+eYyqUSH0t43Zh4y7scMoQLydO+0kOkG1nhpQDxj73tMcR6fH7lJLSb3LH77wFxrlK7uJ4wQ+Pmh/ERzNcZDXH7kowIQT8giyAI5zbyuZTfJII5r3ky6PYrYuUhDQfngRMsoDCFitUmJxEzwP6sbCBJQpXhq3V+qqFW07cZO3bVOMorVEl1tnxpeSqlGADeflSg53Vz3lqknGdsYOnm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:50.0092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9f31fd-9b52-4e6f-f9be-08d633510c25
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Remove SERIAL_UARTLITE_NR_UARTS from Kconfig as it is unused.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 32886c3..dc34d43 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -543,15 +543,6 @@ config SERIAL_UARTLITE_CONSOLE
 	  console (the system console is the device which receives all kernel
 	  messages and warnings and which allows logins in single user mode).
 
-config SERIAL_UARTLITE_NR_UARTS
-	int "Maximum number of uartlite serial ports"
-	depends on SERIAL_UARTLITE
-	range 1 256
-	default 1
-	help
-	  Set this to the number of uartlites in your system, or the number
-	  you think you might implement.
-
 config SERIAL_SUNCORE
 	bool
 	depends on SPARC
-- 
2.1.1

