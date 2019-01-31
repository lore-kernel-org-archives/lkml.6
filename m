Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF2FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E41A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fYGLPWlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfAaONK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:13:10 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33112 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfAaONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:13:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190131141307euoutp02b0d3cd5093f5d649d055fa895488b731~_9FmvA3373115131151euoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:13:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190131141307euoutp02b0d3cd5093f5d649d055fa895488b731~_9FmvA3373115131151euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548943987;
        bh=q9+/Tz0/lxy0J7zMDIcbHQZTQBS5MXZf8fkUP10TNH8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fYGLPWlbAA/n/eerrrBrQ+myIY3gI8K/1kR93BM/nY/kujVCNQk9gmRwF0hoqMmRN
         7vxjfjv3S809dOobTaId8VDACr5c5+UDgZknHr0E2JbxPHAKhocCDRoCNP2pwnfeG5
         Bquic/v+xrkUvsoyt93J24W80YWoYAJE4aOII+jU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190131141307eucas1p2eef21921ecc338b3498cf4fc9c858c10~_9FmG9wkN2194121941eucas1p2G;
        Thu, 31 Jan 2019 14:13:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.C6.04441.272035C5; Thu, 31
        Jan 2019 14:13:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190131141306eucas1p12ff493681222eb774466e949e8c69404~_9FlRVcqK1045910459eucas1p1U;
        Thu, 31 Jan 2019 14:13:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131141306eusmtrp2d4fce58e3b2641e32c962c9058c47e08~_9FlCu7AJ1533915339eusmtrp20;
        Thu, 31 Jan 2019 14:13:06 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-9f-5c5302728d30
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.14.04284.172035C5; Thu, 31
        Jan 2019 14:13:06 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131141305eusmtip143bb2d54ad52b002c283151ddf3e14d7~_9FknS5TU0872208722eusmtip1L;
        Thu, 31 Jan 2019 14:13:05 +0000 (GMT)
Subject: Re: [PATCH 0/8] drm/meson: Add support for HDMI2.0 4k60
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <0fa602d6-a57e-0248-fcfd-929e3d9ceab1@samsung.com>
Date:   Thu, 31 Jan 2019 15:13:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a3de23a8-3fa4-f8c5-5b2a-33109c09a863@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djP87pFTMExBguWm1tc+fqezeL/o9es
        FnMn1Vp0TlzCbrFgNrfF5V1z2CwevNzPaHGoL9ri7r0TLA6cHu9vtLJ7zFtT7TG7Yyarx/3u
        40wem5fUe/T/NfD4O2s/i8f2a/OYPT5vkgvgjOKySUnNySxLLdK3S+DK2NX2kLlgmkrFpwl7
        GRsYH8p0MXJySAiYSMx/8I65i5GLQ0hgBaNEz9JlTCAJIYEvjBJv5wpAJD4zSrTsO8wE09HZ
        /ZAJIrGcUaLzzBdWCOcto8Ss+dvYQaqEBRwkXpxdzAiSEBF4wyjxbeF2sHZmgTSJWzMOsYLY
        bAKaEn8332QDsXkF7CTaf69gBrFZBFQlJjR/YASxRQUiJA73vmOEqBGUODnzCQuIzQm04Per
        96wQM+Ultr+dwwxhi0vcejIf7DwJgUvsEk+erWSBuNtFYkXTf2YIW1ji1fEt7BC2jMT/nfOh
        fquXaJp5hRmiuYNR4sTi5WwQCWuJw8cvAm3jANqgKbF+lz6IKSHgKNF7oAbC5JO48VYQ4gQ+
        iUnbpjNDhHklOtqEIGYoStw/uxXqAHGJpRe+sk1gVJqF5LFZSJ6ZheSZWQhrFzCyrGIUTy0t
        zk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMWaf/Hf+0g/HrpaRDjAIcjEo8vBt+BcUIsSaWFVfm
        HmKU4GBWEuGVegAU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvE
        wSnVACTjgnkFfBs9TTQz2DeVTnbx3jzjL1fejaNPAqXTrt5SDLZl+vRicckVC51fjZc/uq3h
        1798NvM5v3bwXbbzkRMWpqoeOr5iw9//20qaDhxS+qd9eiOj7V0GUY+COV4fhFe+1+HW+sg6
        a/t97YUXq3bcX8fxPEv/r+vJR/fdGG09Piz6/jrwiBJLcUaioRZzUXEiAHfpktxVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7pFTMExBtsrLa58fc9m8f/Ra1aL
        uZNqLTonLmG3WDCb2+LyrjlsFg9e7me0ONQXbXH33gkWB06P9zda2T3mran2mN0xk9Xjfvdx
        Jo/NS+o9+v8aePydtZ/FY/u1ecwenzfJBXBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjq
        GRqbx1oZmSrp29mkpOZklqUW6dsl6GXsanvIXDBNpeLThL2MDYwPZboYOTkkBEwkOrsfMnUx
        cnEICSxllFg3s5kNIiEusXv+W2YIW1jiz7UuNoii14wS8w/OBysSFnCQeHF2MSNIQkTgDaPE
        74mX2UESzAJpEn+egnSDdBxjlDhxcysjSIJNQFPi7+abYN28AnYS7b9XgK1gEVCVmND8AaxG
        VCBC4uPTfUwQNYISJ2c+YQGxOYG2/X71nhVigbrEn3mXmCFseYntb+dA2eISt57MZ5rAKDQL
        SfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmCcbjv2c/MOxksbgw8x
        CnAwKvHwbvgVFCPEmlhWXJl7iFGCg1lJhFfqAVCINyWxsiq1KD++qDQntfgQoynQcxOZpUST
        84EpJK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA2OV33/bC0tP
        qj3btJz3pOpVoWX5tz5J50ervDy9xP7JgWVvKhpSMp75PbJwzlXadePrilXL2NJM+FivzFD5
        uPVn3OR/mpYTz2/+Ls383ds35NLT1l25ffMf7hCZefGCqezaFet3zW11f5p354pRblhu6vK2
        uMmcbLvm1JxOS2mT5bpc7Hvw3L9NSizFGYmGWsxFxYkAN6J0KukCAAA=
