Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE39C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779ED2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779ED2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJPSKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:37 -0400
Received: from mail-co1nam03on0067.outbound.protection.outlook.com ([104.47.40.67]:33872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbeJPSKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:36 -0400
Received: from BYAPR02CA0040.namprd02.prod.outlook.com (2603:10b6:a03:54::17)
 by CY4PR0201MB3556.namprd02.prod.outlook.com (2603:10b6:910:8b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21; Tue, 16 Oct
 2018 10:20:45 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BYAPR02CA0040.outlook.office365.com
 (2603:10b6:a03:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.20 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:45 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQy-0007L3-Qk; Tue, 16 Oct 2018 03:18:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQt-0002Dl-Mt; Tue, 16 Oct 2018 03:18:35 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAIYKn022312;
        Tue, 16 Oct 2018 03:18:35 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQs-00028h-BR; Tue, 16 Oct 2018 03:18:34 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 8/9] serial-uartlite: Remove ULITE_NR_PORTS macro
Date:   Tue, 16 Oct 2018 15:48:07 +0530
Message-ID: <1539685088-13465-9-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.476-7.0-31-1
X-imss-scan-details: No--3.476-7.0-31-1;No--3.476-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588447866470;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(63266004)(9786002)(106466001)(6666004)(356004)(105596002)(82202002)(55446002)(61266001)(47776003)(81166006)(4326008)(5660300001)(36756003)(81156014)(14444005)(450100002)(73972006)(316002)(4744004)(86152003)(76482006)(50466002)(48376002)(86362001)(8676002)(16586007)(498600001)(426003)(8936002)(336012)(73392003)(110136005)(50226002)(87572001)(107886003)(26005)(83322999)(2876002)(54906003)(77096007)(76176011)(446003)(305945005)(11346002)(2906002)(2616005)(486006)(126002)(476003)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3556;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT059;1:NOAXWqACyZJ2vsoZ3STToMUy9xIRlDBaeYiBPvgcghn+fP3ubIwppXdXKLbqDArzHuquU2TdaOxamgxThe4Dn4dZZrPaJU5R6eK1/NJMmgiNjTnlDmzlclv2WennqhpE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb41f04b-42fb-4ce8-64d5-08d63351087c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:CY4PR0201MB3556;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3556;3:WYt/IzEaSvbnYUOmS8ZzEvhxKaLxAZLkx2e2v4w4x43TtoACkky4zCXPvAiaH63n5sAcSnXCS3khorSkHRZ2RYA3Hu7n9QOjrsQTl1n4ymqJtjx6KNUYpA77zk0Y11LwQHNeuUYHPbEdsU4PAQ4YFOYc5ANa2/aQbMJ32hxQmPASEQbUFnrygmaUmNKQzzvEjcbIP97w8BpXyNQtjPOvIp9VN45uoPdnAArLh/ngzbUceJ8Zqg0mYWSr9TLqxXWx2ILRJ//bjTdGoXUTxq82yFDKaKhSnNDOJxPlD+D0ooTLzV5fj5q83T5pS2IgELIQ3rSKMBnHJ0A1FFOkxxFGTj/X2emC1jWofvnxGfHVqck=;25:T+3V94EoAuKTwq2Bk/PHZGO/Ki+vOLtqFiRxslHH0wh/5vw5SBuNGJ+gfWOJODU8uDMipCp23r1qlaxNyGvG06iWAZLtElml70kIvAfIS+x8urFGbQB9sqXkV5kRBW9Qsoz8kAaXjj1ZK/w576h3xlbPSceLLtveALCr8HQmOcu7ZkA20qNl/oB6JHhoXYdtmfPh+yLze/nJK2IzoAWQczkEqrryeLgVDVvrtUCjhu+/xp5kM5jsCoyQ+0FYdBixBc8ey3IC8kFbRPFiEks3kZWe8B9ZQyFwVAuCAnBM9hlLh0vwLCOXqH9JFWDZ8dlazoRc7RPHKX95Qy+pBPrUlw==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3556:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3556;31:aeUyEgkJ2+rUvq/Aga1TdFu3lp6Ga7CnhQu6iUI029SiirzTOZOahie0+XEqBk/FYoGkhEY/MGvw6212EU+GmNVyF6In/HYDoR87san4V4T+p8USH0+cQh2wD4AbSTkScAxHsUkkVJnMwYPtyunWSyKwSH9YvBIqzSGEroAMaAruEwo236FyJhg6yDv0ErZj+bxXg5I14atuEkYk1ZMMCxaEo6F1rFy0H2Id5e4LE2I=;4:E0KsrtRS/Nlxb+XLL5FVlaER8H0V5fcIdLzsDCEKj6PDmVRy5+gpndEI1bi0rVMgbzHikcFdobnP5d538ukGhnQMl4Ejhp4uZ+QQofKYG5WBgz5oCasRwKDkCNu4+dHokKefl8YXOFdYnqIdyhvUDmyPXn930tAe/IfybsV3BXHKKLxPpf9Ln+GORt+FXpDqh3WDofR8jSg3UrgiIRPH7pIoGb9uqi/SI986F9GiYDKLWh813VHR5q+Mt2RA0kEFedcjhETpvSyOPs42kymYFQy3IiqxSyq8d+sQ796T6mRAd1UMlib/IdsSxKXtiOe0
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3556CB2934C035DEC5C72D3487FE0@CY4PR0201MB3556.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6096035)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123563025)(20161123556025)(20161123561025)(201708071742011)(7699051)(76991067);SRVR:CY4PR0201MB3556;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR0201MB3556;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3556;23:72kGWQfk1CY/2Uvg8uGfSgg5PJVrXba+x45oDhh?=
 =?us-ascii?Q?KGP01dpZv2IJgWT2B6Zu6aqweIUYHX8mrqmoQYakCmJL+b6U2CQeQgZKexRV?=
 =?us-ascii?Q?kpdby61SBOtoVHZLCz6GIvVIXrQv+8rOP0gbrloeymxfzwfcpDEXb1oHyUUf?=
 =?us-ascii?Q?i7ZooNrhZqU9mONpodg68tw++vR4VpRzN938PNvcndJgey0x/fzt9CS2HOVU?=
 =?us-ascii?Q?wGCOq4l2ic/7Z6P1UQlxznMoE7uBBoskhMxM0CkCpAyRv+jhFvl/NGioZkkD?=
 =?us-ascii?Q?c67LPEXb5/DvoeJO8nIQYIRGNqfIAmcySzIm76tgIGG5Kg8RYSYrnr19q2lm?=
 =?us-ascii?Q?dxWQmVNGN5OY6MfGKRKmV/lyE44ANHOiYhkuKooOrpFf9CFcZJUyrF8XgjgD?=
 =?us-ascii?Q?XeZM89Boh0mhkYw6s/JVF3Qcrg8J3csGaou22FSvUdK+WXAiRsv4dTqhtx0b?=
 =?us-ascii?Q?h0Vuj9lPfCoq0b5I8PMG74b69UW+fQkFcd/iPXm+E5JVw6JfqAnXtbSWBOHx?=
 =?us-ascii?Q?xEVE/GRG3fvTzxZ76OIyEBkUaeLpBqxkpPfzyaegT86RcxN7ue02oniu1bcz?=
 =?us-ascii?Q?W0OjxU+wZKf15jrkxMhEaZ38+h7x1UYxa13ekmewcYckv8I4gLXsuKUnQXYz?=
 =?us-ascii?Q?+R5F5YBtPojJBlDO4W3fxB2y7gbtYIQ36G9nc+X0gs1ofdycZLsUmLXjSoGi?=
 =?us-ascii?Q?FmG7VmWlHQqqbg5y8CCLRX7H1yKIFBr6uuCKHvuBQKORdHozzQ8PzuN+7sAM?=
 =?us-ascii?Q?JxckYDUgXNNNXgaYWiaqh3HFI+BTE/jkjIpoimP57eUam54bRVKHRb/Z641Y?=
 =?us-ascii?Q?7zDI3iWeEVwBQg8G/cpDEAHDQ0AkSCp5LwoOjbHDqUYmQ8hix+TXc5kW4CSF?=
 =?us-ascii?Q?x+NaJGTeTiocXbr+wxYdKJRvc1sKdM9GuaiSz4xCRcgFlW5BwOmjQHT9OJ9x?=
 =?us-ascii?Q?X2QsY5Nw2vZkbLJ/cLgOXvC4f99GIdos5hrikLW7FFuyA5b+J8gV+MJ5SN3o?=
 =?us-ascii?Q?V4eHVvP7E1PDLfMi29y4D9PJPhJb7K7gcYJ+iFAdfCam4ChcO+hbEHF0n2RS?=
 =?us-ascii?Q?N3V/w5CbIIlooKYVO/1mCjPRS0rYfHD1sevvBkF04bjGtHFCr3lkw0SBI1Eo?=
 =?us-ascii?Q?b0Gkhgz6AWAp1bsaGlXxLNetTIi3irU0QeEdTm0aa7sGh8DQGKQuqPhy/pTn?=
 =?us-ascii?Q?ovJgCHbSuDY4gwPeHlBiXpGpR1gYW5MabI/FMr2nlJMDQ0Ej6J7GEumNwfTf?=
 =?us-ascii?Q?pFBugLTvnkyXXx15Lgl4vrqOA2okmI/Sc9VNEjlaHVNw7cxuRCZeby24lQ1h?=
 =?us-ascii?Q?9wuUNUxpXZ7Dryy74a+tR6MhIcaf84HTswIqY9lb4iw5m?=
