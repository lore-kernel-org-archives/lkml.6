Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49AF2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DUIqVVAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLRMZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:25:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53108 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:25:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181218122514euoutp0253376ea917e7e161e0867bb40eac865c~xbO2B57Ho1572115721euoutp02z
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:25:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181218122514euoutp0253376ea917e7e161e0867bb40eac865c~xbO2B57Ho1572115721euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545135914;
        bh=TZdB6BoLIaIoWgLX2JzgN1BqyZzc6Ely6skPYcaYgqo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DUIqVVAOzK/sb7lD0p4WaDw0WkK0xwzYJkMX5E3YDWMTZStuwaFOhxo2jx/gbk+xd
         NBZuiVI0DdlVTd2QvVcbAnqczO/GBfd6B/oIg2KA4bCnMLJ16J0orJtJE4uFy94sbS
         FW1dk/hbQw4tyKRaaG1quItpqnj19PRvy+QPGRMM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181218122513eucas1p2487f99c8d9967cf6e4cd511503d392a8~xbO1OpOXJ0666006660eucas1p2c;
        Tue, 18 Dec 2018 12:25:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1A.6F.04294.927E81C5; Tue, 18
        Dec 2018 12:25:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181218122512eucas1p23885bab4434bb7aaa350c26e0247067b~xbO0LeNa40666106661eucas1p2W;
        Tue, 18 Dec 2018 12:25:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181218122512eusmtrp28f9032a85eb55613c02067cbcf1db262~xbOz8n8UL1809718097eusmtrp2z;
        Tue, 18 Dec 2018 12:25:12 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-72-5c18e72989f2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.64.04284.827E81C5; Tue, 18
        Dec 2018 12:25:12 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181218122511eusmtip29664c29c913ff835a46415e191e4a532~xbOzal3kM1639516395eusmtip2P;
        Tue, 18 Dec 2018 12:25:11 +0000 (GMT)
