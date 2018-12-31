Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5B9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC7421738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OnYdWD8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeLaKxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:53:47 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60675 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLaKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 05:53:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181231105344euoutp0148689aa8998256120b41365dc4c8490d~1ZXqYru5D2894728947euoutp01n
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181231105344euoutp0148689aa8998256120b41365dc4c8490d~1ZXqYru5D2894728947euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1546253624;
        bh=Zxj6SP95YpfZXWePv+WYDWjDmuZM6/A+YKdIB3ksJGc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OnYdWD8qpd3xrqIsJ6Fx6NEQxgurIXkY+ExNPXKYaNVfCPkY9fFGgJZroDSgqlEkb
         QiX0cSfFG5R6WgMCKa67ihT1ATWvFNpOQTD3MxBB5EIog42lLtx5DI30nl1OoGGExv
         /blUBwqVSHea6vL2QkEcN/3/6t0WUCWfEFhdYZu8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181231105343eucas1p21da338a4e1ecba79f665cf93fb933cd4~1ZXpUUwpe2091220912eucas1p2B;
        Mon, 31 Dec 2018 10:53:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.28.04294.635F92C5; Mon, 31
        Dec 2018 10:53:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181231105342eucas1p15e8939e3599a77db58dbf31780f8a5f4~1ZXolHaF_1905919059eucas1p1A;
        Mon, 31 Dec 2018 10:53:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181231105342eusmtrp2a4f47c790def9ad9897b40b85fd844cb~1ZXoV7MY11006010060eusmtrp2N;
        Mon, 31 Dec 2018 10:53:42 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-b7-5c29f536fd57
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.1F.04284.535F92C5; Mon, 31
        Dec 2018 10:53:42 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181231105341eusmtip13d47531cd3f6bc27b03a1e13e2762217~1ZXnwAIyz1842418424eusmtip1P;
        Mon, 31 Dec 2018 10:53:41 +0000 (GMT)
Subject: Re: [PATCH v2 08/14] drm: remove include of drmP.h from
 bridge/dw_hdmi.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <f478a3bc-2218-6561-e37e-ea654bc3e558@samsung.com>
Date:   Mon, 31 Dec 2018 11:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-9-sam@ravnborg.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b13u5Mmr9PyYUXloB8r0z7tRjIsCi9EUAQSKejS25R0xm6a
        5Y+WZkyXlgXVlpjV+k7Er9UWZtlwjkwyp9inBhJUmC11JVS2u6vkv/Oec573nAcemlCOUyo6
        x3CYMxp0uWppGOnonOpZlTCpSVvdbUlgKnu8EqbEPEox045qgrlmWsj4JsekTGPzW5L5MWBB
        THm1Xcb0uWqkzFV/K8kMf25HTEdVKnN7qhUx78+7UVI4OzZYJmNr7xezfVWVErYtUEeyl81W
        iv1xxkuxDwLDFFvr3c0OWTwStvHbQwnrcb2RsfYL/VJ2vGnJLsW+sMQsLjenkDPGazPCsvs+
        PyUPlS8panjVR5jQV6hAchrwemiffi2tQGG0Et9GEDjZRgmCEk8gcJ6Ri8I4gsYTldTsRL/p
        HCUKtxC03Awg8TGKYMTvkAmuSLwH7jQ5JIIQhS0EVLiHQiEEdgb/qiwjBZcUa+BPs5AupxVY
        C966nyGexMuhpPRxKG8B3gvmoXszngjwWkdCHjlOgE+ddiRgAi+F0tbLhIij4c3IlVAyYCsN
        f0pbSLH4NuhpEE2AI+GLp0Um4sUw7RQGBHwcSqw+Qhw2I+i6fksqCpvhmac32IgOJmigwRUv
        0lvgu7MfCTTgcBgcjRA7hMM5x0VCpBVgPqUU3TEw9KJ1pkE03Hg5KT2L1LY5m9nmbGObs43t
        f24dIu+iaK6Az9Nz/FoDdySO1+XxBQZ9XGZ+XhMKnuLzv56Jh8j1e38HwjRSz1dcmqdJU1K6
        Qv5oXgcCmlBHKVLSg5QiS3f0GGfMTzcW5HJ8B1pEk+poRfG84VQl1usOcwc57hBnnFUltFxl
        QvFad++68v31tSecjz4W9b5O9D31aUwGpeXDl6a1qm3uWPvOrQP1xdwVMiVzx0BX9XGtcXOy
        L8blti1PbI4t9vizj3RP8N2cSvlug/27pdCw6cPBCL/qyc/YLm3NnWXDGfqo/I1J88MPFG2P
        WPnrmf/0gH5qjTsw+Dc++T3Qbqua5LN1a1YQRl73D+FjO3KGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4XV2zr5oxBjvqLHrPnWSyaOp4y2rx
        f9tEZotFDWIWV76+Z7PYuPk2i8Wna92MFp0Tl7BbXN41h81i4cetLBYPXu5ntDjUF22x4udW
        Rou7k48wOvB5vL/Ryu4xb021x+W+XiaPvd8WsHjM7pjJ6vGp/ySrx/ZvD1g95p0M9LjffZzJ
        Y+O7HUwex3fdYvdYMu0qm8fnTXIBvFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GZdfHmQp6JSrWH/pMnMD42uJLkZODgkBE4mrDZNYuxi5OIQE
        ljJKXHkymxEiIS6xe/5bZghbWOLPtS42EFtI4DWjxK/5/iC2sECwxMpN25hAmkUEupkl9rcu
        AHOYBXYzSlx4OZUJYmwno8Tl/X1g7WwCmhJ/N98Es3kF7CROLvjOAmKzCKhKNDXvYwWxRQUi
        JM6+XMcIUSMocXLmE7AaTgEziWfHloDFmQXUJf7Mu8QMYctLNG+dDWWLS9x6Mp9pAqPQLCTt
        s5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBSWDbsZ+bdzBe2hh8iFGA
        g1GJh3cGg2aMEGtiWXFl7iFGCQ5mJRHesHigEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucD
        E1ReSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbG8vcLyjZrVWz1
        PNa8/2dO6I9XV1nvyB09ITFFYuNqKakjf851RL/0+T3x+SdF0c+ieSY+JZETfu+6b8CtKj5D
        yN1qFY+PpPsS6Q1PMpTZGvcb/frLeavg1NqLh5X+37mjH2Gk73/72bmux82NN/x+Tz3lOk8n
        b+EKqbvi9oUFnAvOv502363aT4mlOCPRUIu5qDgRACnYWs0YAwAA
