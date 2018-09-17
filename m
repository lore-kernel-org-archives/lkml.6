Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E6ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94B12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cgm5EBJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94B12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeIQI5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:57:54 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbeIQI1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEYCAvxOMEe0MFGI3/BNGy2sA5MFdKVskTu1PAfq1Lc=;
 b=cgm5EBJqr7HQION42QH5CjG3SBvoS3LgZk73legJltznPJv3vGBzatWd+IFM76ONINWsxIDfjR2phxi2PS4HrxnZPBi6tfWCuLiCstXq0mjG/2Au0D2DpSMyWyHkly0sjRLtCviuR7jyQ2lWjhYb7Qy0RkP88GsLmb4zUt/tir8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 071/136] media: s3c-camif: ignore -ENOIOCTLCMD
 from v4l2_subdev_call for s_power
Thread-Topic: [PATCH AUTOSEL 4.18 071/136] media: s3c-camif: ignore
 -ENOIOCTLCMD from v4l2_subdev_call for s_power
Thread-Index: AQHUTjKnzt5XXxR5XEWOzlRXJWhEDg==
Date:   Mon, 17 Sep 2018 03:00:56 +0000
Message-ID: <20180917030006.245495-71-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:gPeAxQQyNSrYqf+Xx+Yiu1OvDAHbAaBX8mJf4XSqsDjxKEMYZRzgqALgSi7BXJ3wDUBpWylHSb+ur/HFd5iYq7HTnhyZwy7UDamVG1V+c/Wixnk72ClglqO2S6C/j4/GaLuzwmVoNa2fRpAAOw3WTfoUBOr4xSS5dY4GHOObzzzUZmE9WOpWCBHupSRB2MQPfzy7PCX2xOXH4cxxwr7YmNJc6ISFTBHtKZ4KYFo04SRn/OGrIMRW6m6AsrB8PjJTXApykaYgBu19Y57ECjwvE4s57FIv/s11KPhv/lhPGXE7I7qdAIO1TlsOhbf87L07gl14SeOTlY+XDLBNrCy6mAAd634Ec1/b1EuSlQIgY6XjFFG7Zyw6gCC0XOATeCQfJ6wNGimehXo3rMmavFCK3u8o30bHTUEMOtWMij2E35dD98JB04lqarN946r67Cj4XjOuRo1yFlVBTWcFpQGWrg==;5:wpxnKZS0n0YgPnpqq9mfanuEwNbtY2cRfMP056eUmH43YPJdmCjNdErp0oT1RkdxfkIQedtKzrc4/qwqlToxVKnyDojdPwwSHXctfIbqV8tRLSDpqAc+MmZSV8qlIHwXbFUHGFDYGqL8UaFSN9d0HFhyc8SdgQlwfTtyRLvdBJU=;7:ioNVthVqYjURGfei/kgVF/QHD8Wa3g9Hyy9gHMO8IADdVMPlg9v/YaDu8JbvW1CG/3Na7olrdytOxiNSdKz/2ZX4+xhBO9dsaJYpP+1gXzy0ZRF+ipeiB6pMCH9G83JjdazLivlu1UGkjzHcGyEeA/NW9gxS2svF5+KANzxtRYSF2fXeYiAOfflpN/O8ww+zW2wlQlYcU6UxPRSwT1XWqcHsXxmzSkwpjJR4zzaMcP0XlTerShlDvqJaegcHuMJK
x-ms-office365-filtering-correlation-id: 46c887cb-aeab-4c63-fbed-08d61c49ed8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB050213B8DA9936D4DEE468F0FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(15760500003)(102836004)(2906002)(476003)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SNsLE0ky3xEswHLTyE+9DfWfMB5ldqxz1LkN85Vwhvz2ySP9GMsFCt7wacWYiAfKGHoiLu0l2DpLNr5y2AYNJ/FAF9mjk1jvDKRFoCQj9yV1/Kt5wq/x8okoi2mY0e/oWxH9t/zUyBDJgj8h0sVOZNYLsSjXSctHKuavryTLLWMbfe74LjVF2l7OXj+x+UngBEKkQsd5xUxkzoYh/ZqR96Atg+8ICCei1PcuW9asryri7oPlQTixNda+WbZdvEfc8oVMIk6R/L4F4EksKdm3widUQoIGtSFiTSV7eXTYa/OwKuMTw27Ceek+SKWtGOPWa/Q9BY1aevPK8YK2kfyw6RGRidA6MxN8U+basPb2MXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c887cb-aeab-4c63-fbed-08d61c49ed8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:56.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
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
index 9ab8e7ee2e1e..b1d9f3857d3d 100644
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
