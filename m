Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66A3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618F720651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Um1mq0oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfANONf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:13:35 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:18495
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfANONe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8A7wIoJGV+RseG4pbKfs3Zs60px5PGw7ckXwm5S18A=;
 b=Um1mq0oejtvUB5MgT+YZ9+mm5tH4xVNdeGjIqE860ETIc0KoBqcuC4g3pxRIc2I1DXeadLsEF4LSBd5IufyZJZ/Ibv811mPoPl+wOvbCbj5yCdKEvpDivzbm4miumMGn2LEklFR05mlUjpoeoifVCBvRlqZZ6nYp1Gi9d9kiccE=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB4193.eurprd08.prod.outlook.com (20.178.202.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 14:13:24 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::289f:9d33:465:cb4e]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::289f:9d33:465:cb4e%5]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 14:13:24 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>, nd <nd@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [RFC AFBC 03/12] drm/afbc: Add AFBC modifier usage documentation
Thread-Topic: [RFC AFBC 03/12] drm/afbc: Add AFBC modifier usage documentation
Thread-Index: AQHUivvNttZjBJX4VkmVqmat/KPe/qWeNEMAgAxm8QCABFbRAIAAHqAA
Date:   Mon, 14 Jan 2019 14:13:24 +0000
Message-ID: <20190114141322.6l3th2hjbsm7fzhp@DESKTOP-E1NTVVP.localdomain>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-4-git-send-email-ayan.halder@arm.com>
 <2158b458c240874e5c974a2cae374c3fbf682e48.camel@collabora.com>
 <20190111180758.GK20661@e110455-lin.cambridge.arm.com>
 <871s5f5sx9.fsf@intel.com>
In-Reply-To: <871s5f5sx9.fsf@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWLP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::27) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB4193;6:etgSmg6S3DibYD3TBu0SPVqjOImBFlp9I9RhNvC3E6cWdNK7VUrs7+/KDGjMO0W0ef3DLpec5DZTSNRF0US7z5sCysKwfn+claatHlGa3GdHpOGTXoLizXJQ9eSKIR2i5kQBAtm/t/JKdW47A0R75892rNt5QxrEgV68Lmq9UP49CeZrb8Fuq6JLBNj6w1rAKWeM5+dkitQAhCUQ8cVZz9yP93EDZ4gUpfzctE96alOBLUErqubBdXvlDFSV+xS3rlHPfe7t4fF2npFZv7rQiHHKrRcTaBtxxXUcUHMzffXQ9GQ+O0X9etsO87oBRWLYfWvh39Qv2172IHTJSnbCqGcPj6TZS8THWVFdhjxMxUPlsrbu5hi2gK71JstXK4kwwFq4hhFX8vwlOpqXY04dI0v7WvPvUSooCdwhVkwexhU571/0/C2Kat6hvLhah8MZNlkuOlYnW60auQnyx/URLA==;5:Psn4iBX2H4qgFQikmYyP//GSyBp62nnSIKE0H/GNCLfxORBGD7c2KT4eYJPQsQpUtUsq2fPt9G/yBjrLoVgQVfCjQ3N1jCxwa4N75NPVEqOsafmQhoFPr10mAjWD6hGYovSrI2ESYrotfbpS6fZquBQjdBTS8U29d+th8Jgm18pAZsdX4QAAze/jaoZv0vxegC1Swnz0Qk3sXest4BlILg==;7:YM5enfxz1CgVIMZvJBvgl0HVotsm++0XQ/cEmksb3mHZgA2uaO7KsqTLb92HMB86z8Ll9y3+rEGhZZ4xw98NWcFWacRRTSiM6LD3yeE6qpbheKLrJNp2aBtLCEU424yNCd6bjevY7CAPTOYIDyqW2Q==
x-ms-office365-filtering-correlation-id: 7a9e9f6a-9e57-46f1-0280-08d67a2a7241
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4193;
x-ms-traffictypediagnostic: AM0PR08MB4193:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB4193900F4A054C11E154BD23F0800@AM0PR08MB4193.eurprd08.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(256004)(14454004)(6436002)(8676002)(14444005)(81166006)(33896004)(5660300001)(52116002)(76176011)(66066001)(6246003)(86362001)(53936002)(305945005)(2906002)(81156014)(93886005)(72206003)(217873002)(106356001)(105586002)(386003)(229853002)(6486002)(102836004)(6506007)(26005)(186003)(6916009)(9686003)(6512007)(478600001)(68736007)(58126008)(3846002)(6116002)(54906003)(316002)(8936002)(446003)(44832011)(11346002)(476003)(1076003)(30864003)(4326008)(71190400001)(486006)(25786009)(71200400001)(99286004)(7736002)(7416002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4193;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vfvzmLjcKpkpkh/8L4d8gwMnozVibOe1NAFc+9z7bW9aWd5nlxLQZAuGh09GWxKYG5hNpq3oCaimWt+nFH8pJOye+TbyzEVXgBthpN6H1utfLGm3B/QK+cb8mCXwm0c0Cr10etDVfdjPWsfx7o7Iuu1pvyQmW13JZBEuLV4V/DceVh3HX6MiL2Q6b87zbfOk3BX9yOV9kpKlrLRad6zpKAfj+jyKOpo+J3FIKrjG9AoGm2fhsc5oA8GzhMwpNAbpI2oJvCXVaea1w4PcaaOKz/yAUjHYLRW+orX5kc/JJdUNG5ts0mTFxez0cBrzcMed+Jw4hTZclePpmbfY2fZSt31ccTvg9pbhYCW4zZf/T0yPVoF9lRONWp73ZN4kHIq+9KKis0tH6rfD4io0XGkIuCwECmyxflsHjU4XtwsBDAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D52731C6EC69314280656FE2D9035D52@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9e9f6a-9e57-46f1-0280-08d67a2a7241
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 14:13:23.8978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On Mon, Jan 14, 2019 at 02:23:46PM +0200, Jani Nikula wrote:
> On Fri, 11 Jan 2019, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > On Thu, Jan 03, 2019 at 05:44:26PM -0300, Ezequiel Garcia wrote:
> >> Hi Liviu,
> >>=20
> >> On Mon, 2018-12-03 at 11:31 +0000, Ayan Halder wrote:
> >> > From: Brian Starkey <brian.starkey@arm.com>
> >> >=20
> >> > AFBC is a flexible, proprietary, lossless compression protocol and
> >> > format, with a number of defined DRM format modifiers. To facilitate
> >> > consistency and compatibility between different AFBC producers and
> >> > consumers, document the expectations for usage of the AFBC DRM forma=
t
> >> > modifiers in a new .rst chapter.
> >> >=20
> >> > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> >> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> >> > ---
> >>=20
> >> I can't find this commit anywhere. Did you decide to reject
> >> this or perhaps it just fell thru the cracks?
> >
> > Cracks have opened wide enough to let this through, sorry about that!
> >
> > I've now sent a pull request to get it merged.
>=20
> Okay, so this is a very late comment, so feel free to ignore or,
> perhaps, add a change on top.
>=20
> Documentation/gpu mostly contains files that document high level stuff,
> mostly one file per driver (with names matching the directories under
> drivers/gpu/drm) or one file per drm core functional area.
>=20
> Perhaps start an arm.rst, or at least name it more descriptively, say
> arm-fbc.rst? Contrast msm-crash-dump.rst.

I did deliberately put it at the top-level, as AFBC is implemented by
IPs from many different vendors. The intention of this file is to try
and ensure interop between those different vendors' drivers. I fear
that if we namespace it 'arm' then it will be regarded as
Arm-specific, whereas it's meant to set the standard for the AFBC
implementations in all vendors' DRM drivers. That only applies if they
use the AFBC modifiers Arm has defined, but IMO that's what we should
be pushing for instead of having each vendor define their own local
AFBC modifiers, because that will make interop a nightmare. The Arm
definitions should cover all conformant implementations.

AFBC is a relatively well-established name, whereas arm-fbc is not a
term anyone will be familiar with. We could name the file
"arm-afbc.rst", though I am slightly against namespacing it that way
for the reason mentioned above - it does/will/should apply to more
than just the gpu/drm/arm tree.

Best regards,
-Brian

>=20
> BR,
> Jani.
>=20
>=20
> >
> > Best regards,
> > Liviu
> >
> >>=20
> >> Thanks!
> >> Ezequiel
> >>=20
> >>=20
> >> >  Documentation/gpu/afbc.rst    | 233 +++++++++++++++++++++++++++++++=
+++++++++++
> >> >  Documentation/gpu/drivers.rst |   1 +
> >> >  MAINTAINERS                   |   1 +
> >> >  include/uapi/drm/drm_fourcc.h |   3 +
> >> >  4 files changed, 238 insertions(+)
> >> >  create mode 100644 Documentation/gpu/afbc.rst
> >> >=20
> >> > diff --git a/Documentation/gpu/afbc.rst b/Documentation/gpu/afbc.rst
> >> > new file mode 100644
> >> > index 0000000..922d955
> >> > --- /dev/null
> >> > +++ b/Documentation/gpu/afbc.rst
> >> > @@ -0,0 +1,233 @@
> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > + Arm Framebuffer Compression (AFBC)
> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > +
> >> > +AFBC is a proprietary lossless image compression protocol and forma=
t.
> >> > +It provides fine-grained random access and minimizes the amount of
> >> > +data transferred between IP blocks.
> >> > +
> >> > +AFBC can be enabled on drivers which support it via use of the AFBC
> >> > +format modifiers defined in drm_fourcc.h. See DRM_FORMAT_MOD_ARM_AF=
BC(*).
> >> > +
> >> > +All users of the AFBC modifiers must follow the usage guidelines la=
id
> >> > +out in this document, to ensure compatibility across different AFBC
> >> > +producers and consumers.
> >> > +
> >> > +Components and Ordering
> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> > +
> >> > +AFBC streams can contain several components - where a component
> >> > +corresponds to a color channel (i.e. R, G, B, X, A, Y, Cb, Cr).
> >> > +The assignment of input/output color channels must be consistent
> >> > +between the encoder and the decoder for correct operation, otherwis=
e
> >> > +the consumer will interpret the decoded data incorrectly.
> >> > +
> >> > +Furthermore, when the lossless colorspace transform is used
> >> > +(AFBC_FORMAT_MOD_YTR, which should be enabled for RGB buffers for
> >> > +maximum compression efficiency), the component order must be:
> >> > +
> >> > + * Component 0: R
> >> > + * Component 1: G
> >> > + * Component 2: B
> >> > +
> >> > +The component ordering is communicated via the fourcc code in the
> >> > +fourcc:modifier pair. In general, component '0' is considered to
> >> > +reside in the least-significant bits of the corresponding linear
> >> > +format. For example, COMP(bits):
> >> > +
> >> > + * DRM_FORMAT_ABGR8888
> >> > +
> >> > +   * Component 0: R(8)
> >> > +   * Component 1: G(8)
> >> > +   * Component 2: B(8)
> >> > +   * Component 3: A(8)
> >> > +
> >> > + * DRM_FORMAT_BGR888
> >> > +
> >> > +   * Component 0: R(8)
> >> > +   * Component 1: G(8)
> >> > +   * Component 2: B(8)
> >> > +
> >> > + * DRM_FORMAT_YUYV
> >> > +
> >> > +   * Component 0: Y(8)
> >> > +   * Component 1: Cb(8, 2x1 subsampled)
> >> > +   * Component 2: Cr(8, 2x1 subsampled)
> >> > +
> >> > +In AFBC, 'X' components are not treated any differently from any ot=
her
> >> > +component. Therefore, an AFBC buffer with fourcc DRM_FORMAT_XBGR888=
8
> >> > +encodes with 4 components, like so:
> >> > +
> >> > + * DRM_FORMAT_XBGR8888
> >> > +
> >> > +   * Component 0: R(8)
> >> > +   * Component 1: G(8)
> >> > +   * Component 2: B(8)
> >> > +   * Component 3: X(8)
> >> > +
> >> > +Please note, however, that the inclusion of a "wasted" 'X' channel =
is
> >> > +bad for compression efficiency, and so it's recommended to avoid
> >> > +formats containing 'X' bits. If a fourth component is
> >> > +required/expected by the encoder/decoder, then it is recommended to
> >> > +instead use an equivalent format with alpha, setting all alpha bits=
 to
> >> > +'1'. If there is no requirement for a fourth component, then a form=
at
> >> > +which doesn't include alpha can be used, e.g. DRM_FORMAT_BGR888.
> >> > +
> >> > +Number of Planes
> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > +
> >> > +Formats which are typically multi-planar in linear layouts (e.g. YU=
V
> >> > +420), can be encoded into one, or multiple, AFBC planes. As with
> >> > +component order, the encoder and decoder must agree about the numbe=
r
> >> > +of planes in order to correctly decode the buffer. The fourcc code =
is
> >> > +used to determine the number of encoded planes in an AFBC buffer,
> >> > +matching the number of planes for the linear (unmodified) format.
> >> > +Within each plane, the component ordering also follows the fourcc
> >> > +code:
> >> > +
> >> > +For example:
> >> > +
> >> > + * DRM_FORMAT_YUYV: nplanes =3D 1
> >> > +
> >> > +   * Plane 0:
> >> > +
> >> > +     * Component 0: Y(8)
> >> > +     * Component 1: Cb(8, 2x1 subsampled)
> >> > +     * Component 2: Cr(8, 2x1 subsampled)
> >> > +
> >> > + * DRM_FORMAT_NV12: nplanes =3D 2
> >> > +
> >> > +   * Plane 0:
> >> > +
> >> > +     * Component 0: Y(8)
> >> > +
> >> > +   * Plane 1:
> >> > +
> >> > +     * Component 0: Cb(8, 2x1 subsampled)
> >> > +     * Component 1: Cr(8, 2x1 subsampled)
> >> > +
> >> > +Cross-device interoperability
> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> > +
> >> > +For maximum compatibility across devices, the table below defines
> >> > +canonical formats for use between AFBC-enabled devices. Formats whi=
ch
> >> > +are listed here must be used exactly as specified when using the AF=
BC
> >> > +modifiers. Formats which are not listed should be avoided.
> >> > +
> >> > +.. flat-table:: AFBC formats
> >> > +
> >> > +   * - Fourcc code
> >> > +     - Description
> >> > +     - Planes/Components
> >> > +
> >> > +   * - DRM_FORMAT_ABGR2101010
> >> > +     - 10-bit per component RGB, with 2-bit alpha
> >> > +     - Plane 0: 4 components
> >> > +              * Component 0: R(10)
> >> > +              * Component 1: G(10)
> >> > +              * Component 2: B(10)
> >> > +              * Component 3: A(2)
> >> > +
> >> > +   * - DRM_FORMAT_ABGR8888
> >> > +     - 8-bit per component RGB, with 8-bit alpha
> >> > +     - Plane 0: 4 components
> >> > +              * Component 0: R(8)
> >> > +              * Component 1: G(8)
> >> > +              * Component 2: B(8)
> >> > +              * Component 3: A(8)
> >> > +
> >> > +   * - DRM_FORMAT_BGR888
> >> > +     - 8-bit per component RGB
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: R(8)
> >> > +              * Component 1: G(8)
> >> > +              * Component 2: B(8)
> >> > +
> >> > +   * - DRM_FORMAT_BGR565
> >> > +     - 5/6-bit per component RGB
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: R(5)
> >> > +              * Component 1: G(6)
> >> > +              * Component 2: B(5)
> >> > +
> >> > +   * - DRM_FORMAT_ABGR1555
> >> > +     - 5-bit per component RGB, with 1-bit alpha
> >> > +     - Plane 0: 4 components
> >> > +              * Component 0: R(5)
> >> > +              * Component 1: G(5)
> >> > +              * Component 2: B(5)
> >> > +              * Component 3: A(1)
> >> > +
> >> > +   * - DRM_FORMAT_VUY888
> >> > +     - 8-bit per component YCbCr 444, single plane
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: Y(8)
> >> > +              * Component 1: Cb(8)
> >> > +              * Component 2: Cr(8)
> >> > +
> >> > +   * - DRM_FORMAT_VUY101010
> >> > +     - 10-bit per component YCbCr 444, single plane
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: Y(10)
> >> > +              * Component 1: Cb(10)
> >> > +              * Component 2: Cr(10)
> >> > +
> >> > +   * - DRM_FORMAT_YUYV
> >> > +     - 8-bit per component YCbCr 422, single plane
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: Y(8)
> >> > +              * Component 1: Cb(8, 2x1 subsampled)
> >> > +              * Component 2: Cr(8, 2x1 subsampled)
> >> > +
> >> > +   * - DRM_FORMAT_NV16
> >> > +     - 8-bit per component YCbCr 422, two plane
> >> > +     - Plane 0: 1 component
> >> > +              * Component 0: Y(8)
> >> > +       Plane 1: 2 components
> >> > +              * Component 0: Cb(8, 2x1 subsampled)
> >> > +              * Component 1: Cr(8, 2x1 subsampled)
> >> > +
> >> > +   * - DRM_FORMAT_Y210
> >> > +     - 10-bit per component YCbCr 422, single plane
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: Y(10)
> >> > +              * Component 1: Cb(10, 2x1 subsampled)
> >> > +              * Component 2: Cr(10, 2x1 subsampled)
> >> > +
> >> > +   * - DRM_FORMAT_P210
> >> > +     - 10-bit per component YCbCr 422, two plane
> >> > +     - Plane 0: 1 component
> >> > +              * Component 0: Y(10)
> >> > +       Plane 1: 2 components
> >> > +              * Component 0: Cb(10, 2x1 subsampled)
> >> > +              * Component 1: Cr(10, 2x1 subsampled)
> >> > +
> >> > +   * - DRM_FORMAT_YUV420_8BIT
> >> > +     - 8-bit per component YCbCr 420, single plane
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: Y(8)
> >> > +              * Component 1: Cb(8, 2x2 subsampled)
> >> > +              * Component 2: Cr(8, 2x2 subsampled)
> >> > +
> >> > +   * - DRM_FORMAT_YUV420_10BIT
> >> > +     - 10-bit per component YCbCr 420, single plane
> >> > +     - Plane 0: 3 components
> >> > +              * Component 0: Y(10)
> >> > +              * Component 1: Cb(10, 2x2 subsampled)
> >> > +              * Component 2: Cr(10, 2x2 subsampled)
> >> > +
> >> > +   * - DRM_FORMAT_NV12
> >> > +     - 8-bit per component YCbCr 420, two plane
> >> > +     - Plane 0: 1 component
> >> > +              * Component 0: Y(8)
> >> > +       Plane 1: 2 components
> >> > +              * Component 0: Cb(8, 2x2 subsampled)
> >> > +              * Component 1: Cr(8, 2x2 subsampled)
> >> > +
> >> > +   * - DRM_FORMAT_P010
> >> > +     - 10-bit per component YCbCr 420, two plane
> >> > +     - Plane 0: 1 component
> >> > +              * Component 0: Y(10)
> >> > +       Plane 1: 2 components
> >> > +              * Component 0: Cb(10, 2x2 subsampled)
> >> > +              * Component 1: Cr(10, 2x2 subsampled)
> >> > diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drive=
rs.rst
> >> > index 7c16721..c176b34 100644
> >> > --- a/Documentation/gpu/drivers.rst
> >> > +++ b/Documentation/gpu/drivers.rst
> >> > @@ -17,6 +17,7 @@ GPU Driver Documentation
> >> >     vkms
> >> >     bridge/dw-hdmi
> >> >     xen-front
> >> > +   afbc
> >> > =20
> >> >  .. only::  subproject and html
> >> > =20
> >> > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > index 254b7b2..aef18e3 100644
> >> > --- a/MAINTAINERS
> >> > +++ b/MAINTAINERS
> >> > @@ -1131,6 +1131,7 @@ M:	Mali DP Maintainers <malidp@foss.arm.com>
> >> >  S:	Supported
> >> >  F:	drivers/gpu/drm/arm/
> >> >  F:	Documentation/devicetree/bindings/display/arm,malidp.txt
> >> > +F:	Documentation/gpu/afbc.rst
> >> > =20
> >> >  ARM MFM AND FLOPPY DRIVERS
> >> >  M:	Ian Molton <spyro@f2s.com>
> >> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fo=
urcc.h
> >> > index 75c4b5a..0adde4d 100644
> >> > --- a/include/uapi/drm/drm_fourcc.h
> >> > +++ b/include/uapi/drm/drm_fourcc.h
> >> > @@ -597,6 +597,9 @@ extern "C" {
> >> >   * AFBC has several features which may be supported and/or used, wh=
ich are
> >> >   * represented using bits in the modifier. Not all combinations are=
 valid,
> >> >   * and different devices or use-cases may support different combina=
tions.
> >> > + *
> >> > + * Further information on the use of AFBC modifiers can be found in
> >> > + * Documentation/gpu/afbc.rst
> >> >   */
> >> >  #define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, _=
_afbc_mode)
> >> > =20
> >>=20
> >>=20
>=20
> --=20
> Jani Nikula, Intel Open Source Graphics Center
