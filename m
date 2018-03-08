Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuXOWY8ancIu9+LIzJeYyaJnI9azUI8AsNuyRfdccG5ONxKqDH7zg5OTlD7KOyHefWVUDa2
ARC-Seal: i=1; a=rsa-sha256; t=1520485035; cv=none;
        d=google.com; s=arc-20160816;
        b=ufr9RSCB9SsXbsm97AhkNrzwOtpZ/o3rX8dzuGcZAqf8YdljEViXaal8fGQ2Ou5mEW
         YOmbUSNGoa/1pZ4z1jDPQ0rwNGhHOKSdVUJW0Bu2DWtVhg/oV+VcL08ARIACTNHCQvny
         yDeuIiDGEnNH8nUF1QpZZZw6J/ExQoix9r3IgmHrqysM9NmwlO/u2XfXVkUPv5455/5D
         XwZ1JzE5KTUIR0sn+kDversBxOtpSBpfhPtpzf70SsNyAFC3mE1Pb5ZPSZ7fykpzRho8
         oJKX+ocHR7eOfmCLCITyFn3Uxp9/jR0+BV12+VRPN2JP07EBwqQWVwyghJATctOgmE85
         cioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=uZaRY5qwlrvKuJ4dpjMNRzMkezdzXo4P21hiJaVf1Pk=;
        b=UM2aaWmu2pxj8LGAq1lDADyPHd9r89PXbPXgD6SPzJIwSJzc/amdE7WJrUjDQODDDa
         bBEfRPH90yk7pfU0bKFCjO9KmtS/OMhwW9wIQohlV4mcKOEJybZqdw6zxAdq1iv/xLf0
         y6dsG1cVr+JhZb4GdlDfElcSm+1rVw772BXm5IjoLPbg+j8vzwEOXL3IkCFD7kTeRn65
         ZfjYLbWBxbyPN0KYuGXn91MqF8fLuE787TOW/t1gp4Bs8cy/6XOB1DxJMSYFvvVExnkO
         COoWnlefjSNOCxiOlPK8GLYU5T6bdmHlwjdv+faUvcw+c2qCwDjRS6XTqfTFhfQy7T4f
         a4MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=V0G5TuTW;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.96 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=V0G5TuTW;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.96 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Walker <robert.walker@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 52/78] coresight: Fix disabling of CoreSight
 TPIU
Thread-Topic: [PATCH AUTOSEL for 4.15 52/78] coresight: Fix disabling of
 CoreSight TPIU
Thread-Index: AQHTtpnP68bRYyHOv0OEW5BwkSUMDQ==
Date: Thu, 8 Mar 2018 04:56:24 +0000
Message-ID: <20180308045525.7662-52-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:3/pUsxF1T7BJLveZ30dlqX57qkOHzgSvNAdGLcoL7ipYPXraIXfcxaSTT7x1IfhGLHcoQ1m4VIQu67QhJdcUAe+Eyk5xV3wh8RpPyIvMNUzPF6r6w65UKRG+/iV2nAkd2Ca7IxVWXRPlkiDFGqKsnFm6RXwK+FHc/lvsHg2bAcBMl6vzLlKlClLgPMSg6AJgUSI3eQSWqe9jZ/9EM+9YcHv5ug2hI57xiy6Ritmfrza/fMFclPGmsa51L8UrRHGW;20:C8nMPe3z/iftpjk3drO23nUcjwlNO5hRz4k5FGM10KA/kZw43rUw8wOY/0ro1pevc+OPNyC8eU9Gef8mimeVa/pJIIVLOD3mnQN+E+NeeqXf6fP+2d4jx4IritO9ZLEcJEsOmy3OhybFcO7eVS9TAKXor3W5Ys5ssD1g02bl2X8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4dd64622-7ca3-44f9-3f11-08d584b10ef5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032E29AB1E76F53A9B5D8B0FBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(59450400001)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(316002)(107886003)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Rl/ytQc40w+Fh3FQheVpCU7e40Jt16AMaQ39HosIbwBXyuwzc/HpN17ysiM1vsOwI0KAXZinxjo9Q18PlCqmFHZYPoX9yRAwACurXzbF8wJboLJM7onNl6dPKYw6iIGSgLrr+uvwxgX3xjpEA0BFjPu2u2DPqsLrQD1lEUtraYkOtrifTrkwXXxHlYcKhKdNTk+aGJfAV0RUNq3hLg3TawFtTgqIeINEyV+ofzNP2DD1iZ/hIsPvJLtPaU6STH2Wj3iahjdLEjoGVrDQqdfUVc/7CS0SVrsQ+Sdo4zerhJx2VvJdiXMNXTGfDCKx12/gCeEePjmv282OyH3TbVX7Eg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd64622-7ca3-44f9-3f11-08d584b10ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:24.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344116420518797?=
X-GMAIL-MSGID: =?utf-8?q?1594344116420518797?=
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
index bef49a3a5ca7..4b46c494be5e 100644
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
