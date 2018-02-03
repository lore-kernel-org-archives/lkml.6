Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682483-2-10486782416146819152
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
    t=1517682481; b=txcOSDLH/Fg5gn6svQgin+5AwZ8I7/9QdpXl/RAe62x0DJc
    6ccO0Dzh3vV3adbGYiIb+HqirBt76pYmsva4wvAx3HvHLKhiM7LkPYlm1K7vXi3h
    fDoIM8v9fBY4ZBnPB3leSJD+mc4oxRtyvrhJDAAE+rsFYMBPl/MVF5QdTOQXyxE+
    aXNX/dH1NrUmDxVuVEj5D5utjC38Xwxn3pyWri32rPJ7hDLLzJ+7xptZtz03pg6d
    kKpNJUlmhEVPSvo9cWYTcwfztgHjy69u57yaHIkjYsliXRmL8Rk3HIQkdzuMiKdd
    BS4/dXYb/84sqtVJjaYTihuOlmYkR4QkCmX+FUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1517682481; bh=/QW/Krh3nJ0Qc6Lzj66dusfxWp
    ESxCDof1hLZg4lJaU=; b=WDhSJngWR4bXC8LVuZ8n7gfrCcL9O5LTfYCAQN1rWv
    cyEgUkY9EnreU69zvKl+j+tC0YmN2TLeqNT2gjuTSDa36TooRjBqcA8QDzQ++iwq
    QoNq0f6o0df0QSnLeaOTsnvekj6s+q83qiiWJLVHmo0OTAt2B1rxG62g/3ABT9Oy
    07+0brFh5dzMpSZKfXDYYKzC2mSq4OinAsj25LE1VahiFjQqsvtLpKDCFPRND8lL
    WFNAk65Z7RYwEwnVK2MU63PNq38JV00O4aD2Z4pZEE9K1PvcHOxavZY1tuNEFGom
    Tn0F4GQm7ySFO1SdNHQrZAMlSSKERt2Kj7vayycEiDPA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MyVujG5D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MyVujG5D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeBCS1x (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:27:53 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752742AbeBCSFC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andreas Platschek <andreas.platschek@opentech.at>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 01/52] dmaengine: fsl-edma: disable clks on
 all error paths
Thread-Topic: [PATCH AUTOSEL for 4.9 01/52] dmaengine: fsl-edma: disable clks
 on all error paths
Thread-Index: AQHTnRlNTmMyFAvtHE+vmgL9C+QYPQ==
Date: Sat, 3 Feb 2018 18:03:32 +0000
Message-ID: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:yw2eeTGI3kjsR4zXZZYgrr/jiuvT92jFQSvDQyu5AQhaISO1icysKDa2dTMVvsnNI/g5g8XuMT1/YHahks7WQyA7O8iRA/RbCZ5kbLdvMqEa26yzDXYU+Rof7AqM2si9asBX8JMkp2S0pJq+iKpbt687hooGxZYq7/521UDIcS75DVu3ibW5GDzOVz8eaz31p4OrZtdDiKlI0NTwc7ZyBFB7ab7rkIOiNGcmFx2kqiMAjRO+1nJBkfQE7E56cK76
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99bd1746-6f04-4c70-6d36-08d56b307050
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993E1751CE7E762B90CD702FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(81156014)(86362001)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: dopPRudpCftUHrdQFZGhMouffjkA2AFPDXuHk61UU3QO4bQjwgrCzdsEQ1HM8ubgDpGk0SlWnOu3j8vqZlOLtA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bd1746-6f04-4c70-6d36-08d56b307050
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:32.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
