Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A15C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA4820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1Twb2hvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA4820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeKZTnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:43:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53457 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeKZTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:43:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so14024326wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F9hAJfkU2QDubGuNpKphTZlr+T91m8i+qBN4yvSzVaY=;
        b=1Twb2hvZWnOffaXd+l72K2ieY7IhaReDxLIO9m9YO3VB5qU5yvmgKM0u7bau1RC5zT
         PgZTu951ydy7QUAHVpctRl5pF9nbwwBijQVOM8xil653sJ6qSHbGWkeiBYyePljpXn4R
         4f2bfL5cwhtgleKT4zww1W2Qo+3OxBsOfn+6vnoHByX+9aay4MiBnYRMQ9H4JcXCPCjj
         ec+O1rbIL4Hsn3RJ2TdQIdQw4QwM51uTYjPOjQih7tQeTIIaXJBIySuh7sO9+qcg6M6k
         neuRoS3EH2NmsNs3Ed1+dic95JtT67Q95eRzBveL109Tg5A1znSw06SieP8MuMQGrMde
         5SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F9hAJfkU2QDubGuNpKphTZlr+T91m8i+qBN4yvSzVaY=;
        b=Letd1IMc5J8Eo/g3oz1am+bqP9Rd/8XvcqffDVMj8IDdHeF5qdEtaSjSDdVPylQLlk
         4nxM6OC6zAI+sH7FU7HjAsJomkQmQuaaE20jmYayZE6VILPJ5y0PXzwrVdR2ziEWb04Q
         cbIVe+YaVFHMR+8oOMbsD/9JDmBNI74HiZ2BhSqxJ6poZc9OR0gTY1kmgJK91eiyWhmk
         e/coBl87p+N1oReh/RaQLG/8Jli9+Lm2aiXy8urPEtx3DFm/11nDOibt9VfNZ+tRal8b
         Q/LlLuZY8TCjO9vYbGhHh/XoTlhQ05ELSwYG4ZA/Xlf/f1GNsYvaTCpNh2I5rpdKsyvq
         HWqw==
X-Gm-Message-State: AA+aEWa0xFfUpgqZEoBTWHJo6GgbOEcPLnO8rrTiyicsNpUGJuaQ/ipm
        Hw/QIUtfiKIHtX/CQn3moNNAXUnEyk+NtA==
X-Google-Smtp-Source: AFSGD/UEhENlXrdRk7dl5pLPcqAjjK2DouPUDTHhvCe98VM+G5W9Wtytt20NNseHecdkBBVRkxxvlw==
X-Received: by 2002:a1c:70e:: with SMTP id 14mr4300490wmh.139.1543222184445;
        Mon, 26 Nov 2018 00:49:44 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 68sm140828wmt.10.2018.11.26.00.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:49:43 -0800 (PST)
