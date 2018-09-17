Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB9ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84F420693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BVdYfsdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84F420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbeIQIiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:38:23 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:36220
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729624AbeIQIcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfKpVjv16edXamOgnf+sBjFigoTmPdQVyI5RvnqkvPk=;
 b=BVdYfsdSc6c3yZlOUxytw+7ufXh+8SBeq7CYp7yc9dAG2/r3nHsGDNWwo2RJFJ+/f6f2KFLuYbAzqqSMIsUcQikAFXnrxZdGWVPgaU+n6c4gGVCh5pGQ3PF0mXeIHQLdqXUhdAssBgoeInmOFzA6aMq4gDO1HghLlpBnZHJJbYk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 25/43] media: s3c-camif: ignore -ENOIOCTLCMD from
 v4l2_subdev_call for s_power
Thread-Topic: [PATCH AUTOSEL 4.4 25/43] media: s3c-camif: ignore -ENOIOCTLCMD
 from v4l2_subdev_call for s_power
Thread-Index: AQHUTjM7+cmfNyNUY0ap06cMKnVgzA==
Date:   Mon, 17 Sep 2018 03:05:04 +0000
Message-ID: <20180917030445.484-25-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:n5c5bsLkw8XuhyFh7DVEcMXhw/a+DiU9jBIpetULgSGs4GY82G0h2CPU2G6MX4xd8BL1ikjscboe5GOr+pWhUKWfrpW4NeVt6s4vv70GET0rVoGRB4owEZX6ZAW9mx3ocBC6twbcUD3YIVh94qq0rceknoLCRXbAxZrGsfz4IwgHGmug6ECpB5jemzaH46NrhDAmG6Jm/M08e+zrMrSOFbgMmqGLlZ/i6KFCyOPR1Cnup/JaP2pmy2nMgQISdGuX8cHyb4CD+T8P3lBVCFUWyKNTcHmTTJ8ZXC/LKZULxFctPjEoSkiIYIC2+3XKzlhI54G4tpuQkPSSBgZc6V3bKPDy1m/NvgYdY2fc1l4WoULba2mCZyIgO208d7xBnk/XheAT/3Cc4r424NhFKCBBp5j+a/5YIqlnNKVg6G1OMyi5zkCZrQ0ndPQfNvtSVJ2KY+RMpA3fVaZR6NHPUtKZnA==;5:kQKZlwcwA1X9wd2g5F7zbnnKiHmGErrrPH3ggNeekIK0FmnUZmd9D0HvdWd1ojRyWAsnlTg+sElbUlk6UDW3MDIL24jITb1DdrwOGCtT04iU8KbFL8Ekj5ehG335FN6WMrk5QeEeOzg2PCz6NC/YUyAuRfLcF1VV5wxbjOogySo=;7:VOjObDlv1e1QAPHZwzBUtN899SJENnlweLrWi3PKTYx4BImaLz+ON6X3sdkeFgoHy339KKUUw8mFLdhCqAWQL+ccHkAxFI1QIs0etZpPuvxzwiLsYLJahNYxH6WvVmNJG9ps2ZJIWE+O2BZpWNFl5UXD7cAjitKycXKkKgzG9+dKVBnjOFXatpJ5HdpzksLOEmVby8X3mbAsmZAPvk/XdmSgD8TFvl8KjhtzU4/M3bj1t/6ewAt3F+B4ZMHnHx0e
x-ms-office365-filtering-correlation-id: 76fd8446-1219-4e89-3500-08d61c4aa919
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07596550EBC2F0CE1AD768F3FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(15760500003)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3JdyUT6DtsfvDsNP6BQAB6wa5Q9000AdKxoGhv4y9a0N9Z5za1CAD7KnEKW8fkOHtHf4Mo19pPBW1BHU9KHl8zxX+GEobgMI3qUVPeQhG0NxVXA8X/AcJ0bPM+NdMnoSRpDsc/cGYi9Tt2fo//0+eBywYQTv/pviLAXBv27Mf6bD1Ift1WFc9isD772qkiglDJyG7Dcp+fxRFLW7LgOZBNWYxo+tIigtG6BcHcXE6Hptt5r+ea83yALcCtDJm+s7PWMIhF3dYSE9Vr6HbQ3/9MiwC0NNvJ7jZZ29Aj7skt/Kp20Y7n4C6s24QpPYlCocnUFCGHF2pLvWvnYkA7iwngET4SdsjlMPF8GXj38a390=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fd8446-1219-4e89-3500-08d61c4aa919
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:04.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 30ed2b83343bd1e07884ca7355dac70d25ffc158 ]

When the subdevice doesn't provide s_power core ops callback, the
v4l2_subdev_call for s_power returns -ENOIOCTLCMD.  If the subdevice
doesn't have the special handling for its power saving mode, the s_power
isn't required.  So -ENOIOCTLCMD from the v4l2_subdev_call should be
ignored.

Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/s3c-camif/camif-capture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/s3c-camif/camif-capture.c b/drivers/med=
ia/platform/s3c-camif/camif-capture.c
index fa6af4a7dae1..f97f4bc22ced 100644
--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -117,6 +117,8 @@ static int sensor_set_power(struct camif_dev *camif, in=
t on)
=20
 	if (camif->sensor.power_count =3D=3D !on)
 		err =3D v4l2_subdev_call(sensor->sd, core, s_power, on);
+	if (err =3D=3D -ENOIOCTLCMD)
+		err =3D 0;
 	if (!err)
 		sensor->power_count +=3D on ? 1 : -1;
=20
--=20
2.17.1
