Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B6ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C75206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="icwvZZnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C75206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeINSfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:35:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36040 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:35:16 -0400
Received: from [192.168.0.23] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C59ECCE;
        Fri, 14 Sep 2018 15:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536931246;
        bh=pf0GCovhYCE3fX8DkcqJDq29V1iIoXYz9G8liI8KQIs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=icwvZZnZMgz94t/cEvCS35OsPGFhHrsmuYQJO83aIVLCwwGMj3urdRcx9k/M/E+Ql
         2oBFzshXW2AYF054SZpFfDx9kS0xs6DPN+mKuAumtcJQoxdC1LeL+lOOfN5cQ1xl43
         q8ZCqGBtqSJ0T6gIwj8GzUf+39IuJDI4QHAardLg=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 2/3] drm: rcar-du: Add pixel format support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>
References: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
 <20180831181259.29529-3-kieran.bingham+renesas@ideasonboard.com>
 <3865052.iN5JJav0kF@avalon>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <b338a8f7-6af6-8e35-7de3-67f43dd2d52d@ideasonboard.com>
Date:   Fri, 14 Sep 2018 14:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3865052.iN5JJav0kF@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 14/09/18 12:17, Laurent Pinchart wrote:
> Hi Kieran,
> 
> On Friday, 31 August 2018 21:12:58 EEST Kieran Bingham wrote:
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> This patch supports pixel format of RGB332, ARGB4444, XRGB4444,
>> BGR888, RGB888, BGRA8888, BGRX8888 and YVYU.
>> VYUY pixel format is not supported by H/W specification.
> 
> Should VYUY be removed from rcar_du_vsp.c ? This can be done in a separate 
> patch.

On further consideration - yes, I believe it should.

Removal patch generated, and doesn't negatively affect the current
kms-tests, so expect it in your inbox imminently.

--
Regards

Kieran


> 
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
> 

