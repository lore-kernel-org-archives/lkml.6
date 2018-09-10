Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8325CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A55720866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A55720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeIJOik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:38:40 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:44114 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727593AbeIJOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:38:40 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id zIl1f1ZTzw2L8zIl4fJeex; Mon, 10 Sep 2018 11:45:26 +0200
Subject: Re: [PATCH v9 2/9] media: v4l: Add definitions for MPEG-2 slice
 format and metadata
To:     Paul Kocialkowski <contact@paulk.fr>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-3-contact@paulk.fr>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3133cebf-2980-8f3d-4900-f410d4a704fc@xs4all.nl>
Date:   Mon, 10 Sep 2018 11:45:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180906222442.14825-3-contact@paulk.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJrgI5WEXjb/hGCCGQ5VpAQYRlRsWpzAudLuUa/gGcYD8ZehGem15zuT9WDWatBCkMSz77u3EtUknM1jrXSOTd3YQGQmPDZsvHeaVWzX0Lx3CG5LKWON
 sqwH/s1wN2qeXZGA/Ec0gzqhUHCc515YPHXn2rvpkHJuMCHp78JnJ5adOetbeuTS0wGQ9sw7vXVVDK9IMyO+K38F2NBSYvGQGUqFyv/nD4B/6ERpt+aRoyyL
 lmSOj9Nj6SMZNTZcQnITKz6bXiKUmsKQVS2rIe9vhh4BjUTq+/LUqwXycU9cvBzmX2iq6WcZFN2Ech0tPXxGHo1pfA1Jw6RMxPf41Lo1EgVoSKIIGv81W4b2
 lXGcM7oOgl4Pxzg5+Xf2U6e7d+MgBg7oCnHVIqrLNtli/9T0qwG+wOTO2HPqgh2VTOFd9+g2uGJVERybdRPQu2g+3ysBgwfcwFoyp9juwvGcjwThpDwaapV1
 xsH3+Dr5+gZrVFiOzYj3Wh3rm+v7fWgRPe8oN6/cqqIb0Sn8WUtPtkS3I11felIF3nhxmCGABlU2GmQ6MftLMejIBmw6aK7tU/KEv3+zXSSWPOd+xPkhPiH7
 vp/7b7Ue0nK1bQ0aRLYCiSBTUq7DZD8zrElK3UEaWXuEwr086CJD6kMkfIF9cOGibaejoGWt7N1DxwRAzBhwE4+ze96LvtvHD+v6nnNGz0HUDMykZCT8SwOG
 rBh8HpCt0xVptl9XwnWryJiqmWcO44p1TSYGLNwRexDqw9fqSpNRhAAY/iasCmjJ1Di4oPtDjzIFb6aefSbjJ1tzK5ACBVTvobJ+Fi96GV93KtnqwrjL5zH3
 qP6WUxzhLtaXM7cEkG+B3aeuTyHQxxC1aaGkIfcdXheGKitpNw0iHhX6nws0I1tHPdy97uJZZ/mYwABV6f/3tCyh6Yg9afakY2wD19hhJgZPECz05JnQE8ro
 ISb/Ag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Stateless video decoding engines require both the MPEG-2 slices and
> associated metadata from the video stream in order to decode frames.
> 
> This introduces definitions for a new pixel format, describing buffers
> with MPEG-2 slice data, as well as control structure sfor passing the
> frame metadata to drivers.
> 
> This is based on work from both Florent Revest and Hugues Fruchet.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/uapi/v4l/extended-controls.rst      | 176 ++++++++++++++++++
>  .../media/uapi/v4l/pixfmt-compressed.rst      |  16 ++
>  .../media/uapi/v4l/vidioc-queryctrl.rst       |  14 +-
>  .../media/videodev2.h.rst.exceptions          |   2 +
>  drivers/media/v4l2-core/v4l2-ctrls.c          |  63 +++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
>  include/media/v4l2-ctrls.h                    |  18 +-
>  include/uapi/linux/v4l2-controls.h            |  65 +++++++
>  include/uapi/linux/videodev2.h                |   5 +
>  9 files changed, 351 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
> index 9f7312bf3365..f1951236266a 100644
> --- a/Documentation/media/uapi/v4l/extended-controls.rst
> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
> @@ -1497,6 +1497,182 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>  
>  
>  
> +.. _v4l2-mpeg-mpeg2:
> +
> +``V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS (struct)``
> +    Specifies the slice parameters (as extracted from the bitstream) for the
> +    associated MPEG-2 slice data. This includes the necessary parameters for
> +    configuring a stateless hardware decoding pipeline for MPEG-2.
> +    The bitstream parameters are defined according to :ref:`mpeg2part2`.
> +
> +.. c:type:: v4l2_ctrl_mpeg2_slice_params
> +
> +.. cssclass:: longtable
> +
> +.. flat-table:: struct v4l2_ctrl_mpeg2_slice_params
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u32
> +      - ``bit_size``
> +      - Size (in bits) of the current slice data.
> +    * - __u32
> +      - ``data_bit_offset``
> +      - Offset (in bits) to the video data in the current slice data.
> +    * - struct :c:type:`v4l2_mpeg2_sequence`
> +      - ``sequence``
> +      - Structure with MPEG-2 sequence metadata, merging relevant fields from
> +	the sequence header and sequence extension parts of the bitstream.
> +    * - struct :c:type:`v4l2_mpeg2_picture`
> +      - ``picture``
> +      - Structure with MPEG-2 picture metadata, merging relevant fields from
> +	the picture header and picture coding extension parts of the bitstream.
> +    * - __u8
> +      - ``quantiser_scale_code``
> +      - Code used to determine the quantization scale to use for the IDCT.
> +    * - __u8
> +      - ``backward_ref_index``
> +      - Index for the V4L2 buffer to use as backward reference, used with
> +	B-coded and P-coded frames.
> +    * - __u8
> +      - ``forward_ref_index``
> +      - Index for the V4L2 buffer to use as forward reference, used with
> +	P-coded frames.

Do these indices refer to the output or capture buffers? I think these should
refer to the output buffers, since this control is used in a request for the
output side.

Regards,

	Hans
