Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3712D218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ovqWfZ7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfBAKZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:25:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39673 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfBAKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:25:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201102545euoutp0124796869efe5337769b2ba13adf0986f~-NoX9jtE11434414344euoutp01K
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 10:25:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201102545euoutp0124796869efe5337769b2ba13adf0986f~-NoX9jtE11434414344euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549016745;
        bh=rjAPUt/t5Vs4pdnIhm0gbsT2cJYjlngkMnOhui83yG0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ovqWfZ7Z8cHACivL0sCv6FCDutN332/V1BrXxjO5xYE800BeUfrLAum6SlRHy5tcK
         jx1NhToKanrID1C7Fnu1dSuwIbYmTrvZ1sxzuAYCNGOcYFtBDM+AU2guybXrbvnuNX
         5odzbGAB6qE7Su+3vz5YwHDFvfCacZoMNfR9YhuU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190201102545eucas1p1269ef65d3b31eef1bb53ebae744248a6~-NoXXB15T0644206442eucas1p13;
        Fri,  1 Feb 2019 10:25:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 63.21.04294.8AE145C5; Fri,  1
        Feb 2019 10:25:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201102544eucas1p2066d4e10423a04337eb1bd95d5f72550~-NoWkyseP2158621586eucas1p2b;
        Fri,  1 Feb 2019 10:25:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201102544eusmtrp206d3f1907357213efa1dea8db2a0638f~-NoWV4nz30170801708eusmtrp2c;
        Fri,  1 Feb 2019 10:25:44 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-57-5c541ea8fc6b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.55.04128.8AE145C5; Fri,  1
        Feb 2019 10:25:44 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201102543eusmtip22a74b47d8916e8d99e0e39682d75e765~-NoV7yTlK2525925259eusmtip2B;
        Fri,  1 Feb 2019 10:25:43 +0000 (GMT)
Subject: Re: [PATCH 0/8] drm/meson: Add support for HDMI2.0 4k60
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9ba7a251-103e-0cfd-f77e-e78cc1e56ad8@samsung.com>
Date:   Fri, 1 Feb 2019 11:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3f28a247-f6d3-be03-ca9f-15dfee1939c2@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7or5UJiDE4+Z7S48vU9m8X/R69Z
        LeZOqrXonLiE3WLBbG6Ly7vmsFk8eLmf0eJQX7TF3XsnWBw4Pd7faGX3mLem2mN2x0xWj/vd
        x5k8Ni+p9+j/a+Dxd9Z+Fo/t1+Yxe3zeJBfAGcVlk5Kak1mWWqRvl8CV8e3OZ5aCNs2K9Rdf
        sTcwtit2MXJySAiYSBzu+cnUxcjFISSwglGie/8rdgjnC6PEvMmfWUCqhAQ+M0rsuxcM03Hn
        22tWiKLljBK/NsxggXDeMkq8OHGYFaRKWMBB4sXZxYwgCRGBN4wS3xZuZwJJMAukSez+sIkZ
        xGYT0JT4u/kmG4jNK2AncaBvI5DNwcEioCLx5YYlSFhUIELicO87RogSQYmTM5+wgJRwAs2/
        MD8XYqK8xPa3c5ghbHGJW0/mg70jIXCNXaL57D1WkHoJAReJHYdKIB4Qlnh1fAs7hC0j8X/n
        fCYIu16iaeYVZojeDkaJE4uXs0EkrCUOH78INocZ6OT1u/QhRjpK9B6ogTD5JG68FYS4gE9i
        0rbpzBBhXomONiGIGYoS989uZYawxSWWXvjKNoFRaRaSt2Yh+WUWkl9mIaxdwMiyilE8tbQ4
        Nz212CgvtVyvODG3uDQvXS85P3cTIzBZnf53/MsOxl1/kg4xCnAwKvHwbvgVFCPEmlhWXJl7
        iFGCg1lJhHeBVEiMEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkm
        Dk6pBkZ3nV+3v7he9/q38UoB15zDRxKZDy00efix4Hz9h6xNAT99/gfqLBaZfyDw+Ma5ljuZ
        vxZw2Wn669ncqVqz78I9k8S5204ck+p7YjMldPORjr8/HL+vENw798wpz9LG2LsuS5eHT3ZU
        yT7olrol1zfqi///pUX3VM0Fbkiscjqfxvf9h8y/zxGHlFiKMxINtZiLihMBtw5malIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7or5EJiDO7v57a48vU9m8X/R69Z
        LeZOqrXonLiE3WLBbG6Ly7vmsFk8eLmf0eJQX7TF3XsnWBw4Pd7faGX3mLem2mN2x0xWj/vd
        x5k8Ni+p9+j/a+Dxd9Z+Fo/t1+Yxe3zeJBfAGaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8e3OZ5aCNs2K9RdfsTcwtit2MXJySAiYSNz59pq1
        i5GLQ0hgKaNE8/XnzBAJcYnd899C2cISf651sUEUvWaUmNq5khUkISzgIPHi7GJGkISIwBtG
        id8TL7ODJJgF0iSeHd0M1bGRSWLfr6mMIAk2AU2Jv5tvsoHYvAJ2Egf6NgLZHBwsAioSX25Y
        goRFBSIkPj7dxwRRIihxcuYTFpASTqBlF+bnQoxXl/gz7xIzhC0vsf3tHChbXOLWk/lMExiF
        ZiHpnoWkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNJtx35u2cHY9S74
        EKMAB6MSD++GX0ExQqyJZcWVuYcYJTiYlUR4F0iFxAjxpiRWVqUW5ccXleakFh9iNAV6bSKz
        lGhyPjCB5JXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYNzUHGpw
        b1eQ6uHkH4r+ZQovtIrutH3+cPDbt8NHfj7YrBcxf22ey8G+SYJJfnevxpfuX+jNPevGyysf
        ORn+rf1t3hxas2t27z13zcwnn9bcUw93DV0w5/uTTR3KUwq6Ti0+mhbLWXJdqTjg9E4G72tB
        Hbxubi8en9TsmcW0zKXg6rl/nEfF7p9TYinOSDTUYi4qTgQAENlhRugCAAA=
