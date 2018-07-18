Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B667ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF52720854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jrPpbSe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF52720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbeGRPTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:19:17 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:36911
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729667AbeGRPTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubDboFq4t/e3+BNBuNflcsglLYk2UTRn5064FsD5YJo=;
 b=jrPpbSe40AM/HLL1tX92BWsyOWO3+7VCkymLcvOipfoY+yTl4Uqwo/3mUxq/docDDaTDGbScJFbd8J7P4HWLVwv2o0m2w9I9NlIbOFV0p4827HogTDpNuNZ6URFyrZtvLlSWesIflXMsAN4SKaM8xAVQ0w17EEmiT+o7HsVsNt8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from localhost (217.140.96.140) by
 HE1PR0801MB1387.eurprd08.prod.outlook.com (2603:10a6:3:3a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Wed, 18 Jul 2018 14:40:54 +0000
Date:   Wed, 18 Jul 2018 15:40:51 +0100
From:   Ayan Halder <ayan.halder@arm.com>
To:     Ville Syrj?l? <ville.syrjala@linux.intel.com>
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, hjc@rock-chips.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
        sre@kernel.org, bparrot@ti.com, peter.ujfalusi@ti.com, afd@ti.com,
        dri-devel@lists.freedesktop.org, maxime.ripard@bootlin.com,
        wens@csie.org, malidp@foss.arm.com, nd@arm.com
Subject: Re: [Intel-gfx] [PATCH 5/5] drm/sun4i: Substitute
 sun4i_backend_format_is_yuv() with format->is_yuv
Message-ID: <20180718144050.GA2056@arm.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
 <1531847626-22248-5-git-send-email-ayan.halder@arm.com>
 <20180718101540.GT5565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718101540.GT5565@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: PR2P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::18) To HE1PR0801MB1387.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c956ae-1684-422c-71d7-08d5ecbc77b2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1387;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1387;3:upIaasuPmtrN2Js/miNnOUXaWI/uNU6f9Qk3vAB46cBHH/S7kMBK7l4GsS6ZcYsBMj83MR16+ZwqGtNRaMJKSaeYLa9emdSM6ilV3nU8Z43wPuZC4xvdYKFx3HpxW1qdwAbSIFw3wQn+QSVAvAAHOC0wR+J2KSzTLfTzRQn8XyQOylSrn/zXqwyXGJ2GGOshsJniJTP+GhThYNe6V5YxEi5LogJqySoIkoML53uH99px+W1nwuq/Rlc+2f6UAoy2;25:Qb+NbYFN6WaCPnLsZme+ITPpKXu9y5PGgZA3E0ZotjXHUSlRKk7bpTB4188FlBm5rLyCYA/6dIduj2A+myAg/phLzmHP4OjyzSuMIeK4JnSEfGkz24grHZVjcQi2rBKPq5Akib+MG4XEKV6P9wbrSZ06AZwmGVnf9ie6f6KlVowtH6J//CF0R/CLYIsZpymrztsaklfPQ01L83WR8c0N942/HKvuk34utG32L+kPL7MxZBgsMlK9T0lX9+B/CGHzoGdIsRjg9Bd+oX+ponS59eh/uG4Sw3DW8rJ/D/v55ZkaQLFxjSZg/oHccd32dcXRujL7pH+LFrNT5fMXkvmVBw==;31:s/Nq379/5PP63eEkQJCZun4F32WjUn4GS8At5Hxvwb86CS64KAAbn9aPCHvT3YdBIY/E4eFAsIKwULhJ+ufkFs3npLuJ42tWIsP7cNSXCTM2wDOo1XcAlYdnAu7Svtz+XjmK644Sl5SBzYVFcFpyj5fNtj3tzeTvu9kbGtu7+PulqVon60Li5Yvw1KEwDAG9QdOET5g065U1ERdfP6aDgGLF4+8iRvjUmL48NxLSako=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1387:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1387;20:5nk5o4JEZGoVgU06Q04PlO54cQP3H7HGcDUMrGNeghTMX80ZtlaMJihqoHUCRbX8SX34z3YjOlBbdbXMwlklwL7lpT1N9N95mggwiPFW20u2D+Gplgo+XC0FM1y1BNwqAsrMJMir9gpl0Y/wGWosGnqjbwHQTJdYB0GF/aaGxf4=;4:J6H8aiV4mAJtE7DYCIl+qDtyhxCxJ329PzpEwHWQbbv8ch91evm2EtQgn/ZgcPiGGFvZR/MauxDkiglIx1WfpFb1xJ+Ddt6y+OZ01jU/1QQ1yHILFWXJVsmXinhjTQxuv2RDTKybI4N7GW4uFuVbpLkM4cmy6FTfACTtNoVyW4BNEAx60jfrHbdYPa2dgHqH0sdqTuCxX6Tj4NopJKTwdGQNgymH3XXDa/t+GgtirfjruP2mYAJUAwNyzvTwmVadSBa1/Irbv/1zcp/JHMO6QR7uhZjDF0sGHJuz6MDJs/hopMVGL5CDiTZB6h/TNZgKLSROtwhN6ioIieAqCy7disSOFVuKN7aEsga6Mod2rAg=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1387FA4EB67686F2C2ED7F77E4530@HE1PR0801MB1387.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1387;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1387;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(44832011)(36756003)(8676002)(966005)(478600001)(956004)(11346002)(5660300001)(53936002)(2906002)(72206003)(6246003)(6666003)(47776003)(25786009)(6486002)(7416002)(68736007)(66066001)(476003)(6916009)(33656002)(446003)(4326008)(2616005)(6496006)(6306002)(52116002)(58126008)(8936002)(76506005)(81156014)(575784001)(86362001)(15760500003)(14444005)(305945005)(16586007)(81166006)(229853002)(105586002)(23726003)(3846002)(7736002)(106356001)(486006)(6116002)(1076002)(386003)(16526019)(26005)(186003)(50466002)(97736004)(76176011)(316002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1387;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1387;23:Oaje/6o9UexxLOV46c6ehv8U90SjV2L6oZMG5dO?=
 =?us-ascii?Q?6l6OvwsPcUQ8XAfqcF0k13n4jc6atz90MI9CSY8oWYpVesdWKJSCkEYkCKrp?=
 =?us-ascii?Q?9Msw7MrgOAVwbwkSPPDnWIeYa4hmWkxSl5Gqy0PdU9HkBzFjPDCl7meOPHNE?=
 =?us-ascii?Q?HGUVdnHjjdr6t+812Y4/elqDJFMI96x+Usu2XtBzT3C0fO/T6maePoUxjvyV?=
 =?us-ascii?Q?1TiBhNdug30CW+sCKcEaLyz1etrnDI1dAjMstR1PiA3S2YPciDisgZkDVbZO?=
 =?us-ascii?Q?+WvUb9vbZkyvPBCoDWbPrUoWIrNuQVru7A8M6YRtiCuNGS/ywkUxnsOiGm2A?=
 =?us-ascii?Q?UYjSCeYJ4mvUsv/JHf6mSUOykPyDDYspfCjOIlpKIOdcVrRkrv7wWrS1E1Ce?=
 =?us-ascii?Q?MBkbmzio9O8s1s2JAtL/P4GrriY50pWJ8ljQjP8qhxwpDzpbrU+I1gLnNklh?=
 =?us-ascii?Q?+TGbi+kdQNc+cc6lIBy91nj35QZMyN5lSvVEvrbCQautI1xeDwz25R0XkGcm?=
 =?us-ascii?Q?mY7FR25OdPPLa+5ncavypqidkzGl5ZpZCDRm+ciiRVLyHWFVENgzCdxMPLuf?=
 =?us-ascii?Q?DcezPg7Gr09Dh64G38YS1M5oZAEE3c66hkZ2kxiffemIK2vVwDEkhQwybktE?=
 =?us-ascii?Q?iYSJ6SW0i64+J8TG9lbghNVTd901XHgtJsLxo7ErVPI9LvC5xnGTKnaEe2my?=
 =?us-ascii?Q?rKDLAOlEwSonCbXERP6zM9HPp0SKsebe8qMT1hP+2akSyLQIcw1A+1l+Nq2K?=
 =?us-ascii?Q?j8NnGjbqZ9TfvMg5PrWlU21S1VXyEjG2iYFVDFoWuBjoBQDo9r2GtinTPlgy?=
 =?us-ascii?Q?Ai2RQVuCldNfY4pSRnlwWSeYrzu/BRqM2EsJj3iOLVOjXw7tiNs2YMd9xVhR?=
 =?us-ascii?Q?e2vSVWJAT09kByhZ+KSUkOkVjQ+1Oy5HKVsDFcdqNPLNZWcCP0ns+Kx//NBY?=
 =?us-ascii?Q?CNcGAQ/DGYx11nRqSgGMz630VC7/AheaMPEbmLCJoK4hZrfMIc5LmwP8lzm1?=
 =?us-ascii?Q?JaA+oZx12eaTfFIlFrfU1QaT1A9/cCVWR2/WclO6KXkyzcwFJ2T9rmo4Nztg?=
 =?us-ascii?Q?FHAAudgb57gNzTJhnP8hGUDDSfzDM0JqpMqJ8k6o3sRLLrInxmqAW1S6+TUH?=
 =?us-ascii?Q?IfU/71zXLWZwFL+t2ipuNYUuCrCxjX9Yzu+8WgEx04zy+h+Lormv7dqsbs+c?=
 =?us-ascii?Q?DYS17gbEMX9MTiwSjTJP92LEOUr49HYw7J9We+Ry2atvb03QTEv1a785LiYG?=
 =?us-ascii?Q?zWO8NwrSAtJmwnvB0LTPOV/nWh167CfaJcq0SJzdpOyhGd0lhJKzfEXx9zIp?=
 =?us-ascii?Q?N98Qm+ipaqepIH6t7XQEms0mEiSUVpkS5Gcxemj0S4754OrIXjVfGF0eMHSc?=
 =?us-ascii?Q?+k8tkde2e9m3U6RpPioNWl/01ILpqACrT/hWOJiFkTn5BMfozYSSXKu3I9ao?=
 =?us-ascii?Q?vGJi2qIVyMAHd/axdBXgitUJiiOv3x6M=3D?=
