Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C962C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DD721850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IgtuiAXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeLSH0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:26:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48209 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeLSH0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:26:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181219072611euoutp011497024c2521cc37f9128fac3bcd5315~xqzBz08wE0851408514euoutp01i
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:26:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181219072611euoutp011497024c2521cc37f9128fac3bcd5315~xqzBz08wE0851408514euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545204371;
        bh=XZydJTJNuch+LWR+5h+n55h9EDe/Pg6GeJts+TEWxZo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IgtuiAXLKzWSxnzi9kThEV53nG6jO2L1AVBXxoL7b7nrdUweBU0cHQc8L6tSQTEzw
         R/tXRwyx2Wub1cZLRTj1QyIjFfnk90jNjfCVWbiqqeutEmS2R89tQI200GxElqwgZX
         EVgkUn3cNDj9vCRuJlHc6y9B1g5zz3ysqoxb5MvM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181219072610eucas1p2f59c9423e16bbbdb9f2dbaf55605fcd2~xqzBFKxcf1353813538eucas1p2A;
        Wed, 19 Dec 2018 07:26:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 01.C7.04294.292F91C5; Wed, 19
        Dec 2018 07:26:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181219072610eucas1p27da804d4d3c86dd60a6aeee9e75bc90d~xqzAS-Sud1354313543eucas1p2x;
        Wed, 19 Dec 2018 07:26:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181219072609eusmtrp28ef0db4cd819cfe5a89254683a7a6abd~xqzAEY4EK0347203472eusmtrp2W;
        Wed, 19 Dec 2018 07:26:09 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-97-5c19f29270ed
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.37.04284.192F91C5; Wed, 19
        Dec 2018 07:26:09 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181219072609eusmtip1c9d871f58697fe453f800fabacd1a3aa~xqy-ioI2q0318403184eusmtip1i;
        Wed, 19 Dec 2018 07:26:09 +0000 (GMT)
Subject: Re: [PATCH RFC v2 5/8] drm/bridge: dw-hdmi: support dynamically get
 input/out color info
To:     Neil Armstrong <narmstrong@baylibre.com>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     Zheng Yang <zhengyang@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3cd791c0-8a7b-a3d1-09fa-5ddf0ea9c380@samsung.com>
Date:   Wed, 19 Dec 2018 08:26:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130134301.17963-6-narmstrong@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7qTPknGGGw5p27R1PGW1eLK1/ds
        Fv8fvWa1mDup1qJz4hJ2iwWzuS0u75rDZvHg5X5Gi0N90RZ3751gsVjfou/A7fH+Riu7x7w1
        1R6X+3qZPGZ3zGT1uN99nMlj85J6j/6/Bh5/Z+1n8dh+bR6zx+dNcgFcUVw2Kak5mWWpRfp2
        CVwZC15fYis4plbxZst9pgbGV/JdjJwcEgImEmv+rGPtYuTiEBJYwShxZft/RgjnC6PEl0fr
        WSCcz4wSh94eYIdpufzqJ1TLckaJk/dWQbW8ZZQ40XkGrEpYIFni6L7dzCAJEYEWJonvM54y
        gySYBXoZJTpWx4PYbAKaEn8332QDsXkF7CSeHnzGBGKzCKhK3Ni3AiwuKhAh0XF/NVSNoMTJ
        mU9YQGxOAVuJx8/2sUHMlJfY/nYO1HxxiVtP5jNBnPqWXeLjfCcI20ViyvtjUHFhiVfHt0C9
        IyPxfydMfb1E08wrYEdLCHQAfbN4ORtEwlri8PGLQD9zAC3QlFi/Sx8i7Cix99IvsLCEAJ/E
        jbeCECfwSUzaNp0ZIswr0dEmBFGtKHH/7FZmCFtcYumFr2wTGJVmIXlsFpJnZiF5ZhbC3gWM
        LKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECE9rpf8e/7GDc9SfpEKMAB6MSD2+HgmSM
        EGtiWXFl7iFGCQ5mJRHeS9FAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NT
        C1KLYLJMHJxSDYzhxqc3cURyhzx49oll87ZKE9f+kP32qr7r7+xfbizKsYgxZ06h+/M2xlqH
        Uz4VV0NfT1/yNWVqziLRW3Je0zkW/ymROXnpgvaG6YUmrDyP+I/NfmXN+2NjepA3Z4yj9O2n
        a3uWhPCxmhwrcfxwb2eS7YOlCw38A46utdVq63xakmc/Qd3xXZESS3FGoqEWc1FxIgDJINT+
        ZAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7oTP0nGGCz7rGfR1PGW1eLK1/ds
        Fv8fvWa1mDup1qJz4hJ2iwWzuS0u75rDZvHg5X5Gi0N90RZ3751gsVjfou/A7fH+Riu7x7w1
        1R6X+3qZPGZ3zGT1uN99nMlj85J6j/6/Bh5/Z+1n8dh+bR6zx+dNcgFcUXo2RfmlJakKGfnF
        JbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZC15fYis4plbxZst9pgbG
        V/JdjJwcEgImEpdf/WTtYuTiEBJYyiix4fhSZoiEuMTu+W+hbGGJP9e62CCKXjNKzG5tAksI
        CyRLHN23G8wWEWhhknj53BqkiFmgl1Gi/cwzRoiOw4wSTydfYwepYhPQlPi7+SYbiM0rYCfx
        9OAzJhCbRUBV4sa+FWBxUYEIibMv1zFC1AhKnJz5hAXE5hSwlXj8bB9YDbOAusSfeZeYIWx5
        ie1v50DZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+
        7iZGYBRvO/Zz8w7GSxuDDzEKcDAq8fA+UJKMEWJNLCuuzD3EKMHBrCTCeykaKMSbklhZlVqU
        H19UmpNafIjRFOi5icxSosn5wASTVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUg
        tQimj4mDU6qBsefsp+9HNvvNkllk6XUxsfXpqdYftVdOqeXv4VO0md75a+3LrfOSok/K1drb
        P3648czF3wJv+VvayznzFIUPxajM/LV1/Qfz4j4Pi7Bdtqf/LHrzLfrw9EXTp1xfpPTf+Ngv
        9b8fLWou3PqWt/nikR2ypze1eXI4FKvuerVCvJn7c6RLOruVy0wlluKMREMt5qLiRABZZveE
        +AIAAA==
