Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A22ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83120206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OWMfxOBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83120206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeINSQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:16:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35844 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:16:38 -0400
Received: from [192.168.0.23] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A681CE;
        Fri, 14 Sep 2018 15:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536930132;
        bh=ErlC2AmuISSvKzOqr4aFhboQ8wun04npQwOxsuhtFoA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OWMfxOBihP8Do6iPiFtTRUlitz35ldK3Ymd+J/5ciiw6ql+fvkgTdEp9YSmpU9noJ
         Wf1CQkHjvqVrxSzlFceYFXTWpMFrYB/CJdLjGvn16WCv/wgAzlI0My59/oxrdIsglH
         OJXyYK7ujr0+5RZoOd//C7PMrPEoi7aIQx42vyT0=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 2/3] drm: rcar-du: Add pixel format support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>
References: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
 <20180831181259.29529-3-kieran.bingham+renesas@ideasonboard.com>
 <9318122.8LJjaKzHaP@avalon>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <e9a443fa-729b-fad9-cb06-9a8d2d65b408@ideasonboard.com>
Date:   Fri, 14 Sep 2018 14:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9318122.8LJjaKzHaP@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 14/09/18 12:11, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> How about renaming the subject line to "Add support for missing pixel formats" 
> ?
> 

Ack.

> On Friday, 31 August 2018 21:12:58 EEST Kieran Bingham wrote:
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> This patch supports pixel format of RGB332, ARGB4444, XRGB4444,
>> BGR888, RGB888, BGRA8888, BGRX8888 and YVYU.
>> VYUY pixel format is not supported by H/W specification.
>>
>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> ---
>>
>> This patch does not remove existing support for multiplanar YVUY, even
>> though the hardware does not explicitly provide it, because we support
>> it through software by swapping the plane buffers.
>>
>>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 32 +++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
>> b/drivers/gpu/drm/rcar-du/rcar_du_kms.c index 7c7aff8cdf77..d1bd174ec893
>> 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
>> @@ -124,6 +124,38 @@ static const struct rcar_du_format_info
>> rcar_du_format_infos[] = { .fourcc = DRM_FORMAT_YVU444,
>>  		.bpp = 24,
>>  		.planes = 3,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_RGB332,
>> +		.bpp = 8,
>> +		.planes = 1,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_ARGB4444,
>> +		.bpp = 16,
>> +		.planes = 1,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_XRGB4444,
>> +		.bpp = 16,
>> +		.planes = 1,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_BGR888,
>> +		.bpp = 24,
>> +		.planes = 1,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_RGB888,
>> +		.bpp = 24,
>> +		.planes = 1,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_BGRA8888,
>> +		.bpp = 32,
>> +		.planes = 1,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_BGRX8888,
>> +		.bpp = 32,
>> +		.planes = 1,
>> +	}, {
>> +		.fourcc = DRM_FORMAT_YVYU,
>> +		.bpp = 16,
>> +		.planes = 1,
>>  	},
>>  };
> 
> I would list the RGB formats first, followed by the packed YUV format, and 
> then the multiplanar YUV formats. With this changed,
> 
Ack.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> If you're fine with the changes there's no need to resubmit.


That's fine by me.

Thanks

--
Kieran


