Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654FCC6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE7C20858
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwgZMslD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE7C20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJIHXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:23:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40895 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:23:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so18138607wro.7;
        Mon, 08 Oct 2018 17:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U+qZdXp5rIust0zYOQ9IP714AHAIjGqeCz9d6utwTqE=;
        b=bwgZMslDYpG/8W1t5GhCKzUgbpFdBSDLyCeOcnNGY5R/BnBfJuQl0OnFmvwX+P9jcv
         sJY8ZRsFGey4TGrJLxxD6nEbrrbZZMkvcuIbginJw3DSckM4BCnVIHRK7kdqQPjsI4Lo
         KFutrnFM0dZU/YKtx8FSu4M8ZydR/vHKe38tRUWJ0JRUt3T2pDkP+KxdpB2Dol8u6TvC
         Zj1PHfLTepKsJEy6b173ASWcIK28BvQ1qlQvvpAtHym+pJRcm3FpOs7kZ2/VyZ14zZhP
         Ay56D6W14KcEhazq/9pbeUTwRmQcLVRtO3SCON9ortpPx54yq7uxnIl53k+U7RWqrj4X
         NN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U+qZdXp5rIust0zYOQ9IP714AHAIjGqeCz9d6utwTqE=;
        b=V29g46EpowxO8dwpoL+pzuSmfaRFU5JRzsDP0SlekjPL0r3nFcxPtsjExV8pyhCTvL
         3ZDgKxpfPe0iohUs9KHDJEkQJL8CnINUsAkS6Uo9UUaEV86Rq5YowIoE8FpBRIGI9qEe
         2Ura8LguBifIJMBVN+pGsLVGJYVmECjNFivQWUKmn4Hy5515jRsHk+6K52tpijHJE6wg
         DYmF+sWYgS4IUV9FqhooQP+LgbgqEo9FA8PuSW42RzfdVf+Pk5zSw/RH9KwibWGXbymI
         q/634f7X53gqlozvNeK0KiTzPB/9/ygW1QieIALBOyvvFcZyyf7ADpUt6Xh1l6h9r0Xd
         MmEQ==
X-Gm-Message-State: ABuFfoiTTpfvWg5/akRQaPi1WdKECupeWNO9mohziQtUiT7WLA0nN6AC
        RI8V+OSMg/Livwm3GyzFIms=
X-Google-Smtp-Source: ACcGV61lB/O1411H01ILN3lGLia6Z7/zW8JwlJ0d2f5mQS5OltkUs2H/qObnid3ZMDcvFQWYBQiKmg==
X-Received: by 2002:adf:e387:: with SMTP id e7-v6mr18271572wrm.94.1539043769571;
        Mon, 08 Oct 2018 17:09:29 -0700 (PDT)
Received: from [172.30.1.166] (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm11478077wmd.4.2018.10.08.17.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 17:09:28 -0700 (PDT)
Subject: Re: [PATCH v4 03/11] gpu: ipu-v3: Add planar support to interlaced
 scan
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
 <20181004185401.15751-4-slongerbeam@gmail.com>
 <1538732937.3545.8.camel@pengutronix.de>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <2f5cbf7c-4a1c-96c2-971c-86a97ae6dbe1@gmail.com>
Date:   Mon, 8 Oct 2018 17:09:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538732937.3545.8.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 02:48 AM, Philipp Zabel wrote:
> On Thu, 2018-10-04 at 11:53 -0700, Steve Longerbeam wrote:
>> To support interlaced scan with planar formats, cpmem SLUV must
>> be programmed with the correct chroma line stride. For full and
>> partial planar 4:2:2 (YUV422P, NV16), chroma line stride must
>> be doubled. For full and partial planar 4:2:0 (YUV420, YVU420, NV12),
>> chroma line stride must _not_ be doubled, since a single chroma line
>> is shared by two luma lines.
>>
>> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
>> ---
>>   drivers/gpu/ipu-v3/ipu-cpmem.c              | 26 +++++++++++++++++++--
>>   drivers/staging/media/imx/imx-ic-prpencvf.c |  3 ++-
>>   drivers/staging/media/imx/imx-media-csi.c   |  3 ++-
>>   include/video/imx-ipu-v3.h                  |  3 ++-
>>   4 files changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
>> index a9d2501500a1..d41df8034c5b 100644
>> --- a/drivers/gpu/ipu-v3/ipu-cpmem.c
>> +++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
>> @@ -273,9 +273,10 @@ void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off)
>>   }
>>   EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
>>   
>> -void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
>> +void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
>> +			       u32 pixelformat)
>>   {
>> -	u32 ilo, sly;
>> +	u32 ilo, sly, sluv;
>>   
>>   	if (stride < 0) {
>>   		stride = -stride;
>> @@ -286,9 +287,30 @@ void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
>>   
>>   	sly = (stride * 2) - 1;
>>   
>> +	switch (pixelformat) {
>> +	case V4L2_PIX_FMT_YUV420:
>> +	case V4L2_PIX_FMT_YVU420:
>> +		sluv = stride / 2 - 1;
>> +		break;
>> +	case V4L2_PIX_FMT_NV12:
>> +		sluv = stride - 1;
>> +		break;
>> +	case V4L2_PIX_FMT_YUV422P:
>> +		sluv = stride - 1;
>> +		break;
>> +	case V4L2_PIX_FMT_NV16:
>> +		sluv = stride * 2 - 1;
>> +		break;
>> +	default:
>> +		sluv = 0;
>> +		break;
>> +	}
>> +
>>   	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
>>   	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
>>   	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
>> +	if (sluv)
>> +		ipu_ch_param_write_field(ch, IPU_FIELD_SLUV, sluv);
>>   };
>>   EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);
> [...]
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> and
>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> to be merged with the rest of the series via the media tree. I'll take
> care not to introduce nontrivial conflicts in imx-drm.

Ok thanks.

Hans, for v5 I will just include the two IPU patches as before. As Philipp
stated, he is OK with merging them to the media tree (after his ack of
course), along with the rest of the patches in this series.

Steve


