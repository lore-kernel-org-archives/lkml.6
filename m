Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D06B214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nzY4qQdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D06B214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeLCLcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:46 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:21376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbeLCLcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH0HviKmC/Vu8HUFZckW3p6Xx9+TL8TchyZ+aFdpbQ8=;
 b=nzY4qQdQVef7LBkxB4s3pOWdtle+BaRQtRBMZctFPAVw84itNWhwhRDnrGSvnohEdQdexsHHlRbrEkdP9Os09e0PkJ7u2yIyT01PJNNNIbpv3HE1y7x37EX4xJ3gsyvpHWs5HkLKFZO11bATYf9aY8C7+CgT9sOH4oSOJrEd4Zk=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:31:55 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:31:55 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC AFBC 01/12] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Topic: [RFC AFBC 01/12] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Index: AQHUivvLhdpemUHBzUiBjUfFvAvaaA==
Date:   Mon, 3 Dec 2018 11:31:55 +0000
Message-ID: <1543836703-8491-2-git-send-email-ayan.halder@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:im3xltO+QvRTRNm9ZEDbV7hOO9j+jn7gVfJBN6bBYxkIIfHQCUHWt5m2GcHq6EqnvQUKpQPiCQfppY3nJi9q9rMhfKM0jlPQKTWaWnl6AnQoSA37wGf59iCojEiSDy7MnaKIsFKnbduXQPk2y7k3eLLetCTgrypPB/IjbNCEOkG3wXl876kB2Qt9HW37DfV0WynpK50iF2x0vYIha7MN/oMmpzv9CMA76VDMGDRsBbd4S68b+Qo8BbJenR+6bBqaxYneRqSrTsaonuMSAQ+1Ru7NYb6yVCPl6KnREYLoQU8ulclLcrfIG7wTpYKS2pIMqi1IJ6yE+LWQHrToCIo3VyIwKt7mS9agsyEM3F11nI8JOAsyOojc8awSfPUMtYcajjSyPCORlUnS00q/NzX2I91vHwGMtXTDuW6qnYfpmQuDaWnvNkIh5CD0cBlhfsLSQntxuh3RdoJZ47C/dS24dg==;5:ty1jcSNhQGBZARw+V4YRIEWaOtgeudYpZByFXk/FGbd3ewmuHPaw7u2Mh8MKowJhktmJ5mmCwg/P5n9/4ivMtfG21PdwmIXpgLOxmHi/hSeatnsv2K35ArsBUDJJoY976aUZALTXIigDbICHb2Z0Wgg5YzwJONs/Q9oVT11Z5QE=;7:K8GmGXUoW0ZD8AVYuq2cPitfYZpGjCJ+lPog2vFPWVKhQnoXePRQ1iLSPyBjyM4jVpVrC53kggqDx3YwzhUHwmg+Pq9w607LNdR88arb3mOCCM6xsntkFHpEIM0MYR+2gVMU3XwsB6zUU1G8pnyaZA==
x-ms-office365-filtering-correlation-id: 16f270d2-6ee7-4667-0d5f-08d65912eda2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB34914A9F7A0893B7361F5203E4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(4744004)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(14444005)(575784001)(966005)(2616005)(44832011)(476003)(6512007)(6306002)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SI4qtplACuW/IXS/dGthB0E+90Lw8xp1V9HYPbRqXIDbDqN8MCNN4Ou8rzAkmVLbCNdEhfYNZaOSBW4xVoBOln4R0I9DF3E3ge0f927oA4nK/8HBLfU6g5Nv72MPLTF9wdIsMOj4nqqowwySxzqCpd2IEbRQlE4dO1P2jHatTWkBZho0iudSusIc1c5HLc4DxgEymE1pQRgLGKHgAIhC0fZr28xs5hPWatm33b7keLMtHlLeFQtbdg25A65ZN+AbCPusEsH1WanV5fUCOwFiuqrOSE0si90U/ayl+vf2gEcKWUqU3gCh5QyjLISyHjcdg0f2rfiFcV/IuIQx4g51lm5ebSh3IqHjK/G8EIZuCoI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f270d2-6ee7-4667-0d5f-08d65912eda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:31:55.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Starkey <brian.starkey@arm.com>

As we look to enable AFBC using DRM format modifiers, we run into
problems which we've historically handled via vendor-private details
(i.e. gralloc, on Android).