Subject: Re: [PATCH] drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20181124191238.28276-1-lyude@redhat.com>
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
Message-ID: <8ffac756-107b-7638-fb2f-6d1a3bd70cbe@baylibre.com>
Date:   Mon, 26 Nov 2018 09:49:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181124191238.28276-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2018 20:12, Lyude Paul wrote:
> Seeing as we use this registermap in the context of our IRQ handlers, we
> need to be using spinlocks for reading/writing registers so that we can
> still read them from IRQ handlers without having to grab any mutexes and
> accidentally sleep. We don't currently do this, as pointed out by
> lockdep:
> 
> [   18.403770] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
> [   18.406744] in_atomic(): 1, irqs_disabled(): 128, pid: 68, name: kworker/u17:0
> [   18.413864] INFO: lockdep is turned off.
> [   18.417675] irq event stamp: 12
> [   18.420778] hardirqs last  enabled at (11): [<ffff000008a4f57c>] _raw_spin_unlock_irq+0x2c/0x60
> [   18.429510] hardirqs last disabled at (12): [<ffff000008a48914>] __schedule+0xc4/0xa60
> [   18.437345] softirqs last  enabled at (0): [<ffff0000080b55e0>] copy_process.isra.4.part.5+0x4d8/0x1c50
> [   18.446684] softirqs last disabled at (0): [<0000000000000000>]           (null)
> [   18.453979] CPU: 0 PID: 68 Comm: kworker/u17:0 Tainted: G        W  O      4.20.0-rc3Lyude-Test+ #9
> [   18.469839] Hardware name: amlogic khadas-vim2/khadas-vim2, BIOS 2018.07-rc2-armbian 09/11/2018
> [   18.480037] Workqueue: hci0 hci_power_on [bluetooth]
> [   18.487138] Call trace:
> [   18.494192]  dump_backtrace+0x0/0x1b8
> [   18.501280]  show_stack+0x14/0x20
> [   18.508361]  dump_stack+0xbc/0xf4
> [   18.515427]  ___might_sleep+0x140/0x1d8
> [   18.522515]  __might_sleep+0x50/0x88
> [   18.529582]  __mutex_lock+0x60/0x870
> [   18.536621]  mutex_lock_nested+0x1c/0x28
> [   18.543660]  regmap_lock_mutex+0x10/0x18
> [   18.550696]  regmap_read+0x38/0x70
> [   18.557727]  dw_hdmi_hardirq+0x58/0x138 [dw_hdmi]
> [   18.564804]  __handle_irq_event_percpu+0xac/0x410
> [   18.571891]  handle_irq_event_percpu+0x34/0x88
> [   18.578982]  handle_irq_event+0x48/0x78
> [   18.586051]  handle_fasteoi_irq+0xac/0x160
> [   18.593061]  generic_handle_irq+0x24/0x38
> [   18.599989]  __handle_domain_irq+0x60/0xb8
> [   18.606857]  gic_handle_irq+0x50/0xa0
> [   18.613659]  el1_irq+0xb4/0x130
> [   18.620394]  debug_lockdep_rcu_enabled+0x2c/0x30
> [   18.627111]  schedule+0x38/0xa0
> [   18.633781]  schedule_timeout+0x3a8/0x510
> [   18.640389]  wait_for_common+0x15c/0x180
> [   18.646905]  wait_for_completion+0x14/0x20
> [   18.653319]  mmc_wait_for_req_done+0x28/0x168
> [   18.659693]  mmc_wait_for_req+0xa8/0xe8
> [   18.665978]  mmc_wait_for_cmd+0x64/0x98
> [   18.672180]  mmc_io_rw_direct_host+0x94/0x130
> [   18.678385]  mmc_io_rw_direct+0x10/0x18
> [   18.684516]  sdio_enable_func+0xe8/0x1d0
> [   18.690627]  btsdio_open+0x24/0xc0 [btsdio]
> [   18.696821]  hci_dev_do_open+0x64/0x598 [bluetooth]
> [   18.703025]  hci_power_on+0x50/0x270 [bluetooth]
> [   18.709163]  process_one_work+0x2a0/0x6e0
> [   18.715252]  worker_thread+0x40/0x448
> [   18.721310]  kthread+0x12c/0x130
> [   18.727326]  ret_from_fork+0x10/0x1c
> [   18.735555] ------------[ cut here ]------------
> [   18.741430] do not call blocking ops when !TASK_RUNNING; state=2 set at [<000000006265ec59>] wait_for_common+0x140/0x180
> [   18.752417] WARNING: CPU: 0 PID: 68 at kernel/sched/core.c:6096 __might_sleep+0x7c/0x88
> [   18.760553] Modules linked in: dm_mirror dm_region_hash dm_log dm_mod
> btsdio bluetooth snd_soc_hdmi_codec dw_hdmi_i2s_audio ecdh_generic
> brcmfmac brcmutil cfg80211 rfkill ir_nec_decoder meson_dw_hdmi(O)
> dw_hdmi rc_geekbox meson_rng meson_ir ao_cec rng_core rc_core cec
> leds_pwm efivars nfsd ip_tables x_tables crc32_generic f2fs uas
> meson_gxbb_wdt pwm_meson efivarfs ipv6
> [   18.799469] CPU: 0 PID: 68 Comm: kworker/u17:0 Tainted: G        W  O      4.20.0-rc3Lyude-Test+ #9
> [   18.808858] Hardware name: amlogic khadas-vim2/khadas-vim2, BIOS 2018.07-rc2-armbian 09/11/2018
> [   18.818045] Workqueue: hci0 hci_power_on [bluetooth]
> [   18.824088] pstate: 80000085 (Nzcv daIf -PAN -UAO)
> [   18.829891] pc : __might_sleep+0x7c/0x88
> [   18.835722] lr : __might_sleep+0x7c/0x88
> [   18.841256] sp : ffff000008003cb0
> [   18.846751] x29: ffff000008003cb0 x28: 0000000000000000
> [   18.852269] x27: ffff00000938e000 x26: ffff800010283000
> [   18.857726] x25: ffff800010353280 x24: ffff00000868ef50
> [   18.863166] x23: 0000000000000000 x22: 0000000000000000
> [   18.868551] x21: 0000000000000000 x20: 000000000000038c
> [   18.873850] x19: ffff000008cd08c0 x18: 0000000000000010
> [   18.879081] x17: ffff000008a68cb0 x16: 0000000000000000
> [   18.884197] x15: 0000000000aaaaaa x14: 0e200e200e200e20
> [   18.889239] x13: 0000000000000001 x12: 00000000ffffffff
> [   18.894261] x11: ffff000008adfa48 x10: 0000000000000001
> [   18.899517] x9 : ffff0000092a0158 x8 : 0000000000000000
> [   18.904674] x7 : ffff00000812136c x6 : 0000000000000000
> [   18.909895] x5 : 0000000000000000 x4 : 0000000000000001
> [   18.915080] x3 : 0000000000000007 x2 : 0000000000000007
> [   18.920269] x1 : 99ab8e9ebb6c8500 x0 : 0000000000000000
> [   18.925443] Call trace:
> [   18.929904]  __might_sleep+0x7c/0x88
> [   18.934311]  __mutex_lock+0x60/0x870
> [   18.938687]  mutex_lock_nested+0x1c/0x28
> [   18.943076]  regmap_lock_mutex+0x10/0x18
> [   18.947453]  regmap_read+0x38/0x70
> [   18.951842]  dw_hdmi_hardirq+0x58/0x138 [dw_hdmi]
> [   18.956269]  __handle_irq_event_percpu+0xac/0x410
> [   18.960712]  handle_irq_event_percpu+0x34/0x88
> [   18.965176]  handle_irq_event+0x48/0x78
> [   18.969612]  handle_fasteoi_irq+0xac/0x160
> [   18.974058]  generic_handle_irq+0x24/0x38
> [   18.978501]  __handle_domain_irq+0x60/0xb8
> [   18.982938]  gic_handle_irq+0x50/0xa0
> [   18.987351]  el1_irq+0xb4/0x130
> [   18.991734]  debug_lockdep_rcu_enabled+0x2c/0x30
> [   18.996180]  schedule+0x38/0xa0
> [   19.000609]  schedule_timeout+0x3a8/0x510
> [   19.005064]  wait_for_common+0x15c/0x180
> [   19.009513]  wait_for_completion+0x14/0x20
> [   19.013951]  mmc_wait_for_req_done+0x28/0x168
> [   19.018402]  mmc_wait_for_req+0xa8/0xe8
> [   19.022809]  mmc_wait_for_cmd+0x64/0x98
> [   19.027177]  mmc_io_rw_direct_host+0x94/0x130
> [   19.031563]  mmc_io_rw_direct+0x10/0x18
> [   19.035922]  sdio_enable_func+0xe8/0x1d0
> [   19.040294]  btsdio_open+0x24/0xc0 [btsdio]
> [   19.044742]  hci_dev_do_open+0x64/0x598 [bluetooth]
> [   19.049228]  hci_power_on+0x50/0x270 [bluetooth]
> [   19.053687]  process_one_work+0x2a0/0x6e0
> [   19.058143]  worker_thread+0x40/0x448
> [   19.062608]  kthread+0x12c/0x130
> [   19.067064]  ret_from_fork+0x10/0x1c
> [   19.071513] irq event stamp: 12
> [   19.075937] hardirqs last  enabled at (11): [<ffff000008a4f57c>] _raw_spin_unlock_irq+0x2c/0x60
> [   19.083560] hardirqs last disabled at (12): [<ffff000008a48914>] __schedule+0xc4/0xa60
> [   19.091401] softirqs last  enabled at (0): [<ffff0000080b55e0>] copy_process.isra.4.part.5+0x4d8/0x1c50
> [   19.100801] softirqs last disabled at (0): [<0000000000000000>]           (null)
> [   19.108135] ---[ end trace 38c4920787b88c75 ]---
> 
> So, fix this by enabling the fast_io option in our regmap config so that
> regmap uses spinlocks for locking instead of mutexes.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 3f68be7d8e96 ("drm/meson: Add support for HDMI encoder and DW-HDMI bridge + PHY")
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> # v4.12+
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index df7247cd93f9..2cb2ad26d716 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -706,6 +706,7 @@ static const struct regmap_config meson_dw_hdmi_regmap_config = {
>  	.reg_read = meson_dw_hdmi_reg_read,
>  	.reg_write = meson_dw_hdmi_reg_write,
>  	.max_register = 0x10000,
> +	.fast_io = true,
>  };
>  
>  static bool meson_hdmi_connector_is_available(struct device *dev)
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>


Applying to drm-misc-fixes

Thanks,
Neil
