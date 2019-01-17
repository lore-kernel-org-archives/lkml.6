Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C6DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A3B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XcGOfzkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfAQJcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:32:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:29391 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfAQJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:32:14 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190117093211epoutp03888630407b568ee64aba3379d13de053~6mOT4IMs01859418594epoutp03T
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:32:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190117093211epoutp03888630407b568ee64aba3379d13de053~6mOT4IMs01859418594epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547717531;
        bh=fA3LmYG+MDE8TCnlq/z+qYQ9ll7Qp0SFsr6Ft8sFcFg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XcGOfzkdh5dE/Jx5Kh/CtkLM2lfLzwy/LoUwMGusoEBZUOzc8jKt+QdWlvsw6zsR0
         ITez2HtOawnpVIKarORvp8s6r/TTS4O06oF1k4gFg+cVj55GIkSw5MKDFeIBIUnl3Y
         K32YQlWHh4u7hU2oKPmRvyMbaEneBDLKQ8UosLiY=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190117093208epcas1p11df0bfa3593521b54920ef4432df8eb8~6mORibQm30091700917epcas1p1R;
        Thu, 17 Jan 2019 09:32:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.8D.04057.89B404C5; Thu, 17 Jan 2019 18:32:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190117093207epcas1p299ca1fc3771a377401abdc15c743360a~6mOQYAJJk3230632306epcas1p2_;
        Thu, 17 Jan 2019 09:32:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190117093207epsmtrp2ff742e914b4f79747c2dc1c9eefeed8a~6mOQTf-fA0180801808epsmtrp2X;
        Thu, 17 Jan 2019 09:32:07 +0000 (GMT)
X-AuditID: b6c32a36-d31ff70000000fd9-28-5c404b98e003
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.BD.03694.79B404C5; Thu, 17 Jan 2019 18:32:07 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190117093207epsmtip1f45b8d9f4dec70ea3daf7a4b2ea35baa~6mOQGppQu1010710107epsmtip1i;
        Thu, 17 Jan 2019 09:32:07 +0000 (GMT)
