Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5EBFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD96D20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD96D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbeG3O1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:27:32 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:49945 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729104AbeG3O1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:27:31 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id k7f6f1WV8EJtck7fAfgCgf; Mon, 30 Jul 2018 14:52:39 +0200
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        ezequiel@collabora.com
References: <20180724140621.59624-1-tfiga@chromium.org>
 <20180724140621.59624-2-tfiga@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <318f609c-7a28-ef65-e8be-08107981b623@xs4all.nl>
Date:   Mon, 30 Jul 2018 14:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180724140621.59624-2-tfiga@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHzjWc9vR084+TvcnSBlabLweQhy4aYCOpkGPhUh3Rg+upH9VWkYf7kZspZluhakfxf8Tp9eBpbqsJwo10FnyqT8QNth2Q1B9HeP+pEYqu/22Q4uZYKD
 fpEqYOeHWJj4AZ+XKxH8/W9RLX3RLyihCmGca7YY2tqvdEU9CJTuDf2sGhNSdu4Fvf50sxVM5MYssIYvFUMIJo/DQBg5YjY7ZuJhogwR3HfXmKa8e0aClQOp
 DoUsTH7y/lw/u7cuXe5Cr98uz4t2myPnc8zw2dhP6+Qz9zxU8rpSRdmZ6g7I3xh7h1xBcEtLls6B9Mz5V+SFSrZb/MXmGz0VD4gFkBxXS/cLyH2UfCU5BHxS
 MpMN2SZH9upxDzadCfbblxfGEtbyIlFeoApfiuv4wxLhYETMkJgHPfujp2Nn4BBbzPqoAIpXgtFNDb6TKSyAVI5QiJbtBcCulijA1O9z3AVviq4tzY3MUy68
 i8t+fPzGxEeDYLqD+6NfSfRpkR39uTZSMoVicFMlm+yvPhBi6HtdIH08ZbOk5sXVmDtfgI3mjbRoGpwdb+uqNyZJ1OPklYZIjTpkGb9vg8EODJIkgot2WfA8
 rN47VPerpCYBIcy/Fczby1Wbay4JCCJyMdhBLxiizxfOoA9eSUDZl++WS0x4drYjtWLOuWi3kgPLa5LvbXI1eYlkpW16BzzbvwnNS/1SOiwreSi6SFg3TH6y
 ZC5F7kMbw6I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 04:06 PM, Tomasz Figa wrote:
> Due to complexity of the video decoding process, the V4L2 drivers of
> stateful decoder hardware require specific sequences of V4L2 API calls
> to be followed. These include capability enumeration, initialization,
> decoding, seek, pause, dynamic resolution change, drain and end of
> stream.
> 
> Specifics of the above have been discussed during Media Workshops at
> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
> originated at those events was later implemented by the drivers we already
> have merged in mainline, such as s5p-mfc or coda.
> 
> The only thing missing was the real specification included as a part of
> Linux Media documentation. Fix it now and document the decoder part of
> the Codec API.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  Documentation/media/uapi/v4l/dev-decoder.rst | 872 +++++++++++++++++++
>  Documentation/media/uapi/v4l/devices.rst     |   1 +
>  Documentation/media/uapi/v4l/v4l2.rst        |  10 +-
>  3 files changed, 882 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> 
> diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentation/media/uapi/v4l/dev-decoder.rst
> new file mode 100644
> index 000000000000..f55d34d2f860
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
> @@ -0,0 +1,872 @@

<snip>

> +6.  This step only applies to coded formats that contain resolution
> +    information in the stream. Continue queuing/dequeuing bitstream
> +    buffers to/from the ``OUTPUT`` queue via :c:func:`VIDIOC_QBUF` and
> +    :c:func:`VIDIOC_DQBUF`. The driver must keep processing and returning
> +    each buffer to the client until required metadata to configure the
> +    ``CAPTURE`` queue are found. This is indicated by the driver sending
> +    a ``V4L2_EVENT_SOURCE_CHANGE`` event with
> +    ``V4L2_EVENT_SRC_CH_RESOLUTION`` source change type. There is no
> +    requirement to pass enough data for this to occur in the first buffer
> +    and the driver must be able to process any number.
> +
> +    * If data in a buffer that triggers the event is required to decode
> +      the first frame, the driver must not return it to the client,
> +      but must retain it for further decoding.
> +
> +    * If the client set width and height of ``OUTPUT`` format to 0, calling
> +      :c:func:`VIDIOC_G_FMT` on the ``CAPTURE`` queue will return -EPERM,
> +      until the driver configures ``CAPTURE`` format according to stream
> +      metadata.

What about calling TRY/S_FMT on the capture queue: will this also return -EPERM?
I assume so.

Regards,

	Hans
