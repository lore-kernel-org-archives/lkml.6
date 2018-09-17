Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9D8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8FD208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KQdxTck+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8FD208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeIQIbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:13 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729672AbeIQIbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqJ08zdblMSPK6OgFkl8hkAPUVHziAdvs4N9iQ4Cz98=;
 b=KQdxTck+xAGm6eGzYsh3V04ruOdqNH6FieMOUIZLZ5K4pxG/Je0nvX6lpNvZRCV6p0GkyeOYFmpHwMt3C0AmvfaztnkQIQG6YZvir1rriOdT6NtLq4bVXzlXQzNXFzwkFbvdTY8TPPqeDCDC29+yoEoEyfruK/owTcSmIUOk65Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 32/57] media: s3c-camif: ignore -ENOIOCTLCMD from
 v4l2_subdev_call for s_power
Thread-Topic: [PATCH AUTOSEL 4.9 32/57] media: s3c-camif: ignore -ENOIOCTLCMD
 from v4l2_subdev_call for s_power
Thread-Index: AQHUTjMW82gASfsyK0K+6easIKK9Kg==
Date:   Mon, 17 Sep 2018 03:04:02 +0000
Message-ID: <20180917030340.378-32-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:Wgf0YtcX7dS7Apt5xpUiUcjhvoL2sZ03AxREOLiJIO5EygosFmB6DfcIvxvle1Di+4dtwt8kQvoCeWh52Xb/zdeAZbe/wKifVzkyg0cQ2zEZm9xCdXkB5fAIuH/UdVsEiftxyLLC/Ns7wNqep9WJDyshYn7MfVs4BgzZA9cgmPxDA2WgFLwyycXHzsyHUdo3pGhPy7lny0y9N4sVJebXgqOWJTrq8ouQC7pK6NFFMXgrOIuVWR9JVKEYFIhsXKYgRa9UD1UsZLuoFXtvjh1xvotGg48q7qL+DR1rQpUNeNWbQPW/1KyxOwkUQ1qJY6FGAPETbhB6Y5SI5y6kN0GknuFHYLjuqjtA6uf1wNOdSrezGo0fr/0a4QrEON4lloJ66r/6RmWyF+moG4rjCEiL98Or0+zM96xilzJ1foQhrRh38vfkqD7gpC02lPk3juo9kdFBaK5VlqN4Y2ZoeCc93w==;5:N0dN/Q61B5zY33Ef0qVsBJEi2lRtHQ1Ik56iMSNqSSiAyZFRwa0Dz1O4FlQerOGilqCbilAMEtUYzaNSn51MUROe9h+qrcoJBTixKU3rLYYwGMMjMf+DBLT8seK/bA/1tB9a/s/uzpQdTap/8qOalfTIk6Xw3V8wC68SUQK0Nh0=;7:Q2Z/K9k2hNswKGfOcFj7BHE8IvMS4XMVfErk9Z2Q9ucXS8ucIznveXFYnwUkAyiuiDd0WtSGeSBHUQOp2F7HJgL2nVKKHcNdELBlHNm//h+Mn74J46dt549JOYR9q684fw087VokcqX1FE6DwbTon/qaEul9fZCPlCMf2djzg3YE/Z03gNjl6s/mKI0w/5wC71QNC6jo/LXzSVBpjFPbStaN9p8Mv6pSNqDml0fDwN5B7+hnZQWA+awuZaxYR+pz
x-ms-office365-filtering-correlation-id: fd4e887f-7653-4d5a-27d4-08d61c4a777f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07573FF7642877866B3B2FCDFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(15760500003)(25786009)(6346003)(6666003)(5250100002)(39060400002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ntG2CnlU5PoC4eFTCAwjuHog0aMUbOVNoHDTmnXpgK54KI/73QFpgvu+2ATn1zo96SSJE2t4Ch+dIo1qIfbynOmRFVm/NlFbKcgW6Ce8MDSbwqS+Phv3m5uexBmThWp/IQ90Sdx0jX/U4kd7IdVM/+aiv9A1kd+xaIWDncf/mKtObkwoBSyA67DwE+qBYt92DDPNYLMYp0ofkkRksVyFesLCRCwQZ9bD6iLb1D5I+1JgDppM1lwe7+2e9N7IjLbn6OPgUDj9esY0kwFp8MfTIDxcr2hyoElWfHD+zVIoneRbeYGB7ID5WgbRBAhNXZRmvzATy0p7Zk/BFds4Og4qOnma79Z1RsnRW+qKMXjbQKs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4e887f-7653-4d5a-27d4-08d61c4a777f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:02.9147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 5c9db0910a76..d9710b5dd375 100644
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
