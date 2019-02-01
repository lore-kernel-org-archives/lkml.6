Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A92C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF152080D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e2DeQ0WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfBALdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:33:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfBALdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:33:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so6691668wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 03:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=ZXYlc63H7De0rj7SJNfiljjCCHb3Fnm0LQrGE6/dy/8=;
        b=e2DeQ0WPK6Y3XGEaVgurOx36j3qPyB28xrm0q5FaAYBlQ3y8li/WOjVhWWroTKLvZV
         vWnoHtbqvwNSruP2zSTp8lQZ11KH1HWX4oUH8tOncY8VRBgqw3W+yrnYpbrSOCD7Zzda
         TBiLkNBfi/QKyR9mg6LBsuwZebJvEL486hVJ7dCSOBU2a0m+40aOIxMGwktHqhTaPkVc
         f1mTR2dDdEQlpe3uH+PSHTAXa6IDr91jcNlBYSspeDVjzzuzK6aVj1M2Gcj2VNChGJfs
         oce8IqgX7J4+8Ngo8gqe1SJmfsJ4V/2QXkjC5ZS/sVqizStL7uir6ErX8KwParDjA293
         4AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=ZXYlc63H7De0rj7SJNfiljjCCHb3Fnm0LQrGE6/dy/8=;
        b=PxJ/8V3SL4dJ/q/wRaXcgbwYAPheZ6mdJ2Xgnb7/ZWcOtedKXlznKw34uS9uY64Sqb
         6XL0L66own9Y+uYqpRAtqtoyJBLmxOm/Aqk+/C14eUpLsFh7QAeIs7ujHefw2KUcS0AT
         6j9OYh3cVHV7qlTKwjb3cBCQvo+1h7vJIi6+ZXbc5s6nEmET6saFK635SbDR9ZJrs25C
         zOr99NAZ3lOlED3JR8NuvZI7sVf9VllvHCN/9jzcveE0Qybd0+EZ4YTHBUH+BUWMifM+
         btNt0Tkuc+uyhDx2aC5ycO1nzp38fToVHnK3SIpbv/rpKOkvHtZC1X4bVLqq0gHrRPrl
         4YBw==
X-Gm-Message-State: AJcUukdt+/WmC6MbPdvlF5C+xlFYq6h/m2ughvar0bZWPEYNsJSyqQSM
        brlsGpmTUZDQdfCLK7ggILpz4w==
X-Google-Smtp-Source: ALg8bN4Dmm9f/fICAS1iGn7PkjOV1zjh5BWr2fAplYgjZSc1nGfUVHRKgmjloL2XPoKCik01rSe3lg==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr38773824wrc.191.1549020829579;
        Fri, 01 Feb 2019 03:33:49 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id x3sm10712897wrd.19.2019.02.01.03.33.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 03:33:48 -0800 (PST)
Message-ID: <5C542E9B.4020408@baylibre.com>
Date:   Fri, 01 Feb 2019 12:33:47 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
CC:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/8] drm/meson: Add support for HDMI2.0 4k60
References: <20190115123315.11069-1-narmstrong@baylibre.com>    <CGME20190131132546epcas5p264ec54cb60053b409f0459f809825eef@epcas5p2.samsung.com>       <a3de23a8-3fa4-f8c5-5b2a-33109c09a863@baylibre.com>     <0fa602d6-a57e-0248-fcfd-929e3d9ceab1@samsung.com>      <3f28a247-f6d3-be03-ca9f-15dfee1939c2@baylibre.com> <9ba7a251-103e-0cfd-f77e-e78cc1e56ad8@samsung.com>
In-Reply-To: <9ba7a251-103e-0cfd-f77e-e78cc1e56ad8@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/02/2019 11:25, Andrzej Hajda a écrit :
> On 31.01.2019 16:50, Neil Armstrong wrote:
>> On 31/01/2019 15:13, Andrzej Hajda wrote:
>>> On 31.01.2019 14:25, Neil Armstrong wrote:
>>>> Hi Andrzej, Laurent,
>>>>
>>>> On 15/01/2019 13:33, Neil Armstrong wrote:
>>>>> This patchset aims to add support for the following HDMI2.0 4k60 modes:
>>>>> - 594Mhz TMDS frequency needing TMDS Scramling and 1/40 rate for RGB/YUV4:4:4
>>>>> - 297MHz TMDS frequency with YUV4:2:0 encoding
>>>>>
>>>>> The first mode uses the SCDC helpers introduced by intel to :
>>>>> - discover where the monitor support SCDC
>>>>> - setup the SCDC parameters
>>>>> This is implemented in the dw-hdmi bridge driver by handling scrambling
>>>>> support during the bridge setup and by exporting an helper for the PHY
>>>>> setup to setup the SCDC configuration for the 1/40 TMDS rate.
>>>>> This code will only be active if the encoder support a TMDS rate > 340MHz.
>>>>>
>>>>> This patch could eventually break support on different SoC when connected
>>>>> on a 4k60 monitor with SCDC :
>>>>> - i.MX correctly discards pixel clocks > 216MHz
>>>>> - R-CAR discards discards pixel clocks > 297MHz since [1]
>>>>> - Rockchip discards invalid pixel clocks not in the rockchip_mpll_cfg table
>>>>> - sun8i correctly discards pixel clocks > 297MHz on a83t
>>>>> - sun8i discards discards pixel clocks > 594Mhz on h6, which is already broken
>>>>>
>>>>> First patch should fix support for Allwinner H6.
>>>>>
>>>>> The second mode is implemented by added the missing 4:2:0 bypass handling
>>>>> in the dw-hdmi bridge driver and adding a "mtmdsclock" separating the
>>>>> pixel clock from the tmds clock in the mode setup phase.
>>>>> We also enable support for these modes in the connector only if the platform
>>>>> glue code explicits the support.
>>>> Do you think patches 1-4 could be applied ?
>>>
>>> For me they are OK.
>>>
>>> Should I take them via drm-misc?
>> OK for me !
>>
>> Neil
> 
> 
> These patches do not apply. Could you rebase them on drm-misc-next.

