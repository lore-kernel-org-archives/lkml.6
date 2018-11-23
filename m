Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C73CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72CD20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xJ+VbUbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72CD20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440012AbeKXBNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:13:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34836 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeKXBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:13:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so12561154wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aGmNONmQY9Dl7+JuTRbRS2kIVYaJksqfmTwUxMRiY+o=;
        b=xJ+VbUbo72E5UVdsE6tN/ulX/y79EUxVKE5svjTSip+NeuNT/aNa9ndT2o8z++IbSr
         m4EeEHDaKffoq2s1E0FZ7WzBw5rMAhswujwjcP5q6OC7xZBu8hzT2GxuoB+rA/wJ13Jk
         jxBWCqnEf6RKeTmGmEZGfaHIBVlaQiLCpB9ObhiMpgtutYOoROPI0cHXRap9C1Z8dXs4
         UFp2s+HV2TGV2vpqEvIVIZuI63pOSReYuOYcVmaZqFzRQ0wE6X5wX66BZdlHXzLPgbQ4
         XKz8vsg+JfnwFXm1TUW26FovtK7nV7KX4P1xlfdnLGmX19FyXtHUf533HpvsWfOgWPYj
         vNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aGmNONmQY9Dl7+JuTRbRS2kIVYaJksqfmTwUxMRiY+o=;
        b=jl1IngrVy5kSFpCZSyytr2nM2ylb8mR7PjXgycONYZQYVNlayCDupInuGYq2Gj+gbQ
         A4TEM1oBoP0gYJXi+OU7Y/+8efBO3mH7gJCjZ/7yj5fTm+KCsX2Y8lT8H5YVIm7ABJY4
         BJTSKdqWcRO7PRbZIPlKfrD2AQqf7N/VcoQbg9RMTyoeyockVIk8BwJSPE5l2swq2sRs
         8llPSR5P2kCOrIkm1/SvOaYDttFpl33u9FG91QkRnq9J2UZ9GbL2nXhbPt39PTBJXpaW
         GhJmhzO8uUE1eqKzfGjJh21gUs1lhhDCtWNKFGx6i0D9qykKpMwdq4oLHLim+bqUXA1H
         JBXQ==
X-Gm-Message-State: AA+aEWa1kCBrzjPAjbNxuFKOi/gqj3T3ynGazCR39V+TeprVMzGP3Am6
        C16bDxFFjX9yMklNJ+PGTcfusw==
X-Google-Smtp-Source: AFSGD/WUgGbqZ76dv6L8XUdElC6s8gCNI6mJ9wCCXUByYbmkJMAQPe1tTUA5bwG7nFxMO1hJOvQwdA==
X-Received: by 2002:adf:b649:: with SMTP id i9mr14717613wre.70.1542983357880;
        Fri, 23 Nov 2018 06:29:17 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a11sm6530584wmh.26.2018.11.23.06.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 06:29:17 -0800 (PST)