X-Microsoft-Antispam-Message-Info: TCjac05Px/ZR3jCmckIVJnyZs+GiJsXx+PbCmUW9m2XXQ5d29Kky1yx9L67NnCp1HqvKGVS+vweQWEJtpB+PtISk9u1fysp1C1/oVlcxVuXXfO63dEXUvOxalfAO8khicAracNCNsdpgddexrF0m/J3oF01oWhveH0l50pIasCNzAOFtL53EsAgtb2y08NW1woc31VwJz0ZyBksd2JCmw2HvcVUpe0/kmXNd/thB58eiEiW5Ca7jjxK7+MhQn1V7GDRjryUu3lz9Yt++VuzDF+9kiotR1WDYAe93sdQeuXJiNq8e+tKl6VSQA4FbgaYONa0KExK0AdMOzXWd/Xbz4lbxBGqpt+EZ7LqOA0xMSRA=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1387;6:bBBtmJXZD8+Kh/ojBUJaEi/y6GQPAnQcExO+7GvtLxz+BN0tVQ3EXH22NRtu6rRstUKR8HM7IkPY1H7N2vJ83HX8iYKAPLTylGUN+rnbI4dAJ3SkXkARdaDB78dkzFQWWVPvrXbE39+0/X46azNXhsCotx4HquPolvo6akE9atw29EYfXFVaXezadyftUxm/qxD5T5zFgqsbSDs/asH35VkrwelHuhOx45Z4wv+UERDHldat+yk5yakFUnB2jg5A2EisegA2NVIEdC0oLfGumKxURDDCoLyLhpuNArbsYzeefKFmBC9TAuTmJTTCd3PScp5CtKY7xLgExaT0mL2iKab26U6dDMmJFlZwUj+bIXxX13AFerrU5m5Cgmc5OtZU3gGLBU5Vmgv/ZblUql+L71K5GDv/TiWM2hx8qvVDBo2DtKw2rPBVEF70LkYBbO1OZx1nP8gFq+i+FPMEXRnYDg==;5:ttahPK6MSBdhsPUcNqV7dB4LJVbbJLixsDZ5hKepuS9azoxTGAOISrWvFbUOCyfx10udhlN1TSj3DrncvrvmWztufkwq53ddAMhuWGE8ztHG27PPmakXIxrlWwiCfBU8yAt9+ZmsslOU+rwQq+/67V/ZOdFa+titHsXlkkjUCdg=;24:nUTk6Z2IjHyXsN/PKOA57QcFupHZtZb8WV/ZEY6kYSgh7ookoIhsN5JEtx/Gc0M6G9WAivf6P6bbWsA7NJzuChaGpkXFNcu9wJwbbO8mHYQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1387;7:MbpUbYlHSqZDGgjlENowaLxP/ISo2zsSrswJ6bPCC/2B9lcthcZ+fQf54dIs03CyM9uEGQPyYaPzt4VxOTkCGtEEHPF1XGozO+75K13E3wYHFvh0vtPPQQsv2j2ocQkIXYDErE8leBXnU5N9gXFSOuTCS34PbNkXZoDUCL6g2aQRkttdN+48rtyEYo2oZkWIwu19sh9l2uBtxXWg2RU8deTv7ix0ZWS4bd2B+YWfP1/a290QixJnbGJzUGGNHwtN
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 14:40:54.7291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c956ae-1684-422c-71d7-08d5ecbc77b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:15:40PM +0300, Ville Syrj?l? wrote:

