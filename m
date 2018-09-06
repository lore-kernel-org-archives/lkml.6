Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B21AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2090320659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2090320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIFL4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:56:37 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:51135 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbeIFL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:56:36 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id xocWfLcmYxO9BxocZf3zih; Thu, 06 Sep 2018 09:22:32 +0200
Subject: Re: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Paul Kocialkowski <contact@paulk.fr>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-sunxi@googlegroups.com
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-5-paul.kocialkowski@bootlin.com>
 <5faf5eed-eb2c-f804-93e3-5a42f6204d99@xs4all.nl>
 <b7b3cb2320978d45acb34475d15abd7bf03da367.camel@paulk.fr>
 <461c6a0d-a346-b9da-b75e-4aab907054df@xs4all.nl>
Message-ID: <890469f8-434f-4ca1-ec95-20542610fd78@xs4all.nl>
Date:   Thu, 6 Sep 2018 09:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <461c6a0d-a346-b9da-b75e-4aab907054df@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCT1FxqL86hj96ymA3J4QeQdem3Ugbk5x7JBQkFre3JmZx8fu2o99dz3IiXiFK45AvtRKp+KOFtmMRbTXBnsu1tbJtjlnIiAbiOm5EDKwKjIHuAa3C4g
 lo4EsKyDQKXuyMKzF6evmpuckDFiBl9J+7Mmi0lH7nI/U5z6MnNiiZ5d4lrrF0q9yX6tZhisIW0UoZmLuNOpjNrlaCvOW+x6YN/Lu3nDZ8setJqGjOXoh4u0
 Mn82u+/c2XMxtGxFBVaIjk+iBvOzf2LvLdZuzUAF0vHrQWTYugahLCzyY7c7Dbj+u9Kk1oXNM8SCSLprPmOKlPti71e/fbxN5fxhu+D+wNyQXCZ62nEijAFo
 xecnjYj1djjvjSfCboG845ra8/LPTO3g1GmjJgqwhodPltkba9eRYQ9D8pErQV30asktAPJOtnPUuUAWyhXapmPaxxLQGzLmDfRhf9SdlPDj4GxKORXPrZi6
 R5abVTZY2JEqHF2cHobtyIZZfTW9w51JjQMFeJGRQVqyVXP/PGSLHfattfDPuXen2zNmSBte68JFVtAqfH9xX85nkMeAaoJqAxHIfKLcYlFw1DV3wPcQIuzy
 guSX1/KgnUAEujLPADROAdvQSJ2o1opGekSK+8e3Yb6WDl9jZmEfsHzS2wa7fsfT8pH85RAze27S8TKBfm0t4ExuhgMLF6rFgOnAooTxnRLtP2qi2xe+JcKy
 DFXJh7YqHi7OppFm8NWE4QPD/2NDbA+t6iEt9WcbNNFqu2KClYkKriNlWMlcwz9QW/s4KDDI4e0BiwSskwJrG19JB6Lmr9cNS+g3t0k6ZHWgY+HmLsn6860k
 LsUnKOD7GA5alBkoulms36UAkksdqQQVLMZdxpn9nCrb8+CGRLULrpoBVwgSuq0wCJvNJsiAsa7RP5JlJ38=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 09:01 AM, Hans Verkuil wrote:
> On 09/05/2018 06:29 PM, Paul Kocialkowski wrote:
>> Hi and thanks for the review!
>>
>> Le lundi 03 septembre 2018 à 11:11 +0200, Hans Verkuil a écrit :
>>> On 08/28/2018 09:34 AM, Paul Kocialkowski wrote:
>>>> +static int cedrus_queue_setup(struct vb2_queue *vq, unsigned int *nbufs,
>>>> +			      unsigned int *nplanes, unsigned int sizes[],
>>>> +			      struct device *alloc_devs[])
>>>> +{
>>>> +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
>>>> +	struct cedrus_dev *dev = ctx->dev;
>>>> +	struct v4l2_pix_format_mplane *mplane_fmt;
>>>> +	struct cedrus_format *fmt;
>>>> +	unsigned int i;
>>>> +
>>>> +	switch (vq->type) {
>>>> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>>> +		mplane_fmt = &ctx->src_fmt;
>>>> +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
>>>> +					 CEDRUS_DECODE_SRC,
>>>> +					 dev->capabilities);
>>>> +		break;
>>>> +
>>>> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>>> +		mplane_fmt = &ctx->dst_fmt;
>>>> +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
>>>> +					 CEDRUS_DECODE_DST,
>>>> +					 dev->capabilities);
>>>> +		break;
>>>> +
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (!fmt)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (fmt->num_buffers == 1) {
>>>> +		sizes[0] = 0;
>>>> +
>>>> +		for (i = 0; i < fmt->num_planes; i++)
>>>> +			sizes[0] += mplane_fmt->plane_fmt[i].sizeimage;
>>>> +	} else if (fmt->num_buffers == fmt->num_planes) {
>>>> +		for (i = 0; i < fmt->num_planes; i++)
>>>> +			sizes[i] = mplane_fmt->plane_fmt[i].sizeimage;
>>>> +	} else {
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	*nplanes = fmt->num_buffers;
>>>
>>> This code does not take VIDIOC_CREATE_BUFFERS into account.
>>>
>>> If it is called from that ioctl, then *nplanes is non-zero and you need
>>> to check if *nplanes equals fmt->num_buffers and that sizes[n] is >=
>>> the required size of the format. If so, then return 0, otherwise return
>>> -EINVAL.
>>
>> Thanks for spotting this, I'll fix it as you suggested in the next
>> revision.
>>
>>> Doesn't v4l2-compliance fail on that? Or is that test skipped because this
>>> is a decoder for which streaming is not supported (yet)?
>>
>> Apparently, v4l2-compliance doesn't fail since I'm getting:
>> test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 
> It is tested, but only with the -s option. I'll see if I can improve the
> tests.

I've improved the tests. v4l2-compliance should now fail when run (without the
-s option) against this driver. Can you check that that is indeed the case?

Thanks!

	Hans
