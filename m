Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C3C26649
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05BF2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p2p5I9+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfATRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:40:13 -0500
Received: from mail-eopbgr680083.outbound.protection.outlook.com ([40.107.68.83]:12928
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfATRkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74kgdItjdXT9dAelFbA7kgiLe+EDA8JgSt+NXozKRUU=;
 b=p2p5I9+ODfHYc86vBRMeo7w7/6T6L5EUxIEcgkapPS0Q9ZNWrFAVnYU4A3oRkOasuIp88AwDiXypA4OV30QzUHDz0fE/6dneEQ7h46MKATdfYmiRd3qKiOm0PVCKSQEZP5r2gBdLqoUM0PmCkiK69jGGwU4tBwqWGxW6taL+SGw=
Received: from SN4PR0201CA0001.namprd02.prod.outlook.com
 (2603:10b6:803:2b::11) by MWHPR0201MB3513.namprd02.prod.outlook.com
 (2603:10b6:301:77::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27; Sun, 20 Jan
 2019 17:39:54 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN4PR0201CA0001.outlook.office365.com
 (2603:10b6:803:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.24 via Frontend
 Transport; Sun, 20 Jan 2019 17:39:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:39:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4b-0005Y1-Aw; Sun, 20 Jan 2019 09:39:53 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4W-0002us-6x; Sun, 20 Jan 2019 09:39:48 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHde2E027279;
        Sun, 20 Jan 2019 09:39:40 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4N-0002tH-PV; Sun, 20 Jan 2019 09:39:40 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>,
        <robh+dt@kernel.org>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 2/6] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Mon, 21 Jan 2019 23:08:31 +0530
Message-ID: <20190121173835.21173-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121173835.21173-1-nava.manne@xilinx.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(39830400003)(396003)(346002)(2980300002)(199004)(189003)(36386004)(36756003)(7696005)(6666004)(356004)(8936002)(50226002)(336012)(426003)(1076003)(9786002)(186003)(77096007)(446003)(26005)(76176011)(4326008)(476003)(11346002)(478600001)(51416003)(486006)(107886003)(126002)(2616005)(39060400002)(63266004)(50466002)(2906002)(106002)(110136005)(2201001)(54906003)(16586007)(14444005)(47776003)(8676002)(81156014)(305945005)(48376002)(81166006)(106466001)(316002)(107986001)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3513;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT054;1:4UXy6eKfcfIbGYC0Urd8k+y/pIeT3xqG61Xsfyb8A3nFrCVKNY0UVPXsw1b6V8JWFdH0VqgE1PHhZhrDD0/r97R5T/eb/ZppYkSS807+hi4WpucIcRpsC/h9y/cSgoU6nFFVFnbp+1VyKgONqd5CMYHoOipPnw6W6f4zA0cWKlo=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99ae059d-70c2-4bef-2bde-08d67efe49a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;3:f8lok3vd8QrI/jeBT3Js7lVJV7oZd/l1uqQw2MlR6MHQdYfhy96GwQ8kupdJkIkI/sMQ0GfXbScX0nAja426CNTny8eRM2KefIzCU12yy/WPrx3jrw1RYgcn5krmv7TimZXemvyKuRwt0DVwwettkB6io5cMJv2JqaVUIaIZKoPdhAIlP+QB/o9ICJ4xTcJF3SyW9A9RCujB5i0Q5TfW2OSDw6BzQ0hixAvtSuqNirovbVBV/eXmYd8PnSnw6klJwbuh2mjctvn4ASL3euGK8RaVr8xEZDwbWxapgEA5jjc5RqNwRDFD8dC/5+++uVXGnnd7AyIK93IJh8MuvkNO5gnENvVCCmGvaZYSMLNVRdQ9bXYi1wg2867siDzg/rTR;25:lssU0w1PP2AHEOLhK61YGcUskL5XvTaKsDndSRH96Db1J4k4OXTApq42KN7wpEB6hDxJRpRyfbmXIMcCfXB5nTnZB8bzVaOPhEHdz9JBS3cnHonqv7RTl0o5IU+GbDr529janU+HC4RfIqY9ORlAciIY4hHXBiqMq4wl0ei5bTxJ23D9QGBbsZcEj83XHACCeCzaCZkQbUEqjV6Nd7nPu9w/Gz4Dwh0irhJl1O2DU6uxI5Aw2rht9JvGaIPCKBpmQMpuKxZQXPDo9WZYnrRF1PDaon3C8hGwL6B4j0BBsn4jCVC+rHgCt7ydAc4FrzmM1GcTjWW/DW38UbCWNq9Xxg==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3513:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;31:YOBRCAy+Z8S+qJnjHSd2IbagXoDcA1HSQ+vfPlP4dfT4PY7wqfCw48G50oVGsn7UxbLX9Sjr7+sF6g5tr/hAva/Oc03qnYnTVxVUp+TqCOrUajp2wNuvCqhWu38tJdGDEY9z0Vq3dGy6mTdtQXhObeKPXmXvcpq2IHTPIgDnMeDxoN+2OobjQvS+tgC6GPl/04uRs1m4kCzXpkGFbjJOa7lQd8LmZ9toMPHr6FttNKY=;20:8FFg1pdXxbXMsDHqDDZzfUjJUhG+gYMPNzm6v3CjfM4ZUnHuM2GFaQiXIDlGTGpRVFUsHw+jWeiDfWxh+jv0nbwdwzZzl7a6NMlkAO4lAbmkpXooXoS+jVuC/Q+rzbr8NvCoe9UUv8HBNsXZ9+lQmpNMRW++yey762RtQ+N5OaO4bLEOQFTVyQz4l/vvxR0w2YD3jBioxlMkGak8i3PB8ZlTHBDfBMstGmXP5BLiKnabw9YrmVHsFlyWOSudWW4ZLQxZLy7ITwwDDYm3GhsSir7dTTfk8U9oFDxT1Csf8N43/4HERemZynFMGRxfp2W2g06tP60rHIU/7a/i5toEWOf7w5vmjMr8OhWXRwcxQhj5Jq+lsqF4X0cjumaEvuteoBWgHm0RyK449CfzpEwnYdnZ+WNt8nAMJHmcm/3fSLsBr8tz/iwmXxWz43lHeMH2Fu/t/JfyVWKYP+7Cg+pAprvKPGVUQ+/MEPd2waga3hmFPjRNQxU/ekbFqeshRtKL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35135F0459E18C4ABE38FE32C29E0@MWHPR0201MB3513.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;4:2gzB6u/0z2wLpG1ejx5EOmEu3+ePJPDGHFh+RUDTOJNzP16bY4ogxvqKG7Zpc/7J+v2fnsryB4gBT8WcAxGmlDdrLdUHkxn7Df4wuhzbgJOJ+qyZ7i9aaeWXh0wZU4Kze2a9lzwts9etwx8+nph9F3l5ANhhBAivwUMKf1SyY7860EnH/shPDRsp+BLf8dZz5AjHYhh18MWj2UrbPqQ+1CYZMn2k2oXIA9GSSnijWqCjiCswD9MJf7BKd5NvTc/GtI1/4GbvldrpmOP4QtOk4AsXR3ky1BU5sSBna+QWiC2nAVsI/but4VkECg2ERdJO
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3513;23:W2to0rte70Rmf6FOP9TQb4liCx82yIigo68eTgB?=
 =?us-ascii?Q?6hmOJDPPbCAWJX99mV+5j4oLVdn/ijFpVOFuqIN5sz78SB4L3csDlmPmu8Y2?=
 =?us-ascii?Q?L5GVR3bMZhaV08xAP02Y3oyw+fJOb3iZ+As6ZKq07nGQR/jr7s3D2T+QcZew?=
 =?us-ascii?Q?d+8XbCWmu8Mb/2N0V9D7QrQ8kWMqtGQOzJ2Ur+QRHpivl25rrdFrZzXYTe9R?=
 =?us-ascii?Q?Lo6EsQ4xIFNDDnffrUsCC/3pNWQSDshR0TF/e4SB74+YS9CCaDrh5Ipoy7hx?=
 =?us-ascii?Q?5eGGJFsKXrLqNt0jaLaH/LLuwa+G0iHBnpfWJXbLM4eSXm7hKoM9i1HZXXim?=
 =?us-ascii?Q?CSNo+NiPneqzCtIHeHfl+sQgUWgH+F6Zm3D1ml32y0QaTvLgv7EEZKTWZtL3?=
 =?us-ascii?Q?P9xOhmHbGN/2c7nYZmB8mieGSePXVtB1w46WrTikf31qiHqzTzUC5vqhByXe?=
 =?us-ascii?Q?wN/uiOMamcA9GGebHk2m//5PRJAionpd52pwnHUVHuDak32sLhnrwfb+2DLK?=
 =?us-ascii?Q?7DrAknaRaSBn6nXe5vWmvOJw2+ZsGKLOOlc1BrEOru/ZWNFg9ecdqzkVaWqP?=
 =?us-ascii?Q?gnR4ecUPFsyIcSNydu8YXWer3E4PF3NBU3h4kbvwKzik7OrPuSstjekEZoIl?=
 =?us-ascii?Q?DyDGexuh3WhhbxTfygH1sipowNRE6Qoxur6WFrJGunx+vNPseKjnX4gncroW?=
 =?us-ascii?Q?u1LH5cl0TbA/0DeCpyJiJrg1Gy/alv5QOPQz8Y5MXyd2XK+0lxBvdsH5USTZ?=
 =?us-ascii?Q?Mz4fnvDemG+TCcf0KpPgp91SaARzN9VpTe591lXWAtdiZ5dmiZlYz22QuZkx?=
 =?us-ascii?Q?ZtCmju0kw6CnqwxWs2D59bNbGjOHXA3TJymJNuBePY0EHgKrqRTnDy4NZbE1?=
 =?us-ascii?Q?kl1KaEceyEJSmrjqPTExDegwWujNstfFRKWj5r3+/s2flCrCF14eeMk5H0Hn?=
 =?us-ascii?Q?9VM5lV89aLcw+TR15uaGJL8jZWNrZViyI35dgVKNZsud4NJg1LWdCy/zykIQ?=
 =?us-ascii?Q?5p+ZrHN1dngthNMhMJcTZhhhOb2zkseasZzNsSsoi6S4KfsAErKcxB2GaFIp?=
 =?us-ascii?Q?3UYVTckst5ZsXqt562U3jKgoic+s5LhGu98Z4VhxUm+zIEgD3W/97MOJKEsd?=
 =?us-ascii?Q?zO1ft0LPuugAVCeh8kjIAV3MsyM5XpdGC+xNXw9cozEwcbnO9p78eWy94gPf?=
 =?us-ascii?Q?c0W67qZ+gua8O4JtBGyY4Ti9G5uGerosZQTUnwTLl6b6uGmy4p+BZrs4xsnF?=
 =?us-ascii?Q?uNBSX9bRIcPK3rbISRJMZdWgOvibqZiAkWrx/aiyG?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: w98ycJN5WVVXziYdhmM3tU7qu0UrZHtaqAsHrGqgTp9B0JaLgwCgDcY85rqSJCxn4WTLm318HHN92dgm6yIFvyeG/YsI2QqFxvOfEKPtoyRFsw46upb5BqNM1DY9ibqsLo+C/phgkDbvz9QCslyhmeKn4VqnRqb0/eHY3A2jzCw6dFRE8dOMQnjcfLLidPGXB8mqRI439VWq1TMgRcl5+AdkAT70Q174hseeyQWMoC8xVr4d0I+rN8OY6PC8u4RA6LBDthgrU6f2G4d21Or0ILGY3cVHSr5hkBdez703jjIwMeEDVc+cY8ciyRa0sUO3A1QVInY/pZ6OHiMPxoMvlX3QRm82Yg2yXMC3g9/+uqBizyhM1JSTfwDcI3e6gD24Z2PIoJAiJpJmmHcY16eoEF4EEoNByqzLowPigsJ2pFg=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;6:oV6QskeQw+drM4opGPEAWLu+rLSByzOjm8YdOGjiRQpIRxogiaOWt5tvLBYovNgW+fJIIMwtEq0gbWaE4cg6MW8jlR3h+vjZlNwLvAl/euvnhb8SUBlESQTnfD4r/7yUe2f7eKVwjb1FVdUyoqhUyMWuus6F1NkGwpYPjVuhV2HbBxNaRa+IfWRhF72ep5ZfXHthXmUxZJ+mRpKx6jWxvcCVzjN3oTglEm2WOEqDYBUSqNsBhL3rteJ0PGIJAIQtN1NdpszelAje+yS0MD/zd1mIz5eAlYrss20Fgqewi2XaWEKHNClwgfhhiIm/bWV9GCF+GpoiBuILV1ytd54SKhMf9hwzr0ebcB253tntikyynIsKgKLv2gbPH4NTUtjCLYUxjHjk9by/CwwgNMw8o8v727qVuTU4RsV4wPRqe45zCezw+FPEoTaBDi4jsVcZN224+DR+UnxyzbPpmWa3gQ==;5:yvJ/ebXc4+IoGo6lJSSysHOoWzkxLyz0ah4+brAGkDGKlNCk6JrRKllv1ViKQfSFvBI2IR1kTs0Q8l3H02iamJ2Iznsg9olMUVFfRNA4yBhHeRBoAP2Kdv939nJdyGgX2kQjebXz9oCHp/uIL11eaGxeBQTrhIBMe+eIQLLY2hizcioWNeV+LrbqgJyAHrFq0B4kVQHXlkR6vleIIRUzkQ==;7:y3dRVl9zzvAAkvpTitGKDUEtJjiQhveLmE078MInbR8Yo3kHMtjR2J5VPbJ+nJKfb04f0m86YmL+DE8NHdJay+1i6XAKWurQbtzlB+c2ygD5aD60sW/5ZBKnMIPXIHWc2HClPN0fnez59DO7YfbVSg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:39:53.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ae059d-70c2-4bef-2bde-08d67efe49a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
		-None.

 .../power/reset/xlnx,zynqmp-power.txt         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 000000000000..d366f1eb623a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,25 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.18.0