X-CMS-MailID: 20190201102544eucas1p2066d4e10423a04337eb1bd95d5f72550
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131132546epcas5p264ec54cb60053b409f0459f809825eef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131132546epcas5p264ec54cb60053b409f0459f809825eef
References: <20190115123315.11069-1-narmstrong@baylibre.com>
        <CGME20190131132546epcas5p264ec54cb60053b409f0459f809825eef@epcas5p2.samsung.com>
        <a3de23a8-3fa4-f8c5-5b2a-33109c09a863@baylibre.com>
        <0fa602d6-a57e-0248-fcfd-929e3d9ceab1@samsung.com>
        <3f28a247-f6d3-be03-ca9f-15dfee1939c2@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.2019 16:50, Neil Armstrong wrote:
> On 31/01/2019 15:13, Andrzej Hajda wrote:
>> On 31.01.2019 14:25, Neil Armstrong wrote:
>>> Hi Andrzej, Laurent,
>>>
>>> On 15/01/2019 13:33, Neil Armstrong wrote:
>>>> This patchset aims to add support for the following HDMI2.0 4k60 modes:
>>>> - 594Mhz TMDS frequency needing TMDS Scramling and 1/40 rate for RGB/YUV4:4:4
>>>> - 297MHz TMDS frequency with YUV4:2:0 encoding
>>>>
>>>> The first mode uses the SCDC helpers introduced by intel to :
>>>> - discover where the monitor support SCDC
>>>> - setup the SCDC parameters
>>>> This is implemented in the dw-hdmi bridge driver by handling scrambling
>>>> support during the bridge setup and by exporting an helper for the PHY
>>>> setup to setup the SCDC configuration for the 1/40 TMDS rate.
>>>> This code will only be active if the encoder support a TMDS rate > 340MHz.
>>>>
>>>> This patch could eventually break support on different SoC when connected
>>>> on a 4k60 monitor with SCDC :
>>>> - i.MX correctly discards pixel clocks > 216MHz
>>>> - R-CAR discards discards pixel clocks > 297MHz since [1]
>>>> - Rockchip discards invalid pixel clocks not in the rockchip_mpll_cfg table
>>>> - sun8i correctly discards pixel clocks > 297MHz on a83t
>>>> - sun8i discards discards pixel clocks > 594Mhz on h6, which is already broken
>>>>
>>>> First patch should fix support for Allwinner H6.
>>>>
>>>> The second mode is implemented by added the missing 4:2:0 bypass handling
>>>> in the dw-hdmi bridge driver and adding a "mtmdsclock" separating the
>>>> pixel clock from the tmds clock in the mode setup phase.
>>>> We also enable support for these modes in the connector only if the platform
>>>> glue code explicits the support.
>>> Do you think patches 1-4 could be applied ?
>>
>> For me they are OK.
>>
>> Should I take them via drm-misc?
> OK for me !
>
> Neil


