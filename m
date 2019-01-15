Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF2220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lPUGZ9IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAOJBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:01:01 -0500
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:14880
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbfAOJBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC3kcZ//5dxB56C5M5hCwvWbhhT2UG/oWIElwrgtD3E=;
 b=lPUGZ9IVoLhJL77LS+YXGPjvPazJGWi/kuBZNtvea9cf32yVKlhQ9kqdAbtLo9fAnR5p9DnIJepmxxfwRbkmnCAuSQdwT0brElSMxmBnnJs86R5LXFNK7agf6jRC5TwrtRoPNFIjKl5CSvgbwS2QTKekadEVNx2wZcOD48X2Hsw=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3026.eurprd08.prod.outlook.com (52.134.93.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 09:00:14 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%2]) with mapi id 15.20.1537.018; Tue, 15 Jan 2019
 09:00:14 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Matteo Franchin <Matteo.Franchin@arm.com>
Subject: Re: [PATCH] drm/fourcc: Add modifier defininitions for AFBC 1.3
Thread-Topic: [PATCH] drm/fourcc: Add modifier defininitions for AFBC 1.3
Thread-Index: AQHUrCrdfBMOUgu52Eef5RkbU4VOCaWwCRcA
Date:   Tue, 15 Jan 2019 09:00:14 +0000
Message-ID: <20190115090008.izvs3itvjqm3fq6a@DESKTOP-E1NTVVP.localdomain>
References: <1547485311-812-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1547485311-812-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [195.233.151.114]
x-clientproxiedby: AM6P194CA0063.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::40) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3026;6:yVH20vra9tW5nK45YbQPJKZhtwjHu6SQvFLFqokRi9/j/6mXsRyWE7KyYyj+5hj2gw8vcI7eh2Kzl2NFNwG0G4bJqZCGEwMveU7t5SPxh6fdKGK6zI3F+RodD0IqNzz4LfFcdEjaRM7QdD7E4KEU0Y+YDaMnKmD1udlnBJqIFACn0Xgr3qjLl3nUVbxjiEmc6aaiVPPpew+7iVG1YWysqT1rjdH4XUavf8nGY014aV1Zz1oUH4XxlOUwgZDc/1mA/AabOPD7B3oK5ZJPaFskB1mctGX5lve24GsdP0enP4+21BgUck2TgBbIsRG6uWunaDmHshqXYnJcN0eYEUzBB2E7P0wrQKqi3u2GUSLZYZ3HT3EcSm8TFA22OU3Sqil8UJKFYS9W04uHA79quod0wES2ETGlx4u0Bf5vQl8RDN0puURGdvZEYUfr2Jc8DAbI/JY3khRWKOLvDwa3AS9V/g==;5:a1cfGm6ynusObj23xjJJhGQebZwo8eVjlF1CTgUUwogiGwm8pc/ghak7mMskB35SzfTN6NKwOzLGBcMlH8hrbIdD75I/Sk1vIEdqUBOhEsBn6Txe9Sz62Z+X/2fInKTxZMc4Vq/c2mFCwsJbpHuhyvJdSBHln4ZoGk/RqtS9yINEy/fW04IFbvScPOtQOe9QW7ZD8NYZwx7GttuRcw+SUA==;7:zM9BGkRz4++mh7j0UfHnlLoMEwMxbLixnrh7caYpkV14xEr4uppK/ww809Spjm0VX1cmQTuLQ0yVkIBjLW0EAmA0ICe/7GBOiugs0MXvwEzbQzu5hnPqILnhDMCo6CdFygaIfcPxtOl/R4kTtElbsg==
x-ms-office365-filtering-correlation-id: 36c71e3b-45d8-43ce-b938-08d67ac7dc7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3026;
x-ms-traffictypediagnostic: AM0PR08MB3026:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3026A4B72D4052B935BF410BF0810@AM0PR08MB3026.eurprd08.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(478600001)(6246003)(486006)(6862004)(72206003)(305945005)(14454004)(66066001)(9686003)(6512007)(76176011)(52116002)(33896004)(386003)(6506007)(102836004)(53936002)(26005)(446003)(11346002)(476003)(86362001)(68736007)(186003)(7736002)(2906002)(6436002)(6636002)(1076003)(25786009)(44832011)(6486002)(6116002)(99286004)(256004)(3846002)(97736004)(5660300001)(8936002)(58126008)(8676002)(81166006)(4326008)(229853002)(81156014)(316002)(71200400001)(71190400001)(54906003)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3026;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m1eaz6CZdH++pPa81QrFZyMF6yjytPP9EcKvoA9aZgHGr0XFSKtYbaewQ6Nc+vFsXO64C1VTSDSPgAtEfD1Cvk/tp8A0DxYeC3vVTFPumcrXR5opRi0HWXc8Z9S8Q9FrTHmlfMfgRQNfcuZ+N0BdA/FzF7B/fkdwsoXEwKL0wjpale/TgrhiHS85gpYuUTxF/8cxM+NiSLR6viFilR4FpBN1uqcgOi0AcoqIGqnx0LkXyt8qK0ezPxr9Kp9HmrUvSasXrlhswQiqnCg+DumQng5yYjxUGSPkVSnUhr/6yIK1uCZpWuuk/qgQ9Zv7gaKTtDYPuj8wguQaF7cE4N5mvhetjJ7jcNscYGvWt/oF1li5/uHyP4PAGaarFUZzBoeAA1KYFPNodD6ld6LBcGvbvhnPh2Yb3WNm3g75BXYKugQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5911FD43E6009547953EFE6DE7B97D46@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c71e3b-45d8-43ce-b938-08d67ac7dc7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:00:11.3754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

On Mon, Jan 14, 2019 at 05:02:00PM +0000, Ayan Halder wrote:
> From: Matteo Franchin <matteo.franchin@arm.com>
>=20
> This commit adds definitions of format modifiers for version 1.3 of the
> Arm Framebuffer Compression (AFBC).
>=20
> Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>

We should have your Signed-off-by on any patches that you send, but
otherwise this is:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

Thanks!
-Brian

> ---
>  include/uapi/drm/drm_fourcc.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index 8dd1328..d6a20d4 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -602,10 +602,18 @@ extern "C" {
>   * Indicates the superblock size(s) used for the AFBC buffer. The buffer
>   * size (in pixels) must be aligned to a multiple of the superblock size=
.
>   * Four lowest significant bits(LSBs) are reserved for block size.
> + *
> + * Where one superblock size is specified, it applies to all planes of t=
he
> + * buffer (e.g. 16x16, 32x8). When multiple superblock sizes are specifi=
ed,
> + * the first applies to the Luma plane and the second applies to the Chr=
oma
> + * plane(s). e.g. (32x8_64x4 means 32x8 Luma, with 64x4 Chroma).
> + * Multiple superblock sizes are only valid for multi-plane YCbCr format=
s.
>   */
>  #define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
>  #define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
>  #define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
> +#define AFBC_FORMAT_MOD_BLOCK_SIZE_64x4      (3ULL)
> +#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4 (4ULL)
> =20
>  /*
>   * AFBC lossless colorspace transform
> @@ -665,6 +673,21 @@ extern "C" {
>   */
>  #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
> =20
> +/*
> + * AFBC double-buffer
> + *
> + * Indicates that the buffer is allocated in a layout safe for front-buf=
fer
> + * rendering.
> + */
> +#define AFBC_FORMAT_MOD_DB      (1ULL << 10)
> +
> +/*
> + * AFBC buffer content hints
> + *
> + * Indicates that the buffer includes per-superblock content hints.
> + */
> +#define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --=20
> 2.7.4
>=20
