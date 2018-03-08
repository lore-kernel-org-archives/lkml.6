Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtAUORMrxAmGPIvYt6OcyGaioyzzIgU8qVEpij9dRv0uDnbhZu87hNXxHxjONhcBBVbkDwg
ARC-Seal: i=1; a=rsa-sha256; t=1520485147; cv=none;
        d=google.com; s=arc-20160816;
        b=RaJRgdh0Mh2JIphLmzYOd/wxtBQKRaa2zYaDddlaBYrbpprLjZrb1HaGG8vg7d9Gcs
         ZBxQ6suN3JiIKqx50gcHqHU+u9lz3PrDswAwll4QfkhZXDtTwQFlt3MzGlTfJMoZ4PEF
         EcYprSU24/e6RDh/a2PyjgD2pbvWjH1bmKbqmVUOEcH+vlxLjtojPj9RhWq8iYswl0of
         vEzxICfckohDRdOg0xgtLLHB6d8m5l0mubNgfTQQMGbnMFKm/G15goKJIlfbOp2DXQtD
         Kz1GjsfifSnV3xTyEBbLKymUZWs+EZLKBjVtNEiJDJ4879BO1+2+AIu9hKVcT2frFfqZ
         opvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=t0My6eCNx4Fop/4QYpq7twaSzB58j26I8bUKZn0TUII=;
        b=jn0kfy7mz3owIT1Ly5lfaltPK9Gskrx2TL1vKZxOloqUlXUqa5disO+omQECuIENs/
         Pbw6+zGe0cvFqUBteTXrSOaoX/zaguGPNE8wnyxdIZ/U+dup4cD4r6BvM8cjoVL0228C
         ahrNXFYdWxrRZtUtgUfYY9sTizTjhemX0atadpLxDVyXp+6IJ1KVrvBY+ks3fP6G4wTV
         PNBfVzepWqRiufKK6NdE/wfgm7XVwU+9bj3DKhN5fni6+tE740/jqvFqPECtB4+avmVo
         7SFKmIVCz6CuxOr8IJLLcSKBeFZfHcfQgT5lZeVVnbD9vixuTVU7i7huVNQ30q1wB784
         S9QA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LDPrjsSa;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.99 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LDPrjsSa;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.99 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Walker <robert.walker@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 45/67] coresight: Fix disabling of CoreSight
 TPIU
Thread-Topic: [PATCH AUTOSEL for 4.14 45/67] coresight: Fix disabling of
 CoreSight TPIU
Thread-Index: AQHTtpoCLfBW9vOLdkejNDY+6VcdnQ==
Date: Thu, 8 Mar 2018 04:57:51 +0000
Message-ID: <20180308045641.7814-45-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:+h8u6jchjqWp2By56I6iygDIPj4OCZDZB+tCDPaGiECAvrEaojJfgBml3uRsKCCpDJYRkLpEanH0q/auKUJrs06sQPAj5TJhALzSfVFMYmJ/rYtluStASXkCSuMBMXz+Foex0oWHWDSOdv2TRDZAPOJstTGXFg7l7xJCeHNrvobVN0CtrtJ070IXedYvRTEwLGruS91fDwkVIyGXVFI9+/2lrj+NH6Ks7qxbC5B8y5IWvg4epdJJtpSfzCSYxaIR;20:jN+tt8vVpaZIvn1ZI3qRiDPnjq3ojmLOrIPb+DpafM6FoRPGFdWiV+qe5FUzh2FNQW8w97yHq3HuKG+8c0W6yHPzNIrxUJzfxKLikhonFUJB3mo7spre71f4zN4ijrdaDnvJtyZ89nQtCHWQQEeHdmLmFxiitr5++dhxUrAbK5k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99620a20-bacb-4717-e430-08d584b14e8d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10153B851E9DC3CF7030DA8EFBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: vZtJ257VxRP3ukb8CrH2cR4sXowgn+rAo8WEcGPwPKTgUkRWLUB8wYzfhRg3g2U2ll67rtXgtZ0LWZrNy0fV1OrtxTHdrOhNVUAGTD3IOdGA5Io8UYKSgyNmBSnJanjqFeXpHLkKKInpvLViHm7sWtEPClAJgDHJ1jDLBoTusaGsNMoEnt6xCNhx++j0G9tn3MzDZrp0dcFw9Fdx6xweZSpNPkOnQxJQLzmYTmJ22anFthSOyCPv9i9hYf/88FuKRlrPnafntAEhm5U6W8BaJB30YY0xZZ7Ia6gVzHnAIrn6lyx5HlJLdWu780hTDc1IJUlPxwkdhxRNnsuQklT/0Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99620a20-bacb-4717-e430-08d584b14e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:51.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344116420518797?=
X-GMAIL-MSGID: =?utf-8?q?1594344233823200902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Walker <robert.walker@arm.com>

[ Upstream commit 11595db8e17faaa05fadc25746c870e31276962f ]

The CoreSight TPIU should be disabled when tracing to other sinks to allow
them to operate at full bandwidth.

This patch fixes tpiu_disable_hw() to correctly disable the TPIU by
configuring the TPIU to stop on flush, initiating a manual flush, waiting
for the flush to complete and then waits for the TPIU to indicate it has
stopped.

Signed-off-by: Robert Walker <robert.walker@arm.com>
Tested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtraci=
ng/coresight/coresight-tpiu.c
index d7a3e453016d..735dca089389 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -46,8 +46,11 @@
 #define TPIU_ITATBCTR0		0xef8
=20
 /** register definition **/
+/* FFSR - 0x300 */
+#define FFSR_FT_STOPPED		BIT(1)
 /* FFCR - 0x304 */
 #define FFCR_FON_MAN		BIT(6)
+#define FFCR_STOP_FI		BIT(12)
=20
 /**
  * @base:	memory mapped base address for this component.
@@ -85,10 +88,14 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdat=
a)
 {
 	CS_UNLOCK(drvdata->base);
=20
-	/* Clear formatter controle reg. */
-	writel_relaxed(0x0, drvdata->base + TPIU_FFCR);
+	/* Clear formatter and stop on flush */
+	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	/* Wait for flush to complete */
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	/* Wait for formatter to stop */
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
=20
 	CS_LOCK(drvdata->base);
 }
--=20
2.14.1