AFBC (as an encoding) is fully flexible, and for example YUV data can
be encoded into 1, 2 or 3 encoded "planes", much like the linear
equivalents. Component order is also meaningful, as AFBC doesn't
necessarily care about what each "channel" of the data it encodes
contains. Therefore ABGR8888 and RGBA8888 can be encoded in AFBC with
different representations. Similarly, 'X' components may be encoded
into AFBC streams in cases where a decoder expects to decode a 4th
component.

In addition, AFBC is a licensable IP, meaning that to support the
ecosystem we need to ensure that _all_ AFBC users are able to describe
the encodings that they need. This is much better achieved by
preserving meaning in the fourcc codes when they are combined with an
AFBC modifier.

In essence, we want to use the modifier to describe the parameters of
the AFBC encode/decode, and use the fourcc code to describe the data
being encoded/decoded.

To do anything different would be to introduce redundancy - we would
need to duplicate in the modifier information which is _already_
conveyed clearly and non-ambigiously by a fourcc code.

I hope that for RGB this is non-controversial.
(BGRA8888 + MODIFIER_AFBC) is a different format from
(RGBA8888 + MODIFIER_AFBC).

Possibly more controversial is that (XBGR8888 + MODIFIER_AFBC)
is different from (BGR888 + MODIFIER_AFBC). I understand that in some
schemes it is not the case - but in AFBC it is so.

Where we run into problems is where there are not already fourcc codes
which represent the data which the AFBC encoder/decoder is processing.
To that end, we want to introduce new fourcc codes to describe the
data being encoded/decoded, in the places where none of the existing
fourcc codes are applicable.

Where we don't support an equivalent non-compressed layout, or where
no "obvious" linear layout exists, we are proposing adding fourcc
codes which have no associated linear layout - because any layout we
proposed would be completely arbitrary.

Some formats are following the naming conventions from [2].

The summary of the new formats is:
 DRM_FORMAT_VUY888 - Packed 8-bit YUV 444. Y followed by U then V.
 DRM_FORMAT_VUY101010 - Packed 10-bit YUV 444. Y followed by U then
                        V. No defined linear encoding.
 DRM_FORMAT_Y210 - Packed 10-bit YUV 422. Y followed by U (then Y)
                   then V. 10-bit samples in 16-bit words.
 DRM_FORMAT_Y410 - Packed 10-bit YUV 444, with 2-bit alpha.
 DRM_FORMAT_P210 - Semi-planar 10-bit YUV 422. Y plane, followed by
                   interleaved U-then-V plane. 10-bit samples in
                   16-bit words.
 DRM_FORMAT_YUV420_8BIT - Packed 8-bit YUV 420. Y followed by U then
                          V. No defined linear encoding
 DRM_FORMAT_YUV420_10BIT - Packed 10-bit YUV 420. Y followed by U
                           then V. No defined linear encoding

Please also note that in the absence of AFBC, we would still need to
add Y410, Y210 and P210.

Full rationale follows:

YUV 444 8-bit, 1-plane
----------------------
 The currently defined AYUV format encodes a 4th alpha component,
 which makes it unsuitable for representing a 3-component YUV 444
 AFBC stream.

 The proposed[1] XYUV format which is supported by Mali-DP in linear
 layout is also unsuitable, because the component order is the
 opposite of the AFBC version, and it encodes a 4th 'X' component.

 DRM_FORMAT_VUY888 is the "obvious" format for a 3-component, packed,
 YUV 444 8-bit format, with the component order which our HW expects to
 encode/decode. It conforms to the same naming convention as the
 existing packed YUV 444 format.
 The naming here is meant to be consistent with DRM_FORMAT_AYUV and
 DRM_FORMAT_XYUV[1]

YUV 444 10-bit, 1-plane
-----------------------
 There is no currently-defined YUV 444 10-bit format in
 drm_fourcc.h, irrespective of number of planes.

 The proposed[1] XVYU2101010 format which is supported by Mali-DP in
 linear layout uses the wrong component order, and also encodes a 4th
 'X' component, which doesn't match the AFBC version of YUV 444
 10-bit which we support.

 DRM_FORMAT_Y410 is the same layout as XVYU2101010, but with 2 bits of
 alpha.  This format is supported with linear layout by Mali GPUs. The
 naming follows[2].

 There is no "obvious" linear encoding for a 3-component 10:10:10
 packed format, and so DRM_FORMAT_VUY101010 defines a component
 order, but not a bit encoding. Again, the naming is meant to be
 consistent with DRM_FORMAT_AYUV.

