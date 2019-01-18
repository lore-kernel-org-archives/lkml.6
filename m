Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C5BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F2320823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ctUNzI1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfARJNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:13:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40970 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfARJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:13:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190118091332euoutp020b67e496b020a9df28e6c709e69ca972~65nT670DP0831608316euoutp02X
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:13:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190118091332euoutp020b67e496b020a9df28e6c709e69ca972~65nT670DP0831608316euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547802812;
        bh=vt/O1IqgyF9iP3ui5rT6sVTWe44+N6bydzXUC5j7oP4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ctUNzI1AykGHQ2EV+nvMzQ/aAcDFfRPOkc045oH2RsihlRJhAU20EdmS+LF2uthfn
         1t4hfrzYlUk7D35cAbZFzxzIGXCsvHqsNfBokYnxy57sT5FfCmQpkf4Hft5sCvsz8s
         j6qGDKiW8XEEkkdTFDkzMim67cAeo88+xDiQUkAs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190118091331eucas1p28d7bbb1e258e7b92a4f005c68e66658e~65nTVKjNP2657326573eucas1p2-;
        Fri, 18 Jan 2019 09:13:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.64.04294.BB8914C5; Fri, 18
        Jan 2019 09:13:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190118091330eucas1p2478410cf9299c2a3073b48d638a71123~65nSl5xPV2657326573eucas1p28;
        Fri, 18 Jan 2019 09:13:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190118091330eusmtrp2c674ccc3443fa27e976e2983812c24f5~65nSWH3Wa2409924099eusmtrp2L;
        Fri, 18 Jan 2019 09:13:30 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-3f-5c4198bb9c95
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 33.8F.04284.AB8914C5; Fri, 18
        Jan 2019 09:13:30 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190118091330eusmtip17b1eb3eaf6171b6e6df3a22404475f65~65nSEy3Yz1514515145eusmtip1b;
        Fri, 18 Jan 2019 09:13:30 +0000 (GMT)
Subject: Re: [PATCH 2/8] drm/meson: add HDMI div40 TMDS mode
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <5103b2e8-2f73-da18-a043-fa45d6e2c139@samsung.com>
Date:   Fri, 18 Jan 2019 10:13:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115123315.11069-3-narmstrong@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87q7ZzjGGOzs4bC48vU9m0XnxCXs
        Fgtmc1tc3jWHzeJQX7QDq8f7G63sHrM7ZrJ63O8+zuSxeUm9x+dNcgGsUVw2Kak5mWWpRfp2
        CVwZqy5+Yi84LF4x78FZpgbGncJdjJwcEgImEptXPWbvYuTiEBJYwSix9eMlRgjnC6PErf/b
        WSGcz4wSh3fPZ4Rpeb/3JlTVckaJLRfaoKreMkos/trIBlIlLGAj8XDND3YQW0QgUOJ47zaw
        bmaBNIlbMw6xgthsApoSfzffBKvnFbCTmPnmFFicRUBVYvasn2D1ogIREh33V0PVCEqcnPmE
        BcTmFLCVmD9vMzvETHmJ5q2zmSFscYlbT+YzgRwkITCPXWLC8tXMEGe7SNzacp8JwhaWeHV8
        CzuELSPxf+d8qHi9RNPMK8wQzR2MEicWL2eDSFhLHD5+Eeg6DqANmhLrd+lDhB0lNrwGOZQD
        yOaTuPFWEOIGPolJ26YzQ4R5JTrahCCqFSXun90KdY24xNILX9kmMCrNQvLZLCTfzELyzSyE
        vQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpprT/45/2cG460/SIUYBDkYlHt4J
        WxxihFgTy4orcw8xSnAwK4nwGkx1jBHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2x
        JDU7NbUgtQgmy8TBKdXA6Hfp5rdFCdoqBYcXVMVzXAraVzm/eOaU8/+sdyc51T4U6lYS2PJh
        8efsTeqMhz5nV54PPh8avO/aZ/l1G19F//78wqVm9v0tJ3Rq1DZVTzj1cNvJhh0zmVfw3ff/
        naE1YeWHNWZ6zHbaKfXVx9dz5yb0Rbsdk0+zurNZfcGCsEvMQb63ufNmBSmxFGckGmoxFxUn
        AgAZABElMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7q7ZjjGGBw4KmJx5et7NovOiUvY
        LRbM5ra4vGsOm8WhvmgHVo/3N1rZPWZ3zGT1uN99nMlj85J6j8+b5AJYo/RsivJLS1IVMvKL
        S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyVl38xF5wWLxi3oOzTA2M
        O4W7GDk5JARMJN7vvcnYxcjFISSwlFHizYJfjBAJcYnd898yQ9jCEn+udbFBFL1mlLgwdRNY
        QljARuLhmh/sILaIQKDEot4FYHFmgTSJP09BmkEaDjNKnL47kwkkwSagKfF38002EJtXwE5i
        5ptTrCA2i4CqxOxZP8E2iwpESJx9uY4RokZQ4uTMJywgNqeArcT8eZvZIRaoS/yZdwlqmbxE
        89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7
        iREYXduO/dy8g/HSxuBDjAIcjEo8vC+2OcQIsSaWFVfmHmKU4GBWEuE1mOoYI8SbklhZlVqU
        H19UmpNafIjRFOi5icxSosn5wMjPK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQ
        WgTTx8TBKdXAWPX0WsuDlPQn34IVf5w2qNh3yn0pm7nn440rNnDPCQic//Pd/ezr3uxpRyea
        q36Ofb5l98zQU0lHFvEFzVQ9U/3swg/+/0v+/ImQCbG4nl77Tr1QfMnZRDbJ2eLuXlufG7Xz
        x/JzLGhpMuGNUL8+kzfs8hnN42YvvC+YePu8vmd9cKbSJOktpkosxRmJhlrMRcWJAOfyCnnE
        AgAA
X-CMS-MailID: 20190118091330eucas1p2478410cf9299c2a3073b48d638a71123
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190115123329epcas2p238b0b8a9f449f96991e02b34c54741ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190115123329epcas2p238b0b8a9f449f96991e02b34c54741ca
References: <20190115123315.11069-1-narmstrong@baylibre.com>
        <CGME20190115123329epcas2p238b0b8a9f449f96991e02b34c54741ca@epcas2p2.samsung.com>
        <20190115123315.11069-3-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.2019 13:33, Neil Armstrong wrote:
> Add support for TMDS Clock > 3.4GHz for HDMI2.0 display modes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 807111ebfdd9..3d8decb77019 100644
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


    val = mode->clock > 340000 ? 0x03ff03ff : 0x001f001f;
    dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, val);

    dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23, val);


The best would be to replace these magic values with descriptive macros.


Regards

Andrzej


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
> @@ -562,6 +573,10 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>  		mode->vdisplay, mode->vsync_start,
>  		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
>  
> +	/* If sink max TMDS clock, we reject the mode */
> +	if (mode->clock > connector->display_info.max_tmds_clock)
> +		return MODE_BAD;
> +
>  	/* Check against non-VIC supported modes */
>  	if (!vic) {
>  		status = meson_venc_hdmi_supported_mode(mode);


