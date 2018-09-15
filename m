Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273AECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B521477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PTN+9sBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1B521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeIOGr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:56 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728551AbeIOGry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbjU2343dCr4tDhPmzN385sbz3r96xPzBawD6aX0ScU=;
 b=PTN+9sBuXCxtI4IXBAq6Y0r/lnv7rBNaKWbfvRs2l723uw/cgOd0HxvVUooKh1uxVWgBL8P1u7qdKt5kPu44Xs1IJPY/uS1sqCFA4kJmCCqppJQR66kJLdFzHxY5W5E7liim0syAiB44yyIQtRjCMXgTrB6PvvmVSKASF11wvCk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 49/92] coresight: ETM: Add support for Arm
 Cortex-A73 and Cortex-A35
Thread-Topic: [PATCH AUTOSEL 4.18 49/92] coresight: ETM: Add support for Arm
 Cortex-A73 and Cortex-A35
Thread-Index: AQHUTJOsp8GVeXx6fE+dlryqo2DM3g==
Date:   Sat, 15 Sep 2018 01:30:23 +0000
Message-ID: <20180915012944.179481-48-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:j5XtZrd3RQN7ZOLo6oTWdj4fZzGS0WWok+HXdf5TiWOVQsKc8DaEepSITMcVqFvN6Do75LdfT3Dpm2YFK1nJm5ywzEh9njM8B1CRKSStRBfjRrUNaMHnuQg0gbBNXyX2hfl8b5UD2au19OV7RyF5NubLXsVrflzx99Yz/kLTrQCCmZ1aAxolWg+dT0hsUj6smzjR4g1uKOiqPCrRase34O9EYbxi8cCeu+B/raLhGdb6sfLolbZ809h6QknG/Y/nB9bo805tx4wjVGp+zborhuEnKbYm3GCkeuIXDqlF3lAcaHdkIJ7pFoo8zpGL+ijQG5qu+hlYJtd/DEveS8JkItmo2v3we+pDj25VRDO8x3MKR0n31e2dKg2QKr+mm9SfdPqrU11IQBgBeztsynafgNkTCflILPVBikrvxho0w2ruoTwwy4hew8owDV4NN7GpZipFN/KQqWT5Dy66uuiavw==;5:S6Yw4W55Qf6H7G6anVrt90iBlhJ17eDLxzknMrIoM8HjJ9KpeNMxaaANkP6Nw+19sxIRjldEyMRHZDQyEq7Fs4PyCxL6o3LX0BEajpR3cSotX0Q3fvaoIrVUgrIXhQ9/3GabzIuP4gs3EGW57pHnNJBye5r8b9pLHpA6yZS0aDE=;7:3QLoohg+h4L3Sor2oazSVm1lXk6AB/Cz5O0UxWPPfxa1RBr3h/5OVgc+mJo1zOd7eZvRAABAO9H9Pf8EFD87ROwL8ZoJuSNvH6DjAriIyI5LskHKFK1h26/9T+juf9KKRCUVA39rE+/YOyy4XVH+ENn5vDOqbj8Je+cDjiGFyY5QTdF6AtpNeKKSqmHIXr/yzwYgGSgTjVKbYWUl5yc4Z/n7ZaW8mCY9ZeQBbffvtFHommWn6V8squIWwAkrJs5t
x-ms-office365-filtering-correlation-id: d38c6247-83fa-45b7-d855-08d61aaadeac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB0856F921D3E206A3FF868957FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mNexDmrI7qpxYvCcqnQC30LsiwxOqngtWFNREveF6j7cRgL49fmUULmpnLX5D6o3TIbYmn8/7FdRfMHbQu8NYY2j+JuRgCvJrsioqHKTv5HwK9KrawwsorLbGon9F4xtOHPgdBnFzpnEY0MoGkhO2C7/rW7KT4SctnNnk7JW7poA6R2Tl8PWdWTF1pceZuHiXuMT3VnrIYFidjBi0ozwwYkA3+Ogwg+2YwlcWQzWBusGM2py8XkXe8RyZkgb8HIv7NcXxFhVtbiB31Ia8xHpgpX9hUkuOwMh+GjS3ZT+Zg2L6v2lPVjPcatjd1PZRtdF07Rrmp0GBo1bgDrByCXdgfEHLwq2o7nlwhKBWn8tNig=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38c6247-83fa-45b7-d855-08d61aaadeac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:23.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 5cedd22370a0a460b663c06de1fc10b4ba3c5d0b ]

Add ETM PIDs of the Arm cortex-A CPUs to the white list of ETMs.
While at it add a helper macro to make it easier to add the new
entries.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtrac=
ing/coresight/coresight-etm4x.c
index 9bc04c50d45b..1d94ebec027b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1027,7 +1027,8 @@ static int etm4_probe(struct amba_device *adev, const=
 struct amba_id *id)
 	}
=20
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "CPU%d: ETM v%d.%d initialized\n",
+		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
=20
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1045,23 +1046,19 @@ err_arch_supported:
 	return ret;
 }
=20
+#define ETM4x_AMBA_ID(pid)			\
+	{					\
+		.id	=3D pid,			\
+		.mask	=3D 0x000fffff,		\
+	}
+
 static const struct amba_id etm4_ids[] =3D {
-	{       /* ETM 4.0 - Cortex-A53  */
-		.id	=3D 0x000bb95d,
-		.mask	=3D 0x000fffff,
-		.data	=3D "ETM 4.0",
-	},
-	{       /* ETM 4.0 - Cortex-A57 */
-		.id	=3D 0x000bb95e,
-		.mask	=3D 0x000fffff,
-		.data	=3D "ETM 4.0",
-	},
-	{       /* ETM 4.0 - A72, Maia, HiSilicon */
-		.id =3D 0x000bb95a,
-		.mask =3D 0x000fffff,
-		.data =3D "ETM 4.0",
-	},
-	{ 0, 0},
+	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
+	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
+	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
+	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
+	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	{},
 };
=20
 static struct amba_driver etm4x_driver =3D {
--=20
2.17.1