X-Microsoft-Antispam-Message-Info: IWtedTiRR3FsBef9j9u6yQKfCMJdoJBi0qGgsQZ+mm7i9OgeyJETY9LsNrzjXxEzxYlfC2+/MdlZyUmeD4ITKbSmm7aaXhNX7Fd+4DNMfXBLESzygw8rtNcd+f+wacRxCK2X7ZAjBFrNp3UAdfNxHii2HgXUx5n+qv+lSlFjC+mPDcu5VlbE4BzQ/m/Diy/lp5uaYqPLgS5+a8VpzN51hpUZpJbuDrKCymcqKtTzNBPRWUnNNGylDNUGtVjRSGTQR2gUl+1runKWfqr6W4Vpm9XPCvEhMUdIzc0pQfmTe0R+z9nWCxH2GO+cpBQUydfLtDwisjh+YeadliD2SHP9mtCdI4o+krtD3rJrk5XJ0YQ=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3556;6:P15FqdASNkO+EBHknQbb4qCUd+mbOWS/Ju5/Njru0nwM9zTJ03jT/DIQZ/APdYN6oa6kpL8bj6+/u5gf4B54CSuusfKJWtA451RHI30jSVXwjOh0KvAclySzBDoDn/1heSaH3qbsqybeyezE/5cQE+cns5E3HXAMhX8AiZTjcWipJTlCd+U+riZeDWMcvzeF9ScCUTcyo0GD+nAKCwM+jbIEk0QXXXE03dP+DWeIfSLHOfPvDvr3dPTDEwc2V2VohzgDqd7pbSARZpFnwRRwxJw5hSKci2xdRaBpqEkV/nSc9ucPKw2fLiRlM+drPakEBsuviLGlhBps5W/qGDDZ3K/k6b6GNW+zJjIQcI+KXQB/S6qG5BdOjLb7NmLmmznwNu84bBnJyil4LJFxgBUjNBwB8D4rx5j/fNNsoN174F3FQrJNgVWrFMF8ZxqCUjInkEtRl9A6FZCjGbtReCaA0Q==;5:b4bpY8y6JUfqyYvLfhVI392++iDk2qhNqzTfMzFQwMr0d3Mi2qYxhqD6XrfqMMJfmsJgX7zHuPhxsS4668i82mmUi807k1ReBdv4AfvODd6CsBRQTgL+scg2Me0RQZpS79Yg1FiZ73b1NPdW45PEUDHDg9BhAmtjXCZ4zgxQ0OI=;7:oHUtKbvLY3S+GE/tOOgfZdelkAFCgOmvC2grNqfEFyJo2MuG+w4CqP491SR22mXAPlb0dpaxumtU1Vh2VcgqRz1CIjtmsX3GNCHYX/rBOm4exgGLtqtHPLAOGFWXfy/L7Imw8ACwJik3aIpMr1MmtkFah35t7AsfMDNQcPsJVL16MUhmyqjC8tMo6Nil43xaxCjhhaptc0er3kDd9+Sh2hnEEAj5FsqLcLT800MuvfWmEDGEg7c8+r14a7pycsLW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:43.8490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb41f04b-42fb-4ce8-64d5-08d63351087c
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