X-CMS-MailID: 20190131141306eucas1p12ff493681222eb774466e949e8c69404
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131132546epcas5p264ec54cb60053b409f0459f809825eef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131132546epcas5p264ec54cb60053b409f0459f809825eef
References: <20190115123315.11069-1-narmstrong@baylibre.com>
        <CGME20190131132546epcas5p264ec54cb60053b409f0459f809825eef@epcas5p2.samsung.com>
        <a3de23a8-3fa4-f8c5-5b2a-33109c09a863@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.2019 14:25, Neil Armstrong wrote:
> Hi Andrzej, Laurent,
>
> On 15/01/2019 13:33, Neil Armstrong wrote:
>> This patchset aims to add support for the following HDMI2.0 4k60 modes:
>> - 594Mhz TMDS frequency needing TMDS Scramling and 1/40 rate for RGB/YUV4:4:4
>> - 297MHz TMDS frequency with YUV4:2:0 encoding
>>
>> The first mode uses the SCDC helpers introduced by intel to :
>> - discover where the monitor support SCDC
>> - setup the SCDC parameters
>> This is implemented in the dw-hdmi bridge driver by handling scrambling
>> support during the bridge setup and by exporting an helper for the PHY
>> setup to setup the SCDC configuration for the 1/40 TMDS rate.
>> This code will only be active if the encoder support a TMDS rate > 340MHz.
>>
>> This patch could eventually break support on different SoC when connected
>> on a 4k60 monitor with SCDC :
>> - i.MX correctly discards pixel clocks > 216MHz
>> - R-CAR discards discards pixel clocks > 297MHz since [1]
>> - Rockchip discards invalid pixel clocks not in the rockchip_mpll_cfg table
>> - sun8i correctly discards pixel clocks > 297MHz on a83t
>> - sun8i discards discards pixel clocks > 594Mhz on h6, which is already broken
>>
>> First patch should fix support for Allwinner H6.
>>
>> The second mode is implemented by added the missing 4:2:0 bypass handling
>> in the dw-hdmi bridge driver and adding a "mtmdsclock" separating the
>> pixel clock from the tmds clock in the mode setup phase.
>> We also enable support for these modes in the connector only if the platform
>> glue code explicits the support.
> Do you think patches 1-4 could be applied ?


For me they are OK.

Should I take them via drm-misc?


>
> Then we could focus on how we manage the bus format between the encoder
> and the bridge ?
>
> Especially patch 5 linked to patch 7.
>
> Will one of you be at FOSDEM 2019 ? we could chat about this.


Nope.


Regards

Andrzej


>
> Following subjects on the table will be :
> - HDR metadata transmission aligned with the last patchset sent by intel-gfx
> - Colorspace connector property aligned with the last patchset sent by intel-gfx
> - HDCP 1.4 and 2.2 handling
>
> Neil
>
>> Only the meson DRM dw_hdmi glue allows ycbcr420 modes, so no breakage
>> is expected here.
>>
>> The remaining patches adds support for :
>> - 1/40 TMDS rate aka DIV40 in the dw-hdmi meson PHY setup
>> - 4:2:0 output and clock setup
>>
>> The dw-hdmi support re-uses the support done by Rockchip engineers on the
>> Linux 4.4 BSP kernel.
>>
>> These modes has been validated using a MuxLab HDMI Signal Analyser in
>> addition to different UHD TVs supporting full 4k60 or the 4:2:0 variant.
>>
>> Changes since RFC v2 at [3]:
>> - Collected tested-by and reviewed-by tags
>> - Changed if condition in "add HDMI div40 TMDS mode"
>> - Updated "Add YUV420 output support" with the same if condition
>>
>> Changes since RFC v1 at [2]:
>> - Fix all comments from Laurent :
>> - Add define for HDMI 1.4 max tmds clock and SCDC supported version
>> - Call dw_hdmi_set_high_tmds_clock_ratio() in dw_hdmi_phy_enable_powerdown()
>> to unbreak Allwinner H6
>> - Pass in_t(u8, bytes, SCDC_MIN_SOURCE_VERSION) as SCDC version
>> - Finally add comments for SCDC and Scrambling process
>>
>> [1] https://patchwork.freedesktop.org/patch/263616/
>> [2] https://patchwork.freedesktop.org/series/52950/#rev1
>> [3] https://patchwork.freedesktop.org/series/52950/#rev2
>>
>> Neil Armstrong (7):
>>   drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
>>   drm/meson: add HDMI div40 TMDS mode
>>   drm/meson: add support for HDMI2.0 2160p modes
>>   drm/bridge: dw-hdmi: add support for YUV420 output
>>   drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
>>   drm/meson: Add YUV420 output support
>>   drm/meson: Output in YUV444 if sink supports it
>>
>> Zheng Yang (1):
>>   drm/bridge: dw-hdmi: support dynamically get input/out color info
>>
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 182 +++++++++++++++++++---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |   1 +
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 128 ++++++++++++---
>>  drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++++---
>>  drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
>>  drivers/gpu/drm/meson/meson_venc.c        |   8 +-
>>  drivers/gpu/drm/meson/meson_venc.h        |  11 ++
>>  drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
>>  include/drm/bridge/dw_hdmi.h              |   7 +
>>  9 files changed, 374 insertions(+), 66 deletions(-)
>>
>
>

