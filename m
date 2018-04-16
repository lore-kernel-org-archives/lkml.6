Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeDPJxy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:53:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49093 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeDPJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:53:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416095348euoutp0109b78db1acfed98d462dd875f086fc8e~l4eZTIhZt2540825408euoutp01O
X-AuditID: cbfec7f4-713ff700000043e4-84-5ad472aac425
Subject: Re: [PATCH v6 30/30] drm/rockchip: psr: Remove flush by CRTC
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d88a9b84-f39f-7d12-8397-0eb1cca56d92@samsung.com>
Date: Mon, 16 Apr 2018 11:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-31-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zUdRjH+3x/wzj6elj3ZE3nEU3b0mrWnk1zWLq+rs3VP9jY+nHoN3Ry
        p7sTzZqG5/QQ+WH8MDgKayLhRYvdnXKczTPQDoQvCJiAeRwhKUJ0JefVhWLcfW3x3+t5P8/n
        eZ73s49Aa29yC4Stpp2y2WTI0XOJzJkfo13POcxXMp9XbKuwqKudQmv+JItK3Q8cXrkb4rDh
        5xaCD0YmWPyidC/+3XiJRpt7hMLS4FEG/xpQOKwPV/E4NtTDoKurkMWSGxM0dnc38njZ10Gh
        Yv2Nx8Of1vLovHGVxcE7ERb7vJ9zeGf4AY2V3eco/PZCgEdP+XkKz7laGWyLHKMw0KgQrCy7
        zeHUwRkOo94aBm0H6ig81P84duWV8empUkNNA5GmHOOsVJ3Xw0h9xUWU5AnUEqnZHuCl6vwq
        VnI6DnNSU2SYlYJH/JTkqv1Eum/3MVKx20Gkpqs1tDTlXPjmo5mJqzbLOVt3yeblq99P3GKL
        fkV29Os+DHT203lkKKWAJAggroDeiutcAUkUtGI9AU+xQqlBmMA/Y78+DKYI7L/YzRcQIf7k
        5qkkVf+awIzbxqrBJIGi7zv5WN8UcR0U+vxMLDFfvE2g8eJEvBUtnmBh5KdiNlbFiUvhvmuQ
        i7FGXA1H3OE4M2IaWK/30jF+THwbrLeivFozD9qrRpkYJ4ivwi9/NMfraXERHDhdTausg2uj
        x+PDQGxNgPNFJZRqdS2MlzsYlVNg3O/mVX4KOsoKH+ofw+CYlVEf5xMITts4NbESWv09bOwA
        9OzW33mXq7d4BcIDySomw8DkPHWFZCg98xmtyhrIP6RVeyyGoHKaVlkHJy/f5Y6SVPscY/Y5
        ZuxzzNj/H/slYRxEJ+dajNmy5UWTvHuZxWC05Jqyl23abnSS2d/fMeMPe4j3XlYLEQWiT9J4
        lL5MLWvYZdljbCEg0Pr5mjrDrKTZbNjzkWze/p45N0e2tJAnBUav07y7ZF+mVsw27JS3yfIO
        2fxflhISFuQRqfDpveuip1Lrk9qeqIz0R7L9Z1coSxa6/rT4Xt4ANRUnN9Wneh+5dzBr0DR2
        IhgIDY28s/RCZ7rx2jPHM0LabSVpWdOv6V7/PaN9Y276W+vtghLap9//0m6fO2PN+ktjK9d6
        0pwV36x5wzgcgtHexc3HPNaN5Ys+sJ3tCDTdirZNc3rGssXwwrO02WL4F0bwftP5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xTZxTG897/EOruCsobEp2pcUaj1YLYw1abhW3J9cOSJduHgVv0Rq6F
        jbakt5ixhKyDKFjFYXULtKy6DJuJsBFaBTQpWjewYOkYBAQsIrpFrGwLMLCJ6EpxCd+e85zn
        d05OcjhSGaMzuCKTVbKYxGIVk0z1Pe+J7LhoGcrfNT6vg5r+IAEV1TM0hDw3GBj6928GmscD
        CF5MRWn4zlEOT1t7SajyTRHguFdLweKdEAM/ztez8GhigAJv/0kavn4QJSEcbmXht64+AkIV
        T1g4frqRhbYHwzSMzi7QMHi1gYHZyRck1IX9BLT8EmGh4+x1AvzemxTcWviWgEhrCEHdmWkG
        5o4+ZyB21U1BVaWHgGMj66DfdoZ9a5PQ7G5GwlzTY1pw2QYoYfBUDSF0RBqR0OmMsIKrup4W
        2pqOM0L7wiQt3DvRQwjexi+FJWcXJZzyNSGhfdhNCnNtG95/JV+ts5hLrdLGQrNs3avar4FM
        tSYH1Jm7c9SaLO0nb2Rmq3bqdQVScdERybJTf1BdWBX7HpWMpH8euT1C2tBEqh1xHOZ34z8v
        pthRMqfkLyDs+SnK2lFS3E/H187NkCs6FT8btjMroSjCR7unqOVGKv8uPtnVQy030vhphIM1
        j9nlguR/oPHY+DfMckrJ30b4yXRiLMNvxUve0YSv4PX4hG8+oSl+M664+3ti3Vr+IzwRnn2Z
        eRUH6x8mtiXxufj+P50Jn+S34GfulTzJv4YrL7te6nQ89vAcUYuUzlW4cxXiXIU4VyHnEdWE
        0qRS2WgwyplqWTTKpSaD+pDZ2Ibib3elO+brQPa/PgggnkOqFEVHaDBfSYtH5DJjAGGOVKUp
        PGLcUhSIZV9IFvMBS2mxJAdQdvy402TG2kPm+BObrAc02Rot5Gi0WdqsPaBKV4R3leUreYNo
        lT6TpBLJ8j9HcEkZNvTzpR0Z2Y7KwL79LY82bdErFd6ugVyduq737fE998tNe7l9i8HJjXlV
        f9Renolu7h4a3WBIYU0L/nWfGt0NSzNFeR+7ka6kvPmrAr+jJeKJ5Y0lL7oa+lpvbb/Z+96v
        6w1p7W+K+r7Drrzp3LPV/Wv8jmjwdZ9Nu+2dNR8uPu28fkFFyYWiZhtpkcX/APh4f0yMAwAA
