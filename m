Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0582DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568920869
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iYnQuw7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A568920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeIBRTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:14 -0400
Received: from mail-cys01nam02on0091.outbound.protection.outlook.com ([104.47.37.91]:41829
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbeIBRTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhwN0L+QudgAXvelX6QrYDdK6OZZJQCaMJTcWThwtK0=;
 b=iYnQuw7fwpUncF8UOEW4fNoXhjG2vmtl88xtawLvasqXtAL32cNLzPU55cIGuxRJ0XbTFlNq8KpFS00at5ZpOAKttO3GxESs9aqt9mvWxM+lDiSUnsAm8laxHMNY2aruSOZ8LSagnPpelS0CF2Y4fbk3wa7UdOAJDGmhVm/CrOc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 018/131] scsi: qla2xxx: Silent erroneous message
Thread-Topic: [PATCH AUTOSEL 4.18 018/131] scsi: qla2xxx: Silent erroneous
 message
Thread-Index: AQHUQr1Tn23J/rKuE0i0FH8B9G5jgQ==
Date:   Sun, 2 Sep 2018 13:03:21 +0000
Message-ID: <20180902064601.183036-18-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:o2Z5f6xq2Up+pyVO4zcYsXf4PuJWuacAKvkl5Zh06to0JD9fnOdEgNWpfex6LbCVJ3gav1g5ElOKVCm7Xe67s3vIDgezuPcdeKXV/RkjoYQr4S6Lrhx3ZkfaMHvJ77ANE/nQqnoITTqZeue3/1fF27vV7O98In5PrTVjJd/qpCLMftcPESm2yMnfsB9fPkY095LI5XXZDPmxyBFatR/Yw3Q7aaQ8S94WVjJ3gzqXYqPilMTB3PoHWeaEBbYntVDrsDK86Z9HdFrje8F5xnJXlkko1iMKt8TGH69zHbqyVkO0j3dotK7L8Obllnpafmhvlh92uA9EPPZffomxJTxTOkaYI0yAmn5vmMsb7nMhpucBSIDqfVh4cjpVJ1b9/rm3bVmGnG4Ko8hTqVG3Hy5P03nrRX5iNHRUPOT0ErEbBWwARcgrN1vK7u6dOSiDEmlrdxHri5gN/5rKYg4EQXh0Ow==;5:5ayXwsmDIEYcZnFIqh1VilQ9A7FzSfzx+2vGC0+THhqT1l3lYEAfUvL7XTrkj4tQ6QQiqcAfnf7KdWzVJWqwhJkBvnWLRi3eYgW4duu1hh+iRhEu3WafvgfyYaaV4k6YDX+LhWLj/g1WecbwofNG9sPkOHDs84xkv4JhoFgC2Xo=;7:1aPdICL4mvtu+ZYJwWX71xvSMsCbNCXASG2JFdlcChniwW7cwBZAoQOJGBUA78Wd9SgvWWW4u80EHcqk708J9/Am12qqZoHnJWIIln1KchfrvfUs0YsV1eKxPGXpljgpzlWQT+rUYrHw+wXBSAN7O3+ytteyt0VLEIkNQ+95JvEHOVtxua5mnzejruTI0YNJ5o9ZDn3EAlLIe71rH8krQNgFYVuXaNCtthS5A82B83JCaLT4TE6K0QIqAoxMew41
x-ms-office365-filtering-correlation-id: 2fb3c234-289b-4daf-56d8-08d610d475c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150E3122971C05C8A17C55AFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(15650500001)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(575784001)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bopEhZ7UWL2/O5FINVjCWouO3srqBcdH+Y0SDM2TGR4lpgeGxKDwSntHoxB6z/pksWHYLEfRof71ofF7WxqJNNZ1YFtWdnVJpq+Z5X80ZckAAfFLSoYVRaiGqYsBjv6VPdpd/4VSNFUNGF+Lp4enB7siKtPaGSp1C16S5Ycaz6QuuWUZakcGyk2aM3xPYafxVwLsWBxsY+5luCy+/I0F09hNZoUofxUVaF0+UUwrX57eSK6ZytjN8LgfSBjetamFfSVNL7ps/fyQJRK0Lpvu5Z83/dIbezsN4d4sx5om0synQ/AxIC5TrH2+7nPWGS7FfHgR5LcQjKiYWCa0oeUsVVaruJlaxmhPVZ5uiXSxE1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb3c234-289b-4daf-56d8-08d610d475c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:21.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 3f915271b12e11183c606bed1c3dfff0983662d3 ]

Driver uses shadow pointer instead of Mirror pointer for firmware dump
collection. Skip those entries for Mirror pointers for Request/Response
queue from firmware dump template reading.

Following messages are printed in log messages:

 qla27xx_fwdt_entry_t268: unknown buffer 4
 qla27xx_fwdt_entry_t268: unknown buffer 5

This patch fixes these error messages by adding skip_entry() to not read
them from template.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qla2xxx/qla_tmpl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmp=
l.c
index 731ca0d8520a..9f3c263756a8 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -571,6 +571,15 @@ qla27xx_fwdt_entry_t268(struct scsi_qla_host *vha,
 		}
 		break;
=20
+	case T268_BUF_TYPE_REQ_MIRROR:
+	case T268_BUF_TYPE_RSP_MIRROR:
+		/*
+		 * Mirror pointers are not implemented in the
+		 * driver, instead shadow pointers are used by
+		 * the drier. Skip these entries.
+		 */
+		qla27xx_skip_entry(ent, buf);
+		break;
 	default:
 		ql_dbg(ql_dbg_async, vha, 0xd02b,
 		    "%s: unknown buffer %x\n", __func__, ent->t268.buf_type);
--=20
2.17.1
