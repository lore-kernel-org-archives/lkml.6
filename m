Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D5FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B591420882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vuECV4Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B591420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeINTKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:10:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36382 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeINTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:10:20 -0400
Received: from [192.168.0.23] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53385CE;
        Fri, 14 Sep 2018 15:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536933341;
        bh=/19txGlEoKtFpwKSenleSYacysDOGgnDe1eEYJRTZVM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vuECV4Q2rWuLyMihb00HdjELVtlTwl9EJ2GfN9xeso1jEDMl/qKx3YOJmGZAqqDTA
         PkHGqw8ENL5YOUS0MC2xwPD03QNoEa2BB0zex8mw7DORzkB2nkLPhd8Fw8AM4jDwKi
         zXya43LOPDOGN06ky7+av/ixqyThkpetMs8Qkkv8=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] drm: rcar-du: Remove packed VYUY support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180914132149.26354-1-kieran.bingham+renesas@ideasonboard.com>
 <1759929.4apJ9N5u4E@avalon>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <7d2740f2-923c-4b5d-0d1e-c24fb4a8bceb@ideasonboard.com>
Date:   Fri, 14 Sep 2018 14:55:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1759929.4apJ9N5u4E@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 14/09/18 14:51, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Friday, 14 September 2018 16:21:49 EEST Kieran Bingham wrote:
>> The Gen3 VSP used by the DU for display does not support packed the VYUY
>> pixel format. Gen2 VSP hardware is able to process this format, but it
>> is not officially supported there either and thus it's output can not be
>> guaranteed.
> 
> I think we could guarantee proper operation on Gen2, but as DU + VSP operation 
> isn't enabled in the drivers by default, and as the VYUY format isn't a 
> strategic target, I think we can ignore that.
> 
> How about updating the commit message as follows ?
> 
> "The Gen3 VSP used by the DU for display does not support packed the VYUY 

s/packed the/the packed/

Which was a fault in my original text :)

> pixel format. Gen2 VSP hardware is able to process this format, but DU + VSP 
> operation isn't enabled on Gen2, and VYUY isn't a strategic format, so it can 
> be ignored."

That sounds fine to me, though I don't think we would even need to state
that 'VYUY isn't a strategic format' once it's simply not available on
the only platform that is enabled to use the VSP. But I don't object to
stating it otherwise.

--
Kieran



> 
>> Remove the format from the capabilities of the DU driver.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> ---
>>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
>> b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c index 4480243813ec..4576119e7777
>> 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
>> @@ -126,7 +126,6 @@ static const u32 formats_kms[] = {
>>  	DRM_FORMAT_ARGB8888,
>>  	DRM_FORMAT_XRGB8888,
>>  	DRM_FORMAT_UYVY,
>> -	DRM_FORMAT_VYUY,
>>  	DRM_FORMAT_YUYV,
>>  	DRM_FORMAT_YVYU,
>>  	DRM_FORMAT_NV12,
>> @@ -155,7 +154,6 @@ static const u32 formats_v4l2[] = {
>>  	V4L2_PIX_FMT_ABGR32,
>>  	V4L2_PIX_FMT_XBGR32,
>>  	V4L2_PIX_FMT_UYVY,
>> -	V4L2_PIX_FMT_VYUY,
>>  	V4L2_PIX_FMT_YUYV,
>>  	V4L2_PIX_FMT_YVYU,
>>  	V4L2_PIX_FMT_NV12M,
> 

