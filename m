Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB40ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3C4208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GBwKlsKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3C4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeIQIx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:53:56 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:15894
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729566AbeIQI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQOG4CUJpTaGgWQDXjKK7/ikEJgiwjWjoT1qSuLfLAM=;
 b=GBwKlsKls3OEtZx+4W6ITOB+ikbwjJRYJAdr5JMYoUUn6qi2hwaL5TxWtilipjJeacMcuPcK3deyoLVRL147GDAqiQ6Hxgskf1PfBgr7Q5bZcPAI0EMc7nXYjOv1O2B9jiokmpJJ2B4+IfzOnC01uoaQUBibrekwToDIHrpqylo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 113/136] scsi: megaraid_sas: Update controller
 info during resume
Thread-Topic: [PATCH AUTOSEL 4.18 113/136] scsi: megaraid_sas: Update
 controller info during resume
Thread-Index: AQHUTjK3McOfhXm6fkGerDYBccu4Fg==
Date:   Mon, 17 Sep 2018 03:01:23 +0000
Message-ID: <20180917030006.245495-113-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:+OoI0hpGkeSwBDcke9tf0F5jXt5hN80HnZpOaS40L1NwDv8bTTZb5iI9n/fKWt4DcM/Co4uDyzlyFPnHCLIYDssJPNl6pYz4jyfhHs7S8u/DJ2+ECRoeo85x00MR/Ign5EM2/v1qsAfF6efTGLylkrPs2YS6ofw9Gl3EcB+QSecU3hCJaJhPWvofEZkxM1Zu//0IRwUgojl6aPf45DwdghEKIovg7hCTW02p9VRDzytYW/pOGor2R22D74FJ/JrSltSXfGp0GPZzz+y/XSLqO3TpA9/FO6AR/nHzQCrZ1nhIYEsRszJrlcteFsu8bJ/Bn+UXq8PG9tu/bIU1QC3UZOwoetPVFDpRNr7KentL66G3n++3Z9Z253epA1vSyhePQi7kFr2bdQS3WN5PE88nbBeaDJWh6ymzpLJdohpdMZ8yc+lvMw4vyZRe3EPIQrm61/QGwXsLJWD9gDHx4N8Egw==;5:N57c1a98d/lGglZXPpR7AuM/IJpamYhrGAcMgvZOYBpgJBPnJssM5e5tIgcYNOKIaFCusuI4y3ZZNBAIsPhdhSZCJAARV7TkxJGFwuIeonhbpE0TK5ZUAj38Wcp+3qx82xrXUkXz6CYK8ll0z1WsZtX2IF5irz1oisAHJzA1B8Q=;7:MKL9hxvuXfB17TYVq6DUkDLNIGfANdtbbVmh7HgtO0UKEKlw1cZXiM45ofHi1bYRNudgw7dBjP6pFA7qhz69KS+tcHAHC/1001zig2aY7lJKDbIr5z9Tjmcyi+KH0d2/qR4CA1RVUNzvk47VQIuwfnzOfnbyebJrWy0VFwq39za37CIu56j8+MOkCofsqDK5ckIciM698kd8FgZZDMgIX5Q4N5eGB8VsnbiX63yYnWICoFqi7Oqu3Vjwl7xqwwbJ
x-ms-office365-filtering-correlation-id: 780eab23-7954-4f09-c1ae-08d61c4a0b30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168A6A3A660634753EBDA4CFB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(15650500001)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: VudDYE3cPTwGcaYwTluRGlibNGGoyfR1f+9hRwteaugPODbTBzLjgTx0+JD4mtOt+6KM1jGVzZjOO/oFqdo+macWMk1TRgINeaX0Q12A3CW78SU1DNKf5LdcXGWTm4jUkCB+JrTdqnHDUEDds6kTQ1lPAJeeAt30LKR6hVa9xkXAo/lahsdmCXQjfdiiaD15YFOn3vgp60gS5U+ojp3hRgFNF3V5ud4aPK3IKXDl42gP0NPeim6IHqWPTPVC5WlwuKKKaHWTSPYZjRkIE6pEQrs88RQVRuXtJ9yIdScZ+dGvveNZPSyGlQr9jOq4GMm09C9H56i790weSxH0Wsg39symBPB7gX5MOqZk68TXUwM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780eab23-7954-4f09-c1ae-08d61c4a0b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:23.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit c3b10a55abc943a526aaecd7e860b15671beb906 ]

There is a possibility that firmware on the controller was upgraded before
system was suspended. During resume, driver needs to read updated
controller properties.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megar=
aid/megaraid_sas_base.c
index 71d97573a667..8e84e3fb648a 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6789,6 +6789,9 @@ megasas_resume(struct pci_dev *pdev)
 			goto fail_init_mfi;
 	}
=20
+	if (megasas_get_ctrl_info(instance) !=3D DCMD_SUCCESS)
+		goto fail_init_mfi;
+
 	tasklet_init(&instance->isr_tasklet, instance->instancet->tasklet,
 		     (unsigned long)instance);
=20
--=20
2.17.1
