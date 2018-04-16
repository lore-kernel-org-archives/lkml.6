Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbeDPHTc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:19:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38722 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDPHT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:19:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180416071927euoutp02a22b0aa90f8957bdef4e76dca3895815~l2XoKF2GU0359703597euoutp02r
X-AuditID: cbfec7f4-713ff700000043e4-3b-5ad44e7d0728
Subject: Re: [PATCH v6 24/30] drm/rockchip: Disable PSR on input events
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
        hshi@chromium.org, "Kristian H. Kristensen" <hoegsberg@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <20d2aa03-63e3-0072-5ca7-5f3ca42c3c9e@samsung.com>
Date: Mon, 16 Apr 2018 09:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-25-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTdRjH7/P9ue0YfZzQPlFX14w7rHDN6/K5DO3Ku75lZ51dnoeVLfyG
        JgxvE8k8gqbxSwEFFTZsehwiR1i0kSw80Ea5lMZkMxVzQUqGrGW3MYqLH7F99eK/1/Pr/X6e
        Px4ZrRrnUmRbDNtFo0Gfo+EUzKlzk970wjWXMp+61ZgOlf3nKTCXhVjwNH/LQW/jKIJL0Tsc
        tP3sQjB7I8jCZzWF8E/7BRr2ev6iobTjBgU1Q/sZ+Puqh4OWcQsPo78MMODo38dC9c0gDV5v
        Ow8Xz/RR4DH/wUP5gSYe7DcvszAYnmDB33WEg/DwLA313h4KTn4X4MF58CwFPY5eBn6YOExB
        oN2DoL72NgeRT2c4mOyyMVC6u5mCkiv3Q39xLf98qtBma0NCpHWMFRqKBxjBX1VJCc5AExK+
        sQZ44Zg9X2gos7CCvbWcEzonhllhaK+bEhxNRcK09QwjVHW0IqHzso0WIvaHX8eZiuc2iTlb
        dohG7Yp3FZuj1w9x28ozPvzTcYAqRnW6CiSXEfw08Z/wcRVIIVPhFkRa3N20FIwjUmKruhtE
        EPF1n6TujRw+u4ePsQqfQGQ4hKWmECKfewNsrLAQv0QOztTEdZPwbUTavw9SsYDGLo7UX4sw
        sS4OLybTjkEuxkq8gkxdMceZwankuuVcXCkZryfm3yd5qWcBOW8Zic/K8QukcncYxZjGj5DO
        0BFaYjW5NnI0bkawT06+GD3NSnuvIj81+niJF5Ixd8ddfoj01e5jJN5FBkfNjDRchsjQv6Wc
        VFhOet0Dc0KyOYfF5MsubQwJziBm24sSJpKroQXSComk5lQdLaWVpKxEJWk8SoY8X9MSq8nx
        i1FuP1pknXeYdd4x1nnHWP+3PYaYVqQW80252aJpqUEsWGLS55ryDdlLsvJy7WjuF/pm3ONO
        1DX1ngthGdIkKJ0ef6aK1e8w7cx1ISKjNUnKZv1cSrlJv/Mj0Zi30ZifI5pc6EEZo1Er30n7
        OFOFs/Xbxa2iuE003qtSMnlKMdKmFGSstxSVjiXLl20MH197562SlT9+9eSG4OoNRfcV/rou
        ocLv1S7aE05NGCtQ80npdDDtmbePulbp1qnfx3lLo59spRqe/eDlcJoqsTuZf+yW1vrba0+4
        11b7dq1OfOWCLku3bMqpeICv4wwjy7NmX1VNvxF9s9q2smfNaSFSnmYSNYxps173OG006f8D
        5i7GsQcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH87vPona5Fhy/kMVHE2Nw4eoFkcNSiS7G3e2PxUQzTY3gjdyA
        GW1db2uoc47BRB4rAjJniwJTxIWwBVsCtdsAq0GRlYIYmI+iUZKhiC4w8IUwaDXhv0/O93xO
        zkmOitQUMjGqfUaLbDZKWVpmAdU1fTUYd+jzm/q1xa9iwd7dSUBuwSgN/rpLDFw+M4zg5sQz
        Bhru+BDMPBih4XT5N/Ci8ToJxf5/STja9ICA8nulFDz/28/AL/85WBge7KXA3f0DDccejpAQ
        CDSy0NPWRYA/9wkLhWW1LLge9tNwa2yShj7vKQbG7s+QcDLQSsCvV4IseCraCWh1X6bg2uQJ
        AoKNfgQnjz9iYPzINAMvvVUUHM2rIyB/4H3ozjnOblwpNlQ1IHG8/jEtVub0UmJfiZ0QPcFa
        JF50BlmxxmUVKwsctOiqL2TElsn7tHiv+Cohumu/Fd842yixpKkeiS39VaQ47lq6ldPzOrPJ
        apGXZ5oUywbtLgHieSEZ+Ph1ybyQkLT7o/hE7ZoUXbqcte+AbF6TsofPnLj7I7O/cEP2U3cZ
        kYN+EopQhApz6/CJ9u/ZIrRApeHOIZxbmU+Fg2j8e/UoGeZIPNVfxISbRhD2+p7Qc0Ek9wmu
        mC4PBVHcI4Q77Y9Do0juCoM7SmuosPIXwg2XvMycwnCx+I37VojVXAqeGsgNMcWtxHcdHaGx
        S7ideDAw9rZnMe50DIV2iuA+xva8MTTHJLcKT1XdIMO8DLeMnnrL0fj2UDVRijTOebpznuKc
        pzjnKTWIqkdRslUxZBgUgVckg2I1ZvB7TQYXmn3D5o6Xbg+6cWGbD3EqpF2k9vj79BpaOqDY
        DD6EVaQ2Sl0nzZbU6ZLtoGw2pZmtWbLiQ4mzx5WRMUv2mmaf2mhJExKFJEgWkhKSEtaDNlod
        WGvTa7gMySJ/Kcv7ZfM7j1BFxOSgL7Zaopeldm2Kq3ihdqSidt2fO6TIPa5DPXadjW9KS2eR
        IXMq5TxvlJ6f3VL7M5/a8t7mr2wFrbvO9ex+doxcwbTHxP6xKm7y8PnKiU+bv36dPfRBSc9A
        WfaWmd90+pmLK6r1Ha+y8wY9ff6uC814/fDr5fkRny1s+26795/eRTWeD7WUkikJq0mzIv0P
        l2LlGZwDAAA=
