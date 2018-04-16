Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDPJ0h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:26:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52972 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeDPJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:26:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180416092631euoutp02abcc551d5c812acbe83d0e7655f4fc9a~l4Gk2tmWn0270902709euoutp02P
X-AuditID: cbfec7f2-1dbff70000011644-13-5ad46c452e00
Subject: Re: [PATCH v6 27/30] drm/rockchip: psr: Sanitize semantics of
 allow/disallow API
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
Message-ID: <fdd3e03d-a423-ea90-a13b-f124ec9afae0@samsung.com>
Date: Mon, 16 Apr 2018 11:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-28-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxT2vd90K7vWj77pDMtqyMaSydg0HuPGPjTLzf7oz4UluG5ewFDA
        9Ap+b6RsUJgwhm6Di6IJFV3DIqEUSv2a4MYUW6xlCGitAYxI181R6CQEO27vlvHvOc/znPc5
        5+TlSN0DxsDtKtwjWgpNZiOjoTp/mfO9+r55MOu1CRlBte8aAVZbhAZvyxUGBmf/ZKD1Tg+C
        +FiYhhN1h+FJ23USKjrGCKgL1VLw97CXgbMzDSxM3vNT4PQdoeHr8TAJAwNtLNy83E+A1/o7
        C5Xf2FloHx+iYWQ6RkPAc5yB6ftxEuoHLhHw49UgC+5jPxFwydlLwa+x7wgItnkR1B99xED0
        y6cMzHmaKKgoayGg/PZq8JUeZd9ZK7Q2tSIh6piihcZSPyUEaqoJwR20I6FbDrJCo62BFtod
        lYzQFbtPC6Gv+gjBaf9cWJAvU0JNhwMJXUNNpBBtT9n+XJbmzZ2ieVeJaEnP/FiTNzkyQ+ye
        37ovUh4hS5EDqhDHYX49/mH+gyqk4XT8WYQXvrXRVShpsZhB+MZUripEEf6j8wZSBKXh9HAv
        qZrOINzfqlFNEYSjXc2UIqzgP8LWujusIqzkHyHc9nOYUAqSb6bx2G81iQyGT8MLzhFGwVo+
        Ez/wX0xgik/Fwb/siZdW8R9i68M5VvUsx9caJhJ8Ev8efnxxMOEn+RdwmauRVLEej06cTIRh
        /nwSPhkoZ9W5t+JT/jO0ilfgqb6Of/k1ON6tNCj4IB6ZtFJqsw3h0HwFowqbcW+fn1YuRi5O
        fc6TrtJv4dC5q6x6yGQ8HFmuzpCM6zq/J1Vai23lOtX9Ig55XaSK9fj0zVmmFq2Vl2wmL9lG
        XrKN/H/uKUQ5kF4slgpyRSmjUNy7TjIVSMWFues+LSpoR4ufv/9p37Qbzd76pAfxHDI+q3V7
        A1k62lQi7S/oQZgjjSu1LaZFSrvTtP+AaCnaYSk2i1IPep6jjHpt9sufZen4XNMeMV8Ud4uW
        /1SCSzKUomUo+vDtw5tKNhh2pF2X1m95pmTojeTiu7cy7Nn8aP2FsC9Hf+VA8PHo7VTwZpbd
        C17wBI7NfOHe6BI3x6oCtvxVveb8NUfSzne8Hm9uOLQlO8WQMpSX7gpv0qXW2ipz4nL9eLWs
        17hy5MGpl4o8y2LbQu/uCzq3LRR1PqEPGbqNlJRnyniFtEimfwBseDGO+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxzG855bi7HxrIC84YNbumyLU4+cAuuf2TVzce7dJ3X7IGIMNnIE
        Yi/mnJaIcbHBzEs3EEEWKRsuWyGzg4S0oPWGDha1YqkMwrik6kQNwpgKyGTjMigs4dvvfZ7n
        9+FN/mpa+w+brM63OSTZZrbouGVM28zN6LpNlq6slNkpEYrbQxQUHR9hIVz7CwddL59xUNff
        gmD24TAL35V9Aa8abtNwrPEhBWX3Sxn4uyfMwU/jlSoYvNfBQKD9axZODgzTEIk0qODutTYK
        wkV/quDEKa8K/APdLPSOTrDQeelbDkYfzNJwJtJMQf2vURUET1+noDnQysCtiW8oiDaEEZwp
        f8rB2JczHExeqmbg2JFaCo7+vhLaXeWqD98kddV1iIz5hlhS5epgSGdJMUWCUS8iFz1RFak6
        XskSv+8ERy5MPGDJ/a9uUiTgPUymPdcYUtLoQ+RCdzVNxvyrtq7IEoyy3emQ3sizK44PdDtF
        0AtiBgj6tAxBTDXsel+frltvMuZIlvwCSV5v2i3kDfaOU/v/3XRg5OgI7UI+cKM4NebTcE1P
        K+1Gy9RavgbhofEBeqFIwpfPjixyPJ7qdnMLo2GEXz2Pxop4ficuKutXzRcJ/FOEQ8VDsQfN
        /8jivv4Kbn6l5e8gHPTJ88zxq/F0oDeWa3gTftxxNcYM/xaOvvAy85zIZ+J7kdHFzWs4VPko
        lsfxH+HnV7tiOc2/g6eqf6MX+HV8pKlqkZNw36OzVCnSepboniWKZ4niWaJ8jxgfSpCcijXX
        qugFxWxVnLZcYY/d6kdzd3f+xmRjELn/+rwF8WqkW64JhjuztKy5QCm0tiCspnUJmlrzXKTJ
        MRcelGR7tuy0SEoLSp/73Ck6OXGPfe6KbY5sMV00QIZoSDWkvge6JE0kpTBLy+eaHdI+Sdov
        yf97lDou2YXezt672WIsDnQaD9kSM8UK18+tpKl+Q2WpvO1w0JLjXPvpmh09E6G0z1alb6kw
        JeXX1qRoPjb1xYfaKj7x0+TGZNNd7y0SVS5v3xJ5srE8WSh0C5nn6s/9YRQOUCVXNo5uO/SD
        oXtF+R1+RrtG37t9s9Sx+rSr4Pxgw7RU32w4qWOUPLP4Li0r5v8A2dS7b40DAAA=
