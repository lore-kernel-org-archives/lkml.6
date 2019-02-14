Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5459C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB36222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="efxTzB1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436679AbfBNMtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:49:10 -0500
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:26910
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfBNMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGASrYmTzQfTjQFydY1aesMHJZ5vYnPjo8FpdvyACCo=;
 b=efxTzB1d3xbwTok4Lh6E87xb8fuUZFL5s0fACsuFQTUc4BQ9D5N5LCagooEKOoeNq7s6dUmEx+OGNsvIiFn/eKp/hC12npeqhHqk/xX288y/t3Aj4NGy4dM9y90FADRcX4Z5OgU5Y4mRBkScy6hHGDDWIg0oqirP9m6BdcTGM6I=
Received: from AM5PR0601CA0033.eurprd06.prod.outlook.com
 (2603:10a6:203:68::19) by DB6PR0601MB2149.eurprd06.prod.outlook.com
 (2603:10a6:4:4c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Thu, 14 Feb
 2019 12:48:26 +0000
Received: from HE1EUR02FT063.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::208) by AM5PR0601CA0033.outlook.office365.com
 (2603:10a6:203:68::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 12:48:26 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT063.mail.protection.outlook.com (10.152.11.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 12:48:26 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 13:48:25 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Thu, 14 Feb 2019 13:48:24 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        <linux-kernel@vger.kernel.org>
Reply-To: <federico.vaga@cern.ch>
Subject: report: scripts: checkpatch: Spell Checker Does Not Run with '-f'
Date:   Thu, 14 Feb 2019 13:48:24 +0100
Message-ID: <3030138.e1gdHPWlgN@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(189003)(199004)(97756001)(106002)(6116002)(786003)(7736002)(26005)(50466002)(8676002)(7636002)(9686003)(46406003)(8936002)(316002)(336012)(47776003)(246002)(426003)(3450700001)(186003)(23726003)(16526019)(2906002)(14444005)(43066004)(356004)(33896004)(126002)(486006)(9576002)(476003)(305945005)(106466001)(53546011)(86362001)(230700001)(110136005)(478600001)(74482002)(44832011)(33716001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2149;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a803276f-1c3d-488c-0fd7-08d6927ab67d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB6PR0601MB2149;
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2149:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2149;20:7EWxa+Wf68EjQQIuWvIL4mvdV94dT0i0v+SfGiK6yqnXlSV1aMA+jCo1Xi0kCGhC0S9ItM04p2/sV5vKHCR7xWfzSGmJ60IBjFP2BAcEYzdM8POiMMAYQjVdKqd+OAigLKInrJUvFV5IHjPlzHXU+J0FhMnDxLs+F/ymFJ/VmgXOkT4mYQK7CbK1+xF76qEN7Z8uhCU2OfmDI8+ZeSjbA26mG6E00iBGw7Amw/10dcDiMxDJY1ht6HEG+AL2rHA8W1WRqw+8sa/tHAxFMLSgVmeDOTf9xyvvfpPNotTwmvWie4yuRNZeWCtHNaBxBpTGU/MVHncpX+q7vcG1EJQTqOBU+T0QuPR6lvFfEG+UD+7e9KE3SKPKkjbKzj2WQ6lxp1dG8Z8nwXrPSh2Irp1MLPdayLUKlZgrPi+vieMeu49ZEDqO8dYMoY0dTP5kOLC8QDHP1ZsfMCE+pB/3FgAuTMFgAxuC0lry06R2j2BufbZYwnu0mqXMIjSeX+qWu0GQ
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2149A98E32219012E97D157EEF670@DB6PR0601MB2149.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0601MB2149;23:AoOlseHqw56OiN6mA/AbXdMrLwdp7cZCbb+YQf+?=
 =?us-ascii?Q?Qhsr1huHEpV1gUjdFJtEokifhywcAu42My/klaKQUOAJG0q4KZpQ8vSp7udd?=
 =?us-ascii?Q?yKVzxQ918hC5WGvgb/c+GOcXZggFWUuGfr5N1xZWqmCcSQexYFsSoBFWXIgL?=
 =?us-ascii?Q?eVgUSbh4Vgnr6gatf7OHD0/gn+vo53W7SiKlZAi2sns4jjrEGqHuM12Ovs3u?=
 =?us-ascii?Q?OcLdO3DumqEXe8fKPWtttfak862kNv/4R3rC4RtCgrbKstY3Ti0yBnKpeaf+?=
 =?us-ascii?Q?RFZ33JeLmx02gbupkkoNEjXidh9vpumL1JKcnib5k0lQ0/VJb0UI+fQOQjwT?=
 =?us-ascii?Q?mj/WmQKwi7F82578AVuQlVqLo57PNCBc+CM7rKMlLInAJnP9PnRmDzam+ZxX?=
 =?us-ascii?Q?bpE3EVG2bWama8OlZnDXsMSHPpwEW4dzwSyt/KX0W4K2DpiklJhjkwnlDP76?=
 =?us-ascii?Q?0Bk/9UFq2IEhYE2LRy5JbtbaNKFKr/rHNP6J8WS9/AUYp/QQfZ93Fq1vwszM?=
 =?us-ascii?Q?BC1iw3ahhoOvbEDTijUaazkcrtngBJHJPGlgWN7d3uAM1v0ePsM8M86E8MSz?=
 =?us-ascii?Q?2cMNi4D7h4jYOJIjRNzSanbb4NtQ2/KKuNSIHkuA11EIjVO3WQVuTMNAD1Mj?=
 =?us-ascii?Q?n9ZamD4JoDlf7ktE1EMTiPy3V0WZyz2b/J9h9mz35Yuq0Z8pRhLymRJcFGxp?=
 =?us-ascii?Q?TbVpIzge10Fob9GaxvldoiXJjc0hnsdyTuxH80Oer9+huj0HCJ5C11k4CCdT?=
 =?us-ascii?Q?69XboHClwMguw/NSarOCFOKip+j0tKrc2bmBTJmr+iBPe3EQAl9wpDcIIzhJ?=
 =?us-ascii?Q?Ff852Tf4qGRKUobmuW2VYEvPlTaQY8CBaLWvM3+T7Q2Z1qFFtU0jkzPPR/R2?=
 =?us-ascii?Q?cBi+f6l0OTPay/FpSyerPJ9uxdXuhpzhqgE83tveHsekMpFUpsgYVjQtzwYQ?=
 =?us-ascii?Q?kNzRfrRRhi+a/n81qG3Wk4JVK2QqawcJfszBcpSo6j+X6zMnG2wVgQ+sMhPd?=
 =?us-ascii?Q?tAhPhmJ0L9WJ5eoXaoGQt89yaXD7mo91HgP/yhRpDbh1/bbA/RF+57ZLAt0X?=
 =?us-ascii?Q?VoDRVmuUgGytpWWmLu5/1mo7r4Xvj?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xDjpm1ccZHRjVTrXN5ZohttDwVIkaDSgclpxcnaNZAvxVrI/RvJQ1A4c0J+44CWdYEJjLNOR/m1iNEydNy3BxwacdREKFX74sGNyUKYlWxegTTHGVmRh/16DyjTVy1o+rt5VN89QHBrdvUKRX/NP94qdkGe2o18+vYCjM2QPPKNcGu21E2hC36BwHdfNs6eBvGG6BYx3kG4pnTmfvHxT7PnJnWP3ENkFYW0yX7tZIl0h6WArh98BhLQWFpiEg/uyqDlFandbWE4re3BXAgogUo4LjuZKWO9hcmkhjkhKHjYor0vtF5phg2uQoVhM04Ukd/demzCSGFAI17tt6iskj7ver8jXCNhZQMiyxTmxWSYz+4liXLuGDlSYNGv7UxMMn0p8WrN3RzKWkYVdjOarstRI36akonF4yFfUPPyrwUk=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 12:48:26.1826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a803276f-1c3d-488c-0fd7-08d6927ab67d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently I have produce a couple of patches but I get different warnings if I 
run checkpatch on the file (-f) or if I run it of a patch file. In particular, 
the problem I found is with the spell checker which seems to run only when the 
option '-f' is not used. I am wandering if there are other similar cases.

I do not know Perl, so I cannot investigate more, but I have a practical 
example. I have this simple patch applied on my tree that introduces a spell 
error:


From: Federico Vaga <federico.vaga@cern.ch>
Date: Thu, 14 Feb 2019 13:29:39 +0100
Subject: [PATCH] script: checkpatch: buggy(?) output with -f option

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index b32d67c..f4deb90 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -301,7 +301,7 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
 		/* on going transfer */
 		mask = OCI2C_STAT_TIP;
 		/*
-		 * We wait for the data to be transferred (8bit),
+		 * We wait for the data to be transfered (8bit),
 		 * then we start polling on the ACK/NACK bit
 		 */
 		udelay((8 * 1000) / i2c->bus_clock_khz);
-- 
2.15.0


And here the outputs from checkpatch

--------- ON FILE ----------------
./script/checkpatch.pl -f drivers/i2c/busses/i2c-ocores.c

total: 0 errors, 0 warnings, 765 lines checked

drivers/i2c/busses/i2c-ocores.c has no obvious style problems and is ready for 
submission.
---------- ON PATCH ---------------
./script/checkpatch.pl 0001-script-checkpatch-buggy-output-with-f-option.patch

WARNING: Missing commit description - Add an appropriate one

WARNING: 'transfered' may be misspelled - perhaps 'transferred'?
#20: FILE: drivers/i2c/busses/i2c-ocores.c:304:
+		 * We wait for the data to be transfered (8bit),

total: 0 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-script-checkpatch-buggy-output-with-f-option.patch has style problems, 
please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

-------------------------






