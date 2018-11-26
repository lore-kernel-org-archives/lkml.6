Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00833C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49B82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cSkLWEsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49B82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeKZTo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:44:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKZToZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:44:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so17944269wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iLXJoEalet2xGo3y6N/eFwY5HyGKA+uby+22G2yGEtY=;
        b=cSkLWEsNP/wpOIJfbmlEKv0YId22nDgjdOxHRgK+6lWfaeFm1IPnXPpzCkbt9ZYm+v
         P8cK4ErLHpoMs8MxIjFKW038+8WihXPoiRD43lbT6eVKTge57hAR3K5PQ+1LhcH3N28W
         UlI/j27xqyJ0f/j01b6GR09hc2P8IKMbR1ThpoH5ChxhOXL6Ld0hczqM5kL0l5EmXmgD
         28SFVaSCzHi2dn/uonusralp1Lq+duaNM9TZsn+H6VmZiFeUXF0mN7t57FqP9qJrOTPI
         0s19iLKfjsr9Xu9Ap8thSJd/AUlwI4JKIwgsCeSKzmbh+2U07ydRJ5R9M/LNQ8+VuXFA
         QeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iLXJoEalet2xGo3y6N/eFwY5HyGKA+uby+22G2yGEtY=;
        b=Ny55cplqAA24bOs3U3L0juyFAcFXwIOiUqWjMxB2qQSZ8NXEBwo7jlq5pAOZFFsJ/N
         o4ndBTA4RFEMs9TWx4zt34207F2PMU8hIrYi42Vta937y+HIigO6HL6O+xmA3+w9EWOj
         KG6qEJdV9Q4T1ZpOv5cdUfLrs5xGI0iL4QBCdLO+lTVb0pqjdjw+8AB9oPnWO/k1H0TL
         WziXJYxSCGZrANO3XNgKEji4JPA5srP9fPx8GVv/MF3ubEcadRA2HZeveodNwvWvGdEE
         TO1rcdYvnd/QD1dQwbfbQnYG8Y9eEnQ2YYt4ezogb/03dpmjqqXr8ApaApAymMjpnaeS
         03ZQ==
X-Gm-Message-State: AA+aEWbuHX9ShWrEwXhTKI01FemFK8bFwrlo7A1cJmOUQ/HleTDK396E
        c25fxqlpWX7w6hhxhRn6Bd6Zmueb09Md+Q==
X-Google-Smtp-Source: AFSGD/WNBY/fDlDaGaxkq3dJS3RQkAhEn8olU4QkCAXvdH0duyLMHrFE57CM7vFjcLqmy32V95Oj5g==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr22543602wrq.172.1543222258266;
        Mon, 26 Nov 2018 00:50:58 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x186sm61016wmg.41.2018.11.26.00.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:50:57 -0800 (PST)
