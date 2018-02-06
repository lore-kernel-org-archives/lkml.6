Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbeBFUid (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:38:33 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:46776 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753147AbeBFUib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:38:31 -0500
Subject: Re: [PATCH v8 5/7] media: i2c: Add TDA1997x HDMI receiver driver
To: Tim Harvey <tharvey@gateworks.com>, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
References: <1517948874-21681-1-git-send-email-tharvey@gateworks.com>
 <1517948874-21681-6-git-send-email-tharvey@gateworks.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3630ba30-eb18-0829-7b0c-f0a786232969@xs4all.nl>
Date: Tue, 6 Feb 2018 21:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1517948874-21681-6-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNSWjbEAm7Gq+UQ4isp+swmT3UEh+0ueo7elNYn6oJ3DQRd1LwHFN42pAmL+/2k9daaHABz8im9KeSTayqqas6TO1c/2Zyy5QeNVMELR4ay6D4IYENmJ
 NczFzvzxEiicAjKLOGEI0u8h7C2XRJXaIAglKV5kzSZ9Sgm8G1VLpSC3o8Z2VdWRUK2o448lDBA/0tHu0L6RmF5AylEvj9IV6Gkxue2ngXg4PPgXci1+m5Jf
 v7TGKt0gPhHiiQ6xo8jWQEo1h84hM7cBK4FaAWVvtlTBipAVlmwMuCWHVq9x8ybOo5bAo2occzelOz5HKVGNvhbBQHQ1TvPjrb/jpfgZ0q5VOZGZiTdU+bFA
 O4Xkj6IKLcXIniDVfI566DWRSCtx1pJEjm6XsTmqhRl+0RsbmFRnRRnHcUjjbUja323efgSDZDFbMMbybXvR4NMif19N1rDFp3ayEJi3kh1V5j+VR1xKkSM7
 y637RZQwFHmiO2NZ
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 09:27 PM, Tim Harvey wrote:
> Add support for the TDA1997x HDMI receivers.
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---

<snip>

> +static int tda1997x_get_dv_timings_cap(struct v4l2_subdev *sd,
> +				       struct v4l2_dv_timings_cap *cap)
> +{
> +	if (cap->pad != TDA1997X_PAD_SOURCE)
> +		return -EINVAL;
> +
> +	*cap = tda1997x_dv_timings_cap;
> +	return 0;
> +}
> +
> +static int tda1997x_enum_dv_timings(struct v4l2_subdev *sd,
> +				    struct v4l2_enum_dv_timings *timings)
> +{
> +	if (timings->pad != TDA1997X_PAD_SOURCE)
> +		return -EINVAL;
> +
> +	return v4l2_enum_dv_timings_cap(timings, &tda1997x_dv_timings_cap,
> +					NULL, NULL);
> +}

You shouldn't need this pad test: it's done in the v4l2-subdev.c core code
already. But please double-check :-)

Can you post the output of the v4l2-compliance test? I'm curious to see it.

Can you also try to run v4l2-compliance -m /dev/mediaX? That also tests
whether the right entity types are set (note: testing for that should
also happen in the subdev compliance test, but I haven't done that yet).

Regards,

	Hans