Subject: Re: [PATCH RFC 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling
 support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
 <20181123140221.15700-2-narmstrong@baylibre.com> <1880382.AeP59NOuia@avalon>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <ca86b176-603b-8983-f6af-95e2bdce4aab@baylibre.com>
Date:   Fri, 23 Nov 2018 15:29:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1880382.AeP59NOuia@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 23/11/2018 15:25, Laurent Pinchart wrote:
> Hi Neil,
> 
> Thank you for the patch.
> 
> On Friday, 23 November 2018 16:02:14 EET Neil Armstrong wrote:
>> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
>> Scrambling when supported or mandatory.
>>
>> This patch also adds an helper to setup the control bit to support
>> the hight TMDS Bit Period/TMDS Clock-Period Ratio as required with
> 
> s/hight/high/ ?

Thanks for catching !

> 
>> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
> 
> Why do you need a helper for this, is there no way it could be handled 
> internally ?

I could, but all the platforms would also do it internally... seems better
to have common helper, no ? And it will be usable by the PHY models handler
in the dw-hdmi driver aswell.

> 
>> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
>> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
>> on the Rockchip 4.4 BSP kernel at [1]
>>
>> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>>
>> Cc: Nickey Yang <nickey.yang@rock-chips.com>
>> Cc: Huicong Xu <xhc@rock-chips.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 +++++++++++++++++++++--
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
>>  include/drm/bridge/dw_hdmi.h              |  1 +
>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>> 5971976284bf..523508af70b0 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -28,6 +28,7 @@
>>  #include <drm/drm_crtc_helper.h>
>>  #include <drm/drm_edid.h>
>>  #include <drm/drm_encoder_slave.h>
>> +#include <drm/drm_scdc_helper.h>
>>  #include <drm/bridge/dw_hdmi.h>
>>
>>  #include <uapi/linux/media-bus-format.h>
>> @@ -1015,6 +1016,20 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi,
>> unsigned short data, }
>>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
>>
>> +void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
>> +{
>> +	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mpixelclock;
>> +
>> +	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
>> +	if (hdmi->connector.display_info.hdmi.scdc.supported) {
>> +		if (mtmdsclock > 340000000)
> 
> You use the 3.4GHz frequency in a few places, how about creating a macro ?

Good idea.

> 
>> +			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
>> +		else
>> +			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 0);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(dw_hdmi_set_high_tmds_clock_ratio);
>> +
>>  static void dw_hdmi_phy_enable_powerdown(struct dw_hdmi *hdmi, bool enable)
>> {
>>  	hdmi_mask_writeb(hdmi, !enable, HDMI_PHY_CONF0,
>> @@ -1340,11 +1355,12 @@ static void hdmi_tx_hdcp_config(struct dw_hdmi
>> *hdmi)
>>
>>  static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode
>> *mode) {
>> +	bool is_hdmi2_sink = hdmi->connector.display_info.hdmi.scdc.supported;
>>  	struct hdmi_avi_infoframe frame;
>>  	u8 val;
>>
>>  	/* Initialise info frame from DRM mode */
>> -	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, false);
>> +	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, is_hdmi2_sink);
>>
>>  	if (hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format))
>>  		frame.colorspace = HDMI_COLORSPACE_YUV444;
>> @@ -1503,7 +1519,8 @@ static void
>> hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi, static void
>> hdmi_av_composer(struct dw_hdmi *hdmi,
>>  			     const struct drm_display_mode *mode)
>>  {
>> -	u8 inv_val;
>> +	u8 inv_val, bytes;
>> +	struct drm_hdmi_info *hdmi_info = &hdmi->connector.display_info.hdmi;
>>  	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
>>  	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
>>  	unsigned int vdisplay;
>> @@ -1513,7 +1530,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>>  	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
>>
>>  	/* Set up HDMI_FC_INVIDCONF */
>> -	inv_val = (hdmi->hdmi_data.hdcp_enable ?
>> +	inv_val = (hdmi->hdmi_data.hdcp_enable ||
>> +		   vmode->mpixelclock > 340000000 ||
>> +		   hdmi_info->scdc.scrambling.low_rates ?
>>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
>>
>> @@ -1562,6 +1581,26 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>>  		vsync_len /= 2;
>>  	}
>>
>> +	/* Scrambling Control */
>> +	if (hdmi_info->scdc.supported) {
>> +		if (vmode->mpixelclock > 340000000 ||
>> +		    hdmi_info->scdc.scrambling.low_rates) {
>> +			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
>> +				       &bytes);
>> +			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
>> +					bytes);
> 
> Shouldn't the source version be min(sink version, highest supported source 
> version) ?

How should the "highest supported source version" be defined ?

> 
>> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
>> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
>> +				    HDMI_MC_SWRSTZ);
>> +			hdmi_writeb(hdmi, 1, HDMI_FC_SCRAMBLER_CTRL);
>> +		} else {
>> +			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
>> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
>> +				    HDMI_MC_SWRSTZ);
>> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
>> +		}
>> +	}
>> +
>>  	/* Set up horizontal active pixel width */
>>  	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
>>  	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
>> 9d90eb9c46e5..3f3c616eba97 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> @@ -255,6 +255,7 @@
>>  #define HDMI_FC_MASK2                           0x10DA
>>  #define HDMI_FC_POL2                            0x10DB
>>  #define HDMI_FC_PRCONF                          0x10E0
>> +#define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
>>
>>  #define HDMI_FC_GMD_STAT                        0x1100
>>  #define HDMI_FC_GMD_EN                          0x1101
>> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
>> index ccb5aa8468e0..d7cc5d094270 100644
>> --- a/include/drm/bridge/dw_hdmi.h
>> +++ b/include/drm/bridge/dw_hdmi.h
>> @@ -156,6 +156,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool
>> hpd, bool rx_sense); void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi,
>> unsigned int rate); void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
>>  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
>> +void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi);
>>
>>  /* PHY configuration */
>>  void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);
> 
> 

Thanks for the review,

Neil