Subject: Re: [PATCH RFC v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS
 Scrambling support
To:     Neil Armstrong <narmstrong@baylibre.com>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <66eb4d1d-8924-2ee7-7fa4-5b78ae8cea0f@samsung.com>
Date:   Tue, 18 Dec 2018 13:25:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130134301.17963-2-narmstrong@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djP87qazyViDDrXiFk0dbxltbjy9T2b
        xf9Hr1kt5k6qteicuITdYsFsbovLu+awWTx4uZ/R4lBftMXS3+8YLe7eO8Fi0fByJ7MDj8f7
        G63sHvPWVHtc7utl8pjdMZPV4373cSaPzUvqPfr/Gnj8nbWfxWP7tXnMHp83yQVwRXHZpKTm
        ZJalFunbJXBlLDviWvDJuWLqytdsDYybzLoYOTkkBEwkeifvYuxi5OIQEljBKDH79l0WCOcL
        o8SepjXsEM5nRom2l5uYYVranh1ghUgsZ5T4c3kSVNVbRol7H+8xglQJC0RLbLi3HWywiEAL
        k8T3GU+ZQRxmgc2MEn2/JoLNYhPQlPi7+SYbiM0rYCcxt/8rE4jNIqAq8ffCBLBJogIREh33
        V0PVCEqcnPmEBcTmFLCV6GtcB2YzC8hLNG+dzQxhi0vcejKfCWSZhMBXdonT/3ZBHe4icX3/
        e0YIW1ji1fEt7BC2jMT/nfOZIOx6iaaZV5ghmjsYJU4sXs4GkbCWOHz8ItDXHEAbNCXW79KH
        CDtKrFk/lxkkLCHAJ3HjrSDEDXwSk7ZNhwrzSnS0CUFUK0rcP7sV6hpxiaUXvrJNYFSaheSz
        WUi+mYXkm1kIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITG+n/x3/soNx15+k
        Q4wCHIxKPLwrjorHCLEmlhVX5h5ilOBgVhLhvVUqESPEm5JYWZValB9fVJqTWnyIUZqDRUmc
        t5rhQbSQQHpiSWp2ampBahFMlomDU6qBkScsb8O69pYrn5v0ejTsYjLEMp1mvTZ9uMDz4ffj
        Ko5Le7JvV4RzV8cYh39JsA/YuHipfMSFW6c/aqgGhGmcUZjXsVVomf6tB92ROY+++sgZKlqc
        CZzXc/Zj2WELJa/fxgs2v6q/pLbpUnic4qa/5/gmJXZF3ji3y6ImVbv1Q3Xg7NNhtxpNlViK
        MxINtZiLihMBzlCSmWsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xe7oazyViDD4d4bZo6njLanHl63s2
        i/+PXrNazJ1Ua9E5cQm7xYLZ3BaXd81hs3jwcj+jxaG+aIulv98xWty9d4LFouHlTmYHHo/3
        N1rZPeatqfa43NfL5DG7Yyarx/3u40wem5fUe/T/NfD4O2s/i8f2a/OYPT5vkgvgitKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWHbEteCTc8XU
        la/ZGhg3mXUxcnJICJhItD07wNrFyMUhJLCUUWLh6zvsEAlxid3z3zJD2MISf651sUEUvWaU
        OHNpOlhCWCBaYsO97YwgtohAC5PEy+fWIEXMApsZJU6dXA1WJCRwmFHiyoQaEJtNQFPi7+ab
        bCA2r4CdxNz+r0wgNouAqsTfCxPABokKREicfbmOEaJGUOLkzCcsIDangK1EX+M6MJtZQF3i
        z7xLzBC2vETz1tlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhb
        XJqXrpecn7uJERjN24793LyD8dLG4EOMAhyMSjy8DCfEY4RYE8uKK3MPMUpwMCuJ8N4qlYgR
        4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgoskriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQ
        nliSmp2aWpBaBNPHxMEp1cCYbX/2xsqwxJDpRrvPpDpvsXlhUBR4eGtFZm90i/O1QNGnky7U
        m+R/WqK7PXPh/gn3+Nzf9/7nElE3nz31T/wsycyZ3LLN6qIdM6bclBaevCvDx/CFdh6bQMgl
        syOv3ilp9Xc4KEb+2bvPrXoHQ1O4emSeFV9V+E6dzcssbcrS4pzkmCcmWCqxFGckGmoxFxUn
        AgAG1OjO/AIAAA==
X-CMS-MailID: 20181218122512eucas1p23885bab4434bb7aaa350c26e0247067b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181130134341epcas3p330f854d94ebca73704d6582158d7d5b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130134341epcas3p330f854d94ebca73704d6582158d7d5b7
References: <20181130134301.17963-1-narmstrong@baylibre.com>
        <CGME20181130134341epcas3p330f854d94ebca73704d6582158d7d5b7@epcas3p3.samsung.com>
        <20181130134301.17963-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,


On 30.11.2018 14:42, Neil Armstrong wrote:
> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> Scrambling when supported or mandatory.
>
> This patch also adds an helper to setup the control bit to support
> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
>
> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
> on the Rockchip 4.4 BSP kernel at [1]
>
> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>
> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> Cc: Huicong Xu <xhc@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 88 ++++++++++++++++++++++-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
>  include/drm/bridge/dw_hdmi.h              |  1 +
>  3 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 64c3cf027518..fcd941d52753 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -28,6 +28,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder_slave.h>
> +#include <drm/drm_scdc_helper.h>
>  #include <drm/bridge/dw_hdmi.h>
>  
>  #include <uapi/linux/media-bus-format.h>
> @@ -43,6 +44,11 @@
>  
>  #define HDMI_EDID_LEN		512
>  
> +/* DW-HDMI Controller >= 0x200a are at least compliant with SCDC version 1 */
> +#define SCDC_MIN_SOURCE_VERSION	0x1
> +
> +#define HDMI14_MAX_TMDSCLK	340000000
> +
>  enum hdmi_datamap {
>  	RGB444_8B = 0x01,
>  	RGB444_10B = 0x03,
> @@ -1015,6 +1021,33 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
>  
> +/*
> + * HDMI2.0 Specifies the following procedure for High TMDS Bit Rates:
> + * - The Source shall suspend transmission of the TMDS clock and data
> + * - The Source shall write to the TMDS_Bit_Clock_Ratio bit to change it
> + * from a 0 to a 1 or from a 1 to a 0
> + * - The Source shall allow a minimum of 1 ms and a maximum of 100 ms from
> + * the time the TMDS_Bit_Clock_Ratio bit is written until resuming
> + * transmission of TMDS clock and data
> + *
> + * To respect the 100ms maximum delay, the dw_hdmi_set_high_tmds_clock_ratio()
> + * helper should called right before enabling the TMDS Clock and Data in
> + * the PHY configuration callback.
> + */
> +void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
> +{
> +	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mpixelclock;
> +
> +	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
> +	if (hdmi->connector.display_info.hdmi.scdc.supported) {
> +		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
> +			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
> +		else
> +			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 0);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_set_high_tmds_clock_ratio);
> +
>  static void dw_hdmi_phy_enable_powerdown(struct dw_hdmi *hdmi, bool enable)
>  {
>  	hdmi_mask_writeb(hdmi, !enable, HDMI_PHY_CONF0,
> @@ -1216,6 +1249,8 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
>  
>  	dw_hdmi_phy_power_off(hdmi);
>  
> +	dw_hdmi_set_high_tmds_clock_ratio(hdmi);
> +
>  	/* Leave low power consumption mode by asserting SVSRET. */
>  	if (phy->has_svsret)
>  		dw_hdmi_phy_enable_svsret(hdmi, 1);
> @@ -1237,6 +1272,10 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
>  		return ret;
>  	}
>  
> +	/* Wait for resuming transmission of TMDS clock and data */
> +	if (mpixelclock > HDMI14_MAX_TMDSCLK)
> +		msleep(100);
> +
>  	return dw_hdmi_phy_power_on(hdmi);
>  }
>  
> @@ -1340,11 +1379,12 @@ static void hdmi_tx_hdcp_config(struct dw_hdmi *hdmi)
>  
>  static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  {
> +	bool is_hdmi2_sink = hdmi->connector.display_info.hdmi.scdc.supported;
>  	struct hdmi_avi_infoframe frame;
>  	u8 val;
>  
>  	/* Initialise info frame from DRM mode */
> -	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, false);
> +	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, is_hdmi2_sink);
>  
>  	if (hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format))
>  		frame.colorspace = HDMI_COLORSPACE_YUV444;
> @@ -1503,7 +1543,8 @@ static void hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi,
>  static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  			     const struct drm_display_mode *mode)
>  {
> -	u8 inv_val;
> +	u8 inv_val, bytes;
> +	struct drm_hdmi_info *hdmi_info = &hdmi->connector.display_info.hdmi;
>  	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
>  	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
>  	unsigned int vdisplay;
> @@ -1513,7 +1554,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
>  
>  	/* Set up HDMI_FC_INVIDCONF */
> -	inv_val = (hdmi->hdmi_data.hdcp_enable ?
> +	inv_val = (hdmi->hdmi_data.hdcp_enable ||
> +		   vmode->mpixelclock > HDMI14_MAX_TMDSCLK ||
> +		   hdmi_info->scdc.scrambling.low_rates ?
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
>  
> @@ -1562,6 +1605,45 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  		vsync_len /= 2;
>  	}
>  
> +	/* Scrambling Control */
> +	if (hdmi_info->scdc.supported) {
> +		if (vmode->mpixelclock > HDMI14_MAX_TMDSCLK ||
> +		    hdmi_info->scdc.scrambling.low_rates) {
> +			/*
> +			 * HDMI2.0 Specifies the following procedure:
> +			 * After the Source Device has determined that
> +			 * SCDC_Present is set (=1), the Source Device should
> +			 * write the accurate Version of the Source Device
> +			 * to the Source Version field in the SCDCS.
> +			 * Source Devices compliant shall set the
> +			 * Source Version = 1.
> +			 */
> +			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
> +				       &bytes);
> +			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
> +				min_t(u8, bytes, SCDC_MIN_SOURCE_VERSION));
> +
> +			/* Enabled Scrambling in the Sink */
> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
> +
> +			/*
> +			 * To activate the scrambler feature, you must ensure
> +			 * that the quasi-static configuration bit
> +			 * fc_invidconf.HDCP_keepout is set at configuration
> +			 * time, before the required mc_swrstzreq.tmdsswrst_req
> +			 * reset request is issued.
> +			 */
> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,


Are you sure you need casting to u8?


> +				    HDMI_MC_SWRSTZ);
> +			hdmi_writeb(hdmi, 1, HDMI_FC_SCRAMBLER_CTRL);
> +		} else {
> +			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
> +				    HDMI_MC_SWRSTZ);
> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
> +		}
> +	}
> +
>  	/* Set up horizontal active pixel width */
>  	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
>  	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> index 9d90eb9c46e5..3f3c616eba97 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> @@ -255,6 +255,7 @@
>  #define HDMI_FC_MASK2                           0x10DA
>  #define HDMI_FC_POL2                            0x10DB
>  #define HDMI_FC_PRCONF                          0x10E0
> +#define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
>  
>  #define HDMI_FC_GMD_STAT                        0x1100
>  #define HDMI_FC_GMD_EN                          0x1101
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 9c56412bb2cf..7a02744ce0bc 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -157,6 +157,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
>  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
>  void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
>  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
> +void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi);
>  
>  /* PHY configuration */
>  void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej



