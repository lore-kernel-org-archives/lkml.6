Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0471C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rSH55Tpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfBZQVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:00 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:51841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727823AbfBZQU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9aTCBpjXiLmrIwWMxmayiRt6qwX0dMgJjkYgsZdNMg=;
 b=rSH55TpjPP3ZdHFvYfTym7+XqS4LkzKtG4F4DOO1ooA7CDhQXIUEt5K/RTlOePaqqC8d99sRT/kwwxsOYGQYvJtMZabBugWooyWQLfS1Qsoq1rgdsDIanLwtL1d0csl+wtJioZfdQfZONpnYpccSdNPg+QHyLk85Tx8zYmQ6FAU=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:53 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:53 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH v3 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Topic: [PATCH v3 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Index: AQHUze8+2AofyQJ+WkCiiVKJs7QIlw==
Date:   Tue, 26 Feb 2019 16:20:52 +0000
Message-ID: <1551198042-4314-2-git-send-email-ayan.halder@arm.com>
References: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 154c38ab-bc59-458b-633b-08d69c0660af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:v5Dtz7XZilOjW9PbRRnn3WurhZrmiX9NfQYnMhVvaOZb6vVRRR1Z9nBKEcTJyCn0qfeszD0SBIetaG4T+Yeq+5IayLAl0fOhrsNH73jLS4B3M1jlzldLkEZYB/4PuPUkg15tbtnCV+SDDVpy4wATN/qm3KXW8UUGNv5V1rSyFvQ=
x-microsoft-antispam-prvs: <AM0PR08MB36828430B9C6EF8E7029888EE47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(14444005)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6306002)(6512007)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(966005)(81156014)(30864003)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RRgTRYB3hLt0uqilbuDD9Nu0gh0asvLx4jjYBfUfeQlaBSHkD0X9qW2agF48JBeXE/TdT5lyCqz+tKxr0pftBS5VHUtDnxeyeTca6VsveoKHgFSVweo4X9euQiCNvMxtZzQlTKtcJcIwpeiLXk/K4iLQUezjrL6uaMZcCKXfR0WA0FvzVPRvD7Xsq5Fmhf27UG+JbQ/z1IOJkw+eiXF3xgvzEz1OxM34zD8HXgQDYOz1fY7ZOA34R010yi10piK+6m9WomFbk5tUK0usvqGHEE+rvZKBvxEciDmOwUp54ZO1uQOnVvRwKzFJlEESZDpLK7nVocWkkaAmJcw1wuxOgRzP6V3ooivPbWR5nG/RzwEH3MRo4/Ny6uFM74sDdiz9WSfdMdGlbTnRFQlAm6Re2jp4IBpGohq9+j/MzX9nFEM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c38ab-bc59-458b-633b-08d69c0660af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:52.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3682
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

Changes since RFC v2:
- Rebase on top of latest changes in drm-misc-next
- Change the description of DRM_FORMAT_P210 in __drm_format_info and
drm_fourcc.h so as to make it consistent with other DRM_FORMAT_PXXX
formats.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 16 ++++++++++++++++
 include/uapi/drm/drm_fourcc.h | 22 +++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index ba7e19d..0a3efa5 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -225,6 +225,9 @@ const struct drm_format_info *__drm_format_info(u32 for=
mat)
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
 		{ .format =3D DRM_FORMAT_Y0L0,		.depth =3D 0,  .num_planes =3D 1,
 		  .char_per_block =3D { 8, 0, 0 }, .block_w =3D { 2, 0, 0 }, .block_h =
=3D { 2, 0, 0 },
@@ -247,6 +250,19 @@ const struct drm_format_info *__drm_format_info(u32 fo=
rmat)
 		{ .format =3D DRM_FORMAT_P016,		.depth =3D 0,  .num_planes =3D 2,
 		  .char_per_block =3D { 2, 4, 0 }, .block_w =3D { 1, 0, 0 }, .block_h =
=3D { 1, 0, 0 },
 		  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
+		{ .format =3D DRM_FORMAT_P210,		.depth =3D 0,
+		  .num_planes =3D 2, .char_per_block =3D { 2, 4, 0 },
+		  .block_w =3D { 1, 0, 0 }, .block_h =3D { 1, 0, 0 }, .hsub =3D 2,
+		  .vsub =3D 1, .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_VUY101010,	.depth =3D 0,
+		  .num_planes =3D 1, .cpp =3D { 0, 0, 0 }, .hsub =3D 1, .vsub =3D 1,
+		  .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_YUV420_8BIT,     .depth =3D 0,
+		  .num_planes =3D 1, .cpp =3D { 0, 0, 0 }, .hsub =3D 2, .vsub =3D 2,
+		  .is_yuv =3D true },
+		{ .format =3D DRM_FORMAT_YUV420_10BIT,    .depth =3D 0,
+		  .num_planes =3D 1, .cpp =3D { 0, 0, 0 }, .hsub =3D 2, .vsub =3D 2,
+		  .is_yuv =3D true },
 	};
=20
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index bab2029..b4fb674 100644
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
@@ -200,6 +213,13 @@ extern "C" {
  * index 0 =3D Y plane, [15:0] Y:x [10:6] little endian
  * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
  */
+#define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled=
 Cr:Cb plane, 10 bit per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [10:6] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
+ */
 #define DRM_FORMAT_P010		fourcc_code('P', '0', '1', '0') /* 2x2 subsampled=
 Cr:Cb plane 10 bits per channel */
=20
 /*
--=20
2.7.4

