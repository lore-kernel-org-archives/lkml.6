Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2DBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7862152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XHBXiStt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7862152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeITQBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:01:54 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:32230
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeITQBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1p4615XIrnEMlYXcc1rsbRkTr3/mb7XZRriNF3CRUA=;
 b=XHBXiSttxEZgn+pxIfL0//l/wW6L7tf1/MdjDW7GweWIrk4chxwNz+v14+MNEyaOxTbRkr6I/AlT1k2rCe+ShP5s49jggbvo34iSp2NuLm6mg4US7YVrKkxdo40hePfjnKVnZZfYXeUHISzBow4VYU0xtngumsbLg86sC7ISb8o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexandru-Cosmin.Gheorghe@arm.com; 
Received: from localhost (217.140.106.53) by
 DB6PR0802MB2551.eurprd08.prod.outlook.com (2603:10a6:4:a1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 10:19:06 +0000
Date:   Thu, 20 Sep 2018 11:19:04 +0100
From:   Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>, nd@arm.com
Subject: Re: [PATCH 1/2] drm/atomic: Initialise planes with opaque alpha
 values
Message-ID: <20180920101904.GA28394@e114479-lin.cambridge.arm.com>
References: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com>
 <20180919155700.10342-2-kieran.bingham+renesas@ideasonboard.com>
 <20180919161545.GH5565@intel.com>
 <20180919164347.GA21403@e114479-lin.cambridge.arm.com>
 <007554b7-8aa4-3ecd-354a-c63ec6fa39f8@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007554b7-8aa4-3ecd-354a-c63ec6fa39f8@ideasonboard.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: VI1PR0701CA0035.eurprd07.prod.outlook.com
 (2603:10a6:800:90::21) To DB6PR0802MB2551.eurprd08.prod.outlook.com
 (2603:10a6:4:a1::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d052958-24c4-435d-c393-08d61ee27f4a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0802MB2551;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2551;3:t6OjAt2XU8Rv/TfTxPNLVae8+C7yXRUXoeIfn+JiREhGdnYmJ3UiDgHhzSv4CGg6K7nkptP61+gKo78hZ4W7tMDAvv6nkjGzLSagAP3CuUA2Mtl8/gMWibqmHLl9svCiO4I/MuP3AUd2EJsMt3csCRL8Fee2H1/yPk3ot7Pl8mu81ph4uuR8GuCfEON0lHWXwGwynq6s4kHcCxHExr/3+eEa581pxH9m5nOJ1WT0VLnFlvyU+Y0IiMOzNE3KJG6e;25:rYJDYInZGMvIk2GP7wHwuwbpwpH1bIolprV76tIgaMTY70NnuAADFhDMpHAyPAwKzfytF9EsV7sfY09yvJtCQxcDokrdlvg81ZD+29XWp02iCivQiKeEUXLSBg+C1lYhkVLv2BUR2qy6P3aHWzAke4XzsgCwnLvZo+FDOQLjvDQXEYpt2uQg0LjBFV+Tde//yf5dV6hMD/rhBFZVGYN6VaRNNJOvxbrZAwkc5cNUvNJi9ORhLbux+Vf/Dj6mzfn1yFqNPuVD0DooIR5NMV6dkP+RdaHsgqMGurpYfxLVL1si3oCF/1OlM/ssMTLRkktsT68jurr0UtibvKkQ1IwAFg==;31:c29DGkeX38nFrkReAJnxUukr+4wRzWdMB1p75E5DXUv1qVhIwGBES3v6ou5eI8PX0dbn1bcPAgZvR6SOYnOqLvqADBP43j4q9GNBbrB2eWgb7PlHcH5Vxfv4EpcukmDmglagi3div/8LcYEYwUy6CuL6OatUmcFMdUw1bqJdqrmx/t272QGNVfW3qBEoCxitTnnoPUX+9LtM9HIHk3zsPA74euM5HA6LjJQSl9gl1MY=
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2551:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2551;20:X0qWHWSGNm4OFP/UO7KZaZhB7wR8/50wTg/E+95I3G71Li+I0isOevRqGs9hRdy3AKwiAmuzf+TOms+H2xmZjeJC2qmoyDLgEp4r21CVLQbbMYaJ0pa54Af6sSHf4Ml9Oi//sM6o2fgXkKj7J8UOqOg0Qf28etf/2DcwozZpZKvmdkdzlMqKvaAaUP0IMwtlVWM0kaLEdjTUMBaBUGEjFRpoNHWWJHZKY9n+PNDJL0a/3nz7GJeRvTVLt46oe2X5sd1wTayPv8C9R4i2vsIwYzKSSrzJ1FaV7PV7hA3BltOj3mDV0oC7damFRrs3rMSGRisGMFoWvQgV3i3AszAhRmGVGEuOY7vOy3rrTSdyN8Ip0OAZgOH8kn/0OfGOjCSvDXIdNNAF9QCEfLC8MD/J6glKh8Nt89m/TLQlc2fWu4M=;4:tyazk/7mKc7wASDKmgzPyrglgZ2R70ogxSRQycSU6Lm5UXOqlPWMNqxzTlb7z1tR2Ea32+dS/H44b+CEY0fRxjz9siRNeLjpD9rW6gmpDW/gc79/jeVbW9BsV4yr3n3EyC2rzwLfKC6JfRkwpi9OWGzt18tKwcj9zAWeIj/egCp79/qAU1fBPZmX8+kYR1tWGN68pYl/tIk+Cs/E82vkox7kfA43pTYn9N4t8gN1yMjU6q89pneJyz0KoioeYGSoBjLhMgQGK+wTFduNKfzfLzI+OTq75vzioPAIDR0a35KX5vRrShMTZC/ZpX8OoUKnwqVtFp3lbIvJQAYvUjMdJbjT9M/tSFgkT5OiW5XjYWL6nRg1ojKT+foAkIbSBYPB
X-Microsoft-Antispam-PRVS: <DB6PR0802MB255101FA55AEDBB698522183BC130@DB6PR0802MB2551.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DB6PR0802MB2551;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0802MB2551;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(366004)(136003)(39860400002)(396003)(54094003)(189003)(199004)(53936002)(478600001)(6246003)(305945005)(53546011)(54906003)(16526019)(386003)(76176011)(52116002)(50466002)(26005)(11346002)(93886005)(446003)(2870700001)(316002)(966005)(476003)(25786009)(4326008)(956004)(186003)(486006)(2906002)(58126008)(72206003)(6496006)(6306002)(33656002)(1076002)(8936002)(76506005)(23756003)(229853002)(81156014)(7736002)(14444005)(86362001)(8676002)(6116002)(6486002)(3846002)(106356001)(81166006)(47776003)(66066001)(105586002)(68736007)(5660300001)(97736004)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2551;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DB6PR0802MB2551;23:uZOrDjR8jE+g8PB7XKJSQnbAR0BvTSJh67Wtd?=
 =?iso-8859-1?Q?uLD/eZ9HkwrDpCl/STrJkfd4dVFh+wERx/NZQEVA+dV1ZAdsYtEDv8bnBw?=
 =?iso-8859-1?Q?XdSnnLUD3DiYDwd3kBi4SLb2FGEUR49818aShA7Ufv525Ngf8uBScFwRFy?=
 =?iso-8859-1?Q?/yUqlVy8uRdL6bHxsM0raIbr87I7H1DqBM9RvEP5E2M7xN/0Oe83DMzo7L?=
 =?iso-8859-1?Q?IcAeynN9xg8AhjJKwu63qrhUfmN4XV+7dy4/oToWBznk94+2fIx+nUSJ0N?=
 =?iso-8859-1?Q?C31VRdr8s9oXVkliuQsRFoyRTZxA/ozoWYIykyaYU2iKWz+3Tf1DCYebop?=
 =?iso-8859-1?Q?jprAAFI0f7Q6N7AarRBCklV/SUKwNsAeaW3JUemVrlrR91LrEk/tvoXGLx?=
 =?iso-8859-1?Q?C824YcUzBd2MAUIXcFtLRdhZJRnE1RIb8JRMqucv1w93McRYmOVTNWesUA?=
 =?iso-8859-1?Q?DmsvUBeVgrSmFixTbeX5yg3EzS/TOFbBqDchnRiiTx5DnM1f5Kl3IYandD?=
 =?iso-8859-1?Q?IrufOrNiEpaQ1fsE1lhSYCKxtCL+ntedpvDmfRAcH/6+3GTWFDo9x6AHrB?=
 =?iso-8859-1?Q?63Pgv5GPxvTANX8g0if8H014iiQXirzdzIh9KDWHUjFhSRnQlX4FVHcvif?=
 =?iso-8859-1?Q?WUmHz7HpIM5NM2nchl0OS9Z/fYWvZPTuJu2+JxaZ1PIJUC/5USMZ00KTAl?=
 =?iso-8859-1?Q?53c8HxbQ9M/hPxxpCS4VhKumoCKZBxhqdSp7tcC+tQIkgD8L/Z0w3EeGU4?=
 =?iso-8859-1?Q?ehb6gbIKnis/m8tpjs9qXj6S2B3eV77ZMbjnoQ1Syl03KfRDj3BSEtn1Fk?=
 =?iso-8859-1?Q?60GnX2pdq4Im89fX84rSoLB13IegyefdJI54SYx7o7d7uDPfNpj0J3gumE?=
 =?iso-8859-1?Q?0ECHv//9pEoh9liw/ZCvtPjHl1Swu3IPNWbifTgBBcPrV+CiGALPTtAMVS?=
 =?iso-8859-1?Q?o+/RtfRti61M1jD341RQElV2ezd03hBMiUckcM+7Rw9Yz1/HwRD32pmxko?=
 =?iso-8859-1?Q?cXO/zejQNS9vI4CzPBNIfrNwhCKEmQmQJmzcNUoVLJ5U4lX7KhDHJILgpu?=
 =?iso-8859-1?Q?W8kt1pRVa3hga4xqbAiNkz1hfu1sPg9i6sCU/1zTrtcWAsxKb8N+AutMXh?=
 =?iso-8859-1?Q?nSAG8w6FRY2BIsXCyMQ7ucofzhOfV3ZUwMILhsG/zSKVNVJpYsnZQZhLCd?=
 =?iso-8859-1?Q?J7q5ZI9VD2VJnh3WYAOK0I5S3EBUPzpuRhRshSZxdPS+entdJF2KaUbLyU?=
 =?iso-8859-1?Q?nQafHRgaGh3xUzNez1rGpMX0BhXuRVgmrX0MhF05k5P/P+OFBtnY5g/cT5?=
 =?iso-8859-1?Q?APifQ5f1C1R7D38j6db9N5zmQHrGYmgChAA6o6VAEMAg6EWQcd+Q6dyqBL?=
 =?iso-8859-1?Q?v8oBcndgo9nlAiZNLB+M0hXWC0j56U/5+L9oDj1kABy62Cqutkkkw=3D?=
 =?iso-8859-1?Q?=3D?=
X-Microsoft-Antispam-Message-Info: mFoo2kjbCJlSKeVfcnxWJutMjHr2C3l5C98bw7tzXdtHvOoD/8hvsrBWt+/9fUgnj8oCJd/KaMhKs25lFzhpcpL75vOqiVlNLnWQGS3NfcL0eLkVlrri8SNJUFKj+JZKyNfW5J7K/S2s6Ng/af5Voo3qADevIPoP97uL3TUZ4W2tvgQXubaShmXeODFsz4MaJ3vnNnB7Kb/vR19oErTIRhUOw90G7F+PlLbzWeze4ZSiUst62UF5AJHrj/Yay/FUF3hHZp+arEnLaAV09hnzTVyuBZv29oUzhTHbZO6upGSAR2iph7bFHqrkYINSxc0NWOTQRThb/H8xDUp4+26LR632nQatiCGHKgqKhKCERx4=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2551;6:fojqelt/BQRhYd84EBmaVOqstt745za++7VFitTpj+YWw5wA5+AXwIcReIKpPw6ymhxrMA+aTTsSiZhjUvCfArXIXkgIUfEvS6YH+yozf/z7/52OnF/qQBNA8Iw0xJSVsHRQRdGmHpn4b0tkArSApNh5vKDeArKTkNaeLHTmURct69BnqcG5QITU5JljJLcVnP8p/geq8+9OjIShL9XM/D2d+2n/am3GcFXWLpDc6eHchRUZuUOAHxw/1Na8N3ytw1eksgSMnRwai2deUgf2Wf2OYIo2ctoZaMNwL7ySpWJZa6xNqxlLI8/I9LLxlnupeKyIDWwDKs7I/OmHcF6+9dw+ytllW+lMHuxp1tdtX4W8yjnNfs2VoB0pqn8QX1MJ0PAESEKGKxI2WjUeriJKShTOpv33P7kGsvtS7NyAfpAQ2Kmw6lmqm/FXx1X27bsITaUWPD1SHtzQ7jmi1Kop7g==;5:z6arNyDJLogqKgBtqE1kecBUQH4dEGO6Q/W4BpiBnB4LPEvFxj8Sno5zQJdZG4eXLNkVIQki1q7NnvMgA0mjXmA370LWJTOknA2zzPjbFHivKUbw0R3XRAq3CHXCwDdutSTKTmjNq5v7z3/ZNivqYb6l5VnjxnqrsCBDD2q7ex8=;7:zZhrvXrwi7DbFRT92lPP6RmXV6dhCKePwujNO0C+vTB4DCIOpdpkW7qjlymTG3yJP7a20CuN9iM0wGt1WvPn6lv1uroBHvDMg+9eB1qAKYfObtzXVLU4tXoGqr38P9Mz1FYOIfIzP13npI0wYncbrf19dyT34M5QtYp2lnTBmEvQG7qD/3i6LtU8IqFezld/gfYtaHs77mjeASUXsRWJ/51qlIUhVy0kqLWZ4uaJXyazpHKDLiwOhbu4IF6pDQHx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 10:19:06.5141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d052958-24c4-435d-c393-08d61ee27f4a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 11:03:12AM +0100, Kieran Bingham wrote:
> Hi Alexandru,
> 
> On 19/09/18 17:43, Alexandru-Cosmin Gheorghe wrote:
> > Hi Kieran,
> > 
> > 
> > On Wed, Sep 19, 2018 at 07:15:45PM +0300, Ville Syrjälä wrote:
> >> On Wed, Sep 19, 2018 at 04:56:58PM +0100, Kieran Bingham wrote:
> >>> Planes without an alpha property, using __drm_atomic_helper_plane_reset
> >>> will have their plane state alpha initialised as zero, which represents
> >>> a transparent alpha.
> >>>
> >>> If this value is then used for the plane, it may not be visible by
> >>> default, and thus doesn't represent a good initialisation state.
> >>>
> >>> Update the default state->alpha value to DRM_BLEND_ALPHA_OPAQUE
> >>> unconditionally when the plane is reset.
> >>>
> >>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >>> ---
> >>>  drivers/gpu/drm/drm_atomic_helper.c | 4 +---
> >>>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> >>> index 3cf1aa132778..e49b22381048 100644
> >>> --- a/drivers/gpu/drm/drm_atomic_helper.c
> >>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> >>> @@ -3569,9 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
> >>>  	state->plane = plane;
> >>>  	state->rotation = DRM_MODE_ROTATE_0;
> >>>  
> >>> -	/* Reset the alpha value to fully opaque if it matters */
> >>> -	if (plane->alpha_property)
> >>> -		state->alpha = plane->alpha_property->values[1];
> >>> +	state->alpha = DRM_BLEND_ALPHA_OPAQUE;
> >>
> >> I can't come up with a solid excuse for not initializing it always.
> >>
> >> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Neither do I, so:
> > Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> > 
> > And thanks again.
> > 
> > I plan to push it tomorrow to drm-misc-next.
> > 
> > Now, I've seen the plane_reset patches in the pull request for drm-next
> > 4.20, I wonder if someone could tell me what should I do to get this
> > patch on that train.
> 
> I've submitted a separate patch for the rcar-du which enables the alpha
> property for the primary plane - and it incorporates a "Fixes:
> 161ad653d6c9 ("drm: rcar-du: Use __drm_atomic_helper_plane_reset
> instead of copying the logic")" tag.
> 
> Technically that should be sufficient to get that fix into v4.19 I
> believe ...

plane_reset patches are not in v4.19, but in drm-next which as far as
I know will be sent for v4.20

> 
> But if you feel that this patch should also be included - we could add
> the same tag to this patch, and get it queued up for v4.19 fixes?

Looking here 
https://01.org/linuxgraphics/gfx-docs/maintainer-tools/repositories.html#drm-misc-next
It seems that the last pull request for v4.20 of drm-misc-next will be
sent around rc6, so I think putting it in drm-misc-next will be enough
to get this with the rest of the plane_reset patch in v4.20,  but just
to make sure I will double check with Sean on IRC.


> 
> --
> Regards
> 
> Kieran
> 
> 
> > 
> >>
> >>>  	state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
> >>>  
> >>>  	plane->state = state;
> >>> -- 
> >>> 2.17.1
> >>>
> >>> _______________________________________________
> >>> dri-devel mailing list
> >>> dri-devel@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>
> >> -- 
> >> Ville Syrjälä
> >> Intel
> > 

-- 
Cheers,
Alex G
