Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F223ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1A7214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Cn/aUbmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1A7214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbeIQIdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:15 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731475AbeIQIdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwRp0MzIMo/Gk9V+9QtOE5tNdtSPhNNqD5h8ZzUscvk=;
 b=Cn/aUbmrjey6Jf5CwqJUU9MVaWyEGbIq8BWLBuaoxq2NSuXkttycmdu7ntzF5xqWcQQ+wE7GcZr/qBBt27e46HClKKsmEw/XB5GqriWQPshPfsdXahgcxMbNHyKoki9jN3dlziDJ+4myY04wf+JbOy8mHUOBgWRw4WBGUyAxPWs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 15/29] media: s3c-camif: ignore -ENOIOCTLCMD from
 v4l2_subdev_call for s_power
Thread-Topic: [PATCH AUTOSEL 3.18 15/29] media: s3c-camif: ignore -ENOIOCTLCMD
 from v4l2_subdev_call for s_power
Thread-Index: AQHUTjNUtpfvjYk0zEOkmKvKWtPgrQ==
Date:   Mon, 17 Sep 2018 03:05:46 +0000
Message-ID: <20180917030533.592-15-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:Gb+25nCBQRusQfO+hDBLeZF4jdWR5WJto9YQh1FcU0vAoFjKP8CD3oh//o7S/z8unI8vLFVRiP1njlggccN+laAdC1NyWTN/EBDycXjykUWQVWUQTZfd+djQC/f2nN2m7qm8PU42qQju1VpGQqBQ6WoR4LjCY402Z67XyRHl4HVkgCjuqt5lTwOdqPlDo0cg+HDWhvZkOYqefMmq2Ua8PZEzRbHegVVDqOI85Le0kjmgSEeFEAR71j+pBjzmrGOJH7HYcx0t9DIc4Zc0qP9/ifIS8yxRPrXh52GAaVkR0CMWLYEOGhH8DI0v2yPB6bd4tWDSTAPNXGorQW6BBD9I/OUx6DmNl3hOjB+x4IJHs6HQyRn2l6LDeMQFXIAQoiKDfrnnkb7ExJhtdSt4q/FIhqcBIM2UsEGnCZBbHRAW5NnGI/3eGngJjY5lE9uwaRXkP6QgbE6A2ptISH5ilQFfXg==;5:NfixFn2r8uCAm8ba5eMw7CCH3kK/SkJxj/TXzUm/YRZzxB8ojwpFex3Axq+zCivaxyu8OUy7c5rS8uhX/4z3pryqOaoi45ifOkxoqtwCwr2Buv+tjuc6xNRbPh/wxGHoIqC/u6AWcKhOfA3DE/PVVvrRRTut+zctS+nLhopYG9A=;7:HOajla2ElImWS9sa4KG74bK4MYWYHi2LG3B+ttqqGDkFTFBhqw+WIoHZyK+S1TmUj7quHy1wAIhM0e7GmOxvkyMUmAPmKEnsppVcOWHbsTPD9Ph13hdvuIZVoQTjTitzVNfbOfFA8ju9WcjGkaz8talWGL8k3R9DQfChlNFoSDBtmhjXprb2zW7rH/QWJPyI+y4sThc3MzxI172H3Yff8+6ZQAn87/4UWRDlIF6+b7KFZCRCwQEpb8tmtziSfNe2
x-ms-office365-filtering-correlation-id: 01323c37-849f-4f55-ca4a-08d61c4ac22d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150C29DD2EE1F14365A98F7FB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(39060400002)(15760500003)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: iHpP79J2xLxLVansjKxBJQO0b+pB4dZKgW7BW8rZV6GSF5sOa6ErKmZ2GpHp0a8trSWh1st+NwR7d3Ml/ELtVvSzF6v1z4YZCEgTfJTgi3I91K0NiLaPoFNY3JjJAb5Ag5EWFvk2onzyNlKM/E5S0smRvYoQ6HUAPXGkkc4CiYyrKxFksgKMSg/2RYsJPx7+/guMYynTxN5eKKHON/IUX5RTuFuF00t0xD/iFca6pNLJipsfMMxeA7WLk1sZwgumF83TqpN2f4LV1v9t/URnC9c+9MFIJp2G7MgUx6PAroiqYxu/ANO4qjdbS11P9mbC8FIDGjEm8wR6aForcRl3JyfsLhn/6aIzsfDyf6EOLww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01323c37-849f-4f55-ca4a-08d61c4ac22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:46.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
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
index 97a52d4574e7..bb4a57e55aed 100644
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
