Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB8820874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K6giZNtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLRMg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:36:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57338 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:36:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181218123656euoutp0296d342899db4e14865336869a1f9ac75~xbZENvZNA2331223312euoutp02e
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:36:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181218123656euoutp0296d342899db4e14865336869a1f9ac75~xbZENvZNA2331223312euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545136616;
        bh=sN51+L1qpmmimXm3dIBpmjz7d0Eq94dyN9a5ffpOtHA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K6giZNtmjbfmASXS3nH9/Yq3VUleR5DKUPGrpygKTgAyZNw/JpjnyGLBhaz6W9uCc
         Y25ukreiM0wWD7+YVQzGyo2X5BGAWBkfbs6aZq6Z/0Z+XalrflU3twprepRVbbKonI
         Gen/xO8oLT/iq+IXB1trTp0y8BQ6fN6nScYoVtPM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181218123656eucas1p2d62525156c23879692613e6d010a65e0~xbZDjbUEH3061330613eucas1p2_;
        Tue, 18 Dec 2018 12:36:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FB.19.04806.7E9E81C5; Tue, 18
        Dec 2018 12:36:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181218123655eucas1p1e45a37e79c605233f944ad8c9a5767c6~xbZCu4Ztg3004830048eucas1p1p;
        Tue, 18 Dec 2018 12:36:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181218123655eusmtrp2549f8123cc7229b924aa013a0a097b9e~xbZCglWa72146021460eusmtrp2Q;
        Tue, 18 Dec 2018 12:36:55 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-63-5c18e9e77684
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.F5.04284.7E9E81C5; Tue, 18
        Dec 2018 12:36:55 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181218123654eusmtip244840fab46e6dd4cfb6276fe208e35f8~xbZCNb4He1938419384eusmtip2q;
        Tue, 18 Dec 2018 12:36:54 +0000 (GMT)
Subject: Re: [PATCH RFC v2 2/8] drm/meson: add HDMI div40 TMDS mode
To:     Neil Armstrong <narmstrong@baylibre.com>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d63e5df4-2250-178e-2b1e-3a8ac8dcb6df@samsung.com>
Date:   Tue, 18 Dec 2018 13:36:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130134301.17963-3-narmstrong@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7rPX0rEGLx/ZWXR1PGW1eLK1/ds
        Fp0Tl7BbLJjNbXF51xw2i0N90Q5sHu9vtLJ7XO7rZfKY3TGT1eN+93Emj81L6j0+b5ILYIvi
        sklJzcksSy3St0vgyvjz6h1zwXaxiq+vdzA3MO4Q6mLk5JAQMJHomfKKrYuRi0NIYAWjxO6d
        z5ggnC+MEr2rf7BAOJ8ZJc69uc0E0/Lh0QmoluWMEv1/HzJDOG8ZJRacmwKU4eAQFnCWOLbY
        FqRBRCBT4mffUnYQm1kgTeLWjEOsIDabgKbE38032UBsXgE7ib6tEAtYBFQl5vUvAIuLCkRI
        dNxfDVUjKHFy5hMWEJtTwFZia9sDFoiZ8hLb385hhrDFJW49mQ/2goTAOnaJxXeuMENc7SKx
        Z9Z9KFtY4tXxLewQtozE/53zoT6rl2iaeYUZormDUeLE4uVsEAlricPHL7KCPMYMdPX6XfoQ
        YUeJSx8fgP0rIcAnceOtIMQNfBKTtk1nhgjzSnS0QYNaUeL+2a1QF4hLLL3wlW0Co9IsJJ/N
        QvLNLCTfzELYu4CRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg8jn97/jXHYz7/iQd
        YhTgYFTi4WU4IR4jxJpYVlyZe4hRgoNZSYT3VqlEjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        aoYH0UIC6YklqdmpqQWpRTBZJg5OqQbGikiXCVE+P2ef6uPvYtt+4vJPoftZM+9EvmsXFXg3
        fYXmJCGHdzt3ywp2VrhGfzj2joldprP3ha/DP7sD+t/sGdPF8t8l7Qh/asPDeXl/cMG0gofe
        M7P2fXtjdOdjperkqkWrk/LtYhcr9fx5Ye5oY9czf0fVqX3vl9reLem6efPGbMt1f87/UGIp
        zkg01GIuKk4EAPP4NS46AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7rPX0rEGCz9z2zR1PGW1eLK1/ds
        Fp0Tl7BbLJjNbXF51xw2i0N90Q5sHu9vtLJ7XO7rZfKY3TGT1eN+93Emj81L6j0+b5ILYIvS
        synKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/jz6h1z
        wXaxiq+vdzA3MO4Q6mLk5JAQMJH48OgEWxcjF4eQwFJGibauJ8wQCXGJ3fPfQtnCEn+udUEV
        vWaUeN+8gamLkYNDWMBZ4thiW5AaEYFMiQdTLjKC2MwCaRJ/noL0gtQfZpT4+/A7E0iCTUBT
        4u/mm2wgNq+AnUTf1ttgcRYBVYl5/QvA4qICERJnX65jhKgRlDg58wkLiM0pYCuxte0BC8QC
        dYk/8y4xQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73i
        xNzi0rx0veT83E2MwHjbduzn5h2MlzYGH2IU4GBU4uFlOCEeI8SaWFZcmXuIUYKDWUmE91ap
        RIwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wNTQV5JvKGpobmFpaG5sbmxmYWSOO95g8oo
        IYH0xJLU7NTUgtQimD4mDk6pBsaClhXS21XUH/74pjXlasLaRm7TGyUhk7kVeBWLLZw+KsW/
        6y5PDv9+L86iJqbiQs+SyTtPp0j9n/x9uWb67ptLepm3Xf7gUsn+xOKj5/2trnUBbld2nip6
        HKEb9n33ZUb+OW4hhtseL0kWNr0ezLInOmxV3oLgnsKKVbdvCPCW7ff8tfwP3yslluKMREMt
        5qLiRAC8j0xIzQIAAA==