X-CMS-MailID: 20181231105342eucas1p15e8939e3599a77db58dbf31780f8a5f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181230175004epcas1p4f675fc8ea5d1073e3461d15c9dd57862
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181230175004epcas1p4f675fc8ea5d1073e3461d15c9dd57862
References: <CGME20181230175004epcas1p4f675fc8ea5d1073e3461d15c9dd57862@epcas1p4.samsung.com>
        <20181230174838.32330-9-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.2018 18:48, Sam Ravnborg wrote:
> drmP.h is an relic from the days when there was a single header file.
> To enable the removal of drmP.h from all users drop include
> of drmP.h from bridge/dw_hdmi.h.
>
> A few files relied on the file included in drmP.h - add explicit
> include statements or forward declarations to these files.
> Build tested with arm and x86.
>
> v2:
> - prefer forward declarations when possible (Laurent Pinchart)
> - sort include files (Laurent Pinchart)
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>


One general comment below.


> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 4 ++++
>  drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c              | 1 +
>  include/drm/bridge/dw_hdmi.h                        | 6 ++++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index 2228689d9a5e..5cbb71a866d5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -5,6 +5,10 @@
>   * Copyright (c) 2017 Renesas Solutions Corp.
>   * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>   */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +
>  #include <drm/bridge/dw_hdmi.h>
>  
>  #include <sound/hdmi-codec.h>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> index 75490a3e0a2a..790d499daa10 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> @@ -7,6 +7,7 @@
>   * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
>   */
>  
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 9c56412bb2cf..9f93895dde88 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -10,9 +10,11 @@
>  #ifndef __DW_HDMI__
>  #define __DW_HDMI__
>  
> -#include <drm/drmP.h>
> -
> +struct drm_connector;
> +struct drm_display_mode;
> +struct drm_encoder;
>  struct dw_hdmi;
> +struct platform_device;
>  
>  /**
>   * DOC: Supported input formats and encodings


I wonder if it wouldn't be better to create common file for forward
declarations. For example: include/drm/drm_forward.h which will contain
only forward declarations, this way we could avoid adding these
declarations in every file again and again. Since I have not seen such
practice in kernel I wonder if such approach has no serious drawbacks,
but for now I do not see any, except it looks like another incarnation
of drmP.h :)

Quick grep shows potential candidates for forward declarations:

$ git grep -Ph '^struct drm_\S+;$' include/ drivers/gpu/ | sort | uniq
-c | sort -n | tail
      7 struct drm_encoder;
      7 struct drm_gem_object;
      8 struct drm_printer;
      9 struct drm_connector;
      9 struct drm_framebuffer;
     13 struct drm_plane;
     14 struct drm_crtc;
     22 struct drm_i915_private;
     23 struct drm_file;

     47 struct drm_device;


Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej





