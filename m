Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SIc2EDM9GluhPgAAmS7hNA
	; Fri, 08 Jun 2018 08:24:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B0075607A4; Fri,  8 Jun 2018 08:24:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxU/TqD+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 074C260590;
	Fri,  8 Jun 2018 08:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 074C260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeFHIYf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:24:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40279 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeFHITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so1977750wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WnGFrXGohf0ssxHUMuNfANuj6m/SGPG3Sv41IxnMLmE=;
        b=XxU/TqD+6a71OdYQ/BQoEw6GK/Q01LBCBuNxAjvC20j3zeQdeVLqCNBEXKibDCyrwU
         lS334kZY065SXpvhgbQLvjfbLgqv45gqLCtl4ZQXgd0jMi9CTwXYiPESncU/lfLU+Knd
         bnCsCrEMgVbEZiYPBzOTAD+wFbjy3GbOmaau4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WnGFrXGohf0ssxHUMuNfANuj6m/SGPG3Sv41IxnMLmE=;
        b=YKqtO4UjLk8NtwhzOAOwnEM3ta3CILhTRQ914nvz4JAlzXwRrKe3XtC+paVDWivHAH
         hF26lWSMEkbTF4afDTFez0m4+Fojs/AyqD5+GaX7OoIwfJzr3LYOXRHXMqrjriP6QrH3
         zs3COhA9GHS2xbbMz+Ul1v9uzKapkvsqrVcnMGS/+EhdJ49aiKPpYejMjr2V95bOP0tf
         TmB1LpVmA/sDIDyjGgMBeJKBEDogP+Sy/PZkaaXFDJdjFliXEAdXXd8wtU1RP7Uzkj6A
         4H7YpC3gKMVR/WK/AbMAQOZr+6Wdox2Bgt9zz2B2T68MgrOiEmIIEEb+j1nKYbMVb5yB
         CmRA==
X-Gm-Message-State: APt69E28x4HneYhZuartbDOwKY6R3N0KUyvee/c7Rpp8SN6215I3gceQ
        BYVuu18QB8GredXy7OhzGmRUQfWXTsM=
X-Google-Smtp-Source: ADUXVKLNsc04ydVt+Zs7EoIv4JWjmMukla3XfEFm8royaVzirTPOWlXE036klV6oA1t0lVqusgUHfw==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr750394wmi.21.1528445962398;
        Fri, 08 Jun 2018 01:19:22 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id m16-v6sm21481717wro.91.2018.06.08.01.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 01:19:21 -0700 (PDT)
Subject: Re: [PATCH v2] media: v4l: Add new 10-bit packed grayscale format
To: Hans Verkuil <hverkuil@xs4all.nl>
References: <1525769177-6328-1-git-send-email-todor.tomov@linaro.org>
 <6411f254-cc4f-43b2-868f-bcf2d6e6f0eb@xs4all.nl>
From: Todor Tomov <todor.tomov@linaro.org>
Cc: sakari.ailus@iki.fi, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <3b9e09b1-462f-509e-e2e3-06ede47331a1@linaro.org>
Date: Fri, 8 Jun 2018 11:19:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6411f254-cc4f-43b2-868f-bcf2d6e6f0eb@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On  8.06.2018 11:13, Hans Verkuil wrote:
> On 05/08/2018 10:46 AM, Todor Tomov wrote:
>> The new format will be called V4L2_PIX_FMT_Y10P.
>> It is similar to the V4L2_PIX_FMT_SBGGR10P family formats
>> but V4L2_PIX_FMT_Y10P is a grayscale format.
>>
>> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> 
> I see no patch adding support for this to a driver. We don't like adding new
> defines without a driver that needs it.
> 
> Is it possible to add support for this to a mainlined driver? Or is it going to
> be used by a new driver?

This will be used by a new version of the QComm CAMSS driver. I wanted to get it
reviewed first.
If it is ok, you could take it when the new QComm CAMSS is posted and accepted.

Best regards,
Todor