Sure, re-spinning.

Neil

> 
> 
> Regards
> 
> Andrzej
> 
> 
> 
>>
>>>
>>>> Then we could focus on how we manage the bus format between the encoder
>>>> and the bridge ?
>>>>
>>>> Especially patch 5 linked to patch 7.
>>>>
>>>> Will one of you be at FOSDEM 2019 ? we could chat about this.
>>>
>>> Nope.
>>>
>>>
>>> Regards
>>>
>>> Andrzej
>>>
>>>
>>>> Following subjects on the table will be :
>>>> - HDR metadata transmission aligned with the last patchset sent by intel-gfx
>>>> - Colorspace connector property aligned with the last patchset sent by intel-gfx
>>>> - HDCP 1.4 and 2.2 handling
>>>>
>>>> Neil
>>>>
>>>>> Only the meson DRM dw_hdmi glue allows ycbcr420 modes, so no breakage
>>>>> is expected here.
>>>>>
>>>>> The remaining patches adds support for :
>>>>> - 1/40 TMDS rate aka DIV40 in the dw-hdmi meson PHY setup
>>>>> - 4:2:0 output and clock setup
>>>>>
>>>>> The dw-hdmi support re-uses the support done by Rockchip engineers on the
>>>>> Linux 4.4 BSP kernel.
>>>>>
>>>>> These modes has been validated using a MuxLab HDMI Signal Analyser in
>>>>> addition to different UHD TVs supporting full 4k60 or the 4:2:0 variant.
>>>>>
>>>>> Changes since RFC v2 at [3]:
>>>>> - Collected tested-by and reviewed-by tags
>>>>> - Changed if condition in "add HDMI div40 TMDS mode"
>>>>> - Updated "Add YUV420 output support" with the same if condition
>>>>>
>>>>> Changes since RFC v1 at [2]:
>>>>> - Fix all comments from Laurent :
>>>>> - Add define for HDMI 1.4 max tmds clock and SCDC supported version
>>>>> - Call dw_hdmi_set_high_tmds_clock_ratio() in dw_hdmi_phy_enable_powerdown()
>>>>> to unbreak Allwinner H6
>>>>> - Pass in_t(u8, bytes, SCDC_MIN_SOURCE_VERSION) as SCDC version
>>>>> - Finally add comments for SCDC and Scrambling process
>>>>>
>>>>> [1] https://patchwork.freedesktop.org/patch/263616/
>>>>> [2] https://patchwork.freedesktop.org/series/52950/#rev1
>>>>> [3] https://patchwork.freedesktop.org/series/52950/#rev2
>>>>>
>>>>> Neil Armstrong (7):
>>>>>   drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
>>>>>   drm/meson: add HDMI div40 TMDS mode
>>>>>   drm/meson: add support for HDMI2.0 2160p modes
>>>>>   drm/bridge: dw-hdmi: add support for YUV420 output
>>>>>   drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
>>>>>   drm/meson: Add YUV420 output support
>>>>>   drm/meson: Output in YUV444 if sink supports it
>>>>>
>>>>> Zheng Yang (1):
>>>>>   drm/bridge: dw-hdmi: support dynamically get input/out color info
>>>>>
>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 182 +++++++++++++++++++---
>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |   1 +
>>>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 128 ++++++++++++---
>>>>>  drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++++---
>>>>>  drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
>>>>>  drivers/gpu/drm/meson/meson_venc.c        |   8 +-
>>>>>  drivers/gpu/drm/meson/meson_venc.h        |  11 ++
>>>>>  drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
>>>>>  include/drm/bridge/dw_hdmi.h              |   7 +
>>>>>  9 files changed, 374 insertions(+), 66 deletions(-)
>>>>>
>>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>
>>
> 