YUV 422 8-bit, 1-plane
----------------------
 The existing DRM_FORMAT_YUYV (and the other component orders) are
 single-planar YUV 422 8-bit formats. Following the convention of
 the component orders of the RGB formats, YUYV has the correct
 component order for our AFBC encoding (Y followed by U followed by
 V). We can use YUYV for AFBC YUV 422 8-bit.

YUV 422 10-bit, 1-plane
-----------------------
 There is no currently-defined YUV 422 10-bit format in drm_fourcc.h

 DRM_FORMAT_Y210 is analogous to YUYV, but with 10-bits per sample
 packed into the upper 10-bits of 16-bit samples. This format is
 supported in both linear and AFBC by Mali GPUs.

YUV 422 10-bit, 2-plane
-----------------------
 The recently defined DRM_FORMAT_P010 format is a 10-bit semi-planar
 YUV 420 format, which has the correct component ordering for an AFBC
 2-plane YUV 420 buffer. The linear layout contains meaningless padding
 bits, which will not be encoded in an AFBC stream.

YUV 420 8-bit, 1-plane
----------------------
 There is no currently defined single-planar YUV 420, 8-bit format
 in drm_fourcc.h. There's differing opinions on whether using the
 existing fourcc-implied n_planes where possible is a good idea or
 not when using modifiers.

 For me, it's much more "obvious" to use NV12 for 2-plane AFBC and
 YUV420 for 3-plane AFBC. This keeps the aforementioned separation
 between the AFBC codec settings (in the modifier) and the pixel data
 format (in the fourcc). With different vendors using AFBC, this helps
 to ensure that there is no confusion in interoperation. It also
 ensures that the AFBC modifiers describe AFBC itself (which is a
 licensable component), and not implementation details which are not
 defined by AFBC.

 The proposed[1] X0L0 format which Mali-DP supports with Linear layout
 is unsuitable, as it contains a 4th 'X' component, and our AFBC
 decoder expects only 3 components.

 To that end, we propose a new YUV 420 8-bit format. There is no
 "obvious" linear encoding for a 3-component 8:8:8, 420, packed format,
 and so DRM_FORMAT_YUV420_8BIT defines a component order, but not a
 bit encoding. I'm happy to hear different naming suggestions.

YUV 420 8-bit, 2-, 3-plane
--------------------------
 These already exist, we can use NV12 and YUV420.

YUV 420 10-bit, 1-plane
-----------------------
 As above, no current definition exists, and X0L2 encodes a 4th 'X'
 channel.

 Analogous to DRM_FORMAT_YUV420_8BIT, we define DRM_FORMAT_YUV420_10BIT.

[1] https://lists.freedesktop.org/archives/dri-devel/2018-July/184598.html
[2] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-and-16=
-bit-yuv-video-formats

