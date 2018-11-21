Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E7CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D41E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XNOK+xxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D41E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbeKVHqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:46:05 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47984 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKVHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:46:05 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 929A755E;
        Wed, 21 Nov 2018 22:10:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1542834602;
        bh=Y8tgesxlqNSodcmkp7zGFRPdIB+w4p4LsV9lElZGY5o=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XNOK+xxVDsM9mzDEH8k2ok0jv8Pix99jVp0Uj/fjwTSyam7BplQs7yqwOlImD2lRt
         xOJoIAQsVqmsNNi5PTUBokxAAWfQnSJozWfAqGsreLAgKoAnyIhDcZf2/Q3W/eWJZB
         8Lys83Rcm10G28/OPdB6iw2GOghdECkQPLn6p6r0=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 2/2] drm: rcar-du: Enable alpha property on primary planes
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com>
 <20180919155700.10342-3-kieran.bingham+renesas@ideasonboard.com>
 <1604918.OXgyMDt7RE@avalon> <3478783.2iBfSyQcgT@avalon>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <e43c48cf-0774-c1f2-24a9-25b32438d3bf@ideasonboard.com>
Date:   Wed, 21 Nov 2018 21:10:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3478783.2iBfSyQcgT@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 21/11/2018 18:29, Laurent Pinchart wrote:
> Hi Kieran,
> 
> On Thursday, 20 September 2018 14:22:38 EET Laurent Pinchart wrote:
>> On Wednesday, 19 September 2018 18:56:59 EEST Kieran Bingham wrote:
>>> If the alpha property is not added to a plane, a default value will be
>>> used, which can result in a non-visible layer if the alpha is
>>> initialised as 0.
>>>
>>> Provide an alpha blend property on all planes.
>>>
>>> Fixes: 161ad653d6c9 ("drm: rcar-du: Use __drm_atomic_helper_plane_reset
>>> instead of copying the logic")
>>>
>>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>> ---
>>>
>>>  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
>>> b/drivers/gpu/drm/rcar-du/rcar_du_plane.c index 9e07758a755c..72399a19d8a6
>>> 100644
>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
>>> @@ -783,13 +783,18 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
>>>
>>>  		drm_plane_helper_add(&plane->plane,
>>>  		
>>>  				     &rcar_du_plane_helper_funcs);
>>>
>>> +		/*
>>> +		 * The alpha property needs to be initialised on all planes
>>> +		 * to ensure the correct setting at the output.
>>> +		 */
>>> +		drm_plane_create_alpha_property(&plane->plane);
>>> +
>>
>> As mentioned in the cover letter, both patches in this series fix the issue
>> at hand. The first patch is more generic as it will fix it for all drivers,
>> while this patch is specific to the R-Car DU driver. It however makes sense
>> to merge it, as it adds alpha support to the primary plane, which can be
>> useful.
>>
>> Once the first patch gets merged, the above comment won't be correct
>> anymore. I wonder whether we shouldn't change the patch description and
>> comment to focus on usage of the alpha property for primary planes, and not
>> on the bug fix. What's your opinion ?

Aha - sorry this slipped my queue.


> I've removed the comment and changed the commit message to
> 
>   drm: rcar-du: Enable alpha property on primary planes
>   
>   The hardware supports alpha on all planes, and using it on the primary
>   plane can be useful. Don't restrict the alpha property to overlay
>   planes.
> 
> With this,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Perfect, - That reads fine.

Thank you.



> 
> and applied to my tree.
> 
>>>  		if (type == DRM_PLANE_TYPE_PRIMARY)
>>>  			continue;
>>>  		
>>>  		drm_object_attach_property(&plane->plane.base,
>>>  					   rcdu->props.colorkey,
>>>  					   RCAR_DU_COLORKEY_NONE);
>>>
>>> -		drm_plane_create_alpha_property(&plane->plane);
>>>  		drm_plane_create_zpos_property(&plane->plane, 1, 1, 7);
>>>  	}
> 