X-CMS-MailID: 20181218123655eucas1p1e45a37e79c605233f944ad8c9a5767c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181130134341epcas3p47020dea94fe298a3a58ab3007bfd5d75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130134341epcas3p47020dea94fe298a3a58ab3007bfd5d75
References: <20181130134301.17963-1-narmstrong@baylibre.com>
        <CGME20181130134341epcas3p47020dea94fe298a3a58ab3007bfd5d75@epcas3p4.samsung.com>
        <20181130134301.17963-3-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2018 14:42, Neil Armstrong wrote:
> Add support for TMDS Clock > 3.4GHz for HDMI2.0 display modes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 807111ebfdd9..b8775102b100 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -365,7 +365,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>  	unsigned int wr_clk =
>  		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
>  
> -	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
> +	DRM_DEBUG_DRIVER("%d:\"%s\" div%d\n", mode->base.id, mode->name,
> +			 mode->clock > 340000 ? 40 : 10);
>  
>  	/* Enable clocks */
>  	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
> @@ -385,9 +386,17 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>  	/* Enable normal output to PHY */
>  	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
>  
> -	/* TMDS pattern setup (TOFIX pattern for 4k2k scrambling) */
> -	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0x001f001f);
> -	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23, 0x001f001f);
> +	/* TMDS pattern setup (TOFIX Handle the YUV420 case) */
> +	if (mode->clock > 340000) {
> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0);
> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
> +				  0x03ff03ff);
> +	} else {
> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
> +				  0x001f001f);
> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
> +				  0x001f001f);
> +	}
>  
>  	/* Load TMDS pattern */
>  	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x1);
> @@ -413,6 +422,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>  	/* Disable clock, fifo, fifo_wr */
>  	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
>  
> +	dw_hdmi_set_high_tmds_clock_ratio(hdmi);
> +
>  	msleep(100);
>  
>  	/* Reset PHY 3 times in a row */
> @@ -562,6 +573,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>  		mode->vdisplay, mode->vsync_start,
>  		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
>  
> +	/* If sink max TMDS clock < 340MHz, we reject the HDMI2.0 modes */
> +	if (mode->clock > 340000 &&
> +	    connector->display_info.max_tmds_clock < 340000)
> +		return MODE_BAD;
> +


Why not just:

if (mode->clock > connector->display_info.max_tmds_clock)
	return MODE_BAD;


Regards

Andrzej


>  	/* Check against non-VIC supported modes */
>  	if (!vic) {
>  		status = meson_venc_hdmi_supported_mode(mode);


