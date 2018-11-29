Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB849C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B920205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B920205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeK2UFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:05:53 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:37169 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbeK2UFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:05:52 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id SIC4gFfNREPjOSIC7gkzBX; Thu, 29 Nov 2018 10:01:12 +0100
Subject: Re: [PATCH] media: videodev2: add V4L2_FMT_FLAG_NO_SOURCE_CHANGE
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181004133739.19086-1-mjourdan@baylibre.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <491c3f33-b51b-89cb-09f0-b48949d61efb@xs4all.nl>
Date:   Thu, 29 Nov 2018 10:01:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181004133739.19086-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDatgp1e02SqPxY3jKkTQoUxDdeXMe05tle6zCjBPDM6HHLD/Qi0zdD+bAkuxUWlwW1bIEmJ02skJRXyEx41R8suCUJRqITaRmUrz0qk1z0c1bDhkRs7
 A6hREMjNpoxxphmYExJcKtlVUurZdqtEJEzp5rKTtKxL9o/tpOeFz3+ka3e4aJz/XNqT7laFeBqC1uIjkt76lKnSAVyyD+7QAeT1eSfUF0vaL/+l5Fvgc/95
 2nVit+FG4WpjosY0MHkglBKCoBf5fm4R2gIh8bqXFqWoN5ezmkknOOA8ULsfOzIByjYdkSEydNmqBsIIzl60er/GnaejG0Gtx7Zr5P4MVoUEfMpN6D2ktjvJ
 Y46Fx+Bw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 03:37 PM, Maxime Jourdan wrote:
> When a v4l2 driver exposes V4L2_EVENT_SOURCE_CHANGE, some (usually
> OUTPUT) formats may not be able to trigger this event.
> 
> Add a enum_fmt format flag to tag those specific formats.

I think I missed (or forgot) some discussion about this since I have no
idea why this flag is needed. What's the use-case?

Regards,

	Hans

> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  Documentation/media/uapi/v4l/vidioc-enum-fmt.rst | 5 +++++
>  include/uapi/linux/videodev2.h                   | 5 +++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> index 019c513df217..e0040b36ac43 100644
> --- a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> +++ b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> @@ -116,6 +116,11 @@ one until ``EINVAL`` is returned.
>        - This format is not native to the device but emulated through
>  	software (usually libv4l2), where possible try to use a native
>  	format instead for better performance.
> +    * - ``V4L2_FMT_FLAG_NO_SOURCE_CHANGE``
> +      - 0x0004
> +      - The event ``V4L2_EVENT_SOURCE_CHANGE`` is not supported
> +	for this format.
> +
>  
>  
>  Return Value
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 3a65951ca51e..a28acee1cb52 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -723,8 +723,9 @@ struct v4l2_fmtdesc {
>  	__u32		    reserved[4];
>  };
>  
> -#define V4L2_FMT_FLAG_COMPRESSED 0x0001
> -#define V4L2_FMT_FLAG_EMULATED   0x0002
> +#define V4L2_FMT_FLAG_COMPRESSED	0x0001
> +#define V4L2_FMT_FLAG_EMULATED		0x0002
> +#define V4L2_FMT_FLAG_NO_SOURCE_CHANGE	0x0004
>  
>  	/* Frame Size and frame rate enumeration */
>  /*
> 

