Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuwU8ddFSa4sAnstduTJQCwyyCZQF4FvHOVmSHZa/NHQQA7GO3lelI7ie9Z/uI3w9NsmzgH
ARC-Seal: i=1; a=rsa-sha256; t=1520485675; cv=none;
        d=google.com; s=arc-20160816;
        b=ZAtHNQczTvR5aCgsF5KT/vYHYGi3D5Ef1bhyjVBbQWSAIFrhGk8hhjAkvVbAVJ45Wb
         LrEdeo690I4ei6kb6EtNIS11uAnQbIEv2B6EancSfoePnBMGphshmn1qI1lvvclKUUIm
         EYWTbd4emCIT77kWfibpsJBaEsae65g1Kz2I3gQ+vSEPNXp0sI7g3o1ynVCmSUyrKtiL
         EN+z2QUZq+UlZ3Cl2WmgN5+YdD1+/nNGNZFGkPdkLlkMzgUpKYzMdSllpc67HNWnIZlc
         5KRnSw4ttRS6DUUlkm06DOVgQdl9p6I2GkA2GQ16dXWrrPSGWFTxQ0dmSPG/U2IEhdDR
         PJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=R9PilM/NVDyF5uYrfGIUYe1VI4V85BpYNZQKYX2iQGk=;
        b=iy5BT26/4Pjffn0RJJmjyE3/7CP25tByvZJZR881Lcn7TOhmALfAK95YBlGG642MQm
         GDdtg+Kobe+J2N0jlkuAmAxaUd1/kvweKmK25gXligJ5jm2+Dd8N3QpA7fw/O1g9RhEH
         ICLW4KG8MGiq5gdy13encvn0kZkt9GT0TwCP1ZcWHsVUbx7s3fgqKx2ZrxBnzC5v3mFI
         06h3ulOL8aHUktO4tQsqpC/qz9N5lko6BfiPi1ev1pijCulr9HU0Iu0aDmq5awZ2oalP
         TQWw+ATi54UHH8JTSKo24MCXHPo9mEF5XnvESrRLKba6x1X0qtVFSwvjHu1PWjquOGf4
         wkog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LGQovbrG;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.139 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LGQovbrG;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.139 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Walker <robert.walker@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 094/101] coresight: Fix disabling of CoreSight
 TPIU
Thread-Topic: [PATCH AUTOSEL for 4.4 094/101] coresight: Fix disabling of
 CoreSight TPIU
Thread-Index: AQHTtpqfaHrGDIowtEiaoHcFeE2yaQ==
Date: Thu, 8 Mar 2018 05:02:14 +0000
Message-ID: <20180308050023.8548-94-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:a+zLf68FbNpAP1c8p/MHrUBLYNCm2MCR1ETC3hQgxbUnBUvbTsXd+jod2ui68Zl2NNOCcF7e5JgH6q2amzp8xUPD0BzDLBD7R6DcaUzuGDTOAvYBKpgSHiJR0SaQJujKSncwjWFuM8+8Y526ZXhgVj00KKIqOViT584v5Ru6NSDfZJURkRr51AcIvHrmRyoBFy/4j76t8101zaFjQ7PaWcOBolVey4/Mh6NgfFUkHvtasq7s6kUA0UyR3VHlrv5A;20:onkWLxwHvAYPpYG5y0TztbivR2wM4NTG3DaGsMIb1epxhoVf4kWLVCzovcToQjOghrP8xla3hcFiji920JgIh3O2DNTYRrDYBi4VjryQn9vBrHzSDH8EdcnnFTya6MAvUZ/fy0XoFc5Rbwvray+HbVFfqAysz5eT/8kJilw9W4w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9da857b-f713-48bc-1772-08d584b28c68
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07277DD983778A93614C7864FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jedPeTTrybJ9hLRLBF2DlEBPy8eoebmOTL9Bk7nFCTP7FnABsFgi2Wp9eHLeVWHoOf3IS55JHXz2op2zthlo9XJfJzBUAUScc9rE0OsbYlpAbiugi/PFgeEn+VuztCy/IAvbSIBTUKGxmsn9dkTai31AADPkj1zbqRfWwx2OXUe8MTc5FHpTRCZ6vuJs+7yCJJfX3T5mtPtgZfz6zfgUK83yvRLt0R4EgrYdfIARiMpz4dFt3O8RpY6rVj7LLES5Oc2U7OEbVpTvG+HsbXjJ7gsVFvOTpPRFbT2BgYRRHENWs1lTx/KIwHEa0NKe9p5c3MYUr8UdyxRUmOnJwVsU7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9da857b-f713-48bc-1772-08d584b28c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:14.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344116420518797?=
X-GMAIL-MSGID: =?utf-8?q?1594344787973024598?=
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
index 7214efd10db5..22e10b7d505d 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -45,8 +45,11 @@
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