X-CMS-MailID: 20181219072610eucas1p27da804d4d3c86dd60a6aeee9e75bc90d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181130134411epcas3p2dc841f297a16ae25f17323c766a386d6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130134411epcas3p2dc841f297a16ae25f17323c766a386d6
References: <20181130134301.17963-1-narmstrong@baylibre.com>
        <CGME20181130134411epcas3p2dc841f297a16ae25f17323c766a386d6@epcas3p2.samsung.com>
        <20181130134301.17963-6-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2018 14:42, Neil Armstrong wrote:
> From: Zheng Yang <zhengyang@rock-chips.com>
>
> To get input/output bus_format/enc_format dynamically, this patch
> introduce following funstion in plat_data:
> 	- get_input_bus_format
> 	- get_output_bus_format
> 	- get_enc_in_encoding
> 	- get_enc_out_encoding


It seems fishy. On one side description says about dynamic resolution of
formats and encodings.

On the other side these functions as only argument takes platform_data
which should be rather static.

Where is this "dynamic" thing? The only usage of these callbacks I have
found in next patches is also not dynamic, the functions just return
some static value.

Moreover function takes void* argument, which is again something
suspicious, why cannot you pass know structure?

And finally encoding usually should depend on display mode, it should
not depend only static data.


What kind of problems do you want to solve here?


Regards

Andrzej



>
> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 +++++++++++++++++------
>  include/drm/bridge/dw_hdmi.h              |  5 ++++
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 4a9a24e854db..bd564ffdf18b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1810,6 +1810,7 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
>  static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  {
>  	int ret;
> +	void *data = hdmi->plat_data->phy_data;
>  
>  	hdmi_disable_overflow_interrupts(hdmi);
>  
> @@ -1821,10 +1822,13 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  		dev_dbg(hdmi->dev, "CEA mode used vic=%d\n", hdmi->vic);
>  	}
>  
> -	if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
> -	    (hdmi->vic == 21) || (hdmi->vic == 22) ||
> -	    (hdmi->vic == 2) || (hdmi->vic == 3) ||
> -	    (hdmi->vic == 17) || (hdmi->vic == 18))
> +	if (hdmi->plat_data->get_enc_out_encoding)
> +		hdmi->hdmi_data.enc_out_encoding =
> +			hdmi->plat_data->get_enc_out_encoding(data);
> +	else if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
> +		 (hdmi->vic == 21) || (hdmi->vic == 22) ||
> +		 (hdmi->vic == 2) || (hdmi->vic == 3) ||
> +		 (hdmi->vic == 17) || (hdmi->vic == 18))
>  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_601;
>  	else
>  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_709;
> @@ -1833,21 +1837,31 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
>  
>  	/* TOFIX: Get input format from plat data or fallback to RGB888 */
> -	if (hdmi->plat_data->input_bus_format)
> +	if (hdmi->plat_data->get_input_bus_format)
> +		hdmi->hdmi_data.enc_in_bus_format =
> +			hdmi->plat_data->get_input_bus_format(data);
> +	else if (hdmi->plat_data->input_bus_format)
>  		hdmi->hdmi_data.enc_in_bus_format =
>  			hdmi->plat_data->input_bus_format;
>  	else
>  		hdmi->hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>  
>  	/* TOFIX: Get input encoding from plat data or fallback to none */
> -	if (hdmi->plat_data->input_bus_encoding)
> +	if (hdmi->plat_data->get_enc_in_encoding)
> +		hdmi->hdmi_data.enc_in_encoding =
> +			hdmi->plat_data->get_enc_in_encoding(data);
> +	else if (hdmi->plat_data->input_bus_encoding)
>  		hdmi->hdmi_data.enc_in_encoding =
>  			hdmi->plat_data->input_bus_encoding;
>  	else
>  		hdmi->hdmi_data.enc_in_encoding = V4L2_YCBCR_ENC_DEFAULT;
>  
>  	/* TOFIX: Default to RGB888 output format */
> -	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +	if (hdmi->plat_data->get_output_bus_format)
> +		hdmi->hdmi_data.enc_out_bus_format =
> +			hdmi->plat_data->get_output_bus_format(data);
> +	else
> +		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>  
>  	hdmi->hdmi_data.pix_repet_factor = 0;
>  	hdmi->hdmi_data.hdcp_enable = 0;
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 7a02744ce0bc..2e797f782c51 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -142,6 +142,11 @@ struct dw_hdmi_plat_data {
>  	int (*configure_phy)(struct dw_hdmi *hdmi,
>  			     const struct dw_hdmi_plat_data *pdata,
>  			     unsigned long mpixelclock);
> +
> +	unsigned long (*get_input_bus_format)(void *data);
> +	unsigned long (*get_output_bus_format)(void *data);
> +	unsigned long (*get_enc_in_encoding)(void *data);
> +	unsigned long (*get_enc_out_encoding)(void *data);
>  };
>  
>  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,


