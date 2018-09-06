Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FBEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570972077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570972077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIFLfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:35:10 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:49088 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbeIFLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:35:09 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id xoHlfLObCxO9BxoHpf3tHZ; Thu, 06 Sep 2018 09:01:08 +0200
Subject: Re: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
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
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <461c6a0d-a346-b9da-b75e-4aab907054df@xs4all.nl>
Date:   Thu, 6 Sep 2018 09:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <b7b3cb2320978d45acb34475d15abd7bf03da367.camel@paulk.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfN1+h3UOvqZbrarh9UhH8Bfv69s5kMqmDcqkLJ1ycrLl1/38jMEi6GdRVCGa/hiIzqnltppzSEH1zZxcf8U+wDJ0AVG0qXh088G+2jB+lP1graTZrYo9
 4LyA1vMz6tJpDuU+ElTbLkVbw7LTQ8x6iRA44Utb2cKIooluYBR3hyNmg3vWPGB/sB0xLnhi23CVg6wDrXsruoFhTbtrC3hxAKaLefcrzKXDYYwqels1C64s
 SsCml7CY5MeDNv5Nvv879q8d9NPOHUkSLILJuox+Tot7i4p60NCu2v3eAF9nh/+6yWptgFRmG4b0vOVokBWKHitgoUjqZqCZ7JMLXM2rWcM8I7kpKoaG4SLn
 knhLDsy6pypTzdvX1RsuoyPlGRTBdGvm1b2R5G07DZue6c/YZaCKr8IWJxnjXWiYn7qe9rtSUmhivJuwaFLQe3HSE7yZXHuw7Q+jpWOYkDnkNWENn1sZ9u1Y
 3+KZOALSbHOiR81wiat+DqFksCcTZN8EEYB+yTTuG4sw/QPyBfiMBGFNj37ZoYe12M58AFHsw5aZUFlzxvScEIzzgWeJlW4I95lwiKO228wM8pDV/V1CSSAq
 uf4Ezr18AstDqKliXhPs8MihmP9El5/dHGXTAtKayvp6ucnFMCVWJzAzeAUBFIuIsumIVpUJFCdxUxlvbXhz9ZHyba+oBBKTqI+QwG94DbR+slD6Xl2nwghF
 ebQP87t+z1uhvxKdmeaQyTgsJAUu54YJgKtvIDJ4mlH3mDF4zR5fW+sKZYYYdZGT/6LYehI9rCofY5c+rJ/TR8g7c2UUx5iLQFAQ7W7sPTeku7fH3IB8XyZM
 5gdJxEuIvNjFblb7roB2YVFBQQpbeBc0vcAlErM9/1pt/G3IsbL8L1/9P/IGvoUAwTMOGxMkl03B9+XKV7k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 06:29 PM, Paul Kocialkowski wrote:
> Hi and thanks for the review!
> 
> Le lundi 03 septembre 2018 à 11:11 +0200, Hans Verkuil a écrit :
>> On 08/28/2018 09:34 AM, Paul Kocialkowski wrote:
>>> +static int cedrus_request_validate(struct media_request *req)
>>> +{
>>> +	struct media_request_object *obj, *obj_safe;
>>> +	struct v4l2_ctrl_handler *parent_hdl, *hdl;
>>> +	struct cedrus_ctx *ctx = NULL;
>>> +	struct v4l2_ctrl *ctrl_test;
>>> +	unsigned int i;
>>> +
>>> +	list_for_each_entry_safe(obj, obj_safe, &req->objects, list) {
>>
>> You don't need to use the _safe variant during validation.
> 
> Okay, I'll use the regular one then.
> 
>>> +		struct vb2_buffer *vb;
>>> +
>>> +		if (vb2_request_object_is_buffer(obj)) {
>>> +			vb = container_of(obj, struct vb2_buffer, req_obj);
>>> +			ctx = vb2_get_drv_priv(vb->vb2_queue);
>>> +
>>> +			break;
>>> +		}
>>> +	}
>>
>> Interesting question: what happens if more than one buffer is queued in the
>> request? This is allowed by the request API and in that case the associated
>> controls in the request apply to all queued buffers.
>>
>> Would this make sense at all for this driver? If not, then you need to
>> check here if there is more than one buffer in the request and document in
>> the spec that this is not allowed.
> 
> Well, our driver was written with the (unformal) assumption that we
> only deal with a pair of one output and one capture buffer. So I will
> add a check for this at request validation time and document it in the
> spec. Should that be part of the MPEG-2 PIXFMT documentation (and
> duplicated for future formats we add support for)?

Can you make a patch for vb2_request_has_buffers() in videobuf2-core.c
renaming it to vb2_request_buffer_cnt() and returning the number of buffers
in the request?

Then you can call it here to check that you have only one buffer.

And this has to be documented with the PIXFMT.

Multiple buffers are certainly possible in non-codec scenarios (vim2m and
vivid happily accept that), so this is an exception that should be
documented and checked in the codec driver.

> 
>> If it does make sense, then you need to test this.
>>
>> Again, this can be corrected in a follow-up patch, unless there will be a
>> v9 anyway.
> 
> [...]

>>> +static int cedrus_queue_setup(struct vb2_queue *vq, unsigned int *nbufs,
>>> +			      unsigned int *nplanes, unsigned int sizes[],
>>> +			      struct device *alloc_devs[])
>>> +{
>>> +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
>>> +	struct cedrus_dev *dev = ctx->dev;
>>> +	struct v4l2_pix_format_mplane *mplane_fmt;
>>> +	struct cedrus_format *fmt;
>>> +	unsigned int i;
>>> +
>>> +	switch (vq->type) {
>>> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> +		mplane_fmt = &ctx->src_fmt;
>>> +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
>>> +					 CEDRUS_DECODE_SRC,
>>> +					 dev->capabilities);
>>> +		break;
>>> +
>>> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> +		mplane_fmt = &ctx->dst_fmt;
>>> +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
>>> +					 CEDRUS_DECODE_DST,
>>> +					 dev->capabilities);
>>> +		break;
>>> +
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!fmt)
>>> +		return -EINVAL;
>>> +
>>> +	if (fmt->num_buffers == 1) {
>>> +		sizes[0] = 0;
>>> +
>>> +		for (i = 0; i < fmt->num_planes; i++)
>>> +			sizes[0] += mplane_fmt->plane_fmt[i].sizeimage;
>>> +	} else if (fmt->num_buffers == fmt->num_planes) {
>>> +		for (i = 0; i < fmt->num_planes; i++)
>>> +			sizes[i] = mplane_fmt->plane_fmt[i].sizeimage;
>>> +	} else {
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	*nplanes = fmt->num_buffers;
>>
>> This code does not take VIDIOC_CREATE_BUFFERS into account.
>>
>> If it is called from that ioctl, then *nplanes is non-zero and you need
>> to check if *nplanes equals fmt->num_buffers and that sizes[n] is >=
>> the required size of the format. If so, then return 0, otherwise return
>> -EINVAL.
> 
> Thanks for spotting this, I'll fix it as you suggested in the next
> revision.
> 
>> Doesn't v4l2-compliance fail on that? Or is that test skipped because this
>> is a decoder for which streaming is not supported (yet)?
> 
> Apparently, v4l2-compliance doesn't fail since I'm getting:
> test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK

It is tested, but only with the -s option. I'll see if I can improve the
tests.

Regards,

	Hans
