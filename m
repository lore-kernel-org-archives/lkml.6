Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D71C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A9C2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nxNQMn34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A9C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeIBRTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:39 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbeIBRTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzxqCmUyRWazx6DN8Tz7zJI+x0QMykD/+dBwuIMc4Vw=;
 b=nxNQMn34iCD4Lcrlh4o1FYBvpanKL14wOhaYoBXYo4V81Clsh8L+gBAM7y4+y/OnpGg4ei26ZJSYGUBKKO0feklSLFJjl5v0GKe6tijFhVUdyw4voE6ur8L0IdYwr38Nlv2GF5NWZSY9lMN++9HHNYnD/2f6L9YOHo1bU53kwdY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Todor Tomov <todor.tomov@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 026/131] media: camss: csid: Configure data type
 and decode format properly
Thread-Topic: [PATCH AUTOSEL 4.18 026/131] media: camss: csid: Configure data
 type and decode format properly
Thread-Index: AQHUQr1ZjMjLYkZLT0GOIisEcsdxng==
Date:   Sun, 2 Sep 2018 13:03:31 +0000
Message-ID: <20180902064601.183036-26-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:NG1CWQ30iUIYNXNsburUakFiXOBPDfFIiK8miWlLKwH/GPFWCMvHl1HW2Cjnu4pJnBD+D9ajOYt3eH6NAXN3ab+DOeR7LQJxTC7HgNsVtKkECspKQ+CutJeRsP7l2RuGZiMEYE+tOLYvCxSpFWpm6oRdYpudmc0sedqYPS/VduaUiXasmZgY4H9wuQVNFGYqlGJ8jdeO8xoYtBMOfEEMDVpq6UO59ONC68Rok370aeeTFc3Lu/jS68k2mW6I7YlM86xfx6YOfUzSJxIOWvOoepeYy3U/9fxJWCWKAozoiaSHojOjx0YXbnjzb5m77bNcBTHOd4JtuTn7OJlAIWe/dGdCoIF9sBLkNiODCuwRCDiVcR/0fvmaQlLFZEEiRp+sZ/smMuEOLkG8TorOiHNe1gY5hR1kBuXjJiHRW08XJZ8vCZNjhdMkl2GLI4rHAvF0uNM1hueELw3DLjPLloeFMw==;5:LC7ypuWpBxCJSsJLRQgZZade5k9/PNO+iirm2gA5Lk9YjpQBetZilPYa80ut3FpJZUsyqDtsnwZx213jCfQQ+VvUuTH4lO9wKv4gLnMcib3TsoOhcjJ+Q086oFcvcK9Cx/Ez0xq9+bpBY14AEj+myGlh5xZKZaMAlx6+ZDYsj+c=;7:NYhRmskXv7+zngxYTtQiRLXZevioo815bJFzxynkLEn4q+USGd+fKcdU5DftL7tTypzkdjx/YDIDxZBPo2+OI+a+jlotyKGOqzeAALH9JebUnCVrL4MVnwcxkTCdtC6J6YbBHdEmTX7XPvDEl3pmpFJFLO0SKf68TZ4L3kb/rn1WKbM/ct4Tee+t54q0AymfGmEfmTej5UL2HmUyxIMZDLSnFEhAzqZzMfQX2cFIutBYiQlQvX3oCrrnV7i3muzc
x-ms-office365-filtering-correlation-id: b3624f96-9428-4b97-0eb4-08d610d47bbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150F5857AAE870364BC73CCFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OC/227+/oOWqjmk/i81GVSHasdXbJr4WVcBaZBD8CE8kdDiX5vGucVUldDRBuOGyMUVWEs5kBJ37ysKZMEWUU1SYHb7Rqtc9+WkQIvYpKcX/TWEM96m3+vCBeqgv8iD7M/njlhrdyi0ryy8YPSQxKzP6AARCGoRl6/qn3CpDWWYAPUbxS89H+lblQ0Fz/e3mt4GxLzfwggGUlS6mfyUE8iuEhsMcE6izMhMlKdreY4SluaViL99FuUm0hFbkTPCLfcMUpXmqsidneo9v2lKUUIvqml+m1+hepsuYRcjrpXKFoc2A5+fEXnwxa0p5vCfO5Cgx0kz1T8sBg0zk5ltJ9HhAMUVT3fh+B60V8npnOlo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3624f96-9428-4b97-0eb4-08d610d47bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:31.3052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todor Tomov <todor.tomov@linaro.org>

[ Upstream commit c628e78899ff8006b5f9d8206da54ed3bb994342 ]

The CSID decodes the input data stream. When the input comes from
the Test Generator the format of the stream is set on the source
media pad. When the input comes from the CSIPHY the format is the
one on the sink media pad. Use the proper format for each case.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../media/platform/qcom/camss-8x16/camss-csid.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/camss-8x16/camss-csid.c b/drivers/=
media/platform/qcom/camss-8x16/camss-csid.c
index 226f36ef7419..2bf65805f2c1 100644
--- a/drivers/media/platform/qcom/camss-8x16/camss-csid.c
+++ b/drivers/media/platform/qcom/camss-8x16/camss-csid.c
@@ -392,9 +392,6 @@ static int csid_set_stream(struct v4l2_subdev *sd, int =
enable)
 		    !media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
 			return -ENOLINK;
=20
-		dt =3D csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SRC].code)->
-								data_type;
-
 		if (tg->enabled) {
 			/* Config Test Generator */
 			struct v4l2_mbus_framefmt *f =3D
@@ -416,6 +413,9 @@ static int csid_set_stream(struct v4l2_subdev *sd, int =
enable)
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_0(0));
=20
+			dt =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->data_type;
+
 			/* 5:0 data type */
 			val =3D dt;
 			writel_relaxed(val, csid->base +
@@ -425,6 +425,9 @@ static int csid_set_stream(struct v4l2_subdev *sd, int =
enable)
 			val =3D tg->payload_mode;
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_2(0));
+
+			df =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->decode_format;
 		} else {
 			struct csid_phy_config *phy =3D &csid->phy;
=20
@@ -439,13 +442,16 @@ static int csid_set_stream(struct v4l2_subdev *sd, in=
t enable)
=20
 			writel_relaxed(val,
 				       csid->base + CAMSS_CSID_CORE_CTRL_1);
+
+			dt =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SINK].code)->data_type;
+			df =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SINK].code)->decode_format;
 		}
=20
 		/* Config LUT */
=20
 		dt_shift =3D (cid % 4) * 8;
-		df =3D csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SINK].code)->
-								decode_format;
=20
 		val =3D readl_relaxed(csid->base + CAMSS_CSID_CID_LUT_VC_n(vc));
 		val &=3D ~(0xff << dt_shift);
--=20
2.17.1