Subject: Re: [PATCH 1/6] include/drm: color_mgmt: Add enum labels
To:     Christoph Manszewski <c.manszewski@samsung.com>,
        dri-devel@lists.freedesktop.org
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <f51289f2-e94f-40f4-2a61-054d87914030@samsung.com>
Date:   Thu, 17 Jan 2019 18:32:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmnu4Mb4cYg8/N8ha31p1jteg9d5LJ
        YuOM9awWx3cvZbS48vU9m8WLexdZLPofv2a2OH9+A7vF2aY37BabHl9jtbi8aw6bxYzz+5gs
        1h65y26x8ONWFosHL/czWtydfITRYsbkl2wOgh7z1lR7bFrVyeax/dsDVo95JwM97ncfZ/LY
        vKTe4/iuW+wefVtWMXp83iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGu
        pJCXmJtqq+TiE6DrlpkD9ImSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84
        Mbe4NC9dLzk/18rQwMDIFKgwITuj+fRi5oITnBWb7/xka2D8y97FyMkhIWAisf3/RZYuRi4O
        IYEdjBKzd5xmh3A+MUqsPrWTCcL5xijxdfZCRpiWpz+OQbXsZZQ4feARK0hCSOA9UP82fxBb
        WMBRoufGX6AGDg4RgTCJHW8CQeqZBZ6xSHx5NANsEJuAqsTEFffZQGxeATuJM8cvgdksQPG3
        P9vA7hMViJDouL8aqkZQ4uTMJywgNqeAh8TxzeeYQGxmAXGJW0/mQ9nyEs1bZzODLJMQOMUu
        sXhiLxPE1S4Sb17OYIWwhSVeHd8CDQApic/v9rJB2OUSz949YwE5WkKgRuLb3AoI01ji4ooU
        EJNZQFNi/S59iE18Eu++9rBCVPBKdLQJQcxQkjh28QY0pCQkLiyZCDXbQ+Lk/n/QULvJKLH3
        eDPrBEaFWUgem4XkmVlInpmFsHkBI8sqRrHUguLc9NRiwwIj5LjexAhO41pmOxgXnfM5xCjA
        wajEw2tgYh8jxJpYVlyZe4hRgoNZSYS30NkhRog3JbGyKrUoP76oNCe1+BCjKTDcJzJLiSbn
        A3NMXkm8oamRsbGxhYmhmamhoZI47xOpudFCAumJJanZqakFqUUwfUwcnFINjEvXsm+Y77I7
        02f5IQnOKNOn3S9ePN7d2aw55Uknz8/3DIs8n+c6fs4L+3dqjgN7kejb1ik/uyd4hcxu2vj5
        YI38JnuJD8WK0q0BOzecjprwPv4062aBklrbpwXxLxaqVIbxyPrah15U19uc78/OXraEZUJB
        0hsm/R/TGR94mSQce2jjv0Q/WYmlOCPRUIu5qDgRAHy5ld/5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSnO50b4cYgyvX+S1urTvHatF77iST
        xcYZ61ktju9eymhx5et7NosX9y6yWPQ/fs1scf78BnaLs01v2C02Pb7GanF51xw2ixnn9zFZ
        rD1yl91i4cetLBYPXu5ntLg7+QijxYzJL9kcBD3mran22LSqk81j+7cHrB7zTgZ63O8+zuSx
        eUm9x/Fdt9g9+rasYvT4vEkugDOKyyYlNSezLLVI3y6BK6P59GLmghOcFZvv/GRrYPzL3sXI
        ySEhYCLx9Mcxli5GLg4hgd2MEmv7vjF1MXIAJSQktmzlgDCFJQ4fLgYpFxJ4yyhxY14BiC0s
        4CjRc+MvI0iJiECYxLStliBTmAVesEjcP3WUCWLkTUaJfXeWMIM0sAmoSkxccZ8NxOYVsJM4
        c/wSmM0CFH/7sw3sHlGBCImzL9cxQtQISpyc+YQFxOYU8JA4vvkcE4jNLKAu8WfeJWYIW1zi
        1pP5UHF5ieats5knMArNQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqX
        rpecn7uJERy5Wlo7GE+ciD/EKMDBqMTD22FmHyPEmlhWXJl7iFGCg1lJhLfQ2SFGiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA+NMj1sZ1/rs9vO/P136
        3Gz5UXPecHPD39JNS/w/pss3a008vmP6EcFzvoVXbLryXJvX9b6u+yE1rd87xsHK45/AjsI5
        9UWLVxySPK2dLtAe/ya/3CtxidGjTZyF/3NzzWpu3lLcqOi85iOvrt7WKZ7bNFfeXXVn11c7
        FZa1fD4ivrvn8Fw8WqbEUpyRaKjFXFScCABSUZax2AIAAA==
X-CMS-MailID: 20190117093207epcas1p299ca1fc3771a377401abdc15c743360a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6@eucas1p2.samsung.com>
        <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

18. 12. 14. 오후 9:10에 Christoph Manszewski 이(가) 쓴 글:
> Range setting makes sense for YCbCr and RGB buffers. Current
> drm_color_range enum labels suggest use with YCbCr buffers.
> Create enum labels without colorspace specification.
> 
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> ---
>  include/drm/drm_color_mgmt.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
> index 90ef9996d9a4..52f6d5221a0d 100644
> --- a/include/drm/drm_color_mgmt.h
> +++ b/include/drm/drm_color_mgmt.h
> @@ -62,6 +62,8 @@ enum drm_color_range {
>  	DRM_COLOR_YCBCR_LIMITED_RANGE,
>  	DRM_COLOR_YCBCR_FULL_RANGE,
>  	DRM_COLOR_RANGE_MAX,
> +	DRM_COLOR_LIMITED_RANGE = DRM_COLOR_YCBCR_LIMITED_RANGE,
> +	DRM_COLOR_FULL_RANGE = DRM_COLOR_YCBCR_FULL_RANGE,

I don't see why above two types are needed. Is there any case that the range checking behavior should be different according to the color space?
And even if there is that case, I think you have to put DRM_COLOR_RANG_MAX under DRM_COLOR_FULL_RANGE.

Thanks,
Inki Dae

>  };
>  
>  int drm_plane_create_color_properties(struct drm_plane *plane,
> 