X-CMS-MailID: 20180416092629eucas1p2cbf950c79898df4f7eba0ad274e1f882
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416092629eucas1p2cbf950c79898df4f7eba0ad274e1f882
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095246epcas3p26974ed8997dce72fa8d02a0bfe811f07
X-RootMTR: 20180405095246epcas3p26974ed8997dce72fa8d02a0bfe811f07
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095246epcas3p26974ed8997dce72fa8d02a0bfe811f07@epcas3p2.samsung.com>
        <20180405095000.9756-28-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> Currently both rockchip_drm_psr_activate() and _deactivate() only set the
> boolean "active" flag without actually making sure that hardware state
> complies with it.
>
> Since we are going to extend the usage of this API to properly lock PSR
> for the duration of atomic commits, we change the semantics in following
> way:
>  - a counter is used to track the number of disallow requests,
>  - PSR is actually disabled in hardware on first disallow request,
>  - PSR enable work is scheduled on last disallow request.

I guess you meant "on last allow request".
I think It would be more readable if you replace disallow with inhibit.

>
> The above allows using the API as a way to deterministically synchronize
> PSR state changes with other DRM events, i.e. atomic commits and cursor
> updates. As a nice side effect, the naming is sorted out and we have
> "inhibit" for stopping the software logic and "enable" for hardware
> state.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  4 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c     | 57 ++++++++++++++++++-------
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.h     |  4 +-
>  3 files changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 6d45d62466b3..080f05352195 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -134,7 +134,7 @@ static int rockchip_dp_poweron_end(struct analogix_dp_plat_data *plat_data)
>  {
>  	struct rockchip_dp_device *dp = to_dp(plat_data);
>  
> -	return rockchip_drm_psr_activate(&dp->encoder);
> +	return rockchip_drm_psr_inhibit_put(&dp->encoder);
>  }
>  
>  static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
> @@ -142,7 +142,7 @@ static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
>  	struct rockchip_dp_device *dp = to_dp(plat_data);
>  	int ret;
>  
> -	ret = rockchip_drm_psr_deactivate(&dp->encoder);
> +	ret = rockchip_drm_psr_inhibit_get(&dp->encoder);
>  	if (ret != 0)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index 448c5fde241c..e7e16d92d5a1 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -27,7 +27,7 @@ struct psr_drv {
>  	struct drm_encoder	*encoder;
>  
>  	struct mutex		lock;
> -	bool			active;
> +	int			inhibit_count;
>  	bool			enabled;
>  
>  	struct delayed_work	flush_work;
> @@ -76,7 +76,7 @@ static int psr_set_state_locked(struct psr_drv *psr, bool enable)
>  {
>  	int ret;
>  
> -	if (!psr->active)
> +	if (psr->inhibit_count > 0)
>  		return -EINVAL;
>  
>  	if (enable == psr->enabled)
> @@ -101,13 +101,18 @@ static void psr_flush_handler(struct work_struct *work)
>  }
>  
>  /**
> - * rockchip_drm_psr_activate - activate PSR on the given pipe
> + * rockchip_drm_psr_inhibit_put - release PSR inhibit on given encoder
>   * @encoder: encoder to obtain the PSR encoder
>   *
> + * Decrements PSR inhibit count on given encoder. Should be called only
> + * for a PSR inhibit count increment done before. If PSR inhibit counter
> + * reaches zero, PSR flush work is scheduled to make the hardware enter
> + * PSR mode in PSR_FLUSH_TIMEOUT_MS.
> + *
>   * Returns:
>   * Zero on success, negative errno on failure.
>   */
> -int rockchip_drm_psr_activate(struct drm_encoder *encoder)
> +int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder)
>  {
>  	struct psr_drv *psr = find_psr_by_encoder(encoder);
>  
> @@ -115,21 +120,29 @@ int rockchip_drm_psr_activate(struct drm_encoder *encoder)
>  		return PTR_ERR(psr);
>  
>  	mutex_lock(&psr->lock);
> -	psr->active = true;
> +	--psr->inhibit_count;

Maybe some WARN on negative value?
With doc fixes:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> +	if (!psr->inhibit_count)
> +		mod_delayed_work(system_wq, &psr->flush_work,
> +				 PSR_FLUSH_TIMEOUT_MS);
>  	mutex_unlock(&psr->lock);
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(rockchip_drm_psr_activate);
> +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put);
>  
>  /**
> - * rockchip_drm_psr_deactivate - deactivate PSR on the given pipe
> + * rockchip_drm_psr_inhibit_get - acquire PSR inhibit on given encoder
>   * @encoder: encoder to obtain the PSR encoder
>   *
> + * Increments PSR inhibit count on given encoder. This function guarantees
> + * that after it returns PSR is turned off on given encoder and no PSR-related
> + * hardware state change occurs at least until a matching call to
> + * rockchip_drm_psr_inhibit_put() is done.
> + *
>   * Returns:
>   * Zero on success, negative errno on failure.
>   */
> -int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
> +int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder)
>  {
>  	struct psr_drv *psr = find_psr_by_encoder(encoder);
>  
> @@ -137,15 +150,15 @@ int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
>  		return PTR_ERR(psr);
>  
>  	mutex_lock(&psr->lock);
> -	psr->active = false;
> -	psr->enabled = false;
> +	psr_set_state_locked(psr, false);
> +	++psr->inhibit_count;
>  	mutex_unlock(&psr->lock);
>  	cancel_delayed_work_sync(&psr->flush_work);
>  	cancel_work_sync(&psr->disable_work);
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
> +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_get);
>  
>  static void rockchip_drm_do_flush(struct psr_drv *psr)
>  {
> @@ -301,6 +314,11 @@ static const struct input_device_id psr_ids[] = {
>   * @encoder: encoder that obtain the PSR function
>   * @psr_set: call back to set PSR state
>   *
> + * The function returns with PSR inhibit counter initialized with one
> + * and the caller (typically encoder driver) needs to call
> + * rockchip_drm_psr_inhibit_put() when it becomes ready to accept PSR
> + * enable request.
> + *
>   * Returns:
>   * Zero on success, negative errno on failure.
>   */
> @@ -322,7 +340,7 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
>  	INIT_WORK(&psr->disable_work, psr_disable_handler);
>  	mutex_init(&psr->lock);
>  
> -	psr->active = false;
> +	psr->inhibit_count = 1;
>  	psr->enabled = false;
>  	psr->encoder = encoder;
>  	psr->set = psr_set;
> @@ -362,6 +380,11 @@ EXPORT_SYMBOL(rockchip_drm_psr_register);
>   * @encoder: encoder that obtain the PSR function
>   * @psr_set: call back to set PSR state
>   *
> + * It is expected that the PSR inhibit counter is 1 when this function is
> + * called, which corresponds to a state when related encoder has been
> + * disconnected from any CRTCs and its driver called
> + * rockchip_drm_psr_inhibit_get() to stop the PSR logic.
> + *
>   * Returns:
>   * Zero on success, negative errno on failure.
>   */
> @@ -373,10 +396,14 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
>  	mutex_lock(&drm_drv->psr_list_lock);
>  	list_for_each_entry_safe(psr, n, &drm_drv->psr_list, list) {
>  		if (psr->encoder == encoder) {
> -			input_unregister_handler(&psr->input_handler);
> -			cancel_delayed_work_sync(&psr->flush_work);
> -			cancel_work_sync(&psr->disable_work);
> +			/*
> +			 * Any other value would mean that the encoder
> +			 * is still in use.
> +			 */
> +			WARN_ON(psr->inhibit_count != 1);
> +
>  			list_del(&psr->list);
> +			input_unregister_handler(&psr->input_handler);
>  			kfree(psr->input_handler.name);
>  			kfree(psr);
>  		}
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> index 06537ee27565..40e026c14168 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> @@ -18,8 +18,8 @@
>  void rockchip_drm_psr_flush_all(struct drm_device *dev);
>  int rockchip_drm_psr_flush(struct drm_crtc *crtc);
>  
> -int rockchip_drm_psr_activate(struct drm_encoder *encoder);
> -int rockchip_drm_psr_deactivate(struct drm_encoder *encoder);
> +int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
> +int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
>  
>  int rockchip_drm_psr_register(struct drm_encoder *encoder,
>  			int (*psr_set)(struct drm_encoder *, bool enable));
