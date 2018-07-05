Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB00C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C319B24053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZjaWy6ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C319B24053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeGEQVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:21:09 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:62174
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753400AbeGEQVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAiCimhZ5Ub0+W3SIzqMX9Y9pfnEJ5aRiJ2kW7lP70c=;
 b=ZjaWy6ia8R8DFvjvII64tPAgKGgI1c9GhCx3KW4DRN511ZjDt2erk5GNAQAfatCkwkNTVjrQgGOV3I0GqHsAs2ca2GevUV3lfL2eBF9H4RjV9qojia49o25clTgvgjDeY+4bOL/HlmXfnJU1RiO6OipiWo8cL6tASKEIxwk+34E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from localhost (217.140.96.140) by
 HE1PR0801MB1388.eurprd08.prod.outlook.com (2603:10a6:3:3a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Thu, 5 Jul 2018 16:21:00 +0000
Date:   Thu, 5 Jul 2018 17:20:56 +0100
From:   Ayan Halder <ayan.halder@arm.com>
To:     liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [RFC PATCH v2] drm/arm/malidp: Added support for AFBC modifiers
 for all layers except DE_SMART
Message-ID: <20180705162056.GA18005@arm.com>
References: <1530800743-2250-1-git-send-email-ayan.halder@arm.com>
 <20180705154822.GC4273@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705154822.GC4273@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: PR0P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::24) To HE1PR0801MB1388.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aac86b3a-afa9-4078-75cd-08d5e2934c07
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1388;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1388;3:MrJ2M71if2WhU19isJJ/3SQYJKYMwdn6TJEtFo9j8O3zENo78GRF1nms1yoyM7ydkuCuwwXEeqaq/nazpOvXExrJQmeUHhxoz2IeUn0SV955N5Rxy0yKIGthHOkIUOlSjPql2Nh5jge77ejKBbtwSozogdGUEgqgCL6p4nbDLej8GV6gU5C5KscWAVkTyfrqBWVZ3Ardtvc8nuQhRO3NgpMRRkIfvqXGavbqWtBLuoh9fnrwRrpPxko01KUQEQDj;25:c8oqEqCTBjYxfLHXw/fhlw2vN3fztHHU7W7cSzWYOTb65ihdSDHHAPsA9Fx0aC7tkyuKXLFdBpmvojug6Wt/peSwR7yJ92aKQBBwVtCN53hV1oJg15FmONg/N8e8K2md6d2FMoyoRCVw7dm+DocUuHkyTp87QkQXfZB5S8TiN9/h7bHd4PBCV0rw1HcmY/BpUOdifEOzBQRbFNyxve6M+CKVBRUYUsCozTQgRKHAnqxFmBp1WC0rEXlnj0bOzDEtmLy1lpZ0LoCWIQDqpSfCcZqa8OjZhkSsV/PjF0mwUkkKWz6wM8IFKHQ9ug6ZdhMU9hd5T+pnQO6IzAGeRjplZg==;31:WVMDYs/8K0PQtZhv0lPct4AmPcy14tM4+pbEI59EKOa8jB/WtjECQ+JK61sQFaAKXzKMHWO/lje2dgnARhZCvIU8cSV4nL4+EFQZ1cQi7fb/lJ9YVBdYVAHKSP3WzJb0B2S5kyxekb101sBz19xqHAHuUiPpeV/mY3V/Ivez+ELnCAJaXsdgL3YJyOvSa0ZVMLwxJYBE8/6+TJwSgwusYZUPMzX6BXTu00PbdEQBcfQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1388:
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1388;20:FXAXHF0xpeL1wK11EUiSu+mOOtF2seipyUpCDGnWdxBJSz+WyEwmcVJTP742/ipQwGbsFrKupXm/RmRIcmR5eZ8crK49eDcFnv0qqZStbvPLd+XBTEr8yFgdgWKh9Ck2kZ+us3Wvws37SLn4mj8Dz4qpj7Uxd7eisgKvg7X6MHbPiD0IU7hz962wZssnZZ4h1xAEdC/jg3SPWl8bLwlcConnPlVzIe0lq2+PyNKCiEsRon1H0YXGBTPc7KcpqMv6rMnA2beiDI5fUD8eqOdfjqphH6GR1H3Ps/1moAwGaoYH2IAUqb2QznH+o+MJ0y+fomwI5Li63A/kDhXE4cqa2sfvCuRmAf+n9sQxuo6sgx/rWz6nivCpEtFlHKm5zscII7+XXMOM2JrWr474YEuGmcdmWRrGpCHwZwCI355WbSiacmvBqhAbD8LCX84vKD2tfO7L3WaLcPltabKfLUQrxlTHs0YKHz26YmLbWMJ0KO16c/PKQrqdr+M0mac8MacT;4:GjcnU+/s+/e3dRp5wiO4hkxctLNIRliht01/gl6H4zhVJFJFMhd3S1EQw6QH0Cf6oPZJhw6QVUk/RBUGnXey3Mwak6qURKjnrXu/CXpn3ppglfjtJn1KDs1MbVp3SKvVwOtrW17egyGP3qTYOJMuwztGSz2mC1ZVAmDwvad88LR+i2JPxcoNUoCj8VemO0LbX6NdlNUY0TP92bs7ZA0JJMa0f86P2pNN4bCzt5TRbAoPN7tfekzx2FO4UE6HZ7YVBUkeLp6L7uxTiBXVLNPBQ1SxnJchR/gfXqa6WDbOqDRL8Bv0EAyyjsvkKNE3xTPblkDrO2WDNa2kDLmt+jXcI762tBiIswoBUbZyEGH/sPB/e13qneaIyTnfayx9LGsP
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1388009787C0E880B0F64F44E4400@HE1PR0801MB1388.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(223705240517415)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1388;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1388;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(346002)(376002)(396003)(136003)(39860400002)(40434004)(199004)(189003)(58126008)(11346002)(8936002)(8746002)(81156014)(8676002)(316002)(81166006)(66066001)(47776003)(305945005)(587094005)(14444005)(16526019)(105586002)(6636002)(1076002)(6666003)(6116002)(50466002)(23726003)(476003)(26005)(7736002)(68736007)(2906002)(5660300001)(3846002)(956004)(486006)(2616005)(386003)(446003)(44832011)(106356001)(36756003)(966005)(86362001)(76506005)(478600001)(6496006)(97736004)(52116002)(76176011)(6306002)(6486002)(53386004)(6246003)(229853002)(5024004)(45080400002)(53936002)(25786009)(33656002)(72206003)(18370500001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1388;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1388;23:4CoH8j+rPDNsYWBWC+Yvqt0pKFFKUG7YWJDH7Nv?=
 =?us-ascii?Q?1Ky25ApGiOIfEkUxVpA58innhtj+vxM/dKnIaMBucFEZlnqbnBUX5gemgbdQ?=
 =?us-ascii?Q?naI5U2rDvX9pUaz0707KMplfV6B4JcKVlcUaJaZ1xYvx8pBVS2ghpDCTKkbF?=
 =?us-ascii?Q?38n7dLFDLFBMW9hj46ZkSa2IOGDcmXn11Lpw4i5twr/2yZiP/bghS1ulcwyC?=
 =?us-ascii?Q?xNjr0imsw6rGoF2OVvQmqVXsoq4lCaWP/KHe63H6X5r63n3i3yW6fTq70C2t?=
 =?us-ascii?Q?BzvZ6x+Z99DhaL+nqxpddXOT2iUwFTSwbo7fOLzeBBZt2lRqJ1Lou0X4bw69?=
 =?us-ascii?Q?7Nnbq5uegJ+1hzWY9Blezm3wLQyj5Kb0K06wgsKvTjpgHtEvGCiAkbqmkivd?=
 =?us-ascii?Q?OcUGZxlX0KdW9TJCusJFJOyADNPSpRPvDR6BSYp+XDPUqyy/9/zyRqyclARK?=
 =?us-ascii?Q?BKCfUUvpW83zG1Xi4YqoMEn0FeqvODj36XbE23yPtflsgxCKCBSyVKjBCWQY?=
 =?us-ascii?Q?ltuJxeSLNmYG2Q1GCdivLTkyJm52KVBXACcS97YvMfaJjdpGJ4QdR0PDhB0M?=
 =?us-ascii?Q?JlYWQGBMR5DZdEbvZYJXalI5+VCwyNuH2LdPF+j7H6CwreIR4+kS2rjg2g//?=
 =?us-ascii?Q?44hFgzUA3y1O1Wiwmuj6n8mFM0+AZxMxLLnnUdMAQDrbKHHBYGkdmBg7Zf6f?=
 =?us-ascii?Q?UVXH89C3AdC/UjSiOgg4GMTDASrIVSH6tCMSuQXstE0K9X3j11ACWBXk/VgH?=
 =?us-ascii?Q?mcrmlE1nm2Oxk/xLsDrGHhasPRzIkHfwFWA/TMSKxNVBU5VVHnRnyjOwpoZr?=
 =?us-ascii?Q?N8A4CCVtV9N/SY2ijrz3SKonh4RAoWOolQmdaHsuZe6LHNATs92jVkIPLPH3?=
 =?us-ascii?Q?51gZ2L9Do80nGjbVzs8BSIsXPHi621AFE1AfSpQLHBqxm3UfHnbdRUaxMDs2?=
 =?us-ascii?Q?0ug6qLl1NKVELmSCAwSB/5EjrFYGeHAIWa+Bf6VUUc/KxFgg6Gx6bwhiNOrd?=
 =?us-ascii?Q?P84osh1lRMKhl20txFnieXfHRhZtwSZ+Q/h1M6ZYSY3/vwJWcybZilrTkp8n?=
 =?us-ascii?Q?dl2Hqrw9MGgDgXBadNJjzf33i99WISgBrgOuUpSs8G0BItbHcWY+vI9zxgzk?=
 =?us-ascii?Q?QOovAvhBGVFBSibc5yMvXs+W7OkK2FcSz+H4I0zt0LDyRZbYez5gpWD4zMZ5?=
 =?us-ascii?Q?JE4+DG39UmfjmdjMTC7mknpv50XBOxrIeBnKLd1NYXloG7Qf9UNTV29ojjrG?=
 =?us-ascii?Q?aJeDiFCav2cZGLiGTV5GCOkDvlGZ56UuTrNyP5B4/YELfF3RirUElslM/FEb?=
 =?us-ascii?Q?951QIVODkd0sUAgazxVuCMqQpqFkoNr2UNYOddsyPSXycMH30U1CV+KEYu5T?=
 =?us-ascii?Q?EV1TUaWnA8VvfiEgqm8zIO+wfGxjR8WPBOnms4hz7QmY8mlcCJzavcN3Ihgj?=
 =?us-ascii?Q?qI/1Uo5iPom/Tz/gBNaBVQjB51tpnSFgb2wnBg+8oa0EAlkg4QA3F?=
X-Microsoft-Antispam-Message-Info: pky3pAgysLqeDLZPm4kJURQy0CzX9sEABWgqVbTslp0UWsAlYaDJdTuG50Qd96G+oMA9eCxkyY1mgw7eKHcZ0caK+1A4mvEw1WMclHrqs1Uk1lNXbIut9LfuiVE6jkRudZN1oLJu2TfeHS5bZw+isrrzTPXMGHWlwsLeB/A/CpcBLbI5Jyl+bl0gq12vXdU26Ok3tCTXaT9nDGZSBQCeL+lICmxuuPsVSIBQW50E6yYucozlRF2L1DQedVk+iU5hCtaFw5PVupHjCA4HrjF42NbyQbwdvkZbAxrHA1xHpuD4TnuLaO5AI4tFn34+yfIlZfYaM4WQ8Pci1JOHRVWMCHNAOzSA4Pq4aVHSPaIfz2E=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1388;6:zOmpV0eE7bx1WrUZbzDWS9/tzpXUqGwysAeLFdZrht1nUQ9icd8u7BTS9HDEyUpZSr/SPs+KF8MKu9SMTQYOOVeceUNZKVHtk4dVH4+sECUfE3VfPOPZHbYZq1+5McGcipyGcYFh2Lb2SpENWoiJqEsjNCTfQbqGmD18MYx28n8WRhu1/r2md4TQ96CnmxkDudvFkGYmpkbiHJ8Otktr2qG0pKVD+sruTjK1N455oHrlh41Jjy6Xj4QGlXAjNCNsdFv5zwgxUv819KxeueGrllxkd4ofYo1O8NEEFqIAyr66KoR1D1zVL26hAe2Eq0kWDpM4k8D+KNIE4wnMVCVxQZNZKQ+0UxDYlsHDAKnbur3p4voMMkSEJzpbHhWnYY5v3+pNAu4asrRMjFA2EZxsxgye2ZNRygJD32Be2sdDNJK8RUu7Pj9p4hS0aWp/zOljIUMpkGuAxHc9DUSf6dAPqg==;5:ZTLAC8rqBa44cXrsAfLgH2+flmwcantWPiHE/rrPwrtwYizsskw+G139XRP6C2NhUT6J6hvGCc00/Z6dWVWZUBy1La+qxnLPF4DpoOYUmLtpZcyI04qCQnAzQPvf/mPSLk3LFvZbL7Ri38pgHdlY83cUlZMBVowHO5+ReYmyBmI=;24:tcgVmhMLIF8xjnn4k15mBTpGJYIkR66DI5SX6KTAYMEIb0SfHgOpaLrJAxl1CZpZRd8gv3mpLjgrToW3zqxvnftoYGbSfvu9RLPiOxVeBAc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1388;7:TeOD4CIMvH7myriZk6uSWOfxTWvBOZqY8fYiIvQwOhdfearz/PzxCGzpbfiFNqFy8h0MSI+pmAFvYim4cce0efx6POXw7CjCJ2oUNVycD8RVfWIsvz60md/yZJXaIKAYP0/jkW/l3TB9lE1RnXwR30PkszzSrrzGDiKv0vftfogqiDVHoYb8YuYgSeFcDUCp3BLCBTPavfynPvZqWk7OgbOxNb8l/LUULvpAlpn+RJ0XwvM5mPMttz0wCPokrXXY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 16:21:00.5219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac86b3a-afa9-4078-75cd-08d5e2934c07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1388
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:48:22PM +0200, Daniel Vetter wrote:
> On Thu, Jul 05, 2018 at 03:25:43PM +0100, Ayan Kumar Halder wrote:
> > On planes which support AFBC, expose an AFBC modifier for use with BGR8=
88.
> >
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> >
> > Changes from v2:
> > - Removed the gerrit change-id
> > - Replaced DRM_ERROR() with DRM_DEBUG_KMS() in malidp_format_mod_suppor=
ted()
> > to report unsupported modifiers.
> > ---
> >  drivers/gpu/drm/arm/malidp_drv.c    |  1 +
> >  drivers/gpu/drm/arm/malidp_planes.c | 46 +++++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/mal=
idp_drv.c
> > index 7b6a848..7bcd679 100644
> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > @@ -392,6 +392,7 @@ static int malidp_init(struct drm_device *drm)
> >     drm->mode_config.max_height =3D hwdev->max_line_size;
> >     drm->mode_config.funcs =3D &malidp_mode_config_funcs;
> >     drm->mode_config.helper_private =3D &malidp_mode_config_helpers;
> > +   drm->mode_config.allow_fb_modifiers =3D true;
> >
> >     ret =3D malidp_crtc_init(drm);
> >     if (ret) {
> > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/=
malidp_planes.c
> > index 3950504..914cc58 100644
> > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > @@ -124,6 +124,35 @@ static void malidp_plane_atomic_print_state(struct=
 drm_printer *p,
> >     drm_printf(p, "\tn_planes=3D%u\n", ms->n_planes);
> >  }
> >
> > +static bool malidp_format_mod_supported(struct drm_plane *plane,
> > +                                   u32 format, u64 modifier)
> > +{
> > +   if (WARN_ON(modifier =3D=3D DRM_FORMAT_MOD_INVALID))
> > +           return false;
> > +
> > +   /* All the pixel formats are supported without any modifier */
> > +   if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)
> > +           return true;
> > +
> > +   if ((modifier >> 56) !=3D DRM_FORMAT_MOD_VENDOR_ARM)
> > +           return false;
> > +
> > +   if (modifier &
> > +       ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> > +           DRM_DEBUG_KMS("Unsupported modifiers\n");
> > +           return false;
> > +   }
>
> I think the core checks for that by now, or at least Ville had some
> patches to make that happen ...

Can you paste the link (or atleast the title) of the patches that you
are referring to ? I might then have to rework on this.
> I also don't see the ARM_AFBC modifier in upstream yet, is that still
> in-flight somewhere?

I realized that I was missing the ack on my first patch of the series
(ie
https://lists.freedesktop.org/archives/dri-devel/2018-June/180125.html)
and the reason I believe is that I did not put the correct email
addresses in "--to" for the drm_fourcc.h maintainers. I will resend the
patch and wait for their ack.

> -Daniel
>
> > +
> > +   switch (modifier) {
> > +   case DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> > +                           AFBC_FORMAT_MOD_YTR |
> > +                           AFBC_FORMAT_MOD_SPARSE):
> > +           if (format =3D=3D DRM_FORMAT_BGR888)
> > +                   return true;
> > +   }
> > +   return false;
> > +}
> > +
> >  static const struct drm_plane_funcs malidp_de_plane_funcs =3D {
> >     .update_plane =3D drm_atomic_helper_update_plane,
> >     .disable_plane =3D drm_atomic_helper_disable_plane,
> > @@ -132,6 +161,7 @@ static const struct drm_plane_funcs malidp_de_plane=
_funcs =3D {
> >     .atomic_duplicate_state =3D malidp_duplicate_plane_state,
> >     .atomic_destroy_state =3D malidp_destroy_plane_state,
> >     .atomic_print_state =3D malidp_plane_atomic_print_state,
> > +   .format_mod_supported =3D malidp_format_mod_supported,
> >  };
> >
> >  static int malidp_se_check_scaling(struct malidp_plane *mp,
> > @@ -524,6 +554,13 @@ int malidp_de_planes_init(struct drm_device *drm)
> >     u32 *formats;
> >     int ret, i, j, n;
> >
> > +   static const u64 modifiers[] =3D {
> > +           DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> > +                   AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPARSE),
> > +           DRM_FORMAT_MOD_LINEAR,
> > +           DRM_FORMAT_MOD_INVALID
> > +   };
> > +
> >     formats =3D kcalloc(map->n_pixel_formats, sizeof(*formats), GFP_KER=
NEL);
> >     if (!formats) {
> >             ret =3D -ENOMEM;
> > @@ -547,9 +584,14 @@ int malidp_de_planes_init(struct drm_device *drm)
> >
> >             plane_type =3D (i =3D=3D 0) ? DRM_PLANE_TYPE_PRIMARY :
> >                                     DRM_PLANE_TYPE_OVERLAY;
> > +
> > +           /*
> > +            * All the layers except smart layer supports AFBC modifier=
s.
> > +            */
> >             ret =3D drm_universal_plane_init(drm, &plane->base, crtcs,
> > -                                          &malidp_de_plane_funcs, form=
ats,
> > -                                          n, NULL, plane_type, NULL);
> > +                           &malidp_de_plane_funcs, formats, n,
> > +                           (id =3D=3D DE_SMART) ? NULL : modifiers, pl=
ane_type, NULL);
> > +
> >             if (ret < 0)
> >                     goto cleanup;
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
