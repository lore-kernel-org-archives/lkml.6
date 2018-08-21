Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82703C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F0D208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rK5U3MSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F0D208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeHUUaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:30:46 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:33440
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726813AbeHUUaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKhQPyoaldT64rUmnOuMRi9u1d0O9ykDrMcyvikeL+w=;
 b=rK5U3MSRCQrmNP+MnCv9vQHhayR8z40p9c3uAZQY5ch8w/vCBMPlliDr1m8D6nKLXdiThd5WkK6IcLXAPdUItLvkKCcE0EJxEWmsvVgb5JaKf9Y99CqQJhUR9E7UfZmCMCUMxwAUkjMwwnL7GxVEhZ+p23Dv2DcJiA211Wz43lA=
Received: from localhost (217.140.106.49) by
 AM5PR0802MB2547.eurprd08.prod.outlook.com (2603:10a6:203:a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Tue, 21 Aug
 2018 17:09:42 +0000
Date:   Tue, 21 Aug 2018 18:09:40 +0100
From:   Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
        ayan.halder@arm.com
Cc:     nd@arm.com
Subject: Re: [PATCH] drm/fourcc: Add DOC: overview comment
Message-ID: <20180821170940.GA18869@e114479-lin.cambridge.arm.com>
References: <20180821161611.10424-1-brian.starkey@arm.com>
 <20180821165126.GL21634@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821165126.GL21634@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: DB7PR04CA0019.eurprd04.prod.outlook.com
 (2603:10a6:10:12::32) To AM5PR0802MB2547.eurprd08.prod.outlook.com
 (2603:10a6:203:a0::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 928692bb-a474-472e-c353-08d60788e2ff
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0802MB2547;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2547;3:x421rrCm4iwv3tCCPlshSYspYE6IBzEXfEl70WyatOtf2vNphd0A5KdPzRG3SmF9UYVjboaOuR+vb7o0E/EivfyWb1znt5THyJj42HnaFCmQX3RxLrKiU8jnpBkLIgqNPIfdXTTPkjNOxVymmjve7YUrKfKDeOh9POswKtmdVncqWOwlxRU9khDGeKsQQcETC3f7lK8k/4PcfqoJyUEIDKXOUI8q9TYQAZ5vqeeCkbYiTGMdTQPRXex2OU6FmS44;25:V0IA2MpcGKEzPGauJwD3ZZ6ct1/eDbCnx57lpqnTQinBTP/egVnvedp47QP8u+iCGhx0lb8ItGZVAuHlhGetn1xJ7kotFY1vperpYWiShDYiLyLXVbpJlwgLS9Eqi2d1muMlteYh3XbZNB3EBYMRRaYtapAmrHW76RrtUpDXeL++AXz7NXO4illS0VXgFdWyLgmzIyxeLiN6RCWx8+7e7BHXTtIt8gby1J9d4CDWQx9g14Ggpfjfa0aT4KmVzLt3NSCrVrtQQrWNpTeEUbqIFuQ0SMyt2/zF0PbmPMXxkUXq6UQ4EJd6kMah7KjiZCXYepjULVHHfPXw/RgwB2XVqA==;31:hirjWyOstdgoEuRX/TpWNDdftWHREjc7iodVD1FOA07MSMaleyFB4Mlw/e02qMQvmIvcVbXKjX0x2IoPLAHb4SGTrQ7NsRoXU+jW0Rlb09/w3wsFbyK3sP3937n+zf5I26gcumqpNWh7cILYr/fr/2DkLUikydDg68AMCyhPmnTqfzXGtwqvw5F/Wh8FvBPQt11ePw0kG/D6+9s83SqbiDWeUGiWrcMLcc87Jhs53cQ=
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2547:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexandru-Cosmin.Gheorghe@arm.com; 
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2547;20:7tHj6iYTI/ZfunSgJQprvwtjszRt1qPXT5vBN0u7++BdQlFKAjZb+YjbMhoO9+52xW3d5BlKNPpegbT40Mj43QQ4cKzjohbnTVYpxQbyQ9wM9FeaAYSVo9hVbRoyoOvB/DZ6E4FHaElJq5qBhvIbCBFjxVYe03io0m0A8th/TjiZXNlgA3jpuggn7632z4lQum8DFUOoOucI0bJlSwIg+NVI/8mJBrcJwNM6Msm3JYUm9870emwcIQrd9hofPlPN/71XrSizCG7Ni1wV5TCKWme9XgWDmXxHxE4RPmrBdTmXDDht/5ndcrnX7v484L1BqBjAvWnZjGP91P3PO9T4Zw==;4:z50yhyeK/LUtt0xDxZfim0PeIKExotG2MEKnBrGRRvfAWVWzQHOUWSw58Pesc272vi/J3/q/MxmBDfJ+xb7tSzdfbC/WFK4PSSA6Z3izMzQyMrHvojiTOr1Qelo6yNABnGv6iRDLuQBWVMrQ/L598vpDTFXeYnGBROgX5yWfaDf5FWxaU4HFS+vt3UizSGkpxoDF7e1PFdAhewTOzueLE+teF1ET1ZlNZG4Y+Grt4SuPgkwbllcrBF0pLTDXp0Ze2i4PukQmMdBA0P/5TUybEquuW/HKB2j64Maq1dv+CpWc0OlfkL0Y5Lsdz1Fw/290
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2547A46514E6BAE543E74A1CBC310@AM5PR0802MB2547.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM5PR0802MB2547;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0802MB2547;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(6116002)(2906002)(68736007)(58126008)(16586007)(25786009)(229853002)(53386004)(4326008)(76506005)(6636002)(6486002)(105586002)(33656002)(76176011)(6246003)(8936002)(97736004)(106356001)(7736002)(47776003)(587094005)(52116002)(305945005)(23726003)(3846002)(8676002)(53936002)(476003)(966005)(26005)(575784001)(6306002)(86362001)(14444005)(50466002)(11346002)(478600001)(72206003)(5660300001)(316002)(1076002)(386003)(486006)(81156014)(81166006)(956004)(66066001)(6496006)(446003)(16526019)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2547;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0802MB2547;23:OsqShkBheoaAerj2E/WTzFHl67s2ugTcroQJAWT?=
 =?us-ascii?Q?VchzaMCRrJMXM9dF48TWUzVXC/bp9v0/01T7SxaKCgFEHJGR47vPmj6zLqhK?=
 =?us-ascii?Q?wu25hxLqygCRr5cdATxWFIFXHShGnFREDcfN4NesGENemLwArordFDRzoBKD?=
 =?us-ascii?Q?HgM5HWRzMRyND4beID9/pFpZxdeNPPP5EdHU60EWN9bTYmjSILwoTyiVDHeq?=
 =?us-ascii?Q?OC0puaL6u7p0E43O/fkre4J1psxFpEdDlV54Gy0D33U+DU2GhY5XiPHXhEwt?=
 =?us-ascii?Q?so7OFRtLh5700MSusZbXM9brJK372OGhrEyZMOuKiXM+0mbrFwVDWNpuxEcQ?=
 =?us-ascii?Q?tFeJ1Kb+9TT9K2+1Ry0/gn/Ynd6WYIUoyrEzt5M9JRcY5vhO97bEX52voPR9?=
 =?us-ascii?Q?Goz67VW0h5sB6i3eZqKelYH9kVkvNvjauC9vdUX8b7gZprElX/ZlTUruxZcD?=
 =?us-ascii?Q?PvxSOj3ZDQBaSfm7742wv3v91ZvFtCOM13q3lM0rRkO+YhNFIwmlehOXnt5C?=
 =?us-ascii?Q?TiFvRzgUUBig97nFpry4HR4oD9wy0Ew2kX9JSyORX+/UbU6bA6Tq8WPojk3r?=
 =?us-ascii?Q?51GQBW7NNa9+0FOH6xMp5y5hrjMUudxYlmR0xwZeqz7SlGasDFy0yNKO6yNb?=
 =?us-ascii?Q?0ke50NC9xuB2NvwV+DwbkzhTeys1apJVTSI6JQmSDpM4jr0I6awR/xCd2/Pq?=
 =?us-ascii?Q?rDQ0MUTWLmWfUpiCo0aAwrBTdcDN2tGvWVju29LQVzmr6FSpnE84j4Kygzag?=
 =?us-ascii?Q?RkMXWFEGnQMESJb0+WG3sH5FvjkItX20tG+iCXDP7BmMn0bS5bUMzLzGnDRn?=
 =?us-ascii?Q?HG6S/PAZB+txMH+esTUvWKYcSeQJLKjiThSgOG8dNN2eqZDW8ah/ZZir7E4p?=
 =?us-ascii?Q?8ky+JwZvYcdCexX3fTzdxpLlO48W0JejL1Tisv2x8/DWvjKg5fQnBQ6YiASx?=
 =?us-ascii?Q?5bAklgsMqJan96ePZJzVtcfHrTTT/li9VYv9yl1Q/ZYoVf/GBdFxM3VCs5QK?=
 =?us-ascii?Q?0IimOCh0tTSJxmHh8BXqoWHJCQBdt3XecKccUwCd3CGKQ7XoLE71SA/+dPzi?=
 =?us-ascii?Q?Oqa8S1BUfJYt+sGFCbV5CouepxPctXlnPIeyiJ1unfgvxVdc//0hEqayUIMb?=
 =?us-ascii?Q?+2QZF7AFnJfH1VIQRR4ew//0ifDOzEZozy37aujQsOlrkq9cu/WhKR+ISF8r?=
 =?us-ascii?Q?+LfdBtv8lD3tUOcVVTg5wU/8m52BLl9a9Qes6YX4PgArLasNT+2Z0d/ggtKo?=
 =?us-ascii?Q?NBks+iFiWlB/CHlj41FkXsnqbMFWiTQ7ST/KB9FjpN4RooC8stgPNlmw+DsY?=
 =?us-ascii?Q?2tMnUbDnrNu/dqv9c+yfYwIZOtFX1NV98TheIZO1wHRULOZgxu6k51h4x4In?=
 =?us-ascii?Q?LM8C02z9sN5fIO3uFQ/tkMLb8oWc=3D?=
X-Microsoft-Antispam-Message-Info: tziK0MLTKkPXX2l67+tE2OG6KFHrQFej68kEXaHKHylQ9sJ30YJazVPS0Zpl7+5B+b3ptnMvtb7lYFd61CqD0OM62/cLUQJjPjoSChZEs50Rxc5I0HZo88vhJbznlF1vYg1zXckr2ls80TGo+HEpN5v5k4Bgz+lco5EEiOi74hxh6e8BBY3UsdRYNPJmhiSWwonMOvieYo4Zn47+ewL/VwxGOVTCgd5bvIinRh8qC+x2W+n0KKKE0Km+FT4TS1jjxKBjDr61/CEd3wiiJeCWZAjoeUkDHAuVzZbgxir4wdapOPMgMFltFVor8wKKXyEs3lqhUpkV4r9u/+BfZWWYEG2wWumm7BxahEKnz7bnql4=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2547;6:7PGj1B4x/ePoyxV4fOt/mG7Fy+Y79Adw0CKg8/vhcwgDkuojNB8YOmoU7OsAya5ofRyybJI47RoCsvpgv42kHMMHC7vNDcsIemdWVjDotQsvQ1d8rDaNfg/9Y27+gy5ZgG13+xk73obdhZJkkzzK9NmLVuilevpzviMPwdZshf/fv+NyCCxDiPn8GAiwXiUaFjBwap1k6XS+lq4DBbOS47XOEcCXd2tpQbxS4/OWAQM9/Nci8/Ui8W31pDmJzzmXSQmNDb7Dvtski3iRzdbkF25nO10QnaxPp6gGsxoSl4XUlZev1K4SbjtGFA1R0i6OhLCdCoqsLokciMEesuSgkwEylX0tBlc6KykfC9TdMPr4ZxkeHg64AfxhD2y0eqo8QZsRtBkvX2FEMIcnx75//KavROg5HKa/W0cToGEhigmeCSG77BUdpUxxc8paZOrRIbBFkUhe1mpATs8/QaL1Dg==;5:RJeVsEGYVQjb0b5FXMN/k6z06t3p3r8jL7BfuQHnlkKnj2kAzvYoa0/iVT+vbAkIo6pR9l9yh1tRfkCxu6qKLJF1yXlMEnaSRtLLrZU0+VfMjUkqHz5shwbkuwTZILaagGLrWIZffbe4AY4A+fX+F0amykwPHfVjvSzYc0aOBrQ=;7:a5w4znju7qUO5tw+BiJZj503yFGirNulp8VTsTnb5KStlRfEDjZKRpx3JnbX56C0D9cLYomKzDwsQ0dbUCPhPhW4VcdZJ2MwP88F6XoKXh+9IIbpLaHyULw966qtCiHnIX/dn2tyO3jg6cctW3yz+1Br0s+uzI1/Ljr/EGNzwCxSpHbpLQ31/5sRMp0LluL6yAWfoDwwtTaE5+veNbzH6AoQ0IYeRd3kD63uZD31MhPUTXvO35S4f8UhkvSL1J3b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 17:09:42.3692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928692bb-a474-472e-c353-08d60788e2ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 06:51:26PM +0200, Daniel Vetter wrote:
> On Tue, Aug 21, 2018 at 05:16:11PM +0100, Brian Starkey wrote:
> > There's a number of things which haven't previously been documented
> > around the usage of format modifiers. Capture the current
> > understanding in an overview comment and add it to the rst
> > documentation.
> > 
> > Ideally, the generated documentation would also include documentation
> > of all of the #defines, but the kernel-doc system doesn't currently
> > support kernel-doc comments on #define constants.
> > 
> > Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> > ---
> >  Documentation/gpu/drm-kms.rst |  6 ++++++
> >  include/uapi/drm/drm_fourcc.h | 36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> > index 1dffd1ac4cd4..1dd9f4824d3b 100644
> > --- a/Documentation/gpu/drm-kms.rst
> > +++ b/Documentation/gpu/drm-kms.rst
> > @@ -322,6 +322,12 @@ Frame Buffer Functions Reference
> >  DRM Format Handling
> >  ===================
> >  
> > +.. kernel-doc:: include/uapi/drm/drm_fourcc.h
> > +   :doc: overview
> > +
> > +Format Functions Reference
> > +--------------------------
> > +
> >  .. kernel-doc:: include/drm/drm_fourcc.h
> >     :internal:
> >  
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index 894fa2da32fd..3f6c0b499323 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -30,6 +30,42 @@
> >  extern "C" {
> >  #endif
> >  
> > +/**
> > + * DOC: overview
> > + *
> > + * In the DRM subsystem, framebuffer pixel formats are described using the
> > + * fourcc codes defined in `include/uapi/drm/drm_fourcc.h`. In addition to the
> > + * fourcc code, a Format Modifier may optionally be provided, in order to
> > + * further describe the buffer's format - for example tiling or compression.
> > + *
> > + * Format Modifiers
> > + * ----------------
> > + *
> > + * Format modifiers are used in conjunction with a fourcc code, forming a
> > + * unique fourcc:modifier pair. This format:modifier pair must fully define the
> > + * format and data layout of the buffer, and should be the only way to describe
> > + * that particular buffer.
> > + *
> > + * Having multiple fourcc:modifier pairs which describe the same layout should
> > + * be avoided, as such aliases run the risk of different drivers exposing
> > + * different names for the same data format, forcing userspace to understand
> > + * that they are aliases.
> > + *
> > + * Format modifiers may change any property of the buffer, including the number
> > + * of planes and/or the required allocation size. Format modifiers are
> > + * vendor-namespaced, and as such the relationship between a fourcc code and a
> > + * modifier is specific to the modifer being used. For example, some modifiers
> > + * may preserve meaning - such as number of planes - from the fourcc code,
> > + * whereas others may not.
> > + *
> > + * Vendors are encouraged to document their modifier usage in as much detail as
> 
> I'd go with a slightly stronger "... should document ..." but either way:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'll leave pushing to one of the arm committers for drm-misc.
> -Daniel

Done.

> 
> > + * possible, to ensure maximum compatibility across devices, drivers and
> > + * applications.
> > + *
> > + * The authoritative list of format modifier codes is found in
> > + * `include/uapi/drm/drm_fourcc.h`
> > + */
> > +
> >  #define fourcc_code(a, b, c, d) ((__u32)(a) | ((__u32)(b) << 8) | \
> >  				 ((__u32)(c) << 16) | ((__u32)(d) << 24))
> >  
> > -- 
> > 2.16.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Cheers,
Alex G