X-CMS-MailID: 20180416071925eucas1p20d61ccf3173617be9363716561f93fb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416071925eucas1p20d61ccf3173617be9363716561f93fb3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095330epcas1p33487d73838f08a65ce7935f0d3e8b9e4
X-RootMTR: 20180405095330epcas1p33487d73838f08a65ce7935f0d3e8b9e4
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095330epcas1p33487d73838f08a65ce7935f0d3e8b9e4@epcas1p3.samsung.com>
        <20180405095000.9756-25-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+CC: linux-input list and maintainer


On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: "Kristian H. Kristensen" <hoegsberg@google.com>
>
> To improve PSR exit latency, we speculatively start exiting when we
> receive input events. Occasionally, this may lead to false positives,
> but most of the time we get a head start on coming out of PSR. Depending
> on how userspace takes to produce a new frame in response to the event,
> this can completely hide the exit latency. In case of Chrome OS, we
> typically get the input notifier 50ms or more before the dirty_fb
> triggered exit.

As I see from the code below, you just need notification from input
subsystem on user activity.
Maybe there is some simpler notification mechanism for such things?
If not, maybe such helper should be created in input subsystem, I
suppose it could be reused in other places as well.

Regards
Andrzej

>
> Signed-off-by: Kristian H. Kristensen <hoegsberg@google.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 134 ++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index 9376f4396b6b..a107845ba97c 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -12,6 +12,8 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/input.h>
> +
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
>  
> @@ -35,6 +37,9 @@ struct psr_drv {
>  	enum psr_state		state;
>  
>  	struct delayed_work	flush_work;
> +	struct work_struct	disable_work;
> +
> +	struct input_handler    input_handler;
>  
>  	int (*set)(struct drm_encoder *encoder, bool enable);
>  };
> @@ -133,6 +138,18 @@ static void psr_flush_handler(struct work_struct *work)
>  	mutex_unlock(&psr->lock);
>  }
>  
> +static void psr_disable_handler(struct work_struct *work)
> +{
> +	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
> +
> +	/* If the state has changed since we initiated the flush, do nothing */
> +	mutex_lock(&psr->lock);
> +	if (psr->state == PSR_ENABLE)
> +		psr_set_state_locked(psr, PSR_FLUSH);
> +	mutex_unlock(&psr->lock);
> +	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
> +}
> +
>  /**
>   * rockchip_drm_psr_activate - activate PSR on the given pipe
>   * @encoder: encoder to obtain the PSR encoder
> @@ -173,6 +190,7 @@ int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
>  	psr->active = false;
>  	mutex_unlock(&psr->lock);
>  	cancel_delayed_work_sync(&psr->flush_work);
> +	cancel_work_sync(&psr->disable_work);
>  
>  	return 0;
>  }
> @@ -226,6 +244,95 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
>  
> +static void psr_input_event(struct input_handle *handle,
> +			    unsigned int type, unsigned int code,
> +			    int value)
> +{
> +	struct psr_drv *psr = handle->handler->private;
> +
> +	schedule_work(&psr->disable_work);
> +}
> +
> +static int psr_input_connect(struct input_handler *handler,
> +			     struct input_dev *dev,
> +			     const struct input_device_id *id)
> +{
> +	struct input_handle *handle;
> +	int error;
> +
> +	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
> +	if (!handle)
> +		return -ENOMEM;
> +
> +	handle->dev = dev;
> +	handle->handler = handler;
> +	handle->name = "rockchip-psr";
> +
> +	error = input_register_handle(handle);
> +	if (error)
> +		goto err2;
> +
> +	error = input_open_device(handle);
> +	if (error)
> +		goto err1;
> +
> +	return 0;
> +
> +err1:
> +	input_unregister_handle(handle);
> +err2:
> +	kfree(handle);
> +	return error;
> +}
> +
> +static void psr_input_disconnect(struct input_handle *handle)
> +{
> +	input_close_device(handle);
> +	input_unregister_handle(handle);
> +	kfree(handle);
> +}
> +
> +/* Same device ids as cpu-boost */
> +static const struct input_device_id psr_ids[] = {
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
> +			 INPUT_DEVICE_ID_MATCH_ABSBIT,
> +		.evbit = { BIT_MASK(EV_ABS) },
> +		.absbit = { [BIT_WORD(ABS_MT_POSITION_X)] =
> +			    BIT_MASK(ABS_MT_POSITION_X) |
> +			    BIT_MASK(ABS_MT_POSITION_Y) },
> +	}, /* multi-touch touchscreen */
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
> +		.evbit = { BIT_MASK(EV_ABS) },
> +		.absbit = { [BIT_WORD(ABS_X)] = BIT_MASK(ABS_X) }
> +
> +	}, /* stylus or joystick device */
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
> +		.evbit = { BIT_MASK(EV_KEY) },
> +		.keybit = { [BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) },
> +	}, /* pointer (e.g. trackpad, mouse) */
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
> +		.evbit = { BIT_MASK(EV_KEY) },
> +		.keybit = { [BIT_WORD(KEY_ESC)] = BIT_MASK(KEY_ESC) },
> +	}, /* keyboard */
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
> +				INPUT_DEVICE_ID_MATCH_KEYBIT,
> +		.evbit = { BIT_MASK(EV_KEY) },
> +		.keybit = {[BIT_WORD(BTN_JOYSTICK)] = BIT_MASK(BTN_JOYSTICK) },
> +	}, /* joysticks not caught by ABS_X above */
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
> +				INPUT_DEVICE_ID_MATCH_KEYBIT,
> +		.evbit = { BIT_MASK(EV_KEY) },
> +		.keybit = { [BIT_WORD(BTN_GAMEPAD)] = BIT_MASK(BTN_GAMEPAD) },
> +	}, /* gamepad */
> +	{ },
> +};
> +
>  /**
>   * rockchip_drm_psr_register - register encoder to psr driver
>   * @encoder: encoder that obtain the PSR function
> @@ -239,6 +346,7 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
>  {
>  	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
>  	struct psr_drv *psr;
> +	int error;
>  
>  	if (!encoder || !psr_set)
>  		return -EINVAL;
> @@ -248,6 +356,7 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
>  		return -ENOMEM;
>  
>  	INIT_DELAYED_WORK(&psr->flush_work, psr_flush_handler);
> +	INIT_WORK(&psr->disable_work, psr_disable_handler);
>  	mutex_init(&psr->lock);
>  
>  	psr->active = true;
> @@ -255,11 +364,33 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
>  	psr->encoder = encoder;
>  	psr->set = psr_set;
>  
> +	psr->input_handler.event = psr_input_event;
> +	psr->input_handler.connect = psr_input_connect;
> +	psr->input_handler.disconnect = psr_input_disconnect;
> +	psr->input_handler.name =
> +		kasprintf(GFP_KERNEL, "rockchip-psr-%s", encoder->name);
> +	if (!psr->input_handler.name) {
> +		error = -ENOMEM;
> +		goto err2;
> +	}
> +	psr->input_handler.id_table = psr_ids;
> +	psr->input_handler.private = psr;
> +
> +	error = input_register_handler(&psr->input_handler);
> +	if (error)
> +		goto err1;
> +
>  	mutex_lock(&drm_drv->psr_list_lock);
>  	list_add_tail(&psr->list, &drm_drv->psr_list);
>  	mutex_unlock(&drm_drv->psr_list_lock);
>  
>  	return 0;
> +
> + err1:
> +	kfree(psr->input_handler.name);
> + err2:
> +	kfree(psr);
> +	return error;
>  }
>  EXPORT_SYMBOL(rockchip_drm_psr_register);
>  
> @@ -279,8 +410,11 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
>  	mutex_lock(&drm_drv->psr_list_lock);
>  	list_for_each_entry_safe(psr, n, &drm_drv->psr_list, list) {
>  		if (psr->encoder == encoder) {
> +			input_unregister_handler(&psr->input_handler);
>  			cancel_delayed_work_sync(&psr->flush_work);
> +			cancel_work_sync(&psr->disable_work);
>  			list_del(&psr->list);
> +			kfree(psr->input_handler.name);
>  			kfree(psr);
>  		}
>  	}
