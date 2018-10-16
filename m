Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5632086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5632086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeJPSJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:09:55 -0400
Received: from mail-eopbgr680044.outbound.protection.outlook.com ([40.107.68.44]:45504
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbeJPSJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:09:55 -0400
Received: from BN6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:405:60::18)
 by SN4PR0201MB3568.namprd02.prod.outlook.com (2603:10b6:803:45::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21; Tue, 16 Oct
 2018 10:20:08 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR02CA0077.outlook.office365.com
 (2603:10b6:405:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:08 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42177 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQj-00009i-OK; Tue, 16 Oct 2018 03:18:25 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQe-0002BP-Ex; Tue, 16 Oct 2018 03:18:20 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAIJuq005727;
        Tue, 16 Oct 2018 03:18:19 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQc-00028h-Nd; Tue, 16 Oct 2018 03:18:19 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 2/9] serial-uartlite: Add get serial id if not provided
Date:   Tue, 16 Oct 2018 15:48:01 +0530
Message-ID: <1539685088-13465-3-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.734-7.0-31-1
X-imss-scan-details: No--3.734-7.0-31-1;No--3.734-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588076674927;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(11346002)(50226002)(81166006)(476003)(2616005)(126002)(336012)(446003)(486006)(2906002)(8676002)(5660300001)(73392003)(16586007)(76482006)(81156014)(107886003)(9786002)(87572001)(50466002)(48376002)(63266004)(426003)(8936002)(305945005)(82202002)(26005)(498600001)(51416003)(356004)(83322999)(110136005)(316002)(47776003)(73972006)(2876002)(86152003)(61266001)(76176011)(36756003)(54906003)(77096007)(55446002)(6666004)(105596002)(86362001)(4326008)(106466001)(450100002)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3568;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT023;1:IfnDjiM8BGEKpUSQF8fvNVb19yyz1UaGI200wgKuKQZl3HPstqrWNNXWPwbirQQz6NPtoXsG6bmDcHEKFOJBvrudM8Jwv15FXdZQXTHP+DAH1qE6oLPGqNDxzWplv/cI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f82ebc2-9621-4ec7-d854-08d63350f25e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:SN4PR0201MB3568;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3568;3:g+LPtIWOn4MJ7N01v9Fjo/vRhijIv2vzmFNdj+82wmxvML/SzOMz48vX4PM6vZ55Ng14c8Rpy/4cegL45r0qXGwoMUc2BeZ2np816sxk9NT9ieVPgmcAo093rddB7Z+wpy9hwKTFfewoo0LBfXDXc1hll5YPyDa7i0cSmP/zXmXqZTeONXAyVP0DBVVzD+KtAjB6LSZc5XAVhBeAkHj/E5Am7qDGKxqp8941ljWR4464TwjCA0/UKQN5lYO88cZMHxd55LEHYmH9wSl3kJcGlbNpo5ZNSJSAZdxal3+qyckG+fKAbZYDSqMr7P4WiK6l/7t8S1DFpVIsQIKsd20g0og4ODdM0TMDglABUgqEixo=;25:Xw4XVdiavDc4NuADK8gzXKWRGLiCjUgLmBBDVJpq3BQjqJ04EwJCIr3YA67E+b7tc6Mwb0Bh+LHbUoJMh3WDcAV/dABrRMoC1h6irj2rqxKEKPMhJGHE5hbRbLCsyGwRHNlES8EMuYYsfXpMqPjxJ4FSkxvhIcm8jqCJQurV5r/z4o/+QOn3KUg1jZkUyV990GPSmTgGVWI1EMbkIDdR3cK/BgqkGQSjb+fbECkHIK9d0Zjcdlv5wZm7kdklogxZxixmlqcuFgTGcb2zfn0ERTxYxMuVZijNdejlJqWHYOG2yAeZKqNfOtAW070Hn3n+vO5x6bIzF6uaK82zMSBgUQ==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3568:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3568;31:PPsoOkc3m4kgMkYHJxE/O/oZKd3AOPf2iloCKbn4do7/ST5AUWfVNxyr+p7LtI9a2q0ccFUcRkHQIwBgrv3qEHsMRC8lqaV/qnBF2h/oks5bRyEudkR7itUAaTEzLsAKjFF2eYmulMo3EIwLf+/wTjZLVeC0TNYONylxKkkDn2ONMSCUjlbTQ64gnKjwkG3V/HbiLWnfuC0pLP0XQJMg8EtM0EICCpKu7T+r7hN2aMg=;4:uOxqU2rOYZRS3LdXDziyAus9wl8b5UxfUgmdr98mRssL1PKIawYkuzfftJPxlpjflX+s1ugGuQ7CSTPt6ViWFOmsHDO86nIBL1daj4DAA1lgwvPO+IFEQzw8fknoGFEaAhPrblYmRinASDwrCI1zEtovxfUPu+FphNnmgELmudLhtAqA2ppfF/Sa/YPSy09GZIWzX6DtVaClpEC/bh3WlFLOcZlKQEwpvKbe1h6bONvRAipZb2eFXQXwPw8rhr1Oleq7ffLyhXZQrKoWYgy0qdOupw7fBhUZ7Fi4oomjTDO/YrCErY3Q4cZfQyZD31uH
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35685F4F104B7A1E0A8531C787FE0@SN4PR0201MB3568.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(6096035)(20161123561025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123556025)(20161123565025)(201708071742011)(7699051);SRVR:SN4PR0201MB3568;BCL:0;PCL:0;RULEID:(400006);SRVR:SN4PR0201MB3568;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3568;23:Z6Ms4FqPa4VAwgF1A5qNq3Bn0K7vZ8uGGEzoA2P?=
 =?us-ascii?Q?eHv1i0m3bDPD1EBM4HfNjjJ+pH9+CB4h/WtWEqEwnTdt628Xsr0Xc/C8uYIn?=
 =?us-ascii?Q?C6onIuUy+zeGLS7jwie3X4WnfYPq7UOOHSLjR5ZxsQERA2UAuBMz0vtzHTCA?=
 =?us-ascii?Q?ddqo7p1w3u+ttgBj75oa386JtKPTwprm6trHIiVkzCIYWZ3Pd2l11vJ+p6zo?=
 =?us-ascii?Q?egzjNcy4ra5X8Bnn2MereSGFrwEVWkLNzpkgPt6mTS5t9mbLtDqWisX38cTB?=
 =?us-ascii?Q?frFDthpuBCuDL1cd2LbIMXrdZaJ+B0/E7fHqNGHkmFalqWpmZdutDf3JHvnQ?=
 =?us-ascii?Q?m5EFS236m64VPttLv/uGr0zVG+9OSMHuE+5oLo0bNRRx3TAvn6NodYPPEIfU?=
 =?us-ascii?Q?DF/gR4n8BULV8qoj55/xpQfi2QU3xzL92O3Qacd/tcbjrNQ8i1/fwOlasMbT?=
 =?us-ascii?Q?bcxJ96nCuiL7ZFOYQnV3tOW0kt9CJks64UqIgec8T0zIo7mk53hjSsaptt7M?=
 =?us-ascii?Q?0lRHPBacnpFhcHKIbgeB+A8AsopfYzGcLZwazimDTt++jX/qpXh0PfSZzw2d?=
 =?us-ascii?Q?co1v5vl/zCdart8cWCFo4yLffozzDIPCKa7huNhnVbbc8lL9iwxWXF8UZl9L?=
 =?us-ascii?Q?QGVR9Oxqud4MZNZk4USnYrD4bRhlg0y7N/ZUxUqwf1M8OtQ40MMWMeO8Ql+i?=
 =?us-ascii?Q?lZ+FRcXexlBeorNgaqWVD5KI0LiIZaWiIm1e6u4t94qUZQynlvy5Bsn/U3AB?=
 =?us-ascii?Q?Kvn1Rw3gtTP9xAEASfEAa212vZfd1gfk1BlCS333iaSnGOdywQgWqjuScd6G?=
 =?us-ascii?Q?1HR+oJv1rwNJIedfuLcL9t4GBbww+qMoSSaAGtwJxE7ty9Rlgg5sJOOV4cwi?=
 =?us-ascii?Q?h29piqBpePchLbFVW6RfaFLt5JI6AiQOnw6HrNPF5gfTxji2DD409qszU9Yk?=
 =?us-ascii?Q?DHC6GN5ZyO7SgLWrSgxPGq6VTZz2v+LMlapto2uR00edBd93X3bRXrPASVVg?=
 =?us-ascii?Q?wVR7t4fs2v6TNRBMznlHFSnijrkJA3vlqxod8uudaK/lYnkXAJ3gZrNkkqji?=
 =?us-ascii?Q?o6A8yAXriQ+eAH8eh7Dht9u4Jg2EkJkKn8CQwlBfu7+SxfwhWqcxefneyyNE?=
 =?us-ascii?Q?5/++zKrATUiqTYpOshTdw0G3ZyKhtVT/XeSUM7ySGs3BLS0mrDiHv2pKvvZo?=
 =?us-ascii?Q?1/nLm2mCqaK1XQBYAM0DS1Goe5k3G+I7OAOU6eIeXN6KB62u25QhbfgfYsBh?=
 =?us-ascii?Q?P5GRPnGRRN68oQ8mDivBhEEeNQvm0DTpX0/EW8KTo0RclUYgQa1g40NgCrCK?=
 =?us-ascii?Q?Myt/tXH483mrHkajSTomvpB/yRDFvAzTysi8uWSih8FSs70ayf/bNJBNCUez?=
 =?us-ascii?Q?AfVXhG4w1s/F+/xMjvtENWRIWhCz1o5XzrjneJewkePIWY2mJ8oaE5ziMGZA?=
 =?us-ascii?Q?qL+wPxe01sQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3BCN4+gV0Fdy2MdW+P7pojImJbqqHzMCDsfITPVTc5FOxhVT+OKI0TNFeBJCHA661EfAeHkbw2QKq7dPlVyln9ke2izi9MxNSbQ94Z6f1FX7VEpi8NHXLo0tr1WUHAGiJX2FFX/kZv/WO7ut3YWV5LL5RKaF6xBRDt4gTDThl4WyOmX7sDmAlOm+uUOW7bWnKYnv02dqNv4C3G6J3YUpg/+NshjCEAI06oTFPm31H7ftgCXrXhnmygLJVmHzTTVkf+VMjWCV3jdzMBuylAJxH19fFS960vWFxvDJBneYkoXvcUN12f729Us2UyfArXQx74/NWOAGGcsrFC3KDw//3bEEPe+8c3y5ZdEtK78nPLs=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3568;6:CCZ1qugLjt6H/FnffH2riZMUo/+/pnEneDZCIePothmrpCPFX18Tc75ma/AGtPtqTKQ3PiKLfgBB1BHJOOmDev/KajiyQMeM918m3tysxM3jc8LFi7G6G6rk/+tRsLHP3lbjDl55aAxRBPpR1HB0oyEyjdnMYiJVqROMxA++4KHLGz4TSTP0utBMMnFmaTKKhaFCtAekZs2CFWEpaItVhzZiHTvPrt0UfFwTkjcyiSPnAGkGueyklq0BRoJO2j5TmSG8bDotLnc3fRbhQHSbYTlS0ByBSBiAIMVNcYNINorj/Z1ormtxDzKlGo1g6m4hPdYRPMeSEK9xMHEQ+PjJNZ9WYP7QdidRFWgYFyBg15vmFLPqRuap/h1AKRnY+h44Vtva9TYMRAXiZ9dkHUkPMmps56C05zTv7FrZNKlpQX4hOhpkntWLjfa9FqMUa2chbN1oOJC6dNLIpNRzG9iP9Q==;5:Gw0bN/AQfNSHGq++V/79RymEYlny0M4N/gDwVnZ54ewfelRehOxysmdqbHCX4cLXJ1M7SrpBY42llDKbCmuaR182bRoTx/9UhkSzG7LgAQzdWQ5yGa+5RYLJc/gdzTdV27fpH9kksB4xXRcnBOJQZpNki5KySkJpKgeUjsRGV1I=;7:RqvF7hfYkod9V0tkhxJY1oOeFT5c7JpGmbErmBfN92nObEef/F0UBH9OA8R/G1WxYNgB2oV67pDDh0njqsm/8fX2mL1VFAfaCcFefEWeqQFW289dMG/SkWZ/vwW3biIueGdpTe+GwJBpLVrUidVTJVrxhYRHNnz2x4qjyLKxoLEXTyJ7niZr5FSaNWHqSIWRXL97zbz3F4OHFNV/EcyQ1Cpa/CFTvXq3M+E9EZtC7J0KdcI4QHxelauCAZzI/VHH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:06.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f82ebc2-9621-4ec7-d854-08d63350f25e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3568
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add get serial id if not provided

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 77bc9d0..441a216 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -763,6 +763,13 @@ static int ulite_probe(struct platform_device *pdev)
 	if (prop)
 		id = be32_to_cpup(prop);
 #endif
+	if (id < 0) {
+		/* Look for a serialN alias */
+		id = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (id < 0)
+			id = 0;
+	}
+
 	if (!ulite_uart_driver.state) {
 		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
 		ret = uart_register_driver(&ulite_uart_driver);
-- 
2.1.1

