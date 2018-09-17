Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8733FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340C7214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M/0cJQBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340C7214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeIQJAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:00:45 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728852AbeIQI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhnMIVN0txYTPSPDeEbQRCiQJjZWwcVW1aj05d733gY=;
 b=M/0cJQBhENwLbOCUx3A2x1mmlxqqmuRPehANrvk6Cm+45n7bahsNUCqI0sk8Q94IAItmSQj3i07R5e4t/rQHRzWFQsenX0hdjpd2PoMg24i4+Hkdlho58PXsQno4uHxYEKYGPjq7aqzyQo4WGkr5q+TcI8sjvoPxvrKbgZoHcDA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Seiderer <ps.report@gmx.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 039/136] media: staging/imx: fill vb2_v4l2_buffer
 field entry
Thread-Topic: [PATCH AUTOSEL 4.18 039/136] media: staging/imx: fill
 vb2_v4l2_buffer field entry
Thread-Index: AQHUTjKbhdnPE3klU0SseJSjzAWlAA==
Date:   Mon, 17 Sep 2018 03:00:36 +0000
Message-ID: <20180917030006.245495-39-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:9Q2n0ynaZUk7g4V0EzDp0p3OXEHmjncS1yBF87NhT/MmAJqBo6d2vLpnfsprOOQeHe9XJMjMJa+tFfJVaZVymqGAZR06csqFg+6t9e80ELAU3bERz2dS0Efo/T8iTSE4kij8LJ6M91aeRQZJtR5pB2La0RLnwW2sLRRBSfbR6HbMn6hnipqh8/uVD7aWJlUqziU2fw9al6au9RO+WjIBw0lUAZH0nmTii49QptFbF6SrRyyw30NZrPhprUk3NQAJcyBxaiUou4xk48617Dk7NbJWs0DytOrzENJjp03wJqj+WfyzkA965T70DTvuiQsFr535e9OrigNkbvWljU0xwAEaj6gGyLqcj9JTX2sRyRVzjPwnH2Z0RELefDB0M6Ayv60vZhWCn5QuQzbvnmPwUxBFfDOusRwD0bccqlQr6/mpqxGBdxvsxSNjxfVrffySyqlDUK8nVyk1kMTkseyjMQ==;5:Z4IT4K3oKijrsVYIMe2evi1ueBVWjT3FsNV00n/uvUQObkoyJOWMOzaPlV5t7T9kxy1J3Xxxm6EkVPUBQD+6shJzhWXJXUyj6/amJDodKDabV42RqdmvHJLVCdWziR4PUUygMTm/97PHi8i6VNQSmc6B2ckKryrQJqiqYfFFiJc=;7:tRqYECoOPBUW201PrNt+F2RXZoAKWbKCGW790s7UILfEm/wmfLI2Ptngb6j8+vxq/al04zLsFVPj+ZPRtqAqbpgiES1cs2dQBhCrljfLWZ5GB7Ys0mQopG3xrEV7piWhYtNz4+bP28F0fITyUPmYNxsem2VOi4ZU8hH9Lf6g36j0mozRtFvqtYDAGaVM19KCoBdxDiyfCBgvSZm6yrmnfIry+70fQJMj6xRIikN8FvUHnyMyAyVuxBuL6GCtGIA0
x-ms-office365-filtering-correlation-id: 46d09494-e7da-4d0d-b8f1-08d61c49cee5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06292D170592C22EEBFA28E0FB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(248736688235697)(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a6+GnTQFk0aND6g+gsnX7RYLapI9zZ9LE3Hx+PjA/Fy9gQYr3RBFvQGpZRJHaGkMESaGOpZaNxtAttI0XroBdYztzndFQ+B6hZlXtrF48uteaRjJDEE/KKr6YOLxIURyOwn8g3cgEelovLiaeJ+Tx1e+9FkjWp4GxSw+D/oEFHbeDvayjSsNP980KGv72oLR8m85VWtPPF7gWS0bwQ0JsULHw4b6BvVsn6FFiiOZssp+m3GP1b+eV/5KNsfyZzRhLo/8bKgchIWsal9dARrU8X41zahVmEgNWV2nwT8wsmoBD7L/4MaGC7IpbFmLzmz+qK+DLEFOAi5GGVzM8OACJ14Wuxu7Pm+CRcG61Y+gP0Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d09494-e7da-4d0d-b8f1-08d61c49cee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:36.6984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit a38d4b71cb7a12b65317f4e3d59883a918957719 ]

- fixes gstreamer v4l2src warning:

  0:00:00.716640334  349  0x164f720 WARN  v4l2bufferpool gstv4l2bufferpool.=
c:1195:gst_v4l2_buffer_pool_dqbuf:<v4l2src0:pool:src> Driver should never s=
et v4l2_buffer.field to ANY

- fixes v4l2-compliance test failure:

  Streaming ioctls:
          test read/write: OK (Not Supported)
              Video Capture:
                  Buffer: 0 Sequence: 0 Field: Any Timestamp: 58.383658s
                  fail: v4l2-test-buffers.cpp(297): g_field() =3D=3D V4L2_F=
IELD_ANY

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 1 +
 drivers/staging/media/imx/imx-media-csi.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/=
media/imx/imx-ic-prpencvf.c
index ae453fd422f0..ffeb017c73b2 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -210,6 +210,7 @@ static void prp_vb2_buf_done(struct prp_priv *priv, str=
uct ipuv3_channel *ch)
=20
 	done =3D priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.field =3D vdev->fmt.fmt.pix.field;
 		vb =3D &done->vbuf.vb2_buf;
 		vb->timestamp =3D ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/me=
dia/imx/imx-media-csi.c
index 95d7805f3485..0e963c24af37 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -236,6 +236,7 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
=20
 	done =3D priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.field =3D vdev->fmt.fmt.pix.field;
 		vb =3D &done->vbuf.vb2_buf;
 		vb->timestamp =3D ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
--=20
2.17.1
