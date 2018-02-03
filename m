Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1639138-1517683892-2-15521801445192385963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683891; b=o+rXDy+Clyf4MQwW8RqHaguasK9eIGEQBlXmMmlyES+Q1Hk
    cfNg4xvEDMt/CIlsHIz63qWp2PpGMUzSVTUddY4DWPqIzPtJCPH28owWMbHWHeGn
    RRIqVTUMEU1gPoDVs+EZJd1r5l5Ql7+H5p7T1p8KnHItDK0gTrBqgvCexv/An2gh
    Nf2GC4P4q3gO7rxuLFoMOl5UjQSAZxFiMPLBv8cB/szc66/DIrlKEkPF4TCOsk60
    3G+9qxAnF/iZY/OqlrCluLynLQ41SPyHUcbkzIEhyAM5SkeD1Dxi/rkQEdDmi9XK
    i47uXF4O93f3+qOFttg7SHJm1/Fm1UVbpacolLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683891; bh=/QW/Kr
    h3nJ0Qc6Lzj66dusfxWpESxCDof1hLZg4lJaU=; b=seckUNMdXPBc1cQ55nn9Eu
    asE+2d4ha1xTobfoCBa23GdstQwFVg+8oVQ9LyF2AQ596olEoyiuzF9wqldAF08E
    e2QO5YwVXI+5PFBk3OVlu8oehO3+aUCyfRx+A0CcMMy+5zex/MqxjPJ3GjLLKz2j
    p/bpEhkNZjvZtbFCmehXq/Tqoxaa52OFqQylxFD2dVlX2r8oz+MocrvFeKE6KuLc
    mZZkM9NSk/C70zZ8DJZSqJeAhnfla6nxKnY9pyPnSzpG5jwyPFU3DgsNqfHAK04g
    5C35oawucZu9hvkEIoCHho9W6VS8uceiOqgx8wRiR9GNt0efvEsvxBJTLeDNoecA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=khneY+7D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=khneY+7D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeBCSBU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:20 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752669AbeBCSAe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andreas Platschek <andreas.platschek@opentech.at>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 005/110] dmaengine: fsl-edma: disable clks on
 all error paths
Thread-Topic: [PATCH AUTOSEL for 4.14 005/110] dmaengine: fsl-edma: disable
 clks on all error paths
Thread-Index: AQHTnRjfJNsvGoIm+0qCjJ8Rw5Gowg==
Date: Sat, 3 Feb 2018 18:00:28 +0000
Message-ID: <20180203180015.29073-5-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:jq+3RlCKTRqG1fC8LBGNzHVlVv1p5B84EE7rVcQ2LJqQpgPhSUH148NTJDTI1r1nNhy/a2UrLz44BgVcqDsqum2W/O2CusShI/FD7EBetspy9/wCTQoc3dPLLaKTzPeLfl0l+BAYSodnlC5GXeJda+XQF484HIq7VOETw+G9vKIJg/zXVY5+kQqt3wPgyr2Zntz22rDJJD6KnlAX073lhFeUbmJhneicFzdIPpWkBRbj6UbD9jTnTSOmmJ4EDO1l
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf606aaa-94d1-45c2-dc54-08d56b300386
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043BD2F9628E8FFE7C38529FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: GdRD/4s+ix0pTxajQWBsSvZoJCTSqlwrlxu2wDslSQPdas85sHmzrFZCCbPSCsyjfsd+KkvkUCAUETTQt33mSQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf606aaa-94d1-45c2-dc54-08d56b300386
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:28.4721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andreas Platschek <andreas.platschek@opentech.at>

[ Upstream commit 2610acf46b9ed528ec2cacd717bc9d354e452b73 ]

Previously enabled clks are only disabled if clk_prepare_enable() fails.
However, there are other error paths were the previously enabled
clocks are not disabled.

To fix the problem, fsl_disable_clocks() now takes the number of clocks
that shall be disabled + unprepared. For existing calls were all clocks
were already successfully prepared + enabled, DMAMUX_NR is passed to
disable + unprepare all clocks.

In error paths were only some clocks were successfully prepared +
enabled the loop counter is passed, in order to disable + unprepare
all successfully prepared + enabled clocks.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/fsl-edma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 6775f2c74e25..c7568869284e 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -863,11 +863,11 @@ static void fsl_edma_irq_exit(
 	}
 }
=20
-static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma)
+static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_cl=
ocks)
 {
 	int i;
=20
-	for (i =3D 0; i < DMAMUX_NR; i++)
+	for (i =3D 0; i < nr_clocks; i++)
 		clk_disable_unprepare(fsl_edma->muxclk[i]);
 }
=20
@@ -904,25 +904,25 @@ static int fsl_edma_probe(struct platform_device *pde=
v)
=20
 		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
 		fsl_edma->muxbase[i] =3D devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(fsl_edma->muxbase[i]))
+		if (IS_ERR(fsl_edma->muxbase[i])) {
+			/* on error: disable all previously enabled clks */
+			fsl_disable_clocks(fsl_edma, i);
 			return PTR_ERR(fsl_edma->muxbase[i]);
+		}
=20
 		sprintf(clkname, "dmamux%d", i);
 		fsl_edma->muxclk[i] =3D devm_clk_get(&pdev->dev, clkname);
 		if (IS_ERR(fsl_edma->muxclk[i])) {
 			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
+			/* on error: disable all previously enabled clks */
+			fsl_disable_clocks(fsl_edma, i);
 			return PTR_ERR(fsl_edma->muxclk[i]);
 		}
=20
 		ret =3D clk_prepare_enable(fsl_edma->muxclk[i]);
-		if (ret) {
-			/* disable only clks which were enabled on error */
-			for (; i >=3D 0; i--)
-				clk_disable_unprepare(fsl_edma->muxclk[i]);
-
-			dev_err(&pdev->dev, "DMAMUX clk block failed.\n");
-			return ret;
-		}
+		if (ret)
+			/* on error: disable all previously enabled clks */
+			fsl_disable_clocks(fsl_edma, i);
=20
 	}
=20
@@ -976,7 +976,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma);
+		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
 		return ret;
 	}
=20
@@ -985,7 +985,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma);
+		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
 		return ret;
 	}
=20
@@ -1015,7 +1015,7 @@ static int fsl_edma_remove(struct platform_device *pd=
ev)
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-	fsl_disable_clocks(fsl_edma);
+	fsl_disable_clocks(fsl_edma, DMAMUX_NR);
=20
 	return 0;
 }
--=20
2.11.0