Changes since RFC v1:
 - Fix confusing subsampling vs bit-depth X:X:X notation in
   descriptions (danvet)
 - Rename DRM_FORMAT_AVYU1101010 to DRM_FORMAT_Y410 (Lisa Wu)
 - Add drm_format_info structures for the new formats, using the
   new 'bpp' field for those with non-integer bytes-per-pixel
 - Rebase, including Juha-Pekka Heikkila's format definitions

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 10 ++++++++++
 include/uapi/drm/drm_fourcc.h | 16 +++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index d45a3a4..6b7a62e 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -225,10 +225,14 @@ const struct drm_format_info *__drm_format_info(u32 f=
ormat)
 		{ .format =3D DRM_FORMAT_UYVY,		.depth =3D 0,  .num_planes =3D 1, .cpp =
=3D { 2, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_VYUY,		.depth =3D 0,  .num_planes =3D 1, .cpp =
=3D { 2, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_XYUV8888,	.depth =3D 0,  .num_planes =3D 1, .cp=
p =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_Y210,		.depth =3D 0,  .num_planes =3D 1, .cpp =
=3D { 4, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_VUY888,          .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 3, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_Y410,            .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha =3D true, .i=
s_yuv =3D true },
 		{ .format =3D DRM_FORMAT_AYUV,		.depth =3D 0,  .num_planes =3D 1, .cpp =
=3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha =3D true, .is_yuv =3D=
 true },
 		{ .format =3D DRM_FORMAT_P010,		.depth =3D 0,  .num_planes =3D 2, .cpp =
=3D { 2, 4, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true  },
 		{ .format =3D DRM_FORMAT_P012,		.depth =3D 0,  .num_planes =3D 2, .cpp =
=3D { 2, 4, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true  },
 		{ .format =3D DRM_FORMAT_P016,		.depth =3D 0,  .num_planes =3D 2, .cpp =
=3D { 2, 4, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true  },
+		{ .format =3D DRM_FORMAT_P210,		.depth =3D 0,  .num_planes =3D 2, .cpp =
=3D { 2, 4, 0 }, .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true  },
 		{ .format =3D DRM_FORMAT_Y0L0,		.depth =3D 0,  .num_planes =3D 1,
 		  .char_per_block =3D { 8, 0, 0 }, .block_w =3D { 2, 0, 0 }, .block_h =
=3D { 2, 0, 0 },
 		  .hsub =3D 2, .vsub =3D 2, .has_alpha =3D true, .is_yuv =3D true },
@@ -241,6 +245,12 @@ const struct drm_format_info *__drm_format_info(u32 fo=
rmat)
 		{ .format =3D DRM_FORMAT_X0L2,		.depth =3D 0,  .num_planes =3D 1,
 		  .char_per_block =3D { 8, 0, 0 }, .block_w =3D { 2, 0, 0 }, .block_h =
=3D { 2, 0, 0 },
 		  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_VUY101010,	.depth =3D 0,  .num_planes =3D 1,
+		  .cpp =3D { 0, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_YUV420_8BIT,     .depth =3D 0,  .num_planes =3D=
 1,
+		  .cpp =3D { 0, 0, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_YUV420_10BIT,    .depth =3D 0,  .num_planes =3D=
 1,
+		  .cpp =3D { 0, 0, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true },
 	};
=20
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index c6e4598..71b2bc7 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -149,9 +149,13 @@ extern "C" {
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:=
Cr0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_UYVY		fourcc_code('U', 'Y', 'V', 'Y') /* [31:0] Y1:Cr0:=
Y0:Cb0 8:8:8:8 little endian */
 #define DRM_FORMAT_VYUY		fourcc_code('V', 'Y', 'U', 'Y') /* [31:0] Y1:Cb0:=
Y0:Cr0 8:8:8:8 little endian */
+#define DRM_FORMAT_Y210		fourcc_code('Y', '2', '1', '0') /* [63:0] Cr0:0:Y=
1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian */
=20
 #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:=
Cr 8:8:8:8 little endian */
-#define DRM_FORMAT_XYUV8888		fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y=
:Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_XYUV8888	fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:=
Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:=
Y 8:8:8 little endian */
+#define DRM_FORMAT_Y410		fourcc_code('Y', '4', '1', '0') /* [31:0] A:Cr:Y:=
Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed=
 by U then V, 10:10:10. Non-linear modifier only */
=20
 /*
  * packed YCbCr420 2x2 tiled formats
@@ -168,6 +172,15 @@ extern "C" {
 #define DRM_FORMAT_X0L2		fourcc_code('X', '0', 'L', '2')
=20
 /*
+ * 1-plane YUV 4:2:0
+ * In these formats, the component ordering is specified (Y, followed by U
+ * then V), but the exact Linear layout is undefined.
+ * These formats can only be used with a non-Linear modifier.
+ */
+#define DRM_FORMAT_YUV420_8BIT	fourcc_code('Y', 'U', '0', '8')
+#define DRM_FORMAT_YUV420_10BIT	fourcc_code('Y', 'U', '1', '0')
+
+/*
  * 2 plane RGB + A
  * index 0 =3D RGB plane, same format as the corresponding non _A8 format =
has
  * index 1 =3D A plane, [7:0] A
@@ -201,6 +214,7 @@ extern "C" {
  * component xxx msb Y [xxx:16-xxx]
  * index 1 =3D Cr:Cb plane, [31:0] Cr:Cb little endian [xxx:16-xxx:xxx:16-=
xxx]
  */
+#define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled=
 Cr:Cb plane, 10 bit per channel */
 #define DRM_FORMAT_P010		fourcc_code('P', '0', '1', '0') /* 2x2 subsampled=
 Cr:Cb plane, 10 bit per channel */
 #define DRM_FORMAT_P012		fourcc_code('P', '0', '1', '2') /* 2x2 subsampled=
 Cr:Cb plane, 12 bit per channel */
 #define DRM_FORMAT_P016		fourcc_code('P', '0', '1', '6') /* 2x2 subsampled=
 Cr:Cb plane, 16 bit per channel */
--=20
2.7.4