Subject: Re: [PATCH] drm/meson: Fix OOB memory accesses in
 meson_viu_set_osd_lut()
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20181125012117.31915-1-lyude@redhat.com>
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
Message-ID: <59b50c1c-bef2-630f-a9e1-1c7348375df2@baylibre.com>
Date:   Mon, 26 Nov 2018 09:50:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181125012117.31915-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2018 02:21, Lyude Paul wrote:
> Currently on driver bringup with KASAN enabled, meson triggers an OOB
> memory access as shown below:
> 
> [  117.904528] ==================================================================
> [  117.904560] BUG: KASAN: global-out-of-bounds in meson_viu_set_osd_lut+0x7a0/0x890
> [  117.904588] Read of size 4 at addr ffff20000a63ce24 by task systemd-udevd/498
> [  117.904601]
> [  118.083372] CPU: 4 PID: 498 Comm: systemd-udevd Not tainted 4.20.0-rc3Lyude-Test+ #20
> [  118.091143] Hardware name: amlogic khadas-vim2/khadas-vim2, BIOS 2018.07-rc2-armbian 09/11/2018
> [  118.099768] Call trace:
> [  118.102181]  dump_backtrace+0x0/0x3e8
> [  118.105796]  show_stack+0x14/0x20
> [  118.109083]  dump_stack+0x130/0x1c4
> [  118.112539]  print_address_description+0x60/0x25c
> [  118.117214]  kasan_report+0x1b4/0x368
> [  118.120851]  __asan_report_load4_noabort+0x18/0x20
> [  118.125566]  meson_viu_set_osd_lut+0x7a0/0x890
> [  118.129953]  meson_viu_init+0x10c/0x290
> [  118.133741]  meson_drv_bind_master+0x474/0x748
> [  118.138141]  meson_drv_bind+0x10/0x18
> [  118.141760]  try_to_bring_up_master+0x3d8/0x768
> [  118.146249]  component_add+0x214/0x570
> [  118.149978]  meson_dw_hdmi_probe+0x18/0x20 [meson_dw_hdmi]
> [  118.155404]  platform_drv_probe+0x98/0x138
> [  118.159455]  really_probe+0x2a0/0xa70
> [  118.163070]  driver_probe_device+0x1b4/0x2d8
> [  118.167299]  __driver_attach+0x200/0x280
> [  118.171189]  bus_for_each_dev+0x10c/0x1a8
> [  118.175144]  driver_attach+0x38/0x50
> [  118.178681]  bus_add_driver+0x330/0x608
> [  118.182471]  driver_register+0x140/0x388
> [  118.186361]  __platform_driver_register+0xc8/0x108
> [  118.191117]  meson_dw_hdmi_platform_driver_init+0x1c/0x1000 [meson_dw_hdmi]
> [  118.198022]  do_one_initcall+0x12c/0x3bc
> [  118.201883]  do_init_module+0x1fc/0x638
> [  118.205673]  load_module+0x4b4c/0x6808
> [  118.209387]  __se_sys_init_module+0x2e8/0x3c0
> [  118.213699]  __arm64_sys_init_module+0x68/0x98
> [  118.218100]  el0_svc_common+0x104/0x210
> [  118.221893]  el0_svc_handler+0x48/0xb8
> [  118.225594]  el0_svc+0x8/0xc
> [  118.228429]
> [  118.229887] The buggy address belongs to the variable:
> [  118.235007]  eotf_33_linear_mapping+0x84/0xc0
> [  118.239301]
> [  118.240752] Memory state around the buggy address:
> [  118.245522]  ffff20000a63cd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  118.252695]  ffff20000a63cd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  118.259850] >ffff20000a63ce00: 00 00 00 00 04 fa fa fa fa fa fa fa 00 00 00 00
> [  118.267000]                                ^
> [  118.271222]  ffff20000a63ce80: 00 fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
> [  118.278393]  ffff20000a63cf00: 00 00 00 00 00 00 00 00 00 00 00 00 04 fa fa fa
> [  118.285542] ==================================================================
> [  118.292699] Disabling lock debugging due to kernel taint
> 
> It seems that when looping through the OSD EOTF LUT maps, we use the
> same max iterator for OETF: 20. This is wrong though, since 20*2 is 40,
> which means that we'll stop out of bounds on the EOTF maps.
> 
> But, this whole thing is already confusing enough to read through as-is,
> so let's just replace all of the hardcoded sizes with
> OSD_(OETF/EOTF)_LUT_SIZE / 2.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> # v4.10+
> ---
>  drivers/gpu/drm/meson/meson_viu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
> index 6bcfa527c180..26a0857878bf 100644
> --- a/drivers/gpu/drm/meson/meson_viu.c
> +++ b/drivers/gpu/drm/meson/meson_viu.c
> @@ -184,18 +184,18 @@ void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
>  	if (lut_sel == VIU_LUT_OSD_OETF) {
>  		writel(0, priv->io_base + _REG(addr_port));
>  
> -		for (i = 0; i < 20; i++)
> +		for (i = 0; i < (OSD_OETF_LUT_SIZE / 2); i++)
>  			writel(r_map[i * 2] | (r_map[i * 2 + 1] << 16),
>  				priv->io_base + _REG(data_port));
>  
>  		writel(r_map[OSD_OETF_LUT_SIZE - 1] | (g_map[0] << 16),
>  			priv->io_base + _REG(data_port));
>  
> -		for (i = 0; i < 20; i++)
> +		for (i = 0; i < (OSD_OETF_LUT_SIZE / 2); i++)
>  			writel(g_map[i * 2 + 1] | (g_map[i * 2 + 2] << 16),
>  				priv->io_base + _REG(data_port));
>  
> -		for (i = 0; i < 20; i++)
> +		for (i = 0; i < (OSD_OETF_LUT_SIZE / 2); i++)
>  			writel(b_map[i * 2] | (b_map[i * 2 + 1] << 16),
>  				priv->io_base + _REG(data_port));
>  
> @@ -211,18 +211,18 @@ void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
>  	} else if (lut_sel == VIU_LUT_OSD_EOTF) {
>  		writel(0, priv->io_base + _REG(addr_port));
>  
> -		for (i = 0; i < 20; i++)
> +		for (i = 0; i < (OSD_EOTF_LUT_SIZE / 2); i++)
>  			writel(r_map[i * 2] | (r_map[i * 2 + 1] << 16),
>  				priv->io_base + _REG(data_port));
>  
>  		writel(r_map[OSD_EOTF_LUT_SIZE - 1] | (g_map[0] << 16),
>  			priv->io_base + _REG(data_port));
>  
> -		for (i = 0; i < 20; i++)
> +		for (i = 0; i < (OSD_EOTF_LUT_SIZE / 2); i++)
>  			writel(g_map[i * 2 + 1] | (g_map[i * 2 + 2] << 16),
>  				priv->io_base + _REG(data_port));
>  
> -		for (i = 0; i < 20; i++)
> +		for (i = 0; i < (OSD_EOTF_LUT_SIZE / 2); i++)
>  			writel(b_map[i * 2] | (b_map[i * 2 + 1] << 16),
>  				priv->io_base + _REG(data_port));
>  
> 

Good catch !
Acked-by: Neil Armstrong <narmstrong@baylibre.com>


Applying to drm-misc-fixes

Thanks,
Neil