> 
> Regards,
> 
> 	Hans
> 
>> ---
>>
>> v2:
>> - doc: improved bit-packed representation: added bit positions for LSB bits;
>> - doc: improved bit-packed representation: added table column widths.
>>
>>  Documentation/media/uapi/v4l/pixfmt-y10p.rst | 33 ++++++++++++++++++++++++++++
>>  Documentation/media/uapi/v4l/yuv-formats.rst |  1 +
>>  drivers/media/v4l2-core/v4l2-ioctl.c         |  1 +
>>  include/uapi/linux/videodev2.h               |  1 +
>>  4 files changed, 36 insertions(+)
>>  create mode 100644 Documentation/media/uapi/v4l/pixfmt-y10p.rst
>>
>> diff --git a/Documentation/media/uapi/v4l/pixfmt-y10p.rst b/Documentation/media/uapi/v4l/pixfmt-y10p.rst
>> new file mode 100644
>> index 0000000..13b5713
>> --- /dev/null
>> +++ b/Documentation/media/uapi/v4l/pixfmt-y10p.rst
>> @@ -0,0 +1,33 @@
>> +.. -*- coding: utf-8; mode: rst -*-
>> +
>> +.. _V4L2-PIX-FMT-Y10P:
>> +
>> +******************************
>> +V4L2_PIX_FMT_Y10P ('Y10P')
>> +******************************
>> +
>> +Grey-scale image as a MIPI RAW10 packed array
>> +
>> +
>> +Description
>> +===========
>> +
>> +This is a packed grey-scale image format with a depth of 10 bits per
>> +pixel. Every four consecutive pixels are packed into 5 bytes. Each of
>> +the first 4 bytes contain the 8 high order bits of the pixels, and
>> +the 5th byte contains the 2 least significants bits of each pixel,
>> +in the same order.
>> +
>> +**Bit-packed representation.**
>> +
>> +.. flat-table::
>> +    :header-rows:  0
>> +    :stub-columns: 0
>> +    :widths: 8 8 8 8 64
>> +
>> +    * - Y'\ :sub:`00[9:2]`
>> +      - Y'\ :sub:`01[9:2]`
>> +      - Y'\ :sub:`02[9:2]`
>> +      - Y'\ :sub:`03[9:2]`
>> +      - Y'\ :sub:`03[1:0]`\ (bits 7--6) Y'\ :sub:`02[1:0]`\ (bits 5--4)
>> +	Y'\ :sub:`01[1:0]`\ (bits 3--2) Y'\ :sub:`00[1:0]`\ (bits 1--0)
>> diff --git a/Documentation/media/uapi/v4l/yuv-formats.rst b/Documentation/media/uapi/v4l/yuv-formats.rst
>> index 3334ea4..9ab0592 100644
>> --- a/Documentation/media/uapi/v4l/yuv-formats.rst
>> +++ b/Documentation/media/uapi/v4l/yuv-formats.rst
>> @@ -29,6 +29,7 @@ to brightness information.
>>      pixfmt-y10
>>      pixfmt-y12
>>      pixfmt-y10b
>> +    pixfmt-y10p
>>      pixfmt-y16
>>      pixfmt-y16-be
>>      pixfmt-y8i
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index de5d96d..dececea 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1147,6 +1147,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>  	case V4L2_PIX_FMT_Y16:		descr = "16-bit Greyscale"; break;
>>  	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
>>  	case V4L2_PIX_FMT_Y10BPACK:	descr = "10-bit Greyscale (Packed)"; break;
>> +	case V4L2_PIX_FMT_Y10P:		descr = "10-bit Greyscale (MIPI Packed)"; break;
>>  	case V4L2_PIX_FMT_Y8I:		descr = "Interleaved 8-bit Greyscale"; break;
>>  	case V4L2_PIX_FMT_Y12I:		descr = "Interleaved 12-bit Greyscale"; break;
>>  	case V4L2_PIX_FMT_Z16:		descr = "16-bit Depth"; break;
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 600877b..b24ab720 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -522,6 +522,7 @@ struct v4l2_pix_format {
>>  
>>  /* Grey bit-packed formats */
>>  #define V4L2_PIX_FMT_Y10BPACK    v4l2_fourcc('Y', '1', '0', 'B') /* 10  Greyscale bit-packed */
>> +#define V4L2_PIX_FMT_Y10P    v4l2_fourcc('Y', '1', '0', 'P') /* 10  Greyscale, MIPI RAW10 packed */
>>  
>>  /* Palette formats */
>>  #define V4L2_PIX_FMT_PAL8    v4l2_fourcc('P', 'A', 'L', '8') /*  8  8-bit palette */
>>
> 