Hi Ville,
> On Tue, Jul 17, 2018 at 06:13:46PM +0100, Ayan Kumar Halder wrote:
> > drm_format_info table has a field 'is_yuv' to denote if the format
> > is yuv or not. The driver is expected to use this instead of
> > having a function for the same purpose.
> > 
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index de0a76d..d7950b5 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -86,12 +86,6 @@ static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
> >  	}
> >  }
> >  
> > -static inline bool sun4i_backend_format_is_yuv(uint32_t format)
> > -{
> > -	return sun4i_backend_format_is_planar_yuv(format) ||
> > -		sun4i_backend_format_is_packed_yuv422(format);
> > -}
> 
> sun4i_backend_format_is_planar_yuv() is now unused so could be nuked.
> Also the one remaining use of sun4i_backend_format_is_packed_yuv422()
> could be replaced with 'is_yuv && num_planes == 1', so that one could
> be easily killed off ass well.

I will have this in a separate patch.
> > -
> >  static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
> >  {
> >  	int i;
> > @@ -304,7 +298,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
> >  			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN,
> >  			   val);
> >  
> > -	if (sun4i_backend_format_is_yuv(fb->format->format))
> > +	if (fb->format->is_yuv)
> >  		return sun4i_backend_update_yuv_format(backend, layer, plane);
> >  
> >  	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
> > @@ -384,7 +378,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
> >  	 */
> >  	paddr -= PHYS_OFFSET;
> >  
> > -	if (sun4i_backend_format_is_yuv(fb->format->format))
> > +	if (fb->format->is_yuv)
> >  		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
> >  
> >  	/* Write the 32 lower bits of the address (in bits) */
> > @@ -502,7 +496,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
> >  		if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
> >  			num_alpha_planes++;
> >  
> > -		if (sun4i_backend_format_is_yuv(fb->format->format)) {
> > +		if (fb->format->is_yuv) {
> >  			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
> >  			num_yuv_planes++;
> >  		}
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 
> -- 
> Ville Syrj?l?
> Intel
