Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB0EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA10214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Km64G93D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA10214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeIQIt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:49:29 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:11025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728721AbeIQI3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BLhd8254hxAGbYnsaPW2ix2IJlgrydssq2kQbkutck=;
 b=Km64G93DN1TMaf2OjuJ+hxMaxAX1PUdUboyxnA7RX+ahA+fs2XLIvFtoNRjHYaknTrxintgdS72i/CiwNrpXjkowiFWZsCvOSLLuWwjw9UqY5e7D1+XDucFEjpsi/o8YYJgPb3K8983SFvzPFnhUI3EcWeL6IE4TjpX9fe0Eqtk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Seiderer <ps.report@gmx.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 28/87] media: staging/imx: fill vb2_v4l2_buffer
 field entry
Thread-Topic: [PATCH AUTOSEL 4.14 28/87] media: staging/imx: fill
 vb2_v4l2_buffer field entry
Thread-Index: AQHUTjLlUyIr12it0E2stQidNwYDxg==
Date:   Mon, 17 Sep 2018 03:02:41 +0000
Message-ID: <20180917030220.245686-28-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:EmMcJ9AnmVD3QBpc4sgo0796klXys5AwHLXMQxF6qzfAleQyT04SqG14nSPYmLPe+x5WEtcymhfH+7kf8Co2JQrmIhSAuYmZ27wVes8Pq5v6YL2/aaqDLvU/vhghCFaQZikkCID9AkU/nfkhEh7LumFK9egxG0U5OaPBn2+0RY6Xlk4geU/eVpIFGpopvH5dzGLT2+wO0v6QVK3ZntucknE8aiuG/9W0AyGPT1JQD21ZsQAKJo2pYLH0rrNOgA8tHmEq2MDcaujtmD7rwVxF6Q1D8irkfvokPFYOsJWhN6NXFllJxdFr+2j8Kj1g1/72gyxh2gjfVXJdf5uCcjrpmZIjfGOUknKCan9n+CJ9st4EVRq0uUQ6GljXFgSP/6SaYh1+ofFVJRtsc8s8C0ydA1PPrXRfp1GVwGvI0Bz7gQqIeWT8Iz5pJz0gkFprL9rQv21OQRou+tnmU8QwKWS6Hg==;5:xBwh8RRbNN4V8cRgEUFqWczshnGs2QbVcXg5QC/gi1v1mvWUPOFTKVj8SEzX3FkNoa/cG+B9IaYs5eYJ4qZMnRwoJAw43afz3LZmIhS90aHeagr7aD29n0Zh3PAA816SBnPbzV8x2N3KhYRAr3sJBglEPlqgc1uY5TLQc/e+OEw=;7:cb7KaEkppFnqKCekSPLjxl5vkOm/calROMEVWv7kJEV4NY3F9Na//JpFbS3vyL+cMiuUyBL8bx6Yi9U/SsChrCYqiBMNvOAkCmuovb7OP4vYYak+UEeTJDLzRaiW3AIh8TYG/uI6r97EsJqxylVDyI86BWwMEVvR7FnczVr6v3qERgbvCJEOp7aUCtAEYzEzQrBxoMX1Dl5F6wPsYgzFt87vVgNwyhGu0/OPdSxVi5vKE6nWeCPjpcf/H2pbxzT/
x-ms-office365-filtering-correlation-id: d80fb597-844d-40dc-5331-08d61c4a2b6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470CD160B16F7401A36564BFB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(248736688235697)(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Rs/DuoCuBi6jx6/ICoJI8HPDKtkn6a+fqqwnF6dqRvb+LyNEdUZXQBHyI0DSJdqYS5gahBzMuQufIsSdjkQUv9+oq11mNhoguPmG2lxFYcWltNFThqPdQKLvjyWhqDXom6Ma1sGqEAag2VWznH+qLgJc5lS5RWPlUM2ahYFePEUy1WRGAuA1iPorb5r0lvWyrinWwVQozoX0XrNh4UJstzrFfcjeLEC4lmPF202vFCg2l/RI7RzkgFkMCANf+kiLlaPRS44trxVbNyntIdOC3PWHp8yIGVbB5YQdJuVq/g0na1U/S8Q5oE5Nc6kgBoizeS2FHwTTtpowAuYNJrL3TeW7FRgAKqk1lnZh94bvNM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80fb597-844d-40dc-5331-08d61c4a2b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:41.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index 0790b3d9e255..111afd34aa3c 100644
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
index 6d856118c223..83ecb5b2fb9e 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -171,6 +171,7 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
=20
 	done =3D priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.field =3D vdev->fmt.fmt.pix.field;
 		vb =3D &done->vbuf.vb2_buf;
 		vb->timestamp =3D ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
--=20
2.17.1
