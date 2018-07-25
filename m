Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66706C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1137620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0ClC0yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1137620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeGYOSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:18:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36122 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeGYOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:18:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so5987397wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gcsClBRRiXUqYDPGcBQWWMk+E+cwvJgq+KRYvdlkbbM=;
        b=G0ClC0yfI21W1l7mJb9iFXkFoUD1YpbXLHKZ028h6wLHbfidTttV5Nml7kSeXIwQ7O
         hNhbp9R0KjTuPMlbVtwU8eIWbnepmH4ow7t4nSgU/B8z5xEOkekT2shiuXvUcBx8vCnn
         QnqIQOiPI6M1kQSw8lxC2isH7aTCk7xpdqm3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gcsClBRRiXUqYDPGcBQWWMk+E+cwvJgq+KRYvdlkbbM=;
        b=j/+YgY/iZB9cMQ9wCWARF8nTjH95QUaAjxAZFP5z816BPQiSJzk/LyYEZZ9x7j8DIG
         8gBaR2NLxPX8PKt8lhAB+OvKiICAqKhAhRiufkEuBjMHfuuiHRMnirjfOaRhP7w8ayXE
         wp+rcX35Op6ntlIa4sR4cgwy8asyBbIh3QniQLN0L8xXbrJ+q26jvY7fhQTvKKEpWCs0
         iEcVATY2KyNg9laFwIQKF3MIt1oozO8raNJKxtqFBk5vl402jjJ6ZiO5q2Y+LeZq5r6P
         tlejrSILhrJ2JQ9XYKd3O6sNyujvw1/wRR8BW5IvLsxCSYtw8vdSzZuEp21rJdxon2oO
         NFKQ==
X-Gm-Message-State: AOUpUlFiIwyN1dU8LuO6qyiFsHkl/x7pgxqDSVUAGBtpHLOBj/rZbQaf
        9BHD/6X/ltHU8TbGOKGcxfIxC4nmclg=
X-Google-Smtp-Source: AAOMgpcCThHSbo4ONew0dh5vZ+5mZXlIXE/ErP9133gBHwmloWPRVXfE5JIa84CGJ4LkaJWx+sUS5w==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr4491370wmh.34.1532523992070;
        Wed, 25 Jul 2018 06:06:32 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id i205-v6sm7176147wmf.30.2018.07.25.06.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 06:06:31 -0700 (PDT)
Subject: Re: [PATCH v3 35/35] media: v4l2-ioctl: Add format descriptions for
 packed Bayer raw14 pixel formats
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
 <1532343772-27382-36-git-send-email-todor.tomov@linaro.org>
 <20180724125243.jigwhde5rmifctyd@paasikivi.fi.intel.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <82cc13db-fb95-384c-1ba1-7608def83722@linaro.org>
Date:   Wed, 25 Jul 2018 16:06:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180724125243.jigwhde5rmifctyd@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thanks for review.

On 24.07.2018 15:52, Sakari Ailus wrote:
> Hi Todor,
> 
> On Mon, Jul 23, 2018 at 02:02:52PM +0300, Todor Tomov wrote:
>> This removes warning "Unknown pixelformat" for the following formats:
>>         V4L2_PIX_FMT_SBGGR14P
>>         V4L2_PIX_FMT_SGBRG14P
>>         V4L2_PIX_FMT_SGRBG14P
>>         V4L2_PIX_FMT_SRGGB14P
>>
>> CC: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
>> ---
>>  drivers/media/v4l2-core/v4l2-ioctl.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index 2e3b1f0..e8f7c89 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1260,6 +1260,10 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>  	case V4L2_PIX_FMT_SGBRG12P:	descr = "12-bit Bayer GBGB/RGRG Packed"; break;
>>  	case V4L2_PIX_FMT_SGRBG12P:	descr = "12-bit Bayer GRGR/BGBG Packed"; break;
>>  	case V4L2_PIX_FMT_SRGGB12P:	descr = "12-bit Bayer RGRG/GBGB Packed"; break;
>> +	case V4L2_PIX_FMT_SBGGR14P:	descr = "14-bit Bayer BGBG/GRGR Packed"; break;
>> +	case V4L2_PIX_FMT_SGBRG14P:	descr = "14-bit Bayer GBGB/RGRG Packed"; break;
>> +	case V4L2_PIX_FMT_SGRBG14P:	descr = "14-bit Bayer GRGR/BGBG Packed"; break;
>> +	case V4L2_PIX_FMT_SRGGB14P:	descr = "14-bit Bayer RGRG/GBGB Packed"; break;
>>  	case V4L2_PIX_FMT_SBGGR16:	descr = "16-bit Bayer BGBG/GRGR"; break;
>>  	case V4L2_PIX_FMT_SGBRG16:	descr = "16-bit Bayer GBGB/RGRG"; break;
>>  	case V4L2_PIX_FMT_SGRBG16:	descr = "16-bit Bayer GRGR/BGBG"; break;
> 
> You could merge this to the patch that adds the format definitions. Or:

Yes. I think we are going to have v4 so I will merge it with the patch which adds
the format definitions.

> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> And preferrably move it to earlier in the patchset where new formats are
> added.
> 

-- 
Best regards,
Todor Tomov