This patch is removing ULITE_NR_PORTS macro which limits number of
ports which can be used. Every instance is registering own struct
uart_driver with minor number which corresponds to alias ID (or 0 now).
and with 1 uart port. The same alias ID is saved to
tty_driver->name_base which is key field for creating ttyULX name.

Because name_base and minor number are setup already there is no need to
setup any port->line number because 0 is the right value.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v2:
Remove the stray unrelated changes
v3:
Fix a compile error

 drivers/tty/serial/uartlite.c | 249 ++++++++++++++++++++++++++++++------------
 1 file changed, 179 insertions(+), 70 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 20fe11f..a118b8e 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -27,7 +27,6 @@
 #define ULITE_NAME		"ttyUL"
 #define ULITE_MAJOR		204
 #define ULITE_MINOR		187
-#define ULITE_NR_UARTS		CONFIG_SERIAL_UARTLITE_NR_UARTS
 
 /* ---------------------------------------------------------------------
  * Register definitions
@@ -65,6 +64,7 @@ static struct uart_port *console_port;
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
 	struct clk *clk;
+	int id;
 	struct uart_driver *ulite_uart_driver;
 };
 
@@ -117,7 +117,6 @@ static inline void uart_out32(u32 val, u32 offset, struct uart_port *port)
 	pdata->reg_ops->out(val, port->membase + offset);
 }
 
-static struct uart_port ulite_ports[ULITE_NR_UARTS];
 
 /* ---------------------------------------------------------------------
  * Core UART driver operations
@@ -535,18 +534,6 @@ static int ulite_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver ulite_uart_driver;
-
-static struct console ulite_console = {
-	.name	= ULITE_NAME,
-	.write	= ulite_console_write,
-	.device	= uart_console_device,
-	.setup	= ulite_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1, /* Specified on the cmdline (e.g. console=ttyUL0 ) */
-	.data	= &ulite_uart_driver,
-};
-
 static void early_uartlite_putc(struct uart_port *port, int c)
 {
 	/*
@@ -590,18 +577,6 @@ OF_EARLYCON_DECLARE(uartlite_a, "xlnx,xps-uartlite-1.00.a", early_uartlite_setup
 
 #endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
 
-static struct uart_driver ulite_uart_driver = {
-	.owner		= THIS_MODULE,
-	.driver_name	= "uartlite",
-	.dev_name	= ULITE_NAME,
-	.major		= ULITE_MAJOR,
-	.minor		= ULITE_MINOR,
-	.nr		= ULITE_NR_UARTS,
-#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
-	.cons		= &ulite_console,
-#endif
-};
-
 /* ---------------------------------------------------------------------
  * Port assignment functions (mapping devices to uart_port structures)
  */
@@ -622,24 +597,9 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	struct uart_port *port;
 	int rc;
 
-	/* if id = -1; then scan for a free id and use that */
-	if (id < 0) {
-		for (id = 0; id < ULITE_NR_UARTS; id++)
-			if (ulite_ports[id].mapbase == 0)
-				break;
-	}
-	if (id < 0 || id >= ULITE_NR_UARTS) {
-		dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
-		return -EINVAL;
-	}
-
-	if ((ulite_ports[id].mapbase) && (ulite_ports[id].mapbase != base)) {
-		dev_err(dev, "cannot assign to %s%i; it is already in use\n",
-			ULITE_NAME, id);
-		return -EBUSY;
-	}
-
-	port = &ulite_ports[id];
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
 
 	spin_lock_init(&port->lock);
 	port->fifosize = 16;
@@ -653,7 +613,6 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = dev;
 	port->type = PORT_UNKNOWN;
-	port->line = id;
 	port->private_data = pdata;
 
 	dev_set_drvdata(dev, port);
@@ -778,11 +737,24 @@ static const struct of_device_id ulite_of_match[] = {
 MODULE_DEVICE_TABLE(of, ulite_of_match);
 #endif /* CONFIG_OF */
 
-static int ulite_probe(struct platform_device *pdev)
+/*
+ * Maximum number of instances without alias IDs but if there is alias
+ * which target "< MAX_UART_INSTANCES" range this ID can't be used.
+ */
+#define MAX_UART_INSTANCES	256
+
+/* Stores static aliases list */
+static DECLARE_BITMAP(alias_bitmap, MAX_UART_INSTANCES);
+static int alias_bitmap_initialized;
+
+/* Stores actual bitmap of allocated IDs with alias IDs together */
+static DECLARE_BITMAP(bitmap, MAX_UART_INSTANCES);
+/* Protect bitmap operations to have unique IDs */
+static DEFINE_MUTEX(bitmap_lock);
+
+static int ulite_get_id(struct platform_device *pdev)
 {
-	struct resource *res;
-	struct uartlite_data *pdata;
-	int irq, ret;
+	int ret;
 	int id = pdev->id;
 #ifdef CONFIG_OF
 	const __be32 *prop;
@@ -790,40 +762,158 @@ static int ulite_probe(struct platform_device *pdev)
 	prop = of_get_property(pdev->dev.of_node, "port-number", NULL);
 	if (prop)
 		id = be32_to_cpup(prop);
+
+	/* Alias list is stable that's why get alias bitmap only once */
+	if (!alias_bitmap_initialized) {
+		ret = of_alias_get_alias_list(ulite_of_match, "serial",
+					      alias_bitmap, MAX_UART_INSTANCES);
+		if (ret)
+			return ret;
+
+		alias_bitmap_initialized++;
+	}
+
 #endif
-	if (id < 0) {
-		/* Look for a serialN alias */
+
+	mutex_lock(&bitmap_lock);
+
+	/* Make sure that alias ID is not taken by instance without alias */
+	bitmap_or(bitmap, bitmap, alias_bitmap, MAX_UART_INSTANCES);
+
+	dev_dbg(&pdev->dev, "Alias bitmap: %*pb\n",
+		MAX_UART_INSTANCES, bitmap);
+
+	/* Look for a serialN alias */
+	if (id < 0)
 		id = of_alias_get_id(pdev->dev.of_node, "serial");
-		if (id < 0)
-			id = 0;
-	}
 
-	if (!ulite_uart_driver.state) {
-		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
-		ret = uart_register_driver(&ulite_uart_driver);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
-			return ret;
+	if (id < 0) {
+		dev_warn(&pdev->dev,
+			 "No serial alias passed. Using the first free id\n");
+
+		/*
+		 * Start with id 0 and check if there is no serial0 alias
+		 * which points to device which is compatible with this driver.
+		 * If alias exists then try next free position.
+		 */
+		id = 0;
+
+		for (;;) {
+			dev_info(&pdev->dev, "Checking id %d\n", id);
+			id = find_next_zero_bit(bitmap, MAX_UART_INSTANCES, id);
+
+			/* No free empty instance */
+			if (id == MAX_UART_INSTANCES) {
+				dev_err(&pdev->dev, "No free ID\n");
+				mutex_unlock(&bitmap_lock);
+				return -EINVAL;
+			}
+
+			dev_dbg(&pdev->dev, "The empty id is %d\n", id);
+			/* Check if ID is empty */
+			if (!test_and_set_bit(id, bitmap)) {
+				/* Break the loop if bit is taken */
+				dev_dbg(&pdev->dev,
+					"Selected ID %d allocation passed\n",
+					id);
+				break;
+			}
+			dev_dbg(&pdev->dev,
+				"Selected ID %d allocation failed\n", id);
+			/* if taking bit fails then try next one */
+			id++;
 		}
 	}
 
+	mutex_unlock(&bitmap_lock);
+
+	return id;
+}
+
+static int ulite_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct uartlite_data *pdata;
+	int irq, ret;
+	struct uart_driver *ulite_uart_driver;
+	char *driver_name;
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	struct console *ulite_console;
+#endif
+
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
+	ulite_uart_driver = devm_kzalloc(&pdev->dev,
+					 sizeof(*ulite_uart_driver),
+					 GFP_KERNEL);
+	if (!ulite_uart_driver)
+		return -ENOMEM;
+
+	pdata->id = ulite_get_id(pdev);
+	if (pdata->id < 0)
+		return pdata->id;
+
+	/* There is a need to use unique driver name */
+	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
+				     ULITE_NAME, pdata->id);
+	if (!driver_name) {
+		ret = -ENOMEM;
+		goto err_out_id;
+	}
+
+	ulite_uart_driver->owner = THIS_MODULE;
+	ulite_uart_driver->driver_name = driver_name;
+	ulite_uart_driver->dev_name = ULITE_NAME;
+	ulite_uart_driver->major = ULITE_MAJOR;
+	ulite_uart_driver->minor = pdata->id;
+	ulite_uart_driver->nr = 1;
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	ulite_console = devm_kzalloc(&pdev->dev, sizeof(*ulite_console),
+				     GFP_KERNEL);
+	if (!ulite_console) {
+		ret = -ENOMEM;
+		goto err_out_id;
+	}
+
+	strncpy(ulite_console->name, ULITE_NAME,
+		sizeof(ulite_console->name));
+	ulite_console->index = pdata->id;
+	ulite_console->write = ulite_console_write;
+	ulite_console->device = uart_console_device;
+	ulite_console->setup = ulite_console_setup;
+	ulite_console->flags = CON_PRINTBUFFER;
+	ulite_uart_driver->cons = ulite_console;
+	ulite_console->data = ulite_uart_driver;
+#endif
+
+	dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
+	ret = uart_register_driver(ulite_uart_driver);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register driver\n");
+		goto err_out_id;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto err_out_unregister_driver;
+	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq <= 0) {
+		ret = -ENXIO;
+		goto err_out_unregister_driver;
+	}
 
 	pdata->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(pdata->clk)) {
-		if (PTR_ERR(pdata->clk) != -ENOENT)
-			return PTR_ERR(pdata->clk);
+		if (PTR_ERR(pdata->clk) != -ENOENT) {
+			ret = PTR_ERR(pdata->clk);
+			goto err_out_unregister_driver;
+		}
 
 		/*
 		 * Clock framework support is optional, continue on
@@ -832,11 +922,10 @@ static int ulite_probe(struct platform_device *pdev)
 		pdata->clk = NULL;
 	}
 
-	pdata->ulite_uart_driver = &ulite_uart_driver;
 	ret = clk_prepare_enable(pdata->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clock\n");
-		return ret;
+		goto err_out_unregister_driver;
 	}
 
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -844,11 +933,27 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
+	ulite_uart_driver->tty_driver->name_base = pdata->id;
+	pdata->ulite_uart_driver = ulite_uart_driver;
+	ret = ulite_assign(&pdev->dev, pdata->id, res->start, irq, pdata);
+	if (ret < 0)
+		goto err_out_clk_disable;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
+	return 0;
 
+err_out_clk_disable:
+	clk_disable_unprepare(pdata->clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_unregister_driver:
+	uart_unregister_driver(pdata->ulite_uart_driver);
+err_out_id:
+	mutex_lock(&bitmap_lock);
+	clear_bit(pdata->id, bitmap);
+	mutex_unlock(&bitmap_lock);
 	return ret;
 }
 
@@ -860,11 +965,16 @@ static int ulite_remove(struct platform_device *pdev)
 
 	clk_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
+	mutex_lock(&bitmap_lock);
+	clear_bit(pdata->id, bitmap);
+	mutex_unlock(&bitmap_lock);
+
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	if (console_port == port)
 		console_port = NULL;
 #endif
 
+	uart_unregister_driver(pdata->ulite_uart_driver);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
@@ -898,7 +1008,6 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
-- 
2.1.1