X-CMS-MailID: 20180416095346eucas1p1b6b2c0a4fdc7f2a9d587bb39202e13b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416095346eucas1p1b6b2c0a4fdc7f2a9d587bb39202e13b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095121epcas3p36dd90bcde69f6502ed09d9eb96545744
X-RootMTR: 20180405095121epcas3p36dd90bcde69f6502ed09d9eb96545744
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095121epcas3p36dd90bcde69f6502ed09d9eb96545744@epcas3p3.samsung.com>
        <20180405095000.9756-31-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 11:50, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> It is not used anymore after last changes and it was not even correct to
> begin with as it assumed a 1:1 relation between a CRTC and encoder,
> while in fact a CRTC can be attached to multiple encoders.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 35 -----------------------------
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.h |  1 -
>  2 files changed, 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index 1bf5cba9a64d..b1988ac758d5 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -40,23 +40,6 @@ struct psr_drv {
>  	int (*set)(struct drm_encoder *encoder, bool enable);
>  };
>  
> -static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
> -{
> -	struct rockchip_drm_private *drm_drv = crtc->dev->dev_private;
> -	struct psr_drv *psr;
> -
> -	mutex_lock(&drm_drv->psr_list_lock);
> -	list_for_each_entry(psr, &drm_drv->psr_list, list) {
> -		if (psr->encoder->crtc == crtc)
> -			goto out;
> -	}
> -	psr = ERR_PTR(-ENODEV);
> -
> -out:
> -	mutex_unlock(&drm_drv->psr_list_lock);
> -	return psr;
> -}
> -
>  static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
>  {
>  	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
> @@ -173,24 +156,6 @@ static void rockchip_drm_do_flush(struct psr_drv *psr)
>  	mutex_unlock(&psr->lock);
>  }
>  
> -/**
> - * rockchip_drm_psr_flush - flush a single pipe
> - * @crtc: CRTC of the pipe to flush
> - *
> - * Returns:
> - * 0 on success, -errno on fail
> - */
> -int rockchip_drm_psr_flush(struct drm_crtc *crtc)
> -{
> -	struct psr_drv *psr = find_psr_by_crtc(crtc);
> -	if (IS_ERR(psr))
> -		return PTR_ERR(psr);
> -
> -	rockchip_drm_do_flush(psr);
> -	return 0;
> -}
> -EXPORT_SYMBOL(rockchip_drm_psr_flush);
> -
>  /**
>   * rockchip_drm_psr_flush_all - force to flush all registered PSR encoders
>   * @dev: drm device
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> index 40e026c14168..860c62494496 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> @@ -16,7 +16,6 @@
>  #define __ROCKCHIP_DRM_PSR___
>  
>  void rockchip_drm_psr_flush_all(struct drm_device *dev);
> -int rockchip_drm_psr_flush(struct drm_crtc *crtc);
>  
>  int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
>  int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
