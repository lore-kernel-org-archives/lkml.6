Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB43ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D73A208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BWUitNC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D73A208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbeIQI3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:43 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730190AbeIQI3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB+9qanTmXVpv9EIlmlJ05nhP2EcTnlA7tclsOJ+82Q=;
 b=BWUitNC32SKxzLr5PDKruU/r/m+sm1XmqQY6l+kizIrZSIzcE5KFPdgJJrZWS0pfebM7RQmp+4HzSLTs2sY4FanzQw+rEkRSRCFW4h3x5uqLSJydAvilmoRwZ5sY64MtvNoRa2hAqx2p6VzelhDqogbuWkCxl9vQWDWgmCbelcE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 53/87] media: s3c-camif: ignore -ENOIOCTLCMD from
 v4l2_subdev_call for s_power
Thread-Topic: [PATCH AUTOSEL 4.14 53/87] media: s3c-camif: ignore -ENOIOCTLCMD
 from v4l2_subdev_call for s_power
Thread-Index: AQHUTjLv2Xaxk5PkYkythOIzWxce2g==
Date:   Mon, 17 Sep 2018 03:02:56 +0000
Message-ID: <20180917030220.245686-53-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:vXwWDyhNp4nJLf9obq64dv1Hcdhzj48a4kF1UXSK9DZXbVYgb2Bp00UFPJu37Qtf+expOVyyhPcgXyPEpjW7uDUebvvT4T5BcuvbOR+U/kyzJPc/sLlFA79EIjOc86lIgzRsPOKptUIFi6siVdxQptvhAYWwY1lQ0etKy/NA/GnfU8RDBarrQ9GyOsiUHu31XjG5XJND92lmoF/hKZiXOFgyfRZH6sADstcuqsPl0gRezacEvuXv+agtLKsPnTvHA8hysc9y+hwpcDjku4M+jJ3bABsa8rVZ57lYMQVqBjyfAFvk2thhHrdQRWwDbpAHgBAAM4CR2cR/BitQVOwXkU2WLYDACJCDynDfLbOtMXOAHQGIwIfQsiU5G1vdlquGIS0enlWGxmjegozCou/hsWS2uXWoKXMWfV2MkzWYhZwHMSxibYv58D2h1otwNvjjabkcBtO37Wpf3Tv/rrTefg==;5:ESLwCS7G02dKLJ8/9gJl8hedn/Jv4tRwrohd5tsz5n11CGHJwcRho2Qe1yFsSKCjjJDtf6PPBDgi+KitrKrLw+JMxMXMzaAEFFqSFB0ZF1oZ74y3wcx0YPym5//4+8sfl/lHRk8HiFREJ+oTvzgPpfBqo39QmKt1ucMR/cEv1RQ=;7:gIGS42ENhhARvPQCyM6WEqVUVxR/gupLi0VvSMr9ORr5u0Qy9L0fC7OZuZf2Q9EyVh78dP3NencBD6HJYi9QJ+Bo1L6msG1P8avfHkqromqi+FwkGfWey6KpH6s9xkJzG47LWf7E4vyJhe3NPbSvPfztMZCWMMvqfLKXj953aUvrTksyRuqD85TMm3mGoWHBrFLRAD++vsEEiaCVJgcyWwaW8/Xi4d0uGvU06nuOMT1KZ53BJyyA2fbjeD9sjQVn
x-ms-office365-filtering-correlation-id: 5b85516d-80f4-43a6-b309-08d61c4a43cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB07748A68150DDB533BE600AFFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(15760500003)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0F5hFyRKwXj7MOA+gH1xA3XCEgUvsATDTOtiZ067ffHHhtZP+PWpfcyWrmqgiima7PwbrVDeNyx4+3uBunSHBsSGhPjAUgu9PKKk4PpMZuTCBJcW/HsjaNdhuvMbgsoBKqs8N/1d1s5Mz6VN389Fh2tehgmbcnuyDNNJVsBSdZIiBcStwxCc8fgjtp2VIVQ1RFelwfy6oGwqPZQzQPl0ttBLni8VvdCxG6XPNBiuisP6oZXqcxxmBadzifFAiAlZktPTLDW1r/wH7rqpjwIXwQys5MPV5h1ZJNu1sjD0eD902bZ9+zu7HoBovC9gm+u0Stv6M3dvtrucslHaMTknVCGI7XWkaeCV1EhfJTlIHnA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b85516d-80f4-43a6-b309-08d61c4a43cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:56.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
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
index 0f0324a14d51..85d26713cedb 100644
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