These patches do not apply. Could you rebase them on drm-misc-next.


Regards

Andrzej



>
>>
>>> Then we could focus on how we manage the bus format between the encoder
>>> and the bridge ?
>>>
>>> Especially patch 5 linked to patch 7.
>>>
>>> Will one of you be at FOSDEM 2019 ? we could chat about this.
>>
>> Nope.
>>
>>
>> Regards
>>
>> Andrzej
>>
>>
>>> Following subjects on the table will be :
>>> - HDR metadata transmission aligned with the last patchset sent by intel-gfx
>>> - Colorspace connector property aligned with the last patchset sent by intel-gfx
>>> - HDCP 1.4 and 2.2 handling
>>>
>>> Neil
>>>
>>>> Only the meson DRM dw_hdmi glue allows ycbcr420 modes, so no breakage
>>>> is expected here.
>>>>
>>>> The remaining patches adds support for :
>>>> - 1/40 TMDS rate aka DIV40 in the dw-hdmi meson PHY setup
>>>> - 4:2:0 output and clock setup
>>>>
>>>> The dw-hdmi support re-uses the support done by Rockchip engineers on the
>>>> Linux 4.4 BSP kernel.
>>>>
>>>> These modes has been validated using a MuxLab HDMI Signal Analyser in
>>>> addition to different UHD TVs supporting full 4k60 or the 4:2:0 variant.
>>>>
>>>> Changes since RFC v2 at [3]:
>>>> - Collected tested-by and reviewed-by tags
>>>> - Changed if condition in "add HDMI div40 TMDS mode"
>>>> - Updated "Add YUV420 output support" with the same if condition
>>>>
>>>> Changes since RFC v1 at [2]:
>>>> - Fix all comments from Laurent :
>>>> - Add define for HDMI 1.4 max tmds clock and SCDC supported version
>>>> - Call dw_hdmi_set_high_tmds_clock_ratio() in dw_hdmi_phy_enable_powerdown()
>>>> to unbreak Allwinner H6
>>>> - Pass in_t(u8, bytes, SCDC_MIN_SOURCE_VERSION) as SCDC version
>>>> - Finally add comments for SCDC and Scrambling process
>>>>
>>>> [1] https://patchwork.freedesktop.org/patch/263616/
>>>> [2] https://patchwork.freedesktop.org/series/52950/#rev1
>>>> [3] https://patchwork.freedesktop.org/series/52950/#rev2
>>>>
>>>> Neil Armstrong (7):
>>>>   drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
>>>>   drm/meson: add HDMI div40 TMDS mode
>>>>   drm/meson: add support for HDMI2.0 2160p modes
>>>>   drm/bridge: dw-hdmi: add support for YUV420 output
>>>>   drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
>>>>   drm/meson: Add YUV420 output support
>>>>   drm/meson: Output in YUV444 if sink supports it
>>>>
>>>> Zheng Yang (1):
>>>>   drm/bridge: dw-hdmi: support dynamically get input/out color info
>>>>
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 182 +++++++++++++++++++---
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |   1 +
>>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 128 ++++++++++++---
>>>>  drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++++---
>>>>  drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
>>>>  drivers/gpu/drm/meson/meson_venc.c        |   8 +-
>>>>  drivers/gpu/drm/meson/meson_venc.h        |  11 ++
>>>>  drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
>>>>  include/drm/bridge/dw_hdmi.h              |   7 +
>>>>  9 files changed, 374 insertions(+), 66 deletions(-)
>>>>
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>
>

